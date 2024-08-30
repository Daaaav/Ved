#include "read_list.h"

#include <stddef.h>
#include <stdlib.h>
#include <string.h>

static char lang[16] = "en";

static char* file_contents = NULL;
static char* lang_start;
static bool strings_bad = false;

void strings_set_lang(const char* new)
{
	if (strlen(new)+1 > sizeof(lang))
	{
		return;
	}

	strcpy(lang, new);
}

const char* get_string(const char* key)
{
	/* Get the string for the specified key, in the correct language.
	 * The strings file will be opened automatically upon the first request.
	 * Guarantees to not change GetLastError(). */
	if (key == NULL || strings_bad)
	{
		return key;
	}

	if (file_contents == NULL)
	{
		// First set everything up for the first time - point to the first string in your language
		const DWORD last_err = GetLastError();
		const bool read_list_success = read_list(L"update\\strings.txt", &file_contents);
		RestoreLastError(last_err);
		if (!read_list_success)
		{
			return key;
		}

		/* Attempt 1: specified language
		 * Attempt 2: english, if different */
		for (int attempt = 1; attempt <= 2; attempt++)
		{
			lang_start = file_contents;

			const size_t len_lang = strlen(lang);
			bool found = false;
			do
			{
				if (lang_start[0] != '[')
				{
					continue;
				}

				const char* closing_bracket = strchr(&lang_start[1], ']');
				if (closing_bracket == NULL)
				{
					continue;
				}

				const size_t len_header = closing_bracket - &lang_start[1];
				if (len_header == len_lang && memcmp(&lang_start[1], lang, len_lang) == 0)
				{
					found = true;
					next_line(&lang_start);
					break;
				}
			}
			while (next_line(&lang_start));

			if (found)
			{
				break;
			}

			if (attempt == 2 || strcmp(lang, "en") == 0)
			{
				strings_bad = true;
				return key;
			}

			// Go for attempt 2, we didn't find our language
			strings_set_lang("en");
		}
	}

	/* Now this is kind of an inefficient lookup, but there's only like a coupla strings...
	 * And they'd only be displayed in case of errors anyway. */
	char* lang_line = lang_start;
	do
	{
		if (lang_line[0] == '[')
		{
			break;
		}

		char* equals = strchr(lang_line, '=');
		if (equals == NULL)
		{
			continue;
		}

		const size_t len_sought_key = strlen(key);
		const size_t len_found_key = equals - lang_line;
		if (len_sought_key == len_found_key && memcmp(lang_line, key, len_sought_key) == 0)
		{
			// One last hack - replace literal \n ('\' 'n') by CRLF
			char* translation = &equals[1];
			char* p = translation;
			bool just_backslash = false;
			char c;
			while ((c = *p++))
			{
				if (just_backslash && c == 'n')
				{
					p[-2] = '\r';
					p[-1] = '\n';
				}

				just_backslash = c == '\\';
			}

			return translation;
		}
	}
	while (next_line(&lang_line));

	return key;
}

void strings_close(void)
{
	if (file_contents == NULL)
	{
		free(file_contents);
	}
}
