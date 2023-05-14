function fonteditor_init()
	fonteditor_filepath = ""
	fonteditor_filename = ""
	fonteditor_chars = nil
	fonteditor_glyph_w = 8
	fonteditor_glyph_h = 8
	fonteditor_scroll = 0
	fonteditor_maxscroll = 0
	fonteditor_page = 0
	fonteditor_filter = "unicode"

	-- The page cache is a sequential list of all codepoints on this page,
	-- so we don't have to calculate that every frame.
	-- This table is ipairs-able, nil means purged cache
	fonteditor_page_cache_chars = nil
	fonteditor_page_cache_page = 0
	fonteditor_page_cache_filter = "unicode"
end

function fonteditor_new_font(glyph_w, glyph_h)
	fonteditor_init()
	fonteditor_chars = {}
	fonteditor_glyph_w = glyph_w
	fonteditor_glyph_h = glyph_h
end

function fonteditor_load_font(filepath_png, filename_png)
	-- We should've selected a png file
	local success, contents = readfile(filepath_png)
	if not success then
		dialog.create(contents)
		return false
	end

	local success, file_data = pcall(love.filesystem.newFileData, contents, filename_png, "file")
	if not success then
		dialog.create(file_data .. "\n\n" .. L.LOADFONTERRORHINT)
		return false
	end
	local success, img_data = pcall(love.image.newImageData, file_data)
	if not success then
		dialog.create(img_data .. "\n\n" .. L.LOADFONTERRORHINT)
		return false
	end

	-- No going back now
	fonteditor_init()
	fonteditor_chars = {}

	local success, txt_data = readfile(filepath_png:sub(1,-4) .. "txt")
	if not success then
		txt_data = nil
	end

	local success, xml_data = readfile(filepath_png:sub(1,-4) .. "fontmeta")
	if not success then
		xml_data = nil
	end

	local vedfont = cVedFont:new()
	vedfont:init(img_data, txt_data, xml_data)

	fonteditor_glyph_w = vedfont.glyph_w
	fonteditor_glyph_h = vedfont.glyph_h

	for codepoint = 0, 0x10FFFF do
		local vedfont_glyph = vedfont.chars[codepoint]
		if vedfont_glyph ~= nil then
			fonteditor_chars[codepoint] = {
				imagedata = love.image.newImageData(fonteditor_glyph_w, fonteditor_glyph_h)
			}

			if not vedfont_glyph.blank then
				-- Quad:getViewport conveniently returns x,y,w,h
				fonteditor_chars[codepoint].imagedata:paste(
					img_data,
					0, 0,
					vedfont_glyph.quad:getViewport()
				)
			end
		end
	end

	fonteditor_filepath = filepath_png
	fonteditor_filename = filename_png

	return true
end

function fonteditor_is_loaded()
	return fonteditor_chars ~= nil
end

function fonteditor_get_page()
	if fonteditor_page_cache_chars == nil
	or fonteditor_page_cache_page ~= fonteditor_page
	or fonteditor_page_cache_filter ~= fonteditor_filter then
		fonteditor_page_cache_chars = {}
		fonteditor_page_cache_page = fonteditor_page
		fonteditor_page_cache_filter = fonteditor_filter

		local codepoint_min, codepoint_max = 0, 0x10FFFF
		if fonteditor_filter == "unicode" then
			codepoint_min, codepoint_max = fonteditor_page+0, fonteditor_page+0xFFF
		end

		for codepoint = codepoint_min, codepoint_max do
			if fonteditor_filter == "unicode"
			or (fonteditor_filter == "supported" and fonteditor_chars[codepoint] ~= nil) then
				table.insert(fonteditor_page_cache_chars, codepoint)
			end
		end
	end
end

function fonteditor_load_reference_font(filepath, filename)
	if filepath == nil or filename == nil then
		filepath = s.fonteditor_reffont_ttf_filepath
		filename = s.fonteditor_reffont_ttf_filename
	end

	local readsuccess, contents = readfile(filepath)
	if not readsuccess then
		dialog.create(contents)
		return false
	end

	local success, filedata = pcall(love.filesystem.newFileData, contents, filename, "file")
	if not success then
		dialog.create(filedata)
		return false
	end

	local hinting = nil
	if love_version_meets(10) then
		hinting = "mono"
	end

	temp_rasterizer = love.font.newRasterizer(
		filedata,
		math.min(fonteditor_glyph_w, fonteditor_glyph_h)*4,
		hinting
	)

	love.graphics.setNewFont(temp_rasterizer)
	fonteditor_reffont_loaded = true

	return true
end
