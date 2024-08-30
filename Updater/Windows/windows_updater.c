#include <windows.h>
#include <wchar.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "log.h"
#include "read_list.h"
#include "strings.h"
#include "UTF816.h"

#define N_MSG 1024
static char msg[N_MSG];

static const char* format_win_error(const DWORD code)
{
	switch (code)
	{
	case ERROR_VIRUS_INFECTED:
	case ERROR_VIRUS_DELETED:
		// Just in case a false alarm makes _my_ dialog confidently say "this is a virus"...
		return get_string("ANTIVIRUS_BROKE");
	}

	WCHAR win_msg_utf16[N_MSG];
	win_msg_utf16[0] = '\0';
	const DWORD written = FormatMessageW(
		FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL, code, 0, win_msg_utf16, N_MSG, NULL
	);
	// Windows messages always(?) end with a CRLF...
	if (written >= 2 && win_msg_utf16[written-2] == '\r' && win_msg_utf16[written-1] == '\n')
	{
		win_msg_utf16[written-2] = '\0';
	}

	static char win_msg_utf8[N_MSG];
	UTF16_to_UTF8_buf(win_msg_utf16, win_msg_utf8, N_MSG);

	return win_msg_utf8;
}

static const char* format_last_win_error(void)
{
	return format_win_error(GetLastError());
}


static int alert(const char* text, const char* title, const UINT type)
{
	/* Just a wrapper to simplify MessageBox calls and also log things.
	 * MB_SYSTEMMODAL may be a bit much, but since I don't have a window,
	 * my dialogs keep disappearing behind other ones... */

	const DWORD last_err = GetLastError();

	log_write(text);

	WCHAR* text_utf16 = UTF8_to_UTF16_alloc(text);
	WCHAR* title_utf16 = UTF8_to_UTF16_alloc(title);
	int answer = MessageBoxW(NULL, text_utf16, title_utf16, MB_SYSTEMMODAL | type);
	free(title_utf16);
	free(text_utf16);

	if (answer == 0)
	{
		char buf[128];
		snprintf(buf, sizeof(buf), "CANNOT SHOW MESSAGEBOX! Error %d", GetLastError());
		log_write(buf);

		answer = IDCANCEL;
	}

	RestoreLastError(last_err);

	return answer;
}


static char* update_list;
static char* update_current_file = NULL;
static bool rollback_went_questionably = false;


static bool next(void)
{
	/* This is a recursive "pyramid" which handles one file per call.
	 * If anything fails, we can easily rollback everything we did in reverse order,
	 * and we can do cleanups after everything is either confirmed succeeded or failed.
	 * Don't worry about the stack size, it should be increased during compilation. */

	if (update_current_file == NULL)
	{
		// First filename
		update_current_file = update_list;
	}
	else
	{
		// Next filename
		if (!next_line(&update_current_file))
		{
			return true;
		}
	}

	WCHAR dst_filename[MAX_PATH];
	WCHAR src_filename[MAX_PATH];
	WCHAR bak_filename[MAX_PATH];
	UTF8_to_UTF16_buf(update_current_file, dst_filename, MAX_PATH);
	snwprintf(src_filename, MAX_PATH, L"update\\%ls", dst_filename);
	snwprintf(bak_filename, MAX_PATH, L"%ls.bak", dst_filename);

	enum _action {NONE, REPLACE, ADD} used_action = NONE;
	while (true)
	{
		if (ReplaceFileW(dst_filename, src_filename, bak_filename, REPLACEFILE_IGNORE_MERGE_ERRORS, NULL, NULL))
		{
			// Success :D
			used_action = REPLACE;
			break;
		}

		/* ReplaceFile went wrong... Why?
		 * Of special note is ERROR_UNABLE_TO_MOVE_REPLACEMENT_2.
		 * It means the original destination file is left with the backup name,
		 * but this also seems extremely rare - let's assume it's for well-timed
		 * disk failure that prevented Windows from renaming the file back.
		 * All other error codes mean both src and dst file are untouched. */
		DWORD err = GetLastError();
		const char* err_template = get_string("CANNOT_REPLACE");

		if (err == ERROR_FILE_NOT_FOUND)
		{
			// You can't "overwrite" a nonexistent file... :I
			if (MoveFileW(src_filename, dst_filename))
			{
				// Success :D
				used_action = ADD;
				break;
			}
			err = GetLastError();
			/* If we get FILE NOT FOUND *again*, the source file must not exist...
			 * If we get a different error, *then* it's an "adding" problem. */
			if (err != ERROR_FILE_NOT_FOUND)
			{
				err_template = get_string("CANNOT_ADD");
			}
		}

		snprintf(msg, N_MSG, err_template, update_current_file, format_win_error(err));
		if (alert(msg, get_string("UPDATE_PAUSED"), MB_ICONWARNING | MB_RETRYCANCEL) == IDCANCEL)
		{
			// Initiate rollback! Nothing to do for the current file
			return false;
		}
	}

	if (!next())
	{
		// Rollback this file. Of course, any part of this could fail too...
		bool rb_success = true;
		if (used_action == REPLACE && !ReplaceFileW(dst_filename, bak_filename, NULL, REPLACEFILE_IGNORE_MERGE_ERRORS, NULL, NULL))
		{
			if (GetLastError() != ERROR_FILE_NOT_FOUND || !MoveFileW(bak_filename, dst_filename))
			{
				snprintf(msg, N_MSG, get_string("CANNOT_ROLLBACK"), update_current_file, format_last_win_error());
				rb_success = false;
			}
		}
		else if (used_action == ADD && !DeleteFileW(dst_filename))
		{
			snprintf(msg, N_MSG, get_string("CANNOT_DELETE"), update_current_file, format_last_win_error());
			rb_success = false;
		}

		if (!rb_success)
		{
			alert(msg, get_string("ROLLBACK_ERROR"), MB_ICONSTOP);
			rollback_went_questionably = true;
		}

		return false;
	}

	// Fully successful update, clean stuff up!
	if (used_action == REPLACE)
	{
		DeleteFileW(bak_filename);
	}

	return true;
}


