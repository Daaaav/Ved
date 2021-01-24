-- inputtest/keypressed

return function(key)
	if key == "tab" then
		newinputsys.bump(newinputsys.input_ids[#newinputsys.nth_input - 8])
	end
end
