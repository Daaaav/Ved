love.graphics.clearOR = love.graphics.clear
love.graphics.clear = function(...)
	if not s.pausedrawunfocused or window_active() then
		love.graphics.clearOR(...)
	end
end

love.keyboard.isDownOR = love.keyboard.isDown
love.keyboard.isDown = function(...)
	if ime_textedited ~= "" then
		return false
	end

	for _,key in pairs({...}) do
		if table.contains(skip_next_keys, key) then
		elseif love.keyboard.isDownOR(key) then
			return true
		end
	end
	return false
end

love.mouse.isDownOR = love.mouse.isDown
love.mouse.isDown = function(...)
	for _,button in pairs({...}) do
		if table.contains(skip_next_mouses, button) then
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
		-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do text:sub(1, -2).
		text = text:sub(1, byteoffset - 1)
	end
	]]

	if text == nil then return end

	local worktext = tostring(text)
	while true do
		local lastchar = worktext:sub(-1, -1):byte()
		if lastchar == nil then return "" end

		-- Are we about to kill a UTF-8 continuation byte?
		if lastchar >= 0x80 and lastchar <= 0xBF then -- 10xxxxxx
			-- We are, do this again.
			worktext = worktext:sub(1, -2)
		else
			-- All clear!
			return worktext:sub(1, -2)
		end
	end
end

function leftspace(text, righttext)
	if (text == nil) or (righttext == nil) then return end

	text = tostring(text)
	while true do
		local lastchar = text:sub(-1, -1):byte()
		if lastchar == nil then return "", righttext end

		-- Are we about to kill a UTF-8 continuation byte?
		if lastchar >= 0x80 and lastchar <= 0xBF then -- 10xxxxxx
			-- We are, do this again.
			righttext = text:sub(-1, -1) .. righttext
			text = text:sub(1, -2)
		else
			-- All clear!
			righttext = text:sub(-1, -1) .. righttext
			return text:sub(1, -2), righttext
		end
	end
end

function rightspace(text, righttext)
	if (text == nil) or (righttext == nil) then return end

	righttext = tostring(righttext)
	local lastchar = righttext:sub(1, 1):byte()
	if lastchar == nil then return text, "" end

	-- Different UTF-8 stuff going on here.
	if lastchar >= 0xC0 and lastchar <= 0xDF then -- 110xxxxx
		-- Two bytes to move at once!
		text = text .. righttext:sub(1, 2)
		return text, righttext:sub(3, -1)
	elseif lastchar >= 0xE0 and lastchar <= 0xEF then -- 1110xxxx
		-- Three bytes to move at once!
		text = text .. righttext:sub(1, 3)
		return text, righttext:sub(4, -1)
	elseif lastchar >= 0xF0 and lastchar <= 0xF7 then -- 11110xxx
		-- Four!
		text = text .. righttext:sub(1, 4)
		return text, righttext:sub(5, -1)
	else
		-- Just one byte of course.
		text = text .. righttext:sub(1, 1)
		return text, righttext:sub(2, -1)
	end
end

function firstUTF8(text)
	if text == nil then return end

	text = tostring(text)
	local lastchar = text:sub(1, 1):byte()
	if lastchar == nil then return text end

	-- Mostly the same as rightspace()
	if lastchar >= 0xC0 and lastchar <= 0xDF then -- 110xxxxx
		-- Two bytes to move at once!
		return text:sub(1, 2)
	elseif lastchar >= 0xE0 and lastchar <= 0xEF then -- 1110xxxx
		-- Three bytes to move at once!
		return text:sub(1, 3)
	elseif lastchar >= 0xF0 and lastchar <= 0xF7 then -- 11110xxx
		-- Four!
		return text:sub(1, 4)
	else
		-- Just one byte of course.
		return text:sub(1, 1)
	end
end

function allbutfirstUTF8(text)
	if text == nil then return end

	text = tostring(text)
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
	assert(type(str) == "string" and type(div) == "string", "invalid arguments for string explosion")
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

	newinputsys.pause()

	oldstate = state
	state = anythingbutnil0(new)
	if not dontinitialize then
		cons("State changed: " .. oldstate .. " => " .. state .. " (inited)")
		loadstate(state, ...) -- just so states can be prepared easily
	else
		cons("State changed: " .. oldstate .. " => " .. state .. " (not initialized)")
	end

	newinputsys.resume()

	reset_special_cursor()

	if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		unset_middlescroll()
	end

	if playtesting_uistate == PT_UISTATE.ASKING then
		playtesting_cancelask()
	end

	if oldstate == 1 and editingroomname then
		saveroomname()
	end
end

function loadstate(new, ...)
	if uis[new] ~= nil and uis[new].load ~= nil then
		uis[new].load(...)
	end

	hook("func_loadstate", {...})
end

-- Go to state allocated by a plugin
function to_astate(name, new, dontinitialize, ...)
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
		loadstate(state, ...)
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
	lsuccess = directory_exists(levelsfolder)
	if lsuccess then
		files = listlevelfiles(levelsfolder, "name")
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
	current_scrolling_leveltitle_font = font_8x8
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
						ov, lm = anythingbutnil0(parts[1]), anythingbutnil0(parts[2])
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
	if directory_exists(levelsfolder .. dirsep .. editingmap) then
		return levelsfolder .. dirsep .. editingmap
	end

	-- Not found
	return nil
end

function load_vvvvvv_tilesets(levelassetsfolder)
	-- Normally called without argument. This function may call itself once more with it filled.
	-- levelassetsfolder may be a path to a level-specific assets folder, which overrides any existing assets

	load_vvvvvv_tileset("tiles.png", 8, levelassetsfolder)
	load_vvvvvv_tileset("tiles2.png", 8, levelassetsfolder)
	load_vvvvvv_tileset("tiles3.png", 8, levelassetsfolder)
	load_vvvvvv_tileset("entcolours.png", 8, levelassetsfolder)
	load_vvvvvv_tileset("vtools_tiles.png", 1, levelassetsfolder)
	load_vvvvvv_tileset("vtools_tiles2.png", 1, levelassetsfolder)
	load_vvvvvv_sprites("sprites.png", 32, levelassetsfolder)
	load_vvvvvv_sprites("teleporter.png", 96, levelassetsfolder)
	load_vvvvvv_image("covered.png", levelassetsfolder, true, false)
	load_vvvvvv_image("elephant.png", levelassetsfolder, false, true)
	load_vvvvvv_image("gamecomplete.png", levelassetsfolder, true, false)
	load_vvvvvv_image("levelcomplete.png", levelassetsfolder, true, false)
	load_vvvvvv_image("minimap.png", levelassetsfolder, true, false)


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
			load_vvvvvv_tilesets(levelassets)
		end
	end

	-- Doesn't rely on loading files from somewhere specific
	loadwarpbgs()
end

local function read_vvvvvv_imagedata(file, levelassetsfolder)
	local readsuccess, contents
	if levelassetsfolder == nil then
		-- Just loading global assets, either custom or built-in
		tilesets[file] = {}
		tilesets[file].level_specific = false

		-- Try loading custom assets first
		readsuccess, contents = readfile(graphicsfolder .. dirsep .. file)
	else
		-- Level-specific file
		readsuccess, contents = readfile(levelassetsfolder .. dirsep .. "graphics" .. dirsep .. file)

		-- Not interested in another copy of the assets we already had
		if not readsuccess then
			return nil
		end

		-- This level-specific file definitely exists
		tilesets[file] = {}
		tilesets[file].level_specific = true
	end

	local imgdata
	if readsuccess then
		-- Custom image!
		cons("Custom image: " .. file)
		imgdata = love.image.newImageData(love.filesystem.newFileData(contents, file, "file"))
	else
		cons("No custom image for " .. file .. ", " .. contents)
		imgdata = love.image.newImageData("vgraphics/" .. file)
	end
	return imgdata
end

