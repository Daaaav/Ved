--[[

States:
-3	Just blackness
-2	tostate 6
-1	(removed) Display error (expected: errormsg)
0	Temp main menu (enter state)
1	The editor (will expect things to have been loaded!)
2	(removed) Syntax highlighting test
3	Scripting editor
4	(removed) Some XML testing
5	Filesystem info
6	Simple listing of all files in the levels folder, and load a level from here
7	Display all sprites from sprites.png where you can get the number of the sprite you're hovering over
8	(removed) Just save by going to this state and typing in a name
9	Dialog test, and right click menu test
10	List of scripts, and enter one to load
11	Search
12	Map
13	Options screen
14	Sort of entity picker proto
15	Help
16	(never used, removed) Scroll bar test
17	(never used, removed) folderopendialog utility
18	Show main editor undo/redo stacks
19	Flags list
20	Resizable box test
21	Display overlapping entities (may be a visible function later) (maybe doesn't work properly)
22	(removed) Load a script file in the 3DS format (lines separated by dollars)
23	(removed) Load a script file NOT in the 3DS format (lines separated by \r\n or \n)
24	(removed) Simple plugins list (already not used)
25	Syntax highlighting color settings
26	Font test
27	Display/Scale settings
28	Level stats
29	Plural forms test
30	Assets
31	Assets - music/sounds
32	Assets - graphics
33	Language screen
34	New-input-system-that-is-not-2-or-3-vars-concated-together test

Debug keys:
F12: change state
F11: dump all variables in console
' (in editor): display all tilesets and colors in the console
\ (in editor): tileset creator/compiler [NOW CHANGED TO CTRL+\]
/ (in editor): instead of displaying entities as themselves, display them as an E-block
PgDn: change FPS cap

]]

function love.load()
	hook("love_load_start")

	ved_require("loadconfig")

	-- TODO TEMPORARY BEFORE 1.8.2 IS RELEASED
	TEMP_slashfrommain = false

	local loaded_filefunc
	if love.system.getOS() == "OS X" then
		-- Cmd
		ctrl = "gui"
		modifier = "alt"
		dirsep = "/"
		macscrolling = true
		wgetavailable = false
		newline = "\n"
		hook("love_load_mac")
		loaded_filefunc = "linmac"
		if not love.filesystem.exists("available_libs") then
			love.filesystem.createDirectory("available_libs")
		end
		if not love.filesystem.exists("available_libs/vedlib_filefunc_mac02.so") then
			-- Too bad there's no love.filesystem.copy()
			love.filesystem.write("available_libs/vedlib_filefunc_mac02.so", love.filesystem.read("libs/vedlib_filefunc_mac02.so"))
		end
		playtesting_available = true
	elseif love.system.getOS() == "Windows" then
		-- Ctrl
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "\\"
		macscrolling = false
		wgetavailable = false
		newline = "\r\n"
		hook("love_load_win")
		loaded_filefunc = "win"
		playtesting_available = true
	elseif love.system.getOS() == "Linux" then
		-- Ctrl
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "/"
		macscrolling = false
		wgetavailable = true
		newline = "\n"
		hook("love_load_lin")
		if not love.filesystem.exists("available_libs") then
			love.filesystem.createDirectory("available_libs")
		end
		local vedlib_filefunc_available = false
		if love.filesystem.exists("available_libs/vedlib_filefunc_lin02.so") then
			vedlib_filefunc_available = true
		else
			-- Too bad there's no love.filesystem.copy()
			love.filesystem.write("available_libs/vedlib_filefunc_linmac.c", love.filesystem.read("libs/vedlib_filefunc_linmac.c"))
			if os.execute("gcc -shared -fPIC -o '"
				.. love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_lin02.so' '"
				.. love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_linmac.c'"
			) == 0 then
				vedlib_filefunc_available = true
			end
		end
		if vedlib_filefunc_available then
			loaded_filefunc = "linmac"
		else
			loaded_filefunc = "lin_fallback"
		end
		playtesting_available = true
	else
		-- This OS is unknown, so I suppose we will have to fall back on functions in love.filesystem.
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "/"
		macscrolling = false
		wgetavailable = false
		newline = "\n"
		hook("love_load_luv")
		loaded_filefunc = "luv"
		playtesting_available = false
	end
	lctrl = "l" .. ctrl
	rctrl = "r" .. ctrl
	ved_require("filefunc_" .. loaded_filefunc)
	setvvvvvvpaths()

	ved_require("imagefont")

	loadfonts()
	loadlanginfo()
	loadlanguage()
	loadtinynumbersfont()

	ved_require("const")
	ved_require("func")
	ved_require("roomfunc")
	ved_require("scriptfunc")
	ved_require("searchfunc")
	ved_require("helpfunc")
	ved_require("vvvvvvxml")
	ved_require("dialog")
	ved_require("rightclickmenu")
	ved_require("scrollbar")
	ved_require("coordsdialog")
	ved_require("vvvvvv_textbox")
	ved_require("resizablebox")
	ved_require("ui_elements")
	ved_require("drawmaineditor")
	ved_require("drawscripteditor")
	ved_require("drawlevelslist")
	ved_require("drawsearch")
	ved_require("drawhelp")
	ved_require("slider")
	ved_require("mapfunc")
	ved_require("music")
	ved_require("vvvvvvfunc")
	ved_require("playtesting")

	utf8 = require("utf8lib_wrapper")
	ved_require("input")

	dodisplaysettings()

	cons("love.load() reached")

	math.randomseed(os.time())

	state = -2; oldstate = "none"
	input = ""; takinginput = false
	__ = "_"
	input_r = ""
	cursorflashtime = 0
	no_more_quit_dialog = false

	mousepressed = false -- for some things
	mousepressed_custombrush = false
	mousepressed_flag = false
	mousepressed_flag_x = -1
	mousepressed_flag_y = -1
	mousepressed_flag_num = -1
	mousepressed_flag_name = ""
	mousereleased_flag = false
	middlescroll_x, middlescroll_y = -1, -1
	middlescroll_falling = false
	middlescroll_shatter = false
	middlescroll_shatter_pieces = {}
	middlescroll_rolling = 0
	middlescroll_rolling_x = -1
	middlescroll_t, middlescroll_v = 0, 0

	v6_frametimer = 0
	conveyortimer = 0
	conveyorleftcycle = 1
	conveyorrightcycle = 0

	returnpressed = false -- also for some things

	temporaryroomnametimer = 0
	generictimer = 0
	generictimer_mode = 0 -- 0 for nothing, 1 for feedback in copy script/note button, 2 for map flashing, 3 for notification

	notification_text = ""

	inputcopiedtimer = 0
	inputdoubleclicktimer = 0
	inputnumclicks = 0

	focusregainedtimer = 0
	skipnextkeys = {}
	skipnextmouses = {}

	limitglow = 0
	limitglow_enabled = false

	scriptsearchterm = ""
	helpsearchterm = ""

	sp_t = 0
	sp_tim = 0
	sp_go = true
	sp_got = 0

	nodialog = true

	vvvvvv_textboxes = {}

	tilesets = {}

	-- Load a couple of images
	cursorimg = {}
	cursorimg[0] = love.graphics.newImage("cursor/cursor.png")
	cursorimg[1] = love.graphics.newImage("cursor/cursor1.png")
	cursorimg[2] = love.graphics.newImage("cursor/cursor2.png")
	cursorimg[3] = love.graphics.newImage("cursor/cursor3.png")
	cursorimg[4] = love.graphics.newImage("cursor/cursor4.png")
	cursorimg[5] = love.graphics.newImage("cursor/entity.png")
	cursorimg[6] = love.graphics.newImage("cursor/specialentity.png")
	cursorimg[8] = love.graphics.newImage("cursor/cursor8.png")

	local curcol = (love.system.getOS() == "OS X" and "b" or "w")
	cursorimg[11] = love.graphics.newImage("cursor/resizev_" .. curcol .. ".png")
	cursorimg[12] = love.graphics.newImage("cursor/resizeh_" .. curcol .. ".png")

	cursorimg[20] = love.graphics.newImage("cursor/selectedtile.png")
	cursorimg[21] = love.graphics.newImage("cursor/selectedtile8.png")

	cursorobjs = {}
	if not love_version_meets(10) or love.mouse.hasCursor() then
		cursorobjs[11] = love.mouse.getSystemCursor("sizens")
		cursorobjs[12] = love.mouse.getSystemCursor("sizewe")
		cursorobjs[16] = love.mouse.getSystemCursor("sizenwse")
		cursorobjs[17] = love.mouse.getSystemCursor("sizenesw")
		cursorobjs[19] = love.mouse.getSystemCursor("sizeall")

		hand_cursor = love.mouse.getSystemCursor("hand")
		forbidden_cursor = love.mouse.getSystemCursor("no")
		text_cursor = love.mouse.getSystemCursor("ibeam")
	end
	special_cursor = false

	scriptboximg = {}
	scriptboximg[1] = love.graphics.newImage("cursor/script1.png")
	scriptboximg[2] = love.graphics.newImage("cursor/script2.png")
	scriptboximg[3] = love.graphics.newImage("cursor/script3.png")
	scriptboximg[4] = love.graphics.newImage("cursor/script4.png")
	scriptboximg[6] = love.graphics.newImage("cursor/script6.png")
	scriptboximg[7] = love.graphics.newImage("cursor/script7.png")
	scriptboximg[8] = love.graphics.newImage("cursor/script8.png")
	scriptboximg[9] = love.graphics.newImage("cursor/script9.png")


	selectedtoolborder = love.graphics.newImage("images/selectedtool.png")
	unselectedtoolborder = love.graphics.newImage("images/unselectedtool.png")

	savebtn_hq = love.graphics.newImage("images/save_hq.png")
	loadbtn = love.graphics.newImage("images/load.png")
	loadbtn_hq = love.graphics.newImage("images/load_hq.png")
	newbtn_hq = love.graphics.newImage("images/new_hq.png")
	helpbtn = love.graphics.newImage("images/help.png")
	retbtn_hq = love.graphics.newImage("images/ret_hq.png")
	infobtn = love.graphics.newImage("images/info.png")
	infograybtn = love.graphics.newImage("images/infogray.png")

	undobtn = love.graphics.newImage("images/undo.png")
	redobtn = love.graphics.newImage("images/redo.png")
	cutbtn = love.graphics.newImage("images/cut.png")
	copybtn = love.graphics.newImage("images/copy.png")
	pastebtn = love.graphics.newImage("images/paste.png")
	refreshbtn = love.graphics.newImage("images/refresh.png")

	playbtn_hq = love.graphics.newImage("images/play_hq.png")
	playgraybtn_hq = love.graphics.newImage("images/playgray_hq.png")
	playstopbtn_hq = love.graphics.newImage("images/playstop_hq.png")

	eraseron = love.graphics.newImage("images/eraseron.png")
	eraseroff = love.graphics.newImage("images/eraseroff.png")
	eraser = love.graphics.newImage("images/eraser.png")

	checkon = love.graphics.newImage("images/checkon.png")
	checkoff = love.graphics.newImage("images/checkoff.png")
	checkon_hq = love.graphics.newImage("images/checkon_hq.png")
	checkoff_hq = love.graphics.newImage("images/checkoff_hq.png")

	radioon = love.graphics.newImage("images/radioon.png")
	radiooff = love.graphics.newImage("images/radiooff.png")
	radioon_hq = love.graphics.newImage("images/radioon_hq.png")
	radiooff_hq = love.graphics.newImage("images/radiooff_hq.png")

	menupijltje = love.graphics.newImage("images/menupijltje.png")
	colorsel = love.graphics.newImage("images/colorsel.png")

	smallfolder = love.graphics.newImage("images/smallfolder.png")
	smalllevel = love.graphics.newImage("images/smalllevel.png")
	smallunknown = love.graphics.newImage("images/smallunknown.png")

	asset_pppppp = love.graphics.newImage("images/asset_pppppp.png")
	asset_mmmmmm = love.graphics.newImage("images/asset_mmmmmm.png")
	asset_musiceditor = love.graphics.newImage("images/asset_musiceditor.png")
	asset_sounds = love.graphics.newImage("images/asset_sounds.png")
	asset_graphics = love.graphics.newImage("images/asset_graphics.png")

	sound_play = love.graphics.newImage("images/sound_play.png")
	sound_play_current = love.graphics.newImage("images/sound_play_current.png")
	sound_pause = love.graphics.newImage("images/sound_pause.png")
	sound_stop = love.graphics.newImage("images/sound_stop.png")
	sound_rewind = love.graphics.newImage("images/sound_rewind.png")

	folder_parent = love.graphics.newImage("images/folder_parent.png")

	bggrid = love.graphics.newImage("images/bggrid.png")

	solidimg = love.graphics.newImage("images/solid.png")
	solidhalfimg = love.graphics.newImage("images/solidhalf.png")
	covered_full = love.graphics.newImage("images/covered_full.png")
	covered_80x60 = love.graphics.newImage("images/covered_80x60.png")

	snd_break = love.audio.newSource("sounds/break.ogg", "static")
	snd_roll = love.audio.newSource("sounds/roll.ogg", "static")

	scaleimgs = {
		[false] = love.graphics.newImage("images/scale_normal.png"),
		[true] = love.graphics.newImage("images/scale_small.png")
	}
	scaleimgs[false]:setFilter("linear", "nearest")
	scaleimgs[true]:setFilter("linear", "nearest")

	toolimg = {}
	toolimgicon = {}
	for t = 1, 20 do
		toolimg[t] = love.graphics.newImage("tools/" .. t .. ".png")
		toolimgicon[t] = love.image.newImageData("tools2/on/" .. t .. ".png")
	end

	-- But we also have subtools!
	subtoolimgs = {}
	subtoolimgs[1] = {st("1_1"), st("1_2"), st("1_3"), st("1_4"), st("1_5"), st("1_6"), st("1_7"), st("1_8"), st("1_9")}
	subtoolimgs[2] = {st("2_1"), st("2_2"), st("2_3"), st("2_4"), st("2_5"), st("2_6"), st("2_7"), st("2_8"), st("1_9")}
	subtoolimgs[3] = {st("3_1"), st("3_2"), st("3_3"), st("3_4")}
	subtoolimgs[4] = {}
	subtoolimgs[5] = {st("5_1"), st("5_2")}
	subtoolimgs[6] = {}
	subtoolimgs[7] = {st("7_1"), st("7_2"), st("7_3"), st("7_4")}
	subtoolimgs[8] = {st("8_2"), st("8_1"), st("8_3"), st("8_4")}
	subtoolimgs[9] = {st("9_2"), st("9_1"), st("9_3"), st("9_4")}
	subtoolimgs[10] = {st("10_1"), st("10_2")}
	subtoolimgs[11] = {}
	subtoolimgs[12] = {}
	subtoolimgs[13] = {}
	subtoolimgs[14] = {st("14_1"), st("14_2")}
	subtoolimgs[15] = {}
	subtoolimgs[16] = {st("16_1"), st("16_2"), st("16_3"), st("16_4"), st("16_5"), st("16_6"), st("16_7")}
	subtoolimgs[17] = {st("17_1"), st("17_2")}
	subtoolimgs[18] = {}
	subtoolimgs[19] = {st("19_1"), st("19_2"), st("19_3"), st("19_4"), st("19_5")}
	subtoolimgs[20] = {}

	scrollup = love.graphics.newImage("images/scrollup.png")
	scrolldn = love.graphics.newImage("images/scrolldn.png")

	platformimg = love.graphics.newImage("images/platform.png")
	platformpart =
		{
		love.graphics.newQuad(0, 0, 8, 8, 24, 8),
		love.graphics.newQuad(8, 0, 8, 8, 24, 8),
		love.graphics.newQuad(16, 0, 8, 8, 24, 8)
		}

	-- The help has images too, but they shouldn't be loaded repetitively!
	helpimages = {}

	savedwindowtitle = ""

	loaduis()

	-- eeeeeeeeee
	love.keyboard.setKeyRepeat(true)
	thingk()

	if loaded_filefunc == "luv" then
		dialog.create(
			langkeys(L.OSNOTRECOGNIZED,
				{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
			)
		)
	end

	secondlevel = false
	levels_refresh = 0 -- refresh counter, so we know when metadata requests are outdated

	-- Load the levels folder and tilesets
	loadlevelsfolder()
	loadtilesets()

	-- Music! Note that we're not yet loading the music in memory here.
	initvvvvvvmusic()
	musiceditorfile = ""
	musiceditorfile_forcevvvvvvfolder = false

	-- Reuse the subtool names from walls for background, and for moving platforms and enemies
	subtoolnames[2] = subtoolnames[1]
	subtoolnames[9] = subtoolnames[8]

	if not love.filesystem.exists("maps") then
		love.filesystem.createDirectory("maps")
	end
	if not love.filesystem.exists("overwrite_backups") then
		love.filesystem.createDirectory("overwrite_backups")
	end

	load_updatecheck(false)

	loadallmetadatathread = love.thread.newThread("loadallmetadata.lua")
	loadallmetadatathread:start(dirsep, levelsfolder, loaded_filefunc, love.system.getOS(), L)

	allmetadata_inchannel = love.thread.getChannel("allmetadata_in")
	allmetadata_outchannel = love.thread.getChannel("allmetadata_out")

	playtestthread_inchannel = love.thread.getChannel("playtestthread_in")
	playtestthread_outchannel = love.thread.getChannel("playtestthread_out")

	next_frame_time = love.timer.getTime()

	-- If I add layers, I should probably increase the max number of sprites and just add them after each other.
	-- A room with one layer would be 1200 tiles as usual, but a room with two layers would be 2400, etc.
	tile_batch = love.graphics.newSpriteBatch(tilesets["tiles.png"]["img"], 1200, "dynamic")
	tile_batch_needs_update = false
	tile_batch_texture_needs_update = false
	tile_batch_tileset = 1
	tile_batch_vcecustomtileset = 0
	tile_batch_zoomscale2 = 1
	tile_batch_tiles = {}
	for i = 1, 1200 do
		tile_batch_tiles[i] = 0
	end

	if not settings_ok then
		-- If the settings file is broken, good chance we don't know what the language setting was.
		dialog.create("The settings file has an error and can not be loaded.\n\nPress OK to proceed with the default settings.\n\n\n\n\nError: " .. anythingbutnil(settings_err), DBS.OK,
			function()
				saveconfig()
				settings_ok = true
			end
		)
	end

	hook("love_load_end")
end

function love.draw()
	if s.pausedrawunfocused and not window_active() then
		limit_draw_fps()
		return
	end

	if s.pscale ~= 1 then
		love.graphics.push()
		love.graphics.scale(s.pscale,s.pscale)
	end

	if state == -3 then
		-- Do-nothing state
	elseif state == -2 then
		-- Init state - see love.update()
	elseif state == -1 then
	elseif state == 0 then
	elseif state == 1 then
		drawmaineditor()

		if gotostateonnextdraw == 6 then
			gotostateonnextdraw = nil
			tostate(6)
		end
	elseif state == 2 then
	elseif state == 3 then
	elseif state == 4 then
	elseif state == 5 then
	elseif state == 6 then
	elseif state == 7 then
	elseif state == 8 then
	elseif state == 9 then
	elseif state == 10 then
	elseif state == 11 then
	elseif state == 12 then
	elseif state == 13 then
	elseif state == 14 then
	elseif state == 15 then
	elseif state == 16 then

	elseif state == 17 then

	elseif state == 18 then
	elseif state == 19 then
	elseif state == 20 then
	elseif state == 21 then
	elseif state == 22 then
	elseif state == 23 then
	elseif state == 24 then
	elseif state == 25 then
	elseif state == 26 then
	elseif state == 27 then
	elseif state == 28 then
	elseif state == 29 then
	elseif state == 30 then
	elseif state == 31 then
	elseif state == 32 then
	elseif state == 33 then
	elseif state == 34 then
		newinputsys.create(INPUT.ONELINE, "inputtest", "This is the §¤ caret test", 5)
		newinputsys.create(INPUT.MULTILINE, "inputtest2", {"This is line 1", "The second § ¤ line, this is", "Third line"}, 2, 2)
		newinputsys.create(INPUT.MULTILINE, "inputtest3", {"I'm double-scaled!!!", "Wowzers"})
		newinputsys.create(INPUT.MULTILINE, "inputtest4", {"I'mm streetttcheeeddd", "ooouuuuttttt"})
		newinputsys.create(INPUT.ONELINE, "inputtest5", "This is a VVVVVV script line")
		newinputsys.setnewlinechars("inputtest5", "|") -- Don't care about PleaseDo3DSHandlingThanks in a test state
		newinputsys.create(INPUT.MULTILINE, "inputtest6", {"These are VVVVVV script lines", "The one after this one is numbers-only"})
		newinputsys.setnewlinechars("inputtest6", "|")
		newinputsys.create(INPUT.ONELINE, "inputtest7", "0123456789")
		newinputsys.whitelist("inputtest7", "%d")
		newinputsys.create(INPUT.MULTILINE, "inputtest8", {"I'm testing blacklisting Unicode", "even though really you should whitelist ASCII", "because it's simpler"})
		newinputsys.blacklist("inputtest8", "[^\x01-\x7F]")
		newinputsys.create(INPUT.MULTILINE, "inputtest9", {"This input has a line height of 10 pixels", "Instead of 8 pixels like normal", "so things are spaced out more"})

		newinputsys.print("inputtest", 100, 0)
		newinputsys.print("inputtest2", 100, 50)
		newinputsys.print("inputtest3", 100, 100, 2)
		newinputsys.print("inputtest4", 100, 150, 1, 2)
		newinputsys.print("inputtest5", 100, 200)
		newinputsys.print("inputtest6", 100, 250)
		newinputsys.print("inputtest7", 100, 300)
		newinputsys.print("inputtest8", 100, 350)
		newinputsys.print("inputtest9", 100, 400, nil, nil, 10)

		local youhaveselected = "You have selected: "
		local tmp = newinputsys.getseltext(newinputsys.input_ids[#newinputsys.nth_input])
		if tmp ~= nil then
			ved_print(youhaveselected .. tmp, 580, 112)
		end
	else
		hook("love_draw_state")
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].draw ~= nil then
		-- A UI can have its own dedicated drawing function and not use elements, sure.
		uis[state].draw(dt)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		-- Draw every element in this state's master element "container".
		-- This master container doesn't define positions,
		-- and just gives the window width and height as information.
		local w, h = love.graphics.getDimensions()
		for k,v in pairs(uis[state].elements) do
			v:draw(0, 0, w, h)
		end

		-- Debug view
		if allowdebug and love.keyboard.isDown("f8") then
			love.graphics.setColor(0,255,0)
			local function drawcoords(el)
				if el.px == nil or el.py == nil then
					return
				end

				local w, h = el.pw, el.ph
				if w == nil then w = love.graphics.getWidth() end
				if h == nil then h = love.graphics.getHeight() end

				love.graphics.line(el.px, el.py, el.px+w, el.py)
				love.graphics.line(el.px, el.py, el.px, el.py+h)
			end
			for k,v in pairs(uis[state].elements) do
				drawcoords(v)
				if v.recurse ~= nil then
					v:recurse("debug_drawcoords", drawcoords)
				end
			end
			love.graphics.setColor(255,255,255)
		end
	end

	if not RCMabovedialog then
		rightclickmenu.draw()
	end

	dialog.draw()

	if RCMabovedialog then
		rightclickmenu.draw()
	end

	if generictimer_mode == 3 and generictimer > 0 then
		local width, lines = font8:getWrap(notification_text, 80*8)

		-- thelines is a number in 0.9.x, and a table/sequence in 0.10.x and higher
		if type(lines) == "table" then
			lines = #lines
		end

		local boxy = love.graphics.getHeight()-16-lines*8
		love.graphics.setColor(128,128,128,192)
		love.graphics.rectangle("fill", 8, boxy, width+16, lines*8+8)
		love.graphics.setColor(0,0,0,255)
		ved_printf(notification_text, 16, boxy+4, 80*8, "left")
	end

	if love.keyboard.isDown("f9") and state_hotkeys[state] ~= nil then
		--ved_print("HOTKEYS MENU", love.mouse.getX(), love.mouse.getY())
	end

	-- Middle click cursor
	if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		v6_setcol(3)
		drawentitysprite(22, middlescroll_x-16, middlescroll_y-16, 0, false)
	end

	if middlescroll_rolling ~= 0 then
		love.graphics.setColor(130+love.math.random(0,70), 110+love.math.random(0,70), 170+love.math.random(0,70))
		local furtherfall = 0
		if middlescroll_rolling_x < 0 then
			furtherfall = -middlescroll_rolling_x/2
		elseif middlescroll_rolling_x > love.graphics.getWidth() then
			furtherfall = middlescroll_rolling_x - love.graphics.getWidth()
		end
		love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][22], middlescroll_rolling_x, love.graphics.getHeight()-16+furtherfall/1.2, 0, 2, 2, 8, 8)
	end

	if middlescroll_shatter then
		for k,v in pairs(middlescroll_shatter_pieces) do
			love.graphics.setColor(130+love.math.random(0,70), 110+love.math.random(0,70), 170+love.math.random(0,70))
			--love.graphics.rectangle("fill", v.x, v.y, 4, 4)
			love.graphics.setScissor(v.x, v.y, 4, 4)
			drawentitysprite(22, v.x-v.ox, v.y-v.oy, 0, false)
		end
		love.graphics.setScissor()
	end

	love.graphics.setColor(255,255,255,255)

	if allowdebug and s.fpslimit_ix ~= 4 then
		love.graphics.setColor(255,0,0)
		if s.fpslimit_ix == 3 then
			ved_print("120", love.graphics.getWidth()-48, love.graphics.getHeight()-16, 2)
		elseif s.fpslimit_ix == 2 then
			ved_print("60", love.graphics.getWidth()-32, love.graphics.getHeight()-16, 2)
		elseif s.fpslimit_ix == 1 then
			ved_print("30", love.graphics.getWidth()-32, love.graphics.getHeight()-16, 2)
		end
		love.graphics.setColor(255,255,255)
	end

	-- Low FPS warning
	if s.lowfpswarning >= 0 and (love.timer.getTime()-begint >= 3) and love.timer.getFPS() <= s.lowfpswarning then
		love.graphics.setColor(255,160,0,192)
		love.graphics.rectangle("fill", 0, love.graphics.getHeight()-16, 128, 16)
		love.graphics.setColor(255,255,255,255)
		ved_printf(L.FPS .. ": " .. love.timer.getFPS(), 0, love.graphics.getHeight()-12, 128, "center")
	end

	if allowdebug then
		if takinginput then
			-- Taking input warning
			love.graphics.setColor(255,160,0,192)
			love.graphics.rectangle("fill", 128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255,255,255,255)
			ved_printf("TAKING INPUT", 128, love.graphics.getHeight()-12, 128, "center")
		end
		if not nodialog then
			-- Dialog open warning
			love.graphics.setColor(160, 255, 0, 192)
			love.graphics.rectangle("fill", 2*128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255, 255, 255, 255)
			ved_printf("DIALOG OPEN", 2*128, love.graphics.getHeight()-12, 128, "center")
		end
		if mousepressed then
			-- Mouse pressed warning
			love.graphics.setColor(0, 255, 160, 192)
			love.graphics.rectangle("fill", 3*128, love.graphics.getHeight()-16, 128, 16)
			love.graphics.setColor(255, 255, 255, 255)
			ved_printf("MOUSE PRESSED", 3*128, love.graphics.getHeight()-12, 128, "center")
		end
	end

	--[[ some debug stuff for the new map
	if rooms_map_current_x ~= nil then
	ved_print(rooms_map_current_y .. "/" .. rooms_map_current_x .. "\n" .. (#rooms_map_dirty_rooms), 20, 3)
	end
	]]

	hook("love_draw_end")

	-- Are we displaying a replacement cursor?
	--if replacecursor ~= -1 then
		--cursorimg

	if s.fpslimit_ix ~= 4 then
		limit_draw_fps()
	end

	if s.pscale ~= 1 then
		love.graphics.pop()
	end
end

function love.update(dt)
	hook("love_update_start", {dt})

	if window_active() then
		focusregainedtimer = math.min(focusregainedtimer + dt, .1)
	else
		focusregainedtimer = 0
	end

	if playtesting_active then
		local chanmessage = playtestthread_outchannel:pop()

		if chanmessage ~= nil then
			if chanmessage == PLAYTESTING.DONE then
				playtesting_active = false
			elseif chanmessage == PLAYTESTING.ERROR then
				playtesting_active = false
				local err = playtestthread_outchannel:pop()
				dialog.create(err)
			end
		end
	end

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		if RCMactive then
			cursorflashtime = 0
		else
			cursorflashtime = (cursorflashtime+dt) % 1
		end
	end

	if takinginput or sp_t > 0 then
		cursorflashtime = (cursorflashtime + dt) % 1
		--__ = (cursorflashtime <= .5 and "_" or (input_r:sub(1, 1) == "" and " " or firstUTF8(input_r))) .. input_r:sub(2, -1)
		firstchar = firstUTF8(input_r)
		if cursorflashtime <= .5 then
			__ = "_" .. input_r:sub(1 + firstchar:len())
		else
			__ = firstchar .. input_r:sub(1 + firstchar:len())
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf, cftype = dialogs[#dialogs].currentfield
		if dialogs[#dialogs].fields[cf] ~= nil then
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][6])
		end
		if cf ~= 0 and cftype == 0 then
			cursorflashtime = (cursorflashtime + dt) % 1
			firstchar = firstUTF8(anythingbutnil(dialogs[#dialogs].fields[cf][7]))
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

	if state == 1 and sp_t ~= 0 and not sp_go then
		sp_tim = sp_tim + dt
		if sp_tim > .33 then
			sp_tim = 0
			sp_tap()
		end
	elseif state ~= 1 and sp_t ~= 0 then
		sp_t = 0
		sp_go = true
	end
	if state == 1 and sp_t ~= 0 and sp_go and sp_got > 0 then
		sp_got = sp_got - dt
	end

	if state ~= -1 then
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
	end

	if state == -2 and settings_ok then
		if not s.langchosen or opt_forcelanguagescreen then
			opt_forcelanguagescreen = false
			tostate(33)
		elseif opt_loadlevel ~= nil then
			if opt_loadlevel:sub(1, levelsfolder:len()) == levelsfolder then
				opt_loadlevel = opt_loadlevel:sub(levelsfolder:len()+2, -1)
			end
			state6load(opt_loadlevel:sub(1,-8))
			opt_loadlevel = nil -- If the level was invalid, we will still be in this state, and be redirected to state 6
		elseif opt_newlevel then
			triggernewlevel()
			opt_newlevel = false
		else
			tostate(6)
		end
	elseif state == 1 then
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
	elseif state == 6 then
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

function love.textinput(char)
	if focusregainedtimer < .1 then
		return
	end

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		local id = newinputsys.getfocused()
		if newinputsys.hex[id] ~= nil then
			if table.contains({" ", "space"}, char) then -- I'd rather check the Spacebar key than the Space char, but y'know
				local oldstate = {newinputsys.getstate(id)}
				newinputsys.finishhex(id)
				newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
			else
				newinputsys.inserthexchars(id, char)
			end
		else
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.selpos[id] ~= nil then
				newinputsys.delseltext(id)
			end
			newinputsys.insertchars(id, char)
			newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
		end
	end

	-- Textual input isn't needed with a dialog on the screen, we have multiinput
	if takinginput and not dialog.is_open() then
		-- Ugly, but at least won't need another global variable that appears here and there
		if (state == 1) and not nodialog and editingroomname and (char:lower() == "e") then
		elseif (state == 3) and not nodialog and (char == "/" or char == "?") then
		-- Pipes are newlines in scripts (on PC at least)
		elseif (state == 3) and char == "|" then
			table.insert(scriptlines, editingline+1, "")
			editingline = editingline + 1
			input = anythingbutnil(scriptlines[editingline])
		else
			input = input .. char
		end

		cursorflashtime = 0

		if state == 3 then
			scriptlines[editingline] = input
			-- nodialog as a temp global var is checked here too
			if nodialog then
				dirty()
			elseif table.contains({"/", "?"}, char) then
				nodialog = true
			end
		elseif state == 15 and helpeditingline ~= 0 then
			helparticlecontent[helpeditingline] = input
		elseif state == 6 then
			tabselected = 0
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf, cftype = dialogs[#dialogs].currentfield
		if dialogs[#dialogs].fields[cf] ~= nil then
			-- Input boxes can also have their type set to nil and default to 0
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][6])
		end
		if cf ~= 0 and cftype == 0 then
			dialogs[#dialogs].fields[cf][5] = dialogs[#dialogs].fields[cf][5] .. char
		end

		cursorflashtime = 0
	end

	if coordsdialog.active then
		coordsdialog.type(char)
	end

	if coordsdialog.active or RCMactive or dialog.is_open() or playtesting_askwherestart then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].textinput ~= nil then
		uis[state].textinput(char)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, char)
			if e.textinput ~= nil then
				e:textinput(char)
			end
		end
		for k,v in pairs(uis[state].elements) do
			caller(v, char)
			if v.recurse ~= nil then
				v:recurse("textinput", caller, char)
			end
		end
	end
end

function love.keypressed(key)
	if focusregainedtimer < .1 then
		if not table.contains(skipnextkeys, key) then
			table.insert(skipnextkeys, key)
		end
		return
	end

	hook("love_keypressed_start", {key})

	-- Your privacy is respected.
	keyva.keypressed(key)

	-- DEBUG FOR FPS CAP
	if allowdebug and key == "pagedown" and love.keyboard.isDown(rctrl) then
		s.fpslimit_ix = (s.fpslimit_ix % 4) + 1
	elseif allowdebug and key == "pageup" and love.keyboard.isDown(rctrl) then
		debug.debug()
	end

	if key == "escape" then
		RCMactive = false
	end

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		local id = newinputsys.getfocused()
		local multiline = type(inputs[id]) == "table"

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown", "delete"}, key) or keyboard_eitherIsDown(ctrl, modifier) or isclear(key) then
			newinputsys.stophex(id)
		end

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown"}, key) or isclear(key) then
			if #newinputsys.undostack[id] > 0 then
				newinputsys.undostack[id][#newinputsys.undostack[id]].group = nil
			end
		end

		if table.contains({"left", "right", "up", "down", "home", "end", "pageup", "pagedown"}, key) then
			if keyboard_eitherIsDown("shift") and not keyboard_eitherIsDown("alt") then
				if newinputsys.selpos[id] == nil then
					newinputsys.setselpos(id)
				end
			else
				newinputsys.clearselpos(id)
			end
		end

		if key == "left" then
			if keyboard_eitherIsDown(modifier) then
				newinputsys.movexwords(id, -1)
			else
				newinputsys.movex(id, -1)
			end
		elseif key == "right" then
			if keyboard_eitherIsDown(modifier) then
				newinputsys.movexwords(id, 1)
			else
				newinputsys.movex(id, 1)
			end
		elseif key == "up" and not keyboard_eitherIsDown("alt") then
			newinputsys.movey(id, -1)
		elseif key == "down" and not keyboard_eitherIsDown("alt") then
			newinputsys.movey(id, 1)
		elseif key == "home" then
			newinputsys.leftmost(id)
		elseif key == "end" then
			newinputsys.rightmost(id)
		elseif key == "pageup" then
			-- Hardcoded (and pagedown is too)
			-- unless there's big multiline inputs other than the script and article editors
			-- and they aren't 57 lines tall
			newinputsys.movey(id, -57)
		elseif key == "pagedown" then
			newinputsys.movey(id, 57)
		elseif (table.contains({"backspace", "delete"}, key) or isclear(key)) and newinputsys.selpos[id] ~= nil then
			newinputsys.atomicdelete(id)
		elseif key == "backspace" then
			if newinputsys.hex[id] ~= nil then
				newinputsys.deletehexchars(id, 1)
			else
				local oldstate = {newinputsys.getstate(id)}
				if keyboard_eitherIsDown(modifier) then
					newinputsys.deletewords(id, -1)
				else
					newinputsys.deletechars(id, -1)
				end
				newinputsys.unre(id, UNRE.DELETE, unpack(oldstate))
			end
		elseif key == "delete" then
			local oldstate = {newinputsys.getstate(id)}
			if keyboard_eitherIsDown(modifier) then
				newinputsys.deletewords(id, 1)
			else
				newinputsys.deletechars(id, 1)
			end
			newinputsys.unre(id, UNRE.DELETE, unpack(oldstate))
		elseif table.contains({"return", "kpenter"}, key) then
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.hex[id] ~= nil then
				newinputsys.finishhex(id)
			else
				if newinputsys.selpos[id] ~= nil then
					newinputsys.delseltext(id)
				end
				newinputsys.newline(id)
			end
			newinputsys.unre(id, UNRE.INSERT, unpack(oldstate))
		elseif table.contains({"x", "c"}, key) and keyboard_eitherIsDown(ctrl) and newinputsys.selpos[id] ~= nil and not love.mouse.isDown("l") then
			newinputsys.atomiccopycut(id, key == "x")
		elseif key == "v" and keyboard_eitherIsDown(ctrl) then
			newinputsys.atomicpaste(id)
		elseif key == "a" and keyboard_eitherIsDown(ctrl) then
			if keyboard_eitherIsDown("shift") then
				newinputsys.selallleft(id)
			else
				newinputsys.selallright(id)
			end
		elseif table.contains({"u", "k"}, key) and keyboard_eitherIsDown(ctrl) then
			if key == "u" and keyboard_eitherIsDown("shift") then
				newinputsys.starthex(id)
			else
				local oldstate = {newinputsys.getstate(id)}
				if newinputsys.selpos[id] ~= nil then
					newinputsys.delseltext(id)
				else
					if key == "u" then
						newinputsys.deltoleftmost(id)
					elseif key == "k" then
						newinputsys.deltorightmost(id)
					end
				end
				newinputsys.unre(id, nil, unpack(oldstate))
			end
		elseif key == "d" and keyboard_eitherIsDown(ctrl) then
			local oldstate = {newinputsys.getstate(id)}
			if newinputsys.selpos[id] ~= nil then
				newinputsys.delseltext(id)
			else
				if keyboard_eitherIsDown("shift") then
					newinputsys.removelines(id, -1)
				else
					newinputsys.removelines(id, 1)
				end
			end
			newinputsys.unre(id, nil, unpack(oldstate))
		elseif key == "l" and keyboard_eitherIsDown(ctrl) then
			if keyboard_eitherIsDown("shift") then
				newinputsys.sellinetoleft(id)
			else
				newinputsys.sellinetoright(id)
			end
		elseif key == "z" and keyboard_eitherIsDown(ctrl) then
			newinputsys.undo(id)
		elseif key == "y" and keyboard_eitherIsDown(ctrl) then
			newinputsys.redo(id)
		elseif table.contains({"up", "down"}, key) and keyboard_eitherIsDown("alt") and multiline then
			if keyboard_eitherIsDown("shift") then
				newinputsys.atomicdupeline(id, key == "down")
			else
				if key == "up" then
					newinputsys.atomicmovevertical(id, -1)
				elseif key == "down" then
					newinputsys.atomicmovevertical(id, 1)
				end
			end
		end
	end

	if coordsdialog.active and key == "backspace" then
		coordsdialog.input = coordsdialog.input:sub(1, -2)
	elseif takinginput and nodialog then
		if key == "backspace" then
			input = backspace(input)

			if state == 3 then
				-- We're checking for the not-yet-changed line, hence why this doesn't cause the exact same backspace problem VVVVVV has
				if scriptlines[editingline] == "" and editingline ~= 1 then
					table.remove(scriptlines, editingline)
					editingline = editingline - 1
					input = anythingbutnil(scriptlines[editingline])
				else
					scriptlines[editingline] = input
				end
				dirty()
			elseif state == 15 then
				-- Exact same story here.
				if helparticlecontent[helpeditingline] == "" and helpeditingline ~= 1 then
					table.remove(helparticlecontent, helpeditingline)
					helpeditingline = helpeditingline - 1
					input = anythingbutnil(helparticlecontent[helpeditingline])
				else
					helparticlecontent[helpeditingline] = input
				end
			elseif state == 6 and nodialog then
				tabselected = 0
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("v") then
			input = input .. love.system.getClipboardText()

			if state == 3 then
				-- Let's process people trying to sneak past pipes first before processing newlines
				if input:find("|") then
					input = input:gsub("|", "\n")
				end

				if input:find("\n") then
					-- CRLF -> LF
					local inputparts = explode("\n", input:gsub("\r\n", "\n"))

					scriptlines[editingline] = inputparts[1]

					for k = 2, #inputparts do
						table.insert(scriptlines, editingline+(k-1), inputparts[k])
					end

					editingline = editingline + #inputparts - 1
					input = anythingbutnil(scriptlines[editingline])
				else
					scriptlines[editingline] = input
				end
				dirty()
			elseif state == 15 then
				-- Same
				if input:find("\n") then
					-- CRLF -> LF
					local inputparts = explode("\n", input:gsub("\r\n", "\n"))

					helparticlecontent[helpeditingline] = inputparts[1]

					for k = 2, #inputparts do
						table.insert(helparticlecontent, helpeditingline+(k-1), inputparts[k])
					end

					helpeditingline = helpeditingline + #inputparts - 1
					input = anythingbutnil(helparticlecontent[helpeditingline])
				else
					helparticlecontent[helpeditingline] = input
				end
			elseif state == 6 then
				tabselected = 0
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("u") then
			-- If you use Linux you may like this shortcut!
			input = ""

			if state == 3 then
				scriptlines[editingline] = input
				dirty()
			elseif state == 15 then
				helparticlecontent[helpeditingline] = input
			end
		elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("k") then
			-- If you like symmetry and use Linux you may like this shortcut too
			input_r = ""

			if state == 3 then
				dirty()
			end
		elseif key == "left" and not keyboard_eitherIsDown(ctrl) then
			input, input_r = leftspace(input, input_r)

			cursorflashtime = 0

			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "right" and not keyboard_eitherIsDown(ctrl) then
			input, input_r = rightspace(input, input_r)

			cursorflashtime = 0

			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "home" then
			input_r = anythingbutnil(input) .. anythingbutnil(input_r)
			input = ""

			cursorflashtime = 0

			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "end" then
			input = anythingbutnil(input) .. anythingbutnil(input_r)
			input_r = ""

			cursorflashtime = 0

			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "delete" then
			_, input_r = rightspace(input, input_r)

			if state == 3 then
				if input_r == "" and editingline < #scriptlines then
					input_r = anythingbutnil(scriptlines[editingline + 1])
					table.remove(scriptlines, editingline + 1)
				end
				dirty()
			elseif state == 15 then
				if input_r == "" and helpeditingline < #helparticlecontent then
					input_r = anythingbutnil(helparticlecontent[helpeditingline + 1])
					table.remove(helparticlecontent, helpeditingline + 1)
				end
			--elseif state == 6 then
				--tabselected = 0
			-- DO NOT UNCOMMENT THE ABOVE:
			-- If you do, the Delete key will no longer be able to
			-- remove levels from the recently opened level list if
			-- you tab over to them
			end
		end
	elseif dialog.is_open() and not dialogs[#dialogs].closing then
		local cf, cftype = dialogs[#dialogs].currentfield
		if dialogs[#dialogs].fields[cf] ~= nil then
			-- Input boxes can also have their type set to nil and default to 0
			cftype = anythingbutnil0(dialogs[#dialogs].fields[cf][6])
		end
		if cf ~= 0 and cftype == 0 then
			if key == "backspace" then
				dialogs[#dialogs].fields[cf][5] = backspace(dialogs[#dialogs].fields[cf][5])
			elseif key == "delete" then
				_, dialogs[#dialogs].fields[cf][7] = rightspace(dialogs[#dialogs].fields[cf][5], dialogs[#dialogs].fields[cf][7])
			elseif keyboard_eitherIsDown(ctrl) and key == "v" then
				dialogs[#dialogs].fields[cf][5] = dialogs[#dialogs].fields[cf][5] .. love.system.getClipboardText():gsub("[\r\n]", "")
			elseif keyboard_eitherIsDown(ctrl) and key == "u" then
				dialogs[#dialogs].fields[cf][5] = ""
			elseif keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("k") then
				dialogs[#dialogs].fields[cf][7] = ""
			elseif key == "left" then
				dialogs[#dialogs].fields[cf][5], dialogs[#dialogs].fields[cf][7] = leftspace(dialogs[#dialogs].fields[cf][5], anythingbutnil(dialogs[#dialogs].fields[cf][7]))
				cursorflashtime = 0
			elseif key == "right" then
				dialogs[#dialogs].fields[cf][5], dialogs[#dialogs].fields[cf][7] = rightspace(dialogs[#dialogs].fields[cf][5], anythingbutnil(dialogs[#dialogs].fields[cf][7]))
				cursorflashtime = 0
			elseif key == "home" then
				dialogs[#dialogs].fields[cf][7] = anythingbutnil(dialogs[#dialogs].fields[cf][5]) .. anythingbutnil(dialogs[#dialogs].fields[cf][7])
				dialogs[#dialogs].fields[cf][5] = ""
				cursorflashtime = 0
			elseif key == "end" then
				dialogs[#dialogs].fields[cf][5] = anythingbutnil(dialogs[#dialogs].fields[cf][5]) .. anythingbutnil(dialogs[#dialogs].fields[cf][7])
				dialogs[#dialogs].fields[cf][7] = ""
				cursorflashtime = 0
			end
		end
		if key == "tab" then
			dialogs[#dialogs].showtabrect = true
			RCMactive = false
			local done = false
			local original = math.max(cf, 1)
			if cftype == 0 then
				dialogs[#dialogs].fields[cf][5] = anythingbutnil(dialogs[#dialogs].fields[cf][5]) .. anythingbutnil(dialogs[#dialogs].fields[cf][7])
				dialogs[#dialogs].fields[cf][7] = ""
			end

			while not done do
				if keyboard_eitherIsDown("shift") then
					if cf <= 1 then
						dialogs[#dialogs].currentfield = #dialogs[#dialogs].fields
					else
						dialogs[#dialogs].currentfield = cf - 1
					end
				else
					if cf >= #dialogs[#dialogs].fields then
						dialogs[#dialogs].currentfield = 1
					else
						dialogs[#dialogs].currentfield = cf + 1
					end
				end

				cf = dialogs[#dialogs].currentfield
				if cf == original and anythingbutnil(dialogs[#dialogs].fields[cf])[6] ~= 2 then
					-- Don't keep looping around forever
					done = true
				end
				if dialogs[#dialogs].fields[cf] == nil or dialogs[#dialogs].fields[cf][6] == nil or dialogs[#dialogs].fields[cf][6] ~= 2 then
					-- Only text labels are skipped
					done = true
				end

				cursorflashtime = 0
			end
		end
		if cftype == DF.CHECKBOX and (key == " " or key == "space") then
			dialogs[#dialogs].showtabrect = true

			dialogs[#dialogs].fields[cf][5] = not dialogs[#dialogs].fields[cf][5]

			if dialogs[#dialogs].fields[cf][7] ~= nil then
				dialogs[#dialogs].fields[cf][7](not dialogs[#dialogs].fields[cf][5], dialogs[#dialogs])
			end
		elseif (cftype == DF.DROPDOWN or cftype == DF.RADIOS) and (key == "up" or key == "down" or key == "kp8" or key == "kp2") then
			dialogs[#dialogs].showtabrect = true
			RCMactive = false

			local dropdown = 0
			local cfinput = dialogs[#dialogs].fields[cf][5]
			local dropdowns = dialogs[#dialogs].fields[cf][7]
			local mapping = dialogs[#dialogs].fields[cf][8]
			local usethisvalue
			if mapping ~= nil then
				usethisvalue = mapping[cfinput]
			else
				usethisvalue = cfinput
			end

			for k,v in pairs(dropdowns) do
				if v == usethisvalue then
					dropdown = k
					break
				end
			end
			if key == "up" or key == "kp8" then
				dropdown = dropdown - 1
				if dropdown < 1 then
					dropdown = #dropdowns
				end
			end
			if key == "down" or key == "kp2" then
				dropdown = dropdown + 1
				if dropdown > #dropdowns then
					dropdown = 1
				end
			end

			dialogs[#dialogs]:dropdown_onchange(dialogs[#dialogs].fields[cf][1], dropdowns[dropdown])
		elseif cftype == DF.FILES and (key == "backspace" or key == "up" or key == "kp8" or key == "down" or key == "kp2" or key == " " or key == "space") then
			dialogs[#dialogs].showtabrect = true

			local files = dialogs[#dialogs].fields[cf][7]
			local file = 0
			for k,v in pairs(files) do
				if v.name == dialogs[#dialogs]:return_fields().name then
					file = k
					break
				end
			end

			if key == "backspace" then
				dialogs[#dialogs]:cd_to_parent(cf, dialogs[#dialogs].fields[cf][5], unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf]))
				dialogs[#dialogs]:set_field("name", "")
			elseif key == "up" or key == "kp8" or key == "down" or key == "kp2" then
				local menuitems, folder_filter, folder_show_hidden, listscroll, folder_error, list_height, filter_on = unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf])
				local real_x = dialogs[#dialogs].x+10+dialogs[#dialogs].fields[cf][2]*8
				local real_y = dialogs[#dialogs].y+dialogs[#dialogs].windowani+10+dialogs[#dialogs].fields[cf][3]*8 + 1
				local real_w = dialogs[#dialogs].fields[cf][4]*8

				if key == "up" or key == "kp8" then
					file = file - 1
					if file < 1 then
						file = #files
					end
				end
				if key == "down" or key == "kp2" then
					file = file + 1
					if file > #files then
						file = 1
					end
				end

				dialogs[#dialogs]:set_field("name", anythingbutnil(files[file]).name)

				if 8*file - 8 < math.abs(listscroll) then
					dialogs[#dialogs].fields[cf][10] = -8*file + 8
				elseif 8*file - 8 > math.abs(listscroll) + 8*list_height - 8 then
					dialogs[#dialogs].fields[cf][10] = -8*file + 8*list_height
				end
			elseif (key == " " or key == "space") and files[file] ~= nil and files[file].isdir then
				dialogs[#dialogs]:cd(files[file].name, cf, dialogs[#dialogs].fields[cf][5], unpack(dialogs[#dialogs].fields[cf], 7, #dialogs[#dialogs].fields[cf]))
				dialogs[#dialogs]:set_field("name", "")
			end
		end
	end

	handle_scrolling(true, key)

	local _, voided_metadata
	if state == 1 then
		_, voided_metadata = levelmetadata_get(roomx, roomy)
	end

	if dialog.is_open() then
		dialogs[#dialogs]:keypressed(key)
		return
	elseif sp_t ~= 0 and key == "escape" then
		sp_t = 0
		sp_go = true
	elseif sp_t ~= 0 and state == 1 and not (sp_go and sp_got <= 0) then
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
	elseif nodialog and editingroomtext == 0 and not editingroomname and state == 1 and keyboard_eitherIsDown("shift") and keyboard_eitherIsDown(ctrl) then
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

	elseif nodialog and editingroomtext == 0 and not editingroomname and (state == 1) and key == "," then
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
	elseif nodialog and editingroomtext == 0 and not editingroomname and (state == 1) and key == "." then
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

	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and (key == "q" or key == "g") then
		coordsdialog.activate()
		if key == "q" then
			show_notification(L.OLDSHORTCUT_GOTOROOM)
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and metadata.target == "VCE" and key == "a" then
		next_altstate()
		if altstate == 0 then
			temporaryroomname = L.SWITCHEDTOALTSTATEMAIN
		else
			temporaryroomname = langkeys(L.SWITCHEDTOALTSTATE, {altstate})
		end
		temporaryroomnametimer = 90
	elseif coordsdialog.active and key == "escape" then
		coordsdialog.active = false
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and (key == "m" or key == "kp5") then
		tostate(12)
		return -- temporary, until state 1 got GUI overhaul and this is in ui.keypressed
	elseif playtesting_askwherestart and not editingroomname and editingroomtext == 0 and state == 1 and key == "escape" then
		playtesting_cancelask()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "/" then
		if keyboard_eitherIsDown(ctrl) then
			tonotepad()
		else
			tostate(10)
			-- TODO TEMPORARY BEFORE 1.8.2 IS RELEASED
			TEMP_slashfrommain = true
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "f1" and keyboard_eitherIsDown(ctrl) then
		tostate(15)
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "f" and keyboard_eitherIsDown(ctrl) then
		tostate(11)
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "p" and keyboard_eitherIsDown(ctrl) then
		gotostartpointroom()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "d" and keyboard_eitherIsDown(ctrl) then
		tostate(6, nil, "secondlevel")
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "]" and mouselockx == -1 then
		mouselockx = love.mouse.getX()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "[" and mouselocky == -1 then
		mouselocky = love.mouse.getY()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "tab" then
		eraserlocked = not eraserlocked
	elseif nodialog and editingbounds ~= 0 and state == 1 and key == "escape" then
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
	elseif nodialog and editingbounds ~= 0 and state == 1 and key == "delete" then
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
	elseif nodialog and movingentity ~= 0 and state == 1 and key == "escape" then
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
	elseif nodialog and state == 1 and table.contains({3, 4}, selectedsubtool[14]) and key == "escape" then
		selectedsubtool[14] = 1
		warpid = nil
	elseif nodialog and not editingroomname and editingroomtext == 0 and editingbounds == 0 and state == 1 and (key == "right" or key == "kp6") and not keyboardmode then
		-->
		gotoroom_r()
	elseif nodialog and not editingroomname and editingroomtext == 0 and editingbounds == 0 and state == 1 and (key == "left" or key == "kp4") and not keyboardmode then
		--<
		gotoroom_l()
	elseif nodialog and not editingroomname and editingroomtext == 0 and editingbounds == 0 and state == 1 and (key == "down" or key == "kp2") and not keyboardmode then
		--v
		gotoroom_d()
	elseif nodialog and not editingroomname and editingroomtext == 0 and editingbounds == 0 and state == 1 and (key == "up" or key == "kp8") and not keyboardmode then
		--^
		gotoroom_u()
	elseif state == 1 and editingroomname and table.contains({"return", "kpenter"}, key) then
		saveroomname()
	elseif state == 1 and editingroomname and key == "escape" then
		editingroomname = false
		stopinput()
	elseif state == 1 and editingroomtext > 0 and table.contains({"return", "kpenter"}, key) then
		endeditingroomtext()
	elseif state == 1 and editingroomtext > 0 and key == "escape" then
		if entitydata[editingroomtext].data == "" then
			removeentity(editingroomtext, nil, true)
		end
		editingroomtext = 0
		stopinput()
	elseif allowdebug and state == 1 and key == "\\" and love.keyboard.isDown(lctrl) then
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
	elseif allowdebug and state == 1 and key == "'" and love.keyboard.isDown(lctrl) then
		-- Just display all tilesets and colors in the console.
		for k,v in pairs(tilesetblocks) do
			cons("==== " .. k .. " ====")
			for k2,v2 in pairs(v.colors) do
				cons("-> " .. k2)
			end
		end
	-- Now come some more of VVVVVV's keybindings!
	elseif nodialog and state == 1 and key == "f1" and not voided_metadata then
		-- Change tileset
		switchtileset()
		temporaryroomname = langkeys(L.TILESETCHANGEDTO, {(tilesetblocks[selectedtileset].name ~= nil and (tilesetblocks[selectedtileset].longname ~= nil and tilesetblocks[selectedtileset].longname or tilesetblocks[selectedtileset].name) or selectedtileset)})
		temporaryroomnametimer = 90
	elseif nodialog and state == 1 and key == "f2" and not voided_metadata then
		-- Change tilecol
		switchtilecol()
		temporaryroomname = langkeys(L.TILESETCOLORCHANGEDTO, {(tilesetblocks[selectedtileset].colors[selectedcolor].name ~= nil and tilesetblocks[selectedtileset].colors[selectedcolor].name or langkeys(L.TSCOLOR, {selectedcolor}))})
		temporaryroomnametimer = 90
	elseif nodialog and state == 1 and key == "f3" and not voided_metadata then
		-- Change enemy type
		switchenemies()
		temporaryroomname = L.ENEMYTYPECHANGED
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and key == "f4" and not voided_metadata then
		-- Enemy bounds
		changeenemybounds()
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and key == "f5" and not voided_metadata then
		-- Platform bounds
		changeplatformbounds()
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and metadata.target == "VCE" and levelmetadata_get(roomx, roomy).tower == 0 and key == "f6" then
		-- Add altstate
		local new_altstate = add_altstate(roomx, roomy)
		altstate = new_altstate
		temporaryroomname = langkeys(L.ADDEDALTSTATE, {new_altstate})
		temporaryroomnametimer = 90
	elseif nodialog and state == 1 and metadata.target == "VCE" and key == "f9" and keyboard_eitherIsDown(ctrl) and not voided_metadata then
		-- customtileset/customspritesheet dialog
		dialog.create("", DBS.OKCANCEL, dialog.callback.vcecustomgraphics, L.CUSTOMGRAPHICS,
			dialog.form.vcecustomgraphics_make(levelmetadata_get(roomx, roomy))
		)
	elseif nodialog and state == 1 and key == "f10" and not voided_metadata then
		-- Auto/manual mode
		changedmode()
		temporaryroomname = langkeys(L.CHANGEDTOMODE, {(levelmetadata_get(roomx, roomy).directmode == 1 and L.CHANGEDTOMODEMANUAL or (levelmetadata_get(roomx, roomy).auto2mode == 1 and L.CHANGEDTOMODEMULTI or L.CHANGEDTOMODEAUTO))})
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "w") and not voided_metadata then
		-- Change warp dir
		changewarpdir()
		temporaryroomname = warpdirchangedtext[levelmetadata_get(roomx, roomy).warpdir]
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "e") and not voided_metadata then
		-- Edit room name
		toggleeditroomname()

		-- Stop that extra e from getting into the roomname...
		nodialog = false

		--[[
		if input == "e" then
			input = ""
		else
			input = input:sub(1, -2)
		end
		]]
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "s") then
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
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "l") then
		-- Load
		--
		-- We have to do this in love.draw() or else the
		-- editorscreenshot will be of the wrong state
		gotostateonnextdraw = 6
	elseif nodialog and editingroomtext == 0 and not editingroomname and editingbounds == 0 and state == 1 and table.contains({"return", "kpenter"}, key) then
		-- Play
		playtesting_start()
	elseif nodialog and state == 1 and key == "n" and keyboard_eitherIsDown(ctrl) then
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
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("y") then
		-- No wait redo
		redo()
	elseif (not holdingzvx) and nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and ((key == "c") or (key == "v") or (key == "z") or (key == "x") or (key == "h") or (key == "b") or (key == "f")) then -- Tried cleaning this bit up, later I realized why it was like this
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
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 5 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 or selectedtool == 10 or selectedtool == 19 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 2

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "x" then
			-- 5x5 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 or selectedtool == 19 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 3

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "c" then
			-- Alright, 7x7 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 or selectedtool == 19 then
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
	elseif state == 1 and nodialog and key == "f11" and temporaryroomnametimer == 0 and not keyboard_eitherIsDown(ctrl) then
		user_reload_tilesets()
	elseif state == 1 and selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0 and (key == "lshift" or key == "rshift") then
		if customsizemode <= 2 then
			customsizemode = 3
		else
			customsizemode = 1
		end
	elseif state == 1 and nodialog and editingbounds == 0 and editingroomtext == 0 and not editingroomname and not tilespicker_shortcut and key == "escape" then
		tilespicker = false
	elseif allowdebug and (key == "f11") then
		if love.keyboard.isDown(lctrl) then
			cons("You pressed L" .. ctrl .. "+F11, you get a wall.\n\n***********************************\n* G L O B A L   V A R I A B L E S *\n***********************************\n")
			for k,v in pairs(_G) do
				if type(v) == "boolean" then
					print(k .. " = " .. (v and "true" or "false") .. "\t\t\t[boolean]")
				elseif type(v) == "userdata" and v.type ~= nil and type(v.type) == "function" then
					-- LÖVE object
					print(k .. "\t\t\t[" .. v:type() .. "]")
				elseif table.contains({"function", "table", "userdata", "cdata"}, type(v)) then
					print(k .. "\t\t\t[" .. type(v) .. "]")
				else
					print(k .. " = " .. tostring(v) .. "\t\t\t[" .. type(v) .. "]")
				end
			end
			cons("\n***********************************\n* E N D                           *\n***********************************\n")
			--test = test .. test -- temporary crash on purpose
		else
			--[[
			if love.window.getFullscreen() then
				-- It is already fullscreen.
				love.window.setMode(64+640+192, 480, {fullscreen=false})
			else
				love.window.setMode(64+640+192, 480, {fullscreen=true})
			end
			]]
		end
	elseif allowdebug and (key == "f12") then
		tostate(0, true)
	elseif not editingroomname and (editingroomtext == 0) and nodialog and state == 1 then
		for k,v in pairs(toolshortcuts) do
			local shiftdown = false
			if metadata.target == "VCE" then
				shiftdown = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
			end
			if key == string.lower(v) then
				if (selectedtool == k and k ~= 13 and k ~= 14 and state == 1) and (shiftdown and (k ~= 1 and k ~= 2 and k ~= 3)) then
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
	elseif state == 34 then
		if key == "tab" then
			newinputsys.bump(newinputsys.input_ids[#newinputsys.nth_input - 8])
		end
	end

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].keypressed ~= nil then
		uis[state].keypressed(key)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, key)
			if e.keypressed ~= nil then
				e:keypressed(key)
			end
		end
		for k,v in pairs(uis[state].elements) do
			caller(v, key)
			if v.recurse ~= nil then
				v:recurse("keypressed", caller, key)
			end
		end
	end
end

function love.keyreleased(key)
	for k,v in pairs(skipnextkeys) do
		if v == key then
			table.remove(skipnextkeys, k)
			return
		end
	end

	hook("love_keyreleased_start", {key})

	if key == "/" then
		TEMP_slashfrommain = false
	end

	if holdingzvx and (key == "z" or key == "x" or key == "c" or key == "v" or key == "h" or key == "b" or key == "f") then
		if selectedtool == 1 or selectedtool == 2
		or ((selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9) and oldzxsubtool <= 4)
		or ((selectedtool == 5 or selectedtool == 10) and oldzxsubtool <= 2)
		or (selectedtool == 19 and oldzxsubtool <= 5) then -- this entire system will be improved later
			selectedsubtool[selectedtool] = oldzxsubtool
		end
		holdingzvx = false
	elseif key == "]" then
		mouselockx = -1
	elseif key == "[" then
		mouselocky = -1
	elseif nodialog and (key == "lshift" or key == lctrl) then
		tilespicker = false
		tilespicker_shortcut = false
	elseif table.contains({"return", "kpenter"}, key) then
		returnpressed = false
	end

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].keyreleased ~= nil then
		uis[state].keyreleased(key)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, key)
			if e.keyreleased ~= nil then
				e:keyreleased(key)
			end
		end
		for k,v in pairs(uis[state].elements) do
			caller(v, key)
			if v.recurse ~= nil then
				v:recurse("keyreleased", caller, key)
			end
		end
	end
end

function love.mousepressed(x, y, button)
	-- Love 0.10 compatibility
	if type(button) == "number" then
		if button == 1 then
			button = "l"
		elseif button == 2 then
			button = "r"
		elseif button == 3 then
			button = "m"
		end
	end

	if focusregainedtimer < .1 and not table.contains({"wu", "wd"}, button) then
		if not table.contains(skipnextmouses, button) then
			table.insert(skipnextmouses, button)
		end
		return
	end

	if s.pscale ~= 1 then
		x, y = x*s.pscale^-1, y*s.pscale^-1
	end

	if s.pausedrawunfocused and not window_active() and table.contains({"wu", "wd"}, button) then
		-- When drawing is paused it won't look like the scrollbar has moved,
		-- so just don't move it so the visual will be accurate
		return
	end

	hook("love_mousepressed_start", {x, y, button})


	if rightclickmenu.mousepressed(x, y, button) then
		return
	end
	if dialog.is_open() and button == "l" then
		dialogs[#dialogs]:mousepressed(x, y)
	end

	if state == 1 then
		if x < 64 and not s.psmallerscreen and not (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) then
			if button == "wu" then
				lefttoolscroll = lefttoolscroll + 16
				lefttoolscrollbounds()
			elseif button == "wd" then
				lefttoolscroll = lefttoolscroll - 16
				lefttoolscrollbounds()
			end
		elseif nodialog and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-16-2-4-8, (6*16), 8+4) then -- show all tiles
			tilespicker = not tilespicker
			editingroomname = false

		elseif nodialog and (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wd" or "wu") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
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
		elseif nodialog and (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wu" or "wd") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
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
		elseif nodialog and button == flipscrollmore(macscrolling and "wd" or "wu") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
			if selectedsubtool[selectedtool] > 1 then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
			else
				selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
			end
		elseif nodialog and button == flipscrollmore(macscrolling and "wu" or "wd") and (x >= 64 or s.psmallerscreen) and selectedtool ~= 14 then
			if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
			else
				selectedsubtool[selectedtool] = 1
			end
		end
	end

	handle_scrolling(false, button)

	if button == "m" then
		if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
			unset_middlescroll()
		elseif is_scrollable(x, y) then
			set_middlescroll(x, y)
		end
	elseif button == "l" and middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		unset_middlescroll()
	end

	boxmousepress()

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].mousepressed ~= nil then
		uis[state].mousepressed(x, y, button)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, x, y, button)
			if e.mousepressed ~= nil
			and e.px <= x and (e.pw == nil or e.px+e.pw > x)
			and e.py <= y and (e.ph == nil or e.py+e.ph > y) then
				e:mousepressed(x-e.px, y-e.py, button)
			end
		end
		-- If needed, you might want to change this to cycle through elements in reverse and catch clicks
		for k,v in pairs(uis[state].elements) do
			caller(v, x, y, button)
			if v.recurse ~= nil then
				v:recurse("mousepressed", caller, x, y, button)
			end
		end
	end
end

function love.mousereleased(x, y, button)
	-- Love 0.10 compatibility
	if type(button) == "number" then
		if button == 1 then
			button = "l"
		elseif button == 2 then
			button = "r"
		elseif button == 3 then
			button = "m"
		end
	end

	for k,v in pairs(skipnextmouses) do
		if v == button then
			table.remove(skipnextmouses, k)
			return
		end
	end

	if s.pscale ~= 1 then
		x, y = x*s.pscale^-1, y*s.pscale^-1
	end

	hook("love_mousereleased_start", {x, y, button})


	if state == 1 and undosaved ~= 0 and undobuffer[undosaved] ~= nil then
		undobuffer[undosaved].toredotiles = table.copy(roomdata_get(roomx, roomy, altstate))
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	end

	mousepressed = false
	mousepressed_custombrush = false
	if mousepressed_flag then
		mousepressed_flag = false
		mousereleased_flag = true
	end
	minsmear = -1; maxsmear = -1
	toout = 0

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		newinputsys.ignoremousepressed = false

		local id = newinputsys.getfocused()
		local multiline = type(inputs[id]) == "table"

		if newinputsys.selpos[id] ~= nil then
			local whichfirst
			if multiline then
				local curx, cury = unpack(newinputsys.pos[id])
				local selx, sely = unpack(newinputsys.selpos[id])
				local lines = inputs[id]
				if newinputsys.rightmosts[id] then
					curx = utf8.len(lines[cury])
				end

				if cury < sely then
					whichfirst = 1
				elseif sely < cury then
					whichfirst = 2
				elseif curx < selx then
					whichfirst = 1
				elseif selx < curx then
					whichfirst = 2
				end
			else
				local curx = newinputsys.pos[id]
				local selx = newinputsys.selpos[id]
				if newinputsys.rightmosts[id] then
					curx = utf8.len(inputs[id])
				end

				if curx < selx then
					whichfirst = 1
				elseif selx < curx then
					whichfirst = 2
				end
			end

			if whichfirst == nil then
				newinputsys.clearselpos(id)
			end
		end
	end

	for k,v in pairs(dialogs) do
		v:mousereleased(x, y)
	end

	if button == "m" and middlescroll_x ~= -1 and middlescroll_y ~= -1 and not mouseon(middlescroll_x-16, middlescroll_y-16, 32, 32) then
		unset_middlescroll()
	end

	boxmouserelease()

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].mousereleased ~= nil then
		uis[state].mousereleased(x, y, button)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, x, y, button)
			if e.mousereleased ~= nil
			and e.px <= x and (e.pw == nil or e.px+e.pw > x)
			and e.py <= y and (e.ph == nil or e.py+e.ph > y) then
				e:mousereleased(x-e.px, y-e.py, button)
			end
		end
		-- If needed, you might want to change this to cycle through elements in reverse and catch clicks
		-- Also, since this is mouse released, maybe only call this iff we already called mousepressed??
		for k,v in pairs(uis[state].elements) do
			caller(v, x, y, button)
			if v.recurse ~= nil then
				v:recurse("mousereleased", caller, x, y, button)
			end
		end
	end
end

function love.directorydropped(path)
	-- LÖVE 0.10+
	hook("love_directorydropped", {path})
end

function love.filedropped(file)
	-- LÖVE 0.10+
	hook("love_filedropped", {file})

	if state == 32 then
		-- Maybe make a UI callback for this?
		local path = file:getFilename()
		-- A bit annoying that we have to do this manually, but oh well
		local last_dirsep = path:reverse():find(dirsep, 1, true)
		local filename
		if last_dirsep == nil then
			filename = path
		else
			filename = path:sub(-last_dirsep+1, -1)
		end
		assets_openimage(path, filename)
	end
end

function love.focus(f)
	if f then
		hook("love_focus_gained")
	else
		hook("love_focus_lost")
	end
	hook("love_focus", {f})
end

function love.quit()
	if not s.neveraskbeforequit and has_unsaved_changes() then
		if love.window.requestAttention ~= nil and not window_active() then
			love.window.requestAttention(true)
		end

		if dialog.is_open() and dialogs[#dialogs].identifier == "quit" then
			-- There's already a quit dialog right in front (only top layer though, for convenience)
			return true
		end

		dialog.create(
			L.SUREQUITNEW, DBS.SAVEDISCARDCANCEL,
			dialog.callback.surequit, nil, nil,
			dialog.callback.noclose_on.save, "quit"
		)

		return true
	end
end

function love.threaderror(thread, errorstr)
	dialog.create(L.THREADERROR .. "\n\n" .. errorstr)
	cons("Thread error")
end
