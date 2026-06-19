-- Load an appropriate backend for making HTTPS requests.

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
	function https.request(url)
		return nil
	end
	return https
end
