-- Load an appropriate backend for making HTTPS requests.

-- We're certainly in a thread
require("love.system")


if love.system.getOS() == "Windows" then
	require("https_win")
elseif love.system.getOS() == "OS X" then
	require("https_mac")
elseif love.system.getOS() == "Linux" then
	require("https_lin")
else
	function https_request(url)
		return nil
	end
end