function load_vvvvvv_image(file, levelassetsfolder, colored, white)
	-- Load an image from the game into tilesets[file].
	-- Like load_vvvvvv_tileset() and load_vvvvvv_sprites(), but without making a tile grid
	local imgdata = read_vvvvvv_imagedata(file, levelassetsfolder)
	if imgdata == nil then
		return false
	end

	local w, h = imgdata:getDimensions()
	if colored then
		tilesets[file].img = love.graphics.newImage(imgdata)
	end
	tilesets[file].width = w
	tilesets[file].height = h

	local imgdata_white
	if white then
		if colored then
			-- Both white and colored...
			imgdata_white = love.image.newImageData(w, h)
			imgdata_white:paste(imgdata, 0, 0, 0, 0, w, h)
		else
			-- Simply make a reference, we weren't using the colored one
			imgdata_white = imgdata
		end

		imgdata_white:mapPixel(function(x, y, r, g, b, a)
			return 255, 255, 255, a
		end)

		tilesets[file].white_img = love.graphics.newImage(imgdata_white)
	end

	return true
end

function load_vvvvvv_tileset(file, res, levelassetsfolder)
	-- Load a tiles*.png into tilesets[file].
	-- Some tiles need to show up in any color we choose, so load both a colored
	-- and a white version so we can color-correct it.
	if not load_vvvvvv_image(file, levelassetsfolder, true, true) then
		return
	end

	tilesets[file].tiles_width = math.floor(tilesets[file].width/res)
	tilesets[file].tiles_height = math.floor(tilesets[file].height/res)

	tilesets[file].total_tiles = tilesets[file].tiles_width * tilesets[file].tiles_height

	tilesets[file].tiles_width_picker = math.min(40, tilesets[file].tiles_width)
	if tilesets[file].tiles_width_picker == 0 then
		tilesets[file].tiles_height_picker = 0
	else
		tilesets[file].tiles_height_picker = math.ceil(tilesets[file].total_tiles / tilesets[file].tiles_width_picker)
	end

	cons("Loading tileset: " .. file .. ", "
		.. tilesets[file].width .. "x" .. tilesets[file].height .. ", "
		.. tilesets[file].tiles_width .. "x" .. tilesets[file].tiles_height
	)

	tilesets[file].tiles = {}

	for tsy = 0, (tilesets[file].tiles_height-1) do
		for tsx = 0, (tilesets[file].tiles_width-1) do
			tilesets[file].tiles[(tsy*tilesets[file].tiles_width)+tsx] = love.graphics.newQuad(
				tsx*res, tsy*res, res, res, tilesets[file].width, tilesets[file].height
			)
		end
	end

	-- If this tileset is smaller than 1200 (tiles3) then fill up with tile 0 to prevent crashes
	for filler = tilesets[file].tiles_width*tilesets[file].tiles_height, 1199 do
		tilesets[file].tiles[filler] = love.graphics.newQuad(0, 0, res, res, tilesets[file].width, tilesets[file].height)
	end
end

function load_vvvvvv_sprites(file, res, levelassetsfolder)
	-- Load a sprites file into tilesets[file].
	if not load_vvvvvv_image(file, levelassetsfolder, false, true) then
		return
	end

	tilesets[file].tiles_width = math.floor(tilesets[file].width/res)
	tilesets[file].tiles_height = math.floor(tilesets[file].height/res)

	cons("Loading spriteset: " .. file .. ", "
		.. tilesets[file].width .. "x" .. tilesets[file].height .. ", "
		.. tilesets[file].tiles_width .. "x" .. tilesets[file].tiles_height
	)

	tilesets[file].tiles = {}

	for tsy = 0, (tilesets[file].tiles_height-1) do
		for tsx = 0, (tilesets[file].tiles_width-1) do
			tilesets[file].tiles[(tsy*tilesets[file].tiles_width)+tsx] = love.graphics.newQuad(
				tsx*res, tsy*res, res, res, tilesets[file].width, tilesets[file].height
			)
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
				love.graphics.newSpriteBatch(tilesets["tiles2.png"].img, 16*21, "static")
			)
			local quad = love.graphics.newQuad(
				-24+24*c, 128 + 16*d, 16, 16,
				tilesets["tiles2.png"].width, tilesets["tiles2.png"].height
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
	load_vvvvvv_tilesets()
	loadfonts_custom()
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

function hoverdraw(img, x, y, w, h, s)
	local callret = theme:call("hover_draw_asset", img, x, y, w, h, s)
	if callret ~= nil then
		return callret
	end

	if nodialog and mouseon(x, y, w, h) and window_active() then
		theme:draw(img, x, y, 0, s)
	else
		love.graphics.setColor(255,255,255,128)
		theme:draw(img, x, y, 0, s)
		love.graphics.setColor(255,255,255,255)
	end
end

function hoverrectangle_noshine(r, g, b, a, x, y, w, h, thisbelongstoarightclickmenu)
	local hovering = (nodialog or thisbelongstoarightclickmenu) and mouseon(x, y, w, h) and window_active()
	if hovering then
		a = 255
	end
	love.graphics.setColor(r, g, b, a)
	love.graphics.rectangle("fill", x, y, w, h)

	love.graphics.setColor(255,255,255,255)

	-- Avoid a nil return
	return hovering == true
end

function hoverrectangle(r, g, b, a, x, y, w, h, thisbelongstoarightclickmenu, darkfactor)
	local callret = theme:call("draw_button", r, g, b, a, x, y, w, h, thisbelongstoarightclickmenu, darkfactor)
	if callret ~= nil then
		return callret
	end
	if darkfactor == nil then
		if thisbelongstoarightclickmenu then
			darkfactor = 0.9
		else
			darkfactor = 0.75
		end
	end

	local hovering = (nodialog or thisbelongstoarightclickmenu) and mouseon(x, y, w, h) and window_active()
	local half_height = math.floor(h/2)
	if hovering then
		a = 255
	end
	love.graphics.setColor(r, g, b, a)
	love.graphics.rectangle("fill", x, y, w, half_height)
	love.graphics.setColor(r*darkfactor, g*darkfactor, b*darkfactor, a)
	love.graphics.rectangle("fill", x, y+half_height, w, h-half_height)

	love.graphics.setColor(255,255,255,255)

	-- Avoid a nil return
	return hovering == true
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
	if (font_ui:getWidth(label) > 128-16 or label:find("\n") ~= nil) then
		textyoffset = 0
	end

	local y
	if bottom then
		y = love.graphics.getHeight()-(buttonspacing*(pos+1))-(yoffset-8)
	else
		y = yoffset+(buttonspacing*pos)
	end
	hoverrectangle(yellow and 160 or 128,yellow and 160 or 128,yellow and 0 or 128,128, love.graphics.getWidth()-(128-8), y, 128-16, 16)
	font_ui:printf(label, love.graphics.getWidth()-(128-8)+1, y+textyoffset, 128-16, "center")
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

function radio_wrap(selected, x, y, key, label, label_max_width, onclickfunc, onhoverfunc, font)
	-- label_max_width is allowed to be nil (Ved has its own :getWrap that explicitly allows it)
	font = font or font_ui
	local clickable_w, label_lines = font:getWrap(label, label_max_width)
	clickable_w = clickable_w + 8 + 32
	hoverdraw(
		selected and image.radioon_hq or image.radiooff_hq,
		x, y, clickable_w, 16
	)
	if selected then
		love.graphics.setColor(255,255,128)
	end
	local print_y = y+4
	if label_lines > 1 then
		print_y = y
	end
	if label_max_width ~= nil then
		font:printf(label, x+16+8, print_y, label_max_width, "left")
	else
		font:print(label, x+16+8, print_y)
	end
	love.graphics.setColor(255,255,255)

	if nodialog and mouseon(x, y, clickable_w, 16) then
		if onhoverfunc ~= nil then
			onhoverfunc(key)
		end

		if not mousepressed and love.mouse.isDown("l") then
			onclickfunc(key)
			mousepressed = true
		end
	end
end

function radio(selected, x, y, key, label, onclickfunc, onhoverfunc, font)
	radio_wrap(selected, x, y, key, label, nil, onclickfunc, onhoverfunc, font)
end

function checkbox(selected, x, y, key, label, onclickfunc, onhoverfunc, font)
	font = font or font_ui
	local clickable_w = 8+32+font:getWidth(label)
	hoverdraw(
		selected and image.checkon_hq or image.checkoff_hq,
		x, y, clickable_w, 16
	)
	font:print(label, x+16+8, y+4)

	if nodialog and mouseon(x, y, clickable_w, 16) then
		if onhoverfunc ~= nil then
			onhoverfunc(key)
		end

		if not mousepressed and love.mouse.isDown("l") then
			onclickfunc(key, not selected)
			mousepressed = true
		end
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

	if tostring(number):len() > dig then
		return ("9"):rep(dig)
	elseif tostring(number):len() == dig then
		return tostring(number)
	else
		return filler:rep(dig-tostring(number):len()) .. tostring(number)
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
	return "ui/tools/sub/" .. name
end

function updatecountdelete(thet, id, undoing)
	-- So what are we removing?
	if thet == 9 then
		level.count.trinkets = level.count.trinkets - 1
	elseif thet == 15 then
		level.count.crewmates = level.count.crewmates - 1
	elseif thet == 16 then
		level.count.startpoint = nil
	end

	-- Make sure we can undo this! If we're not already removing an entity by undoing
	if not undoing then
		table.insert(undobuffer, {undotype = "removeentity", rx = roomx, ry = roomy, entid = id, removedentitydata = table.copy(entitydata[id])})
		finish_undo("REMOVED ENTITY")
	end

	level.count.entities = level.count.entities - 1
end

function updatecountadd(thet)
	if thet == 9 then
		level.count.trinkets = level.count.trinkets + 1
	elseif thet == 15 then
		level.count.crewmates = level.count.crewmates + 1
	-- Startpoint (16) should not be handled with this function
	end

	level.count.entities = level.count.entities + 1
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
	if keyboard_eitherIsDown("shift") then
		selectedtileset = revcycle(selectedtileset, maxtileset, 0)
	else
		selectedtileset = cycle(selectedtileset, maxtileset, 0)
	end
	local rmd = level:get_roommetadata(roomx, roomy)
	if tilesetblocks[selectedtileset].colors[selectedcolor] == nil
	or (selectedtileset == 2 and selectedcolor == 6 and rmd.directmode == 0 and rmd.auto2mode == 0) then
		selectedcolor = 0
	end

	local oldtileset = rmd.tileset
	local oldtilecol = rmd.tilecol

	level:set_roommetadata(roomx, roomy, "tileset", selectedtileset)
	level:set_roommetadata(roomx, roomy, "tilecol", selectedcolor)

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
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
			toundotiles = table.copy(roomdata_get(roomx, roomy))
		}
	)
	finish_undo("TILESET")

	autotiling:make_autotiling_base()

	autocorrectroom() -- this already checks if automatic mode is on

	tilespicker_page = 0
