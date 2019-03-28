-- Note to self: environment variables: set

-- These functions assume you're not on a school computer or anywhere where cmd is completely restricted.


-- We know we're on Windows for a start...
userprofile = os.getenv("USERPROFILE")

simplevvvvvvfolder = false
standardvvvvvvfolders = {
	display = "\\(My) Documents\\VVVVVV",
	folders = {
		"\\Documents\\VVVVVV",
		"\\My Documents\\VVVVVV"
	}
}


local ffi = require("ffi")
ffi.cdef([[
	typedef uint16_t WORD;
	typedef uint32_t DWORD;
	typedef char CHAR;
	typedef void* HANDLE;
	typedef bool BOOL;
	typedef const char* LPCSTR;

	typedef struct _FILETIME {
	  DWORD dwLowDateTime;
	  DWORD dwHighDateTime;
	} FILETIME, *PFILETIME, *LPFILETIME;

	typedef struct _WIN32_FIND_DATAA {
	  DWORD    dwFileAttributes;
	  FILETIME ftCreationTime;
	  FILETIME ftLastAccessTime;
	  FILETIME ftLastWriteTime;
	  DWORD    nFileSizeHigh;
	  DWORD    nFileSizeLow;
	  DWORD    dwReserved0;
	  DWORD    dwReserved1;
	  CHAR     cFileName[260];
	  CHAR     cAlternateFileName[14];
	  DWORD    dwFileType;
	  DWORD    dwCreatorType;
	  WORD     wFinderFlags;
	} WIN32_FIND_DATAA, *PWIN32_FIND_DATAA, *LPWIN32_FIND_DATAA;

	HANDLE FindFirstFileA(
	  LPCSTR             lpFileName,
	  LPWIN32_FIND_DATAA lpFindFileData
	);

	BOOL FindNextFileA(
	  HANDLE             hFindFile,
	  LPWIN32_FIND_DATAA lpFindFileData
	);

	BOOL FindClose(
	  HANDLE hFindFile
	);

	typedef struct _SYSTEMTIME {
	  WORD wYear;
	  WORD wMonth;
	  WORD wDayOfWeek;
	  WORD wDay;
	  WORD wHour;
	  WORD wMinute;
	  WORD wSecond;
	  WORD wMilliseconds;
	} SYSTEMTIME, *PSYSTEMTIME, *LPSYSTEMTIME;

	BOOL FileTimeToSystemTime(
	  const FILETIME *lpFileTime,
	  LPSYSTEMTIME   lpSystemTime
	);

	typedef void TIME_ZONE_INFORMATION;

	BOOL SystemTimeToTzSpecificLocalTime(
	  const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
	  const SYSTEMTIME            *lpUniversalTime,
	  LPSYSTEMTIME                lpLocalTime
	);
]])


function cp850toutf8(text)
	-- We're working with the command line...

	if text == nil then return nil end

	local extended = "ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»░▒▓│┤ÁÂÀ©╣║╗╝¢¥┐└┴┬├─┼ãÃ╚╔╩╦╠═╬¤ðÐÊËÈıÍÎÏ┘┌█▄¦Ì▀ÓßÔÒõÕµþÞÚÛÙýÝ¯´-±‗¾¶§÷¸°¨·¹³²■ "

	local convertedtext = {}

	for c = 1, text:len() do
		local chr = string.sub(text, c, c)
		local binarychar = toBinary(chr)

		if string.sub(binarychar, 1, 1) == "0" then
			table.insert(convertedtext, chr)
		else
			local seekthis = string.byte(chr) - 127

			local currentbytepos = 1
			local currentnumpos = 1

			while currentnumpos < seekthis do
				local extbinarychar = toBinary(string.sub(extended, currentbytepos, currentbytepos))

				if string.sub(extbinarychar, 1, 3) == "110" then
					currentbytepos = currentbytepos + 2
				elseif string.sub(extbinarychar, 1, 4) == "1110" then
					currentbytepos = currentbytepos + 3
				elseif string.sub(extbinarychar, 1, 5) == "11110" then
					currentbytepos = currentbytepos + 4
				else
					currentbytepos = currentbytepos + 1
				end

				currentnumpos = currentnumpos + 1
			end

			-- So currentbytepos should now have the start of the character we're looking for.

			--cons("AT POSITION " .. currentbytepos .. " #" .. currentnumpos)

			table.insert(convertedtext, firstUTF8(string.sub(extended, currentbytepos)))
		end
	end

	return table.concat(convertedtext)

	--[[
	local count1, count2, count3, count4 = 0, 0, 0, 0

	for c = 1, string.len(extended) do
		binarychar = toBinary(string.sub(extended, c, c))

		if string.sub(binarychar, 1, 1) == "0" then
			count1 = count1 + 1
		elseif string.sub(binarychar, 1, 3) == "110" then
			count2 = count2 + 1
		elseif string.sub(binarychar, 1, 4) == "1110" then
			count3 = count3 + 1
		elseif string.sub(binarychar, 1, 5) == "11110" then
			count4 = count4 + 1
		end
	end

	cons(count1 .. " - " .. count2 .. " - " .. count3 .. " - " .. count4)
	--cons(extended:len() .. "!!!!!!!!!!!!!!")
	]]
