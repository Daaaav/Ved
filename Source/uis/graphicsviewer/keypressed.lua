-- graphicsviewer/keypressed

return function(key)
	if key == "escape" then
		tostate(oldstate, true)
		if state == 30 then
			oldstate = olderstate
		end
		nodialog = false
	elseif key == "l" then
		assets_graphicsloaddialog()
	elseif imageviewer_image_color ~= nil then
		if key == "=" or key == "+" or key == "kp+" then
			imageviewer_zoomin()
		elseif key == "-" or key == "kp-" then
			imageviewer_zoomout()
		elseif key == "c" then
			imageviewer_showwhite = not imageviewer_showwhite
		elseif key == "`" then
			imageviewer_grid = 0
		elseif key == "1" then
			imageviewer_grid = 1
		elseif key == "2" then
			imageviewer_grid = 8
		elseif key == "3" then
			imageviewer_grid = 32
		elseif key == "r" then
			assets_graphicsreload()
		end
	end
end