end

function switchtilecol()
	local max = #tilesetblocks[selectedtileset].colors
	local min = selectedtileset == 0 and -1 or 0
	if keyboard_eitherIsDown("shift") then
		selectedcolor = revcycle(selectedcolor, max, min)
	else
		selectedcolor = cycle(selectedcolor, max, min)
	end
	local rmd = level:get_roommetadata(roomx, roomy)
	if selectedtileset == 2 and selectedcolor == 6 and rmd.directmode == 0 and rmd.auto2mode == 0 then
		-- lab rainbow background isn't available in auto-mode
		if keyboard_eitherIsDown("shift") then
			selectedcolor = 5
		else
			selectedcolor = 0
		end
	end

	local oldtilecol = rmd.tilecol

	level:set_roommetadata(roomx, roomy, "tilecol", selectedcolor)

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "tilecol",
					oldvalue = oldtilecol,
					newvalue = selectedcolor
				}
			},
			changetiles = true,
			toundotiles = table.copy(roomdata_get(roomx, roomy))
		}
	)
	finish_undo("TILECOL")

	autotiling:make_autotiling_base()

	autocorrectroom() -- this already checks if automatic mode is on
end

function switchenemies()
	local oldtype = level:get_roommetadata(roomx, roomy).enemytype
	local maxenemy = 9
	local newtype
	if keyboard_eitherIsDown("shift") then
		newtype = revcycle(oldtype, maxenemy, 0)
	else
		newtype = cycle(oldtype, maxenemy, 0)
	end
	level:set_roommetadata(roomx, roomy, "enemytype", newtype)

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "enemytype",
					oldvalue = oldtype,
					newvalue = newtype
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
	cancel_placing_entity()

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
					newvalue = level:get_roommetadata(roomx, roomy)["enemy" .. v]
				}
			)
		end
		table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
		finish_undo("ENEMY BOUNDS (canceled)")
	else
		if editingbounds == 2 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = level:get_roommetadata(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (canceled by enemy bounds)")
		end
		editingbounds = -1
	end
end

function changeplatformbounds()
	cancel_placing_entity()

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
					newvalue = level:get_roommetadata(roomx, roomy)["plat" .. v]
				}
			)
		end
		table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
		finish_undo("PLATFORM BOUNDS (canceled)")
	else
		if editingbounds == 1 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = level:get_roommetadata(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (canceled by platform bounds)")
		end
		editingbounds = -2
	end
end

function changedmode()
	local rmd = level:get_roommetadata(roomx, roomy)
	local olddirect = rmd.directmode
	local oldauto2 = rmd.auto2mode

	if keyboard_eitherIsDown("shift") then
		if olddirect == 0 and oldauto2 == 0 then
			level:set_roommetadata(roomx, roomy, "directmode", 1)
		elseif oldauto2 == 1 then
			level:set_roommetadata(roomx, roomy, "auto2mode", 0)
		else
			level:set_roommetadata(roomx, roomy, "directmode", 0)
			level:set_roommetadata(roomx, roomy, "auto2mode", 1)
		end
	else
		if olddirect == 0 and oldauto2 == 0 then
			level:set_roommetadata(roomx, roomy, "auto2mode", 1)
		elseif oldauto2 == 1 then
			level:set_roommetadata(roomx, roomy, "directmode", 1)
			level:set_roommetadata(roomx, roomy, "auto2mode", 0)
		else
			level:set_roommetadata(roomx, roomy, "directmode", 0)
		end
	end

	rmd = level:get_roommetadata(roomx, roomy)

	if selectedtileset == 2 and selectedcolor == 6 and rmd.directmode == 0 and rmd.auto2mode == 0 then
		-- lab rainbow background isn't available in auto-mode
		selectedcolor = 0
	end

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "directmode",
					oldvalue = olddirect,
					newvalue = rmd.directmode
				},
				{
					key = "auto2mode",
					oldvalue = oldauto2,
					newvalue = rmd.auto2mode
				}
			}
		}
	)
	finish_undo("MODE")
end

function changewarpdir()
	local oldwarpdir = level:get_roommetadata(roomx, roomy).warpdir
	local newwarpdir
	if keyboard_eitherIsDown("shift") then
		newwarpdir = revcycle(oldwarpdir, 3, 0)
	else
		newwarpdir = cycle(oldwarpdir, 3, 0)
	end
	level:set_roommetadata(roomx, roomy, "warpdir", newwarpdir)

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "warpdir",
					oldvalue = oldwarpdir,
					newvalue = newwarpdir
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
		-- If we have any special roomnames in this room, go to the special editor immediately!
		if level.specialroomnames[roomy] ~= nil
		and level.specialroomnames[roomy][roomx] ~= nil
		and #level.specialroomnames[roomy][roomx] >= 1 then
			edit_special_roomnames()
		else
			editingroomname = true
			tilespicker = false
			newinputsys.create(INPUT.ONELINE, "roomname", level:get_roommetadata(roomx, roomy).roomname)
		end
	end
end

function edit_special_roomnames()
	cancel_editing_roomname()
	tostate(38)
end

function tilespicker_last_page_number()
	-- Return the number of the last tilespicker page
	return math.ceil(tilesets[tileset_names[level:get_roommetadata(roomx, roomy).tileset]].tiles_height_picker/30)-1
end

function tilespicker_prev_page()
	tilespicker_page = tilespicker_page - 1
	if tilespicker_page < 0 then
		tilespicker_page = tilespicker_last_page_number()
	end
end

function tilespicker_next_page()
	tilespicker_page = tilespicker_page + 1
	if tilespicker_page > tilespicker_last_page_number() then
		tilespicker_page = 0
	end
end

function tilespicker_selectedtile_page()
	-- Ensure the current page is set so that selectedtile is on screen
	local ts = tilesets[tileset_names[level:get_roommetadata(roomx, roomy).tileset]]
	tilespicker_page = math.floor(selectedtile/(ts.tiles_width_picker*30))
end

