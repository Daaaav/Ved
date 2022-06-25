local cache_modtimes = {} -- filepath => unix_timestamp


require("libs/windows_constants")

local ffi = require("ffi")
local shell32 = ffi.load("Shell32") -- SHGetFolderPathW
local psapi_loaded, psapi = pcall(ffi.load, "Psapi") -- EnumProcesses, GetModule*
if not psapi_loaded then
	autodetect_vvvvvv_available = false
end
ffi.cdef((love.filesystem.read("libs/universal.h")))
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

named_pipe_id = 0



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

	levelsfolder_rel = "\\levels"
	graphicsfolder_rel = "\\graphics"
	soundsfolder_rel = "\\sounds"
	levelsfolder = vvvvvvfolder .. levelsfolder_rel
	graphicsfolder = vvvvvvfolder .. graphicsfolder_rel
	soundsfolder = vvvvvvfolder .. soundsfolder_rel
end

function directory_exists(path)
	local dwAttributes = ffi.C.GetFileAttributesW(path_utf8_to_utf16(path))

	return dwAttributes ~= INVALID_FILE_ATTRIBUTES and file_attributes_directory(dwAttributes)
end

function file_exists(path)
	local dwAttributes = ffi.C.GetFileAttributesW(path_utf8_to_utf16(path))

	return dwAttributes ~= INVALID_FILE_ATTRIBUTES and not file_attributes_directory(dwAttributes)
end

function create_directory(path)
	-- returns success, errmsg
	if not ffi.C.CreateDirectoryW(path_utf8_to_utf16(path), nil) then
		return false, format_last_win_error()
	end
	return true
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

function find_vvvvvv_exe()
	-- returns `true, path` if success, `false, errmsg` if failure

	local processes_max = 8192
	local processes
	local processes_bytes_used = ffi.new("DWORD[1]")
	local fits
	repeat
		processes = ffi.new("DWORD[?]", processes_max)

		if not psapi.EnumProcesses(processes, processes_max * 4, processes_bytes_used) then
			return false, L.FIND_V_EXE_ERROR
		end

		fits = processes_bytes_used[0] < processes_max * 4
		if not fits then
			processes_max = processes_max * 2
		end
	until fits

	local n_returned = processes_bytes_used[0] / 4

	-- Default for !success: we simply didn't find it
	local errmsg = L.FIND_V_EXE_NOTFOUND

	local path
	local n_processes = 0
	local success = false

	for i = 0, n_returned do
		local hProcess = ffi.C.OpenProcess(
			PROCESS_QUERY_INFORMATION + PROCESS_VM_READ,
			false,
			processes[i]
		);

		if hProcess ~= nil then
			local process_name_utf16 = ffi.new("WCHAR[?]", MAX_PATH)
			local process_path_utf16 = ffi.new("WCHAR[?]", MAX_PATH)

			if psapi.GetModuleBaseNameW(hProcess, nil, process_name_utf16, MAX_PATH)
			and path_utf16_to_utf8(process_name_utf16):lower() == "vvvvvv.exe" then
				if not psapi.GetModuleFileNameExW(hProcess, nil, process_path_utf16, MAX_PATH) then
					-- Okay, maybe *this* VVVVVV causes a failing GetModuleFileNameExW...
					-- Maybe there's still another where it doesn't fail.
					-- Either way it's no longer a "not found".
					errmsg = L.FIND_V_EXE_FOUNDERROR
				end

				n_processes = n_processes + 1
				local process_path_utf8 = path_utf16_to_utf8(process_path_utf16)

				-- If multiple VVVVVVs are running, we'll allow it if the executable is the same
				if n_processes > 1 and process_path_utf8 ~= path then
					errmsg = L.FIND_V_EXE_MULTI
					success = false
					ffi.C.CloseHandle(hProcess)
					break
				end

				path = process_path_utf8
				success = true
			end

			ffi.C.CloseHandle(hProcess)
		end
	end

	if not success then
		return false, errmsg
	end

	return true, path
end

cProcess =
{
	path = nil,
	args_table = {},
	timeout = 0,
	will_read = false,
	will_write = false,

	stdin_write_end = nil,
	stdout_read_end = nil,
	stderr_read_end = nil,

	processinfo = nil,
	read_error_stdout = nil,
	read_error_stderr = nil,
	buf_stdout = {buf=nil, capacity=0, pos=0},
	buf_stderr = {buf=nil, capacity=0, pos=0},
	res_stdout = {error_code=107, bytes_read=0},
	res_stderr = {error_code=107, bytes_read=0},
}

