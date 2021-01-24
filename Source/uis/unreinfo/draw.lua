-- unreinfo/draw

return function()
	-- Dev/testing/debug state, not translated
	ved_print("Undo stack:\n" .. undostacktext, 8, 8)
	ved_print("Redo stack:\n" .. redostacktext, love.graphics.getWidth()/2 + 8, 8)
end
