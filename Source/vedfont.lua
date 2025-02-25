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

local bidi_layout_n = 2048
local bidi_layout

local bidi
function init_font_libraries()
	if not ffi_success then
		return
	end

	if love.system.getOS() == "Windows" then
		bidi = load_library(ffi, "vedlib_bidi_win00." .. ffi.arch .. ".dll")
	elseif love.system.getOS() == "Linux" then
		bidi = load_library(ffi, "vedlib_bidi_lin00.so")
	elseif love.system.getOS() == "OS X" then
		bidi = load_library(ffi, "vedlib_bidi_mac00.so")
	end

	ffi.cdef((love.filesystem.read("libs/vedlib_bidi.h")))

	if bidi ~= nil then
		bidi.bidi_init()
	end

	bidi_layout = ffi.new("VisualLayoutGlyph[?]", bidi_layout_n)
end

function cleanup_font_libraries()
	if bidi ~= nil then
		bidi.bidi_destroy()
	end
end

local print_buf_n = 8192
local print_buf = ffi.new("uint32_t[?]", print_buf_n)

cVedFont =
{
	--== PUBLIC OPTIONS ==--
	standard_height = nil, -- the height expected for non-CJK, as in 8 (optional)

	--== PRIVATE ==--
	font_type = "font",
	display_name = "undefined",
	glyph_w = nil,
	glyph_h = nil,
	fallback_glyph_w = nil,
	fallback_glyph_h = nil,

	context = nil, -- "ui", "level" or "8x8", only when using font_ui, font_level or font_8x8

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
	self.fallback_glyph_w, self.fallback_glyph_h = 8, 8

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
		local font_type = fontmeta:match("<type>(.-)</type>")
		if font_type ~= nil then
			self.font_type = font_type
		end
		local display_name = fontmeta:match("<display_name>(.-)</display_name>")
		if display_name ~= nil then
			self.display_name = display_name
		end
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
		local w = tonumber(fontmeta_fallback:match("<width>(.-)</width>"))
		local h = tonumber(fontmeta_fallback:match("<height>(.-)</height>"))
		if w ~= nil then
			self.fallback_glyph_w = w
		end
		if h ~= nil then
			self.fallback_glyph_h = h
		end

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
		local subfont_glyph_w, subfont_glyph_h
		if subfont == 0 then
			img_w, img_h = imgA_w, imgA_h
			subfont_txt = txt
			subfont_fontmeta = fontmeta
			subfont_glyph_w = self.glyph_w
			subfont_glyph_h = self.glyph_h
		else
			img_x, img_y = imgB_paste_x, imgB_paste_y
			img_w, img_h = imgB_w, imgB_h
			subfont_txt = txt_fallback
			subfont_fontmeta = fontmeta_fallback
			subfont_glyph_w = self.fallback_glyph_w
			subfont_glyph_h = self.fallback_glyph_h
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
		local n_cx, n_cy = math.floor(img_w/subfont_glyph_w), math.floor(img_h/subfont_glyph_h)

		for k,v in pairs(char_ranges) do
			for codepoint = v[1], v[2] do
				if cur_cy >= n_cy then
					-- No more glyphs
					break
				end

				if self.chars[codepoint] == nil then
					local char_px = img_x + cur_cx*subfont_glyph_w
					local char_py = img_y + cur_cy*subfont_glyph_h

					local blank = false
					if codepoint == 0x20 then
						-- It's pretty likely space is empty, _and_ it's used a lot.
						blank = true
						for y = 0, subfont_glyph_h-1 do
							for x = 0, subfont_glyph_w-1 do
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
							char_px, char_py, subfont_glyph_w, subfont_glyph_h, target_w, target_h
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
					if subfont == 0 and attr.advance ~= nil then
						self:set_glyph_advance(tonumber(attr.advance), tonumber(attr.start), tonumber(attr["end"]))
					end
					if attr.color ~= nil then
						self:set_glyph_color(attr.color == "1", tonumber(attr.start), tonumber(attr["end"]))
					end
				end
				special_loaded = true
			end
		end

		if not special_loaded and subfont_glyph_w == 8 and subfont_glyph_h == 8 then
			-- If we don't have <special>, and the font is 8x8,
			-- 0x00-0x1F will be less wide because that's how it has always been.
			self:set_glyph_advance(6, 0x00, 0x1F)
		end
	end

	for i = 1, self.limit_batches do
		table.insert(self.batches,
			{
				text = ffi.new("uint32_t[?]", self.limit_line_chars+1),
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

		if c == 0x0A then -- '\n'
			newline_continue = i+1
			c = 0
		end

		if not changed and batch.text[i] ~= c then
			changed = true
		end

		if changed then
			batch.text[i] = c
		end

		if c == 0 then
			break
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

		local used_buf
		local rtl = self:is_rtl()
		if bidi ~= nil and bidi.bidi_should_transform_utf32(rtl, batch.text) then
			used_buf = bidi.bidi_transform_utf32(rtl, batch.text, nil, 0)
			len = 0
			local c
			repeat
				c = used_buf[len]
				len = len + 1
			until c == 0 or c == 0x0A
			len = len - 1
		else
			used_buf = batch.text
		end

		-- Since the global color may need to be overridden per-character (colored glyphs),
		-- we set the global color to white and instead set the SpriteBatch color to the global color
		spritebatch_set_color(batch.spritebatch, global_r, global_g, global_b, global_a)

		local cur_x = 0

		for i = 0, len-1 do
			local c = used_buf[i]
			local advance = self.glyph_w

			local blank = false
			local glyph = self:get_glyph(c)
			if bidi ~= nil and (bidi.is_directional_character(c) or bidi.is_joiner(c)) then
				blank = true
				advance = 0
			elseif glyph == nil then
				blank = true
			else
				blank = glyph.blank
				advance = glyph.advance
			end

			if not blank then
				if glyph.color then
					spritebatch_set_color(batch.spritebatch, 255, 255, 255, global_a)
				end

				local offsetx, offsety = 0, 0
				if glyph.subfont ~= 0 then
					offsetx = offsetx + math.floor((self.glyph_w - self.fallback_glyph_w) / 2)
					offsety = offsety + math.floor((self.glyph_h - self.fallback_glyph_h) / 2)
				end

				if love_version_meets(9) then
					batch.spritebatch:add(glyph.quad, cur_x+offsetx, offsety)
				else
					batch.spritebatch:addq(glyph.quad, cur_x+offsetx, offsety)
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

	-- First, a special case:
	-- If, after bidi, the whole thing fits on one line, then don't wordwrap at all.
	-- This matters where Arabic ligatures are smaller than their regular forms,
	-- causing lines to be split when they visibly didn't need to be split.
	-- While it doesn't fix every case, it at least fixes all the prominent ones.
	-- (and 1 line becoming 2 is a problem in many more places than 2 lines becoming 3)
	local rtl = self:is_rtl()
	if bidi ~= nil and bidi.bidi_should_transform_utf32(rtl, print_buf) then
		-- If there are any newline characters, then forget about it *here*.
		-- The bidi functions don't expect text with newlines.
		local any_newlines = false
		local i = 0
		while i < print_buf_n-1 do
			if print_buf[i] == 0 then
				break
			elseif print_buf[i] == 0x0A then
				any_newlines = true
				break
			end

			i = i + 1
		end

		if not any_newlines then
			if max_width == nil then
				-- Then it's gonna fit on one line too, right?
				return 1
			end

			local buf = bidi.bidi_transform_utf32(rtl, print_buf, nil, 0)
			local line_width = 0
			i = 0

			-- While the line fits, go through every character
			while line_width <= max_width do
				if buf[i] == 0 then
					-- That's the end! So it fits! Skip the wordwrapping!
					return 1
				end
				line_width = line_width + self:get_glyph_advance(buf[i])

				i = i + 1
			end
		end

		-- If we're here, then it didn't fit or there were multiple lines...
	end

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

function cVedFont:shadowprint(text, x, y, cjk_align, sx, sy)
	if sx == nil then sx = 1 end
	if sy == nil then sy = sx end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0,0,0,255)
	self:print(text, x, y-sy, cjk_align, sx, sy)
	self:print(text, x-sx, y, cjk_align, sx, sy)
	self:print(text, x+sx, y, cjk_align, sx, sy)
	self:print(text, x, y+sy, cjk_align, sx, sy)
	love.graphics.setColor(r, g, b, a)
	self:print(text, x, y, cjk_align, sx, sy)
end

function cVedFont:shadowprintf(text, x, y, limit, align, cjk_align, sx, sy)
	if sx == nil then sx = 1 end
	if sy == nil then sy = sx end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0,0,0,255)
	self:printf(text, x, y-sy, limit, align, cjk_align, sx, sy)
	self:printf(text, x-sx, y, limit, align, cjk_align, sx, sy)
	self:printf(text, x+sx, y, limit, align, cjk_align, sx, sy)
	self:printf(text, x, y+sy, limit, align, cjk_align, sx, sy)
	love.graphics.setColor(r, g, b, a)
	self:printf(text, x, y, limit, align, cjk_align, sx, sy)
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

	local print_buf_i = 0
	local line_is_bidi = nil -- nil: not yet determined for this line, otherwise true/false
	local used_buf, used_i
	while true do
		if line_is_bidi == nil then
			-- Bidiness is determined on a per-line basis... So...  ._.  some lines
			-- will be from the original buffer, some will be from the bidi system's
			-- buffer... with its own i that keeps starting from 0......

			local rtl = self:is_rtl()
			line_is_bidi = bidi ~= nil and bidi.bidi_should_transform_utf32(rtl, print_buf)

			if line_is_bidi then
				used_buf = bidi.bidi_transform_utf32(rtl, print_buf, nil, 0)
				used_i = 0

				-- The print_buf_i needs to catch up too... Meet us at the next '\n' or '\0'
				while print_buf[print_buf_i] ~= 0x0A and print_buf[print_buf_i] ~= 0 do
					print_buf_i = print_buf_i + 1
				end
			else
				used_buf = print_buf
				used_i = print_buf_i
			end
		end

		if used_buf[used_i] == 0x0A or used_buf[used_i] == 0 then -- '\n' or '\0'
			if line_width > total_width then
				total_width = line_width
			end
			line_width = 0

			-- Not a mistake - the bidi system changes a newline to a null terminator
			if used_buf[print_buf_i] == 0 then
				break
			end

			-- Next line
			line_is_bidi = nil
		elseif bidi ~= nil and (
			bidi.is_directional_character(used_buf[used_i]) or
			bidi.is_joiner(used_buf[used_i])
		) then
			-- pass
		else
			line_width = line_width + self:get_glyph_advance(used_buf[used_i])
		end
		used_i = used_i + 1
		if not line_is_bidi then -- intent: EITHER false OR nil
			print_buf_i = print_buf_i + 1
		end
	end

	return total_width, lines
end

function cVedFont:getWidth(text)
	return (self:getWrap(text, nil))
end

function cVedFont:getHeight()
	return self.glyph_h
end

function cVedFont:get_bidi_layout(text)
	local codepoints = utf8_to_utf32(text, print_buf, print_buf_n)
	codepoints = math.min(codepoints, bidi_layout_n-1)

	local rtl = self:is_rtl()
	if bidi == nil or not bidi.bidi_should_transform_utf32(rtl, print_buf) then
		for i = 0, codepoints-1 do
			bidi_layout[i].out_codepoint = print_buf[i]
			bidi_layout[i].orig_char_index = i
			bidi_layout[i].glyph_width = self:get_glyph_advance(print_buf[i])
			bidi_layout[i].tombstone = false
			bidi_layout[i].in_rtl_run = false
		end
		bidi_layout[codepoints].out_codepoint = 0
		return bidi_layout, codepoints-1
	end

	bidi.bidi_transform_utf32(rtl, print_buf, bidi_layout, bidi_layout_n)

	-- Now we just need to go through all layout slots, and get the width of all glyphs!
	-- And we do that from right to left, because RTL runs can have tombstones
	-- to the left of a ligature glyph, which needs to share half the width...
	local last
	for i = 0, bidi_layout_n-1 do
		if bidi_layout[i].out_codepoint == 0 then
			last = i - 1
			break
		end
	end
	for i = last, 0, -1 do
		if bidi_layout[i].tombstone then
			-- This is the second character of a ligature
			local combined_width = bidi_layout[i+1].glyph_width
			local one_half_width = math.floor(combined_width/2)
			bidi_layout[i+1].glyph_width = one_half_width
			bidi_layout[i].glyph_width = combined_width-one_half_width
		elseif bidi ~= nil and (
			bidi.is_directional_character(bidi_layout[i].out_codepoint) or
			bidi.is_joiner(bidi_layout[i].out_codepoint)
		) then
			bidi_layout[i].glyph_width = 0
		else
			bidi_layout[i].glyph_width = self:get_glyph_advance(bidi_layout[i].out_codepoint)
		end
	end

	return bidi_layout, last
end

function cVedFont:is_rtl()
	-- This function may never return nil! (cannot convert it to C bool)
	if self.context == "ui" then
		if langinfo ~= nil
		and langinfo[s.lang] ~= nil
		and langinfo[s.lang].rtl then
			return true
		end
		return false
	elseif self.context == "level" then
		if metadata ~= nil and metadata.rtl then
			return true
		end
		return false
	end
	return false
end

function cVedFont:align_start()
	if self:is_rtl() then
		return "right"
	end
	return "left"
end

function utf8_to_utf32(str, buf, buf_n)
	-- Decodes an UTF-8 Lua string into a UTF-32 (uint32_t) buffer.
	-- Will null-terminate the buffer.
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
