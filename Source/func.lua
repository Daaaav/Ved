love.graphics.clearOR = love.graphics.clear
love.graphics.clear = function(...)
	if not s.pausedrawunfocused or window_active() then
		love.graphics.clearOR(...)
	end
end

love.keyboard.isDownOR = love.keyboard.isDown
love.keyboard.isDown = function(...)
	for _,key in pairs({...}) do
		if table.contains(skipnextkeys, key) then
		elseif love.keyboard.isDownOR(key) then
			return true
		end
	end
	return false
end

love.mouse.isDownOR = love.mouse.isDown
love.mouse.isDown = function(...)
	for _,button in pairs({...}) do
		if table.contains(skipnextmouses, button) then
		elseif love.mouse.isDownOR(button) then
			return true
		end
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
		local lastchar = string.sub(worktext, -1, -1):byte()
		if lastchar == nil then return "" end

		-- Are we about to kill a UTF-8 continuation byte?
		if lastchar >= 0x80 and lastchar <= 0xBF then -- 10xxxxxx
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
		local lastchar = string.sub(text, -1, -1):byte()
		if lastchar == nil then return "", righttext end

		-- Are we about to kill a UTF-8 continuation byte?
		if lastchar >= 0x80 and lastchar <= 0xBF then -- 10xxxxxx
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

	local lastchar = string.sub(righttext, 1, 1):byte()
	if lastchar == nil then return text, "" end

	-- Different UTF-8 stuff going on here.
	if lastchar >= 0xC0 and lastchar <= 0xDF then -- 110xxxxx
		-- Two bytes to move at once!
		text = text .. string.sub(righttext, 1, 2)
		return text, string.sub(righttext, 3, -1)
	elseif lastchar >= 0xE0 and lastchar <= 0xEF then -- 1110xxxx
		-- Three bytes to move at once!
		text = text .. string.sub(righttext, 1, 3)
		return text, string.sub(righttext, 4, -1)
	elseif lastchar >= 0xF0 and lastchar <= 0xF7 then -- 11110xxx
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

	local lastchar = string.sub(text, 1, 1):byte()
	if lastchar == nil then return text end

	-- Mostly the same as rightspace()
	if lastchar >= 0xC0 and lastchar <= 0xDF then -- 110xxxxx
		-- Two bytes to move at once!
		return string.sub(text, 1, 2)
	elseif lastchar >= 0xE0 and lastchar <= 0xEF then -- 1110xxxx
		-- Three bytes to move at once!
		return string.sub(text, 1, 3)
	elseif lastchar >= 0xF0 and lastchar <= 0xF7 then -- 11110xxx
		-- Four!
		return string.sub(text, 1, 4)
	else
		-- Just one byte of course.
		return string.sub(text, 1, 1)
	end
end

function allbutfirstUTF8(text)
	if text == nil then return end

	local firstchar = text:sub(1, 1):byte()
	if firstchar == nil then
		return text
	end

	if firstchar >= 0xC0 and firstchar <= 0xDF then -- 110xxxxx
		return text:sub(3, text:len())
	elseif firstchar >= 0xE0 and firstchar <= 0xEF then -- 1110xxxx
		return text:sub(4, text:len())
	elseif firstchar >= 0xF0 and firstchar <= 0xF7 then -- 11110xxx
		return text:sub(5, text:len())
	else
		return text:sub(2, text:len())
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

function startinput()
	cons("Input started (not once)")
	input = ""
	input_r = ""
	__ = "_"
	cursorflashtime = 0
	takinginput = true
end

function startinputonce()
	if not takinginput then
		cons("Input started (once)")
		input = ""
		input_r = ""
		__ = "_"
		cursorflashtime = 0
		takinginput = true
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
end

function tostate(new, dontinitialize, ...)
	-- The feedback from the button should be over by now
	-- Make sure it doesn't carry into another state
	if generictimer_mode == 1 then
		setgenerictimer(0, 0)
	end

	if dontinitialize == nil then
		dontinitialize = false
	end

	if newinputsys ~= nil then -- nil check only because we're in a temporary transitional period
		newinputsys.pause()
	end

	oldstate = state
	state = anythingbutnil0(tonumber(new)) -- please
	if not dontinitialize then
		cons("State changed: " .. oldstate .. " => " .. state .. " (inited)")
		loadstate(state, ...) -- just so states can be prepared easily
	else
		cons("State changed: " .. oldstate .. " => " .. state .. " (not initialized)")
	end

	if special_cursor then
		love.mouse.setCursor()
		special_cursor = false
	end

	if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		unset_middlescroll()
	end

	if oldstate == 1 then
		editingroomname = false
	end
end

function loadstate(new, ...)
	if uis[new] ~= nil and uis[new].load ~= nil then
		uis[new].load(...)
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


function loadlevelsfolder()
	cons("Loading levels folder...")
	levels_refresh = levels_refresh + 1
	if allmetadata_inchannel ~= nil then
		allmetadata_inchannel:clear()
	end
	lsuccess = directory_exists(vvvvvvfolder, "levels")
	if lsuccess then
		files = listlevelfiles(levelsfolder)
	else
		files = {}
	end
	metadataloaded_folders = {}
	recentmetadata_files = {}
	metadata_lastmodified = {}
	for kdir,vdir in pairs(files) do
		local dirprefix
		if kdir == "" then
			dirprefix = ""
		else
			dirprefix = kdir .. dirsep
		end
		for kfile,vfile in pairs(vdir) do
			metadata_lastmodified[dirprefix .. vfile.name] = vfile.lastmodified
		end
	end
	current_scrolling_leveltitle_k = nil
	current_scrolling_leveltitle_title = nil
	current_scrolling_leveltitle_pos = 168
	current_scrolling_levelfilename_k = nil
	current_scrolling_levelfilename_filename = nil
	current_scrolling_levelfilename_pos = (s.psmallerscreen and 50-12 or 50)*8
	cons("Loaded.")
	-- Now get all the backups
	files[".ved-sys" .. dirsep .. "backups"] = {}
	local rootbackupfolders = love.filesystem.getDirectoryItems("overwrite_backups")
	for k1, f1 in pairs(rootbackupfolders) do
		table.insert(files[".ved-sys" .. dirsep .. "backups"],
			{
				name = f1,
				isdir = love.filesystem.isDirectory("overwrite_backups/" .. f1),
				bu_lastmodified = 0,
				bu_overwritten = 0,
				lastmodified = nil,
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
							bu_lastmodified = lm,
							bu_overwritten = ov,
							lastmodified = nil,
						}
					)
				end
			end
		end
	end
end

function getlevelassetsfolder()
	-- Priority: lev.data.zip, everything in .zip, lev/ folder
	-- Currently lev/ folder is supported
	if directory_exists(levelsfolder, editingmap) then
		return levelsfolder .. dirsep .. editingmap
	end

	-- Not found
	return nil
end

function loadtilesets(levelassetsfolder)
	-- Normally called without argument. This function may call itself once more with it filled.
	-- levelassetsfolder may be a path to a level-specific assets folder, which overrides any existing assets

	loadtileset("tiles.png", levelassetsfolder)
	loadtileset("tiles2.png", levelassetsfolder)
	loadtileset("tiles3.png", levelassetsfolder)
	loadtileset("entcolours.png", levelassetsfolder)
	loadsprites("sprites.png", 32, levelassetsfolder)
	loadsprites("teleporter.png", 96, levelassetsfolder)

	loadvcecustomgraphics(levelassetsfolder)


	if levelassetsfolder ~= nil then
		-- We're done loading level-specific assets
		level_assets_loaded = true
		return
	else
		-- Don't reload stock tiles and sprites if both old and new levels have no assets.
		level_assets_loaded = false
	end

	-- Now maybe we have a level to load level-specific assets for?
	if editingmap ~= nil then
		local levelassets = getlevelassetsfolder()
		if levelassets ~= nil then
			cons("Loading level-specific assets from " .. levelassets)
			loadtilesets(levelassets)
		end
	end

	-- Doesn't rely on loading files from somewhere specific
	loadwarpbgs()
