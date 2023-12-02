function generate_dropdown_tables(tuples)
	-- Converts a table with key-value tuples into the three dropdown/radio arguments as
	-- described in the technical documentation.
	-- tuples must be structured like {{0.5, "50%"}, {1, "100%"}, {2, "200%"}}

	local displaylist = {}
	local keyvalue = {}

	for _,v in pairs(tuples) do
		table.insert(displaylist, v[2])
		keyvalue[v[1]] = v[2]
	end

	return displaylist, keyvalue,
	function(picked)
		for _,v in pairs(tuples) do
			if picked == v[2] then
				return v[1]
			end
		end
	end
end

-- Some forms are tables directly, some are functions returning tables (those are prefixed _make).
dialog.form = {}

function dialog.form.save_make()
	return {
		{"filename", 0, 1, 40, (editingmap ~= "untitled\n" and editingmap or ""), DF.TEXT},
		{"", 40, 1, 7, ".vvvvvv", DF.LABEL},
		{"title", 0, 4, 20, metadata.Title, DF.TEXT},
		{"zip", 0, 12, 2+math.min(font8:getWidth(L.ZIP_SAVE_AS)/8, 46), false, DF.CHECKBOX},
		{"", 2, 12, 46, L.ZIP_SAVE_AS, DF.LABEL},
	}
end

function dialog.form.simplename_make(default)
	return {
		{"name", 0, 1, 40, default, DF.TEXT},
	}
end

function dialog.form.exportmap_make()
	local co = not s.coords0 and 1 or 0 -- coordoffset

	-- Top left / width & height / bottom right is three things on one line,
	-- calculate how we should space it.
	local spacing = (47 - font8:getWidth(L.TOPLEFT)/8 - font8:getWidth(L.WIDTHHEIGHT)/8 - font8:getWidth(L.BOTTOMRIGHT)/8) / 2
	local wh_pos = font8:getWidth(L.TOPLEFT)/8 + round(spacing)
	local br_pos = 46 - font8:getWidth(L.BOTTOMRIGHT)/8

	local map_resolutions, room_w, room_h
	if s.mapstyle == "minimap" then
		local zoom = getminimapzoom(metadata)
		room_w, room_h = 12*zoom, 9*zoom
		map_resolutions = {
			{1, langkeys(L.MAPRES_PERCENT, {100, room_w, room_h})},
			{2, langkeys(L.MAPRES_PERCENT, {200, room_w*2, room_h*2})},
			{4, langkeys(L.MAPRES_PERCENT, {400, room_w*4, room_h*4})},
			{8, langkeys(L.MAPRES_PERCENT, {800, room_w*8, room_h*8})}
		}
	elseif s.mapstyle == "vtools" then
		room_w, room_h = 40, 30
		map_resolutions = {
			{1, langkeys(L.MAPRES_PERCENT, {100, room_w, room_h})},
			{2, langkeys(L.MAPRES_PERCENT, {200, room_w*2, room_h*2})},
			{4, langkeys(L.MAPRES_PERCENT, {400, room_w*4, room_h*4})},
			{8, langkeys(L.MAPRES_PERCENT, {800, room_w*8, room_h*8})}
		}
	else
		room_w, room_h = 320, 240
		map_resolutions = {
			{-1, L.MAPRES_ASSHOWN},
			{1/8, langkeys(L.MAPRES_RATIO, {1, 8, 40, 30})},
			{1/4, langkeys(L.MAPRES_PERCENT, {25, 80, 60})},
			{1/2, langkeys(L.MAPRES_PERCENT, {50, 160, 120})},
			{1, langkeys(L.MAPRES_PERCENT, {100, 320, 240})},
			{2, langkeys(L.MAPRES_PERCENT, {200, 640, 480})}
		}
	end

	return {
		{"", 0, 0, 40, L.MAPRESOLUTION, DF.LABEL},
		{
			"resolution", 0, 1, 30, s.mapstyle == "full" and -1 or 1, DF.DROPDOWN,
			generate_dropdown_tables(map_resolutions)
		},
		{
			"res_label", 33, 1, 12,
			function(_, fields)
				local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)
				if fields.resolution == -1 then
					return 640*mapscale*w .. "x" .. 480*mapscale*h
				end
				return room_w*fields.resolution*w .. "x" .. room_h*fields.resolution*h
			end, DF.LABEL
		},
		{"", 0, 3, 40, L.TOPLEFT, DF.LABEL},
		{"", wh_pos, 3, 40, L.WIDTHHEIGHT, DF.LABEL},
		{"x1", 0, 4, 3, co},
		{"", 3, 4, 1, ",", DF.LABEL},
		{"y1", 4, 4, 3, co},
		{"w", wh_pos, 4, 3, metadata.mapwidth},
		{"h", wh_pos+4, 4, 3, metadata.mapheight},
		{"", br_pos, 3, 40, L.BOTTOMRIGHT, DF.LABEL},
		{
			"bottomright_label", br_pos, 4, 40,
			function(_, fields)
				local x1, y1, w, h, x2, y2 = fix_map_export_input(fields)
				return x2 .. "," .. y2
			end, DF.LABEL
		},
		{"transparentbg", 0, 7, 2+font8:getWidth(L.TRANSPARENTMAPBG)/8, false, DF.CHECKBOX},
		{"", 2, 7, 40, L.TRANSPARENTMAPBG, DF.LABEL},
		{"keepdialogopen", 0, 15, 2+font8:getWidth(L.KEEPDIALOGOPEN)/8, false, DF.CHECKBOX},
		{"", 2, 15, 40, L.KEEPDIALOGOPEN, DF.LABEL},
	}
