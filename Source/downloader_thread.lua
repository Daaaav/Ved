local id, url, sha512, size
L, id, url, sha512, size = ...

size = tonumber(size)

--[[
This thread is downloads packages. Its job is to:
- Download the given file from the URL
- Verify the file's hash and size once downloaded
- Report on the download and verification progress
- Send the file contents (or any errors) out through the output channels
  so the main thread can do something with it

Inputs:
- id: whatever's necessary for the main thread to identify one package from another
- url: the URL to download from
- sha512: expected SHA-512 hash
- size: expected number of bytes
]]

require("love.filesystem")
require("love.system")

local channel_progress = love.thread.getChannel("downloader_progress")
local channel_data = love.thread.getChannel("downloader_data")

-- Just because we're unable to verify the hash...
if love.getVersion() < 11 then
	channel_progress:push({id=id, fail=L.DOWNLOAD_REQUIRES_BETTER_LOVE})
	return
end

require("https_main")
local package = https_request(url)

if package == nil then
	print("Package download failed!")
	channel_progress:push({id=id, fail=L.DOWNLOAD_FAIL_GET})
	return
end

-- So now that we have the data, time to verify it...
-- If the size doesn't match we don't have to bother hashing.
local found_size = package:len()
local package_correct = found_size == size

if not package_correct then
	print("Package size unexpected! Expected " .. size .. ", found " .. found_size)
else
	-- Time to do something big with numbers!
	local found_sha512 = love.data.encode("string", "hex", love.data.hash("sha512", package))
	package_correct = found_sha512:lower() == sha512:lower()
	if not package_correct then
		print("Package hash unexpected!\nExpected: " .. sha512 .. "\n   Found: " .. found_sha512)
	end
end
if not package_correct then
	channel_progress:push({id=id, fail=L.DOWNLOAD_FAIL_VERIFY})
	return
end

channel_data:push({id=id, data=package})
channel_progress:push({id=id, done=true})
