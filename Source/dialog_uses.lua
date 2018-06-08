-- Some forms are tables directly, some are functions returning tables (those are prefixed _make).
dialog.form = {}

function dialog.form.save_make()
	return {
		{"filename", 0, 1, 40, (editingmap ~= "untitled\n" and editingmap or "")},
		{"title", 0, 4, 40, metadata.Title},
	}
end

-- 
dialog.form.simplename = {
	{"name", 0, 1, 40, ""},
}

dialog.callback = {}
dialog.callback.noclose_on = {}

function dialog.callback.noclose_on.save(button)
	if button == DB.SAVE then
		return true
	end
end

function dialog.callback.surequit(button)
	if button == DB.SAVE then
		dialog.create(
			L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, DBS.OKCANCEL,
			dialog.callback.savequit, nil, dialog.form.save_make(), nil, "quit"
		)
	elseif button == DB.DISCARD then
		no_more_quit_dialog = true
		love.event.quit()
	end
end

function dialog.callback.surenewlevel(button)
	if button == DB.SAVE then
		dialog.create(
			L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, DBS.OKCANCEL,
			dialog.callback.savenewlevel, nil, dialog.form.save_make(), nil
		)
	elseif button == DB.DISCARD then
		triggernewlevel()
	end
end

function dialog.callback.save(button, fields)
	if button == DB.OK then
		-- Save the level with this name. But first apply the title!
		local oldtitle = metadata.Title
		metadata.Title = fields.title

		if metadata.Title ~= oldtitle then
			table.insert(undobuffer, {undotype = "metadata", changedmetadata = {
						{
							key = "Title",
							oldvalue = oldtitle,
							newvalue = metadata.Title
						}
					}
				}
			)
			finish_undo("TITLE WHEN SAVING")
		end

		savedsuccess, savederror = savelevel(fields.filename .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, false)
		editingmap = fields.filename

		if not savedsuccess then
			-- Why not :c
			dialog.create(L.SAVENOSUCCESS .. anythingbutnil(savederror))
		end
	end
end

function dialog.callback.savequit(button, fields)
	dialog.callback.save(button, fields)

	if not has_unsaved_changes() then
		love.event.quit()
	end
end

function dialog.callback.savenewlevel(button, fields)
	dialog.callback.save(button, fields)

	if button == DB.OK and not has_unsaved_changes() then
		dialogs[#dialogs]:press_button(0)
		triggernewlevel()
	end
end

function dialog.callback.newscript(button, fields, identifier)
	-- Old question IDs:
	--  9: new script (list)
	-- 11: new script (editor)
	-- 21: split      (editor)
	-- 22: duplicate  (list)
	if button ~= DB.OK then
		-- Not pressing OK
		if identifier == "newscript_editor" or identifier == "split_editor" then
			-- We were already editing a script so re-enable input for that!
			takinginput = true
		end
		return
	end

	if scripts[fields.name] ~= nil then
		-- Script already exists
		dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
		return
	end

	-- Add a script with this name. In case we're making a new script while editing one already that uses
	-- an unused flag name and all flags are occupied, make this all a function.

	leavescript_to_state = function()
		if identifier == "newscript_editor" then -- making new script from editor, not in script list
			-- We're currently already editing a script so save that before jumping to a new one!
			scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
			scripts[scriptname] = table.copy(scriptlines)
		elseif identifier == "split_editor" then
			-- Splitting a script, but we already saved the input earlier
			scripts[scriptname] = table.copy(scriptlines)
		end

		if scripts[fields.name] == nil then
			table.insert(scriptnames, fields.name)
			if identifier ~= "split_editor" and identifier ~= "duplicate_list" then
				-- Creating an empty script
				scripts[fields.name] = {""}

				scriptlines = {""}

				-- Also make sure internal scripting mode doesn't stick
				internalscript = false
			else
				-- Splitting/duplicating the current script
				local keepinternal
				if identifier == "split_editor" then
					-- Splitting, meaning in editor
					scripts[fields.name] = originalscript -- We now have a duplicate. Might as well leave this as a reference.

					-- Now cut off the top part of the new script
					for i = 1, spl_originaleditingline-1 do
						table.remove(scripts[fields.name], 1)
					end

					-- Oh, was the script an internal script by the way?
					keepinternal = internalscript
				else
					-- Duplicating, meaning in menu
					input = tonumber(input)
					scripts[fields.name] = table.copy(scripts[scriptnames[input]])
				end

				scriptlines = table.copy(scripts[fields.name])

				processflaglabels()
				if identifier == "split_editor" then
					-- Splitting
					internalscript = keepinternal
				end
			end
			scriptname = fields.name
			tostate(3)
		end
	end

	if identifier == "split_editor" then
		-- Splitting
		scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
		spl_originaleditingline = editingline
		editingline = 1
		input, input_r = scriptlines[1], ""
		originalscript = table.copy(scriptlines) -- We need to have the unconverted version
		local totalnumberlines = #scriptlines

		-- Before we save the current (possibly internal) script, split the contents of the old script.
		for i = spl_originaleditingline, totalnumberlines do
			table.remove(scriptlines)
		end
	end

	if (identifier ~= "newscript_editor" and identifier ~= "split_editor") or (not processflaglabelsreverse()) then
		leavescript_to_state()
	end

	dirty()
end

function dialog.callback.newscript_noclose(button, fields, identifier)
	if button == DB.OK and scripts[fields.name] ~= nil then
		return true
	end
end
