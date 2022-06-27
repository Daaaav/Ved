-- map/wheelmoved

return function(xm, ym)
	if ym == 0 then
		return
	end

	local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17
	if flipscrollmore(macscrolling and -ym or ym) > 0 then
		if not toolanyofthese then
			selectedtool = 17
		elseif selectedtool == 17 then
			selectedtool = 16
		elseif selectedtool == 16 then
			selectedtool = 4
		elseif selectedtool == 4 then
			selectedtool = 1
		end
	else
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
