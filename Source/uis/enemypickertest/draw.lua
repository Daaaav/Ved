-- enemypickertest/draw

return function()
	for r = 0, 1 do
		for c = 0, 4 do
			drawentitysprite(enemysprites[5*r+c], 16+48*c, 16+48*r)
		end
	end

	for r = 0, 1 do
		for c = 0, 4 do
			drawentitysprite(enemysprites[5*r+c], 600+16*c, 16+16*r, true)
		end
	end
end
