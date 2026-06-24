local https_lin = {}

local chan_curl_success = love.thread.getChannel("curl_global_init")
local curl_const
local ffi
local curl
local curl_success, errmsg = pcall(function()
	curl_const = require("libs.curl_constants")

	ffi = require("ffi")
	curl = ffi.load("libcurl.so.4")
	ffi.cdef((love.filesystem.read("libs/curl.h")))
end)
if not curl_success then
	print("CURL loading error: " .. errmsg)
end

function https_lin.global_init()
	if curl_success then
		curl_success, errmsg = pcall(function()
			if curl.curl_global_init(curl_const.CURL_GLOBAL_ALL) ~= "CURLE_OK" then
				error("not CURLE_OK")
			end
		end)
		if not curl_success then
			print("curl_global_init error: " .. errmsg)
		end
	end

	chan_curl_success:push(curl_success)
end

function https_lin.request_curl(url)
	-- Main implementation: use libcurl

	local helper = ffi.load(
		love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_curlhelper_lin00.so"
	)
	ffi.cdef((love.filesystem.read("libs/vedlib_curlhelper.h")))

	local userdata = ffi.new("ved_curl_download_data")

	local handle = curl.curl_easy_init()
	assert(handle ~= nil)

	-- Really important options: if these fail, might as well pack up
	if curl.curl_easy_setopt(handle, "CURLOPT_URL", url) ~= "CURLE_OK"
	or curl.curl_easy_setopt(handle, "CURLOPT_WRITEFUNCTION", helper.ved_curl_download) ~= "CURLE_OK"
	or curl.curl_easy_setopt(handle, "CURLOPT_WRITEDATA", userdata) ~= "CURLE_OK" then
		curl.curl_easy_cleanup(handle)
		error("Important curl_easy_setopt failed")
	end

	-- Less important options: if these fail, keep going
	if curl.curl_easy_setopt(handle, "CURLOPT_PROTOCOLS_STR", "HTTPS") ~= "CURLE_OK" then
		-- Probably CURLE_UNKNOWN_OPTION on curl before 7.85.0 (August 2022), so:
		curl.curl_easy_setopt(handle, "CURLOPT_PROTOCOLS", ffi.new("long", curl_const.CURLPROTO_HTTPS))
	end
	curl.curl_easy_setopt(handle, "CURLOPT_NOSIGNAL", ffi.new("long", 1))
	curl.curl_easy_setopt(handle, "CURLOPT_USERAGENT", "Ved/libcurl")

	local transfer_code = curl.curl_easy_perform(handle)

	curl.curl_easy_cleanup(handle)

	if transfer_code ~= "CURLE_OK" then
		return nil
	end

	local data_str = ffi.string(userdata.data, userdata.total_data)
	helper.ved_cleanup_userdata(userdata)
	return data_str
end

function https_lin.request_wget(url)
	-- Fallback implementation: Just popen wget like before.

	-- We could assume the URL is trusted and doesn't need to be escaped, but just in case
	if url:find("'") ~= nil then
		return nil
	end

	local total_bytes = 0

	local pfile = io.popen("wget -qO- '" .. url .. "' --https-only")
	local lua_string_data = {}
	while true do
		local response_text = pfile:read(50000)
		if response_text == nil then
			break
		end

		total_bytes = total_bytes + response_text:len()
		table.insert(lua_string_data, response_text)
	end
	pfile:close()

	return table.concat(lua_string_data)
end

function https_lin.request(...)
	if chan_curl_success:peek() then
		local success, data = pcall(https_lin.request_curl, ...)
		if success then
			return data
		else
			print("CURL request broke: " .. data)
		end
	end

	return https_lin.request_wget(...)
end

return https_lin
