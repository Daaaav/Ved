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
			local ver = curl.curl_version_info("CURLVERSION_TWELFTH")

			if ver.version_num < 0x074200 then
				error("libcurl " .. ffi.string(ver.version) .. " is older than 7.66.0 (Sep 2019)!")
			end

			if curl.curl_global_init(curl_const.CURL_GLOBAL_ALL) ~= "CURLE_OK" then
				error("not CURLE_OK")
			end
		end)
		if not curl_success then
			print("libcurl init error: " .. errmsg)
		end
	end

	chan_curl_success:push(curl_success)
end

function https_lin.request_curl(url, progress_callback)
	-- Main implementation: use libcurl

	local helper = ffi.load(
		love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_curlhelper_lin01.so"
	)
	ffi.cdef((love.filesystem.read("libs/vedlib_curlhelper.h")))

	local userdata = ffi.new("ved_curl_download_data")

	-- Easy handle
	local ehand = curl.curl_easy_init()
	assert(ehand ~= nil)

	-- Really important options: if these fail, might as well pack up
	if curl.curl_easy_setopt(ehand, "CURLOPT_URL", url) ~= "CURLE_OK"
	or curl.curl_easy_setopt(ehand, "CURLOPT_WRITEFUNCTION", helper.ved_curl_download) ~= "CURLE_OK"
	or curl.curl_easy_setopt(ehand, "CURLOPT_WRITEDATA", userdata) ~= "CURLE_OK" then
		curl.curl_easy_cleanup(ehand)
		error("Important curl_easy_setopt failed")
	end

	-- Less important options: if these fail, keep going
	if curl.curl_easy_setopt(ehand, "CURLOPT_PROTOCOLS_STR", "HTTPS") ~= "CURLE_OK" then
		-- Probably CURLE_UNKNOWN_OPTION on curl before 7.85.0 (August 2022), so:
		curl.curl_easy_setopt(ehand, "CURLOPT_PROTOCOLS", ffi.new("long", curl_const.CURLPROTO_HTTPS))
	end
	curl.curl_easy_setopt(ehand, "CURLOPT_NOSIGNAL", ffi.new("long", 1))
	curl.curl_easy_setopt(ehand, "CURLOPT_USERAGENT", "Ved/libcurl")
	curl.curl_easy_setopt(ehand, "CURLOPT_FAILONERROR", ffi.new("long", 1))
	curl.curl_easy_setopt(ehand, "CURLOPT_FOLLOWLOCATION", ffi.new("long", 1))
	curl.curl_easy_setopt(ehand, "CURLOPT_MAXREDIRS", ffi.new("long", 10))
	if curl.curl_easy_setopt(ehand, "CURLOPT_XFERINFOFUNCTION", helper.ved_curl_progress) == "CURLE_OK"
	and curl.curl_easy_setopt(ehand, "CURLOPT_XFERINFODATA", userdata) == "CURLE_OK" then
		curl.curl_easy_setopt(ehand, "CURLOPT_NOPROGRESS", ffi.new("long", 0))
	end

	-- Multi handle
	local mhand = curl.curl_multi_init()
	if mhand == nil or curl.curl_multi_add_handle(mhand, ehand) ~= "CURLM_OK" then
		curl.curl_easy_cleanup(ehand)
		curl.curl_multi_cleanup(mhand)
		error("Setting up multi handle failed")
	end

	local last_progress_dlnow = 0
	local last_progress_dltotal = nil
	local still_running = ffi.new("int[1]")
	local multi_result
	local transfer_result
	repeat
		multi_result = curl.curl_multi_poll(mhand, nil, 0, 1000, nil)

		if multi_result == "CURLM_OK" then
			multi_result = curl.curl_multi_perform(mhand, still_running)

			if multi_result == "CURLM_OK" and still_running[0] == 0 then
				local msgs_in_queue = ffi.new("int[1]")
				local msg = curl.curl_multi_info_read(mhand, msgs_in_queue)
				if msg ~= nil and msg.msg == "CURLMSG_DONE" then
					transfer_result = msg.data.result
				end
			end

			if progress_callback ~= nil then
				-- Progress updates! Only call the callback when we have new numbers,
				-- and make sure total is nil when unknown (not 0)
				local progress_dlnow = tonumber(userdata.progress_dlnow)
				local progress_dltotal = tonumber(userdata.progress_dltotal)
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
	until multi_result ~= "CURLM_OK" or transfer_result ~= nil

	curl.curl_multi_remove_handle(mhand, ehand)
	curl.curl_easy_cleanup(ehand)
	curl.curl_multi_cleanup(mhand)

	if multi_result ~= "CURLM_OK" or transfer_result ~= "CURLE_OK" then
		return nil
	end

	local data_str = ffi.string(userdata.data, userdata.data_len)
	helper.ved_cleanup_userdata(userdata)
	return data_str
end

function https_lin.request_wget(url, progress_callback)
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

		if progress_callback ~= nil then
			progress_callback(total_bytes, nil)
		end
	end
	pfile:close()

	if total_bytes == 0 then
		-- More likely failure than an actual empty download
		return nil
	end

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