function saveroomname()
	if not editingroomname then
		return
	end
	editingroomname = false
	local old_roomname = anythingbutnil(level:get_roommetadata(roomx, roomy).roomname)
	local new_roomname = inputs.roomname
	newinputsys.close("roomname")
	level:set_roommetadata(roomx, roomy, "roomname", new_roomname)

	table.insert(undobuffer, {undotype = "roommetadata", rx = roomx, ry = roomy, changedmetadata = {
				{
					key = "roomname",
					oldvalue = old_roomname,
					newvalue = new_roomname
				}
			}
		}
	)
	finish_undo("ROOMNAME")
end

function cancel_editing_roomname()
	if not editingroomname then
		return
	end
	editingroomname = false
	newinputsys.close("roomname")
end

function get_load_script_creation_mode()
	local mode = create_load_script
	if not nodialog or editingroomname then
		-- No Shift/Ctrl switching now
	elseif keyboard_eitherIsDown("shift") then
		if mode == LOAD_SCRIPT_CREATION_MODE.RUNONCE then
			mode = LOAD_SCRIPT_CREATION_MODE.NO
		else
			mode = LOAD_SCRIPT_CREATION_MODE.RUNONCE
		end
	elseif keyboard_eitherIsDown(ctrl) then
		if mode == LOAD_SCRIPT_CREATION_MODE.REPEATING then
			mode = LOAD_SCRIPT_CREATION_MODE.NO
		else
			mode = LOAD_SCRIPT_CREATION_MODE.REPEATING
		end
	end
	return mode
end

function start_editing_roomtext(ent_id, is_new, make_script)
	editingroomtext = ent_id
	editingroomtext_is_new = is_new
	editingroomtext_make_script = make_script
	local init = ""
	if entitydata[ent_id] ~= nil then
		init = entitydata[ent_id].data
	end
	newinputsys.create(INPUT.ONELINE, "roomtext", init)
end

function end_editing_roomtext()
	if entitydata[editingroomtext] == nil then
		cons("Existing room text we were editing is nil!")
		editingroomtext = 0
		return
	end
	if entitydata[editingroomtext].t ~= 17 and inputs.roomtext:find("|") then
		dialog.create(langkeys(L.CANNOTUSENEWLINES, {"|"}))
		return
	end

	-- We were typing a text!
	local olddata = entitydata[editingroomtext].data
	entitydata[editingroomtext].data = inputs.roomtext
	-- Only make a script if this is a terminal/script box, and the name is not empty
	if editingroomtext_make_script and inputs.roomtext ~= "" then
		if s.loadscriptname ~= "" and s.loadscriptname ~= "$1" then
			local warnloadscriptexists = false
			local loadscriptname = langkeys(s.loadscriptname, {inputs.roomtext})
			local create_mode = get_load_script_creation_mode()
			if create_mode == LOAD_SCRIPT_CREATION_MODE.RUNONCE then -- flag
				if level.scripts[loadscriptname] ~= nil then
					warnloadscriptexists = true
				else
					-- What flag is available?
					usedflags = {}
					outofrangeflags = {}

					-- See which flags have been used in this level.
					return_used_flags(usedflags, outofrangeflags)

					local useflag = -1
					for flag = 0, limit.flags-1 do
						if not usedflags[flag] then
							useflag = flag
							usedflags[flag] = true
							--level.vedmetadata.flaglabel[flag] = partss[2]
							break
						end
					end

					if useflag == -1 then
						-- No flags left?
						dialog.create(langkeys(L.NOFLAGSLEFT_LOADSCRIPT, {inputs.roomtext}))
						level.scripts[loadscriptname] = {"iftrinkets(0," .. inputs.roomtext .. ")"}
					else
						level.scripts[loadscriptname] = {
							"ifflag(" .. useflag .. ",stop)",
							"flag(" .. useflag .. ",on)",
							"iftrinkets(0," .. inputs.roomtext .. ")"
						}
					end
					table.insert(level.scriptnames, loadscriptname)

					temporaryroomname = L.LOADSCRIPTMADE
					temporaryroomnametimer = 90
				end
				entitydata[editingroomtext].data = loadscriptname
			elseif create_mode == LOAD_SCRIPT_CREATION_MODE.REPEATING then -- trinkets
				if level.scripts[loadscriptname] ~= nil then
					warnloadscriptexists = true
				else
					level.scripts[loadscriptname] = {"iftrinkets(0," .. inputs.roomtext .. ")"}
					table.insert(level.scriptnames, loadscriptname)

					temporaryroomname = L.LOADSCRIPTMADE
					temporaryroomnametimer = 90
				end
				entitydata[editingroomtext].data = loadscriptname
			end
			if warnloadscriptexists then
				dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {loadscriptname}))
			end
		end

		if level.scripts[inputs.roomtext] == nil then
			level.scripts[inputs.roomtext] = {""}
			table.insert(level.scriptnames, inputs.roomtext)
		end
	end
	if editingroomtext_is_new then
		entityplaced(editingroomtext)
		editingroomtext_is_new = false
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

	editingroomtext = 0
	newinputsys.close("roomtext")
end

function print_editing_roomtext(x, y, cjk_align)
	-- Print the roomtext that's currently being edited at x,y.

	textshadow(inputs.roomtext, x, y, font_level, cjk_align, 2)
	-- We need to set the mouse area manually because this is in a scissored area,
	-- which will take over otherwise...
	local area_x1 = math.max(x-4, screenoffset)
	local area_x2 = math.min(font_level:getWidth(inputs.roomtext)*2+8 + (x-4), (screenoffset+640))
	newinputsys.setmousearea("roomtext", area_x1, y-4, area_x2-area_x1, 16+8)
	newinputsys.print("roomtext", x, y, font_level, cjk_align, 2)
end

function createmde(thislimit)
	if thislimit == nil then
		thislimit = limit
	end
	cons("Creating metadata entity...")
	if level ~= nil and level.count ~= nil then
		level.count.entities = level.count.entities + 1
	end
	local emptyflaglabel = {}
	for i = 0, thislimit.flags-1 do
		emptyflaglabel[i] = ""
	end
	return {
		mdeversion = thismdeversion,
		flaglabel = emptyflaglabel,
		vars = {},
		notes = {}
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
			inputs.levelname = levelname .. dirsep
			newinputsys.rightmost("levelname")
			tabselected = 0
			return
		end
	end

	-- Loading levels tends to happen where it shouldn't.
	love.graphics.setScissor()

	if dirsep == "\\" then
		levelname = levelname:gsub("/", "\\")
	end

	local success

	if not secondlevel then
		local oldlevel
		if level ~= nil then
			-- We already had a level loaded, but this one might fail to load! Most of these will be pointers to tables, so it won't hurt much to do this.
			oldeditingmap, oldmetadata, oldlimit, oldroomdata, oldentitydata, oldlevel
			=  editingmap,    metadata,    limit,    roomdata,    entitydata,    level
		end

		success, metadata, limit, roomdata, entitydata, level = loadlevel(levelname .. ".vvvvvv")

		if not success then
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata)

			-- Did we have a previous level open?
			if oldlevel ~= nil then
				-- We did!
				   editingmap,    metadata,    limit,    roomdata,    entitydata,    level =
				oldeditingmap, oldmetadata, oldlimit, oldroomdata, oldentitydata, oldlevel
			end
		else
			editingmap = levelname
			recentlyopened(editingmap)
			map_init()
			unloadvvvvvvmusics_level()
			if level_assets_loaded or getlevelassetsfolder() ~= nil then
				-- Either previous or new level has level-specific assets, so reload.
				load_vvvvvv_tilesets()
				loadfonts_custom()
				tile_batch_texture_needs_update = true
			end
			if state == 6 then
				levelslist_close_input()
			end
			tostate(1)
		end
	else
		success, metadata2, limit2, roomdata2, entitydata2, level2 = loadlevel(levelname .. ".vvvvvv")

		if not success then
			dialog.create(langkeys(L.LEVELOPENFAIL, {anythingbutnil(levelname)}) .. "\n\n" .. metadata2)
		else
			-- Compare differences now!
			compare_level_differences(levelname)
		end
	end
end

function levelslist_close_input()
	levelslist_old_input = inputs.levelname
	newinputsys.close("levelname")
end

