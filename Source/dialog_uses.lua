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
		{"title", 0, 4, 40, metadata.Title, DF.TEXT},
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

	return {
		{"", 0, 0, 40, L.MAPRESOLUTION, DF.LABEL},
		{
			"resolution", 0, 1, 30, -1, DF.DROPDOWN,
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
	local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6", "data"}
	local form = {}

	for k,v in pairs(entitypropkeys) do
		table.insert(form, {v, 5, 2+k, 38, thisentity[v], DF.TEXT})
	end

	return form
end

function dialog.form.language_make()
	local bottomleft_text = L.TRANSLATIONCREDIT
	if s.lang == "English" then
		-- Yeah, hardcoded text!
		bottomleft_text = "Want to help translating Ved? Please contact Dav999!"
	end
	local year = os.date("%Y")
	return {
		{"language", 0, 0, 30, s.lang, DF.DROPDOWN, getalllanguages()},
		{"", 0, 3, 40, L.DATEFORMAT, DF.LABEL},
		{
			"dateformat", 0, 4, 0, s.new_dateformat, DF.RADIOS,
			generate_dropdown_tables(
				{{"YMD", year .. "-12-31"}, {"DMY", "31-12-" .. year}, {"MDY", "12/31/" .. year}}
			)
		},
		{"", 23, 3, 40, L.TIMEFORMAT, DF.LABEL},
		{
			"timeformat", 23, 4, 0, s.new_timeformat, DF.RADIOS,
			generate_dropdown_tables(
				{{24, "23:59"}, {12, "11:59pm"}}
			)
		},
		{"", 0, 15, 30, bottomleft_text, DF.LABEL}
	}
end

function dialog.form.leveloptions_make()
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
			"levmusic", 8, 10, 30, metadata.levmusic, DF.DROPDOWN, listmusicnames, listmusicids,
			function(picked)
				for k,v in pairs(listmusicnamesids) do
					if picked == v[1] then
						return v[2]
					end
				end
			end
		},
	}
end

function dialog.form.songmetadata_make(song_metadata)
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

function dialog.form.savevvvvvvmusic_make(default)
	return {
		{"name", 0, 1, 40, default, DF.TEXT},
		{"savemetadata", 0, 3, 2+font8:getWidth(L.SAVEMETADATA)/8, true, DF.CHECKBOX},
		{"", 2, 3, 40, L.SAVEMETADATA, DF.LABEL}
	}
end

function dialog.form.files_make(startfolder, defaultname, filter, show_hidden, list_height)
	local len_namelabel = font8:getWidth(L.FILEOPENERNAME)/8
	local success, files, everr = listfiles_generic(startfolder, filter, true)
	if success then
		everr = ""
	end
	form = {
		--{"folder", 0, 0, 47, startfolder, DF.TEXT},
		{"folder", 0, 0, 47, startfolder, DF.FILES, files, filter, show_hidden, 0, everr, list_height, true},
	}

	if filter ~= dirsep then
		table.insert(form,
			{"", 0, 2+list_height, 6, L.FILEOPENERNAME, DF.LABEL}
		)
		table.insert(form,
			{"name", len_namelabel, 2+list_height, 47-len_namelabel, defaultname, DF.TEXT}
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
						if v[1] == "folder" then
							local success, everr
							success, dialog.fields[k][7], everr = listfiles_generic(
								dialog.fields[k][5],
								value and dialog.fields[k][8] or "",
								dialog.fields[k][9]
							)
							if success then
								everr = ""
							end
							dialog.fields[k][10] = 0
							dialog.fields[k][11] = everr
							dialog.fields[k][13] = value
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

--function dialog.form.

-- 
dialog.form.simplename = {
	{"name", 0, 1, 40, "", DF.TEXT},
}

dialog.callback = {}
dialog.callback.noclose_on = {}

function dialog.callback.noclose_on.save(button)
	if button == DB.SAVE then
		return true
	end
end
function dialog.callback.noclose_on.apply(button)
	if button == DB.APPLY then
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
	if button == DB.OK then
		if scripts[fields.name] ~= nil then
			-- Script already exists
			dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
			return true
		end

		if (not PleaseDo3DSHandlingThanks and fields.name:match("|")) or
		(PleaseDo3DSHandlingThanks and fields.name:match("%$")) then
			-- Script name has | or $
			dialog.create(langkeys(L.CANNOTUSENEWLINES, {PleaseDo3DSHandlingThanks and "$" or "|"}))
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
				cutscenebarsinternalscript = false
			else
				-- Splitting/duplicating the current script
				local keepinternal, keepcutscenebarsinternal
				if identifier == "split_editor" then
					-- Splitting, meaning in editor
					scripts[fields.name] = originalscript -- We now have a duplicate. Might as well leave this as a reference.

					-- Now cut off the top part of the new script
					for i = 1, spl_originaleditingline-1 do
						table.remove(scripts[fields.name], 1)
					end

					-- Oh, was the script an internal script by the way?
					keepinternal = internalscript
					keepcutscenebarsinternal = cutscenebarsinternalscript
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
					cutscenebarsinternalscript = keepcutscenebarsinternal
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
		local x1, y1, w, h, x2, y2 = fix_map_export_input(fields, true)

		-- Check if we're gonna exceed the max texture size...
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

	takinginput = true -- We were working on a script
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

	takinginput = true -- We were working on a script
end

function dialog.callback.noflagsleft(button)
	if button == DB.YES then
		-- Leave the editor even though a flag label doesn't have a number now.
		leavescript_to_state()
	end
end

function dialog.callback.renamenote(button, fields)
	if button == DB.OK then
		local newname = uniquenotename(fields.name, helppages[helparticle].subj)

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
		helparticlecontent = explode("\n", helppages[helparticle].cont)
	end
end

function dialog.callback.newnote(button, fields)
	if button == DB.OK then
		-- Add a note with this name.
		local newname = uniquenotename(fields.name)

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
		if scripts[fields.name] ~= nil and fields.name ~= scriptnames[input] then
			-- Script already exists
			dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {fields.name}))
			return true
		end

		if (not PleaseDo3DSHandlingThanks and fields.name:match("|")) or
		(PleaseDo3DSHandlingThanks and fields.name:match("%$")) then
			-- Script name has | or $
			dialog.create(langkeys(L.CANNOTUSENEWLINES, {PleaseDo3DSHandlingThanks and "$" or "|"}))
			return true
		end
	end