end

function dialog.form.rawentityproperties_make()
	local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6"}
	local form = {}

	local row, col = 3, 0
	for k,v in pairs(entitypropkeys) do
		if v == "p1" then
			row = row+1
		end
		table.insert(form, {"", 16*col, row, 3, v, DF.LABEL})
		table.insert(form, {v, 16*col+3, row, 12, thisentity[v], DF.TEXT})
		col = col+1
		if col == 3 then
			row = row+1
			col = 0
		end
	end
	row = row+1

	local labelwidth = font8:getWidth(L.SMALLENTITYDATA)/8 + 1
	table.insert(form, {"", 0, row, labelwidth, L.SMALLENTITYDATA, DF.LABEL})
	table.insert(form, {"data", labelwidth, row, 47-labelwidth, thisentity.data, DF.TEXT})

	return form
end

function dialog.form.leveloptions_make()
	local function get_music_list(music_page)
		local music_list, music_kv = {}, {}
		for m = music_page, math.min(126, music_page+15) do
			local label
			if m <= 15 then
				label = "[" .. m .. "] " .. list_music_names[m+1]
			else
				label = "[" .. m .. "]"
			end
			table.insert(music_list, label)
			music_kv[m] = label
		end
		return music_list, music_kv
	end

	local music_page_list = {}
	local music_page_kv = {}
	local music_page_vk = {}
	local selected_page = 0
	for music_page = 0, 126, 16 do
		local label = music_page .. "-" .. math.min(126, music_page+15)
		table.insert(music_page_list, label)
		music_page_kv[music_page] = label
		music_page_vk[label] = music_page

		local levmusic = anythingbutnil0(metadata.levmusic)
		if levmusic >= music_page and levmusic <= music_page+15 then
			selected_page = music_page
		end
	end

	local main_music_list, main_music_kv = get_music_list(selected_page)

	return {
		{"", 0, 0, 8, L.OPTNAME, DF.LABEL},
		{"Title", 8, 0, 20, metadata.Title, DF.TEXT},
		{"", 0, 1, 8, L.OPTBY, DF.LABEL},
		{"Creator", 8, 1, 37, metadata.Creator, DF.TEXT},
		{"", 0, 2, 8, L.OPTWEBSITE, DF.LABEL},
		{"website", 8, 2, 40, metadata.website, DF.TEXT},
		{"", 0, 4, 8, L.OPTDESC, DF.LABEL},
		{"Desc1", 8, 4, 40, metadata.Desc1, DF.TEXT},
		{"Desc2", 8, 5, 40, metadata.Desc2, DF.TEXT},
		{"Desc3", 8, 6, 40, metadata.Desc3, DF.TEXT},
		{"", 0, 8, 8, L.OPTSIZE, DF.LABEL},
		{"mapwidth", 8, 8, 3, metadata.mapwidth, DF.TEXT},
		{"mapheight", 12, 8, 3, metadata.mapheight, DF.TEXT},
		{"", 0, 10, 8, L.OPTMUSIC, DF.LABEL},
		{
			"levmusic_page", 8, 10, 8, selected_page, DF.DROPDOWN, music_page_list, music_page_kv,
			function(picked, _, _, dialog_obj)
				local page_start = music_page_vk[picked]

				-- Modify the other dropdown lol
				for k,v in pairs(dialog_obj.fields) do
					if v[DFP.KEY] == "levmusic" then
						v[DFP.DROPDOWN_MENUITEMS], v[DFP.DROPDOWN_MENUITEMSLABEL] = get_music_list(page_start)
						v[DFP.VALUE] = page_start
					end
				end

				return page_start
			end
		},
		{
			"levmusic", 17, 10, 30, metadata.levmusic, DF.DROPDOWN, main_music_list, main_music_kv,
			function(picked, _, menuitemslabel)
				for k,v in pairs(menuitemslabel) do
					if picked == v then
						return k
					end
				end
				return 0
			end
		},
	}
end

function dialog.form.advancedleveloptions_make()
	return {
		{"", 2, 0, 46, L.ONEWAYCOL_OVERRIDE, DF.LABEL},
		{"onewaycol_override", 0, 0, 2+math.min(font8:getWidth(L.ONEWAYCOL_OVERRIDE)/8, 46), metadata.onewaycol_override, DF.CHECKBOX},
	}