function compare_level_differences(second_level_name)
	-- Assuming we have both level and level2
	-- Where level2 is the older version, level is the newer version. Also, second_level_name is the older version

	differencesn = {}
	local pagetext

	-- L E V E L   P R O P E R T I E S
	pagetext = diffmessages.pages.levelproperties .. "\\wh#\n\n"
		.. (editingmap == "untitled\n"
			and langkeys(L.COMPARINGTHESENEW, {second_level_name})
			or langkeys(L.COMPARINGTHESE, {editingmap, second_level_name})
		) .. "\\\n\n"
	for _,v in pairs(metadataitems) do
		if metadata2[v] ~= metadata[v] then
			pagetext = pagetext .. langkeys(
				diffmessages.levelpropertiesdiff[v],
				{metadata2[v], metadata[v]}
			) .. "\\\n"
		end
	end

	if metadata2.mapwidth ~= metadata.mapwidth
	or metadata2.mapheight ~= metadata.mapheight then
		pagetext = pagetext .. langkeys(
			diffmessages.levelpropertiesdiff.mapsize,
			{metadata2.mapwidth, metadata2.mapheight, metadata.mapwidth, metadata.mapheight}
		) .. "\\\n"
	end
	if metadata2.levmusic ~= metadata.levmusic then
		pagetext = pagetext .. langkeys(
			diffmessages.levelpropertiesdiff.levmusic,
			{metadata2.levmusic, metadata.levmusic}
		) .. "\\\n"
	end

	table.insert(differencesn, {subj = diffmessages.pages.levelproperties, imgs = {}, cont = pagetext})

	-- R O O M S
	pagetext = diffmessages.pages.changedrooms .. "\\wh#\n\n"
	local co = not s.coords0 and 1 or 0 -- coordoffset

	if metadata2.mapwidth ~= metadata.mapwidth
	or metadata2.mapheight ~= metadata.mapheight then
		pagetext = pagetext .. langkeys(
			diffmessages.levelpropertiesdiff.mapsizenote,
			{
				metadata2.mapwidth, metadata2.mapheight,
				metadata.mapwidth, metadata.mapheight,
				math.min(metadata2.mapwidth, metadata.mapwidth),
				math.min(metadata2.mapheight, metadata.mapheight)
			}
		) .. "\n\n"
	end

	for ry = 0, math.min(metadata2.mapheight-1, metadata.mapheight-1) do
		for rx = 0, math.min(metadata2.mapwidth-1, metadata.mapwidth-1) do
			local leftblank, rightblank, changed = true, true, false

			local roomdata1 = roomdata_get(rx, ry)
			for k,v in pairs(roomdata2_get(rx, ry)) do
				if leftblank and v ~= 0 then
					leftblank = false
				end
				if rightblank and roomdata1[k] ~= 0 then
					rightblank = false
				end
				if not changed and v ~= roomdata1[k] then
					changed = true
				end
			end

			if changed and level2:get_roommetadata(rx, ry).roomname == level:get_roommetadata(rx, ry).roomname then
				if leftblank then
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.added1,
						{rx+co, ry+co, level2:get_roommetadata(rx, ry).roomname}
					) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.cleared1,
						{rx+co, ry+co, level2:get_roommetadata(rx, ry).roomname}
					) .. "\n"
				else
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.changed1,
						{rx+co, ry+co, level2:get_roommetadata(rx, ry).roomname}
					) .. "\n"
				end
			elseif changed then -- room names not the same
				if leftblank then
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.added2,
						{
							rx+co, ry+co,
							level2:get_roommetadata(rx, ry).roomname,
							level:get_roommetadata(rx, ry).roomname
						}
					) .. "\n"
				elseif rightblank then
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.cleared2,
						{
							rx+co, ry+co,
							level2:get_roommetadata(rx, ry).roomname,
							level:get_roommetadata(rx, ry).roomname
						}
					) .. "\n"
				else
					pagetext = pagetext .. langkeys(
						diffmessages.rooms.changed2,
						{
							rx+co, ry+co,
							level2:get_roommetadata(rx, ry).roomname,
							level:get_roommetadata(rx, ry).roomname
						}
					) .. "\n"
				end
			end
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.changedrooms, imgs = {}, cont = pagetext})

	-- R O O M   M E T A D A T A
	pagetext = diffmessages.pages.changedroommetadata .. "\\wh#\n\n"

	for ry = 0, math.min(metadata2.mapheight-1, metadata.mapheight-1) do
		for rx = 0, math.min(metadata2.mapwidth-1, metadata.mapwidth-1) do
			local rmd1, rmd2 = level:get_roommetadata(rx, ry), level2:get_roommetadata(rx, ry)
			local changed = false

			-- Is anything different?
			for k,v in pairs(rmd2) do
				if v ~= rmd1[k] then
					changed = true
				end
			end

			local lrmx, lrmy = rx, ry

			if not s.coords0 then
				lrmx = lrmx + 1
				lrmy = lrmy + 1
			end

			if changed and rmd2.roomname ~= rmd1.roomname then
				-- We're already going to show that the room name has changed
				pagetext = pagetext .. langkeys(
					diffmessages.roommetadata.changed0,
					{lrmx, lrmy}
				) .. "\n"
			elseif changed then
				-- We're not, so label this
				pagetext = pagetext .. langkeys(
					diffmessages.roommetadata.changed1,
					{lrmx, lrmy, rmd2.roomname}
				) .. "\\\n"
			end

			if changed then
				-- So what has changed?
				if rmd2.roomname ~= rmd1.roomname then
					if rmd2.roomname == "" then
						pagetext = pagetext .. "  " .. langkeys(
							diffmessages.roommetadata.roomnameadded,
							{rmd1.roomname}
						) .. "\n"
					elseif rmd1.roomname == "" then
						pagetext = pagetext .. "  " .. langkeys(
							diffmessages.roommetadata.roomnameremoved,
							{rmd2.roomname}
						) .. "\n"
					else
						pagetext = pagetext .. "  " .. langkeys(
							diffmessages.roommetadata.roomname,
							{rmd2.roomname, rmd1.roomname}
						) .. "\n"
					end
				end
				if rmd2.tileset ~= rmd1.tileset or rmd2.tilecol ~= rmd1.tilecol then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.tileset,
						{rmd2.tileset, rmd2.tilecol, rmd1.tileset, rmd1.tilecol}
					) .. "\n"
				end
				if rmd2.platv ~= rmd1.platv then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.platv,
						{rmd2.platv, rmd1.platv}
					) .. "\n"
				end
				if rmd2.enemytype ~= rmd1.enemytype then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.enemytype,
						{rmd2.enemytype, rmd1.enemytype}
					) .. "\n"
				end
				if rmd2.platx1 ~= rmd1.platx1 or rmd2.platy1 ~= rmd1.platy1
				or rmd2.platx2 ~= rmd1.platx2 or rmd2.platy2 ~= rmd1.platy2 then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.platbounds,
						{
							rmd2.platx1, rmd2.platy1, rmd2.platx2, rmd2.platy2,
							rmd1.platx1, rmd1.platy1, rmd1.platx2, rmd1.platy2
						}
					) .. "\n"
				end
				if rmd2.enemyx1 ~= rmd1.enemyx1 or rmd2.enemyy1 ~= rmd1.enemyy1
				or rmd2.enemyx2 ~= rmd1.enemyx2 or rmd2.enemyy2 ~= rmd1.enemyy2 then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.enemybounds,
						{
							rmd2.enemyx1, rmd2.enemyy1, rmd2.enemyx2, rmd2.enemyy2,
							rmd1.enemyx1, rmd1.enemyy1, rmd1.enemyx2, rmd1.enemyy2
						}
					) .. "\n"
				end
				if rmd2.directmode == 0 and rmd1.directmode == 1 then
					pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode01 .. "\n"
				elseif rmd2.directmode == 1 and rmd1.directmode == 0 then
					pagetext = pagetext .. "  " .. diffmessages.roommetadata.directmode10 .. "\n"
				end
				if rmd2.warpdir ~= rmd1.warpdir then
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.roommetadata.warpdir,
						{warpdirs[rmd2.warpdir], warpdirs[rmd1.warpdir]}
					) .. "\n"
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
				pagetext = pagetext .. langkeys(
					diffmessages.entities.addedmultiple,
					{bkx, bky, eroomx, eroomy}
				) .. "\n"
				for k2,v2 in pairs(v) do
					pagetext = pagetext .. "  " .. langkeys(
						diffmessages.entities.entity,
						{getentityname(v2.t, v2.p1)}
					) .. "\n"
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
					pagetext = pagetext .. langkeys(
						diffmessages.entities.multiple1,
						{bkx, bky, eroomx, eroomy}
					) .. "\n"
					-- List all entities at this spot from original level
					for k2,v2 in pairs(locentities2[k]) do
						pagetext = pagetext .. "  " .. langkeys(
							diffmessages.entities.entity,
							{getentityname(v2.t, v2.p1)}
						) .. "\n"
					end
					pagetext = pagetext .. diffmessages.entities.multiple2 .. "\n"
					-- List all entities at this spot from newer level
					for k2,v2 in pairs(v) do
						pagetext = pagetext .. "  " .. langkeys(
							diffmessages.entities.entity,
							{getentityname(v2.t, v2.p1)}
						) .. "\n"
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

			pagetext = pagetext .. langkeys(
				diffmessages.entities.removedmultiple,
				{bkx, bky, eroomx, eroomy}
			) .. "\n"
			for k2,v2 in pairs(v) do
				pagetext = pagetext .. "  " .. langkeys(
					diffmessages.entities.entity,
					{getentityname(v2.t, v2.p1)}
				) .. "\n"
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
			pagetext = pagetext .. langkeys(
				diffmessages.entities.added,
				{getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}
			) .. "\n"
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
					pagetext = pagetext .. langkeys(
						diffmessages.entities.changedtype,
						{
							getentityname(locentities2[k][1].t, locentities2[k][1].p1),
							getentityname(v[1].t, v[1].p1),
							bkx, bky, eroomx, eroomy
						}
					) .. "\n"
				else
					pagetext = pagetext .. langkeys(
						diffmessages.entities.changed,
						{getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}
					) .. "\n"
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

		pagetext = pagetext .. langkeys(
			diffmessages.entities.removed,
			{getentityname(v[1].t, v[1].p1), bkx, bky, eroomx, eroomy}
		) .. "\n"

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
	for k,v in pairs(level.scripts) do
		if level2.scripts[k] == nil then
			-- This script didn't exist in the older version, so it was added!
			pagetext = pagetext .. langkeys(diffmessages.scripts.added, {k}) .. "\n"
		else
			-- Was it edited?
			if table.concat(level2.scripts[k], "\n") ~= table.concat(v, "\n") then
				pagetext = pagetext .. langkeys(diffmessages.scripts.edited, {k}) .. "\n"
			end
		end
	end

	-- Any scripts that were removed?
	for k,v in pairs(level2.scripts) do
		if level.scripts[k] == nil then
			pagetext = pagetext .. langkeys(diffmessages.scripts.removed, {k}) .. "\n"
		end
	end

	table.insert(differencesn, {subj = diffmessages.pages.scripts, imgs = {}, cont = pagetext})

	if level.vedmetadata ~= false or level2.vedmetadata ~= false then
		-- F L A G   N A M E S
		pagetext = diffmessages.pages.flagnames .. "\\wh#\n\n"

		if level2.vedmetadata == false then
			-- It was added in the new version
			pagetext = pagetext .. diffmessages.mde.added .. "\n\n"

			for i = 0, limit.flags-1 do
				if level.vedmetadata.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(
						diffmessages.flagnames.added,
						{i, level.vedmetadata.flaglabel[i]}
					) .. "\n"
				end
			end
		elseif level.vedmetadata == false then
			-- It was removed in the new version
			pagetext = pagetext .. diffmessages.mde.removed .. "\n\n"

			for i = 0, limit2.flags-1 do
				if level2.vedmetadata.flaglabel[i] ~= "" then
					pagetext = pagetext .. langkeys(
						diffmessages.flagnames.removed,
						{level2.vedmetadata.flaglabel[i], i}
					) .. "\n"
				end
			end
		else
			-- This one is simple, just cycle through the numbers!
			for i = 0, math.min(limit.flags, limit2.flags)-1 do
				if level2.vedmetadata.flaglabel[i] == ""
				and level.vedmetadata.flaglabel[i] ~= "" then
					-- Added name
					pagetext = pagetext .. langkeys(
						diffmessages.flagnames.added,
						{i, level.vedmetadata.flaglabel[i]}
					) .. "\n"
				elseif level2.vedmetadata.flaglabel[i] ~= ""
				and level.vedmetadata.flaglabel[i] == "" then
					-- Removed name
					pagetext = pagetext .. langkeys(
						diffmessages.flagnames.removed,
						{level2.vedmetadata.flaglabel[i], i}
					) .. "\n"
				elseif level2.vedmetadata.flaglabel[i] ~= level.vedmetadata.flaglabel[i] then
					-- Changed name
					pagetext = pagetext .. langkeys(
						diffmessages.flagnames.edited,
						{i, level2.vedmetadata.flaglabel[i], level.vedmetadata.flaglabel[i]}
					) .. "\n"
				end
			end
		end

		table.insert(differencesn, {subj = diffmessages.pages.flagnames, imgs = {}, cont = pagetext})

		-- L E V E L   N O T E S
		pagetext = diffmessages.pages.levelnotes .. "\\wh#\n\n"

		if level2.vedmetadata == false then
			-- It was added in the new version
			pagetext = pagetext .. diffmessages.mde.added .. "\n\n"

			for k,v in pairs(level.vedmetadata.notes) do
				pagetext = pagetext .. langkeys(diffmessages.levelnotes.added, {v.subj}) .. "\n"
			end
		elseif level.vedmetadata == false then
			-- It was removed in the new version
			pagetext = pagetext .. diffmessages.mde.removed .. "\n\n"

			for k,v in pairs(level2.vedmetadata.notes) do
				pagetext = pagetext .. langkeys(diffmessages.levelnotes.removed, {v.subj}) .. "\n"
			end
		else
			-- Were any notes added or changed?
			for k,v in pairs(level.vedmetadata.notes) do
				local found = false

				for k2, v2 in pairs(level2.vedmetadata.notes) do
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
			for k,v in pairs(level2.vedmetadata.notes) do
				local found = false

				for k2, v2 in pairs(level.vedmetadata.notes) do
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


	tostate(15, nil, {differencesn, false, font_level, false})
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

