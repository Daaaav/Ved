love.graphics.clearOR = love.graphics.clear
love.graphics.clear = function()
	if not s.pausedrawunfocused or love.window.hasFocus() then
		love.graphics.clearOR()
	end
end

function limit_draw_fps()
	local cur_frame_time = love.timer.getTime()
	if next_frame_time <= cur_frame_time then
		next_frame_time = cur_frame_time
	elseif next_frame_time - cur_frame_time <= 1 then
		love.timer.sleep(next_frame_time - cur_frame_time)
	else
		-- Safety measure: we were going to sleep for WAY too long, make sure we do it right next time.
		cons("Excessive FPS limit sleep for " .. (next_frame_time - cur_frame_time) .. "s prevented")
		next_frame_time = cur_frame_time
	end
end

function fatalerror(msg)
	errormsg = msg
	cons("FATAL ERROR: " .. msg)
	state = -1
end

function backspace(text)
	--[[ UTF-8 library is 0.9.2+
	-- get the byte offset to the last UTF-8 character in the string.
	local byteoffset = utf8.offset(text, -1)

	if byteoffset then
		-- remove the last UTF-8 character.
		-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
		text = string.sub(text, 1, byteoffset - 1)
	end
	]]

	if text == nil then return end

	local worktext = text
	while true do
		local lastchar = string.sub(worktext, -1, -1) -- als dit niet werkt...
		if lastchar == "" then return "" end

		-- Are we about to kill a UTF-8 continuation byte?
		if string.sub(toBinary(lastchar), 1, 2) == "10" then
			-- We are, do this again.
			worktext = string.sub(worktext, 1, -2)
		else
			-- All clear!
			return string.sub(worktext, 1, -2)
		end
	end
end

function leftspace(text, righttext)	
	if (text == nil) or (righttext == nil) then return end

	while true do
		local lastchar = string.sub(text, -1, -1) -- als dit niet werkt...
		if lastchar == "" then return "", righttext end

		-- Are we about to kill a UTF-8 continuation byte?
		if string.sub(toBinary(lastchar), 1, 2) == "10" then
			-- We are, do this again.
			righttext = string.sub(text, -1, -1) .. righttext
			text = string.sub(text, 1, -2)
		else
			-- All clear!
			righttext = string.sub(text, -1, -1) .. righttext
			return string.sub(text, 1, -2), righttext
		end
	end
end

function rightspace(text, righttext)	
	if (text == nil) or (righttext == nil) then return end

	local lastchar = string.sub(righttext, 1, 1) -- als dit niet werkt...
	if lastchar == "" then return text, "" end

	-- Different UTF-8 stuff going on here.
	local binarychar = toBinary(lastchar)

	if string.sub(binarychar, 1, 3) == "110" then
		-- Two bytes to move at once!
		text = text .. string.sub(righttext, 1, 2)
		return text, string.sub(righttext, 3, -1)
	elseif string.sub(binarychar, 1, 4) == "1110" then
		-- Three bytes to move at once!
		text = text .. string.sub(righttext, 1, 3)
		return text, string.sub(righttext, 4, -1)
	elseif string.sub(binarychar, 1, 5) == "11110" then
		-- Four!
		text = text .. string.sub(righttext, 1, 4)
		return text, string.sub(righttext, 5, -1)
	else
		-- Just one byte of course.
		text = text .. string.sub(righttext, 1, 1)
		return text, string.sub(righttext, 2, -1)
	end
end

function firstUTF8(text)
	if text == nil then return end

	local lastchar = string.sub(text, 1, 1) -- als dit niet werkt...
	if lastchar == "" then return text end

	-- Mostly the same as rightspace()
	local binarychar = toBinary(lastchar)

	if string.sub(binarychar, 1, 3) == "110" then
		-- Two bytes to move at once!
		return string.sub(text, 1, 2)
	elseif string.sub(binarychar, 1, 4) == "1110" then
		-- Three bytes to move at once!
		return string.sub(text, 1, 3)
	elseif string.sub(binarychar, 1, 5) == "11110" then
		-- Four!
		return string.sub(text, 1, 4)
	else
		-- Just one byte of course.
		return string.sub(text, 1, 1)
	end
end


