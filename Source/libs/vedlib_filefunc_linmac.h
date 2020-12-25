/*
Version 03

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
	DIR *dir;
	char path[256];
	size_t len_prefix;
	bool filter_active;
	char filter[8];
	bool show_hidden;
} ved_directoryiter;

void init_lang(const char *(*l)(char *key));

bool ved_opendir(ved_directoryiter *diriter, const char *path, const char *filter, bool show_hidden, const char **errmsg);

bool ved_nextfile(ved_directoryiter *diriter, ved_filedata *filedata);

void ved_closedir(ved_directoryiter *diriter);

bool ved_directory_exists(const char *path);

bool ved_file_exists(const char *path);

long long ved_getmodtime(const char *path);
