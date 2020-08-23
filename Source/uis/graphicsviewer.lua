local ui = {name = "graphicsviewer"}

function ui.load()
end

ui.elements = {
}

function ui.draw()
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

function ui.update(dt)
	if imageviewer_image_color ~= nil and nodialog then
		if imageviewer_moving then
			imageviewer_x = imageviewer_moved_from_x + (love.mouse.getX()-imageviewer_moved_from_mx)
			imageviewer_y = imageviewer_moved_from_y + (love.mouse.getY()-imageviewer_moved_from_my)
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("left", "kp4", "a") then
			imageviewer_x = imageviewer_x + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("right", "kp6", "d") then
			imageviewer_x = imageviewer_x - 1200*dt
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("up", "kp8", "w") then
			imageviewer_y = imageviewer_y + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("down", "kp2", "s") then
			imageviewer_y = imageviewer_y - 1200*dt
			fix_imageviewer_position()
		end

		if love.keyboard.isDown("pageup") then
			imageviewer_x, imageviewer_y = 8, 16
			fix_imageviewer_position()
		elseif love.keyboard.isDown("pagedown") then
			imageviewer_x, imageviewer_y = -imageviewer_w*imageviewer_s, -imageviewer_h*imageviewer_s
			fix_imageviewer_position()
		end
	end
end

function ui.keypressed(key)
	if key == "escape" then
		tostate(oldstate, true)
		if state == 30 then
			oldstate = olderstate
		end
		nodialog = false
	elseif key == "l" then
		assets_graphicsloaddialog()
	elseif imageviewer_image_color ~= nil then
		if key == "=" or key == "+" or key == "kp+" then
			imageviewer_zoomin()
		elseif key == "-" or key == "kp-" then
			imageviewer_zoomout()
		elseif key == "r" then
			imageviewer_showwhite = not imageviewer_showwhite
		elseif key == "`" then
			imageviewer_grid = 0
		elseif key == "1" then
			imageviewer_grid = 1
		elseif key == "2" then
			imageviewer_grid = 8
		elseif key == "3" then
			imageviewer_grid = 32
		end
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
	if button == "l" and imageviewer_image_color ~= nil and x < love.graphics.getWidth()-128 then
		imageviewer_moving = true
		imageviewer_moved_from_x, imageviewer_moved_from_y = imageviewer_x, imageviewer_y
		imageviewer_moved_from_mx, imageviewer_moved_from_my = x, y
		mousepressed = true
	end
end

function ui.mousereleased(x, y, button)
	imageviewer_moving = false
end

return ui