--
function love.graphics.UTF8debugprint(text, x, y)
	--print("UTF-8 debug safe print!")

	local displaythis = ""
	local stringleft = text
	local assertfalsetext = "\n  ======================================"

	local represent = {}

	for c = 1, string.len(text) do
		table.insert(represent, string.byte(text, c, c))
	end

	while string.len(stringleft) > 0 do
		local binarychar = toBinary(string.sub(stringleft, 1, 1))

		if string.sub(binarychar, 1, 3) == "110" then
			-- Two bytes at once!
			assert(stringleft:len() >= 2 and toBinary(stringleft:sub(2, 2)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 1" .. assertfalsetext)

			displaythis = displaythis .. stringleft:sub(1,2)
			stringleft = stringleft:sub(3,-1)
		elseif string.sub(binarychar, 1, 4) == "1110" then
			-- Three bytes at once!
			assert(stringleft:len() >= 3 and toBinary(stringleft:sub(2, 2)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 2" .. assertfalsetext)
			assert(toBinary(stringleft:sub(3, 3)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 3" .. assertfalsetext)

			displaythis = displaythis .. stringleft:sub(1,3)
			stringleft = stringleft:sub(4,-1)
		elseif string.sub(binarychar, 1, 5) == "11110" then
			-- Four!
			assert(stringleft:len() >= 4 and toBinary(stringleft:sub(2, 2)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 4" .. assertfalsetext)
			assert(toBinary(stringleft:sub(3, 3)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 5" .. assertfalsetext)
			assert(toBinary(stringleft:sub(4, 4)):sub(1, 2) == "10" , "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 6" .. assertfalsetext)

			displaythis = displaythis .. stringleft:sub(1,4)
			stringleft = stringleft:sub(5,-1)
		elseif string.sub(binarychar, 1, 1) == "1" then
			-- Wtf, random continuation byte or something else that's invalid UTF-8!
			assert(false, "\n" .. assertfalsetext .. "\n   F O U N D . T H E . E R R O R:\n   Starts with: " .. displaythis .. "\n   Decimal representation of string: " .. table.concat(represent, ":") .. "\n   Location: 7" .. assertfalsetext)
		else
			-- Just one byte of course.
			displaythis = displaythis .. stringleft:sub(1,1)
			stringleft = stringleft:sub(2,-1)
		end
	end

	love.graphics.print(displaythis, x, y)
end
--


-- numberString toBinary http://pastebin.com/LkFYQPGP
function numberString(number)
	local s = ""
	repeat
		local remainder = number % 2
		s = remainder..s
		number = (number-remainder)/2
	until number==0
	return s
end

--[[
function chartobinary(char)
	string.format("%08d",numberString(string.byte(char)))
	-- Geen wonder dat dit nil geeft!!
end
]]

function toBinary(str)
	if #str > 0 then
		local result = ""
		for a = 1, #str do
			result = result..string.format("%08d",numberString(string.byte(string.sub(str,a,a))))
		end
		return result
	else return nil
	end
end

-- https://love2d.org/wiki/String_exploding
function explode(div, str)
	--cons("Explode is being used on string " .. str)
	assert(type(str) == "string" and type(div) == "string", "invalid arguments for string explosion (div is " .. type(div) .. " [" .. anythingbutnil(div) .. "], str is " .. type(str) .. " [" .. anythingbutnil(str) .. "])")
	local o = {}
	while true do
		local pos1,pos2 = str:find(div)
		if not pos1 then
			o[#o+1] = str
			break
		end
		o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
	end
	return o
end

function implode(div, tbl)
	return table.concat(tbl, div)
end

function startinput()
	cons("Input started (not once)")
	input = ""
	input_r = ""
	__ = "_"
	cursorflashtime = 0
	takinginput = true
	currentmultiinput = 0
end

function startinputonce()
	if not takinginput then
		cons("Input started (once)")
		input = ""
		input_r = ""
		__ = "_"
		cursorflashtime = 0
		takinginput = true
		currentmultiinput = 0
	end
end

function stopinput()
	cons("Input stopped.")
	-- Do not clear input here, because then we can't use it anymore after using stopinput(). Output will now be locked.
	input = anythingbutnil(input) .. anythingbutnil(input_r)
	input_r = ""
	__ = "_"
	cursorflashtime = 0
	takinginput = false
	currentmultiinput = 0
end

function startmultiinput(usethese)
	cons("Multi-input started: " .. #usethese)
	multiinput = usethese -- Already by reference
	__ = "_"
	cursorflashtime = 0
	takinginput = false
	currentmultiinput = 0
end

function tostate(new, dontinitialize, extradata)
	if dontinitialize == nil then
		dontinitialize = false
	end

	oldstate = state
	state = anythingbutnil0(tonumber(new)) -- please
	if not dontinitialize then
		cons("State changed: " .. oldstate .. " => " .. state .. " (inited)")
		loadstate(state, extradata) -- just so states can be prepared easily
	else
		cons("State changed: " .. oldstate .. " => " .. state .. " (not initialized)")
	end

	if special_cursor then
		love.mouse.setCursor()
		special_cursor = false
	end

	if oldstate == 1 then
		editingroomname = false
	end

end

function loadstate(new, extradata)
	if new == 1 then

		-- DON'T FORGET editingmap
		-- ^ has been forgotten, has been realized, has been fixed.

		--roomdata = {}; roomdata[0] = {} -- temporary
		--roomdata[0][0], entitydata, metadata = loademptyroom()
		--success, metadata, roomdata, entitydata, levelmetadata, scripts = loadlevel("tilesets2.vvvvvv")
		tilespicker = false
		tilespicker_shortcut = false
		selectedtool = 1; selectedsubtool = {1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1}
		selectedtile = 1
		selectedtileset = 0 --"spacestation" --"outside"
		selectedcolor = 0 --"c9" --"red"
		lefttoolscroll = 16 -- offset
		leftsubtoolscroll = 16
		zoomscale = 1 -- Or 1/2 or 1/4 or w/e
		dropdown = 0
		if extradata ~= true then
			roomx = 0
			roomy = 0
		end
		updatewindowicon()

		if levelmetadata ~= nil and levelmetadata[(roomy)*20 + (roomx+1)] ~= nil then
			gotoroom_finish()
		end

		editingroomtext = 0
		newroomtext = false
		editingroomname = false
		movingentity = 0
		--roomoptpage2 = false
		upperoptpage2 = false
		warpid = nil
		oldscriptx, oldscripty, oldscriptp1, oldscriptp2 = 0, 0, 0, 0
		oldbounds = {0, 0, 0, 0}

		minsmear = -1; maxsmear = -1

		-- old if not success

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
	elseif new == 3 then
		-- scriptname == ""
		-- scriptlines = {}

		-- Scripts can be fully contentless- without even one line.
		if #scriptlines == 0 then
			table.insert(scriptlines, "")
		end

		editingline = 1 --#scriptlines
		textlinestogo = 0
		startinput()
		scriptscroll = 0
		input = scriptlines[editingline]
		syntaxhlon = true
		textsize = false

		-- Little bit of caching
		rememberflagnumber = -1

		-- Are we loading a $-separated 3DS script?
		if oldstate == 22 then
			PleaseDo3DSHandlingThanks = true
		else
			PleaseDo3DSHandlingThanks = false
		end

		-- Make sure we don't keep checking for a load script when we can do it once.
		intscrwarncache_script = nil
		intscrwarncache_warn_noloadscript = nil
		intscrwarncache_warn_boxed = nil

		if oldstate ~= 3 then
			scripthistorystack = {}
		end
	elseif new == 4 then
		success, metadata, contents, entities, levelmetadata, scripts = loadlevel("testlevel.vvvvvv")
		test = test .. test
	elseif new == 5 then
		userprofile = os.getenv("USERPROFILE")
		lsuccess, levelsfolder = getlevelsfolder()
		if lsuccess then
			lerror = 0
		else
			lerror = 4
		end
		files = listdirs(userprofile)
	elseif new == 6 then
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
		else
			--state6old1 = false
		end

		if extradata == "secondlevel" then
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

		tabselected = 0
		backupscreen = false
		currentbackupdir = ""
		levellistscroll = 0
		max_levellistscroll = 0
	elseif new == 10 then
		if oldstate ~= 3 or scriptlistscroll == nil then
			scriptlistscroll = 0
			scriptdisplay_used = true
			scriptdisplay_unused = true
		end
		usedscripts, n_usedscripts = findusedscripts()
	elseif new == 11 then
		startinput()
		searchscripts = {}; searchrooms = {}; searchnotes = {}
		searchedfor = "moot"
		showresults = 100
	elseif new == 12 then
		mapscale = math.min(1/metadata.mapwidth, 1/metadata.mapheight)
		--mapxoffset = (640-(((1/mapscale)-metadata.mapwidth)*mapscale*640))/2
		--mapyoffset = (480-(((1/mapscale)-metadata.mapheight)*mapscale*480))/2
		mapxoffset = (((1/mapscale)-metadata.mapwidth)*mapscale*640)/2
		mapyoffset = (((1/mapscale)-metadata.mapheight)*mapscale*480)/2

		selectingrooms = 0
		selected1x = -1; selected1y = -1
		selected2x = -1; selected2y = -1

		mapmovedroom = false

		setgenerictimer(2, 2.75)
	elseif new == 13 then
		firstvvvvvvfolder = s.customvvvvvvdir
	elseif new == 15 then
		helplistscroll = 0
		helparticle = 2
		--helparticlecontent = {} -- Heette vroeger sis, geen idee waarom.
		helparticlescroll = 0
		helpeditingline = 0
		onlefthelpbuttons = false
		part1parts_cache = {}
		cachedlink = nil
		matching_url = nil
		matching_article = nil
		matching_anchor = nil
		matching_article_num = nil
		matching_anchor_line = nil

		-- Are we gonna use this for Ved help or for level notes?
		if extradata == nil then
			-- Just the Ved help
			helppages = LH
			helpeditable = false
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		elseif extradata == "plugins" then
			--helppages = {}
			loadpluginpages()
			helpeditable = false
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		else
			-- Level notes (or something custom because extradata is an array here!
			helppages = extradata[1]
			helpeditable = extradata[2]
			if helppages[2] ~= nil then
				helparticlecontent = explode("\n", helppages[helparticle].cont)
			end
		end
	elseif new == 17 then
		util_folderopendialog()
	elseif new == 18 then
		undostacktext = ""
		redostacktext = ""

		for k,v in pairs(undobuffer) do
			undostacktext = undostacktext .. v.undotype

			if v.undotype == "tiles" then
				undostacktext = undostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
			end

			undostacktext = undostacktext .. "\n"
		end

		for k,v in pairs(redobuffer) do
			redostacktext = redostacktext .. v.undotype

			if v.undotype == "tiles" then
				redostacktext = redostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
			end

			redostacktext = redostacktext .. "\n"
		end
	elseif new == 19 then
		local flagstextleftar = {}
		local flagstextrightar = {}

		usedflags = {}
		outofrangeflags = {}

		-- Seee which flags have been used in this level.
		returnusedflags(usedflags, outofrangeflags)

		for fl = 0, 49 do
			table.insert(flagstextleftar, (fl < 10 and " " or "") .. fl .. " - " .. (usedflags[fl] and L.FLAGUSED or L.FLAGNOTUSED) .. (vedmetadata ~= false and (vedmetadata.flaglabel[fl] ~= "" and " - " .. anythingbutnil(vedmetadata.flaglabel[fl]) or " - " .. L.FLAGNONAME) or "") .. "\n")
		end

		for fl = 50, 99 do
			table.insert(flagstextrightar, fl .. " - " .. (usedflags[fl] and L.FLAGUSED or L.FLAGNOTUSED) .. (vedmetadata ~= false and (vedmetadata.flaglabel[fl] ~= "" and " - " .. anythingbutnil(vedmetadata.flaglabel[fl]) or " - " .. L.FLAGNONAME) or "") .. "\n")
		end

		flagstextleft = table.concat(flagstextleftar)
		flagstextright = table.concat(flagstextrightar)

		outofrangeflagstext = ""

		for k,v in pairs(outofrangeflags) do
			if outofrangeflagstext == "" then
				outofrangeflagstext = L.USEDOUTOFRANGEFLAGS .. " " .. k
			else
				outofrangeflagstext = outofrangeflagstext .. ", " .. k
			end
		end
	elseif new == 20 then
		box_exists = true
		box_x, box_y, box_w, box_h = 80,80,208,208
		boxperi_x, boxperi_y, boxperi_w, boxperi_h = 0,0,love.graphics.getWidth(),love.graphics.getHeight()
		box_type = 0
	elseif new == 21 then
		overlappingentities = {}
		listoverlappingentities(overlappingentities)
		text21 = ""
		for k,v in pairs(overlappingentities) do
			text21 = text21 .. "Entity #" .. k .. " type " .. v.t .. " in room " .. (v.x/40) .. "," .. (v.y/30) .. "\n"
		end
	elseif new == 24 then
		pluginstext = textlistplugins()
	elseif new == 25 then
		editingcolor = nil
	elseif new == 26 then
		startinput()
	elseif new == 27 then
		nonintscale = s.scale ~= math.floor(anythingbutnil0(tonumber(s.scale)))
		if nonintscale then
			startinput()
			input = tostring(s.scale)
		end
	elseif new == 28 then
		local usedflags = {}

		-- See which flags have been used in this level.
		returnusedflags(usedflags, {})

		local n_usedflags = 0
		for fl = 0, 99 do
			if usedflags[fl] then
				n_usedflags = n_usedflags + 1
			end
		end

		basic_stats = {
			{L.AMOUNTSCRIPTS, #scriptnames, 500},
			{L.AMOUNTUSEDFLAGS, n_usedflags, 100},
			{L.AMOUNTENTITIES, anythingbutnil0(count.entities), 3000},
			{L.AMOUNTTRINKETS, anythingbutnil0(count.trinkets), 20},
			{L.AMOUNTCREWMATES, anythingbutnil0(count.crewmates), 20},
		}

		basic_stats_max_text_width = 0
		limitglow_enabled = false
		for k,v in pairs(basic_stats) do
			local width = font8:getWidth(v[1] .. " /" .. v[2] .. v[3])

			if width > basic_stats_max_text_width then
				basic_stats_max_text_width = width
			end

			if v[2] > v[3] then
				limitglow_enabled = true
			end
		end
	elseif new == 29 then
		plural_test = {val = 1}
	end

	hook("func_loadstate")
end

-- Go to state allocated by a plugin
function to_astate(name, new, dontinitialize)
	if new == nil then
		new = 0
	end
	assert(state_allocations[name] ~= nil, "No states have been allocated for '" .. name .. "'")
	assert(new <= state_allocations[name][2], "State " .. new .. " is beyond upper bound for '" .. name .. "', only " .. state_allocations[name][2] .. " allocated (starting at 0)")

	if dontinitialize == nil then
		dontinitialize = false
	end

	oldstate = state
	state = anythingbutnil0(state_allocations[name][1] + new)
	if not dontinitialize then
		cons("State changed: " .. oldstate .. " => " .. name .. "." .. new .. "(" .. state .. ") (inited)")
		-- Now load the state!
		hook("func_loadstate")
	else
		cons("State changed: " .. oldstate .. " => " .. name .. "." .. new .. "(" .. state .. ") (not initialized)")
	end
end



-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Just as a filler because I need this part often ---------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------



function loadlevelsfolder()
	cons("Loading levels folder...")
	levels_refresh = levels_refresh + 1
	if allmetadata_inchannel ~= nil then
		allmetadata_inchannel:clear()
	end
	lsuccess, levelsfolder = getlevelsfolder()
	if lsuccess then
		files = listfiles(levelsfolder)
	end
	metadataloaded_folders = {}
	recentmetadata_files = {}
	cons("Loaded.")
	-- Now get all the backups
	if files == nil then
		files = {}
	end
	files[".ved-sys" .. dirsep .. "backups"] = {}
	local rootbackupfolders = love.filesystem.getDirectoryItems("overwrite_backups")
	for k1, f1 in pairs(rootbackupfolders) do
		table.insert(files[".ved-sys" .. dirsep .. "backups"],
			{
				name = f1,
				isdir = love.filesystem.isDirectory("overwrite_backups/" .. f1),
				lastmodified = 0,
				overwritten = 0,
			}
		)
		if love.filesystem.isDirectory("overwrite_backups/" .. f1) then
			-- Go down ONE more level, we don't expect subdirectories in this.
			files[".ved-sys" .. dirsep .. "backups" .. dirsep .. f1] = {}
			local backupfiles = love.filesystem.getDirectoryItems("overwrite_backups/" .. f1)
			for k2, f2 in pairs(backupfiles) do
				if not love.filesystem.isDirectory("overwrite_backups/" .. f1 .. "/" .. f2) then
					-- What are the dates for this?
					local ov, lm = 0, 0
					local parts = explode("_", f2)
					if #parts >= 2 then
						ov, lm = anythingbutnil0(tonumber(parts[1])), anythingbutnil0(tonumber(parts[2]))
					end
					table.insert(files[".ved-sys" .. dirsep .. "backups" .. dirsep .. f1],
						{
							name = f2,
							isdir = false,
							lastmodified = lm,
							overwritten = ov,
						}
					)
				end
			end
		end
	end
end

function loadtilesets()
	loadtileset("tiles.png")
	loadtileset("tiles2.png")
	loadsprites("sprites.png", 32)
end

function loadtileset(file)
	tilesets[file] = {}

	-- Try loading custom assets first
	readsuccess, contents = readimage(levelsfolder, file)

	local asimgdata
	if readsuccess == true then
		-- Custom image!
		cons("Custom image: " .. file)
		--love.filesystem.write("temp/" .. file, contents)
		--tilesets[file]["img"] = love.graphics.newImage("temp/" .. file)
		asimgdata = love.image.newImageData(love.filesystem.newFileData(contents, file, "file"))
	else
		cons("No custom image for " .. file .. ", " .. contents)
		asimgdata = love.image.newImageData(file)
	end
	tilesets[file]["img"] = love.graphics.newImage(asimgdata)
	tilesets[file]["width"] = tilesets[file]["img"]:getWidth()
	tilesets[file]["height"] = tilesets[file]["img"]:getHeight()
	tilesets[file]["tileswidth"] = tilesets[file]["width"]/8  -- 16
	tilesets[file]["tilesheight"] = tilesets[file]["height"]/8  -- 16

	cons("Loading tileset: " .. file .. ", " .. tilesets[file]["width"] .. "x" .. tilesets[file]["height"] .. ", " .. tilesets[file]["tileswidth"] .. "x" .. tilesets[file]["tilesheight"])

	-- Some tiles need to show up in any color we choose, so make another version where everything is white so we can color-correct it.
	asimgdata:mapPixel(function(x, y, r, g, b, a)
		return 255, 255, 255, a
	end)
	tilesets[file]["white_img"] = love.graphics.newImage(asimgdata)

	tilesets[file]["tiles"] = {}

	for tsy = 0, (tilesets[file]["tilesheight"]-1) do
		for tsx = 0, (tilesets[file]["tileswidth"]-1) do
			tilesets[file]["tiles"][(tsy*tilesets[file]["tileswidth"])+tsx] = love.graphics.newQuad(tsx*8, tsy*8, 8, 8, tilesets[file]["width"], tilesets[file]["height"]) -- 16 16 16 16
		end
	end
end

function loadsprites(file, res)
	tilesets[file] = {}

	-- Try loading custom assets first
	readsuccess, contents = readimage(levelsfolder, file)

	local asimgdata
	if readsuccess then
		-- Custom image!
		cons("Custom image: " .. file)
		--love.filesystem.write("temp/" .. file, contents)
		--tilesets[file]["img"] = love.graphics.newImage("temp/" .. file)
		asimgdata = love.image.newImageData(love.filesystem.newFileData(contents, file, "file"))
	else
		cons("No custom image for " .. file .. ", " .. contents)
		asimgdata = love.image.newImageData(file)
	end
	tilesets[file]["img"] = love.graphics.newImage(asimgdata)
	tilesets[file]["width"] = tilesets[file]["img"]:getWidth()
	tilesets[file]["height"] = tilesets[file]["img"]:getHeight()
	tilesets[file]["tileswidth"] = tilesets[file]["width"]/res -- 32
	tilesets[file]["tilesheight"] = tilesets[file]["height"]/res -- 32

	cons("Loading spriteset: " .. file .. ", " .. tilesets[file]["width"] .. "x" .. tilesets[file]["height"] .. ", " .. tilesets[file]["tileswidth"] .. "x" .. tilesets[file]["tilesheight"])

	-- Now make everything white so we can color-correct it!
	asimgdata:mapPixel(function(x, y, r, g, b, a)
		return 255, 255, 255, a
	end)
	tilesets[file]["img"] = love.graphics.newImage(asimgdata)

	tilesets[file]["tiles"] = {}

	for tsy = 0, (tilesets[file]["tilesheight"]-1) do
		for tsx = 0, (tilesets[file]["tileswidth"]-1) do
			tilesets[file]["tiles"][(tsy*tilesets[file]["tileswidth"])+tsx] = love.graphics.newQuad(tsx*res, tsy*res, res, res, tilesets[file]["width"], tilesets[file]["height"])
		end
	end
end

function loadfontpng()
	local readsuccess, contents = readimage(levelsfolder, "font.png")

	if not readsuccess then
		return false
	end

	-- The following function can be found in imagefont.lua
	convertfontpng(love.image.newImageData(love.filesystem.newFileData(contents, "font.png", "file")))

	return true
end

function mousein(x1, y1, x2, y2)
	-- Determines whether mouse is in a box with corners x1,y1 and x2,y2
	return (love.mouse.getX() >= x1) and (love.mouse.getX() <= x2) and (love.mouse.getY() >= y1) and (love.mouse.getY() <= y2)
end

function mouseon(x, y, w, h)
	-- Determines whether mouse is on a box with top left corner x1,y1 and width w and height h
	return (love.mouse.getX() >= x) and (love.mouse.getX() < x+w) and (love.mouse.getY() >= y) and (love.mouse.getY() < y+h)
end

function lockablemouseon(x, y, w, h)
	-- Determines whether mouse is on a box with top left corner x1,y1 and width w and height h - but locked x and y (with [ or ]) is observed
	return (getlockablemouseX() >= x) and (getlockablemouseX() < x+w) and (getlockablemouseY() >= y) and (getlockablemouseY() < y+h)
end

function lefttoolscrollbounds()
	if (lefttoolscroll < -368) then
		lefttoolscroll = -368
	elseif (lefttoolscroll > 16) then
		lefttoolscroll = 16
	end
end

function hoverdraw(img, x, y, w, h, s)
	if nodialog and mouseon(x, y, w, h) then
		love.graphics.draw(img, x, y, 0, s)
	else
		love.graphics.setColor(255,255,255,128)
		love.graphics.draw(img, x, y, 0, s)
		love.graphics.setColor(255,255,255,255)
	end
end

function hoverrectangle(r, g, b, a, x, y, w, h, thisbelongstoarightclickmenu)
	if (nodialog or thisbelongstoarightclickmenu) and mouseon(x, y, w, h) then
		love.graphics.setColor(r, g, b, 255)
		love.graphics.rectangle("fill", x, y, w, h)
	else
		love.graphics.setColor(r, g, b, a)
		love.graphics.rectangle("fill", x, y, w, h)
	end

	love.graphics.setColor(255,255,255,255)
end

function rbutton(label, pos, yoffset, bottom, buttonspacing, yellow)
	if yoffset == nil then yoffset = 8 end
	if buttonspacing == nil then buttonspacing = 24 end

	local hotkey
	if type(label) == "table" then
		hotkey = label[2]
		label = label[1]
	end

	-- Text too long to fit?
	local textyoffset = 6 -- 4+2
	if (font8:getWidth(label) > 128-16 or label:find("\n") ~= nil) then
		textyoffset = 2
	end

	local y
	if bottom then
		y = love.graphics.getHeight()-(buttonspacing*(pos+1))-(yoffset-8)
	else
		y = yoffset+(buttonspacing*pos)
	end
	hoverrectangle(yellow and 160 or 128,yellow and 160 or 128,yellow and 0 or 128,128, love.graphics.getWidth()-(128-8), y, 128-16, 16)
	love.graphics.printf(label, love.graphics.getWidth()-(128-8)+1, y+textyoffset, 128-16, "center")
	if love.keyboard.isDown("f9") and hotkey ~= nil then
		love.graphics.setFont(tinynumbers)
		local hotkey_w = tinynumbers:getWidth(hotkey)
		love.graphics.setColor(255,255,255,192)
		love.graphics.rectangle("fill", love.graphics.getWidth()-9-hotkey_w, y-2, hotkey_w+3, 10)
		love.graphics.setColor(0,0,0)
		love.graphics.print(hotkey, love.graphics.getWidth()-7-hotkey_w, y)
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(font8)
	end
end

function onrbutton(pos, yoffset, bottom, buttonspacing)
	if mousepressed or (not nodialog) then return false end

	if yoffset == nil then yoffset = 8 end
	if buttonspacing == nil then buttonspacing = 24 end

	if bottom then
		return mouseon(love.graphics.getWidth()-(128-8), love.graphics.getHeight()-(buttonspacing*(pos+1))-(yoffset-8), 128-16, 16)
	else
		return mouseon(love.graphics.getWidth()-(128-8), yoffset+(buttonspacing*pos), 128-16, 16)
	end
end

-- dialog.new("TODO: This can probably be removed later")
function hoverdiatext(x, y, w, h, text, minumber, active, mode, menuitems, menuitemslabel, menuid)
	-- Mode can be 0 for text, 1 for dropdown
	-- menuitems is used for the right click menu, menuitemslabel is used for the label on the field (but can be nil to just show text)
	if mode == nil then
		mode = 0
	end

	if active or mouseon(x, y-3, w, h) then
		setColorDIA(255,255,255,255)
		love.graphics.rectangle("fill", x, y-3, w, h)

		if (active and love.keyboard.isDown("tab")) or (mouseon(x, y-3, w, h) and love.mouse.isDown("l") and not mousepressed) then
			currentmultiinput = minumber

			if mode == 1 and (not RCMactive) then
				rightclickmenu.create(menuitems, menuid, x, (y-3)+h, true) -- y+h

				mousepressed = true
			end
		end
	else
		setColorDIA(255,255,255,192)
		love.graphics.rectangle("fill", x, y-3, w, h)
	end
	setColorDIA(0,0,0,255)

	if mode == 0 then
		love.graphics.print(anythingbutnil(text) .. (active and __ or ""), x, y-1)
	elseif mode == 1 then
		if menuitemslabel == nil then
			love.graphics.print(anythingbutnil(text), x, y-1)
		else
			love.graphics.print(anythingbutnil(menuitemslabel[anythingbutnil0(tonumber(text))]), x, y-1)
		end
		love.graphics.draw(menupijltje, x+w-8, (y-3)+2) -- Die 8 is 7+1
	end

	setColorDIA(255,255,255,255)
end

function cycle(var, themax, themin)
	if themin == nil then
		themin = 1
	end

	if var == themax then
		return themin
	else
		return var+1
	end
end

function revcycle(var, themax, themin)
	if themin == nil then
		themin = 1
	end

	if var == themin then
		return themax
	else
		return var-1
	end
end

function t(cond, thens, elses)
	if cond then
		return thens
	else
		return elses
	end
end

function return_value()
	local dm = os.date("%d%m")
	if tonumber(dm:sub(1,1)) == 0 and tonumber(dm:sub(2,-1)) == 104 then
		for value = 1, 2 do
			subtoolimgs[12][value] = st("12_" .. value) --toolimg[12];
		end
		subtoolnames[12] = table.copy(subtoolnames[5])
	end

	return #subtoolnames
end

function spitoutarrays()
	love.system.setClipboardText([[				blocks =
					{
					]] .. fixdig(cb[1], 4, " ") .. [[, ]] .. fixdig(cb[2], 4, " ") .. [[, ]] .. fixdig(cb[3], 4, " ") .. [[, ]] .. fixdig(cb[4], 4, " ") .. [[, ]] .. fixdig(cb[5], 4, " ") .. [[, ]] .. fixdig(cb[6], 4, " ") .. [[,
					]] .. fixdig(cb[7], 4, " ") .. [[, ]] .. fixdig(cb[8], 4, " ") .. [[, ]] .. fixdig(cb[9], 4, " ") .. [[, ]] .. fixdig(cb[10], 4, " ") .. [[, ]] .. fixdig(cb[11], 4, " ") .. [[, ]] .. fixdig(cb[12], 4, " ") .. [[,
					]] .. fixdig(cb[13], 4, " ") .. [[, ]] .. fixdig(cb[14], 4, " ") .. [[, ]] .. fixdig(cb[15], 4, " ") .. [[, ]] .. fixdig(cb[16], 4, " ") .. [[, ]] .. fixdig(cb[17], 4, " ") .. [[, ]] .. fixdig(cb[18], 4, " ") .. [[,
					]] .. fixdig(cb[19], 4, " ") .. [[, ]] .. fixdig(cb[20], 4, " ") .. [[, ]] .. fixdig(cb[21], 4, " ") .. [[, ]] .. fixdig(cb[22], 4, " ") .. [[, ]] .. fixdig(cb[23], 4, " ") .. [[, ]] .. fixdig(cb[24], 4, " ") .. [[,
					]] .. fixdig(cb[25], 4, " ") .. [[, ]] .. fixdig(cb[26], 4, " ") .. [[, ]] .. fixdig(cb[27], 4, " ") .. [[, ]] .. fixdig(cb[28], 4, " ") .. [[, ]] .. fixdig(cb[29], 4, " ") .. [[, ]] .. fixdig(cb[30], 4, " ") .. [[,
					},
				background =
					{
					]] .. fixdig(ca[1], 4, " ") .. [[, ]] .. fixdig(ca[2], 4, " ") .. [[, ]] .. fixdig(ca[3], 4, " ") .. [[, ]] .. fixdig(ca[4], 4, " ") .. [[, ]] .. fixdig(ca[5], 4, " ") .. [[, ]] .. fixdig(ca[6], 4, " ") .. [[,
					]] .. fixdig(ca[7], 4, " ") .. [[, ]] .. fixdig(ca[8], 4, " ") .. [[, ]] .. fixdig(ca[9], 4, " ") .. [[, ]] .. fixdig(ca[10], 4, " ") .. [[, ]] .. fixdig(ca[11], 4, " ") .. [[, ]] .. fixdig(ca[12], 4, " ") .. [[,
					]] .. fixdig(ca[13], 4, " ") .. [[, ]] .. fixdig(ca[14], 4, " ") .. [[, ]] .. fixdig(ca[15], 4, " ") .. [[, ]] .. fixdig(ca[16], 4, " ") .. [[, ]] .. fixdig(ca[17], 4, " ") .. [[, ]] .. fixdig(ca[18], 4, " ") .. [[,
					]] .. fixdig(ca[19], 4, " ") .. [[, ]] .. fixdig(ca[20], 4, " ") .. [[, ]] .. fixdig(ca[21], 4, " ") .. [[, ]] .. fixdig(ca[22], 4, " ") .. [[, ]] .. fixdig(ca[23], 4, " ") .. [[, ]] .. fixdig(ca[24], 4, " ") .. [[,
					]] .. fixdig(ca[25], 4, " ") .. [[, ]] .. fixdig(ca[26], 4, " ") .. [[, ]] .. fixdig(ca[27], 4, " ") .. [[, ]] .. fixdig(ca[28], 4, " ") .. [[, ]] .. fixdig(ca[29], 4, " ") .. [[, ]] .. fixdig(ca[30], 4, " ") .. [[,
					},
				spikes =
					{
					]] .. fixdig(cs[1], 4, " ") .. [[, ]] .. fixdig(cs[2], 4, " ") .. [[, ]] .. fixdig(cs[3], 4, " ") .. [[, ]] .. fixdig(cs[4], 4, " ") .. [[, ]] .. fixdig(cs[5], 4, " ") .. [[, ]] .. fixdig(cs[6], 4, " ") .. [[,
					]] .. fixdig(cs[7], 4, " ") .. [[, ]] .. fixdig(cs[8], 4, " ") .. [[, ]] .. fixdig(cs[9], 4, " ") .. [[, ]] .. fixdig(cs[10], 4, " ") .. [[, ]] .. fixdig(cs[11], 4, " ") .. [[, ]] .. fixdig(cs[12], 4, " ") .. [[,
					]] .. fixdig(cs[13], 4, " ") .. [[, ]] .. fixdig(cs[14], 4, " ") .. [[, ]] .. fixdig(cs[15], 4, " ") .. [[, ]] .. fixdig(cs[16], 4, " ") .. [[, ]] .. fixdig(cs[17], 4, " ") .. [[, ]] .. fixdig(cs[18], 4, " ") .. [[,
					]] .. fixdig(cs[19], 4, " ") .. [[, ]] .. fixdig(cs[20], 4, " ") .. [[, ]] .. fixdig(cs[21], 4, " ") .. [[, ]] .. fixdig(cs[22], 4, " ") .. [[, ]] .. fixdig(cs[23], 4, " ") .. [[, ]] .. fixdig(cs[24], 4, " ") .. [[,
					]] .. fixdig(cs[25], 4, " ") .. [[, ]] .. fixdig(cs[26], 4, " ") .. [[, ]] .. fixdig(cs[27], 4, " ") .. [[, ]] .. fixdig(cs[28], 4, " ") .. [[, ]] .. fixdig(cs[29], 4, " ") .. [[, ]] .. fixdig(cs[30], 4, " ") .. [[,
					}]])
end

function fixdig(number, dig, filler)
	if filler == nil then filler = "0" end

	if string.len(tostring(number)) > dig then
		return string.rep("9", dig)
	elseif string.len(tostring(number)) == dig then
		return tostring(number)
	else
		return string.rep(filler, dig-string.len(tostring(number))) .. tostring(number)
	end
end

function fixdige(number, dig, filler, highfiller)
	if filler == nil then filler = "0" end

	if string.len(tostring(number)) > dig then
		return string.rep(highfiller, dig)
	elseif string.len(tostring(number)) == dig then
		return tostring(number)
	else
		return string.rep(filler, dig-string.len(tostring(number))) .. tostring(number)
	end
end

function setColorArr(yourarray)
	love.graphics.setColor(yourarray[1], yourarray[2], yourarray[3])
end

function insertrowcolor(rowcolors, yourarray)
	if not backgroundshift then
		table.insert(rowcolors, yourarray)
	else
		if #rowcolors == 0 then
			table.insert(rowcolors, {192,192,192})
		end
		table.insert(rowcolors[#rowcolors], yourarray[1])
		table.insert(rowcolors[#rowcolors], yourarray[2])
		table.insert(rowcolors[#rowcolors], yourarray[3])
		backgroundshift = false
	end
end

function st(name)
	return love.graphics.newImage("tools/sub/" .. name .. ".png")
end

function updatecountdelete(thet, id, undoing)
	-- So what are we removing?
	if thet == 9 then
		count.trinkets = count.trinkets - 1
	elseif thet == 15 then
		count.crewmates = count.crewmates - 1
	elseif thet == 16 then
		count.startpoint = nil
	end

	-- Is this a roomtext/terminal/script box entity and were we editing it?
	if editingroomtext == id then
		stopinput()
		editingroomtext = 0
		makescriptroomtext = false
	end

	-- Make sure we can undo this! If we're not already removing an entity by undoing
	if not undoing then
		table.insert(undobuffer, {undotype = "removeentity", rx = roomx, ry = roomy, entid = id, removedentitydata = table.copy(entitydata[id])})
		finish_undo("REMOVED ENTITY")
	end

	count.entities = count.entities - 1
end

function updatecountadd(thet)
	if thet == 9 then
		count.trinkets = count.trinkets + 1
	elseif thet == 15 then
		count.crewmates = count.crewmates + 1
	-- Startpoint (16) should not be handled with this function
	end

	count.entities = count.entities + 1
end

function namefound(obj)
	if obj.data:lower() == string.char(115,110,97,107,101) then
		return 1
	end
	return 0
end

function escapegsub(invoer, keepcaps)
	if not keepcaps then
		invoer = invoer:lower()
	end
	return invoer:gsub("%%", "%%%%"):gsub("%(", "%%%("):gsub("%)", "%%%)"):gsub("%.", "%%%."):gsub("%+", "%%%+"):gsub("%-", "%%%-"):gsub("%*", "%%%*"):gsub("%?", "%%%?"):gsub("%[", "%%%["):gsub("%^", "%%%^"):gsub("%$", "%%%$")
end

function flipscrollmore(wheel)
	-- Ok so on OSX by default scrolling is the opposite of Windows, which can feel natural because you're using two fingers instead of rolling a wheel
	-- Now this does not feel normal when you're switching between items instead of scrolling
	-- So on Mac we reverse that with the subtools but you can also reverse this way of scrolling, in which case our flipped code changes to the unnatural feeling one
	-- In which case you can change a setting in Ved to again reverse that
	if s.flipsubtoolscroll then
		if wheel == "wu" then
			return "wd"
		else
			return "wu"
		end
	else
		return wheel
	end
end

function thingk()
	keyva = require("keyfunc")(function()
		if state == 1 and (selectedtool == 1 or selectedtool == 2) and mouseon(16+64, 16+48*8+leftsubtoolscroll, 32, 32) then
			subtoolimgs[1][10] = st("1_10");subtoolimgs[2][10] = st("1_10")
		elseif state == 15 then
			helpeditable = true
		end
	end)

	return return_value()
end

function switchtileset()
	if keyboard_eitherIsDown("shift") then
		selectedtileset = revcycle(selectedtileset, 4, 0)
	else
		selectedtileset = cycle(selectedtileset, 4, 0)
	end
	if selectedcolor > #tilesetblocks[selectedtileset].colors or (selectedtileset == 2 and selectedcolor == 6 and levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0) then
		selectedcolor = 0
	end

	local oldtileset = levelmetadata[(roomy)*20 + (roomx+1)].tileset
	local oldtilecol = levelmetadata[(roomy)*20 + (roomx+1)].tilecol

	levelmetadata[(roomy)*20 + (roomx+1)].tileset = selectedtileset
	levelmetadata[(roomy)*20 + (roomx+1)].tilecol = selectedcolor

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "tileset",
					oldvalue = oldtileset,
					newvalue = selectedtileset
				},
				{
					key = "tilecol",
					oldvalue = oldtilecol,
					newvalue = selectedcolor
				}
			},
			changetiles = true,
			toundotiles = table.copy(roomdata[roomy][roomx])
		}
	)
	finish_undo("TILESET")

	autocorrectroom() -- this already checks if automatic mode is on
end

function switchtilecol()
	if keyboard_eitherIsDown("shift") then
		selectedcolor = revcycle(selectedcolor, #tilesetblocks[selectedtileset].colors, 0)
	else
		selectedcolor = cycle(selectedcolor, #tilesetblocks[selectedtileset].colors, 0)
	end
	if selectedtileset == 2 and selectedcolor == 6 and levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
		-- lab rainbow background isn't available in auto-mode
		selectedcolor = 0
	end

	local oldtilecol = levelmetadata[(roomy)*20 + (roomx+1)].tilecol

	levelmetadata[(roomy)*20 + (roomx+1)].tilecol = selectedcolor

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "tilecol",
					oldvalue = oldtilecol,
					newvalue = selectedcolor
				}
			},
			changetiles = true,
			toundotiles = table.copy(roomdata[roomy][roomx])
		}
	)
	finish_undo("TILECOL")

	autocorrectroom() -- this already checks if automatic mode is on
end

function switchenemies()
	local oldtype = levelmetadata[(roomy)*20 + (roomx+1)].enemytype
	if keyboard_eitherIsDown("shift") then
		levelmetadata[(roomy)*20 + (roomx+1)].enemytype = revcycle(levelmetadata[(roomy)*20 + (roomx+1)].enemytype, 9, 0)
	else
		levelmetadata[(roomy)*20 + (roomx+1)].enemytype = cycle(levelmetadata[(roomy)*20 + (roomx+1)].enemytype, 9, 0)
	end

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "enemytype",
					oldvalue = oldtype,
					newvalue = levelmetadata[(roomy)*20 + (roomx+1)].enemytype
				}
			},
			switchtool = 9
		}
	)
	finish_undo("ENEMY TYPE")
end

--[[ editingbounds:
0 nothing
-1 1 enemy (shrink or expand)
-2 2 platform (shrink or expand)
]]

function changeenemybounds()
	if selectedtool == 13 and selectedsubtool[13] ~= 1 then return end

	selectedtool = 9
	updatewindowicon()

	-- Make sure we see the bounds
	showepbounds = true

	if editingbounds == -1 then
		--editingbounds = 1
		editingbounds = 0
	elseif editingbounds == 1 then
		editingbounds = 0
	else
		editingbounds = -1
	end
end

function changeplatformbounds()
	if selectedtool == 13 and selectedsubtool[13] ~= 1 then return end

	selectedtool = 8
	updatewindowicon()

	-- Make sure we see the bounds
	showepbounds = true

	if editingbounds == -2 then
		--editingbounds = 2
		editingbounds = 0
	elseif editingbounds == 2 then
		editingbounds = 0
	else
		editingbounds = -2
	end
end

function changedmode()
	--levelmetadata[(roomy)*20 + (roomx+1)].directmode = cycle(levelmetadata[(roomy)*20 + (roomx+1)].directmode, 1, 0)

	local olddirect = levelmetadata[(roomy)*20 + (roomx+1)].directmode
	local oldauto2 = levelmetadata[(roomy)*20 + (roomx+1)].auto2mode
	--local oldtilecol = selectedcolor

	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 and levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 0 then
		levelmetadata[(roomy)*20 + (roomx+1)].auto2mode = 1
	elseif levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 then
		levelmetadata[(roomy)*20 + (roomx+1)].directmode = 1
		levelmetadata[(roomy)*20 + (roomx+1)].auto2mode = 0
	else
		levelmetadata[(roomy)*20 + (roomx+1)].directmode = 0
	end

	if selectedtileset == 2 and selectedcolor == 6 and levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
		-- lab rainbow background isn't available in auto-mode
		selectedcolor = 0
	end

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "directmode",
					oldvalue = olddirect,
					newvalue = levelmetadata[(roomy)*20 + (roomx+1)].directmode
				},
				{
					key = "auto2mode",
					oldvalue = oldauto2,
					newvalue = levelmetadata[(roomy)*20 + (roomx+1)].auto2mode
				}
			}
		}
	)
	finish_undo("MODE")
end

function changewarpdir()
	local oldwarpdir = levelmetadata[(roomy)*20 + (roomx+1)].warpdir
	levelmetadata[(roomy)*20 + (roomx+1)].warpdir = cycle(levelmetadata[(roomy)*20 + (roomx+1)].warpdir, 3, 0)

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "warpdir",
					oldvalue = oldwarpdir,
					newvalue = levelmetadata[(roomy)*20 + (roomx+1)].warpdir
				}
			}
		}
	)
	finish_undo("WARPDIR")
end

function toggleeditroomname()
	if editingroomname then
		saveroomname()
	else
		editingroomname = true
		startinputonce()
		input = anythingbutnil(levelmetadata[(roomy)*20 + (roomx+1)].roomname)
	end
end

function saveroomname()
	editingroomname = false
	stopinput()
	local oldroomname = anythingbutnil(levelmetadata[(roomy)*20 + (roomx+1)].roomname)
	levelmetadata[(roomy)*20 + (roomx+1)].roomname = input

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "roomname",
					oldvalue = oldroomname,
					newvalue = input
				}
			}
		}
	)
	finish_undo("ROOMNAME")
