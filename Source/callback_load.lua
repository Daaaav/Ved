function love.load()
	hook("love_load_start")

	utf8 = require("utf8lib_wrapper")
	local table_clear_success = pcall(require, "table.clear")
	if not table_clear_success then
		function table.clear(t)
			for k,v in pairs(t) do
				t[k] = nil
			end
		end
	end

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
	local bidi_available, bidi_load_errmsg
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
		bidi_available, bidi_load_errmsg = prepare_library("vedlib_bidi_mac00.so")
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
		local ffi = require("ffi")
		bidi_available, bidi_load_errmsg = prepare_library("vedlib_bidi_win00." .. ffi.arch .. ".dll")
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
		bidi_available, bidi_load_errmsg = prepare_library("vedlib_bidi_lin00.so")
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
		bidi_available, bidi_load_errmsg = false, nil
	end
	if bidi_available then
		copy_library_license("SheenBidi.txt")
		copy_library_license("c-hashmap.txt")
	end
	init_font_libraries()
	lctrl = "l" .. ctrl
	rctrl = "r" .. ctrl
	ved_require("filefunc_" .. loaded_filefunc)
	setvvvvvvpaths()

	loadfonts_main()
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
	theming = ved_require("theming")
	theming:init()
	tilenumberbatch = ved_require("tilenumberbatch")
	tilenumberbatch:init()
	ved_require("zipwriter")
	ved_require("ziplevel")


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

	image = {
		selectedtool = "ui/images/selectedtool",
		unselectedtool = "ui/images/unselectedtool",

		savebtn_hq = "ui/images/save_hq",
		loadbtn = "ui/images/load",
		loadbtn_hq = "ui/images/load_hq",
		newbtn = "ui/images/new",
		newbtn_hq = "ui/images/new_hq",
		helpbtn = "ui/images/help",
		retbtn_hq = "ui/images/ret_hq",
		infobtn = "ui/images/info",
		infograybtn = "ui/images/infogray",

		undobtn = "ui/images/undo",
		redobtn = "ui/images/redo",
		cutbtn = "ui/images/cut",
		copybtn = "ui/images/copy",
		pastebtn = "ui/images/paste",
		refreshbtn = "ui/images/refresh",

		playbtn_hq = "ui/images/play_hq",
		playgraybtn_hq = "ui/images/playgray_hq",
		playstopbtn_hq = "ui/images/playstop_hq",

		eraseron = "ui/images/eraseron",
		eraseroff = "ui/images/eraseroff",
		eraser = "ui/images/eraser",

		checkon = "ui/images/checkon",
		checkoff = "ui/images/checkoff",
		checkon_hq = "ui/images/checkon_hq",
		checkoff_hq = "ui/images/checkoff_hq",

		radioon = "ui/images/radioon",
		radiooff = "ui/images/radiooff",
		radioon_hq = "ui/images/radioon_hq",
		radiooff_hq = "ui/images/radiooff_hq",

		dropdownarrow = "ui/images/dropdownarrow",
		colorsel = "ui/images/colorsel",

		smallfolder = "ui/images/smallfolder",
		smalllevel = "ui/images/smalllevel",
		smallunknown = "ui/images/smallunknown",

		asset_pppppp = "ui/images/asset_pppppp",
		asset_mmmmmm = "ui/images/asset_mmmmmm",
		asset_musiceditor = "ui/images/asset_musiceditor",
		asset_sounds = "ui/images/asset_sounds",
		asset_graphics = "ui/images/asset_graphics",

		sound_play = "ui/images/sound_play",
		sound_play_current = "ui/images/sound_play_current",
		sound_pause = "ui/images/sound_pause",
		sound_stop = "ui/images/sound_stop",
		sound_rewind = "ui/images/sound_rewind",

		folder_parent = "ui/images/folder_parent",

		bggrid = "ui/images/bggrid",

		solid = "ui/images/solid",
		solidhalf = "ui/images/solidhalf",
		covered_full = "ui/images/covered_full",
		covered_80x60 = "ui/images/covered_80x60",

		scrollup = "ui/images/scrollup",
		scrolldn = "ui/images/scrolldn",

		stat_trinkets = "ui/images/stat_trinkets",
		stat_crewmates = "ui/images/stat_crewmates",
		stat_entities = "ui/images/stat_entities",

		intsc_off = "ui/images/intsc_off",
		intsc_on = "ui/images/intsc_on",

		crosshair_mini = "ui/images/crosshair_mini",
		crosshair_gigantic = "ui/images/crosshair_gigantic",
	}

	script_warn_lights = {
		loadscript_required = {
			img = "ui/images/warn_loadscript_required",
			img_hq = "ui/images/warn_loadscript_required_hq",
			lang_title = "INTSCRWARNING_NOLOADSCRIPT",
			lang_expl = "INTSCRWARNING_NOLOADSCRIPT_EXPL",
		},
		direct_reference = {
			img = "ui/images/warn_direct_reference",
			img_hq = "ui/images/warn_direct_reference_hq",
			lang_title = "INTSCRWARNING_BOXED",
			lang_expl = "INTSCRWARNING_BOXED_EXPL",
		},
		name = {
			img = "ui/images/warn_name",
			img_hq = "ui/images/warn_name_hq",
			lang_title = "INTSCRWARNING_NAME",
			lang_expl = "INTSCRWARNING_NAME_EXPL",
		},
	}

	snd_break = love.audio.newSource("sounds/break.ogg", "static")
	snd_roll = love.audio.newSource("sounds/roll.ogg", "static")

	v6_sounds = {} -- can be used in the sound script context

	scaleimgs = {
		[false] = "ui/images/scale_normal",
		[true] = "ui/images/scale_small"
	}

	toolimg = {}
	toolimgicon = {}
	for t = 1, 17 do
		toolimg[t] = "ui/tools/" .. t
		toolimgicon[t] = "ui/tools/prepared/" .. t
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

	if bidi_load_errmsg ~= nil then
		local template = L.LIB_LOAD_ERRMSG_BIDI
		if love.system.getOS() == "Windows" then
			template = template .. L.LIB_LOAD_ERRMSG_AV
		end
		dialog.create(langkeys(template, {bidi_load_errmsg}))
	end

	tilesets = {}

	-- Load the levels folder and tilesets
	loadlevelsfolder()
	load_vvvvvv_tilesets()

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
