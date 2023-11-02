function love.load()
	hook("love_load_start")

	utf8 = require("utf8lib_wrapper")

	ved_require("loadconfig")

	dodisplaysettings()
	init_window_properties()

	love.graphics.clear()
	love.graphics.scale(s.pscale,s.pscale)
	local loadingimg = love.graphics.newImage("images/loading.png")
	love.graphics.draw(loadingimg,
		(love.graphics.getWidth()-loadingimg:getWidth())/2,
		(love.graphics.getHeight()-loadingimg:getHeight())/2
	)
	love.graphics.scale(1,1)
	love.graphics.present()

	ved_require("librarian")

	lib_load_errmsg = nil
	local loaded_filefunc
	if love.system.getOS() == "OS X" then
		ctrl = "gui" -- cmd
		modifier = "alt"
		dirsep = "/"
		macscrolling = true
		newline = "\n"
		hook("love_load_mac")
		loaded_filefunc = "linmac"
		local lib_ok, errmsg = prepare_library("vedlib_filefunc_mac06.so")
		if not lib_ok then
			lib_load_errmsg = errmsg
		end
		prepare_library("vedlib_https_mac01.so")
		autodetect_vvvvvv_available = prepare_library("vedlib_findv6_mac01.so")
		playtesting_available = true
	elseif love.system.getOS() == "Windows" then
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "\\"
		macscrolling = false
		newline = "\r\n"
		hook("love_load_win")
		loaded_filefunc = "win"
		playtesting_available = true
		autodetect_vvvvvv_available = true
	elseif love.system.getOS() == "Linux" then
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "/"
		macscrolling = false
		newline = "\n"
		hook("love_load_lin")
		local lib_ok, errmsg = prepare_library("vedlib_filefunc_lin06.so", "vedlib_filefunc_linmac.c")
		if not lib_ok then
			lib_load_errmsg = errmsg
		end
		loaded_filefunc = "linmac"
		playtesting_available = true
		autodetect_vvvvvv_available = true
	else
		-- This OS is unknown, so I suppose we will have to fall back on functions in love.filesystem.
		ctrl = "ctrl"
		modifier = "ctrl"
		dirsep = "/"
		macscrolling = false
		newline = "\n"
		hook("love_load_luv")
		loaded_filefunc = "luv"
		playtesting_available = false
		autodetect_vvvvvv_available = false
	end
	lctrl = "l" .. ctrl
	rctrl = "r" .. ctrl
	ved_require("filefunc_" .. loaded_filefunc)
	setvvvvvvpaths()

	loadfonts()
	loadlanginfo()
	loadlanguage()
	loadtinyfont()

	ved_require("const")
	ved_require("tileset_data")
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
	ved_require("slider")
	ved_require("mapfunc")
	ved_require("music")
	ved_require("vvvvvvfunc")
	ved_require("playtesting")
	ved_require("updatecheck")
	ved_require("input")
	ved_require("entity_mousedown")
	ved_require("tool_mousedown")
	autotiling = ved_require("autotiling")
	autotiling:init()
	tilenumberbatch = ved_require("tilenumberbatch")
	tilenumberbatch:init()


	math.randomseed(os.time())

	state = -2; oldstate = -2
	input = ""; takinginput = false
	__ = "_"
	input_r = ""
	cursorflashtime = 0
	no_more_quit_dialog = false

	mousepressed = false
	mousepressed_custombrush = false
	mousepressed_editor_right = false
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

	next_frame_time = love.timer.getTime()

	v6_frametimer = 0
	conveyortimer = 0
	conveyorleftcycle = 1
	conveyorrightcycle = 0

	returnpressed = false

	temporaryroomnametimer = 0
	generictimer = 0
	generictimer_mode = 0 -- 0 for nothing, 1 for feedback in copy script/note button, 2 for map flashing, 3 for notification

	notification_text = ""

	inputcopiedtimer = 0
	inputdoubleclicktimer = 0
	inputnumclicks = 0

	focus_regained_timer = 0
	skip_next_keys = {}
	skip_next_mouses = {}
	textinput_started_timer = 0

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

	image = {
		selectedtool = love.graphics.newImage("images/selectedtool.png"),
		unselectedtool = love.graphics.newImage("images/unselectedtool.png"),

		savebtn_hq = love.graphics.newImage("images/save_hq.png"),
		loadbtn = love.graphics.newImage("images/load.png"),
		loadbtn_hq = love.graphics.newImage("images/load_hq.png"),
		newbtn_hq = love.graphics.newImage("images/new_hq.png"),
		helpbtn = love.graphics.newImage("images/help.png"),
		retbtn_hq = love.graphics.newImage("images/ret_hq.png"),
		infobtn = love.graphics.newImage("images/info.png"),
		infograybtn = love.graphics.newImage("images/infogray.png"),

		undobtn = love.graphics.newImage("images/undo.png"),
		redobtn = love.graphics.newImage("images/redo.png"),
		cutbtn = love.graphics.newImage("images/cut.png"),
		copybtn = love.graphics.newImage("images/copy.png"),
		pastebtn = love.graphics.newImage("images/paste.png"),
		refreshbtn = love.graphics.newImage("images/refresh.png"),

		playbtn_hq = love.graphics.newImage("images/play_hq.png"),
		playgraybtn_hq = love.graphics.newImage("images/playgray_hq.png"),
		playstopbtn_hq = love.graphics.newImage("images/playstop_hq.png"),

		eraseron = love.graphics.newImage("images/eraseron.png"),
		eraseroff = love.graphics.newImage("images/eraseroff.png"),
		eraser = love.graphics.newImage("images/eraser.png"),

		checkon = love.graphics.newImage("images/checkon.png"),
		checkoff = love.graphics.newImage("images/checkoff.png"),
		checkon_hq = love.graphics.newImage("images/checkon_hq.png"),
		checkoff_hq = love.graphics.newImage("images/checkoff_hq.png"),

		radioon = love.graphics.newImage("images/radioon.png"),
		radiooff = love.graphics.newImage("images/radiooff.png"),
		radioon_hq = love.graphics.newImage("images/radioon_hq.png"),
		radiooff_hq = love.graphics.newImage("images/radiooff_hq.png"),

		dropdownarrow = love.graphics.newImage("images/dropdownarrow.png"),
		colorsel = love.graphics.newImage("images/colorsel.png"),

		smallfolder = love.graphics.newImage("images/smallfolder.png"),
		smalllevel = love.graphics.newImage("images/smalllevel.png"),
		smallunknown = love.graphics.newImage("images/smallunknown.png"),

		asset_pppppp = love.graphics.newImage("images/asset_pppppp.png"),
		asset_mmmmmm = love.graphics.newImage("images/asset_mmmmmm.png"),
		asset_musiceditor = love.graphics.newImage("images/asset_musiceditor.png"),
		asset_sounds = love.graphics.newImage("images/asset_sounds.png"),
		asset_graphics = love.graphics.newImage("images/asset_graphics.png"),

		sound_play = love.graphics.newImage("images/sound_play.png"),
		sound_play_current = love.graphics.newImage("images/sound_play_current.png"),
		sound_pause = love.graphics.newImage("images/sound_pause.png"),
		sound_stop = love.graphics.newImage("images/sound_stop.png"),
		sound_rewind = love.graphics.newImage("images/sound_rewind.png"),

		folder_parent = love.graphics.newImage("images/folder_parent.png"),

		bggrid = love.graphics.newImage("images/bggrid.png"),

		solid = love.graphics.newImage("images/solid.png"),
		solidhalf = love.graphics.newImage("images/solidhalf.png"),
		covered_full = love.graphics.newImage("images/covered_full.png"),
		covered_80x60 = love.graphics.newImage("images/covered_80x60.png"),

		scrollup = love.graphics.newImage("images/scrollup.png"),
		scrolldn = love.graphics.newImage("images/scrolldn.png"),

		stat_trinkets = love.graphics.newImage("images/stat_trinkets.png"),
		stat_crewmates = love.graphics.newImage("images/stat_crewmates.png"),
		stat_entities = love.graphics.newImage("images/stat_entities.png"),

		intsc_off = love.graphics.newImage("images/intsc_off.png"),
		intsc_on = love.graphics.newImage("images/intsc_on.png"),

		crosshair_mini = love.graphics.newImage("images/crosshair_mini.png"),
		crosshair_gigantic = love.graphics.newImage("images/crosshair_gigantic.png"),
	}

	script_warn_lights = {
		loadscript_required = {
			img = love.graphics.newImage("images/warn_loadscript_required.png"),
			img_hq = love.graphics.newImage("images/warn_loadscript_required_hq.png"),
			lang_title = "INTSCRWARNING_NOLOADSCRIPT",
			lang_expl = "INTSCRWARNING_NOLOADSCRIPT_EXPL",
		},
		direct_reference = {
			img = love.graphics.newImage("images/warn_direct_reference.png"),
			img_hq = love.graphics.newImage("images/warn_direct_reference_hq.png"),
			lang_title = "INTSCRWARNING_BOXED",
			lang_expl = "INTSCRWARNING_BOXED_EXPL",
		},
		name = {
			img = love.graphics.newImage("images/warn_name.png"),
			img_hq = love.graphics.newImage("images/warn_name_hq.png"),
			lang_title = "INTSCRWARNING_NAME",
			lang_expl = "INTSCRWARNING_NAME_EXPL",
		},
	}

	snd_break = love.audio.newSource("sounds/break.ogg", "static")
	snd_roll = love.audio.newSource("sounds/roll.ogg", "static")

	v6_sounds = {} -- can be used in the sound script context

	scaleimgs = {
		[false] = love.graphics.newImage("images/scale_normal.png"),
		[true] = love.graphics.newImage("images/scale_small.png")
	}
	scaleimgs[false]:setFilter("linear", "nearest")
	scaleimgs[true]:setFilter("linear", "nearest")

	toolimg = {}
	toolimgicon = {}
	for t = 1, 17 do
		toolimg[t] = love.graphics.newImage("tools/" .. t .. ".png")
		toolimgicon[t] = love.image.newImageData("tools/prepared/" .. t .. ".png")
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
	subtoolimgs[12] = {st("12_1"), st("12_2")}
	subtoolimgs[13] = {}
	subtoolimgs[14] = {st("14_1"), st("14_2")}
	subtoolimgs[15] = {}
	subtoolimgs[16] = {st("16_1"), st("16_2"), st("16_3"), st("16_4"), st("16_5"), st("16_6"), st("16_7")}
	subtoolimgs[17] = {st("17_1"), st("17_2")}

	-- Reuse the subtool names from walls for background, and for moving platforms and enemies
	subtoolnames[2] = subtoolnames[1]
	subtoolnames[9] = subtoolnames[8]
	subtoolnames[12] = table.copy(subtoolnames[5])

	-- The help has images too, but they shouldn't be loaded repetitively!
	helpimages = {}

	savedwindowtitle = ""

	load_uis()

	love.keyboard.setKeyRepeat(true)
	load_konami()

	secondlevel = false
	levels_refresh = 0 -- refresh counter, so we know when metadata requests are outdated

	previous_search = ""
	resume_search = false

	playtesting_engstate = PT_ENGSTATE.OFF
	playtesting_uistate = PT_UISTATE.OFF

	if loaded_filefunc == "luv" then
		dialog.create(
			langkeys(L.OSNOTRECOGNIZED,
				{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
			)
		)
	end

	if lib_load_errmsg ~= nil then
		local template = L.LIB_LOAD_ERRMSG
		if love.system.getOS() == "Linux" then
			template = template .. L.LIB_LOAD_ERRMSG_GCC
		end
		dialog.create(langkeys(template, {lib_load_errmsg}), DBS.QUIT,
			function()
				love.event.quit()
			end
		)

		hook("love_load_end")
		return
	elseif not settings_ok then
		-- If the settings file is broken, good chance we don't know what the language setting was.
		dialog.create("The settings file has an error and can not be loaded.\n\nPress OK to proceed with the default settings.\n\n\n\n\nError: " .. anythingbutnil(settings_err), DBS.OK,
			function()
				saveconfig()
				settings_ok = true
			end
		)
	end

	tilesets = {}

	-- Load the levels folder and tilesets
	loadlevelsfolder()
	loadtilesets()

	-- Music! Note that we're not yet loading the music in memory here.
	initvvvvvvmusic()
	musiceditorfile = ""
	musiceditorfile_forcevvvvvvfolder = false
	musiceditorfolder = vvvvvvfolder
	musiceditorfolder_set = false

	if not love.filesystem.exists("maps") then
		love.filesystem.createDirectory("maps")
	end
	if not love.filesystem.exists("overwrite_backups") then
		love.filesystem.createDirectory("overwrite_backups")
	end

	if s.pcheckforupdates then
		updatecheck.start_check()
	end

	loadallmetadatathread = love.thread.newThread("loadallmetadata.lua")
	loadallmetadatathread:start(dirsep, levelsfolder, loaded_filefunc, L)

	allmetadata_inchannel = love.thread.getChannel("allmetadata_in")
	allmetadata_outchannel = love.thread.getChannel("allmetadata_out")

	playtestthread = love.thread.newThread("playtestthread.lua")
	playtestthread_inchannel = love.thread.getChannel("playtestthread_in")
	playtestthread_outchannel = love.thread.getChannel("playtestthread_out")

	-- If I add layers, I should probably increase the max number of sprites and just add them after each other.
	-- A room with one layer would be 1200 tiles as usual, but a room with two layers would be 2400, etc.
	tile_batch = love.graphics.newSpriteBatch(tilesets["tiles.png"].img, 1200, "dynamic")
	tile_batch_oneway = love.graphics.newSpriteBatch(tilesets["tiles.png"].img, 1200, "dynamic")
	tile_batch_needs_update = false
	tile_batch_texture_needs_update = false
	tile_batch_tileset = 1
	tile_batch_zoomscale2 = 1
	tile_batch_tiles = {}
	for i = 1, 1200 do
		tile_batch_tiles[i] = 0
	end
	tile_batch_has_oneway = false

	if love.graphics.isSupported("shader") then
		-- The shader should be valid, but just in case.
		local success
		success, shader_tint = pcall(love.graphics.newShader, "shader_tint.frag")
		if not success then
			cons("Shader creation failed!")
			cons(shader_tint)
			shader_tint = nil
		end
	end

	hook("love_load_end")
end
