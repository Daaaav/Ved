-- specialroomnames/load

return function(...)
	specialroomnames_frametimer = 0

	specialroomnames_glitchprogress = 0
	specialroomnames_glitchdelay = 25 + love.math.random(0, 9)
	specialroomnames_transformdelay = 2

	if level.specialroomnames[roomy] ~= nil and level.specialroomnames[roomy][roomx] ~= nil then
		-- Reset all roomname frames to 0
		for k,v in pairs(level.specialroomnames[roomy][roomx]) do
			v.progress = 0
		end
	end

	specialroomnames_update_elements()

	specialroomnames_editing = nil
	specialroomnames_currentinput = "roomname" -- for glitch ones with 2 text fields
end