end

function dialog.form.songmetadata_make(song_metadata, song)
	local name, filename, notes = "", "", ""
	if song_metadata ~= nil then
		name = song_metadata.name
		filename = song_metadata.filename
		notes = song_metadata.notes
	end

	return {
		{"", 0, 0, 40, L.MUSICTITLE, DF.LABEL},
		{"name", 0, 1, 32, name, DF.TEXT},
		{"", 0, 3, 40, L.MUSICFILENAME, DF.LABEL},
		{"filename", 0, 4, 32, filename, DF.TEXT},
		{"", 0, 6, 40, L.MUSICNOTES, DF.LABEL},
		{"notes", 0, 7, 47, notes, DF.TEXT},
		{"song", 0, 0, 0, song, DF.HIDDEN},
	}
end

function dialog.form.musicfilemetadata_make(file_metadata)
	local export_time, name, artist, notes = 0, "", "", ""
	if file_metadata ~= nil then
		export_time = file_metadata.export_time
		name = file_metadata.name
		artist = file_metadata.artist
		notes = file_metadata.notes
	end

	return {
		{"", 0, 0, 40, L.MUSICTITLE, DF.LABEL},
		{"name", 0, 1, 32, name, DF.TEXT},
		{"", 0, 3, 40, L.MUSICARTIST, DF.LABEL},
		{"artist", 0, 4, 32, artist, DF.TEXT},
		{"", 0, 6, 40, L.MUSICNOTES, DF.LABEL},
		{"notes", 0, 7, 47, notes, DF.TEXT},
		{"", 0, 15, 30, L.MUSICEXPORTEDON .. "\n" .. format_date(export_time), DF.LABEL}
	}
end

function dialog.form.savevvvvvvmusic_make(startfolder, defaultname)
	local form = dialog.form.files_make(startfolder, defaultname, ".vvv", true, 9)
	table.insert(form, {"savemetadata", 0, 13, 2+font8:getWidth(L.SAVEMETADATA)/8, true, DF.CHECKBOX})
	table.insert(form, {"", 2, 13, 40, L.SAVEMETADATA, DF.LABEL})
	return form
end

function dialog.form.zip_level_make(startfolder, defaultname)
	return dialog.form.files_make(startfolder, defaultname, ".zip", true, 11)
end

function dialog.form.files_make(startfolder, defaultname, filter, show_hidden, list_height, yoff)
	if yoff == nil then
		yoff = 0
	end
	local len_namelabel = font8:getWidth(L.FILEOPENERNAME)/8
	local success, files, everr = listfiles_generic(startfolder, filter, true)
	if success then
		everr = ""
	end
	local form = {
		--{"folder", 0, yoff, 47, startfolder, DF.TEXT},
		{"folder", 0, yoff, 47, startfolder, DF.FILES, files, filter, show_hidden, 0, everr, list_height, true},
	}

	if filter ~= dirsep then
		table.insert(form,
			{"", 0, yoff+2+list_height, 6, L.FILEOPENERNAME, DF.LABEL}
		)
		table.insert(form,
			{"name", len_namelabel, yoff+2+list_height, 47-len_namelabel, defaultname, DF.TEXT}
		)
	end
	if filter ~= "" then
		local filtertext
		if filter == dirsep then
			filtertext = L.DOFILTERDIR
		else
			filtertext = langkeys(L.DOFILTER, {filter})
		end
		table.insert(form, {"dofilter", 0, 15, 2+font8:getWidth(filtertext)/8, true, DF.CHECKBOX,
				function(value, dialog)
					for k,v in pairs(dialog.fields) do
						if v[DFP.KEY] == "folder" then
							local success, everr
							success, dialog.fields[k][DFP.FILES_MENUITEMS], everr = listfiles_generic(
								dialog.fields[k][DFP.VALUE],
								value and dialog.fields[k][DFP.FILES_FOLDER_FILTER] or "",
								dialog.fields[k][DFP.FILES_FOLDER_SHOW_HIDDEN]
							)
							if success then
								everr = ""
							end
							dialog.fields[k][DFP.FILES_LISTSCROLL] = 0
							dialog.fields[k][DFP.FILES_FOLDER_ERROR] = everr
							dialog.fields[k][DFP.FILES_FILTER_ON] = value
							break
						end
					end
				end
			}
		)
		table.insert(form, {"", 2, 15, 40, filtertext, DF.LABEL})
	end

	return form
end

function dialog.form.hidden_make(values, existing_form)
	local form
	if existing_form == nil then
		form = {}
	else
		form = table.copy(existing_form)
	end

	for k,v in pairs(values) do
		if v ~= nil then
			table.insert(form, {k, 0, 0, 0, v, DF.HIDDEN})
		end
	end

	return form
end

--function dialog.form.

