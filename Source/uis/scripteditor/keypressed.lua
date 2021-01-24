-- scripteditor/keypressed

return function(key)
	if key == "up" or key == "down" or key == "pageup" or key == "pagedown" then
		if keyboard_eitherIsDown(ctrl) and keyboard_eitherIsDown("alt") then
			inplacescroll(key)
		elseif key == "up" then
			scriptgotoline(editingline-1)
		elseif key == "down" then
			scriptgotoline(editingline+1)
		elseif key == "pageup" then
			scriptgotoline(editingline-57)
		elseif key == "pagedown" then
			scriptgotoline(editingline+57)
		end
	elseif table.contains({"return", "kpenter"}, key) then
		-- We can split lines because the current line is in input and input_r.
		-- So input_r is simply transferred to the newly inserted line along with the cursor.
		table.insert(scriptlines, editingline+1, "")
		editingline = editingline + 1
		input = anythingbutnil(scriptlines[editingline])
		dirty()
		-- We also want to scroll the screen if necessary
		scriptlineonscreen()
	elseif key == "f1" then
		tostate(15)
	elseif key == "f3" then
		inscriptsearch(scriptsearchterm)
	elseif keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("alt") then
		local temp_jumped_lr = false
		if key == "left" and #scripthistorystack > 0 then
			editorjumpscript(scripthistorystack[#scripthistorystack][1], true, scripthistorystack[#scripthistorystack][2])
			temp_jumped_lr = true
		elseif key == "right" and (context == "flagscript" or context == "crewmatescript") and carg2 ~= nil and carg2 ~= "" and not scriptinstack(carg2) then
			editorjumpscript(carg2)
			temp_jumped_lr = true
		elseif key == "right" and context == "script" and not scriptinstack(carg1) then
			editorjumpscript(carg1)
			temp_jumped_lr = true
		elseif key == "right" and context == "roomscript" and not scriptinstack(carg3) then
			editorjumpscript(carg3)
			temp_jumped_lr = true
		elseif not keyboard_eitherIsDown(ctrl) then
			-- Temporary catch while both ctrl/alt+left/right are possible, from here on only ctrl
		elseif key == "c" then
			copyscriptline()
		elseif key == "a" then
			copyscript()
		elseif key == "f" then
			startinscriptsearch()
		elseif key == "g" then
			startscriptgotoline()
		elseif key == "i" then
			if keyboard_eitherIsDown("shift") then
				if internalscript then
					internalscript = false
				elseif cutscenebarsinternalscript then
					internalscript = true
					cutscenebarsinternalscript = false
				else
					cutscenebarsinternalscript = true
				end
			else
				if internalscript then
					internalscript = false
					cutscenebarsinternalscript = true
				elseif cutscenebarsinternalscript then
					internalscript = false
					cutscenebarsinternalscript = false
				else
					internalscript = true
				end
			end
			dirty()
		elseif key == "d" then
			if #scriptlines > 1 then
				table.remove(scriptlines, editingline)
			else
				scriptlines[editingline] = ""
			end
			if keyboard_eitherIsDown("shift") then
				editingline = math.max(editingline - 1, 1)
			else
				if editingline > #scriptlines and editingline > 1 then
					editingline = editingline - 1
				end
			end
			input = anythingbutnil(scriptlines[editingline])
			input_r = ""
			dirty()
		end

		if temp_jumped_lr and not keyboard_eitherIsDown("alt") then
			show_notification(L.OLDSHORTCUT_SCRIPTJUMP)
		end
	elseif key == "tab" then
		matching = {}

		for k,v in pairs(knowncommands) do
			if k:sub(1, input:len()) == input then
				table.insert(matching, k)
			end
		end
		for k,v in pairs(knowninternalcommands) do
			if k:sub(1, input:len()) == input and not table.contains(matching, k) then
				table.insert(matching, k)
			end
		end

		if #matching == 1 then
			input = matching[1]
			scriptlines[editingline] = input
			dirty()
		end
	elseif key == "escape" then
		leavescript_to_state = function()
			stopinput()
			scriptlines[editingline] = input
			scripts[scriptname] = table.copy(scriptlines)
			if scriptfromsearch then
				resume_search = true
				tostate(11)
			else
				tostate(10)
			end
			nodialog = false
		end

		if not processflaglabelsreverse() then
			leavescript_to_state()
		end
	end
end
