local ffi_success, ffi = pcall(require, "ffi")
if not ffi_success then
	-- Just so we can still render text on the "your LÖVE is old" screen. It's fast enough anyway
	ffi = {}

	function ffi.new(ct, nelem)
		local arr = {}
		for i = 0, nelem-1 do
			arr[i] = 0
		end
		return arr
	end

	function ffi.cast(ct, init)
		local arr = {}
		local i = 0
		for c in tostring(init):gmatch(".") do
			arr[i] = string.byte(c)
			i = i + 1
		end
		arr[i] = 0
		return arr
	end
end

local print_buf_n = 8192
local print_buf = ffi.new("uint32_t[?]", print_buf_n)

cVedFont =
{
	--== PUBLIC OPTIONS ==--
	standard_height = nil, -- the height expected for non-CJK, as in 8 (optional)

	--== PRIVATE ==--
	glyph_w = nil,
	glyph_h = nil,

	image = nil,
	chars = {},
	batches = {},

	current_batch = 0,

	limit_batches = 512,
	limit_line_chars = 256,
}

function cVedFont:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	o.chars = {}
	o.batches = {}

	return o
end

function cVedFont:init(imgdata, txt, fontmeta, imgdata_fallback, txt_fallback, fontmeta_fallback)
	-- Initialize the font with all necessary configuration.
	-- imgdata is an ImageData with the font image, loaded from a .png.
	-- txt is a string with the characters, loaded from a .txt (may be nil if missing)
	-- fontmeta is a string with the XML loaded from a .fontmeta (may be nil if missing)
	-- imgdata_fallback, txt_fallback and fontmeta_fallback are optional
	-- and represent a fallback font. (The fallback font must have the same glyph width and height)

	self.glyph_w, self.glyph_h = 8, 8

	-- It's also possible to pass only the _fallbacks, in which case that'll be promoted to main font.
	if imgdata == nil then
		imgdata = imgdata_fallback
		txt = txt_fallback
		fontmeta = fontmeta_fallback
		imgdata_fallback = nil
		txt_fallback = nil
		fontmeta_fallback = nil
	end

	local white_teeth = false
	local white_teeth_fallback = false

	if fontmeta ~= nil then
		local w = tonumber(fontmeta:match("<width>(.-)</width>"))
		local h = tonumber(fontmeta:match("<height>(.-)</height>"))
		if w ~= nil then
			self.glyph_w = w
		end
		if h ~= nil then
			self.glyph_h = h
		end
		white_teeth = fontmeta:match("<white_teeth>(.-)</white_teeth>") == "1"
	end
	if fontmeta_fallback ~= nil then
		white_teeth_fallback = fontmeta_fallback:match("<white_teeth>(.-)</white_teeth>") == "1"
	end

	local imgA_w, imgA_h = imgdata:getWidth(), imgdata:getHeight()
	local imgB_w, imgB_h
	local imgB_paste_x, imgB_paste_y = 0, 0
	local target
	local target_w, target_h = imgA_w, imgA_h
	local need_paste = false

	local function toothbrush(imgd)
		local rgb_full
		if love_version_meets(11) then
			rgb_full = 1
		else
			rgb_full = 255
		end

		imgd:mapPixel(
			function(x, y, r, g, b, a)
				return rgb_full, rgb_full, rgb_full, a
			end
		)
	end

	if not white_teeth then
		toothbrush(imgdata)
	end

	if imgdata_fallback ~= nil then
		if not white_teeth_fallback then
			toothbrush(imgdata_fallback)
		end

		imgB_w, imgB_h = imgdata_fallback:getWidth(), imgdata_fallback:getHeight()

		-- We'll place both fonts in the same image; decide what fits best
		target_w, target_h = math.max(imgA_w, imgB_w), math.max(imgA_h, imgB_h)
		if (imgA_w + imgB_w) * target_h < target_w * (imgA_h + imgB_h) then
			-- Side-by-side
			target_w = imgA_w + imgB_w
			imgB_paste_x = imgA_w
		else
			-- On top of each other
			target_h = imgA_h + imgB_h
			imgB_paste_y = imgA_h
		end

		need_paste = true
	end

	if not love_version_meets(8) or not love.graphics.isSupported("npot") then
		target_w = math.pow(2, math.ceil(math.log(target_w)/math.log(2)))
		target_h = math.pow(2, math.ceil(math.log(target_h)/math.log(2)))
		need_paste = true
	end

	if need_paste then
		target = love.image.newImageData(target_w, target_h)
		target:paste(imgdata, 0, 0)
		if imgdata_fallback ~= nil then
			target:paste(imgdata_fallback, imgB_paste_x, imgB_paste_y)
		end
	else
		target = imgdata
	end

	self.image = love.graphics.newImage(target)
	pcall(self.image.setFilter, self.image, "linear", "nearest")

	local codepoints_n = 0
	if txt ~= nil then
		codepoints_n = txt:len() + 1
	end
	if txt_fallback ~= nil then
		codepoints_n = math.max(codepoints_n, txt_fallback:len() + 1)
	end
	local codepoints
	if codepoints_n > 0 then
		codepoints = ffi.new("uint32_t[?]", codepoints_n)
	end

	for subfont = 0, 1 do
		if subfont == 1 and imgdata_fallback == nil then
			break
		end

		-- img_x and img_y are the position of this subfont in the combined image.
		local img_x, img_y = 0, 0
		local img_w, img_h

		local subfont_txt, subfont_fontmeta
		if subfont == 0 then
			img_w, img_h = imgA_w, imgA_h
			subfont_txt = txt
			subfont_fontmeta = fontmeta
		else
			img_x, img_y = imgB_paste_x, imgB_paste_y
			img_w, img_h = imgB_w, imgB_h
			subfont_txt = txt_fallback
			subfont_fontmeta = fontmeta_fallback
		end

		local charset_loaded = false
		local char_ranges = {}
		if subfont_txt ~= nil then
			-- If font.txt exists, it takes priority over <chars>.
			local codepoints_found = utf8_to_utf32(subfont_txt, codepoints, codepoints_n)

			-- It's the old system anyway...
			for i = 0, codepoints_found-1 do
				table.insert(char_ranges, {tonumber(codepoints[i]), tonumber(codepoints[i])})
			end
			charset_loaded = true
		end

		if subfont_fontmeta ~= nil and not charset_loaded then
			local xchars = subfont_fontmeta:match("<chars>(.*)</chars>")
			if xchars ~= nil then
				for range in xchars:gmatch("<range (.-)/>") do
					local attr = parsexmlattributes(range)
					table.insert(char_ranges, {tonumber(attr.start), tonumber(attr["end"])})
				end
				charset_loaded = true
			end
		end

		if not charset_loaded then
			-- If we don't have font.txt and no <chars>, this is 2.2-style plain ASCII
			table.insert(char_ranges, {0x00, 0x7F})
		end

		-- cur_cx and cur_cy are the character (not pixel) coordinate in the current subfont.
		local cur_cx, cur_cy = 0, 0

		-- n_cx and n_cy are the total number of characters that can fit in this subfont.
		-- if cur_cx >= n_cx we go to the next line, if cur_cy >= n_cy then we're out of glyphs
		local n_cx, n_cy = math.floor(img_w/self.glyph_w), math.floor(img_h/self.glyph_h)

		for k,v in pairs(char_ranges) do
			for codepoint = v[1], v[2] do
				if cur_cy >= n_cy then
					-- No more glyphs
					break
				end

				if self.chars[codepoint] == nil then
					local char_px = img_x + cur_cx*self.glyph_w
					local char_py = img_y + cur_cy*self.glyph_h

					local blank = false
					if codepoint == 0x20 then
						-- It's pretty likely space is empty, _and_ it's used a lot.
						blank = true
						for y = 0, self.glyph_h-1 do
							for x = 0, self.glyph_w-1 do
								local r,g,b,a = target:getPixel(char_px+x, char_py+y)
								if a > 0 then
									blank = false
									break
								end
							end
							if blank then
								break
							end
						end
					end

					self.chars[codepoint] = {
						advance = self.glyph_w,
						color = false,
						subfont = subfont
					}

					if blank then
						self.chars[codepoint].blank = true
					else
						self.chars[codepoint].quad = love.graphics.newQuad(
							char_px, char_py, self.glyph_w, self.glyph_h, target_w, target_h
						)
					end
				end

				cur_cx = cur_cx + 1
				if cur_cx >= n_cx then
					cur_cx = 0
					cur_cy = cur_cy + 1
				end
			end
		end

		local special_loaded = false
		if subfont_fontmeta ~= nil then
			local xspecial = subfont_fontmeta:match("<special>(.*)</special>")
			if xspecial ~= nil then
				for range in xspecial:gmatch("<range (.-)/>") do
					local attr = parsexmlattributes(range)
					if attr.advance ~= nil then
						self:set_glyph_advance(tonumber(attr.advance), tonumber(attr.start), tonumber(attr["end"]))
					end
					if attr.color ~= nil then
						self:set_glyph_color(attr.color == "1", tonumber(attr.start), tonumber(attr["end"]))
					end
				end
				special_loaded = true
			end
		end

		if not special_loaded and self.glyph_w == 8 and self.glyph_h == 8 then
			-- If we don't have <special>, and the font is 8x8,
			-- 0x00-0x1F will be less wide because that's how it has always been.
			self:set_glyph_advance(6, 0x00, 0x1F)
		end
	end

	for i = 1, self.limit_batches do
		table.insert(self.batches,
			{
				text = ffi.new("uint32_t[?]", self.limit_line_chars),
				text_len = 0,
				width = 0,
				spritebatch = love.graphics.newSpriteBatch(self.image, self.limit_line_chars),
				r = 0, g = 0, b = 0, a = 0
			}
		)
	end
