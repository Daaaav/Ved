function convertfontpng(imagedata, glyphs_string)
	-- Make an image for the imagefont. Apparently VVVVVV sees chars < 0x20 as 6 pixels wide.
	-- But apparently that only applies to the kerning, the character itself is still 8 pixels.

	if glyphs_string == nil then
		local glyphs_table = {}
		for g = 0x00, 0x7f do
			table.insert(glyphs_table, string.char(g))
		end

		glyphs_string = table.concat(glyphs_table, "")
	end

	-- We need to know how long the ImageFont should be... For now just use theoretical maxima
	local imagedata_w, imagedata_h = imagedata:getDimensions()
	local max_chars = math.floor((imagedata_w*imagedata_h)/64)
	imagefont = love.image.newImageData(max_chars*11 + 1, 8)

	local full
	if love_version_meets(11) then
		full = 1
	else
		full = 255
	end

	-- Make a mapping from each (pixel) column to the corresponding character
	local column_map = imagefont_make_column_map(glyphs_string)

	imagefont:mapPixel(
		function(x, y) -- r, g, b, a
			local typ, charnum, xcoord
			if column_map[x] ~= nil then
				typ, charnum, xcoord = unpack(column_map[x])
			end

			if typ == 1 or typ == nil then
				return 0, 0, 0, 0
			elseif typ == 2 then
				return full, full, 0, full
			else
				local fontpng_x = (charnum*8+xcoord)
				local fontpng_y = math.floor(fontpng_x/imagedata_w)*8 + y
				fontpng_x = fontpng_x % imagedata_w

				if fontpng_x >= imagedata_w or fontpng_y >= imagedata_h then
					return 0, 0, 0, 0
				end
				return full, full, full, ({imagedata:getPixel(fontpng_x, fontpng_y)})[4]
			end
		end
	)

	font8 = love.graphics.newImageFont(imagefont, glyphs_string, -2)

	local fallback_chars = love.filesystem.read("fonts/imagefont_fallback.txt")
	font8:setFallbacks(love.graphics.newImageFont("fonts/imagefont_fallback.png", fallback_chars))

	--imagefont:encode("png", "debug_imagefont.png")

	cons("Custom font.png loaded")
end

function imagefont_make_column_map(glyphs_string)
	-- Make a mapping that, given an x coordinate in the new image font strip, contains which character
	-- that column belongs to, along with the x coordinate in that character (0-7).
	-- returns table of x -> {type, charnum, xcoord}
	-- type: 0: char (part of character)
	--       1: transparent (not part of character, and also not part of separator)
	--       2: separator (part of separator)
	-- charnum: number of glyph that appears in the font (nil if type ~= 0)
	-- xcoord: 0-7 (nil if type ~= 0)

	local column_map = {}
	column_map[0] = {2} -- Row 0 is a separator
	local cur_x = 1
	local charnum = 0

	for byte, code in utf8.codes(glyphs_string) do
		if code < 32 then
			-- Characters 0x00 - 0x1f; these are 9 pixels wide including separator
			for xcoord = 0, 7 do
				column_map[cur_x] = {0, charnum, xcoord}
				cur_x = cur_x + 1
			end
			column_map[cur_x] = {2}
			cur_x = cur_x + 1
		else
			-- Characters 0x20 - ...; these are 11 pixels wide including separator (yes!)
			for xcoord = 0, 7 do
				column_map[cur_x] = {0, charnum, xcoord}
				cur_x = cur_x + 1
			end
			column_map[cur_x+0] = {1}
			column_map[cur_x+1] = {1}
			column_map[cur_x+2] = {2}
			cur_x = cur_x + 3
		end
		charnum = charnum + 1
	end

	return column_map
end
