local executethis = ...

-- Workaround for including lang/English, which is a workaround for including const
require("corefunc")

-- Workaround for including const
-- Just don't actually use L keys, I guess
require("lang/English")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local theprocess = io.popen(executethis)

-- A bit hack-ish, but it works
for _ in theprocess:lines() do end

love.filesystem.remove("veduser/VVVVVV/levels/ved_playtesting_temp.vvvvvv")
love.filesystem.remove("veduser/VVVVVV/saves/ved_playtesting_temp.vvvvvv.vvv")
love.filesystem.remove("veduser/VVVVVV/saves/qsave.vvv")
love.filesystem.remove("veduser/VVVVVV/saves/tsave.vvv")

outchannel:push(PLAYTESTING.DONE)
