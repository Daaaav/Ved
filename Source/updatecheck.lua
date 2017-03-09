checkver, nohttps = ...

local requesturl = "tolp2.nl/ved/version.php?sys=2&ver=" .. checkver

verchannel = love.thread.getChannel("version")

if nohttps then
	local http = require("socket.http")

	versioncheckedt = http.request("http://" .. requesturl)
else
	local https = require("ssl.https")

	versioncheckedt = https.request("https://" .. requesturl)
end

print("Finished version request.")

if versioncheckedt == nil then
	verchannel:push("connecterror")
elseif versioncheckedt:sub(1,1) ~= ">" then
	verchannel:push("error")
else
	verchannel:push(versioncheckedt:sub(2,-1))
end

-- Other arguments returned by http(s).request: code, headers, status