end

function dialog.callback.renamescript(button, fields, _, notclosed)
	if notclosed or button ~= DB.OK then
		return
	end

	input = tonumber(input)
	-- Rename this script... As long as the names aren't the same,
	-- because then we'd end up *removing* the script (just read the code)
	-- And of course, as long as a script with that name doesn't already exist.
	-- input is the 'number' of the script
	if fields.name ~= scriptnames[input] then
		local oldname = scriptnames[input]
		local newname = fields.name

		scripts[fields.name] = scripts[scriptnames[input]] -- Copy script from old to new name
		scripts[scriptnames[input]] = nil -- Remove old name

		scriptnames[input] = fields.name -- Administrative rename

		dirty()

		if fields.references then
			-- Ok, now time to update ALL the references to this script.

			-- Scripts
			local field3cmds = {"iftrinkets", "customiftrinkets", "iftrinketsless", "customiftrinketsless", "ifflag", "customifflag"}
			local field3intcmds = {"ifcrewlost", "iflast"}
			local field2intcmds = {"loadscript", "ifskip"}
			local field4intcmds = {"ifexplored"}

			local tmp
			for rvnum = #scriptnames, 1, -1 do
				for k,v in pairs(scripts[scriptnames[rvnum]]) do
					v = v:gsub(" ", "")
					for _,command in pairs(field3cmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)])" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[rvnum]][k] = tmp
							end
						end
					end
					for _, command in pairs(field3intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[rvnum]][k] = tmp
							end
						end
					end
					for _, command in pairs(field2intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[rvnum]][k] = tmp
							end
						end
					end
					for _, command in pairs(field4intcmds) do
						if #v > #command then
							local pattern = "^(" .. command .. "[%(,%)][^%(,%)]-[%(,%)][^%(,%)]-[%(,%)]custom_)" .. oldname
							tmp = renamescriptline(v, pattern, newname)
							if tmp ~= nil then
								scripts[scriptnames[rvnum]][k] = tmp
							end
						end
					end
				end
			end

			-- Terminals and script boxes
			for k,v in pairs(entitydata) do
				if (v.t == 18 or v.t == 19) and v.data == oldname then
					entitydata[k].data = newname
				end
			end
		end

		-- Update referenced scripts, since we changed some around
		usedscripts, n_usedscripts = findusedscripts()
	end
end

function dialog.callback.suredeletescript(button)
	if button == DB.YES then
		-- Delete this script!
		-- input is the 'number' of the script

		scripts[scriptnames[input]] = nil
		table.remove(scriptnames, input)
		dirty()

		-- We might have removed a script reference, so update usages
		usedscripts, n_usedscripts = findusedscripts()
	end
end

function dialog.callback.customvvvvvvdir1(button)
	if button == L.CHANGEVERB then
		local start = s.customvvvvvvdir
		if start == "" then
			start = userprofile
		end
		dialog.create(
			"",
			DBS.OKCANCEL,
			dialog.callback.customvvvvvvdir2,
			L.CUSTOMVVVVVVDIRECTORY,
			dialog.form.files_make(start, "", dirsep, true, 12)
		)
	elseif button == L.RESET then
		-- Reset the custom VVVVVV directory
		s.customvvvvvvdir = ""
	end
end

function dialog.callback.customvvvvvvdir2(button, fields)
	if button == DB.CANCEL then
		return
	end

	s.customvvvvvvdir = fields.folder
end

