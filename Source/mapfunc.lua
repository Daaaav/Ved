function map_init()
	-- Initialize/reset the map
	local collect = rooms_map ~= nil

	rooms_map = {}
	rooms_map_done = false
	rooms_map_current_x = 0
	rooms_map_current_y = 0
	rooms_map_dirty_rooms = {}

	if collect then
		collectgarbage("collect")
	end

	for y = 0, metadata.mapheight-1 do
		rooms_map[y] = {}

		for x = 0, metadata.mapwidth-1 do
			map_initroom(x, y)
		end
	end
end

function map_work(timelimit)
	-- Work on the map if it's not done yet, stop if we've passed 0.011s
	-- Note that it will go over 0.01s, and theoretically take forever.
	if rooms_map_done and #rooms_map_dirty_rooms == 0 then
		return
	end

	-- Apparently there's still work to do. Unless the first room in queue is the current one. Unless we're on the map or in the script editor.
	local first_dirty = rooms_map_dirty_rooms[1]
	if rooms_map_done and #rooms_map_dirty_rooms > 0 and first_dirty[1] == roomx and first_dirty[2] == roomy and state ~= 12 and state ~= 3 then
		return
	end

	local st = love.timer.getTime()

	while love.timer.getTime()-st < timelimit do
		-- Okay, so which room do we actually do?
		local curr_x, curr_y
		if not rooms_map_done then
			curr_x, curr_y = rooms_map_current_x, rooms_map_current_y
			rooms_map_current_x = rooms_map_current_x + 1

			if rooms_map_current_x >= metadata.mapwidth then
				rooms_map_current_x = 0
				rooms_map_current_y = rooms_map_current_y + 1
			end

			if rooms_map_current_y >= metadata.mapheight then
				rooms_map_done = true
			end
		elseif #rooms_map_dirty_rooms > 0 then
			curr_x, curr_y = first_dirty[1], first_dirty[2]
			table.remove(rooms_map_dirty_rooms, 1)
		else
			-- Just to be sure
			break
		end

		map_doroom(curr_x, curr_y)

		if rooms_map_done then
			break
		end
	end
end

function map_initroom(x, y)
	-- Initialize one room on the map
	rooms_map[y][x] = {
		done = false,
		map = nil,
	}
end

function map_correspondreset(x, y, dirty_attrs, dirty_rows)
	local rooms = {}
	local function dirty(rooms, x, y)
		local alreadyexists = false
		for _,r in pairs(rooms) do
			if x == r[1] and y == r[2] then
				alreadyexists = true
				break
			end
		end
		if not alreadyexists then
			table.insert(rooms, {x, y})
		end
	end

	for _,attr in pairs(dirty_attrs) do
		if attr == DIRTY.ROW then
			for _,row in pairs(dirty_rows) do
				local absolute_row = 30*y + row
				for mrx = x, metadata.mapwidth-1, 20 do
					local roomywithrow = math.floor(absolute_row/30)
					dirty(rooms, mrx, roomywithrow)

					absolute_row = absolute_row - 1
					if absolute_row < 0 then
						break
					end
				end

				if metadata.mapheight > 20 then
					absolute_row = 30*y + row
					for mrx = x, metadata.mapwidth-1, 20 do
						local distortion = math.floor(mrx/20)
						if absolute_row == distortion then
							for mry = 20, metadata.mapheight-1 do
								dirty(rooms, mrx, mry)
							end
						end
					end
				end
			end
		elseif attr == DIRTY.OUTROW29 then
			local absolute_row = 19*30 + 29 -- tile row 29 on room row 19
			for mrx = x, metadata.mapwidth-1, 20 do
				local roomywithrow = math.floor(absolute_row/30)
				dirty(rooms, mrx, roomywithrow)

				absolute_row = absolute_row - 1
				if absolute_row < 0 then
					break
				end
			end
		elseif attr == DIRTY.PROPERTY then
			local mry = y
			local cnt = 0
			for mrx = x, metadata.mapwidth-1, 20 do
				cnt = cnt + 1
				dirty(rooms, mrx, mry)

				mry = mry - 1
				if mry < 0 then
					break
				end
			end
		elseif attr == DIRTY.ENTITY then
			dirty(rooms, x, y)
		end
	end

	for _,r in pairs(rooms) do
		map_resetroom(r[1], r[2])
	end
