-- specialroomnames/update

return function(dt)
	-- This function has some awfully long names but oh well...

	specialroomnames_frametimer = specialroomnames_frametimer + dt
	while specialroomnames_frametimer > .034 do
		-- Transforming roomnames
		specialroomnames_transformdelay = specialroomnames_transformdelay - 1
		if specialroomnames_transformdelay <= 0 then
			specialroomnames_transformdelay = 2
			if level.specialroomnames[roomy] ~= nil and level.specialroomnames[roomy][roomx] ~= nil then
				for k,v in pairs(level.specialroomnames[roomy][roomx]) do
					v.progress = v.progress + 1
					local max = #v.name
					if specialroomnames_editing == k then
						max = #inputs.roomname
					end
					if v.progress >= max then
						if v.loop then
							v.progress = 0
						else
							v.progress = max - 1
						end
					end
				end
			end
		end

		-- Glitch roomnames
		specialroomnames_glitchdelay = specialroomnames_glitchdelay - 1
		if specialroomnames_glitchdelay <= 0 then
			specialroomnames_glitchprogress  = (specialroomnames_glitchprogress  + 1) % 2
			if specialroomnames_glitchprogress  == 0 then
				specialroomnames_glitchdelay  = 25 + love.math.random(0, 9)
			else
				specialroomnames_glitchdelay  = 5
			end
		end

		specialroomnames_frametimer = specialroomnames_frametimer - .034
	end
end
