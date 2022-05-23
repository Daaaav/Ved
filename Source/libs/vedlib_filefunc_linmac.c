/*
Version 04

Typical usage (in C):

ved_directoryiter diriter;
if (!ved_opendir(&diriter, ".", ".vvvvvv", false, NULL))
{
	return; // or error
}
ved_filedata filedata;
while (ved_nextfile(&diriter, &filedata))
{
	printf("File %s, isdir %d, edited %lld\n",
		filedata.name, filedata.isdir, filedata.lastmodified
	);
}
ved_closedir(&diriter);
*/

#include <dirent.h>
#include <errno.h>
#include <locale.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

#if !defined(__APPLE__)
/* For finding running VVVVVV executable on Linux */
#include <unistd.h>
#endif

typedef struct _ved_filedata
{
	char name[256];
	bool isdir;
	long long lastmodified;
	long long filesize;
} ved_filedata;

typedef struct _ved_directoryiter
{
	DIR* dir;
	char path[256];
	size_t len_prefix;
	bool filter_active;
	char filter[8];
	bool show_hidden;
} ved_directoryiter;


const char* (*ved_L)(char* key);

/*
 * Register a callback to get translations from Lua, and set locale to system locale
 */
void init_lang(const char* (*l)(char* key))
{
	ved_L = l;

	setlocale(LC_MESSAGES, "");
}

/*
 * Returns true if filename ends in the filter text (like ".vvvvvv" or ".png")
 */
bool is_filtered_file(ved_directoryiter* diriter, struct dirent* dirent)
{
	if (strcmp(diriter->filter, "/") == 0)
	{
		/* If this were a directory, we wouldn't be calling this function. */
		return false;
	}
	size_t len_filter = strlen(diriter->filter);
	size_t len_name = strlen(dirent->d_name);
	return len_name >= len_filter
		&& strcmp(dirent->d_name + len_name - len_filter, diriter->filter) == 0;
}

/*
 * Returns true if we should list this file - it's a directory, or is filtered
 */
bool is_listable(ved_directoryiter* diriter, struct dirent* dirent, bool isdir)
{
	if (!diriter->show_hidden && dirent->d_name[0] == '.')
	{
		return false;
	}
	if (diriter->show_hidden && (strcmp(dirent->d_name, ".") == 0 || strcmp(dirent->d_name, "..") == 0))
	{
		return false;
	}
#if defined(__APPLE__)
	if (diriter->show_hidden && strcmp(dirent->d_name, ".DS_Store") == 0)
	{
		return false;
	}
#endif
	return isdir || !diriter->filter_active || is_filtered_file(diriter, dirent);
}

/*
 * Opens the directory at the specified path in preparation of file listing.
 * The path must end in "/".
 * The filter is either an extension including '.', or an empty string to not
 * filter any files. For example, it can be ".vvvvvv" to only list VVVVVV
 * levels and directories. If the filter is "/", only matches directories.
 * Returns true if successful. If unsuccessful, and errmsg is not NULL, errmsg
 * will point to an error string.
 */
bool ved_opendir(ved_directoryiter* diriter, const char* path, const char* filter, bool show_hidden, const char** errmsg)
{
	diriter->filter_active = filter != NULL && filter[0] != '\0';
	strncpy(diriter->filter, filter, 7);
	diriter->filter[7] = '\0';
	diriter->show_hidden = show_hidden;
	diriter->len_prefix = strlen(path);
	if (diriter->len_prefix > 247 || path[diriter->len_prefix-1] != '/')
	{
		if (errmsg != NULL)
		{
			*errmsg = ved_L("PATHINVALID");
		}
		return false;
	}
	strcpy(diriter->path, path);
	diriter->path[255] = '\0';
	diriter->dir = opendir(path);
	if (!(bool)diriter->dir)
	{
		if (errmsg != NULL)
		{
			*errmsg = strerror(errno);
		}
		return false;
	}
	return true;
}

/*
 * Stores data about the next file in filedata.
 * Returns false if there is no file anymore.
 */