end

function loadvcecustomgraphics(levelassetsfolder)
	local success, files
	if levelassetsfolder == nil then
		vcecustomtilesets = {} -- num -> tiles{num}.png, for any tiles{num}.png that exists
		vcecustomspritesheets = {} -- same for any sprites{num}.png that exists

		success, files = listfiles_generic(graphicsfolder, ".png", false)
	else
		success, files = listfiles_generic(levelassetsfolder .. dirsep .. "graphics", ".png", false)
	end
	if not success then
		return
	end

	for k,v in pairs(files) do
		if not v.isdir then
			local num_tiles = v.name:match("^tiles(%d+).png$")
			local num_sprites = v.name:match("^sprites(%d+).png$")

			if num_tiles ~= nil and tonumber(num_tiles) >= 4 then
				loadtileset(v.name, levelassetsfolder)
				vcecustomtilesets[tonumber(num_tiles)] = v.name
			elseif num_sprites ~= nil and tonumber(num_sprites) >= 2 then
				loadsprites(v.name, 32, levelassetsfolder)
				vcecustomspritesheets[tonumber(num_sprites)] = v.name
			end
		end
	end
end

function loadtileset(file, levelassetsfolder)
	local readsuccess, contents
	if levelassetsfolder == nil then
		-- Just loading global assets, either custom or built-in
		tilesets[file] = {}

		-- Try loading custom assets first
		readsuccess, contents = readfile(graphicsfolder .. dirsep .. file)
	else
		-- Level-specific file
		readsuccess, contents = readfile(levelassetsfolder .. dirsep .. "graphics" .. dirsep .. file)

		-- Not interested in another copy of the assets we already had
		if not readsuccess then
			return
		end

		-- This level-specific file definitely exists
		tilesets[file] = {}
	end

	local asimgdata, asimgdata_white
	if readsuccess then
		-- Custom image!
		cons("Custom image: " .. file)
		asimgdata = love.image.newImageData(love.filesystem.newFileData(contents, file, "file"))
		-- Too bad Data:clone() is LÖVE 11+ only
		asimgdata_white = love.image.newImageData(love.filesystem.newFileData(contents, file, "file"))
	else
		cons("No custom image for " .. file .. ", " .. contents)
		asimgdata = love.image.newImageData(file)
		-- Too bad Data:clone() is LÖVE 11+ only
		asimgdata_white = love.image.newImageData(file)
	end

	tilesets[file]["img"] = love.graphics.newImage(asimgdata)
	tilesets[file]["width"] = tilesets[file]["img"]:getWidth()
	tilesets[file]["height"] = tilesets[file]["img"]:getHeight()
	tilesets[file]["tileswidth"] = tilesets[file]["width"]/8  -- 16
	tilesets[file]["tilesheight"] = tilesets[file]["height"]/8  -- 16

	cons("Loading tileset: " .. file .. ", " .. tilesets[file]["width"] .. "x" .. tilesets[file]["height"] .. ", " .. tilesets[file]["tileswidth"] .. "x" .. tilesets[file]["tilesheight"])

	-- Some tiles need to show up in any color we choose, so make another version where everything is white so we can color-correct it.
	asimgdata_white:mapPixel(function(x, y, r, g, b, a)
		return 255, 255, 255, a
	end)
	tilesets[file]["white_img"] = love.graphics.newImage(asimgdata_white)

	tilesets[file]["tiles"] = {}

	for tsy = 0, (tilesets[file]["tilesheight"]-1) do
		for tsx = 0, (tilesets[file]["tileswidth"]-1) do
			tilesets[file]["tiles"][(tsy*tilesets[file]["tileswidth"])+tsx] = love.graphics.newQuad(tsx*8, tsy*8, 8, 8, tilesets[file]["width"], tilesets[file]["height"]) -- 16 16 16 16
		end
	end

	-- If this tileset is smaller than 1200 (tiles3) then fill up with tile 0 to prevent crashes
	for filler = tilesets[file].tileswidth*tilesets[file].tilesheight, 1199 do
		tilesets[file].tiles[filler] = love.graphics.newQuad(0, 0, 8, 8, tilesets[file].width, tilesets[file].height)
	end
end

function loadsprites(file, res, levelassetsfolder)
	local readsuccess, contents
	if levelassetsfolder == nil then
		-- Just loading global assets, either custom or built-in
		tilesets[file] = {}

		-- Try loading custom assets first
		readsuccess, contents = readfile(graphicsfolder .. dirsep .. file)
	else
		-- Level-specific file
		readsuccess, contents = readfile(levelassetsfolder .. dirsep .. "graphics" .. dirsep .. file)

		-- Not interested in another copy of the assets we already had
		if not readsuccess then
			return
		end

		-- This level-specific file definitely exists
		tilesets[file] = {}
	end

	local asimgdata
	if readsuccess then
		-- Custom image!
		cons("Custom image: " .. file)
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

function loadwarpbgs()
	-- warpbgs[C][D] means warp background color C, direction D.
	-- So, you can fill in warpbg from the big tilesetblocks table from const,
	-- and the warpdir room property.
	warpbgs = {}

	for c = 1, 7 do
		table.insert(warpbgs, {})

		for d = 1, 2 do
			table.insert(warpbgs[c],
				love.graphics.newSpriteBatch(tilesets["tiles2.png"]["img"], 16*21, "static")
			)
			local quad = love.graphics.newQuad(
				-24+24*c, 128 + 16*d, 16, 16,
				tilesets["tiles2.png"]["width"], tilesets["tiles2.png"]["height"]
			)
			for bgy = -1, 14 do
				for bgx = -1, 19 do
					warpbgs[c][d]:add(quad, 32*bgx, 32*bgy, 0, 2)
				end
			end
		end
	end
end

function user_reload_tilesets()
	-- User pressed F11 to reload tilesets
	loadtilesets()
	loadfonts()
	tile_batch_texture_needs_update = true
	map_init()
	temporaryroomname = L.TILESETSRELOADED
	temporaryroomnametimer = 90
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
	local max_scroll = 368
	if (lefttoolscroll < -max_scroll) then
		lefttoolscroll = -max_scroll
	elseif (lefttoolscroll > 16) then
		lefttoolscroll = 16
	end
end

function hoverdraw(img, x, y, w, h, s)
	if nodialog and mouseon(x, y, w, h) and window_active() then
		love.graphics.draw(img, x, y, 0, s)
	else
		love.graphics.setColor(255,255,255,128)
		love.graphics.draw(img, x, y, 0, s)
		love.graphics.setColor(255,255,255,255)
	end
end

function hoverrectangle(r, g, b, a, x, y, w, h, thisbelongstoarightclickmenu)
	if (nodialog or thisbelongstoarightclickmenu) and mouseon(x, y, w, h) and window_active() then
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
	local textyoffset = 4
	if (font8:getWidth(label) > 128-16 or label:find("\n") ~= nil) then
		textyoffset = 0
	end

	local y
	if bottom then
		y = love.graphics.getHeight()-(buttonspacing*(pos+1))-(yoffset-8)
	else
		y = yoffset+(buttonspacing*pos)
	end
	hoverrectangle(yellow and 160 or 128,yellow and 160 or 128,yellow and 0 or 128,128, love.graphics.getWidth()-(128-8), y, 128-16, 16)
	ved_printf(label, love.graphics.getWidth()-(128-8)+1, y+textyoffset, 128-16, "center")
	if hotkey ~= nil then
		showhotkey(hotkey, love.graphics.getWidth()-9, y-2, ALIGN.RIGHT)
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

