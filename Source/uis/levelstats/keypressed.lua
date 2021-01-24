-- levelstats/keypressed

return function(key)
	if key == "escape" then
		tostate(oldstate, true)
		nodialog = false
	end
end
