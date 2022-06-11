if load_library == nil then
	-- This can also be used in a thread...
	require("librarian")
end

userprofile = os.getenv("HOME")

local ffi = require("ffi")
local libC
local findv6_mac

local standardvvvvvvfolder

ffi.cdef((love.filesystem.read("libs/universal.h")))

if love.system.getOS() == "Linux" then
	standardvvvvvvfolder = "/.local/share/VVVVVV"

	libC = load_library(ffi, "vedlib_filefunc_lin05.so")
elseif love.system.getOS() == "OS X" then
	standardvvvvvvfolder = "/Library/Application Support/VVVVVV"

	libC = load_library(ffi, "vedlib_filefunc_mac05.so")
	findv6_mac = load_library(ffi, "vedlib_findv6_mac01.so")

	ffi.cdef((love.filesystem.read("libs/vedlib_findv6_mac.h")))
end

ffi.cdef((love.filesystem.read("libs/vedlib_filefunc_linmac.h")))

if libC ~= nil then
	libC.init_lang(
		function(key)
			return L[ffi.string(key)]
		end
	)
end


local function new_filedata()
	return ffi.new("ved_filedata")
end

local function new_diriter()
	return ffi.new("ved_directoryiter")
end



function listlevelfiles(directory)
	local t = {}

	local currentdir = ""
	local dirs = {""}
	local currentdir_i = 1
	local current_name
	while dirs[currentdir_i] ~= nil do
		local prefix
		if dirs[currentdir_i] == "" then
			prefix = ""
		else
			prefix = dirs[currentdir_i] .. "/"
		end
		local buffer_diriter = new_diriter()
		if libC.ved_opendir(buffer_diriter, directory .. "/".. prefix, ".vvvvvv", false, nil) then
			t[dirs[currentdir_i]] = {}
			local buffer_filedata = new_filedata()
			while libC.ved_nextfile(buffer_diriter, buffer_filedata) do
				current_name = ffi.string(buffer_filedata.name)
				if buffer_filedata.isdir then
					table.insert(dirs, prefix .. current_name)
				end
				table.insert(t[dirs[currentdir_i]],
					{
						name = current_name,
						isdir = buffer_filedata.isdir,
						result_shown = true,
						bu_lastmodified = 0,
						bu_overwritten = 0,
						lastmodified = tonumber(buffer_filedata.lastmodified),
					}
				)
			end
			libC.ved_closedir(buffer_diriter)
		elseif prefix == "" then
			-- The root levels dir is invalid?
			return t
		end
		currentdir_i = currentdir_i + 1
	end

	for k,v in pairs(t) do
		sort_files(t[k])
	end
	return t
end

function listfiles_generic(directory, filter, show_hidden)
	-- If successful, returns: true, files.
	-- If not, returns: false, {}, message.
	local files = {}

	local errmsg = ffi.new("const char*[1]")
	local buffer_diriter = new_diriter()
	if libC.ved_opendir(buffer_diriter, directory .. "/", filter, show_hidden, errmsg) then
		local buffer_filedata = new_filedata()
		while libC.ved_nextfile(buffer_diriter, buffer_filedata) do
			table.insert(files,
				{
					name = ffi.string(buffer_filedata.name),
					isdir = buffer_filedata.isdir,
					lastmodified = tonumber(buffer_filedata.lastmodified),
				}
			)
		end
		libC.ved_closedir(buffer_diriter)
	else
		-- The dir is invalid?
		return false, {}, ffi.string(errmsg[0])
	end

	sort_files(files)
	return true, files
end

function get_parent_path(directory)
	-- "" counts as the root directory - imagine a slash after the return value.
	local last_dirsep = directory:reverse():find("/", 1, true)
	if last_dirsep == nil then
		return "", directory
	end
	return directory:sub(1, -last_dirsep-1), directory:sub(-last_dirsep, -1):sub(2, -1)
end

function get_child_path(directory, child)
	return directory .. "/" .. child
end

function get_root_dir_display()
	return "/"
end

function filepath_from_dialog(folder, name)
	-- Returns the full path, and the final filename
	local last_dirsep = name:reverse():find("/", 1, true)
	local filename
	if last_dirsep == nil then
		filename = name
	else
		filename = name:sub(-last_dirsep+1, -1)
	end
	if name:match("^/.*") ~= nil then
		return name, filename
	end
	return folder .. "/" .. name, filename
end

function setvvvvvvpaths()
	-- Sets the path variables to what they _should_ be, even if they don't exist.
	-- That way we can say "check {levelsfolder} exists and try again"

	vvvvvvfolder_expected = userprofile .. standardvvvvvvfolder

	if s.customvvvvvvdir == "" then
		vvvvvvfolder = vvvvvvfolder_expected
	else
		-- The user has supplied a custom directory.
		vvvvvvfolder = s.customvvvvvvdir
	end

	levelsfolder = vvvvvvfolder .. "/levels"
	graphicsfolder = vvvvvvfolder .. "/graphics"
	soundsfolder = vvvvvvfolder .. "/sounds"
end

function directory_exists(where, what)
	return libC.ved_directory_exists(where .. "/" .. what)
end

function file_exists(path)
	return libC.ved_file_exists(path)
end

function readlevelfile(path)
	-- returns success, contents

	local fh, everr = io.open(path, "rb")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message

	local fh, everr = io.open(path, "wb")

	if fh == nil then
		return false, everr
	end

	fh:write(contents)

	fh:close()

	return true, nil
