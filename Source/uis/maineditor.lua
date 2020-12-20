local ui = {name = "maineditor"}

function ui.load()
	tilespicker = false
	tilespicker_shortcut = false
	selectedtool = 1; selectedsubtool = {1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1, 1,1,1}
	selectedtile = 1
	selectedtileset = 0 --"spacestation" --"outside"
	selectedcolor = 0 --"c9" --"red"
	lefttoolscroll = 16 -- offset
	leftsubtoolscroll = 16
	zoomscale = 1 -- Or 1/2 or 1/4 or w/e
	dropdown = 0
	roomx = 0
	roomy = 0
	altstate = 0
	updatewindowicon()

	if levelmetadata ~= nil and levelmetadata_get(roomx, roomy) ~= nil then
		gotoroom_finish()
	end

	editingroomtext = 0
	newroomtext = false
	editingroomname = false
	movingentity = 0
	movingentity_copying = false
	upperoptpage2 = false
	warpid = nil
	oldscriptx, oldscripty, oldscriptp1, oldscriptp2 = 0, 0, 0, 0
	oldbounds = {0, 0, 0, 0}

	minsmear = -1; maxsmear = -1

	holdingzvx = false
	oldzxsubtool = 1

	undobuffer = {}
	redobuffer = {}
	undosaved = 0
	unsavedchanges = false
	saved_at_undo = 0

	editingbounds = 0
	showepbounds = true

	mouselockx = -1
	mouselocky = -1

	warpbganimation = 0

	customsizemode = 1 -- 0: using, 1: changing size (or needing to click first tile in tiles picker, 2: needing to click second tile in tiles picker), 3: needing to click top left in a room because I misunderstood the request all along, 4: needing to click bottom right of that.
	customsizex = 0 -- tiles to the left AND right of the cursor (can be a half)
	customsizey = 0 -- tiles to the top AND bottom of the cursor
	customsizetile = nil -- what group of tiles to draw with this special cursor (2D table)
	customsizecoorx = nil -- coordinates of tile selected in mode 3
	customsizecoory = nil

	eraserlocked = false
	keyboardmode = false
end

ui.elements = {
}

function ui.draw()
	drawmaineditor()
end

function ui.update(dt)
	if (editingbounds == -1 or editingbounds == 1) and selectedtool ~= 9 then
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
			finish_undo("ENEMY BOUNDS (tool canceled)")
		end

		editingbounds = 0
	elseif (editingbounds == -2 or editingbounds == 2) and selectedtool ~= 8 then
		if editingbounds == 2 then
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
			finish_undo("PLATFORM BOUNDS (tool canceled)")
		end

		editingbounds = 0
	end

	if sp_t ~= 0 and not sp_go then
		sp_tim = sp_tim + dt
		if sp_tim > .33 then
			sp_tim = 0
			sp_tap()
		end
	end
	if sp_t ~= 0 and sp_go and sp_got > 0 then
		sp_got = sp_got - dt
	end

	if levelmetadata_get(roomx, roomy).warpdir == 3 then
		warpbganimation = (warpbganimation + 2) % 64
	elseif levelmetadata_get(roomx, roomy).warpdir ~= 0 then
		warpbganimation = (warpbganimation + 3) % 32
	end

	if vedmetadata == nil then
		cons("vedmetadata == nil! Setting to false.")
		vedmetadata = false
	end

	if keyboardmode and love.timer.getTime() % 0.02 < 0.007 then
		--[[ Experimental and still very annoying.
		You want to be able to:
		* Move one tile by pressing once
		* Smoothly move multiple times at a reasonable speed, not too fast not too slow
		* Move diagonally and such
		]]
		local x, y = love.mouse.getPosition(x,y)
		local changed = false
		if love.keyboard.isDown("right") or love.keyboard.isDown("kp6") then
			x = x + 16
			changed = true
		end
		if love.keyboard.isDown("left") or love.keyboard.isDown("kp4") then
			x = x - 16
			changed = true
		end
		if love.keyboard.isDown("down") or love.keyboard.isDown("kp2") then
			y = y + 16
			changed = true
		end
		if love.keyboard.isDown("up") or love.keyboard.isDown("kp8") then
			y = y - 16
			changed = true
		end
		if changed then
			love.mouse.setPosition(x,y)
		end
	end
end

