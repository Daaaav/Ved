#include "read_list.h"

#include <windows.h>
#include <stdlib.h>

bool read_list(const WCHAR* filename, char** dst)
{
	/* Reads the contents of the given file, and puts it in an allocated buffer
	 * as a NUL-separated list.
	 * Newlines are thus converted to \0 characters, blank lines are removed.
	 * At the end of the list, there will be \0\0.
	 * \r (CR) characters (if any) are removed. Btw, the file must be UTF-8.
	 * Returns true if successful, false if unsuccessful (use GetLastError()).
	 * Also returns false if the list is empty.
	 * Of course, if successful, the caller must free *dst. */

	HANDLE fh = CreateFileW(
		filename,
		GENERIC_READ,
		FILE_SHARE_READ,
		NULL,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		NULL
	);
	if (fh == INVALID_HANDLE_VALUE)
	{
		return false;
	}
	LARGE_INTEGER uf_size;
	if (!GetFileSizeEx(fh, &uf_size))
	{
		DWORD err = GetLastError();
		CloseHandle(fh);
		RestoreLastError(err);
		return false;
	}
	*dst = malloc(uf_size.QuadPart + 2);
	if (*dst == NULL)
	{
		CloseHandle(fh);
		SetLastError(ERROR_NOT_ENOUGH_MEMORY);
		return false;
	}
	DWORD read;
	if (!ReadFile(fh, *dst, uf_size.QuadPart, &read, NULL))
	{
		DWORD err = GetLastError();
		free(*dst);
		CloseHandle(fh);
		RestoreLastError(err);
		return false;
	}

	CloseHandle(fh);

	// Separate the items in the list by null characters, ending with a \0\0
	(*dst)[read] = '\0';
	(*dst)[read+1] = '\0';
	size_t write_offset = 0;
	bool last_was_newline = true;
	for (size_t i = 0; i < read+2; i++)
	{
		if ((*dst)[i] == '\n')
		{
			if (last_was_newline)
			{
				write_offset++;
			}
			else
			{
				(*dst)[i - write_offset] = '\0';
				last_was_newline = true;
			}
		}
		else
		{
			last_was_newline = false;

			if ((*dst)[i] == '\r')
			{
				write_offset++;
			}
			else if (write_offset > 0)
			{
				(*dst)[i - write_offset] = (*dst)[i];
			}
		}
	}

	// Fail on an empty list
	if ((*dst)[0] == '\0')
	{
		free(*dst);
		SetLastError(ERROR_NO_MORE_ITEMS);
		return false;
	}

	return true;
}

bool next_line(char** ptr)
{
	/* Advances ptr to the next line, i.e. the first character after the next \0.
	 * Returns false if that character is another \0 (so a \0\0 is encountered). */

	if ((*ptr)[0] == '\0')
	{
		return false;
	}

	*ptr += strlen(*ptr) + 1;
	return (*ptr)[0] != '\0';
}
