/*
 * Provides callbacks to use for libcurl, because:
 * - Apparently calling Lua callbacks from C is slow
 *   and could cause JIT issues if you're not careful
 * - Why not do the realloc's in C rather than putting
 *   strings in a table in Lua and concatenating them
 */

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>


typedef struct _ved_curl_download_data
{
	char* data;
	size_t capacity;
	size_t total_data;
} ved_curl_download_data;


void ved_cleanup_userdata(ved_curl_download_data* userdata)
{
	free(userdata->data);
	userdata->data = NULL;
}

size_t ved_curl_download(char* data, size_t size, size_t nmemb, void* ptr_userdata)
{
	size_t real_size = size * nmemb;
	ved_curl_download_data* userdata = (ved_curl_download_data*)ptr_userdata;

	bool grown = false;
	while (userdata->total_data + real_size > userdata->capacity)
	{
		if (userdata->capacity == 0)
		{
			userdata->capacity = 65536;
		}
		else
		{
			userdata->capacity *= 2;
		}
		grown = true;
	}
	if (grown)
	{
		char* new_data = realloc(userdata->data, userdata->capacity);
		if (new_data == NULL)
		{
			ved_cleanup_userdata(userdata);
			return 0;
		}
		userdata->data = new_data;
	}

	memcpy(&userdata->data[userdata->total_data], data, real_size);
	userdata->total_data += real_size;

	return real_size;
}
