-- Note to self: environment variables: env


-- We know we're on Linux for a start...
userprofile = os.getenv("HOME")

simplevvvvvvfolder = true
standardvvvvvvfolder = "/.local/share/VVVVVV"


-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local i, t = 0, {}

	-- Only do files.
	for filename in io.popen("ls " .. directory:gsub(" ", "\\ ")):lines() do -- kijk eens bij t voor sorteren
		i = i + 1
		t[i] = {
			name = filename,
			isdir = false,
			lastmodified = 0,
		}
	end
	return t
end

function getlevelsfolder(ignorecustom)
	-- Returns success, path

	if s.customvvvvvvdir == "" or ignorecustom then
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

function listdirs(directory)
	local i, t = 0, {}
	-- Only do folders.
	for filename in io.popen("ls " .. directory:gsub(" ", "\\ ")):lines() do
		i = i + 1
		t[i] = filename

		--cons(filename)
	end
	return t
end

function directory_exists(where, what)
	local i, t = 0, {}

	for filename in io.popen("ls " .. where:gsub(" ", "\\ ")):lines() do
		if filename == what then return true end
	end

	-- If we're here, then the dir doesn't exist.
	return false
end

function readlevelfile(path)
	-- returns success, contents

	fh, everr = io.open(path, "r")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message

	fh, everr = io.open(path, "w")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:write(contents)

	fh:close()

	return true, nil
end

function readimage(levelsfolder, filename)
	-- returns success, contents

	fh, everr = io.open(levelsfolder:sub(1, -8) .. "/graphics/" .. filename, "rb")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function openurl(url)
	os.execute("xdg-open " .. url)
end