--
dialog.form.simplename = {
	{"name", 0, 1, 40, "", DF.TEXT},
}

dialog.callback = {}

function dialog.callback.noclose_on_make(match_button)
	return function(actual_button)
		return actual_button == match_button
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

function dialog.callback.sureopenlevel(button, fields)
	if button == DB.SAVE then
		dialog.create(
			L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, DBS.OKCANCEL,
			dialog.callback.saveopenlevel,
			nil,
			dialog.form.hidden_make({levelname=fields.levelname}, dialog.form.save_make()),
			nil
		)
	elseif button == DB.DISCARD then
		state6load(fields.levelname)
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

		savedsuccess, savederror = savelevel(fields.filename .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, extra, false)

		if not savedsuccess then
			-- Why not :c
			dialog.create(L.SAVENOSUCCESS .. anythingbutnil(savederror))
		else
			editingmap = fields.filename

			if fields.zip then
				if not love_version_meets(10) then
					dialog.create(langkeys(L.ZIP_LOVE11_ONLY, {"0.10"}))
					return
				end

				local folder = s.default_save_folder_zip
				if folder == "" then
					folder = levelsfolder
				end

				dialog.create(
					"",
					DBS.SAVECANCEL,
					dialog.callback.zip_level,
					L.ZIP_CREATE_TITLE,
					dialog.form.zip_level_make(folder, editingmap .. ".zip")
				)
			end
		end
	end
end

function dialog.callback.zip_level(button, fields)
	if button == DB.CANCEL then
		return
	end

	local new_default_folder
	if fields.folder == levelsfolder then
		new_default_folder = ""
	else
		new_default_folder = fields.folder
	end
	if s.default_save_folder_zip ~= new_default_folder then
		s.default_save_folder_zip = new_default_folder
		saveconfig()
	end

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	local success, err = zip_level(editingmap, filepath, filename)
	if not success then
		dialog.create(L.ZIP_SAVING_FAIL .. "\n\n" .. err)
	else
		dialog.create(
			L.ZIP_SAVING_SUCCESS,
			{L.OPENFOLDER, DB.OK},
			function(button2)
				if button2 == L.OPENFOLDER then
					love.system.openURL("file://" .. fields.folder)
				end
			end,
			filename,
			nil,
			dialog.callback.noclose_on_make(L.OPENFOLDER)
		)
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