function ui.keypressed(key)
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

	local _, voided_metadata = levelmetadata_get(roomx, roomy)

	if keyboard_eitherIsDown("shift") and keyboard_eitherIsDown(ctrl) then
		tilespicker = true
		if not love.keyboard.isDown("rshift") and not love.keyboard.isDown(rctrl) then
			tilespicker_shortcut = true
		end

		local tsw = tilesets[tilesetnames[usedtilesets[selectedtileset]]].tileswidth
		local tsh = tilesets[tilesetnames[usedtilesets[selectedtileset]]].tilesheight
		if levelmetadata_get(roomx, roomy).directmode == 1 then
			if table.contains({"left", "a"}, key) then
				selectedtile = selectedtile - 1
			elseif table.contains({"right", "d"}, key) then
				selectedtile = (selectedtile + 1) % (tsw*tsh)
			elseif table.contains({"up", "w"}, key) then
				selectedtile = selectedtile - tsw
			elseif table.contains({"down", "s"}, key) then
				selectedtile = (selectedtile + tsw) % (tsw*tsh)
			end
		end

		if selectedtile < 0 then
			selectedtile = selectedtile + tsw*tsh
		end

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
				if metadata.target == "VCE" then
					selectedtool = 20
				end
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
			if metadata.target == "VCE" then
				tool_count = 20
			end
			if selectedtool < tool_count then
				selectedtool = selectedtool + 1
			else
				selectedtool = 1
			end
			updatewindowicon()
			toolscroll()
		end

	elseif key == "q" or key == "g" then
		coordsdialog.activate()
		if key == "q" then
			show_notification(L.OLDSHORTCUT_GOTOROOM)
		end
	elseif metadata.target == "VCE" and key == "a" then
		next_altstate()
		if altstate == 0 then
			temporaryroomname = L.SWITCHEDTOALTSTATEMAIN
		else
			temporaryroomname = langkeys(L.SWITCHEDTOALTSTATE, {altstate})
		end
		temporaryroomnametimer = 90
	elseif key == "m" or key == "kp5" then
		tostate(12)
		return -- temporary, until state 1 got GUI overhaul and this is in ui.keypressed
	elseif playtesting_askwherestart and key == "escape" then
		playtesting_cancelask()
	elseif key == "/" then
		if keyboard_eitherIsDown(ctrl) then
			tonotepad()
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
	elseif key == "tab" then
		eraserlocked = not eraserlocked
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
	elseif allowdebug and key == "\\" and love.keyboard.isDown(lctrl) then
		cons("*** TILESET COLOR CREATOR STARTED FOR TILESET " .. usedtilesets[levelmetadata_get(roomx, roomy).tileset] .. " ***")
		cons("First select the wall tiles")

		tilescreator = true
		cb = {}
		ca = {}
		cs = {}
		creatorstep = 1
		creatorsubstep = 1

		usedtilesets.creator = usedtilesets[selectedtileset]
		selectedtileset = "creator"
		selectedcolor = "creator"

		tilesetblocks.creator.tileimg = usedtilesets[levelmetadata_get(roomx, roomy).tileset]

		tilespicker = true
		selectedtool = 1

		mousepressed = false
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
	elseif metadata.target == "VCE" and levelmetadata_get(roomx, roomy).tower == 0 and key == "f6" then
		-- Add altstate
		local new_altstate = add_altstate(roomx, roomy)
		altstate = new_altstate
		temporaryroomname = langkeys(L.ADDEDALTSTATE, {new_altstate})
		temporaryroomnametimer = 90
	elseif metadata.target == "VCE" and key == "f9" and keyboard_eitherIsDown(ctrl) and not voided_metadata then
		-- customtileset/customspritesheet dialog
		dialog.create("", DBS.OKCANCEL, dialog.callback.vcecustomgraphics, L.CUSTOMGRAPHICS,
			dialog.form.vcecustomgraphics_make(levelmetadata_get(roomx, roomy))
		)
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
		playtesting_start()
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
			if table.contains({1,2,3,5,7,8,9,10,12,19}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 2

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "x" then
			-- 5x5 brush
			if table.contains({1,2,3,7,8,9,19}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 3

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "c" then
			-- Alright, 7x7 brush
			if table.contains({1,2,3,7,8,9,19}, selectedtool) then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 4

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "v" then
			-- And 9x9 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 19 then
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
			local shiftdown = false
			if metadata.target == "VCE" then
				shiftdown = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
			end
			if key == string.lower(v) then
				if (selectedtool == k and k ~= 13 and k ~= 14) and (shiftdown and (k ~= 1 and k ~= 2 and k ~= 3)) then
					-- We're re-pressing this button, so set the subtool to the first one.
					selectedsubtool[k] = 1
				elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					-- Weird hack to make shift + number tools possible
					if shiftdown and (k == 1 or k == 2 or k == 3) then
						selectedtool = k + 17
					else
						selectedtool = k
					end
					updatewindowicon()
				end
				toolscroll()
			end
		end
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
	if x < 64 and not s.psmallerscreen and not (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) then
		if button == "wu" then
			lefttoolscroll = lefttoolscroll + 16
			lefttoolscrollbounds()
		elseif button == "wd" then
			lefttoolscroll = lefttoolscroll - 16
			lefttoolscrollbounds()
		end
	elseif mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-16-2-4-8, (6*16), 8+4) then -- show all tiles
		tilespicker = not tilespicker
		editingroomname = false

	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wd" or "wu") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		if selectedtool > 1 then
			selectedtool = selectedtool - 1
		else
			selectedtool = 17
			if metadata.target == "VCE" then
				selectedtool = 20
			end
		end
		updatewindowicon()
		toolscroll()
	elseif (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wu" or "wd") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
		local tool_count = 17
		if metadata.target == "VCE" then
			tool_count = 20
		end
		if selectedtool < tool_count then
			selectedtool = selectedtool + 1
		else
			selectedtool = 1
		end
		updatewindowicon()
		toolscroll()
	elseif button == flipscrollmore(macscrolling and "wd" or "wu") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
		if selectedsubtool[selectedtool] > 1 then
			selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
		else
			selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
		end
	elseif button == flipscrollmore(macscrolling and "wu" or "wd") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
		if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
			selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
		else
			selectedsubtool[selectedtool] = 1
		end
	end
end

function ui.mousereleased(x, y, button)
	if undosaved ~= 0 and undobuffer[undosaved] ~= nil then
		undobuffer[undosaved].toredotiles = table.copy(roomdata_get(roomx, roomy, altstate))
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	end
end

return ui