function cProcess:new(o)
	-- Usage:
	-- process = cProcess:new{path="", args_table={}, timeout=0, will_read=false, will_write=false}
	-- All attributes are optional except for path.
	--
	-- The timeout is an integer amount of seconds that the process can take in total, 0 for no timeout.
	-- To be able to use process:read_stdout() or process:read_stderr(), will_read must be true.
	-- To be able to use process:write_stdin(data), will_write must be true.

	setmetatable(o, self)
	self.__index = self

	return o
end

function cProcess:start()
	-- Start the child process and get its OS-dependent pid or handle.
	-- Returns `true` on success, `false, err` on failure.
	-- Note that this function may return true - indicating success - even if starting VVVVVV is going
	-- to fail. This will become apparent when calling :await_completion() (or :write_stdin(data)).

	-- The pipes need to be inherited
	local sattr = ffi.new("SECURITY_ATTRIBUTES")
	sattr.nLength = ffi.sizeof("SECURITY_ATTRIBUTES")
	sattr.bInheritHandle = true
	sattr.lpSecurityDescriptor = nil

	-- I'd have liked HANDLE[2][1], but I need to be able to set them to nil arbitrarily...
	local READ_END, WRITE_END = 0, 1
	local p_stdin, p_stdin_made = {[READ_END]=ffi.new("HANDLE[1]"), [WRITE_END]=ffi.new("HANDLE[1]")}, false
	local p_stdout, p_stdout_made = {[READ_END]=ffi.new("HANDLE[1]"), [WRITE_END]=ffi.new("HANDLE[1]")}, false
	local p_stderr, p_stderr_made = {[READ_END]=ffi.new("HANDLE[1]"), [WRITE_END]=ffi.new("HANDLE[1]")}, false

	local function cleanup_win_error()
		local errmsg = format_last_win_error()
		if p_stdin_made then
			ffi.C.CloseHandle(p_stdin[READ_END][0])
			ffi.C.CloseHandle(p_stdin[WRITE_END][0])
		end
		if p_stdout_made then
			ffi.C.CloseHandle(p_stdout[READ_END][0])
			ffi.C.CloseHandle(p_stdout[WRITE_END][0])
		end
		if p_stderr_made then
			ffi.C.CloseHandle(p_stderr[READ_END][0])
			ffi.C.CloseHandle(p_stderr[WRITE_END][0])
		end
		return false, errmsg
	end

	if self.will_write then
		if not ffi.C.CreatePipe(p_stdin[READ_END], p_stdin[WRITE_END], sattr, 204800) then
			return cleanup_win_error()
		end
		p_stdin_made = true

		-- VVVVVV should not inherit the write end
		if not ffi.C.SetHandleInformation(p_stdin[WRITE_END][0], HANDLE_FLAG_INHERIT, 0) then
			return cleanup_win_error()
		end
	else
		p_stdin[READ_END][0] = ffi.C.GetStdHandle(STD_INPUT_HANDLE)
		p_stdin[WRITE_END] = nil
	end

	if self.will_read then
		-- We can't use asynchronous reading without named pipes...
		local pid = tostring(ffi.C.GetCurrentProcessId())
		local tid = tostring(ffi.C.GetCurrentThreadId())
		local named_pipe_prefix = "\\\\.\\pipe\\ved_" .. pid .. "_" .. tid .. "_" .. named_pipe_id
		named_pipe_id = named_pipe_id + 1

		p_stdout[WRITE_END][0] = ffi.C.CreateNamedPipeA(named_pipe_prefix .. "_stdout", PIPE_ACCESS_OUTBOUND, 0, 1, 4096, 4096, 0, sattr)
		if handle_is_invalid(p_stdout[WRITE_END][0]) then
			return cleanup_win_error()
		end
		p_stdout[READ_END][0] = ffi.C.CreateFileA(named_pipe_prefix .. "_stdout", GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, nil)
		if handle_is_invalid(p_stdout[READ_END][0]) then
			ffi.C.CloseHandle(p_stdout[WRITE_END][0])
			return cleanup_win_error()
		end
		p_stdout_made = true

		p_stderr[WRITE_END][0] = ffi.C.CreateNamedPipeA(named_pipe_prefix .. "_stderr", PIPE_ACCESS_OUTBOUND, 0, 1, 4096, 4096, 0, sattr)
		if handle_is_invalid(p_stderr[WRITE_END][0]) then
			return cleanup_win_error()
		end
		p_stderr[READ_END][0] = ffi.C.CreateFileA(named_pipe_prefix .. "_stderr", GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, nil)
		if handle_is_invalid(p_stderr[READ_END][0]) then
			ffi.C.CloseHandle(p_stderr[WRITE_END][0])
			return cleanup_win_error()
		end
		p_stderr_made = true
	else
		p_stdout[READ_END] = nil
		p_stderr[READ_END] = nil
		p_stdout[WRITE_END][0] = ffi.C.GetStdHandle(STD_OUTPUT_HANDLE)
		p_stderr[WRITE_END][0] = ffi.C.GetStdHandle(STD_ERROR_HANDLE)
	end

	local startupinfo = ffi.new("STARTUPINFOW")
	startupinfo.cb = ffi.sizeof("STARTUPINFOW")
	startupinfo.hStdInput = p_stdin[READ_END][0]
	startupinfo.hStdOutput = p_stdout[WRITE_END][0]
	startupinfo.hStdError = p_stderr[WRITE_END][0]
	startupinfo.dwFlags = STARTF_USESTDHANDLES
	self.processinfo = ffi.new("PROCESS_INFORMATION")

	-- Arguments?
	local cmdline = "\"" .. self.path .. "\" " .. table.concat(self.args_table, " ")
	local len_cmdline = cmdline:len()+1
	local buffer_cmdline_utf16 = ffi.new("WCHAR[?]", len_cmdline)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0, cmdline, -1, buffer_cmdline_utf16, len_cmdline)

	-- VVVVVV-CE 1.0-pre1 expected data.zip in the working directory, still can't hurt to start the process there
	local buffer_workingdir_utf16 = ffi.new("WCHAR[?]", MAX_PATH)
	ffi.copy(buffer_workingdir_utf16, path_utf8_to_utf16(get_parent_path(self.path)), MAX_PATH)

	-- Start VVVVVV
	local success = ffi.C.CreateProcessW(
		path_utf8_to_utf16(self.path),
		buffer_cmdline_utf16,
		nil,
		nil,
		true,
		CREATE_NO_WINDOW,
		nil,
		buffer_workingdir_utf16,
		startupinfo,
		self.processinfo
	)
	if not success then
		return cleanup_win_error()
	end

	-- Now we can close our unused pipe handles right?
	if p_stdin_made then
		ffi.C.CloseHandle(p_stdin[READ_END][0])
	end
	if p_stdout_made then
		ffi.C.CloseHandle(p_stdout[WRITE_END][0])
	end
	if p_stderr_made then
		ffi.C.CloseHandle(p_stderr[WRITE_END][0])
	end

	self.stdin_write_end = p_stdin[WRITE_END]
	self.stdout_read_end = p_stdout[READ_END]
	self.stderr_read_end = p_stderr[READ_END]

	return true
