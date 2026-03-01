Level = {}

function Level:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self

	o.xml = nil

	o.metadata = {}
	o.limit = limit_v
	o.tiles = {}
	o.entities = {}
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

function Level:get_tiles(rx, ry)
	if rx < 0 or ry < 0 or rx >= self.metadata.mapwidth or ry >= self.metadata.mapheight then
		error("Attempt to Level:get_tiles in out-of-bounds room " .. rx .. "," .. ry)
	end

	return self.tiles[ry][rx]
end

function Level:get_tile(rx, ry, tx, ty)
	if tx < 0 or tx > 39 or ty < 0 or ty > 29 then
		error("Attempt to Level:get_tile " .. tx .. "," .. ty .. ", which is out of room bounds")
	end

	return self:get_tiles(rx, ry)[ty*40 + tx+1]
end

function Level:set_tiles(rx, ry, values)
	if rx < 0 or ry < 0 or rx >= self.metadata.mapwidth or ry >= self.metadata.mapheight then
		return
	end

	for ity = 0, 29 do
		for itx = 0, 39 do
			self.tiles[ry][rx][ity*40 + itx+1] = values[ity*40 + itx+1]
		end
	end

	map_resetroom(rx, ry)
end

function Level:set_tile(rx, ry, tx, ty, value)
	if rx < 0 or ry < 0 or rx >= self.metadata.mapwidth or ry >= self.metadata.mapheight then
		return
	end

	if tx < 0 or ty < 0 or tx >= 40 or ty >= 30 then
		return
	end

	self.tiles[ry][rx][ty*40 + tx+1] = value

	map_resetroom(rx, ry)
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