function triggernewlevel(width, height)
	if width == nil or height == nil then
		width, height = 5, 5
	end
	success, metadata, limit, roomdata, entitydata, level = createblanklevel(width, height)
	map_init()
	editingmap = "untitled\n"
	unloadvvvvvvmusics_level()
	if level_assets_loaded then
		load_vvvvvv_tilesets()
		loadfonts_custom()
		tile_batch_texture_needs_update = true
	end
	tostate(1)
end

function get_all_languages()
	loadlanginfo()
	local lang_filenames = love.filesystem.getDirectoryItems("lang")
	local lang_codes = {}

	for k,v in pairs(lang_filenames) do
		if v:sub(-4,-1) == ".lua" then
			table.insert(lang_codes, v:sub(1,-5))
		end
	end

	return lang_codes
end

function to_notepad()
	if level.vedmetadata == false then
		level.vedmetadata = createmde()
	end
	tostate(15, nil, {level.vedmetadata.notes, true, font_level, false})
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
				tinyfont:print(s_ge2ten, ox+4, oy+4)
			else
				font_8x8:print(s_ge2ten, ox+3, oy+3)
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

function unique_note_name(newname, oldname)
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
	theme:set_icon(toolimgicon[selectedtool])
end

function roomtext_extralines(text)
	local _, lines = font_ui:getWrap(text, 40*8)

	return lines - 1
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

function textshadow(text, x, y, font, cjk_align, sx, sy)
	font = font or font_ui
	sx = sx or 1
	sy = sy or sx
	y = font:y_align(y, cjk_align, sy)

	love.graphics.setColor(96,96,96,192)
	love.graphics.rectangle("fill", x, y, font:getWidth(text)*sx, font:getHeight()*sy)
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

