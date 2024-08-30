#include "UTF816.h"

#include <stdlib.h>

#define wchar uint16_t

#define STARTS_0(byte) ((byte & 0x80) == 0x00)
#define STARTS_10(byte) ((byte & 0xC0) == 0x80)
#define STARTS_110(byte) ((byte & 0xE0) == 0xC0)
#define STARTS_1110(byte) ((byte & 0xF0) == 0xE0)
#define STARTS_11110(byte) ((byte & 0xF8) == 0xF0)
#define TAKE(byte, nbits) (byte & ((1 << nbits)-1))

static inline bool is_illegal(uint32_t codepoint)
{
	return (codepoint >= 0xD800 && codepoint <= 0xDFFF) || codepoint > 0x10FFFF;
}

uint32_t UTF8_peek_next(const char* s_str, uint8_t* codepoint_nbytes)
{
	/* Get the next codepoint from a string, but instead of advancing the
	 * pointer, give the number of bytes the index will need to advance. */
	if (s_str == NULL)
	{
		return 0;
	}

	// Pointer conversion to avoid all those brilliant signedness plot twists...
	const unsigned char* str = (const unsigned char*) s_str;
	uint32_t codepoint;
	*codepoint_nbytes = 1;

	if (STARTS_0(str[0]))
	{
		// 0xxx xxxx - ASCII
		codepoint = str[0];
	}
	else if (STARTS_10(str[0]))
	{
		// 10xx xxxx - unexpected continuation byte
		codepoint = 0xFFFD;
	}
	else if (STARTS_110(str[0]))
	{
		// 110x xxxx - 2-byte sequence
		if (!STARTS_10(str[1]))
		{
			codepoint = 0xFFFD;
		}
		else
		{
			codepoint =
				(TAKE(str[0], 5) << 6) |
				(TAKE(str[1], 6));
			*codepoint_nbytes = 2;
		}
	}
	else if (STARTS_1110(str[0]))
	{
		// 1110 xxxx - 3-byte sequence
		if (!STARTS_10(str[1]) || !STARTS_10(str[2]))
		{
			codepoint = 0xFFFD;
		}
		else
		{
			codepoint =
				(TAKE(str[0], 4) << 12) |
				(TAKE(str[1], 6) << 6) |
				(TAKE(str[2], 6));
			*codepoint_nbytes = 3;
		}
	}
	else if (STARTS_11110(str[0]))
	{
		// 1111 0xxx - 4-byte sequence
		if (!STARTS_10(str[1]) || !STARTS_10(str[2]) || !STARTS_10(str[3]))
		{
			codepoint = 0xFFFD;
		}
		else
		{
			codepoint =
				(TAKE(str[0], 3) << 18) |
				(TAKE(str[1], 6) << 12) |
				(TAKE(str[2], 6) << 6) |
				(TAKE(str[3], 6));
			*codepoint_nbytes = 4;
		}
	}
	else
	{
		// 1111 1xxx - invalid
		codepoint = 0xFFFD;
	}

	// Overlong sequence?
	if (
		(codepoint <= 0x7F && *codepoint_nbytes > 1) ||
		(codepoint > 0x7F && codepoint <= 0x7FF && *codepoint_nbytes > 2) ||
		(codepoint > 0x7FF && codepoint <= 0xFFFF && *codepoint_nbytes > 3)
	) {
		codepoint = 0xFFFD;
	}

	// UTF-16 surrogates are invalid, so are codepoints after 10FFFF
	if (is_illegal(codepoint))
	{
		codepoint = 0xFFFD;
	}

	return codepoint;
}

uint32_t UTF8_next(const char** p_str)
{
	/* Get the next codepoint from a string, and advance the pointer.
	 * Example usage:
	 *
	 *  const char* str = "asdf";
	 *  uint32_t codepoint;
	 *  while ((codepoint = UTF8_next(&str)))
	 *  {
	 *      // you have a codepoint congrats
	 *  }
	 */
	if (p_str == NULL)
	{
		return 0;
	}

	uint8_t codepoint_nbytes;
	uint32_t codepoint = UTF8_peek_next(*p_str, &codepoint_nbytes);
	*p_str += codepoint_nbytes;
	return codepoint;
}

