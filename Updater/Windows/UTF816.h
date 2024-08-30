#ifndef UTF816_H
#define UTF816_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define wchar uint16_t

typedef struct
{
	char bytes[5];
	uint8_t nbytes;
	bool error;
}
UTF8_encoding;

typedef struct
{
	wchar words[3];
	uint8_t nwords;
	bool error;
}
UTF16_encoding;


uint32_t UTF8_peek_next(const char* s_str, uint8_t* codepoint_nbytes);

uint32_t UTF8_next(const char** p_str);
UTF8_encoding UTF8_encode(uint32_t codepoint);

size_t UTF8_total_codepoints(const char* str);
size_t UTF8_backspace(const char* str, size_t len);


uint32_t UTF16_peek_next(const wchar* str, uint8_t* codepoint_nwords);

uint32_t UTF16_next(const wchar** p_str);
UTF16_encoding UTF16_encode(uint32_t codepoint);

size_t UTF16_total_codepoints(const wchar* str);


size_t UTF8_to_UTF16_buf(const char* src, wchar* dst, size_t n_dst);
wchar* UTF8_to_UTF16_alloc2(const char* src, size_t* words_written);
wchar* UTF8_to_UTF16_alloc(const char* src);

size_t UTF16_to_UTF8_buf(const wchar* src, char* dst, size_t n_dst);
char* UTF16_to_UTF8_alloc2(const wchar* src, size_t* bytes_written);
char* UTF16_to_UTF8_alloc(const wchar* src);


#undef wchar

#endif // UTF816_H