do
	local mouselockhorizontalline, mouselockverticalline

	function maineditor_get_cursor()
		local cursorx = math.floor((getlockablemouseX()-screenoffset) / 16)
		local cursory = math.floor(getlockablemouseY() / 16)

		-- If we're holding [ and ] down, display the cursor inside the plus-shape created by those two lines
		if mouselockx ~= -1 and mouselocky ~= -1 then
			if math.floor((getlockablemouseX()-screenoffset) / 16) <= (love.mouse.getX()-screenoffset) / 16
			and (love.mouse.getX()-screenoffset) / 16 <= math.ceil((getlockablemouseX()-screenoffset) / 16) then
				mouselockhorizontalline = true
				mouselockverticalline = false
			end

			if math.floor(getlockablemouseY() / 16) <= love.mouse.getY() / 16
			and love.mouse.getY() / 16 <= math.ceil(getlockablemouseY() / 16) then
				mouselockhorizontalline = false
				mouselockverticalline = true
			end


			if mouselockhorizontalline then
				cursory = math.floor(love.mouse.getY() / 16)
			end

			if mouselockverticalline then
				cursorx = math.floor((love.mouse.getX()-screenoffset) / 16)
			end
		end

		return cursorx, cursory
	end
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
	local modtime = anythingbutnil0(getmodtime(fullpath))
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
	local prefix = ""
	if font_ui:is_rtl() then
		-- Left-to-right mark (U+200E), so the format doesn't get messed up by bidi
		prefix = U_200E
	end

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
			return prefix .. string.format("%02d-%02d-%d %s",
				timestamp[3], timestamp[2], timestamp[1],
				timestring
			)
		elseif s.new_dateformat == "MDY" then
			return prefix .. string.format("%02d/%02d/%d %s",
				timestamp[2], timestamp[3], timestamp[1],
				timestring
			)
		end
		-- YMD
		return prefix .. string.format("%d-%02d-%02d %s",
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
	return prefix .. os.date(datetimeformat, timestamp):lower()
end

function drawlink(link)
	if link:sub(1,7) == "file://" then
		if dirsep ~= "/" then
			link = link:sub(8):gsub("/", dirsep)
		else
			link = link:sub(8)
		end
	end

	love.graphics.setColor(255,255,255,192)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-10, font_ui:getWidth(link)+8, 10)
	love.graphics.setColor(0,0,0)
	font_ui:print(link, 4, love.graphics.getHeight()-9)
	love.graphics.setColor(255,255,255)
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
	if level == nil or level.vedmetadata == false then
		return nil
	end

	if level.vedmetadata.vars[key] == nil then
		return nil
	end

	return cast_level_var_type(level.vedmetadata.vars[key]["type"], level.vedmetadata.vars[key].value)
end

function get_all_level_vars()
	-- Get all vars as an array.

	if level == nil or level.vedmetadata == false then
		return {}
	end

	local vars = {}

	for k,v in pairs(level.vedmetadata.vars) do
		vars[k] = cast_level_var_type(v["type"], v.value)
	end

	return vars
end

function set_level_var(key, value)
	-- Returns false in case of invalid value type, true if valid.

	if level == nil then
		return false
	end

	if level.vedmetadata == false then
		level.vedmetadata = createmde()
	end

	local t, v = serialize_level_var_type(value)

	if t == nil then
		return false
	end

	level.vedmetadata.vars[key] = {
		["type"] = t,
		value = v
	}

	return true
end

function remove_level_var(key)
	if level == nil or level.vedmetadata == false then
		return
	end

	level.vedmetadata.vars[key] = nil
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

function explore_folder(folder)
	love.system.openURL("file://" .. folder)
end

function explore_lvl_dir()
	explore_folder(levelsfolder)
end

function search_levels_list(currentdir, prefix)
	-- Marks matching levels in the levels list as shown and vice versa
	if inputs.levelname == oldinput then
		return
	end
	oldinput = inputs.levelname

	for k,v in pairs(files[currentdir]) do
		files[currentdir][k].result_shown =
			(prefix .. v.name):lower():sub(1, (inputs.levelname):len()) == (inputs.levelname):lower()
	end
end

function displayable_filename(name)
	-- This function changes the filename to make it displayable - like removing newlines.
	-- The resulting filename may thus not be a valid filename anymore.
	return name:gsub("[\r\n]", "?")
end

