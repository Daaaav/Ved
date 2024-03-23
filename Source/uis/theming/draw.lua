-- theming/draw

return function()
	ved_print(L.THEMINGTITLE, 8, 8+4)

	ved_print(L.ACTIVETHEMES, 8, 8+4+24)

	local should_disable = {}
	local should_enable = {}
	local should_shift_up = {}
	local should_shift_down = {}

	local x = 8
	local y = 8 + 4 + 24 + 32
	local active_themes = theming:get_active_themes()
	local inactive_themes = {}
	for name, theme in pairs(theming:get_themes()) do
		if not table.contains(active_themes, name) then
			table.insert(inactive_themes, name)
		end
	end

	for i = #active_themes, 1, -1 do
		local name = active_themes[i]
		love.graphics.setColor(255, 255, 255)

		if i ~= 1 then
			hoverrectangle(128,128,128,128, x, y, 16, 16)
			ved_printf("X", x, y + 4, 16, "center")

			if (not mousepressed) and nodialog and mouseon(x, y, 16, 16) and love.mouse.isDown("l") then
				mousepressed = true
				table.insert(should_disable, name)
			end

			if i ~= #active_themes then
				hoverrectangle(128,128,128,128, x + 20, y, 16, 16)
				ved_printf(arrow_up, x + 20, y + 4, 16, "center")
				if (not mousepressed) and nodialog and mouseon(x + 20, y, 16, 16) and love.mouse.isDown("l") then
					mousepressed = true
					table.insert(should_shift_up, name)
				end
			end

			if i ~= 2 then
				hoverrectangle(128,128,128,128, x + 40, y, 16, 16)
				ved_printf(arrow_down, x + 40, y+4, 16, "center")
				if (not mousepressed) and nodialog and mouseon(x + 40, y, 16, 16) and love.mouse.isDown("l") then
					mousepressed = true
					table.insert(should_shift_down, name)
				end
			end
		end

		local theme_info = theming:get_themes()[name].info

		ved_print(theme_info.name .. " by " .. theme_info.author, x + 48 + 16, y)
		y = y + 24
	end

	love.graphics.setColor(128, 128, 128)

	y = y + 24

	love.graphics.setLineWidth(2)
	love.graphics.setLineStyle("rough")
	love.graphics.line(x, y, x + 160, y)
	love.graphics.setLineWidth(1)

	y = y + 24

	love.graphics.setColor(255, 255, 255)
	ved_print(L.INACTIVETHEMES, 8, y)

	y = y + 24

	for i, name in ipairs(inactive_themes) do
		local theme_info = theming:get_themes()[name].info
		hoverrectangle(128,128,128,128, x, y, 16, 16)
		ved_printf(arrow_up, x, y+4, 16, "center")
		ved_print(theme_info.name .. " by " .. theme_info.author, x + 24, y)
		if (not mousepressed) and nodialog and mouseon(x, y, 16, 16) and love.mouse.isDown("l") then
			mousepressed = true
			table.insert(should_enable, name)
		end
		y = y + 24
	end

	rbutton({L.BTN_OK, "b"}, 0)

	for _, name in ipairs(should_disable) do
		theming:disable_theme(name)
	end

	for _, name in ipairs(should_enable) do
		theming:enable_theme(name)
	end

	for _, name in ipairs(should_shift_up) do
		theming:shift_theme_up(name)
	end

	for _, name in ipairs(should_shift_down) do
		theming:shift_theme_down(name)
	end

	if nodialog and not mousepressed and love.mouse.isDown("l") then
		if onrbutton(0) then
			-- Save
			exitdisplayoptions()
		end

		mousepressed = true
	end
end
