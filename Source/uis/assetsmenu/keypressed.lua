-- assetsmenu/keypressed

return function(key)
	if key == "escape" then
		tostate(oldstate, true)
		nodialog = false
	elseif key == "f11" then
		assets_reload_pressed()
		nodialog = false
	end
end
