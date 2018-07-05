#!/usr/bin/env lua

--[[
	This creates both a lua template and a pot file.
	lang/English.lua is the center of attention here when reading.
	This code is a little complicated because the language files are just
	manually-written lua files, with just about enough structure to be able
	to automatically process them
]]

require("inc")

-- Can't hurt to have the real values as parsed by lua
load_lua_lang("templates")

-- An array that will pretty much hold the lines we'll export to the pot.
-- This avoids heaps of string concatenation during execution.
po_list_main = {}
po_list_help = {}

-- The current po to add to
po_list = po_list_main

-- A similar array for the resulting lua template.
luatemplate_list = {}

--[[ Modes!
	root: level 0, not inside any arrays
	root_com: same as root, but inside a - - [ [ ... ] ]
	auto: automatically detect how table items are structured with regex:
	--kvc: KEY = "Value",[ -- comment]. Comments may also appear above entire blocks
	--vc: "Value",. For keys, a counter is incremented.
	--nac: [1] = {"Value1", "Value2", "Value3"},
	-- Okay, so in auto mode, actually this:
	---- [(key|[n]) = ]
	---- Agh
	---- Match one of these:
	---- [A-Za-z_]+ = ".*",?
	---- [A-Za-z_]+ = ".*",? %-%- .*
	---- ".*",?
	---- %[ [0-9]+] = {.*},?
	---- %[ [0-9]+] = ".*",?
	diffmessages: Since this is different than the others,
		I'd like to parse it separately
	diffmessages_sub: like auto is to root
	plu: inside L_PLU, similar to diffmessages
	plu_sub: similar to diffmessages_sub (like auto is to root)
	help
	help_com
	help_article
	help_articlecontent
]]
main_mode = "root"
current_arr = nil
vc_key = 1 -- in case there's incremental keys in the current var
batch_comment = nil

current_arr_sub = nil -- nested

