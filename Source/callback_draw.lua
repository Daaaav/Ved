function love.draw()
	if s.pausedrawunfocused and not window_active() then
		limit_draw_fps()
		return
	end

	if s.pscale ~= 1 then
		love.graphics.push()
		love.graphics.scale(s.pscale,s.pscale)
	end

	for k,font in pairs(fonts_main) do
		font:frame_start()
	end
	for k,font in pairs(fonts_custom) do
		font:frame_start()
	end
	tinyfont:frame_start()

	hook("love_draw_state")

	local callback_state = state
	if uis[state] ~= nil and uis[state].draw ~= nil then
		-- A UI can have its own dedicated drawing function and not use elements, sure.
		uis[state].draw(dt)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		-- Draw every element in this state's master element "container".
		-- This master container doesn't define positions,
		-- and just gives the window width and height as information.

		local w, h = love.graphics.getDimensions()

		if not uis[state].drawn then
			-- Just throw away a couple of frames to make sure
			-- everything's settled and nothing's flashing...
			love.graphics.setColorMask(false,false,false,false)
			for i = 1, 2 do
				for k,v in elements_iter(uis[state].elements) do
					v:draw(0, 0, w, h)
				end
			end
			love.graphics.setColorMask(true,true,true,true)
			uis[state].drawn = true
		end

		for k,v in elements_iter(uis[state].elements) do
			v:draw(0, 0, w, h)
		end

		-- Debug view
		if allowdebug and love.keyboard.isDown("f8") then
			love.graphics.setColor(0,255,0)
			local function drawcoords(el)
				if el.px == nil or el.py == nil then
					return
				end

				local w, h = el.pw, el.ph
				if w == nil then w = love.graphics.getWidth() end
				if h == nil then h = love.graphics.getHeight() end

				love.graphics.line(el.px, el.py, el.px+w, el.py)
				love.graphics.line(el.px, el.py, el.px, el.py+h)
			end
			for k,v in elements_iter(uis[state].elements) do
				drawcoords(v)
				if v.recurse ~= nil then
					v:recurse("debug_drawcoords", drawcoords)
				end
			end
			love.graphics.setColor(255,255,255)
		end
	end

	if not RCMabovedialog then
		rightclickmenu.draw()
	end

	dialog.draw()

	if RCMabovedialog then
		rightclickmenu.draw()
	end

	if ime_textedited ~= "" and not (newinputsys.active and newinputsys.getfocused() ~= nil) then
		-- Temporary, just a copy-paste from input.lua until the old input system is gone...
		local cursor_start = font_level:getWidth(utf8.sub(ime_textedited, 1, ime_textstart))*2
		local cursor_length = font_level:getWidth(utf8.sub(ime_textedited, ime_textstart+1, ime_textstart+ime_textlength))*2

		local fontheight = font_level:getHeight()
		local y = love.graphics.getHeight()-12-fontheight*2
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 12, y, font_level:getWidth(ime_textedited)*2, fontheight*2)

		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle("line", 12, y, font_level:getWidth(ime_textedited)*2, fontheight*2)

		font_level:print(ime_textedited, 12, y, "cjk_low", 2, 2)

		if ime_textlength > 0 then
			love.graphics.setColor(255, 127, 0, 127)
		else
			cursor_length = cursor_length + 2
		end
		love.graphics.rectangle("fill", 12 + cursor_start, y, cursor_length, fontheight*2)
		love.graphics.setColor(255, 255, 255)
	end

	if generictimer_mode == 3 and generictimer > 0 then
		local width, lines = font_ui:getWrap(notification_text, 80*8)

		local boxy = love.graphics.getHeight()-16-lines*8
		love.graphics.setColor(128,128,128,192)
		love.graphics.rectangle("fill", 8, boxy, width+16, lines*8+8)
		love.graphics.setColor(0,0,0,255)
		font_ui:printf(notification_text, 16, boxy+4, 80*8, "left")
	end

	-- Middle click cursor
	if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		v6_setcol(3)
		drawentitysprite(22, middlescroll_x-16, middlescroll_y-16, false)
	end

	if middlescroll_rolling ~= 0 then
		love.graphics.setColor(130+love.math.random(0,70), 110+love.math.random(0,70), 170+love.math.random(0,70))
		local furtherfall = 0
		if middlescroll_rolling_x < 0 then
			furtherfall = -middlescroll_rolling_x/2
		elseif middlescroll_rolling_x > love.graphics.getWidth() then
			furtherfall = middlescroll_rolling_x - love.graphics.getWidth()
		end
		love.graphics.draw(
			tilesets["sprites.png"].white_img,
			tilesets["sprites.png"].tiles[22],
			middlescroll_rolling_x, love.graphics.getHeight()-16+furtherfall/1.2,
			0, 2, 2, 8, 8
		)
	end

	if middlescroll_shatter then
		for k,v in pairs(middlescroll_shatter_pieces) do
			love.graphics.setColor(130+love.math.random(0,70), 110+love.math.random(0,70), 170+love.math.random(0,70))
			love.graphics.setScissor(v.x, v.y, 4, 4)
			drawentitysprite(22, v.x-v.ox, v.y-v.oy, false)
		end
		love.graphics.setScissor()
	end

	love.graphics.setColor(255,255,255,255)

	if allowdebug and s.fpslimit_ix ~= 4 then
		love.graphics.setColor(255,0,0)
		if s.fpslimit_ix == 3 then
			font_8x8:print("120", love.graphics.getWidth()-48, love.graphics.getHeight()-16, nil, 2)
		elseif s.fpslimit_ix == 2 then
			font_8x8:print("60", love.graphics.getWidth()-32, love.graphics.getHeight()-16, nil, 2)
		elseif s.fpslimit_ix == 1 then
			font_8x8:print("30", love.graphics.getWidth()-32, love.graphics.getHeight()-16, nil, 2)
		end
		love.graphics.setColor(255,255,255)
	end

	-- Low FPS warning
	if s.lowfpswarning >= 0 and (love.timer.getTime()-begint >= 3) and love.timer.getFPS() <= s.lowfpswarning then
		love.graphics.setColor(255,160,0,192)
		love.graphics.rectangle("fill", 0, love.graphics.getHeight()-16, 128, 16)
		love.graphics.setColor(255,255,255,255)
		font_ui:printf(L.FPS .. ": " .. love.timer.getFPS(), 0, love.graphics.getHeight()-12, 128, "center")
	end

	if allowdebug then
		if love.keyboard.hasTextInput() then
			-- Taking input warning
			love.graphics.setColor(255,160,0,192)
			love.graphics.rectangle("fill", 128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255,255,255,255)
			font_8x8:printf("TAKING INPUT", 128, love.graphics.getHeight()-12, 128, "center")
		end
		if not nodialog then
			-- Dialog open warning
			love.graphics.setColor(160, 255, 0, 192)
			love.graphics.rectangle("fill", 2*128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255, 255, 255, 255)
			font_8x8:printf("DIALOG OPEN", 2*128, love.graphics.getHeight()-12, 128, "center")
		end
		if mousepressed then
			-- Mouse pressed warning
			love.graphics.setColor(0, 255, 160, 192)
			love.graphics.rectangle("fill", 3*128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255, 255, 255, 255)
			font_8x8:printf("MOUSE PRESSED", 3*128, love.graphics.getHeight()-12, 128, "center")
		end
	end

	hook("love_draw_end")

	if s.fpslimit_ix ~= 4 then
		limit_draw_fps()
	end

	if s.pscale ~= 1 then
		love.graphics.pop()
	end
end
