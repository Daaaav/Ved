local ui = {name = "levelslist"}

function ui.load(...)
	if oldstate == 1 and levelmetadata ~= nil then -- if levelmetadata is nil, it's clear we don't have a level loaded so going "back" to the editor will be a small disaster
		-- We'll be able to go back. Show this by making a screenshot
		if love_version_meets(11) then
			love.graphics.captureScreenshot(
				function(imgdata)
					editorscreenshot = love.graphics.newImage(imgdata)
				end
			)
		else
			editorscreenshot = love.graphics.newImage(love.graphics.newScreenshot())
		end
		state6old1 = true
	end

	if ... == "secondlevel" then
		-- This is the second level we're loading!
		secondlevel = true
	else
		secondlevel = false
	end

	-- Input should've been stopped, but it isn't always stopped apparently.
	stopinput()
	input = ""
	input_r = ""

	--loadlevelsfolder()

	oldinput = ""
	tabselected = 0
	backupscreen = false
	currentbackupdir = ""
	levellistscroll = 0
	max_levellistscroll = 0
end

ui.elements = {
	DrawingFunction(drawlevelslist)
}

function ui.draw()
end

function ui.update(dt)
	if updatescrollingtext ~= nil then
		updatescrollingtext_pos = updatescrollingtext_pos + 55*dt
		if updatescrollingtext_pos > font8:getWidth(updatescrollingtext) + 112 then
			updatescrollingtext_pos = 0
		end
	end
	if current_scrolling_leveltitle_k ~= nil then
		current_scrolling_leveltitle_pos = current_scrolling_leveltitle_pos + 55*dt
		if current_scrolling_leveltitle_pos > font8:getWidth(anythingbutnil(current_scrolling_leveltitle_title)) + 168 then
			current_scrolling_leveltitle_pos = 0
		end
	end
	if current_scrolling_levelfilename_k ~= nil then
		current_scrolling_levelfilename_pos = current_scrolling_levelfilename_pos + 55*dt
		if current_scrolling_levelfilename_pos > font8:getWidth(current_scrolling_levelfilename_filename) + (s.psmallerscreen and 50-12 or 50)*8 then
			current_scrolling_levelfilename_pos = 0
		end
	end

	local chanmessage = allmetadata_outchannel:pop()

	if chanmessage ~= nil and chanmessage.refresh == levels_refresh then
		-- This file could have been (visually) removed by the debug function Shift+F3
		if files[chanmessage.dir][chanmessage.id] ~= nil then
			files[chanmessage.dir][chanmessage.id].metadata = chanmessage
		end

		-- Is this also the metadata for any recent file? TODO: Support subdirectories
		for k,v in pairs(s.recentfiles) do
			if chanmessage.path == v .. ".vvvvvv" then
				recentmetadata_files[v] = chanmessage.id
			end
		end
	end
end

function ui.keypressed(key)
	if nodialog and key == "n" and keyboard_eitherIsDown(ctrl) then
		-- New level?
		if not state6old1 then
			stopinput()
			triggernewlevel()
			-- Don't immediately trigger the dialog in state 1!
			nodialog = false
		elseif has_unsaved_changes() then
			-- Else block also runs if state == 6 and state6old1, and thus makes a dialog appear; hey a free feature!
			dialog.create(
				L.SURENEWLEVELNEW, DBS.SAVEDISCARDCANCEL,
				dialog.callback.surenewlevel, nil, nil,
				dialog.callback.noclose_on.save
			)
		else
			triggernewlevel()
		end
	elseif nodialog and key == "f11" and temporaryroomnametimer == 0 and not keyboard_eitherIsDown(ctrl) then
		user_reload_tilesets()
	elseif key == "f1" then
		stopinput()
		tostate(15)
	elseif table.contains({"return", "kpenter"}, key) and tabselected == 0 then
		state6load(input .. input_r)
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
				stopinput()
				tostate(1, true)
			end
		end
	elseif key == "f5" then
		loadlevelsfolder()
	elseif backupscreen and currentbackupdir ~= "" and key == "backspace" and nodialog then
		currentbackupdir = ""
	elseif not secondlevel and nodialog and not backupscreen and (key == "a" or key == "r") and keyboard_eitherIsDown(ctrl) then
		stopinput()
		tostate(30)
		if key == "a" then
			show_notification(L.OLDSHORTCUT_ASSETS)
		end
	elseif not secondlevel and nodialog and not backupscreen and (key == "d" or key == "f") and keyboard_eitherIsDown(ctrl) then
		explore_lvl_dir()
		if key == "d" then
			show_notification(L.OLDSHORTCUT_OPENLVLDIR)
		end
	elseif allowdebug and key == "f2" and keyboard_eitherIsDown("shift") then
		table.insert(files[""], {name="--[debug]--", isdir=false, bu_lastmodified=0, bu_overwritten=0, result_shown=true})
	elseif allowdebug and key == "f3" and keyboard_eitherIsDown("shift") then
		table.remove(files[""])
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
	if hoveringlevel ~= nil and button == "l" then
		-- Just like when going to a room by clicking on the map, we don't want to click the first tile we press.
		nodialog = false

		state6load(hoveringlevel)
	elseif hoveringlevel ~= nil and button == "r" then
		if backupscreen and currentbackupdir ~= "" then
			rightclickmenu.create({"#[" .. hoveringlevel_k .. "]", L.SAVEBACKUP}, "bul_" .. hoveringlevel:sub((".ved-sys/backups"):len()+2, -1))
		end
	end
end

function ui.mousereleased(x, y, button)
	if not secondlevel and nodialog and not backupscreen and button == "l" and onrbutton(1, nil, true) then
		-- This has to be in mousereleased, since opening a window with a mouse press prevents a mouse
		-- release event to occur, which either causes the next click to be missed, or causes a new
		-- window to be opened on focus when you try to fix that!
		explore_lvl_dir()
	end
end

return ui
