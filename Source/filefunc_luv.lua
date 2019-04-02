-- These functions are a replacement for the OS-specific functions (that determine VVVVVV's directory)

function listfiles(directory)
	-- Preferably, only do files.
	files = {}
	for f in love.filesystem.getDirectoryItems(directory) do
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

function getlevelsfolder(ignorecustom)
	-- Returns success, path

	if ignorecustom then
		return nil, "???"
	end

	-- We can't really set a custom directory if we don't know what commands to use :/

	if not love.filesystem.exists("levels") then
		love.filesystem.createDirectory("levels")
	end
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	end

	return true, "levels"
end

function listdirs(directory)
	-- Currently unused, except in a testing state
	-- Preferably, only do directories.
	return love.filesystem.getDirectoryItems(directory)
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

function readimage(levelsfolder, filename)
	-- returns success, contents

	return false, ""
end
