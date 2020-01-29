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
	for k,v in pairs(t) do
		if type(v) == "table" then
			t2[k] = table.copy(v)
		else
			t2[k] = v
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

function langkeys(str, thesekeys, pluralvar)
	-- Fills in $1 $2 etc in the strings.
	if type(str) == "table" then
		if pluralvar == nil then
			pluralvar = 1
		end

		local pluralform = lang_plurals(thesekeys[pluralvar])

		if type(pluralform) == "boolean" then
			pluralform = pluralform and 1 or 0
		end

		if str[pluralform] == nil then
			-- Use English fallback
			pluralform = (thesekeys[pluralvar] ~= 1) and -2 or -1
		end

		str = str[pluralform]
	end

	for lk,lv in pairs(thesekeys) do
		str = str:gsub("$" .. lk, (tostring(lv):gsub("%%", "%%%%")))
	end

	return str
end

function ved_ver_human()
	-- Displays Ved's version in a human-readable way. Must also work in filenames.
	if intermediate_version then
		return ver .. "-pre" .. (commitversion < 10 and "0" or "") .. commitversion
	end
	return ver
end

-- Returns the bit that signifies a certain significance from an integer.
-- Assumes your check/sig bit is actually one bit.
-- Example: bit(31, 8) == true because 31 is 11111, 8 is 01000, and that bit is 1.
-- Useful for checking attributes on Windows, think of bit(fileAttributes, FILE_ATTRIBUTE_DIRECTORY)
function bit(integer, sig)
	return (integer % (sig*2)) - (integer % sig) ~= 0
end
