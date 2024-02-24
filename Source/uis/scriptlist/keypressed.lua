-- scriptlist/keypressed

return function(key)
	if key == "up" or key == "down" then
		handle_scrolling(false, key == "up" and "wu" or "wd") -- 16px
	elseif table.contains({"home", "end"}, key) then
		handle_scrolling(true, key)
	elseif key == "n" then
		dialog.create(
			L.NEWSCRIPTNAME, DBS.OKCANCEL,
			dialog.callback.newscript, L.CREATENEWSCRIPT, dialog.form.simplename,
			dialog.callback.newscript_validate, "newscript_list"
		)
	elseif key == "f" then
		tostate(19,false)
	elseif key == "c" then
		tostate(36)
	elseif key == "/" then
		if #scriptnames >= 1 then
			scriptineditor(scriptnames[#scriptnames], #scriptnames)
			nodialog = false -- Terrible
		end
	elseif key == "escape" then
		stopinput()
		tostate(1, true)
		nodialog = false
	end
end
