-- help/keypressed

return function(key)
	if key == "escape" then
		if helpeditingline ~= 0 then
			save_help_article()
		elseif oldstate == 11 then
			-- Back to search results
			resume_search = true
			tostate(11)
		else
			tostate(oldstate, true)
		end
		nodialog = false
	elseif helpeditingline ~= 0 then
		if keyboard_eitherIsDown(ctrl) and keyboard_eitherIsDown("alt") then
			inplacescroll(key)
		elseif key == "up" and helpeditingline ~= 1 then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline - 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "down" and helparticlecontent[helpeditingline+1] ~= nil then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif table.contains({"return", "kpenter"}, key) then
			table.insert(helparticlecontent, helpeditingline+1, "")
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "insert" then
			if keyboard_eitherIsDown("shift") then
				input = input .. "§"
			else
				input = input .. "¤"
			end
			helparticlecontent[helpeditingline] = input
		elseif key == "d" and keyboard_eitherIsDown(ctrl) then
			if #helparticlecontent > 1 then
				table.remove(helparticlecontent, helpeditingline)
			else
				helparticlecontent[helpeditingline] = ""
			end
			if keyboard_eitherIsDown("shift") then
				helpeditingline = math.max(helpeditingline - 1, 1)
			else
				if helpeditingline > #helparticlecontent and helpeditingline > 1 then
					helpeditingline = helpeditingline - 1
				end
			end
			input = anythingbutnil(helparticlecontent[helpeditingline])
			input_r = ""
		end
	elseif key == "up" or key == "down" then
		local new = helparticle
		repeat
			if key == "up" then
				new = revcycle(new, #helppages, 1)
			else
				new = cycle(new, #helppages, 1)
			end
		until helppages[new] == nil or helppages[new].cont ~= "" or new == helparticle
		gotohelparticle(new)
	elseif table.contains({"home", "end"}, key) then
		handle_scrolling(true, key)
	end
end
