#!/usr/bin/env luajit

--[[
	This allows you to change a string in all languages at the same time.

	For example changing the syntax of a placeholder, without having to make the change in English,
	pushing to Weblate, and hoping the fuzzy system picked it up and/or manually copy-pasting all
	the translations back in.

	Does the changes in en.pot in Ved, and all other language .po files in the repo!
	So after this, run before_push.lua
]]

require("inc")
local vedpo = require("vedpo")
local vedxml = require("vedxml")

local function path_for_file(lang)
	if lang == "en" then
		return ved_path .. "/lang/en.pot"
	end
	return weblate_repo_path .. "/ved/" .. lang .. ".po"
end

local po = vedpo.VedPO:new(io.lines(path_for_file("en")), false)

local match_key, match_english

while true do
	print("Search term (key or english string):")
	local search = io.read()
	print("")

	local n_matches = 0
	for k,entry in ipairs(po.entries) do
		local key = entry.msgctxt
		local english = entry.msgid

		if (key ~= nil and key:find(search, 1, true) ~= nil)
		or english:find(search, 1, true) ~= nil then
			n_matches = n_matches + 1
			match_key = key
			match_english = english

			if key ~= nil then
				print(key)
			end
			print("[en] " .. english)
		end
	end

	if n_matches == 0 then
		print("No matches\n")
	elseif n_matches >= 2 then
		print("\nToo many matches\n")
	else
		break
	end
end

local xml = vedxml.VedXML:new{root="tweak", preserve_all_whitespace=false}
xml:add_comment_in_last(nil, "Edit the strings below, then press ENTER on tweak_string.lua")
xml:set_text(xml:add_element_in_last(nil, "en"), match_english)

local language_exists = {}
local languages_incl_inactive = {}
for _,lang_code in pairs(languages) do
	table.insert(languages_incl_inactive, lang_code)
	language_exists[lang_code] = true
end

for filename in io.popen("ls '" .. weblate_repo_path .. "/ved/'"):lines() do
	local lang_code = filename:match("([A-Za-z0-9_%-]+)%.pot?")
	if not language_exists[lang_code] then
		table.insert(languages_incl_inactive, lang_code)
	end
end

for _,lang_code in pairs(languages_incl_inactive) do
	if lang_code ~= "en" then
		po = vedpo.VedPO:new(io.lines(path_for_file(lang_code)), false)

		local i = 1
		while po.entries[i] ~= nil do
			if po.entries[i].msgctxt == match_key and po.entries[i].msgid == match_english then
				print("[" .. lang_code .. "] " .. po.entries[i].msgstr)
				xml:set_text(xml:add_element_in_last(nil, lang_code), po.entries[i].msgstr)
			end
			i = i + 1
		end
	end
end

local fh, everr = io.open("tweak.xml", "w")
if fh == nil then
	print("ERROR: Cannot open tweak.xml for writing")
	print(everr)
	os.exit(0)
end

fh:write(xml:export())
fh:close()

print("\nEdit the strings in tweak.xml, press ENTER when ready")
io.read()

fh, everr = io.open("tweak.xml")
if fh == nil then
	print("ERROR: Cannot open tweak.xml for reading")
	print(everr)
	os.exit(0)
end

xml = vedxml.VedXML:new{string=(fh:read("*a"))}
fh:close()

local english_new = xml:get_text_or_nil(xml:find(nil, "en"))

for cur in xml:each_child_element(nil) do
	local lang_code = xml:get_name(cur)
	local po_path = path_for_file(lang_code)
	local translation = xml:get_text_or_nil(cur)

	po = vedpo.VedPO:new(io.lines(po_path), false)

	local changed = false
	local i = 1
	while po.entries[i] ~= nil do
		if po.entries[i].msgid == "" then
			-- A nice amount of leaning toothpicks with oranges...
			po.entries[i].msgstr = po.entries[i].msgstr:gsub(
				"PO%-Revision%-Date: %d%d%d%d%-%d%d%-%d%d %d%d:%d%d[%+%-]%d+\n",
				"PO-Revision-Date: " .. os.date("%Y-%m-%d %H:%M%z") .. "\n"
			)
		elseif po.entries[i].msgctxt == match_key and po.entries[i].msgid == match_english then
			po.entries[i].msgid = english_new
			if lang_code == "en" then
				changed = true
				print("[en] " .. english_new)
			elseif po.entries[i].msgstr ~= translation then
				changed = true
				print("[" .. lang_code .. "] " .. translation)
				po.entries[i].msgstr = translation
			end
		end
		i = i + 1
	end

	if changed then
		fh, everr = io.open(po_path, "w")
		if fh == nil then
			print("ERROR: Cannot open " .. po_path .. " for reading")
			print(everr)
		else
			fh:write(po:export())
			fh:close()
		end
	end
end

print("\nMake sure to run BEFORE_PUSH.LUA before pushing to Weblate!")
print("(the English file is not in the translation repo yet)")
