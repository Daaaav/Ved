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
	size_t data_len;
	int64_t progress_dlnow;
	int64_t progress_dltotal;
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
	while (userdata->data_len + real_size > userdata->capacity)
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

	memcpy(&userdata->data[userdata->data_len], data, real_size);
	userdata->data_len += real_size;

	return real_size;
}

/* These int64_t's are normally curl_off_t, which is either 'long' or 'long long',
 * but then I'd have to include curl.h here. */
int ved_curl_progress(void* ptr_userdata, int64_t dltotal, int64_t dlnow, int64_t ultotal, int64_t ulnow)
{
	ved_curl_download_data* userdata = (ved_curl_download_data*)ptr_userdata;

	userdata->progress_dltotal = dltotal;
	userdata->progress_dlnow = dlnow;

	return 0;
}
