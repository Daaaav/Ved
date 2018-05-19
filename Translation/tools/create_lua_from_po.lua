#!/usr/bin/env lua

--[[
	This fills in the template (out/Template.lua) to create a traditional
	Ved language file.
	Requires the files for the language to exist at in/po/(code)/, and also
	out/Template.lua is required to exist.
	Outputs the language lua file as out/(Langname).lua, so that changes
	aren't as likely to be overwritten, and so you can manually run a diff
	to know everything's still fine.

	Language code expected (normally 2 letters)

	(there's no practical reason to do this with "templates", but no real
	reason to block it, since it works)
]]

require("inc")

assert_lang_arg(1)

-- Load the template
local fh, everr = io.open("out/Template.lua", "r")

if fh == nil then
	print("ERROR: Cannot open out/Template.lua for reading!")
	print(everr)
	os.exit(0)
end

local template = fh:read("*a")

fh:close()

template = template:gsub(
	"%-%-%- Language: .-\n",
	"%-%-%- Language: " .. languages[arg[1]] .. " (" .. arg[1] .. ")\n"
):gsub(
	"%-%-%- Last converted: .-\n",
	"%-%-%- Last converted: " .. os.date("%Y-%m-%d %H:%M:%S (%Z)\n")
)

local count_translated = 0
local count_total = 0

for _, pofile in pairs({"ved_main", "ved_help", "ved_lua_func"}) do
	local po_list = {}

	local current_key = nil
	local current_english = nil
	local current_translated = nil
	local multiline_mode = 0 -- 1 for msgid, 2 for msgstr
	local fuzzy = false

	local function save_translation()
		-- Okay, apply and reset
		if current_key ~= nil then
			current_english = unescape_po_str(current_english)
			current_translated = unescape_po_str(current_translated)
			if current_translated == "" or fuzzy then
				-- Just use the English string if it's untranslated
				current_translated = current_english
				count_translated = count_translated - 1 -- elegant
			end
			if current_translated == "<empty>" then
				-- It's actually supposed to be empty.
				current_translated = ""
			end
			local fillin
			if current_key:match("^LH%.[0-9]+%.cont$") ~= nil then
				-- This is a multiline string
				fillin = escape_lua_blockstr(current_translated)
			else
				fillin = escape_lua_str(current_translated)
			end
			if current_key == "fontpng_ascii" then
				template = template:gsub(
					"%-%-%- fontpng_ascii: N%.A%.",
					"function fontpng_ascii(c)\n"
					.. current_translated:gsub("\\t", "\t"):gsub("%%", "%%%%")
					.. "\nend"
				)
			else
				fillin = fillin:gsub("%%", "%%%%")
				template = template:gsub(
					"<" .. current_key:gsub("%.", "%%%.") .. ">",
					fillin
				)
			end
		end
		current_key = nil
		current_english = nil
		current_translated = nil
		multiline_mode = 0
		fuzzy = false

		count_translated = count_translated + 1
		count_total = count_total + 1
	end

	for line in io.lines("in/po/" .. arg[1] .. "/" .. pofile .. ".po") do
		local handled = false

		if line == "" then
			save_translation()

			handled = true
		elseif line:match("^#%. .*$") ~= nil then
			-- #. developer's comment
			handled = true
		elseif line == "#, fuzzy" then
			-- Actually maybe don't consider it translated
			fuzzy = true
			handled = true
		elseif line == "msgid \"\"" then
			-- Must be a multiline English string
			multiline_mode = 1
			current_english = ""
			handled = true
		elseif line:match("^msgid \".*\"$") ~= nil then
			-- Single-line English string
			multiline_mode = 0
			current_english = line:match("^msgid \"(.*)\"$")
			handled = true
		elseif line:match("^msgctxt \".*\"$") ~= nil then
			-- Key
			current_key = line:match("^msgctxt \"(.*)\"$")

			handled = true
		elseif line == "msgstr \"\"" then
			-- Maybe untranslated, maybe multiline!
			multiline_mode = 2
			current_translated = ""
			handled = true
		elseif line:match("^msgstr \".*\"$") ~= nil then
			-- Translated! On a single line.
			multiline_mode = 0
			current_translated = line:match("^msgstr \"(.*)\"$")
			handled = true
		elseif line:match("^\".*\"$") ~= nil then
			-- Hey, it's a continuation line!
			local part = line:match("^\"(.*)\"$")
			-- But we do have something to continue, don't we!
			if multiline_mode == 0 then
				print("WARNING: Line wrapping found near line "
					.. line_number .. ", but there's nothing to continue!"
				)
				handled = true
			elseif multiline_mode == 1 then
				-- Continuing msgid
				current_english = current_english .. part
				handled = true
			elseif multiline_mode == 2 then
				-- Continuing msgstr
				current_translated = current_translated .. part
				handled = true
			end
		end

		if not handled then
			print("WARNING: Line " .. line_number .. " not handled:")
			print(line)
		end
	end
	save_translation()

	fh, everr = io.open("out/" .. languages[arg[1]] .. ".lua", "w")
	if fh == nil then
		print("ERROR: Cannot open language file for writing")
		print(everr)
	else
		fh:write(template .. "\n")
		fh:close()
	end
end

if count_total == 0 then
	print("Total is 0?")
else
	print("Translated: " .. count_translated .. "/" .. count_total
		.. " (" .. (count_translated/count_total*100) .. "%)"
	)
end