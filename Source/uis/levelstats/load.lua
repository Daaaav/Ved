-- levelstats/load

return function()
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
		{name=L.AMOUNTSCRIPTS, value=#scriptnames, max=limit.scripts, alt_max=500},
		{name=L.AMOUNTUSEDFLAGS, value=n_usedflags, max=limit.flags, alt_max=100},
		{name=L.AMOUNTENTITIES, value=anythingbutnil0(count.entities), max=limit.entities, alt_max=3000},
		{name=L.AMOUNTTRINKETS, value=anythingbutnil0(count.trinkets), max=limit.trinkets, alt_max=100},
		{name=L.AMOUNTCREWMATES, value=anythingbutnil0(count.crewmates), max=limit.crewmates, alt_max=100},
	}

	basic_stats_max_text_width = 0
	limitglow_enabled = false
	for k,v in pairs(basic_stats) do
		local width = font8:getWidth(v.name .. " /" .. v.value .. v.max)

		if width > basic_stats_max_text_width then
			basic_stats_max_text_width = width
		end

		if v.value > v.max then
			limitglow_enabled = true
		end
	end
end