end

function cProcess:write_stdin(data)
	-- Returns success, err
	-- You can only use this once for a pipe. After calling this function, the pipe is closed.

	local bytes_written = ffi.new("DWORD[1]")
	success = ffi.C.WriteFile(self.stdin_write_end[0], data, data:len(), bytes_written, nil)

	if not success then
		local errmsg = format_last_win_error()
		ffi.C.CloseHandle(self.stdin_write_end[0])
		self.stdin_write_end = nil
		return false, errmsg
	end

	ffi.C.CloseHandle(self.stdin_write_end[0])
	self.stdin_write_end = nil
	return true
end

function cProcess:read_stdout()
	-- Returns `data` on success, `nil, err` on failure
	-- You should only call this function after process completion.

	if self.read_error_stdout ~= nil then
		return nil, self.read_error_stdout
	end
	if self.buf_stdout.buf == nil or self.buf_stdout.capacity == 0 then
		return ""
	end

	return ffi.string(self.buf_stdout.buf, self.buf_stdout.pos)
end

function cProcess:read_stderr()
	-- Returns `data` on success, `nil, err` on failure
	-- You should only call this function after process completion.

	if self.read_error_stderr ~= nil then
		return nil, self.read_error_stderr
	end
	if self.buf_stderr.buf == nil or self.buf_stderr.capacity == 0 then
		return ""
	end

	return ffi.string(self.buf_stderr.buf, self.buf_stderr.pos)
