-- levelslist/mousereleased

return function(x, y, button)
	if not secondlevel and not backupscreen and button == "l" and onrbutton(1, nil, true) then
		-- This has to be in mousereleased, since opening a window with a mouse press prevents a mouse
		-- release event to occur, which either causes the next click to be missed, or causes a new
		-- window to be opened on focus when you try to fix that!
		explore_lvl_dir()
	end
end
