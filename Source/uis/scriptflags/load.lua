-- scriptflags/load

return function()
	flags_digits = tostring(limit.flags-1):len()
	flags_page = 0

	loadflagslist()
end
