local cache_modtimes = {} -- filepath => unix_timestamp


require("libs/windows_constants")

local ffi = require("ffi")
local shell32 = ffi.load("Shell32") -- SHGetFolderPathW
ffi.cdef((love.filesystem.read("libs/windows_types.h")))
ffi.cdef((love.filesystem.read("libs/windows_main.h")))


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
		and not bit(buffer_filedata.dwFileAttributes, FILE_ATTRIBUTE_SYSTEM)
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
		return "", directory
	end
	return directory:sub(1, -last_dirsep-1), directory:sub(-last_dirsep, -1):sub(2, -1)
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

function setvvvvvvpaths()
	-- Sets the path variables to what they _should_ be, even if they don't exist.
	-- That way we can say "check {levelsfolder} exists and try again"

	shell32.SHGetFolderPathW(nil, CSIDL_PERSONAL, nil, SHGFP_TYPE_CURRENT, buffer_path_utf16);
	vvvvvvfolder_expected = path_utf16_to_utf8(buffer_path_utf16) .. "\\VVVVVV"

	if s.customvvvvvvdir == "" then
		vvvvvvfolder = vvvvvvfolder_expected
	else
		-- The user has supplied a custom directory.
		vvvvvvfolder = s.customvvvvvvdir
	end

	levelsfolder = vvvvvvfolder .. "\\levels"
	graphicsfolder = vvvvvvfolder .. "\\graphics"
	soundsfolder = vvvvvvfolder .. "\\sounds"
end

function directory_exists(where, what)
	local dwAttributes = ffi.C.GetFileAttributesW(path_utf8_to_utf16(where .. "\\" .. what))

	return dwAttributes ~= INVALID_FILE_ATTRIBUTES and file_attributes_directory(dwAttributes)
end

function file_exists(path)
	local dwAttributes = ffi.C.GetFileAttributesW(path_utf8_to_utf16(path))

	return dwAttributes ~= INVALID_FILE_ATTRIBUTES and not file_attributes_directory(dwAttributes)
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

	ffi.C.FlushFileBuffers(file_handle)
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
	ffi.C.FlushFileBuffers(os_fh)
	ffi.C.CloseHandle(os_fh)
end

function run_pipe_process(app_path, args, stdin)
	-- The pipe needs to be inherited
	local sattr = ffi.new("SECURITY_ATTRIBUTES")
	sattr.nLength = ffi.sizeof("SECURITY_ATTRIBUTES")
	sattr.bInheritHandle = true
	sattr.lpSecurityDescriptor = nil

	-- Set up the pipe - it has a send end and a receive end
	local pipe_send = ffi.new("HANDLE[1]")
	local pipe_recv = ffi.new("HANDLE[1]")
	if not ffi.C.CreatePipe(pipe_recv, pipe_send, sattr, stdin:len()+1) then
		return false, format_last_win_error()
	end
	-- VVVVVV should not inherit the send end
	if not ffi.C.SetHandleInformation(pipe_send[0], HANDLE_FLAG_INHERIT, 0) then
		ffi.C.CloseHandle(pipe_recv[0])
		ffi.C.CloseHandle(pipe_send[0])
		return false, format_last_win_error()
	end

	local startupinfo = ffi.new("STARTUPINFOW")
	startupinfo.cb = ffi.sizeof("STARTUPINFOW")
	startupinfo.hStdInput = pipe_recv[0]
	startupinfo.dwFlags = STARTF_USESTDHANDLES
	local processinfo = ffi.new("PROCESS_INFORMATION")

	-- Arguments?
	local cmdline = "\"" .. app_path .. "\" " .. args
	local len_cmdline = cmdline:len()+1
	local buffer_cmdline_utf16 = ffi.new("WCHAR[?]", len_cmdline)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0, cmdline, -1, buffer_cmdline_utf16, len_cmdline)

	-- VVVVVV-CE 1.0-pre1 expects data.zip in the working directory, can't hurt to start the process there
	local buffer_workingdir_utf16 = ffi.new("WCHAR[?]", MAX_PATH)
	ffi.copy(buffer_workingdir_utf16, path_utf8_to_utf16(get_parent_path(app_path)), MAX_PATH)

	-- Start VVVVVV
	local success = ffi.C.CreateProcessW(
		path_utf8_to_utf16(app_path),
		buffer_cmdline_utf16,
		nil,
		nil,
		true,
		CREATE_NO_WINDOW,
		nil,
		buffer_workingdir_utf16,
		startupinfo,
		processinfo
	)
	if not success then
		ffi.C.CloseHandle(pipe_recv[0])
		ffi.C.CloseHandle(pipe_send[0])
		return false, format_last_win_error()
	end

	-- Write to stdin pipe
	local lpNumberOfBytesWritten = ffi.new("DWORD[1]")
	success = ffi.C.WriteFile(pipe_send[0], stdin, stdin:len(), lpNumberOfBytesWritten, nil)

	ffi.C.CloseHandle(pipe_send[0])
	ffi.C.CloseHandle(pipe_recv[0])

	if not success then
		ffi.C.CloseHandle(processinfo.hProcess)
		ffi.C.CloseHandle(processinfo.hThread)

		return false, format_last_win_error()
	end

	-- Wait until completion
	ffi.C.WaitForSingleObject(processinfo.hProcess, INFINITE)

	ffi.C.CloseHandle(processinfo.hProcess)
	ffi.C.CloseHandle(processinfo.hThread)

	return true
end
