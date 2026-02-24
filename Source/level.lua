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
	o.roommetadata = {}
	o.scripts = {}
	o.scriptnames = {}
	o.count = {
		trinkets = 0,
		crewmates = 0,
		entities = 0,
		entity_ai = 1,
		startpoint = nil
	}
	o.vedmetadata = false
	o.textboxcolors = {}
	o.textboxcolors_order = {}
	o.specialroomnames = {}
	o.specialroomnames_order = {}

	return o
end

function Level:get_roommetadata(x, y)
	if self.roommetadata[y] == nil or self.roommetadata[y][x] == nil then
		error("Attempt to Level:get_roommetadata for out-of-bounds room " .. x .. "," .. y)
	end

	return self.roommetadata[y][x]
end

function Level:set_roommetadata(x, y, param1, param2)
	local attribute, value
	if param2 ~= nil then
		attribute = param1
		value = param2
	else
		value = param1
	end

	if self.roommetadata[y] == nil or self.roommetadata[y][x] == nil then
		return
	end

	if attribute ~= nil then
		self.roommetadata[y][x][attribute] = value
	else
		self.roommetadata[y][x] = value
	end

	map_resetroom(x, y)
end
