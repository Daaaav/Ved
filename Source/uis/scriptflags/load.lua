-- scriptflags/load

return function()
	flags_digits = tostring(limit.flags-1):len()
	flags_page = 0

	mousepressed_flag = false
	mousepressed_flag_x = -1
	mousepressed_flag_y = -1
	mousepressed_flag_num = -1
	mousepressed_flag_name = ""
	mousereleased_flag = false

	loadflagslist()
end
