-- theme/keypressed

return function(key)
	if key == "escape" then
		saveconfig()
		tostate(oldstate, true)
		oldstate = olderstate
	end
end
