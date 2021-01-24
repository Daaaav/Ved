-- state0/draw

return function()
	ved_print("Placeholder main menu. Enter state: " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 10)

	local state_y = 16
	for k,v in pairs(uis) do
		ved_print(k .. " - " .. v.name, love.graphics.getWidth()-280, state_y)
		state_y = state_y + 10
	end

	startinputonce()
end
