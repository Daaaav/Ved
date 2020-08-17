local ui = {name = "help"}

function ui.load(mode)
	helplistscroll = 0
	helparticle = 2
	helparticlescroll = 0
	helpeditingline = 0
	helprefreshable = false
	onlefthelpbuttons = false
	part1parts_cache = {}
	cachedlink = nil
	matching_url = nil
	matching_article = nil
	matching_anchor = nil
	matching_article_num = nil
	matching_anchor_line = nil

	-- Are we gonna use this for Ved help, for level notes, something else?
	if mode == nil then
		-- Just the Ved help
		helppages = LH
		helpeditable = false
		helparticlecontent = explode("\n", helppages[helparticle].cont)
	elseif mode == "plugins" then
		--helppages = {}
		loadpluginpages()
		helpeditable = false
		helparticlecontent = explode("\n", helppages[helparticle].cont)
	else
		-- Level notes (or something else because extradata is an array here!)
		helppages = mode[1]
		helpeditable = mode[2]
		helprefreshable = mode[3]
		if helppages[2] ~= nil then
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		end
	end
end

ui.elements = {
	DrawingFunction(drawhelp),
}

function ui.draw()
end

function ui.update(dt)
	if s.psmallerscreen then
		local leftpartw = 8+200+8-96-2
		local extrawidth = 0
		if helprefreshable then
			extrawidth = 20
		end
		if love.mouse.getX() <= leftpartw then
			onlefthelpbuttons = true
		elseif love.mouse.getX() > 25*8+16-28+extrawidth then
			onlefthelpbuttons = false
		end
	end
end

function ui.keypressed(key)
	if key == "escape" then
		tostate(oldstate, true)
		if state == 11 then
			-- Back to search results
			startinput()
			input = searchedfor
		end
		nodialog = false
	elseif helpeditingline ~= 0 then
		if keyboard_eitherIsDown(ctrl) and keyboard_eitherIsDown("alt") then
			inplacescroll(key)
		elseif key == "up" and helpeditingline ~= 1 then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline - 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "down" and helparticlecontent[helpeditingline+1] ~= nil then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif table.contains({"return", "kpenter"}, key) then
			table.insert(helparticlecontent, helpeditingline+1, "")
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "insert" then
			if keyboard_eitherIsDown("shift") then
				input = input .. "§"
			else
				input = input .. "¤"
			end
			helparticlecontent[helpeditingline] = input
		elseif key == "d" and keyboard_eitherIsDown(ctrl) then
			if #helparticlecontent > 1 then
				table.remove(helparticlecontent, helpeditingline)
			else
				helparticlecontent[helpeditingline] = ""
			end
			if keyboard_eitherIsDown("shift") then
				helpeditingline = math.max(helpeditingline - 1, 1)
			else
				if helpeditingline > #helparticlecontent and helpeditingline > 1 then
					helpeditingline = helpeditingline - 1
				end
			end
			input = anythingbutnil(helparticlecontent[helpeditingline])
			input_r = ""
		end
	elseif key == "up" then
		gotohelparticle(revcycle(helparticle, #helppages, 2))
	elseif key == "down" then
		gotohelparticle(cycle(helparticle, #helppages, 2))
	elseif table.contains({"home", "end"}, key) then
		handle_scrolling(true, key)
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
	if helpeditingline ~= 0 and button == "l" and mouseon(
		214+(s.psmallerscreen and -96 or 0),
		8,
		love.graphics.getWidth()-238-(s.psmallerscreen and -96 or 0),
		love.graphics.getHeight()-16
	) then
		local chr, line
		local screenxoffset = 0
		if s.psmallerscreen then
			screenxoffset = -96
		end
		chr = math.floor((x-216-screenxoffset)/8) + 1
		line = math.floor(((y-8)-helparticlescroll-3)/10) + 1
		helpgotoline(line, chr)
	end
end

function ui.mousereleased(x, y, button)
end

return ui
