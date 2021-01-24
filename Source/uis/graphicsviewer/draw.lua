-- graphicsviewer/draw

return function()
	love.graphics.setColor(12,12,12,255)
	love.graphics.rectangle("fill", 8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
	love.graphics.setColor(255,255,255,255)
	if imageviewer_image_color ~= nil then
		love.graphics.setScissor(8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
		--[[
		love.graphics.setColor(0,0,0,255)
		love.graphics.rectangle(
			"fill", imageviewer_x, imageviewer_y,
			imageviewer_w*imageviewer_s, imageviewer_h*imageviewer_s
		)
		love.graphics.setColor(255,255,255,255)
		]]
		love.graphics.draw(
			imageviewer_showwhite and imageviewer_image_white or imageviewer_image_color,
			imageviewer_x, imageviewer_y, 0, imageviewer_s
		)
		local grid_tile
		if imageviewer_grid ~= 0 and nodialog
		and mouseon(8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
		and mouseon(imageviewer_x, imageviewer_y, imageviewer_w*imageviewer_s, imageviewer_h*imageviewer_s) then
			local hover_x = (love.mouse.getX()-imageviewer_x)/imageviewer_s
			local hover_y = (love.mouse.getY()-imageviewer_y)/imageviewer_s
			local hover_tx, hover_ty = math.floor(hover_x/imageviewer_grid), math.floor(hover_y/imageviewer_grid)

			love.graphics.setColor(192,192,192,128)
			love.graphics.rectangle("fill",
				imageviewer_x + hover_tx*imageviewer_grid*imageviewer_s,
				imageviewer_y + hover_ty*imageviewer_grid*imageviewer_s,
				imageviewer_grid*imageviewer_s, imageviewer_grid*imageviewer_s
			)
			love.graphics.setColor(255,255,255,255)

			if imageviewer_grid == 1 then
				grid_tile = hover_tx .. "," .. hover_ty
			else
				grid_tile = hover_tx + hover_ty*math.ceil(imageviewer_w/imageviewer_grid)
			end
		end
		love.graphics.setScissor()
		ved_print(L.GRAPHICS .. " - " .. imageviewer_filepath, 8, 4)

		local check_w = font8:getWidth(L.NOTALPHAONLY)+24
		local check_x = love.graphics.getWidth()-64-check_w/2
		checkbox(not imageviewer_showwhite, check_x, love.graphics.getHeight()-288, nil, L.NOTALPHAONLY,
			function(key, newvalue)
				imageviewer_showwhite = not newvalue
			end
		)
		showhotkey("R", check_x+16, love.graphics.getHeight()-288-2, ALIGN.RIGHT)

		ved_printf(
			L.GRID,
			love.graphics.getWidth()-128, love.graphics.getHeight()-236, 128, "center"
		)
		custom_int_control(
			love.graphics.getWidth()-100, love.graphics.getHeight()-216,
			imageviewer_gridout, imageviewer_gridin, nil,
			function()
				if imageviewer_grid == 0 then
					return "--"
				else
					return imageviewer_grid
				end
			end, 32
		)
		if grid_tile ~= nil then
			love.graphics.setColor(255,255,64,255)
			if imageviewer_w/imageviewer_grid ~= math.ceil(imageviewer_w/imageviewer_grid) then
				grid_tile = "(" .. grid_tile .. ")"
			end
			ved_printf(
				grid_tile,
				love.graphics.getWidth()-128, love.graphics.getHeight()-188, 128, "center"
			)
			love.graphics.setColor(255,255,255,255)
		end

		custom_int_control(
			love.graphics.getWidth()-100, love.graphics.getHeight()-144,
			imageviewer_zoomout, imageviewer_zoomin, nil,
			function()
				return (imageviewer_s*100) .. "%"
			end, 32
		)
		showhotkey("-", love.graphics.getWidth()-100+16, love.graphics.getHeight()-144-2, ALIGN.RIGHT)
		showhotkey("+", love.graphics.getWidth()-100+64+8, love.graphics.getHeight()-144-2, ALIGN.RIGHT)
		ved_printf(
			imageviewer_w .. L.X .. imageviewer_h,
			love.graphics.getWidth()-128, love.graphics.getHeight()-116, 128, "center"
		)
	else
		ved_print(L.GRAPHICS, 8, 4)

		local infostring = langkeys(L.CLICKONTHING, {L.LOAD})
		if love_version_meets(10) then
			infostring = infostring .. "\n" .. L.ORDRAGDROP
		end

		local _, lines = font8:getWrap(infostring, love.graphics.getWidth()-136)

		-- lines is a number in 0.9.x, and a table/sequence in 0.10.x and higher
		if type(lines) == "table" then
			lines = #lines
		end

		local centery = (love.graphics.getHeight() - 8*lines) / 2

		ved_printf(infostring, 0, centery, love.graphics.getWidth()-136, "center")
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)
	rbutton({L.LOAD, "L"}, 2, nil, true)

	if nodialog and love.mouse.isDown("l") and not mousepressed then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(30, true)
			oldstate = olderstate
			mousepressed = true
		elseif onrbutton(2, nil, true) then
			-- Load
			assets_graphicsloaddialog()
			mousepressed = true
		end
	end
end
