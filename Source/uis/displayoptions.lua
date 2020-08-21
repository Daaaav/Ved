local ui = {name = "displayoptions"}

function ui.load()
	oldforcescale = s.forcescale
	nonintscale = s.scale ~= math.floor(anythingbutnil0(tonumber(s.scale)))
	if nonintscale then
		startinput()
		input = tostring(s.scale)
	end
end

ui.elements = {
	
}

function ui.draw()
	ved_print(L.DISPLAYSETTINGSTITLE, 8, 8+4)

	ved_print(L.SCALE, 8, 8+(24*1)+4)
	if nonintscale then
		-- Something
		ved_print(input .. __, 16+font8:getWidth(L.SCALE), 8+(24*1)+4)
	else
		int_control(16+font8:getWidth(L.SCALE), 8+(24*1), "scale", 1, 9,
			function(value)
				local swidth = 896
				if s.psmallerscreen then
					swidth = 800
				end
				local fits = false

				for mon = 1, love.window.getDisplayCount() do
					local monw, monh = love.window.getDesktopDimensions(mon)

					if windowfits(swidth*value, 480*value, {monw, monh}) then
						fits = true
					end
				end
				return not fits
			end
		)
	end

	checkbox(nonintscale, 8, 8+(24*2), nil, L.NONINTSCALE,
		function(key, newvalue)
			nonintscale = newvalue
			if nonintscale then
				startinput()
				input = tostring(s.scale)
			else
				stopinput()
				s.scale = math.floor(num_scale)
				if s.scale <= 0 then
					s.scale = 1
				end
			end
		end
	)

	checkbox(s.smallerscreen, 8, 8+(24*3), "smallerscreen", L.SMALLERSCREEN,
		function(key, newvalue)
			s[key] = newvalue
		end
	)

	checkbox(s.forcescale, 8, 8+(24*4), "forcescale", L.FORCESCALE,
		function(key, newvalue)
			s[key] = newvalue
		end
	)

	if nonintscale then
		num_scale = anythingbutnil0(tonumber((input:gsub(",", "."))))
	else
		num_scale = anythingbutnil0(tonumber(s.scale))
	end
	local ved_w, ved_h = 896*num_scale, 480*num_scale
	if s.smallerscreen then
		ved_w = 800*num_scale
	end


	-- Display monitors
	love.graphics.setColor(12, 12, 12)
	love.graphics.rectangle("fill", 16, 125, love.graphics.getWidth()-32, 332)
	local total_monw, high_monh = -16, 0
	local monitors = {}
	local fits = false
	for mon = 1, love.window.getDisplayCount() do
		local monw, monh = love.window.getDesktopDimensions(mon)
		table.insert(monitors, {monw, monh})

		if monh > high_monh then
			high_monh = monh
		end
		total_monw = total_monw + monw + 16

		if windowfits(ved_w, ved_h, {monw, monh}) then
			fits = true
		end
	end
	local pixelscale = 1/math.max(total_monw/(love.graphics.getWidth()-96), high_monh/268)
	local currentmon_x = 0
	for k,v in pairs(monitors) do
		local monw, monh = unpack(v)
		local dispx = (love.graphics.getWidth()/2 - (total_monw*pixelscale)/2) + currentmon_x
		local dispy = 125 + (166 - (monh*pixelscale)/2)

		love.graphics.setColor(6, 6, 6)
		love.graphics.rectangle("fill", dispx-4, dispy-4, monw*pixelscale+8, monh*pixelscale+8)
		love.graphics.setColor(0, 0, 128)
		love.graphics.rectangle("fill", dispx, dispy, monw*pixelscale, monh*pixelscale)
		love.graphics.setColor(255, 255, 255)
		love.graphics.setScissor(dispx, dispy, monw*pixelscale+1, monh*pixelscale+1)
		love.graphics.draw(
			scaleimgs[s.smallerscreen],                         -- compensate for window borders in this image
			dispx + ((monw*pixelscale)/2 - (ved_w*pixelscale)/2) - 9*pixelscale*num_scale,
			dispy + ((monh*pixelscale)/2 - (ved_h*pixelscale)/2) - 30*pixelscale*num_scale,
			0, pixelscale*num_scale
		)
		love.graphics.setScissor()
		ved_printf(
			(love.window.getDisplayName ~= nil and love.window.getDisplayName(k) .. "\n" or "")
			.. langkeys(L.MONITORSIZE, {monw, monh}),
			dispx, 135 + (164 + (monh*pixelscale)/2), monw*pixelscale, "center"
		)
		currentmon_x = currentmon_x + monw*pixelscale + 16
	end

	ved_printf(langkeys(L.VEDRES, {ved_w, ved_h}), 0, 129, love.graphics.getWidth(), "center")


	if num_scale ~= tonumber(num_scale) or num_scale == nil or num_scale <= 0 then
		love.graphics.setColor(255,0,0)
		ved_print(L.SCALENONUM, 8, love.graphics.getHeight()-17)
		love.graphics.setColor(255,255,255)
	elseif not fits then
		love.graphics.setColor(255,0,0)
		ved_print(L.SCALENOFIT, 8, love.graphics.getHeight()-17)
		love.graphics.setColor(255,255,255)
	end


	rbutton({L.BTN_OK, "b"}, 0)


	if nodialog and not mousepressed and love.mouse.isDown("l") then
		if onrbutton(0) then
			-- Save
			exitdisplayoptions()
		end

		mousepressed = true
	end
end

function ui.update(dt)
end

function ui.keypressed(key)
end

function ui.keyreleased(key)
	if key == "escape" then
		-- Put it here instead of love.keypressed,
		-- otherwise the new window will interpret a hold as a press
		exitdisplayoptions()
	end
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
