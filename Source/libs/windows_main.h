/* Windows API structs and functions normally available via simply include <windows.h>, on an as-needed basis. */

typedef struct _FILETIME {
  DWORD dwLowDateTime;
  DWORD dwHighDateTime;
} FILETIME, *PFILETIME, *LPFILETIME;

typedef struct _WIN32_FIND_DATAW {
  DWORD    dwFileAttributes;
  FILETIME ftCreationTime;
  FILETIME ftLastAccessTime;
  FILETIME ftLastWriteTime;
  DWORD    nFileSizeHigh;
  DWORD    nFileSizeLow;
  DWORD    dwReserved0;
  DWORD    dwReserved1;
  WCHAR    cFileName[260];
  WCHAR    cAlternateFileName[14];
  DWORD    dwFileType;
  DWORD    dwCreatorType;
  WORD     wFinderFlags;
} WIN32_FIND_DATAW, *PWIN32_FIND_DATAW, *LPWIN32_FIND_DATAW;

typedef struct _SYSTEMTIME {
  WORD wYear;
  WORD wMonth;
  WORD wDayOfWeek;
  WORD wDay;
  WORD wHour;
  WORD wMinute;
  WORD wSecond;
  WORD wMilliseconds;
} SYSTEMTIME, *PSYSTEMTIME, *LPSYSTEMTIME;

typedef struct _SECURITY_ATTRIBUTES {
  DWORD  nLength;
  LPVOID lpSecurityDescriptor;
  BOOL   bInheritHandle;
} SECURITY_ATTRIBUTES, *PSECURITY_ATTRIBUTES, *LPSECURITY_ATTRIBUTES;

typedef struct _STARTUPINFOW {
  DWORD  cb;
  LPWSTR lpReserved;
  LPWSTR lpDesktop;
  LPWSTR lpTitle;
  DWORD  dwX;
  DWORD  dwY;
  DWORD  dwXSize;
  DWORD  dwYSize;
  DWORD  dwXCountChars;
  DWORD  dwYCountChars;
  DWORD  dwFillAttribute;
  DWORD  dwFlags;
  WORD   wShowWindow;
  WORD   cbReserved2;
  LPBYTE lpReserved2;
  HANDLE hStdInput;
  HANDLE hStdOutput;
  HANDLE hStdError;
} STARTUPINFOW, *LPSTARTUPINFOW;

typedef struct _PROCESS_INFORMATION {
  HANDLE hProcess;
  HANDLE hThread;
  DWORD  dwProcessId;
  DWORD  dwThreadId;
} PROCESS_INFORMATION, *PPROCESS_INFORMATION, *LPPROCESS_INFORMATION;

typedef struct _OVERLAPPED {
  ULONG_PTR Internal;
  ULONG_PTR InternalHigh;
  union {
    struct {
      DWORD Offset;
      DWORD OffsetHigh;
    } DUMMYSTRUCTNAME;
    PVOID Pointer;
  } DUMMYUNIONNAME;
  HANDLE    hEvent;
} OVERLAPPED, *LPOVERLAPPED;

HANDLE FindFirstFileW(
  LPCWSTR            lpFileName,
  LPWIN32_FIND_DATAW lpFindFileData
);

BOOL FindNextFileW(
  HANDLE             hFindFile,
  LPWIN32_FIND_DATAW lpFindFileData
);

BOOL FindClose(
  HANDLE hFindFile
);

BOOL FileTimeToSystemTime(
  const FILETIME *lpFileTime,
  LPSYSTEMTIME   lpSystemTime
);

BOOL SystemTimeToTzSpecificLocalTime(
  const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
  const SYSTEMTIME            *lpUniversalTime,
  LPSYSTEMTIME                lpLocalTime
);

DWORD GetFileAttributesW(
  LPCWSTR lpFileName
);

HANDLE CreateFileW(
  LPCWSTR               lpFileName,
  DWORD                 dwDesiredAccess,
  DWORD                 dwShareMode,
  LPSECURITY_ATTRIBUTES lpSecurityAttributes,
  DWORD                 dwCreationDisposition,
  DWORD                 dwFlagsAndAttributes,
  HANDLE                hTemplateFile
);

BOOL CloseHandle(
  HANDLE hObject
);

DWORD GetFileSize(
  HANDLE  hFile,
  LPDWORD lpFileSizeHigh
);

