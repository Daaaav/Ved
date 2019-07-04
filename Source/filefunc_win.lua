local cache_modtimes = {} -- filepath => unix_timestamp


-- Some Windows constants
CP_UTF8 = 65001
FILE_ATTRIBUTE_HIDDEN = 0x2
FILE_ATTRIBUTE_DIRECTORY = 0x10
FILE_ATTRIBUTE_NORMAL = 0x80
FILE_ATTRIBUTE_REPARSE_POINT = 0x400
FILE_SHARE_READ = 1
FORMAT_MESSAGE_FROM_SYSTEM = 0x00001000
FORMAT_MESSAGE_IGNORE_INSERTS = 0x00000200
GENERIC_READ = 0x80000000
GENERIC_WRITE = 0x40000000
INVALID_FILE_ATTRIBUTES = 0xFFFFFFFF
INVALID_FILE_SIZE = 0xFFFFFFFF
INVALID_HANDLE_VALUE = -1
MAX_PATH = 260
OPEN_EXISTING = 3; CREATE_ALWAYS = 2


local ffi = require("ffi")
ffi.cdef([[
	typedef unsigned short WORD, *PWORD, *LPWORD;
	typedef unsigned long DWORD, *PDWORD, *LPDWORD;
	typedef bool BOOL, *PBOOL, *LPBOOL;
	typedef unsigned int UINT;
	typedef void* HANDLE;
	typedef void VOID, *PVOID, *LPVOID;
	typedef const void* LPCVOID;
	typedef char CHAR, *PCHAR;
	typedef char* PSTR, *LPSTR;
	typedef const char* LPCSTR;
	typedef wchar_t WCHAR, *PWCHAR;
	typedef wchar_t* LPWSTR, *PWSTR;
	typedef const wchar_t* LPCWSTR;

	typedef LPCSTR LPCCH;
	typedef LPCWSTR LPCWCH;

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

	BOOL FileTimeToSystemTime(
	  const FILETIME *lpFileTime,
	  LPSYSTEMTIME   lpSystemTime
	);

	typedef void TIME_ZONE_INFORMATION;

	BOOL SystemTimeToTzSpecificLocalTime(
	  const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
	  const SYSTEMTIME            *lpUniversalTime,
	  LPSYSTEMTIME                lpLocalTime
	);

	DWORD GetFileAttributesW(
	  LPCWSTR lpFileName
	);

	typedef void* LPSECURITY_ATTRIBUTES;

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

	typedef void* LPOVERLAPPED;

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

	DWORD GetLogicalDrives(

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
]])


buffer_filedata = ffi.new("WIN32_FIND_DATAW")
buffer_st_utc = ffi.new("SYSTEMTIME")
buffer_st_loc = ffi.new("SYSTEMTIME")
buffer_filetime = ffi.new("FILETIME")
buffer_path_utf8 = ffi.new("CHAR[?]", MAX_PATH*4)
buffer_path_utf16 = ffi.new("WCHAR[?]", MAX_PATH)
buffer_formatmessage_utf16 = ffi.new("WCHAR[?]", 512)
buffer_formatmessage_utf8 = ffi.new("CHAR[?]", 512)



function path_utf8_to_utf16(lua_str)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0, lua_str, -1, buffer_path_utf16, MAX_PATH)
	return buffer_path_utf16
end

function path_utf16_to_utf8(wstr)
	ffi.C.WideCharToMultiByte(CP_UTF8, 0, wstr, -1, buffer_path_utf8, MAX_PATH*4, nil, nil)
	return ffi.string(buffer_path_utf8)
end

function file_attributes_directory(dwAttributes)
	return bit(dwAttributes, FILE_ATTRIBUTE_DIRECTORY)
end

function handle_is_invalid(handle)
	return tonumber(ffi.cast("intptr_t", handle)) == INVALID_HANDLE_VALUE
end

function format_last_win_error()
	ffi.C.FormatMessageW(
		FORMAT_MESSAGE_FROM_SYSTEM + FORMAT_MESSAGE_IGNORE_INSERTS,
		nil, ffi.C.GetLastError(), 0, buffer_formatmessage_utf16, 512, nil
	)
	ffi.C.WideCharToMultiByte(
		CP_UTF8, 0, buffer_formatmessage_utf16, -1, buffer_formatmessage_utf8, 512, nil, nil
	)
	return ffi.string(buffer_formatmessage_utf8):gsub("\r", "")
