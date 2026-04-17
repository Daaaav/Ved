#!/usr/bin/env luajit

--[[
	This places template files into the correct folder to push to Weblate.

	For the regular language files, this is a simple copy from Ved to Ved-translation.

	For the help, this generates .pot files based off the English .txt files.
]]

require("inc")
local vedpo = require("vedpo")

-- Just use cp to copy the main pot
local cp_ret = os.execute("cp '" .. ved_path .. "/lang/en.pot' '" .. weblate_repo_path .. "/ved/'")
if cp_ret ~= 0 then
	print("ERROR: Cannot copy main pot, return code:")
	print(cp_ret)
else
	print("Copied main pot")
end

-- Check which help pages there are!
local help_ids = get_help_ids()
for _,id in pairs(help_ids) do
	local subj, cont = load_help_page("en", id)

	if subj ~= nil and cont ~= nil then
		local po = vedpo.VedPO:new()

		po:add_entry{
			msgctxt = "LHS." .. id .. ".subj",
			msgid = subj,
			msgstr = ""
		}

		local paragraphs, blanklines = split_help_page(cont)
		local seen = {}
		for k,v in pairs(paragraphs) do
			if not seen[v] then
				seen[v] = true

				po:add_entry{
					msgid = v,
					msgstr = ""
				}
			end
		end

		local fh, everr = io.open(weblate_repo_path .. "/ved_help/en/" .. id .. ".pot", "w")
		if fh == nil then
			print("ERROR: Cannot open new help " .. id .. " pot file for writing")
			print(everr)
		else
			fh:write(po:export())
			fh:close()
			print("Wrote help " .. id .. " pot")
		end
	end
end

