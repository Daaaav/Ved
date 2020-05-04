function drawmaineditor()
	love.graphics.setColor(128,128,128)
	love.graphics.rectangle("line", screenoffset-0.5, -0.5, 640+1, 480+1)
	love.graphics.setColor(255,255,255)
	local function getcursor()
		return math.floor((getlockablemouseX()-screenoffset) / 16), math.floor(getlockablemouseY() / 16)
	end
	-- Are we clicking?
	if nodialog and (love.mouse.isDown("l") or love.mouse.isDown("r")) and mouseon(screenoffset, 0, 639, 480)
	and (not keyboard_eitherIsDown("alt") or movingentity > 0 or selectedsubtool[14] >= 3) then
		editingroomname = false
		local atx, aty = getcursor()

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
			if true and tilescreator then
				-- This is the one where you have to click 30 tiles individually.
				local tsw = tilesets[tilesetnames[usedtilesets.creator]].tileswidth
				if not mousepressed then
					if creatorstep == 1 then
						cons("Wall tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						tilesetblocks.creator.colors.creator.blocks[creatorsubstep] = (aty*tsw)+atx
						cb[creatorsubstep] = (aty*tsw)+atx
					elseif creatorstep == 2 then
						cons("Background tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						tilesetblocks.creator.colors.creator.background[creatorsubstep] = (aty*tsw)+atx
						ca[creatorsubstep] = (aty*tsw)+atx
					elseif creatorstep == 3 then
						cons("Spike tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						tilesetblocks.creator.colors.creator.spikes[creatorsubstep] = (aty*tsw)+atx
						cs[creatorsubstep] = (aty*tsw)+atx
					end

					if creatorsubstep == 30 then
						creatorstep = creatorstep + 1
						cons("Next: step " .. creatorstep)
						selectedtool = creatorstep

						creatorsubstep = 1
					else
						creatorsubstep = creatorsubstep + 1
					end

					if creatorstep == 4 then
						spitoutarrays()
						cons("*** ARRAYS COPIED TO CLIPBOARD ***")
						tilescreator = false
					end

					mousepressed = true
				end
			elseif tilescreator then
				-- Faster one.
				local tsw = tilesets[tilesetnames[usedtilesets.creator]].tileswidth
				if not mousepressed then
					if creatorstep == 1 then
						cons("Wall tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						--tilesetblocks.creator.colors.creator.blocks[creatorsubstep] = (aty*tsw)+atx

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*tsw)+atx == 0 then
									cb[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									cb[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
								end
							end
						end
					elseif creatorstep == 2 then
						cons("Background tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						--tilesetblocks.creator.colors.creator.background[creatorsubstep] = (aty*tsw)+atx

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*tsw)+atx == 0 then
									ca[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									ca[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
								end
							end
						end
					elseif creatorstep == 3 then
						cons("Spike tile " .. creatorsubstep .. ": " .. (aty*tsw)+atx)

						--tilesetblocks.creator.colors.creator.spikes[creatorsubstep] = (aty*tsw)+atx

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*tsw)+atx == 0 then
									cs[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									cs[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*tsw)+atx + (tsw*yplus) + xplus
								end
							end
						end
					end

					if creatorsubstep == 4 then
						creatorstep = creatorstep + 1
						cons("Next: step " .. creatorstep)
						selectedtool = creatorstep

						creatorsubstep = 1
					else
						creatorsubstep = creatorsubstep + 3
					end

					if creatorstep == 4 then
						spitoutarrays()
						cons("*** ARRAYS COPIED TO CLIPBOARD ***")
						tilescreator = false
					end

					mousepressed = true
				end

			elseif levelmetadata_get(roomx, roomy).directmode == 1 then
				if selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and not mousepressed and customsizemode ~= 0 then
					-- You can also make a stamp from the tileset
					if customsizemode ~= 0 and customsizemode ~= 2 then
						customsizecoorx = atx
						customsizecoory = aty
						customsizemode = 2
						mousepressed = true
					elseif customsizemode == 2 then
						atx = math.max(atx, customsizecoorx)
						aty = math.max(aty, customsizecoory)
						customsizex = (atx-customsizecoorx)/2
						customsizey = (aty-customsizecoory)/2
						cons("sizex sizey " .. customsizex .. "," .. customsizey)
						customsizemode = 0
						customsizetile = {}
						for sty = customsizecoory, aty do
							table.insert(customsizetile, {})
							for stx = customsizecoorx, atx do
								table.insert(customsizetile[#customsizetile], (sty*40)+stx)
							end
						end
						mousepressed = true
						nodialog = false
						tilespicker = false
					end
				elseif atx < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth
				and aty < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tilesheight then
					selectedtile = (aty*tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth)+(atx+1)-1
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
				elseif entitydata[movingentity].t == 14 then
					if not movingentity_copying then
						update_vce_teleporters_remove(old_roomx, old_roomy)
					end
					update_vce_teleporters_insert(roomx, roomy)
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
					table.insert(undobuffer, {undotype = "tiles", rx = roomx, ry = roomy, toundotiles = table.copy(roomdata_get(roomx, roomy, altstate)), toredotiles = {}, altstate=altstate})
					undosaved = #undobuffer
					finish_undo("SAVED BEGIN RESULT FOR UNDO")
				end

				if selectedtool <= 2 then
					--cons("Tile clicked: " .. atx .. " " .. aty .. ", set to " .. selectedtile .. ", subtool " .. selectedsubtool[selectedtool])

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
						roomdata_set(roomx, roomy, altstate, atx, aty, useselectedtile)
					elseif selectedsubtool[selectedtool] == 2 then
						-- 3x3
						for sty = (aty-1), (aty+1) do
							for stx = (atx-1), (atx+1) do
								--if roomdata[roomy][roomx][(sty*40)+(stx+1)] ~= nil then
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 3 then
						-- 5x5
						for sty = (aty-2), (aty+2) do
							for stx = (atx-2), (atx+2) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 4 then
						-- 7x7
						for sty = (aty-3), (aty+3) do
							for stx = (atx-3), (atx+3) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 5 then
						-- 9x9
						for sty = (aty-4), (aty+4) do
							for stx = (atx-4), (atx+4) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 6 then
						-- horizontal fill
						if minsmear == -1 and maxsmear == -1 then
							minsmear = aty; maxsmear = aty
							for stx = 0, 39 do
								roomdata_set(roomx, roomy, altstate, stx, aty, useselectedtile)
							end
						end

						if aty < minsmear or aty > maxsmear then
							for sty = math.min(aty, minsmear), math.max(aty, maxsmear) do
								for stx = 0, 39 do
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
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
								roomdata_set(roomx, roomy, altstate, atx, sty, useselectedtile)
							end
						end

						if atx < minsmear or atx > maxsmear then
							for stx = math.min(atx, minsmear), math.max(atx, maxsmear) do
								for sty = 0, 29 do
									roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
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
											roomdata_set(roomx, roomy, altstate, stx, sty, customsizetile[iy][ix])
										elseif not (customsizetile ~= nil and customsizetile[iy][ix] == 0) then -- We don't want this when this tile in a stamp is 0!
											roomdata_set(roomx, roomy, altstate, stx, sty, useselectedtile)
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
									local tnum = roomdata_get(roomx, roomy, altstate, stx, sty)
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
						local oldtile = roomdata_get(roomx, roomy, altstate, atx, aty)
						roomdata_set(roomx, roomy, altstate, atx, aty, useselectedtile)

						-- It's only useful to fill if we're not filling an area with exactly the same tile.
						if oldtile ~= useselectedtile then
							-- Start a list of tiles
							local tilesarea, i = {{atx, aty}}, 1

							while tilesarea[i] ~= nil and i < 1200 do
								local f_x, f_y = unpack(tilesarea[i])
								for _,dir in pairs({{-1,0}, {0,-1}, {1,0}, {0,1}}) do
									if  f_x+dir[1] >= 0 and f_x+dir[1] <= 39
									and f_y+dir[2] >= 0 and f_y+dir[2] <= 29
									and roomdata_get(roomx, roomy, altstate, f_x+dir[1], f_y+dir[2]) == oldtile then
										roomdata_set(roomx, roomy, altstate, f_x+dir[1], f_y+dir[2], useselectedtile)

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
							roomdata_set(roomx, roomy, altstate, atx+rot, aty-tooutnow, useselectedtile) -- top to right
							roomdata_set(roomx, roomy, altstate, atx+tooutnow, aty+rot, useselectedtile) -- right to bottom
							roomdata_set(roomx, roomy, altstate, atx-rot, aty+tooutnow, useselectedtile) -- bottom to left
							roomdata_set(roomx, roomy, altstate, atx-tooutnow, aty-rot, useselectedtile) -- left to top
						end

						toout = anythingbutnil0(toout) + 1
					end
				else
					--cons("Tile clicked spike: " .. atx .. " " .. aty .. ", set to " .. selectedtile .. ", subtool " .. selectedsubtool[3])

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
						roomdata_set(roomx, roomy, altstate, atx, aty, useselectedtile)
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
			if not issolid(roomdata_get(roomx, roomy, altstate, atx, aty), usedtilesets[levelmetadata_get(roomx, roomy).tileset], true, true) then
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

			insert_entity(atx, aty, 18)
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
			if not issolid(roomdata_get(roomx, roomy, altstate, atx, aty), usedtilesets[levelmetadata_get(roomx, roomy).tileset], true, true) then
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
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 17 and altstate == 0 then
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
        elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 18 and metadata.target == "VCE" then
			-- Flip tokens
			insert_entity(atx, aty, 5, 181)
			mousepressed = true
        elseif love.mouse.isDown("l") and selectedtool == 19 and metadata.target == "VCE" then
			-- Coins
			local found = false
			for ke,ve in pairs(entitydata) do
				if ve.x == (atx + 40 * roomx) and ve.y == (aty + 30 * roomy) then
					-- We found one, whoops
					found = true
					break
				end
			end
			if not found then
				insert_entity(atx, aty, 8, selectedsubtool[19]-1)
			end
        elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 20 and metadata.target == "VCE" then
			-- Teleporters
			insert_entity(atx, aty, 14)
			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed then
			dialog.create(L.UNSUPPORTEDTOOL .. anythingbutnil(selectedtool))
			mousepressed = true
		end
	elseif nodialog and love.mouse.isDown("m") and mouseon(screenoffset, 0, 639, 480) and tilespicker and not tilescreator and levelmetadata_get(roomx, roomy).directmode == 1 then
		local atx, aty = getcursor()

		if atx < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth
		and aty < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tilesheight then
			selectedtile = (aty*tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth)+atx
		end
	elseif nodialog and love.mouse.isDown("m") and mouseon(screenoffset, 0, 639, 480) and selectedtool <= 3 and levelmetadata_get(roomx, roomy).directmode == 1 then
		editingroomname = false
		local atx, aty = getcursor()

		selectedtile = roomdata_get(roomx, roomy, altstate, atx, aty)
	end

	if tilespicker then
		local displaytilenumbers, displaysolid
		if nodialog and editingroomtext == 0 and not editingroomname then
			if love.keyboard.isDown("n") then
				ved_setFont(tinynumbers)
				displaytilenumbers = true
			end
			if love.keyboard.isDown("j") then
				displaysolid = true
			end
		end

		local ts_name = tilesetnames[usedtilesets[levelmetadata_get(roomx, roomy).tileset]]

		displaytilespicker(screenoffset, 0, ts_name, displaytilenumbers, displaysolid)
	else
		-- If we have gravity lines and such, make sure they don't go offscreen
		love.graphics.setScissor(screenoffset, 0, 640, 480)
		-- If we have room warping, then display that!
		if levelmetadata_get(roomx, roomy).warpdir == 1 or levelmetadata_get(roomx, roomy).warpdir == 2 then
			-- Horizontal/vertical warp direction.

			local tils = levelmetadata_get(roomx, roomy).tileset
			local tilc = levelmetadata_get(roomx, roomy).tilecol

			if levelmetadata_get(roomx, roomy).warpdir == 1 then
				love.graphics.draw(
					warpbgs[tilesetblocks[tils].colors[tilc].warpbg][1],
					screenoffset + (32-warpbganimation), 0
				)
			elseif levelmetadata_get(roomx, roomy).warpdir == 2 then
				love.graphics.draw(
					warpbgs[tilesetblocks[tils].colors[tilc].warpbg][2],
					screenoffset, 32-warpbganimation
				)
			end

			love.graphics.setColor(255,255,255,92)
		elseif levelmetadata_get(roomx, roomy).warpdir == 3 then
			-- Warping in all directions.

			local tils = levelmetadata_get(roomx, roomy).tileset
			local tilc = levelmetadata_get(roomx, roomy).tilecol

			for squarel = 11, 0, -1 do
				-- Centerx: 128+320 = 448
				local side = (squarel-1)*64 + (warpbganimation*2)

				if squarel % 2 == 0 then
					love.graphics.setColor(warpbgcolors[tilesetblocks[tils].colors[tilc].warpbg][2])
				else
					love.graphics.setColor(warpbgcolors[tilesetblocks[tils].colors[tilc].warpbg][1])
				end

				if side >= 0 then
					love.graphics.rectangle("fill", screenoffset+(320-(side/2)), 240-(side/2), side, side)
				end
			end

			love.graphics.setColor(255,255,255,92)
		end

		love.graphics.draw(bggrid, screenoffset, 0)

		love.graphics.setColor(255,255,255,255)


		local displaytilenumbers, displaysolid, displayminimapgrid
		if nodialog and editingroomtext == 0 and not editingroomname and not keyboard_eitherIsDown(ctrl) then
			if love.keyboard.isDown("n") then
				ved_setFont(tinynumbers)
				displaytilenumbers = true
			end
			if love.keyboard.isDown("j") then
				displaysolid = true
			end
			if love.keyboard.isDown(";") and not keyboard_eitherIsDown("shift") then
				displayminimapgrid = true
			end
		end
		if roomx >= limit.mapwidth or roomy >= limit.mapheight then
			displayminimapgrid = false
		end
		-- Display the room now including its entities
		local showroom = not (love.keyboard.isDown("k") or (love.keyboard.isDown(";") and keyboard_eitherIsDown("shift"))) or love.mouse.isDown("l") or love.mouse.isDown("m") or love.mouse.isDown("r") or not nodialog or RCMactive or editingroomtext > 0 or editingroomname
		if showroom then
			displayroom(screenoffset, 0, roomdata_get(roomx, roomy, altstate), levelmetadata_get(roomx, roomy), nil, displaytilenumbers, displaysolid, displayminimapgrid)
		elseif love.keyboard.isDown("k") then
			show_notification(L.OLDSHORTCUT_SHOWBG)
		end

		-- Display indicators for tiles in adjacent rooms
		if s.adjacentroomlines then
			local roomupW, roomleftW, roomrightW, roomdownW = false, false, false, false
			local roomup, roomleft, roomright, roomdown

			-- Make sure there are no warp lines in the room. If there are, then the background doesn't apply
			local warplines = warplinesinroom(roomx, roomy)

			-- Room up. I now notice the bug in the code for switching rooms but it works 100% which is kind of unique to have
			if (levelmetadata_get(roomx, roomy).warpdir == 2 or levelmetadata_get(roomx, roomy).warpdir == 3) and not warplines then
				-- Use this room because it warps.
				roomup = roomy
				roomupW = true
			else
				if roomy+1 <= 1 then
					roomup = metadata.mapheight-1
				else
					roomup = roomy - 1
				end
			end
			-- Room left
			if (levelmetadata_get(roomx, roomy).warpdir == 1 or levelmetadata_get(roomx, roomy).warpdir == 3) and not warplines then
				-- Use this room because it warps.
				roomleft = roomx
				roomleftW = true
			else
				if roomx+1 <= 1 then
					roomleft = metadata.mapwidth-1
				else
					roomleft = roomx - 1
				end
			end
			-- Room right
			if (levelmetadata_get(roomx, roomy).warpdir == 1 or levelmetadata_get(roomx, roomy).warpdir == 3) and not warplines then
				-- Use this room because it warps.
				roomright = roomx
				roomrightW = true
			else
				if roomx+1 >= metadata.mapwidth then
					roomright = 0
				else
					roomright = roomx + 1
				end
			end
			-- Room down
			if (levelmetadata_get(roomx, roomy).warpdir == 2 or levelmetadata_get(roomx, roomy).warpdir == 3) and not warplines then
				-- Use this room because it warps.
				roomdown = roomy
				roomdownW = true
			else
				if roomy+1 >= metadata.mapheight then
					roomdown = 0
				else
					roomdown = roomy + 1
				end
			end

			-- Up
			for t = 0, 39 do
				-- Wall
				if issolid(roomdata_get(roomx, roomup, altstate, t, 29), usedtilesets[levelmetadata_get(roomx, roomup).tileset]) then
					if roomupW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.rectangle("fill", screenoffset+(t*16), 0, 16, 2)

					if roomupW then
						love.graphics.setColor(255, 255, 255)
					end
				elseif not roomupW and ( (levelmetadata_get(roomx, roomup).warpdir == 2) or (levelmetadata_get(roomx, roomup).warpdir == 3) ) and not warplinesinroom(roomx, roomup) then
					love.graphics.rectangle("fill", screenoffset+(t*16), 0, 16, 1)
				end

				-- Spikes
				if issolid(roomdata_get(roomx, roomup, altstate, t, 29), usedtilesets[levelmetadata_get(roomx, roomup).tileset], false) ~= issolid(roomdata_get(roomx, roomup, altstate, t, 29), usedtilesets[levelmetadata_get(roomx, roomup).tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomupW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.rectangle("fill", screenoffset+(t*16), 0, 16, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Left
			for t = 0, 29 do
				-- Wall
				if issolid(roomdata_get(roomleft, roomy, altstate, 39, t), usedtilesets[levelmetadata_get(roomleft, roomy).tileset]) then
					if roomleftW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.rectangle("fill", screenoffset, t*16, 2, 16)

					if roomleftW then
						love.graphics.setColor(255, 255, 255)
					end
				elseif not roomleftW and ( (levelmetadata_get(roomleft, roomy).warpdir == 1) or (levelmetadata_get(roomleft, roomy).warpdir == 3) ) and not warplinesinroom(roomleft, roomy) then
					love.graphics.rectangle("fill", screenoffset, t*16, 1, 16)
				end

				-- Spikes
				if issolid(roomdata_get(roomleft, roomy, altstate, 39, t), usedtilesets[levelmetadata_get(roomleft, roomy).tileset], false) ~= issolid(roomdata_get(roomleft, roomy, altstate, 39, t), usedtilesets[levelmetadata_get(roomleft, roomy).tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomleftW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.rectangle("fill", screenoffset, t*16, 2, 16)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Right
			for t = 0, 29 do
				-- Wall
				if issolid(roomdata_get(roomright, roomy, altstate, 0, t), usedtilesets[levelmetadata_get(roomright, roomy).tileset]) then

					if roomrightW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.rectangle("fill", screenoffset+(39*16)+16-2, t*16, 2, 16)

					if roomrightW then
						love.graphics.setColor(255, 255, 255)
					end

				elseif not roomrightW and ( (levelmetadata_get(roomright, roomy).warpdir == 1) or (levelmetadata_get(roomright, roomy).warpdir == 3) ) and not warplinesinroom(roomright, roomy) then
					love.graphics.rectangle("fill", screenoffset+(39*16)+16-1, t*16, 1, 16)
				end

				-- Spikes
				if issolid(roomdata_get(roomright, roomy, altstate, 0, t), usedtilesets[levelmetadata_get(roomright, roomy).tileset], false) ~= issolid(roomdata_get(roomright, roomy, altstate, 0, t), usedtilesets[levelmetadata_get(roomright, roomy).tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomrightW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.rectangle("fill", screenoffset+(39*16)+16-2, t*16, 2, 16)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Down
			for t = 0, 39 do
				-- Wall
				if issolid(roomdata_get(roomx, roomdown, altstate, t, 0), usedtilesets[levelmetadata_get(roomx, roomdown).tileset]) then

					if roomdownW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.rectangle("fill", screenoffset+(t*16), 29*16+16-2, 16, 2)

					if roomdownW then
						love.graphics.setColor(255, 255, 255)
					end

				elseif not roomdownW and ( (levelmetadata_get(roomx, roomdown).warpdir == 2) or (levelmetadata_get(roomx, roomdown).warpdir == 3) ) and not warplinesinroom(roomx, roomdown) then
					love.graphics.rectangle("fill", screenoffset+(t*16), 29*16+16-1, 16, 1)
				end

				-- Spikes
				if issolid(roomdata_get(roomx, roomdown, altstate, t, 0), usedtilesets[levelmetadata_get(roomx, roomdown).tileset], false) ~= issolid(roomdata_get(roomx, roomdown, altstate, t, 0), usedtilesets[levelmetadata_get(roomx, roomdown).tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomdownW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.rectangle("fill", screenoffset+(t*16), 29*16+16-2, 16, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
		end

		ved_setFont(font8)
		local hasroomname = levelmetadata_get(roomx, roomy).roomname:gsub(" ", "") ~= ""
		local overwritename = temporaryroomnametimer > 0 or editingbounds ~= 0 or editingcustomsize
		if showroom then
			displayentities(screenoffset, 0, roomx, roomy, altstate, overwritename or not hasroomname)
		end

		-- Now display bounds! Enemies first...
		if showepbounds or editingbounds ~= 0 then
			if not (levelmetadata_get(roomx, roomy).enemyx1 == 0 and levelmetadata_get(roomx, roomy).enemyy1 == 0 and levelmetadata_get(roomx, roomy).enemyx2 == 320 and levelmetadata_get(roomx, roomy).enemyy2 == 240) then
				love.graphics.setColor(255,0,0,255)
				love.graphics.rectangle("line",
					screenoffset+(levelmetadata_get(roomx, roomy).enemyx1*2),
					levelmetadata_get(roomx, roomy).enemyy1*2,
					((levelmetadata_get(roomx, roomy).enemyx2-levelmetadata_get(roomx, roomy).enemyx1)*2),
					(levelmetadata_get(roomx, roomy).enemyy2-levelmetadata_get(roomx, roomy).enemyy1)*2
				)
			end

			-- Then platforms.
			if not (levelmetadata_get(roomx, roomy).platx1 == 0 and levelmetadata_get(roomx, roomy).platy1 == 0 and levelmetadata_get(roomx, roomy).platx2 == 320 and levelmetadata_get(roomx, roomy).platy2 == 240) then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("line",
					screenoffset+(levelmetadata_get(roomx, roomy).platx1*2),
					levelmetadata_get(roomx, roomy).platy1*2,
					((levelmetadata_get(roomx, roomy).platx2-levelmetadata_get(roomx, roomy).platx1)*2),
					(levelmetadata_get(roomx, roomy).platy2-levelmetadata_get(roomx, roomy).platy1)*2
				)
			end
		end


		love.graphics.setColor(255,255,255,255)

		love.graphics.setScissor()

		local editingcustomsize = selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0

		-- Does this room have a name, perhaps?
		if temporaryroomnametimer > 0 or editingbounds ~= 0 or editingcustomsize then
			-- Oh wait, we're displaying a message as room name!
			if editingbounds < 0 then
				temporaryroomname = L.BOUNDSTOPLEFT
			elseif editingbounds > 0 then
				temporaryroomname = L.BOUNDSBOTTOMRIGHT
			elseif editingcustomsize then
				if customsizemode <= 2 then
					local dispx, dispy = "--", "--"
					if mouseon(screenoffset, 0, 639, 480) then
						dispx = math.floor((getlockablemouseX()-screenoffset) / 16) + 1
						dispy = 30-math.floor(getlockablemouseY() / 16)
					end
					temporaryroomname = langkeys(L.CUSTOMSIZE, {dispx, dispy})
				elseif customsizemode == 3 then
					temporaryroomname = L.SELECTINGA
				elseif customsizemode == 4 then
					local dispx, dispy = "--", "--"
					if mouseon(screenoffset, 0, 639, 480) then
						dispx = math.floor((getlockablemouseX()-screenoffset) / 16) - customsizecoorx + 1
						dispy = math.floor(getlockablemouseY() / 16) - customsizecoory + 1
					end
					temporaryroomname = langkeys(L.SELECTINGB, {dispx, dispy})
				end
			end

			-- Is the text we're displaying going to fit?
			local extralines = roomtext_extralines(temporaryroomname)

			love.graphics.setColor(160,160,0,128)
			love.graphics.rectangle("fill", screenoffset, 29*16 - extralines*16 - 4, 40*16, 16 + extralines*16 + 4)
			love.graphics.setColor(255,255,255,255)
			ved_printf(temporaryroomname, screenoffset, 29*16 - extralines*16 - 2, 40*16, "center", 2)
		elseif editingroomname then
			-- We're editing this room name! If it doesn't fit, then just make it higher, we're editing it anyway
			local text = input .. (__:sub(1,1) == "_" and __ or " " .. __:sub(2,-1))
			local extralines = roomtext_extralines(text)

			love.graphics.setColor(128,128,128,128)
			love.graphics.rectangle("fill", screenoffset, 29*16 - 4, 40*16, 16 + 4)
			if extralines > 0 then
				love.graphics.setColor(255,0,0,128)
				love.graphics.rectangle("fill", screenoffset, 29*16 - extralines*16 - 4, 40*16, extralines*16 + 1)
			end
			love.graphics.setColor(255,255,255,255)
			ved_printf(text, screenoffset, 29*16 - extralines*16 - 2, 40*16, "center", 2)
		elseif hasroomname then
			-- Display it
			local text = levelmetadata_get(roomx, roomy).roomname
			local textx = (screenoffset+320)-font8:getWidth(text) -- We want double font size, /2. So, width of regular font.

			love.graphics.setColor(0,0,0,s.opaqueroomnamebackground and 255 or 128)
			love.graphics.rectangle("fill", screenoffset, 29*16-4, 40*16, 16+4)
			love.graphics.setScissor(screenoffset, 29*16-2, 40*16, 16)
			v6_setroomprintcol()
			ved_print(text, textx, 29*16 -2, 2)
			love.graphics.setColor(255,255,255,255)
			love.graphics.setScissor()
		end

		-- Display the bottom 2 rows of roomtexts ABOVE the roomname
		if hasroomname and not overwritename then
			displaybottom2rowstexts(screenoffset, 0, roomx, roomy)
		end
	end

	-- Now display the cursor. If it's on the level
	if nodialog and mouseon(screenoffset, 0, 639, 480) then
		cursorx = math.floor((getlockablemouseX()-screenoffset) / 16)
		cursory = math.floor(getlockablemouseY() / 16)

		-- If we're holding [ and ] down, display the cursor inside the plus-shape created by those two lines
		if mouselockx ~= -1 and mouselocky ~= -1 then
			if math.floor((getlockablemouseX()-screenoffset) / 16) <= (love.mouse.getX()-screenoffset) / 16
			and (love.mouse.getX()-screenoffset) / 16 <= math.ceil((getlockablemouseX()-screenoffset) / 16) then
				mouselockhorizontalline = true
				mouselockverticalline = false
			end

			if math.floor(getlockablemouseY() / 16) <= love.mouse.getY() / 16
			and love.mouse.getY() / 16 <= math.ceil(getlockablemouseY() / 16) then
				mouselockhorizontalline = false
				mouselockverticalline = true
			end


			if mouselockhorizontalline then
				cursory = math.floor(love.mouse.getY() / 16)
			end

			if mouselockverticalline then
				cursorx = math.floor((love.mouse.getX()-screenoffset) / 16)
			end
		end

		-- Are we supposed to display a special cursor shape?
		if tilespicker then
			if levelmetadata_get(roomx, roomy).directmode ~= 0
			and cursorx < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth
			and cursory < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tilesheight then
				-- Just one tile, but only in manual/direct mode.
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16))
			end
		elseif movingentity > 0 and entitydata[movingentity] ~= nil then
			displayentity(
				screenoffset, 0, roomx, roomy, movingentity, entitydata[movingentity],
				cursorx, cursory,
				false, false, {}, false, false, true
			)
		elseif table.contains({3, 4}, selectedsubtool[14]) and entitydata[warpid] ~= nil then
			if selectedsubtool[14] == 4 then
				love.graphics.setColor(255, 255, 255, 64)
			end
			drawentitysprite(
				18,
				screenoffset + 16*cursorx,
				16*cursory,
				levelmetadata_get(roomx, roomy).customspritesheet
			)
			love.graphics.setColor(255, 255, 255, 255)
		elseif selectedtool <= 2 then
			-- Wall and background have different kinds of possible cursor shapes
			if selectedsubtool[selectedtool] == 1 or selectedsubtool[selectedtool] == 9 then
				-- Just a regular cursor
				displayalphatile(0, 0, 0, 0)
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16))
			elseif selectedsubtool[selectedtool] == 2 then
				-- 3x3
				displayalphatile(1, 1, 2, 2)
				displayshapedcursor(1, 1, 1, 1)
			elseif selectedsubtool[selectedtool] == 3 then
				-- 5x5
				displayalphatile(2, 2, 4, 4)
				displayshapedcursor(2, 2, 2, 2)
			elseif selectedsubtool[selectedtool] == 4 then
				-- 7x7
				displayalphatile(3, 3, 6, 6)
				displayshapedcursor(3, 3, 3, 3)
			elseif selectedsubtool[selectedtool] == 5 then
				-- 9x9
				displayalphatile(4, 4, 8, 8)
				displayshapedcursor(4, 4, 4, 4)
			elseif selectedsubtool[selectedtool] == 6 then
				-- horizontal fill
				displayalphatile_hor()
				love.graphics.draw(cursorimg[1], screenoffset, (cursory*16))
				love.graphics.draw(cursorimg[2], screenoffset+(39*16), (cursory*16))
				love.graphics.draw(cursorimg[3], screenoffset, (cursory*16))
				love.graphics.draw(cursorimg[4], screenoffset+(39*16), (cursory*16))
			elseif selectedsubtool[selectedtool] == 7 then
				-- vertical fill
				displayalphatile_ver()
				love.graphics.draw(cursorimg[1], screenoffset+(cursorx*16), 0)
				love.graphics.draw(cursorimg[2], screenoffset+(cursorx*16), 0)
				love.graphics.draw(cursorimg[3], screenoffset+(cursorx*16), (29*16))
				love.graphics.draw(cursorimg[4], screenoffset+(cursorx*16), (29*16))
			elseif selectedsubtool[selectedtool] == 8 then
				-- Custom size
				if customsizemode == 1 then
					love.graphics.setColor(255,255,0,255)
					love.graphics.rectangle("line",
						screenoffset+0,
						cursory*16,
						(cursorx+1)*16,
						love.graphics.getHeight()-cursory*16
					)
					love.graphics.setColor(255,255,255,255)
				elseif customsizemode == 4 then
					love.graphics.setColor(255,255,0,255)
					love.graphics.rectangle("line",
						screenoffset+customsizecoorx*16,
						customsizecoory*16,
						(math.max(cursorx, customsizecoorx)-customsizecoorx+1)*16,
						(math.max(cursory, customsizecoory)-customsizecoory+1)*16
					)
					love.graphics.setColor(255,255,255,255)
				end
				displayalphatile(math.floor(customsizex), math.floor(customsizey), customsizex*2, customsizey*2, true)
				displayshapedcursor(math.floor(customsizex), math.floor(customsizey), math.ceil(customsizex), math.ceil(customsizey))
			elseif selectedsubtool[selectedtool] == 10 then
				displayalphatile(-1, 0, 0, 0)
				displayalphatile(1, 0, 0, 0)
				displayalphatile(0, -1, 0, 0)
				displayalphatile(0, 1, 0, 0)
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset-16, (cursory*16))
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset+16, (cursory*16))
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16)-16)
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16)+16)
			end

			-- If direct mode is on, we want to know what tile number we're about to place!
			if levelmetadata_get(roomx, roomy).directmode == 1 then
				tinyprint(selectedtile, screenoffset+(16*cursorx), (16*cursory))
			end
		elseif selectedtool == 3 then
			-- Spike
			displayalphatile(0, 0, 0, 0)
			love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16))
		elseif selectedtool == 4 then
			-- Trinket
			displayshapedcursor(0, 0, 1, 1)
		elseif selectedtool == 5 then
			-- Checkpoint
			displayshapedcursor(0, 0, 1, 1)
		elseif selectedtool == 6 then
			-- Disappearing platform
			displayshapedcursor(0, 0, 3, 0)
		elseif selectedtool == 7 then
			-- Conveyor
			if selectedsubtool[7] <= 2 then
				displayshapedcursor(0, 0, 3, 0)
			else
				displayshapedcursor(0, 0, 7, 0)
			end
		elseif selectedtool == 8 and editingbounds == 0 then
			-- Moving platform
			displayshapedcursor(0, 0, 3, 0)
		elseif selectedtool == 9 and editingbounds == 0 then
			-- Enemy
			displayshapedcursor(0, 0, 1, 1)
		elseif selectedtool == 12 then
			-- Terminal
			displayshapedcursor(0, 0, 1, 2)
		elseif selectedtool == 14 then
			-- Warp token
			displayshapedcursor(0, 0, 1, 1)
		elseif selectedtool == 16 then
			-- Crewmate
			displayshapedcursor(0, 0, 1, 2)
		elseif selectedtool == 17 then
			-- Start point
			displayshapedcursor(0, 0, 1, 2)
		elseif selectedtool == 18 then
			-- Flip token
			displayshapedcursor(0, 0, 1, 1)
		elseif selectedtool == 19 then
			-- Coin
			local coincursize
			if selectedsubtool[19] == 1 then
				coincursize = 0
			elseif selectedsubtool[19] <= 3 then
				coincursize = 1
			else
				coincursize = 2
			end
			displayshapedcursor(0, 0, coincursize, coincursize)
		elseif selectedtool == 20 then
			-- Teleporter
			displayshapedcursor(0, 0, 11, 11)
		elseif not (selectedtool == 13 and selectedsubtool[13] == 2) then
			love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16))
		end
	else
		cursorx = "--"
		cursory = "--"
	end

	if (not s.psmallerscreen) or (keyboard_eitherIsDown(ctrl) and not love.keyboard.isDown("lshift")) then
		-- We also want the tools on the left. But it's a scrollable area.
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 127, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		love.graphics.setScissor(16, 16, 32 + 4 + 10, love.graphics.getHeight()-32)

		local thistooltip = ""

		for t = 1, 20 do
			-- love.graphics.rectangle("fill", 16, (16+(48*(t-1)))+lefttoolscroll, 32, 32)
			-- Are we hovering over it? Or maybe even clicking it?
			if not nodialog or ((mouseon(16, 0, 32, 16)) or (mouseon(16, love.graphics.getHeight()-16, 32, 16)) or (not mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32))) and selectedtool ~= t then
				love.graphics.setColor(255,255,255,128)
			elseif not window_active() then
				love.graphics.setColor(255,255,255,128)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32) and not mouseon(16, 0, 32, 16) and not mouseon(16, love.graphics.getHeight()-16, 32, 16) and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
				selectedtool = t
				updatewindowicon()
			end

			if nodialog and not mousepressed and love.mouse.isDown("r") and t == 17 and mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32) and not mouseon(16, 0, 32, 16) and not mouseon(16, love.graphics.getHeight()-16, 32, 16) then
				-- Find the start point
				gotostartpointroom()
				-- This works with right click as well
				mousepressed = true
			end

			if selectedtool == t then
				love.graphics.draw(selectedtoolborder,  16, (16+(48*(t-1)))+lefttoolscroll)
			else
				love.graphics.draw(unselectedtoolborder,  16, (16+(48*(t-1)))+lefttoolscroll)
			end

			coorx = 16+2
			coory = (16+2+(48*(t-1)))+lefttoolscroll

			love.graphics.draw(toolimg[t], coorx, coory)
			love.graphics.setColor(255,255,255,255)

			-- Put the shortcut next to it.
			tinyprint(toolshortcuts[t], coorx-2+32+1, coory)

			if nodialog and ((not mouseon(16, 0, 32, 16)) and not (mouseon(16, love.graphics.getHeight()-16, 32, 16)) and (mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32))) then
				thistooltip = toolnames[t]
			end
		end

		toolfinish({coorx, coory, selectedtool})

		-- We're done with that now, but now we have an area with subtools.
		love.graphics.setScissor(16+64, 16, 32+4, love.graphics.getHeight()-32)

		-- Allow for more than 9 subtools without scrolling, up to 13.
		local subtoolheight = 48
		if (#subtoolimgs[selectedtool] > 8) then
			local n_subtools = #subtoolimgs[selectedtool]
			subtoolheight = (400-n_subtools*32)/(n_subtools-1)+32
		end

		for k,v in pairs(subtoolimgs[selectedtool]) do
			-- Are we hovering over it? Or maybe even clicking it?
			if not nodialog or (selectedtool == 14 and selectedsubtool[selectedtool] ~= k) then
				love.graphics.setColor(255,255,255,128)
			elseif not nodialog or ((mouseon(16+64, 0, 32, 16)) or (mouseon(16+64, love.graphics.getHeight()-16, 32, 16)) or (not mouseon(16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll, 32, 32))) and selectedsubtool[selectedtool] ~= k then
				love.graphics.setColor(255,255,255,128)
			elseif not window_active() then
				love.graphics.setColor(255,255,255,128)
			end

			if nodialog and not mousepressed and (love.mouse.isDown("l") or love.mouse.isDown("r")) and mouseon(16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll, 32, 32) and not mouseon(16+64, 0, 32, 16) and not mouseon(16+64, love.graphics.getHeight()-16, 32, 16) and selectedtool ~= 14 then
				if selectedtool <= 2 and k == 8 and love.mouse.isDown("r") then
					customsizemode = 1
					customsizex = 0
					customsizey = 0
					customsizetile = nil
				end
				selectedsubtool[selectedtool] = k
			end

			if selectedsubtool[selectedtool] == k then
				love.graphics.draw(selectedtoolborder,  16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll)
			else
				love.graphics.draw(unselectedtoolborder,  16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll)
			end

			coorx = 16+64+2
			coory = (16+2+(subtoolheight*(k-1)))+leftsubtoolscroll

			-- v = subtoolimgs[selectedtool][k]
			love.graphics.draw(v, coorx, coory)
			love.graphics.setColor(255,255,255,255)

			-- Shortcut text, but only for ZXCV
			if (selectedtool <= 3 or selectedtool == 5 or (selectedtool >= 7 and selectedtool <= 10) or selectedtool == 19) and k >= 2 and k <= 9 then
				tinyprint(({"", "Z", "X", "C", "V", "H", "B", "", "F"})[k], coorx-2+32+1, coory)
			end

			if nodialog and ((not mouseon(16+64, 0, 32, 16)) and not (mouseon(16+64, love.graphics.getHeight()-16, 32, 16)) and (mouseon(16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll, 32, 32))) and window_active() then
				local tooltip_text = anythingbutnil(subtoolnames[selectedtool][k])
				if selectedtool <= 2 and k == 8 then
					tooltip_text = tooltip_text .. "\n" .. L.RESETCUSTOMBRUSH
				end
				thistooltip = tooltip_text
			end
		end

		love.graphics.setScissor()

		if roomx < limit.mapwidth and roomy < limit.mapheight then
			-- Display the minimap of the current room, just underneath our subtools
			local atx, aty = getcursor()
			local zoom = getminimapzoom(metadata)
			love.graphics.setColor(255, 255, 255, 63)
			love.graphics.rectangle("fill", 71, love.graphics.getHeight()-38, 50, 38)
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.rectangle("fill", 72, love.graphics.getHeight()-37, 48, 36)
			displayminimaproom(72, love.graphics.getHeight()-37, roomdata_get(roomx, roomy), levelmetadata_get(roomx, roomy), 4/zoom, atx, aty)
			love.graphics.setColor(255, 255, 255, 255)
		end

		if thistooltip ~= "" and window_active() then
			-- Ugh this code but we're hovering over it. So display a tooltip, but don't let it get snipped away by the scissors.
			love.graphics.setScissor()
			love.graphics.setColor(128,128,128,192)
			love.graphics.rectangle("fill",
				love.mouse.getX()+15, love.mouse.getY()-10,
				font8:getWidth(thistooltip), 8+(thistooltip:find("\n") ~= nil and 8 or 0)
			)
			love.graphics.setColor(255,255,255,255)
			ved_print(thistooltip, love.mouse.getX()+16, love.mouse.getY()-10)
			love.graphics.setScissor(16, 16, 32+4, love.graphics.getHeight()-32)
		end

		-- We're done with the scrollable menus now.
		love.graphics.setScissor()

		-- But we still want to be able to scroll!
		hoverdraw(scrollup, 16, 0, 32, 16)
		hoverdraw(scrolldn, 16, love.graphics.getHeight()-16, 32, 16)

		-- Are we clicking them?
		if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, 0, 32, 16) then
			lefttoolscroll = lefttoolscroll + 4
			lefttoolscrollbounds()
		elseif nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, love.graphics.getHeight()-16, 32, 16) then
			lefttoolscroll = lefttoolscroll - 4
			lefttoolscrollbounds()
		end

		-- For certain features, it would be nice to indicate that there are shortcuts you can use
		if selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0 then
			-- Custom cursor size
			local tinywidth = tinynumbers:getWidth(L.TINY_SHIFT)
			love.graphics.setColor(0, 0, 0, 224)
			love.graphics.rectangle("fill", 128-tinywidth-1, love.graphics.getHeight()-8, tinywidth+2, 9)
			love.graphics.setColor(255,255,0,255)
			tinyprint(L.TINY_SHIFT, 128-tinywidth, love.graphics.getHeight()-7)
			love.graphics.setColor(255,255,255,255)
		elseif editingroomtext > 0 and entitydata[editingroomtext] ~= nil and (entitydata[editingroomtext].t == 18 or entitydata[editingroomtext].t == 19) then
			-- Name for script box
			local tinywidth = math.max(tinynumbers:getWidth("{" .. L.TINY_SHIFT), tinynumbers:getWidth("}" .. L.TINY_CTRL))
			love.graphics.setColor(0, 0, 0, 224)
			love.graphics.rectangle("fill", 128-tinywidth-1, love.graphics.getHeight()-15, tinywidth+2, 16)
			love.graphics.setColor(255,255,0,255)
			tinyprint("{" .. L.TINY_SHIFT, 128-tinywidth, love.graphics.getHeight()-14)
			tinyprint("}" .. L.TINY_CTRL, 128-tinywidth, love.graphics.getHeight()-7)
			love.graphics.setColor(255,255,255,255)
		end

		hoverdraw((eraserlocked and eraseroff or eraseron), 88, 0, 16, 16)
		_= not editingroomname and showhotkey("f", 88-1, 16-8)

		if not mousepressed and nodialog and love.mouse.isDown("l") and mouseon(88, 0, 16, 16) then
			eraserlocked = not eraserlocked
			mousepressed = true
		end
	else
		-- Still have a background, in case we have a brush that's so big it overlaps with this part of the screen
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 31, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		if not window_active() then
			love.graphics.setColor(255,255,255,128)
		end
		tinyprint(L.TINY_CTRL, 0, 0)

		-- Also display the current (sub)tool!
		love.graphics.draw(selectedtoolborder, 0, love.graphics.getHeight()-32)
		if subtoolimgs[selectedtool][selectedsubtool[selectedtool]] ~= nil then
			-- We have a subtool to display!
			love.graphics.draw(subtoolimgs[selectedtool][selectedsubtool[selectedtool]], 2, love.graphics.getHeight()-30)
		else
			-- Just display the tool itself.
			love.graphics.draw(toolimg[selectedtool], 2, love.graphics.getHeight()-30)
		end
	end

	-- Now stuff on the right.
	love.graphics.setColor(0, 0, 0, 192)
	love.graphics.rectangle("fill", love.graphics.getWidth()-127, 0, 128, love.graphics.getHeight())
	love.graphics.setColor(255,255,255,255)
	local usethisbtn
	if playtesting_available then
		if playtesting_askwherestart then
			usethisbtn = stopbtn
		else
			usethisbtn = playbtn
		end
	else
		usethisbtn = playgraybtn
	end
	hoverdraw(usethisbtn, love.graphics.getWidth()-128, 0, 32, 32, 2)
	_= not editingroomname and editingbounds == 0 and showhotkey("n", love.graphics.getWidth()-128, 32-8) -- The Esc hotkey to cancel playtesting is after the side panels are darkened
	hoverdraw(helpbtn, love.graphics.getWidth()-120+40, 40, 16, 16, 1)
	_= not editingroomname and showhotkey("cq", love.graphics.getWidth()-120+40+8-2, 40+2, ALIGN.CENTER)
	hoverdraw(newbtn, love.graphics.getWidth()-96, 0, 32, 32, 2)
	showhotkey("cN", love.graphics.getWidth()-96-2, 32-8)
	hoverdraw(loadbtn, love.graphics.getWidth()-64, 0, 32, 32, 2)
	_= not editingroomname and showhotkey("L", love.graphics.getWidth()-64-2, 32-8)
	hoverdraw(savebtn, love.graphics.getWidth()-32, 0, 32, 32, 2)
	_= not editingroomname and showhotkey("S", love.graphics.getWidth()-32-2, 32-8)

	-- Now for the other buttons - about this variable, I can hardcode it again later.
	local buttonspacing = 20 --24

	if #undobuffer >= 1 then
		hoverdraw(undobtn, love.graphics.getWidth()-120, 40, 16, 16, 1)     -- 128-8 => 120
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(undobtn, love.graphics.getWidth()-120, 40)
		love.graphics.setColor(255,255,255)
	end
	if #redobuffer >= 1 then
		hoverdraw(redobtn, love.graphics.getWidth()-120+16, 40, 16, 16, 1)
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(redobtn, love.graphics.getWidth()-120+16, 40)
		love.graphics.setColor(255,255,255)
	end

	_= not editingroomname and showhotkey("cZ", love.graphics.getWidth()-120+7, 40-4, ALIGN.CENTER)
	_= not editingroomname and showhotkey("cY", love.graphics.getWidth()-120+16+6, 40+8+2, ALIGN.CENTER)

	hoverdraw(cutbtn, love.graphics.getWidth()-120+64, 40, 16, 16, 1)
	hoverdraw(copybtn, love.graphics.getWidth()-120+80, 40, 16, 16, 1)
	hoverdraw(pastebtn, love.graphics.getWidth()-120+96, 40, 16, 16, 1)

	_= not editingroomname and showhotkey("cX", love.graphics.getWidth()-120+64+6, 40-4-2, ALIGN.CENTER)
	_= not editingroomname and showhotkey("cC", love.graphics.getWidth()-120+80+6, 40+8, ALIGN.CENTER)
	_= not editingroomname and showhotkey("cV", love.graphics.getWidth()-120+96+6, 40-4, ALIGN.CENTER)

	--rbutton((upperoptpage2 and L.UNDO or L.VEDOPTIONS), 0, 40, false, 20)
	rbutton((upperoptpage2 and L.VEDOPTIONS or L.LEVELOPTIONS), 1, 40, false, 20)
	rbutton((upperoptpage2 and (not editingroomname and {L.COMPARE, "cD"} or L.COMPARE) or (not editingroomname and {L.MAP, "M"} or L.MAP)), 2, 40, false, 20)
	rbutton((upperoptpage2 and L.STATS or (not editingroomname and {L.SCRIPTS, "/"} or L.SCRIPTS)), 3, 40, false, 20)
	if not upperoptpage2 then
		rbutton(not editingroomname and {L.SEARCH, "cF"} or L.SEARCH, 4, 40, false, 20)
		rbutton(not editingroomname and {L.LEVELNOTEPAD, "c/"} or L.LEVELNOTEPAD, 5, 40, false, 20)
	end
	rbutton((upperoptpage2 and L.BACKB or L.MOREB), 6, 40, false, 20)

	-- When adding an extra button for layers mode or something like that, and the buttons needs to be squished, just set this to true and then hardcode it. Not for plugins though
	local additionalbutton = metadata.target == "VCE"
	local additionalbutton_np = additionalbutton and 1 or 0
	local additionalbutton_yoffset = additionalbutton and 166 or 164
	local additionalbutton_spacing = additionalbutton and 20 or 24

	if additionalbutton then
		rbutton({L.CUSTOMGRAPHICS, "co"}, 0, 166, true, 20)
	end

	rbutton(fontpng_works and L.ROTATE180 or L.ROTATE180UNI, 0+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	local _, voided_metadata = levelmetadata_get(roomx, roomy)
	_= not voided_metadata and rbutton({(levelmetadata_get(roomx, roomy).directmode == 1 and L.MANUALMODE or (levelmetadata_get(roomx, roomy).auto2mode == 1 and L.AUTO2MODE or L.AUTOMODE)), "p"}, 1+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)

	rbutton((showepbounds and L.HIDEBOUNDS or L.SHOWBOUNDS), 2+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	_= not voided_metadata and rbutton(not editingroomname and {langkeys(L.WARPDIR, {warpdirs[levelmetadata_get(roomx, roomy).warpdir]}), "W"} or langkeys(L.WARPDIR, {warpdirs[levelmetadata_get(roomx, roomy).warpdir]}), 3+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	_= not voided_metadata and rbutton({L.ROOMNAME, not editingroomname and "E" or "n"}, 4+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing, editingroomname) -- (6*16)+16+24+12+16

	ved_printf(L.ROOMOPTIONS, love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-300)+8, 128-16, "center") -- -(6*16)-16-24-12-8-(24*6))+4+2+4 => -300)+10

	-- Well make them actually do something!
	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-128, 0, 32, 32) then
			-- Play
			if playtesting_askwherestart then
				playtesting_cancelask()
			else
				playtesting_start()
			end
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+40, 40, 16, 16) then
			-- Help
			tostate(15)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-96, 0, 32, 32) then
			-- New
			editingroomname = false
			if has_unsaved_changes() then
				dialog.create(
					L.SURENEWLEVELNEW, DBS.SAVEDISCARDCANCEL,
					dialog.callback.surenewlevel, nil, nil,
					dialog.callback.noclose_on.save
				)
			else
				triggernewlevel()
			end
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-64, 0, 32, 32) then
			-- Load. But first ask them if they want to save (make this save/don't save/cancel later, yes/no for now)
			editingroomname = false
			tostate(6)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-32, 0, 32, 32) then
			-- Save
			--tostate(8)
			editingroomname = false
			dialog.create(
				L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, DBS.OKCANCEL,
				dialog.callback.save, nil, dialog.form.save_make()
			)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120, 40, 16, 16) then
			undo()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+16, 40, 16, 16) then
			redo()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+64, 40, 16, 16) then
			-- Cut
			cutroom()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+80, 40, 16, 16) then
			-- Copy
			copyroom()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+98, 40, 16, 16) then
			-- Paste
			pasteroom()
			mousepressed = true
		elseif onrbutton(1, 40, false, 20) then
			if not upperoptpage2 then
				-- Level options
				dialog.create(
					"",
					DBS.OKCANCEL,
					dialog.callback.leveloptions,
					L.LEVELOPTIONS,
					dialog.form.leveloptions_make()
				)
				editingroomname = false
			else
				-- Ved options
				tostate(13)
			end
			mousepressed = true
		elseif onrbutton(2, 40, false, 20) then
			if not upperoptpage2 then
				-- Map
				tostate(12)
			else
				-- Compare
				tostate(6, nil, "secondlevel")
			end
		elseif onrbutton(3, 40, false, 20) then
			if not upperoptpage2 then
				-- Scripts
				tostate(10)
				mousepressed = true
			else
				-- Stats
				tostate(28)
				mousepressed = true
			end
		elseif onrbutton(4, 40, false, 20) then
			if not upperoptpage2 then
				-- Search
				tostate(11)
			end
		elseif onrbutton(5, 40, false, 20) then
			if not upperoptpage2 then
				-- Level notepad
				tonotepad()
			end
		elseif upperoptpage2 and onrbutton(6, 40, false, 20) then
			-- Pages
			upperoptpage2 = not upperoptpage2

			mousepressed = true

		-- Room options now
		elseif additionalbutton and onrbutton(0, 166, true, 20) then
			-- ...
			dialog.create("", DBS.OKCANCEL, dialog.callback.vcecustomgraphics, L.CUSTOMGRAPHICS,
				dialog.form.vcecustomgraphics_make(levelmetadata_get(roomx, roomy))
			)

		elseif onrbutton(0+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Rotate
			rotateroom180(roomx, roomy, altstate)
			if levelmetadata_get(roomx, roomy).directmode == 0 then
				autocorrectroom()
			end
			mousepressed = true
		elseif onrbutton(1+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) and not voided_metadata then
			-- Direct mode on or off
			changedmode()

			mousepressed = true
		elseif onrbutton(2+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Show bounds
			showepbounds = not showepbounds

			mousepressed = true
		elseif onrbutton(3+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) and not voided_metadata then
			-- Warp dir
			changewarpdir()

			mousepressed = true
		elseif onrbutton(4+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) and not voided_metadata then
			-- Roomname
			toggleeditroomname()

			mousepressed = true
		end
	end

	-- We also have buttons for trinkets, enemy and platform settings, and crewmates!
	if selectedtool == 4 or selectedtool == 8 or selectedtool == 9 or selectedtool == 16 then
		local roomsettings = {platv = levelmetadata_get(roomx, roomy).platv}
		if selectedtool ~= 4 and selectedtool ~= 16 and not voided_metadata then
			rbutton((selectedtool == 8 and (not editingroomname and {L.PLATFORMBOUNDS, "t"} or L.PLATFORMBOUNDS) or (not editingroomname and {L.ENEMYBOUNDS, "r"} or L.ENEMYBOUNDS)), -3, 164+4, true, nil, editingbounds ~= 0)
		end
		if selectedtool == 4 or selectedtool == 16 then
			rbutton(selectedtool == 4 and L.LISTALLTRINKETS or L.LISTALLCREWMATES, -2, 164+4, true)
		elseif voided_metadata then
		elseif selectedtool == 9 then
			rbutton({langkeys(L.ENEMYTYPE, {levelmetadata_get(roomx, roomy).enemytype}), "e"}, -2, 164+4, true)
		else
			ved_print(L.PLATFORMSPEEDSLIDER, love.graphics.getWidth()-(128-8), love.graphics.getHeight()+24-160+4)
			hoverrectangle(128, 128, 128, 128, love.graphics.getWidth()-(128-8)+(6*8) + (64 - font8:getWidth(roomsettings.platv))/2 - 4, love.graphics.getHeight()+24-160, font8:getWidth(roomsettings.platv) + 8, 16)
			int_control(love.graphics.getWidth()-(128-8)+(6*8), love.graphics.getHeight()+24-160, "platv", 0, 8, nil, roomsettings, function() return roomsettings.platv end, 8*3)
			local oldplatv = levelmetadata_get(roomx, roomy).platv
			if roomsettings.platv ~= oldplatv then
				levelmetadata_set(roomx, roomy, "platv", roomsettings.platv)
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
							{
								key = "platv",
								oldvalue = oldplatv,
								newvalue = levelmetadata_get(roomx, roomy).platv
							}
						},
						switchtool = 8
					}
				)
				finish_undo("PLATV (slider)")
			end
		end

		ved_printf(
			selectedtool == 4 and L.TRINKETS or
			selectedtool == 8 and L.ROOMPLATFORMS or
			selectedtool == 9 and L.ROOMENEMIES or L.CREWMATES,
			love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-156)+4, 128-16, "center"
		) -- hier is 4 afgegaan. ---- -(6*16)-16-24-12-8-(24*0))+4 => -156)+4

		local changedplatv, oldplatv = false, levelmetadata_get(roomx, roomy).platv

		-- They should work
		if not mousepressed and nodialog and love.mouse.isDown("l") then
			if onrbutton(-2, 164+4, true) and selectedtool == 4 then
				-- List all trinkets
				local trinkets = {}
				for _,ent in pairs(entitydata) do
					if ent.t == 9 then
						local x, y = math.floor(ent.x/40), math.floor(ent.y/30)
						if x < 0 then x = 0 end
						if y < 0 then y = 0 end
						if not s.coords0 then
							x = x + 1
							y = y + 1
						end
						table.insert(trinkets, "(" .. x .. "," .. y .. ")")
					end
				end

				trinkets = table.concat(trinkets, ", ")
				if trinkets == "" then
					trinkets = L.NOTRINKETSINLEVEL
				end
				editingroomname = false
				dialog.create(trinkets, nil, nil, L.LISTOFALLTRINKETS)
			elseif onrbutton(-2, 164+4, true) and selectedtool == 16 then
				-- List all crewmates
				local crewmates = {}
				for _, ent in pairs(entitydata) do
					if ent.t == 15 then
						local x, y = math.floor(ent.x/40), math.floor(ent.y/30)
						if x < 0 then x = 0 end
						if y < 0 then y = 0 end
						if not s.coords0 then
							x = x + 1
							y = y + 1
						end
						table.insert(crewmates, "(" .. x .. "," .. y .. ")")
					end
				end

				crewmates = table.concat(crewmates, ", ")
				if crewmates == "" then
					crewmates = L.NOCREWMATESINLEVEL
				end
				editingroomname = false
				dialog.create(crewmates, nil, nil, L.LISTOFALLCREWMATES)
			elseif selectedtool == 4 or selectedtool == 16 or voided_metadata then
			elseif onrbutton(-3, 164+4, true) then
				-- Enemy/platform bounds
				if selectedtool == 9 then
					-- Enemy.
					changeenemybounds()
				else
					-- Platform.
					changeplatformbounds()
				end

				mousepressed = true
			elseif onrbutton(-2, 164+4, true) and selectedtool == 9 then
				-- Enemy type
				switchenemies()
				mousepressed = true
			elseif mouseon(love.graphics.getWidth()-(128-8)+(6*8) + (64 - font8:getWidth(levelmetadata_get(roomx, roomy).platv))/2 - 4, love.graphics.getHeight()+24-160, font8:getWidth(levelmetadata_get(roomx, roomy).platv) + 8, 16) and selectedtool == 8 then
				-- Platform speed
				dialog.create(
					L.PLATVCHANGE_MSG,
					DBS.OKCANCEL,
					dialog.callback.platv,
					L.PLATVCHANGE_TITLE,
					{{"name", 0, 1, 5, ""}},
					dialog.callback.platv_validate
				)
				editingroomname = false

				mousepressed = true
			end
		end

		if selectedtool == 8 and nodialog and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), love.graphics.getHeight()-136, 128-16, 16) and not mousepressed and not voided_metadata then -- -(6*16)-16-24-12-8-(24*-1)-4 => -136
			changedplatv = true
			levelmetadata_set(roomx, roomy, "platv", 4)
			mousepressed = true
		end

		if changedplatv then
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
						{
							key = "platv",
							oldvalue = oldplatv,
							newvalue = levelmetadata_get(roomx, roomy).platv
						}
					},
					switchtool = 8
				}
			)
			finish_undo("PLATV (reset to 4)")
		end
	end

	-- And coordinates.
	love.graphics.setColor(128,128,128)
	if s.coords0 then
		tinyprint("0", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		ved_printf("(" .. roomx .. "," .. roomy .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-10, 56, "right")
	else
		tinyprint("1", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		ved_printf("(" .. (roomx+1) .. "," .. (roomy+1) .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-10, 56, "right")
	end

	-- But if we're in the tiles picker instead display the tile we're hovering on!
	if tilespicker then
		if cursorx ~= "--" and cursory ~= "--"
		and cursorx < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth
		and cursory < tilesets[tilesetnames[usedtilesets[selectedtileset]]].tilesheight then
			ved_printf(
				langkeys(L.TILE, {(cursory*tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth)+cursorx}),
				love.graphics.getWidth()-128, love.graphics.getHeight()-8-10, 128, "right"
			)
			ved_printf(
				(issolid((cursory*40)+(cursorx+1)-1, usedtilesets[levelmetadata_get(roomx, roomy).tileset]) and L.SOLID or L.NOTSOLID),
				love.graphics.getWidth()-128, love.graphics.getHeight()-10, 128, "right"
			)
		else
			ved_printf(langkeys(L.TILE, {"----"}), love.graphics.getWidth()-128, love.graphics.getHeight()-8-10, 128, "right")
		end
	else
		ved_printf("[" .. cursorx .. "," .. cursory .. "]", love.graphics.getWidth()-56, love.graphics.getHeight()-8-10, 56, "right")
		if (cursorx ~= "--") and (cursory ~= "--") then
			ved_printf("<" .. (cursorx*8) .. "," .. (cursory*8) .. ">", love.graphics.getWidth()-72, love.graphics.getHeight()-10, 72, "right") -- 56+16=72
		else
			ved_printf("<---,--->", love.graphics.getWidth()-72, love.graphics.getHeight()-10, 72, "right")
		end
	end

	-- Also display a smaller tiles picker for semi-undirect mode
	if selectedtool <= 3 and not voided_metadata then
		local picker_x, picker_y = love.graphics.getWidth()-(7*16), love.graphics.getHeight()-156 -- -(6*16)-16-24-12-8 => -156
		local picker_scale
		if metadata.target == "VCE" then
			picker_y = picker_y + 40
			picker_scale = 1
		else
			picker_scale = 2
		end
		local picker_w, picker_h = 6*picker_scale*8, 5*picker_scale*8

		love.graphics.setColor(128,128,128,255)
		love.graphics.rectangle("fill", picker_x-1, picker_y-1, picker_w+2, picker_h+2)
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle("fill", picker_x, picker_y, picker_w, picker_h)
		love.graphics.setColor(255,255,255,255)
		displaysmalltilespicker(picker_x, picker_y, selectedtileset, selectedcolor, levelmetadata_get(roomx, roomy).customtileset, picker_scale)

		if metadata.target == "VCE" then
			local ct = levelmetadata_get(roomx, roomy).customtileset
			local cs = levelmetadata_get(roomx, roomy).customspritesheet

			local ind_x, ind_y = love.graphics.getWidth()-7*8, love.graphics.getHeight()-116
			ved_print(langkeys(L.ONECUSTOMTILESET, {ct == 0 and "-" or ct}), ind_x, ind_y)
			ved_print(langkeys(L.ONECUSTOMSPRITESHEET, {cs == 0 and "-" or cs}), ind_x, ind_y+8)
			if #extra.altstates[roomy][roomx] > 0 then
				ved_print(langkeys(L.ONEALTSTATE, {altstate, #extra.altstates[roomy][roomx]}), ind_x, ind_y+24)
			end
			--ved_print(langkeys(L.ONETOWER, {"↑", 1, 400}), ind_x, ind_y+24)
		end
	end

	_= not voided_metadata and hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-70, (6*16), 8+4) -- -16-32-2-12-8 => -70
	_= not voided_metadata and ved_printf(
		tilesetblocks[selectedtileset].name ~= nil and tilesetblocks[selectedtileset].name or selectedtileset,
		love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-32-12-8, 6*16, "center"
	)

	_= not voided_metadata and hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-24-2-8-8, (6*16), 8+4)
	_= not voided_metadata and ved_printf(
		tilesetblocks[selectedtileset].colors[selectedcolor].name ~= nil
		and tilesetblocks[selectedtileset].colors[selectedcolor].name
		or langkeys(L.TSCOLOR, {selectedcolor}),
		love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-24-8-8, 6*16, "center"
	)

	if love.mouse.isDown("l") and nodialog and not mousepressed and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-70, (6*16), 8+4) and not voided_metadata then -- -16-32-2-12-8 => -70
		-- Switch tileset
		switchtileset()
		mousepressed = true
	elseif love.mouse.isDown("l") and nodialog and not mousepressed and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-58, (6*16), 8+4) and not voided_metadata then -- -16-24-2-8-8 => 58
		-- Switch tilecol
		switchtilecol()
		mousepressed = true
	end

	hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-46, (6*16), 8+4) -- -16-16-2-4-8 => -46
	ved_printf(
		tilespicker and L.HIDEALL or L.SHOWALL,
		love.graphics.getWidth()-(7*16), love.graphics.getHeight()-44, 6*16, "center"
	) -- -16-16-4-8 => -44

	_= not voided_metadata showhotkey("q", love.graphics.getWidth()-16, love.graphics.getHeight()-70-2, ALIGN.RIGHT)
	_= not voided_metadata showhotkey("w", love.graphics.getWidth()-16, love.graphics.getHeight()-58-2, ALIGN.RIGHT)
	_= not editingroomname and showhotkey("cs", love.graphics.getWidth()-16, love.graphics.getHeight()-46-2, ALIGN.RIGHT)

	-- Some text below the tiles picker-- how many trinkets and crewmates do we have?
	ved_printf(
		L.ONETRINKETS .. fixdig(anythingbutnil(count.trinkets), 3, "") .. "\n"
		.. L.ONECREWMATES .. fixdig(anythingbutnil(count.crewmates), 3, "") .. "\n"
		.. L.ONEENTITIES .. fixdig(anythingbutnil(count.entities), 5, ""),
		640+screenoffset+2, love.graphics.getHeight()-16-10, 128, "left"
	)

	if coordsdialog.active then
		coordsdialog.draw()
	end

	local bottomwidemsg
	if playtesting_askwherestart then
		bottomwidemsg = L.WHEREPLACEPLAYER
	elseif playtesting_active then
		bottomwidemsg = L.YOUAREPLAYTESTING
	end

	if playtesting_askwherestart then
		local mouseoncanvas = mouseon(screenoffset, 0, 640, love.graphics.getHeight())

		if mouseoncanvas then
			local atx, aty = love.mouse.getPosition()
			local flipped = false
			atx = atx - screenoffset
			atx = math.floor(atx / 2)
			aty = math.floor(aty / 2)

			if not keyboard_eitherIsDown("alt") then
				atx, aty, flipped = playtesting_snap_position(atx, aty, flipped)
			end

			atx = atx * 2
			aty = aty * 2
			atx = atx + screenoffset
			v6_setcol(0)
			love.graphics.setScissor(screenoffset, 0, 640, love.graphics.getHeight())

			if keyboard_eitherIsDown("shift") then
				flipped = not flipped
			end

			local usethissprite = 0
			if flipped then
				usethissprite = usethissprite + 6
			end
			drawentitysprite(
				usethissprite,
				atx - 12,
				aty - 4,
				levelmetadata_get(roomx, roomy).customspritesheet
			)

			love.graphics.setScissor()
			love.graphics.setColor(255, 255, 255, 255)
		end

		local flipindicator = "gvj"
		local unlockindicator = ";"

		local tinywidth = math.max(tinynumbers:getWidth(L.TINY_SHIFT), tinynumbers:getWidth(L.TINY_ALT))
		local tinyiconwidth = math.max(tinynumbers:getWidth(flipindicator), tinynumbers:getWidth(unlockindicator))
		local totalwidth = tinywidth + tinyiconwidth

		love.graphics.setColor(0, 0, 0, 224)
		love.graphics.rectangle("fill", 128-totalwidth-1, love.graphics.getHeight()-15, totalwidth+2, 16)
		love.graphics.setColor(255, 255, 0, 255)
		tinyprint(flipindicator .. L.TINY_SHIFT, 128-tinywidth-tinynumbers:getWidth(flipindicator), love.graphics.getHeight()-15)
		tinyprint(unlockindicator .. L.TINY_ALT, 128-tinywidth-tinynumbers:getWidth(unlockindicator), love.graphics.getHeight()-7)
		love.graphics.setColor(255, 255, 255, 255)

		if love.mouse.isDown("l") and not mousepressed then
			mousepressed = true
			if mouseoncanvas then
				playtesting_endaskwherestart()
			else
				playtesting_askwherestart = false
			end
		end
	end

	if bottomwidemsg ~= nil then
		local _, lines = font8:getWrap(bottomwidemsg, love.graphics.getWidth())
		-- lines is a number in 0.9.x, and a table/sequence in 0.10.x and higher
		if type(lines) == "table" then
			lines = #lines
		end
		local yoff = 16 * (lines-1)

		love.graphics.setColor(255, 255, 127, 63)
		love.graphics.rectangle("fill", 0, love.graphics.getHeight()-40-yoff, love.graphics.getWidth(), 16+yoff)
		love.graphics.setColor(255, 255, 255, 255)
		ved_printf(bottomwidemsg, 0, love.graphics.getHeight()-40-yoff, love.graphics.getWidth(), "center", 2)
	end

	if playtesting_askwherestart then
		showhotkey("b", love.graphics.getWidth()-128, 32-8, nil, true)
	end

	-- Do we want to see room metadata?
	if allowdebug and love.keyboard.isDown("f11") then

	end
end
