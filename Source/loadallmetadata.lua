dirsep, levelsfolder, loaded_filefunc, getOS, L = ...

local inchannel = love.thread.getChannel("allmetadata_in")
local outchannel = love.thread.getChannel("allmetadata_out")

require("love.filesystem")

-- Workaround for including func
love.graphics = {}
function hook() end

-- Workaround for love.system.getOS()
if love.system == nil then
	love.system = {}
end
love.system.getOS = function()
	return getOS
end

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
