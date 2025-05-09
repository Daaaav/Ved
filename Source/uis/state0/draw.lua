-- state0/draw

return function()
	font_8x8:print("Placeholder main menu. Enter state:", 10, 10)
	newinputsys.print("state", 20, 30, nil, nil, 2)
	font_8x8:print("ENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 74)

	local state_y = 16
	for k,v in pairs(uis) do
		font_8x8:print(k .. " - " .. v.name, love.graphics.getWidth()-280, state_y)
		state_y = state_y + 10
	end
end
