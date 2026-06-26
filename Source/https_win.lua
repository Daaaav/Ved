local https_win = {}

require("libs.windows_constants")

local ffi = require("ffi")
local wininet = ffi.load("wininet")
ffi.cdef((love.filesystem.read("libs/windows_types.h")))
ffi.cdef((love.filesystem.read("libs/windows_main.h")))
ffi.cdef((love.filesystem.read("libs/windows_wininet.h")))

local function utf16(text_utf8)
	local text_utf16_len = ffi.C.MultiByteToWideChar(CP_UTF8, 0, text_utf8, -1, nil, 0)
	local text_utf16 = ffi.new("WCHAR[?]", text_utf16_len)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0, text_utf8, -1, text_utf16, text_utf16_len)
	return text_utf16
end

function https_win.request(url, progress_callback)
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

	local dword_buf = ffi.new("DWORD[1]")
	local sizeof_dword = ffi.new("DWORD[1]", ffi.sizeof(dword_buf))

	if wininet.HttpQueryInfoW(
		hRequest,
		HTTP_QUERY_STATUS_CODE + HTTP_QUERY_FLAG_NUMBER,
		dword_buf,
		sizeof_dword,
		nil
	) and tonumber(dword_buf[0]) >= 400 then
		wininet.InternetCloseHandle(hRequest)
		wininet.InternetCloseHandle(hInternet)
		return nil
	end

	local progress_dltotal = nil
	if progress_callback ~= nil then
		if wininet.HttpQueryInfoW(
			hRequest,
			HTTP_QUERY_CONTENT_LENGTH + HTTP_QUERY_FLAG_NUMBER,
			dword_buf,
			sizeof_dword,
			nil
		) then
			progress_dltotal = tonumber(dword_buf[0])
		end
	end

	local lua_string_data = {}
	local progress_dlnow = 0
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
		progress_dlnow = progress_dlnow + bytesRead[0]
		table.insert(lua_string_data, ffi.string(buffer_data, bytesRead[0]))
		if progress_callback ~= nil then
			progress_callback(progress_dlnow, progress_dltotal)
		end
	end

	wininet.InternetCloseHandle(hRequest)
	wininet.InternetCloseHandle(hInternet)

	return table.concat(lua_string_data)
end

return https_win
