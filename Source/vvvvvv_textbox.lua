-- Display a text box like in a VVVVVV cutscene.
-- text is a table with the lines.
function vvvvvv_textbox(color, x, y, text, coords_raw)
	local width = 0
	for k,v in pairs(text) do
		local line_width = font_level:getWidth(v)
		if line_width > width then
			width = line_width
		end
	end
	local height = #text*font_level:getHeight()

	if not coords_raw then
		-- Coordinate corrections, consistent with VVVVVV
		x = math.min(math.max(x, 10), 294-width) -- VVVVVV always has a padding of 10 pixels. 320-10-16 since the left and right edges are always there
		y = math.min(math.max(y, 10), 214-height) -- 240-10-16

		x = (screenoffset/2) + x

		x = x*2
		y = y*2
	end

	width = width*2
	height = height*2

	-- What color?
	local r, g, b = get_textbox_color(color)

	if r ~= 0 or g ~= 0 or b ~= 0 then
		-- Text box backgrounds divide all color values by 6
		love.graphics.setColor(math.floor(r/6), math.floor(g/6), math.floor(b/6))
		love.graphics.rectangle("fill", x, y, 32+width, 32+height)

		local function draw_edge(t, x, y)
			love.graphics.draw(tilesets["tiles.png"].white_img, tilesets["tiles.png"].tiles[t], x, y, 0, 2)
		end

		-- All the edge parts
		love.graphics.setColor(r, g, b)
		draw_edge(40, x, y) -- top left
		draw_edge(42, x+16+width, y) -- top right
		draw_edge(45, x, y+16+height) -- bottom left
		draw_edge(47, x+16+width, y+16+height) -- bottom right

		for i = 1, width/16 do
			draw_edge(41, x+i*16, y) -- top
			draw_edge(46, x+i*16, y+16+height) -- bottom
		end
		for i = 1, height/16 do
			draw_edge(43, x, y+i*16) -- left
			draw_edge(44, x+16+width, y+i*16) -- right
		end

		-- Fill the gaps, if not multiples of 8 (16)
		-- This extra tile is made to overlap with the other edge tiles.
		-- Visually, this goes as follows (where [/=] and [=\] are corner tiles):
		-- [/=][00][11][22][3[44][=\]
		if width%16 ~= 0 then
			draw_edge(41, x+width, y)
			draw_edge(46, x+width, y+16+height)
		end
		if height%16 ~= 0 then
			draw_edge(43, x, y+height)
			draw_edge(44, x+16+width, y+height)
		end
	else
		-- Transparent textboxes are slightly different
		v6_setroomprintcol()
	end

	-- Now put the text in
	for k,v in pairs(text) do
		font_level:print(v, x+16, y+k*16, "cjk_low", 2)
	end

	love.graphics.setColor(255,255,255)
end
