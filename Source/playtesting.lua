-- Quick overview:
-- When the user presses the play button or presses Enter, it calls playtesting_start()
-- which then sets playtesting_askwherestart to true, then when they indicate where they want to start,
-- playtesting_endaskwherestart() will set it to false, then call playtesting_execute(),
-- which will start a thread that just io.popen()s VVVVVV (or VVVVVV-CE) with command line args to immediately load the level.

function playtesting_execute(path, thisroomx, thisroomy, posx, posy, gravitycontrol)
	thisroomx = thisroomx + 100
	thisroomy = thisroomy + 100

	posx = posx - 6
	posy = posy - 2

	local music = metadata.levmusic
	if music == 0 then
		music = -1
	end

	path = path:gsub("\\", "\\\\"):gsub(" ", "\\ ")
	local vvvvvv = path

	local run = {
		vvvvvv,
		"-p",
		"special/stdin",
		"-playx",
		posx,
		"-playy",
		posy,
		"-playrx",
		thisroomx,
		"-playry",
		thisroomy,
		"-playgc",
		gravitycontrol,
		"-playmusic",
		music
	}
	run = table.concat(run, " ")

	local commands = {
		run,
	}

	cons("RUNNING VVVVVV WITH THESE COMMANDS:\n" .. table.concat(commands, "\n"))

	if playtestthread == nil then
		playtestthread = love.thread.newThread("playtestthread.lua")
	end
	playtestthread:start(table.concat(commands, "\n"), playtesting_levelcontents)
	-- Don't leave this laying around
	playtesting_levelcontents = ""

	playtesting_active = true
end

function playtesting_locate_path()
	if metadata.target == "V" then
		return s.vvvvvv23
	elseif metadata.target == "VCE" then
		return s.vvvvvvce
	end
end

function playtesting_validate_path(thepath)
	return file_exists(thepath)
end

function playtesting_get_vvvvvv_message()
	if metadata.target == "V" then
		if table.contains({"Linux", "OS X"}, love.system.getOS()) then
			return langkeys(L.VVVVVVFILE, {"VVVVVV"})
		elseif love.system.getOS() == "Windows" then
			return langkeys(L.VVVVVVFILE, {"VVVVVV.exe"})
		end
	elseif metadata.target == "VCE" then
		if table.contains({"Linux", "OS X"}, love.system.getOS()) then
			return langkeys(L.VVVVVVFILE, {"VVVVVV-CE"})
		elseif love.system.getOS() == "Windows" then
			return langkeys(L.VVVVVVFILE, {"VVVVVV-CE.exe"})
		end
	end
end

function playtesting_start()
	if not playtesting_available then
		dialog.create(langkeys(L.PLAYTESTUNAVAILABLE, {love.system.getOS()}))
		return
	end

	if playtesting_active then
		dialog.create(L.ALREADYPLAYTESTING)
		return
	end

	local path = playtesting_locate_path()

	if path == nil or path == "" then
		local files = dialog.form.files_make(userprofile, "", "", true, 9, 2)
		dialog.create(
			playtesting_get_vvvvvv_message(),
			DBS.OKCANCEL,
			dialog.callback.locatevvvvvv,
			langkeys(L.LOCATEVVVVVV, {metadata.target == "VCE" and "VVVVVV-CE" or "VVVVVV 2.3"}),
			files,
			dialog.callback.locatevvvvvv_validate
		)
		return
	end

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
	else
		playtesting_askwherestart = true

		-- Ah crud a global
		playtesting_levelcontents = thissavederror
	end
end

function playtesting_endaskwherestart()
	playtesting_askwherestart = false

	local path = playtesting_locate_path()

	if path == nil then -- Good job user, you unnecessarily changed it after it was valid
		dialog.create(L.CHANGINGPATHAFTERASK)
		playtesting_cancelask()
		return
	end

	local atx, aty = love.mouse.getPosition()
	local flipped = false
	atx = atx - screenoffset

	atx = math.floor(atx / 2)
	aty = math.floor(aty / 2)

	if not keyboard_eitherIsDown("alt") then
		atx, aty, flipped = playtesting_snap_position(atx, aty, flipped)
	end

	if keyboard_eitherIsDown("shift") then
		flipped = not flipped
	end

	local gravitycontrol = 0
	if flipped then
		gravitycontrol = 1
	end

	playtesting_execute(path, roomx, roomy, atx, aty, gravitycontrol)
end

function playtesting_cancelask()
	playtesting_askwherestart = false
end

function playtesting_snap_position(posx, posy, flipped)
	-- Snap onto a checkpoint/start position.
	-- If there's multiple in the same place, prioritize based on which top-left corner the cursor is on.
	-- Otherwise, attempt to snap onto a floor or ceiling.
	-- Otherwise, attempt to snap onto a wall.
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

	local function correctentitypos(ent)
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

	if #matchingentities == 1 then
		return correctentitypos(matchingentities[1])
	elseif #matchingentities > 1 then
		local usethisentity

		local nested_break = false
		for tiley = 29, 0, -1 do
			for tilex = 39, 0, -1 do
				for _, ent in pairs(matchingentities) do
					if ent.x == tilex and ent.y == tiley then
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

		return correctentitypos(usethisentity)
	end

	return posx, posy, flipped
end
