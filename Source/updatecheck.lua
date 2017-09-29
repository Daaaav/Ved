checkver, nohttps = ...

local requesturl = "tolp.nl/ved/version.php?sys=3&ver=" .. checkver

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
elseif versioncheckedt:sub(1,3) ~= "!>>" then
	verchannel:push("error")
else
	verchannel:push(versioncheckedt)
end

-- Other arguments returned by http(s).request: code, headers, status