function dialog.callback.saveopenlevel(button, fields)
	dialog.callback.save(button, fields)

	if button == DB.OK and not has_unsaved_changes() then
		dialogs[#dialogs]:press_button(0)
		state6load(fields.levelname)
	end
end

function dialog.callback.newscript_validate(button, fields, identifier)
	if button == DB.OK then
		if scripts[fields.name] ~= nil then
			-- Script already exists
			dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
			return true
		end

		if fields.name:match("|") then
			-- Script name has |
			dialog.create(langkeys(L.CANNOTUSENEWLINES, {"|"}))
			return true
		end
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
		return
	end

	local spl_originaleditingline, originalscript
	if identifier == "split_editor" then
		-- Splitting
		local _, editing_line = newinputsys.getpos("script_lines")
		spl_originaleditingline = editing_line
		originalscript = table.copy(inputs.script_lines) -- We need to have the unconverted version
		local totalnumberlines = #inputs.script_lines

		-- Before we save the current (possibly internal) script, split the contents of the old script.
		for i = spl_originaleditingline, totalnumberlines do
			table.remove(inputs.script_lines)
		end
	end

	if identifier == "split_editor" then
		-- Splitting a script, but we already saved the input earlier
		local success, raw_script = script_compile(inputs.script_lines)
		if not success then
			return
		end
		scripts[scriptname] = raw_script
		newinputsys.close("script_lines")
	end

	if scripts[fields.name] == nil then
		table.insert(scriptnames, fields.name)
		if identifier ~= "split_editor" and identifier ~= "duplicate_list" then
			-- Creating an empty script
			scripts[fields.name] = {""}

			-- Also make sure internal scripting mode doesn't stick
			internalscript = false
			cutscenebarsinternalscript = false
		else
			-- Splitting/duplicating the current script
			if identifier == "split_editor" then
				-- Splitting, meaning in editor
				scripts[fields.name] = originalscript -- We now have a duplicate. Might as well leave this as a reference.

				-- Now cut off the top part of the new script
				for i = 1, spl_originaleditingline-1 do
					table.remove(scripts[fields.name], 1)
				end
			else
				-- Duplicating, meaning in menu
				scripts[fields.name] = table.copy(scripts[scriptnames[fields.script_i]])
			end
		end
		scriptname = fields.name
		tostate(3)
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

		-- Refresh the list so it shows the correct label now
		loadflagslist()
	end
end

function dialog.callback.mapexport_validate(button, fields, identifier)
	if button == DB.SAVE then
		local x1, y1, w, h, x2, y2 = fix_map_export_input(fields, true)

		-- Check if we're gonna exceed the max texture size...
		local sizelimit = love.graphics.getSystemLimit("texturesize")
		local w_size, h_size

		if fields.resolution == -1 then
			w_size, h_size = 640*mapscale*w, 480*mapscale*h
		else
			local room_w, room_h
			if s.mapstyle == "minimap" then
				local zoom = getminimapzoom(metadata)
				room_w, room_h = 12*zoom, 9*zoom
			elseif s.mapstyle == "vtools" then
				room_w, room_h = 40, 30
			else
				room_w, room_h = 320, 240
			end

			w_size, h_size = room_w*fields.resolution*w, room_h*fields.resolution*h
		end

		if w_size > sizelimit or h_size > sizelimit then
			dialog.create(
				langkeys(L.MAXTEXTURESIZE, {w_size, h_size, sizelimit})
				.. "\n\n\n" .. renderer_info_string()
			)
			return true
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
		local x1, y1, w, h, x2, y2 = fix_map_export_input(fields, true)

		map_export(x1, y1, w, h, tonumber(fields.resolution), fields.transparentbg)
	end
end

function dialog.callback.helpsearch(button, fields)
	if button == DB.OK then
		helpsearchterm = fields.name
		inhelpsearch(fields.name)
	end

	takinginput = true
end

function dialog.callback.scriptsearch(button, fields)
	if button == DB.OK then
		scriptsearchterm = fields.name
		inscriptsearch(fields.name)
	end
end

function dialog.callback.scriptgotoline_validate(button, fields)
	if button == DB.OK then
		-- Check if this is a valid number.
		if tonumber(fields.line) == nil
		or tostring(tonumber(fields.line)) ~= fields.line
		or math.floor(tonumber(fields.line)) ~= tonumber(fields.line) then
			dialog.create(L.INVALIDLINENUMBER)
			return true
		end
	end
end

function dialog.callback.scriptgotoline(button, fields, _, notclosed)
	if notclosed then
		return
	end

	if button == DB.OK then
		scriptgotoline(tonumber(fields.line))
	end
end

function dialog.callback.renamenote(button, fields)
	if button == DB.OK then
		local newname = unique_note_name(fields.name, helppages[helparticle].subj)

		helppages[helparticle].subj = newname

		dirty()
	end
end

function dialog.callback.suredeletenote(button)
	if button == DB.YES then
		-- Yes, delete this note
		table.remove(helppages, helparticle)
		dirty()
		if helppages[helparticle] == nil then
			helparticle = helparticle - 1
		end

		-- Go to the new article (removing this line will cause the deleted article to be left on the screen, along with its buttons, but not the button in the left menu for it)
		if helppages[helparticle] == nil then
			helparticlecontent = nil
		else
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		end
	end
end

function dialog.callback.newnote(button, fields)
	if button == DB.OK then
		-- Add a note with this name.
		local newname = unique_note_name(fields.name)

						-- v by reference anyways
		table.insert(helppages, {subj = newname, imgs = {}, cont = [[
]] .. fields.name .. [[\wh#

]] .. L.CONTENTFILLER})

		helparticle = #helppages
		helpeditingline = 3
		takinginput = true
		helparticlecontent = explode("\n", helppages[#helppages].cont)
		input = anythingbutnil(helparticlecontent[3])
	end
end

function dialog.callback.renamescript_validate(button, fields)
	if button == DB.OK then
		if scripts[fields.name] ~= nil and fields.name ~= scriptnames[fields.script_i] then
			-- Script already exists
			dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
			return true
		end

		if fields.name:match("|") then
			-- Script name has |
			dialog.create(langkeys(L.CANNOTUSENEWLINES, {"|"}))
			return true
		end
	end
end

function dialog.callback.renamescript(button, fields, _, notclosed)
	if notclosed or button ~= DB.OK then
		return
	end

	-- Rename this script... As long as the names aren't the same,
	-- because then we'd end up *removing* the script (just read the code)
	-- And of course, as long as a script with that name doesn't already exist.
	-- fields.script_i is the 'number' of the script
	if fields.name ~= scriptnames[fields.script_i] then
		local oldname = scriptnames[fields.script_i]
		local newname = fields.name

		scripts[fields.name] = scripts[scriptnames[fields.script_i]] -- Copy script from old to new name
		scripts[scriptnames[fields.script_i]] = nil -- Remove old name

		scriptnames[fields.script_i] = fields.name -- Administrative rename

		dirty()

		if fields.references then
			-- Ok, now time to update ALL the references to this script.

			-- Scripts
			local field3cmds = {"iftrinkets", "customiftrinkets", "iftrinketsless", "customiftrinketsless", "ifflag", "customifflag"}
			local field3intcmds = {"ifcrewlost", "iflast"}
			local field2intcmds = {"loadscript", "ifskip"}
			local field4intcmds = {"ifexplored"}
			local field5cmds = {"ifwarp"}

			local oldnamenotgsub = oldname
			oldname = escapegsub(oldname, true)

			local tmp
			for script_i = #scriptnames, 1, -1 do
				for k,v in pairs(scripts[scriptnames[script_i]]) do
					v = v:gsub(" ", "")
					for _,command in pairs(field3cmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)])" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[script_i]][k] = tmp
							end
						end
					end
					for _, command in pairs(field3intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[script_i]][k] = tmp
							end
						end
					end
					for _, command in pairs(field2intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[script_i]][k] = tmp
							end
						end
					end
					for _, command in pairs(field4intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)][^%(,%)]-[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[script_i]][k] = tmp
							end
						end
					end
					for _, command in pairs(field5cmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)][^%(,%)]-[%(,%)][^%(,%)]-[%(,%)])" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[script_i]][k] = tmp
							end
						end
					end
				end
			end

			-- Terminals and script boxes
			for k,v in pairs(entitydata) do
				if (v.t == 18 or v.t == 19) and v.data == oldnamenotgsub then
					entitydata[k].data = newname
				end
			end
		end

		-- Update referenced scripts, since we changed some around
		usedscripts, n_usedscripts = find_used_scripts()
	end