end

function endeditingroomtext(donotmakethisnil)
	-- We were typing a text!
	stopinput()
	if entitydata[editingroomtext] == nil then
		dialog.create(L.EDITINGROOMTEXTNIL .. "\n\n(Location x)")
	elseif input ~= "" or editingroomtext == donotmakethisnil then
		local olddata = entitydata[editingroomtext].data
		entitydata[editingroomtext].data = input
		if makescriptroomtext and scripts[input] == nil then
			if s.loadscriptname ~= "" and s.loadscriptname ~= "$1" then
				local warnloadscriptexists = false
				local loadscriptname = langkeys(s.loadscriptname, {input})
				if keyboard_eitherIsDown("shift") then -- flag
					if scripts[loadscriptname] ~= nil then
						warnloadscriptexists = true
					else
						-- What flag is available?
						usedflags = {}
						outofrangeflags = {}

						-- See which flags have been used in this level.
						returnusedflags(usedflags, outofrangeflags)

						local useflag = -1
						for vlag = 0, 99 do
							if not usedflags[vlag] then
								useflag = vlag
								usedflags[vlag] = true
								--vedmetadata.flaglabel[vlag] = partss[2]
								break
							end
						end

						if useflag == -1 then
							-- No flags left?
							dialog.create(langkeys(L.NOFLAGSLEFT_LOADSCRIPT, {input}))
							scripts[loadscriptname] = {"iftrinkets(0," .. input .. ")"}
						else
							scripts[loadscriptname] = {
								"ifflag(" .. useflag .. ",stop)",
								"flag(" .. useflag .. ",on)",
								"iftrinkets(0," .. input .. ")"
							}
						end
						table.insert(scriptnames, loadscriptname)
						entitydata[editingroomtext].data = loadscriptname

						temporaryroomname = L.LOADSCRIPTMADE
						temporaryroomnametimer = 90
					end
				elseif keyboard_eitherIsDown(ctrl) then -- trinkets
					if scripts[loadscriptname] ~= nil then
						warnloadscriptexists = true
					else
						scripts[loadscriptname] = {"iftrinkets(0," .. input .. ")"}
						table.insert(scriptnames, loadscriptname)
						entitydata[editingroomtext].data = loadscriptname

						temporaryroomname = L.LOADSCRIPTMADE
						temporaryroomnametimer = 90
					end
				end
				if warnloadscriptexists then
					dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {loadscriptname}))
				end
			end

			scripts[input] = {""}
			table.insert(scriptnames, input)
		end
		if newroomtext then
			entityplaced(editingroomtext)
			newroomtext = false
		else
			table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = editingroomtext, changedentitydata = {{key = "data", oldvalue = olddata, newvalue = entitydata[editingroomtext].data}}})
		end
	else
		removeentity(editingroomtext)
	end
	editingroomtext = 0
