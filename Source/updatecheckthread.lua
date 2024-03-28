local ved_ver_string, commitversion, dist_method = ...

local request_query = "?sys=3&ver=" .. ved_ver_string .. "&dist_method=" .. dist_method

if commitversion ~= nil then
	request_query = request_query .. "&pre=" ..  commitversion
end

local check_channel = love.thread.getChannel("version")
check_channel:clear()

-- Needed in LÖVE 0.9.x
require("love.filesystem")

require("https_main")
local response_text = https_request("https://tolp.nl/ved/version-ssl.php" .. request_query)

print("Finished version request.")

if response_text == nil then
	check_channel:push("connecterror")
elseif response_text:sub(1,3) ~= "!>>" then
	check_channel:push("error")
else
	check_channel:push(response_text)
end
