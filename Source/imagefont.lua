function convertfontpng(imagedata)
	-- Make an image for the imagefont. Apparently VVVVVV sees chars < 0x20 as 6 pixels wide.
	-- But apparently that only applies to the kerning, the character itself is still 8 pixels.
	-- Don't do 0x00.
	imagefont = love.image.newImageData(0x1f*8 + 0x60*10 + 0x80, 8)

	local colfactor
	if love_version_meets(11) then
		colfactor = 1
	else
		colfactor = 255
	end

	imagefont:mapPixel(
		function(x, y) -- r, g, b, a
			local typ, charnum, xcoord = imagefont_xtochar(x)

			if typ == 1 then
				return 0, 0, 0, 0
			elseif typ == 2 then
				return colfactor, colfactor, 0, colfactor
			else
				return colfactor, colfactor, colfactor, ({imagedata:getPixel(
					(charnum*8+xcoord) % 128,
					math.floor(charnum/16)*8 + y
				)})[4]
			end
		end
	)

	local glyphs = {}
	for g = 1, 0x7f do
		table.insert(glyphs, string.char(g))
	end
	--[[
	for g = 1, string.byte("?") do
		if g == string.byte("?") then -- f0 90 80 80
			table.insert(glyphs, string.char(0xef))
			table.insert(glyphs, string.char(0xbf))
			table.insert(glyphs, string.char(0xbd))
		else
			table.insert(glyphs, " ")
		end
		--table.insert(glyphs, string.char(g))
	end
	]]

	local glyphstring = table.concat(glyphs, "")

	font8 = love.graphics.newImageFont(imagefont, glyphstring, -2)

	-- Also create font16 from the same image.
	local font16canvas = love.graphics.newCanvas(imagefont:getWidth()*2, imagefont:getHeight()*2)
	love.graphics.setCanvas(font16canvas)
	love.graphics.clear()
	love.graphics.draw(love.graphics.newImage(imagefont), 0, 0, 0, 2)
	love.graphics.setCanvas()
	font16 = love.graphics.newImageFont(font16canvas:newImageData(), glyphstring, -4)

	--font8:setFallbacks(love.graphics.newFont("Space Station.ttf", 8))

	love.graphics.setFont(font8)

	--imagefont:encode("png", "debug_imagefont.png")

	cons("Custom font.png loaded")
end

function imagefont_xtochar(x)
	-- Given an x coordinate in the new image font strip, returns which character that column belongs to,
	-- along with the x coordinate in that character (0-7).
	-- returns type, charnum, xcoord
	-- type: 0: char (part of character)
	--       1: transparent (not part of character, and also not part of separator)
	--       2: separator (part of separator)
	-- charnum: 0x01 - 0x7f (nil if type ~= 0)
	-- xcoord: 0-7 (nil if type ~= 0)

	if x == 0 then
		-- Row 0 is a separator
		return 2
	elseif x <= 0x1f*9 then
		-- Characters 0x01 - 0x1f; these are 9 pixels wide including separator
		local x_start = x-1
		local col = x_start % 9

		if col <= 7 then
			return 0, math.floor(x_start/9)+1, col
		end
		return 2
	else
		-- Characters 0x20 - 0x7f; these are 11 pixels wide including separator (yes!)
		local x_start = (x-1)-0x1f*9
		local col = x_start % 11

		if col <= 7 then
			return 0, math.floor(x_start/11)+0x20, col
		elseif col <= 9 then
			return 1
		end
		return 2
	end
end
