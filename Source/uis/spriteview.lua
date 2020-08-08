local ui = {name = "spriteview"}

function ui.load()
end

ui.elements = {
	
}

function ui.draw()
	for y = 0, 7 do
		for x = 0, 23 do
			if mouseon(x*32, y*32, 32, 32) then
				ved_print((y*24)+x, love.graphics.getWidth()-24, love.graphics.getHeight()-8)
				love.graphics.setColor(255,255,255,64)
				love.graphics.rectangle("fill", x*32, y*32, 32, 32)
				love.graphics.setColor(255,255,255)
			end

			love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][(y*24)+x], x*32, y*32)
		end
	end
end

function ui.update(dt)
end

function ui.keypressed(key)
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