end

function getmodtime(fullpath)
	return tonumber(libC.ved_getmodtime(fullpath))
end

function readfile(filename)
	-- returns success, contents

	local fh, everr = io.open(filename, "rb")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function escapename(name)
	-- We just need to somewhat escape '
	return name:gsub("'", "'\\''")
end

-- multiwritefile_* are meant for writing to a file multiple times in a row (handy for music files).
-- os_fh can mean lua's file object, a Windows HANDLE, or even a filename for love.filesystem,
-- dependent on OS.
function multiwritefile_open(filename)
	-- returns true, os_fh / false, error message
	local os_fh, everr = io.open(filename, "wb")

	if os_fh == nil then
		return false, everr
	end
	return true, os_fh
end

function multiwritefile_write(os_fh, data)
	-- returns success, (if not) error message
	os_fh:write(data)
	return true
end

function multiwritefile_close(os_fh)
	os_fh:close()
end

function find_vvvvvv_exe()
	-- returns `true, path` if success, `false, errmsg` if failure

	local ffi_find_vvvvvv_exe
	if love.system.getOS() == "Linux" then
		ffi_find_vvvvvv_exe = libC.ved_find_vvvvvv_exe_linux
	elseif love.system.getOS() == "OS X" then
		ffi_find_vvvvvv_exe = findv6_mac.ved_find_vvvvvv_exe_macos
	end

	local buffer_path = ffi.new("char[?]", 4096)
	local errkey = ffi.new("const char*[1]")

	if not ffi_find_vvvvvv_exe(buffer_path, 4096, errkey) then
		return false, L[ffi.string(errkey[0])]
	end

	return true, ffi.string(buffer_path)
end

function start_process(path, args_table, timeout, retain_stdin, retain_stdout, retain_stderr)
	-- Start a child process and get its "processinfo" (an OS-dependent pid or handle).
	-- On success, returns true, processinfo, stdin_write_end, stdout_read_end, stderr_read_end
	-- On failure, returns false, err
	-- The timeout is an integer amount of seconds that the process can take in total, 0 for no timeout.
	-- You can choose which stdio pipe handles to retain, unretained handles are nil (retrieved pipes
	-- will need to be closed later). You probably SHOULD retain stdout, or VVVVVV may get SIGPIPE'd.
	-- Note that this function will return true - indicating success - even if starting VVVVVV is going
	-- to fail. This will become apparent when calling await_process, because the process exits with
	-- a special code and prints the error to stderr. You may thus want to get the stderr pipe for passing
	-- it to await_process, it handles this and you can get a more detailed error message in this case.

	local cmd = ffi.new("const char* [?]", #args_table+2)
	cmd[0] = path
	for i = 1, #args_table - 1 do
		cmd[i] = tostring(args_table[i])
	end
	cmd[#args_table+1] = nil

	local stdin_write_end, stdout_read_end, stderr_read_end = nil, nil, nil
	if retain_stdin then
		stdin_write_end = ffi.new("int[1]")
	end
	if retain_stdout then
		stdout_read_end = ffi.new("int[1]")
	end
	if retain_stderr then
		stderr_read_end = ffi.new("int[1]")
	end
	local errmsg = ffi.new("const char*[1]")

	local pid = libC.start_process(
		cmd,
		timeout,
		stdin_write_end,
		stdout_read_end,
		stderr_read_end,
		errmsg
	)
	if tonumber(pid) < 0 then
		return false, ffi.string(errmsg[0])
	end

	return true, pid, stdin_write_end, stdout_read_end, stderr_read_end
end

function write_to_pipe(write_end, data)
	-- Returns success, err
	-- You can only use this once for a pipe. After calling this function, the pipe is closed.

	local errmsg = ffi.new("const char*[1]")
	local success = libC.write_to_pipe(write_end[0], data, data:len(), errmsg)
	if not success then
		return false, ffi.string(errmsg[0])
	end
	return true
end

function read_from_pipe(read_end)
	-- Returns success, maybe_data (`true, data` on success, `false, err` on failure)

	local bytes_read = ffi.new("size_t[1]")
	local errmsg = ffi.new("const char*[1]")
	local data_alloc = libC.read_from_pipe(read_end[0], bytes_read, errmsg)
	if data_alloc == nil then
		return false, ffi.string(errmsg[0])
	end
	local data = ffi.string(data_alloc, bytes_read[0])
	libC.pipedata_free(data_alloc)
	return true, data
end

function await_process(processinfo, stderr_read_end)
	-- Wait for a child process to finish.
	-- You HAVE to call this function at some point after successfully starting a process!
	-- Returns success, maybe_exitcode (`true, exitcode` if process started and exited cleanly, else `false, err`)

	local pid = processinfo
	local exitcode = ffi.new("int[1]")
	local errmsg = ffi.new("const char*[1]")
	local success = libC.await_process(pid, stderr_read_end, exitcode, errmsg)
	if not success then
		return false, ffi.string(errmsg[0])
	end
	return true, exitcode[0]
end

function process_cleanup(stdin_write_end, stdout_read_end, stderr_read_end)
	-- Needs to be called at some point after doing await_process, even if that failed.
	-- Cleans up internally, and also closes the pipe handles you give.

	libC.process_cleanup(stdin_write_end, stdout_read_end, stderr_read_end)
end
