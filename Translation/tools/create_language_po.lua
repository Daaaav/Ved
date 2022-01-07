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

	This script was also updated to handle the split help pages, but it does
	not handle any of the plural forms, so those will need to be done manually.
	Not much of a problem, since this should be rarely needed anyway, and the
	plural forms are only a small part of the language files.
]]

require("inc")

assert_lang_arg(1)

if arg[1] == "templates" then
	print("You can't fill templates into itself!")
	os.exit(0)
end

os.execute("mkdir out/po/ved/" .. arg[1] .. "/ -p") -- it must be a language code
os.execute("mkdir out/po/ved_help/" .. arg[1] .. "/ -p")

-- First make sure we can copy the English help articles...
load_lua_lang("templates")
english_help = {}

for k,v in pairs(LH) do
	local paragraphs, blanklines = split_help_page(v.cont)
	english_help[v.splitid] = {
		splitid = v.splitid,
		paragraphs = paragraphs,
		blanklines = blanklines
	}
end

-- Load the language
load_lua_lang(arg[1])

local count_translated = 1 -- count fontpng_ascii as translated
local count_total = 0

local pofiles = {"ved_main", "ved_help", "ved_lua_func"}

for k,v in pairs(english_help) do
	table.insert(pofiles, k)
end

for _, pofile in pairs(pofiles) do
	local po_list = {}

	local current_value = nil
	local current_english = nil

	local split_help_mode = english_help[pofile] ~= nil

	local project = "ved"
	if pofile == "ved_help" or split_help_mode then
		project = "ved_help"
	end

	local help_ix
	local help_map = {}
	if split_help_mode then
		for k,v in pairs(LH) do
			if v.splitid == pofile then
				help_ix = k
				break
			end
		end

		local paragraphs, blanklines = split_help_page(LH[help_ix].cont)

		if #paragraphs ~= #english_help[pofile].paragraphs
		or #blanklines ~= #english_help[pofile].blanklines then
			print("WARNING: paragraph counts for " .. pofile .. " not equal between languages! Skipping file, needs to be done manually")
			break
		end

		for k,v in pairs(paragraphs) do
			local eng_paragraph = english_help[pofile].paragraphs[k]
			local _, len_eng = eng_paragraph:gsub("\n", "")
			local _, len_tra = v:gsub("\n", "")
			if len_tra < len_eng - 2 or len_tra > len_eng + 2 then
				print("WARNING: Paragraph " .. k .. " (1-ix) in " .. pofile .. " is a whopping " .. math.abs(len_eng - len_tra) .. " lines longer/shorter")
			end

			local eng_escaped = escape_po_str(eng_paragraph)
			if help_map[eng_escaped] == nil then
				help_map[eng_escaped] = escape_po_str(v)
			end
		end

		for k,v in pairs(blanklines) do
			local eng_blankline = english_help[pofile].blanklines[k]
			if v ~= eng_blankline then
				print("WARNING: Spacing between paragraphs " .. (k-1) .. " and " .. k .. " (1-ix) in " .. pofile .. " is different: " .. eng_blankline .. "/" .. v)
			end
		end
	end

	local line_number = 0
	for line in io.lines("out/po/" .. project .. "/templates/" .. pofile .. ".pot") do
		line_number = line_number + 1
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

			if split_help_mode and current_value == nil then
				current_value = help_map[current_english]

				if current_value == nil then
					print("WARNING: English paragraph in " .. pofile .. " can't be found!")
				end
			end

			handled = true
		elseif line:match("^msgid_plural \".*\"$") ~= nil then
			-- English string (plural)
			handled = true
		elseif line:match("^msgctxt \".*\"$") ~= nil then
			-- Key
			local key = line:match("^msgctxt \"(.*)\"$")

			if split_help_mode and key == "LHS." .. pofile .. ".subj" then
				current_value = LH[help_ix].subj
			elseif key == "fontpng_ascii" then
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
					if type(val) == "table" and key:sub(1,6) == "L_PLU." then
						-- Ignore, it's just a plural string that we ignore
					elseif type(val) ~= "string" then
						print("WARNING: Type of " .. key .. " is " .. type(val))
					else
						current_value = escape_po_str(val)
					end
				end
			end

			handled = true
		elseif line == "msgstr \"\"" then
			if current_value ~= nil then
				if current_value == current_english then
					if not split_help_mode then
						-- If it's the same, warn, just in case
						print("Is \"" .. current_value .. "\" the same in both languages?")
					end
				else
					count_translated = count_translated + 1
				end
				export_line = "msgstr \"" .. current_value .. "\""
			end
			count_total = count_total + 1
			current_value = nil
			current_english = nil

			handled = true
		elseif line == "msgstr[0] \"\"" or line == "msgstr[1] \"\"" then
			handled = true
		end

		if not handled then
			print("WARNING: Line " .. line_number .. " in " .. pofile .. ".pot not handled:")
			print("  " .. line)
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

print("You'll need to do the plural strings by hand.")

if count_total == 0 then
	print("Total is 0?")
else
	print("Definitely translated: " .. count_translated .. "/" .. count_total
		.. " (" .. (count_translated/count_total*100) .. "%)"
	)
end

print("If you want to import it into Pootle, please download the empty files from there, and fill in the X-Pootle-Revision headers in each file correspondingly! Better not use revision 0, seems like that triggers everything to be suggestions instead of submissions.")

print("Of course, diff the lua->po->lua version with the original .lua")
