require("vedfont")

function read_font_file(custom_folder, font_name, ext)
	-- custom_folder can be the path to a level-specific
	-- fonts folder, or nil to signify a built-in font.
	-- Returns contents, or nil

	if custom_folder == nil then
		local success, contents = pcall(love.filesystem.read, "fonts/" .. font_name .. ext)
		if not success then
			contents = nil
		end
		return contents
	end

	local success, contents = readfile(custom_folder .. dirsep .. font_name .. ext)
	if success then
		return contents
	end
end

function load_font_filename(fonts, custom_folder, font_name)
	local png_contents = read_font_file(custom_folder, font_name, ".png")
	if png_contents ~= nil then
		local txt_contents = read_font_file(custom_folder, font_name, ".txt")
		local fontmeta_contents = read_font_file(custom_folder, font_name, ".fontmeta")

		local fallback, fallback_imgdata, fallback_fontmeta_contents
		if fontmeta_contents ~= nil then
			fallback = fontmeta_contents:match("<fallback>(.-)</fallback>")
		end
		if fallback ~= nil then
			-- Fallback fonts can only be main fonts, so we can cut corners a liiitle bit...
			fallback_png_contents = read_font_file(nil, fallback, ".png")
			fallback_fontmeta_contents = read_font_file(nil, fallback, ".fontmeta")

			if fallback_png_contents ~= nil and fallback_fontmeta_contents ~= nil then
				fallback_imgdata = love.image.newImageData(
					love.filesystem.newFileData(fallback_png_contents, fallback.. ".png", "file")
				)
			end
		end

		imgdata = love.image.newImageData(
			love.filesystem.newFileData(png_contents, font_name .. ".png", "file")
		)

		fonts[font_name] = cVedFont:new{standard_height=8}
		fonts[font_name]:init(
			imgdata,
			txt_contents,
			fontmeta_contents,
			fallback_imgdata,
			nil,
			fallback_fontmeta_contents
		)
	end
end

function loadfonts_main()
	-- Load the main (built-in) fonts. This should only be needed once in a session.
	fonts_main = {}
	fonts_custom = {}

	local files
	if love_version_meets(9) then
		files = love.filesystem.getDirectoryItems("fonts")
	else
		files = love.filesystem.enumerate("fonts")
	end
	for k,file_name in pairs(files) do
		if file_name:sub(-9) == ".fontmeta" and file_name ~= "tinyfont.fontmeta" then
			local font_name = file_name:sub(1,-10)
			load_font_filename(fonts_main, nil, font_name)
		end
	end

	font_ui = {
		context = "ui"
	}
	font_ui_metatable = {
		__index = function(table, index)
			local f
			if s ~= nil and s.lang ~= nil
			and langinfo ~= nil
			and langinfo[s.lang] ~= nil
			and langinfo[s.lang].font ~= nil
			and fonts_main[langinfo[s.lang].font] ~= nil then
				f = fonts_main[langinfo[s.lang].font]
			else
				f = font_8x8
			end

			return f[index]
		end
	}
	setmetatable(font_ui, font_ui_metatable)

	font_level = {
		context = "level"
	}
	font_level_metatable = {
		__index = function(table, index)
			local font = "font"
			if metadata ~= nil and metadata.font ~= nil then
				font = metadata.font
			end

			local f
			if fonts_custom[font] ~= nil then
				f = fonts_custom[font]
			elseif fonts_main[font] ~= nil then
				f = fonts_main[font]
			elseif fonts_custom["font"] ~= nil then
				f = fonts_custom["font"]
			else
				f = font_8x8
			end

			return f[index]
		end
	}
	setmetatable(font_level, font_level_metatable)

	font_8x8 = {
		context = "8x8"
	}
	font_8x8_metatable = {
		__index = function(table, index)
			assert(fonts_main["font"] ~= nil, "Main font is missing!")
			return fonts_main["font"][index]
		end
	}
	setmetatable(font_8x8, font_8x8_metatable)

	-- font8 is deprecated
	font8 = {
		context = "8x8"
	}
	setmetatable(font8, font_8x8_metatable)
end

function loadfonts_custom()
	-- Load the level-specific fonts
	fonts_custom = {}

	if editingmap ~= nil then
		local levelassets = getlevelassetsfolder()
		if levelassets ~= nil then
			local fonts_folder = levelassets .. graphicsfolder_rel

			-- Load font.png separately, it's not required to have a .fontmeta...
			load_font_filename(fonts_custom, fonts_folder, "font")

			local success, files = listfiles_generic(fonts_folder, ".fontmeta", true)
			for k,file in pairs(files) do
				if file.name ~= "font.fontmeta" then
					local font_name = file.name:sub(1,-10)
					load_font_filename(fonts_custom, fonts_folder, font_name)
				end
			end
		end
	end
end

