local ui = {name = "levelstats"}

function ui.load()
	local usedflags = {}

	-- See which flags have been used in this level.
	returnusedflags(usedflags, {})

	local n_usedflags = 0
	for fl = 0, limit.flags-1 do
		if usedflags[fl] then
			n_usedflags = n_usedflags + 1
		end
	end

	basic_stats = {
		{L.AMOUNTSCRIPTS, #scriptnames, limit.scripts, 500},
		{L.AMOUNTUSEDFLAGS, n_usedflags, limit.flags, 100},
		{L.AMOUNTENTITIES, anythingbutnil0(count.entities), limit.entities, 3000},
		{L.AMOUNTTRINKETS, anythingbutnil0(count.trinkets), limit.trinkets, 100},
		{L.AMOUNTCREWMATES, anythingbutnil0(count.crewmates), limit.crewmates, 100},
	}

	basic_stats_max_text_width = 0
	limitglow_enabled = false
	for k,v in pairs(basic_stats) do
		local width = font8:getWidth(v[1] .. " /" .. v[2] .. v[3])

		if width > basic_stats_max_text_width then
			basic_stats_max_text_width = width
		end

		if v[2] > v[3] then
			limitglow_enabled = true
		end
	end
end

ui.elements = {
}

function ui.draw()
	-- basic_stats has elements: {name, value, max, vvvvvvmax}
	local p100 = love.graphics.getWidth() - 40 - basic_stats_max_text_width
	for k,v in pairs(basic_stats) do
		ved_print(v[1] .. " " .. v[2] .. "/" .. v[3], 16, 16*k)

		-- Background
		love.graphics.setColor(32, 32, 32)
		love.graphics.rectangle("fill",
			24+basic_stats_max_text_width, 16*k,
			p100, 8
		)
		-- Value
		local perone = v[2] / v[3]
		if perone >= 1 then
			-- limitglow can be between 0 and 2
			local glowadd = 0
			if perone > 1 then
				if limitglow > 1 then
					glowadd = 125*(2-limitglow)
				else
					glowadd = 125*limitglow
				end
			end
			love.graphics.setColor(130+glowadd,0,0)
		elseif perone >= .95 then
			love.graphics.setColor(255,0,0)
		elseif perone >= .8 then
			love.graphics.setColor(255,216,0)
		else
			love.graphics.setColor(38,127,0)
		end
		love.graphics.rectangle("fill",
			24+basic_stats_max_text_width, 16*k,
			math.min(perone, 1)*p100, 8
		)
		love.graphics.setColor(255,255,255)
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)

	if nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(oldstate, true) -- keep the scrollbar "farness"
			mousepressed = true
		end
	end
end

function ui.update(dt)
	if limitglow_enabled then
		limitglow = limitglow + dt

		if limitglow > 2 then
			limitglow = limitglow - 2
		end
	end
end

function ui.keypressed(key)
	if key == "escape" then
		tostate(oldstate, true)
		nodialog = false
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
