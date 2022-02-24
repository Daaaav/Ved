function love.update(dt)
	hook("love_update_start", {dt})

	if window_active() then
		focus_regained_timer = math.min(focus_regained_timer + dt, .1)
		textinput_started_timer = math.min(textinput_started_timer + dt, .1)
	else
		focus_regained_timer = 0
	end

	local current_audio = music_get_audio_playing()
	if current_audio ~= nil and current_audio.update ~= nil then
		current_audio:update()
	end

	if playtesting_active then
		local chanmessage = playtestthread_outchannel:pop()

		if chanmessage ~= nil then
			if chanmessage == PLAYTESTING.DONE then
				playtesting_active = false
			elseif chanmessage == PLAYTESTING.ERROR then
				playtesting_active = false
				local err = playtestthread_outchannel:pop()
				dialog.create(langkeys(L.PLAYTESTINGFAILED, {err}))
			end
		end
	end

	if newinputsys.active and newinputsys.getfocused() ~= nil then
		if RCMactive then
			cursorflashtime = 0
		else
			cursorflashtime = (cursorflashtime+dt) % 1
		end
	end

	if takinginput or sp_t > 0 then
		cursorflashtime = (cursorflashtime + dt) % 1
		firstchar = firstUTF8(input_r)
		if cursorflashtime <= .5 then
			__ = "_" .. input_r:sub(1 + firstchar:len())
		else
			__ = firstchar .. input_r:sub(1 + firstchar:len())
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf, cftype = dialogs[#dialogs].currentfield
		if dialogs[#dialogs].fields[cf] ~= nil then
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][DFP.T])
		end
		if cf ~= 0 and cftype == DF.TEXT then
			cursorflashtime = (cursorflashtime + dt) % 1
			firstchar = firstUTF8(anythingbutnil(dialogs[#dialogs].fields[cf][DFP.TEXT_CONTENT_R]))
			if cursorflashtime <= .5 then
				__ = "_"
			else
				__ = firstchar
			end
		end
	elseif __ ~= "_" then
		__ = "_"
	end

	if s.fpslimit_ix == 3 then
		next_frame_time = next_frame_time + 1/120
	elseif s.fpslimit_ix == 2 then
		next_frame_time = next_frame_time + 1/60
	elseif s.fpslimit_ix == 1 then
		next_frame_time = next_frame_time + 1/30
	end

	-- The timing for this doesn't really matter
	if temporaryroomnametimer > 0 then
		temporaryroomnametimer = temporaryroomnametimer - 1
	end

	-- The generic timer will be precise, though!
	if generictimer > 0 then
		generictimer = generictimer - dt
	end

	if inputcopiedtimer > 0 then
		inputcopiedtimer = inputcopiedtimer - dt
	end

	if inputdoubleclicktimer > 0 then
		inputdoubleclicktimer = inputdoubleclicktimer - dt
	elseif not love.mouse.isDown("l") then
		inputnumclicks = 0
	end

	v6_frametimer = v6_frametimer + dt
	while v6_frametimer > .034 do
		v6_help:updateglow()
		v6_graphics:updatelinestate()
		v6_graphics.trinketcolset = false

		conveyortimer = (conveyortimer + 1) % 3
		if conveyortimer == 0 then
			conveyorleftcycle = (conveyorleftcycle + 1) % 4
			conveyorrightcycle = (conveyorrightcycle + 1) % 4
		end

		v6_frametimer = v6_frametimer - .034
	end

	local title_editingmap = ""
	if editingmap ~= nil then
		title_editingmap = (has_unsaved_changes() and "*" or "") .. editingmap:gsub("\n", "") .. " - "
	end

	if allowdebug then
		love.window.setTitle(title_editingmap .. "Ved v" .. ved_ver_human() .. "  [" .. L.DEBUGMODEON .. "]  [" .. L.FPS .. ": " .. love.timer.getFPS() .. "] - " .. L.STATE .. ": " .. state .. " - " .. love.graphics.getWidth() .. "x" .. love.graphics.getHeight() .. " " .. L.MOUSE .. ": " .. love.mouse.getX() .. " " .. love.mouse.getY() .. "  [ LÖVE v" .. love._version_major .. "." .. love._version_minor .. "." .. love._version_revision .. " ]")
	elseif s.showfps then
		love.window.setTitle(title_editingmap .. "Ved v" .. ved_ver_human() .. "  [" .. L.FPS .. ": " .. love.timer.getFPS() .. "]")
	else
		local newtitle = title_editingmap .. "Ved v" .. ved_ver_human()
		if newtitle ~= savedwindowtitle then
			love.window.setTitle(newtitle)
			savedwindowtitle = newtitle
		end
	end

	if state == 1 then
		-- In the main editor, just work on the map without taking too much time.
		map_work(0.011)
	elseif state == 12 then
		-- If we're looking at the map, then it has a little higher priority.
		map_work(0.015)
	elseif lowprio_maploading_states[state] then
		-- There are states (like the script editor) where we'll load the map at low priority.
		map_work(0.005)
	end

	if coordsdialog.active or RCMactive or dialog.is_open() or playtesting_askwherestart then
		nodialog = false
	elseif not love.mouse.isDown("l") then
		nodialog = true
	end

	if middlescroll_x ~= -1 and middlescroll_y ~= -1 and (love.mouse.getY() < middlescroll_y-16 or love.mouse.getY() > middlescroll_y+16) and not middlescroll_falling then
		handle_scrolling(
			false,
			love.mouse.getY() < middlescroll_y and "wu" or "wd",
			10*dt*(math.abs(love.mouse.getY()-middlescroll_y)-16),
			middlescroll_x, middlescroll_y
		)
	end
	if middlescroll_falling then
		middlescroll_fall_update(dt)
	elseif middlescroll_shatter then
		middleclick_shatter_update(dt)
	elseif middlescroll_rolling ~= 0 then
		middleclick_roll_update(dt)
	end

	updatecheck.await_response()

	local callback_state = state
	if uis[state] ~= nil and uis[state].update ~= nil then
		uis[state].update(dt)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, dt)
			if e.update ~= nil then
				e:update(dt)
			end
		end
		for k,v in pairs(uis[state].elements) do
			caller(v, dt)
			if v.recurse ~= nil then
				v:recurse("update", caller, dt)
			end
		end
	end

	hook("love_update_end", {dt})

	dialog.update(dt)
	boxupdate()

	if s.pausedrawunfocused and not window_active() then
		-- Save some more CPU time
		love.timer.sleep(.1)
	end
end