BOOL GetFileTime(
  HANDLE     hFile,
  LPFILETIME lpCreationTime,
  LPFILETIME lpLastAccessTime,
  LPFILETIME lpLastWriteTime
);

BOOL ReadFile(
  HANDLE       hFile,
  LPVOID       lpBuffer,
  DWORD        nNumberOfBytesToRead,
  LPDWORD      lpNumberOfBytesRead,
  LPOVERLAPPED lpOverlapped
);

BOOL WriteFile(
  HANDLE       hFile,
  LPCVOID      lpBuffer,
  DWORD        nNumberOfBytesToWrite,
  LPDWORD      lpNumberOfBytesWritten,
  LPOVERLAPPED lpOverlapped
);

BOOL FlushFileBuffers(
  HANDLE hFile
);

DWORD GetLastError(void);

DWORD FormatMessageW(
  DWORD   dwFlags,
  LPCVOID lpSource,
  DWORD   dwMessageId,
  DWORD   dwLanguageId,
  LPWSTR  lpBuffer,
  DWORD   nSize,
  va_list *Arguments
);

DWORD GetEnvironmentVariableW(
  LPCWSTR lpName,
  LPWSTR  lpBuffer,
  DWORD   nSize
);

HRESULT SHGetFolderPathW(
  HWND   hwnd,
  int    csidl,
  HANDLE hToken,
  DWORD  dwFlags,
  LPWSTR pszPath
);

DWORD GetLogicalDrives();

BOOL CreatePipe(
  PHANDLE               hReadPipe,
  PHANDLE               hWritePipe,
  LPSECURITY_ATTRIBUTES lpPipeAttributes,
  DWORD                 nSize
);

BOOL SetHandleInformation(
  HANDLE hObject,
  DWORD  dwMask,
  DWORD  dwFlags
);

HANDLE GetStdHandle(
  DWORD nStdHandle
);

BOOL CreateProcessW(
  LPCWSTR               lpApplicationName,
  LPWSTR                lpCommandLine,
  LPSECURITY_ATTRIBUTES lpProcessAttributes,
  LPSECURITY_ATTRIBUTES lpThreadAttributes,
  BOOL                  bInheritHandles,
  DWORD                 dwCreationFlags,
  LPVOID                lpEnvironment,
  LPCWSTR               lpCurrentDirectory,
  LPSTARTUPINFOW        lpStartupInfo,
  LPPROCESS_INFORMATION lpProcessInformation
);

DWORD WaitForSingleObject(
  HANDLE hHandle,
  DWORD  dwMilliseconds
);

BOOL TerminateProcess(
  HANDLE hProcess,
  UINT   uExitCode
);

BOOL GetExitCodeProcess(
  HANDLE  hProcess,
  LPDWORD lpExitCode
);

BOOL EnumProcesses(
  DWORD   *lpidProcess,
  DWORD   cb,
  LPDWORD lpcbNeeded
);

HANDLE OpenProcess(
  DWORD dwDesiredAccess,
  BOOL  bInheritHandle,
  DWORD dwProcessId
);

BOOL EnumProcessModulesEx(
  HANDLE  hProcess,
  HMODULE *lphModule,
  DWORD   cb,
  LPDWORD lpcbNeeded,
  DWORD   dwFilterFlag
);

DWORD GetModuleBaseNameW(
  HANDLE  hProcess,
  HMODULE hModule,
  LPWSTR  lpBaseName,
  DWORD   nSize
);

DWORD GetModuleFileNameExW(
  HANDLE  hProcess,
  HMODULE hModule,
  LPWSTR  lpFilename,
  DWORD   nSize
);

/* UTF-8 -> UTF-16 */
int MultiByteToWideChar(
  UINT   CodePage,
  DWORD  dwFlags,
  LPCCH  lpMultiByteStr,
  int    cbMultiByte,
  LPWSTR lpWideCharStr,
  int    cchWideChar
);

/* UTF-16 -> UTF-8 */
int WideCharToMultiByte(
  UINT   CodePage,
  DWORD  dwFlags,
  LPCWCH lpWideCharStr,
  int    cchWideChar,
  LPSTR  lpMultiByteStr,
  int    cbMultiByte,
  LPCCH  lpDefaultChar,
  LPBOOL lpUsedDefaultChar
);
