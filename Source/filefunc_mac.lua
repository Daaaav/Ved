-- Note to self: environment variables: set


-- We know we're on OS X for a start...
userprofile = os.getenv("HOME")

simplevvvvvvfolder = true
standardvvvvvvfolder = "/Library/Application Support/VVVVVV"


-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local t = {[""] = {}}

	-- Only do files.
	local pfile = io.popen("cd '" .. escapename(directory) .. "' && ls -p")
	for filename in pfile:lines() do -- kijk eens bij t voor sorteren
		-- Unfortunately, Mac's ls doesn't have --group-directories-first, so let's show only the files
		if filename:sub(-1,-1) ~= "/" then
			table.insert(t[""],
				{
					name = filename,
					isdir = false,
					result_shown = true,
					bu_lastmodified = 0,
					bu_overwritten = 0,
					lastmodified = nil,
				}
			)
		end
	end

	pfile:close()
	return t
end

function getlevelsfolder(ignorecustom)
	-- Returns success, path

	if s.customvvvvvvdir == "" or ignorecustom then
		-- Spawn less cmd windows
		if directory_exists(userprofile .. standardvvvvvvfolder, "levels") then
			return true, userprofile .. standardvvvvvvfolder .. "/levels"
		else
			-- Also return what it should have been
			return false, userprofile .. standardvvvvvvfolder .. "/levels"
		end
	else
		-- The user has supplied a custom directory.
		if directory_exists(s.customvvvvvvdir, "levels") then
			-- Fair enough
			return true, s.customvvvvvvdir .. "/levels"
		else
			-- What are you doing?
			return false, s.customvvvvvvdir .. "/levels"
		end
	end
end

function directory_exists(where, what)
	local t = {}

	local pfile = io.popen("ls '" .. escapename(where) .. "'")
	for filename in pfile:lines() do
		if filename == what then
			pfile:close()
			return true
		end
	end

	-- If we're here, then the dir doesn't exist.
	pfile:close()
	return false
end

function readlevelfile(path)
	-- returns success, contents

	local fh, everr = io.open(path, "r")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message
	if path:match(".*:.*") ~= nil then
		return false, L.INVALIDFILENAME_MAC
	end

	local fh, everr = io.open(path, "w")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:write(contents)

	fh:close()

	return true, nil
end

function getmodtime(fullpath)
	local pfile = io.popen("stat -c %Y '" .. escapename(fullpath) .. "'")
	local modtime = pfile:read("*a")
	pfile:close()
	return modtime
end

function readimage(levelsfolder, filename)
	-- returns success, contents

	local fh, everr = io.open(levelsfolder:sub(1, -8) .. "/graphics/" .. filename, "rb")

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
