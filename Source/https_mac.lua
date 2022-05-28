require("librarian")

local ffi = require("ffi")
local lib = load_library(ffi, "vedlib_https_mac01.so")
ffi.cdef((love.filesystem.read("libs/vedlib_https_mac.h")))

function https_request(url)
	if lib == nil then
		return nil
	end

	local success = lib.https_start_request(url, 0)

	if not success then
		return nil
	end

	local len = tonumber(lib.https_get_response_length())
	local response
	if len == 0 then
		response = ""
	else
		response = ffi.string(lib.https_get_response_data(), len)
	end

	lib.https_free_request()
	return response
end
