#include <windows.h>
#include <wchar.h>

static HANDLE fh = INVALID_HANDLE_VALUE;

void log_write(const char* text)
{
	/* Log the specified text to a log file.
	 * The log will be opened automatically upon the first write.
	 * Guarantees to not change GetLastError(). */
	if (text == NULL)
	{
		return;
	}

	const DWORD last_err = GetLastError();

	if (fh == INVALID_HANDLE_VALUE)
	{
		SYSTEMTIME t;
		GetLocalTime(&t);
		WCHAR logname[MAX_PATH];
		snwprintf(
			logname, MAX_PATH,
			L"UpdateLog_%d-%02d-%02d_%02d.%02d.%02d.txt",
			t.wYear, t.wMonth, t.wDay, t.wHour, t.wMinute, t.wSecond
		);

		fh = CreateFileW(logname, GENERIC_WRITE, 0, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
		if (fh == INVALID_HANDLE_VALUE)
		{
			RestoreLastError(last_err);
			return;
		}
	}

	DWORD written;
	WriteFile(fh, text, strlen(text), &written, NULL);
	WriteFile(fh, "\r\n", 2, &written, NULL);

	RestoreLastError(last_err);
}

void log_close(void)
{
	if (fh != INVALID_HANDLE_VALUE)
	{
		FlushFileBuffers(fh);
		CloseHandle(fh);
	}
}
