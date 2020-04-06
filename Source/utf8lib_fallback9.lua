--[[

Ved supports LÖVE versions 0.9.1 and up (not 0.9.0).
Since the utf8 module was added in LÖVE 0.9.2, we have to rewrite the functions
from the module that Ved uses, but in pure Lua.

Thus, this file will contain the following functions (but none else provided by
the proper utf8 module):

 - utf8.offset()
 - utf8.len()

]]

local utf8 = {}

local bit = require("bit")

local MAXUNICODE = 0x10FFFF

local function iscont(p)
	p = p:byte()
	-- Lua version of `(p & 0xC0) == 0x80`
	return bit.band(p, 0xC0) == 0x80
end

-- So negative means we start from the end of the string
local function u_posrelat(pos, len)
	if pos >= 0 then
		return pos
	elseif math.abs(pos) > len then
		return 0
	else
		return len + pos + 1
	end
end

-- This is just the utf8 module's function straight from LÖVE's source, but implemented in pure Lua
-- And LÖVE got it straight from Lua 5.3's source
function utf8.offset(s, n, i)
	assert(type(s) == "string", "bad argument #1 to 'offset' (string expected, got " .. type(s) .. ")")
	if #s == 0 then
		return 0
	end
	assert(type(n) == "number", "bad argument #2 to 'offset' (number expected, got " .. type(n) .. ")")
	n = math.floor(n)
	local default_i
	if n >= 0 then
		default_i = 1
	else
		default_i = #s
	end
	i = i or default_i
	assert(type(i) == "number", "bad argument #3 to 'offset' (number expected, got " .. type(i) .. ")")
	i = math.floor(i)
	i = u_posrelat(i, #s)
	assert(1 <= i and i <= #s, "bad argument #3 to 'offset' (position out of range)")

	if n == 0 then
		-- Find the beginning of the current byte sequence
		while i > 0 and iscont(s:sub(i)) do
			i = i - 1
		end
	else
		if iscont(s:sub(i)) then
			error("initial position is a continuation byte")
		end
		if n < 0 then
			while n < 0 and i > 0 do -- Move back
				-- Read "repeat-until not" as "do-while"
				repeat
					-- Find the beginning of previous character
					i = i - 1
				until not (i > 0 and iscont(s:sub(i)))
				n = n + 1
			end
		else
			n = n - 1 -- Don't move for the first character
			while n > 0 and i < #s do
				-- Again, read "repeat-until not" as "do-while"
				repeat -- Find the beginning of the next character
					i = i + 1
				until not (i <= #s and iscont(s:sub(i))) -- We don't have null terminators in Lua
				n = n - 1
			end
		end
	end
	if n == 0 then -- Did it find the given character?
		return i
	else -- It didn't
		return nil
	end
end

-- Straight from the utf8 module, but implemented in pure Lua
local function utf8_decode(s, pos)
	local limits = {0xFF, 0x7F, 0x7FF, 0xFFFF}
	local c = s:sub(pos):byte()
	local res = 0 -- Final result
	if c < 0x80 then -- ASCII?
	else
		local count = 0 -- to count number of continuation bytes
		while bit.band(c, 0x40) ~= 0 do -- Still have continuation bytes?
			count = count + 1
			local cc = s:sub(pos + count):byte() -- Read next byte
			if bit.band(cc, 0xC0) ~= 0x80 then -- Not a continuation byte?
				return nil -- Invalid byte sequence
			end
			res = bit.bor(bit.lshift(res, 6), bit.band(cc, 0x3F)) -- Add lower 6 bits from continuation byte
			c = bit.lshift(c, 1) -- to test next bit
		end
		res = bit.bor(res, bit.lshift(bit.band(c, 0x7F), count * 5)) -- Add first byte
		if count > 3 or res > MAXUNICODE or res <= limits[count + 1] then
			return nil -- Invalid byte sequence
		end
		pos = pos + count -- Skip continuation bytes read
	end
	return pos + 1 -- +1 to include first byte
end

-- From the utf8 module, but in Lua
function utf8.len(s, i, j)
	local n = 0
	assert(type(s) == "string", "bad argument #1 to 'len' (string expected, got " .. type(s) .. ")")
	if #s == 0 then
		return 0
	end
	i = i or 1
	assert(type(i) == "number", "bad argument #2 to 'len' (number expected, got " .. type(i) .. ")")
	i = math.floor(i)
	i = u_posrelat(i, #s)
	j = j or -1
	assert(type(j) == "number", "bad argument #3 to 'len' (number expected, got " .. type(j) .. ")")
	j = math.floor(j)
	j = u_posrelat(j, #s)
	assert(1 <= i and i <= #s, "bad argument #2 to 'len' (initial position out of string)")
	assert(j <= #s, "bad argument #3 to 'len' (final position out of string)")

	while i <= j do
		local s1 = utf8_decode(s, i)
		if s1 == nil then -- Conversion error?
			return nil, i -- Return nil and current position
		end
		i = s1
		n = n + 1
	end
	return n
end

return utf8