end


local len_text_userprofile = ("USERPROFILE"):len()+1
local buffer_text_userprofile_utf16 = ffi.new("WCHAR[?]", len_text_userprofile)
ffi.C.MultiByteToWideChar(
	CP_UTF8, 0, "USERPROFILE", -1, buffer_text_userprofile_utf16, len_text_userprofile
)
ffi.C.GetEnvironmentVariableW(buffer_text_userprofile_utf16, buffer_path_utf16, MAX_PATH)
userprofile = path_utf16_to_utf8(buffer_path_utf16)



function listlevelfiles(directory)
	local t = {[""] = {}}

	-- We really can't have slashes here instead of backslashes, this is Windows.
	directory = directory:gsub("/", "\\")
	-- We can't have a trailing backslash either, or our matching system will blow up. This comes in the form of a double backslash.
	directory = directory:gsub("\\\\", "\\")

	local search_handle = ffi.C.FindFirstFileW(path_utf8_to_utf16(directory .. "\\*"), buffer_filedata)
	if handle_is_invalid(search_handle) then
		return t
	end
	local currentdir = ""
	local prefix = ""
	local directory_insertion_point = 1
	local subdirectories_left = {}
	local isdir
	local current_name
	local current_data
	local files_left = true
	while files_left do
		isdir = file_attributes_directory(buffer_filedata.dwFileAttributes)
		current_name = path_utf16_to_utf8(buffer_filedata.cFileName)
		if current_name ~= "." and current_name ~= ".." then
			if isdir then
				table.insert(subdirectories_left, prefix .. current_name)
			end

			if isdir or current_name:sub(-7, -1) == ".vvvvvv" then
				ffi.C.FileTimeToSystemTime(buffer_filedata.ftLastWriteTime, buffer_st_utc)
				ffi.C.SystemTimeToTzSpecificLocalTime(nil, buffer_st_utc, buffer_st_loc)

				current_data = {
					name = current_name,
					isdir = isdir,
					result_shown = true,
					bu_lastmodified = 0,
					bu_overwritten = 0,
					lastmodified = {
						buffer_st_loc.wYear, buffer_st_loc.wMonth, buffer_st_loc.wDay,
						buffer_st_loc.wHour, buffer_st_loc.wMinute, buffer_st_loc.wSecond
					},
				}

				if isdir then
					-- Group directories first
					table.insert(t[currentdir], directory_insertion_point, current_data)
					directory_insertion_point = directory_insertion_point + 1
				else
					table.insert(t[currentdir], current_data)
				end
			end
		end
		files_left = ffi.C.FindNextFileW(search_handle, buffer_filedata)
		if not files_left and #subdirectories_left > 0 then
			ffi.C.FindClose(search_handle)

			currentdir = table.remove(subdirectories_left, 1)
			prefix = currentdir .. "\\"
			directory_insertion_point = 1

			t[currentdir] = {}

			search_handle = ffi.C.FindFirstFileW(
				path_utf8_to_utf16(directory .. "\\" .. prefix .. "*"),
				buffer_filedata
			)

			files_left = true
		end
	end
	ffi.C.FindClose(search_handle)
	return t
end

