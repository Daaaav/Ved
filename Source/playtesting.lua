-- Quick overview:
-- playtesting_init_veduser() is called in love.load() and takes care of making our own XDG_DATA_HOME (or OS equivalent)
-- When the user presses the play button or presses Enter, it calls playtesting_start()
-- which then sets playtesting_askwherestart to true, then when they indicate where they want to start,
-- playtesting_endaskwherestart() will set it to false, then call playtesting_execute_<os>(),
-- which will start a thread that just io.popen()s VVVVVV with libvloader.

function playtesting_init_veduser()
	if not love.filesystem.exists("veduser") then
		love.filesystem.createDirectory("veduser")
	end
	if not love.filesystem.exists("veduser/VVVVVV") then
		love.filesystem.createDirectory("veduser/VVVVVV")
	end
	if not love.filesystem.exists("veduser/VVVVVV/saves") then
		love.filesystem.createDirectory("veduser/VVVVVV/saves")
	end
	if not love.filesystem.exists("veduser/VVVVVV/levels") then
		love.filesystem.createDirectory("veduser/VVVVVV/levels")
	end
end

function playtesting_execute_linmac(path, thisroomx, thisroomy, posx, posy, gravitycontrol, with_gdb)
	if with_gdb == nil then
		with_gdb = false
	end

	thisroomx = thisroomx + 100
	thisroomy = thisroomy + 100

	posx = posx - 6
	posy = posy - 2

	local music = metadata.levmusic
	if music == 0 then
		music = -1
	end

	local envvars = {}

	local vvvvvv = path .. "/VVVVVV-CE"

	-- Syntax is <vvvvvv> <index of level in levels list> <savex> <savey> <saverx> <savery> <savegc> <music id>
	local run = {
		vvvvvv,
		"-p",
		love.filesystem.getSaveDirectory() .. "/veduser/VVVVVV/levels/ved_playtesting_temp.vvvvvv",
		"--playx",
		posx,
		"--playy",
		posy,
		"--playrx",
		thisroomx,
		"--playry",
		thisroomy,
		"--playgc",
		gravitycontrol,
		"--playmusic",
		music
	}
	run = table.concat(run, " ")

	path = path:gsub("\\", "\\\\"):gsub(" ", "\\ ")
	local commands = {
		"cd " .. path,
	}

	if with_gdb then
		local envvars_gdb = {}
		for varname, var in pairs(envvars) do
			var = tostring(var)

			var = var:gsub("\\", "\\\\"):gsub('"', '\\"')
			table.insert(envvars_gdb, '"' .. varname .. "=" .. var .. '"')
		end
		table.insert(commands, "/usr/bin/gdb -q -ex 'set exec-wrapper env " .. table.concat(envvars_gdb, " ") .. "' -ex run --args " .. run)
	else
		for varname, var in pairs(envvars) do
			table.insert(commands, "export " .. varname .. "=" .. var)
		end
		table.insert(commands, run)
	end

	cons("RUNNING VVVVVV WITH THESE COMMANDS:\n" .. table.concat(commands, "\n"))

	if playtestthread == nil then
		playtestthread = love.thread.newThread("playtestthread.lua")
	end
	playtestthread:start(table.concat(commands, "\n"))
	playtesting_active = true
end

function playtesting_locate_path()
	-- We first try getting the Steam version, because it's always in the same place.
	-- But if that doesn't exist, we ask them where they put the non-Steam version.
	-- However, if the user already has non-Steam set in settings.lua, we'll use that.
	-- Because this priority order... (non-Steam path in config > Steam path exists > Ask for non-Steam path)
	-- ...is better than the other one, because people can easily force the Steam or non-Steam version if they want to
	-- without having to, say, move the Steam version's executable somewhere else,
	-- which they'd have to do with the other order (Steam path exists > non-Steam path in config > Ask for non-Steam path)

        if anythingbutnil(s.vvvvvvnonsteam) ~= "" and playtesting_validate_path(s.vvvvvvnonsteam) then
                -- M&P path in config
                return s.vvvvvvnonsteam
        else
                -- Ask for M&P path
                return
        end
end

