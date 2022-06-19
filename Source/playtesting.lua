--[[
	Quick overview:

	The playtesting UI state controls the interface, and the engine state tracks the state of the
	playtesting thread. Normally, the UI state is OFF (playtesting_uistate == PT_UISTATE.OFF).
	When the user presses the play button or presses Enter, it calls playtesting_start(force_ask_path)
	which then sets the UI state to ASKING. Then when they indicate where they want to start,
	playtesting_endaskwherestart() will call playtesting_execute(), which sets the UI state to
	PLAYTESTING, and tells the playtesting thread to open VVVVVV with the level.

	The engine state can be one of the following:
	OFF - The thread is not running
	IDLE - The thread is running and (almost) waiting to receive level data and starting position
	PLAYTESTING - Currently playtesting (cannot be stopped by user except by closing VVVVVV)
	CANCELING - Going from IDLE to OFF, thread is terminating

	In which states VVVVVV is or isn't running depends on the VVVVVV version and is up to the thread.
	For example, VVVVVV 2.3 is only started when going to the PLAYTESTING state, but VVVVVV 2.4+ can
	already be started when going to IDLE (and will thus be shut down in the CANCELING state)

	When the thread terminates, it will give a message via its out channel.
	This can be PT_RESULT.DONE for success, or PT_RESULT.ERROR followed by a message for an error.
	This result being received is the only thing that can change the engine state from any other
	state to OFF, and the engine state needs to be OFF before the thread can be started again.
]]


function playtesting_execute(thisroomx, thisroomy, posx, posy, gravitycontrol)
	-- Going from playtesting uistate ASKING to PLAYTESTING (part 2)

	if playtesting_engstate ~= PT_ENGSTATE.IDLE then
		-- Should not happen
		dialog.create("Unexpected playtesting engine state " .. playtesting_engstate .. " in playtesting_execute")
		return
	end

	thisroomx = thisroomx + 100
	thisroomy = thisroomy + 100

	posx = posx - 6
	posy = posy - 2

	local music = metadata.levmusic
	if music == 0 then
		music = -1
	end

	playtesting_engstate = PT_ENGSTATE.PLAYTESTING
	playtesting_uistate = PT_UISTATE.PLAYTESTING

	-- Give the thread the last data and the go-ahead
	playtestthread_inchannel:push(PT_CMD.DATA_POS)
	playtestthread_inchannel:push(
		{
			x = posx,
			y = posy,
			rx = thisroomx,
			ry = thisroomy,
			gc = gravitycontrol,
			music = music
		}
	)
	playtestthread_inchannel:push(PT_CMD.GO)
end

function playtesting_locate_path()
	if metadata.target == "V" then
		return s.vvvvvv23
	end
end

function playtesting_ask_path_manual(target, continue_playtesting)
	local ext = ""
	if love.system.getOS() == "Windows" then
		ext = ".exe"
	end
	local files = dialog.form.files_make(userprofile, "", ext, true, 9, 2)
	dialog.create(
		playtesting_get_vvvvvv_message(target),
		DBS.OKCANCEL,
		dialog.callback.locatevvvvvv,
		langkeys(L.LOCATEVVVVVV, {"VVVVVV 2.3"}),
		dialog.form.hidden_make({target=target, start=continue_playtesting}, files),
		dialog.callback.locatevvvvvv_validate
	)
end

function playtesting_validate_path(thepath)
	return file_exists(thepath)
end

function playtesting_get_vvvvvv_message(target)
	if target == "V" then
		if table.contains({"Linux", "OS X"}, love.system.getOS()) then
			return langkeys(L.VVVVVVFILE, {"VVVVVV"})
		elseif love.system.getOS() == "Windows" then
			return langkeys(L.VVVVVVFILE, {"VVVVVV.exe"})
		end
	end
end

function playtesting_ask_path_autodetect(target, continue_playtesting)
	dialog.create(
		L.FIND_V_EXE_EXPLANATION,
		{L.BTN_AUTODETECT, L.BTN_MANUALLY, DB.CANCEL},
		dialog.callback.locatevvvvvvchoice,
		nil,
		dialog.form.hidden_make({target=target, start=continue_playtesting})
	)
end

function playtesting_ask_path(target, continue_playtesting)
	if autodetect_vvvvvv_available then
		playtesting_ask_path_autodetect(target, continue_playtesting)
	else
		playtesting_ask_path_manual(target, continue_playtesting)
	end
end

function playtesting_start(force_ask_path)
	-- Going from playtesting uistate OFF to ASKING

	if not playtesting_available then
		dialog.create(langkeys(L.PLAYTESTUNAVAILABLE, {love.system.getOS()}))
		return
	end

	if playtesting_engstate == PT_ENGSTATE.PLAYTESTING
	or playtesting_engstate == PT_ENGSTATE.CANCELING then
		dialog.create(L.ALREADYPLAYTESTING)
		return
	end

	if playtesting_uistate == PT_UISTATE.ASKING then
		-- Apparently we pressed Enter twice.
		atx, aty, flipped = playtesting_find_first_checkpoint()
		playtesting_endaskwherestart(atx, aty, flipped, true)
		return
	end

	if playtestthread:isRunning() then
		-- Should not happen - unless we add support for earlier preloading!
		dialog.create("Playtesting thread is unexpectedly already running!")
		return
	end

	local path
	if not force_ask_path then
		path = playtesting_locate_path()
	end

	if path == nil or path == "" then
		playtesting_ask_path(metadata.target, true)
		return
	end

	-- Time to start the thread
	playtesting_engstate = PT_ENGSTATE.IDLE
	playtesting_uistate = PT_UISTATE.ASKING

	cons("RUNNING VVVVVV AT THIS PATH:\n" .. path)
	playtestthread_inchannel:clear()
	playtestthread:start(path, editingmap, L)

	-- We have to save the level. Unfortunately, this will freeze Ved for a bit
	-- TODO: Put this in a thread somehow... then in a stroke of sneaky UX genius,
	-- we'll just save the level WHILE we're asking the player where they want to start!
	-- Then they won't get the impression that Ved takes a while to start playtesting (because of the level-saving),
	-- because we're doing it behind their backs while they're not looking!
	-- Mwahahaha!
	--
	-- Only problem is: savelevel() has TONS of dependencies, so do this later

	-- Note: thissavederror will contain level contents if not an error
	local thissavedsuccess, thissavederror = savelevel(nil, metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, extra, false, false)

	if not thissavedsuccess then
		dialog.create(L.SAVENOSUCCESS .. anythingbutnil(thissavederror))
		playtesting_cancelask()
	else
		playtesting_uistate = PT_UISTATE.ASKING

		playtestthread_inchannel:push(PT_CMD.DATA_LEVEL)
		playtestthread_inchannel:push(thissavederror)
	end