function listfiles_generic(directory, filter, show_hidden)
	-- If successful, returns: true, files.
	-- If not, returns: false, {}, message.
	local files = {}

	if directory == "" then
		-- Change of plans, we're above C: or whatever, list all the drives.
		local drivebits = ffi.C.GetLogicalDrives()

		for d = 0, 25 do
			if bit(drivebits, 2^d) then
				table.insert(files,
					{
						name = string.char(0x41+d) .. ":",
						isdir = true,
						lastmodified = 0,
					}
				)
			end
		end
		return true, files
	end

	local search_handle = ffi.C.FindFirstFileW(path_utf8_to_utf16(directory .. "\\*"), buffer_filedata)
	if handle_is_invalid(search_handle) then
		return false, {}, format_last_win_error()
	end
	local current_name
	local files_left = true
	while files_left do
		local isdir = file_attributes_directory(buffer_filedata.dwFileAttributes)
		current_name = path_utf16_to_utf8(buffer_filedata.cFileName)
		if current_name ~= "." and current_name ~= ".."
		and (isdir or filter == "" or current_name:sub(-filter:len(), -1) == filter)
		and not bit(buffer_filedata.dwFileAttributes, FILE_ATTRIBUTE_REPARSE_POINT)
		and (show_hidden or not bit(buffer_filedata.dwFileAttributes, FILE_ATTRIBUTE_HIDDEN)) then
			ffi.C.FileTimeToSystemTime(buffer_filedata.ftLastWriteTime, buffer_st_utc)
			ffi.C.SystemTimeToTzSpecificLocalTime(nil, buffer_st_utc, buffer_st_loc)

			table.insert(files,
				{
					name = current_name,
					isdir = isdir,
					lastmodified = {
						buffer_st_loc.wYear, buffer_st_loc.wMonth, buffer_st_loc.wDay,
						buffer_st_loc.wHour, buffer_st_loc.wMinute, buffer_st_loc.wSecond
					},
				}
			)
		end
		files_left = ffi.C.FindNextFileW(search_handle, buffer_filedata)
	end
	ffi.C.FindClose(search_handle)

	sort_files(files)
	return true, files
end

function get_parent_path(directory)
	-- "" counts as the list of drives.
	local last_dirsep = directory:reverse():find("\\", 1, true)
	if last_dirsep == nil then
		return ""
	end
	return directory:sub(1, -last_dirsep-1)
end

function get_child_path(directory, child)
	if directory == "" then
		return child
	end
	return directory .. "\\" .. child
end

function get_root_dir_display()
	return L.DRIVES
end

function filepath_from_dialog(folder, name)
	-- Returns the full path, and the final filename
	local last_dirsep = name:reverse():find("\\", 1, true)
	local filename
	if last_dirsep == nil then
		filename = name
	else
		filename = name:sub(-last_dirsep+1, -1)
	end
	if name:match("^[A-Z]:\\.*") ~= nil then
		return name, filename
	end
	return folder .. "\\" .. name, filename
end

function getlevelsfolder()
	-- Returns success. Sets the path variables to what they _should_ be, even if
	-- they don't exist. That way we can say "check {levelsfolder} exists and try again"

	if not directory_exists(userprofile, "\\Documents") and directory_exists(userprofile, "\\My Documents") then
		-- Windows XP still?
		vvvvvvfolder_expected = userprofile .. "\\My Documents\\VVVVVV"
	else
		vvvvvvfolder_expected = userprofile .. "\\Documents\\VVVVVV"
	end

	if s.customvvvvvvdir == "" then
		vvvvvvfolder = vvvvvvfolder_expected
	else
		-- The user has supplied a custom directory.
		vvvvvvfolder = s.customvvvvvvdir
	end

	levelsfolder = vvvvvvfolder .. "\\levels"
	graphicsfolder = vvvvvvfolder .. "\\graphics"
	soundsfolder = vvvvvvfolder .. "\\sounds"
	return directory_exists(vvvvvvfolder, "levels")
end

function directory_exists(where, what)
	local dwAttributes = ffi.C.GetFileAttributesW(path_utf8_to_utf16(where .. "\\" .. what))

	return dwAttributes ~= INVALID_FILE_ATTRIBUTES and file_attributes_directory(dwAttributes)
end

