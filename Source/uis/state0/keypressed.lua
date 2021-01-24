-- state0/keypressed

return function(key)
	if table.contains({"return", "kpenter"}, key) then
		stopinput()
		tostate(input, keyboard_eitherIsDown("shift"))
	end
end
