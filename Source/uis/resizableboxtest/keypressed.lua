-- resizableboxtest/keypressed

return function(key)
	if key == "m" then
		if box_type == 0 then
			box_type = -1
		else
			box_type = 0
		end
	elseif key == "v" then
		boxperi_x, boxperi_y, boxperi_w, boxperi_h = boxperi_x+16, boxperi_y+16, boxperi_w-32, boxperi_h-32
	elseif key == "r" then
		box_x, box_y, box_w, box_h = 80,80,208,208
		boxperi_x, boxperi_y, boxperi_w, boxperi_h = 0,0,love.graphics.getWidth(),love.graphics.getHeight()
	elseif key == "e" then
		box_exists = true
	end
end