end

function cVedFont:frame_start()
	-- Make sure to call this at the start of love.draw();
	-- at least if there will be prints this frame.
	self.current_batch = 0
end

function cVedFont:has_glyphs(str, require_main)
	-- Returns true if the font can render all UTF-8 characters in the string.
	-- If require_main is true, characters may not be from the fallback font either.
	local codepoints = utf8_to_utf32(str, print_buf, print_buf_n)
	local i = 0
	while i < print_buf_n and i < codepoints do
		if self.chars[print_buf[0]] == nil then
			return false
		end
		if require_main and self.chars[print_buf[0]].subfont > 0 then
			return false
		end

		i = i + 1
	end
	return true
end

function cVedFont:get_glyph(c)
	local glyph = self.chars[c]
	if glyph == nil then
		glyph = self.chars[0xFFFD] -- <?>
	end
	if glyph == nil then
		glyph = self.chars[0x3F] -- '?'
	end
	return glyph
end

function cVedFont:get_glyph_advance(c)
	local glyph = self:get_glyph(c)
	if glyph == nil then
		return self.glyph_w
	end
	return glyph.advance
end

function cVedFont:set_glyph_advance(a, c, c_end)
	-- Set the width of the glyph for codepoint c to a, if the glyph exists.
	-- If c_end is specified, this is applied to the range c - c_end
	if c_end == nil then
		c_end = c
	end

	for g = c, c_end do
		if self.chars[g] ~= nil then
			self.chars[g].advance = a
		end
	end