function readlevelfile(path)
	-- returns success, contents

	local file_handle = ffi.C.CreateFileW(
		path_utf8_to_utf16(path),
		GENERIC_READ,
		FILE_SHARE_READ,
		nil,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		nil
	)
	if handle_is_invalid(file_handle) then
		return false, format_last_win_error()
	end

	-- We may need this later, don't unnecessarily create two file handles for this
	ffi.C.GetFileTime(file_handle, nil, nil, buffer_filetime)
	local unix_time = (
		buffer_filetime.dwHighDateTime*2^32 + buffer_filetime.dwLowDateTime
	) / 10000000 - 11644473600
	cache_modtimes[path] = unix_time

	local dwFilesize = ffi.C.GetFileSize(file_handle, nil)
	if dwFilesize == INVALID_FILE_SIZE then
		-- They recommend GetFileSizeEx, but no way you'd want 4 GB VVVVVV levels
		ffi.C.CloseHandle(file_handle)
		return false, L.INVALIDFILESIZE
	end

	local buffer_contents = ffi.new("char[?]", dwFilesize+1)
	local lpNumberOfBytesRead = ffi.new("DWORD[1]")
	if not ffi.C.ReadFile(file_handle, buffer_contents, dwFilesize, lpNumberOfBytesRead, nil) then
		-- Reading failed.
		ffi.C.CloseHandle(file_handle)
		return false, format_last_win_error()
	end

	ffi.C.CloseHandle(file_handle)

	local ficontents = ffi.string(buffer_contents, lpNumberOfBytesRead[0])

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message
	if path:sub(3):match(".*[:%*%?\"<>|].*") ~= nil then
		return false, L.INVALIDFILENAME_WIN
	end

	local file_handle = ffi.C.CreateFileW(
		path_utf8_to_utf16(path),
		GENERIC_WRITE,
		0,
		nil,
		CREATE_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		nil
	)
	if handle_is_invalid(file_handle) then
		return false, format_last_win_error()
	end

	local lpNumberOfBytesWritten = ffi.new("DWORD[1]")
	if not ffi.C.WriteFile(file_handle, contents, contents:len(), lpNumberOfBytesWritten, nil) then
		-- Writing failed.
		ffi.C.CloseHandle(file_handle)
		return false, format_last_win_error()
	end

	ffi.C.CloseHandle(file_handle)

	return true, nil
end

function getmodtime(fullpath)
	return cache_modtimes[fullpath]
end

function readfile(filename)
	-- returns success, contents

	local file_handle = ffi.C.CreateFileW(
		path_utf8_to_utf16(filename),
		GENERIC_READ,
		FILE_SHARE_READ,
		nil,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		nil
	)
	if handle_is_invalid(file_handle) then
		return false, format_last_win_error()
	end

	local dwFilesize = ffi.C.GetFileSize(file_handle, nil)
	if dwFilesize == INVALID_FILE_SIZE then
		ffi.C.CloseHandle(file_handle)
		return false, L.INVALIDFILESIZE
	end

	local buffer_contents = ffi.new("char[?]", dwFilesize+1)
	local lpNumberOfBytesRead = ffi.new("DWORD[1]")
	if not ffi.C.ReadFile(file_handle, buffer_contents, dwFilesize, lpNumberOfBytesRead, nil) then
		-- Reading failed.
		ffi.C.CloseHandle(file_handle)
		return false, format_last_win_error()
	end

	ffi.C.CloseHandle(file_handle)

	local ficontents = ffi.string(buffer_contents, lpNumberOfBytesRead[0])

	return true, ficontents
end

-- multiwritefile_* are meant for writing to a file multiple times in a row (handy for music files).
-- os_fh can mean lua's file object, a Windows HANDLE, or even a filename for love.filesystem,
-- dependent on OS.
function multiwritefile_open(filename)
	-- returns true, os_fh / false, error message
	if filename:sub(3):match(".*[:%*%?\"<>|].*") ~= nil then
		return false, L.INVALIDFILENAME_WIN
	end

	local os_fh = ffi.C.CreateFileW(
		path_utf8_to_utf16(filename),
		GENERIC_WRITE,
		0,
		nil,
		CREATE_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		nil
	)
	if handle_is_invalid(os_fh) then
		return false, format_last_win_error()
	end
	return true, os_fh
end

function multiwritefile_write(os_fh, data)
	-- returns success, (if not) error message
	local lpNumberOfBytesWritten = ffi.new("DWORD[1]")
	if not ffi.C.WriteFile(os_fh, data, data:len(), lpNumberOfBytesWritten, nil) then
		-- Writing failed.
		ffi.C.CloseHandle(os_fh)
		return false, format_last_win_error()
	end
	return true
end

function multiwritefile_close(os_fh)
	ffi.C.CloseHandle(os_fh)
end
