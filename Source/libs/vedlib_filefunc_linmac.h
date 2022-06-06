/*
Version 05

Header file intended for use with LuaJIT FFI's cdef
*/

typedef struct _ved_filedata
{
	char name[256];
	bool isdir;
	long long lastmodified;
	long long filesize;
} ved_filedata;

/* We can't #include <dirent.h>, but we only need this for a pointer */
typedef struct _DIR DIR;

typedef struct _ved_directoryiter
{
	DIR* dir;
	char path[256];
	size_t len_prefix;
	bool filter_active;
	char filter[8];
	bool show_hidden;
} ved_directoryiter;

void init_lang(const char* (*l)(char* key));

bool ved_opendir(ved_directoryiter* diriter, const char* path, const char* filter, bool show_hidden, const char** errmsg);

bool ved_nextfile(ved_directoryiter* diriter, ved_filedata* filedata);

void ved_closedir(ved_directoryiter* diriter);

bool ved_directory_exists(const char* path);

bool ved_file_exists(const char* path);

long long ved_getmodtime(const char* path);

bool ved_mkdir(const char* pathname, const char** errmsg);

bool ved_find_vvvvvv_exe_linux(char* buffer, size_t buffer_size, const char** errkey);

int64_t start_process(
	const char* const cmd[], /* in */
	unsigned int timeout,    /* in, 0 for no timeout */
	int* stdin_write_end,    /* out, nullable */
	int* stdout_read_end,    /* out, nullable */
	int* stderr_read_end,    /* out, nullable */
	const char** errmsg      /* out, nullable */
);

bool write_to_pipe(int write_end, const char* data, size_t data_size, const char** errmsg);
char* read_from_pipe(int read_end, size_t* out_bytes_read, const char** errmsg);
void pipedata_free(char* data);

bool await_process(
	int64_t pid,          /* in */
	int* stderr_read_end, /* in, nullable */
	int* out_exitcode,    /* out, nullable */
	const char** errmsg   /* out, nullable */
);

void process_cleanup(int* stdin_write_end, int* stdout_read_end, int* stderr_read_end);
