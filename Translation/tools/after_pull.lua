#!/usr/bin/env luajit

--[[
	This gets (translated) language files from the Weblate repo folder
	and ensures they are copied (and if needed, converted) to the correct places in Ved.
]]

require("inc")
local vedpo = require("vedpo")

pofiles = {}

local help_ids = get_help_ids()

for _,lang_code in pairs(languages) do
	if lang_code ~= "en" then
		print(lang_code .. ":")

		-- Just use cp to copy the main pos
		local cp_ret = os.execute(
			"cp '" .. weblate_repo_path .. "/ved/" .. lang_code .. ".po' '" .. ved_path .. "/lang/'"
		)
		if cp_ret ~= 0 then
			print("ERROR: Cannot copy main po, return code:")
			print(cp_ret)
		else
			print("Copied main po")
		end

		-- Now get all the help pages
		for _,id in pairs(help_ids) do
			print("Doing " .. id .. " in ved_help...")

			local po = vedpo.VedPO:new(
				io.lines(weblate_repo_path .. "/ved_help/" .. lang_code .. "/" .. id .. ".po"),
				false
			)

			local keyless_strings = {}

			local help_subj = "SUBJ"
			local any_translated = false

			for k,entry in ipairs(po.entries) do
				local str = entry.msgstr
				if entry.msgctxt ~= nil then
					if str == "" or entry.fuzzy then
						-- Just use the English string if it's untranslated
						str = entry.msgid
					else
						any_translated = true
					end
					if entry.msgctxt == "LHS." .. id .. ".subj" then
						help_subj = str
					end
				elseif entry.msgid ~= nil and entry.msgid ~= "" then
					-- No key (ctxt), just add this to our dictionary.
					if str == "" or entry.fuzzy then
						-- Just use the English string if it's untranslated
						str = entry.msgid
					else
						any_translated = true
					end
					keyless_strings[entry.msgid] = str
				end
			end

			if any_translated then
				-- Now write the help text file!
				local subj, cont = load_help_page("en", id)

				if subj ~= nil and cont ~= nil then
					local paragraphs, blanklines = split_help_page(cont)

					for k,v in pairs(paragraphs) do
						if keyless_strings[v] ~= nil then
							paragraphs[k] = keyless_strings[v]
						end
					end

					os.execute("mkdir " .. ved_path .. "/help/" .. lang_code .. "/ -p")
					local fh, everr = io.open(ved_path .. "/help/" .. lang_code .. "/" .. id .. ".txt", "w")
					if fh == nil then
						print("ERROR: Cannot open help file " .. lang_code .. "/" .. id .. " for writing")
						print(everr)
					else
						fh:write(help_subj .. "\n\n" .. merge_help_page(paragraphs, blanklines))
						fh:close()
					end
				end
			end
		end
	end
end
