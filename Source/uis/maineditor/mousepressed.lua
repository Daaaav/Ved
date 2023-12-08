-- maineditor/mousepressed

return function(x, y, button)
	if mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-16-2-4-8, (6*16), 8+4) then -- show all tiles
		tilespicker = not tilespicker
		cancel_editing_roomname()
		if editingroomtext > 0 then
			endeditingroomtext()
		end
	end
end
