-- fonttest/draw

return function()
	-- Using font_level on purpose, so it's the most changeable. This is a test state anyway
	love.graphics.setColor(128,128,255,64)
	love.graphics.rectangle("line", 32.5, 32.5, font_level:getWidth(input), 8)
	love.graphics.rectangle("line", 32.5, 64.5, font_level:getWidth(input)*2, 16)
	love.graphics.rectangle("line", 32.5, 96.5, tinyfont:getWidth(input), 7)
	love.graphics.setColor(255,128,128,64)
	love.graphics.rectangle("line", 32.5, 32.5-2, font_level:getWidth(input), 8)
	love.graphics.rectangle("line", 32.5, 64.5-4, font_level:getWidth(input)*2, 16)
	love.graphics.setColor(255,255,255)
	font_level:print(input, 32, 32)
	font_level:print(input, 32, 64, 2)
	tinyfont:print(input, 32, 96)

	font_level:print("Font test", 10, 10)
end