end

function dialog.callback.suredeletescript(button, fields)
	if button == DB.YES then
		-- Delete this script!
		-- fields.script_i is the 'number' of the script
		delete_script(fields.script_i)
	end
end

function dialog.callback.customvvvvvvdir(button, fields)
	if button == DB.CANCEL then
		return
	end

	s.customvvvvvvdir = fields.folder
end

function dialog.callback.savebackup(button, fields)
	-- Save copy of backup in levels folder
	if button == DB.OK then
		local filename = fields.filename
		if dirsep ~= "/" then
			filename = filename:gsub(dirsep, "/")
		end
		local ficontents = love.filesystem.read("overwrite_backups/" .. filename .. ".vvvvvv")
		if ficontents == nil then
			dialog.create(langkeys(L.LEVELOPENFAIL, {"overwrite_backups/" .. filename}))
		else
			local success, iferrmsg = writelevelfile(levelsfolder .. dirsep .. fields.name .. ".vvvvvv", ficontents)
			if not success then
				dialog.create(L.SAVENOSUCCESS .. anythingbutnil(iferrmsg))
			end
		end
	end
end

function dialog.callback.rawentityproperties(button, fields, identifier, notclosed, dialog_obj)
	if button == DB.CANCEL then
		return
	end

	-- thisentity is still this entity
	local correctlines = false
	if (thisentity.t == 11 or thisentity.t == 50) -- gravity line or warp line
	and thisentity.p1 == anythingbutnil0(fields.p1)
	and thisentity.p2 == anythingbutnil0(fields.p2)
	and thisentity.p3 == anythingbutnil0(fields.p3) then
		correctlines = true
	end

	local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6", "data"}
	local changeddata = {}
	for k,v in pairs(entitypropkeys) do
		local newvalue = fields[v]
		if v ~= "data" then
			-- Needs to be a number
			newvalue = anythingbutnil0(newvalue)
		end
		table.insert(changeddata, {
				key = v,
				oldvalue = thisentity[v],
				newvalue = newvalue
			}
		)
		thisentity[v] = newvalue
	end

	if correctlines then
		autocorrectlines()

		for k,v in pairs(changeddata) do
			if v.key == "p1" or v.key == "p2" or v.key == "p3" then
				changeddata[k].newvalue = thisentity[v.key]
			end
		end

		-- Do keep the fields in sync, if we're only applying
		if button == DB.APPLY then
			dialog_obj:set_field('p1', thisentity.p1)
			dialog_obj:set_field('p2', thisentity.p2)
			dialog_obj:set_field('p3', thisentity.p3)
		end
	end

	-- entdetails[3] is still the ID of this entity
	table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = tonumber(entdetails[3]), changedentitydata = changeddata})
	finish_undo("CHANGED ENTITY (PROPERTIES)")
end

