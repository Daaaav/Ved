local checkver, commitversion = ...

local request_query = "?sys=3&ver=" .. checkver

if commitversion ~= nil then
	request_query = request_query .. "&pre=" ..  commitversion
end

local verchannel = love.thread.getChannel("version")
verchannel:clear()

-- Needed in LÖVE 0.9.x
require("love.filesystem")

require("https_main")
local response_text = https_request("https://tolp.nl/ved/version-ssl.php" .. request_query)

print("Finished version request.")

if response_text == nil then
	verchannel:push("connecterror")
elseif response_text:sub(1,3) ~= "!>>" then
	verchannel:push("error")
else
	verchannel:push(response_text)
end
