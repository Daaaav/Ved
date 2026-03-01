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
utf8 = require("utf8lib_wrapper")
require("vedxml_defaults")
require("func")
require("vvvvvvxml")
require("filefunc_" .. loaded_filefunc)

-- Could do cons = print, but if you have 300 levels then that'd be chaos in the console
cons = function() end

while true do
	local file = inchannel:demand()

	local success, metadata = loadlevelmetadata(file.path)

	if not success then
		outchannel:push(
			{
				dir = file.dir,
				id = file.id,
				path = file.path,
				success = false,
				errmsg = metadata,
				refresh = file.refresh
			}
		)
	else
		metadata.dir = file.dir
		metadata.id = file.id
		metadata.path = file.path
		metadata.success = true
		metadata.refresh = file.refresh
		outchannel:push(metadata)
	end
end
