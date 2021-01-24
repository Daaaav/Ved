-- maineditor/mousepressed

return function(x, y, button)
	if x < 64 and not s.psmallerscreen and not (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) then
		if button == "wu" then
			lefttoolscroll = lefttoolscroll + 16
			lefttoolscrollbounds()
		elseif button == "wd" then
			lefttoolscroll = lefttoolscroll - 16
			lefttoolscrollbounds()
		end
	elseif mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-16-2-4-8, (6*16), 8+4) then -- show all tiles
		tilespicker = not tilespicker
		editingroomname = false

	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wd" or "wu") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		if selectedtool > 1 then
			selectedtool = selectedtool - 1
		else
			selectedtool = 17
			if metadata.target == "VCE" then
				selectedtool = 20
			end
		end
		updatewindowicon()
		toolscroll()
	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wu" or "wd") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		local tool_count = 17
		if metadata.target == "VCE" then
			tool_count = 20
		end
		if selectedtool < tool_count then
			selectedtool = selectedtool + 1
		else
			selectedtool = 1
		end
		updatewindowicon()
		toolscroll()
	elseif button == flipscrollmore(macscrolling and "wd" or "wu") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
		if selectedsubtool[selectedtool] > 1 then
			selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
		else
			selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
		end
	elseif button == flipscrollmore(macscrolling and "wu" or "wd") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
		if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
			selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
		else
			selectedsubtool[selectedtool] = 1
		end
	end
end
