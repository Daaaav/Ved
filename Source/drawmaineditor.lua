function drawmaineditor()
	-- Are we clicking?
	if nodialog and (love.mouse.isDown("l") or love.mouse.isDown("r")) and mouseon(screenoffset, 0, 639, 480)
	and (not keyboard_eitherIsDown("alt") or movingentity > 0 or selectedsubtool[14] >= 3) then
		local atx = math.floor((getlockablemouseX()-screenoffset) / 16)
		local aty = math.floor(getlockablemouseY() / 16)

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
		if love.mouse.isDown("l") and not mousepressed and (selectedtool >= 4 or movingentity > 0) and editingbounds == 0 then
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
					end
				end
			end
		end

		if s.psmallerscreen and (keyboard_eitherIsDown(ctrl) and not love.keyboard.isDown("lshift")) and love.mouse.getX() < 128 then
			-- Discard anything we're doing with the mouse in the room, we're now on the toolbar
		elseif tilespicker then
			if false and tilescreator then
				-- This is the one where you have to click 30 tiles individually.
				if not mousepressed then
					if creatorstep == 1 then
						cons("Wall tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						tilesetblocks.creator.colors.creator.blocks[creatorsubstep] = (aty*40)+(atx+1)-1
						cb[creatorsubstep] = (aty*40)+(atx+1)-1
					elseif creatorstep == 2 then
						cons("Background tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						tilesetblocks.creator.colors.creator.background[creatorsubstep] = (aty*40)+(atx+1)-1
						ca[creatorsubstep] = (aty*40)+(atx+1)-1
					elseif creatorstep == 3 then
						cons("Spike tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						tilesetblocks.creator.colors.creator.spikes[creatorsubstep] = (aty*40)+(atx+1)-1
						cs[creatorsubstep] = (aty*40)+(atx+1)-1
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
				if not mousepressed then
					if creatorstep == 1 then
						cons("Wall tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						--tilesetblocks.creator.colors.creator.blocks[creatorsubstep] = (aty*40)+(atx+1)-1

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*40)+(atx+1)-1 == 0 then
									cb[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									cb[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
								end
							end
						end
					elseif creatorstep == 2 then
						cons("Background tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						--tilesetblocks.creator.colors.creator.background[creatorsubstep] = (aty*40)+(atx+1)-1

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*40)+(atx+1)-1 == 0 then
									ca[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									ca[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
								end
							end
						end
					elseif creatorstep == 3 then
						cons("Spike tile " .. creatorsubstep .. ": " .. (aty*40)+(atx+1)-1)

						--tilesetblocks.creator.colors.creator.spikes[creatorsubstep] = (aty*40)+(atx+1)-1

						for yplus = 0, 4 do
							for xplus = 0, 2 do
								if (aty*40)+(atx+1)-1 == 0 then
									cs[creatorsubstep+(6*yplus)+xplus] = 0
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = 0
								else
									cs[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
									tilesetblocks.creator.colors.creator.blocks[creatorsubstep+(6*yplus)+xplus] = (aty*40)+(atx+1)-1 + (40*yplus) + xplus
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

			elseif levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
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
				else
					cons("Tile selected: " .. (aty*40)+(atx+1)-1)
					selectedtile = (aty*40)+(atx+1)-1
				end
			end
		elseif movingentity > 0 and entitydata[movingentity] ~= nil then
			if love.mouse.isDown("l") and not mousepressed then
				local new_x, new_y = 40*roomx + atx, 30*roomy + aty
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
								}
							}
						}
					)
					finish_undo("CHANGED ENTITY (X AND Y)")
				end
				entitydata[movingentity].x = new_x
				entitydata[movingentity].y = new_y
				if movingentity_copying then
					entityplaced(movingentity)
				end
				movingentity = 0
				movingentity_copying = false
				nodialog = false
			end
		elseif selectedtool <= 3 then
			if not (eraserlocked and love.mouse.isDown("r")) then
				if undosaved == 0 then
					table.insert(undobuffer, {undotype = "tiles", rx = roomx, ry = roomy, toundotiles = table.copy(roomdata[roomy][roomx]), toredotiles = {}})
					undosaved = #undobuffer
					finish_undo("SAVED BEGIN RESULT FOR UNDO")
				end

				if selectedtool <= 2 then
					--cons("Tile clicked: " .. atx .. " " .. aty .. ", set to " .. selectedtile .. ", subtool " .. selectedsubtool[selectedtool])

					if love.mouse.isDown("r") then
						useselectedtile = 0
					else
						if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
							-- Auto mode
							useselectedtile = selectedtool
						else
							useselectedtile = selectedtile
						end
					end

					if selectedsubtool[selectedtool] == 1 then
						-- 1x1
						roomdata[roomy][roomx][(aty*40)+(atx+1)] = useselectedtile
					elseif selectedsubtool[selectedtool] == 2 then
						-- 3x3
						for sty = (aty-1), (aty+1) do
							for stx = (atx-1), (atx+1) do
								--if roomdata[roomy][roomx][(sty*40)+(stx+1)] ~= nil then
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 3 then
						-- 5x5
						for sty = (aty-2), (aty+2) do
							for stx = (atx-2), (atx+2) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 4 then
						-- 7x7
						for sty = (aty-3), (aty+3) do
							for stx = (atx-3), (atx+3) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 5 then
						-- 9x9
						for sty = (aty-4), (aty+4) do
							for stx = (atx-4), (atx+4) do
								if stx >= 0 and stx <= 39 and sty >= 0 and sty <= 29 then
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
								end
							end
						end
					elseif selectedsubtool[selectedtool] == 6 then
						-- horizontal fill
						if minsmear == -1 and maxsmear == -1 then
							minsmear = aty; maxsmear = aty
							for stx = 0, 39 do
								roomdata[roomy][roomx][(aty*40)+(stx+1)] = useselectedtile
							end
						end

						if aty < minsmear or aty > maxsmear then
							for sty = math.min(aty, minsmear), math.max(aty, maxsmear) do
								for stx = 0, 39 do
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
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
								roomdata[roomy][roomx][(sty*40)+(atx+1)] = useselectedtile
							end
						end

						if atx < minsmear or atx > maxsmear then
							for stx = math.min(atx, minsmear), math.max(atx, maxsmear) do
								for sty = 0, 29 do
									roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
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
											roomdata[roomy][roomx][(sty*40)+(stx+1)] = customsizetile[iy][ix]
										elseif not (customsizetile ~= nil and customsizetile[iy][ix] == 0) then -- We don't want this when this tile in a stamp is 0!
											roomdata[roomy][roomx][(sty*40)+(stx+1)] = useselectedtile
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
									local tnum = roomdata[roomy][roomx][(sty*40)+stx+1]
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
						local oldtile = roomdata[roomy][roomx][aty*40+atx+1]
						roomdata[roomy][roomx][aty*40+atx+1] = useselectedtile

						-- It's only useful to fill if we're not filling an area with exactly the same tile.
						if oldtile ~= useselectedtile then
							-- Start a list of tiles
							local tilesarea, i = {{atx, aty}}, 1

							while tilesarea[i] ~= nil and i < 1200 do
								local f_x, f_y = unpack(tilesarea[i])
								for _,dir in pairs({{-1,0}, {0,-1}, {1,0}, {0,1}}) do
									if  f_x+dir[1] >= 0 and f_x+dir[1] <= 39
									and f_y+dir[2] >= 0 and f_y+dir[2] <= 29
									and roomdata[roomy][roomx][(f_y+dir[2])*40+f_x+dir[1]+1] == oldtile then
										roomdata[roomy][roomx][(f_y+dir[2])*40+f_x+dir[1]+1] = useselectedtile

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
							roomdata[roomy][roomx][((aty-tooutnow)*40)+((atx+rot)+1)] = useselectedtile -- top to right
							roomdata[roomy][roomx][((aty+rot)*40)+((atx+tooutnow)+1)] = useselectedtile -- right to bottom
							roomdata[roomy][roomx][((aty+tooutnow)*40)+((atx-rot)+1)] = useselectedtile -- bottom to left
							roomdata[roomy][roomx][((aty-rot)*40)+((atx-tooutnow)+1)] = useselectedtile -- left to top
						end

						toout = anythingbutnil0(toout) + 1
					end
				else
					--cons("Tile clicked spike: " .. atx .. " " .. aty .. ", set to " .. selectedtile .. ", subtool " .. selectedsubtool[3])

					if love.mouse.isDown("r") then
						useselectedtile = 0
					else
						if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
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
						roomdata[roomy][roomx][(aty*40)+(atx+1)] = useselectedtile
					elseif selectedsubtool[3] == 2 then
						-- <-->
						if issolidmultispikes(adjtile((aty*40)+(atx+1), 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_floor_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_ceiling_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_leftwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_rightwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
							spikes_rightwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
						else
							-- No solid blocks directly surrounding this spike

						end
					elseif selectedsubtool[3] == 3 then
						-- <--
						if issolidmultispikes(adjtile((aty*40)+(atx+1), 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_up(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_rightwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						else
							-- No solid blocks directly surrounding this spike

						end
					elseif selectedsubtool[3] == 4 then
						-- -->
						if issolidmultispikes(adjtile((aty*40)+(atx+1), 0, 1), ts) then
							-- There's a solid block below this spike.
							spikes_floor_right(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 0, -1), ts) then
							-- There's a solid block above this spike.
							spikes_ceiling_left(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), -1, 0), ts) then
							-- There's a solid block to the left of this spike.
							spikes_leftwall_down(atx, aty, tilesetblocks[selectedtileset].tileimg)
						elseif issolidmultispikes(adjtile((aty*40)+(atx+1), 1, 0), ts) then
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
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 4 then
			-- Trinket
			if count.trinkets >= 20 then
				dialog.create(L.MAXTRINKETS)
			else
				cons("Trinket: " .. atx .. " " .. aty)

				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 9,
					p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})

				entityplaced()
				count.trinkets = count.trinkets + 1
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1

				if not love.keyboard.isDown("v") then
					mousepressed = true
				end
			end
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 5 then
			-- Checkpoint
			cons("Checkpoint: " .. atx .. " " .. aty)

			if selectedsubtool[5] == 1 then
				-- Upright
				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 10,
					p1 = 1, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
			elseif selectedsubtool[5] == 2 then
				-- Upside down
				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 10,
					p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
			end

			entityplaced()
			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 6 then
			-- Disappearing platform
			cons("Disappear: " .. atx .. " " .. aty)

			table.insert(entitydata, count.entity_ai,
				{
				x = 40*roomx + atx,
				y = 30*roomy + aty,
				t = 3,
				p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
				data = ""
				})

			entityplaced()
			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 7 then
			-- Conveyor
			cons("Conveyor: " .. atx .. " " .. aty)

			table.insert(entitydata, count.entity_ai,
				{
				x = 40*roomx + atx,
				y = 30*roomy + aty,
				t = 2,
				p1 = 4+selectedsubtool[7], p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
				data = ""
				})

			entityplaced()
			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 8 then
			-- Moving platform
			if editingbounds == -2 then
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					oldbounds[k] = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
				end

				levelmetadata[(roomy)*20 + (roomx+1)].platx1, levelmetadata[(roomy)*20 + (roomx+1)].platy1 = atx*8, aty*8
				levelmetadata[(roomy)*20 + (roomx+1)].platx2, levelmetadata[(roomy)*20 + (roomx+1)].platy2 = 320, 240
				editingbounds = 2
			elseif editingbounds == 2 then
				levelmetadata[(roomy)*20 + (roomx+1)].platx2, levelmetadata[(roomy)*20 + (roomx+1)].platy2 = atx*8+8, aty*8+8
				editingbounds = 0

				local changeddata = {}
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					table.insert(changeddata,
						{
							key = "plat" .. v,
							oldvalue = oldbounds[k],
							newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
						}
					)
				end
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
				finish_undo("PLATFORM BOUNDS")
			else
				cons("Moving: " .. atx .. " " .. aty)

				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 2,
					p1 = -1+selectedsubtool[8], p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})

				entityplaced()
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 9 then
			-- Enemy
			if editingbounds == -1 then
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					oldbounds[k] = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
				end

				levelmetadata[(roomy)*20 + (roomx+1)].enemyx1, levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 = atx*8, aty*8
				levelmetadata[(roomy)*20 + (roomx+1)].enemyx2, levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = 320, 240
				editingbounds = 1
			elseif editingbounds == 1 then
				levelmetadata[(roomy)*20 + (roomx+1)].enemyx2, levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = atx*8+8, aty*8+8
				editingbounds = 0

				local changeddata = {}
				for k,v in pairs({"x1", "x2", "y1", "y2"}) do
					table.insert(changeddata,
						{
							key = "enemy" .. v,
							oldvalue = oldbounds[k],
							newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
						}
					)
				end
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
				finish_undo("ENEMY BOUNDS")
			else
				cons("Enemy: " .. atx .. " " .. aty)

				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 1,
					p1 = -1+selectedsubtool[9], p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})

				entityplaced()
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 10 then
			-- Gravity line
			if not issolid(roomdata[roomy][roomx][(aty*40)+(atx+1)], usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset], true, true) then
				cons("Gravity line: " .. atx .. " " .. aty)

				local p1, p2
				if selectedsubtool[10] == 1 then
					-- Horizontal
					p1, p2 = 0, atx
				else
					-- Vertical
					p1, p2 = 1, aty
				end

				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 11,
					p1 = p1, p2 = p2, p3 = 8, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})

				autocorrectlines()
				entityplaced()
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 11 then
			-- Roomtext
			if editingroomtext > 0 then
				-- We were already typing a text!
				endeditingroomtext()
			end

			cons("Roomtext: " .. atx .. " " .. aty)

			table.insert(entitydata, count.entity_ai,
				{
				x = 40*roomx + atx,
				y = 30*roomy + aty,
				t = 17,
				p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
				data = ""
				})

			editingroomtext = count.entity_ai
			newroomtext = true
			makescriptroomtext = false
			startinput()

			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 12 then
			-- Terminal
			if editingroomtext > 0 then
				-- We were already typing a text!
				endeditingroomtext()
			end

			cons("Terminal: " .. atx .. " " .. aty)

			table.insert(entitydata, count.entity_ai,
				{
				x = 40*roomx + atx,
				y = 30*roomy + aty,
				t = 18,
				p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
				data = ""
				})

			editingroomtext = count.entity_ai
			newroomtext = true
			makescriptroomtext = true
			startinput()

			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 13 then
			-- Script box
			cons("Script box: " .. atx .. " " .. aty)

			-- Subtool is changed in the background
			if selectedsubtool[13] == 1 then
				-- Placing top left corner.
				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 19,
					p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
				editingsboxid = count.entity_ai
				selectedsubtool[13] = 2

				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1

				mousepressed = true
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

				mousepressed = true
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

				mousepressed = true
			else
				cons("You tried placing the bottom right of a non-existant script box!")

				editingsboxid = nil
				selectedsubtool[13] = 1
			end

			--mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 14 then
			-- Warp token
			cons("Warp token: " .. atx .. " " .. aty)

			if selectedsubtool[14] == 1 or (selectedsubtool[14] == 2 and entitydata[warpid] == nil) then
				-- Placing entrance.
				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 13,
					p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
				warpid = count.entity_ai

				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1

				selectedsubtool[14] = 2
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
				end
				warpid = nil
				selectedsubtool[14] = 1
			else
				dialog.create(L.WHATDIDYOUDO .. "\n\n(warp token out of range subtool)")
			end

			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 15 then
			-- Warp line
			cons("Warp line: " .. atx .. " " .. aty)

			if not issolid(roomdata[roomy][roomx][(aty*40)+(atx+1)], usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset], true, true) then
				cons("Warp line: " .. atx .. " " .. aty)

				if atx == 0 or atx == 39 then
					-- Vertical left or right, type 0 or 1

					table.insert(entitydata, count.entity_ai,
						{
						x = 40*roomx + atx,
						y = 30*roomy + aty,
						t = 50,
						p1 = (atx == 0 and 0 or 1), p2 = aty, p3 = 8, p4 = 0, p5 = 320, p6 = 240,
						data = ""
						})
					autocorrectlines()
					entityplaced()
					count.entities = count.entities + 1
					count.entity_ai = count.entity_ai + 1

					mousepressed = true
				elseif aty == 0 or aty == 29 then
					-- Horizontal top or bottom, type 2 or 3

					table.insert(entitydata, count.entity_ai,
						{
						x = 40*roomx + atx,
						y = 30*roomy + aty,
						t = 50,
						p1 = (aty == 0 and 2 or 3), p2 = atx, p3 = 8, p4 = 0, p5 = 320, p6 = 240,
						data = ""
						})
					autocorrectlines()
					entityplaced()
					count.entities = count.entities + 1
					count.entity_ai = count.entity_ai + 1

					mousepressed = true
				end
			end

		elseif love.mouse.isDown("l") and not mousepressed and selectedtool == 16 then
			-- Rescuable crewmate				
			if count.crewmates >= 20 then
				dialog.create(L.MAXCREWMATES)
			else
				cons("Rescuable crewmate: " .. atx .. " " .. aty .. ", " .. selectedsubtool[selectedtool] .. " " .. anythingbutnil(({1, 2, 3, 4, 5, 0})[selectedsubtool[selectedtool]]))

				table.insert(entitydata, count.entity_ai,
					{
					x = 40*roomx + atx,
					y = 30*roomy + aty,
					t = 15,
					p1 = ({1, 2, 3, 4, 5, 0, math.random(0,5)})[selectedsubtool[selectedtool]], p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
				entityplaced()

				count.crewmates = count.crewmates + 1
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1
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
				table.insert(entitydata, count.entity_ai,
					{
					x = x,
					y = y,
					t = 16,
					p1 = p1, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
					data = ""
					})
				entityplaced()

				count.startpoint = count.entity_ai
				count.entities = count.entities + 1
				count.entity_ai = count.entity_ai + 1
			end


			mousepressed = true
		elseif love.mouse.isDown("l") and not mousepressed then
			dialog.create(L.UNSUPPORTEDTOOL .. anythingbutnil(selectedtool))
		end
	--[[
	elseif nodialog and love.mouse.isDown("r") and mouseon(64+64, 0, 639, 480) then
		atx = math.floor((love.mouse.getX()-64-64) / 16)
		aty = math.floor((love.mouse.getY()) / 16)

		cons("Tile cleared: " .. atx .. " " .. aty)

		roomdata[roomy][roomx][(aty*40)+(atx+1)] = 0
	]]
	elseif nodialog and love.mouse.isDown("m") and mouseon(screenoffset, 0, 639, 480) and tilespicker and not tilescreator and levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		local atx = math.floor((love.mouse.getX()-screenoffset) / 16)
		local aty = math.floor((love.mouse.getY()) / 16)

		cons("Tile selected: " .. (aty*40)+(atx+1)-1)

		selectedtile = (aty*40)+(atx+1)-1
	elseif nodialog and love.mouse.isDown("m") and mouseon(screenoffset, 0, 639, 480) and selectedtool <= 3 then --and levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1
		local atx = math.floor((love.mouse.getX()-screenoffset) / 16)
		local aty = math.floor((love.mouse.getY()) / 16)

		selectedtile = roomdata[roomy][roomx][(aty*40)+(atx+1)]
	end

	if tilespicker then
		local displaytilenumbers, displaysolid
		if nodialog and editingroomtext == 0 and not editingroomname then
			if love.keyboard.isDown("n") then
				love.graphics.setFont(tinynumbers)
				displaytilenumbers = true
			end
			if love.keyboard.isDown("j") then
				displaysolid = true
			end
		end

		local ts_name = tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]

		displaytilespicker(screenoffset, 0, ts_name, displaytilenumbers, displaysolid)
	else
		-- If we have gravity lines and such, make sure they don't go offscreen
		love.graphics.setScissor(screenoffset, 0, 640, 480)
		-- If we have room warping, then display that!
		if levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 1 or levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 2 then
			-- Horizontal/vertical warp direction.

			local tils = levelmetadata[(roomy)*20 + (roomx+1)].tileset
			local tilc = levelmetadata[(roomy)*20 + (roomx+1)].tilecol

			if levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 1 then
				love.graphics.draw(
					warpbgs[tilesetblocks[tils].colors[tilc].warpbg][1],
					screenoffset + (32-warpbganimation), 0
				)
			elseif levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 2 then
				love.graphics.draw(
					warpbgs[tilesetblocks[tils].colors[tilc].warpbg][2],
					screenoffset, 32-warpbganimation
				)
			end

			love.graphics.setColor(255,255,255,92)
		elseif levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 3 then
			-- Warping in all directions.

			local tils = levelmetadata[(roomy)*20 + (roomx+1)].tileset
			local tilc = levelmetadata[(roomy)*20 + (roomx+1)].tilecol

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


		--[[
		cons("Using room " .. (roomy)*20 + (roomx+1))
		for k,v in pairs(levelmetadata[(roomy)*20 + (roomx+1)]) do
			cons(k .. "->" .. v)
		end
		]]
		local displaytilenumbers, displaysolid
		if nodialog and editingroomtext == 0 and not editingroomname and not keyboard_eitherIsDown(ctrl) then
			if love.keyboard.isDown("n") then
				love.graphics.setFont(tinynumbers)
				displaytilenumbers = true
			end
			if love.keyboard.isDown("j") then
				displaysolid = true
			end
		end
		-- Display the room now including its entities
		displayroom(screenoffset, 0, roomdata[roomy][roomx], levelmetadata[(roomy)*20 + (roomx+1)], nil, displaytilenumbers, displaysolid)

		-- Display indicators for tiles in adjacent rooms
		if s.adjacentroomlines then
			local roomupW, roomleftW, roomrightW, roomdownW = false, false, false, false
			local roomup, roomleft, roomright, roomdown

			-- Room up. I now notice the bug in the code for switching rooms but it works 100% which is kind of unique to have
			if levelmetadata[roomy*20 + (roomx+1)].warpdir == 2 or levelmetadata[roomy*20 + (roomx+1)].warpdir == 3 then
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
			if levelmetadata[roomy*20 + (roomx+1)].warpdir == 1 or levelmetadata[roomy*20 + (roomx+1)].warpdir == 3 then
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
			if levelmetadata[roomy*20 + (roomx+1)].warpdir == 1 or levelmetadata[roomy*20 + (roomx+1)].warpdir == 3 then
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
			if levelmetadata[roomy*20 + (roomx+1)].warpdir == 2 or levelmetadata[roomy*20 + (roomx+1)].warpdir == 3 then
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
				if issolid(roomdata[roomup][roomx][t+1161], usedtilesets[levelmetadata[(roomup)*20 + (roomx+1)].tileset]) then
					--love.graphics.line(64+64+(t*16) +1, 0, 64+64+(t*16)+15, 0)
					--love.graphics.line(64+64+(t*16) +1, 1, 64+64+(t*16)+15, 1)

					if roomupW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.draw(sideimg, sideline[1], screenoffset+(t*16), 0, 0, 2)

					if roomupW then
						love.graphics.setColor(255, 255, 255)
					end
				elseif not roomupW and ( (levelmetadata[(roomup)*20 + (roomx+1)].warpdir == 2) or (levelmetadata[(roomup)*20 + (roomx+1)].warpdir == 3) ) then
					love.graphics.draw(smallsideimg, smallsideline[1], screenoffset+(t*16), 0, 0, 1)
				end

				-- Spikes
				if issolid(roomdata[roomup][roomx][t+1161], usedtilesets[levelmetadata[(roomup)*20 + (roomx+1)].tileset], false) ~= issolid(roomdata[roomup][roomx][t+1161], usedtilesets[levelmetadata[(roomup)*20 + (roomx+1)].tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomupW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.draw(sideimg, sideline[1], screenoffset+(t*16), 0, 0, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Left
			for t = 1, 30 do
				-- Wall
				if issolid(roomdata[roomy][roomleft][t*40], usedtilesets[levelmetadata[(roomy)*20 + (roomleft+1)].tileset]) then
					--love.graphics.line(64+64, (t-1)*16 +1, 64+64, (t-1)*16 +15)
					--love.graphics.line(64+64+1, (t-1)*16 +1, 64+64+1, (t-1)*16 +15)

					if roomleftW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.draw(sideimg, sideline[2], screenoffset, (t-1)*16, 0, 2)

					if roomleftW then
						love.graphics.setColor(255, 255, 255)
					end
				elseif not roomleftW and ( (levelmetadata[(roomy)*20 + (roomleft+1)].warpdir == 1) or (levelmetadata[(roomy)*20 + (roomleft+1)].warpdir == 3) ) then
					love.graphics.draw(smallsideimg, smallsideline[2], screenoffset, (t-1)*16, 0, 1)
				end

				-- Spikes
				if issolid(roomdata[roomy][roomleft][t*40], usedtilesets[levelmetadata[(roomy)*20 + (roomleft+1)].tileset], false) ~= issolid(roomdata[roomy][roomleft][t*40], usedtilesets[levelmetadata[(roomy)*20 + (roomleft+1)].tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomleftW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.draw(sideimg, sideline[2], screenoffset, (t-1)*16, 0, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Right
			for t = 0, 29 do
				-- Wall
				if issolid(roomdata[roomy][roomright][t*40 + 1], usedtilesets[levelmetadata[(roomy)*20 + (roomright+1)].tileset]) then

					if roomrightW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.draw(sideimg, sideline[3], screenoffset+(39*16), t*16, 0, 2)

					if roomrightW then
						love.graphics.setColor(255, 255, 255)
					end

				elseif not roomrightW and ( (levelmetadata[(roomy)*20 + (roomright+1)].warpdir == 1) or (levelmetadata[(roomy)*20 + (roomright+1)].warpdir == 3) ) then
					love.graphics.draw(smallsideimg, smallsideline[3], screenoffset+(39*16), t*16, 0, 1)
				end

				-- Spikes
				if issolid(roomdata[roomy][roomright][t*40 + 1], usedtilesets[levelmetadata[(roomy)*20 + (roomright+1)].tileset], false) ~= issolid(roomdata[roomy][roomright][t*40 + 1], usedtilesets[levelmetadata[(roomy)*20 + (roomright+1)].tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomrightW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.draw(sideimg, sideline[3], screenoffset+(39*16), t*16, 0, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
			-- Down
			for t = 0, 39 do
				-- Wall
				if issolid(roomdata[roomdown][roomx][t + 1], usedtilesets[levelmetadata[(roomdown)*20 + (roomx+1)].tileset]) then

					if roomdownW then
						love.graphics.setColor(0, 192, 255)
					end

					love.graphics.draw(sideimg, sideline[4], screenoffset+(t*16), 29*16, 0, 2)

					if roomdownW then
						love.graphics.setColor(255, 255, 255)
					end

				elseif not roomdownW and ( (levelmetadata[(roomdown)*20 + (roomx+1)].warpdir == 2) or (levelmetadata[(roomdown)*20 + (roomx+1)].warpdir == 3) ) then
					love.graphics.draw(smallsideimg, smallsideline[4], screenoffset+(t*16), 29*16, 0, 1)
				end

				-- Spikes
				if issolid(roomdata[roomdown][roomx][t + 1], usedtilesets[levelmetadata[(roomdown)*20 + (roomx+1)].tileset], false) ~= issolid(roomdata[roomdown][roomx][t + 1], usedtilesets[levelmetadata[(roomdown)*20 + (roomx+1)].tileset], true) then
					love.graphics.setColor(255, 0, 0)

					if roomdownW then
						love.graphics.setColor(255, 192, 0)
					end

					love.graphics.draw(sideimg, sideline[4], screenoffset+(t*16), 29*16, 0, 2)

					love.graphics.setColor(255, 255, 255)
				end
			end
		end

		love.graphics.setFont(font8)
		displayentities(screenoffset, 0, roomx, roomy)

		-- Now display bounds! Enemies first...
		if showepbounds or editingbounds ~= 0 then
			if not (levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 == 0 and levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 == 0 and levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 == 320 and levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 == 240) then
				love.graphics.setColor(255,0,0,255)
				love.graphics.rectangle("line",
					screenoffset+(levelmetadata[(roomy)*20 + (roomx+1)].enemyx1*2),
					levelmetadata[(roomy)*20 + (roomx+1)].enemyy1*2,
					((levelmetadata[(roomy)*20 + (roomx+1)].enemyx2-levelmetadata[(roomy)*20 + (roomx+1)].enemyx1)*2),
					(levelmetadata[(roomy)*20 + (roomx+1)].enemyy2-levelmetadata[(roomy)*20 + (roomx+1)].enemyy1)*2
				)
			end

			-- Then platforms.
			if not (levelmetadata[(roomy)*20 + (roomx+1)].platx1 == 0 and levelmetadata[(roomy)*20 + (roomx+1)].platy1 == 0 and levelmetadata[(roomy)*20 + (roomx+1)].platx2 == 320 and levelmetadata[(roomy)*20 + (roomx+1)].platy2 == 240) then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("line",
					screenoffset+(levelmetadata[(roomy)*20 + (roomx+1)].platx1*2),
					levelmetadata[(roomy)*20 + (roomx+1)].platy1*2,
					((levelmetadata[(roomy)*20 + (roomx+1)].platx2-levelmetadata[(roomy)*20 + (roomx+1)].platx1)*2),
					(levelmetadata[(roomy)*20 + (roomx+1)].platy2-levelmetadata[(roomy)*20 + (roomx+1)].platy1)*2
				)
			end
		end


		love.graphics.setColor(255,255,255,255)

		love.graphics.setScissor()

		--local multispikesmsg = levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 and selectedtool == 3
		local editingcustomsize = selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0

		-- Does this room have a name, perhaps?
		if temporaryroomnametimer > 0 or editingbounds ~= 0 or editingcustomsize then --or multispikesmsg
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
			--elseif multispikesmsg then
				--temporaryroomname = "To fix: spikes tool in multi mode"
			end

			-- Is the text we're displaying going to fit?
			local extralines = roomtext_extralines(temporaryroomname)

			love.graphics.setColor(160,160,0,128)
			love.graphics.rectangle("fill", screenoffset, 29*16 - extralines*16 - 4, 40*16, 16 + extralines*16 + 4)
			love.graphics.setColor(255,255,255,255)
			love.graphics.setFont(font16)
			love.graphics.printf(temporaryroomname, screenoffset, 29*16 +3 - extralines*16 - 2, 40*16, "center")
			love.graphics.setFont(font8)
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
			love.graphics.setFont(font16)
			love.graphics.printf(text, screenoffset, 29*16 +3 - extralines*16 - 2, 40*16, "center")
			love.graphics.setFont(font8)
		elseif levelmetadata[(roomy)*20 + (roomx+1)].roomname ~= "" then
			-- Display it
			local text = levelmetadata[(roomy)*20 + (roomx+1)].roomname
			local textx = (screenoffset+320)-(font16:getWidth(text)/2)

			love.graphics.setColor(0,0,0,s.opaqueroomnamebackground and 255 or 128)
			love.graphics.rectangle("fill", screenoffset, 29*16-4, 40*16, 16+4)
			love.graphics.setColor(255,255,255,255)
			love.graphics.setFont(font16)
			love.graphics.setScissor(screenoffset, 29*16-2, 40*16, 16)
			love.graphics.print(text, textx, 29*16 +3-2)
			love.graphics.setScissor()
			love.graphics.setFont(font8)
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
			if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then else
				-- Just one tile, but only in manual/direct mode.
				love.graphics.draw(cursorimg[0], (cursorx*16)+screenoffset, (cursory*16))
			end
		elseif movingentity > 0 and entitydata[movingentity] ~= nil then
			displayentity(
				screenoffset, 0, roomx, roomy, movingentity, entitydata[movingentity],
				cursorx, cursory,
				false, false, {}, false, false
			)
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
			if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
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
		love.graphics.rectangle("fill", 0, 0, 128, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		love.graphics.setScissor(16, 16, 32+4, love.graphics.getHeight()-32)

		for t = 1, 17 do
			-- love.graphics.rectangle("fill", 16, (16+(48*(t-1)))+lefttoolscroll, 32, 32)
			-- Are we hovering over it? Or maybe even clicking it?
			if not nodialog or ((mouseon(16, 0, 32, 16)) or (mouseon(16, love.graphics.getHeight()-16, 32, 16)) or (not mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32))) and selectedtool ~= t then
				love.graphics.setColor(255,255,255,128)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32) and not mouseon(16, 0, 32, 16) and not mouseon(16, love.graphics.getHeight()-16, 32, 16) and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
				selectedtool = t
				updatewindowicon()
			end

			if nodialog and not mousepressed and love.mouse.isDown("r") and t == 17 and mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32) and not mouseon(16, 0, 32, 16) and not mouseon(16, love.graphics.getHeight()-16, 32, 16) then
				-- Find the start point
				gotostartpointroom()
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
				-- Ugh this code but we're hovering over it. So display a tooltip, but don't let it get snipped away by the scissors.
				love.graphics.setScissor()
				love.graphics.setColor(128,128,128,192)
				love.graphics.rectangle("fill", love.mouse.getX()+15, love.mouse.getY()-10, font8:getWidth(toolnames[t]), 8) -- string.len(toolnames[t])*8
				love.graphics.setColor(255,255,255,255)
				love.graphics.print(toolnames[t], love.mouse.getX()+16, love.mouse.getY()-8)
				love.graphics.setScissor(16, 16, 32+4, love.graphics.getHeight()-32)
			end
		end

		toolfinish({coorx, coory, selectedtool})

		-- We're done with that now, but now we have an area with subtools.
		love.graphics.setScissor(16+64, 16, 32+4, love.graphics.getHeight()-32)

		-- Allow for more than 9 subtools without scrolling, up to 13.
		local subtoolheight = 48
		if (#subtoolimgs[selectedtool] > 9) then
			local n_subtools = #subtoolimgs[selectedtool]
			subtoolheight = (416-n_subtools*32)/(n_subtools-1)+32
		end

		for k,v in pairs(subtoolimgs[selectedtool]) do
			-- Are we hovering over it? Or maybe even clicking it?
			if not nodialog or (selectedtool == 14 and selectedsubtool[selectedtool] ~= k) then
				love.graphics.setColor(255,255,255,128)
			elseif not nodialog or ((mouseon(16+64, 0, 32, 16)) or (mouseon(16+64, love.graphics.getHeight()-16, 32, 16)) or (not mouseon(16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll, 32, 32))) and selectedsubtool[selectedtool] ~= k then
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
			if (selectedtool <= 3 or selectedtool == 5 or (selectedtool >= 7 and selectedtool <= 10)) and k >= 2 and k <= 9 then
				tinyprint((" ZXCVHB F"):sub(k,k), coorx-2+32+1, coory)
			end

			if nodialog and ((not mouseon(16+64, 0, 32, 16)) and not (mouseon(16+64, love.graphics.getHeight()-16, 32, 16)) and (mouseon(16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll, 32, 32))) then
				-- Ugh this code but we're hovering over it. So display a tooltip, but don't get snipped away by the scissors.
				local tooltip_text = anythingbutnil(subtoolnames[selectedtool][k])
				if selectedtool <= 2 and k == 8 then
					tooltip_text = tooltip_text .. "\n" .. L.RESETCUSTOMBRUSH
				end
				love.graphics.setScissor()
				love.graphics.setColor(128,128,128,192)
				love.graphics.rectangle("fill", love.mouse.getX()+15, love.mouse.getY()-10, font8:getWidth(tooltip_text), 8+(tooltip_text:find("\n") ~= nil and 8 or 0))
				love.graphics.setColor(255,255,255,255)
				love.graphics.print(tooltip_text, love.mouse.getX()+16, love.mouse.getY()-8)
				love.graphics.setScissor(16+64, 16, 32+4, love.graphics.getHeight()-32)
			end
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
			tinyprint(L.TINY_SHIFT, 128-tinynumbers:getWidth(L.TINY_SHIFT), love.graphics.getHeight()-7)
		elseif editingroomtext > 0 and entitydata[editingroomtext] ~= nil and (entitydata[editingroomtext].t == 18 or entitydata[editingroomtext].t == 19) then
			-- Name for script box
			local tinywidth = math.max(tinynumbers:getWidth("{" .. L.TINY_SHIFT), tinynumbers:getWidth("}" .. L.TINY_CTRL))
			tinyprint("{" .. L.TINY_SHIFT, 128-tinywidth, love.graphics.getHeight()-14)
			tinyprint("}" .. L.TINY_CTRL, 128-tinywidth, love.graphics.getHeight()-7)
		end

		hoverdraw((eraserlocked and eraseroff or eraseron), 88, 0, 16, 16)

		if not mousepressed and nodialog and love.mouse.isDown("l") and mouseon(88, 0, 16, 16) then
			eraserlocked = not eraserlocked
			mousepressed = true
		end
	else
		-- Still have a background, in case we have a brush that's so big it overlaps with this part of the screen
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 32, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
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
	love.graphics.rectangle("fill", love.graphics.getWidth()-128, 0, 128, love.graphics.getHeight())
	love.graphics.setColor(255,255,255,255)
	hoverdraw(helpbtn, love.graphics.getWidth()-120, 8, 16, 16, 1) -- -128+8 => -120
	hoverdraw(newbtn, love.graphics.getWidth()-96, 0, 32, 32, 2)
	hoverdraw(loadbtn, love.graphics.getWidth()-64, 0, 32, 32, 2)
	hoverdraw(savebtn, love.graphics.getWidth()-32, 0, 32, 32, 2)

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
	hoverdraw(cutbtn, love.graphics.getWidth()-120+64, 40, 16, 16, 1)
	hoverdraw(copybtn, love.graphics.getWidth()-120+80, 40, 16, 16, 1)
	hoverdraw(pastebtn, love.graphics.getWidth()-120+96, 40, 16, 16, 1)

	--rbutton((upperoptpage2 and L.UNDO or L.VEDOPTIONS), 0, 40, false, 20)
	rbutton((upperoptpage2 and L.VEDOPTIONS or L.LEVELOPTIONS), 1, 40, false, 20)
	rbutton((upperoptpage2 and {L.COMPARE, "cD"} or {L.MAP, "M"}), 2, 40, false, 20)
	rbutton((upperoptpage2 and L.STATS or {L.SCRIPTS, "/"}), 3, 40, false, 20)
	if not upperoptpage2 then
		rbutton({L.SEARCH, "cF"}, 4, 40, false, 20)
		rbutton({L.LEVELNOTEPAD, "c/"}, 5, 40, false, 20)
	end
	rbutton((upperoptpage2 and L.BACKB or L.MOREB), 6, 40, false, 20)

	-- When adding an extra button for layers mode or something like that, and the buttons needs to be squished, just set this to true and then hardcode it. Not for plugins though
	local additionalbutton = false
	local additionalbutton_np = additionalbutton and 1 or 0
	local additionalbutton_yoffset = additionalbutton and 166 or 164
	local additionalbutton_spacing = additionalbutton and 20 or 24

	if additionalbutton then
		rbutton("...", 0, 166, true, 20)
	end

	rbutton(fontpng_works and L.ROTATE180 or L.ROTATE180UNI, 0+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) -- (roomoptpage2 and L.BACKB or L.MOREB)
	rbutton({(levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 and L.MANUALMODE or (levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 and L.AUTO2MODE or L.AUTOMODE)), "p"}, 1+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)

	rbutton((showepbounds and L.HIDEBOUNDS or L.SHOWBOUNDS), 2+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	rbutton({langkeys(L.WARPDIR, {warpdirs[levelmetadata[(roomy)*20 + (roomx+1)].warpdir]}), "W"}, 3+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	rbutton({L.ROOMNAME, "E"}, 4+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing, editingroomname) -- (6*16)+16+24+12+16

	love.graphics.printf(L.ROOMOPTIONS, love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-300)+10, 128-16, "center") -- -(6*16)-16-24-12-8-(24*6))+4+2+4 => -300)+10

	-- Well make them actually do something!
	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-120, 8, 16, 16) then
			-- Help
			tostate(15)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-96, 0, 32, 32) then
			-- New
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
			tostate(6)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-32, 0, 32, 32) then
			-- Save
			--tostate(8)
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
		elseif onrbutton(6, 40, false, 20) then
			-- Pages
			upperoptpage2 = not upperoptpage2

			mousepressed = true

		-- Room options now
		elseif additionalbutton and onrbutton(0, 166, true, 20) then
			-- ...

		elseif onrbutton(0+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Rotate
			rotateroom180(roomx, roomy)
			if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
				autocorrectroom()
			end
			mousepressed = true
		elseif onrbutton(1+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Direct mode on or off
			changedmode()

			mousepressed = true
		elseif onrbutton(2+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Show bounds
			showepbounds = not showepbounds

			mousepressed = true
		elseif onrbutton(3+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Warp dir
			changewarpdir()

			mousepressed = true
		elseif onrbutton(4+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing) then
			-- Roomname
			toggleeditroomname()

			mousepressed = true
		end

		-- Gewoon overal??
		--mousepressed = true
		-- Nee want dan kun je hieronder geen klikken meer opvangen
	end

	-- We also have buttons for enemy and platform settings!
	if selectedtool == 8 or selectedtool == 9 then
		rbutton((selectedtool == 8 and {L.PLATFORMBOUNDS, "t"} or {L.ENEMYBOUNDS, "r"}), -3, 164+4, true, nil, editingbounds ~= 0)
		rbutton((selectedtool == 8 and langkeys(L.PLATFORMSPEED, {levelmetadata[(roomy)*20 + (roomx+1)].platv}) or {langkeys(L.ENEMYTYPE, {levelmetadata[(roomy)*20 + (roomx+1)].enemytype}), "e"}), -2, 164+4, true)

		love.graphics.printf((selectedtool == 8 and L.ROOMPLATFORMS or L.ROOMENEMIES), love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-156)+6, 128-16, "center") -- hier is 4 afgegaan. ---- -(6*16)-16-24-12-8-(24*0))+4+2 => -156)+6

		local changedplatv, oldplatv = false, levelmetadata[(roomy)*20 + (roomx+1)].platv

		-- They should work
		if not mousepressed and nodialog and love.mouse.isDown("l") then
			if onrbutton(-3, 164+4, true) then
				-- Enemy/platform bounds
				if selectedtool == 9 then
					-- Enemy.
					changeenemybounds()
				else
					-- Platform.
					changeplatformbounds()
				end

				mousepressed = true
			elseif onrbutton(-2, 164+4, true) then
				-- Enemy type // Platform speed
				if selectedtool == 9 then
					-- Enemy type
					switchenemies()
				else
					-- Platform speed
					changedplatv = true
					levelmetadata[(roomy)*20 + (roomx+1)].platv = cycle(levelmetadata[(roomy)*20 + (roomx+1)].platv, 8, 0)
				end

				mousepressed = true
			end
		end

		if selectedtool == 8 and nodialog and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), love.graphics.getHeight()-136, 128-16, 16) and not mousepressed then -- -(6*16)-16-24-12-8-(24*-1)-4 => -136
			changedplatv = true
			levelmetadata[(roomy)*20 + (roomx+1)].platv = 4
			mousepressed = true
		end

		if changedplatv then
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
						{
							key = "platv",
							oldvalue = oldplatv,
							newvalue = levelmetadata[(roomy)*20 + (roomx+1)].platv
						}
					},
					switchtool = 8
				}
			)
			finish_undo("PLATV")
		end
	end

	-- And coordinates.
	love.graphics.setColor(128,128,128)
	if s.coords0 then
		tinyprint("0", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		love.graphics.printf("(" .. roomx .. "," .. roomy .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-8, 56, "right")
	else
		tinyprint("1", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		love.graphics.printf("(" .. (roomx+1) .. "," .. (roomy+1) .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-8, 56, "right")
	end

	-- But if we're in the tiles picker instead display the tile we're hovering on!
	if tilespicker then
		if (cursorx ~= "--") and (cursory ~= "--") then
			love.graphics.printf(
				langkeys(L.TILE, {(cursory*40)+(cursorx+1)-1}),
				love.graphics.getWidth()-128, love.graphics.getHeight()-8-8, 128, "right"
			)
			love.graphics.printf(
				(issolid((cursory*40)+(cursorx+1)-1, usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]) and L.SOLID or L.NOTSOLID),
				love.graphics.getWidth()-128, love.graphics.getHeight()-8, 128, "right"
			)
		else
			love.graphics.printf(langkeys(L.TILE, {"----"}), love.graphics.getWidth()-128, love.graphics.getHeight()-8-8, 128, "right")
		end
	else
		love.graphics.printf("[" .. cursorx .. "," .. cursory .. "]", love.graphics.getWidth()-56, love.graphics.getHeight()-8-8, 56, "right")
		if (cursorx ~= "--") and (cursory ~= "--") then
			love.graphics.printf("<" .. (cursorx*8) .. "," .. (cursory*8) .. ">", love.graphics.getWidth()-72, love.graphics.getHeight()-8, 72, "right") -- 56+16=72
		else
			love.graphics.printf("<---,--->", love.graphics.getWidth()-72, love.graphics.getHeight()-8, 72, "right")
		end
	end

	-- Also display a smaller tiles picker for semi-undirect mode
	if selectedtool <= 3 then
		love.graphics.rectangle("fill", love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-157, (6*16)+2, (5*16)+2) -- -(6*16)-16-24-12-1-8 => -157
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle("fill", love.graphics.getWidth()-(7*16), love.graphics.getHeight()-156, (6*16), (5*16)) -- -(6*16)-16-24-12-8 => -156
		love.graphics.setColor(255,255,255,255)
		--if selectedtool <= 3 then
		displaysmalltilespicker(love.graphics.getWidth()-(7*16), love.graphics.getHeight()-156, selectedtileset, selectedcolor) -- -(6*16)-16-24-12-8 => -156
	end

	-- And text below it.
	--[[
	hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-32-2, (6*16), 8)
	love.graphics.print("<tiles2.png>", love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-32)
	]]

	hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-70, (6*16), 8+4) -- -16-32-2-12-8 => -70
	love.graphics.printf((tilesetblocks[selectedtileset].name ~= nil and tilesetblocks[selectedtileset].name or selectedtileset), love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-32-12+2-8, 6*16, "center")

	hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-24-2-8-8, (6*16), 8+4)
	love.graphics.printf((tilesetblocks[selectedtileset].colors[selectedcolor].name ~= nil and tilesetblocks[selectedtileset].colors[selectedcolor].name or langkeys(L.TSCOLOR, {selectedcolor})), love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-24-8+2-8, 6*16, "center")

	if love.mouse.isDown("l") and nodialog and not mousepressed and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-70, (6*16), 8+4) then -- -16-32-2-12-8 => -70
		-- Switch tileset
		switchtileset()
		mousepressed = true
	elseif love.mouse.isDown("l") and nodialog and not mousepressed and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-58, (6*16), 8+4) then -- -16-24-2-8-8 => 58
		-- Switch tilecol
		switchtilecol()
		mousepressed = true
	end

	hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-46, (6*16), 8+4) -- -16-16-2-4-8 => -46
	love.graphics.printf(tilespicker and L.HIDEALL or L.SHOWALL, love.graphics.getWidth()-(7*16), love.graphics.getHeight()-42, 6*16, "center") -- -16-16-4+2-8 => -42

	-- Some text below the tiles picker-- how many trinkets and crewmates do we have?
	--love.graphics.printf("Trinkets: " .. anythingbutnil(count.trinkets) .. "/20\nCrewmates: " .. anythingbutnil(count.crewmates) .. "/20", 768, love.graphics.getHeight()-(6*16)-16-24-12-16, 128, "right")
	love.graphics.printf(L.ONETRINKETS .. fixdige(anythingbutnil(count.trinkets), 2, "", "!") .. (not tilespicker and "/20" or "") .. "\n" .. L.ONECREWMATES .. fixdige(anythingbutnil(count.crewmates), 2, "", "!") .. (not tilespicker and "/20" or "") .. "\n" .. L.ONEENTITIES .. fixdig(anythingbutnil(count.entities), 5, ""), 640+screenoffset, love.graphics.getHeight()-16-8, 128, "left")


	-- Dropdown for tileset?
	--[[
	if dropdown == 1 then
		--[ [
		love.graphics.print([ [-1-
		 Space St.
		-2-
		 Outside
		 Lab
		 Warp Zone
		 Ship] ], love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-32-2-12-56)
		 ] ]
		if not nodialog then
			rightclickmenu.create({"#1", "Space St.", "#2", "Outside", "Lab", "Warp Zone", "Ship"}, "tileset")
		end
	elseif dropdown == 2 then

	end
	]]

	if coordsdialog.active then
		coordsdialog.draw()
	end

	-- Do we want to see room metadata?
	if allowdebug and love.keyboard.isDown("f11") then

	end
end
