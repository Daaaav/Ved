typedef struct _ved_curl_download_data
{
	char* data;
	size_t capacity;
	size_t data_len;
	int64_t progress_dlnow;
	int64_t progress_dltotal;
} ved_curl_download_data;

void ved_cleanup_userdata(ved_curl_download_data* userdata);
size_t ved_curl_download(char* data, size_t size, size_t nmemb, void* ptr_userdata);
int ved_curl_progress(void* ptr_userdata, int64_t dltotal, int64_t dlnow, int64_t ultotal, int64_t ulnow);
