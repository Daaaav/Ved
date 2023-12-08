-- levelslist/keypressed

return function(key)
	if key == "n" and keyboard_eitherIsDown(ctrl) then
		-- New level?
		if not state6old1 then
			levelslist_close_input()
			triggernewlevel()
			-- Don't immediately trigger the dialog in state 1!
			nodialog = false
		elseif has_unsaved_changes() then
			-- Else block also runs if state == 6 and state6old1, and thus makes a dialog appear; hey a free feature!
			dialog.create(
				L.SURENEWLEVELNEW, DBS.SAVEDISCARDCANCEL,
				dialog.callback.surenewlevel, nil, nil,
				dialog.callback.noclose_on_make(DB.SAVE)
			)
		else
			triggernewlevel()
		end
	elseif key == "f11" and temporaryroomnametimer == 0 and not keyboard_eitherIsDown(ctrl) then
		user_reload_tilesets()
	elseif key == "f1" then
		tostate(15)
	elseif table.contains({"return", "kpenter"}, key) and tabselected == 0 then
		state6load(inputs.levelname)
	elseif (keyboard_eitherIsDown("shift") and key == "tab") or key == "up" then
		if tabselected ~= 0 then
			tabselected = tabselected - 1
		end
	elseif key == "tab" or key == "down" then --and tabselected < #files then
		if tabselected == -1 then
			tabselected = 1
		else
			tabselected = tabselected + 1
		end
	elseif key == "escape" then
		if tabselected ~= 0 then
			tabselected = 0
		else
			if state6old1 then
				levelslist_close_input()
				tostate(1, true)
			end
		end
	elseif key == "f5" then
		loadlevelsfolder()
	elseif backupscreen and currentbackupdir ~= "" and key == "backspace" then
		currentbackupdir = ""
	elseif not secondlevel and not backupscreen and key == "r" and keyboard_eitherIsDown(ctrl) then
		tostate(30)
	elseif not secondlevel and not backupscreen and key == "f" and keyboard_eitherIsDown(ctrl) then
		explore_lvl_dir()
	elseif allowdebug and key == "f2" and keyboard_eitherIsDown("shift") then
		table.insert(files[""], {name="--[debug]--", isdir=false, bu_lastmodified=0, bu_overwritten=0, result_shown=true})
	elseif allowdebug and key == "f3" and keyboard_eitherIsDown("shift") then
		table.remove(files[""])
	end
end
