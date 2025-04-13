-- map/draw

return function()
	love.graphics.setColor(128,128,128)
	love.graphics.rectangle("line", mapxoffset+screenoffset-0.5, mapyoffset-0.5, 640*mapscale*metadata.mapwidth+1, 480*mapscale*metadata.mapheight+1)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setScissor(mapxoffset+screenoffset, mapyoffset, 640*mapscale*metadata.mapwidth, 480*mapscale*metadata.mapheight)
	love.graphics.draw(image.covered_full, mapxoffset+screenoffset, mapyoffset)
	love.graphics.setScissor()

	local startx, starty
	if entitydata[count.startpoint] ~= nil then
		startx = math.floor(entitydata[count.startpoint].x/40)
		starty = math.floor(entitydata[count.startpoint].y/30)
		startx = math.max(startx, 0)
		starty = math.max(starty, 0)
	end

	for mry = 0, metadata.mapheight-1 do
		for mrx = 0, metadata.mapwidth-1 do
			love.graphics.setScissor()
			if rooms_map[mry][mrx].map ~= nil then
				-- First draw a black background
				love.graphics.setColor(0,0,0,255)
				love.graphics.rectangle("fill", mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
				love.graphics.setColor(255,255,255,255)

				love.graphics.draw(rooms_map[mry][mrx].map, mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, 0, maproomscale)
			end

			if selectedtool == 4 or selectedtool == 16 or selectedtool == 17 then
				love.graphics.setScissor(mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
				love.graphics.setColor(0,0,0,128)
				love.graphics.rectangle("fill", mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
				love.graphics.setColor(255,255,255,255)
			end

			-- Draw one thing if there is one, draw two if there is two,
			-- draw three if there is three.
			-- Else, just draw the number instead.
			if (selectedtool == 4 and map_trinkets[mry][mrx] > 0)
			or (selectedtool == 16 and map_crewmates[mry][mrx][1] > 0)
			or (selectedtool == 17 and mrx == startx and mry == starty) then
				-- Having mystrious variables like "widthb" is still better than what this code looked like before, without abstraction at all.
				local amount, sprite, width, widthb, extray, scalesubtract, colorfunc

				if selectedtool == 4 then
					amount = map_trinkets[mry][mrx]
					spritefunc = function() return 22 end
					width = 16
					widthb = 16
					extray = 0
					scalesubtract = 16
					colorfunc = function(n) v6_setcol(3) end
				elseif selectedtool == 16 then
					amount = map_crewmates[mry][mrx][1]
					spritefunc = function(n)
						return getrescuablesprite(map_crewmates[mry][mrx][2][n])
					end
					width = 10
					widthb = 12
					extray = -2
					scalesubtract = 21
					colorfunc = function(n)
						setrescuablecolor(map_crewmates[mry][mrx][2][n])
					end
				else
					amount = 1
					spritefunc = function() return 3*entitydata[count.startpoint].p1 end
					width = 10
					widthb = 12
					extray = -2
					scalesubtract = 21
					colorfunc = function(n)
						love.graphics.setColor(132, 181, 255)
					end
				end

				if amount <= 3 then
					for i = 1, amount do
						colorfunc(i)
						local sprite = spritefunc(i)

						drawentitysprite(
							sprite,
							mapxoffset + screenoffset + mrx*mapscale*640 + i * (mapscale*640 - amount*widthb) / (amount+1) + (i-1)*widthb - (16-width),
							mapyoffset + mry*mapscale*480 + (mapscale*480 - scalesubtract)/2 + extray,
							true
						)
					end
				else
					ved_printf(amount, mapxoffset + screenoffset + mrx*mapscale*640, mapyoffset + mry*mapscale*480 + mapscale*480/2 - 4, mapscale*640, "center")
				end
			end
		end
	end
	love.graphics.setBlendMode("alpha")
	love.graphics.setScissor()

	-- We should be able to hover over rooms
	hoverx = nil
	hovery = nil
	hovername = nil

	-- Just so if we click on a tool in smallerscreen mode,
	-- we won't click on the room behind it
	-- (and also we won't highlight the room behind it either if we're not clicking)
	local mouseontools = keyboard_eitherIsDown(ctrl) and love.mouse.getX() <= 64

	if nodialog then
		for mry = 0, metadata.mapheight-1 do
			for mrx = 0, metadata.mapwidth-1 do
				if mouseon(mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480) and not mouseontools then
					love.graphics.setColor(255,255,255,64)
					love.graphics.rectangle("fill", mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
					love.graphics.setColor(255,255,255,255)

					hoverx = mrx
					hovery = mry
					hovername = levelmetadata_get(mrx, mry).roomname

					-- But maybe we're clicking this room!
					if love.mouse.isDown("l") then
						-- Is this an action?
						if not mousepressed and selectingrooms == 0 then
							-- Nope
							gotoroom(hoverx, hovery)

							-- We don't want to click the first tile we press
							nodialog = false

							tostate(1, true)
						elseif not mousepressed and selected1x == -1 then
							-- Select 1
							selected1x = hoverx
							selected1y = hovery
							mousepressed = true
						elseif not mousepressed and selected2x == -1 then
							-- Select 2 and proceed
							selected2x = hoverx
							selected2y = hovery

							if selected1x == selected2x and selected1y == selected2y then
								-- This may have resulted in an infinite loop memory flood!
								dialog.create(L.SOURCEDESTROOMSSAME)
							else
								-- What were we selecting the rooms for, btw?
								if selectingrooms == 1 then
									-- Copying!
									mapcopy(selected1x, selected1y, selected2x, selected2y)
									locatetrinketscrewmates()
								elseif selectingrooms == 2 then
									-- Swapping!
									mapswap(selected1x, selected1y, selected2x, selected2y)
									locatetrinketscrewmates()
								end
							end

							selectingrooms = 0
							mousepressed = true
						end
					elseif love.mouse.isDown("r") then
						-- We just want to go there
						gotoroom(hoverx, hovery)
						mapmovedroom = true
					end
				end
			end
		end
	end

	if mapmovedroom or (generictimer_mode == 2
	and ((generictimer > 0 and generictimer <= 0.5)
	or (generictimer > 1 and generictimer <= 1.5)
	or (generictimer > 2 and generictimer < 2.5))) then
		love.graphics.setColor(255,255,0)
		love.graphics.setLineWidth(3)
		love.graphics.rectangle("line",
			mapxoffset+screenoffset+(roomx*mapscale*640),
			mapyoffset+roomy*mapscale*480,
			mapscale*640, mapscale*480
		)
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255,255,255)
	end

	-- Maybe we're exporting the map and showing which selection will be exported?
	if dialog.is_open() and dialogs[#dialogs].identifier == "mapexport" then
		local x1, y1, w, h, x2, y2 = fix_map_export_input(dialogs[#dialogs]:return_fields(), true)

		love.graphics.setColor(0,0,255)
		love.graphics.setLineWidth(3)
		love.graphics.rectangle("line",
			mapxoffset+screenoffset+(x1*mapscale*640),
			mapyoffset+y1*mapscale*480,
			w*mapscale*640, h*mapscale*480
		)
		love.graphics.setLineWidth(1)
		love.graphics.setColor(255,255,255)
	end

	local bar_w = love.graphics.getWidth()-screenoffset-640
	if (hoverx ~= nil) and (hovery ~= nil) then
		local coordtext
		if s.coords0 then
			coordtext = "(" .. hoverx .. "," .. hovery .. ")"
		else
			coordtext = "(" .. (hoverx+1) .. "," .. (hovery+1) .. ")"
		end
		font_8x8:printf(coordtext, screenoffset+640, 1, bar_w, font_level:align_start())
	end
	if (hovername ~= nil) then
		font_level:printf(hovername, screenoffset+640, 12, bar_w, font_level:align_start())
	end
	if selectingrooms == 1 and selected1x == -1 then
		-- Copy 1
		font_ui:printf(L.SELECTCOPY1, screenoffset+640, 80, bar_w, font_ui:align_start())
	elseif selectingrooms == 1 then
		-- Copy 2
		font_ui:printf(L.SELECTCOPY2, screenoffset+640, 80, bar_w, font_ui:align_start())
	elseif selectingrooms == 2 and selected1x == -1 then
		-- Swap 1
		font_ui:printf(L.SELECTSWAP1, screenoffset+640, 80, bar_w, font_ui:align_start())
	elseif selectingrooms == 2 then
		-- Swap 2
		font_ui:printf(L.SELECTSWAP2, screenoffset+640, 80, bar_w, font_ui:align_start())
	end

	local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17

	local pluraltoolnames = table.copy(toolnames)
	pluraltoolnames[4] = L.TRINKETS
	pluraltoolnames[16] = L.CREWMATES
	if not s.psmallerscreen or keyboard_eitherIsDown(ctrl) then
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 64, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)

		for t = 1, 4 do
			local actual_t
			if t == 1 then
				actual_t = 1
			elseif t == 2 then
				actual_t = 4
			elseif t == 3 then
				actual_t = 16
			elseif t == 4 then
				actual_t = 17
			end
			love.graphics.setColor(255,255,255,255)

			if not nodialog or (not mouseon(16, (16+(48*(t-1))), 32, 32) and ((t == 1 and not toolanyofthese) or selectedtool ~= actual_t)) then
				love.graphics.setColor(255,255,255,128)
			end
			if nodialog and t == 1 and not toolanyofthese then
				love.graphics.setColor(255,255,255,255)
			end
			if not window_active() then
				love.graphics.setColor(255,255,255,128)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(16, (16+(48*(t-1))), 32, 32) then
				selectedtool = actual_t
				updatewindowicon()
				toolscroll()
				mousepressed = true
			end
			if nodialog and not mousepressed and love.mouse.isDown("r") and mouseon(16, (16+(48*(t-1))), 32, 32) and t == 4 then
				gotostartpointroom()
			end

			if (t ~= 1 and selectedtool == actual_t) or (t == 1 and not toolanyofthese) then
				love.graphics.draw(image.selectedtool,  16, (16+(48*(t-1))))
			else
				love.graphics.draw(image.unselectedtool,  16, (16+(48*(t-1))))
			end
			if t ~= 1 then
				local cx, cy = 16+2, (16+2+(48*(t-1)))
				theming:draw(toolimg[actual_t], cx, cy)
				if nodialog and (mouseon(16, (16+(48*(t-1))), 32, 32)) and window_active() then
					love.graphics.setColor(128,128,128,192)
					love.graphics.rectangle("fill", love.mouse.getX()+15, love.mouse.getY()-8, font8:getWidth(pluraltoolnames[actual_t]), 8)
					love.graphics.setColor(255,255,255,255)
					ved_print(pluraltoolnames[actual_t], love.mouse.getX()+16, love.mouse.getY()-8)
				end
			end
		end

		love.graphics.setColor(255,255,255,255)
	end

	-- Smaller screen? Display a "CTRL" and the current tool, just like the main editor
	if s.psmallerscreen and not keyboard_eitherIsDown(ctrl) then
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", 0, 0, 31, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		if not window_active() then
			love.graphics.setColor(255,255,255,128)
		end
		tinyfont:print(L.TINY_CTRL, 0, 0)

		love.graphics.draw(image.selectedtool, 0, love.graphics.getHeight()-32)
		if toolanyofthese then
			theming:draw(toolimg[selectedtool], 2, love.graphics.getHeight()-30)
		end
	end
end
