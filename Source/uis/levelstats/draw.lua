-- levelstats/draw

return function()
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