end

function createmde()
	cons("Creating metadata entity...")
	return {
		mdeversion = thismdeversion,
		-- This is of course an ugly way to do it
		flaglabel = {"","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","","", "","","","","","","","","", [0] = ""},
		vars = {},
		notes = {{subj = L.RETURN, imgs = {}, cont = [[\)]]}}
	}
end

function state6load(levelname)
	if backupscreen then
		if files[levelname] ~= nil then
			currentbackupdir = levelname
			tabselected = 0
		end
		return
	end

	if files[levelname] ~= nil then
		input = levelname .. dirsep
		input_r = ""
		tabselected = 0
		return
	end

	stopinput()

	-- Loading levels tends to happen where it shouldn't.
	love.graphics.setScissor()

	if dirsep == "\\" then
		levelname = levelname:gsub("/", "\\")
	end

	if not secondlevel then
		if levelmetadata ~= nil then
			-- We already had a level loaded, but this one might fail to load! Most of these will be pointers to tables, so it won't hurt much to do this.
			oldeditingmap, oldmetadata, oldroomdata, oldentitydata, oldlevelmetadata, oldscripts, oldcount, oldscriptnames, oldvedmetadata
			=  editingmap,    metadata,    roomdata,    entitydata,    levelmetadata,    scripts,    count,    scriptnames,    vedmetadata
		end

		success, metadata, roomdata, entitydata, levelmetadata, scripts, count, scriptnames, vedmetadata = loadlevel(levelname .. ".vvvvvv")

		if not success then
			--tostate(6)
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata)

			-- Did we have a previous level open?
			if oldlevelmetadata ~= nil then
				-- We did!
				   editingmap,    metadata,    roomdata,    entitydata,    levelmetadata,    scripts,    count,    scriptnames,    vedmetadata =
				oldeditingmap, oldmetadata, oldroomdata, oldentitydata, oldlevelmetadata, oldscripts, oldcount, oldscriptnames, oldvedmetadata
			end
		else
			editingmap = levelname
			recentlyopened(editingmap)
			tostate(1)
			map_init()
		end
	else
		success, metadata2, roomdata2, entitydata2, levelmetadata2, scripts2, count2, scriptnames2, vedmetadata2 = loadlevel(levelname .. ".vvvvvv")

		if not success then
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata2)
		else
			-- Compare differences now!
			compareleveldifferences(levelname)
		end
	end
