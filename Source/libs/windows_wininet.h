typedef PVOID HINTERNET;
typedef HINTERNET *LPHINTERNET;

HINTERNET InternetOpenW(
  LPCWSTR lpszAgent,
  DWORD   dwAccessType,
  LPCWSTR lpszProxy,
  LPCWSTR lpszProxyBypass,
  DWORD   dwFlags
);

HINTERNET InternetOpenUrlW(
  HINTERNET hInternet,
  LPCWSTR   lpszUrl,
  LPCWSTR   lpszHeaders,
  DWORD     dwHeadersLength,
  DWORD     dwFlags,
  DWORD_PTR dwContext
);

BOOL InternetReadFile(
  HINTERNET hFile,
  LPVOID    lpBuffer,
  DWORD     dwNumberOfBytesToRead,
  LPDWORD   lpdwNumberOfBytesRead
);

BOOL InternetCloseHandle(
  HINTERNET hInternet
);
