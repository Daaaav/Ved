-- levelstats/update

return function(dt)
	if limitglow_enabled then
		limitglow = limitglow + dt

		if limitglow > 2 then
			limitglow = limitglow - 2
		end
	end
end
