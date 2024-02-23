function love.keypressed(key)
	if focus_regained_timer < .1 then
		if not table.contains(skip_next_keys, key) then
			table.insert(skip_next_keys, key)
		end
		return
	end

	hook("love_keypressed_start", {key})

	-- It's not really a secret that you can use the konami code in the help pages to make them editable in-place, that's useful for translators.
	konami.keypressed(key)

	-- DEBUG FOR FPS CAP
	if allowdebug and key == "pagedown" and love.keyboard.isDown(rctrl) then
		s.fpslimit_ix = (s.fpslimit_ix % 4) + 1
	elseif allowdebug and key == "pageup" and love.keyboard.isDown(rctrl) then
		debug.debug()
	end

	if key == "escape" then
		RCMactive = false
	end

	if newinputsys.active and newinputsys.getfocused() ~= nil then
		local id = newinputsys.getfocused()
		local multiline = type(inputs[id]) == "table"

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown", "delete"}, key) or keyboard_eitherIsDown(ctrl, modifier) or isclear(key) then
			newinputsys.stophex(id)
		end

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown"}, key) or isclear(key) then
			if #newinputsys.undostack[id] > 0 then
				newinputsys.undostack[id][#newinputsys.undostack[id]].group = nil
			end
		end

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown"}, key) then
			if keyboard_eitherIsDown("shift") and not keyboard_eitherIsDown("alt") then
				if newinputsys.selpos[id] == nil then
					newinputsys.setselpos(id)
				end
			else
				newinputsys.clearselpos(id)
			end
		end

		if key == "left" and not keyboard_eitherIsDown("alt") then
			if keyboard_eitherIsDown(modifier) then
				newinputsys.movexwords(id, -1)
			else
				newinputsys.movex(id, -1)
			end
		elseif key == "right" and not keyboard_eitherIsDown("alt") then
			if keyboard_eitherIsDown(modifier) then
				newinputsys.movexwords(id, 1)
			else
				newinputsys.movex(id, 1)
			end
		elseif key == "up" and not keyboard_eitherIsDown("alt") then
			newinputsys.movey(id, -1)
		elseif key == "down" and not keyboard_eitherIsDown("alt") then
			newinputsys.movey(id, 1)
		elseif key == "home" then
			newinputsys.leftmost(id)
		elseif key == "end" then
			newinputsys.rightmost(id)
		elseif key == "pageup" then
			-- Hardcoded (and pagedown is too)
			-- unless there's big multiline inputs other than the script and article editors
			-- and they aren't 57 lines tall
			newinputsys.movey(id, -57)
		elseif key == "pagedown" then
			newinputsys.movey(id, 57)
		elseif (table.contains({"backspace", "delete"}, key) or isclear(key)) and newinputsys.selpos[id] ~= nil then
			newinputsys.atomicdelete(id)
		elseif key == "backspace" then
			if newinputsys.hex[id] ~= nil then
				newinputsys.deletehexchars(id, 1)
			else
				local oldstate = {newinputsys.getstate(id)}
				if keyboard_eitherIsDown(modifier) then
					newinputsys.deletewords(id, -1)
				else
					newinputsys.deletechars(id, -1)
				end
				newinputsys.unre(id, UNRE.DELETE, unpack(oldstate))
			end
		elseif key == "delete" then
			local oldstate = {newinputsys.getstate(id)}
			if keyboard_eitherIsDown(modifier) then
				newinputsys.deletewords(id, 1)
			else
				newinputsys.deletechars(id, 1)
			end
			newinputsys.unre(id, UNRE.DELETE, unpack(oldstate))
		elseif table.contains({"return", "kpenter"}, key) then
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.hex[id] ~= nil then
				newinputsys.finishhex(id)
			else
				if newinputsys.selpos[id] ~= nil then
					newinputsys.delseltext(id)
				end
				newinputsys.newline(id)
			end
			newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
		elseif table.contains({"x", "c"}, key) and keyboard_eitherIsDown(ctrl) and newinputsys.selpos[id] ~= nil and not love.mouse.isDown("l") then
			newinputsys.atomiccopycut(id, key == "x")
		elseif key == "v" and keyboard_eitherIsDown(ctrl) then
			newinputsys.atomicpaste(id)
		elseif key == "a" and keyboard_eitherIsDown(ctrl) then
			if keyboard_eitherIsDown("shift") then
				newinputsys.selallleft(id)
			else
				newinputsys.selallright(id)
			end
		elseif table.contains({"u", "k"}, key) and keyboard_eitherIsDown(ctrl) then
			if key == "u" and keyboard_eitherIsDown("shift") then
				newinputsys.starthex(id)
			else
				local oldstate = {newinputsys.getstate(id)}
				if newinputsys.selpos[id] ~= nil then
					newinputsys.delseltext(id)
				else
					if key == "u" then
						newinputsys.deltoleftmost(id)
					elseif key == "k" then
						newinputsys.deltorightmost(id)
					end
				end
				newinputsys.unre(id, nil, unpack(oldstate))
			end
		elseif key == "d" and keyboard_eitherIsDown(ctrl) then
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.selpos[id] ~= nil then
				newinputsys.delseltext(id)
			else
				if keyboard_eitherIsDown("shift") then
					newinputsys.removelines(id, -1)
				else
					newinputsys.removelines(id, 1)
				end
			end
			newinputsys.unre(id, nil, unpack(oldstate))
		elseif key == "l" and keyboard_eitherIsDown(ctrl) then
			if keyboard_eitherIsDown("shift") then
				newinputsys.sellinetoleft(id)
			else
				newinputsys.sellinetoright(id)
			end
		elseif key == "z" and keyboard_eitherIsDown(ctrl) then
			newinputsys.undo(id)
		elseif key == "y" and keyboard_eitherIsDown(ctrl) then
			newinputsys.redo(id)
		elseif table.contains({"up", "down"}, key) and keyboard_eitherIsDown("alt") and multiline then
			if keyboard_eitherIsDown("shift") then
				newinputsys.atomicdupeline(id, key == "down")
			else
				if key == "up" then
					newinputsys.atomicmovevertical(id, -1)
				elseif key == "down" then
					newinputsys.atomicmovevertical(id, 1)
				end
			end
		end
	end

	if coordsdialog.active and key == "backspace" then
		coordsdialog.input = coordsdialog.input:sub(1, -2)
	elseif takinginput and nodialog then
		if key == "backspace" then
			input = backspace(input)

			if state == 15 then
				-- We're checking for the not-yet-changed line, hence why this doesn't cause the exact same backspace problem VVVVVV has
				if helparticlecontent[helpeditingline] == "" and helpeditingline ~= 1 then
					table.remove(helparticlecontent, helpeditingline)
					helpeditingline = helpeditingline - 1
					input = anythingbutnil(helparticlecontent[helpeditingline])
				else
					helparticlecontent[helpeditingline] = input
				end
			elseif state == 6 and nodialog then
				tabselected = 0
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("v") then
			input = input .. love.system.getClipboardText()

			if state == 15 then
				if input:find("\n") then
					-- CRLF -> LF
					local inputparts = explode("\n", input:gsub("\r\n", "\n"))

					helparticlecontent[helpeditingline] = inputparts[1]

					for k = 2, #inputparts do
						table.insert(helparticlecontent, helpeditingline+(k-1), inputparts[k])
					end

					helpeditingline = helpeditingline + #inputparts - 1
					input = anythingbutnil(helparticlecontent[helpeditingline])
				else
					helparticlecontent[helpeditingline] = input
				end
			elseif state == 6 then
				tabselected = 0
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("u") then
			-- If you use Linux you may like this shortcut!
			input = ""

			if state == 15 then
				helparticlecontent[helpeditingline] = input
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("k") then
			-- If you like symmetry and use Linux you may like this shortcut too
			input_r = ""
		elseif key == "left" and not keyboard_eitherIsDown(ctrl) then
			input, input_r = leftspace(input, input_r)

			cursorflashtime = 0

			if state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "right" and not keyboard_eitherIsDown(ctrl) then
			input, input_r = rightspace(input, input_r)

			cursorflashtime = 0

			if state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "home" then
			input_r = anythingbutnil(input) .. anythingbutnil(input_r)
			input = ""

			cursorflashtime = 0

			if state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "end" then
			input = anythingbutnil(input) .. anythingbutnil(input_r)
			input_r = ""

			cursorflashtime = 0

			if state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "delete" then
			_, input_r = rightspace(input, input_r)

			if state == 15 then
				if input_r == "" and helpeditingline < #helparticlecontent then
					input_r = anythingbutnil(helparticlecontent[helpeditingline + 1])
					table.remove(helparticlecontent, helpeditingline + 1)
				end
			--elseif state == 6 then
				--tabselected = 0
			-- DO NOT UNCOMMENT THE ABOVE:
			-- If you do, the Delete key will no longer be able to
			-- remove levels from the recently opened level list if
			-- you tab over to them
			end
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf = dialogs[#dialogs].currentfield
		local cftype
		if dialogs[#dialogs].fields[cf] ~= nil then
			-- Input boxes can also have their type set to nil and default to 0
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][DFP.T])
		end
		if cf ~= 0 and cftype == DF.TEXT then
			if key == "backspace" then
				dialogs[#dialogs].fields[cf][DFP.VALUE] = backspace(dialogs[#dialogs].fields[cf][DFP.VALUE])
			elseif key == "delete" then
				_, dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = rightspace(dialogs[#dialogs].fields[cf][DFP.VALUE], dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R])
			elseif keyboard_eitherIsDown(ctrl) and key == "v" then
				dialogs[#dialogs].fields[cf][DFP.VALUE] = dialogs[#dialogs].fields[cf][DFP.VALUE] .. love.system.getClipboardText():gsub("[\r\n]", "")
			elseif keyboard_eitherIsDown(ctrl) and key == "u" then
				dialogs[#dialogs].fields[cf][DFP.VALUE] = ""
			elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("k") then
				dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = ""
			elseif key == "left" then
				dialogs[#dialogs].fields[cf][DFP.VALUE], dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = leftspace(dialogs[#dialogs].fields[cf][DFP.VALUE], anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R]))
				cursorflashtime = 0
			elseif key == "right" then
				dialogs[#dialogs].fields[cf][DFP.VALUE], dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = rightspace(dialogs[#dialogs].fields[cf][DFP.VALUE], anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R]))
				cursorflashtime = 0
			elseif key == "home" then
				dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = anythingbutnil(dialogs[#dialogs].fields[cf][DFP.VALUE]) .. anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R])
				dialogs[#dialogs].fields[cf][DFP.VALUE] = ""
				cursorflashtime = 0
			elseif key == "end" then
				dialogs[#dialogs].fields[cf][DFP.VALUE] = anythingbutnil(dialogs[#dialogs].fields[cf][DFP.VALUE]) .. anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R])
				dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = ""
				cursorflashtime = 0
			end
		end
		if key == "tab" then
			dialogs[#dialogs].showtabrect = true
			RCMactive = false
			cursorflashtime = 0
			if cftype == DF.TEXT then
				dialogs[#dialogs].fields[cf][DFP.VALUE] = anythingbutnil(dialogs[#dialogs].fields[cf][DFP.VALUE]) .. anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R])
				dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R] = ""
			end

			local reverse = keyboard_eitherIsDown("shift")
			local new_field, looped = cf, 0
			while true do
				if reverse then
					if new_field <= 1 then
						new_field = #dialogs[#dialogs].fields
						looped = looped + 1
					else
						new_field = new_field - 1
					end
				else
					if new_field >= #dialogs[#dialogs].fields then
						new_field = 1
						looped = looped + 1
					else
						new_field = new_field + 1
					end
				end

				if looped >= 2 then
					-- Don't keep looping around forever
					new_field = cf
					break
				end

				if dialogs[#dialogs].fields[new_field] ~= nil and
				dialogs[#dialogs].fields[new_field][DFP.T] ~= DF.LABEL and
				dialogs[#dialogs].fields[new_field][DFP.T] ~= DF.HIDDEN then
					-- Only text labels and hidden fields are skipped
					break
				end
			end
			dialogs[#dialogs].currentfield = new_field
		end
		if cftype == DF.CHECKBOX and (key == " " or key == "space") then
			dialogs[#dialogs].showtabrect = true

			local new_value = not dialogs[#dialogs].fields[cf][DFP.VALUE]
			dialogs[#dialogs].fields[cf][DFP.VALUE] = new_value

			if dialogs[#dialogs].fields[cf][DFP.CHECKBOX_ONCHANGE] ~= nil then
				dialogs[#dialogs].fields[cf][DFP.CHECKBOX_ONCHANGE](new_value, dialogs[#dialogs])
			end
		elseif (cftype == DF.DROPDOWN or cftype == DF.RADIOS) and (key == "up" or key == "down" or key == "kp8" or key == "kp2") then
			dialogs[#dialogs].showtabrect = true
			RCMactive = false

			local dropdown = 0
			local cfinput = dialogs[#dialogs].fields[cf][DFP.VALUE]
			local dropdowns = dialogs[#dialogs].fields[cf][DFP.DROPDOWN_MENUITEMS]
			local mapping = dialogs[#dialogs].fields[cf][DFP.DROPDOWN_MENUITEMSLABEL]
			local usethisvalue
			if mapping ~= nil then
				usethisvalue = mapping[cfinput]
			else
				usethisvalue = cfinput
			end

			for k,v in pairs(dropdowns) do
				if v == usethisvalue then
					dropdown = k
					break
				end
			end
			if key == "up" or key == "kp8" then
				dropdown = dropdown - 1
				if dropdown < 1 then
					dropdown = #dropdowns
				end
			end
			if key == "down" or key == "kp2" then
				dropdown = dropdown + 1
				if dropdown > #dropdowns then
					dropdown = 1
				end
			end

			dialogs[#dialogs]:dropdown_onchange(dialogs[#dialogs].fields[cf][DFP.KEY], dropdowns[dropdown])
		elseif cftype == DF.FILES and (key == "backspace" or key == "up" or key == "kp8" or key == "down" or key == "kp2" or key == " " or key == "space") then
			dialogs[#dialogs].showtabrect = true

			local files = dialogs[#dialogs].fields[cf][DFP.FILES_MENUITEMS]
			local file = 0
			local filled_name = dialogs[#dialogs]:return_fields().name
			for k,v in pairs(files) do
				if v.name == filled_name then
					file = k
					break
				end
			end

			if key == "backspace" then
				dialogs[#dialogs]:cd_to_parent(cf, dialogs[#dialogs].fields[cf][DFP.VALUE], unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf]))
				dialogs[#dialogs]:set_field("name", "")
			elseif key == "up" or key == "kp8" or key == "down" or key == "kp2" then
				local menuitems, folder_filter, folder_show_hidden, listscroll, folder_error, list_height, filter_on = unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf])
				local real_x = dialogs[#dialogs].x+10+dialogs[#dialogs].fields[cf][DFP.X]*8
				local real_y = dialogs[#dialogs].y+dialogs[#dialogs].windowani+10+dialogs[#dialogs].fields[cf][DFP.Y]*12 + 1
				local real_w = dialogs[#dialogs].fields[cf][DFP.W]*8

				if key == "up" or key == "kp8" then
					file = file - 1
					if file < 1 then
						file = #files
					end
				end
				if key == "down" or key == "kp2" then
					file = file + 1
					if file > #files then
						file = 1
					end
				end

				dialogs[#dialogs]:set_field("name", anythingbutnil(files[file]).name)

				if 12*file - 12 < math.abs(listscroll) then
					dialogs[#dialogs].fields[cf][DFP.FILES_LISTSCROLL] = -12*file + 12
				elseif 12*file - 12 > math.abs(listscroll) + 12*list_height - 12 then
					dialogs[#dialogs].fields[cf][DFP.FILES_LISTSCROLL] = -12*file + 12*list_height
				end
			elseif (key == " " or key == "space") and files[file] ~= nil and files[file].isdir then
				dialogs[#dialogs]:cd(files[file].name, cf, dialogs[#dialogs].fields[cf][DFP.VALUE], unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf]))
				dialogs[#dialogs]:set_field("name", "")
			end
		end
	end

	handle_scrolling(true, key)


	if dialog.is_open() then
		dialogs[#dialogs]:keypressed(key)
		return
	elseif allowdebug and (key == "f11") then
		if love.keyboard.isDown(lctrl) then
			cons("You pressed L" .. ctrl .. "+F11, you get a wall.\n\n***********************************\n* G L O B A L   V A R I A B L E S *\n***********************************\n")
			for k,v in pairs(_G) do
				if type(v) == "boolean" then
					print(k .. " = " .. (v and "true" or "false") .. "\t\t\t[boolean]")
				elseif type(v) == "userdata" and v.type ~= nil and type(v.type) == "function" then
					-- LÖVE object
					print(k .. "\t\t\t[" .. v:type() .. "]")
				elseif table.contains({"function", "table", "userdata", "cdata"}, type(v)) then
					print(k .. "\t\t\t[" .. type(v) .. "]")
				else
					print(k .. " = " .. tostring(v) .. "\t\t\t[" .. type(v) .. "]")
				end
			end
			cons("\n***********************************\n* E N D                           *\n***********************************\n")
		end
	elseif allowdebug and (key == "f12") then
		tostate(0)
	end

	if RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].keypressed ~= nil then
		uis[state].keypressed(key)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, key)
			if e.keypressed ~= nil then
				e:keypressed(key)
			end
		end
		for k,v in elements_iter(uis[state].elements) do
			caller(v, key)
			if v.recurse ~= nil then
				v:recurse("keypressed", caller, key)
			end
		end
	end
end
