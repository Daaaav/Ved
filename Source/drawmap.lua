function drawmap()
	love.graphics.setColor(128,128,128)
	love.graphics.rectangle("line", mapxoffset+screenoffset-0.5, mapyoffset-0.5, 640*mapscale*metadata.mapwidth+1, 480*mapscale*metadata.mapheight+1)
	love.graphics.setColor(255,255,255)
	love.graphics.setScissor(mapxoffset+screenoffset, mapyoffset, 640*mapscale*metadata.mapwidth, 480*mapscale*metadata.mapheight)
	love.graphics.draw(covered_full, mapxoffset+screenoffset, mapyoffset)
	love.graphics.setScissor()
	love.graphics.setBlendMode("premultiplied")
	for mry = 0, metadata.mapheight-1 do
		for mrx = 0, metadata.mapwidth-1 do
			if rooms_map[mry][mrx].map ~= nil then
				-- First draw a black background
				love.graphics.setColor(0,0,0,255)
				love.graphics.rectangle("fill", mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
				love.graphics.setColor(255,255,255,255)

				love.graphics.draw(rooms_map[mry][mrx].map, mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, 0, mapscale*2)
			end
		end
	end
	love.graphics.setBlendMode("alpha")

	-- We should be able to hover over rooms
	hoverx = nil
	hovery = nil
	hovername = nil

	if nodialog then
		for mry = 0, metadata.mapheight-1 do
			for mrx = 0, metadata.mapwidth-1 do
				if mouseon(mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480) then
					love.graphics.setColor(255,255,255,64)
					love.graphics.rectangle("fill", mapxoffset+screenoffset+(mrx*mapscale*640), mapyoffset+mry*mapscale*480, mapscale*640, mapscale*480)
					love.graphics.setColor(255,255,255,255)

					hoverx = mrx
					hovery = mry
					hovername = levelmetadata[(mry)*20 + (mrx+1)].roomname

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
								elseif selectingrooms == 2 then
									-- Swapping!
									mapswap(selected1x, selected1y, selected2x, selected2y)
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
	if #dialogs > 0 and dialogs[#dialogs].identifier == "mapexport" then
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

	if (hoverx ~= nil) and (hovery ~= nil) then
		if s.coords0 then
			love.graphics.print("(" .. hoverx .. "," .. hovery .. ")", screenoffset+640, 3)
		else
			love.graphics.print("(" .. (hoverx+1) .. "," .. (hovery+1) .. ")", screenoffset+640, 3)
		end
	end
	if (hovername ~= nil) then
		love.graphics.printf(hovername, screenoffset+640, 11, love.graphics.getWidth()-screenoffset-640, "left")
	end
	if selectingrooms == 1 and selected1x == -1 then
		-- Copy 1
		love.graphics.printf(L.SELECTCOPY1, screenoffset+640, 80, love.graphics.getWidth()-(screenoffset+640), "left")
	elseif selectingrooms == 1 then
		-- Copy 2
		love.graphics.printf(L.SELECTCOPY2, screenoffset+640, 80, love.graphics.getWidth()-(screenoffset+640), "left")
	elseif selectingrooms == 2 and selected1x == -1 then
		-- Swap 1
		love.graphics.printf(L.SELECTSWAP1, screenoffset+640, 80, love.graphics.getWidth()-(screenoffset+640), "left")
	elseif selectingrooms == 2 then
		-- Swap 2
		love.graphics.printf(L.SELECTSWAP2, screenoffset+640, 80, love.graphics.getWidth()-(screenoffset+640), "left")
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)
	rbutton({L.SAVEMAP, "S"}, 1, nil, true)
	rbutton(L.COPYROOMS, 3, nil, true)
	rbutton(L.SWAPROOMS, 4, nil, true)

	local strip_ypos = love.graphics.getHeight()-144

	if #undobuffer >= 1 then
		hoverdraw(undobtn, love.graphics.getWidth()-120, strip_ypos, 16, 16, 1)
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(undobtn, love.graphics.getWidth()-120, strip_ypos)
		love.graphics.setColor(255,255,255)
	end
	if #redobuffer >= 1 then
		hoverdraw(redobtn, love.graphics.getWidth()-120+16, strip_ypos, 16, 16, 1)
	else
		love.graphics.setColor(64,64,64)
		love.graphics.draw(redobtn, love.graphics.getWidth()-120+16, strip_ypos)
		love.graphics.setColor(255,255,255)
	end
	hoverdraw(cutbtn, love.graphics.getWidth()-120+64, strip_ypos, 16, 16, 1)
	hoverdraw(copybtn, love.graphics.getWidth()-120+80, strip_ypos, 16, 16, 1)
	hoverdraw(pastebtn, love.graphics.getWidth()-120+96, strip_ypos, 16, 16, 1)

	-- The buttons are clickable
	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(1, true)
		elseif onrbutton(1, nil, true) then
			-- Save map
			create_export_dialog()
		elseif onrbutton(3, nil, true) then
			-- Copy rooms
			selectingrooms = 1
			selected1x = -1; selected1y = -1
			selected2x = -1; selected2y = -1
		elseif onrbutton(4, nil, true) then
			-- Swap rooms
			selectingrooms = 2
			selected1x = -1; selected1y = -1
			selected2x = -1; selected2y = -1
		elseif mouseon(love.graphics.getWidth()-120, strip_ypos, 16, 16) then
			undo()
		elseif mouseon(love.graphics.getWidth()-120+16, strip_ypos, 16, 16) then
			redo()
		elseif mouseon(love.graphics.getWidth()-120+64, strip_ypos, 16, 16) then
			cutroom()
		elseif mouseon(love.graphics.getWidth()-120+80, strip_ypos, 16, 16) then
			copyroom()
		elseif mouseon(love.graphics.getWidth()-120+98, strip_ypos, 16, 16) then
			pasteroom()
		end

		mousepressed = true
	end
end
