--[[ Load an appropriate backend for making HTTPS requests.

body = https.request(url, progress_callback)

If the request is successful, body is the full response body, else it is nil.

progress_callback is optional. If specified, it should be a function as follows:

	function(dlnow, dltotal)
	end

It will be periodically called until the download is complete.

dlnow is the current amount of downloaded bytes
dltotal is the total expected size.
dltotal may be nil if unknown, and it might change, depending on the backend.

]]

-- We're certainly in a thread
require("love.system")


if love.system.getOS() == "Windows" then
	return require("https_win")
elseif love.system.getOS() == "OS X" then
	return require("https_mac")
elseif love.system.getOS() == "Linux" then
	return require("https_lin")
else
	local https = {}
	function https.request(url, progress_callback)
		return nil
	end
	return https
end