bool ved_nextfile(ved_directoryiter* diriter, ved_filedata* filedata)
{
	struct dirent* dirent;
	struct stat dstat;
	bool isdir;
	do /* normally once */
	{
		dirent = readdir(diriter->dir);
		if (dirent == NULL)
		{
			return false;
		}
		strncpy(diriter->path+diriter->len_prefix, dirent->d_name, 255-diriter->len_prefix);
		if (stat(diriter->path, &dstat) == -1)
		{
			/* stat failed */
			isdir = false;
			dstat.st_mtime = 0;
			dstat.st_size = 0;
		}
		else
		{
			isdir = S_ISDIR(dstat.st_mode);
		}
	} while (!is_listable(diriter, dirent, isdir));

	strncpy(filedata->name, dirent->d_name, 255);
	filedata->name[255] = '\0';
	filedata->isdir = isdir;
	filedata->lastmodified = dstat.st_mtime;
	filedata->filesize = (long long) dstat.st_size;

	return true;
}

/*
 * Simply closes the DIR we had open
 */
void ved_closedir(ved_directoryiter* diriter)
{
	closedir(diriter->dir);
}

/*
 * Checks if a path exists and is a directory
 */
bool ved_directory_exists(const char* path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
	{
		/* stat failed */
		return false;
	}
	return S_ISDIR(dstat.st_mode);
}

/*
 * Checks if a path exists and is not a directory
 */
bool ved_file_exists(const char* path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
	{
		/* stat failed */
		return false;
	}
	return !S_ISDIR(dstat.st_mode);
}

/*
 * Gives last modification timestamp of a file, like `stat -c %Y PATH`.
 * If stat fails, returns 0.
 * Since this is a 64-bit value, LuaJIT FFI requires tonumber() for it.
 */
long long ved_getmodtime(const char* path)
{
	struct stat dstat;
	if (stat(path, &dstat) == -1)
	{
		/* stat failed */
		return 0;
	}
	return dstat.st_mtime;
}

#if !defined(__APPLE__)
/*
 * Gets the path to the currently-running VVVVVV executable.
 * If one (1) running VVVVVV is found, buffer contains the path to the
 * executable, and the function returns true.
 * A false return value indicates error or ambiguity.
 * You may pass NULL for errkey. errkey is meaningless upon success.
 */
bool ved_find_vvvvvv_exe_linux(char* buffer, size_t buffer_size, const char** errkey)
{
	/* Get IDs of processes named VVVVVV */
	FILE* f_procid = popen("pgrep -x VVVVVV", "r");
	if (f_procid == NULL)
	{
		if (errkey != NULL)
		{
			*errkey = "FIND_V_EXE_ERROR";
		}
		return false;
	}

	/* Default for !success: we simply didn't find it */
	if (errkey != NULL)
	{
		*errkey = "FIND_V_EXE_NOTFOUND";
	}

	unsigned n_processes = 0;
	bool success = false;
	while (true)
	{
		char buf_procid[16];
		if (fgets(buf_procid, 16, f_procid) == NULL)
		{
			break;
		}

		n_processes++;

		char* newline = strchr(buf_procid, '\n');
		if (newline != NULL)
		{
			newline[0] = '\0';
		}

		char proc_exe[PATH_MAX];
		snprintf(proc_exe, sizeof(proc_exe), "/proc/%s/exe", buf_procid);

		char real_exe[PATH_MAX];
		real_exe[readlink(proc_exe, real_exe, sizeof(real_exe)-1)] = '\0';

		/* If multiple VVVVVVs are running, we'll allow it if the executable is the same */
		if (n_processes > 1 && strcmp(real_exe, buffer) != 0)
		{
			if (errkey != NULL)
			{
				*errkey = "FIND_V_EXE_MULTI";
			}
			success = false;
			break;
		}

		strncpy(buffer, real_exe, buffer_size-1);
		buffer[buffer_size-1] = '\0';

		success = true;
	}

	pclose(f_procid);

	return success;
}
#endif