UTF8_encoding UTF8_encode(uint32_t codepoint)
{
	UTF8_encoding enc = {0};

	// Pretend the bytes array is unsigned...
	unsigned char* bytes = (unsigned char*) &enc.bytes;

	if (is_illegal(codepoint))
	{
		codepoint = 0xFFFD;
		enc.error = true;
	}

	if (codepoint <= 0x7F)
	{
		enc.nbytes = 1;
		bytes[0] = codepoint;
	}
	else if (codepoint <= 0x7FF)
	{
		enc.nbytes = 2;
		bytes[0] = 0xC0 | (codepoint >> 6);
		bytes[1] = 0x80 | (codepoint & 0x3F);
	}
	else if (codepoint <= 0xFFFF)
	{
		enc.nbytes = 3;
		bytes[0] = 0xE0 | (codepoint >> 12);
		bytes[1] = 0x80 | ((codepoint >> 6) & 0x3F);
		bytes[2] = 0x80 | (codepoint & 0x3F);
	}
	else
	{
		enc.nbytes = 4;
		bytes[0] = 0xF0 | (codepoint >> 18);
		bytes[1] = 0x80 | ((codepoint >> 12) & 0x3F);
		bytes[2] = 0x80 | ((codepoint >> 6) & 0x3F);
		bytes[3] = 0x80 | (codepoint & 0x3F);
	}

	return enc;
}

size_t UTF8_total_codepoints(const char* str)
{
	size_t total = 0;
	while (UTF8_next(&str))
	{
		total++;
	}
	return total;
}

size_t UTF8_backspace(const char* str, size_t len)
{
	/* Given a string of length len,
	 * give the new length after removing the last character.
	 * In other words, the index at which to write a \0 byte. */

	for (len -= 1; len > 0; len--)
	{
		if (!STARTS_10(str[len]))
		{
			break;
		}
	}

	return len;
}

uint32_t UTF16_peek_next(const wchar* str, uint8_t* codepoint_nwords)
{
	/* Get the next codepoint from a string, but instead of advancing the
	 * pointer, give the number of bytes the index will need to advance. */
	if (str == NULL)
	{
		return 0;
	}

	uint32_t codepoint;
	*codepoint_nwords = 1;

	if (str[0] >= 0xD800 && str[0] <= 0xDBFF)
	{
		// Leading surrogate
		if (str[1] >= 0xDC00 && str[1] <= 0xDFFF)
		{
			// Complete surrogate pair
			codepoint = 0x10000 + (str[0]-0xD800)*1024 + (str[1]-0xDC00);
			*codepoint_nwords = 2;
		}
		else
		{
			codepoint = 0xFFFD;
		}
	}
	else if (str[0] >= 0xDC00 && str[0] <= 0xDFFF)
	{
		// Unexpected trailing surrogate
		codepoint = 0xFFFD;
	}
	else
	{
		codepoint = str[0];
	}

	return codepoint;
}

uint32_t UTF16_next(const wchar** p_str)
{
	/* Get the next codepoint from a string, and advance the pointer.
	 * Example usage:
	 *
	 *  const WCHAR* str = L"asdf";
	 *  uint32_t codepoint;
	 *  while ((codepoint = UTF16_next(&str)))
	 *  {
	 *      // you have a codepoint congrats
	 *  }
	 */
	if (p_str == NULL)
	{
		return 0;
	}

	uint8_t codepoint_nwords;
	uint32_t codepoint = UTF16_peek_next(*p_str, &codepoint_nwords);
	*p_str += codepoint_nwords;
	return codepoint;
}

