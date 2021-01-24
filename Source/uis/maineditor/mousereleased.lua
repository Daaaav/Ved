-- maineditor/mousereleased

return function(x, y, button)
	if undosaved ~= 0 and undobuffer[undosaved] ~= nil then
		undobuffer[undosaved].toredotiles = table.copy(roomdata_get(roomx, roomy, altstate))
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	end
end
