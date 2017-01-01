checkver = ...

verchannel = love.thread.getChannel("version")

local http = require("socket.http")

versioncheckedt = http.request("http://tolp2.nl/ved/version.php?sys=2&ver=" .. checkver)

print("Finished version request.")

if versioncheckedt == nil then
	verchannel:push("connecterror")
elseif versioncheckedt:sub(1,1) ~= ">" then
	verchannel:push("error")
else
	verchannel:push(versioncheckedt:sub(2,-1))
end