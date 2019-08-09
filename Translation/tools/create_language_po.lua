#!/usr/bin/env lua

--[[
	This creates a po file for a given language.
	The template .pot files must already exist.
	It also assumes the .pot format is more simple than it can be
	(no wrapped lines, since our own script made it)
	NOTE: ved_lua_func.po is not filled in, that must be done by hand.

	This script should only need to be run if there's a lua language file
	that's translated, and no po file.

	Language code expected (normally 2 letters, not templates)

	template .pot files are read and are filled with translated
	strings from the given language

	This script is kinda outdated in two ways:
	- It wasn't updated for supporting plural forms
	- It wasn't updated for supporting split help pages
	So these things would need to be done manually. Not much of a problem,
	since this should be rarely needed anyway, and the vast majority of the
	file would be handled.
]]

require("inc")

assert_lang_arg(1)

if arg[1] == "templates" then
	print("You can't fill templates into itself!")
	os.exit(0)
end

os.execute("mkdir out/po/ved/" .. arg[1] .. "/ -p") -- it must be a language code
os.execute("mkdir out/po/ved_help/" .. arg[1] .. "/ -p")

-- Load the language
load_lua_lang(arg[1])

local count_translated = 1 -- count fontpng_ascii as translated
local count_total = 0

for _, pofile in pairs({"ved_main", "ved_help", "ved_lua_func"}) do
	local po_list = {}

	local current_value = nil
	local current_english = nil

	local project = "ved"
	if pofile == "ved_help" then
		project = "ved_help"
	end

	for line in io.lines("out/po/" .. project .. "/templates/" .. pofile .. ".pot") do
		local export_line = line
		local handled = false

		if line == "" then
			handled = true
		elseif line:match("^#%. .*$") ~= nil then
			-- #. developer's comment
			handled = true
		elseif line:match("^msgid \".*\"$") ~= nil then
			-- English string
			current_english = line:match("^msgid \"(.*)\"$")
			handled = true
		elseif line:match("^msgctxt \".*\"$") ~= nil then
			-- Key
			local key = line:match("^msgctxt \"(.*)\"$")

			if key == "fontpng_ascii" then
				print("You'll need to change the value of fontpng_ascii by hand.")
			else
				-- Actually get the value from this
				local _, count = key:gsub("%.", "")

				local var_stack = { key:match("^([^%.]+)" .. ("%.([^%.]+)"):rep(count) .. "$") }
				local val = _G
				while (#var_stack) > 0 do
					local nxt = var_stack[1]
					if nxt ~= nil and nxt == tostring(tonumber(nxt)) then
						nxt = tonumber(nxt)
					end
					val = val[nxt]
					table.remove(var_stack, 1)

					if val == nil then
						break
					end
				end

				if val == nil then
					print("WARNING: Value of " .. key .. " is nil")
				else
					if type(val) ~= "string" then
						print("WARNING: Type of " .. key .. " is " .. type(val))
					else
						current_value = escape_po_str(val)
					end
				end
			end

			handled = true
		elseif line == "msgstr \"\"" then
			if current_value ~= nil and current_value ~= current_english then
				-- If it's the same, count as not translated, just in case
				-- (plus by definition it'll be the same if it's English)
				export_line = "msgstr \"" .. current_value .. "\""
				count_translated = count_translated + 1
			end
			count_total = count_total + 1
			current_value = nil
			current_english = nil

			handled = true
		end

		if not handled then
			print("WARNING: Line " .. line_number .. " not handled:")
			print(line)
		end
		table.insert(po_list, export_line)
	end

	fh, everr = io.open("out/po/" .. project .. "/" .. arg[1] .. "/" .. pofile .. ".po", "w")
	if fh == nil then
		print("ERROR: Cannot open " .. pofile .. ".po for writing")
		print(everr)
	else
		fh:write([[
msgid ""
msgstr ""
"X-Pootle-Path: /]] .. arg[1] .. [[/]] .. project .. [[/]] .. pofile .. [[.po\n"
"X-Pootle-Revision: x\n"
]] .. table.concat(po_list, "\n") .. "\n")
		fh:close()
	end
end

if count_total == 0 then
	print("Total is 0?")
else
	print("Definitely translated: " .. count_translated .. "/" .. count_total
		.. " (" .. (count_translated/count_total*100) .. "%)"
	)
end

print("If you want to import it into Pootle, please download the empty files from there, and fill in the X-Pootle-Revision headers in each file correspondingly! Better not use revision 0, seems like that triggers everything to be suggestions instead of submissions.")