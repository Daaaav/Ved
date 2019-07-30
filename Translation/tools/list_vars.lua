#!/usr/bin/env lua

--[[
	This loads a language file (from lang/), and displays all variables that are defined by it.

	Language code expected (normally 2 letters or "templates")
]]

require("inc")

assert_lang_arg(1)

-- First determine which global variables already exist
local already_exist = {}
for k,v in pairs(_G) do
	already_exist[k] = true
end

load_lua_lang(arg[1])

-- What new arguments have we got?
for k,v in pairs(_G) do
	if not already_exist[k] then
		print(k .. ": " .. type(v))
	end
end
