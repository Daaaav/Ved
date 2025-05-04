-- maineditor/draw

return function()
	love.graphics.setColor(128,128,128)
	love.graphics.rectangle("line", screenoffset-0.5, -0.5, 640+1, 480+1)
	love.graphics.setColor(255,255,255)

	if tilespicker then
		local displaytilenumbers, displaysolid
		if nodialog then
			if love.keyboard.isDown("n") then
				displaytilenumbers = true
			end
			if love.keyboard.isDown("j") then
				displaysolid = true
			end
		end

		local ts_name = tileset_names[levelmetadata_get(roomx, roomy).tileset]

		displaytilespicker(screenoffset, 0, ts_name, tilespicker_page, displaytilenumbers, displaysolid)
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
					screenoffset + (32-math.floor(warpbganimation)), 0
				)
			elseif levelmetadata_get(roomx, roomy).warpdir == 2 then
				love.graphics.draw(
					warpbgs[tilesetblocks[tils].colors[tilc].warpbg][2],
					screenoffset, 32-math.floor(warpbganimation)
				)
			end

			love.graphics.setColor(255,255,255,92)
		elseif levelmetadata_get(roomx, roomy).warpdir == 3 then
			-- Warping in all directions.

			local tils = levelmetadata_get(roomx, roomy).tileset
			local tilc = levelmetadata_get(roomx, roomy).tilecol

			for squarel = 11, 0, -1 do
				-- Centerx: 128+320 = 448
				local side = (squarel-1)*64 + (math.floor(warpbganimation)*2)

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

		love.graphics.draw(image.bggrid, screenoffset, 0)

		love.graphics.setColor(255,255,255,255)


		local displaytilenumbers, displaysolid, displayminimapgrid
		if nodialog and editingroomtext == 0 and not editingroomname and not keyboard_eitherIsDown(ctrl) then
			if love.keyboard.isDown("n") then
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
		local showroom = not (love.keyboard.isDown(";") and keyboard_eitherIsDown("shift")) or love.mouse.isDown("l") or love.mouse.isDown("m") or love.mouse.isDown("r") or not nodialog or RCMactive or editingroomtext > 0 or editingroomname
		if showroom then
			displayroom(screenoffset, 0, roomdata_get(roomx, roomy), levelmetadata_get(roomx, roomy), nil, displaytilenumbers, displaysolid, displayminimapgrid, s.adjacentroomlines)
		end

		local hasroomname = levelmetadata_get(roomx, roomy).roomname:gsub(" ", "") ~= ""
		local overwritename = temporaryroomnametimer > 0 or editingbounds ~= 0 or editingcustomsize
		if showroom then
			displayentities(screenoffset, 0, roomx, roomy, overwritename or not hasroomname)
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
				temporaryroomname = L.BOUNDSFIRST
			elseif editingbounds > 0 then
				temporaryroomname = L.BOUNDSLAST
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
			local font_height = font_ui:getHeight()
			local box_height = 2 * (font_height + extralines*font_height) + 4

			love.graphics.setColor(160,160,0,128)
			love.graphics.rectangle("fill", screenoffset, 480-box_height, 40*16, box_height)
			love.graphics.setColor(255,255,255,255)
			font_ui:shadowprintf(temporaryroomname, screenoffset, 480-box_height+2, 40*16, "center", "cjk_low", 2)
		elseif editingroomname or hasroomname then
			local text
			local bg_color
			local bg_alpha
			if editingroomname then
				-- We're editing this room name!
				text = inputs.roomname
				bg_color = 128
			else
				text = levelmetadata_get(roomx, roomy).roomname
				bg_color = 0
			end
			if s.opaqueroomnamebackground then
				bg_alpha = 255
			else
				bg_alpha = 128
			end
			local text_width = math.min(font_level:getWidth(text)*2, 640)
			local font_height = font_level:getHeight()
			local box_height
			if font_height <= 8 then
				box_height = 2 * (font_height + 2)
			else
				box_height = 2 * (font_height + 1)
			end
			local text_x = screenoffset + 320 - text_width/2
			local text_y = 480 - box_height + 2

			love.graphics.setScissor(screenoffset, text_y - 2, 40*16, box_height)
			love.graphics.setColor(bg_color, bg_color, bg_color, bg_alpha)
			love.graphics.rectangle("fill", screenoffset, text_y - 2, 40*16, box_height)
			v6_setroomprintcol()
			font_level:shadowprint(text, text_x, text_y, "cjk_low", 2)
			love.graphics.setColor(255,255,255,255)
			newinputsys.drawcas("roomname", text_x, text_y, font_level, "cjk_low", 2)
			love.graphics.setScissor()
		end

		-- Display the bottom 2 rows of roomtexts ABOVE the roomname
		if hasroomname and not overwritename then
			displaybottom2rowstexts(screenoffset, 0, roomx, roomy)
		end
	end

	-- Now display the cursor. If it's on the level
	if nodialog and mouseon(screenoffset, 0, 639, 480) and not editingroomname and editingroomtext == 0 then
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
			local ts = tilesets[tileset_names[selectedtileset]]
			local tile = ((tilespicker_page*30+cursory)*ts.tiles_width_picker)+cursorx

			if levelmetadata_get(roomx, roomy).directmode ~= 0
			and cursorx < ts.tiles_width_picker
			and cursory < ts.tiles_height_picker
			and tile < ts.total_tiles then
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
				16*cursory
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
				print_tile_number(selectedtile, screenoffset+(16*cursorx), (16*cursory))
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
		love.graphics.rectangle("fill", 0, 0, 127, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		love.graphics.setScissor(16, 16, 32 + 4 + 10, love.graphics.getHeight()-32)

		local thistooltip = ""
		local coorx, coory

		for t = 1, 17 do
			-- love.graphics.rectangle("fill", 16, (16+(48*(t-1)))+lefttoolscroll, 32, 32)
			-- Are we hovering over it? Or maybe even clicking it?
			if not nodialog or ((mouseon(16, 0, 32, 16)) or (mouseon(16, love.graphics.getHeight()-16, 32, 16)) or (not mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32))) and selectedtool ~= t then
				love.graphics.setColor(255,255,255,128)
			elseif not window_active() then
				love.graphics.setColor(255,255,255,128)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, (16+(48*(t-1)))+lefttoolscroll, 32, 32) and not mouseon(16, 0, 32, 16) and not mouseon(16, love.graphics.getHeight()-16, 32, 16) then
				cancel_placing_scriptbox()
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
				love.graphics.draw(image.selectedtool,  16, (16+(48*(t-1)))+lefttoolscroll)
			else
				love.graphics.draw(image.unselectedtool,  16, (16+(48*(t-1)))+lefttoolscroll)
			end

			coorx = 16+2
			coory = (16+2+(48*(t-1)))+lefttoolscroll

			love.graphics.draw(toolimg[t], coorx, coory)
			love.graphics.setColor(255,255,255,255)

			-- Put the shortcut next to it.
			tinyfont:print(toolshortcuts[t], coorx-2+32+1, coory)

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
				love.graphics.draw(image.selectedtool,  16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll)
			else
				love.graphics.draw(image.unselectedtool,  16+64, (16+(subtoolheight*(k-1)))+leftsubtoolscroll)
			end

			coorx = 16+64+2
			coory = (16+2+(subtoolheight*(k-1)))+leftsubtoolscroll

			-- v = subtoolimgs[selectedtool][k]
			love.graphics.draw(v, coorx, coory)
			love.graphics.setColor(255,255,255,255)

			-- Shortcut text, but only for ZXCV
			if (selectedtool <= 3 or selectedtool == 5 or (selectedtool >= 7 and selectedtool <= 10) or selectedtool == 12) and k >= 2 and k <= 9 then
				tinyfont:print(({"", "Z", "X", "C", "V", "H", "B", "", "F"})[k], coorx-2+32+1, coory)
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
			local atx, aty
			if nodialog then
				atx, aty = maineditor_get_cursor()
			end
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
		hoverdraw(image.scrollup, 16, 0, 32, 16)
		hoverdraw(image.scrolldn, 16, love.graphics.getHeight()-16, 32, 16)

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
			local tinywidth = tinyfont:getWidth(L.TINY_SHIFT)
			love.graphics.setColor(0, 0, 0, 224)
			love.graphics.rectangle("fill", 128-tinywidth-1, love.graphics.getHeight()-8, tinywidth+2, 9)
			love.graphics.setColor(255,255,0,255)
			tinyfont:print(L.TINY_SHIFT, 128-tinywidth, love.graphics.getHeight()-7)
			love.graphics.setColor(255,255,255,255)
		elseif editingroomtext > 0
		and entitydata[editingroomtext] ~= nil
		and (entitydata[editingroomtext].t == 18 or entitydata[editingroomtext].t == 19) then
			-- Name for script box
			local tinywidth = math.max(tinyfont:getWidth("{" .. L.TINY_SHIFT), tinyfont:getWidth("}" .. L.TINY_CTRL))
			love.graphics.setColor(0, 0, 0, 224)
			love.graphics.rectangle("fill", 128-tinywidth-1, love.graphics.getHeight()-15, tinywidth+2, 16)
			love.graphics.setColor(255,255,0,255)
			tinyfont:print("{" .. L.TINY_SHIFT, 128-tinywidth, love.graphics.getHeight()-14)
			tinyfont:print("}" .. L.TINY_CTRL, 128-tinywidth, love.graphics.getHeight()-7)
			love.graphics.setColor(255,255,255,255)
		end
	else
		-- Still have a background, in case we have a brush that's so big it overlaps with this part of the screen
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 31, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		if not window_active() then
			love.graphics.setColor(255,255,255,128)
		end
		tinyfont:print(L.TINY_CTRL, 0, 0)

		-- Also display the current (sub)tool!
		love.graphics.draw(image.selectedtool, 0, love.graphics.getHeight()-32)
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
		if playtesting_uistate == PT_UISTATE.ASKING
		or playtesting_uistate == PT_UISTATE.PLAYTESTING then
			usethisbtn = image.playstopbtn_hq
		else
			usethisbtn = image.playbtn_hq
		end
	else
		usethisbtn = image.playgraybtn_hq
	end
	hoverdraw(usethisbtn, love.graphics.getWidth()-128, 0, 32, 32)
	hoverdraw(image.helpbtn, love.graphics.getWidth()-120+40, 40, 16, 16, 1)
	hoverdraw(image.newbtn_hq, love.graphics.getWidth()-96, 0, 32, 32)
	hoverdraw(image.loadbtn_hq, love.graphics.getWidth()-64, 0, 32, 32)
	hoverdraw(image.savebtn_hq, love.graphics.getWidth()-32, 0, 32, 32)
	if editingbounds == 0 then
		showhotkey("n", love.graphics.getWidth()-128, 32-8) -- The Esc hotkey to cancel playtesting is later
	end
	showhotkey("cq", love.graphics.getWidth()-120+40+8-2, 40+2, ALIGN.CENTER)
	showhotkey("cN", love.graphics.getWidth()-96-2, 32-8)
	showhotkey("L", love.graphics.getWidth()-64-2, 32-8)
	showhotkey("S", love.graphics.getWidth()-32-2, 32-8)

	-- Now for the other buttons - about this variable, I can hardcode it again later.
	local buttonspacing = 20 --24

	if #undobuffer >= 1 then
		hoverdraw(image.undobtn, love.graphics.getWidth()-120, 40, 16, 16, 1)     -- 128-8 => 120
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(image.undobtn, love.graphics.getWidth()-120, 40)
		love.graphics.setColor(255,255,255)
	end
	if #redobuffer >= 1 then
		hoverdraw(image.redobtn, love.graphics.getWidth()-120+16, 40, 16, 16, 1)
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(image.redobtn, love.graphics.getWidth()-120+16, 40)
		love.graphics.setColor(255,255,255)
	end

	showhotkey("cZ", love.graphics.getWidth()-120+7, 40-4, ALIGN.CENTER)
	showhotkey("cY", love.graphics.getWidth()-120+16+6, 40+8+2, ALIGN.CENTER)

	hoverdraw(image.cutbtn, love.graphics.getWidth()-120+64, 40, 16, 16, 1)
	hoverdraw(image.copybtn, love.graphics.getWidth()-120+80, 40, 16, 16, 1)
	hoverdraw(image.pastebtn, love.graphics.getWidth()-120+96, 40, 16, 16, 1)

	showhotkey("cX", love.graphics.getWidth()-120+64+6, 40-4-2, ALIGN.CENTER)
	showhotkey("cC", love.graphics.getWidth()-120+80+6, 40+8, ALIGN.CENTER)
	showhotkey("cV", love.graphics.getWidth()-120+96+6, 40-4, ALIGN.CENTER)

	rbutton((upperoptpage2 and L.VEDOPTIONS or L.LEVELOPTIONS), 1, 40, false, 20)
	rbutton((upperoptpage2 and {L.COMPARE, "cD"} or {L.MAP, "M"}), 2, 40, false, 20)
	rbutton((upperoptpage2 and L.STATS or {L.SCRIPTS, "/"}), 3, 40, false, 20)
	rbutton((upperoptpage2 and {L.LEVELNOTEPAD, "c/"} or {L.SEARCH, "cF"}), 4, 40, false, 20)
	if not upperoptpage2 then
		rbutton({L.ASSETS, "cR"}, 5, 40, false, 20)
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

	rbutton(fontpng_works and L.ROTATE180 or L.ROTATE180UNI, 0+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	local voided_metadata = levelmetadata_get(roomx, roomy).voided
	if not voided_metadata then
		rbutton({(levelmetadata_get(roomx, roomy).directmode == 1 and L.MANUALMODE or (levelmetadata_get(roomx, roomy).auto2mode == 1 and L.AUTO2MODE or L.AUTOMODE)), "p"}, 1+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	end

	rbutton((showepbounds and L.HIDEBOUNDS or L.SHOWBOUNDS), 2+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
	if not voided_metadata then
		rbutton({langkeys(L.WARPDIR, {warpdirs[levelmetadata_get(roomx, roomy).warpdir]}), "W"}, 3+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing)
		rbutton({L.ROOMNAME, not editingroomname and "E" or "n"}, 4+additionalbutton_np, additionalbutton_yoffset, true, additionalbutton_spacing, editingroomname) -- (6*16)+16+24+12+16
	end

	ved_printf(L.ROOMOPTIONS, love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-300)+8, 128-16, "center") -- -(6*16)-16-24-12-8-(24*6))+4+2+4 => -300)+10

	-- Well make them actually do something!
	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-128, 0, 32, 32) then
			-- Play
			if playtesting_uistate == PT_UISTATE.ASKING then
				playtesting_cancelask()
			else
				playtesting_start(keyboard_eitherIsDown("shift"))
				playtesting_mousepressed = true
			end
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-120+40, 40, 16, 16) then
			-- Help
			tostate(15)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-96, 0, 32, 32) then
			-- New
			cancel_editing_roomname()
			if editingroomtext > 0 then
				end_editing_roomtext()
			end
			if has_unsaved_changes() then
				dialog.create(
					L.SURENEWLEVELNEW, DBS.SAVEDISCARDCANCEL,
					dialog.callback.surenewlevel, nil, nil,
					dialog.callback.noclose_on_make(DB.SAVE)
				)
			else
				triggernewlevel()
			end
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-64, 0, 32, 32) then
			-- Load. But first ask them if they want to save (make this save/don't save/cancel later, yes/no for now)
			cancel_editing_roomname()
			if editingroomtext > 0 then
				end_editing_roomtext()
			end
			tostate(6)
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-32, 0, 32, 32) then
			-- Save
			--tostate(8)
			cancel_editing_roomname()
			if editingroomtext > 0 then
				end_editing_roomtext()
			end
			dialog.create(
				L.ENTERNAMESAVE, DBS.OKCANCEL,
				dialog.callback.save, nil, dialog.form.save_make(true)
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
					DBS.OKCANCELADVANCED,
					dialog.callback.leveloptions,
					L.LEVELOPTIONS,
					dialog.form.leveloptions_make(),
					dialog.callback.noclose_on_make(DB.ADVANCED),
					"leveloptions"
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
			else
				-- Level notepad
				to_notepad()
			end
		elseif onrbutton(5, 40, false, 20) then
			if not upperoptpage2 then
				-- Assets
				tostate(30, nil, true)
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
	elseif nodialog and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-128, 0, 32, 32) then
		-- Right clicking on the play button
		playtesting_start(true)
	end

	-- We also have buttons for trinkets, enemy and platform settings, and crewmates!
	-- FIXME: This code is in dire need of refactoring
	if selectedtool == 4 or selectedtool == 8 or selectedtool == 9 or selectedtool == 16 or selectedtool == 17 then
		local roomsettings = {platv = levelmetadata_get(roomx, roomy).platv}
		if selectedtool ~= 4 and selectedtool ~= 16 and selectedtool ~= 17 and not voided_metadata then
			rbutton((selectedtool == 8 and {L.PLATFORMBOUNDS, "t"} or {L.ENEMYBOUNDS, "r"}), -3, 164+4, true, nil, editingbounds ~= 0)
		end
		if selectedtool == 4 or selectedtool == 16 or selectedtool == 17 then
			local label
			if selectedtool == 4 then
				label = L.LISTALLTRINKETS
			elseif selectedtool == 16 then
				label = L.LISTALLCREWMATES
			else
				label = L.GOTO
			end
			rbutton(label, -2, 164+4, true)
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
			selectedtool == 9 and L.ROOMENEMIES or
			selectedtool == 16 and L.CREWMATES or toolnames[selectedtool],
			love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-156)+4, 128-16, "center"
		)

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
				dialog.create(crewmates, nil, nil, L.LISTOFALLCREWMATES)
			elseif onrbutton(-2, 164+4, true) and selectedtool == 17 then
				-- Go to start point
				gotostartpointroom()
				mousepressed = true
			elseif selectedtool == 4 or selectedtool == 16 or selectedtool == 17 or voided_metadata then
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

				mousepressed = true
			end
		end

		if selectedtool == 8 and nodialog and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), love.graphics.getHeight()-136, 128-16, 16) and not mousepressed and not voided_metadata then
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

	-- If we're placing a terminal or script box, display some radio buttons
	if (selectedtool == 12 or selectedtool == 13) then
		local y = (love.graphics.getHeight()-156)+1
		ved_printf(
			L.CREATE_LOAD_SCRIPT,
			love.graphics.getWidth()-(128-4),
			y,
			128-8,
			"center"
		)
		for k,v in pairs({
			"NO",
			"RUNONCE",
			"REPEATING"
		}) do
			local mode = LOAD_SCRIPT_CREATION_MODE[v]
			local name = L["CREATE_LOAD_SCRIPT_" .. v]
			local selected = get_load_script_creation_mode() == mode
			radio_wrap(selected, love.graphics.getWidth()-(128-6), y+(19*k)+4, mode, name, 96,
				function(key)
					create_load_script = mode
				end,
				function(key)
					local title = L["CREATE_LOAD_SCRIPT_TITLE_" .. v]
					local expl_prefix
					if selectedtool == 12 then
						expl_prefix = "CREATE_LOAD_SCRIPT_EXPL_T_"
					else
						expl_prefix = "CREATE_LOAD_SCRIPT_EXPL_S_"
					end
					local explanation = L[expl_prefix .. v]
					local box_w, box_h = tooltip_box_dimensions(title, explanation)
					tooltip_box_draw(
						title,
						explanation,
						nil,
						love.graphics.getWidth()-128-box_w,
						y+(19*k),
						box_w, box_h,
						255,255,128
					)
				end
			)
		end
	end

	-- And coordinates.
	love.graphics.setColor(128,128,128)
	if s.coords0 then
		tinyfont:print("0", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		ved_printf("(" .. roomx .. "," .. roomy .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-10, 56, "right")
	else
		tinyfont:print("1", love.graphics.getWidth()-4, love.graphics.getHeight()-16-17)
		love.graphics.setColor(255,255,255)
		ved_printf("(" .. (roomx+1) .. "," .. (roomy+1) .. ")", love.graphics.getWidth()-56, love.graphics.getHeight()-16-10, 56, "right")
	end

	-- But if we're in the tiles picker instead display the tile we're hovering on!
	if tilespicker then
		local tiles_width_picker = tilesets[tileset_names[selectedtileset]].tiles_width_picker
		local tiles_height_picker = tilesets[tileset_names[selectedtileset]].tiles_height_picker
		local total_tiles = tilesets[tileset_names[selectedtileset]].total_tiles
		local cursor_not_dashes = cursorx ~= "--" and cursory ~= "--"
		local tile
		if cursor_not_dashes then
			tile = ((tilespicker_page*30+cursory)*tiles_width_picker)+cursorx
		end
		if cursor_not_dashes
		and cursorx < tiles_width_picker
		and tile < total_tiles then
			ved_printf(
				langkeys(L.TILE, {tile}),
				love.graphics.getWidth()-128, love.graphics.getHeight()-8-10, 128, "right"
			)
			ved_printf(
				(issolid(tile, usedtilesets[levelmetadata_get(roomx, roomy).tileset]) and L.SOLID or L.NOTSOLID),
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
	if ((selectedtool <= 2 and selectedsubtool[selectedtool] ~= 8) or selectedtool == 3) and not voided_metadata then
		local picker_x, picker_y = love.graphics.getWidth()-(7*16), love.graphics.getHeight()-156 -- -(6*16)-16-24-12-8 => -156
		local picker_scale = 2
		local picker_w, picker_h = 6*picker_scale*8, 5*picker_scale*8

		love.graphics.setColor(128,128,128,255)
		love.graphics.rectangle("fill", picker_x-1, picker_y-1, picker_w+2, picker_h+2)
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle("fill", picker_x, picker_y, picker_w, picker_h)
		love.graphics.setColor(255,255,255,255)
		displaysmalltilespicker(picker_x, picker_y, selectedtileset, selectedcolor, picker_scale)
	elseif selectedtool <= 2 and selectedsubtool[selectedtool] == 8 then
		-- The custom brush needs radio buttons as well...
		local y = (love.graphics.getHeight()-156)+1
		local title_y = y
		if font8:getWidth(L.CUSTOM_SIZED_BRUSH) < 128-8 then
			title_y = title_y + 4
			y = y - 4
		end
		ved_printf(
			L.CUSTOM_SIZED_BRUSH,
			love.graphics.getWidth()-(128-4),
			title_y,
			128-8,
			"center"
		)
		if customsizemode == 0 then
			rbutton(L.RESET, 0, 156-19*2, true)

			if not mousepressed and nodialog and love.mouse.isDown("l") then
				if onrbutton(0, 156-19*2, true) then
					customsizemode = 1
					customsizex = 0
					customsizey = 0
					customsizetile = nil
				end
			end
		else
			for k,v in pairs({
				"BRUSH",
				"STAMP",
				"TILESET"
			}) do
				local name = L["CUSTOM_SIZED_BRUSH_" .. v]
				local selected = false
				if tilespicker then
					selected = k == 3
				elseif customsizemode <= 2 then
					selected = k == 1
				else
					selected = k == 2
				end
				radio_wrap(selected, love.graphics.getWidth()-(128-6), y+(19*k)+4, k, name, 96,
					function(key)
						if key == 1 then
							-- Brush
							tilespicker = false
							customsizemode = 1
							customsizex = 0
							customsizey = 0
							customsizetile = nil
						elseif key == 2 then
							-- Stamp
							tilespicker = false
							customsizemode = 3
							customsizex = 0
							customsizey = 0
							customsizetile = nil
						elseif key == 3 then
							-- Tileset
							cancel_editing_roomname()
							if editingroomtext > 0 then
								end_editing_roomtext()
							end
							tilespicker = true
							customsizemode = 1
							customsizex = 0
							customsizey = 0
							customsizetile = nil
						end
					end,
					function(key)
						local title = L["CUSTOM_SIZED_BRUSH_TITLE_" .. v]
						local explanation = L["CUSTOM_SIZED_BRUSH_EXPL_" .. v]
						local box_w, box_h = tooltip_box_dimensions(title, explanation)
						tooltip_box_draw(
							title,
							explanation,
							nil,
							love.graphics.getWidth()-128-box_w,
							y+(19*k),
							box_w, box_h,
							255,255,128
						)
					end
				)
			end
		end
	end

	if not voided_metadata then
		hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-70, (6*16), 8+4) -- -16-32-2-12-8 => -70
		ved_printf(
			tilesetblocks[selectedtileset].name ~= nil and tilesetblocks[selectedtileset].name or selectedtileset,
			love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-32-12-8, 6*16, "center"
		)

		hoverrectangle(128,128,128,128, love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-24-2-8-8, (6*16), 8+4)
		ved_printf(
			tilesetblocks[selectedtileset].colors[selectedcolor].name ~= nil
			and tilesetblocks[selectedtileset].colors[selectedcolor].name
			or langkeys(L.TSCOLOR, {selectedcolor}),
			love.graphics.getWidth()-(7*16), love.graphics.getHeight()-16-24-8-8, 6*16, "center"
		)
	end

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

	if not voided_metadata then
		showhotkey("q", love.graphics.getWidth()-16, love.graphics.getHeight()-70-2, ALIGN.RIGHT)
		showhotkey("w", love.graphics.getWidth()-16, love.graphics.getHeight()-58-2, ALIGN.RIGHT)
	end
	showhotkey("cs", love.graphics.getWidth()-16, love.graphics.getHeight()-46-2, ALIGN.RIGHT)

	if tilespicker then
		if tilespicker_last_page_number() ~= 0 then
			-- Display page switcher for big tiles picker
			local label = tilespicker_page+1 .. "/" .. tilespicker_last_page_number()+1
			ved_print(
				label,
				640+screenoffset+3, love.graphics.getHeight()-8-10
			)

			local label_w = font8:getWidth(label)
			hoverrectangle(128,128,128,128, 640+screenoffset+1, love.graphics.getHeight()-19-10, label_w+4, 10)
			hoverrectangle(128,128,128,128, 640+screenoffset+1, love.graphics.getHeight()-10, label_w+4, 10)
			ved_printf(arrow_up, 640+screenoffset+1, love.graphics.getHeight()-19-10+1, label_w+4, "center")
			ved_printf(arrow_down, 640+screenoffset+1, love.graphics.getHeight()-10+1, label_w+4, "center")

			if love.mouse.isDown("l") and not mousepressed then
				if mouseon(640+screenoffset+1, love.graphics.getHeight()-19-10, label_w+4, 10) then
					tilespicker_prev_page()
					mousepressed = true
				elseif mouseon(640+screenoffset+1, love.graphics.getHeight()-10, label_w+4, 10) then
					tilespicker_next_page()
					mousepressed = true
				end
			end
		end
	else
		-- Some text below the small tiles picker-- how many trinkets and crewmates do we have?
		love.graphics.draw(image.stat_trinkets, 640+screenoffset+2, love.graphics.getHeight()-16-10)
		love.graphics.draw(image.stat_crewmates, 640+screenoffset+2, love.graphics.getHeight()-8-10)
		love.graphics.draw(image.stat_entities, 640+screenoffset+2, love.graphics.getHeight()-10)
		font_8x8:printf(
			fixdig(anythingbutnil(count.trinkets), 3, "") .. "\n"
			.. fixdig(anythingbutnil(count.crewmates), 3, "") .. "\n"
			.. fixdig(anythingbutnil(count.entities), 5, ""),
			640+screenoffset+11, love.graphics.getHeight()-16-10, 128, "left"
		)
	end

	if coordsdialog.active then
		coordsdialog.draw()
	end

	local bottomwidemsg
	if playtesting_uistate == PT_UISTATE.ASKING then
		bottomwidemsg = L.WHEREPLACEPLAYER
	elseif playtesting_uistate == PT_UISTATE.PLAYTESTING then
		bottomwidemsg = L.YOUAREPLAYTESTING
	end

	if playtesting_uistate == PT_UISTATE.ASKING then
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
				aty - 4
			)

			love.graphics.setScissor()
			love.graphics.setColor(255, 255, 255, 255)
		end

		local flipindicator = "gvj"
		local unlockindicator = ";"

		local tinywidth = math.max(tinyfont:getWidth(L.TINY_SHIFT), tinyfont:getWidth(L.TINY_ALT))
		local tinyiconwidth = math.max(tinyfont:getWidth(flipindicator), tinyfont:getWidth(unlockindicator))
		local totalwidth = tinywidth + tinyiconwidth

		love.graphics.setColor(0, 0, 0, 224)
		love.graphics.rectangle("fill", 128-totalwidth-1, love.graphics.getHeight()-15, totalwidth+2, 16)
		love.graphics.setColor(255, 255, 0, 255)
		tinyfont:print(flipindicator .. L.TINY_SHIFT, 128-tinywidth-tinyfont:getWidth(flipindicator), love.graphics.getHeight()-15)
		tinyfont:print(unlockindicator .. L.TINY_ALT, 128-tinywidth-tinyfont:getWidth(unlockindicator), love.graphics.getHeight()-7)
		love.graphics.setColor(255, 255, 255, 255)
	end

	if bottomwidemsg ~= nil then
		local _, lines = font8:getWrap(bottomwidemsg, love.graphics.getWidth())
		local yoff = 16 * (lines-1)

		love.graphics.setColor(255, 255, 127, 63)
		love.graphics.rectangle("fill", 0, love.graphics.getHeight()-40-yoff-2, love.graphics.getWidth(), 16+yoff+4)
		love.graphics.setColor(255, 255, 255, 255)
		ved_shadowprintf(bottomwidemsg, 0, love.graphics.getHeight()-40-yoff, love.graphics.getWidth(), "center", 2)
	end

	if playtesting_uistate == PT_UISTATE.ASKING then
		showhotkey("b", love.graphics.getWidth()-128, 32-8, nil, true)
	end

	-- Do we want to see room metadata?
	if allowdebug and love.keyboard.isDown("f11") then

	end
end
