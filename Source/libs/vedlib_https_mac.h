bool https_start_request(const char* cstr_url, unsigned long expected_length);
unsigned long https_get_response_length(void);
const void* https_get_response_data(void);
void https_free_request(void);
