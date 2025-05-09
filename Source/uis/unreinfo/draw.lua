-- unreinfo/draw

return function()
	-- Dev/testing/debug state, not translated
	font_8x8:print("Undo stack:\n" .. undostacktext, 8, 8)
	font_8x8:print("Redo stack:\n" .. redostacktext, love.graphics.getWidth()/2 + 8, 8)
end
