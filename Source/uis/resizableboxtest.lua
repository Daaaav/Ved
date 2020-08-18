local ui = {name = "resizableboxtest"}

function ui.load()
	box_exists = true
	box_x, box_y, box_w, box_h = 80,80,208,208
	boxperi_x, boxperi_y, boxperi_w, boxperi_h = 0,0,love.graphics.getWidth(),love.graphics.getHeight()
	box_type = 0
end

ui.elements = {
	
}

function ui.draw()
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

	ved_print((box_exists and "Box exists" or "Box exists not") .. "\nPeri xywh " .. boxperi_x .. " " .. boxperi_y .. " " .. boxperi_w .. " " .. boxperi_h .. "\nBox xywh " .. box_x .. " " .. box_y .. " " .. box_w .. " " .. box_h .. "\nMoving HV: " .. box_moving_h .. box_moving_v .. "\n\nType " .. box_type .. "\nM for switching type -1/0\nV for shrinking the allowed perimeter\nR Reset\nE Re-enable", 10, 10)
end

function ui.update(dt)
end

function ui.keypressed(key)
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

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