function radio(selected, x, y, key, label, onclickfunc)
	local clickable_w = 8+32+font8:getWidth(label)
	hoverdraw(
		selected and image.radioon_hq or image.radiooff_hq,
		x, y, clickable_w, 16
	)
	if selected then
		love.graphics.setColor(255,255,128)
	end
	ved_print(label, x+16+8, y+4)
	love.graphics.setColor(255,255,255)

	if nodialog and not mousepressed and mouseon(x, y, clickable_w, 16) and love.mouse.isDown("l") then
		onclickfunc(key)
		mousepressed = true
	end
end

function checkbox(selected, x, y, key, label, onclickfunc)
	local clickable_w = 8+32+font8:getWidth(label)
	hoverdraw(
		selected and image.checkon_hq or image.checkoff_hq,
		x, y, clickable_w, 16
	)
	ved_print(label, x+16+8, y+4)

	if nodialog and not mousepressed and mouseon(x, y, clickable_w, 16) and love.mouse.isDown("l") then
		onclickfunc(key, not selected)
		mousepressed = true
	end
end


function cycle(var, themax, themin)
	if themin == nil then
		themin = 1
	end

	if var >= themax then
		return themin
	else
		return var+1
	end
end

function revcycle(var, themax, themin)
	if themin == nil then
		themin = 1
	end

	if var <= themin then
		return themax
	else
		return var-1
	end
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
	elseif thet == 14 then
		update_vce_teleporters_remove(
			math.floor(entitydata[id].x/40),
			math.floor(entitydata[id].y/40),
			id
		)
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

function escapegsub(text, keepcaps)
	if not keepcaps then
		text = text:lower()
	end
	return text
		:gsub("%%", "%%%%")
		:gsub("%(", "%%%(")
		:gsub("%)", "%%%)")
		:gsub("%.", "%%%.")
		:gsub("%+", "%%%+")
		:gsub("%-", "%%%-")
		:gsub("%*", "%%%*")
		:gsub("%?", "%%%?")
		:gsub("%[", "%%%[")
		:gsub("%^", "%%%^")
		:gsub("%$", "%%%$")
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

function load_konami()
	konami = require("konami")(function()
		if state == 1 and (selectedtool == 1 or selectedtool == 2) and mouseon(16+64, 16+46*8+leftsubtoolscroll, 32, 32) then
			subtoolimgs[1][10] = st("1_10");subtoolimgs[2][10] = st("1_10")
		elseif state == 15 then
			helpeditable = true
		end
	end)
end

function switchtileset()
	local maxtileset = 4
	if metadata.target == "VCE" then
		maxtileset = 5
	end
	if keyboard_eitherIsDown("shift") then
		selectedtileset = revcycle(selectedtileset, maxtileset, 0)
	else
		selectedtileset = cycle(selectedtileset, maxtileset, 0)
	end
	if tilesetblocks[selectedtileset].colors[selectedcolor] == nil
	or (selectedtileset == 2 and selectedcolor == 6 and levelmetadata_get(roomx, roomy).directmode == 0 and levelmetadata_get(roomx, roomy).auto2mode == 0) then
		selectedcolor = 0
	end

	local oldtileset = levelmetadata_get(roomx, roomy).tileset
	local oldtilecol = levelmetadata_get(roomx, roomy).tilecol

	levelmetadata_set(roomx, roomy, "tileset", selectedtileset)
	levelmetadata_set(roomx, roomy, "tilecol", selectedcolor)

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
			toundotiles = table.copy(roomdata_get(roomx, roomy, altstate)) -- ALTSTATES: yes, we're screwed for the moment
		}
	)
	finish_undo("TILESET")

	autocorrectroom() -- this already checks if automatic mode is on
end

function switchtilecol()
	if keyboard_eitherIsDown("shift") then
		selectedcolor = revcycle(selectedcolor, #tilesetblocks[selectedtileset].colors, selectedtileset == 0 and -1 or 0)
	else
		selectedcolor = cycle(selectedcolor, #tilesetblocks[selectedtileset].colors, selectedtileset == 0 and -1 or 0)
	end
	if selectedtileset == 2 and selectedcolor == 6 and levelmetadata_get(roomx, roomy).directmode == 0 and levelmetadata_get(roomx, roomy).auto2mode == 0 then
		-- lab rainbow background isn't available in auto-mode
		if keyboard_eitherIsDown("shift") then
			selectedcolor = 5
		else
			selectedcolor = 0
		end
	end

	local oldtilecol = levelmetadata_get(roomx, roomy).tilecol

	levelmetadata_set(roomx, roomy, "tilecol", selectedcolor)

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "tilecol",
					oldvalue = oldtilecol,
					newvalue = selectedcolor
				}
			},
			changetiles = true,
			toundotiles = table.copy(roomdata_get(roomx, roomy, altstate)) -- ALTSTATES: see above
		}
	)
	finish_undo("TILECOL")

	autocorrectroom() -- this already checks if automatic mode is on
end

function switchenemies()
	local oldtype = levelmetadata_get(roomx, roomy).enemytype
	local maxenemy = 9
	if metadata.target == "VCE" then
		maxenemy = 24
	end
	if keyboard_eitherIsDown("shift") then
		levelmetadata_set(roomx, roomy, "enemytype", revcycle(levelmetadata_get(roomx, roomy).enemytype, maxenemy, 0))
	else
		levelmetadata_set(roomx, roomy, "enemytype", cycle(levelmetadata_get(roomx, roomy).enemytype, maxenemy, 0))
	end

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "enemytype",
					oldvalue = oldtype,
					newvalue = levelmetadata_get(roomx, roomy).enemytype
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

	if math.abs(editingbounds) == 1 then
		editingbounds = 0
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
		finish_undo("ENEMY BOUNDS (canceled)")
	else
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
			finish_undo("PLATFORM BOUNDS (canceled by enemy bounds)")
		end
		editingbounds = -1
	end
end

function changeplatformbounds()
	if selectedtool == 13 and selectedsubtool[13] ~= 1 then return end

	selectedtool = 8
	updatewindowicon()

	-- Make sure we see the bounds
	showepbounds = true

	if math.abs(editingbounds) == 2 then
		editingbounds = 0
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
		finish_undo("PLATFORM BOUNDS (canceled)")
	else
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
			finish_undo("ENEMY BOUNDS (canceled by platform bounds)")
		end
		editingbounds = -2
	end
end

function changedmode()
	local olddirect = levelmetadata_get(roomx, roomy).directmode
	local oldauto2 = levelmetadata_get(roomx, roomy).auto2mode

	if keyboard_eitherIsDown("shift") then
		if levelmetadata_get(roomx, roomy).directmode == 0 and levelmetadata_get(roomx, roomy).auto2mode == 0 then
			levelmetadata_set(roomx, roomy, "directmode", 1)
		elseif levelmetadata_get(roomx, roomy).auto2mode == 1 then
			levelmetadata_set(roomx, roomy, "auto2mode", 0)
		else
			levelmetadata_set(roomx, roomy, "directmode", 0)
			levelmetadata_set(roomx, roomy, "auto2mode", 1)
		end
	else
		if levelmetadata_get(roomx, roomy).directmode == 0 and levelmetadata_get(roomx, roomy).auto2mode == 0 then
			levelmetadata_set(roomx, roomy, "auto2mode", 1)
		elseif levelmetadata_get(roomx, roomy).auto2mode == 1 then
			levelmetadata_set(roomx, roomy, "directmode", 1)
			levelmetadata_set(roomx, roomy, "auto2mode", 0)
		else
			levelmetadata_set(roomx, roomy, "directmode", 0)
		end
	end

	if selectedtileset == 2 and selectedcolor == 6 and levelmetadata_get(roomx, roomy).directmode == 0 and levelmetadata_get(roomx, roomy).auto2mode == 0 then
		-- lab rainbow background isn't available in auto-mode
		selectedcolor = 0
	end

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "directmode",
					oldvalue = olddirect,
					newvalue = levelmetadata_get(roomx, roomy).directmode
				},
				{
					key = "auto2mode",
					oldvalue = oldauto2,
					newvalue = levelmetadata_get(roomx, roomy).auto2mode
				}
			}
		}
	)
	finish_undo("MODE")
