-- maineditor/mousereleased

return function(x, y, button)
	if undosaved ~= 0 and undobuffer[undosaved] ~= nil then
		undobuffer[undosaved].toredotiles = table.copy(roomdata_get(roomx, roomy))
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	end

	if not playtesting_mousepressed and playtesting_uistate == PT_UISTATE.ASKING and button == "l" then
		local mouseoncanvas = mouseon(screenoffset, 0, 640, love.graphics.getHeight())

		if mouseoncanvas then
			local atx, aty = x, y
			atx = atx - screenoffset
			atx = math.floor(atx / 2)
			aty = math.floor(aty / 2)
			playtesting_endaskwherestart(atx, aty)
		else
			playtesting_cancelask()
		end
	end
	playtesting_mousepressed = false
end
