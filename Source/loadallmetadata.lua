dirsep, levelsfolder, loaded_filefunc, L = ...

local inchannel = love.thread.getChannel("allmetadata_in")
local outchannel = love.thread.getChannel("allmetadata_out")

-- love.filesystem is needed in LÖVE 0.9.x
require("love.filesystem")
require("love.system")

-- Workaround for including func
love.graphics = {}
love.keyboard = {}
love.mouse = {}
function hook() end

require("corefunc")
require("func")
require("vvvvvvxml")
require("filefunc_" .. loaded_filefunc)

-- Could do cons = print, but if you have 300 levels then that'd be chaos in the console
cons = function() end

while true do
	local level = inchannel:demand()

	local success, metadata = loadlevelmetadata(level.path)

	if not success then
		outchannel:push(
			{
				dir = level.dir,
				id = level.id,
				path = level.path,
				success = false,
				errmsg = metadata,
				refresh = level.refresh
			}
		)
	else
		metadata.dir = level.dir
		metadata.id = level.id
		metadata.path = level.path
		metadata.success = true
		metadata.refresh = level.refresh
		outchannel:push(metadata)
	end
end
