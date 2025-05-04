-- maineditor/wheelmoved

return function(xm, ym)
	if ym == 0 then
		return
	end

	local pos_x = love.mouse.getX()

	if pos_x < 64 and not s.psmallerscreen and not (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) then
		if ym > 0 then
			lefttoolscroll = lefttoolscroll + 16
			lefttoolscrollbounds()
		else
			lefttoolscroll = lefttoolscroll - 16
			lefttoolscrollbounds()
		end

	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and flipscrollmore(macscrolling and -ym or ym) > 0 and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		if selectedtool > 1 then
			selectedtool = selectedtool - 1
		else
			selectedtool = 17
		end
		updatewindowicon()
		toolscroll()
	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and flipscrollmore(macscrolling and -ym or ym) < 0 and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		local tool_count = 17
		if selectedtool < tool_count then
			selectedtool = selectedtool + 1
		else
			selectedtool = 1
		end
		updatewindowicon()
		toolscroll()
	elseif (pos_x >= 64 or s.psmallerscreen) and selectedtool ~= 13 and selectedtool ~= 14 then
		if flipscrollmore(macscrolling and -ym or ym) > 0 then
			if selectedsubtool[selectedtool] > 1 then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
			else
				selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
			end
		else
			if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
			else
				selectedsubtool[selectedtool] = 1
			end
		end
	end
end