end

function changewarpdir()
	local oldwarpdir = levelmetadata_get(roomx, roomy).warpdir
	if keyboard_eitherIsDown("shift") then
		levelmetadata_set(roomx, roomy, "warpdir", revcycle(levelmetadata_get(roomx, roomy).warpdir, 3, 0))
	else
		levelmetadata_set(roomx, roomy, "warpdir", cycle(levelmetadata_get(roomx, roomy).warpdir, 3, 0))
	end

	table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "warpdir",
					oldvalue = oldwarpdir,
					newvalue = levelmetadata_get(roomx, roomy).warpdir
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
		tilespicker = false
		startinputonce()
		input = anythingbutnil(levelmetadata_get(roomx, roomy).roomname)
	end
end

function saveroomname()
	editingroomname = false
	stopinput()
	local oldroomname = anythingbutnil(levelmetadata_get(roomx, roomy).roomname)
	levelmetadata_set(roomx, roomy, "roomname", input)

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

function endeditingroomtext(currently_targetting)
	-- currently_targetting may be specified if input is being ended BECAUSE we're going to
	-- modify an entity, to bypass the entity getting deleted now for having an empty data.
	-- Alternatively we could gray out the options, it's only used in entity right click menus.
	if entitydata[editingroomtext].t ~= 17 and input:find("|") then
		dialog.create(langkeys(L.CANNOTUSENEWLINES, {"|"}))
		return
	end

	-- We were typing a text!
	stopinput()
	if entitydata[editingroomtext] == nil then
		dialog.create(L.EDITINGROOMTEXTNIL)
	elseif input ~= "" or editingroomtext == currently_targetting then
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
						for flag = 0, limit.flags-1 do
							if not usedflags[flag] then
								useflag = flag
								usedflags[flag] = true
								--vedmetadata.flaglabel[flag] = partss[2]
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
			table.insert(undobuffer,
				{
					undotype = "changeentity",
					rx = roomx, ry = roomy,
					entid = editingroomtext,
					changedentitydata = {
						{key = "data", oldvalue = olddata, newvalue = entitydata[editingroomtext].data}
					}
				}
			)
		end
	else
		removeentity(editingroomtext, nil, true)
	end
	editingroomtext = 0
end

function createmde(thislimit)
	if thislimit == nil then
		thislimit = limit
	end
	cons("Creating metadata entity...")
	if count ~= nil then
		count.entities = count.entities + 1
	end
	local emptyflaglabel = {}
	for i = 0, thislimit.flags-1 do
		emptyflaglabel[i] = ""
	end
	return {
		mdeversion = thismdeversion,
		flaglabel = emptyflaglabel,
		vars = {},
		notes = {{subj = L.RETURN, imgs = {}, cont = [[\)]]}}
	}
end

function state6load(levelname)
	local hastrailingdirsep = levelname:sub(-#dirsep) == dirsep
	if hastrailingdirsep then
		levelname = levelname:sub(1, -#dirsep - 1)
	end

	if backupscreen then
		if files[levelname] ~= nil then
			currentbackupdir = levelname
			tabselected = 0
		end
		return
	end

	if files[levelname] ~= nil then
		if not hastrailingdirsep then
			-- Oh, it's just a level that has the same name as a directory. Carry on.
		else
			input = levelname .. dirsep
			input_r = ""
			tabselected = 0
			return
		end
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
			oldeditingmap, oldmetadata, oldlimit, oldroomdata, oldentitydata, oldlevelmetadata, oldscripts, oldcount, oldscriptnames, oldvedmetadata, oldextra
			=  editingmap,    metadata,    limit,    roomdata,    entitydata,    levelmetadata,    scripts,    count,    scriptnames,    vedmetadata,    extra
		end

		success, metadata, limit, roomdata, entitydata, levelmetadata, scripts, count, scriptnames, vedmetadata, extra = loadlevel(levelname .. ".vvvvvv")

		if not success then
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata)

			-- Did we have a previous level open?
			if oldlevelmetadata ~= nil then
				-- We did!
				   editingmap,    metadata,    limit,    roomdata,    entitydata,    levelmetadata,    scripts,    count,    scriptnames,    vedmetadata,    extra =
				oldeditingmap, oldmetadata, oldlimit, oldroomdata, oldentitydata, oldlevelmetadata, oldscripts, oldcount, oldscriptnames, oldvedmetadata, oldextra
			end
		else
			editingmap = levelname
			recentlyopened(editingmap)
			map_init()
			if level_assets_loaded or getlevelassetsfolder() ~= nil then
				-- Either previous or new level has level-specific assets, so reload.
				loadtilesets()
				tile_batch_texture_needs_update = true
			end
			tostate(1)
		end
	else
		success, metadata2, limit2, roomdata2, entitydata2, levelmetadata2, scripts2, count2, scriptnames2, vedmetadata2, extra2 = loadlevel(levelname .. ".vvvvvv")

		if not success then
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata2)
		else
			-- Compare differences now!
			compareleveldifferences(levelname)
		end
	end
end