function dialog.callback.leveloptions(button, fields)
	if button == DB.CANCEL then
		return
	elseif button == DB.ADVANCED then
		dialog.create(
			"",
			DBS.OKCANCEL,
			dialog.callback.advancedleveloptions,
			L.ADVANCED_LEVEL_OPTIONS,
			dialog.form.advancedleveloptions_make()
		)
		return
	end

	-- What are the old properties?
	local undo_propertynames = {"Title", "Creator", "website", "Desc1", "Desc2", "Desc3", "mapwidth", "mapheight", "levmusic"}
	local undo_properties = {}
	for k,v in pairs(undo_propertynames) do
		undo_properties[k] = {
			key = v,
			oldvalue = metadata[v]
		}
	end

	-- Level properties
	metadata.Title = fields.Title
	metadata.Creator = fields.Creator
	metadata.website = fields.website
	metadata.Desc1 = fields.Desc1
	metadata.Desc2 = fields.Desc2
	metadata.Desc3 = fields.Desc3
	metadata.levmusic = fields.levmusic

	if (tonumber(fields.mapwidth) ~= nil and tonumber(fields.mapheight) ~= nil) then
		-- Make sure we have a dimension, and that it isn't too interesting
		local w, h = tonumber(fields.mapwidth), tonumber(fields.mapheight)
		if w < 1 then w = 1 end
		if h < 1 then h = 1 end

		-- Make sure our dimension has a precise width and height
		w, h = math.floor(w), math.floor(h)

		if metadata.mapwidth <= limit.mapwidth and metadata.mapheight <= limit.mapheight
		and (w > limit.mapwidth or h > limit.mapheight) then
			local newbuttons
			if s.allowbiggerthansizelimit then
				newbuttons = {L.BTNOVERRIDE, DB.OK}
			end

			dialog.create(
				langkeys(
					L.SIZELIMIT,
					{limit.mapwidth, limit.mapheight, math.min(w, limit.mapwidth), math.min(h, limit.mapheight)}
				),
				newbuttons,
				dialog.callback.leveloptions_maxlevelsize,
				"",
				dialog.form.hidden_make({mapwidth=w, mapheight=h})
			)
		else
			resize_level(w, h)
		end
	end

	--What are the new properties again?
	for k,v in pairs(undo_propertynames) do
		undo_properties[k].newvalue = metadata[v]
	end

	-- Make sure we can undo and redo it
	table.insert(undobuffer, {undotype = "metadata", changedmetadata = undo_properties})
	finish_undo("CHANGED METADATA")
end

function dialog.callback.advancedleveloptions(button, fields)
	if button == DB.CANCEL then
		return
	end

	-- What are the old properties?
	local undo_propertynames = {"onewaycol_override"}
	local undo_properties = {}
	for k,v in pairs(undo_propertynames) do
		undo_properties[k] = {
			key = v,
			oldvalue = metadata[v]
		}
	end

	-- Level properties
	metadata.onewaycol_override = fields.onewaycol_override

	--What are the new properties again?
	for k,v in pairs(undo_propertynames) do
		undo_properties[k].newvalue = metadata[v]
	end

	-- Make sure we can undo and redo it
	table.insert(undobuffer, {undotype = "metadata", changedmetadata = undo_properties})
	finish_undo("CHANGED METADATA")
end

function dialog.callback.loadvvvvvvmusic(button, fields)
	if button == DB.CANCEL or fields.name == "" then
		return
	end

	musiceditorfile_forcevvvvvvfolder = false
	musiceditorfolder = fields.folder
	musiceditorfolder_set = true

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	local success, errormessage
	if filepath == vvvvvvfolder .. dirsep .. "vvvvvvmusic.vvv"
	or filepath == vvvvvvfolder .. dirsep .. "mmmmmm.vvv" then
		success, errormessage = loadvvvvvvmusic(filename)
		musiceditorfile_forcevvvvvvfolder = true
	else
		success, errormessage = loadvvvvvvmusic("musiceditor", filepath)
	end
	if not success then
		dialog.create(langkeys(L.MUSICLOADERROR, {fields.name}) .. anythingbutnil(errormessage))
	else
		musiceditorfile = filename
		if musiceditorfile_forcevvvvvvfolder then
			musicplayerfile = musiceditorfile
		else
			musicplayerfile = "musiceditor"
		end
	end
end

function dialog.callback.savevvvvvvmusic(button, fields)
	if button == DB.CANCEL or fields.name == "" then
		return
	end

	musiceditorfolder = fields.folder
	musiceditorfolder_set = true

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	local success, errormessage = savevvvvvvmusic(musicplayerfile, filepath, fields.savemetadata)
	if not success then
		dialog.create(L.SAVENOSUCCESS .. errormessage)
	else
		musiceditorfile = filename
	end
end

function dialog.callback.suredeletesong(button, fields)
	if button == DB.YES then
		musicedit_deletesong(musicplayerfile, fields.song)
	end
end

function dialog.callback.replacesong(button, fields)
	if button == DB.CANCEL or fields.name == "" then
		return
	end

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	local readsuccess, ficontents = readfile(filepath)
	if not readsuccess then
		dialog.create(langkeys(L.SONGOPENFAIL, {fields.name}) .. "\n\n" .. ficontents)
		return
	end

	local success, err = musicedit_replacesong(musicplayerfile, fields.song, ficontents)
	if not success then
		dialog.create(L.SONGREPLACEFAIL .. "\n\n" .. anythingbutnil(err))
	else
		music_set_song_vvv_metadata(musicplayerfile, fields.song, nil, filename, nil)
	end
end

function dialog.callback.songmetadata(button, fields)
	if button == DB.CANCEL then
		return
	end

	music_set_song_vvv_metadata(musicplayerfile, fields.song, fields.name, fields.filename, fields.notes)