end

function map_resetroom(x, y)
	-- Reset one room on the map, and marks it as dirty.
	rooms_map[y] = rooms_map[y] or {}
	rooms_map[y][x] = rooms_map[y][x] or {}

	if rooms_map[y][x].done ~= nil and not rooms_map[y][x].done and rooms_map[y][x].map == nil then
		-- We've already reset this, so don't do it again
		return
	end

	rooms_map[y][x].done = false
	rooms_map[y][x].map = nil
	local n_dirty = #rooms_map_dirty_rooms
	if n_dirty == 0 or rooms_map_dirty_rooms[n_dirty][1] ~= x or rooms_map_dirty_rooms[n_dirty][2] ~= y then
		table.insert(rooms_map_dirty_rooms, {x, y})
		cons("Inserting map room! " .. x .. "," .. y)
	end
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
		--love.graphics.setColor(0,0,0,255)
		--love.graphics.rectangle("fill", 0, 0, 320, 240)
		love.graphics.setColor(255,255,255,255)
		displayroom(0, 0, roomdata_get(x, y), levelmetadata_get(x, y), 0.5)
		love.graphics.setCanvas()

		rooms_map[y][x].map = canvas
	end

	rooms_map[y][x].done = true
end

function map_export(x1, y1, w, h, resolution, transparentbg)
	-- Save an exported map, starting at x1,y1 (0-indexed), w rooms wide and h rooms high.
	-- Resolution can be -1 for "As shown (max 640x480)", or another number for the scale times 320x240.
	-- So for resolution 2, every room is displayed at 640x480.
	-- Assumes everything has been checked for validity before.

	local room_w, room_h, used_resolution

	if resolution == -1 then
		room_w, room_h = 640*mapscale, 480*mapscale
		used_resolution = mapscale*2
	else
		room_w, room_h = 320*resolution, 240*resolution
		used_resolution = resolution
	end
	local w_size, h_size = room_w*w, room_h*h

	-- Now create the canvas, which should be possible, but a crash may be luring...
	local status, err = pcall(function()
		local canvas
		if love.graphics.isSupported("npot") then
			-- Perfectly normal
			canvas = love.graphics.newCanvas(w_size, h_size)
		else
			-- Don't mind that empty filler, be glad that non-npot-compatible thing even works!
			canvas = love.graphics.newCanvas(
				math.pow(2, math.ceil(math.log(w_size)/math.log(2))),
				math.pow(2, math.ceil(math.log(h_size)/math.log(2)))
			)
		end

		love.graphics.setCanvas(canvas)
		clear_canvas(canvas)
		if not transparentbg then
			love.graphics.setColor(0,0,0,255)
			love.graphics.rectangle("fill", 0, 0, w_size, h_size)
		end
		love.graphics.setColor(255,255,255,255)
		love.graphics.setBlendMode("premultiplied")
		for yo = 0, h-1 do
			local mry = y1 + yo
			for xo = 0, w-1 do
				local mrx = x1 + xo
				if rooms_map[mry][mrx].map ~= nil then
					love.graphics.draw(rooms_map[mry][mrx].map, xo*room_w, yo*room_h, 0, used_resolution)
				end
			end
		end
		love.graphics.setBlendMode("alpha")
		love.graphics.setCanvas()

		local saveas = ((editingmap == "untitled\n" and "untitled" or editingmap) .. "_" .. os.time() .. ".png"):gsub(dirsep, "__")

		if love_version_meets(10) then
			canvas:newImageData():encode("png", "maps/" .. saveas)
		else
			canvas:getImageData():encode("maps/" .. saveas)
		end

		dialog.create(
			langkeys(L.MAPSAVEDAS, {saveas, love.filesystem.getSaveDirectory()}),
			{L.VIEWIMAGE, DB.OK},
			function(button)
				if button == L.VIEWIMAGE then
					love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. "/maps/" .. saveas)
				end
			end,
			nil, nil,
			function(button)
				if button == L.VIEWIMAGE then
					return true
				end
			end
		)

		collectgarbage("collect")
	end)

	if not status then
		dialog.create(
			L.MAPEXPORTERROR .. "\n\n"
			.. err .. "\n\n\n"
			.. renderer_info_string()
		)
	end
