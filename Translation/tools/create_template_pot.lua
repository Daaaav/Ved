#!/usr/bin/env luajit

--[[
	This creates both a lua template and a pot file.
	lang/en.lua is the center of attention here when reading.
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
po_list_help_articles = {} -- this one is new, one element per article. Key is name.

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
]]
main_mode = "root"
current_arr = nil
vc_key = 1 -- in case there's incremental keys in the current var
batch_comment = nil

current_arr_sub = nil -- nested

line_number = 0
for line in io.lines(ved_path .. "/lang/" .. languages["templates"] .. ".lua") do
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
			-- These directives are especially for converting po+template into a lua language file
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
			export_line = "\t\t[0] = \"<" .. key .. ">\",\n\t},"
			current_arr_sub = nil
			main_mode = "plu"
			handled = true
		elseif line:match("^\t\t%[[0-5]%] = \".*\",?$") ~= nil then
			-- [KEY] = "Value",
			no_lua_export = true
			handled = true
		end
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

-- Check which help pages there are!
local help_ids = get_help_ids()
for _,id in pairs(help_ids) do
	local subj, cont = load_help_page("templates", id)

	if subj ~= nil and cont ~= nil then
		po_list_help_articles[id] = {}
		po_list = po_list_help_articles[id]

		local key = "LHS." .. id .. ".subj"
		local value = subj
		local value_escaped = escape_po_str(value)
		table.insert(po_list, "msgctxt \"" .. key .. "\"\nmsgid \""
			.. value_escaped .. "\"\nmsgstr \"\"\n"
		)

		local paragraphs, blanklines = split_help_page(cont)
		local seen = {}
		for k,v in pairs(paragraphs) do
			if not seen[v] then
				seen[v] = true

				value_escaped = escape_po_str(v)
				table.insert(po_list, "msgid \"" .. value_escaped .. "\"\nmsgstr \"\"\n")
			end
		end
	end
end

-- The same goes for the pot
os.execute("mkdir out/po/ved/templates/ -p")
os.execute("mkdir out/po/ved_help/templates/ -p")
fh, everr = io.open("out/po/ved/templates/ved_main.pot", "w")
if fh == nil then
	print("ERROR: Cannot open new main pot file for writing")
	print(everr)
else
	fh:write("\n" .. table.concat(po_list_main, "\n"))
	fh:close()
end

for k,v in pairs(po_list_help_articles) do
	fh, everr = io.open("out/po/ved_help/templates/" .. k .. ".pot", "w")
	if fh == nil then
		print("ERROR: Cannot open new help " .. k .. " pot file for writing")
		print(everr)
	else
		fh:write("\n" .. table.concat(v, "\n"))
		fh:close()
	end
end
