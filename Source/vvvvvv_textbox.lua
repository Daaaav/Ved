-- Display a text box like in a VVVVVV cutscene.
-- text is a table with the lines.
function vvvvvv_textbox(color, x, y, text)
	maxwidth = 0
	for k,v in pairs(text) do
		if v:len() > maxwidth then
			maxwidth = v:len()
		end
	end

	-- Coordinate corrections, consistent with VVVVVV
	x = math.min(math.max(x, 10), 294-(maxwidth*8)) -- VVVVVV always has a padding of 10 pixels. 320-10-16 since the left and right edges are always there
	y = math.min(math.max(y, 10), 214-(#text*8)) -- 240-10-16

	x = (screenoffset/2) + x

	-- What color?
	if textboxcolors[color] == nil then
		color = "gray"
	end

	-- Text box backgrounds apparently divide all color values by 6
	love.graphics.setColor(
		math.floor(textboxcolors[color][1]/6),
		math.floor(textboxcolors[color][2]/6),
		math.floor(textboxcolors[color][3]/6)
	)
	love.graphics.rectangle("fill", x*2, y*2, 32+maxwidth*16, 32+(#text*16))

	-- All the edge parts
	love.graphics.setColor(textboxcolors[color])
	love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][40], x*2, y*2, 0, 2) -- top left
	love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][42], x*2+16+maxwidth*16, y*2, 0, 2) -- top right
	love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][45], x*2, y*2+16+(#text*16), 0, 2) -- bottom left
	love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][47], x*2+16+maxwidth*16, y*2+16+(#text*16), 0, 2) -- bottom right
	for i = 1, maxwidth do
		love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][41], x*2+i*16, y*2, 0, 2) -- top
		love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][46], x*2+i*16, y*2+16+(#text*16), 0, 2) -- bottom
	end
	for i = 1, #text do
		love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][43], x*2, y*2+i*16, 0, 2) -- left
		love.graphics.draw(tilesets["tiles.png"]["white_img"], tilesets["tiles.png"]["tiles"][44], x*2+16+maxwidth*16, y*2+i*16, 0, 2) -- right
	end

	-- Now put the text in
	love.graphics.setFont(font16)
	for k,v in pairs(text) do
		love.graphics.print(v, x*2+16, y*2+k*16 +3)
	end
	love.graphics.setFont(font8)

	love.graphics.setColor(255,255,255)
end
