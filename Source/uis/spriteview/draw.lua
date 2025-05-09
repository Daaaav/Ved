-- spriteview/draw

return function()
	for y = 0, 7 do
		for x = 0, 23 do
			if mouseon(x*32, y*32, 32, 32) then
				font_8x8:print((y*24)+x, love.graphics.getWidth()-24, love.graphics.getHeight()-8)
				love.graphics.setColor(255,255,255,64)
				love.graphics.rectangle("fill", x*32, y*32, 32, 32)
				love.graphics.setColor(255,255,255)
			end

			love.graphics.draw(tilesets["sprites.png"].white_img, tilesets["sprites.png"].tiles[(y*24)+x], x*32, y*32)
		end
	end
end
