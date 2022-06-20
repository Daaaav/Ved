/*
Version 06

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
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>


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
	setlocale(LC_CTYPE, "C.UTF-8");
}

/*
 * Sets an error out parameter to the specified message except when NULL was passed.
 */
static void set_error(const char** out_err, const char* message)
{
	if (out_err != NULL)
	{
		*out_err = message;
	}
}

/*
 * See set_error
 */
static void set_error_strerror(const char** out_err)
{
	set_error(out_err, strerror(errno));
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
		set_error(errmsg, ved_L("PATHINVALID"));
		return false;
	}
	strcpy(diriter->path, path);
	diriter->path[255] = '\0';
	diriter->dir = opendir(path);
	if (!(bool)diriter->dir)
	{
		set_error_strerror(errmsg);
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

/*
 * Create a directory
 */
bool ved_mkdir(const char* pathname, const char** errmsg)
{
	if (mkdir(pathname, 0775) < 0)
	{
		set_error_strerror(errmsg);
		return false;
	}
	return true;
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
		set_error(errkey, "FIND_V_EXE_ERROR");
		return false;
	}

	/* Default for !success: we simply didn't find it */
	set_error(errkey, "FIND_V_EXE_NOTFOUND");

	unsigned n_processes = 0;
	bool success = false;
	while (true)
	{
		char buf_procid[16];
		if (fgets(buf_procid, 16, f_procid) == NULL)
		{
			break;
		}

		char* newline = strchr(buf_procid, '\n');
		if (newline != NULL)
		{
			newline[0] = '\0';
		}

		char proc_exe[PATH_MAX];
		snprintf(proc_exe, sizeof(proc_exe), "/proc/%s/exe", buf_procid);

		char real_exe[PATH_MAX];
		ssize_t link_len = readlink(proc_exe, real_exe, sizeof(real_exe)-1);
		if (link_len == -1)
		{
			/* Okay, maybe *this* VVVVVV causes a failing readlink...
			 * Maybe there's still another where it doesn't fail.
			 * Either way it's no longer a "not found". */
			set_error(errkey, "FIND_V_EXE_FOUNDERROR");
			continue;
		}
		real_exe[link_len] = '\0';

		if (strncmp(&real_exe[link_len-2], "sh", 2) == 0)
		{
			/* bash is NOT a valid VVVVVV executable. */
			set_error(errkey, "FIND_V_EXE_FOUNDERROR");
			continue;
		}

		n_processes++;

		/* If multiple VVVVVVs are running, we'll allow it if the executable is the same */
		if (n_processes > 1 && strcmp(real_exe, buffer) != 0)
		{
			set_error(errkey, "FIND_V_EXE_MULTI");
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


/*
 * Copy pipe file descriptor to out parameter if it is not NULL, otherwise just close the pipe.
 */
static void retain_or_close_pipe(int* out_pipe, int fd)
{
	if (out_pipe == NULL)
	{
		close(fd);
	}
	else
	{
		*out_pipe = fd;
	}
}

enum { READ_END = 0, WRITE_END = 1 };
#define EXIT_CHILD_EXEC_FAIL 70

/*
 * Start a child process and get its pid.
 * On success returns pid (as int64_t), on failure returns a negative number and sets errmsg.
 * You can get stdio pipe handles via arguments, or pass NULL to not get that pipe (retrieved pipes
 * will need to be closed later). You probably SHOULD retain stdout, or VVVVVV may get SIGPIPE'd.
 * Note that this function will return a pid - indicating success - even if starting VVVVVV is going
 * to fail. This will become apparent when calling await_process, because the process exits with
 * a special code and prints the error to stderr. You may thus want to get the stderr pipe for passing
 * it to await_process, it handles this and you can get a more detailed error message in this case.
 */
int64_t start_process(
	const char* const cmd[], /* in */
	unsigned int timeout,    /* in, 0 for no timeout */
	int* stdin_write_end,    /* out, nullable */
	int* stdout_read_end,    /* out, nullable */
	int* stderr_read_end,    /* out, nullable */
	const char** errmsg      /* out, nullable */
)
{
	int p_stdin[2], p_stdout[2], p_stderr[2];

	if (pipe(p_stdin) != 0 || pipe(p_stdout) != 0 || pipe(p_stderr) != 0)
	{
		set_error_strerror(errmsg);
		return -1;
	}

	pid_t pid = fork();
	if (pid < 0)
	{
		set_error_strerror(errmsg);
		return -1;
	}

	if (pid == 0)
	{
		/* Child code. First stop blocking signals - this is a main thread now. */
		sigset_t sig_mask;
		sigemptyset(&sig_mask);
		sigprocmask(SIG_SETMASK, &sig_mask, NULL);

		close(p_stdin[WRITE_END]);
		close(p_stdout[READ_END]);
		close(p_stderr[READ_END]);
		dup2(p_stdin[READ_END], STDIN_FILENO);
		dup2(p_stdout[WRITE_END], STDOUT_FILENO);
		dup2(p_stderr[WRITE_END], STDERR_FILENO);

		/* For legacy reasons, we can't pass "const char* const*"...
		 * We have a (non-const) pointer to an array full of const pointers to const strings.
		 * We have to pass a pointer to an array full of const pointers to mutable strings!
		 * But they don't actually have to be mutable. */
		char* const* cmd_cast = (char* const*) cmd;

		if (timeout != 0)
		{
			/* Poison pill for 2.2 where -version doesn't instantly exit.
			 * When the alarm goes off and it's unhandled, the program is terminated */
			alarm(timeout);
		}

		execv(cmd_cast[0], cmd_cast);

		/* execv only returns if an error occurred... So if we're here, it did!
		 * We can't really set_error anymore... */
		fprintf(stderr, "%s", strerror(errno));
		exit(EXIT_CHILD_EXEC_FAIL);
	}

	/* Parent code */
	close(p_stdin[READ_END]);
	close(p_stdout[WRITE_END]);
	close(p_stderr[WRITE_END]);
	retain_or_close_pipe(stdin_write_end, p_stdin[WRITE_END]);
	retain_or_close_pipe(stdout_read_end, p_stdout[READ_END]);
	retain_or_close_pipe(stderr_read_end, p_stderr[READ_END]);

	return pid;
}


/*
 * Simply write(write_end, data, data_size) but different
 * Returns false if error, true if successful.
 * You can only use this once for a pipe. After calling this function, the pipe is closed.
 */
bool write_to_pipe(int write_end, const char* data, size_t data_size, const char** errmsg)
{
	/* Avoid getting SIGPIPE'd if starting VVVVVV failed (only happens on macOS?) */
	struct sigaction new, old;
	new.sa_handler = SIG_IGN;
	sigemptyset(&new.sa_mask);
	new.sa_flags = 0;
	sigaction(SIGPIPE, &new, &old);

	bool success = true;
	ssize_t bytes_left = data_size;
	while (bytes_left > 0)
	{
		ssize_t written = write(write_end, &data[data_size-bytes_left], bytes_left);
		if (written < 0)
		{
			set_error_strerror(errmsg);
			success = false;
			break;
		}
		bytes_left -= written;
	}
	if (close(write_end) < 0 && success)
	{
		set_error_strerror(errmsg);
		success = false;
	}

	/* Restore old signal handler */
	sigaction(SIGPIPE, &old, NULL);

	return success;
}

/*
 * Reads data from a pipe file descriptor. mallocs for convenience, and also null-terminates.
 * You can pass out_bytes_read to get the number of bytes read, but you may also pass NULL.
 * Returns malloc'ed pointer on success, NULL on error (and sets errmsg).
 * You should free the returned pointer with pipedata_free.
 */
char* read_from_pipe(int read_end, size_t* out_bytes_read, const char** errmsg)
{
	if (out_bytes_read != NULL)
	{
		*out_bytes_read = 0;
	}

	/* capacity excludes space for a null terminator, so we know we can always add one */
	size_t capacity = 1024;
	char* buf = malloc(capacity + 1);
	if (buf == NULL)
	{
		set_error_strerror(errmsg);
		return NULL;
	}

	size_t pos = 0;
	while (true)
	{
		ssize_t cur_bytes_read = read(read_end, &buf[pos], capacity - pos);
		if (cur_bytes_read < 0)
		{
			set_error_strerror(errmsg);
			free(buf);
			return NULL;
		}
		else if (cur_bytes_read == 0)
		{
			/* EOF */
			break;
		}
		pos += cur_bytes_read;

		if (out_bytes_read != NULL)
		{
			(*out_bytes_read) += cur_bytes_read;
		}

		/* Buffer more than halfway filled? */
		if (pos*2 > capacity)
		{
			capacity *= 2;
			char* tmp = realloc(buf, capacity + 1);
			if (tmp == NULL)
			{
				set_error_strerror(errmsg);
				free(buf);
				return NULL;
			}
			buf = tmp;
		}
	}
	buf[pos] = '\0';

	return buf;
}

/*
 * Frees the malloc'ed data obtained from read_from_pipe
 */
void pipedata_free(char* data)
{
	free(data);
}



/* Kept around until process_cleanup is called */
char* last_process_errmsg = NULL;

/*
 * Wait for a child process to finish.
 * You HAVE to call this function at some point after successfully starting a process!
 * Returns true if process started and exited cleanly (out_exitcode is set), false if not (errmsg is set)
 */
bool await_process(
	int64_t pid,          /* in */
	int* stderr_read_end, /* in, nullable */
	int* out_exitcode,    /* out, nullable */
	const char** errmsg   /* out, nullable */
)
{
	int wstatus;
	pid_t rpid = waitpid(pid, &wstatus, 0);
	if (rpid < 0)
	{
		set_error_strerror(errmsg);
		return false;
	}

	if (WIFSIGNALED(wstatus))
	{
		int sig = WTERMSIG(wstatus);
		if (sig == SIGALRM)
		{
			/* Our time-out tripped, that can only mean we were trying -version on 2.2... */
			set_error(errmsg, ved_L("VVVVVV_22_OR_OLDER"));
		}
		else
		{
			set_error(errmsg, strsignal(sig));
		}
		return false;
	}
	else if (WIFEXITED(wstatus))
	{
		int exitcode = WEXITSTATUS(wstatus);
		if (exitcode == EXIT_CHILD_EXEC_FAIL)
		{
			/* The non-transformed child process reports that execv failed! */
			free(last_process_errmsg);
			last_process_errmsg = NULL;

			if (stderr_read_end != NULL)
			{
				last_process_errmsg = read_from_pipe(*stderr_read_end, NULL, NULL);
			}

			if (last_process_errmsg != NULL)
			{
				set_error(errmsg, last_process_errmsg);
			}
			else
			{
				set_error(errmsg, ved_L("VVVVVV_SOMETHING_HAPPENED"));
			}

			return false;
		}

		/* Process terminated cleanly */
		if (out_exitcode != NULL)
		{
			*out_exitcode = exitcode;
		}
		return true;
	}

	/* We shouldn't be getting "stopped" signals or anything else? */
	set_error(errmsg, "Unexpected wstatus from waitpid, this should not happen!");
	return false;
}

/*
 * Needs to be called at some point after doing await_process, even if that failed.
 * Cleans up internally, and also closes the pipe handles you give.
 */
void process_cleanup(int* stdin_write_end, int* stdout_read_end, int* stderr_read_end)
{
	if (stdin_write_end != NULL)
	{
		close(*stdin_write_end);
	}
	if (stdout_read_end != NULL)
	{
		close(*stdout_read_end);
	}
	if (stderr_read_end != NULL)
	{
		close(*stderr_read_end);
	}

	pipedata_free(last_process_errmsg);
	last_process_errmsg = NULL;
}
