-- theming/keyreleased

return function(key)
	if key == "escape" then
		-- Put it here instead of love.keypressed,
		-- otherwise the new window will interpret a hold as a press
		exitdisplayoptions()
	end
end