function loadlanginfo()
	-- Load the language properties for all languages.
	-- Language properties include the name, fonts, RTL, etc
	langinfo = {}
	local contents = love.filesystem.read("lang/info.xml")
	if contents == nil then
		return
	end
	local xlanguages = contents:match("<languages>(.*)</languages>")
	if xlanguages == nil then
		return
	end
	for language in xlanguages:gmatch("<language (.-) />") do
		local attributes = parsexmlattributes(language)
		langinfo[attributes.code] = table.copy(attributes)
	end
end

function unloadlanguage()
	-- Prepare for language change
	package.loaded["lang." .. s.lang] = false
	package.loaded.devstrings = false
end

function loadlanguage()
	-- Load current language files depending on setting, and devstrings
	-- Possibly reload files that depend on language (const)
	-- Apply non-ASCII replacements if font.png is active
	if love.filesystem.exists("lang/" .. s.lang .. ".lua") then
		ved_require("lang/" .. s.lang)
	else
		-- Interpret old-style language setting
		local found = false
		for k,v in pairs(langinfo) do
			if s.lang == v.name and love.filesystem.exists("lang/" .. v.code .. ".lua") then
				ved_require("lang/" .. v.code)
				s.lang = v.code
				found = true
				break
			end
		end
		if not found then
			ved_require("lang/en")
		end
	end

	if fontpng_works then
		--[[
			If we're using font.png, and the language file defines a function to replace
			certain non-ASCII characters with ASCII, then apply that to the entire file.
			Should work fine as anything not translated will be ASCII and shouldn't be replaced.
			And the fontpng_ascii function itself will be destroyed, but we only use it once so /care.
			For example, a language may use a small amount of accented characters,
			but if only ASCII is allowed, would prefer to leave the accent off rather
			than have that character not be displayed at all.
			And yes, this means a language file will have to be loaded 2 times
		]]

		if fontpng_ascii == nil then
			fontpng_ascii = function(c) end
		end

		local any_unsupported = false
		local readlua = love.filesystem.read("lang/" .. s.lang .. ".lua")
		if readlua ~= nil then
			cons("Replacing non-ASCII in language file... Characters unsupported by font.png:")
			local newlua, replacements = readlua:gsub(
				"([\194-\244][\128-\191]*)",
				function(c)
					if c == "¤" or c == "§" or c == "°" then
						return
					end

					if font_ui:has_glyphs(c, true) then
						-- The font supports it, no need to replace it!
						-- (this already fully accounts for UTF-8, by the way)
						return
					end

					local newc = fontpng_ascii(c)

					if newc == nil then
						any_unsupported = true
						print(c)
					end
					return newc
				end
			)
			if not any_unsupported then
				print("(All characters apparently supported!)")
			end
			cons("Replacements: " .. replacements)

			assert(loadstring(newlua))()
		end
	end

	ved_require("devstrings")

	if package.loaded.const then
		package.loaded.const = false
		ved_require("const")
	end
	if package.loaded.tileset_data then
		package.loaded.tileset_data = false
		ved_require("tileset_data")
	end
	if uis ~= nil then
		-- Need to reload this for all the buttons that are in there
		unload_uis()
		load_uis()
	end
end

function loadtinyfont()
	local xml, err = love.filesystem.read("fonts/tinyfont.fontmeta")
	if xml == nil then
		-- I don't want to hardcode a "default" width for tinyfont, and this HAS to exist...
		error(err)
	end

	tinyfont = cVedFont:new()
	tinyfont:init(love.image.newImageData("fonts/tinyfont.png"), (love.filesystem.read("fonts/tinyfont.txt")), xml)

	-- Replace some key glyphs based on OS and language
	if s.lang == "de" then
		tinyfont:copy_glyph(0x63, 0xDF) -- c [CTRL] <- ß [STRG]
	elseif s.lang == "fr" then
		tinyfont:copy_glyph(0x62, 0xE9) -- b [ESC] <- é [ECHAP]
	end
	if love.system.getOS() == "OS X" then
		tinyfont:copy_glyph(0x63, 0x6D) -- c [CTRL] <- m [cmd]
	end
end

function ved_print(text, x, y, sx, sy)
	-- Deprecated
	font_8x8:print(text, x, y, nil, sx, sy)
end

function ved_printf(text, x, y, max_width, align, sx, sy)
	-- Deprecated
	font_8x8:printf(text, x, y, max_width, align, nil, sx, sy)
end

function ved_shadowprint(text, x, y, sx, sy)
	-- Deprecated
	font_8x8:shadowprint(text, x, y, nil, sx, sy)
end

function ved_shadowprintf(text, x, y, limit, align, sx, sy)
	-- Deprecated
	font_8x8:shadowprintf(text, x, y, limit, align, nil, sx, sy)
end

function ved_shadowprint_tiny(text, x, y, sx, sy)
	-- Deprecated
	tinyfont:shadowprint(text, x, y, nil, sx, sy)
end
