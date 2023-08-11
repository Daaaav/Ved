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

	if lovemajor == nil or loveminor == nil then
		-- I see, LÖVE 0.7
		return false
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
		return tonumber(this)
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

function love_ver_human()
	if love._version_major == nil then
		return "0.7.x or lower"
	else
		return love._version_major .. "." .. love._version_minor .. "." .. love._version_revision
	end
end

-- Returns the bit that signifies a certain significance from an integer.
-- Assumes your check/sig bit is actually one bit.
-- Example: check_bit(31, 8) == true because 31 is 11111, 8 is 01000, and that bit is 1.
-- Useful for checking attributes on Windows, think of check_bit(fileAttributes, FILE_ATTRIBUTE_DIRECTORY)
function check_bit(integer, sig)
	return (integer % (sig*2)) - (integer % sig) ~= 0
end

-- XML functions. These are not just limited to loading/saving VVVVVV levels, but also for languages information and the update information pages.
function xmlspecialchars(text)
	-- Replace real special entities like < > & by XML entities like &lt; &gt; &amp;
	return xmlnumericentities(text:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("'", "&apos;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("^ ", "&#32;"):gsub(" $", "&#32;"):gsub("  ", " &#32;"))
end

function unxmlspecialchars(text)
	-- Decode XML entities like &lt; &gt; &amp; to < > &
	return unxmlnumericentities(text):gsub("&gt;", ">"):gsub("&lt;", "<"):gsub("&apos;", "'"):gsub("&quot;", "\""):gsub("&amp;", "&")
end

function xmlnumericentities(text)
	-- Replace real control characters (<0x20) by numeric XML entities like &#31;
	return text:gsub(
		"%c",
		function(c)
			return "&#" .. string.byte(c) .. ";"
		end
	)
end

function unxmlnumericentities(text)
	-- Replace numeric XML entities (like &#32;) to real characters
	return text:gsub(
		"&#(%d+);",
		function(n)
			return utf8.char(tonumber(n))
		end
	):gsub(
		"&#x(%x+);",
		function(n)
			return utf8.char(tonumber(n,16))
		end
	)
end

function parsexmlattributes(text)
	-- Parses a sequence of XML attributes (x="12" y="34") and returns a table of key-value pairs
	-- Values are always of type string, so type conversions need to be done manually.
	local attributes = {}
	local curpos = 1
	while true do
		local key, value
		local found_start, found_openquote = text:find("[%w_]+=\"", curpos)
		if found_start == nil then
			break
		end
		key = text:sub(found_start, found_openquote-2)
		local found_closequote = text:find("\"", found_openquote+1, true)
		value = text:sub(found_openquote+1, found_closequote-1)
		attributes[key] = unxmlspecialchars(value)
		curpos = found_closequote+1
	end
	return attributes
end

function create_fallback_window()
	-- Make a window if we can't get to the main love.window.setMode in dodisplaysettings
	-- For example, early crash, incompatible LÖVE - hence the ancient LÖVE 0.8- support!
	if love_version_meets(9) then
		love.window.setMode(896, 480)
	else
		love.graphics.setMode(896, 480)
	end

	init_window_properties()
end

function init_window_properties()
	-- Again, compatibility for every LÖVE version under the sun
	local title = "Ved " .. ved_ver_human()
	local icon = love.image.newImageData("tools/prepared/1.png")

	if love_version_meets(9) then
		love.window.setTitle(title)
		love.window.setIcon(icon)
	else
		love.graphics.setCaption(title)
		if love.graphics.setIcon ~= nil then
			love.graphics.setIcon(love.graphics.newImage(icon))
		end
	end
end

function spritebatch_set_color(spritebatch, r, g, b, a)
	if not love_version_meets(8) then
		-- We're forcing text to be white in DINOSAUR love2d, but it already was white, so...
		-- Otherwise, just add another of these around the lg.setColor(255, 255, 255, 255)
		return
	end

	-- Colors in Ved are still 0-255
	local white = 255
	local div = 1
	if love_version_meets(11) then
		white = 1
		div = 255
	end

	if a == nil then
		a = 255
	end

	spritebatch:setColor(r/div, g/div, b/div, a/div)
end
