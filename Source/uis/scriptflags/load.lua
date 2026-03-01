-- scriptflags/load

return function(picker_mode, picked)
	flags_digits = tostring(level.limit.flags-1):len()
	flags_page = 0

	-- nil for regular flags list, or a string for a picker
	flags_picker = picker_mode
	flags_picker_current = picked

	mousepressed_flag = false
	mousepressed_flag_x = -1
	mousepressed_flag_y = -1
	mousepressed_flag_num = -1
	mousepressed_flag_name = ""
	mousereleased_flag = false

	loadflagslist()
end