end

-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local t = {[""] = {}}

	-- We really can't have slashes here instead of backslashes, this is Windows.
	directory = directory:gsub("/", "\\")
	-- We can't have a trailing backslash either, or our matching system will blow up. This comes in the form of a double backslash.
	directory = directory:gsub("\\\\", "\\")

	filedata = ffi.new("WIN32_FIND_DATAA")
	st_utc = ffi.new("SYSTEMTIME")
	st_loc = ffi.new("SYSTEMTIME")
	search_handle = ffi.C.FindFirstFileA(directory .. "\\*.vvvvvv", filedata)
	if search_handle == -1 then -- TODO check if this is really INVALID_HANDLE_VALUE
		return t
	end
	local files_left = true
	while files_left do
		ffi.C.FileTimeToSystemTime(filedata.ftLastWriteTime, st_utc)
		ffi.C.SystemTimeToTzSpecificLocalTime(nil, st_utc, st_loc)

		table.insert(t[""], -- currentdir
			{
				name = cp850toutf8(ffi.string(filedata.cFileName)),
				isdir = false,
				bu_lastmodified = 0,
				bu_overwritten = 0,
				lastmodified = {st_loc.wYear, st_loc.wMonth, st_loc.wDay, st_loc.wHour, st_loc.wMinute, st_loc.wSecond},
			}
		)
		files_left = ffi.C.FindNextFileA(search_handle, filedata)
	end

	ffi.C.FindClose(search_handle)
	return t
end

function getlevelsfolder(ignorecustom)
	-- Returns success, path

	if s.customvvvvvvdir == "" or ignorecustom then
		-- Spawn less cmd windows
		if directory_exists(userprofile .. standardvvvvvvfolders.folders[1], "levels") then
			return true, userprofile .. standardvvvvvvfolders.folders[1] .. "\\levels"
		elseif directory_exists(userprofile .. standardvvvvvvfolders.folders[2], "levels") then
			return true, userprofile .. standardvvvvvvfolders.folders[2] .. "\\levels"
		else
			-- Also return what it should have been
			return false, userprofile .. standardvvvvvvfolders.display .. "\\levels"
		end
	else
		-- The user has supplied a custom directory.
		if directory_exists(s.customvvvvvvdir, "levels") then
			-- Fair enough
			return true, s.customvvvvvvdir .. "\\levels"
		else
			-- What are you doing?
			return false, s.customvvvvvvdir .. "\\levels"
		end
	end
end

function listdirs(directory)
	-- Currently unused, except in a testing state
	local t = {}
	-- Only do folders.
	local pfile = io.popen('dir "' .. escapename(directory) .. '" /b /ad')
	for filename in pfile:lines() do
		table.append(t, filename)
	end
	pfile:close()
	return t
end

function directory_exists(where, what)
	local t = {}

	local pfile = io.popen('dir "' .. escapename(where) .. '" /b /ad')
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
	if path:sub(3):match(".*[:%*%?\"<>|].*") ~= nil then
		return false, L.INVALIDFILENAME_WIN
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
	local pfile = io.popen(
		escapename(
			love.filesystem.getSaveDirectory():gsub(
				escapegsub(love.filesystem.getAppdataDirectory(), true),
				"%%appdata%%"
			):gsub("/", "\\")
		) .. '\\available_utils\\fileunix.exe "' .. escapename(fullpath) .. '"'
	)
	local modtime = pfile:read("*a")
	pfile:close()
	return modtime
end

function readimage(levelsfolder, filename)
	-- returns success, contents

	local fh, everr = io.open(levelsfolder:sub(1, -8) .. "\\graphics\\" .. filename, "rb")

	if fh == nil then
		return false, everr
	end

	local ficontents = fh:read("*a")

	fh:close()

	return true, ficontents
end

function util_folderopendialog()
	-- love.filesystem.getSaveDirectory() = C:/Users/David/AppData/Roaming/LOVE/ved
	os.execute(love.filesystem.getSaveDirectory():gsub("/", "\\") .. "\\utils\\folderopendialog.exe")
end

function escapename(name)
	-- Windows doesn't allow all sorts of characters in filenames, which is nice for programmers using the command line and can be annoying for users.
	return name:gsub('"', "")
end
