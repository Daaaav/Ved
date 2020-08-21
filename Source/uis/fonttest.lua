local ui = {name = "fonttest"}

function ui.load()
	startinput()
end

ui.elements = {
	
}

function ui.draw()
	love.graphics.setColor(128,128,255,64)
	love.graphics.rectangle("line", 32.5, 32.5, font8:getWidth(input), 8)
	love.graphics.rectangle("line", 32.5, 64.5, font8:getWidth(input)*2, 16)
	love.graphics.rectangle("line", 32.5, 96.5, tinynumbers:getWidth(input), 7)
	love.graphics.setColor(255,128,128,64)
	love.graphics.rectangle("line", 32.5, 32.5-2, font8:getWidth(input), 8)
	love.graphics.rectangle("line", 32.5, 64.5-4, font8:getWidth(input)*2, 16)
	love.graphics.setColor(255,255,255)
	ved_print(input, 32, 32)
	ved_print(input, 32, 64, 2)
	ved_setFont(tinynumbers)
	ved_print(input, 32, 96)
	ved_setFont(font8)

	ved_print("Font test", 10, 10)
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