function dialog.callback.savebackup(button, fields)
	-- Save copy of backup in levels folder
	if button == DB.OK then
		if dirsep ~= "/" then
			input = input:gsub(dirsep, "/")
		end
		local ficontents = love.filesystem.read("overwrite_backups/" .. input .. ".vvvvvv")
		if ficontents == nil then
			dialog.create(langkeys(L.LEVELOPENFAIL, {"overwrite_backups/" .. input}))
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
	and thisentity.p1 == anythingbutnil0(tonumber(fields.p1))
	and thisentity.p2 == anythingbutnil0(tonumber(fields.p2))
	and thisentity.p3 == anythingbutnil0(tonumber(fields.p3)) then
		correctlines = true
	end

	local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6"}
	local changeddata = {}
	for i = 1, 9 do
		table.insert(changeddata, {
				key = entitypropkeys[i],
				oldvalue = thisentity[entitypropkeys[i]],
				newvalue = anythingbutnil0(tonumber(fields[entitypropkeys[i]]))
			}
		)
		thisentity[entitypropkeys[i]] = anythingbutnil0(tonumber(fields[entitypropkeys[i]]))
	end
	thisentity.data = fields.data

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

function dialog.callback.language(button, fields)
	if button == DB.OK then
		s.new_dateformat = fields.dateformat
		s.new_timeformat = fields.timeformat

		unloadlanguage()
		s.lang = fields.language
		loadlanguage()

		saveconfig()

		swaptinynumbersglyphs()
	end
end

function dialog.callback.leveloptions(button, fields)
	if button == DB.CANCEL then
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

		if w > 20 or h > 20 then
			dialog.create(
				langkeys(L.SIZELIMIT, {
					math.min(20, w),
					math.min(20, h)
				})
			)
		end
		metadata.mapwidth = math.min(20, w)
		metadata.mapheight = math.min(20, h)
		addrooms(metadata.mapwidth, metadata.mapheight)
		gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
	end

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

	local success, errormessage = savevvvvvvmusic(musicplayerfile, fields.name .. ".vvv", fields.savemetadata)
	if not success then
		dialog.create(L.SAVENOSUCCESS .. errormessage)
	else
		musiceditorfile = fields.name .. ".vvv"
	end
end

function dialog.callback.suredeletesong(button)
	if button == DB.YES then
		-- input is the number of the song
		musicedit_deletesong(musicplayerfile, input)
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

	-- input is the number of the song
	local success, err = musicedit_replacesong(musicplayerfile, input, ficontents)
	if not success then
		dialog.create(L.SONGREPLACEFAIL .. "\n\n" .. anythingbutnil(err))
	else
		setmusicmeta_song(musicplayerfile, input, nil, filename, nil)
	end
end

function dialog.callback.songmetadata(button, fields)
	if button == DB.CANCEL then
		return
	end

	-- input is the number of the song
	setmusicmeta_song(musicplayerfile, input, fields.name, fields.filename, fields.notes)
end

function dialog.callback.musicfilemetadata(button, fields)
	if button == DB.CANCEL then
		return
	end

	setmusicmeta_file(musicplayerfile, nil, fields.name, fields.artist, fields.notes)
end

function dialog.callback.openimage(button, fields)
	if button == DB.CANCEL or fields.name == "" then
		return
	end

	local filepath, filename = filepath_from_dialog(fields.folder, fields.name)

	local readsuccess, contents = readfile(filepath)
	if not readsuccess then
		dialog.create(contents)
		return
	end

	local success, filedata = pcall(love.filesystem.newFileData, contents, filename, "file")
	if not success then
		dialog.create(filedata)
		return
	end
	local imgdata
	success, imgdata = pcall(love.image.newImageData, filedata)
	if not success then
		dialog.create(imgdata)
		return
	end
	success, imageviewer_image_color = pcall(love.graphics.newImage, imgdata)
	if not success then
		dialog.create(imageviewer_image_color)
		return
	end
	imgdata:mapPixel(
		function(x, y, r, g, b, a)
			return 255, 255, 255, a
		end
	)
	imageviewer_image_white = love.graphics.newImage(imgdata)
	imageviewer_filepath, imageviewer_filename = filepath, filename

	imageviewer_x, imageviewer_y, imageviewer_s = 0, 0, 1
	imageviewer_w, imageviewer_h = imageviewer_image_color:getDimensions()
	fix_imageviewer_position()
	imageviewer_moving = false
	imageviewer_moved_from_x, imageviewer_moved_from_y = 0, 0
	imageviewer_moved_from_mx, imageviewer_moved_from_my = 0, 0
	imageviewer_grid, imageviewer_showwhite = 0, false

	-- Guess the grid setting
	if filename:sub(1,10) == "entcolours"
	or filename:sub(1,4) == "font"
	or filename:sub(1,5) == "tiles" then
		imageviewer_grid = 8
	elseif filename:sub(1,7) == "sprites"
	or filename:sub(1,11) == "flipsprites" then
		imageviewer_grid = 32
	end
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

	local oldplatv = levelmetadata[(roomy)*20 + (roomx+1)].platv
	levelmetadata[(roomy)*20 + (roomx+1)].platv = tonumber(fields.name)
	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "platv",
					oldvalue = oldplatv,
					newvalue = levelmetadata[(roomy)*20 + (roomx+1)].platv
				}
			},
			switchtool = 8
		}
	)
	finish_undo("PLATV")
end
