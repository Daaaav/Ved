function handle_tool_mousedown()
	-- Handles general clicking on the canvas in the main editor, including all the tools, and placing down moved entities.
	-- Excludes (right) clicking on entities, see handle_entity_mousedown() (entity_mousedown.lua) for that.

	if (love.mouse.isDown("l") or love.mouse.isDown("r")) and mouseon(screenoffset, 0, 639, 480)
	and (not keyboard_eitherIsDown("alt") or movingentity > 0 or selectedsubtool[14] >= 3)
	and not keyboard_eitherIsDown("shift") then
		editingroomname = false
		local atx, aty = maineditor_get_cursor()

		-- If we're holding both [ and ] down, then let the cursor move only in the plus-shape created by those two lines
		if mouselockx ~= -1 and mouselocky ~= -1 then
			if mouselockhorizontalline then
				aty = math.floor(love.mouse.getY() / 16)
			end

			if mouselockverticalline then
				atx = math.floor((love.mouse.getX()-screenoffset) / 16)
			end
		end

		-- Try to prevent entities of the same type from being placed on top of each other, because it can happen accidentally and go unnoticed. You can always place them on top of each other by editing their properties.
		local entityalreadyhere = false
		if love.mouse.isDown("l") and (selectedtool >= 4 or movingentity > 0) and editingbounds == 0 then
			for k,v in pairs(entitydata) do
				-- Exceptions related to whatever entity we're clicking on!
				if selectedtool == 13 and selectedsubtool[13] == 2 and (entitydata[editingsboxid] ~= nil) then
					-- We're trying to place a script box bottom right corner?
				elseif selectedtool == 13 and selectedsubtool[13] == 3 and k == editingsboxid then
					-- This is actually the script box we're editing at the moment, we might want to keep the top left...
				elseif v.x == 40*roomx + atx and v.y == 30*roomy + aty then
					if movingentity == k then
						-- Okay, we're moving an entity where it already is
					elseif movingentity > 0 and entitydata[movingentity] ~= nil and v.t == entitydata[movingentity].t then
						-- Moving an entity on top of another one, eh?
						mousepressed = true
					elseif selectedtool >= 4 and v.t == entitytooltoid[selectedtool] then
						-- Yep, "You are already checked in"
						mousepressed = true
						entityalreadyhere = true
					end
				end
			end
		end

		if s.psmallerscreen and (keyboard_eitherIsDown(ctrl) and not love.keyboard.isDown("lshift")) and love.mouse.getX() < 128 then
			-- Discard anything we're doing with the mouse in the room, we're now on the toolbar
		elseif tilespicker then
			-- The tiles picker page changes the Y position, of course
			local aty_paged = aty + tilespicker_page*30

			if levelmetadata_get(roomx, roomy).directmode == 1 then
				if selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and not mousepressed and customsizemode ~= 0 then
					-- You can also make a stamp from the tileset
					if customsizemode ~= 0 and customsizemode ~= 2 then
						customsizecoorx = atx
						customsizecoory = aty_paged
						customsizemode = 2
						mousepressed = true
					elseif customsizemode == 2 then
						atx = math.max(atx, customsizecoorx)
						aty_paged = math.max(aty_paged, customsizecoory)
						customsizex = (atx-customsizecoorx)/2
						customsizey = (aty_paged-customsizecoory)/2
						cons("sizex sizey " .. customsizex .. "," .. customsizey)
						customsizemode = 0
						customsizetile = {}
						for sty = customsizecoory, aty_paged do
							table.insert(customsizetile, {})
							for stx = customsizecoorx, atx do
								table.insert(customsizetile[#customsizetile], (sty*40)+stx)
							end
						end
						mousepressed = true
						nodialog = false
						tilespicker = false
					end
				elseif atx < tilesets[tileset_names[selectedtileset]].tiles_width_picker
				and aty_paged < tilesets[tileset_names[selectedtileset]].tiles_height_picker then
					local new_tile = (aty_paged*tilesets[tileset_names[selectedtileset]].tiles_width_picker)+(atx+1)-1
					if new_tile < tilesets[tileset_names[selectedtileset]].total_tiles then
						selectedtile = new_tile
					end
				end
			end
		elseif movingentity > 0 and entitydata[movingentity] ~= nil then
			if love.mouse.isDown("l") and not mousepressed
			-- Prevent warp lines' control points from being placed not on borders, in order to prevent confusion
			-- (you can always manually place their control points away from borders by manually editing the properties.
			-- It doesn't really do anything, though, their part of the border still warps)
			and (entitydata[movingentity].t ~= 50
			or (entitydata[movingentity].p1 == 0 and atx == 0)
			or (entitydata[movingentity].p1 == 1 and atx == 39)
			or (entitydata[movingentity].p1 == 2 and aty == 0)
			or (entitydata[movingentity].p1 == 3 and aty == 29)) then
				local old_roomx = math.floor(entitydata[movingentity].x/40)
				local old_roomy = math.floor(entitydata[movingentity].y/30)
				local new_x, new_y = 40*roomx + atx, 30*roomy + aty
				local new_p2 = entitydata[movingentity].p2
				if table.contains({11, 50}, entitydata[movingentity].t) then
					local use_x, use_y = false, false
					if entitydata[movingentity].t == 11 then
						if entitydata[movingentity].p1 <= 0 then
							use_x = true
						else
							use_y = true
						end
					elseif entitydata[movingentity].t == 50 then
						if table.contains({2, 3}, entitydata[movingentity].p1) then
							use_x = true
						elseif table.contains({0, 1}, entitydata[movingentity].p1) then
							use_y = true
						end
					end
					if use_x then
						local offset = entitydata[movingentity].p2 - entitydata[movingentity].x%40
						new_p2 = new_x%40 + offset
					elseif use_y then
						local offset = entitydata[movingentity].p2 - entitydata[movingentity].y%30
						new_p2 = new_y%30 + offset
					end
				end
				if not movingentity_copying then
					table.insert(
						undobuffer,
						{
							undotype = "changeentity",
							rx = roomx, ry = roomy, entid = movingentity,
							changedentitydata = {
								{
									key = "x",
									oldvalue = entitydata[movingentity].x,
									newvalue = new_x
								},
								{
									key = "y",
									oldvalue = entitydata[movingentity].y,
									newvalue = new_y
								},
								{
									key = "p2",
									oldvalue = entitydata[movingentity].p2,
									newvalue = new_p2
								}
							}
						}
					)
					finish_undo("CHANGED ENTITY (X AND Y)")
				end
				entitydata[movingentity].x = new_x
				entitydata[movingentity].y = new_y
				entitydata[movingentity].p2 = new_p2
				if movingentity_copying then
					entityplaced(movingentity)
				end
				movingentity = 0
				movingentity_copying = false
				nodialog = false
			else
				mousepressed = true
			end
		elseif selectedtool <= 3 then
			if not (eraserlocked and love.mouse.isDown("r")) then
				if undosaved == 0 then
					table.insert(undobuffer, {undotype = "tiles", rx = roomx, ry = roomy, toundotiles = table.copy(roomdata_get(roomx, roomy)), toredotiles = {}})
					undosaved = #undobuffer
					finish_undo("SAVED BEGIN RESULT FOR UNDO")
				end

				if selectedtool <= 2 then
					if love.mouse.isDown("r") then
						useselectedtile = 0
					else
						if levelmetadata_get(roomx, roomy).directmode == 0 then
							-- Auto mode
							useselectedtile = selectedtool

							-- Tower doesn't have 1 as a solid tile
							if levelmetadata_get(roomx, roomy).tileset == 5 and useselectedtile == 1 then
								useselectedtile = 12
							end
						else
							useselectedtile = selectedtile
						end
					end

					if selectedsubtool[selectedtool] == 1 then
						-- 1x1
						roomdata_set(roomx, roomy, atx, aty, useselectedtile)
					elseif selectedsubtool[selectedtool] == 2 then
						-- 3x3
						for sty = (aty-1), (aty+1) do
							for stx = (atx-1), (atx+1) do
								--if roomdata[roomy][roomx][(sty*40)+(stx+1)] ~= nil then
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 3 then
						-- 5x5
						for sty = (aty-2), (aty+2) do
							for stx = (atx-2), (atx+2) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 4 then
						-- 7x7
						for sty = (aty-3), (aty+3) do
							for stx = (atx-3), (atx+3) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 5 then
						-- 9x9
						for sty = (aty-4), (aty+4) do
							for stx = (atx-4), (atx+4) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 6 then
						-- horizontal fill
						if minsmear == -1 and maxsmear == -1 then
							minsmear = aty; maxsmear = aty
							for stx = 0, 39 do
								roomdata_set(roomx, roomy, stx, aty, useselectedtile)
							end
						end

						if aty < minsmear or aty > maxsmear then
							for sty = math.min(aty, minsmear), math.max(aty, maxsmear) do
								for stx = 0, 39 do
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end

						if aty < minsmear then
							minsmear = aty
						elseif aty > maxsmear then
							maxsmear = aty
						end
					elseif selectedsubtool[selectedtool] == 7 then
						-- vertical fill
						if minsmear == -1 and maxsmear == -1 then
							minsmear = atx; maxsmear = atx
							for sty = 0, 29 do
								roomdata_set(roomx, roomy, atx, sty, useselectedtile)
							end
						end

						if atx < minsmear or atx > maxsmear then
							for stx = math.min(atx, minsmear), math.max(atx, maxsmear) do
								for sty = 0, 29 do
									roomdata_set(roomx, roomy, stx, sty, useselectedtile)
								end
							end
						end

						if atx < minsmear then
							minsmear = atx
						elseif atx > maxsmear then
							maxsmear = atx
						end
					elseif not mousepressed_custombrush and selectedsubtool[selectedtool] == 8 then
						-- custom size
						if customsizemode == 0 then
							local iy = 1
							for sty = (aty-math.floor(customsizey)), (aty+math.ceil(customsizey)) do
								local ix = 1
								for stx = (atx-math.floor(customsizex)), (atx+math.ceil(customsizex)) do
									if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
										if customsizetile ~= nil and customsizetile[iy][ix] ~= 0 and not love.mouse.isDown("r") then
											-- Stamp
											roomdata_set(roomx, roomy, stx, sty, customsizetile[iy][ix])
										elseif not (customsizetile ~= nil and customsizetile[iy][ix] == 0) then -- We don't want this when this tile in a stamp is 0!
											roomdata_set(roomx, roomy, stx, sty, useselectedtile)
										end
									end
									ix = ix + 1
								end
								iy = iy + 1
							end
						elseif customsizemode <= 2 then -- Either 1 or 2 is fine, if we're at 2 and we closed the tiles picker then we'll just consider it 1
							customsizex = (atx)/2
							customsizey = (29-aty)/2
							customsizemode = 0
							customsizetile = nil
							mousepressed_custombrush = true
						elseif customsizemode == 3 then
							customsizecoorx = atx
							customsizecoory = aty
							customsizemode = 4
							mousepressed_custombrush = true
						elseif customsizemode == 4 then
							atx = math.max(atx, customsizecoorx)
							aty = math.max(aty, customsizecoory)
							customsizex = (atx-customsizecoorx)/2
							customsizey = (aty-customsizecoory)/2
							customsizemode = 0
							customsizetile = {}
							local foundnonzero = false
							for sty = customsizecoory, aty do
								table.insert(customsizetile, {})
								for stx = customsizecoorx, atx do
									local tnum = roomdata_get(roomx, roomy, stx, sty)
									table.insert(customsizetile[#customsizetile], tnum)
									if tnum ~= 0 then
										foundnonzero = true
									end
								end
							end
							if not foundnonzero then
								-- Ok, we don't need a useless brush.
								customsizetile = nil
							end

							mousepressed_custombrush = true
							cons("That is " .. (atx-customsizecoorx) .. " by " .. (aty-customsizecoory) .. " starting at " .. customsizecoorx .. "," .. customsizecoory)
						end
					elseif selectedsubtool[selectedtool] == 9 then
						-- Fill bucket
						-- What "color" is the tile we're clicking on?
						local oldtile = roomdata_get(roomx, roomy, atx, aty)
						roomdata_set(roomx, roomy, atx, aty, useselectedtile)

						-- It's only useful to fill if we're not filling an area with exactly the same tile.
						if oldtile ~= useselectedtile then
							-- Start a list of tiles
							local tilesarea, i = {{atx, aty}}, 1

							while tilesarea[i] ~= nil and i < 1200 do
								local f_x, f_y = unpack(tilesarea[i])
								for _,dir in pairs({{-1,0}, {0,-1}, {1,0}, {0,1}}) do
									if  f_x+dir[1] >= 0 and f_x+dir[1] <= 39
									and f_y+dir[2] >= 0 and f_y+dir[2] <= 29
									and roomdata_get(roomx, roomy, f_x+dir[1], f_y+dir[2]) == oldtile then
										roomdata_set(roomx, roomy, f_x+dir[1], f_y+dir[2], useselectedtile)

										table.insert(tilesarea, {f_x+dir[1], f_y+dir[2]})
									end
								end

								i = i + 1
							end
						end
					elseif selectedsubtool[selectedtool] == 10 then
						-- to out
						-- rot

						for rot = 0, anythingbutnil0(toout)-1 do
							local tooutnow = toout - rot
							roomdata_set(roomx, roomy, atx+rot, aty-tooutnow, useselectedtile) -- top to right
							roomdata_set(roomx, roomy, atx+tooutnow, aty+rot, useselectedtile) -- right to bottom
							roomdata_set(roomx, roomy, atx-rot, aty+tooutnow, useselectedtile) -- bottom to left
							roomdata_set(roomx, roomy, atx-tooutnow, aty-rot, useselectedtile) -- left to top
						end

						toout = anythingbutnil0(toout) + 1
					end
				else
					if love.mouse.isDown("r") then
						useselectedtile = 0
					else
						if levelmetadata_get(roomx, roomy).directmode == 0 then
							-- Auto mode
							useselectedtile = tilesetblocks[selectedtileset].colors[selectedcolor].spikes[9]
						else
							useselectedtile = selectedtile
						end
					end

					-- No comment.
					if selectedsubtool[3] > 1 then
						doorroomx = roomx
						doorroomy = roomy
					end

					if selectedsubtool[3] == 1 then
						-- 1 spike
						roomdata_set(roomx, roomy, atx, aty, useselectedtile)
					elseif selectedsubtool[3] == 2 then
						-- <-->
						if issolidmultispikes(adjtile(atx, aty, 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_floor_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_ceiling_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_leftwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_rightwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_rightwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
						else
							-- No solid blocks directly surrounding this spike

						end
					elseif selectedsubtool[3] == 3 then
						-- <--
						if issolidmultispikes(adjtile(atx, aty, 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_rightwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						else
							-- No solid blocks directly surrounding this spike

						end
					elseif selectedsubtool[3] == 4 then
						-- -->
						if issolidmultispikes(adjtile(atx, aty, 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile(atx, aty, 1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_rightwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
						else
							-- No solid blocks directly surrounding this spike

						end
					end
				end

				autocorrectroom()

				-- Make sure warp lines and gravity lines are not floating or inside of new walls.
				autocorrectlines()
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and (not mousepressed or (love.keyboard.isDown("v") and not entityalreadyhere)) and selectedtool == 4 then
			-- Trinket
			if count.trinkets >= limit.trinkets then
				dialog.create(langkeys(L.MAXTRINKETS, {limit.trinkets}))
			else
				insert_entity(atx, aty, 9)
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 5 then
			-- Checkpoint
			if selectedsubtool[5] == 1 then
				-- Upright
				insert_entity(atx, aty, 10, 1)
			elseif selectedsubtool[5] == 2 then
				-- Upside down
				insert_entity(atx, aty, 10, 0)
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 6 then
			-- Disappearing platform
			insert_entity(atx, aty, 3)
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 7 then
			-- Conveyor
			insert_entity(atx, aty, 2, 4+selectedsubtool[7])
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 8 then
			-- Moving platform
			if editingbounds == -2 then
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					oldbounds[k] = levelmetadata_get(roomx, roomy)["plat" .. v]
				end

				levelmetadata_set(roomx, roomy, "platx1", atx*8)
				levelmetadata_set(roomx, roomy, "platy1", aty*8)
				levelmetadata_set(roomx, roomy, "platx2", 320)
				levelmetadata_set(roomx, roomy, "platy2", 240)
				editingbounds = 2
			elseif editingbounds == 2 then
				levelmetadata_set(roomx, roomy, "platx2", atx*8+8)
				levelmetadata_set(roomx, roomy, "platy2", aty*8+8)
				editingbounds = 0

				local changeddata = {}
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					table.insert(changeddata,
						{
							key = "plat" .. v,
							oldvalue = oldbounds[k],
							newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
						}
					)
				end
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
				finish_undo("PLATFORM BOUNDS")
			else
				insert_entity(atx, aty, 2, -1+selectedsubtool[8])
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 9 then
			-- Enemy
			if editingbounds == -1 then
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					oldbounds[k] = levelmetadata_get(roomx, roomy)["enemy" .. v]
				end

				levelmetadata_set(roomx, roomy, "enemyx1", atx*8)
				levelmetadata_set(roomx, roomy, "enemyy1", aty*8)
				levelmetadata_set(roomx, roomy, "enemyx2", 320)
				levelmetadata_set(roomx, roomy, "enemyy2", 240)
				editingbounds = 1
			elseif editingbounds == 1 then
				levelmetadata_set(roomx, roomy, "enemyx2", atx*8+8)
				levelmetadata_set(roomx, roomy, "enemyy2", aty*8+8)
				editingbounds = 0

				local changeddata = {}
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					table.insert(changeddata,
						{
							key = "enemy" .. v,
							oldvalue = oldbounds[k],
							newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
						}
					)
				end
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
				finish_undo("ENEMY BOUNDS")
			else
				insert_entity(atx, aty, 1, -1+selectedsubtool[9])
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 10 then
			-- Gravity line
			if not issolid(roomdata_get(roomx, roomy, atx, aty), usedtilesets[levelmetadata_get(roomx, roomy).tileset], true, true) then
				local p1, p2
				if selectedsubtool[10] == 1 then
					-- Horizontal
					p1, p2 = 0, atx
				else
					-- Vertical
					p1, p2 = 1, aty
				end

				insert_entity(atx, aty, 11, p1, p2, 8)
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 11 then
			-- Roomtext
			if editingroomtext > 0 then
				-- We were already typing a text!
				endeditingroomtext()
			end

			insert_entity(atx, aty, 17)
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 12 then
			-- Terminal
			if editingroomtext > 0 then
				-- We were already typing a text!
				endeditingroomtext()
			end

			if selectedsubtool[12] == 2 then
				-- Upside down
				insert_entity(atx, aty, 18, 1)
			else
				insert_entity(atx, aty, 18)
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 13 then
			-- Script box
			-- Subtool is changed in the background
			if selectedsubtool[13] == 1 then
				-- Placing top left corner. Refactoring multi-step entities is definitely on my todo list.
				insert_entity(atx, aty, 19)
			elseif selectedsubtool[13] == 2 and (entitydata[editingsboxid] ~= nil) then
				-- Placing bottom right corner
				local new_p1 = math.max((40*roomx + atx) - entitydata[editingsboxid].x + 1, 1)
				local new_p2 = math.max((30*roomy + aty) - entitydata[editingsboxid].y + 1, 1)
				entitydata[editingsboxid].p1 = new_p1
				entitydata[editingsboxid].p2 = new_p2

				if not sboxdontaskname then
					editingroomtext = editingsboxid
					newroomtext = true
					makescriptroomtext = true
					startinput()
				else
					-- Register entity change for undo/redo
					table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = editingsboxid, changedentitydata = {
								{
									key = "x",
									oldvalue = oldscriptx,
									newvalue = entitydata[editingsboxid].x
								},
								{
									key = "y",
									oldvalue = oldscripty,
									newvalue = entitydata[editingsboxid].y
								},
								{
									key = "p1",
									oldvalue = oldscriptp1,
									newvalue = new_p1
								},
								{
									key = "p2",
									oldvalue = oldscriptp2,
									newvalue = new_p2
								}
							}
						}
					)
					finish_undo("MOVED SCRIPT BOX")
				end

				editingsboxid = nil
				selectedsubtool[13] = 1

				sboxdontaskname = nil
			elseif selectedsubtool[13] == 3 and (entitydata[editingsboxid] ~= nil) then
				-- We were editing this box
				oldscriptx, oldscripty = entitydata[editingsboxid].x, entitydata[editingsboxid].y
				oldscriptp1, oldscriptp2 = entitydata[editingsboxid].p1, entitydata[editingsboxid].p2
				entitydata[editingsboxid].x = 40*roomx + atx
				entitydata[editingsboxid].y = 30*roomy + aty
				entitydata[editingsboxid].p1 = 0
				entitydata[editingsboxid].p2 = 0

				selectedsubtool[13] = 2
				sboxdontaskname = true
			else
				cons("You tried placing the bottom right of a non-existant script box!")

				editingsboxid = nil
				selectedsubtool[13] = 1
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 14 then
			-- Warp token
			if selectedsubtool[14] == 1 or (selectedsubtool[14] == 2 and entitydata[warpid] == nil) then
				-- Placing entrance.
				insert_entity(atx, aty, 13)
			elseif selectedsubtool[14] == 2 or selectedsubtool[14] == 4 then
				-- Placing exit, or moving exit
				if entitydata[warpid] ~= nil then
					local new_p1 = 40*roomx + atx
					local new_p2 = 30*roomy + aty
					-- We're moving the exit, which is an entity change
					if selectedsubtool[14] == 4 then
						table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = warpid, changedentitydata = {
									{
										key = "p1",
										oldvalue = entitydata[warpid].p1,
										newvalue = new_p1
									},
									{
										key = "p2",
										oldvalue = entitydata[warpid].p2,
										newvalue = new_p2
									}
								}
							}
						)
						finish_undo("MOVED WARP EXIT")
					end
					entitydata[warpid].p1 = new_p1
					entitydata[warpid].p2 = new_p2

					-- We're not adding a new entity if we're moving it!
					if selectedsubtool[14] == 2 then
						entityplaced(warpid)
					else
						-- Don't ask, it's to make alt+clicking work well for warp tokens
						nodialog = false
					end
				else
					dialog.create(L.WARPTOKENENT404)
					mousepressed = true
				end
				warpid = nil
				selectedsubtool[14] = 1
			elseif selectedsubtool[14] == 3 and entitydata[warpid] ~= nil then
				-- Moving entrance
				if entitydata[warpid] ~= nil then
					local new_x = 40*roomx + atx
					local new_y = 30*roomy + aty

					table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = warpid, changedentitydata = {
								{
									key = "x",
									oldvalue = entitydata[warpid].x,
									newvalue = new_x
								},
								{
									key = "y",
									oldvalue = entitydata[warpid].y,
									newvalue = new_y
								}
							}
						}
					)
					finish_undo("MOVED WARP ENTRANCE")

					entitydata[warpid].x = new_x
					entitydata[warpid].y = new_y

					nodialog = false
				else
					dialog.create(L.WARPTOKENENT404)
					mousepressed = true
				end
				warpid = nil
				selectedsubtool[14] = 1
			else
				dialog.create(L.WHATDIDYOUDO .. "\n\n(warp token out of range subtool)")
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 15 then
			-- Warp line
			if not issolid(roomdata_get(roomx, roomy, atx, aty), usedtilesets[levelmetadata_get(roomx, roomy).tileset], true, true) then
				if atx == 0 or atx == 39 then
					-- Vertical left or right, type 0 or 1
					insert_entity(atx, aty, 50, (atx == 0 and 0 or 1), aty, 8)
				elseif aty == 0 or aty == 29 then
					-- Horizontal top or bottom, type 2 or 3
					insert_entity(atx, aty, 50, (aty == 0 and 2 or 3), atx, 8)
				end
				mousepressed = true
			end

		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 16 then
			-- Rescuable crewmate
			if count.crewmates >= limit.crewmates then
				dialog.create(langkeys(L.MAXCREWMATES, {limit.crewmates}))
				mousepressed = true
			else
				insert_entity(atx, aty, 15, ({1, 2, 3, 4, 5, 0, math.random(0,5)})[selectedsubtool[selectedtool]])
			end
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 17 then
			-- Start point
			cons("Start point: " .. atx .. " " .. aty)

			-- First remove the old one, but check first
			if (count.startpoint ~= nil) and ( (entitydata[count.startpoint] == nil) or (entitydata[count.startpoint].t ~= 16) ) then
				cons("Whoops, old start point not found! At least find out if even exists anywhere anymore (probably not)")

				local found = false

				for ke,ve in pairs(entitydata) do
					if ve.t == 16 then
						-- Found it!
						count.startpoint = ke
						found = true
						break
					end
				end

				if not found then
					-- Ok, then it's simply gone and we thought it isn't.
					count.startpoint = nil
				end
			end

			local x, y, p1 = 40*roomx + atx, 30*roomy + aty, selectedsubtool[17]-1

			if count.startpoint ~= nil then
				cons("Old start point at " .. entitydata[count.startpoint].x .. " " .. entitydata[count.startpoint].y .. " will be changed")

				table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = count.startpoint, changedentitydata = {
							{
								key = "x",
								oldvalue = entitydata[count.startpoint].x,
								newvalue = x,
							},
							{
								key = "y",
								oldvalue = entitydata[count.startpoint].y,
								newvalue = y,
							},
							{
								key = "p1",
								oldvalue = entitydata[count.startpoint].p1,
								newvalue = p1,
							}
						}
					}
				)
				finish_undo("CHANGED ENTITY (START POINT)")

				entitydata[count.startpoint].x = x
				entitydata[count.startpoint].y = y
				entitydata[count.startpoint].p1 = p1
			else
				cons("Inserting new start point")
				insert_entity(atx, aty, 16, p1)
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed then
			dialog.create(L.UNSUPPORTEDTOOL .. anythingbutnil(selectedtool))
			mousepressed = true
		end
	elseif love.mouse.isDown("m") and mouseon(screenoffset, 0, 639, 480) and selectedtool <= 3 and not tilespicker and levelmetadata_get(roomx, roomy).directmode == 1 then
		editingroomname = false
		local atx, aty = maineditor_get_cursor()

		selectedtile = roomdata_get(roomx, roomy, atx, aty)
	end
end
