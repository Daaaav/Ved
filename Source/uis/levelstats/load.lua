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
		{L.AMOUNTSCRIPTS, #scriptnames, limit.scripts, math.huge},
		{L.AMOUNTUSEDFLAGS, n_usedflags, limit.flags, 100},
		{L.AMOUNTENTITIES, anythingbutnil0(count.entities), limit.entities, math.huge},
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
