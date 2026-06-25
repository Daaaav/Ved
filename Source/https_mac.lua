local https_mac = {}

require("librarian")

local ffi = require("ffi")
local lib = load_library(ffi, "vedlib_https_mac02.so")
ffi.cdef((love.filesystem.read("libs/vedlib_https_mac.h")))

function https_mac.request(url, progress_callback)
	if lib == nil then
		return nil
	end

	lib.https_start_request(url, 0)

	local last_progress_dlnow = 0
	local last_progress_dltotal = nil
	local status = ffi.new("https_status")

	while lib.https_request_await(status) do
		if progress_callback ~= nil then
			-- Progress updates! Only call the callback when we have new numbers,
			-- and make sure total is nil when unknown (not 0)
			local progress_dlnow = tonumber(status.progress_dlnow)
			local progress_dltotal = tonumber(status.progress_dltotal)
			if progress_dltotal == 0 then
				progress_dltotal = nil
			end

			if progress_dlnow ~= last_progress_dlnow
			or progress_dltotal ~= last_progress_dltotal then
				progress_callback(progress_dlnow, progress_dltotal)

				last_progress_dlnow = progress_dlnow
				last_progress_dltotal = progress_dltotal
			end
		end
	end

	if not status.final_success then
		return nil
	end

	local len = tonumber(status.final_dltotal)
	local response
	if len == 0 then
		response = ""
	else
		response = ffi.string(lib.https_get_response_data(), len)
	end

	lib.https_free_request()
	return response
end

return https_mac
