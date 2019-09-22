function love_version_meets(major, minor)
	-- Returns true if the version of love is major.minor or higher, false if lower.
	-- Love 0.9.x and 0.10.x are seen as 9.x and 10.x

	if minor == nil then
		minor = 0
	end

	local lovemajor, loveminor
	if love._version_major == 0 then
		lovemajor, loveminor = love._version_minor, love._version_revision
	else
		lovemajor, loveminor = love._version_major, love._version_minor
	end

	-- Yes, this could be done in one line, but this is much clearer.
	if lovemajor > major then
		return true
	elseif lovemajor < major then
		return false
	end

	-- Major is equal
	return loveminor >= minor
end

function cons(text)
	if text == nil then
		text = "nil"
	elseif type(text) == "boolean" then
		text = (text and "TRUE" or "FALSE")
	end
	print("[" .. round(love.timer.getTime()-begint, 2) .. "\\" .. round(love.timer.getTime()-begint-sincet, 2) .. "] " .. text)
	sincet = round(love.timer.getTime()-begint, 2)
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function anythingbutnil(this)
	if this == nil then
		return ""
	else
		return this
	end
end

function anythingbutnil0(this)
	-- Same, but instead of an empty string return 0
	if this == nil then
		return 0
	else
		return this
	end
end

-- http://stackoverflow.com/a/18975924/3495280
function table.copy(t)
	local t2 = {}
	for kap,vep in pairs(t) do
		if type(vep) == "table" then
			t2[kap] = table.copy(vep)
		else
			t2[kap] = vep
		end
	end
	return t2
end

function table.contains(t, thing)
	for _,element in pairs(t) do
		if element == thing then
			return true
		end
	end
	return false
end

function langkeys(strin, thesekeys, pluralvar)
	-- Fills in $1 $2 etc in the strings.
	if type(strin) == "table" then
		if pluralvar == nil then
			pluralvar = 1
		end

		local pluralform = lang_plurals(thesekeys[pluralvar])

		if type(pluralform) == "boolean" then
			pluralform = pluralform and 1 or 0
		end

		if strin[pluralform] == nil then
			-- Use English fallback
			pluralform = (thesekeys[pluralvar] ~= 1) and -2 or -1
		end

		strin = strin[pluralform]
	end

	for lk,lv in pairs(thesekeys) do
		strin = strin:gsub("$" .. lk, (tostring(lv):gsub("%%", "%%%%")))
	end

	return strin
end

function ved_ver_human()
	-- Displays Ved's version in a human-readable way. Must also work in filenames.
	if intermediate_version then
		return ver .. "-pre" .. (commitversion < 10 and "0" or "") .. commitversion
	end
	return ver
end

function loadfonts()
	-- load font8 and font16, either TTF or font.png, depending on setting for font.png
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

		hijack_print = true

		arrow_up = "^"
		arrow_down = "V"
		arrow_left = "<"
		arrow_right = ">"
	else
		-- Use the TTF
		font8 = love.graphics.newFont("fonts/Space Station.ttf", 8)
		font16 = love.graphics.newFont("fonts/Space Station.ttf", 16)

		hijack_print = false

		arrow_up = "↑"
		arrow_down = "↓"
		arrow_left = "←"
		arrow_right = "→"
	end

	-- Update the font to the new object
	love.graphics.setFont(font8)
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
		ved_require("lang/English")
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
			And yes, this means a language file will have to be loaded 3 times (English first)
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
end

function loadtinynumbersfont()
	-- Load the tinynumbers font, accounting for the current language
	-- TODO
end