end

function compareleveldifferences(secondlevelname)
	-- Assuming we have both metadata till vedmetadata and metadata till vedmetadata
	-- Where xx2 is the older version, xx is the newer version. Also, secondlevelname is the older version

	differencesn = {{subj = L.RETURN, imgs = {}, cont = [[\)]]}}
	local pagetext

	-- L E V E L   P R O P E R T I E S
	pagetext = diffmessages.pages.levelproperties .. "\\wh#\n\n" .. (editingmap == "untitled\n" and langkeys(L.COMPARINGTHESENEW, {secondlevelname}) or langkeys(L.COMPARINGTHESE, {editingmap, secondlevelname})) .. "\\\n\n"
	for _,v in pairs(metadataitems) do
		if metadata2[v] ~= metadata[v] then
			pagetext = pagetext .. langkeys(diffmessages.levelpropertiesdiff[v], {metadata2[v], metadata[v]}) .. "\\\n"
		end
	end

	if metadata2.mapwidth ~= metadata.mapwidth or metadata2.mapheight ~= metadata.mapheight then
		pagetext = pagetext .. langkeys(diffmessages.levelpropertiesdiff.mapsize, {metadata2.mapwidth, metadata2.mapheight, metadata.mapwidth, metadata.mapheight}) .. "\\\n"
	end
	if metadata2.levmusic ~= metadata.levmusic then
		pagetext = pagetext .. langkeys(diffmessages.levelpropertiesdiff.levmusic, {metadata2.levmusic, metadata.levmusic}) .. "\\\n"
	end

	table.insert(differencesn, {subj = diffmessages.pages.levelproperties, imgs = {}, cont = pagetext})

	-- R O O M S
	pagetext = diffmessages.pages.changedrooms .. "\\wh#\n\n"
	local co = not s.coords0 and 1 or 0 -- coordoffset

	if metadata2.mapwidth ~= metadata.mapwidth or metadata2.mapheight ~= metadata.mapheight then
		pagetext = pagetext .. langkeys(diffmessages.levelpropertiesdiff.mapsizenote, {metadata2.mapwidth, metadata2.mapheight, metadata.mapwidth, metadata.mapheight, math.min(metadata2.mapwidth, metadata.mapwidth), math.min(metadata2.mapheight, metadata.mapheight)}) .. "\n\n"
	end

	for ry = 0, math.min(metadata2.mapheight-1, metadata.mapheight-1) do
		for rx = 0, math.min(metadata2.mapwidth-1, metadata.mapwidth-1) do
			local leftblank, rightblank, changed = true, true, false

			for k,v in pairs(roomdata2[ry][rx]) do
				if leftblank and v ~= 0 then
					leftblank = false
				end
				if rightblank and roomdata[ry][rx][k] ~= 0 then
					rightblank = false
				end
				if not changed and v ~= roomdata[ry][rx][k] then
					changed = true
				end
			end

			if changed and levelmetadata2[(ry)*20 + (rx+1)].roomname == levelmetadata[(ry)*20 + (rx+1)].roomname then
				if leftblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.added1, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname}) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.cleared1, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname}) .. "\n"
				else
					pagetext = pagetext .. langkeys(diffmessages.rooms.changed1, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname}) .. "\n"
				end
			elseif changed then -- room names not the same
				if leftblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.added2, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname, levelmetadata[(ry)*20 + (rx+1)].roomname}) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.cleared2, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname, levelmetadata[(ry)*20 + (rx+1)].roomname}) .. "\n"
				else
					pagetext = pagetext .. langkeys(diffmessages.rooms.changed2, {rx+co, ry+co, levelmetadata2[(ry)*20 + (rx+1)].roomname, levelmetadata[(ry)*20 + (rx+1)].roomname}) .. "\n"
				end
			end
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.changedrooms, imgs = {}, cont = pagetext})

	-- R O O M   M E T A D A T A
	pagetext = diffmessages.pages.changedroommetadata .. "\\wh#\n\n"

	for k,v in pairs(levelmetadata2) do
		local changed = false

		-- Is anything different?
		for k2,v2 in pairs(v) do
			if v2 ~= levelmetadata[k][k2] then
				changed = true
			end
		end

		local lrmx = (k-1) % 20
		local lrmy = math.floor(((k-1) - lrmx) / 20)

		if not s.coords0 then
			lrmx = lrmx + 1
			lrmy = lrmy + 1
		end

		if changed and levelmetadata2[k].roomname ~= levelmetadata[k].roomname then
			-- We're already going to show that the room name has changed
			pagetext = pagetext .. langkeys(diffmessages.roommetadata.changed0, {lrmx, lrmy}) .. "\n"
		elseif changed then
			-- We're not, so label this
			pagetext = pagetext .. langkeys(diffmessages.roommetadata.changed1, {lrmx, lrmy, levelmetadata2[k].roomname}) .. "\\\n"
		end

		if changed then
			-- So what has changed?
			if levelmetadata2[k].roomname ~= levelmetadata[k].roomname then
				if levelmetadata2[k].roomname == "" then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomnameadded, {levelmetadata[k].roomname}) .. "\n"
				elseif levelmetadata[k].roomname == "" then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomnameremoved, {levelmetadata2[k].roomname}) .. "\n"
				else
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomname, {levelmetadata2[k].roomname, levelmetadata[k].roomname}) .. "\n"
				end
			end
			if levelmetadata2[k].tileset ~= levelmetadata[k].tileset or levelmetadata2[k].tilecol ~= levelmetadata[k].tilecol then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.tileset, {levelmetadata2[k].tileset, levelmetadata2[k].tilecol, levelmetadata[k].tileset, levelmetadata[k].tilecol}) .. "\n"
			end
			if levelmetadata2[k].platv ~= levelmetadata[k].platv then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.platv, {levelmetadata2[k].platv, levelmetadata[k].platv}) .. "\n"
			end
			if levelmetadata2[k].enemytype ~= levelmetadata[k].enemytype then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.enemytype, {levelmetadata2[k].enemytype, levelmetadata[k].enemytype}) .. "\n"
			end
			if levelmetadata2[k].platx1 ~= levelmetadata[k].platx1 or levelmetadata2[k].platy1 ~= levelmetadata[k].platy1 or levelmetadata2[k].platx2 ~= levelmetadata[k].platx2 or levelmetadata2[k].platy2 ~= levelmetadata[k].platy2 then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.platbounds, {levelmetadata2[k].platx1, levelmetadata2[k].platy1, levelmetadata2[k].platx2, levelmetadata2[k].platy2, levelmetadata[k].platx1, levelmetadata[k].platy1, levelmetadata[k].platx2, levelmetadata[k].platy2}) .. "\n"
			end
			if levelmetadata2[k].enemyx1 ~= levelmetadata[k].enemyx1 or levelmetadata2[k].enemyy1 ~= levelmetadata[k].enemyy1 or levelmetadata2[k].enemyx2 ~= levelmetadata[k].enemyx2 or levelmetadata2[k].enemyy2 ~= levelmetadata[k].enemyy2 then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.enemybounds, {levelmetadata2[k].enemyx1, levelmetadata2[k].enemyy1, levelmetadata2[k].enemyx2, levelmetadata2[k].enemyy2, levelmetadata[k].enemyx1, levelmetadata[k].enemyy1, levelmetadata[k].enemyx2, levelmetadata[k].enemyy2}) .. "\n"
			end
			if levelmetadata2[k].directmode == 0 and levelmetadata[k].directmode == 1 then
				pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode01 .. "\n"
			elseif levelmetadata2[k].directmode == 1 and levelmetadata[k].directmode == 0 then
				pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode10 .. "\n"
			end
			if levelmetadata2[k].warpdir ~= levelmetadata[k].warpdir then
				pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.warpdir, {warpdirs[levelmetadata2[k].warpdir], warpdirs[levelmetadata[k].warpdir]}) .. "\n"
			end
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.changedroommetadata, imgs = {}, cont = pagetext})

	-- E N T I T I E S
	pagetext = diffmessages.pages.entities .. "\\wh#\n\n"

	-- Locations are identifying here.
	locentities2 = {}
	locentities = {}
	for k,v in pairs(entitydata2) do
		if locentities2[(v.x*1000)+v.y] == nil then
			locentities2[(v.x*1000)+v.y] = {entitydata2[k]}
		else
			table.insert(locentities2[(v.x*1000)+v.y], entitydata2[k])
		end
	end
	for k,v in pairs(entitydata) do
		if locentities[(v.x*1000)+v.y] == nil then
			locentities[(v.x*1000)+v.y] = {entitydata[k]}
		else
			table.insert(locentities[(v.x*1000)+v.y], entitydata[k])
		end
	end

	-- First handle double entities at one location
	for k,v in pairs(locentities) do
		if #v > 1 then
			-- This is what we're looking for.
			local bkx, bky = v[1].x % 40, v[1].y % 30
			local eroomx, eroomy = (v[1].x-bkx)/40+co, (v[1].y-bky)/30+co

			if locentities2[k] == nil then
				-- Easy, everything was added.
				pagetext = pagetext .. langkeys(diffmessages.entities.addedmultiple, {bkx, bky, eroomx, eroomy}) .. "\n"
				for k2,v2 in pairs(v) do
					pagetext = pagetext .. "  " .. langkeys(diffmessages.entities.entity, {getentityname(v2.t, v2.p1)}) .. "\n"
				end
			else
				-- Say the situation changed, IF not all entities are the same.
				local thesame = false

				if #v == #locentities2[k] then  -- The number of entities at this spot remained the same
					thesame = true  -- all these entities have a matching entity in the other level unless we find one that's different  (:1)
					for khere,vhere in pairs(v) do  -- For all entities at this location in the newer level
						local exactmatchhere = false  -- we don't know yet if this entity matches with some other entity, unless we find a match  (:2)
						for kthere,vthere in pairs(locentities2[k]) do  -- For all entities at this location in the original level
							local thisisanexactmatch = true  -- unless we find a property that doesn't match, these two match  (:3)
							for kattr,vattr in pairs(vhere) do  -- For all attributes
								if vattr ~= vthere[kattr] then  -- Is this attribute the same?
									thisisanexactmatch = false  -- It isn't? Then this specific entity isn't a match. (~3)
									break  -- Try the next entity to match against
								end
							end
							if thisisanexactmatch then  -- We ran out of attributes, and we haven't found a difference? (3?)
								exactmatchhere = true  -- Then this entity is a match (2)
								break  -- No need to keep checking whether another entity matches
							end
						end
						if not exactmatchhere then  -- Did this entity match with not other entity? (~2?)
							thesame = false  -- Then not everything is the same.
							break
						end
					end
				end

				if not thesame then
					-- Different situation
					pagetext = pagetext .. langkeys(diffmessages.entities.multiple1, {bkx, bky, eroomx, eroomy}) .. "\n"
					-- List all entities at this spot from original level
					for k2,v2 in pairs(locentities2[k]) do
						pagetext = pagetext .. "  " .. langkeys(diffmessages.entities.entity, {getentityname(v2.t, v2.p1)}) .. "\n"
					end
					pagetext = pagetext .. diffmessages.entities.multiple2 .. "\n"
					-- List all entities at this spot from newer level
					for k2,v2 in pairs(v) do
						pagetext = pagetext .. "  " .. langkeys(diffmessages.entities.entity, {getentityname(v2.t, v2.p1)}) .. "\n"
					end
				end
			end

			-- We can get rid of this now

			locentities[k] = nil
			locentities2[k] = nil
		end
	end

	-- Did we miss anything last time around? Multiple entities removed from one spot?
	for k,v in pairs(locentities2) do
		if #v > 1 then
			-- These were all removed, else we'd have seen these above
			local bkx, bky = v[1].x % 40, v[1].y % 30
			local eroomx, eroomy = (v[1].x-bkx)/40+co, (v[1].y-bky)/30+co

			pagetext = pagetext .. langkeys(diffmessages.entities.removedmultiple, {bkx, bky, eroomx, eroomy}) .. "\n"
			for k2,v2 in pairs(v) do
				pagetext = pagetext .. "  " .. langkeys(diffmessages.entities.entity, {getentityname(v2.t, v2.p1)}) .. "\n"
			end

			-- Get rid of this too
			locentities2[k] = nil
		end
	end

	-- Now we only have single entities left! Check for added and changed entities now
	for k,v in pairs(locentities) do
		local bkx, bky = v[1].x % 40, v[1].y % 30
		local eroomx, eroomy = (v[1].x-bkx)/40+co, (v[1].y-bky)/30+co
		if locentities2[k] == nil then
			-- Added
			pagetext = pagetext .. langkeys(diffmessages.entities.added, {getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}) .. "\n"
		else
			-- Maybe changed?
			local thisisanexactmatch = true
			for kattr,vattr in pairs(v[1]) do
				if vattr ~= locentities2[k][1][kattr] then
					thisisanexactmatch = false
					break
				end
			end

			if not thisisanexactmatch then
				if v[1].t ~= locentities2[k][1].t then
					-- The type was changed as well...
					pagetext = pagetext .. langkeys(diffmessages.entities.changedtype, {getentityname(locentities2[k][1].t, locentities2[k][1].p1), getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}) .. "\n"
				else
					pagetext = pagetext .. langkeys(diffmessages.entities.changed, {getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}) .. "\n"
				end
			end
		end

		-- Handled.
		locentities[k] = nil
		locentities2[k] = nil
	end

	-- Lastly, were any entities removed?
	for k,v in pairs(locentities2) do
		local bkx, bky = v[1].x % 40, v[1].y % 30
		local eroomx, eroomy = (v[1].x-bkx)/40+co, (v[1].y-bky)/30+co

		pagetext = pagetext .. langkeys(diffmessages.entities.removed, {getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}) .. "\n"

		-- Just so we can check if everything was handled.
		locentities2[k] = nil
	end

	if #locentities ~= 0 or #locentities2 ~= 0 then
		pagetext = pagetext .. "\n" .. diffmessages.entities.incomplete .. " " .. #locentities .. "," .. #locentities2 .. "\n"
	end

	table.insert(differencesn, {subj = diffmessages.pages.entities, imgs = {}, cont = pagetext})

	-- S C R I P T S
	pagetext = diffmessages.pages.scripts .. "\\wh#\n\n"

	-- Were any scripts added or changed?
	for k,v in pairs(scripts) do
		if scripts2[k] == nil then
			-- This script didn't exist in the older version, so it was added!
			pagetext = pagetext .. langkeys(diffmessages.scripts.added, {k}) .. "\n"
		else
			-- Was it edited?
			if table.concat(scripts2[k], "\n") ~= table.concat(v, "\n") then
				pagetext = pagetext .. langkeys(diffmessages.scripts.edited, {k}) .. "\n"
			end
		end
	end

	-- Any scripts that were removed?
	for k,v in pairs(scripts2) do
		if scripts[k] == nil then
			pagetext = pagetext .. langkeys(diffmessages.scripts.removed, {k}) .. "\n"
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.scripts, imgs = {}, cont = pagetext})

	if vedmetadata ~= false or vedmetadata2 ~= false then
		-- F L A G   N A M E S
		pagetext = diffmessages.pages.flagnames .. "\\wh#\n\n"

		if vedmetadata2 == false then
			-- It was added in the new version
			pagetext = pagetext .. diffmessages.mde.added .. "\n\n"

			for i = 0, 99 do
				if vedmetadata.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(diffmessages.flagnames.added, {i, vedmetadata.flaglabel[i]}) .. "\n"
				end
			end
		elseif vedmetadata == false then
			-- It was removed in the new version
			pagetext = pagetext .. diffmessages.mde.removed .. "\n\n"

			for i = 0, 99 do
				if vedmetadata2.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(diffmessages.flagnames.removed, {vedmetadata2.flaglabel[i], i}) .. "\n"
				end
			end
		else
			-- This one is simple, just cycle through the numbers!
			for i = 0, 99 do
				if vedmetadata2.flaglabel[i] == "" and vedmetadata.flaglabel[i] ~= "" then
					-- Added name
					pagetext = pagetext .. langkeys(diffmessages.flagnames.added, {i, vedmetadata.flaglabel[i]}) .. "\n"
				elseif vedmetadata2.flaglabel[i] ~= "" and vedmetadata.flaglabel[i] == "" then
					-- Removed name
					pagetext = pagetext .. langkeys(diffmessages.flagnames.removed, {vedmetadata2.flaglabel[i], i}) .. "\n"
				elseif vedmetadata2.flaglabel[i] ~= vedmetadata.flaglabel[i] then
					-- Changed name
					pagetext = pagetext .. langkeys(diffmessages.flagnames.edited, {i, vedmetadata2.flaglabel[i], vedmetadata.flaglabel[i]}) .. "\n"
				end
			end
		end

		table.insert(differencesn, {subj = diffmessages.pages.flagnames, imgs = {}, cont = pagetext})

		-- L E V E L   N O T E S
		pagetext = diffmessages.pages.levelnotes .. "\\wh#\n\n"

		if vedmetadata2 == false then
			-- It was added in the new version
			pagetext = pagetext .. diffmessages.mde.added .. "\n\n"

			for k,v in pairs(vedmetadata.notes) do
				pagetext = pagetext .. langkeys(diffmessages.levelnotes.added, {v.subj}) .. "\n"
			end
		elseif vedmetadata == false then
			-- It was removed in the new version
			pagetext = pagetext .. diffmessages.mde.removed .. "\n\n"

			for k,v in pairs(vedmetadata2.notes) do
				pagetext = pagetext .. langkeys(diffmessages.levelnotes.removed, {v.subj}) .. "\n"
			end
		else
			-- Were any notes added or changed?
			for k,v in pairs(vedmetadata.notes) do
				local found = false

				for k2, v2 in pairs(vedmetadata2.notes) do
					if v.subj == v2.subj then
						-- Maybe it has been edited?
						if v.cont ~= v2.cont then
							-- Yep, edited
							pagetext = pagetext .. langkeys(diffmessages.levelnotes.edited, {v.subj}) .. "\n"
						end
						found = true
						break
					end
				end
				if not found then
					-- It has been added
					pagetext = pagetext .. langkeys(diffmessages.levelnotes.added, {v.subj}) .. "\n"
				end
			end

			-- Any level notes that were removed?
			for k,v in pairs(vedmetadata2.notes) do
				local found = false

				for k2, v2 in pairs(vedmetadata.notes) do
					if v.subj == v2.subj then
						found = true
						break
					end
				end
				if not found then
					pagetext = pagetext .. langkeys(diffmessages.levelnotes.removed, {v.subj}) .. "\n"
				end
			end
		end

		table.insert(differencesn, {subj = diffmessages.pages.levelnotes, imgs = {}, cont = pagetext})
	end


	tostate(15, nil, {differencesn, false})
