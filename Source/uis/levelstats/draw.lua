-- levelstats/draw

return function()
	-- basic_stats has elements: {name, value, max, alt_max}
	local p100 = love.graphics.getWidth() - 40 - basic_stats_max_text_width
	for k,v in pairs(basic_stats) do
		local unlimited = false
		if v.max == math.huge then
			unlimited = true
		end

		font_ui:print(v.name .. " " .. v.value .. "/" .. v.max, 16, 16*k)

		-- Background
		love.graphics.setColor(32, 32, 32)
		love.graphics.rectangle("fill",
			24+basic_stats_max_text_width, 16*k,
			p100, 8
		)
		-- Value
		local perone
		if unlimited then
			perone = v.value / v.alt_max
		else
			perone = v.value / v.max
		end
		if unlimited then
			love.graphics.setColor(0,64,0)
		elseif perone < .8 then
			love.graphics.setColor(38,127,0)
		elseif perone < .95 then
			love.graphics.setColor(255,216,0)
		elseif perone < 1 then
			love.graphics.setColor(255,0,0)
		else
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
		end

		local bar_x, bar_y = 24+basic_stats_max_text_width, 16*k
		local bar_width = math.floor(math.min(perone, 1)*p100)
		love.graphics.rectangle("fill", bar_x, bar_y, bar_width, 8)

		if unlimited then
			local alt_max_x = math.floor(bar_x+(p100/(math.max(perone, 1)))-1)

			love.graphics.setColor(96, 96, 96)
			love.graphics.rectangle("fill", alt_max_x, bar_y, 1, 8)
			tinyfont:printf(v.alt_max, 0, bar_y+1, alt_max_x, "right")

			love.graphics.setScissor(bar_x, bar_y, bar_width, 8)
			love.graphics.setColor(0, 128, 0)
			love.graphics.rectangle("fill", alt_max_x, bar_y, 1, 8)
			tinyfont:printf(v.alt_max, 0, bar_y+1, alt_max_x, "right")

			love.graphics.setScissor()
		end

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
