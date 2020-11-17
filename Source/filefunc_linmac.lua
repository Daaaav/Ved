userprofile = os.getenv("HOME")

local ffi = require("ffi")
local libC

local standardvvvvvvfolder

if love.system.getOS() == "Linux" then
	standardvvvvvvfolder = "/.local/share/VVVVVV"

	libC = ffi.load(love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_lin03.so")
elseif love.system.getOS() == "OS X" then
	standardvvvvvvfolder = "/Library/Application Support/VVVVVV"

	libC = ffi.load(love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_mac03.so")
end

ffi.cdef((love.filesystem.read("libs/vedlib_filefunc_linmac.h")))

libC.init_lang(
	function(key)
		return L[ffi.string(key)]
	end
)


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

-- Project Format stuff

function isproject(path)
	return file_exists(path .. "/" .. PROJECT_FILE)
end

function readfile(path)
	local fh, everr = io.open(path)

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function readprojectversion(path)
	if not isproject(path) then
		return false, L.PROJECT_UNRECOGNIZED
	end

	return readfile(path .. "/" .. METADATA_FILE)
end

-- Mutates: rettable, errortable
local function readfileinsert(rettable, errortable, base_path, ...)
	local path = {...}
	local current_rettable = rettable
	local current_error_table = errortable
	for depth, file in pairs(path) do
		if depth < #path then
			if current_rettable[file] ~= nil then
				current_rettable[file] = {}
				current_rettable = current_rettable[file]
			end
			if current_error_table[file] ~= nil then
				current_error_table[file] = {}
				current_error_table = current_error_table[file]
			end
		end
	end

	local success, ret2 = readfile(base_path .. "/" .. table.concat(path, "/"))
	if not success then
		local errormsg = ret2
		current_error_table[file] = errormsg
		return
	end

	local contents = ret2
	current_rettable[file] = contents
end

function readprojectmetadata(path)
	if not isproject(path) then
		return false, L.PROJECT_UNRECOGNIZED
	end

	return readfile(path .. "/" .. METADATA_FILE)
end

function readprojectfolder(path)
	if not isproject(path) then
		return false, L.PROJECT_UNRECOGNIZED
	end

	local retval = {}
	local errorval = {}

	-- Base metadata and project version
	readfileinsert(retval, errorval, path, METADATA_FILE)
	readfileinsert(retval, errorval, path, PROJECT_FILE)

	-- Ved metadata
	readfileinsert(retval, errorval, path, VEDMETADATA_DIR, FLAGNAMES_FILE)
	local buffer_diriter = new_diriter()
	if libC.ved_opendir(buffer_diriter, path .. "/" .. VEDMETADATA_DIR .. "/" .. LEVELNOTES_DIR, nil, false, nil) then
		local buffer_filedata = new_filedata()
		while libC.ved_nextfile(buffer_diriter, buffer_filedata) do
			if not buffer_filedata.isdir then
				local name = ffi.string(buffer_filedata.name)
				readfileinsert(retval, errorval, path, VEDMETADATA_DIR, LEVELNOTES_DIR, name)
			end
		end
	end
	libC.ved_closedir(buffer_diriter)

	-- Rooms
	local function isvalidnumber(number)
		-- Returns true if it is an integer, and that it's not negative,
		-- and that it doesn't have any leading zeroes.
		-- We check this by converting it a bunch and back to a string

		local converted = tonumber(number)
		converted = anythingbutnil0(number)
		converted = math.floor(number)
		converted = math.abs(number)
		converted = tostring(number)

		return converted == number
	end

	local function isvalidname(name, startletter)
		-- Valid here means that it starts with x/y, and that it's
		-- followed by a valid number.

		assert(startletter)
		local startswithletter = name:sub(1, 1) == startletter
		local validnumber = isvalidnumber(name:sub(2))

		return startswithletter and validnumber
	end

	local function isvaliddir(thisentry, startletter)
		-- Valid here means that the entry is a directory, and that it
		-- has a valid name. (So it requires passing startletter)

		return thisentry.isdir and isvalidname(ffi.string(thisentry.name), startletter)
	end

	local function readroom(...)
		-- Unfortunately, `func(..., extraargs)` doesn't work
		-- (you can't pass extra args after passing `...`)
		-- so we have to do this
		local args = {...}

		table.insert(args, ROOMPROPERTIES_FILE)
		readfileinsert(retval, errorval, unpack(args))

		args[#args] = ROOMCONTENTS_FILE
		readfileinsert(retval, errorval, unpack(args))

		args[#args] = EDENTITIES_FILE
		readfileinsert(retval, errorval, unpack(args))
	end

	local buffer_diriter = new_diriter()
	if libC.ved_opendir(buffer_diriter, path .. "/" .. ROOMS_DIR, nil, false, nil) then

		-- Get ready for crazy indentation. Lua doesn't have a `continue` statement
		local x_entry = new_filedata()
		while libC.ved_nextfile(buffer_diriter, x_entry) do
			if isvaliddir(x_entry, "x") then
				local y_diriter = new_diriter()
				if libC.ved_opendir(y_diriter, path .. "/" .. ROOMS_DIR .. "/" .. x_entry.name, nil, false, nil) then
					local y_entry = new_filedata()
					while libC.ved_nextfile(y_diriter, y_entry) do
						if isvaliddir(y_entry, "y") then
							readroom(path, ROOMS_DIR, x_entry.name, y_entry.name)
						end -- entry in rooms/xNN/ is valid
					end -- iterating over rooms/xNN/
				end -- ved_opendir() on rooms/xNN/
				libC.ved_closedir(y_diriter)
			end -- entry in rooms/ is valid
		end -- iterating over rooms/

	end -- ved_opendir() on rooms/
	libC.ved_closedir(buffer_diriter)

	-- Scripts
	local function recurse_read(...)
		local args = {...}

		local diriter = new_diriter()
		if libC.ved_opendir(diriter, table.concat(args, "/"), nil, false, nil) then
			local entry = new_filedata()
			while libC.ved_nextfile(diriter, entry) do
				if entry.isdir then
					table.insert(args, ffi.string(entry.name))
					recurse_read(unpack(args))
				else
					readfileinsert(retval, errorval, unpack(args))
				end
			end
		end
		libC.ved_closedir(diriter)
	end

	recurse_read(path, SCRIPTS_DIR)

	return true, retval, errorval
end
