-- Note to self: environment variables: env


-- We know we're on Linux for a start...
userprofile = os.getenv("HOME")

simplevvvvvvfolder = true
standardvvvvvvfolder = "/.local/share/VVVVVV"


-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local t = {}
	local namekeys = {}
	local termoutput = {}

	--[[ Quick note: If you want to do modification timestamps here, consider -lQR --time-style +%s
		-Q for quoted filenames so it's a little bit easier to get the name, and --time-style +%s uses unix timestamps for the modification times
	]]
	local expectingdir = true
	-- First check what all the different directories and subdirectories are, so we can fill them
	local pfile = io.popen("cd '" .. escapename(directory) .. "' && ls -R --group-directories-first")
	for filename in pfile:lines() do -- kijk eens bij t voor sorteren
		table.insert(termoutput, filename)
		if expectingdir then
			-- The shown directory will be listed as `./subfolder/deeper:`, the root will be listed as `.:`
			t[filename:sub(3, -2)] = {}
			expectingdir = false
		elseif filename == "" then
			expectingdir = true
		end
	end
	local currentdir
	expectingdir = true
	-- Now we can fill them all with files
	for _,filename in pairs(termoutput) do
		if expectingdir then
			currentdir = filename:sub(3, -2)
			expectingdir = false
		elseif filename == "" then
			expectingdir = true
		else
			local prefix
			if currentdir == "" then
				prefix = ""
			else
				prefix = currentdir .. "/"
			end
			table.insert(t[currentdir],
				{
					name = filename,
					isdir = t[prefix .. filename] ~= nil,
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
