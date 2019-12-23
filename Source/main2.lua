--[[

States:
-3	Just blackness
-2	tostate 6
-1	Display error (expected: errormsg)
0	Temp main menu (enter state)
1	The editor (will expect things to have been loaded!)
2	Syntax highlighting test
3	Scripting editor
4	Some XML testing
5	Filesystem testing
6	Simple listing of all files in the levels folder, and load a level from here
7	Display all sprites from sprites.png where you can get the number of the sprite you're hovering over
8	Just save by going to this state and typing in a name
9	Dialog test, and right click menu test
10	List of scripts, and enter one to load
11	Search
12	Map
13	Options screen
14	Sort of entity picker proto
15	Help
16	Scroll bar test
17	folderopendialog utility
18	Show undo/redo stacks
19	Flags list
20	Resizable box test
21	Display overlapping entities (may be a visible function later) (maybe doesn't work properly)
22	Load a script file in the 3DS format (lines separated by dollars)
23	Load a script file NOT in the 3DS format (lines separated by \r\n or \n)
24	Simple plugins list (already not used)
25	Syntax highlighting color settings
26	Font test
27	Display/Scale settings
28	Level stats
29	Plural forms test
30	Assets
31	Assets - music/sounds
32	Assets - graphics
33	Language screen

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

	local loaded_filefunc
	if love.system.getOS() == "OS X" then
		-- Cmd
		ctrl = "gui"
		dirsep = "/"
		macscrolling = true
		wgetavailable = false
		hook("love_load_mac")
		loaded_filefunc = "linmac"
		if not love.filesystem.exists("available_libs") then
			love.filesystem.createDirectory("available_libs")
		end
		if not love.filesystem.exists("available_libs/vedlib_filefunc_mac02.so") then
			-- Too bad there's no love.filesystem.copy()
			love.filesystem.write("available_libs/vedlib_filefunc_mac02.so", love.filesystem.read("libs/vedlib_filefunc_mac02.so"))
		end
	elseif love.system.getOS() == "Windows" then
		-- Ctrl
		ctrl = "ctrl"
		dirsep = "\\"
		macscrolling = false
		wgetavailable = false
		hook("love_load_win")
		loaded_filefunc = "win"
	elseif love.system.getOS() == "Linux" then
		-- Ctrl
		ctrl = "ctrl"
		dirsep = "/"
		macscrolling = false
		wgetavailable = true
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
			if os.execute("gcc -shared -fPIC -o "
				.. love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_lin02.so "
				.. love.filesystem.getSaveDirectory() .. "/available_libs/vedlib_filefunc_linmac.c"
			) == 0 then
				vedlib_filefunc_available = true
			end
		end
		if vedlib_filefunc_available then
			loaded_filefunc = "linmac"
		else
			loaded_filefunc = "lin_fallback"
		end
	else
		-- This OS is unknown, so I suppose we will have to fall back on functions in love.filesystem.
		ctrl = "ctrl"
		dirsep = "/"
		macscrolling = false
		wgetavailable = false
		hook("love_load_luv")
		loaded_filefunc = "luv"
	end
	lctrl = "l" .. ctrl
	rctrl = "r" .. ctrl
	ved_require("filefunc_" .. loaded_filefunc)
	setvvvvvvpaths()

	ved_require("imagefont")

	loadfonts()
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

	local curcol = (love.system.getOS() == "OS X" and "b" or "w")
	cursorimg[11] = love.graphics.newImage("cursor/resizev_" .. curcol .. ".png")
	cursorimg[12] = love.graphics.newImage("cursor/resizeh_" .. curcol .. ".png")

	cursorimg[20] = love.graphics.newImage("cursor/selectedtile.png")

	cursorobjs = {}
	if not love_version_meets(10) or love.mouse.hasCursor() then
		cursorobjs[11] = love.mouse.getSystemCursor("sizens")
		cursorobjs[12] = love.mouse.getSystemCursor("sizewe")
		cursorobjs[16] = love.mouse.getSystemCursor("sizenwse")
		cursorobjs[17] = love.mouse.getSystemCursor("sizenesw")
		cursorobjs[19] = love.mouse.getSystemCursor("sizeall")

		hand_cursor = love.mouse.getSystemCursor("hand")
		forbidden_cursor = love.mouse.getSystemCursor("no")
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

	savebtn = love.graphics.newImage("images/save.png")
	loadbtn = love.graphics.newImage("images/load.png")
	newbtn = love.graphics.newImage("images/new.png")
	helpbtn = love.graphics.newImage("images/help.png")
	retbtn = love.graphics.newImage("images/ret.png")
	infobtn = love.graphics.newImage("images/info.png")
	infograybtn = love.graphics.newImage("images/infogray.png")

	undobtn = love.graphics.newImage("images/undo.png")
	redobtn = love.graphics.newImage("images/redo.png")
	cutbtn = love.graphics.newImage("images/cut.png")
	copybtn = love.graphics.newImage("images/copy.png")
	pastebtn = love.graphics.newImage("images/paste.png")
	refreshbtn = love.graphics.newImage("images/refresh.png")

	eraseron = love.graphics.newImage("images/eraseron.png")
	eraseroff = love.graphics.newImage("images/eraseroff.png")
	eraser = love.graphics.newImage("images/eraser.png")

	checkon = love.graphics.newImage("images/checkon.png")
	checkoff = love.graphics.newImage("images/checkoff.png")

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
	for t = 1, 17 do
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

	next_frame_time = love.timer.getTime()

	-- If I add layers, I should probably increase the max number of sprites and just add them after each other.
	-- A room with one layer would be 1200 tiles as usual, but a room with two layers would be 2400, etc.
	tile_batch = love.graphics.newSpriteBatch(tilesets["tiles.png"]["img"], 1200, "dynamic")
	tile_batch_needs_update = false
	tile_batch_texture_needs_update = false
	tile_batch_tileset = 1
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
		ved_printf(L.FATALERROR .. anythingbutnil(errormsg) .. "\n\n" .. L.FATALEND, 10, 10, love.graphics.getWidth()-20, "left")
	elseif state == 0 then
		ved_print("Placeholder main menu. Enter state: " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 10)
		startinputonce()
	elseif state == 1 then
		drawmaineditor()

		if gotostateonnextdraw == 6 then
			gotostateonnextdraw = nil
			tostate(6)
		end
	elseif state == 2 then
		ved_print("Syntax highlighting" .. input .. __, 10, 10)

		syntaxhl(input, 10, 30, false, true)
		startinputonce()
	elseif state == 3 then
		drawscripteditor()
	elseif state == 4 then
		ved_print(metadata.Creator, 10, 10)
		ved_print("That should say Unknown.", 10, 20)
	elseif state == 5 then
		ved_print("Userprofile: " .. userprofile, 8, 8)
		for k,v in pairs(files) do
			ved_print(v, 8, 16+8*k)

			lastk = k
		end

		ved_print("Levels folder error: " .. lerror .. " (0 means no error)", 8, 16+8*lastk+16)
		ved_print("Levels folder: " .. anythingbutnil(levelsfolder), 8, 16+8*lastk+24)
		ved_print("Identity: " .. love.filesystem.getIdentity() .. "\nSaveDirectory: " .. love.filesystem.getSaveDirectory(), 8, 16+8*lastk+24+16)
	elseif state == 6 then
		drawlevelslist()
	elseif state == 7 then
		for y = 0, 7 do
			for x = 0, 23 do
				if mouseon(x*32, y*32, 32, 32) then
					ved_print((y*24)+x, love.graphics.getWidth()-24, love.graphics.getHeight()-8)
					love.graphics.setColor(255,255,255,64)
					love.graphics.rectangle("fill", x*32, y*32, 32, 32)
					love.graphics.setColor(255,255,255)
				end

				love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][(y*24)+x], x*32, y*32)
			end
		end
	elseif state == 8 then
		ved_print(L.ENTERNAMESAVE .. input .. __, 10, 10)
		startinputonce()
		if savedsuccess ~= nil then
			if savedsuccess == true then
				ved_print(L.SAVESUCCESS, 10, 50)
			else
				ved_print(L.SAVENOSUCCESS .. anythingbutnil(savederror), 10, 50)
			end
		end
	elseif state == 9 then
		ved_print("\nRight click menu return: " .. anythingbutnil(RCMreturn), 10, 10)

		vvvvvv_textbox("cyan", 0, 25, {"Cyan"})
		vvvvvv_textbox("red", 0, 50, {"Red"})
		vvvvvv_textbox("yellow", 0, 75, {"Yellow"})
		vvvvvv_textbox("green", 0, 100, {"Green"})
		vvvvvv_textbox("blue", 0, 125, {"Blue"})
		vvvvvv_textbox("purple", 0, 150, {"Purple"})
		vvvvvv_textbox("gray", 0, 175, {"Gray"})

		for k,v in pairs(vvvvvv_textboxes) do
			vvvvvv_textbox(unpack(v))
		end
	elseif state == 10 then
		local j = -1
		local newscroll
		for rvnum = #scriptnames, 1, -1 do
			if scriptdisplay_used and scriptdisplay_unused
			or scriptdisplay_used and usedscripts[scriptnames[rvnum]]
			or scriptdisplay_unused and not usedscripts[scriptnames[rvnum]]
			then
				j = j + 1
				local y = scriptlistscroll+8+(24*j)
				if skipnextscripthoverrect then
					skipnextscripthoverrect = nil
				elseif y >= -16 and y <= love.graphics.getHeight() then
					local used = usedscripts[scriptnames[rvnum]]
					hoverrectangle(128,128,128, used and 128 or 64, 8, y, screenoffset+640-8-24 -36, 16)
					ved_printf(scriptnames[rvnum], 8, y+4, screenoffset+640-8-36, "center")
					if rvnum == #scriptnames then
						showhotkey("/", 8+screenoffset+640-8-24 -36, y-2, ALIGN.RIGHT)
					end

					if rvnum ~= #scriptnames then
						hoverrectangle(128,128,128,128, 8+screenoffset+640-8-24 -36 +4, y, 16, 16)
						ved_printf(arrow_up, 8+screenoffset+640-8-24 -36 +4, y+4, 16, "center")
					end
					if rvnum ~= 1 then
						hoverrectangle(128,128,128,128, 8+screenoffset+640-8-24 -36 +4 +16 +4, y, 16, 16)
						ved_printf(arrow_down, 8+screenoffset+640-8-24 -36 +4 +16 +4, y+4, 16, "center")
					end
				end

				-- Are we clicking on this?
				if mousepressed or not nodialog then
				elseif mouseon(8, scriptlistscroll+8+(24*j), screenoffset+640-8-24 -36, 16) then
					if love.mouse.isDown("l") then
						scriptineditor(scriptnames[rvnum], rvnum)
					elseif love.mouse.isDown("r") then
						rightclickmenu.create({L.EDIT, L.EDITWOBUMPING, L.COPYNAME, L.COPYCONTENTS, L.DUPLICATE, L.RENAME, L.DELETE}, "spt_" .. rvnum)
					end
				elseif rvnum ~= #scriptnames and mouseon(8+screenoffset+640-8-24 -36 +4, scriptlistscroll+8+(24*j), 16, 16) and love.mouse.isDown("l") then
					movescriptdown(rvnum)
					mousepressed = true
					local nextscriptvisible = (scriptdisplay_used and scriptdisplay_unused) or (scriptdisplay_used and usedscripts[scriptnames[rvnum]]) or (scriptdisplay_unused and not usedscripts[scriptnames[rvnum]])
					if not nextscriptvisible then
					elseif scriptlistscroll+8+24*(j-1) < 0 then
						newscroll = scriptlistscroll + 24
						if newscroll > 0 then -- the correction can be farther than the top of the list
							love.mouse.setPosition(love.mouse.getX(), love.mouse.getY()-newscroll)
							newscroll = 0
						end
					else
						love.mouse.setPosition(love.mouse.getX(), love.mouse.getY()-24)
					end
				elseif rvnum ~= 1 and mouseon(8+screenoffset+640-8-24 -36 +4 +16 +4, scriptlistscroll+8+(24*j), 16, 16) and love.mouse.isDown("l") then
					movescriptup(rvnum)
					mousepressed = true
					local nextscriptvisible = (scriptdisplay_used and scriptdisplay_unused) or (scriptdisplay_used and usedscripts[scriptnames[rvnum]]) or (scriptdisplay_unused and not usedscripts[scriptnames[rvnum]])
					if not nextscriptvisible then
						j = j - 1 -- prevents flickering
						skipnextscripthoverrect = true
					elseif scriptlistscroll+8+24*(j+1) +16 > love.graphics.getHeight() then
						newscroll = scriptlistscroll - 24
						local height = -(((#scriptnames)*24-8)-(love.graphics.getHeight()-16))
						if newscroll < height then -- correction is too far past the bottom
							local diff = height-newscroll
							love.mouse.setPosition(love.mouse.getX(), love.mouse.getY()+diff)
							newscroll = height
						end
					else
						love.mouse.setPosition(love.mouse.getX(), love.mouse.getY()+24)
					end
				end

			end
		end

		-- Scrollbar
		local newperonetage = scrollbar(love.graphics.getWidth()-(128-8)-24, 8, love.graphics.getHeight()-16, ((j+1)*24-8), (-scriptlistscroll)/(((j+1)*24-8)-(love.graphics.getHeight()-16)))

		if newperonetage ~= nil then
			scriptlistscroll = -(newperonetage*(((j+1)*24-8)-(love.graphics.getHeight()-16)))
		end
		if newscroll ~= nil then
			scriptlistscroll = newscroll -- to prevent flickering
		end

		rbutton({L.NEW, "N"}, 0)
		rbutton({L.FLAGS, "F"}, 1)

		ved_printf(L.SCRIPTDISPLAY, love.graphics.getWidth()-120, 84, 112, "center")
		checkbox(scriptdisplay_used, love.graphics.getWidth()-120, 104, nil, L.SCRIPTDISPLAY_USED,
			function(key, newvalue)
				scriptdisplay_used = newvalue
				if not scriptdisplay_used and not scriptdisplay_unused then
					scriptdisplay_unused = true
				end
				changed_scriptdisplay = true
			end
		)
		checkbox(scriptdisplay_unused, love.graphics.getWidth()-120, 128, nil, L.SCRIPTDISPLAY_UNUSED,
			function(key, newvalue)
				scriptdisplay_unused = newvalue
				if not scriptdisplay_used and not scriptdisplay_unused then
					scriptdisplay_used = true
				end
				changed_scriptdisplay = true
			end
		)

		if not (scriptdisplay_used and scriptdisplay_unused) then
			ved_printf(langkeys(L_PLU.SCRIPTDISPLAY_SHOWING, {j+1}), love.graphics.getWidth()-120, 180, 112, "center")
		end

		-- Script count
		ved_printf(
			L.COUNT .. #scriptnames .. "/500",
			love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-(24*2))+4, 128-16, "left"
		)

		rbutton({L.RETURN, "b"}, 0, nil, true)

		-- Buttons again
		if nodialog and not mousepressed and love.mouse.isDown("l") then
			local changed_scriptdisplay = false
			if onrbutton(0) then
				-- New
				dialog.create(
					L.NEWSCRIPTNAME, DBS.OKCANCEL,
					dialog.callback.newscript, L.CREATENEWSCRIPT, dialog.form.simplename,
					dialog.callback.newscript_validate, "newscript_list"
				)
			elseif onrbutton(1) then
				-- Flags
				mousepressed = true
				tostate(19, false)
			elseif onrbutton(0, nil, true) then
				-- Return
				tostate(1, true)
			end
			if changed_scriptdisplay then
				scriptlistscroll = 0
				if usedscripts == nil then
					usedscripts, n_usedscripts = findusedscripts()
				end
			end

			mousepressed = true
		end
	elseif state == 11 then
		drawsearch()
	elseif state == 12 then
	elseif state == 13 then
		-- Options screen
		--love.graphics.draw(checkon, love.graphics.getWidth()-98, 50, 0, 2)
		--love.graphics.draw(checkoff, love.graphics.getWidth()-98, 70, 0, 2)
		ved_print(L.VEDOPTIONS, 8, 8+4)

		for k,v in pairs({
				"dialoganimations",
				"flipsubtoolscroll",
				"adjacentroomlines",
				"neveraskbeforequit",
				"coords0",
				"showfps",
				false,
				"checkforupdates",
				"pausedrawunfocused",
				"enableoverwritebackups",
				false,
				"autosavecrashlogs",
				"loadallmetadata",
				"usefontpng",
				"opaqueroomnamebackground"
			}
		) do
			if v then
				local label = L[v:upper()]
				if v == "usefontpng" then
					label = L.USEFONTPNG .. (not love_version_meets(10) and langkeys(L.REQUIRESHIGHERLOVE, {"0.10.0"}) or "")
				end

				checkbox(s[v], 8, 8+(24*k), v, label,
					function(key, newvalue)
						s[key] = newvalue
						if key == "showfps" then
							savedwindowtitle = ""
						elseif key == "usefontpng" and love_version_meets(10) then
							loadfonts()
							unloadlanguage()
							loadlanguage()
						end
					end
				)
			end
		end

		ved_print(L.FPSLIMIT, 8, 8+(24*7)+4)
		int_control(16+font8:getWidth(L.FPSLIMIT), 8+(24*7), "fpslimit_ix", 1, 4, nil, nil,
			function(value)
				local ret = ({"30", "60", "120", "---"})[value]
				if ret == nil then
					return "??"
				end
				return ret
			end, 24
		)

		if s.enableoverwritebackups then
			ved_print(L.AMOUNTOVERWRITEBACKUPS, 8, 8+(24*11)+4)
			int_control(16+font8:getWidth(L.AMOUNTOVERWRITEBACKUPS), 8+(24*11), "amountoverwritebackups", 0, 999)
		end

		ved_print(
			ERR_VEDVERSION .. " " .. ved_ver_human() .. "\n"
			.. ERR_LOVEVERSION .. " " .. love._version_major .. "." .. love._version_minor .. "." .. love._version_revision,
			8, love.graphics.getHeight()-23
		)


		rbutton({L.BTN_OK, "b"}, 0)

		rbutton(L.CUSTOMVVVVVVDIRECTORY, 2)
		rbutton(L.LANGUAGE, 3)
		rbutton(L.SYNTAXCOLORS, 4)
		rbutton(L.DISPLAYSETTINGS, 5)

		rbutton(L.SENDFEEDBACK, 7)


		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- Save
				exitvedoptions()
			elseif onrbutton(2) then
				-- Custom VVVVVV folder
				if vvvvvvfolder_expected == nil then
					dialog.create(
						langkeys(L.OSNOTRECOGNIZED,
							{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
						)
					)
				else
					local explanation, buttons
					if s.customvvvvvvdir == "" then
						explanation = L.CUSTOMVVVVVVDIRECTORY_NOTSET
						buttons = {L.CHANGEVERB, DB.CANCEL}
					else
						explanation = langkeys(L.CUSTOMVVVVVVDIRECTORY_SET, {s.customvvvvvvdir})
						buttons = {L.CHANGEVERB, L.RESET, DB.CANCEL}
					end
					explanation = explanation .. langkeys(L.CUSTOMVVVVVVDIRECTORYEXPL, {vvvvvvfolder_expected})
					dialog.create(
						explanation,
						buttons,
						dialog.callback.customvvvvvvdir1
					)
				end
			elseif onrbutton(3) then
				-- Language
				olderstate = oldstate
				tostate(33)
			elseif onrbutton(4) then
				-- Syntax colors
				olderstate = oldstate
				tostate(25)
			elseif onrbutton(5) then
				-- Display/Scale
				olderstate = oldstate
				tostate(27)
			elseif not mousepressed and onrbutton(7) then
				love.system.openURL("https://tolp.nl/ved/feedback")

				mousepressed = true
			--elseif not mousepressed and mouseon(love.graphics.getWidth()-(128-8), 8+(24*1), 128-16, 16) then
				-- Cancel
				--tostate(oldstate)
			end

			mousepressed = true
		end
	elseif state == 14 then
		for rrrrr = 0, 1 do
			for asdfg = 0, 4 do
				drawentitysprite(enemysprites[5*rrrrr+asdfg], 16+48*asdfg, 16+48*rrrrr)
			end
		end

		for rrrrr = 0, 1 do
			for asdfg = 0, 4 do
				drawentitysprite(enemysprites[5*rrrrr+asdfg], 600+16*asdfg, 16+16*rrrrr, true)
			end
		end
	elseif state == 15 then
		drawhelp()
	elseif state == 16 then

	elseif state == 17 then

	elseif state == 18 then
		ved_print("Undo stack:\n" .. undostacktext, 8, 8) -- Dev/testing/debug state, not translated
		ved_print("Redo stack:\n" .. redostacktext, love.graphics.getWidth()/2 + 8, 8)
	elseif state == 19 then
		-- Columns 1 and 2
		for flcol = 8, love.graphics.getWidth()/2 + 8, love.graphics.getWidth()/2 do -- dit was misschien niet handig om te doen
			for flk = 0, 49 do
				local ax, ay, w, h = flcol-2, 24+flk*8, love.graphics.getWidth()/2 - 16, 8

				if nodialog and mouseon(ax, ay, w, h) then
					love.graphics.setColor(128,128,128,255)

					if not mousepressed and nodialog and mousereleased_flag then
						flgnum = flk + (flcol == 8 and 0 or 50) -- niet local, wordt gebruikt in dialog

						if mousepressed_flag_num ~= -1 and flgnum ~= mousepressed_flag_num then
							cons("We dropped flag " .. mousepressed_flag_num .. " onto flag " .. flgnum)
							swapflags(flgnum, mousepressed_flag_num)
							dirty()
							mousepressed_flag_x = -1
							mousepressed_flag_y = -1
							mousepressed_flag_num = -1
							mousepressed_flag_name = ""
							-- We have to redraw the flags screen somehow
							loadstate(19)
						else
							mousepressed_flag_x = -1
							mousepressed_flag_y = -1
							mousepressed_flag_num = -1
							mousepressed_flag_name = ""

							local field_default = ""
							if vedmetadata ~= false then
								field_default = vedmetadata.flaglabel[flgnum]
							end

							-- We also want to know where this was used.
							local usages = {}
							local n_usages = returnusedflags(nil, nil, flgnum, usages)

							dialog.create(
								langkeys(L.NAMEFORFLAG, {flgnum}) .. "\n\n\n"
								.. langkeys(L_PLU.FLAGUSAGES, {n_usages, table.concat(usages, ", ")}),
								DBS.OKCANCEL,
								dialog.callback.changeflagname,
								nil,
								dialog.form.simplename_make(field_default),
								dialog.callback.changeflagname_validate
							)
						end

						mousereleased_flag = false
					elseif not mousepressed and nodialog and love.mouse.isDown("l") then
						mousepressed = true
						mousepressed_flag = true
						mousepressed_flag_x = love.mouse.getX()
						mousepressed_flag_y = love.mouse.getY()
						mousepressed_flag_num = flk + (flcol == 8 and 0 or 50)
						if vedmetadata then
							mousepressed_flag_name = vedmetadata.flaglabel[mousepressed_flag_num]
						end
					end
				else
					love.graphics.setColor(64,64,64,128)

					local flgnum2 = flk + (flcol == 8 and 0 or 50)
					local used = usedflags[flgnum2]
					if used then
						love.graphics.setColor(128,128,128,128)
					end
				end

				love.graphics.rectangle("fill", ax, ay, w, h)
			end
		end

		-- Catch anyone dropping flags into the void and then moving back to a flag
		if nodialog and mousereleased_flag and not (mouseon(8-2, 24, love.graphics.getWidth()/2 - 16, 8*50) or mouseon(love.graphics.getWidth()/2 + 8-2, 24, love.graphics.getWidth()/2 - 16, 8*50)) then
			mousereleased_flag = false
			mousepressed_flag_x = -1
			mousepressed_flag_y = -1
			mousepressed_flag_num = -1
			mousepressed_flag_name = ""
		end

		love.graphics.setColor(255,255,255,255)

		ved_print(L.FLAGS .. "\n\n" .. flagstextleft .. "\n\n" .. outofrangeflagstext, 8, 8)
		ved_print(" \n\n" .. flagstextright, love.graphics.getWidth()/2 + 8, 8)

		if nodialog and mousepressed_flag_x ~= -1 and mousepressed_flag_y ~= -1 and (mousepressed_flag_x ~= love.mouse.getX() or mousepressed_flag_y ~= love.mouse.getY()) then
			local t = mousepressed_flag_num .. " - " .. (anythingbutnil(mousepressed_flag_name) ~= "" and anythingbutnil(mousepressed_flag_name) or L.FLAGNONAME)
			love.graphics.setColor(128,128,128,128)
			love.graphics.rectangle("fill", love.mouse.getX() + 8, love.mouse.getY(), 8*#t, 8)
			love.graphics.setColor(255,255,255,255)
			ved_print(t, love.mouse.getX() + 8, love.mouse.getY())
		end

		rbutton({L.RETURN, "b"}, 0, nil, true)

		if nodialog and love.mouse.isDown("l") then
			if onrbutton(0, nil, true) then
				-- Return
				tostate(oldstate, true) -- keep the scrollbar "farness"
				mousepressed = true
			end
		end
	elseif state == 20 then
		love.graphics.setColor(0,0,50)
		love.graphics.rectangle("fill", boxperi_x, boxperi_y, boxperi_w, boxperi_h)
		love.graphics.setColor(50,50,50)
		for li = 0, love.graphics.getWidth(), 16 do
			love.graphics.line(li, 0, li, love.graphics.getHeight())
		end	
		for li = 0, love.graphics.getHeight(), 16 do
			love.graphics.line(0, li, love.graphics.getWidth(), li)
		end
		love.graphics.setColor(255,255,255,255)

		love.graphics.rectangle("line", box_x, box_y, box_w, box_h)

		ved_print((box_exists and "Box exists" or "Box exists not") .. "\nPeri xywh " .. boxperi_x .. " " .. boxperi_y .. " " .. boxperi_w .. " " .. boxperi_h .. "\nBox xywh " .. box_x .. " " .. box_y .. " " .. box_w .. " " .. box_h .. "\nMoving HV: " .. box_moving_h .. box_moving_v .. "\n\nType " .. box_type .. "\nM for switching type -1/0\nV for shrinking the allowed perimeter\nR Reset\nE Re-enable", 10, 10)

		if love.keyboard.isDown("m") then
			if box_type == 0 then
				box_type = -1
			else
				box_type = 0
			end
		end if love.keyboard.isDown("v") then
			boxperi_x, boxperi_y, boxperi_w, boxperi_h = boxperi_x+16, boxperi_y+16, boxperi_w-32, boxperi_h-32
		end if love.keyboard.isDown("r") then
			box_x, box_y, box_w, box_h = 80,80,208,208
			boxperi_x, boxperi_y, boxperi_w, boxperi_h = 0,0,love.graphics.getWidth(),love.graphics.getHeight()
		end if love.keyboard.isDown("e") then
			box_exists = true
		end
	elseif state == 21 then
		ved_print(text21, 8, 8)
	elseif state == 22 then -- These are not translate-worthy I'm guessing
		ved_printf("Filename to a script file (IN the 3DS format) (lines separated by dollars): " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\n\n\n\n\n\n\n\nIf you clicked Open by accident, F12 to 3 with shift", 10, 10, love.graphics.getWidth()-20, "left")
		startinputonce()
	elseif state == 23 then
		ved_printf("Filename to a script file (NOT in the 3DS format) (lines separated by \\r\\n or \\n): " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\n\n\n\n\n\n\n\nIf you clicked Open by accident, F12 to 3 with shift", 10, 10, love.graphics.getWidth()-20, "left")
		startinputonce()
	elseif state == 24 then
		ved_printf("Plugins\n\n\n" .. pluginstext, 8, 8, love.graphics.getWidth()-16, "left")
	elseif state == 25 then
		-- Syntax highlighting color settings
		ved_print(L.SYNTAXCOLORSETTINGSTITLE, 8, 8+4)

		colorsetting(L.SYNTAXCOLOR_COMMAND,     1, s.syntaxcolor_command    )
		colorsetting(L.SYNTAXCOLOR_GENERIC,     2, s.syntaxcolor_generic    )
		colorsetting(L.SYNTAXCOLOR_SEPARATOR,   3, s.syntaxcolor_separator  )
		colorsetting(L.SYNTAXCOLOR_NUMBER,      4, s.syntaxcolor_number     )
		colorsetting(L.SYNTAXCOLOR_TEXTBOX,     5, s.syntaxcolor_textbox    )
		colorsetting(L.SYNTAXCOLOR_ERRORTEXT,   6, s.syntaxcolor_errortext  )
		colorsetting(L.SYNTAXCOLOR_CURSOR,      7, s.syntaxcolor_cursor     )
		colorsetting(L.SYNTAXCOLOR_FLAGNAME,    8, s.syntaxcolor_flagname   )
		colorsetting(L.SYNTAXCOLOR_NEWFLAGNAME, 9, s.syntaxcolor_newflagname)
		colorsetting(L.SYNTAXCOLOR_COMMENT,    10, s.syntaxcolor_comment    )

		checkbox(s.colored_textboxes, 8, 8+(24*12), "colored_textboxes", L.COLORED_TEXTBOXES,
			function(key, newvalue)
				s[key] = newvalue
			end
		)

		rbutton({L.BTN_OK, "b"}, 0)
		rbutton(L.RESETCOLORS, 2)

		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- Save
				exitsyntaxcoloroptions()
			elseif onrbutton(2) then
				-- Reset colors
				for k,v in pairs(s) do
					if k:sub(1,12) == "syntaxcolor_" then
						s[k] = table.copy(configs[k].default)
					end
				end
				editingcolor = nil
			end

			mousepressed = true
		end

		if editingcolor ~= nil then
			for colb = 0, 255 do
				love.graphics.setColor(colb,0,0)
				love.graphics.rectangle("fill", love.graphics.getWidth()-160, love.graphics.getHeight()-(colb+1), 50, 1)
				love.graphics.setColor(0,colb,0)
				love.graphics.rectangle("fill", love.graphics.getWidth()-105, love.graphics.getHeight()-(colb+1), 50, 1)
				love.graphics.setColor(0,0,colb)
				love.graphics.rectangle("fill", love.graphics.getWidth()-50, love.graphics.getHeight()-(colb+1), 50, 1)
			end

			-- A colored block at the top
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill", love.graphics.getWidth()-160, love.graphics.getHeight()-263-20, 160, 16)
			love.graphics.setColor(editingcolor[1],editingcolor[2],editingcolor[3])
			love.graphics.rectangle("fill", love.graphics.getWidth()-159, love.graphics.getHeight()-263-19, 158, 14)

			-- The numbers
			love.graphics.setColor(255,255,255)
			ved_printf(editingcolor[1], love.graphics.getWidth()-160, love.graphics.getHeight()-265, 50, "center")
			ved_printf(editingcolor[2], love.graphics.getWidth()-105, love.graphics.getHeight()-265, 50, "center")
			ved_printf(editingcolor[3], love.graphics.getWidth()-50, love.graphics.getHeight()-265, 50, "center")

			-- The arrows
			love.graphics.draw(colorsel, love.graphics.getWidth()-164, love.graphics.getHeight()-editingcolor[1]-4)
			love.graphics.draw(colorsel, love.graphics.getWidth()-109, love.graphics.getHeight()-editingcolor[2]-4)
			love.graphics.draw(colorsel, love.graphics.getWidth()-54, love.graphics.getHeight()-editingcolor[3]-4)

			-- Are we clicking?
			if love.mouse.isDown("l") then
				if mouseon(love.graphics.getWidth()-160, love.graphics.getHeight()-256, 50, 256) then
					editingcolor[1] = love.graphics.getHeight()-love.mouse.getY() - 1
				elseif mouseon(love.graphics.getWidth()-105, love.graphics.getHeight()-256, 50, 256) then
					editingcolor[2] = love.graphics.getHeight()-love.mouse.getY() - 1
				elseif mouseon(love.graphics.getWidth()-50, love.graphics.getHeight()-256, 50, 256) then
					editingcolor[3] = love.graphics.getHeight()-love.mouse.getY() - 1
				end
			end
		end
	elseif state == 26 then
		love.graphics.setColor(128,128,255,64)
		love.graphics.rectangle("line", 32.5, 32.5, font8:getWidth(input), 8)
		love.graphics.rectangle("line", 32.5, 64.5, font8:getWidth(input)*2, 16)
		love.graphics.rectangle("line", 32.5, 96.5, tinynumbers:getWidth(input), 7)
		love.graphics.setColor(255,128,128,64)
		love.graphics.rectangle("line", 32.5, 32.5-2, font8:getWidth(input), 8)
		love.graphics.rectangle("line", 32.5, 64.5-4, font8:getWidth(input)*2, 16)
		love.graphics.setColor(255,255,255)
		ved_print(input, 32, 32)
		ved_print(input, 32, 64, 2)
		ved_setFont(tinynumbers)
		ved_print(input, 32, 96)
		ved_setFont(font8)

		ved_print("Font test", 10, 10)
	elseif state == 27 then
		-- Display/Scale settings
		ved_print(L.DISPLAYSETTINGSTITLE, 8, 8+4)

		ved_print(L.SCALE, 8, 8+(24*1)+4)
		if nonintscale then
			-- Something
			ved_print(input .. __, 16+font8:getWidth(L.SCALE), 8+(24*1)+4)
		else
			int_control(16+font8:getWidth(L.SCALE), 8+(24*1), "scale", 1, 9,
				function(value)
					local swidth = 896
					if s.psmallerscreen then
						swidth = 800
					end
					local fits = false

					for mon = 1, love.window.getDisplayCount() do
						local monw, monh = love.window.getDesktopDimensions(mon)

						if windowfits(swidth*value, 480*value, {monw, monh}) then
							fits = true
						end
					end
					return not fits
				end
			)
		end

		checkbox(nonintscale, 8, 8+(24*2), nil, L.NONINTSCALE,
			function(key, newvalue)
				nonintscale = newvalue
				if nonintscale then
					startinput()
					input = tostring(s.scale)
				else
					stopinput()
					s.scale = math.floor(num_scale)
					if s.scale <= 0 then
						s.scale = 1
					end
				end
			end
		)

		checkbox(s.smallerscreen, 8, 8+(24*3), "smallerscreen", L.SMALLERSCREEN,
			function(key, newvalue)
				s[key] = newvalue
			end
		)

		checkbox(s.forcescale, 8, 8+(24*4), "forcescale", L.FORCESCALE,
			function(key, newvalue)
				s[key] = newvalue
			end
		)

		if nonintscale then
			num_scale = anythingbutnil0(tonumber((input:gsub(",", "."))))
		else
			num_scale = anythingbutnil0(tonumber(s.scale))
		end
		local ved_w, ved_h = 896*num_scale, 480*num_scale
		if s.smallerscreen then
			ved_w = 800*num_scale
		end


		-- Display monitors
		love.graphics.setColor(12, 12, 12)
		love.graphics.rectangle("fill", 16, 125, love.graphics.getWidth()-32, 332)
		local total_monw, high_monh = -16, 0
		local monitors = {}
		local fits = false
		for mon = 1, love.window.getDisplayCount() do
			local monw, monh = love.window.getDesktopDimensions(mon)
			table.insert(monitors, {monw, monh})

			if monh > high_monh then
				high_monh = monh
			end
			total_monw = total_monw + monw + 16

			if windowfits(ved_w, ved_h, {monw, monh}) then
				fits = true
			end
		end
		local pixelscale = 1/math.max(total_monw/(love.graphics.getWidth()-96), high_monh/268)
		local currentmon_x = 0
		for k,v in pairs(monitors) do
			local monw, monh = unpack(v)
			local dispx = (love.graphics.getWidth()/2 - (total_monw*pixelscale)/2) + currentmon_x
			local dispy = 125 + (166 - (monh*pixelscale)/2)

			love.graphics.setColor(6, 6, 6)
			love.graphics.rectangle("fill", dispx-4, dispy-4, monw*pixelscale+8, monh*pixelscale+8)
			love.graphics.setColor(0, 0, 128)
			love.graphics.rectangle("fill", dispx, dispy, monw*pixelscale, monh*pixelscale)
			love.graphics.setColor(255, 255, 255)
			love.graphics.setScissor(dispx, dispy, monw*pixelscale+1, monh*pixelscale+1)
			love.graphics.draw(
				scaleimgs[s.smallerscreen],                         -- compensate for window borders in this image
				dispx + ((monw*pixelscale)/2 - (ved_w*pixelscale)/2) - 9*pixelscale*num_scale,
				dispy + ((monh*pixelscale)/2 - (ved_h*pixelscale)/2) - 30*pixelscale*num_scale,
				0, pixelscale*num_scale
			)
			love.graphics.setScissor()
			ved_printf(
				(love.window.getDisplayName ~= nil and love.window.getDisplayName(k) .. "\n" or "")
				.. langkeys(L.MONITORSIZE, {monw, monh}),
				dispx, 135 + (164 + (monh*pixelscale)/2), monw*pixelscale, "center"
			)
			currentmon_x = currentmon_x + monw*pixelscale + 16
		end

		ved_printf(langkeys(L.VEDRES, {ved_w, ved_h}), 0, 129, love.graphics.getWidth(), "center")


		if num_scale ~= tonumber(num_scale) or num_scale == nil or num_scale <= 0 then
			love.graphics.setColor(255,0,0)
			ved_print(L.SCALENONUM, 8, love.graphics.getHeight()-17)
			love.graphics.setColor(255,255,255)
		elseif not fits then
			love.graphics.setColor(255,0,0)
			ved_print(L.SCALENOFIT, 8, love.graphics.getHeight()-17)
			love.graphics.setColor(255,255,255)
		end


		rbutton({L.BTN_OK, "b"}, 0)


		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- Save
				exitdisplayoptions()
			end

			mousepressed = true
		end
	elseif state == 28 then
		-- Stats screen
		-- basic_stats has elements: {name, value, max}
		local p100 = love.graphics.getWidth() - 40 - basic_stats_max_text_width
		for k,v in pairs(basic_stats) do
			ved_print(v[1] .. " " .. v[2] .. "/" .. v[3], 16, 16*k)

			-- Background
			love.graphics.setColor(32, 32, 32)
			love.graphics.rectangle("fill",
				24+basic_stats_max_text_width, 16*k,
				p100, 8
			)
			-- Value
			local perone = v[2] / v[3]
			if perone >= 1 then
				-- limitglow can be between 0 and 2
				local glowadd = 0
				if perone > 1 then
					if limitglow > 1 then
						glowadd = 125*(2-limitglow)
					else
						glowadd = 125*limitglow
					end
				end
				love.graphics.setColor(130+glowadd,0,0)
			elseif perone >= .95 then
				love.graphics.setColor(255,0,0)
			elseif perone >= .8 then
				love.graphics.setColor(255,216,0)
			else
				love.graphics.setColor(38,127,0)
			end
			love.graphics.rectangle("fill",
				24+basic_stats_max_text_width, 16*k,
				math.min(perone, 1)*p100, 8
			)
			love.graphics.setColor(255,255,255)
		end

		rbutton({L.RETURN, "b"}, 0, nil, true)

		if nodialog and love.mouse.isDown("l") then
			if onrbutton(0, nil, true) then
				-- Return
				tostate(oldstate, true) -- keep the scrollbar "farness"
				mousepressed = true
			end
		end
	elseif state == 29 then
		-- Plural forms test
		int_control(20, 20, "val", 0, 9999, nil, plural_test)
		ved_print(langkeys(L_PLU.NUMUNSUPPORTEDPLUGINS, {plural_test.val}), 20, 70)
		ved_print(langkeys(L_PLU.ROOMINVALIDPROPERTIES, {0, plural_test.val}, 2), 20, 100)

		if nodialog and love.mouse.isDown("l") then
			-- Shrug
			mousepressed = true
		end
	elseif state == 30 then
		-- Assets
		local selecting
		for a = 0, 4 do
			love.graphics.setColor(128,128,128)
			love.graphics.rectangle("line", 16.5, 16.5+44*a, 744, 33)

			if mouseon(16.5, 16.5+44*a, 744, 33) and not mousepressed and nodialog then
				love.graphics.setColor(48,48,48)
				love.graphics.rectangle("fill", 17, 17+44*a, 743, 32)
				if love.mouse.isDown("l") then
					selecting = a
					mousepressed = true
				end
			end

			love.graphics.setColor(255,255,255)
			if a == 0 then
				love.graphics.draw(asset_pppppp, 21, 21)
				ved_print("vvvvvvmusic.vvv", 33, 21)
				ved_print(musicfileexists("vvvvvvmusic.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37)
			elseif a == 1 then
				love.graphics.draw(asset_mmmmmm, 21, 21+44)
				ved_print("mmmmmm.vvv", 33, 21+44)
				ved_print(musicfileexists("mmmmmm.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37+44)
			elseif a == 2 then
				love.graphics.draw(asset_musiceditor, 21, 21+88)
				ved_print(L.MUSICEDITOR, 33, 21+88)
				--ved_print(musicfileexists("mmmmmm.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37+88)
			elseif a == 3 then
				love.graphics.draw(asset_sounds, 21, 21+132)
				ved_print(L.SOUNDS, 33, 21+132)
			elseif a == 4 then
				love.graphics.draw(asset_graphics, 21, 21+176)
				ved_print(L.GRAPHICS, 33, 21+176)
			end

			if love.keyboard.isDown("f9") then
				local hotkey = ({"P", "sP", "M", "S", "G"})[a+1]
				showhotkey(hotkey, (17+744-1), (16+44*a)-2, ALIGN.RIGHT)
			end
		end

		if love.keyboard.isDown("p") then
			if keyboard_eitherIsDown("shift") then
				selecting = 1
			else
				selecting = 0
			end
		elseif love.keyboard.isDown("m") then
			selecting = 2
		elseif love.keyboard.isDown("s") then
			selecting = 3
		elseif love.keyboard.isDown("g") then
			selecting = 4
		end

		if selecting == 0 then
			tostate(31, false, "vvvvvvmusic.vvv")
		elseif selecting == 1 then
			tostate(31, false, "mmmmmm.vvv")
		elseif selecting == 2 then
			tostate(31, false, "musiceditor")
		elseif selecting == 3 then
			tostate(31, false, "sounds")
		elseif selecting == 4 then
			tostate(32)
		end

		rbutton({L.RETURN, "b"}, 0, nil, true)

		if nodialog and love.mouse.isDown("l") then
			if onrbutton(0, nil, true) then
				-- Return
				tostate(oldstate, true)
				mousepressed = true
			end
		end
	elseif state == 31 then
		-- Assets - music/sounds
		if musiceditor then
			if musiceditorfile == "" then
				ved_print(L.MUSICEDITOR, 16, 12)
			else
				ved_print(L.MUSICEDITOR .. " - " .. musiceditorfile, 16, 12)
			end
		elseif soundviewer then
			ved_print(L.SOUNDS, 16, 12)
		else
			ved_print(musicplayerfile, 16, 12)
		end
		file_metadata, file_metadata_anyset = getmusicmeta_file(musicplayerfile)
		local musicnamex_offset
		if musiceditor then
			musicnamex_offset = 76
		elseif file_metadata ~= nil then
			musicnamex_offset = 44
		else
			musicnamex_offset = 28
		end
		for mx = 0, (soundviewer and 1 or 0) do
			local musicx = mx == 0 and 16 or 396
			local musicnamex = musicx + musicnamex_offset
			local musicsizerx = soundviewer and musicx+316 or musicx+680
			local musicdurationx = soundviewer and musicx+332 or musicx+712
			if s.psmallerscreen and not soundviewer then
				musicsizerx = musicsizerx - 128 + 16
				musicdurationx = musicdurationx - 128 + 16
			end
			for my = 0, 15 do
				local m = mx*16 + my
				if (soundviewer and m > 27) or (not soundviewer and m > 15) then
					break
				end
				local audio = getmusicaudio(musicplayerfile, m)
				if audio == nil then
					love.graphics.setColor(64,64,64)
					love.graphics.draw(sound_play, musicx, 32+24*my)
					love.graphics.setColor(255,255,255)
				elseif currentmusic_file == musicplayerfile and currentmusic == m then
					hoverdraw(sound_play_current, musicx, 32+24*my, 16, 16)
				else
					hoverdraw(sound_play, musicx, 32+24*my, 16, 16)
				end
				local song_metadata, song_metadata_anyset
				if musiceditor or file_metadata ~= nil then
					song_metadata, song_metadata_anyset = getmusicmeta_song(musicplayerfile, m)
					if not musiceditor and not song_metadata_anyset then
						love.graphics.setColor(64,64,64)
						love.graphics.draw(infograybtn, musicx+16, 32+24*my)
						love.graphics.setColor(255,255,255)
					else
						local notes_set = song_metadata_anyset and song_metadata.notes ~= ""
						hoverdraw(notes_set and infobtn or infograybtn, musicx+16, 32+24*my, 16, 16)
					end
				end
				local can_remove = false
				local filedata = getmusicfiledata(musicplayerfile, m)
				if musiceditor then
					can_remove = filedata ~= nil
					hoverdraw(loadbtn, musicx+32, 32+24*my, 16, 16)
					if not can_remove then
						love.graphics.setColor(64,64,64)
						love.graphics.draw(eraser, musicx+48, 32+24*my)
						love.graphics.setColor(255,255,255)
					else
						hoverdraw(eraser, musicx+48, 32+24*my, 16, 16)
					end
				end
				if love.mouse.isDown("l") and not mousepressed and nodialog then
					if mouseon(musicx, 32+24*my, 16, 16) then
						-- Play
						if audio == nil then
							dialog.create(soundviewer and L.SOUNDPLAYERROR or L.MUSICPLAYERROR)
						else
							playmusic(musicplayerfile, m)
							mousepressed = true
						end
					elseif musiceditor and mouseon(musicx+16, 32+24*my, 16, 16) then
						-- Song metadata (editor)
						input = m
						dialog.create(
							"",
							DBS.OKCANCEL,
							dialog.callback.songmetadata,
							langkeys(L.SONGMETADATA, {m}),
							dialog.form.songmetadata_make(song_metadata)
						)
					elseif song_metadata_anyset and mouseon(musicx+16, 32+24*my, 16, 16) then
						-- Song metadata (player)
						dialog.create(
							L.MUSICTITLE .. song_metadata.name .. "\n\n"
							.. L.MUSICFILENAME .. song_metadata.filename .. "\n\n"
							.. L.MUSICNOTES .. "\n" .. song_metadata.notes
						)
					elseif musiceditor and mouseon(musicx+32, 32+24*my, 16, 16) then
						-- Replace
						input = m
						dialog.create(
							"",
							DBS.LOADCANCEL,
							dialog.callback.replacesong,
							langkeys(L.INSERTSONG, {m}),
							dialog.form.files_make(userprofile, "", ".ogg", true, 11)
						)
					elseif can_remove and mouseon(musicx+48, 32+24*my, 16, 16) then
						-- Remove
						input = m
						dialog.create(langkeys(L.SUREDELETESONG, {m}), DBS.YESNO, dialog.callback.suredeletesong)
					end
				end
				if getmusicedited(musicplayerfile, m) then
					love.graphics.setColor(255,0,0)
				end
				if soundviewer then
					ved_print(
						"[" .. fixdig(m, 2) .. "] " .. listsoundids[m]:sub(1, -5),
						musicnamex, 36+24*my
					)
				else
					ved_print(
						"[" .. fixdig(m, 2) .. "] " .. (m == 0 and "Path Complete" or listmusicids[m]),
						musicnamex, 36+24*my
					)
				end
				if song_metadata_anyset then
					local shown_name
					if song_metadata.name == "" then
						shown_name = song_metadata.filename
					else
						shown_name = song_metadata.name
					end
					love.graphics.setScissor(musicnamex+248, 36+24*my, 256, 8)
					ved_print(shown_name, musicnamex+248, 36+24*my)
					love.graphics.setScissor()
				end
				if not love_version_meets(10) then
					ved_print("?:??", musicdurationx, 36+24*my)
				elseif audio == nil then
					ved_print("-:--", musicdurationx, 36+24*my)
				else
					ved_print(mmss_duration(audio:getDuration()), musicdurationx, 36+24*my)
				end
				if filedata ~= nil then
					local readable_size = bytes_notation(filedata:getSize())
					love.graphics.setColor(128,128,128)
					ved_print(readable_size, musicsizerx-font8:getWidth(readable_size), 36+24*my)
				end
				love.graphics.setColor(255,255,255)
			end
		end

		local current_audio = getmusicaudioplaying()
		local cura_y = love.graphics.getHeight()-32
		local width = 568
		if s.psmallerscreen then
			width = width - 128 + 16
		end
		if current_audio == nil then
			love.graphics.setColor(64,64,64)
			love.graphics.draw(sound_play, 16, cura_y)
			love.graphics.draw(sound_stop, 32, cura_y)
			love.graphics.draw(sound_rewind, 48, cura_y)
			ved_print("[--] -:--", 72, cura_y+4)
			love.graphics.rectangle("fill", 152, cura_y+4, width, 8)
			ved_print("-:--", width+160, cura_y+4)
			love.graphics.setColor(255,255,255)
		else
			hoverdraw(currentmusic_paused and sound_play or sound_pause, 16, cura_y, 16, 16)
			hoverdraw(sound_stop, 32, cura_y, 16, 16)
			hoverdraw(sound_rewind, 48, cura_y, 16, 16)
			local elapsed = current_audio:tell()
			ved_print("[" .. fixdig(currentmusic, 2) .. "] " .. mmss_duration(elapsed), 72, cura_y+4)
			if nodialog and not mousepressed and love.mouse.isDown("l") then
				if mouseon(16, cura_y, 16, 16) then
					-- Play/pause
					if currentmusic_paused then
						resumemusic()
					else
						pausemusic()
					end
					mousepressed = true
				elseif mouseon(32, cura_y, 16, 16) then
					-- Stop
					stopmusic()
					mousepressed = true
				elseif mouseon(48, cura_y, 16, 16) then
					-- Rewind
					current_audio:seek(0)
					mousepressed = true
				end
			end
			local duration
			if love_version_meets(10) then
				duration = current_audio:getDuration()
			end
			love.graphics.setColor(128,128,128)
			love.graphics.rectangle("fill", 152, cura_y+4, width, 8)
			love.graphics.setColor(255,255,255)
			if duration ~= nil and duration ~= 0 then
				love.graphics.rectangle("fill", 152, cura_y+4, (elapsed/duration)*width, 8)
				if nodialog and not mousepressed and mouseon(152, cura_y+4, width, 8) then
					local mouse_elapsed = ((love.mouse.getX()-152)/width)*duration
					ved_print(mmss_duration(mouse_elapsed), love.mouse.getX()-16, cura_y-10)
					if love.mouse.isDown("l") then
						current_audio:seek(mouse_elapsed)
						mousepressed = true
					end
				end
			end
			ved_print(mmss_duration(duration), width+160, cura_y+4)
			showhotkey(" ", 16+16, cura_y-2, ALIGN.RIGHT)
			showhotkey("h", 48+16, cura_y-2, ALIGN.RIGHT)
		end

		rbutton({L.RETURN, "b"}, 0, nil, true)
		rbutton({musiceditor and L.LOAD or (musicfileexists(musicplayerfile) and L.RELOAD or L.LOAD), "L"}, 2, nil, true, nil, generictimer_mode == 1 and generictimer > 0)
		if musiceditor then
			rbutton({L.SAVE, "S"}, 3, nil, true)
		end
		if musiceditor then
			rbutton({L.MUSICFILEMETADATA, "M"}, 5, nil, true)
		elseif file_metadata_anyset then
			rbutton({L.MUSICFILEMETADATA, "M"}, 4, nil, true)
		end

		if nodialog and love.mouse.isDown("l") then
			if onrbutton(0, nil, true) then
				-- Return
				tostate(30, true)
				oldstate = olderstate
				mousepressed = true
			elseif onrbutton(2, nil, true) then
				-- Reload/Load
				if musiceditor then
					assets_musicloaddialog()
				else
					assets_musicreload()
				end
				mousepressed = true
			elseif musiceditor and onrbutton(3, nil, true) then
				-- Save
				assets_savedialog()
			elseif musiceditor and onrbutton(5, nil, true) then
				-- File metadata (editor)
				assets_metadataeditordialog()
			elseif not musiceditor and file_metadata_anyset and onrbutton(4, nil, true) then
				-- File metadata (player)
				assets_metadataplayerdialog()
			end
		elseif nodialog and love.mouse.isDown("r") and onrbutton(2, nil, true) and musicfileexists(musicplayerfile) then
			-- Reload right click menu
			rightclickmenu.create({"#" .. musicplayerfile, L.UNLOAD}, "assets_music_load")
		end
	elseif state == 32 then
		-- Assets - graphics
		love.graphics.setColor(12,12,12,255)
		love.graphics.rectangle("fill", 8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
		love.graphics.setColor(255,255,255,255)
		if imageviewer_image_color ~= nil then
			love.graphics.setScissor(8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
			--[[
			love.graphics.setColor(0,0,0,255)
			love.graphics.rectangle(
				"fill", imageviewer_x, imageviewer_y,
				imageviewer_w*imageviewer_s, imageviewer_h*imageviewer_s
			)
			love.graphics.setColor(255,255,255,255)
			]]
			love.graphics.draw(
				imageviewer_showwhite and imageviewer_image_white or imageviewer_image_color,
				imageviewer_x, imageviewer_y, 0, imageviewer_s
			)
			local grid_tile
			if imageviewer_grid ~= 0 and nodialog
			and mouseon(8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
			and mouseon(imageviewer_x, imageviewer_y, imageviewer_w*imageviewer_s, imageviewer_h*imageviewer_s) then
				local hover_x = (love.mouse.getX()-imageviewer_x)/imageviewer_s
				local hover_y = (love.mouse.getY()-imageviewer_y)/imageviewer_s
				local hover_tx, hover_ty = math.floor(hover_x/imageviewer_grid), math.floor(hover_y/imageviewer_grid)

				love.graphics.setColor(192,192,192,128)
				love.graphics.rectangle("fill",
					imageviewer_x + hover_tx*imageviewer_grid*imageviewer_s,
					imageviewer_y + hover_ty*imageviewer_grid*imageviewer_s,
					imageviewer_grid*imageviewer_s, imageviewer_grid*imageviewer_s
				)
				love.graphics.setColor(255,255,255,255)

				if imageviewer_grid == 1 then
					grid_tile = hover_tx .. "," .. hover_ty
				else
					grid_tile = hover_tx + hover_ty*math.ceil(imageviewer_w/imageviewer_grid)
				end
			end
			love.graphics.setScissor()
			ved_print(L.GRAPHICS .. " - " .. imageviewer_filepath, 8, 4)

			local check_w = font8:getWidth(L.NOTALPHAONLY)+24
			local check_x = love.graphics.getWidth()-64-check_w/2
			checkbox(not imageviewer_showwhite, check_x, love.graphics.getHeight()-288, nil, L.NOTALPHAONLY,
				function(key, newvalue)
					imageviewer_showwhite = not newvalue
				end
			)
			showhotkey("R", check_x+16, love.graphics.getHeight()-288-2, ALIGN.RIGHT)

			ved_printf(
				L.GRID,
				love.graphics.getWidth()-128, love.graphics.getHeight()-236, 128, "center"
			)
			custom_int_control(
				love.graphics.getWidth()-100, love.graphics.getHeight()-216,
				imageviewer_gridout, imageviewer_gridin, nil,
				function()
					if imageviewer_grid == 0 then
						return "--"
					else
						return imageviewer_grid
					end
				end, 32
			)
			if grid_tile ~= nil then
				love.graphics.setColor(255,255,64,255)
				if imageviewer_w/imageviewer_grid ~= math.ceil(imageviewer_w/imageviewer_grid) then
					grid_tile = "(" .. grid_tile .. ")"
				end
				ved_printf(
					grid_tile,
					love.graphics.getWidth()-128, love.graphics.getHeight()-188, 128, "center"
				)
				love.graphics.setColor(255,255,255,255)
			end

			custom_int_control(
				love.graphics.getWidth()-100, love.graphics.getHeight()-144,
				imageviewer_zoomout, imageviewer_zoomin, nil,
				function()
					return (imageviewer_s*100) .. "%"
				end, 32
			)
			showhotkey("-", love.graphics.getWidth()-100+16, love.graphics.getHeight()-144-2, ALIGN.RIGHT)
			showhotkey("+", love.graphics.getWidth()-100+64+8, love.graphics.getHeight()-144-2, ALIGN.RIGHT)
			ved_printf(
				imageviewer_w .. L.X .. imageviewer_h,
				love.graphics.getWidth()-128, love.graphics.getHeight()-116, 128, "center"
			)
		else
			ved_print(L.GRAPHICS, 8, 4)
		end

		rbutton({L.RETURN, "b"}, 0, nil, true)
		rbutton({L.LOAD, "L"}, 2, nil, true)

		if nodialog and love.mouse.isDown("l") and not mousepressed then
			if onrbutton(0, nil, true) then
				-- Return
				tostate(30, true)
				oldstate = olderstate
				mousepressed = true
			elseif onrbutton(2, nil, true) then
				-- Load
				assets_graphicsloaddialog()
				mousepressed = true
			end
		end
	elseif state == 33 then
		local language_x = love.graphics.getWidth()/2-64-widestlang
		ved_print(L.LANGUAGE, language_x, 32+4)

		for k,v in pairs(alllanguages) do
			radio(s.lang == v, language_x, 32+(24*k), v, v,
				function(key)
					changelanguage(v)
				end
			)
		end

		local dateformat_x = love.graphics.getWidth()/2+64
		local year = os.date("%Y")
		ved_print(L.DATEFORMAT, dateformat_x, 32+4)

		for k,v in pairs({
			{"YMD", year .. "-12-31"},
			{"DMY", "31-12-" .. year},
			{"MDY", "12/31/" .. year},
		}) do
			radio(s.new_dateformat == v[1], dateformat_x, 32+(24*k), v[1], v[2],
				function(key)
					s.new_dateformat = v[1]
				end
			)
		end

		ved_print(L.TIMEFORMAT, dateformat_x, 32+96+24+4)

		for k,v in pairs({
			{24, "23:59"},
			{12, "11:59pm"}
		}) do
			radio(s.new_timeformat == v[1], dateformat_x, 32+96+24+(24*k), v[1], v[2],
				function(key)
					s.new_timeformat = v[1]
				end
			)
		end

		local bottomleft_text = L.TRANSLATIONCREDIT
		if s.lang == "English" then
			-- Yeah, hardcoded text!
			bottomleft_text = "Want to help translate Ved? Please contact Dav999!"
		end

		ved_printf(bottomleft_text, 64, love.graphics.getHeight()-40, love.graphics.getWidth()-128, "center")


		rbutton({L.BTN_OK, "b"}, 0)


		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- Save
				exitlanguageoptions()
			end

			mousepressed = true
		end
	else
		statecaught = false

		hook("love_draw_state")

		if not statecaught then
			fatalerror(langkeys(L.UNKNOWNSTATE, {state, oldstate}))
		end
	end

	if uis[state] ~= nil and uis[state].draw ~= nil then
		-- A UI can have its own dedicated drawing function and not use elements, sure.
		uis[state].draw(dt)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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
		drawentitysprite(22, middlescroll_x-16, middlescroll_y-16, false)
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
			drawentitysprite(22, v.x-v.ox, v.y-v.oy, false)
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

	-- Taking input warning
	if allowdebug and takinginput then
		love.graphics.setColor(255,160,0,192)
		love.graphics.rectangle("fill", 128, love.graphics.getHeight()-16, 128, 16)
		love.graphics.setColor(255,255,255,255)
		ved_printf("TAKING INPUT", 128, love.graphics.getHeight()-12, 128, "center")
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

	if updatescrollingtext ~= nil and state == 6 then
		updatescrollingtext_pos = updatescrollingtext_pos + 55*dt
		if updatescrollingtext_pos > font8:getWidth(updatescrollingtext) + 112 then
			updatescrollingtext_pos = 0
		end
	end
	if current_scrolling_leveltitle_k ~= nil and state == 6 then
		current_scrolling_leveltitle_pos = current_scrolling_leveltitle_pos + 55*dt
		if current_scrolling_leveltitle_pos > font8:getWidth(anythingbutnil(current_scrolling_leveltitle_title)) + 168 then
			current_scrolling_leveltitle_pos = 0
		end
	end
	if current_scrolling_levelfilename_k ~= nil and state == 6 then
		current_scrolling_levelfilename_pos = current_scrolling_levelfilename_pos + 55*dt
		if current_scrolling_levelfilename_pos > font8:getWidth(current_scrolling_levelfilename_filename) + (s.psmallerscreen and 50-12 or 50)*8 then
			current_scrolling_levelfilename_pos = 0
		end
	end

	if state == 28 and limitglow_enabled then
		limitglow = limitglow + dt

		if limitglow > 2 then
			limitglow = limitglow - 2
		end
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
							newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
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
							newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
						}
					)
				end
				table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
				finish_undo("PLATFORM BOUNDS (tool canceled)")
			end

			editingbounds = 0
		end

		if levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 3 then
			warpbganimation = (warpbganimation + 2) % 64
		elseif levelmetadata[(roomy)*20 + (roomx+1)].warpdir ~= 0 then
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
		local chanmessage = allmetadata_outchannel:pop()

		if chanmessage ~= nil and chanmessage.refresh == levels_refresh then
			-- This file could have been (visually) removed by the debug function Shift+F3
			if files[chanmessage.dir][chanmessage.id] ~= nil then
				files[chanmessage.dir][chanmessage.id].metadata = chanmessage
			end

			-- Is this also the metadata for any recent file? TODO: Support subdirectories
			for k,v in pairs(s.recentfiles) do
				if chanmessage.path == v .. ".vvvvvv" then
					recentmetadata_files[v] = chanmessage.id
				end
			end
		end
	elseif state == 15 and s.psmallerscreen then
		local leftpartw = 8+200+8-96-2
		local extrawidth = 0
		if helprefreshable then
			extrawidth = 20
		end
		if love.mouse.getX() <= leftpartw then
			onlefthelpbuttons = true
		elseif love.mouse.getX() > 25*8+16-28+extrawidth then
			onlefthelpbuttons = false
		end
	elseif state == 32 and imageviewer_image_color ~= nil and nodialog then
		if imageviewer_moving then
			imageviewer_x = imageviewer_moved_from_x + (love.mouse.getX()-imageviewer_moved_from_mx)
			imageviewer_y = imageviewer_moved_from_y + (love.mouse.getY()-imageviewer_moved_from_my)
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("left", "kp4", "a") then
			imageviewer_x = imageviewer_x + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("right", "kp6", "d") then
			imageviewer_x = imageviewer_x - 1200*dt
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("up", "kp8", "w") then
			imageviewer_y = imageviewer_y + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("down", "kp2", "s") then
			imageviewer_y = imageviewer_y - 1200*dt
			fix_imageviewer_position()
		end

		if love.keyboard.isDown("pageup") then
			imageviewer_x, imageviewer_y = 8, 16
			fix_imageviewer_position()
		elseif love.keyboard.isDown("pagedown") then
			imageviewer_x, imageviewer_y = -imageviewer_w*imageviewer_s, -imageviewer_h*imageviewer_s
			fix_imageviewer_position()
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

	if coordsdialog.active or RCMactive or dialog.is_open() then
		nodialog = false
	elseif not love.mouse.isDown("l") then
		nodialog = true
	end

	-- Right click menu
	if RCMreturn ~= nil and RCMreturn ~= "" then
		if RCMid:sub(1, 4) == "ent_" then
			-- Something to do with an entity.
			entdetails = explode("_", RCMid)
			if entitydata[tonumber(entdetails[3])] ~= nil then
				if RCMreturn == L.DELETE then
					removeentity(tonumber(entdetails[3]), tonumber(entdetails[2]))
				elseif RCMreturn == L.MOVEENTITY then
					movingentity = tonumber(entdetails[3])
				elseif RCMreturn == L.COPY or RCMreturn == L.COPYENTRANCE then
					setcopyingentity(tonumber(entdetails[3]))
				elseif RCMreturn == L.PROPERTIES then
					-- Edit properties of this entity, whatever it is. But if we were editing room text or a name of something, stop that first.
					if editingroomtext > 0 then
						-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the properties of
						endeditingroomtext(tonumber(entdetails[3]))
					end

					thisentity = entitydata[tonumber(entdetails[3])]
					dialog.create(
						L.RAWENTITYPROPERTIES .. "\n\nx\ny\nt\np1\np2\np3\np4\np5\np6\n" .. L.SMALLENTITYDATA,
						DBS.OKCANCELAPPLY,
						dialog.callback.rawentityproperties,
						(allowdebug and "[ID: " .. tonumber(entdetails[3]) .. "] (do not rely on the ID)" or ""),
						dialog.form.rawentityproperties_make(),
						dialog.callback.noclose_on.apply
					)
				elseif tonumber(entdetails[2]) == 1 then
					-- Enemy
					if RCMreturn == L.CHANGEDIRECTION then
						local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 3, 0)
						rcm_changingentity(entdetails, {p1 = new_p1})
						entitydata[tonumber(entdetails[3])].p1 = new_p1
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 2 then
					-- Platform, moving/conveyor
					if RCMreturn == L.CYCLETYPE then
						local new_p1
						if entitydata[tonumber(entdetails[3])].p1 < 4 then
							-- Moving platform
							new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 3, 0)
						else
							-- Conveyor
							new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 8, 5)
						end
						rcm_changingentity(entdetails, {p1 = new_p1})
						entitydata[tonumber(entdetails[3])].p1 = new_p1
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 10 then
					-- Checkpoint
					if RCMreturn == L.FLIP then
						local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
						rcm_changingentity(entdetails, {p1 = new_p1})
						entitydata[tonumber(entdetails[3])].p1 = new_p1
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 11 then
					-- Gravity line
					local old_p1 = entitydata[tonumber(entdetails[3])].p1
					local old_p2 = entitydata[tonumber(entdetails[3])].p2
					local old_p3 = entitydata[tonumber(entdetails[3])].p3
					local old_p4 = entitydata[tonumber(entdetails[3])].p4
					local new_p1, new_p4
					if RCMreturn == L.CHANGETOHOR then
						new_p1 = 0
						new_p4 = old_p4
					elseif RCMreturn == L.CHANGETOVER then
						new_p1 = 1
						new_p4 = old_p4
					elseif RCMreturn == L.UNLOCK then
						new_p1 = old_p1
						new_p4 = 0
					elseif RCMreturn == L.LOCK then
						new_p1 = old_p1
						new_p4 = 1
					end
					entitydata[tonumber(entdetails[3])].p1 = new_p1
					entitydata[tonumber(entdetails[3])].p4 = new_p4
					autocorrectlines()
					table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = tonumber(entdetails[3]), changedentitydata = {
								{
									key = "p1",
									oldvalue = old_p1,
									newvalue = new_p1
								},
								{
									key = "p2",
									oldvalue = old_p2,
									newvalue = entitydata[tonumber(entdetails[3])].p2
								},
								{
									key = "p3",
									oldvalue = old_p3,
									newvalue = entitydata[tonumber(entdetails[3])].p3
								},
								{
									key = "p4",
									oldvalue = old_p4,
									newvalue = entitydata[tonumber(entdetails[3])].p4
								}
							}
						}
					)
					finish_undo("CHANGED ENTITY (GRAVLINE)")
				elseif tonumber(entdetails[2]) == 13 then
					-- Warp token
					if RCMreturn == L.GOTODESTINATION then
						gotoroom(math.floor(entitydata[tonumber(entdetails[3])].p1 / 40), math.floor(entitydata[tonumber(entdetails[3])].p2 / 30))
						love.mouse.setPosition(64+64 + (entitydata[tonumber(entdetails[3])].p1 - (roomx*40))*16 + 8 - (s.psmallerscreen and 96 or 0), (entitydata[tonumber(entdetails[3])].p2 - (roomy*30))*16 + 8)
						cons("Destination token is at " .. entitydata[tonumber(entdetails[3])].p1 .. " " .. entitydata[tonumber(entdetails[3])].p2 .. "... So at " .. entitydata[tonumber(entdetails[3])].p1 - (roomx*40) .. " " .. entitydata[tonumber(entdetails[3])].p2 - (roomy*30) .. " in room " .. roomx .. " " .. roomy)
					elseif RCMreturn == L.GOTOENTRANCE then
						gotoroom(math.floor(entitydata[tonumber(entdetails[3])].x / 40), math.floor(entitydata[tonumber(entdetails[3])].y / 30))
						love.mouse.setPosition(64+64 + (entitydata[tonumber(entdetails[3])].x - (roomx*40))*16 + 8 - (s.psmallerscreen and 96 or 0), (entitydata[tonumber(entdetails[3])].y - (roomy*30))*16 + 8)
						cons("Entrance token is at " .. entitydata[tonumber(entdetails[3])].x .. " " .. entitydata[tonumber(entdetails[3])].y .. "... So at " .. entitydata[tonumber(entdetails[3])].x - (roomx*40) .. " " .. entitydata[tonumber(entdetails[3])].y - (roomy*30) .. " in room " .. roomx .. " " .. roomy)
					elseif RCMreturn == L.CHANGEENTRANCE then
						selectedtool = 14
						selectedsubtool[14] = 3
						warpid = tonumber(entdetails[3])
					elseif RCMreturn == L.CHANGEEXIT then
						selectedtool = 14
						selectedsubtool[14] = 4
						warpid = tonumber(entdetails[3])
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 15 then
					-- Rescuable crewmate
					if RCMreturn == L.CHANGECOLOR then
						local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 5, 0)
						rcm_changingentity(entdetails, {p1 = new_p1})
						entitydata[tonumber(entdetails[3])].p1 = new_p1
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 16 then
					-- Start point
					if RCMreturn == L.CHANGEDIRECTION then
						local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
						rcm_changingentity(entdetails, {p1 = new_p1})
						entitydata[tonumber(entdetails[3])].p1 = new_p1
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 17 then
					-- Roomtext
					if RCMreturn == L.EDITTEXT then
						-- Were we already editing roomtext or a name?
						if editingroomtext > 0 then
							-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the text of
							endeditingroomtext(tonumber(entdetails[3]))
						end

						startinput()
						input = entitydata[tonumber(entdetails[3])].data
						editingroomtext = tonumber(entdetails[3])
						makescriptroomtext = false
					elseif RCMreturn == L.COPYTEXT then
						love.system.setClipboardText(entitydata[tonumber(entdetails[3])].data)
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 18 or tonumber(entdetails[2]) == 19 then
					-- Terminal or script box
					if RCMreturn == L.EDITSCRIPT then
						-- Were we already editing roomtext or a name?
						if editingroomtext > 0 then
							-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the script of
							endeditingroomtext(tonumber(entdetails[3]))
						end

						if scripts[entitydata[tonumber(entdetails[3])].data] == nil then
							dialog.create(langkeys(L.SCRIPT404, {entitydata[tonumber(entdetails[3])].data}))
						else
							scriptineditor(entitydata[tonumber(entdetails[3])].data)
						end
					elseif RCMreturn == L.OTHERSCRIPT then
						-- Were we already editing roomtext or a name?
						if editingroomtext > 0 then
							-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the name of
							endeditingroomtext(tonumber(entdetails[3]))
						end

						startinput()
						input = entitydata[tonumber(entdetails[3])].data
						editingroomtext = tonumber(entdetails[3])
						makescriptroomtext = true
					elseif RCMreturn == L.RESIZE then -- only for script boxes obviously
						editingsboxid = tonumber(entdetails[3])
						selectedsubtool[13] = 3
						selectedtool = 13
					elseif RCMreturn == toolnames[12] then
						local ret = namefound(entitydata[tonumber(entdetails[3])])
						if ret == 1 then
							s_nieuw(tonumber(entdetails[3]))
						elseif ret == -1 then
							p_nieuw(tonumber(entdetails[3]))
						end
					else
						dialog.create(RCMid .. " " .. RCMreturn .. " not supported yet.")
					end
				elseif tonumber(entdetails[2]) == 50 then
					-- Warp line
					local old_p1 = entitydata[tonumber(entdetails[3])].p1
					local old_p2 = entitydata[tonumber(entdetails[3])].p2
					local old_p3 = entitydata[tonumber(entdetails[3])].p3
					local old_p4 = entitydata[tonumber(entdetails[3])].p4
					local new_p4
					if RCMreturn == L.UNLOCK then
						new_p4 = 0
					elseif RCMreturn == L.LOCK then
						new_p4 = 1
					end
					entitydata[tonumber(entdetails[3])].p4 = new_p4
					autocorrectlines()
					table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = tonumber(entdetails[3]), changedentitydata = {
								{
									key = "p1",
									oldvalue = old_p1,
									newvalue = new_p1
								},
								{
									key = "p2",
									oldvalue = old_p2,
									newvalue = entitydata[tonumber(entdetails[3])].p2
								},
								{
									key = "p3",
									oldvalue = old_p3,
									newvalue = entitydata[tonumber(entdetails[3])].p3
								},
								{
									key = "p4",
									oldvalue = old_p4,
									newvalue = entitydata[tonumber(entdetails[3])].p4
								}
							}
						}
					)
					finish_undo("CHANGED ENTITY (WARPLINE)")
				else
					dialog.create(langkeys(L.UNKNOWNENTITYTYPE, {anythingbutnil(entdetails[2])}) .. ",\n\nID: " .. RCMid .. "\nReturn value: " .. RCMreturn)
				end
			else
				dialog.create(langkeys(L.ENTITY404, {tonumber(entdetails[3])}))
			end
		elseif RCMid:sub(1, 4) == "spt_" then
			local rvnum = tonumber(RCMid:sub(5, -1))

			if RCMreturn == L.EDIT then
				scriptineditor(scriptnames[rvnum], rvnum)
			elseif RCMreturn == L.EDITWOBUMPING then
				scriptineditor(scriptnames[rvnum], -1)
			elseif RCMreturn == L.COPYNAME then
				love.system.setClipboardText(scriptnames[rvnum])
			elseif RCMreturn == L.COPYCONTENTS then
				love.system.setClipboardText(table.concat(scripts[scriptnames[rvnum]], (love.system.getOS() == "Windows" and "\r\n" or "\n")))
			elseif RCMreturn == L.DUPLICATE then
				dialog.create(
					L.NEWSCRIPTNAME, DBS.OKCANCEL,
					dialog.callback.newscript, L.DUPLICATE, dialog.form.simplename,
					dialog.callback.newscript_validate, "duplicate_list"
				)
				input = rvnum
			elseif RCMreturn == L.DELETE then
				input = rvnum
				if keyboard_eitherIsDown("shift") then
					dialog.callback.suredeletescript(DB.YES)
				else
					dialog.create(
						langkeys(L.SUREDELETESCRIPT, {scriptnames[rvnum]}), DBS.YESNO,
						dialog.callback.suredeletescript
					)
				end
			elseif RCMreturn == L.RENAME then
				dialog.create(
					L.NEWNAME, DBS.OKCANCEL,
					dialog.callback.renamescript, L.RENAMESCRIPT,
					{
						{"name", 0, 1, 40, scriptnames[rvnum], DF.TEXT},
						{"references", 0, 3, 2+font8:getWidth(L.RENAMESCRIPTREFERENCES)/8, true, DF.CHECKBOX},
						{"", 2, 3, 40, L.RENAMESCRIPTREFERENCES, DF.LABEL},
					},
					dialog.callback.renamescript_validate
				)
				input = rvnum
			else
				unrecognized_rcmreturn()
			end
		elseif RCMid:sub(1, 4) == "bul_" then
			if RCMreturn == L.SAVEBACKUP then
				dialog.create(
					L.ENTERNAMESAVE .. "\n\n\n" .. L.SAVEBACKUPNOBACKUP, DBS.OKCANCEL,
					dialog.callback.savebackup, L.SAVEBACKUP, dialog.form.simplename
				)
				input = RCMid:sub(5, -1)
			else
				unrecognized_rcmreturn()
			end
		elseif RCMid:sub(1, 4) == "lnk_" then
			if RCMreturn == L.COPYLINK then
				love.system.setClipboardText(RCMid:sub(5, -1))
			else
				unrecognized_rcmreturn()
			end
		elseif RCMid:sub(1, 4) == "dia_" then
			-- New-style dialog dropdown
			if dialog.is_open() then
				dialogs[#dialogs]:dropdown_onchange(RCMid:sub(5, -1), RCMreturn)
			end
		elseif RCMid == "assets_music_load" then
			-- Reload button
			if RCMreturn == L.UNLOAD then
				unloadvvvvvvmusic(musicplayerfile)
				collectgarbage("collect")
			else
				unrecognized_rcmreturn()
			end
		else
			dialog.create("Unhandled right click menu!\n\nID: " .. RCMid .. "\nReturn value: " .. RCMreturn)
		end

		RCMreturn = ""
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

	if uis[state] ~= nil and uis[state].update ~= nil then
		uis[state].update(dt)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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
end

function love.textinput(char)
	if focusregainedtimer < .1 then
		return
	end

	-- Ved should really only accept printable ASCII only when typing...
	if s.acceptutf8 or (state == 13 or state == 15 or char:byte(2, 2) == nil) then
		-- Textual input isn't needed with a dialog on the screen, we have multiinput
		if takinginput and not dialog.is_open() then
			-- Ugly, but at least won't need another global variable that appears here and there
			if (state == 1) and not nodialog and editingroomname and (char:lower() == "e") then
			elseif (state == 3) and not nodialog and (char == "/" or char == "?") then
			-- Pipes are newlines on PC and dollar signs are newlines on 3DS
			elseif (state == 3) and
			((not PleaseDo3DSHandlingThanks and char == "|") or
			(PleaseDo3DSHandlingThanks and char == "$")) then
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
					if char ~= "/" and char ~= "?" then
						-- But we don't want pressing '/' to not dirty when we're actually typing
						nodialog = true
					else
						dirty()
					end
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
	end

	if coordsdialog.active then
		coordsdialog.type(char)
	end

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	if uis[state] ~= nil and uis[state].textinput ~= nil then
		uis[state].textinput(char)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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
				-- Let's process people trying to sneak past pipes and dollar signs first before processing newlines
				if not PleaseDo3DSHandlingThanks and input:find("|") then
					input = input:gsub("|", "\n")
				elseif PleaseDo3DSHandlingThanks and input:find("%$") then
					input = input:gsub("%$", "\n")
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

	if dialog.is_open() then
		dialogs[#dialogs]:keypressed(key)
		return
	elseif state == 0 and table.contains({"return", "kpenter"}, key) and keyboard_eitherIsDown("shift") then
		stopinput()
		tostate(input, true)
	elseif state == 0 and table.contains({"return", "kpenter"}, key) then
		stopinput()
		tostate(input)
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

		if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
			if table.contains({"left", "a"}, key) then
				selectedtile = selectedtile - 1
			elseif table.contains({"right", "d"}, key) then
				selectedtile = (selectedtile + 1) % 1200
			elseif table.contains({"up", "w"}, key) then
				selectedtile = selectedtile - 40
			elseif table.contains({"down", "s"}, key) then
				selectedtile = (selectedtile + 40) % 1200
			end
		end

		if selectedtile < 0 then
			selectedtile = selectedtile + 1200
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
			if selectedtool < 17 then
				selectedtool = selectedtool + 1
			else
				selectedtool = 1
			end
			updatewindowicon()
			toolscroll()
		end

	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "q" then
		coordsdialog.activate()
	elseif coordsdialog.active and key == "escape" then
		coordsdialog.active = false
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and (key == "m" or key == "kp5") then
		tostate(12)
		return -- temporary, until state 1 got GUI overhaul and this is in ui.keypressed
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "/" then
		if keyboard_eitherIsDown(ctrl) then
			tonotepad()
		else
			tostate(10)
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
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
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
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
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
				oldbounds[k] = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
			end

			levelmetadata[(roomy)*20 + (roomx+1)].enemyx1, levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 = 0, 0
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx2, levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = 320, 240

			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (deleted)")
		else
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				oldbounds[k] = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
			end

			levelmetadata[(roomy)*20 + (roomx+1)].platx1, levelmetadata[(roomy)*20 + (roomx+1)].platy1 = 0, 0
			levelmetadata[(roomy)*20 + (roomx+1)].platx2, levelmetadata[(roomy)*20 + (roomx+1)].platy2 = 320, 240

			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (deleted)")
		end

		editingbounds = 0
	elseif nodialog and movingentity ~= 0 and state == 1 and key == "escape" then
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
		cons("*** TILESET COLOR CREATOR STARTED FOR TILESET " .. usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset] .. " ***")
		cons("First select the wall tiles")

		tilescreator = true
		cb = {}
		ca = {}
		cs = {}
		creatorstep = 1
		creatorsubstep = 1

		selectedtileset = "creator"
		selectedcolor = "creator"

		tilesetblocks.creator.tileimg = usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]

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
	elseif nodialog and state == 1 and key == "f1" then
		-- Change tileset
		switchtileset()
		temporaryroomname = langkeys(L.TILESETCHANGEDTO, {(tilesetblocks[selectedtileset].name ~= nil and (tilesetblocks[selectedtileset].longname ~= nil and tilesetblocks[selectedtileset].longname or tilesetblocks[selectedtileset].name) or selectedtileset)})
		temporaryroomnametimer = 90
	elseif nodialog and state == 1 and key == "f2" then
		-- Change tilecol
		switchtilecol()
		temporaryroomname = langkeys(L.TILESETCOLORCHANGEDTO, {(tilesetblocks[selectedtileset].colors[selectedcolor].name ~= nil and tilesetblocks[selectedtileset].colors[selectedcolor].name or langkeys(L.TSCOLOR, {selectedcolor}))})
		temporaryroomnametimer = 90
	elseif nodialog and state == 1 and key == "f3" then
		-- Change enemy type
		switchenemies()
		temporaryroomname = L.ENEMYTYPECHANGED
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and key == "f4" then
		-- Enemy bounds
		changeenemybounds()
	elseif nodialog and editingroomtext == 0 and editingroomname == false and state == 1 and key == "f5" then
		-- Platform bounds
		changeplatformbounds()
	elseif nodialog and state == 1 and key == "f10" then
		-- Auto/manual mode
		changedmode()
		temporaryroomname = langkeys(L.CHANGEDTOMODE, {(levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 and L.CHANGEDTOMODEMANUAL or (levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 and L.CHANGEDTOMODEMULTI or L.CHANGEDTOMODEAUTO))})
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "w") then
		-- Change warp dir
		changewarpdir()
		temporaryroomname = warpdirchangedtext[levelmetadata[(roomy)*20 + (roomx+1)].warpdir]
		temporaryroomnametimer = 90
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "e") then
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
			savedsuccess, savederror = savelevel(editingmap .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, false)

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
	elseif nodialog and (state == 1 or state == 6) and key == "n" and keyboard_eitherIsDown(ctrl) then
		-- New level?
		if state == 6 and not state6old1 then
			stopinput()
			triggernewlevel()
			-- Don't immediately trigger the dialog in state 1!
			nodialog = false
		elseif has_unsaved_changes() then
			-- Else block also runs if state == 6 and state6old1, and thus makes a dialog appear; hey a free feature!
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
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 5 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 or selectedtool == 10 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 2

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "x" then
			-- 5x5 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 3

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "c" then
			-- Alright, 7x7 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 4

				if not keyboard_eitherIsDown("shift") then
					holdingzvx = true
				end
			end
		elseif key == "v" then
			-- And 9x9 brush
			if selectedtool == 1 or selectedtool == 2 then
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
	elseif (state == 1 or state == 6) and nodialog and key == "f11" and temporaryroomnametimer == 0 and not keyboard_eitherIsDown(ctrl) then
		-- Reload tilesets
		loadtilesets()
		loadfonts()
		tile_batch_texture_needs_update = true
		map_init()
		temporaryroomname = L.TILESETSRELOADED
		temporaryroomnametimer = 90
	elseif state == 1 and selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode ~= 0 and (key == "lshift" or key == "rshift") then
		if customsizemode <= 2 then
			customsizemode = 3
		else
			customsizemode = 1
		end
	elseif state == 1 and nodialog and editingbounds == 0 and editingroomtext == 0 and not editingroomname and not tilespicker_shortcut and key == "escape" then
		tilespicker = false
	elseif state == 3 and (key == "up" or key == "down" or key == "pageup" or key == "pagedown") then
		if key == "up" then
			scriptgotoline(editingline-1)
		elseif key == "down" then
			scriptgotoline(editingline+1)
		elseif key == "pageup" then
			scriptgotoline(editingline-57)
		elseif key == "pagedown" then
			scriptgotoline(editingline+57)
		end
	elseif state == 3 and table.contains({"return", "kpenter"}, key) then
		-- We can split lines because the current line is in input and input_r.
		-- So input_r is simply transferred to the newly inserted line along with the cursor.
		table.insert(scriptlines, editingline+1, "")
		editingline = editingline + 1
		input = anythingbutnil(scriptlines[editingline])
		dirty()
		-- We also want to scroll the screen if necessary
		scriptlineonscreen()
	elseif (state == 3 or state == 6) and key == "f1" then
		if state == 6 then
			stopinput()
		end
		tostate(15)
	elseif state == 3 and key == "f3" then
		inscriptsearch(scriptsearchterm)
	elseif state == 3 and (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("alt")) then
		local temp_jumped_lr = false
		if key == "left" and #scripthistorystack > 0 then
			editorjumpscript(scripthistorystack[#scripthistorystack][1], true, scripthistorystack[#scripthistorystack][2])
			temp_jumped_lr = true
		elseif key == "right" and (context == "flagscript" or context == "crewmatescript") and carg2 ~= nil and carg2 ~= "" and not scriptinstack(carg2) then
			editorjumpscript(carg2)
			temp_jumped_lr = true
		elseif key == "right" and context == "script" and not scriptinstack(carg1) then
			editorjumpscript(carg1)
			temp_jumped_lr = true
		elseif key == "right" and context == "roomscript" and not scriptinstack(carg3) then
			editorjumpscript(carg3)
			temp_jumped_lr = true
		elseif not keyboard_eitherIsDown(ctrl) then
			-- Temporary catch while both ctrl/alt+left/right are possible, from here on only ctrl
		elseif key == "c" then
			copyscriptline()
		elseif key == "a" then
			copyscript()
		elseif key == "f" then
			startinscriptsearch()
		elseif key == "g" then
			startscriptgotoline()
		elseif key == "i" then
			if keyboard_eitherIsDown("shift") then
				if internalscript then
					internalscript = false
				elseif cutscenebarsinternalscript then
					internalscript = true
					cutscenebarsinternalscript = false
				else
					cutscenebarsinternalscript = true
				end
			else
				if internalscript then
					internalscript = false
					cutscenebarsinternalscript = true
				elseif cutscenebarsinternalscript then
					internalscript = false
					cutscenebarsinternalscript = false
				else
					internalscript = true
				end
			end
			dirty()
		elseif key == "d" then
			if #scriptlines > 1 then
				table.remove(scriptlines, editingline)
			else
				scriptlines[editingline] = ""
			end
			if keyboard_eitherIsDown("shift") then
				editingline = math.max(editingline - 1, 1)
			else
				if editingline > #scriptlines and editingline > 1 then
					editingline = editingline - 1
				end
			end
			input = anythingbutnil(scriptlines[editingline])
			input_r = ""
			dirty()
		end

		if temp_jumped_lr and not keyboard_eitherIsDown("alt") then
			show_notification(L.OLDSHORTCUT_SCRIPTJUMP)
		end
	elseif state == 3 and key == "tab" then
		matching = {}

		for k,v in pairs(knowncommands) do
			if k:sub(1, input:len()) == input then
				table.insert(matching, k)
			end
		end
		for k,v in pairs(knowninternalcommands) do
			if k:sub(1, input:len()) == input and not table.contains(matching, k) then
				table.insert(matching, k)
			end
		end

		if #matching == 1 then
			input = matching[1]
			scriptlines[editingline] = input
			dirty()
		end
	elseif (state == 6) and table.contains({"return", "kpenter"}, key) and tabselected == 0 then
		state6load(input .. input_r)
	elseif (state == 6) and ((keyboard_eitherIsDown("shift") and key == "tab") or key == "up") then
		if tabselected ~= 0 then
			tabselected = tabselected - 1
		end
	elseif (state == 6) and (key == "tab" or key == "down") then --and tabselected < #files then
		if tabselected == -1 then
			tabselected = 1
		else
			tabselected = tabselected + 1
		end
	elseif (state == 6) and key == "escape" then
		if tabselected ~= 0 then
			tabselected = 0
		else
			if state6old1 then
				stopinput()
				tostate(1, true)
			end
		end
	elseif state == 6 and key == "f5" then
		loadlevelsfolder()
	elseif state == 6 and backupscreen and currentbackupdir ~= "" and key == "backspace" and nodialog then
		currentbackupdir = ""
	elseif state == 6 and not secondlevel and nodialog and not backupscreen and (key == "a" or key == "r") and keyboard_eitherIsDown(ctrl) then
		stopinput()
		tostate(30)
		if key == "a" then
			show_notification(L.OLDSHORTCUT_ASSETS)
		end
	elseif state == 6 and not secondlevel and nodialog and not backupscreen and (key == "d" or key == "f") and keyboard_eitherIsDown(ctrl) then
		explore_lvl_dir()
		if key == "d" then
			show_notification(L.OLDSHORTCUT_OPENLVLDIR)
		end
	elseif state == 6 and allowdebug and key == "f2" and keyboard_eitherIsDown("shift") then
		table.insert(files[""], {name="--[debug]--", isdir=false, bu_lastmodified=0, bu_overwritten=0, result_shown=true})
	elseif state == 6 and allowdebug and key == "f3" and keyboard_eitherIsDown("shift") then
		table.remove(files[""])
	elseif (state == 8) and (table.contains({"return", "kpenter"}, key)) then
		stopinput()
		savedsuccess, savederror = savelevel(input .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, false)
		if savedsuccess then
			editingmap = input
		end
	elseif state == 10 and (key == "up" or key == "down") then
		handle_scrolling(false, key == "up" and "wu" or "wd") -- 16px
	elseif state == 10 and key == "n" and nodialog then
		dialog.create(
			L.NEWSCRIPTNAME, DBS.OKCANCEL,
			dialog.callback.newscript, L.CREATENEWSCRIPT, dialog.form.simplename,
			dialog.callback.newscript_validate, "newscript_list"
		)
	elseif state == 10 and key == "f" and nodialog then
		tostate(19,false)
	elseif state == 10 and key == "/" and nodialog then
		if #scriptnames >= 1 then
			scriptineditor(scriptnames[#scriptnames], #scriptnames)
			nodialog = false -- Terrible
		end
	elseif state == 11 and table.contains({"return", "kpenter"}, key) then
		searchscripts, searchrooms, searchnotes = searchtext(input .. input_r)
		searchedfor = input .. input_r
	elseif nodialog and (state == 10 or state == 11) and key == "escape" then
		stopinput()
		tostate(1, true)
		nodialog = false
	elseif nodialog and state == 13 and key == "escape" then
		exitvedoptions()
	elseif nodialog and (state == 15 or state == 19 or state == 28 or state == 30 or state == 31 or state == 32) and key == "escape" then
		tostate(oldstate, true)
		if state == 11 then
			-- Back to search results
			startinput()
			input = searchedfor
		elseif state == 30 then
			oldstate = olderstate
		end
		nodialog = false
	elseif nodialog and state == 3 and key == "escape" then
		leavescript_to_state = function()
			stopinput()
			scriptlines[editingline] = input
			scripts[scriptname] = table.copy(scriptlines)
			if scriptfromsearch then
				tostate(11, true)
				startinput()
				input = searchedfor
			else
				tostate(10)
			end
			nodialog = false
		end

		if not processflaglabelsreverse() then
			leavescript_to_state()
		end
	elseif nodialog and state == 15 and helpeditingline ~= 0 then
		if key == "up" and helpeditingline ~= 1 then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline - 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "down" and helparticlecontent[helpeditingline+1] ~= nil then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif table.contains({"return", "kpenter"}, key) then
			table.insert(helparticlecontent, helpeditingline+1, "")
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
			helplineonscreen()
		elseif key == "insert" then
			if keyboard_eitherIsDown("shift") then
				input = input .. "§"
			else
				input = input .. "¤"
			end
			helparticlecontent[helpeditingline] = input
		elseif key == "d" and keyboard_eitherIsDown(ctrl) then
			if #helparticlecontent > 1 then
				table.remove(helparticlecontent, helpeditingline)
			else
				helparticlecontent[helpeditingline] = ""
			end
			if keyboard_eitherIsDown("shift") then
				helpeditingline = math.max(helpeditingline - 1, 1)
			else
				if helpeditingline > #helparticlecontent and helpeditingline > 1 then
					helpeditingline = helpeditingline - 1
				end
			end
			input = anythingbutnil(helparticlecontent[helpeditingline])
			input_r = ""
		end
	elseif nodialog and state == 15 then
		if key == "up" then
			gotohelparticle(revcycle(helparticle, #helppages, 2))
		elseif key == "down" then
			gotohelparticle(cycle(helparticle, #helppages, 2))
		end
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
			if key == string.lower(v) then
				if selectedtool == k and k ~= 13 and k ~= 14 and state == 1 then
					-- We're re-pressing this button, so set the subtool to the first one.
					selectedsubtool[k] = 1
				elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					selectedtool = k
					updatewindowicon()
				end
				toolscroll()
			end
		end
	elseif (state == 22 or state == 23) and table.contains({"return", "kpenter"}, key) then
		stopinput()
		scsuccess, sccontents = readlevelfile(input)
		if scsuccess then
			scriptname = input
			scriptlines = explode((state == 22 and "%$" or "\r?\n"), sccontents)
			tostate(3)
		else
			dialog.create("Cannot open " .. input .. "\n\n" .. sccontents)
			startinput()
		end
	elseif state == 25 and key == "escape" then
		exitsyntaxcoloroptions()
	elseif state == 31 and (key == " " or key == "space" or key == "kp5") then
		if currentmusic_paused then
			resumemusic()
		else
			pausemusic()
		end
	elseif state == 31 and musiceditor and key == "s" then
		assets_savedialog()
	elseif state == 31 and musiceditor and key == "m" then
		assets_metadataeditordialog()
	elseif state == 31 and not musiceditor and file_metadata_anyset and key == "m" then
		assets_metadataplayerdialog()
	elseif state == 31 and musiceditor and key == "l" then
		assets_musicloaddialog()
	elseif state == 31 and not musiceditor and key == "l" then
		assets_musicreload()
	elseif state == 31 and (key == "home" or key == "kp7") then
		local current_audio = getmusicaudioplaying()
		if current_audio ~= nil then
			current_audio:seek(0)
		end
	elseif state == 31 and love_version_meets(10) and (key == "left" or key == "kp4" or key == "right" or key == "kp6") then
		local seconds = 0
		if key == "left" or key == "kp4" then
			seconds = -5
		elseif key == "right" or key == "kp6" then
			seconds = 5
		end
		if keyboard_eitherIsDown("shift") then
			seconds = seconds * 2
		end
		local current_audio = getmusicaudioplaying()
		if current_audio ~= nil then
			local duration = current_audio:getDuration("seconds")
			if duration ~= nil and duration > 0 then
				local seek = math.max(current_audio:tell("seconds") + seconds, 0)
				if seek > duration then
					seek = 0
				end
				current_audio:seek(seek, "seconds")
			end
		end
	elseif state == 32 and key == "l" then
		assets_graphicsloaddialog()
	elseif state == 32 and imageviewer_image_color ~= nil and nodialog then
		if key == "=" or key == "+" or key == "kp+" then
			imageviewer_zoomin()
		elseif key == "-" or key == "kp-" then
			imageviewer_zoomout()
		elseif key == "r" then
			imageviewer_showwhite = not imageviewer_showwhite
		elseif key == "`" then
			imageviewer_grid = 0
		elseif key == "1" then
			imageviewer_grid = 1
		elseif key == "2" then
			imageviewer_grid = 8
		elseif key == "3" then
			imageviewer_grid = 32
		end
	elseif state == 33 then
		if key == "escape" or key == "return" then
			exitlanguageoptions()
		elseif key == "up" or key == "down" then
			local curlang
			for k,v in pairs(alllanguages) do
				if v == s.lang then
					curlang = k
					break
				end
			end
			if curlang == nil then
				changelanguage("English")
			else
				local newlang
				if key == "up" then
					newlang = curlang - 1
					if newlang < 1 then
						newlang = #alllanguages
					end
				elseif key == "down" then
					newlang = curlang + 1
					if newlang > #alllanguages then
						newlang = 1
					end
				end
				changelanguage(alllanguages[newlang])
			end
		end
	end

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	if uis[state] ~= nil and uis[state].keypressed ~= nil then
		uis[state].keypressed(key)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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

	if holdingzvx and (key == "z" or key == "x" or key == "c" or key == "v" or key == "h" or key == "b" or key == "f") then
		if selectedtool == 1 or selectedtool == 2 or ((selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9) and oldzxsubtool <= 4) or ((selectedtool == 5 or selectedtool == 10) and oldzxsubtool <= 2) then
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
	elseif state == 27 and key == "escape" then
		-- Put it here instead of love.keypressed,
		-- otherwise the new window will interpret a hold as a press
		exitdisplayoptions()
	end

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	if uis[state] ~= nil and uis[state].keyreleased ~= nil then
		uis[state].keyreleased(key)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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
			end
			updatewindowicon()
			toolscroll()
		elseif nodialog and (keyboard_eitherIsDown(ctrl) or keyboard_eitherIsDown("shift")) and button == flipscrollmore(macscrolling and "wu" or "wd") and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
			if selectedtool < 17 then
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
	elseif state == 3 and button == "l" and nodialog and mouseon(48, 24, love.graphics.getWidth()-192, love.graphics.getHeight()-24) then
		local chr, line
		if s.scripteditor_largefont then
			chr = math.floor((x-88)/16) + 1
			line = math.floor(((y-24)-scriptscroll-4)/16) + 1
		else
			chr = math.floor((x-48)/8) + 1
			line = math.floor(((y-24)-scriptscroll-6)/8) + 1
		end
		if chr < 1 then
			chr = 1
		end
		scriptgotoline(line, chr)
	elseif state == 6 and hoveringlevel ~= nil and button == "l" then
		-- Just like when going to a room by clicking on the map, we don't want to click the first tile we press.
		nodialog = false

		state6load(hoveringlevel)
	elseif state == 6 and hoveringlevel ~= nil and button == "r" then
		if backupscreen and currentbackupdir ~= "" then
			rightclickmenu.create({"#[" .. hoveringlevel_k .. "]", L.SAVEBACKUP}, "bul_" .. hoveringlevel:sub((".ved-sys/backups"):len()+2, -1))
		end
	elseif state == 9 and button == "r" then -- TEST STATE
		rightclickmenu.create({"Delete", "Edit script", "Rename"}, "1")
	elseif state == 9 and button == "l" and nodialog then
		tbx, tby = math.floor((x-screenoffset)/2), math.floor(y/2)
		table.insert(vvvvvv_textboxes, {({"cyan", "red", "yellow", "green", "blue", "purple", "gray"})[math.random(1,7)], tbx, tby, {"Text!", tbx .. "," .. tby}})
	elseif state == 15 and helpeditingline ~= 0 and button == "l" and nodialog and mouseon(214+(s.psmallerscreen and -96 or 0), 8, love.graphics.getWidth()-238-(s.psmallerscreen and -96 or 0), love.graphics.getHeight()-16) then
		local chr, line
		local screenxoffset = 0
		if s.psmallerscreen then
			screenxoffset = -96
		end
		chr = math.floor((x-216-screenxoffset)/8) + 1
		line = math.floor(((y-8)-helparticlescroll-3)/10) + 1
		helpgotoline(line, chr)
	elseif state == 32 and button == "l" and imageviewer_image_color ~= nil and nodialog and x < love.graphics.getWidth()-128 then
		imageviewer_moving = true
		imageviewer_moved_from_x, imageviewer_moved_from_y = imageviewer_x, imageviewer_y
		imageviewer_moved_from_mx, imageviewer_moved_from_my = x, y
		mousepressed = true
	else
		handle_scrolling(false, button)
	end

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

	if uis[state] ~= nil and uis[state].mousepressed ~= nil then
		uis[state].mousepressed(x, y, button)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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
		undobuffer[undosaved].toredotiles = table.copy(roomdata[roomy][roomx])
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	elseif state == 32 then
		imageviewer_moving = false
	end

	mousepressed = false
	mousepressed_custombrush = false
	if mousepressed_flag then
		mousepressed_flag = false
		mousereleased_flag = true
	end
	minsmear = -1; maxsmear = -1
	toout = 0

	for k,v in pairs(dialogs) do
		v:mousereleased(x, y)
	end

	if button == "m" and middlescroll_x ~= -1 and middlescroll_y ~= -1 and not mouseon(middlescroll_x-16, middlescroll_y-16, 32, 32) then
		unset_middlescroll()
	end

	if state == 6 and not secondlevel and nodialog and not backupscreen and button == "l" and onrbutton(1, nil, true) then
		-- This has to be in mousereleased, since opening a window with a mouse press prevents a mouse
		-- release event to occur, which either causes the next click to be missed, or causes a new
		-- window to be opened on focus when you try to fix that!
		explore_lvl_dir()
	end

	boxmouserelease()

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	if uis[state] ~= nil and uis[state].mousereleased ~= nil then
		uis[state].mousereleased(x, y, button)
	end
	if uis[state] ~= nil and uis[state].elements ~= nil then
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

function love.filedropped(path)
	-- LÖVE 0.10+
	hook("love_filedropped", {path})
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