end

function cVedFont:set_glyph_color(value, c, c_end)
	-- Set the colored state of the glyph for codepoint c to value, if the glyph exists.
	-- If c_end is specified, this is applied to the range c - c_end
	if c_end == nil then
		c_end = c
	end

	for g = c, c_end do
		if self.chars[g] ~= nil then
			self.chars[g].color = value
		end
	end
end

function cVedFont:copy_glyph(c_target, c_source)
	-- Overwrite the glyph for c_target with the one for c_source.
	self.chars[c_target] = self.chars[c_source]
end

function cVedFont:y_align(y, cjk_align, sy)
	if self.standard_height ~= nil then
		local h_diff_standard = (self.glyph_h-self.standard_height)*sy
		if h_diff_standard < 0 then
			-- If the font is less high than standard,
			-- just center it (lower on screen)
			y = y - h_diff_standard/2
		elseif cjk_align == "cjk_high" then
			y = y - h_diff_standard
		elseif cjk_align ~= "cjk_low" then
			y = y - h_diff_standard/2
		end
	end

	return y
end

function cVedFont:buf_print(x, y, cjk_align, sx, sy, max_width, align, offset)
	-- Print a string of codepoints from print_buf
	-- sx and sy are scale factors (1 by default)
	-- max_width is ONLY for alignment with align (which are both optional)
	-- offset the starting position in print_buf (0 by default)
	if sx == nil then
		sx = 1
	end
	if sy == nil then
		sy = sx
	end
	if offset == nil then
		offset = 0
	end

	if self.current_batch < self.limit_batches then
		self.current_batch = self.current_batch + 1
	end

	local batch = self.batches[self.current_batch]

	-- If this batch is exactly the same as last frame, we can just directly use it!
	local changed = false

	local newline_continue = nil
	local i = 0
	while i < self.limit_line_chars and offset+i < print_buf_n do
		local c = print_buf[offset + i]
		if c == 0 then
			break
		end
		if c == 0x0A then -- '\n'
			newline_continue = i+1
			break
		end

		if not changed and batch.text[i] ~= c then
			changed = true
		end

		if changed then
			batch.text[i] = c
		end

		i = i + 1
	end
	local len = i

	if batch.text_len ~= len then
		-- The cached string only starts with the requested string
		changed = true
	end

	local global_r, global_g, global_b, global_a = love.graphics.getColor()

	if not changed and (
	batch.r ~= global_r or
	batch.g ~= global_g or
	batch.b ~= global_b or
	batch.a ~= global_a) then
		changed = true
	end

	if len > 0 and changed then
		batch.text_len = len
		batch.r = global_r
		batch.g = global_g
		batch.b = global_b
		batch.a = global_a
		batch.spritebatch:clear()

		-- Since the global color may need to be overridden per-character (colored glyphs),
		-- we set the global color to white and instead set the SpriteBatch color to the global color
		spritebatch_set_color(batch.spritebatch, global_r, global_g, global_b, global_a)

		local cur_x = 0

		for i = 0, len-1 do
			local c = batch.text[i]
			local advance = self.glyph_w

			local blank = false
			local glyph = self:get_glyph(c)
			if glyph == nil then
				blank = true
			else
				blank = glyph.blank
				advance = glyph.advance
			end

			if not blank then
				if glyph.color then
					spritebatch_set_color(batch.spritebatch, 255, 255, 255, global_a)
				end

				if love_version_meets(9) then
					batch.spritebatch:add(glyph.quad, cur_x, 0)
				else
					batch.spritebatch:addq(glyph.quad, cur_x, 0)
				end

				if glyph.color then
					spritebatch_set_color(batch.spritebatch, global_r, global_g, global_b, global_a)
				end
			end

			cur_x = cur_x + advance
		end

		batch.width = cur_x
	end

	if len > 0 then
		local px, py = x, y
		if max_width ~= nil then
			if align == "center" then
				px = px + (max_width - batch.width*sx)/2
			elseif align == "right" then
				px = px + (max_width - batch.width*sx)
			end
		end
		py = self:y_align(py, cjk_align, sy)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(batch.spritebatch, math.floor(px), math.floor(py), nil, sx, sy)
		love.graphics.setColor(global_r, global_g, global_b, global_a)
	end

	if newline_continue ~= nil then
		self:buf_print(
			x,
			y + self.glyph_h*sy,
			cjk_align,
			sx,
			sy,
			max_width,
			align,
			offset + newline_continue
		)
	end