end

function cProcess:async_read_from_pipe(res, buf, read_end, overlapped, event_handle)
	-- Internal function
	-- Start an async read from a pipe into a buffer.
	-- We make sure the "overlapped completion routine" is ALWAYS called after calling this function.

	local function completion_routine(error_code, bytes_read, void_overlapped)
		res.error_code = error_code
		res.bytes_read = bytes_read

		ffi.C.SetEvent(ffi.cast("LPOVERLAPPED", void_overlapped).hEvent)
	end

	ffi.fill(overlapped, ffi.sizeof("OVERLAPPED"))
	overlapped.hEvent = event_handle

	-- Still need to do the initial malloc?
	if buf.capacity == 0 then
		-- capacity excludes space for a null terminator, so we know we can always add one
		buf.capacity = 1024
		buf.buf = ffi.cast("char*", ffi.C.malloc(buf.capacity + 1))
		if buf.buf == nil then
			completion_routine(ERROR_NOT_ENOUGH_MEMORY, 0, overlapped)
			return
		end
	end

	-- Make sure the buffer isn't full
	if buf.pos >= buf.capacity then
		buf.capacity = buf.capacity * 2
		local tmp = ffi.cast("char*", ffi.C.realloc(buf.buf, buf.capacity + 1))
		if tmp == nil then
			ffi.C.free(buf.buf)
			buf.buf = nil
			completion_routine(ERROR_NOT_ENOUGH_MEMORY, 0, overlapped)
			return
		end
		buf.buf = tmp
	end

	ffi.C.ResetEvent(event_handle)

	if not ffi.C.ReadFileEx(read_end[0], buf.buf+buf.pos, buf.capacity-buf.pos, overlapped, completion_routine) then
		-- If you won't call the completion routine, I'll do it for ya
		completion_routine(ffi.C.GetLastError(), 0, overlapped)
	end
end