UTF16_encoding UTF16_encode(uint32_t codepoint)
{
	UTF16_encoding enc = {0};

	if (is_illegal(codepoint))
	{
		codepoint = 0xFFFD;
		enc.error = true;
	}

	if (codepoint <= 0xFFFF)
	{
		enc.nwords = 1;
		enc.words[0] = codepoint;
	}
	else
	{
		codepoint -= 0x10000;

		enc.nwords = 2;
		enc.words[0] = 0xD800 | (codepoint >> 10);
		enc.words[1] = 0xDC00 | (codepoint & 0x3FF);
	}

	return enc;
}

size_t UTF16_total_codepoints(const wchar* str)
{
	size_t total = 0;
	while (UTF16_next(&str))
	{
		total++;
	}
	return total;
}

size_t UTF8_to_UTF16_buf(const char* src, wchar* dst, size_t n_dst)
{
	// Returns number of written wchars

	if (src == NULL || dst == NULL || n_dst == 0)
	{
		return 0;
	}

	uint32_t words_written = 0;
	uint32_t codepoint;
	while ((codepoint = UTF8_next(&src)))
	{
		UTF16_encoding enc = UTF16_encode(codepoint);
		if (enc.nwords+1 > n_dst)
		{
			dst[0] = '\0';
			return words_written;
		}
		for (size_t i = 0; i < enc.nwords; i++)
		{
			dst[i] = enc.words[i];
		}
		dst += enc.nwords;
		n_dst -= enc.nwords;
		words_written += enc.nwords;
	}

	dst[0] = '\0';

	return words_written;
}

wchar* UTF8_to_UTF16_alloc2(const char* src, size_t* words_written)
{
	// Caller must free. words_written may be NULL.

	size_t needed_words = 1;
	const char* p_src = src;
	uint32_t codepoint;
	while ((codepoint = UTF8_next(&p_src)))
	{
		needed_words += UTF16_encode(codepoint).nwords;
	}
	if (words_written != NULL)
	{
		*words_written = needed_words;
	}

	wchar* dst = malloc(needed_words * 2);
	UTF8_to_UTF16_buf(src, dst, needed_words);
	return dst;
}

wchar* UTF8_to_UTF16_alloc(const char* src)
{
	// Caller must free.

	return UTF8_to_UTF16_alloc2(src, NULL);
}

size_t UTF16_to_UTF8_buf(const wchar* src, char* dst, size_t n_dst)
{
	// Returns number of written bytes

	if (src == NULL || dst == NULL || n_dst == 0)
	{
		return 0;
	}

	uint32_t bytes_written = 0;
	uint32_t codepoint;
	while ((codepoint = UTF16_next(&src)))
	{
		UTF8_encoding enc = UTF8_encode(codepoint);
		if (enc.nbytes+1 > n_dst)
		{
			dst[0] = '\0';
			return bytes_written;
		}
		for (size_t i = 0; i < enc.nbytes; i++)
		{
			dst[i] = enc.bytes[i];
		}
		dst += enc.nbytes;
		n_dst -= enc.nbytes;
		bytes_written += enc.nbytes;
	}

	dst[0] = '\0';

	return bytes_written;
}

char* UTF16_to_UTF8_alloc2(const wchar* src, size_t* bytes_written)
{
	// Caller must free. bytes_written may be NULL.

	size_t needed_bytes = 1;
	const wchar* p_src = src;
	uint32_t codepoint;
	while ((codepoint = UTF16_next(&p_src)))
	{
		needed_bytes += UTF8_encode(codepoint).nbytes;
	}
	if (bytes_written != NULL)
	{
		*bytes_written = needed_bytes;
	}

	char* dst = malloc(needed_bytes);
	UTF16_to_UTF8_buf(src, dst, needed_bytes);
	return dst;
}

char* UTF16_to_UTF8_alloc(const wchar* src)
{
	// Caller must free.

	return UTF16_to_UTF8_alloc2(src, NULL);
}
