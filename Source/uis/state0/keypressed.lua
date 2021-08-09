-- state0/keypressed

return function(key)
	if table.contains({"return", "kpenter"}, key) then
		local s = inputs.state
		newinputsys.close("state")
		tostate(s, keyboard_eitherIsDown("shift"))
	end
end
