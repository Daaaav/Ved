-- fonteditor/draw

local ffi = require("ffi")

function display_char_block(x, y, codepoint)
	local charbox_w, charbox_h = fonteditor_glyph_w*4, fonteditor_glyph_h*4
	local char = fonteditor_chars[codepoint]

	if char == nil then
		-- Print the reference font character as a fallback
		love.graphics.setColor(40,40,40)
		if codepoint < 0xD800 or codepoint > 0xDFFF then
			local utf8_char = utf8.char(codepoint)
			local ref_size = math.min(fonteditor_glyph_w, fonteditor_glyph_h)*4
			if s.fonteditor_reffont_format == 0 then
				if font8:has_glyphs(utf8_char) then
					local ref_scale = ref_size/font8:getHeight()
					ved_print(utf8_char, x, y, ref_scale)
				end
			else
				local love_font = love.graphics.getFont()
				if love_font:hasGlyphs(utf8_char) then
					local ref_scale = ref_size/love_font:getHeight()
					love.graphics.printf(utf8_char, x, y, charbox_w/ref_scale, "center", 0, ref_scale)
				end
			end
		end
		love.graphics.setColor(255,255,255)
	else
		-- Print the character itself!
		-- Unfortunately, having 30000 Image objects makes GC take 15 seconds,
		-- and directly showing pixels becomes much simpler than some kind of shared buffer...
		local rgba
		if love_version_meets(11,3) then
			rgba = char.imagedata:getFFIPointer()
		else
			rgba = char.imagedata:getPointer()
		end
		rgba = ffi.cast("uint8_t*", rgba)
		for py = 0, fonteditor_glyph_h-1 do
			for px = 0, fonteditor_glyph_w-1 do
				local p = (py*fonteditor_glyph_w + px)*4
				if rgba[p+3] ~= 0 then
					love.graphics.setColor(rgba[p], rgba[p+1], rgba[p+2], rgba[p+3])
					love.graphics.rectangle("fill", x+px*4, y+py*4, 4, 4)
				end
			end
		end
	end

	love.graphics.setColor(64,64,64)
	love.graphics.rectangle("line", x+.5, y+.5, charbox_w-1, charbox_h-1)

	love.graphics.setColor(128,128,128)
	tinyfont:printf(string.format("%04X", codepoint), x, y+charbox_h+1, charbox_w, "center")
	love.graphics.setColor(255,255,255,255)
end

return function()
	love.graphics.setColor(255,255,255,255)
	if fonteditor_filename ~= "" then
		ved_print(L.FONTEDITOR .. " - " .. fonteditor_filename, 8, 8)
	else
		ved_print(L.FONTEDITOR, 8, 8)
	end

	if fonteditor_is_loaded() then
		local viewport_w = love.graphics.getWidth()-136-16
		local viewport_h = love.graphics.getHeight()-32

		love.graphics.setScissor(8, 24, viewport_w, viewport_h)

		local box_x, box_y = 0, 0
		local box_w, box_h = fonteditor_glyph_w*4 + 4, fonteditor_glyph_h*4 + 10

		fonteditor_get_page()
		for k,codepoint in ipairs(fonteditor_page_cache_chars) do
			if box_x+box_w > viewport_w then
				box_x = 0
				box_y = box_y + box_h
			end
			local screen_box_y = 24+box_y+fonteditor_scroll
			if screen_box_y+box_h >= 0 and screen_box_y <= love.graphics.getHeight() then
				display_char_block(8+box_x, screen_box_y, codepoint)
			end
			box_x = box_x + box_w
		end
		love.graphics.setScissor()

		-- Scrollbar
		fonteditor_maxscroll = (box_y+box_h)-viewport_h
		local newfraction = scrollbar(8+viewport_w, 24, viewport_h, box_y+box_h, (-fonteditor_scroll)/fonteditor_maxscroll)

		if newfraction ~= nil then
			fonteditor_scroll = -(newfraction*fonteditor_maxscroll)
		end

		if fonteditor_filter == "unicode" then
			custom_int_control(love.graphics.getWidth()-128-24-144, 4,
				function() fonteditor_page = math.max(0x000000, fonteditor_page - 0x1000) end,
				function() fonteditor_page = math.min(0x10F000, fonteditor_page + 0x1000) end,
				nil,
				function() return string.format("%04X-%04X", fonteditor_page, fonteditor_page+0xFFF) end,
				13*8
			)
		end
	else
		local infostring = langkeys(L.CLICKONTHING2, {L.LOAD, L.NEW})
		if love_version_meets(10) then
			infostring = infostring .. "\n" .. langkeys(L.ORDRAGDROPEXT, {".png"})
		end

		local _, lines = font8:getWrap(infostring, love.graphics.getWidth()-136)

		local centery = (love.graphics.getHeight() - 8*lines) / 2

		ved_printf(infostring, 0, centery, love.graphics.getWidth()-136, "center")
	end
end
