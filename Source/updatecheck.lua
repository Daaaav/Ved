local checkver, commitversion = ...

local request_base = "tolp.nl/ved/"
local request_query = "?sys=3&ver=" .. checkver

if commitversion ~= nil then
	request_query = request_query .. "&pre=" ..  commitversion
end

local verchannel = love.thread.getChannel("version")
verchannel:clear()
local response_text

require("love.system")

if love.system.getOS() == "Windows" then
	require("https_win")

	response_text = https_request("https://" .. request_base .. "version-ssl.php" .. request_query)
elseif love.system.getOS() == "Linux" then
	local pfile = io.popen("wget -qO- 'https://" .. request_base .. "version-ssl.php" .. request_query .. "' --https-only")
	response_text = pfile:read("*a")
	pfile:close()
else
	local http = require("socket.http")

	response_text = http.request("http://" .. request_base .. "version.php" .. request_query)
end

print("Finished version request.")

if response_text == nil then
	verchannel:push("connecterror")
elseif response_text:sub(1,3) ~= "!>>" then
	verchannel:push("error")
else
	verchannel:push(response_text)
end

-- Other arguments returned by http(s).request: code, headers, status
