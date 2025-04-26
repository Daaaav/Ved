/* Just some of the WinAPI types on an as-needed basis. */

typedef unsigned short WORD, *PWORD, *LPWORD;
typedef unsigned long DWORD, *PDWORD, *LPDWORD;
typedef unsigned char BYTE, *PBYTE, *LPBYTE;
typedef bool BOOL, *PBOOL, *LPBOOL;
typedef unsigned int UINT;
typedef void VOID, *PVOID, *LPVOID;
typedef const void* LPCVOID;
typedef PVOID HANDLE, *PHANDLE, *LPHANDLE;
typedef char CHAR, *PCHAR;
typedef char* PSTR, *LPSTR;
typedef const char* LPCSTR;
typedef wchar_t WCHAR, *PWCHAR;
typedef wchar_t* LPWSTR, *PWSTR;
typedef const wchar_t* LPCWSTR;

typedef void* DWORD_PTR;
typedef void* ULONG_PTR;

/* Weird ifdeffed types actually but I checked both 32 and 64 bit */
typedef uintptr_t UINT_PTR;
typedef intptr_t LONG_PTR;

typedef UINT_PTR WPARAM;
typedef LONG_PTR LPARAM;

typedef LPCSTR LPCCH;
typedef LPCWSTR LPCWCH;

typedef void TIME_ZONE_INFORMATION;

typedef long LONG;
typedef LONG HRESULT;
typedef HANDLE HWND;

typedef HANDLE HINSTANCE;
typedef HINSTANCE HMODULE;

typedef VOID (__stdcall *LPOVERLAPPED_COMPLETION_ROUTINE) (
  DWORD  dwErrorCode,
  DWORD  dwNumberOfBytesTransfered,
  LPVOID lpOverlapped
);

typedef BOOL (__stdcall *WNDENUMPROC) (
  HWND   hwnd,
  LPARAM lParam
);
