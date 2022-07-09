require("vedfont")

function loadfonts()
	-- load font8, either provided or customized, depending on settings for font.png

	fontpng_works = false
	local fontpng_folder, fontpng_contents

	-- First try level-specific fonts... If we're ready for that, and it's enabled.
	if s ~= nil and s.uselevelfontpng and editingmap ~= nil then
		local levelassets = getlevelassetsfolder()
		if levelassets ~= nil then
			fontpng_folder = levelassets .. dirsep .. "graphics"
			fontpng_works, fontpng_contents = readfile(fontpng_folder .. dirsep .. "font.png")
		end
	end

	-- If that doesn't exist (not already fontpng_works) try the graphics folder font. If enabled.
	if s ~= nil and s.usefontpng and not fontpng_works then
		fontpng_folder = graphicsfolder
		fontpng_works, fontpng_contents = readfile(fontpng_folder .. dirsep .. "font.png")
	end

	local custom_imgdata, custom_chars = nil, nil
	if fontpng_works then
		-- Use a customized font.png with the built-in as fallback

		local chars_success
		chars_success, custom_chars = readfile(fontpng_folder .. dirsep .. "font.txt")
		if not chars_success then
			local glyphs_table = {}
			for g = 0x00, 0x7f do
				table.insert(glyphs_table, string.char(g))
			end

			custom_chars = table.concat(glyphs_table, "")
		end

		custom_imgdata = love.image.newImageData(
			love.filesystem.newFileData(fontpng_contents, "font.png", "file")
		)
	end

	-- The font that comes with Ved
	local builtin_imgdata = love.image.newImageData("fonts/font.png")
	local builtin_chars = love.filesystem.read("fonts/font.txt")

	font8 = cVedFont:new()
	font8:init(8, 8, custom_imgdata, custom_chars, builtin_imgdata, builtin_chars)

	font8:set_glyph_width(6, 0x00, 0x1F)

	if font8:has_glyphs("↑↓←→", true) then
		arrow_up = "↑"
		arrow_down = "↓"
		arrow_left = "←"
		arrow_right = "→"
	else
		arrow_up = "^"
		arrow_down = "V"
		arrow_left = "<"
		arrow_right = ">"
	end
end

function loadlanginfo()
	-- Load the language properties for all languages.
	-- Language properties include the name, and in the future could have stuff like fonts, RTL, etc
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
	package.loaded["lang/" .. s.lang] = false
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

					if font8:has_glyphs(c, true) then
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

function loadtinynumbersfont()
	-- Load the tinynumbers font, accounting for the current language
	tinynumbers_all = love.graphics.newImageFont(
		"fonts/tinynumbersfont.png",
		"0123456789.,~RTYUIOPZXCVHBLSF{}ADEGJKMNQWcsaqwertyuiopkl<>/[]zxnbf+-d hgvj;",
		love_version_meets(10) and 1 or nil
	)
	if not love_version_meets(10) then
		tinynumbers = tinynumbers_all
	else
		tinynumbers = love.graphics.newImageFont("fonts/tinynumbersfont.png", "", 1)

		-- First has highest priority
		local fallbacks = {}
		if love.system.getOS() == "OS X" then
			table.insert(fallbacks, love.graphics.newImageFont("fonts/tinynumbersfont_mac.png", "c", 1))
		end
		if s.lang == "de" then
			table.insert(fallbacks, love.graphics.newImageFont("fonts/tinynumbersfont_de.png", "c", 1))
		elseif s.lang == "fr" then
			table.insert(fallbacks, love.graphics.newImageFont("fonts/tinynumbersfont_fr.png", "b", 1))
		end
		table.insert(fallbacks, tinynumbers_all)
		tinynumbers:setFallbacks(unpack(fallbacks))
	end

	love.graphics.setFont(tinynumbers)
end

function ved_print(...)
	font8:print(...)
end

function ved_printf(...)
	font8:printf(...)
end

function ved_shadowprint(text, x, y, sx, sy)
	if sx == nil then sx = 1 end
	if sy == nil then sy = sx end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0,0,0,255)
	ved_print(text, x, y-sy, sx, sy)
	ved_print(text, x-sx, y, sx, sy)
	ved_print(text, x+sx, y, sx, sy)
	ved_print(text, x, y+sy, sx, sy)
	love.graphics.setColor(r, g, b, a)
	ved_print(text, x, y, sx, sy)
end

function ved_shadowprintf(text, x, y, limit, align, sx, sy)
	if sx == nil then sx = 1 end
	if sy == nil then sy = sx end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0,0,0,255)
	ved_printf(text, x, y-sy, limit, align, sx, sy)
	ved_printf(text, x-sx, y, limit, align, sx, sy)
	ved_printf(text, x+sx, y, limit, align, sx, sy)
	ved_printf(text, x, y+sy, limit, align, sx, sy)
	love.graphics.setColor(r, g, b, a)
	ved_printf(text, x, y, limit, align, sx, sy)
end

function ved_shadowprint_tiny(text, x, y, sx, sy)
	if sx == nil then sx = 1 end
	if sy == nil then sy = sx end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0,0,0,255)
	tinyfont:print(text, x, y-sy, sx, sy)
	tinyfont:print(text, x-sx, y, sx, sy)
	tinyfont:print(text, x+sx, y, sx, sy)
	tinyfont:print(text, x, y+sy, sx, sy)
	love.graphics.setColor(r, g, b, a)
	tinyfont:print(text, x, y, sx, sy)
end

function font8_getWrap(text, wraplimit)
	-- DEPRECATED
	-- font8:getWrap(), but unify LÖVE version differences.
	-- Gives the number of lines (not the table of lines) because we never need the table.

	return font8:getWrap(text, wraplimit)
end

function font8_getHeight()
	-- DEPRECATED
	return font8:getHeight()
end


cTempTinyfontWrapper = {}

function cTempTinyfontWrapper:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function cTempTinyfontWrapper:print(text, x, y, sx, sy)
	love.graphics.print(text, x, y, 0, sx, sy)
end

function cTempTinyfontWrapper:printf(...)
	love.graphics.printf(...)
end

tinyfont = cTempTinyfontWrapper:new()