end

function cVedFont:buf_wordwrap(max_width)
	-- Wordwraps print_buf in-place for this font by adding newlines.
	-- Returns the total number of lines.
	-- max_width can be nil to indicate no limit (and is thus only useful for
	-- getting the number of lines that are already in the text)
	local lines = 1

	local last_split, last_space = -1, -1
	local line_width = 0
	local word_width = 0 -- width since last space/split

	local i = 0
	while i < print_buf_n-1 do
		if print_buf[i] == 0 then
			break
		end
		local char_w = self:get_glyph_advance(print_buf[i])
		line_width = line_width + char_w
		word_width = word_width + char_w

		if print_buf[i] == 0x20 then -- ' '
			last_space = i
			word_width = 0
		end
		if print_buf[i] == 0x0A then -- '\n'
			last_split = i
			last_space = i
			line_width = 0
			word_width = 0
			lines = lines + 1
		end

		if max_width ~= nil and line_width > max_width and last_split ~= last_space then
			print_buf[last_space] = 0x0A
			last_split = last_space
			line_width = word_width
			lines = lines + 1
		end

		i = i + 1
	end

	return lines
end

function cVedFont:print(text, x, y, cjk_align, sx, sy)
	if text == nil then
		text = "nil"
	end
	utf8_to_utf32(text, print_buf, print_buf_n)
	self:buf_print(x, y, cjk_align, sx, sy)
end

function cVedFont:printf(text, x, y, max_width, align, cjk_align, sx, sy)
	if text == nil then
		text = "nil"
	end
	if sx == nil then
		sx = 1
	end
	utf8_to_utf32(text, print_buf, print_buf_n)
	self:buf_wordwrap(max_width/sx)
	self:buf_print(x, y, cjk_align, sx, sy, max_width, align)
end

