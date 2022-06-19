-- maineditor/keypressed

return function(key)
	if editingroomtext > 0 then
		if table.contains({"return", "kpenter"}, key) then
			endeditingroomtext()
		elseif key == "escape" then
			if entitydata[editingroomtext].data == "" then
				removeentity(editingroomtext, nil, true)
			end
			editingroomtext = 0
			stopinput()
		end
		return
	end

	if editingroomname then
		if table.contains({"return", "kpenter"}, key) then
			saveroomname()
		elseif key == "escape" then
			editingroomname = false
			stopinput()
		end
		return
	end

	if coordsdialog.active then
		if key == "escape" then
			coordsdialog.active = false
		end
		return
	end

	local voided_metadata = levelmetadata_get(roomx, roomy).voided

	if keyboard_eitherIsDown("shift") and keyboard_eitherIsDown(ctrl) then
		tilespicker = true
		if not love.keyboard.isDown("rshift") and not love.keyboard.isDown(rctrl) then
			tilespicker_shortcut = true
		end
	end

	if tilespicker and table.contains({"left", "right", "up", "down", "a", "d", "w", "s"}, key) then
		if levelmetadata_get(roomx, roomy).directmode == 1 then
			local tsw = tilesets[tileset_names[selectedtileset]].tiles_width_picker
			local tsh = tilesets[tileset_names[selectedtileset]].tiles_height_picker
			local total_tiles = tilesets[tileset_names[selectedtileset]].total_tiles

			if table.contains({"left", "a"}, key) then
				selectedtile = selectedtile - 1
			elseif table.contains({"right", "d"}, key) then
				selectedtile = (selectedtile + 1) % total_tiles
			elseif table.contains({"up", "w"}, key) then
				selectedtile = selectedtile - tsw
			elseif table.contains({"down", "s"}, key) then
				selectedtile = (selectedtile + tsw) % total_tiles
			end

			if selectedtile < 0 then
				selectedtile = selectedtile + total_tiles
			end

			tilespicker_selectedtile_page()
		end
	elseif tilespicker and key == "pageup" then
		tilespicker_prev_page()
	elseif tilespicker and key == "pagedown" then
		tilespicker_next_page()
	elseif key == "," then
		if keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift") then
			if selectedtool ~= 14 then
				if selectedsubtool[selectedtool] > 1 then
					selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
				else
					selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
				end
			end
		elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
			if selectedtool > 1 then
				selectedtool = selectedtool - 1
			else
				selectedtool = 17
			end
			updatewindowicon()
			toolscroll()
		end
	elseif key == "." then
		if keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift") then
			if selectedtool ~= 14 then
				if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
					selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
				else
					selectedsubtool[selectedtool] = 1
				end
			end
		elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
			local tool_count = 17
			if selectedtool < tool_count then
				selectedtool = selectedtool + 1
			else
				selectedtool = 1
			end
			updatewindowicon()
			toolscroll()
		end

	elseif key == "g" then
		coordsdialog.activate()
	elseif key == "m" or key == "kp5" then
		tostate(12)
		return -- temporary, until state 1 got GUI overhaul and this is in ui.keypressed
	elseif playtesting_uistate == PT_UISTATE.ASKING and key == "escape" then
		playtesting_cancelask()
	elseif key == "/" then
		if keyboard_eitherIsDown(ctrl) then
			to_notepad()
		else
			tostate(10)
		end
	elseif key == "f1" and keyboard_eitherIsDown(ctrl) then
		tostate(15)
	elseif key == "f" and keyboard_eitherIsDown(ctrl) then
		tostate(11)
	elseif key == "p" and keyboard_eitherIsDown(ctrl) then
		gotostartpointroom()
	elseif key == "d" and keyboard_eitherIsDown(ctrl) then
		tostate(6, nil, "secondlevel")
	elseif key == "]" and mouselockx == -1 then
		mouselockx = love.mouse.getX()
	elseif key == "[" and mouselocky == -1 then
		mouselocky = love.mouse.getY()
	elseif editingbounds ~= 0 and key == "escape" then
		if editingbounds == 1 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (esc canceled)")
		elseif editingbounds == 2 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (esc canceled)")
		end

		editingbounds = 0
	elseif editingbounds ~= 0 and key == "delete" then
		if editingbounds == -1 or editingbounds == 1 then
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				oldbounds[k] = levelmetadata_get(roomx, roomy)["enemy" .. v]
			end

			levelmetadata_set(roomx, roomy, "enemyx1", 0)
			levelmetadata_set(roomx, roomy, "enemyy1", 0)
			levelmetadata_set(roomx, roomy, "enemyx2", 320)
			levelmetadata_set(roomx, roomy, "enemyy2", 240)

			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (deleted)")
		else
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				oldbounds[k] = levelmetadata_get(roomx, roomy)["plat" .. v]
			end

			levelmetadata_set(roomx, roomy, "platx1", 0)
			levelmetadata_set(roomx, roomy, "platy1", 0)
			levelmetadata_set(roomx, roomy, "platx2", 320)
			levelmetadata_set(roomx, roomy, "platy2", 240)

			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (deleted)")
		end

		editingbounds = 0
	elseif movingentity ~= 0 and key == "escape" then
		if movingentity_copying then
			movingentity_copying = false
			count.entities = count.entities - 1
			if entitydata[movingentity].t == 9 then
				count.trinkets = count.trinkets - 1
			elseif entitydata[movingentity].t == 15 then
				count.crewmates = count.crewmates - 1
			end
			count.entity_ai = count.entity_ai - 1
			table.remove(entitydata, movingentity)
		end
		movingentity = 0
		movingentity_copying = false
	elseif table.contains({3, 4}, selectedsubtool[14]) and key == "escape" then
		selectedsubtool[14] = 1
		warpid = nil
	elseif sp_t ~= 0 and key == "escape" then
		sp_t = 0
		sp_go = true
	elseif sp_t ~= 0 and not (sp_go and sp_got <= 0) then
		if sp_t > 0 then
			if key == "up" and s_hoofdd ~= 2 then
				s_hoofdd = 0
			elseif key == "right" and s_hoofdd ~= 3 then
				s_hoofdd = 1
			elseif key == "down" and s_hoofdd ~= 0 then
				s_hoofdd = 2
			elseif key == "left" and s_hoofdd ~= 1 then
				s_hoofdd = 3
			end
		end
	elseif editingbounds == 0 and (key == "right" or key == "kp6") and not keyboardmode then
		-->
		gotoroom_r()
	elseif editingbounds == 0 and (key == "left" or key == "kp4") and not keyboardmode then
		--<
		gotoroom_l()
	elseif editingbounds == 0 and (key == "down" or key == "kp2") and not keyboardmode then
		--v
		gotoroom_d()
	elseif editingbounds == 0 and (key == "up" or key == "kp8") and not keyboardmode then
		--^
		gotoroom_u()
	elseif allowdebug and key == "'" and love.keyboard.isDown(lctrl) then
		-- Just display all tilesets and colors in the console.
		for k,v in pairs(tilesetblocks) do
			cons("==== " .. k .. " ====")
			for k2,v2 in pairs(v.colors) do
				cons("-> " .. k2)
			end
		end
	-- Now come some more of VVVVVV's keybindings!
	elseif key == "f1" and not voided_metadata then
		-- Change tileset
		switchtileset()
		local t, tilesetname = tilesetblocks[selectedtileset]
		if t.longname ~= nil then
			tilesetname = t.longname
		elseif t.name ~= nil then
			tilesetname = t.name
		else
			tilesetname = selectedtileset
		end
		temporaryroomname = langkeys(L.TILESETCHANGEDTO, {tilesetname})
		temporaryroomnametimer = 90
	elseif key == "f2" and not voided_metadata then
		-- Change tilecol
		switchtilecol()
		local c, colorname = tilesetblocks[selectedtileset].colors[selectedcolor]
		if c.name ~= nil then
			colorname = c.name
		else
			colorname = langkeys(L.TSCOLOR, {selectedcolor})
		end
		temporaryroomname = langkeys(L.TILESETCOLORCHANGEDTO, {colorname})
		temporaryroomnametimer = 90
	elseif key == "f3" and not voided_metadata then
		-- Change enemy type
		switchenemies()
		temporaryroomname = L.ENEMYTYPECHANGED
		temporaryroomnametimer = 90
	elseif key == "f4" and not voided_metadata then
		-- Enemy bounds
		changeenemybounds()
	elseif key == "f5" and not voided_metadata then
		-- Platform bounds
		changeplatformbounds()
	elseif key == "f10" and not voided_metadata then
		-- Auto/manual mode
		changedmode()
		local modename
		if levelmetadata_get(roomx, roomy).directmode == 1 then
			modename = L.CHANGEDTOMODEMANUAL
		elseif levelmetadata_get(roomx, roomy).auto2mode == 1 then
			modename = L.CHANGEDTOMODEMULTI
		else
			modename = L.CHANGEDTOMODEAUTO
		end
		temporaryroomname = langkeys(L.CHANGEDTOMODE, {modename})
		temporaryroomnametimer = 90
	elseif key == "w" and not voided_metadata then
		-- Change warp dir
		changewarpdir()
		temporaryroomname = warpdirchangedtext[levelmetadata_get(roomx, roomy).warpdir]
		temporaryroomnametimer = 90
	elseif key == "e" and not voided_metadata then
		-- Edit room name
		toggleeditroomname()

		-- Stop that extra e from getting into the roomname...
		nodialog = false
	elseif key == "s" then
		-- Save
		--tostate(8)
		if keyboard_eitherIsDown(ctrl) and editingmap ~= "untitled\n" then
			-- Quicksave- we have a name already

			-- Maybe we have a massive map... Or a slow computer
			temporaryroomname = L.BUSYSAVING
			temporaryroomnametimer = 9000 -- Surely saving a map won't take more than ~5 minutes, would it? I mean...

			love.graphics.clear(); love.draw(); love.graphics.present()

			-- Save now
			savedsuccess, savederror = savelevel(editingmap .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, extra, false)

			if not savedsuccess then
				-- Why not :c
				dialog.create(L.SAVENOSUCCESS .. anythingbutnil(savederror))
			else
				temporaryroomname = langkeys(L.SAVEDLEVELAS, {editingmap})
				temporaryroomnametimer = 90
			end
		else
			dialog.create(
				L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, DBS.OKCANCEL,
				dialog.callback.save, nil, dialog.form.save_make()
			)
		end
	elseif key == "l" then
		-- Load
		tostate(6)
	elseif editingbounds == 0 and table.contains({"return", "kpenter"}, key) then
		-- Play
		playtesting_start(keyboard_eitherIsDown("shift"))
	elseif key == "n" and keyboard_eitherIsDown(ctrl) then
		-- New level?
		if has_unsaved_changes() then
			dialog.create(
				L.SURENEWLEVELNEW, DBS.SAVEDISCARDCANCEL,
				dialog.callback.surenewlevel, nil, nil,
				dialog.callback.noclose_on.save
			)
		else
			triggernewlevel()
		end
	elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("y") then
		-- No wait redo
		redo()
	elseif not holdingzvx and (key == "c" or key == "v" or key == "z" or key == "x" or key == "h" or key == "b" or key == "f") then -- Tried cleaning this bit up, later I realized why it was like this
		if keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("z") then
			-- We goofed, undo.
			undo()
		-- Redo code had to be moved
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("x") then
			-- Cut the room!
			cutroom()
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("c") then
			-- Copy the room!
			copyroom()
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("v") then
			-- Try pasting
			pasteroom()
		elseif key == "z" then
			-- 3x3 brush
			if table.contains({1,2,3,5,7,8,9,10,12}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 2

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "x" then
			-- 5x5 brush
			if table.contains({1,2,3,7,8,9}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 3

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "c" then
			-- Alright, 7x7 brush
			if table.contains({1,2,3,7,8,9}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 4

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "v" then
			-- And 9x9 brush
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 5

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "h" then
			-- Horizontal
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 6

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "b" then
			-- Vertical
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 7

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "f" then
			-- Fill bucket
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 9

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		end
	elseif key == "f11" and temporaryroomnametimer == 0 and not keyboard_eitherIsDown(ctrl) then
		user_reload_tilesets()
	elseif selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0 and (key == "lshift" or key == "rshift") then
		if customsizemode <= 2 then
			customsizemode = 3
		else
			customsizemode = 1
		end
	elseif editingbounds == 0 and not tilespicker_shortcut and key == "escape" then
		tilespicker = false
	else
		for k,v in pairs(toolshortcuts) do
			if key == v:lower() then
				if selectedtool == k and k ~= 13 and k ~= 14 then
					-- We're re-pressing this button, so set the subtool to the first one.
					selectedsubtool[k] = 1
				elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					selectedtool = k
					updatewindowicon()
				end
				toolscroll()
			end
		end
	end
end
