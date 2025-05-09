-- resizableboxtest/draw

return function()
	love.graphics.setColor(0,0,50)
	love.graphics.rectangle("fill", boxperi_x, boxperi_y, boxperi_w, boxperi_h)
	love.graphics.setColor(50,50,50)
	for li = 0, love.graphics.getWidth(), 16 do
		love.graphics.line(li, 0, li, love.graphics.getHeight())
	end	
	for li = 0, love.graphics.getHeight(), 16 do
		love.graphics.line(0, li, love.graphics.getWidth(), li)
	end
	love.graphics.setColor(255,255,255,255)

	love.graphics.rectangle("line", box_x, box_y, box_w, box_h)

	font_8x8:print((box_exists and "Box exists" or "Box exists not") .. "\nPeri xywh " .. boxperi_x .. " " .. boxperi_y .. " " .. boxperi_w .. " " .. boxperi_h .. "\nBox xywh " .. box_x .. " " .. box_y .. " " .. box_w .. " " .. box_h .. "\nMoving HV: " .. box_moving_h .. box_moving_v .. "\n\nType " .. box_type .. "\nM for switching type -1/0\nV for shrinking the allowed perimeter\nR Reset\nE Re-enable", 10, 10)
end
