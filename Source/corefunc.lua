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
