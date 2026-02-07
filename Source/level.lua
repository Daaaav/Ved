Level = {}

function Level:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self

	o.xml = nil

	o.metadata = {}
	o.limit = limit_v
	o.roomdata = {}
	o.entitydata = {}
	o.levelmetadata = {}
	o.scripts = {}
	o.scriptnames = {}
	o.count = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil, FC = 0} -- FC = Failed Checks
	o.vedmetadata = false
	o.textboxcolors = {}
	o.textboxcolors_order = {}

	return o
end
