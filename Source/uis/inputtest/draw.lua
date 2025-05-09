-- inputtest/draw

return function()
	newinputsys.print("inputtest", 100, 0)
	newinputsys.print("inputtest2", 100, 50)
	newinputsys.print("inputtest3", 100, 100, nil, nil, 2)
	newinputsys.print("inputtest4", 100, 150, nil, nil, 1, 2)
	newinputsys.print("inputtest5", 100, 200)
	newinputsys.print("inputtest6", 100, 250)
	newinputsys.print("inputtest7", 100, 300)
	newinputsys.print("inputtest8", 100, 350)
	newinputsys.print("inputtest9", 100, 400, nil, nil, nil, nil, 10)

	local youhaveselected = "You have selected: "
	local tmp = newinputsys.getseltext(newinputsys.input_ids[#newinputsys.nth_input])
	if tmp ~= nil then
		font_8x8:print(youhaveselected .. tmp, 580, 112)
	end
end
