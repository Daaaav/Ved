-- Note to self: environment variables: set

-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local i, t, popen = 0, {}, io.popen
	--for filename in popen('ls -a "'..directory..'"'):lines() do
	
	-- Only do files.
	for filename in popen('ls '..directory:gsub(" ", "\\ ")..''):lines() do -- kijk eens bij t voor sorteren
		i = i + 1
		t[i] = filename
		
		--cons(filename)
	end
	return t
end

function getlevelsfolder(ignorecustom)
	-- Returns error, path
	-- 1: no documents, 2: no vvvvvv, 3: no levels folder

	if s.customvvvvvvdir == "" or ignorecustom then
		-- We know we're on OS X for a start...
		userprofile = os.getenv('HOME')
		
		-- Spawn less cmd windows
		if directory_exists(userprofile .. "/Library/Application Support/VVVVVV", "levels") then
			return 0,userprofile .. "/Library/Application Support/VVVVVV/levels"
		else
			-- Also return what it should have been
			return 4, userprofile .. "/Library/Application Support/VVVVVV/levels"
		end
	else
		-- The user has supplied a custom directory.
		if directory_exists(s.customvvvvvvdir, "levels") then
			-- Fair enough
			return 0, s.customvvvvvvdir .. "/levels"
		else
			-- What are you doing?
			return 4, s.customvvvvvvdir .. "/levels"
		end
	end
end

function listdirs(directory)
	local i, t, popen = 0, {}, io.popen
	--for filename in popen('ls -a "'..directory..'"'):lines() do
	
	-- Only do folders.
	for filename in popen('ls '..directory:gsub(" ", "\\ ")..''):lines() do
		i = i + 1
		t[i] = filename
		
		--cons(filename)
	end
	return t
end

function directory_exists(where, what)
	local i, t, popen = 0, {}, io.popen
	
	for filename in popen('ls '..where:gsub(" ", "\\ ")..''):lines() do
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
	os.execute("open " .. url)
end