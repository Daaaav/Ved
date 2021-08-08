function love.textinput(char)
	if focusregainedtimer < .1 or textinput_started_timer < .1 then
		return
	end

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		local id = newinputsys.getfocused()
		if newinputsys.hex[id] ~= nil then
			if table.contains({" ", "space"}, char) then -- I'd rather check the Spacebar key than the Space char, but y'know
				local oldstate = {newinputsys.getstate(id)}
				newinputsys.finishhex(id)
				newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
			else
				newinputsys.inserthexchars(id, char)
			end
		else
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.selpos[id] ~= nil then
				newinputsys.delseltext(id)
			end
			newinputsys.insertchars(id, char)
			newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
		end
	end

	-- Textual input isn't needed with a dialog on the screen, we have dialog fields
	if takinginput and not dialog.is_open() then
		-- Ugly, but at least won't need another global variable that appears here and there
		if (state == 1) and not nodialog and editingroomname and (char:lower() == "e") then
		elseif (state == 1) and holdingzvx then
			-- TODO Remove at least this branch when tool overhaul, needed for upside down terminal
			-- Just for grepping if holdingzvx doesn't do: selectedtool selectedsubtool
		elseif (state == 3) and not nodialog and (char == "/" or char == "?") then
		-- Pipes are newlines in scripts (on PC at least)
		elseif (state == 3) and char == "|" then
			table.insert(scriptlines, editingline+1, "")
			editingline = editingline + 1
			input = anythingbutnil(scriptlines[editingline])
		else
			input = input .. char
		end

		cursorflashtime = 0

		if state == 3 then
			scriptlines[editingline] = input
			-- nodialog as a temp global var is checked here too
			if nodialog then
				dirty()
			elseif table.contains({"/", "?"}, char) then
				nodialog = true
			end
		elseif state == 15 and helpeditingline ~= 0 then
			helparticlecontent[helpeditingline] = input
		elseif state == 6 then
			tabselected = 0
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf, cftype = dialogs[#dialogs].currentfield
		if dialogs[#dialogs].fields[cf] ~= nil then
			-- Input boxes can also have their type set to nil and default to 0
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][DFP.T])
		end
		if cf ~= 0 and cftype == DF.TEXT then
			dialogs[#dialogs].fields[cf][DFP.VALUE] = dialogs[#dialogs].fields[cf][DFP.VALUE] .. char
		end

		cursorflashtime = 0
	end

	if coordsdialog.active then
		coordsdialog.type(char)
	end

	if coordsdialog.active or RCMactive or dialog.is_open() or playtesting_askwherestart then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].textinput ~= nil then
		uis[state].textinput(char)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, char)
			if e.textinput ~= nil then
				e:textinput(char)
			end
		end
		for k,v in pairs(uis[state].elements) do
			caller(v, char)
			if v.recurse ~= nil then
				v:recurse("textinput", caller, char)
			end
		end
	end
end
