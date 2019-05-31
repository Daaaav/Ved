/*
Version 01

Typical usage (in C):

if (!ved_opendir(".", ".vvvvvv"))
	return; // or error
ved_filedata filedata;
while (ved_nextfile(&filedata))
	printf("File %s, isdir %d, edited %lld\n",
		filedata.name, filedata.isdir, filedata.lastmodified
	);
ved_closedir();
*/

#include <dirent.h>
#include <stdbool.h>
#include <string.h>
#include <sys/stat.h>

typedef struct _ved_filedata
{
	char name[256];
	bool isdir;
	long long lastmodified;
} ved_filedata;


DIR *g_dir;
char g_path[256];
size_t g_len_prefix;
bool g_filter_active;
char g_filter[8];

/*
 * Returns true if filename ends in the filter text (like ".vvvvvv" or ".png")
 */
bool is_filtered_file(struct dirent *dirent)
{
	size_t len_filter = strlen(g_filter);
	size_t len_name = strlen(dirent->d_name);
	return len_name >= len_filter
		&& strcmp(dirent->d_name + len_name - len_filter, g_filter) == 0;
}

/*
 * Returns true if we should list this file - it's a directory, or is filtered
 */
bool is_listable(struct dirent *dirent, bool isdir)
{
	if (dirent->d_name[0] == '.')
		return false;
	return isdir || !g_filter_active || is_filtered_file(dirent);
}

/*
 * Opens the directory at the specified path in preparation of file listing.
 * The path must end in "/".
 * The filter is either an extension including '.', or an empty string to not
 * filter any files. For example, it can be ".vvvvvv" to only list VVVVVV
 * levels and directories.
 * Returns true if successful.
 */
bool ved_opendir(const char *path, const char *filter)
{
	g_filter_active = strlen(filter) > 0;
	strncpy(g_filter, filter, 7);
	g_filter[7] = '\0';
	g_len_prefix = strlen(path);
	if (g_len_prefix > 247)
		return false;
	if (path[g_len_prefix-1] != '/')
		return false;
	strcpy(g_path, path);
	g_path[255] = '\0';
	g_dir = opendir(path);
	return (bool)g_dir;
}

/*
 * Stores data about the next file in filedata.
 * Returns false if there is no file anymore.
 */
bool ved_nextfile(ved_filedata *filedata)
{
	struct dirent *dirent;
	struct stat dstat;
	bool isdir;
	do /* normally once */
	{
		dirent = readdir(g_dir);
		if (dirent == NULL)
			return false;
		strncpy(g_path+g_len_prefix, dirent->d_name, 255-g_len_prefix);
		if (stat(g_path, &dstat) == -1)
		{
			/* stat failed */
			isdir = false;
			dstat.st_mtime = 0;
		}
		else
		{
			isdir = S_ISDIR(dstat.st_mode);
		}
	} while (!is_listable(dirent, isdir));

	strncpy(filedata->name, dirent->d_name, 255);
	filedata->name[255] = '\0';
	filedata->isdir = isdir;
	filedata->lastmodified = dstat.st_mtime;

	return true;
}

/*
 * Simply closes the DIR we had open
 */
void ved_closedir(void)
{
	closedir(g_dir);
}

/*
 * Checks if a path exists and is a directory
 */
bool ved_directory_exists(const char *path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
		/* stat failed */
		return false;
	return S_ISDIR(dstat.st_mode);
}

/*
 * Checks if a path exists and is not a directory
 */
bool ved_file_exists(const char *path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
		/* stat failed */
		return false;
	return !S_ISDIR(dstat.st_mode);
}

/*
 * Gives last modification timestamp of a file, like `stat -c %Y PATH`.
 * If stat fails, returns 0.
 * Since this is a 64-bit value, LuaJIT FFI requires tonumber() for it.
 */
long long ved_getmodtime(const char *path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
		/* stat failed */
		return 0;
	return dstat.st_mtime;
}
