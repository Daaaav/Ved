function map_init()
	-- Initialize/reset the map
	local collect = rooms_map ~= nil

	rooms_map = {}
	rooms_map_done = false
	rooms_map_current_x = 0
	rooms_map_current_y = 0

	if collect then
		collectgarbage("collect")
	end

	for y = 0, 19 do
		rooms_map[y] = {}

		for x = 0, 19 do
			map_initroom(x, y)
		end
	end
end

function map_work(timelimit)
	-- Work on the map if it's not done yet, stop if we've passed 0.011s
	-- Note that it will go over 0.01s, and theoretically take forever.
	if rooms_map_done then
		return
	end

	local st = love.timer.getTime()

	while love.timer.getTime()-st < timelimit do
		map_doroom(rooms_map_current_x, rooms_map_current_y)

		rooms_map_current_x = rooms_map_current_x + 1

		if rooms_map_current_x >= metadata.mapwidth then
			rooms_map_current_x = 0
			rooms_map_current_y = rooms_map_current_y + 1
		end

		if rooms_map_current_y >= metadata.mapheight then
			rooms_map_done = true
			break
		end
	end
end

function map_initroom(x, y)
	-- Initialize/reset one room on the map
	rooms_map[y][x] = {
		done = false,
		map = nil,
	}
end

function map_doroom(x, y)
	-- Create map for one room on the map
	-- LÖVE 0.9.x is still supported, with support for ancient graphics cards/drivers.
	if love.graphics.isSupported("canvas") then
		local canvas
		if love.graphics.isSupported("npot") then
			-- You're running a system that's not, what, 12 years old?
			canvas = love.graphics.newCanvas(320, 240)
		else
			-- I have access to a cardboard box that doesn't have NPOT support.
			canvas = love.graphics.newCanvas(512, 256)
		end

		love.graphics.setCanvas(canvas)
		clear_canvas(canvas)
		love.graphics.setScissor()
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle("fill", 0, 0, 320, 240)
		love.graphics.setColor(255,255,255,255)
		displayroom(0, 0, roomdata[y][x], levelmetadata[y*20 + x+1], 0.5)
		love.graphics.setCanvas()

		rooms_map[y][x].map = canvas
	end

	rooms_map[y][x].done = true
end