end

function playtesting_endaskwherestart(atx, aty, flipped, nosnap)
	-- Going from playtesting uistate ASKING to PLAYTESTING (part 1)

	if flipped == nil then
		flipped = false
	end

	if not nosnap and not keyboard_eitherIsDown("alt") then
		atx, aty, flipped = playtesting_snap_position(atx, aty, flipped)
	end

	if keyboard_eitherIsDown("shift") then
		flipped = not flipped
	end

	local gravitycontrol = 0
	if flipped then
		gravitycontrol = 1
	end

	playtesting_execute(roomx, roomy, atx, aty, gravitycontrol)
end

function playtesting_cancelask()
	-- Going from playtesting uistate ASKING to OFF
	if playtesting_engstate ~= PT_ENGSTATE.IDLE then
		-- Should not happen
		dialog.create("Unexpected playtesting engine state " .. playtesting_engstate .. " in playtesting_cancelask")
		return
	end

	playtesting_engstate = PT_ENGSTATE.CANCELING
	playtesting_uistate = PT_UISTATE.OFF

	playtestthread_inchannel:push(PT_CMD.CANCEL)
end

function playtesting_correctentitypos(ent, flipped)
	if ent.t == 10 then
		if ent.p1 == 0 then
			return 8*(ent.x%40) + 2, 8*(ent.y%30), true
		else
			return 8*(ent.x%40) + 2, 8*(ent.y%30) - 5, false
		end
	elseif ent.t == 16 then
		return 8*(ent.x%40) + 2, 8*(ent.y%30) + 3, flipped
	end
end

function playtesting_snap_position(posx, posy, flipped)
	-- Snap onto a checkpoint/start position.
	-- If there's multiple in the same place, prioritize based on which top-left corner the cursor is on.
	-- Otherwise, give up and just let the player float there.

	local entities = {}
	-- Get all checkpoints in the room, and the start point too, if it's in the room
	for _, ent in pairs(entitydata) do
		if ent.x >= 40 * roomx and ent.x < 40 * (roomx+1)
		and ent.y >= 30 * roomy and ent.y < 30 * (roomy+1)
		and table.contains({10, 16}, ent.t) then
			table.insert(entities, ent)
		end
	end

	local matchingentities = {}
	for _, ent in pairs(entities) do
		if ent.t == 10 then
			-- Check checkpoint hitbox, 2x2
			if mouseon(screenoffset + 16*(ent.x%40), 16 * (ent.y%30), 32, 32) then
				table.insert(matchingentities, ent)
			end
		elseif ent.t == 16 then
			-- Check start point hitbox, 2x3
			if mouseon(screenoffset + 16*(ent.x%40), 16 * (ent.y%30), 32, 48) then
				table.insert(matchingentities, ent)
			end
		end
	end

	if #matchingentities == 1 then
		return playtesting_correctentitypos(matchingentities[1], flipped)
	elseif #matchingentities > 1 then
		local usethisentity

		local nested_break = false
		for tiley = 29, 0, -1 do
			for tilex = 39, 0, -1 do
				for _, ent in pairs(matchingentities) do
					if ent.x % 40 == tilex and ent.y % 30 == tiley then
						usethisentity = ent
						nested_break = true
						break
					end
				end

				if nested_break then
					break
				end
			end
			if nested_break then
				break
			end
		end

		return playtesting_correctentitypos(usethisentity, flipped)
	end

	return posx, posy, flipped
end

function playtesting_find_first_checkpoint()
	-- Replicate VVVVVV's playtesting behavior:
	-- Start at the startpoint if it's in the room, otherwise the first checkpoint.
	-- If all fails, just spawn in the center, why not.
	-- Returns x/y position to place the player at.

	local first_checkpoint = nil

	for k,v in pairs(entitydata) do
		if (v.t == 16 or v.t == 10)
		and v.x >= roomx*40 and v.x <= roomx*40+39
		and v.y >= roomy*30 and v.y <= roomy*30+29 then
			if v.t == 16 then
				-- Start point, we done
				return playtesting_correctentitypos(v, false)
			end
			if v.t == 10 and first_checkpoint == nil then
				-- It's the first checkpoint, but we might still find the start point...
				first_checkpoint = v
			end
		end
	end

	if first_checkpoint ~= nil then
		return playtesting_correctentitypos(first_checkpoint, false)
	end

	-- Just spawn where VVVVVV would spawn you for a level without a start point
	return 160, 120, false
end
