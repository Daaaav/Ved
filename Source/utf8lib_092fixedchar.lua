--[[

The utf8 lib was added in LÖVE 0.9.2, but utf8.char() doesn't work properly
until LÖVE 0.10.0. So we'll have to fix it on our own to support 0.9.2

]]

local MAXUNICODE = 0x10FFFF
local UTF8BUFFSZ = 8

local bit = require("bit")

local function utf8esc(buff, x)
	local n = 1 -- Number of bytes put in buffer (backwards)
	assert(x <= 0x10FFFF) -- Editor's note: the source deadass doesn't use MAXUNICODE, instead it repeats the constant here. Hopefully they don't have to change MAXUNICODE in the future!

	if x < 0x80 then -- ASCII?
		buff[UTF8BUFFSZ - 1] = x
	else -- Need continuation bytes
		local mfb = 0x3f -- The maximum that fits in the first byte
		-- "repeat-until not" is "do-while" in disguise
		repeat
			buff[UTF8BUFFSZ - n] = bit.bor(0x80, bit.band(x, 0x3f))
			n = n + 1
			x = bit.rshift(x, 6) -- Remove added bits
			mfb = bit.rshift(mfb, 1) -- Now there is one less bit available in first byte
		until not (x > mfb) -- Still needs continuation byte?
		buff[UTF8BUFFSZ - n] = bit.bor(bit.lshift(bit.bnot(mfb), 1), x) -- Add first byte
	end
	return n
end

local function pushutfchar(n, arg)
	assert(type(arg) == "number", "bad argument #" .. n .. " to 'char' (number expected, got " .. type(arg) .. ")")
	local code = math.floor(arg)
	assert(0 <= code and code <= MAXUNICODE, "bad argument #" .. n .. " to 'char' (value out of range)")

	-- The %U string format doesn't exist in Lua 5.1 or 5.2, so we emulate it
	-- (Uhhh, the above makes more sense in the original C source)
	local buff = {}
	local l = utf8esc(buff, code) -- Classic C side-effect-oriented programming: `buff` is modified in `utf8esc`

	-- Classic C small-type-oriented programming: these bytes are unsigned and can't be negative...
	for thischar = UTF8BUFFSZ - l, UTF8BUFFSZ - 1 do
		buff[thischar] = buff[thischar] % 256
	end

	return string.char(unpack(buff, UTF8BUFFSZ - l, UTF8BUFFSZ - 1))
end

local function utfchar(...)
	local args = {...}
	local n = #args -- Number of arguments (this was less self-documenting in the original C)
	if n == 1 then -- Optimize common case of single char
		return pushutfchar(1, args[1])
	else
		local b = {}
		for i = 1, n do
			table.insert(b, pushutfchar(i, args[i]))
		end
		return table.concat(b)
	end
end

return utfchar
