-- language/draw

return function()
	local language_x = love.graphics.getWidth()/2-64-widestlang
	font_ui:print(L.LANGUAGE, language_x, 32+4)

	for k,v in pairs(all_languages) do
		local langname, font
		if langinfo[v] ~= nil then
			langname = langinfo[v].name
			font = fonts_main[langinfo[v].font]
		else
			langname = v
		end
		if font == nil then
			font = font_8x8
		end
		radio(s.lang == v, language_x, 32+(24*k), v, langname,
			function(key)
				changelanguage(key)
			end,
			nil,
			font
		)
	end

	local dateformat_x = love.graphics.getWidth()/2+64
	local year = os.date("%Y")
	font_ui:print(L.DATEFORMAT, dateformat_x, 32+4)

	for k,v in pairs({
		{"YMD", year .. "-12-31"},
		{"DMY", "31-12-" .. year},
		{"MDY", "12/31/" .. year},
	}) do
		radio(s.new_dateformat == v[1], dateformat_x, 32+(24*k), v[1], v[2],
			function(key)
				s.new_dateformat = v[1]
			end
		)
	end

	font_ui:print(L.TIMEFORMAT, dateformat_x, 32+96+24+4)

	for k,v in pairs({
		{24, "23:59"},
		{12, "11:59pm"}
	}) do
		radio(s.new_timeformat == v[1], dateformat_x, 32+96+24+(24*k), v[1], v[2],
			function(key)
				s.new_timeformat = v[1]
			end
		)
	end

	local bottomleft_text = L.TRANSLATIONCREDIT
	if s.lang == "en" then
		-- Yeah, hardcoded text!
		bottomleft_text = "Want to help translate Ved? Please contact Dav999!"
	end

	font_ui:printf(bottomleft_text, 64, love.graphics.getHeight()-40, love.graphics.getWidth()-128, "center")


	rbutton({L.BTN_OK, "b"}, 0)


	if nodialog and not mousepressed and love.mouse.isDown("l") then
		if onrbutton(0) then
			-- Save
			exitlanguageoptions()
		end

		mousepressed = true
	end
end