function display_levels_list_string(string, x, y, k, len, scroll_k, scroll_pos, font)
	local stringtoolong = font:getWidth(string) > len*8
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
		font:print(string, x+len*8-math.floor(scroll_pos), y)
	else
		if stringtoolong then
			love.graphics.setScissor(x, sy, (len-1)*8, sh)
		end
		font:print(string, x, y)
	end
	if stringtoolong then
		love.graphics.setScissor(sx, sy, sw, sh)
		if scroll_k ~= k then
			font:print(arrow_right, x+(len-1)*8, y)
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
	-- We want 3 significant digits - aka: 3.22 MB, 33.2 MB or 333 MB
	-- (333.2 MB is too precise and an extra digit in 3.2 MB couldn't hurt)
	-- If you think 1024 should be used instead of 1000, you can go and
	-- verify whether 1.81 TB and 1862 GB are the same number or something :P

	if bytes == nil then
		bytes = 0
	end

	if bytes < 1000 then
		return langkeys(L.BYTES, {bytes})
	end

	local n_prefixes = 4 -- k, M, G, T

	-- n//3 is the unit (0 => kB, 1 => MB, 2 => GB, etc)
	-- n%3 gives us the number of pre-decimal digits in this unit:
	-- 0 => 3.22, 1 => 33.2, 2 => 333
	-- If we run out of prefixes, we just max out on the last prefix with
	-- no decimals mode (showing 1000 TB instead of 1 PB is fine)
	local n = 0
	while bytes >= 9995 * 10^n and (n+1)/3 < n_prefixes do
		n = n + 1
	end

	-- Round off appropriately - then make it 3 digits (still integer)
	local digits = bytes + 5*10^n
	digits = math.floor(digits / 10^(n+1))

	local unit = "$1 ?B"
	if n < 3 then
		unit = L.KILOBYTES
	elseif n < 6 then
		unit = L.MEGABYTES
	elseif n < 9 then
		unit = L.GIGABYTES
	elseif n < 12 then
		unit = L.TERABYTES
	end

	if n % 3 == 0 then
		-- 3.22
		return langkeys(unit, {string.format("%d%s%02d", digits/100, L.DECIMAL_SEP, digits%100)})
	elseif n % 3 == 1 then
		-- 33.2
		return langkeys(unit, {string.format("%d%s%d", digits/10, L.DECIMAL_SEP, digits%10)})
	else
		-- 333
		return langkeys(unit, {string.format("%d", digits)})
	end
end

function sort_files(files, sort_by, sort_asc)
	-- Valid values for sort_by:
	--  * "name" - filename
	--  * "lastmodified" - last modified, if equal: by filename
	--  * "filesize" - file size, if equal: by filename
	--  * nil - do not sort

	if sort_by == nil then
		return
	end
	if sort_asc == nil then
		sort_asc = true
	end

	-- In place
	table.sort(files,
		function(a,b)
			-- Always sort directories above files
			if a.isdir and not b.isdir then return true end
			if b.isdir and not a.isdir then return false end

			local result = nil
			if sort_by == "lastmodified" then
				if a.lastmodified_sort < b.lastmodified_sort then
					result = true
				elseif a.lastmodified_sort > b.lastmodified_sort then
					result = false
				end
			elseif sort_by == "filesize" then
				if a.filesize < b.filesize then
					result = true
				elseif a.filesize > b.filesize then
					result = false
				end
			end

			if result ~= nil then
				if not sort_asc then
					return not result
				else
					return result
				end
			end

			-- We have a nil result either because two files compared equal (in timestamp/size)
			-- or because we're not sorting by timestamp/size in the first place.
			-- So sort by name.
			-- Interesting case is that lua does call our function to compare files to themselves.
			-- In that case - always false - they're expecting behavior of <, and "not <" is >=

			if sort_asc then
				return a.name_sort < b.name_sort
			else
				return a.name_sort > b.name_sort
			end
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

	loadtinyfont()
end

function exitdisplayoptions()
	if nonintscale then
		newinputsys.close("scale")
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
		local hotkey_w = tinyfont:getWidth(hotkey)
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
		tinyfont:print(hotkey, x+2, y+2)
		if dialog_obj ~= nil then
			dialog_obj:setColor(255,255,255,255)
		else
			love.graphics.setColor(255,255,255)
		end
	end
end

function assets_musicsavedialog()
	local default_filename = musiceditorfile
	if default_filename == "" then
		default_filename = "vvvvvvmusic.vvv"
	end
	dialog.create(
		"",
		DBS.SAVECANCEL,
		dialog.callback.savevvvvvvmusic,
		L.SAVEMUSICNAME,
		dialog.form.savevvvvvvmusic_make(musiceditorfolder, default_filename)
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
		dialog.form.files_make(musiceditorfolder, "", ".vvv", true, 18)
	)
end

function assets_musicreload()
	loadvvvvvvmusic(musicplayerfile)
	setgenerictimer(1, .25)
end

function assets_graphicsloaddialog()
	dialog.create(
		"",
		DBS.LOADCANCEL,
		dialog.callback.openimage,
		L.LOADIMAGE,
		dialog.form.files_make(assetsmenu_graphicsfolder, "", ".png", true, 18)
	)
end

function assets_graphicsreload()
	assets_openimage(imageviewer_filepath, imageviewer_filename, true)
	setgenerictimer(1, .25)
end

function assets_create_or_explore_folder()
	if assetsmenu_unsaved_level then
		dialog.create(L.UNSAVED_LEVEL_ASSETS_FOLDER)
		return
	end

	if directory_exists(assetsmenu_vvvvvvfolder) then
		explore_folder(assetsmenu_vvvvvvfolder)
		assetsmenu_vvvvvvfolder_exists = true
	else
		local message
		if assetsmenu_show_level_assets then
			message = langkeys(L.CREATE_ASSETS_FOLDER, {"levels" .. dirsep .. editingmap})
		else
			message = L.CREATE_VVVVVV_FOLDER
		end
		dialog.create(
			message,
			DBS.YESNO,
			dialog.callback.create_assets_folder,
			nil,
			dialog.form.hidden_make({folder=assetsmenu_vvvvvvfolder})
		)
		assetsmenu_vvvvvvfolder_exists = false
	end
end

function assets_reload_pressed()
	user_reload_tilesets()
	if assetsmenu_show_level_assets then
		unloadvvvvvvmusics_level()
	else
		unloadvvvvvvmusics()
	end
	tostate(oldstate, true)
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
			local name = (v.path .. k2):gsub("/", ".")
			if package.loaded[name] then
				package.loaded[name] = false
			end
		end
	end
end

function load_ui(ui_name, ui_path)
	if ui_path == nil then
		ui_path = "uis/" .. ui_name .. "/"
	end
	local ui = {name = ui_name, path = ui_path}

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
	load_ui_part("mousepressed")
	load_ui_part("mousereleased")
	load_ui_part("wheelmoved")

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
	uis[35] = load_ui("vvvvvvsetupoptions")
	uis[36] = load_ui("textboxcolors")
	uis[37] = load_ui("theme")
	uis[38] = load_ui("specialroomnames")
	-- Don't forget states.txt

	for k,v in pairs(plugin_uis) do
		uis[v.state_number] = load_ui(v.ui_name, v.ui_path)
	end
end

function show_notification(text)
	notification_text = text

	setgenerictimer(3, 5)
end

function window_active()
	return love.window.hasFocus() and love.window.isVisible()
end

function assets_openimage(filepath, filename, is_reload)
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
	imageviewer_w, imageviewer_h = imageviewer_image_color:getDimensions()
	imageviewer_moving = false
	imageviewer_moved_from_x, imageviewer_moved_from_y = 0, 0
	imageviewer_moved_from_mx, imageviewer_moved_from_my = 0, 0

	-- Some initialization we only need to do if the image actually changed!
	if not is_reload then
		imageviewer_filepath, imageviewer_filename = filepath, filename

		imageviewer_x, imageviewer_y, imageviewer_s = 0, 0, 1
		imageviewer_grid, imageviewer_showwhite = 0, false

		-- Guess the grid setting
		if filename:sub(1,10) == "entcolours"
		or filename:sub(1,4) == "font"
		or filename:sub(1,5) == "tiles" then
			imageviewer_grid = 8
		elseif filename:sub(1,7) == "sprites"
		or filename:sub(1,11) == "flipsprites" then
			imageviewer_grid = 32
		elseif filename:sub(1,12) == "vtools_tiles" then
			imageviewer_grid = 1
		end
	end
	fix_imageviewer_position()
end

function isclear(key)
	-- On macOS, Numlock turns into the Clear key and behaves differently
	return key == "numlock" and love.system.getOS() == "OS X"
end

function tooltip_box_dimensions(title, explanation, icon)
	local box_w = math.max(
		256,
		font_ui:getWidth(title) + 16
	)
	local icon_w, icon_h = 0, 0
	if icon ~= nil then
		icon_w, icon_h = theme:get_width(icon)+8, theme:get_height(icon)
	end
	local expl_w = box_w - 16 - icon_w
	local _, lines = font_ui:getWrap(explanation, expl_w)
	local box_h = 32+math.max(
		icon_h,
		lines*font_ui:getHeight()
	)

	if lines == 0 then
		box_h = box_h - 8
	end

	return box_w, box_h
end

function tooltip_box_draw(title, explanation, icon, box_x, box_y, box_w, box_h, title_r, title_g, title_b)
	local icon_w = 0
	if icon ~= nil then
		icon_w = theme:get_width(icon)+8
	end
	local expl_w = box_w - 16 - icon_w

	love.graphics.setColor(40,40,40,192)
	love.graphics.rectangle("fill", box_x, box_y, box_w, box_h)
	love.graphics.setColor(title_r, title_g, title_b, 255)
	font_ui:print(title, box_x+8, box_y+8)
	if icon ~= nil then
		theme:draw(icon, box_x+8, box_y+24)
	end
	love.graphics.setColor(255,255,255,255)
	font_ui:printf(
		explanation,
		box_x + 8 + icon_w,
		box_y + 24,
		expl_w,
		"left"
	)
end

function draw_script_warn_light(id, x, y, active)
	local light = script_warn_lights[id]
	local active_hovering = false

	if active then
		active_hovering = mouseon(x, y, theme:get_dimensions(light.img))
		local red
		if active_hovering or love.timer.getTime() % 1 < .5 then
			red = 255
		else
			red = 224
		end
		love.graphics.setColor(red,12,12,255)
	else
		love.graphics.setColor(12,12,12,255)
	end

	theme:draw(light.img, x, y)

	if active_hovering then
		local box_w, box_h = tooltip_box_dimensions(L[light.lang_title], L[light.lang_expl], light.img_hq)
		local box_x, box_y = x+theme:get_width(light.img)-box_w, y+theme:get_height(light.img)+1

		tooltip_box_draw(
			L[light.lang_title],
			L[light.lang_expl],
			light.img_hq,
			box_x, box_y,
			box_w, box_h,
			255,12,12
		)
	end
end

function canvas_size(w, h)
	if love.graphics.isSupported("npot") then
		-- You're running a system that's not, what, 15 years old?
		return w, h
	end

	-- I have access to a cardboard box that doesn't have NPOT support.
	return math.pow(2, math.ceil(math.log(w)/math.log(2))), math.pow(2, math.ceil(math.log(h)/math.log(2)))
end

function print_tile_number(t, x, y)
	-- Print a tile number in the "fading" style.
	-- Not used for showing the whole room - see tilenumberbatch.lua

	local st = tostring(t)

	if st:len() > 8 then
		st = ("9"):rep(8)
	end

	for i = 0, st:len()-1 do
		local print_y = math.floor(i/4)
		local col = 255 - 32*i + 32*print_y

		love.graphics.setColor(col, col, col)

		tinyfont:shadowprint(
			st:sub(i+1,i+1),
			x+(i%4)*4, y+print_y*7
		)
	end
	love.graphics.setColor(255,255,255)
end

function reset_special_cursor()
	if special_cursor then
		love.mouse.setCursor()
		special_cursor = false
	end
end

function draw_tile_line(x1, x2, y1, y2, callback)
	-- DDA to draw a line from (x1, y1) to (x2, y2).
	-- callback is called for each pixel.

	local dx = x2 - x1
	local dy = y2 - y1
	local steps = math.max(math.abs(dx), math.abs(dy))

	if steps == 0 then
		callback(x1, y1)
		return
	end

	for i = 0, steps do
		local x = math.floor(x1 + (i*dx)/steps)
		local y = math.floor(y1 + (i*dy)/steps)
		callback(x, y)
	end
end

function get_desc3_field_type()
	local show_desc3 = font_level:getHeight() <= 10
	if show_desc3 then
		return DF.TEXT
	end
	return DF.HIDDEN
end

hook("func")