line_number = 0
for line in io.lines(langdir_path .. "/" .. languages["templates"] .. ".lua") do
	line_number = line_number + 1
	local export_line = line
	local handled = false
	local no_single = false -- For example: nested list on one line
	local no_lua_export = false -- For example: multiline help articles

	local lua_key = nil -- original key, maybe as used in subarrays
	local key = nil -- key as used in po, to be unique
	local value = nil
	local value_plural = nil
	local comment = nil

	if main_mode == "root" then
		if line == "" then
			handled = true
		elseif line:match("^[A-Za-z0-9_]+ = {$") ~= nil then
			-- table = {
			current_arr = line:match("^([A-Za-z0-9_]+) = {$")
			if current_arr == "diffmessages" then
				main_mode = "diffmessages"
			elseif current_arr == "LH" then
				main_mode = "help"
				po_list = po_list_help
				vc_key = 1
			elseif current_arr == "L_PLU" then
				main_mode = "plu"
			else
				main_mode = "auto"
			end
			vc_key = 1
			handled = true
		elseif line:match("^[A-Za-z0-9_]+ = \".*\"$") ~= nil then
			-- KEY = "Value"
			lua_key = line:match("^([A-Za-z0-9_]+) = \".*\"$")
			key = lua_key
			value = _G[key]
			export_line = lua_key .. " = \"<" .. key .. ">\""
			handled = true
		elseif line:match("^[A-Za-z0-9_]+ = \".*\" %-%- .*$") ~= nil then
			-- KEY = "Value" -- comment
			lua_key, comment = line:match("^([A-Za-z0-9_]+) = \".*\" %-%- (.*)$")
			key = lua_key
			value = _G[key]
			export_line = lua_key .. " = \"<" .. key .. ">\" -- " .. comment
			handled = true
		elseif line == "--[[" then
			main_mode = "root_com"
			handled = true
		elseif line:match("^%-%- .*$") ~= nil then
			-- -- comment
			handled = true
		elseif line:match("^%-%-%- [^:]+:.*$") ~= nil then
			-- --- directive
			local directive_key, directive_val = line:match("^%-%-%- ([^:]+):(.*)$")

			-- These directives are especially for converting po+template into a lua language file
			--[[
			if directive_key == "fontpng_ascii" then
				key = "fontpng_ascii"
				value = ""
			end
			]]
			handled = true
		elseif line == "function lang_plurals(n) return (n ~= 1) end" then
			export_line = "function lang_plurals(n) return 0 end"
			handled = true
		end
	elseif main_mode == "root_com" then
		if line == "]]" then
			main_mode = "root"
		end
		handled = true
	elseif main_mode == "auto" then
		if line == "" then
			batch_comment = nil
			handled = true
		elseif line == "}" then
			current_arr = nil
			main_mode = "root"
			handled = true
		elseif line:match("^[A-Za-z0-9_]+ = \".*\",?$") ~= nil then
			-- KEY = "Value",
			lua_key = line:match("^([A-Za-z0-9_]+) = \".*\",?$")
			key = current_arr .. "." .. lua_key
			value = _G[current_arr][lua_key]
			export_line = lua_key .. " = \"<" .. key .. ">\","
			handled = true
		elseif line:match("^[A-Za-z0-9_]+ = \".*\",? %-%- .*$") ~= nil then
			-- KEY = "Value", -- comment
			lua_key, comment = line:match("^([A-Za-z0-9_]+) = \".*\",? %-%- (.*)$")
			key = current_arr .. "." .. lua_key
			value = _G[current_arr][lua_key]
			export_line = lua_key .. " = \"<" .. key .. ">\", -- " .. comment
			handled = true
		elseif line:match("^\".*\",?$") ~= nil then
			-- "Value",
			lua_key = vc_key
			key = current_arr .. "." .. lua_key
			value = _G[current_arr][lua_key]
			export_line = "\"<" .. key .. ">\","
			vc_key = vc_key + 1
			handled = true
		elseif line:match("^%[[0-9]+] = {.*},?$") ~= nil then
			-- [1] = {"Value1", "Value2", "Value3"},
			lua_key = line:match("^%[([0-9]+)] = {.*},?$")
			key = current_arr .. "." .. lua_key
			--value = table.concat(_G[current_arr][tonumber(key)], ", ")
			local actualvalue = _G[current_arr][tonumber(lua_key)]
			local placeholderlist = {}
			for i = 1, #actualvalue do
				table.insert(placeholderlist, "\"<" .. key .. "." .. i .. ">\"")
				-- We also better add this to the pot!
				value = actualvalue[i]
				if value == "" then
					value = "<empty>"
				end
				value_escaped = escape_po_str(value)
				table.insert(po_list, "msgctxt \"" .. key .. "." .. i .. "\"\nmsgid \""
					.. value_escaped .. "\"\nmsgstr \"\"\n"
				)
			end
			export_line = "[" .. lua_key .. "] = {" .. table.concat(placeholderlist, ", ") .. "},"
			no_single = true
			handled = true
		elseif line:match("^%[[0-9]+] = \".*\",?$") ~= nil then
			-- [1] = "Value",
			lua_key = line:match("^%[([0-9]+)] = \".*\",?$")
			key = current_arr .. "." .. lua_key
			value = _G[current_arr][tonumber(lua_key)]
			export_line = "[" .. lua_key .. "] = \"<" .. key .. ">\","
			handled = true
		elseif line:match("^%-%- .*$") ~= nil then
			-- -- comment
			batch_comment = line:match("^%-%- (.*)$")
			handled = true
		end
	elseif main_mode == "diffmessages" then
		if line == "" then
			handled = true
		elseif line == "}" then
			current_arr = nil
			main_mode = "root"
			handled = true
		elseif line:match("^\t[A-Za-z0-9_]+ = {$") ~= nil then
			-- subtable = {
			current_arr_sub = line:match("^\t([A-Za-z0-9_]+) = {$")
			main_mode = "diffmessages_sub"
			handled = true
		end
	elseif main_mode == "diffmessages_sub" then
		if line == "" then
			handled = true
		elseif line == "\t}," then
			current_arr_sub = nil
			main_mode = "diffmessages"
			handled = true
		elseif line:match("^\t\t[A-Za-z0-9_]+ = \".*\",?$") ~= nil then
			-- KEY = "Value",
			lua_key = line:match("^\t\t([A-Za-z0-9_]+) = \".*\",?$")
			key = current_arr .. "." .. current_arr_sub .. "." .. lua_key
			value = _G[current_arr][current_arr_sub][lua_key]
			export_line = "\t\t" .. lua_key .. " = \"<" .. key .. ">\","
			handled = true
		end
	elseif main_mode == "plu" then
		if line == "" then
			handled = true
		elseif line == "}" then
			current_arr = nil
			main_mode = "root"
			handled = true
		elseif line:match("^\t[A-Za-z0-9_]+ = {$") ~= nil then
			-- subtable = {
			current_arr_sub = line:match("^\t([A-Za-z0-9_]+) = {$")
			main_mode = "plu_sub"
			handled = true
		end
	elseif main_mode == "plu_sub" then
		if line == "" then
			handled = true
		elseif line == "\t}," then
			key = current_arr .. "." .. current_arr_sub
			value = _G[current_arr][current_arr_sub][0]
			value_plural = _G[current_arr][current_arr_sub][1]
			export_line = "\t\t[0] = \"<" .. key .. ">\",\n\t}"
			current_arr_sub = nil
			main_mode = "plu"
			handled = true
		elseif line:match("^\t\t%[[0-5]%] = \".*\",?$") ~= nil then
			-- [KEY] = "Value",
			no_lua_export = true
			handled = true
		end
	elseif main_mode == "help" then
		if line == "" then
			handled = true
		elseif line:match("^%-%- .*$") ~= nil then
			-- -- comment
			handled = true
		elseif line == "--[[" then
			main_mode = "help_com"
			handled = true
		elseif line == "{" then
			-- Start of article
			main_mode = "help_article"
			handled = true
		elseif line == "}" then
			-- End of help
			main_mode = "root"
			po_list = po_list_main
			handled = true
		end
	elseif main_mode == "help_com" then
		if line == "]]" then
			main_mode = "help"
		end
		handled = true
	elseif main_mode == "help_article" then
		if line == "" then
			handled = true
		elseif line:match("^subj = \".*\",$") ~= nil then
			key = current_arr .. "." .. vc_key .. ".subj"
			value = _G[current_arr][vc_key].subj
			export_line = "subj = \"<" .. key .. ">\","
			handled = true
		elseif line:match("^imgs = {.*},$") ~= nil then
			handled = true
		elseif line == "cont = [[" then
			main_mode = "help_articlecontent"
			handled = true
		elseif line == "}," then
			main_mode = "help"
			vc_key = vc_key + 1
			handled = true
		end
	elseif main_mode == "help_articlecontent" then
		local ended = false
		if line == "]]" then
			ended = true
		elseif line:match("^]] %-%- .*$") ~= nil then
			comment = line:match("^]] %-%- (.*)$")
			ended = true
		end
		if ended then
			main_mode = "help_article"
			no_lua_export = false

			key = current_arr .. "." .. vc_key .. ".cont"
			value = _G[current_arr][vc_key].cont
			export_line = "<" .. key .. ">\n" .. line
		else
			no_lua_export = true
		end
		handled = true
	end

	-- XOR would be neat but meh, this works
	if not no_single and (key ~= nil or value ~= nil) then
		if key == nil or value == nil then
			print("WARNING: Line " .. line_number .. " has either key or val but not both")
		else
			if batch_comment ~= nil then
				if comment == nil then
					comment = batch_comment
				else
					comment = comment .. " / " .. batch_comment
				end
			end
		end
	end

	if not handled then
		print("WARNING: Line " .. line_number .. " not handled in mode " .. main_mode .. ":")
		print(line)
	end
	if not no_single and key ~= nil and value ~= nil then
		if comment ~= nil then
			table.insert(po_list, "#. " .. comment)
		end
		if value == "" then
			value = "<empty>"
		end
		value_escaped = escape_po_str(value)
		if value_plural == nil then
			table.insert(po_list, "msgctxt \"" .. key .. "\"\nmsgid \""
				.. value_escaped .. "\"\nmsgstr \"\"\n"
			)
		else
			if value_plural == "" then
				value_plural = "<empty>"
			end
			value_plural_escaped = escape_po_str(value_plural)
			table.insert(po_list, "msgctxt \"" .. key .. "\"\nmsgid \""
				.. value_escaped .. "\"\nmsgid_plural \""
				.. value_plural_escaped .. "\"\nmsgstr[0] \"\"\nmsgstr[1] \"\"\n"
			)
		end
	end
	if not no_lua_export then
		table.insert(luatemplate_list, export_line)
	end
end

print("Final mode is " .. main_mode .. " (expecting root)")

-- Save the lua template!
local fh, everr = io.open("out/Template.lua", "w")
if fh == nil then
	print("ERROR: Cannot open new lua file for writing")
	print(everr)
else
	fh:write(table.concat(luatemplate_list, "\n"))
	fh:close()
end

-- The same goes for the pot
os.execute("mkdir out/po/templates/ -p")
fh, everr = io.open("out/po/templates/ved_main.pot", "w")
if fh == nil then
	print("ERROR: Cannot open new main pot file for writing")
	print(everr)
else
	fh:write("\n" .. table.concat(po_list_main, "\n"))
	fh:close()
end

fh, everr = io.open("out/po/templates/ved_help.pot", "w")
if fh == nil then
	print("ERROR: Cannot open new help pot file for writing")
	print(everr)
else
	fh:write("\n" .. table.concat(po_list_help, "\n"))
	fh:close()
end

-- Also make a pot for fontpng, which shall not be defined in English
fh, everr = io.open("out/po/templates/ved_lua_func.pot", "w")
if fh == nil then
	print("ERROR: Cannot open new help pot file for writing")
	print(everr)
else
	fh:write([[

#. function fontpng_ascii(c) - see the special page for info
msgctxt "fontpng_ascii"
msgid "<empty>"
msgstr ""
]])
	fh:close()
end