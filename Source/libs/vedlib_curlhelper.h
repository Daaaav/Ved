typedef struct _ved_curl_download_data
{
	char* data;
	size_t capacity;
	size_t total_data;
} ved_curl_download_data;

void ved_cleanup_userdata(ved_curl_download_data* userdata);
size_t ved_curl_download(char* data, size_t size, size_t nmemb, void* ptr_userdata);