end

function fix_map_export_input(fields, output0)
	-- Expects fields as given in the export dialog
	-- Returns valid x1, y1, w, h, x2, y2 as far as possible.
	-- Fixes anything that can go wrong in user input: text, negative numbers, decimal point, out-of-range, ...

	-- co is the coordinates indexing, 1 or 0. Input and output will be using that, unless output0 is true,
	-- then the input will be using it but the output will always use 0-indexing.
	local co = not s.coords0 and 1 or 0 -- coordoffset

	-- We get the values from the fields, as numbers.
	local x1, y1, w, h, x2, y2 = tonumber(fields.x1), tonumber(fields.y1), tonumber(fields.w), tonumber(fields.h)

	-- Anything not a valid number? Also make it 0-indexed.
	if x1 == nil then x1 = 0 else x1 = x1-co end
	if y1 == nil then y1 = 0 else y1 = y1-co end
	if w == nil then w = 20 end
	if h == nil then h = 20 end

	-- Now that we have 0-indexed values, we can continue to do so if output0 is true.
	if output0 then co = 0 end

	-- Make sure we're not splitting rooms in parts, that'd suck.
	x1, y1, w, h = math.floor(x1), math.floor(y1), math.ceil(w), math.ceil(h)

	-- Make sure we're in bounds. First our x and y, those are simple, should be at least 0, and at most mapwidth-1/mapheight-1.
	x1, y1 = math.min(metadata.mapwidth-1, math.max(0, x1)), math.min(metadata.mapheight-1, math.max(0, y1))

	-- Width and height must also not be less than 1.
	w, h = math.max(1, w), math.max(1, h)

	-- Now make sure the map size isn't going off the map.
	if x1+w > metadata.mapwidth then
		w = metadata.mapwidth-x1
	end
	if y1+h > metadata.mapheight then
		h = metadata.mapheight-y1
	end

	return x1+co, y1+co, w, h, x1+w+co-1, y1+h+co-1
end

function create_export_dialog()
	if not love.graphics.isSupported("canvas") then
		dialog.create(L.GRAPHICSCARDCANVAS .. "\n\n\n\n\n" .. renderer_info_string())
		return
	end

	dialog.create(
		"",
		DBS.SAVECANCEL,
		dialog.callback.mapexport,
		L.SAVEMAP,
		dialog.form.exportmap_make(),
		dialog.callback.mapexport_validate,
		"mapexport"
	)
end

function locatetrinketscrewmates()
	map_trinkets, map_crewmates = {}, {}
	-- For each room in crewmates, we'll also store the color of each crewmate.

	-- Instantiation
	for mry = 0, metadata.mapheight-1 do
		map_trinkets[mry] = {}
		map_crewmates[mry] = {}
		for mrx = 0, metadata.mapwidth-1 do
			map_trinkets[mry][mrx] = 0
			map_crewmates[mry][mrx] = {0, {}}
		end
	end

	for _,ent in pairs(entitydata) do
		if ent.t == 9 or ent.t == 15 then
			local rx, ry = math.floor(ent.x/40), math.floor(ent.y/30)
			rx = math.max(rx, 0)
			ry = math.max(ry, 0)
			if rx < metadata.mapwidth and ry < metadata.mapheight then
				if ent.t == 9 then
					map_trinkets[ry][rx] = map_trinkets[ry][rx] + 1
				elseif ent.t == 15 then
					map_crewmates[ry][rx][1] = map_crewmates[ry][rx][1] + 1
					table.insert(map_crewmates[ry][rx][2], ent.p1)
				end
			end
		end
	end
end
