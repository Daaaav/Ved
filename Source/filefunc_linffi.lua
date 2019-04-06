-- Note to self: environment variables: env


-- We know we're on Linux for a start...
userprofile = os.getenv("HOME")

simplevvvvvvfolder = true
standardvvvvvvfolder = "/.local/share/VVVVVV"


local ffi = require("ffi")
local libC = ffi.load(love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_lin00.so")
ffi.cdef([[
	typedef struct _ved_filedata
	{
		char name[256];
		bool isdir;
		long long lastmodified;
	} ved_filedata;

	bool ved_opendir(const char *path);

	bool ved_nextfile(ved_filedata *filedata);

	void ved_closedir(void);

	bool ved_directory_exists(const char *path);

	long long ved_getmodtime(const char *path);
]])


buffer_filedata = ffi.new("ved_filedata")



function listfiles(directory)
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
		if libC.ved_opendir(directory .. "/".. prefix) then
			t[dirs[currentdir_i]] = {}
			while libC.ved_nextfile(buffer_filedata) do
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
			libC.ved_closedir()
		elseif prefix == "" then
			-- The root levels dir is invalid?
			return t
		end
		currentdir_i = currentdir_i + 1
	end

	for k,v in pairs(t) do
		table.sort(t[k],
			function(a,b)
				if a.isdir and not b.isdir then return true end
				if b.isdir and not a.isdir then return false end

				return a.name:lower() < b.name:lower()
			end
		)
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

function directory_exists(where, what)
	return libC.ved_directory_exists(where .. "/" .. what)
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
	return tonumber(libC.ved_getmodtime(fullpath))
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
