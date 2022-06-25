-- These functions are a replacement for the OS-specific functions (that determine VVVVVV's directory)

userprofile = ""

function listlevelfiles(directory)
	-- Preferably, only do files.
	files = {[""] = {}}
	for _,f in pairs(love.filesystem.getDirectoryItems(directory)) do
		if not love.filesystem.isDirectory(f) then
			table.insert(files[""], {
					name = f,
					isdir = false,
					result_shown = true,
					bu_lastmodified = 0,
					bu_overwritten = 0,
					lastmodified = nil,
				}
			)
		end
	end
	return files
end

function listfiles_generic(directory, filter, show_hidden)
	-- If successful, returns: true, files.
	-- If not, returns: false, {}, message.
	-- Kinda TODO, but realize you'll also list all files from the .love
	--[[
	local files = {}

	for k,v in pairs(love.filesystem.getDirectoryItems(directory)) do
		table.insert(files,
			{
				name = v,
				isdir = true,
				lastmodified = nil
			}
		)
	end

	sort_files(files)
	return true, files
	]]

	return false, {}, L.FILEDIALOGLUV
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

	-- We can't really set a custom directory if we don't know what commands to use :/
	vvvvvvfolder_expected = nil

	if not love.filesystem.exists("levels") then
		love.filesystem.createDirectory("levels")
	end
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	end

	vvvvvvfolder = ""

	levelsfolder_rel = "/levels"
	graphicsfolder_rel = "/graphics"
	soundsfolder_rel = "/sounds"
	levelsfolder = "levels"
	graphicsfolder = "graphics"
	soundsfolder = "sounds"
end

function directory_exists(path)
	return love.filesystem.isDirectory(path)
end

function file_exists(path)
	return love.filesystem.isFile(path)
end

function create_directory(path)
	-- returns success, errmsg
	if not love.filesystem.createDirectory(path) then
		return false, "Failed."
	end
	return true
end

function readlevelfile(path)
	-- returns success, contents

	local ficontents, everr = love.filesystem.read(path)

	if ficontents == nil then
		return false, everr
	end

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message

	local success = love.filesystem.write(path, contents)

	return success, ""
end

function getmodtime(fullpath)
	return love.filesystem.getLastModified(fullpath) -- convenient UNIX timestamp
end

function readfile(filename)
	-- returns success, contents

	return false, ""
end

-- multiwritefile_* are meant for writing to a file multiple times in a row (handy for music files).
-- os_fh can mean lua's file object, a Windows HANDLE, or even a filename for love.filesystem,
-- dependent on OS.
function multiwritefile_open(filename)
	-- returns true, os_fh / false, error message
	local success, everr = love.filesystem.write(filename, "")

	if not success then
		return false, everr
	end
	return true, filename
end

function multiwritefile_write(os_fh, data)
	-- returns success, (if not) error message
	local success, everr = love.filesystem.append(os_fh, data)

	if not success then
		return false, everr
	end
	return true
end

function multiwritefile_close(os_fh)
end

function find_vvvvvv_exe()
	-- returns `true, path` if success, `false, errmsg` if failure
	return false, L.FIND_V_EXE_ERROR
end
