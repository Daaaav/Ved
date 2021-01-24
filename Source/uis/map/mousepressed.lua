-- map/mousepressed

return function(x, y, button)
	if button == "wu" or button == "wd" then
		local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17
		if button == flipscrollmore(macscrolling and "wd" or "wu") then
			if not toolanyofthese then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 1
			end
		elseif button == flipscrollmore(macscrolling and "wu" or "wd") then
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
	end
end
