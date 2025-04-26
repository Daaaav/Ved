/*
Version 07

Header file intended for use with LuaJIT FFI's cdef
*/

typedef struct _ved_filedata
{
	char name[1024];
	bool isdir;
	long long lastmodified;
	long long filesize;
} ved_filedata;

/* We can't #include <dirent.h>, but we only need this for a pointer */
typedef struct _DIR DIR;

typedef struct _ved_directoryiter
{
	DIR* dir;
	char path[1024];
	size_t len_prefix;
	bool filter_active;
	char filter[32];
	bool show_hidden;
} ved_directoryiter;

typedef struct _ved_c_err
{
	const char* msg;
	int code;
	int line;
} ved_c_err;

void init_lang(const char* (*l)(char* key));

bool ved_opendir(ved_directoryiter* diriter, const char* path, const char* filter, bool show_hidden, ved_c_err* errmsg);

bool ved_nextfile(ved_directoryiter* diriter, ved_filedata* filedata);

void ved_closedir(ved_directoryiter* diriter);

bool ved_directory_exists(const char* path);

bool ved_file_exists(const char* path);

long long ved_getmodtime(const char* path);

bool ved_mkdir(const char* pathname, ved_c_err* errmsg);

bool ved_find_vvvvvv_exe_linux(char* buffer, size_t buffer_size, ved_c_err* errkey);

int64_t start_process(
	const char* const cmd[], /* in */
	unsigned int timeout,    /* in, 0 for no timeout */
	int* stdin_write_end,    /* out, nullable */
	int* stdout_read_end,    /* out, nullable */
	int* stderr_read_end,    /* out, nullable */
	ved_c_err* errmsg        /* out, nullable */
);

bool write_to_pipe(int write_end, const char* data, size_t data_size, ved_c_err* errmsg);
char* read_from_pipe(int read_end, size_t* out_bytes_read, ved_c_err* errmsg);
void pipedata_free(char* data);

bool await_process(
	int64_t pid,          /* in */
	int* stderr_read_end, /* in, nullable */
	int* out_exitcode,    /* out, nullable */
	ved_c_err* errmsg     /* out, nullable */
);

void process_cleanup(int* stdin_write_end, int* stdout_read_end, int* stderr_read_end);

bool send_signal(int64_t pid, int sig, ved_c_err* errmsg);