function compareleveldifferences(secondlevelname)
	-- Assuming we have both metadata till vedmetadata and metadata2 till vedmetadata2
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

			local firstlevelroomdatathisroom = roomdata_get(rx, ry)
			for k,v in pairs(roomdata2_get(rx, ry)) do
				if leftblank and v ~= 0 then
					leftblank = false
				end
				if rightblank and firstlevelroomdatathisroom[k] ~= 0 then
					rightblank = false
				end
				if not changed and v ~= firstlevelroomdatathisroom[k] then
					changed = true
				end
			end

			if changed and levelmetadata2_get(rx, ry).roomname == levelmetadata_get(rx, ry).roomname then
				if leftblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.added1, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname}) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.cleared1, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname}) .. "\n"
				else
					pagetext = pagetext .. langkeys(diffmessages.rooms.changed1, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname}) .. "\n"
				end
			elseif changed then -- room names not the same
				if leftblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.added2, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname, levelmetadata_get(rx, ry).roomname}) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(diffmessages.rooms.cleared2, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname, levelmetadata_get(rx, ry).roomname}) .. "\n"
				else
					pagetext = pagetext .. langkeys(diffmessages.rooms.changed2, {rx+co, ry+co, levelmetadata2_get(rx, ry).roomname, levelmetadata_get(rx, ry).roomname}) .. "\n"
				end
			end
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.changedrooms, imgs = {}, cont = pagetext})

	-- R O O M   M E T A D A T A
	pagetext = diffmessages.pages.changedroommetadata .. "\\wh#\n\n"

	for ry = 0, math.min(metadata2.mapheight-1, metadata.mapheight-1) do
		for rx = 0, math.min(metadata2.mapwidth-1, metadata.mapwidth-1) do
			local lmd1, lmd2 = levelmetadata_get(rx, ry), levelmetadata2_get(rx, ry)
			local changed = false

			-- Is anything different?
			for k,v in pairs(lmd2) do
				if v ~= lmd1[k] then
					changed = true
				end
			end

			local lrmx, lrmy = rx, ry

			if not s.coords0 then
				lrmx = lrmx + 1
				lrmy = lrmy + 1
			end

			if changed and lmd2.roomname ~= lmd1.roomname then
				-- We're already going to show that the room name has changed
				pagetext = pagetext .. langkeys(diffmessages.roommetadata.changed0, {lrmx, lrmy}) .. "\n"
			elseif changed then
				-- We're not, so label this
				pagetext = pagetext .. langkeys(diffmessages.roommetadata.changed1, {lrmx, lrmy, lmd2.roomname}) .. "\\\n"
			end

			if changed then
				-- So what has changed?
				if lmd2.roomname ~= lmd1.roomname then
					if lmd2.roomname == "" then
						pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomnameadded, {lmd1.roomname}) .. "\n"
					elseif lmd1.roomname == "" then
						pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomnameremoved, {lmd2.roomname}) .. "\n"
					else
						pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.roomname, {lmd2.roomname, lmd1.roomname}) .. "\n"
					end
				end
				if lmd2.tileset ~= lmd1.tileset or lmd2.tilecol ~= lmd1.tilecol then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.tileset, {lmd2.tileset, lmd2.tilecol, lmd1.tileset, lmd1.tilecol}) .. "\n"
				end
				if lmd2.platv ~= lmd1.platv then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.platv, {lmd2.platv, lmd1.platv}) .. "\n"
				end
				if lmd2.enemytype ~= lmd1.enemytype then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.enemytype, {lmd2.enemytype, lmd1.enemytype}) .. "\n"
				end
				if lmd2.platx1 ~= lmd1.platx1 or lmd2.platy1 ~= lmd1.platy1 or lmd2.platx2 ~= lmd1.platx2 or lmd2.platy2 ~= lmd1.platy2 then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.platbounds, {lmd2.platx1, lmd2.platy1, lmd2.platx2, lmd2.platy2, lmd1.platx1, lmd1.platy1, lmd1.platx2, lmd1.platy2}) .. "\n"
				end
				if lmd2.enemyx1 ~= lmd1.enemyx1 or lmd2.enemyy1 ~= lmd1.enemyy1 or lmd2.enemyx2 ~= lmd1.enemyx2 or lmd2.enemyy2 ~= lmd1.enemyy2 then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.enemybounds, {lmd2.enemyx1, lmd2.enemyy1, lmd2.enemyx2, lmd2.enemyy2, lmd1.enemyx1, lmd1.enemyy1, lmd1.enemyx2, lmd1.enemyy2}) .. "\n"
				end
				if lmd2.directmode == 0 and lmd1.directmode == 1 then
					pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode01 .. "\n"
				elseif lmd2.directmode == 1 and lmd1.directmode == 0 then
					pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode10 .. "\n"
				end
				if lmd2.warpdir ~= lmd1.warpdir then
					pagetext = pagetext .. "  " .. langkeys(diffmessages.roommetadata.warpdir, {warpdirs[lmd2.warpdir], warpdirs[lmd1.warpdir]}) .. "\n"
				end
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
				if (kattr ~= "data" or table.contains({17, 18, 19}, v[1].t))
				and vattr ~= locentities2[k][1][kattr] then
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

			for i = 0, limit.flags-1 do
				if vedmetadata.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(diffmessages.flagnames.added, {i, vedmetadata.flaglabel[i]}) .. "\n"
				end
			end
		elseif vedmetadata == false then
			-- It was removed in the new version
			pagetext = pagetext .. diffmessages.mde.removed .. "\n\n"

			for i = 0, limit2.flags-1 do
				if vedmetadata2.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(diffmessages.flagnames.removed, {vedmetadata2.flaglabel[i], i}) .. "\n"
				end
			end
		else
			-- This one is simple, just cycle through the numbers!
			for i = 0, math.min(limit.flags, limit2.flags)-1 do
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

function triggernewlevel(width, height)
	if width == nil or height == nil then
		width, height = 5, 5
	end
	success, metadata, limit, roomdata, entitydata, levelmetadata, scripts, count, scriptnames, vedmetadata, extra = createblanklevel(width, height)
	map_init()
	editingmap = "untitled\n"
	if level_assets_loaded then
		loadtilesets()
		tile_batch_texture_needs_update = true
	end
	tostate(1)
end

function cons_fc(list, text)
	table.insert(list, text)
	cons("[CHECK] " .. text)
end

