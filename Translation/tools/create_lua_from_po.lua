#!/usr/bin/env lua

--[[
	This fills in the template (out/Template.lua) to create a traditional
	Ved language file.
	Requires the files for the language to exist at in/po/ved/(code)/, and also
	out/Template.lua is required to exist.
	Outputs the language lua file as out/(Langname).lua, so that changes
	aren't as likely to be overwritten, and so you can manually run a diff
	to know everything's still fine.

	Language code expected (normally 2 letters)

	(there's no practical reason to do this with "templates", but no real
	reason to block it, since it works)
]]

require("inc")

local create_languages
if assert_lang_arg(1, true) then
	-- A valid language argument is given
	all_languages = {[arg[1]] = languages[arg[1]]}
else
	-- No language is given, so do all!
	all_languages = languages
end

for lang_code, lang_name in pairs(all_languages) do
	if lang_code ~= "templates" then
		print(lang_code .. ":")

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
			"%-%-%- Language: " .. lang_name .. " (" .. lang_code .. ")\n"
		):gsub(
			"%-%-%- Last converted: .-\n",
			"%-%-%- Last converted: " .. os.date("%Y-%m-%d %H:%M:%S (%Z)\n")
		)

		local count_translated = 0
		local count_total = 0

		local number_plurals = 1
		local plural_equation = "0"

		for _, pofile in pairs({"ved_main", "ved_help", "ved_lua_func"}) do
			print("Doing " .. pofile .. "...")

			local po_list = {}

			local current_key = nil
			local current_english = nil
			local current_english_plural = nil
			local current_translated = nil
			local current_translated_plurals = {}
			local current_translated_plurals_count = 0
			local multiline_mode = 0 -- 1 for msgid, 2 for msgstr, 11 for msgid_plural, >=20 for msgstr[n+20]
			local fuzzy = false

			local function save_translation()
				-- Okay, apply and reset
				if current_key ~= nil then
					current_english = unescape_po_str(current_english)
					if current_english_plural ~= nil then
						-- PLURALS ARE USED FOR THIS STRING
						current_english_plural = unescape_po_str(current_english_plural)
						local any_untranslated = false
						local plurals_export = {} -- contains lines which can be concatted with \n
						for k,v in pairs(current_translated_plurals) do
							v = unescape_po_str(v)
							if v == "" or fuzzy then
								-- Just ignore this one, we won't use it. English fallbacks exist.
								any_untranslated = true
							else
								if v == "<empty>" then
									-- It's actually supposed to be empty.
									v = ""
								end
								local fillin
								if current_key:match("^LH%.[0-9]+%.cont$") ~= nil then
									-- This is a multiline string
									fillin = escape_lua_blockstr(v)
								else
									fillin = escape_lua_str(v)
								end
								fillin = fillin:gsub("%%", "%%%%")
								plurals_export[k+1] = "\t\t[" .. k .. "] = \"" .. fillin .. "\","
							end
						end
						-- Are there any gaps in the list? Lua will act a bit screwy in that case
						local lastfound = false
						for k = number_plurals, 1, -1 do
							if lastfound and plurals_export[k] == nil then
								plurals_export[k] = ""
							elseif not lastfound and plurals_export[k] ~= nil then
								lastfound = true
							end
						end
						if current_translated_plurals_count < number_plurals or any_untranslated then
							table.insert(plurals_export, "\t\t[-1] = \"" .. current_english .. "\",")
							table.insert(plurals_export, "\t\t[-2] = \"" .. current_english_plural .. "\",")
						end
						if any_untranslated then
							count_translated = count_translated - 1 -- elegant
						end
						template = template:gsub(
							"\t\t%[0%] = \"<" .. current_key:gsub("%.", "%%%.") .. ">\",",
							table.concat(plurals_export, "\n")
						)
					else
						-- PLURALS ARE NOT USED FOR THIS STRING
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
				elseif current_english == "" and pofile == "ved_main" then
					-- current_translated should be the headers! We need the plural rules.
					local plural_line = unescape_po_str(current_translated):match(".*\nPlural%-Forms: ([^\n]-)\n.*")
					if plural_line == nil then
						print("ERROR: Plural line couldn't be matched in " .. pofile)
						os.exit(0)
					end
					--print("Got plural rule: " .. plural_line)
					number_plurals, plural_equation = plural_line:match("^nplurals=([1-6]); plural=(.*);$")
					number_plurals = tonumber(number_plurals)
					--print(number_plurals .. " plural(s), eqn: " .. plural_equation)

					-- Now convert the plural equation to lua
					lua_plural_equation = plural_equation
						:gsub("%?", "and")
						:gsub(":", "or")
						:gsub("&&", "and")
						:gsub("||", "or")
						:gsub("!=", "~=")
						:gsub("%%", "%%%%")

					template = template:gsub(
						"function lang_plurals%(n%) return 0 end\n",
						"function lang_plurals(n) return " .. lua_plural_equation .. " end\n"
					)
				end
				current_key = nil
				current_english = nil
				current_english_plural = nil
				current_translated = nil
				current_translated_plurals = {}
				current_translated_plurals_count = 0
				multiline_mode = 0
				fuzzy = false

				count_translated = count_translated + 1
				count_total = count_total + 1
			end

			local project = "ved"
			if pofile == "ved_help" then
				project = "ved_help"
			end

			local line_number = 0
			for line in io.lines("in/po/" .. project .. "/" .. lang_code .. "/" .. pofile .. ".po") do
				line_number = line_number + 1
				local handled = false

				if line == "" then
					save_translation()

					handled = true
				elseif line:match("^#%. .*$") ~= nil then
					-- #. developer's comment
					handled = true
				elseif line:match("^# .*$") ~= nil then
					-- # translator comment
					handled = true
				elseif line:match("^#~ .*$") ~= nil then
					-- #~ deleted string
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
				elseif line == "msgid_plural \"\"" then
					-- Must be a multiline English plural string
					multiline_mode = 11
					current_english_plural = ""
					handled = true
				elseif line:match("^msgid \".*\"$") ~= nil then
					-- Single-line English string
					multiline_mode = 0
					current_english = line:match("^msgid \"(.*)\"$")
					handled = true
				elseif line:match("^msgid_plural \".*\"$") ~= nil then
					-- Single-line English plural string
					multiline_mode = 0
					current_english_plural = line:match("^msgid_plural \"(.*)\"$")
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
				elseif line:match("msgstr%[[0-5]%] \"\"") ~= nil then
					-- Plural form: Maybe untranslated, maybe multiline!
					local form = line:match("msgstr%[([0-5])%] \"\"")
					multiline_mode = 20 + form
					current_translated_plurals[tonumber(form)] = ""
					current_translated_plurals_count = current_translated_plurals_count + 1
					handled = true
				elseif line:match("^msgstr \".*\"$") ~= nil then
					-- Translated! On a single line.
					multiline_mode = 0
					current_translated = line:match("^msgstr \"(.*)\"$")
					handled = true
				elseif line:match("^msgstr%[[0-5]%] \".*\"$") ~= nil then
					-- Translated! On a single line.
					multiline_mode = 0
					local form, translation = line:match("^msgstr%[([0-5])%] \"(.*)\"$")
					current_translated_plurals[form] = translation
					current_translated_plurals_count = current_translated_plurals_count + 1
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
					elseif multiline_mode == 11 then
						-- Continuing msgid_plural
						current_english_plural = current_english_plural .. part
						handled = true
					elseif multiline_mode >= 20 then
						-- Continuing msgstr[n+20]
						current_translated_plurals[multiline_mode-20] =
							current_translated_plurals[multiline_mode-20] .. part
						handled = true
					end
				end

				if not handled then
					print("WARNING: Line " .. line_number .. " not handled:")
					print(line)
				end
			end
			save_translation()

			fh, everr = io.open("out/" .. lang_name .. ".lua", "w")
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
	end
end