function cProcess:await_completion()
	-- Wait for a child process to finish.
	-- You HAVE to call this function at some point after successfully starting a process!
	-- Returns `exitcode` if process started and exited cleanly, `nil, err` otherwise

	local process_still_open = true
	local stdout_still_open, reading_stdout = false, false
	local stderr_still_open, reading_stderr = false, false
	local overlapped_stdout = ffi.new("OVERLAPPED")
	local overlapped_stderr = ffi.new("OVERLAPPED")
	local event_stdout, event_stderr
	if self.will_read then
		local bad = false
		event_stdout = ffi.C.CreateEventW(nil, true, false, nil)
		if event_stdout == nil then
			self.read_error_stdout = format_last_win_error()
			self.read_error_stderr = self.read_error_stdout
			bad = true
		else
			event_stderr = ffi.C.CreateEventW(nil, true, false, nil)
			if event_stderr == nil then
				self.read_error_stdout = format_last_win_error()
				self.read_error_stderr = self.read_error_stdout
				bad = true
				ffi.C.CloseHandle(event_stdout)
			end
		end
		if bad then
			self.will_read = false
			ffi.C.CloseHandle(self.stdout_read_end[0])
			ffi.C.CloseHandle(self.stderr_read_end[0])
		end
	end
	if self.will_read then
		stdout_still_open = true
		stderr_still_open = true
	end

	local wait_handles = ffi.new("HANDLE[3]")
	local process_handle_ix, stdout_handle_ix, stderr_handle_ix

	local timeout_expires
	if self.timeout > 0 then
		require("love.timer")
		timeout_expires = love.timer.getTime() + self.timeout
	end

	local break_error
	while true do
		local wait_handles_len = 0
		if process_still_open then
			process_handle_ix = wait_handles_len
			wait_handles[process_handle_ix] = self.processinfo.hProcess
			wait_handles_len = wait_handles_len + 1
		end
		if stdout_still_open then
			stdout_handle_ix = wait_handles_len
			wait_handles[stdout_handle_ix] = event_stdout
			wait_handles_len = wait_handles_len + 1

			if not reading_stdout then
				self:async_read_from_pipe(self.res_stdout, self.buf_stdout, self.stdout_read_end, overlapped_stdout, event_stdout)
				reading_stdout = true
			end
		end
		if stderr_still_open then
			stderr_handle_ix = wait_handles_len
			wait_handles[stderr_handle_ix] = event_stderr
			wait_handles_len = wait_handles_len + 1

			if not reading_stderr then
				self:async_read_from_pipe(self.res_stderr, self.buf_stderr, self.stderr_read_end, overlapped_stderr, event_stderr)
				reading_stderr = true
			end
		end

		if wait_handles_len == 0 then
			local exitcode = ffi.new("DWORD[1]")
			if not ffi.C.GetExitCodeProcess(self.processinfo.hProcess, exitcode) then
				return nil, format_last_win_error()
			end
			if exitcode[0] >= 0x40000000 then
				-- This is where Windows exception codes start, I think? Not normal in any case.
				return nil, langkeys(L.VVVVVV_EXITCODE_FAILURE, {string.format("0x%X", exitcode[0])})
			end
			return exitcode[0]
		end

		local win_timeout = INFINITE
		if self.timeout > 0 then
			-- Don't keep resetting to full timeout
			win_timeout = math.max(0, (timeout_expires - love.timer.getTime()) * 1000)
		end

		local event
		repeat
			event = ffi.C.WaitForMultipleObjectsEx(wait_handles_len, wait_handles, false, win_timeout, true)
		until event ~= WAIT_IO_COMPLETION

		local event_is_pipe = false
		local event_read_end, event_overlapped, event_buf

		if event == WAIT_FAILED then
			break_error = format_last_win_error()
			break
		elseif event == WAIT_TIMEOUT then
			-- Just use the same exit code I used on Linux and macOS... Doesn't really matter
			ffi.C.TerminateProcess(self.processinfo.hProcess, 70)
			break_error = L.VVVVVV_22_OR_OLDER
			break
		elseif process_still_open and event-WAIT_OBJECT_0 == process_handle_ix then
			-- Process handle
			process_still_open = false
		elseif stdout_still_open and event-WAIT_OBJECT_0 == stdout_handle_ix then
			-- stdout handle
			reading_stdout = false
			event_is_pipe = true
			event_is_stdout = true
			event_read_end = self.stdout_read_end[0]
			event_event = event_stdout
			event_buf = self.buf_stdout
			event_res = self.res_stdout
		elseif stderr_still_open and event-WAIT_OBJECT_0 == stderr_handle_ix then
			-- stderr handle
			reading_stderr = false
			event_is_pipe = true
			event_is_stdout = false
			event_read_end = self.stderr_read_end[0]
			event_event = event_stderr
			event_buf = self.buf_stderr
			event_res = self.res_stderr
		end

		if event_is_pipe then
			if event_res.error_code ~= ERROR_SUCCESS then
				-- When all write handles are closed, it finishes off with one "unsuccessful" 0 bytes read
				if event_res.error_code ~= ERROR_BROKEN_PIPE then
					-- Not the failure we were expecting
					ffi.C.SetLastError(event_res.error_code)
					local errmsg = format_last_win_error()
					if event_is_stdout then
						self.read_error_stdout = errmsg
					else
						self.read_error_stderr = errmsg
					end
				end

				if event_is_stdout then
					stdout_still_open = false
					ffi.C.CloseHandle(self.stdout_read_end[0])
				else
					stderr_still_open = false
					ffi.C.CloseHandle(self.stderr_read_end[0])
				end
				ffi.C.CloseHandle(event_event)
			else
				event_buf.pos = event_buf.pos + event_res.bytes_read
			end
		end
	end

	-- Break means error here
	if stdout_still_open then
		ffi.C.CloseHandle(self.stdout_read_end[0])
		ffi.C.CloseHandle(event_stdout)
	end
	if stderr_still_open then
		ffi.C.CloseHandle(self.stdout_read_end[0])
		ffi.C.CloseHandle(event_stderr)
	end

	return nil, break_error
end

function cProcess:cleanup()
	-- Needs to be called at some point after doing await_process, even if that failed.

	if self.stdin_write_end ~= nil then
		ffi.C.CloseHandle(self.stdin_write_end[0])
	end

	ffi.C.CloseHandle(self.processinfo.hProcess)
	ffi.C.CloseHandle(self.processinfo.hThread)

	ffi.C.free(self.buf_stdout.buf)
	ffi.C.free(self.buf_stderr.buf)
	self.buf_stdout.buf = nil
	self.buf_stderr.buf = nil
end
