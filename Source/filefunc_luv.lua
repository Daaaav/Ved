-- These functions are a replacement for the OS-specific functions (that determine VVVVVV's directory)

userprofile = ""

function listlevelfiles(directory)
	-- Preferably, only do files.
	files = {}
	for _,f in pairs(love.filesystem.getDirectoryItems(directory)) do
		if not love.filesystem.isDirectory(f) then
			table.insert(files, {
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

function getlevelsfolder()
	-- Returns success. Sets the path variables to what they _should_ be, even if
	-- they don't exist. That way we can say "check {levelsfolder} exists and try again"

	-- We can't really set a custom directory if we don't know what commands to use :/
	vvvvvvfolder_expected = nil

	if not love.filesystem.exists("levels") then
		love.filesystem.createDirectory("levels")
	end
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	end

	vvvvvvfolder = ""
	levelsfolder = "levels"
	graphicsfolder = "graphics"
	return true
end

function directory_exists(where, what)
	return love.filesystem.isDirectory(where .. "/" .. what)
end

function readlevelfile(path)
	-- returns success, contents

	local ficontents = love.filesystem.read(path)

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message

	local success = love.filesystem.write(path, contents)

	return success, ""
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