function cVedFont:getWrap(text, max_width)
	-- LÖVE 0.9-style Font:getWrap (returns width and number of lines)
	-- Gives the number of lines (not the table of lines) because we never need the table.
	-- max_width can also be nil, to indicate no limit.

	if text == nil then
		text = "nil"
	end
	if text == "" then
		-- Only LÖVE 11.4 and up returns 1 line, and I needed 0...
		return 0, 0
	end

	utf8_to_utf32(text, print_buf, print_buf_n)
	local lines = self:buf_wordwrap(max_width)
	local total_width = 0
	local line_width = 0

	local i = 0
	while i < print_buf_n-1 do
		if print_buf[i] == 0x0A or print_buf[i] == 0 then -- '\n' or '\0'
			if line_width > total_width then
				total_width = line_width
			end
			line_width = 0

			if print_buf[i] == 0 then
				break
			end
		else
			line_width = line_width + self:get_glyph_advance(print_buf[i])
		end
		i = i + 1
	end

	return total_width, lines
end

function cVedFont:getWidth(text)
	return (self:getWrap(text, nil))
end

function cVedFont:getHeight()
	return self.glyph_h
end

function utf8_to_utf32(str, buf, buf_n)
	-- Decodes an UTF-8 Lua string into a UTF-32 (uint32_t) buffer.
	-- Will null-terminate the bufer.
	-- Returns the number of codepoints written (excluding null)
	if str == nil or buf == nil then
		error("attempt to decode UTF-8 with a nil value")
	end
	str = tostring(str)
	local len_remaining = str:len()
	local cstr = ffi.cast("const unsigned char*", str)
	local str_i, buf_i = 0, 0
	local code = 0
	local code_nbytes = 0
	while buf_i < buf_n-1 and len_remaining > 0 do
		code_nbytes = 1
		if cstr[str_i] < 0x80 then
			-- 0xxx xxxx - ASCII
			code = cstr[str_i]
		elseif cstr[str_i] < 0xC0 then
			-- 10xx xxxx - unexpected continuation byte
			code = 0xFFFD
		elseif cstr[str_i] < 0xE0 then
			-- 110x xxxx - 2-byte sequence
			if len_remaining < 2
			or cstr[str_i+1] < 0x80 or cstr[str_i+1] >= 0xC0 then
				code = 0xFFFD
			else
				code = (cstr[str_i]-0xC0)*64
					+(cstr[str_i+1]-0x80)
				code_nbytes = 2
			end
		elseif cstr[str_i] < 0xF0 then
			-- 1110 xxxx - 3-byte sequence
			if len_remaining < 3
			or cstr[str_i+1] < 0x80 or cstr[str_i+1] >= 0xC0
			or cstr[str_i+2] < 0x80 or cstr[str_i+2] >= 0xC0 then
				code = 0xFFFD
			else
				code = (cstr[str_i]-0xE0)*64*64
					+(cstr[str_i+1]-0x80)*64
					+(cstr[str_i+2]-0x80)
				code_nbytes = 3
			end
		elseif cstr[str_i] < 0xF8 then
			-- 1111 0xxx - 4-byte sequence
			if len_remaining < 4
			or cstr[str_i+1] < 0x80 or cstr[str_i+1] >= 0xC0
			or cstr[str_i+2] < 0x80 or cstr[str_i+2] >= 0xC0
			or cstr[str_i+3] < 0x80 or cstr[str_i+3] >= 0xC0 then
				code = 0xFFFD
			else
				code = (cstr[str_i]-0xF0)*64*64*64
					+(cstr[str_i+1]-0x80)*64*64
					+(cstr[str_i+2]-0x80)*64
					+(cstr[str_i+3]-0x80)
				code_nbytes = 4
			end
		else
			-- 1111 1xxx - invalid
			code = 0xFFFD
		end

		-- Overlong sequence?
		if (code <= 0x7F and code_nbytes > 1)
		or (code > 0x7F and code <= 0x7FF and code_nbytes > 2)
		or (code > 0x7FF and code <= 0xFFFF and code_nbytes > 3) then
			code = 0xFFFD
		end

		-- UTF-16 surrogates are invalid, so are codepoints after 10FFFF
		if code >= 0xD800 and code <= 0xDFFF then
			code = 0xFFFD
		end
		if code > 0x10FFFF then
			code = 0xFFFD
		end

		buf[buf_i] = code

		len_remaining = len_remaining - code_nbytes
		str_i = str_i + code_nbytes
		buf_i = buf_i + 1
	end
	buf[buf_i] = 0

	return buf_i
end
