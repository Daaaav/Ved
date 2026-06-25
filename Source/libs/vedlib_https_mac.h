typedef struct _https_status
{
	int64_t progress_dlnow;
	int64_t progress_dltotal;

	bool done;
	bool final_success;
	unsigned long final_dltotal;
} https_status;

void https_start_request(const char* cstr_url, unsigned long expected_length);
bool https_request_await(https_status* status);
const void* https_get_response_data(void);
void https_free_request(void);