function handle_scrolling(viakeyboard, mkinput, customdistance, x, y)
	local direction, distance

	if x == nil or y == nil then
		x, y = love.mouse.getPosition()
	end

	if viakeyboard then
		distance = 10*46
		if takinginput and table.contains({"home", "end"}, mkinput) then
			return
		elseif table.contains({"pageup", "home"}, mkinput) then
			direction = "u"
		elseif table.contains({"pagedown", "end"}, mkinput) then
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

	if direction == nil then
		return
	end

	if dialog.is_open() then
		local topdialog = dialogs[#dialogs]
		local k = topdialog:get_on_scrollable_field(x, y, viakeyboard)
		local cf = dialogs[#dialogs].currentfield
		local cfistext = anythingbutnil(dialogs[#dialogs].fields[cf])[DFP.T] == DF.TEXT
		if k ~= nil then
			local fieldscroll = topdialog.fields[k][DFP.FILES_LISTSCROLL]
			if direction == "u" then
				if mkinput == "home" and not cfistext then
					fieldscroll = 0
				else
					fieldscroll = fieldscroll + distance
					if fieldscroll > 0 then
						fieldscroll = 0
					end
				end
			elseif direction == "d" then
				local upperbound = (#topdialog.fields[k][DFP.FILES_MENUITEMS])*8-8*topdialog.fields[k][DFP.FILES_LIST_HEIGHT]
				if mkinput == "end" and not cfistext then
					fieldscroll = math.min(-upperbound, 0)
				else
					fieldscroll = fieldscroll - distance
					if -fieldscroll > upperbound then
						fieldscroll = math.min(-upperbound, 0)
					end
				end
			end
			dialogs[#dialogs].fields[k][DFP.FILES_LISTSCROLL] = fieldscroll
		end
	elseif state == 3 and not viakeyboard then
		if direction == "u" then
			scriptscroll = scriptscroll + distance
			if scriptscroll > 0 then
				scriptscroll = 0
			end
		elseif direction == "d" then
			scriptscroll = scriptscroll - distance
			local textscale = s.scripteditor_largefont and 2 or 1
			local upperbound = (((#scriptlines*8+16)*textscale-(s.scripteditor_largefont and 24 or 0))-(love.graphics.getHeight()-24)) -- scrollableHeight - visiblePart
			if -scriptscroll > upperbound then
				scriptscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 6 then
		if distance % 8 == 0 then
			-- The levels list now has items that are 12 high... Which makes 16 scroll distance jarring
			distance = distance * 1.5
		end
		if direction == "u" then
			levellistscroll = levellistscroll + distance
			if levellistscroll > 0 then
				levellistscroll = 0
			end
		elseif direction == "d" then
			levellistscroll = levellistscroll - distance
			local lessheight = 48
			if #s.recentfiles > 0 and input == "" and input_r == "" then
				lessheight = lessheight + 16 + #s.recentfiles*12
			end
			local upperbound = ((max_levellistscroll)-(love.graphics.getHeight()-lessheight))
			if -levellistscroll > upperbound then
				levellistscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 10 then
		if direction == "u" then
			if mkinput == "home" then
				scriptlistscroll = 0
			else
				scriptlistscroll = scriptlistscroll + distance
				if scriptlistscroll > 0 then
					scriptlistscroll = 0
				end
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
			local upperbound = ((ndisplayedscripts*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
			if mkinput == "end" then
				scriptlistscroll = math.min(-upperbound, 0)
			else
				scriptlistscroll = scriptlistscroll - distance
				if -scriptlistscroll > upperbound then
					scriptlistscroll = math.min(-upperbound, 0)
				end
			end
		end
	elseif state == 11 then
		if direction == "u" then
			searchscroll = searchscroll + distance
			if searchscroll > 0 then
				searchscroll = 0
			end
		elseif direction == "d" then
			searchscroll = searchscroll - distance
			local upperbound = ((longestsearchlist*32)-2-(love.graphics.getHeight()-56)) -- scrollableHeight - visiblePart
			if -searchscroll > upperbound then
				searchscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 15 then
		local usethiscondition = x <= 25*8 and (x ~= 0 or y ~= 0)
		if s.psmallerscreen then
			usethiscondition = onlefthelpbuttons
		end

		if usethiscondition then
			if direction == "u" then
				if mkinput == "home" then
					helplistscroll = 0
				else
					helplistscroll = helplistscroll + distance
					if helplistscroll > 0 then
						helplistscroll = 0
					end
				end
			elseif direction == "d" then
				local upperbound = (((#helppages+(helpeditable and 1 or 0))*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
				if mkinput == "end" then
					helplistscroll = math.min(-upperbound, 0)
				else
					helplistscroll = helplistscroll - distance
					if -helplistscroll > upperbound then
						helplistscroll = math.min(-upperbound, 0)
					end
				end
			end
		else
			if direction == "u" then
				if mkinput == "home" then
					helparticlescroll = 0
				else
					helparticlescroll = helparticlescroll + distance
					if helparticlescroll > 0 then
						helparticlescroll = 0
					end
				end
			elseif direction == "d" then
				-- #anythingbutnil(helparticlecontent) is very quirky; if the table helparticlecontent == nil, then we get an empty string, and #"" is 0, which is exactly what we want.
				-- The alternative is defining an extra anythingbutnil* function for returning an empty list, but #{}==#"" and if not nil, it just happily returns the table it got.
				local upperbound = ((#anythingbutnil(helparticlecontent)*10)-(love.graphics.getHeight()-32))
				if mkinput == "end" then
					helparticlescroll = math.min(-upperbound, 0)
				else
					helparticlescroll = helparticlescroll - distance
					if -helparticlescroll > upperbound then
						helparticlescroll = math.min(-upperbound, 0)
					end
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

function is_scrollable(x, y)
	if dialog.is_open() then
		return dialogs[#dialogs]:get_on_scrollable_field(x, y) ~= nil
	end
	if state == 3 or state == 10 or state == 11 or state == 15 then
		return true
	end
	if state == 6 and x < love.graphics.getWidth()-128 then
		return true
	end
	return false
end

function getalllanguages()
	loadlanginfo()
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
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 8, 8+(24*pos), 32, 16)
	love.graphics.setColor(mycolor)
	love.graphics.rectangle("fill", 9, 9+(24*pos), 30, 14)
	if editingcolor == mycolor then
		love.graphics.setColor(255,255,255)
	else
		love.graphics.setColor(128,128,128)
	end
	ved_print(label, 8+32+8, 8+(24*pos)+4)

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
	if vedmetadata == false then
		vedmetadata = createmde()
	end
	tostate(15, nil, {vedmetadata.notes, true})
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

	if v.p1 < 0 or v.p1 > 1 then
		return
	elseif v.p1 == 1 then
		oy = oy - 14
	end

	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", ox, oy, 20, 14)
	love.graphics.setColor(0,255,0)

	if sp_t > 0 then
		if sp_go and sp_got > 0 then
			if s_ge2ten > 99 then
				tinyprint(s_ge2ten, ox+4, oy+4)
			else
				ved_print(s_ge2ten, ox+3, oy+3)
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
	_, thelines = font8:getWrap(text, 40*8)

	-- thelines is a number in 0.9.x, and a table/sequence in 0.10.x and higher
	if type(thelines) == "table" then
		return #thelines - 1
	else
		return thelines - 1
	end
end

function gotohelparticle(n)
	if helppages[n] == nil then return end
	helparticle = n
	helparticlecontent = explode("\n", helppages[helparticle].cont)
	helparticlescroll = 0
end

function keyboard_eitherIsDown(...)
	local args = {...}

	if #args == 1 then -- Fast path
		return love.keyboard.isDown("l" .. args[1], "r" .. args[1])
	end

	local list = {}
	local alreadyseen = {}
	for _, button in pairs(args) do
		if not table.contains(alreadyseen, button) then
			table.insert(list, "l" .. button)
			table.insert(list, "r" .. button)
			table.insert(alreadyseen, button)
		end
	end
	return love.keyboard.isDown(unpack(list))
end

-- Simply print a string in the tiny font
function tinyprint(text, x, y)
	ved_setFont(tinynumbers)
	ved_print(text, x, y)
	ved_setFont(font8)
end

function textshadow(text, x, y, largefont)
	love.graphics.setColor(128,128,128,192)
	love.graphics.rectangle("fill", x, y, love.graphics.getFont():getWidth(text)*(largefont and 2 or 1), largefont and 16 or 8)
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

function format_date(timestamp)
	if timestamp == nil then
		return ""
	elseif type(timestamp) == "table" then
		-- Table should be {Y, M, D, H, M, S}
		local timestring
		if s.new_timeformat == 12 then
			local ampm, hour
			if timestamp[4] < 12 then
				ampm = "am"
				hour = timestamp[4]
			else
				ampm = "pm"
				hour = timestamp[4]-12
			end
			if hour == 0 then
				hour = 12
			end
			timestring = string.format("%02d:%02d%s",
				hour, timestamp[5], ampm
			)
		else
			timestring = string.format("%02d:%02d",
				timestamp[4], timestamp[5]
			)
		end
		if s.new_dateformat == "DMY" then
			return string.format("%02d-%02d-%d %s",
				timestamp[3], timestamp[2], timestamp[1],
				timestring
			)
		elseif s.new_dateformat == "MDY" then
			return string.format("%02d/%02d/%d %s",
				timestamp[2], timestamp[3], timestamp[1],
				timestring
			)
		end
		-- YMD
		return string.format("%d-%02d-%02d %s",
			timestamp[1], timestamp[2], timestamp[3],
			timestring
		)
	end
	-- Unix timestamp
	local datetimeformat
	if s.new_dateformat == "DMY" then
		datetimeformat = "%d-%m-%Y"
	elseif s.new_dateformat == "MDY" then
		datetimeformat = "%m/%d/%Y"
	else
		datetimeformat = "%Y-%m-%d"
	end
	if s.new_timeformat == 12 then
		datetimeformat = datetimeformat .. " %I:%M%p"
	else
		datetimeformat = datetimeformat .. " %H:%M"
	end
	return os.date(datetimeformat, timestamp):lower()
end

function drawlink(link)
	love.graphics.setColor(255,255,255,192)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-10, font8:getWidth(link)+8, 10)
	love.graphics.setColor(0,0,0)
	ved_print(link, 4, love.graphics.getHeight()-9)
	love.graphics.setColor(255,255,255)
end

function set_middlescroll(x, y)
	if middlescroll_falling then return end

	middlescroll_x, middlescroll_y = x, y
	middlescroll_t = love.timer.getTime()
end

function unset_middlescroll()
	if middlescroll_falling then return end

	if love.timer.getTime() - middlescroll_t < 24 or middlescroll_y > love.graphics.getHeight()-16 then
		middlescroll_x, middlescroll_y = -1, -1
	else
		middlescroll_falling = true
	end
end

function middlescroll_fall_update(dt)
	middlescroll_v = middlescroll_v + 1200*dt
	middlescroll_y = middlescroll_y + middlescroll_v*dt

	if middlescroll_y > love.graphics.getHeight()-16 then
		if middlescroll_v > 500 then
			-- Shatter.
			snd_break:play()
			middlescroll_shatter = true
			for y = 0, 15 do
				for x = 0, 15 do
					table.insert(middlescroll_shatter_pieces, {
							x = middlescroll_x-16 + 4*x,
							y = love.graphics.getHeight()-16 + 4*y,
							ox = 4*x,
							oy = 4*y,
							vx = love.math.random(-50,50),
							vy = -middlescroll_v/1.5
						}
					)
				end
			end
		else
			-- Roll.
			snd_roll:play()
			middlescroll_rolling = (middlescroll_x < love.graphics.getWidth()/2) and -1 or 1
			middlescroll_rolling_x = middlescroll_x
		end
		middlescroll_x, middlescroll_y = -1, -1
		middlescroll_falling = false
		middlescroll_t, middlescroll_v = 0, 0
	end
end

function middleclick_shatter_update(dt)
	for k,v in pairs(middlescroll_shatter_pieces) do
		if v.y > love.graphics.getHeight()+64 then
			middlescroll_shatter = false
			middlescroll_shatter_pieces = {}
			break
		end

		middlescroll_shatter_pieces[k].x = v.x + v.vx*dt
		middlescroll_shatter_pieces[k].y = v.y + v.vy*dt
		middlescroll_shatter_pieces[k].vy = v.vy + 2400*dt
	end
end

function middleclick_roll_update(dt)
	middlescroll_v = middlescroll_v + 150*dt
	middlescroll_rolling_x = middlescroll_rolling_x + middlescroll_v*middlescroll_rolling*dt

	if middlescroll_rolling_x < -16 or middlescroll_rolling_x > love.graphics.getWidth() + 16 then
		snd_roll:stop()
		middlescroll_rolling = 0
		middlescroll_v = 0
	end
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

function search_levels_list(currentdir, prefix)
	-- Marks matching levels in the levels list as shown and vice versa
	if input .. input_r == oldinput then
		return
	end
	oldinput = input .. input_r

	for k,v in pairs(files[currentdir]) do
		files[currentdir][k].result_shown =
			(prefix .. v.name):lower():sub(1, (input .. input_r):len()) == (input .. input_r):lower()
	end
end

function displayable_filename(name)
	-- This function changes the filename to make it displayable - like removing newlines.
	-- The resulting filename may thus not be a valid filename anymore.
	return name:gsub("[\r\n]", "?")
end

function display_levels_list_string(string, x, y, k, len, scroll_k, scroll_pos)
	local stringtoolong = font8:getWidth(string) > len*8
	local sx, sy, sw, sh
	if stringtoolong then
		sx, sy, sw, sh = love.graphics.getScissor()
	end
	if sy == nil or sh == nil then
		sy = 0
		sh = love.graphics.getHeight()
	end
	if scroll_k == k then
		love.graphics.setScissor(x, sy, len*8, sh)
		ved_print(string, x+len*8-math.floor(scroll_pos), y)
	else
		if stringtoolong then
			love.graphics.setScissor(x, sy, (len-1)*8, sh)
		end
		ved_print(string, x, y)
	end
	if stringtoolong then
		love.graphics.setScissor(sx, sy, sw, sh)
		if scroll_k ~= k then
			ved_print(arrow_right, x+(len-1)*8, y)
		end
	end
end

function mmss_duration(seconds)
	if seconds == nil or seconds < 0 or seconds ~= seconds then
		-- Yes, believe it or not, this can be unequal to itself.
		return "?:??"
	end

	seconds = math.floor(seconds)

	local minutes = math.floor(seconds/60)
	seconds = seconds - minutes*60

	return string.format("%d:%02d", minutes, seconds)
end

function bytes_notation(bytes)
	if bytes == nil then
		bytes = 0
	end
	if bytes < 10^3 then
		return langkeys(L_PLU.BYTES, {bytes})
	elseif bytes < 10^6 then
		return langkeys(L.KILOBYTES, {round(bytes/10^3, 1)})
	elseif bytes < 10^9 then
		return langkeys(L.MEGABYTES, {round(bytes/10^6, 1)})
	end
	return langkeys(L.GIGABYTES, {round(bytes/10^9, 1)})
end

function sort_files(files)
	-- In place
	table.sort(files,
		function(a,b)
			if a.isdir and not b.isdir then return true end
			if b.isdir and not a.isdir then return false end

			return a.name:lower() < b.name:lower()
		end
	)
end

function fix_imageviewer_position()
	local canvas_x, canvas_y = 8, 16
	local canvas_w, canvas_h = love.graphics.getWidth()-136, love.graphics.getHeight()-24
	if imageviewer_w*imageviewer_s < canvas_w then
		imageviewer_x = canvas_x + (canvas_w-imageviewer_w*imageviewer_s)/2
	else
		imageviewer_x = math.min(
			canvas_x, math.max(
				(canvas_x+canvas_w)-imageviewer_w*imageviewer_s,
				imageviewer_x
			)
		)
	end
	if imageviewer_h*imageviewer_s < canvas_h then
		imageviewer_y = canvas_y + (canvas_h-imageviewer_h*imageviewer_s)/2
	else
		imageviewer_y = math.min(
			canvas_y, math.max(
				(canvas_y+canvas_h)-imageviewer_h*imageviewer_s,
				imageviewer_y
			)
		)
	end

	imageviewer_x, imageviewer_y = math.floor(imageviewer_x), math.floor(imageviewer_y)
end

function imageviewer_get_view_center()
	-- Get the "coordinate" of the centermost point, for x and y, on the scale 0-1.
	-- So, if the center of the image is on the center of the canvas precisely, return 0.5, 0.5
	local canvas_x, canvas_y = 8, 16
	local canvas_w, canvas_h = love.graphics.getWidth()-136, love.graphics.getHeight()-24

	local x = ((canvas_x+canvas_w/2) - imageviewer_x) / imageviewer_s
	local y = ((canvas_y+canvas_h/2) - imageviewer_y) / imageviewer_s

	return x/imageviewer_w, y/imageviewer_h
end

function imageviewer_zoomin()
	if imageviewer_s >= 8 then return end
	local center_x, center_y = imageviewer_get_view_center()
	imageviewer_x = imageviewer_x-(imageviewer_w*imageviewer_s)*center_x
	imageviewer_y = imageviewer_y-(imageviewer_h*imageviewer_s)*center_y
	imageviewer_s = imageviewer_s * 2
	fix_imageviewer_position()
end

function imageviewer_zoomout()
	if imageviewer_s <= 0.5 then return end
	local center_x, center_y = imageviewer_get_view_center()
	imageviewer_s = imageviewer_s / 2
	imageviewer_x = imageviewer_x+(imageviewer_w*imageviewer_s)*center_x
	imageviewer_y = imageviewer_y+(imageviewer_h*imageviewer_s)*center_y
	fix_imageviewer_position()
end

function imageviewer_gridin()
	if imageviewer_grid == 0 then
		imageviewer_grid = 1
	elseif imageviewer_grid == 1 then
		imageviewer_grid = 8
	elseif imageviewer_grid == 8 then
		imageviewer_grid = 32
	end
end

function imageviewer_gridout()
	if imageviewer_grid == 32 then
		imageviewer_grid = 8
	elseif imageviewer_grid == 8 then
		imageviewer_grid = 1
	elseif imageviewer_grid == 1 then
		imageviewer_grid = 0
	end
end

function changelanguage(newlanguage)
	unloadlanguage()
	s.lang = newlanguage
	loadlanguage()

	loadtinynumbersfont()
end

function exitdisplayoptions()
	if nonintscale then
		stopinput()
		s.scale = num_scale
	end
	saveconfig()

	if s.smallerscreen ~= s.psmallerscreen or s.scale ~= s.pscale or s.forcescale ~= oldforcescale then
		local mouseposx, mouseposy
		if love.mouse.isDown("l") then
			mouseposx, mouseposy = love.mouse.getPosition()
		end
		s.pscale = s.scale
		s.psmallerscreen = s.smallerscreen
		dodisplaysettings(true)
		if mouseposx ~= nil and mouseposy ~= nil then
			love.mouse.setPosition(mouseposx, mouseposy)
		end
	end

	tostate(oldstate, true)
	-- Just to make sure we don't get stuck in the settings
	oldstate = olderstate
end

function exitsyntaxcoloroptions()
	saveconfig()
	tostate(oldstate, true)
	-- Just to make sure we don't get stuck in the settings
	oldstate = olderstate
end

function exitlanguageoptions()
	s.langchosen = true
	saveconfig()
	tostate(oldstate, true)
	-- We may not come from the settings, but otherwise
	oldstate = olderstate
end

function showhotkey(hotkey, x, y, align, topmost, dialog_obj)
	align = align or ALIGN.LEFT

	if love.keyboard.isDown("f9") and (nodialog or topmost) then
		ved_setFont(tinynumbers)
		local hotkey_w = tinynumbers:getWidth(hotkey)
		if align == ALIGN.RIGHT then
			x = x - hotkey_w
		elseif align == ALIGN.CENTER then
			x = x - math.floor(hotkey_w / 2) -- Don't want subpixels now
		end
		if dialog_obj ~= nil then
			dialog_obj:setColor(255,255,255,192)
		else
			love.graphics.setColor(255,255,255,192)
		end
		love.graphics.rectangle("fill", x, y, hotkey_w+3, 10)
		if dialog_obj ~= nil then
			dialog_obj:setColor(0,0,0,255)
		else
			love.graphics.setColor(0,0,0,255)
		end
		ved_print(hotkey, x+2, y+2)
		if dialog_obj ~= nil then
			dialog_obj:setColor(255,255,255,255)
		else
			love.graphics.setColor(255,255,255)
		end
		ved_setFont(font8)
	end
end

function assets_savedialog()
	dialog.create(
		L.ENTERNAMESAVE,
		DBS.OKCANCEL,
		dialog.callback.savevvvvvvmusic,
		nil,
		dialog.form.savevvvvvvmusic_make(musiceditorfile:sub(1,-5))
	)
end

function assets_metadataeditordialog()
	dialog.create(
		"",
		DBS.OKCANCEL,
		dialog.callback.musicfilemetadata,
		L.MUSICFILEMETADATA,
		dialog.form.musicfilemetadata_make(file_metadata)
	)
end

function assets_metadataplayerdialog()
	dialog.create(
		L.MUSICEXPORTEDON .. format_date(file_metadata.export_time) .. "\n\n"
		.. L.MUSICTITLE .. file_metadata.name .. "\n\n"
		.. L.MUSICARTIST .. file_metadata.artist .. "\n\n"
		.. L.MUSICNOTES .. "\n" .. file_metadata.notes
	)
end

function assets_musicloaddialog()
	dialog.create(
		"",
		DBS.LOADCANCEL,
		dialog.callback.loadvvvvvvmusic,
		L.LOADMUSICNAME,
		dialog.form.files_make(vvvvvvfolder, "", ".vvv", true, 11)
	)
end

function assets_musicreload()
	setgenerictimer(1, .25)
	loadvvvvvvmusic(musicplayerfile)
end

function assets_graphicsloaddialog()
	dialog.create(
		"",
		DBS.LOADCANCEL,
		dialog.callback.openimage,
		L.LOADIMAGE,
		dialog.form.files_make(graphicsfolder, "", ".png", true, 11)
	)
end

function hotkey(checkkey, checkmod)
	return function(detectedkey)
		return detectedkey == checkkey and (checkmod == nil or keyboard_eitherIsDown(checkmod))
	end
end

function unload_uis()
	-- Unload the UI files, just so we can reload them.
	if uis == nil then
		-- What are you doing here?
		return
	end

	for k,v in pairs(uis) do
		for k2,v2 in pairs(v) do
			local name = "uis/" .. v.name .. "/" .. k2
			if package.loaded[name] then
				package.loaded[name] = false
			end
		end
	end
end

function load_ui(ui_name)
	local ui = {name = ui_name}
	local ui_path = "uis/" .. ui_name .. "/"

	local function load_ui_part(part_name)
		if love.filesystem.exists(ui_path .. part_name .. ".lua") then
			ui[part_name] = ved_require(ui_path .. part_name)
			if ui[part_name] == nil or type(ui[part_name]) == "boolean" then
				dialog.create("Part \"" .. part_name .. "\" of UI \"" .. ui_name .. "\" returned nothing, and therefore won't function.")

				-- We can't call/iterate over a boolean (what require returns if the code doesn't), and checks for nil are in place...
				ui[part_name] = nil
			end
		end
	end

	load_ui_part("load")
	load_ui_part("elements")
	load_ui_part("draw")
	load_ui_part("update")
	load_ui_part("keypressed")
	load_ui_part("keyreleased")
	load_ui_part("textinput")
	load_ui_part("mousepressed")
	load_ui_part("mousereleased")

	return ui
end

function load_uis()
	uis = {}

	uis[-2] = load_ui("init")
	uis[0] = load_ui("state0")
	uis[1] = load_ui("maineditor")
	uis[3] = load_ui("scripteditor")
	uis[5] = load_ui("fsinfo")
	uis[6] = load_ui("levelslist")
	uis[7] = load_ui("spriteview")
	uis[9] = load_ui("dialogtest")
	uis[10] = load_ui("scriptlist")
	uis[11] = load_ui("search")
	uis[12] = load_ui("map")
	uis[13] = load_ui("options")
	uis[14] = load_ui("enemypickertest")
	uis[15] = load_ui("help")
	uis[18] = load_ui("unreinfo")
	uis[19] = load_ui("scriptflags")
	uis[20] = load_ui("resizableboxtest")
	uis[25] = load_ui("syntaxoptions")
	uis[26] = load_ui("fonttest")
	uis[27] = load_ui("displayoptions")
	uis[28] = load_ui("levelstats")
	uis[29] = load_ui("pluralformstest")
	uis[30] = load_ui("assetsmenu")
	uis[31] = load_ui("audioplayer")
	uis[32] = load_ui("graphicsviewer")
	uis[33] = load_ui("language")
	uis[34] = load_ui("inputtest")
end

function show_notification(text)
	notification_text = text

	setgenerictimer(3, 5)
end

function window_active()
	return love.window.hasFocus() and love.window.isVisible()
end

function inplacescroll(key)
	local usethisinput, usethisdistance
	if table.contains({"up", "pageup"}, key) then
		usethisinput = "wu"
	elseif table.contains({"down", "pagedown"}, key) then
		usethisinput = "wd"
	end
	if table.contains({"pageup", "pagedown"}, key) then
		usethisdistance = 10*46
	end
	handle_scrolling(false, usethisinput, usethisdistance)
end

function assets_openimage(filepath, filename)
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

function isclear(key)
	-- On macOS, Numlock turns into the Clear key and behaves differently
	return key == "numlock" and love.system.getOS() == "OS X"
end

function next_key(t, c)
	-- Return the lowest key in table t that is higher than c.
	-- If not found, return nil.
	local lowscore
	for k,v in pairs(t) do
		if k > c and (lowscore == nil or lowscore > k) then
			lowscore = k
		end
	end
	return lowscore
end

function draw_script_warn_light(id, x, y, active)
	if active then
		love.graphics.setColor(255,224,0,255)
	else
		love.graphics.setColor(12,12,12,255)
	end

	local light = script_warn_lights[id]

	love.graphics.draw(light.img, x, y)

	if active and mouseon(x, y, light.img:getDimensions()) then
		local box_w = math.max(
			256,
			font8:getWidth(L[light.lang_title]) + 16
		)
		local expl_w = box_w - 24 - light.img_hq:getWidth()
		local _, lines = font8:getWrap(L[light.lang_expl], expl_w)
		if type(lines) == "table" then
			lines = #lines
		end
		local box_h = 32+math.max(
			light.img_hq:getHeight(),
			lines*font8:getHeight()
		)
		local box_x, box_y = x+light.img:getWidth()-box_w, y+light.img:getHeight()+1

		love.graphics.setColor(64,64,64,128)
		love.graphics.rectangle("fill", box_x, box_y, box_w, box_h)
		love.graphics.setColor(255,224,0,255)
		love.graphics.print(L[light.lang_title], box_x+8, box_y+8)
		love.graphics.draw(light.img_hq, box_x+8, box_y+24)
		love.graphics.setColor(255,255,255,255)
		love.graphics.printf(
			L[light.lang_expl],
			box_x + light.img_hq:getWidth() + 16,
			box_y + 24,
			expl_w,
			"left"
		)
	end
end

function vce_deprecation_dialog()
	dialog.create(L.VCE_DEPRECATED)
end

hook("func")
