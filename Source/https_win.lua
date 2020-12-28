require("windows_constants")

local ffi = require("ffi")
local wininet = ffi.load("wininet")
ffi.cdef((love.filesystem.read("windows_types.h")))
ffi.cdef((love.filesystem.read("windows_main.h")))
ffi.cdef((love.filesystem.read("windows_wininet.h")))

local function utf16(text_utf8)
	local text_utf16_len = ffi.C.MultiByteToWideChar(CP_UTF8, 0, text_utf8, -1, nil, 0)
	local text_utf16 = ffi.new("WCHAR[?]", text_utf16_len)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0, text_utf8, -1, text_utf16, text_utf16_len)
	return text_utf16
end

function https_request(url)
	local hInternet = wininet.InternetOpenW(utf16("Ved/WinINet"), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
	if hInternet == nil then
		return nil
	end

	local hRequest = wininet.InternetOpenUrlW(
		hInternet, utf16(url), nil, 0,
		INTERNET_FLAG_NO_COOKIES + INTERNET_FLAG_NO_UI + INTERNET_FLAG_SECURE, nil
	)
	if hRequest == nil then
		wininet.InternetCloseHandle(hInternet)
		return nil
	end

	local lua_string_data = ""
	local buffer_data = ffi.new("char[50000]")
	local bytesRead = ffi.new("DWORD[1]")
	while true do
		-- Download in chunks of max 50 KB
		local success = wininet.InternetReadFile(hRequest, buffer_data, 50000, bytesRead)
		if not success then
			wininet.InternetCloseHandle(hRequest)
			wininet.InternetCloseHandle(hInternet)
			return nil
		end
		if bytesRead[0] == 0 then
			-- success and 0 bytes read means done
			break
		end
		lua_string_data = lua_string_data .. ffi.string(buffer_data, bytesRead[0])
	end

	wininet.InternetCloseHandle(hRequest)
	wininet.InternetCloseHandle(hInternet)

	return lua_string_data
end