end

function getentityname(id, p1)
	if id ~= 2 then
		-- Just look it up!
		for t = 4, #entitytooltoid do
			if entitytooltoid[t] == id then
				return toolnames[t]
			end
		end

		-- And now?
		return id
	else
		-- It's a platform, but what kind?
		if p1 <= 4 then
			return toolnames[8]
		else
			return toolnames[7]
		end
	end
end

function toolscroll()
	lefttoolscroll = math.max(16-(48*(selectedtool-1)), lefttoolscroll)--, lefttoolscroll+(love.graphics.getHeight()-32))--, -368)
	lefttoolscroll = math.min(16-(48*(selectedtool-1))+(love.graphics.getHeight()-32)-64, lefttoolscroll)
end

function listoverlappingentities(tabel)
	for k,v in pairs(entitydata) do
		for k2,v2 in pairs(entitydata) do
			if k ~= k2 and v.x == v.x2 and v.y == v.y2 then
				table.insert(tabel, v)
				cons("--\nOverlap: Entity #" .. k .. " type " .. v.t .. " in room " .. (v.x/40) .. "," .. (v.y/30) .. "\n   with: Entity #" .. k2 .. " type " .. v2.t .. " in room " .. (v2.x/40) .. "," .. (v2.y/30) .. "\n")
			end
		end
	end
