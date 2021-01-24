-- dialogtest/mousepressed

return function(x, y, button)
	if button == "r" then
		rightclickmenu.create({"Delete", "Edit script", "Rename"}, "1")
	elseif button == "l" then
		tbx, tby = math.floor((x-screenoffset)/2), math.floor(y/2)
		table.insert(vvvvvv_textboxes, {({"cyan", "red", "yellow", "green", "blue", "purple", "gray"})[math.random(1,7)], tbx, tby, {"Text!", tbx .. "," .. tby}})
	end
end
