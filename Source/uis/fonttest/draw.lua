-- fonttest/draw

return function()
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
	tinyfont:print(input, 32, 96)

	ved_print("Font test", 10, 10)
end