end

function triggernewlevel(width, height)
	if width == nil or height == nil then
		width, height = 5, 5
	end
	success, metadata, roomdata, entitydata, levelmetadata, scripts, count, scriptnames, vedmetadata = createblanklevel(width, height)
	map_init()
	editingmap = "untitled\n"
	tostate(1)
end

function cons_fc(text)
	table.insert(FClist, text)
	cons("[CHECK] " .. text)
end

function handle_scrolling(viakeyboard, mkinput, customdistance)
	local direction, distance

	if viakeyboard then
		distance = 10*46
		if mkinput == "pageup" then
			direction = "u"
		elseif mkinput == "pagedown" then
			direction = "d"
		end
	else
		distance = 16
		if mkinput == "wu" then
			direction = "u"
		elseif mkinput == "wd" then
			direction = "d"
		end
	end
	if customdistance ~= nil then
		distance = customdistance
	end


	if direction ~= nil then
		if state == 3 and not viakeyboard then
			if direction == "u" then
				scriptscroll = scriptscroll + distance
				if scriptscroll > 0 then
					scriptscroll = 0
				end
			elseif direction == "d" then
				scriptscroll = scriptscroll - distance
				local upperbound = (((#scriptlines*8+16)*(textsize and 2 or 1)-(textsize and 24 or 0))-(love.graphics.getHeight()-24)) -- scrollableHeight - visiblePart
				if -scriptscroll > upperbound then
					scriptscroll = math.min(-upperbound, 0)
				end
			end
		elseif state == 6 then
			if direction == "u" then
				levellistscroll = levellistscroll + distance
				if levellistscroll > 0 then
					levellistscroll = 0
				end
			elseif direction == "d" then
				levellistscroll = levellistscroll - distance
				local lessheight = 48
				if #s.recentfiles > 0 and input == "" and input_r == "" then
					lessheight = lessheight + 16 + #s.recentfiles*8
				end
				local upperbound = ((max_levellistscroll)-(love.graphics.getHeight()-lessheight))
				if -levellistscroll > upperbound then
					levellistscroll = math.min(-upperbound, 0)
				end
			end
		elseif state == 10 then
			if direction == "u" then
				scriptlistscroll = scriptlistscroll + distance
				if scriptlistscroll > 0 then
					scriptlistscroll = 0
				end
			elseif direction == "d" then
				local ndisplayedscripts = 0
				if scriptdisplay_used and scriptdisplay_unused then
					ndisplayedscripts = #scriptnames
				elseif scriptdisplay_used then
					ndisplayedscripts = n_usedscripts
				elseif scriptdisplay_unused then
					ndisplayedscripts = #scriptnames - n_usedscripts
				end
				scriptlistscroll = scriptlistscroll - distance
				local upperbound = ((ndisplayedscripts*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
				if -scriptlistscroll > upperbound then
					scriptlistscroll = math.min(-upperbound, 0)
				end
			end
		elseif state == 15 then
			if love.mouse.getX() <= 25*8 then
				if direction == "u" then
					helplistscroll = helplistscroll + distance
					if helplistscroll > 0 then
						helplistscroll = 0
					end
				elseif direction == "d" then
					helplistscroll = helplistscroll - distance
					local upperbound = (((#helppages+(helpeditable and 1 or 0))*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
					if -helplistscroll > upperbound then
						helplistscroll = math.min(-upperbound, 0)
					end
				end
			elseif love.mouse.getX() >= 25*8+8 then
				if direction == "u" then
					helparticlescroll = helparticlescroll + distance
					if helparticlescroll > 0 then
						helparticlescroll = 0
					end
				elseif direction == "d" then
					helparticlescroll = helparticlescroll - distance
					-- #anythingbutnil(helparticlecontent) is very quirky; if the table helparticlecontent == nil, then we get an empty string, and #"" is 0, which is exactly what we want.
					-- The alternative is defining an extra anythingbutnil* function for returning an empty list, but #{}==#"" and if not nil, it just happily returns the table it got.
					local upperbound = ((#anythingbutnil(helparticlecontent)*10)-(love.graphics.getHeight()-32))
					if -helparticlescroll > upperbound then
						helparticlescroll = math.min(-upperbound, 0)
					end
				end

				if helpeditingline ~= 0 and viakeyboard then
					helparticlecontent[helpeditingline] = input .. input_r
					input_r = ""
					__ = "_"
					if direction == "u" then
						helpeditingline = math.max(1, helpeditingline - 46)
					else
						helpeditingline = math.min(#helparticlecontent, helpeditingline + 46)
					end
					input = anythingbutnil(helparticlecontent[helpeditingline])
				end
			end
		end
	end
end

function is_scrollable(x, y)
	if state == 3 or state == 10 or state == 15 then
		return true
	end
	if state == 6 and x < love.graphics.getWidth()-128 then
		return true
	end
	return false
end

function getalllanguages()
	local languagesarray = love.filesystem.getDirectoryItems("lang")
	local returnarray = {}

	for k,v in pairs(languagesarray) do
		if v:sub(-4,-1) == ".lua" then
			table.insert(returnarray, v:sub(1,-5))
		end
	end

	return returnarray
end

function colorsetting(label, pos, mycolor)
	--hoverdraw(checkoff, 8, 8+(24*pos), 16, 16, 2)
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 8, 8+(24*pos), 32, 16)
	love.graphics.setColor(mycolor)
	love.graphics.rectangle("fill", 9, 9+(24*pos), 30, 14)
	if editingcolor == mycolor then
		love.graphics.setColor(255,255,255)
	else
		love.graphics.setColor(128,128,128)
	end
	love.graphics.print(label, 8+32+8, 8+(24*pos)+4+2)

	if mouseon(8, 8+(24*pos), 32, 16) then
		love.graphics.setColor(255,255,255,64)
		love.graphics.rectangle("fill", 9, 9+(24*pos), 30, 14)

		if love.mouse.isDown("l") and editingcolor ~= mycolor then
			editingcolor = mycolor
		end
	end

	love.graphics.setColor(255,255,255,255)
end

function tonotepad()
	if vedmetadata ~= false then
		tostate(15, nil, {vedmetadata.notes, true})
	else
		vedmetadata = createmde()
		tostate(15, nil, {vedmetadata.notes, true})
	end
end

function s_nieuw(t)
	s_veld = {}
	for y = 0, 6 do
		s_veld[y] = {}
		for x = 0, 9 do
			s_veld[y][x] = 0
		end
	end

	s_veld[3][1] = 1
	s_puntje = 1
	s_volgendenek = 2
	s_ge2ten = 0
	s_hoofdx = 2
	s_hoofdy = 3
	s_hoofdd = 1
	sp_t = t
	sp_go = false
	sp_got = 1.5
	sp_tim = 0

	s_noep()
end

function s_noep()
	legeplekken = 0
	for ky,vy in pairs(s_veld) do
		for kx,vx in pairs(vy) do
			if vx == 0 and not (s_hoofdx == kx and s_hoofdy == ky) and not (
				(kx == 0 and ky == 0) or
				(kx == 0 and ky == 6) or
				(kx == 9 and ky == 0) or
				(kx == 9 and ky == 6)
			) then
				legeplekken = legeplekken + 1
			end
		end
	end

	if legeplekken == 0 then
		return
	end

	gekozenplek = math.random(0, legeplekken-1)

	for ky,vy in pairs(s_veld) do
		for kx,vx in pairs(vy) do
			if vx == 0 and not (s_hoofdx == kx and s_hoofdy == ky) and not (
				(kx == 0 and ky == 0) or
				(kx == 0 and ky == 6) or
				(kx == 9 and ky == 0) or
				(kx == 9 and ky == 6)
			) then
				if gekozenplek == 0 then
					s_veld[ky][kx] = -1
					return
				end
				gekozenplek = gekozenplek - 1
			end
		end
	end		

	dialog.create("s_noep() failed!")
end

function s_verwpuntje()
	for ky,vy in pairs(s_veld) do
		for kx,vx in pairs(vy) do
			if vx == s_puntje then
				s_veld[ky][kx] = 0
				s_puntje = s_puntje + 1
				return
			end
		end
	end
end

function s_nek()
	s_veld[s_hoofdy][s_hoofdx] = s_volgendenek
	s_volgendenek = s_volgendenek + 1
end

function p_nieuw(t)
	sp_t = -t
end

function sp_tap()
	if sp_t > 0 then
		if s_hoofdd == 0 then
			if s_hoofdy <= 0 then sp_go = true; return end
			s_nek()
			s_hoofdy = s_hoofdy - 1
		elseif s_hoofdd == 1 then
			if s_hoofdx >= 9 then sp_go = true; return end
			s_nek()
			s_hoofdx = s_hoofdx + 1
		elseif s_hoofdd == 2 then
			if s_hoofdy >= 6 then sp_go = true; return end
			s_nek()
			s_hoofdy = s_hoofdy + 1
		else
			if s_hoofdx <= 0 then sp_go = true; return end
			s_nek()
			s_hoofdx = s_hoofdx - 1
		end

		if s_veld[s_hoofdy][s_hoofdx] == -1 then
			s_veld[s_hoofdy][s_hoofdx] = 0
			s_ge2ten = s_ge2ten + 1
			s_noep()
		elseif s_veld[s_hoofdy][s_hoofdx] ~= 0 and s_veld[s_hoofdy][s_hoofdx] ~= s_puntje then
			sp_go = true
		else
			s_verwpuntje()
		end
	else

	end
end

function sp_teken(v, offx, offy, myroomx, myroomy)
	ox = offx+(v.x-myroomx*40)*16 + 6
	oy = offy+(v.y-myroomy*30)*16 + 24

	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", ox, oy, 20, 14)
	love.graphics.setColor(0,255,0)

	if sp_t > 0 then
		if sp_go and sp_got > 0 then
			if s_ge2ten > 99 then
				tinyprint(s_ge2ten, ox+4, oy+4)
			else
				love.graphics.print(s_ge2ten, ox+3, oy+5)
			end
		else
			for y = 0, 6 do
				for x = 0, 9 do
					if s_veld[y][x] > 0 or (s_hoofdx == x and s_hoofdy == y) then
						love.graphics.rectangle("fill", ox+2*x, oy+2*y, 2, 2)
					elseif s_veld[y][x] == -1 then
						if cursorflashtime <= .7 then
							love.graphics.rectangle("fill", ox+2*x, oy+2*y, 2, 2)
						else
							love.graphics.rectangle("fill", ox+2*x, oy+2*y-1, 2, 1)
							love.graphics.rectangle("fill", ox+2*x-1, oy+2*y, 1, 2)
							love.graphics.rectangle("fill", ox+2*x+2, oy+2*y, 1, 2)
							love.graphics.rectangle("fill", ox+2*x, oy+2*y+2, 2, 1)
						end
					end
				end
			end
		end
	else
		love.graphics.rectangle("fill", ox+3, oy+3, 1, 1)
		love.graphics.rectangle("fill", ox+4, oy+4, 1, 1)
		love.graphics.rectangle("fill", ox+5, oy+5, 1, 1)
		love.graphics.rectangle("fill", ox+3, oy+5, 1, 1)
		love.graphics.rectangle("fill", ox+5, oy+3, 1, 1)
	end

	if math.random(0,100) < 10 then
		if math.random(0,10) < 4 then
			love.graphics.setColor(0,0,0)
		end

		love.graphics.rectangle("fill", ox+math.random(0,19), oy+math.random(0,13), 1, 1)
	end

	love.graphics.setColor(255,255,255)
end

function uniquenotename(newname, oldname)
	if newname == oldname then
		return newname
	end
	local i, found = 0, false

	while not found do
		i = i+1
		found = true
		for k,v in pairs(helppages) do
			if (i == 1 and v.subj == newname) or (i ~= 1 and v.subj == newname .. i) then
				found = false
				break
			end
		end
	end

	if i == 1 then
		return newname
	end
	return newname .. i
end

function updatewindowicon()
	love.window.setIcon(toolimgicon[selectedtool])
end

function roomtext_extralines(text)
	_, thelines = font16:getWrap(text, 40*16)

	-- thelines is a number in 0.9.x, and a table/sequence in 0.10.x and higher
	if type(thelines) == "table" then
		return #thelines - 1
	else
		return thelines - 1
	end
end

function gotohelparticle(n)
	helparticle = n
	helparticlecontent = explode("\n", helppages[helparticle].cont)
	helparticlescroll = 0
end

function keyboard_eitherIsDown(button)
	return love.keyboard.isDown("l" .. button) or love.keyboard.isDown("r" .. button)
end

-- Simply print a string in the tiny font
function tinyprint(text, x, y)
	love.graphics.setFont(tinynumbers)
	love.graphics.print(text, x, y)
	love.graphics.setFont(font8)
end

function textshadow(text, x, y, largefont)
	love.graphics.setColor(128,128,128,192)
	love.graphics.rectangle("fill", x, y, love.graphics.getFont():getWidth(text), largefont and 16 or 8)
	love.graphics.setColor(255,255,255,255)
end

function setgenerictimer(mode, sec)
	generictimer = sec
	generictimer_mode = mode
end

function recentlyopened(levelname)
	if #s.recentfiles > 0 and s.recentfiles[#s.recentfiles] == levelname then
		return
	end
	for k,v in pairs(s.recentfiles) do
		if v == levelname then
			table.remove(s.recentfiles, k)
			break
		end
	end
	table.insert(s.recentfiles, levelname)
	while #s.recentfiles > 5 do
		table.remove(s.recentfiles, 1)
	end
	saveconfig()
end

function getlockablemouseX()
	if mouselockx == nil or mouselockx == -1 then
		return love.mouse.getX()
	end
	return mouselockx
end

function getlockablemouseY()
	if mouselocky == nil or mouselocky == -1 then
		return love.mouse.getY()
	end
	return mouselocky
end

function backup_level(levelsfolder, levelname)
	-- levelname is `editingmap` - without ".vvvvvv"
	-- What's the full path?
	local fullpath = levelsfolder .. dirsep .. levelname .. ".vvvvvv"

	-- Get the current contents of the level file, so we can save it somewhere else
	local success, contents = readlevelfile(fullpath)
	if not success then
		-- Oh, it doesn't exist or something.
		return false
	end

	-- If we're on Windows, we're dealing with backslashes at the moment. But we don't need that in love.filesystem.
	if dirsep == "\\" then
		levelname = levelname:gsub("\\", "/")
	end

	-- What to save it as?
	local nowtime = os.time()
	local modtime = anythingbutnil0(tonumber(getmodtime(fullpath)))
	local savename = nowtime .. "_" .. modtime .. "_" .. levelname:gsub("/", "__") .. ".vvvvvv"

	-- Actually save
	if not write_overwrite_backup_file(levelname, savename, contents) then
		return false
	end

	-- Level files can be several megabytes big, and you may save often.
	prune_old_overwrite_backups(levelname)

	return true
end

function prune_old_overwrite_backups(levelname)
	-- What are all the backups we already got?
	local oldest = {os.time()+3600, nil} -- time and key to full filename

	local files = love.filesystem.getDirectoryItems("overwrite_backups/" .. levelname .. "/")
	-- We only want this list of files to contain actual backups, so other things don't mess us up!
	local ignorefiles = {}
	for k,v in pairs(files) do
		if not v:find("^[0-9]+_[0-9]+_.*%.vvvvvv$") then
			cons(v .. " does not seem like one of my backup files, so I'm ignoring it.")
			table.insert(ignorefiles, v)
		end
	end
	-- Temporarily screw avoiding O(n^2), we don't have more than thousands of backups, and we're only doing this once when saving, right?
	for k,v in pairs(ignorefiles) do
		for k2,v2 in pairs(files) do
			if v == v2 then
				table.remove(files, k2)
				break
			end
		end
	end
	while #files > s.amountoverwritebackups and #files > 0 do
		for k,v in pairs(files) do
			local parts = explode("_", v)

			if tonumber(parts[1]) ~= nil and tonumber(parts[1]) < oldest[1] then
				oldest[1] = tonumber(parts[1])
				oldest[2] = k
			end
		end
		-- Now we did find at least something, right?
		if oldest[2] == nil then
			break
		end
		cons("Pruning away backup " .. files[oldest[2]] .. " because it's the oldest")
		love.filesystem.remove("overwrite_backups/" .. levelname .. "/" .. files[oldest[2]])
		table.remove(files, oldest[2])
	end
end

function write_overwrite_backup_file(levelname, savename, contents)
	-- Make sure levels in subfolders also get backed up properly.
	levelname = levelname:gsub("/", "__")
	if not love.filesystem.exists("overwrite_backups/" .. levelname) then
		love.filesystem.createDirectory("overwrite_backups/" .. levelname)
	end

	return love.filesystem.write("overwrite_backups/" .. levelname .. "/" .. savename, contents)
end

function windowfits(w, h, monitorres)
	return w <= monitorres[1] and h <= monitorres[2]
end

function languagedialog()
	languageslist = getalllanguages()
	local standarddateformat_key, customdateformat = nil, s.dateformat
	for k,v in pairs(standarddateformat_formats) do
		if s.dateformat == v then
			standarddateformat_key = k
			break
		end
	end
	if standarddateformat_key == nil then
		standarddateformat_key = 4
	end
	startmultiinput({s.lang, standarddateformat_key, customdateformat})
	dialog.new(L.RESTARTVEDLANG, L.LANGUAGE, 1, 4, 24)
end

function format_date(timestamp)
	return os.date(s.dateformat, timestamp)
end

function drawlink(link)
	love.graphics.setColor(255,255,255,192)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-10, font8:getWidth(link)+8, 10)
	love.graphics.setColor(0,0,0)
	love.graphics.print(link, 4, love.graphics.getHeight()-7)
	love.graphics.setColor(255,255,255)
end

function unrecognized_rcmreturn()
	dialog.create(RCMid .. " " .. RCMreturn .. " unrecognized.")
end

-- Returns true if there are unsaved changes.
function has_unsaved_changes()
	if metadata == nil or no_more_quit_dialog then
		return false
	end
	if unsavedchanges then
		return true
	end
	if undobuffer == nil then
		return false
	end
	if #undobuffer == saved_at_undo then
		return false
	end
	return true
end

-- Just stores that a change was made to the currently opened level that cannot be undone
function dirty()
	if not unsavedchanges then
		unsavedchanges = true
	end
end

function temp_print_override()
	-- This will stop being used later.
	-- Basically, in LÖVE 0.9 and 0.10, the TTF font is displaced, and the correction for this has
	-- always been hardcoded. This doesn't happen in 11+, and also doesn't happen for bitmap fonts.
	-- Plan is to remove the hardcoded offset EVERYWHERE and hijack lg.print[f] for 0.9/0.10 with TTF instead.

	function love11_tempfixfontpos(func, ...)
		local args = {...}
		local currentfont = love.graphics.getFont()
		if currentfont == font8 then
			args[3] = args[3] - 2 -- y
		elseif currentfont == font16 then
			args[3] = args[3] - 3
		end
		func(unpack(args))
	end

	love.graphics.print11 = love.graphics.print

	love.graphics.print = function(...)
		love11_tempfixfontpos(love.graphics.print11, ...)
	end

	love.graphics.printf11 = love.graphics.printf

	love.graphics.printf = function(...)
		love11_tempfixfontpos(love.graphics.printf11, ...)
	end
end


-- Some helper functions for level-specific vars in the metadata entity
function cast_level_var_type(t, v)
	if t == "b" then
		return v == "1"
	elseif t == "n" then
		return tonumber(v)
	elseif t == "t" then
		if type(v) ~= "table" then
			return nil
		end
		local tab = {}
		local current_type -- Precedes both key and value
		local current_key, current_value
		for k,v in pairs(v) do
			local ix = ((k-1)%4)+1
			if ix == 1 or ix == 3 then
				-- Key type or value type
				current_type = v
			elseif ix == 2 then
				-- Key
				current_key = cast_level_var_type(current_type, v)
			elseif ix == 4 then
				-- Value
				if current_key ~= nil then
					tab[current_key] = cast_level_var_type(current_type, v)
				end
				current_key, current_value = nil
			end
		end
		return tab
	end
	return v
end

function serialize_level_var_type(value, disallow_table)
	if type(value) == "boolean" then
		return "b", value and "1" or "0"
	elseif type(value) == "number" then
		return "n", tostring(value)
	elseif type(value) == "string" then
		return "s", value
	elseif type(value) == "table" and not disallow_table then
		-- Only 1d tables!
		tab = {}
		for k,v in pairs(value) do
			local key_type, key = serialize_level_var_type(k, true)
			local val_type, val = serialize_level_var_type(v, true)

			if key_type == nil or val_type == nil then
				return nil, nil
			end

			table.insert(tab, key_type)
			table.insert(tab, key)
			table.insert(tab, val_type)
			table.insert(tab, val)
		end
		return "t", tab
	else
		return nil, nil
	end
end

-- Functions for level-specific vars in the metadata entity
function get_level_var(key)
	-- Might look excessive, but we don't want "falsy" stuff, and returning nil is clear
	if vedmetadata == false or vedmetadata == nil then
		return nil
	end

	if vedmetadata.vars[key] == nil then
		return nil
	end

	return cast_level_var_type(vedmetadata.vars[key]["type"], vedmetadata.vars[key].value)
end

function get_all_level_vars()
	-- Get all vars as an array.

	if vedmetadata == false or vedmetadata == nil then
		return {}
	end

	local vars = {}

	for k,v in pairs(vedmetadata.vars) do
		vars[k] = cast_level_var_type(v["type"], v.value)
	end

	return vars
end

function set_level_var(key, value)
	-- Returns false in case of invalid value type, true if valid.

	if vedmetadata == false then
		vedmetadata = createmde()
	end

	local t, v = serialize_level_var_type(value)

	if t == nil then
		return false
	end

	vedmetadata.vars[key] = {
		["type"] = t,
		value = v
	}

	return true
end

function remove_level_var(key)
	if vedmetadata == false or vedmetadata == nil then
		return
	end

	vedmetadata.vars[key] = nil
end

function clear_canvas(canvas)
	if love_version_meets(10) then
		love.graphics.clear()
	else
		canvas:clear()
	end
end

function renderer_info_string()
	local rend_name, rend_version, rend_vendor, rend_device = love.graphics.getRendererInfo()

	return L.RENDERERINFO .. "\n\n"
		.. rend_name .. " - " .. rend_version .. "\n"
		.. rend_device .. "\n"
		.. rend_vendor
end

function explore_lvl_dir()
	love.system.openURL("file://" .. levelsfolder)
end

hook("func")
