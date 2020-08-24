local ui = {name = "language"}

function ui.load()
	alllanguages = getalllanguages()
	widestlang = 0
	for k,v in pairs(alllanguages) do
		local langname
		if langinfo[v] ~= nil then
			langname = langinfo[v].name
		else
			langname = v
		end
		local w = font8:getWidth(langname)
		if w > widestlang then
			widestlang = w
		end
	end
end

ui.elements = {
}

function ui.draw()
	local language_x = love.graphics.getWidth()/2-64-widestlang
	ved_print(L.LANGUAGE, language_x, 32+4)

	for k,v in pairs(alllanguages) do
		local langname
		if langinfo[v] ~= nil then
			langname = langinfo[v].name
		else
			langname = v
		end
		radio(s.lang == v, language_x, 32+(24*k), v, langname,
			function(key)
				changelanguage(key)
			end
		)
	end

	local dateformat_x = love.graphics.getWidth()/2+64
	local year = os.date("%Y")
	ved_print(L.DATEFORMAT, dateformat_x, 32+4)

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

	ved_print(L.TIMEFORMAT, dateformat_x, 32+96+24+4)

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

	ved_printf(bottomleft_text, 64, love.graphics.getHeight()-40, love.graphics.getWidth()-128, "center")


	rbutton({L.BTN_OK, "b"}, 0)


	if nodialog and not mousepressed and love.mouse.isDown("l") then
		if onrbutton(0) then
			-- Save
			exitlanguageoptions()
		end

		mousepressed = true
	end
end

function ui.update(dt)
end

function ui.keypressed(key)
	if key == "escape" or key == "return" then
		exitlanguageoptions()
	elseif key == "up" or key == "down" then
		local curlang
		for k,v in pairs(alllanguages) do
			if v == s.lang then
				curlang = k
				break
			end
		end
		if curlang == nil then
			changelanguage("en")
		else
			local newlang
			if key == "up" then
				newlang = curlang - 1
				if newlang < 1 then
					newlang = #alllanguages
				end
			elseif key == "down" then
				newlang = curlang + 1
				if newlang > #alllanguages then
					newlang = 1
				end
			end
			changelanguage(alllanguages[newlang])
		end
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
