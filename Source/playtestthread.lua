local opsys, path, args, levelcontents = ...

-- Needed in LÖVE 0.9.x
require("love.filesystem")

-- Workaround for including lang/English, which is a workaround for including const
require("corefunc")

-- Workaround for including const
-- Just don't actually use L keys, I guess
require("lang/en")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local success, err

if opsys == "Windows" then
	require("filefunc_win")
	success, err = run_pipe_process(path, args, levelcontents)
else
	-- Linux and Mac
	local theprocess = io.popen("'" .. path:gsub("'", "'\\''") .. "' " .. args, "w")

	-- Technically this only returns whether sending data was successful, but it looks like it's all we can really do
	success, err = theprocess:write(levelcontents)
	theprocess:close()
end

if not success then
	outchannel:push(PLAYTESTING.ERROR)
	outchannel:push(err)
else
	outchannel:push(PLAYTESTING.DONE)
end
