-- map/keypressed

return function(key)
	if key == "p" and keyboard_eitherIsDown(ctrl) then
		gotostartpointroom()
	elseif key == "right" or key == "kp6" then
		-->
		gotoroom_r()
		mapmovedroom = true
	elseif key == "left" or key == "kp4" then
		--<
		gotoroom_l()
		mapmovedroom = true
	elseif key == "down" or key == "kp2" then
		--v
		gotoroom_d()
		mapmovedroom = true
	elseif key == "up" or key == "kp8" then
		--^
		gotoroom_u()
		mapmovedroom = true
	elseif table.contains({"return", "kpenter"}, key) or key == "m" or key == "kp5" then
		tostate(1, true)
		nodialog = false
	elseif key == "," or key == "." then
		local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17
		if key == "," then
			if not toolanyofthese then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 1
			end
		elseif key == "." then
			if not toolanyofthese then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 1
			end
		end
		updatewindowicon()
		toolscroll()
	else
		for k,v in pairs(toolshortcuts) do
			if key == string.lower(v) then
				if not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					selectedtool = k
					updatewindowicon()
				end
				toolscroll()
			end
		end
	end
end
