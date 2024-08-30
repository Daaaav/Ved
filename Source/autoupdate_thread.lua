local url, hash, length
L, url, hash, length = ...

--[[
This thread's job is to:
- Download the given zip
- Verify the zip's hash once downloaded
- Report on the download and verification progress
- Unpack the files from the zip in the correct places
- Start the updater program
- Signal Ved to quit
]]

require("love.filesystem")
require("love.system")

local outchannel = love.thread.getChannel("autoupdate_out")

local basedir = love.filesystem.getSourceBaseDirectory()
local updater_exe
local args

if love.system.getOS() == "Windows" then
	require("filefunc_win")
	updater_exe = basedir .. "\\ved_updater.exe"
	args = {"-lang", "TODO"} -- , "-await", TODO see /home/david/prog/c/WINDOWSMNT/createprocess_parentterminate/parent.c
elseif love.system.getOS() == "OS X" then
	require("filefunc_linmac")
	updater_exe = basedir
	outchannel:push({cmd="error", msg=L.AUTOUPDATE_OSNYI})
	return
elseif love.system.getOS() == "Linux" then
	require("filefunc_linmac")
	updater_exe = basedir
	outchannel:push({cmd="error", msg=L.AUTOUPDATE_OSNYI})
	return
else
	outchannel:push({cmd="error", msg=L.AUTOUPDATE_OSNYI})
	return
end

-- TODO download

-- TODO verify

-- TODO unpack

local process = cProcess:new{path=updater_exe, args_table=args}
local success, err = process:start()

if success then
	outchannel:push({cmd="quit"})
else
	outchannel:push({cmd="error", msg=err})
end
