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

function getalllanguages()
	local languagesarray = love.filesystem.getDirectoryItems("lang")
	local returnarray = {}

	for k,v in pairs(languagesarray) do
		if v:sub(-4,-1) == ".lua" then
			table.insert(returnarray, v:sub(1,-5))
		end
	end

	return returnarray
end

function autolang()
	-- Figure out the language based on the operating system's language,
	-- which, of course, is OS-dependent
	if love.system.getOS() ~= "Windows" and love.system.getOS() ~= "OS X" and love.system.getOS() ~= "Linux" then
		return nil
	end

	local langs = getalllanguages()
	local function in_table(thistable, item)
		for _,thing in pairs(thistable) do
			if thing == item then
				return true
			end
		end
		return false
	end

	if love.system.getOS() == "OS X" or love.system.getOS() == "Linux" then
		local lang = os.getenv("LANG")
		if lang == nil or lang == "" then
			return nil
		end
		lang = lang:sub(1, 2)
		if #lang ~= 2 then
			return nil
		end

		local mapping = {
			de = "Deutsch",
			en = "English",
			eo = "Esperanto",
			fr = "Français",
			nl = "Nederlands",
			ru = "Русский",
		}

		if mapping[lang] ~= nil and in_table(langs, mapping[lang]) then
			return mapping[lang]
		else
			return nil
		end
	elseif love.system.getOS() == "Windows" then
		-- https://stackoverflow.com/a/25691701/
		-- But for Lua instead of Python
		-- and also: https://docs.microsoft.com/en-us/windows/win32/intl/language-identifier-constants-and-strings
		local ffi = require("ffi")
		ffi.cdef([[
		int GetUserDefaultUILanguage();
		]])
		local lang = ffi.C.GetUserDefaultUILanguage()

		lang = ("%x"):format(lang)
		if lang == nil or lang == "" then
			return nil
		end
		if #lang == 1 then
			lang = "0" .. lang
		end
		lang = lang:sub(-2, -1)

		local mapping = {
			["07"] = "Deutsch",
			["09"] = "English",
			-- Unfortunately, Windows does not allow you to use Esperanto as a language
			["0c"] = "Français",
			["13"] = "Nederlands",
			["19"] = "Русский",
		}

		if mapping[lang] ~= nil and in_table(langs, mapping[lang]) then
			return mapping[lang]
		else
			return nil
		end
	end
end

function ved_ver_human()
	-- Displays Ved's version in a human-readable way. Must also work in filenames.
	if intermediate_version then
		return ver .. "-pre" .. (commitversion < 10 and "0" or "") .. commitversion
	end
	return ver
end
