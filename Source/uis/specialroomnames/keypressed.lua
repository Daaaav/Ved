-- specialroomnames/keypressed

return function(key)
	if key == "tab"
	and specialroomnames_editing ~= nil and specialroomnames_editing ~= 0
	and level.specialroomnames[roomy][roomx][specialroomnames_editing].mode == "glitch" then
		if specialroomnames_currentinput == "roomname" then
			specialroomnames_currentinput = "roomname2"
		else
			specialroomnames_currentinput = "roomname"
		end
		newinputsys.bump(specialroomnames_currentinput)
	end
end
