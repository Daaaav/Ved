local ui = {name = "enemypickertest"}

function ui.load()
end

ui.elements = {
}

function ui.draw()
	for r = 0, 1 do
		for c = 0, 4 do
			drawentitysprite(enemysprites[5*r+c], 16+48*c, 16+48*r, 0)
		end
	end

	for r = 0, 1 do
		for c = 0, 4 do
			drawentitysprite(enemysprites[5*r+c], 600+16*c, 16+16*r, 0, true)
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