int main()
{
	// Parse arguments
	int argc;
	LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);

	bool shift_await = false;
	bool shift_lang = false;

	for (int i = 0; i < argc; i++)
	{
		char* arg = UTF16_to_UTF8_alloc(argv[i]);
		if (shift_await)
		{
			// Ved can give us a process handle of itself, so we can start only when it has exited
			HANDLE handle = (HANDLE)strtoull(arg, NULL, 0);
			WaitForSingleObject(handle, 2000);
			CloseHandle(handle);
			shift_await = false;
		}
		else if (shift_lang)
		{
			strings_set_lang(arg);
			shift_lang = false;
		}
		else if (strcmp(arg, "-await") == 0)
		{
			shift_await = true;
		}
		else if (strcmp(arg, "-lang") == 0)
		{
			shift_lang = true;
		}
		free(arg);
	}

	LocalFree(argv);

	// Get the list of files we need to update
	if (!read_list(L"update\\updatefiles.txt", &update_list))
	{
		snprintf(msg, N_MSG, get_string("CANNOT_BEGIN"), format_last_win_error());
		alert(msg, get_string("UPDATE_NOT_APPLIED"), MB_ICONINFORMATION);
	}
	else
	{
		// Start the update pyramid!
		if (!next())
		{
			// Something went wrong and everything has already been rolled back... Hopefully
			if (rollback_went_questionably)
			{
				alert(get_string("BAD_ROLLBACK"), get_string("ROLLBACK_FAILED"), MB_ICONSTOP);
			}
			else
			{
				alert(get_string("GOOD_ROLLBACK"), get_string("UPDATE_NOT_APPLIED"), MB_ICONINFORMATION);
			}
		}
		else
		{
			// Update succeeded! Get rid of the update dir if possible...
			WIN32_FIND_DATAW file;
			HANDLE h = FindFirstFileW(L"update\\*", &file);
			if (h != INVALID_HANDLE_VALUE)
			{
				do
				{
					if (file.cFileName[0] == '.')
					{
						continue;
					}
					WCHAR path[MAX_PATH];
					snwprintf(path, MAX_PATH, L"update\\%ls", file.cFileName);
					DeleteFileW(path);
				}
				while (FindNextFileW(h, &file));
				FindClose(h);
			}
			RemoveDirectoryW(L"update");
		}

		free(update_list);
	}

	// Launch Ved again
	STARTUPINFOW si;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	PROCESS_INFORMATION pi;
	ZeroMemory(&pi, sizeof(pi));

	if (!CreateProcessW(L"Ved.exe", NULL, NULL, NULL, false, CREATE_NO_WINDOW, NULL, NULL, &si, &pi))
	{
		snprintf(msg, N_MSG, get_string("CANNOT_LAUNCH_VED_DESC"), format_last_win_error());
		alert(msg, get_string("CANNOT_LAUNCH_VED_TITLE"), MB_ICONSTOP);
	}

	// Close log file and strings, if they were open
	log_close();
	strings_close();

	return 0;
}
