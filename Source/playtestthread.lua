local executethis, levelcontents = ...

-- Workaround for including lang/English, which is a workaround for including const
require("corefunc")

-- Workaround for including const
-- Just don't actually use L keys, I guess
require("lang/en")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local theprocess = io.popen(executethis, 'w')

theprocess:write(levelcontents)

theprocess:close()

outchannel:push(PLAYTESTING.DONE)
