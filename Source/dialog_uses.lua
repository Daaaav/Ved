-- Some forms are tables directly, some are functions returning tables (those are prefixed _make).
dialog.form = {}

function dialog.form.save_make()
	return {
		{"filename", 0, 1, 40, (editingmap ~= "untitled\n" and editingmap or "")},
		{"title", 0, 4, 40, metadata.Title},
	}
end

function dialog.form.simplename_make(default)
	return {
		{"name", 0, 1, 40, default},
	}
end

function dialog.form.exportmap_make()
	local co = not s.coords0 and 1 or 0 -- coordoffset

	-- Top left / width & height / bottom right is three things on one line,
	-- calculate how we should space it.
	local spacing = (47 - font8:getWidth(L.TOPLEFT)/8 - font8:getWidth(L.WIDTHHEIGHT)/8 - font8:getWidth(L.BOTTOMRIGHT)/8) / 2
	local wh_pos = font8:getWidth(L.TOPLEFT)/8 + round(spacing)
	local br_pos = 46 - font8:getWidth(L.BOTTOMRIGHT)/8

	return {
		{"", 0, 0, 40, L.MAPRESOLUTION, 2},
		{
			"resolution", 0, 1, 30, -1, 1,
			map_resolutions_labels, map_resolutions_numbertolabel,
			function(picked)
				return map_resolutions_labeltonumber[picked]
			end
		},
		{
			"res_label", 33, 1, 12,
			function(_, fields)
				local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)
				if fields.resolution == -1 then
					return 640*mapscale*w .. "x" .. 480*mapscale*h
				end
				return 320*fields.resolution*w .. "x" .. 240*fields.resolution*h
			end, 2
		},
		{"", 0, 3, 40, L.TOPLEFT, 2},
		{"", wh_pos, 3, 40, L.WIDTHHEIGHT, 2},
		{"x1", 0, 4, 3, co},
		{"", 3, 4, 1, ",", 2},
		{"y1", 4, 4, 3, co},
		{"w", wh_pos, 4, 3, metadata.mapwidth},
		{"h", wh_pos+4, 4, 3, metadata.mapheight},
		{"", br_pos, 3, 40, L.BOTTOMRIGHT, 2},
		{
			"bottomright_label", br_pos, 4, 40,
			function(_, fields)
				local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)
				return x2 .. "," .. y2
			end, 2
		},
		{"transparentbg", 0, 7, 2+font8:getWidth(L.TRANSPARENTMAPBG)/8, false, 3},
		{"", 2, 7, 40, L.TRANSPARENTMAPBG, 2},
		{"keepdialogopen", 0, 15, 2+font8:getWidth(L.KEEPDIALOGOPEN)/8, false, 3},
		{"", 2, 15, 40, L.KEEPDIALOGOPEN, 2},
	}
end

--function dialog.form.

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

		if not savedsuccess then
			-- Why not :c
			dialog.create(L.SAVENOSUCCESS .. anythingbutnil(savederror))
		else
			editingmap = fields.filename
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

function dialog.callback.newscript_validate(button, fields, identifier)
	if button == DB.OK and scripts[fields.name] ~= nil then
		-- Script already exists
		dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
		return true
	end
end

function dialog.callback.newscript(button, fields, identifier, notclosed)
	-- Old question IDs:
	--  9: new script (list)
	-- 11: new script (editor)
	-- 21: split      (editor)
	-- 22: duplicate  (list)
	if notclosed then
		-- Already errored because script already exists
		return
	end

	if button ~= DB.OK then
		-- Not pressing OK
		if identifier == "newscript_editor" or identifier == "split_editor" then
			-- We were already editing a script so re-enable input for that!
			takinginput = true
		end
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

function dialog.callback.changeflagname_validate(button, fields)
	if button == DB.OK then
		local problem = flagname_check_problem(fields.name, flgnum)

		if problem ~= nil then
			dialog.create(problem)
			return true
		end
	end
end

function dialog.callback.changeflagname(button, fields, _, notclosed)
	if notclosed then
		return
	end

	if button == DB.OK then
		-- Give a name to this flag, but first check if we actually have vedmetadata
		if vedmetadata == false then
			vedmetadata = createmde()
		end

		vedmetadata.flaglabel[flgnum] = fields.name

		-- This is a change!
		dirty()

		-- Refresh the state so it shows the correct label now
		loadstate(state)
	end
end

function dialog.callback.mapexport_validate(button, fields, identifier)
	if button == DB.SAVE then
		local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)

		-- Check if we're gonna exceed the max texture size... Unless you're on 0.9.0, update.
		if love_version_meets(9,1) then
			local sizelimit = love.graphics.getSystemLimit("texturesize")
			local w_size, h_size

			if fields.resolution == -1 then
				w_size, h_size = 640*mapscale*w, 480*mapscale*h
			else
				w_size, h_size = 320*fields.resolution*w, 240*fields.resolution*h
			end

			if w_size > sizelimit or h_size > sizelimit then
				dialog.create(
					langkeys(L.MAXTEXTURESIZE, {w_size, h_size, sizelimit})
					.. "\n\n\n" .. renderer_info_string()
				)
				return true
			end
		end

		-- So is everything done?
		for mry = y1, y2 do
			for mrx = x1, x2 do
				if not rooms_map[mry][mrx].done then
					dialog.create(L.MAPINCOMPLETE)
					return true
				end
			end
		end

		-- Maybe we always want it left open?
		if fields.keepdialogopen then
			-- Let's also lie to the handler function, it was actually closed.
			dialog.callback.mapexport(button, fields, identifier, false)
			return true
		end
	end
end

function dialog.callback.mapexport(button, fields, _, notclosed)
	if notclosed then
		-- If an error occured, then this will be true.
		-- If we checked "Keep dialog open", then the validator will make this false.
		return
	end

	if button == DB.SAVE then
		local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)

		map_export(x1, y1, w, h, tonumber(fields.resolution), fields.transparentbg)
	end
end
