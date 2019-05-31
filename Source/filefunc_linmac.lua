userprofile = os.getenv("HOME")

local ffi = require("ffi")
local libC

local standardvvvvvvfolder

if love.system.getOS() == "Linux" then
	standardvvvvvvfolder = "/.local/share/VVVVVV"

	libC = ffi.load(love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_lin01.so")
elseif love.system.getOS() == "OS X" then
	standardvvvvvvfolder = "/Library/Application Support/VVVVVV"

	libC = ffi.load(love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_mac01.so")
end

ffi.cdef([[
	typedef struct _ved_filedata
	{
		char name[256];
		bool isdir;
		long long lastmodified;
	} ved_filedata;

	bool ved_opendir(const char *path, const char *filter);

	bool ved_nextfile(ved_filedata *filedata);

	void ved_closedir(void);

	bool ved_directory_exists(const char *path);

	bool ved_file_exists(const char *path);

	long long ved_getmodtime(const char *path);
]])


buffer_filedata = ffi.new("ved_filedata")



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
		if libC.ved_opendir(directory .. "/".. prefix, ".vvvvvv") then
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

function getlevelsfolder()
	-- Returns success. Sets the path variables to what they _should_ be, even if
	-- they don't exist. That way we can say "check {levelsfolder} exists and try again"

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
	return directory_exists(vvvvvvfolder, "levels")
end

function directory_exists(where, what)
	return libC.ved_directory_exists(where .. "/" .. what)
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