end

function dialog.callback.musicfilemetadata(button, fields)
	if button == DB.CANCEL then
		return
	end

	music_set_file_vvv_metadata(musicplayerfile, nil, fields.name, fields.artist, fields.notes)
end

function dialog.callback.openimage(button, fields)
	if button == DB.CANCEL or fields.name == "" then
		return
	end

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	assets_openimage(filepath, filename)
end

function dialog.callback.platv_validate(button, fields)
	if button == DB.OK and fields.name ~= tostring(tonumber(fields.name)) then
		dialog.create(L.PLATVCHANGE_INVALID)
		return true
	end
end

function dialog.callback.platv(button, fields, _, notclosed)
	if notclosed or button ~= DB.OK then
		return
	end

	local oldplatv = levelmetadata_get(roomx, roomy).platv
	levelmetadata_set(roomx, roomy, "platv", tonumber(fields.name))
	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "platv",
					oldvalue = oldplatv,
					newvalue = levelmetadata_get(roomx, roomy).platv
				}
			},
			switchtool = 8
		}
	)
	finish_undo("PLATV")
end

function dialog.callback.locatevvvvvv(button, fields, _, notclosed)
	if notclosed or button ~= DB.OK then
		return
	end

	local path = fields.folder .. dirsep .. fields.name

	if fields.target == "V" then
		s.vvvvvv23 = path
	end
	saveconfig()

	if fields.start then
		playtesting_start(false)
	end
end

function dialog.callback.locatevvvvvv_validate(button, fields)
	if button ~= DB.OK then
		return
	end

	local path = fields.folder .. dirsep .. fields.name
	if not playtesting_validate_path(path) then
		dialog.create(L.PATHINVALID .. "\n\n" .. playtesting_get_vvvvvv_message(fields.target))
		return true
	end
end

function dialog.callback.locatevvvvvvchoice(button, fields)
	if button == L.BTN_AUTODETECT or button == L.BTN_RETRY then
		local success, path = find_vvvvvv_exe()
		if not success then
			dialog.create(
				path,
				{L.BTN_RETRY, DB.CANCEL},
				dialog.callback.locatevvvvvvchoice,
				nil,
				dialog.form.hidden_make(fields)
			)
		else
			if fields.target == "V" then
				s.vvvvvv23 = path
			end
			saveconfig()

			if fields.start then
				playtesting_start(false)
			end
		end
	elseif button == L.BTN_MANUALLY then
		playtesting_ask_path_manual(fields.target, fields.start)
	end
end

function dialog.callback.leveloptions_maxlevelsize(button, fields)
	if button == L.BTNOVERRIDE then
		dialog.create(
			langkeys(
				L.CONFIRMBIGGERSIZE,
				{
					fields.mapwidth, fields.mapheight,
					limit.mapwidth, limit.mapheight,
					math.min(fields.mapwidth, limit.mapwidth), math.min(fields.mapheight, limit.mapheight)
				}
			),
			DBS.YESNO,
			dialog.callback.leveloptions_biggersize,
			"",
			dialog.form.hidden_make({mapwidth=fields.mapwidth, mapheight=fields.mapheight})
		)
	elseif button == DB.OK then
		resize_level(math.min(fields.mapwidth, limit.mapwidth), math.min(fields.mapheight, limit.mapheight))

		-- Uh, yeah, this is kind of an ugly hack and kind of relies on the
		-- assumptions that (1) the user can't undo, redo, or make any other
		-- changes while a dialog is open, and (2) the order of the changed
		-- metadata in the undo buffer won't change in the future
		if #undobuffer == 0 then
			return
		end
		undobuffer[#undobuffer].changedmetadata[7].newvalue = metadata.mapwidth
		undobuffer[#undobuffer].changedmetadata[8].newvalue = metadata.mapheight
		finish_undo("CHANGED METADATA (max level size, also ugly hack)")
	end
end

function dialog.callback.leveloptions_biggersize(button, fields)
	if button == DB.NO then
		resize_level(math.min(fields.mapwidth, limit.mapwidth), math.min(fields.mapheight, limit.mapheight))
	elseif button == DB.YES then
		resize_level(fields.mapwidth, fields.mapheight)
	end

	if #undobuffer == 0 then
		return
	end
	undobuffer[#undobuffer].changedmetadata[7].newvalue = metadata.mapwidth
	undobuffer[#undobuffer].changedmetadata[8].newvalue = metadata.mapheight
	finish_undo("CHANGED METADATA (bigger than " .. limit.mapwidth .. "x" .. limit.mapheight .. " size, also ugly hack)")
end

function dialog.callback.create_assets_folder(button, fields)
	if button == DB.YES then
		local success, errmsg = create_directory(fields.folder)
		if not success then
			dialog.create(langkeys(L.CREATE_FOLDER_FAIL, {errmsg}))
		else
			assetsmenu_vvvvvvfolder_exists = true
		end
	end
end