function playtesting_validate_path(thepath)
	-- TODO: This is all useless until Ved has better directory-checking and file-checking filefuncs
	if love.system.getOS() == "Linux" then
		-- Check that x86_64/vvvvvv.x86_64 exists
		return true -- TEMP DEBUG
	elseif love.system.getOS() == "OS X" then
		-- Check that osx/vvvvvv.osx exists
	elseif love.system.getOS() == "Windows" then
		-- Check that VVVVVV.exe exists
	end
end

function playtesting_get_vvvvvvnonsteam_message()
	if love.system.getOS() == "Linux" then
		return langkeys(L.NONSTEAMCONTAINSFILE, {"VVVVVV-CE"})
	elseif love.system.getOS() == "OS X" then
		return langkeys(L.NONSTEAMCONTAINSFILE, {"VVVVVV-CE"})
	elseif love.system.getOS() == "Windows" then
		return langkeys(L.NONSTEAMCONTAISNFILE, {"VVVVVV-CE.exe"})
	end
end

function playtesting_start()
	if not playtesting_available then
		local usethistext
		if table.contains({"Windows", "OS X", "Linux"}, love.system.getOS()) then
			-- Yes, hardcoded English text
			-- Eventually (hopefully) this string will go unused
			usethistext = "Sorry, you currently cannot playtest on $1. But Ved will support it soon!"
		else
			usethistext = L.PLAYTESTUNAVAILABLE
		end
		dialog.create(langkeys(usethistext, {love.system.getOS()}))
		return
	end

	if playtesting_active then
		dialog.create(L.ALREADYPLAYTESTING)
		return
	end

	local path = playtesting_locate_path()

	if path == nil then
		local files = dialog.form.files_make(userprofile, "", dirsep, true, 10)
		files[1][3] = files[1][3] + 2 -- Move the y-position of the files list down, to make way for the message
		dialog.create(
			playtesting_get_vvvvvvnonsteam_message(),
			DBS.OKCANCEL,
			nil,
			L.LOCATEVVVVVVNONSTEAM,
			files,
			dialog.callback.locatevvvvvvnonsteam_validate
		)
		return
	end

	-- We have to save the level in our veduser levels directory. Unfortunately, this will freeze Ved for a bit
	-- TODO: Put this in a thread somehow... then in a stroke of sneaky UX genius,
	-- we'll just save the level WHILE we're asking the player where they want to start!
	-- Then they won't get the impression that Ved takes a while to start playtesting (because of the level-saving),
	-- because we're doing it behind their backs while they're not looking!
	-- Mwahahaha!
	--
	-- Only problem is: savelevel() has TONS of dependencies, so do this later

	-- savelevel() does too much, dangnabbit
	local oldunsavedchanges = unsavedchanges
	local oldenableoverwritebackups = s.enableoverwritebackups
	local oldrecentlyopened = recentlyopened
	local old_saved_at_undo = saved_at_undo
	s.enableoverwritebackups = false
	recentlyopened = function() end

	local thissavedsuccess, thissavederror = savelevel(love.filesystem.getSaveDirectory() .. "/veduser/VVVVVV/levels/ved_playtesting_temp.vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, nil, false, false)

	unsavedchanges = oldunsavedchanges
	s.enableoverwritebackups = oldenableoverwritebackups
	recentlyopened = oldrecentlyopened
	saved_at_undo = old_saved_at_undo

	if not thissavedsuccess then
		dialog.create(L.SAVENOSUCCESS .. anythingbutnil(thissavederror))
	else
		playtesting_askwherestart = true
		if allowdebug and playtesting_attach_gdb == nil then
			playtesting_attach_gdb = true
		end
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

	local usethisfunc
	if table.contains({"Linux", "OS X"}, love.system.getOS()) then
		usethisfunc = playtesting_execute_linmac
	end
	usethisfunc(path, roomx, roomy, atx, aty, gravitycontrol, playtesting_attach_gdb)
end

function playtesting_cancelask()
	playtesting_askwherestart = false
	love.filesystem.remove("veduser/VVVVVV/levels/ved_playtesting_temp.vvvvvv")
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
