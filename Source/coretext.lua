function loadfonts()
	-- load font8, either TTF or font.png, depending on setting for font.png
	-- Set up alignment offset values depending on font and LÖVE version

	fontpng_works = false
	local fontpngcontents

	if s ~= nil and s.usefontpng and love_version_meets(10) then
		fontpng_works, fontpngcontents = readfile(graphicsfolder .. dirsep .. "font.png")
	end

	if fontpng_works then
		-- Use font.png

		-- The following function can be found in imagefont.lua
		convertfontpng(
			love.image.newImageData(love.filesystem.newFileData(fontpngcontents, "font.png", "file"))
		)

		arrow_up = "^"
		arrow_down = "V"
		arrow_left = "<"
		arrow_right = ">"

		print_font8_y_off = 0
	else
		-- Use the TTF
		font8 = love.graphics.newFont("fonts/Space Station.ttf", 8)

		arrow_up = "↑"
		arrow_down = "↓"
		arrow_left = "←"
		arrow_right = "→"

		if not love_version_meets(11) then
			print_font8_y_off = 2
		else
			print_font8_y_off = 0
		end
	end

	-- Update the font to the new object
	ved_setFont(font8)
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
	if uis ~= nil then
		-- Need to reload this for all the buttons that are in there
		unloaduis()
		loaduis()
	end
end

function loadtinynumbersfont()
	-- Load the tinynumbers font, accounting for the current language
	tinynumbers_all = love.graphics.newImageFont(
		"fonts/tinynumbersfont.png",
		"0123456789.,~RTYUIOPZXCVHBLSF{}ADEGJKMNQWcsaqwertyuiopkl<>/[]zxnbf+-d h",
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
end

function ved_setFont(font)
	if font == font8 then
		print_y_off = print_font8_y_off
	else
		print_y_off = 0
	end

	love.graphics.setFont(font)
end

function ved_print(text, x, y, sx, sy)
	local y_off = print_y_off
	if sy ~= nil then
		y_off = y_off * sy
	elseif sx ~= nil then
		y_off = y_off * sx
	end

	love.graphics.print(text, x, y + y_off, nil, sx, sy)
end

function ved_printf(text, x, y, limit, align, sx, sy)
	local y_off = print_y_off
	if sy ~= nil then
		y_off = y_off * sy
	elseif sx ~= nil then
		y_off = y_off * sx
	end
	if sx ~= nil then
		limit = limit/sx
	end

	love.graphics.printf(text, x, y + y_off, limit, align, nil, sx, sy)
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
