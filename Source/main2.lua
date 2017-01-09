--[[

States:
-3	Just blackness
-2  tostate 6
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
	ved_require("lang/English") -- just as a fallback. Doesn't work for the most part.
	if s.lang ~= "English" and love.filesystem.exists("lang/" .. s.lang .. ".lua") then
		ved_require("lang/" .. s.lang)
	end
	ved_require("devstrings")
	ved_require("const")
	ved_require("func")
	ved_require("roomfunc")
	ved_require("scriptfunc")
	ved_require("searchfunc")
	ved_require("vvvvvvxml")
	ved_require("dialog")
	ved_require("resizablebox")
	ved_require("drawmaineditor")
	ved_require("drawscripteditor")
	ved_require("drawlevelslist")
	ved_require("drawsearch")
	ved_require("drawmap")
	ved_require("drawhelp")
	ved_require("slider")
	
	if s.pscale ~= 1 then
		za,zb,zc = love.window.getMode()
		love.window.setMode(za*s.pscale,zb*s.pscale,zc)
		
		ved_require("scaling")
	end

	-- Are we using 0.10.x?
	if love.getVersion ~= nil then
		local major, minor, revision, codename = love.getVersion()
		
		if minor >= 10 then
			ved_require("love10compat")
		end
	else
		-- 0.9.0 which does not support love.getVersion() but is still supported along with 0.10?
		love.getVersion = function()
			return 0, 9, 0, ""
		end
	end
	
	cons("love.load() reached")
	
	math.randomseed(os.time())
	
	state = -2; oldstate = "none"
	--debug = 0 (kom ik achter zodra ik debug.debug probeer te gebruiken, syntax highlighting hielp blijkbaar niet)
	input = ""; takinginput = false
	__ = "_"
	input_r = ""
	cursorflashtime = 0
	multiinput = {}; currentmultiinput = 0
	bypassdialog = false
	
	mousepressed = false -- for some things
	
	temporaryroomnametimer = 0
	
	scriptsearchterm = ""
	
	sp_t = 0
	sp_tim = 0
	sp_go = true
	sp_got = 0
	
	-- Dialogs. To not have an active window, set DIAwindowani to 16. To show one, just call dialog.new(message, title, showbar, canclose, questionid). -15 ~ -1 opening, 0 is normal, 1 ~ 15 closing
	dialog.init()
	nodialog = true
	
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
	--cursorobjs[11] = love.mouse.newCursor(cursorimg[11]:getData(), 8, 10)
	--cursorobjs[12] = love.mouse.newCursor(cursorimg[12]:getData(), 10, 8)
	cursorobjs[11] = love.mouse.getSystemCursor("sizens")
	cursorobjs[12] = love.mouse.getSystemCursor("sizewe")
	cursorobjs[16] = love.mouse.getSystemCursor("sizenwse")
	cursorobjs[17] = love.mouse.getSystemCursor("sizenesw")
	cursorobjs[19] = love.mouse.getSystemCursor("sizeall")
	
	scriptboximg = {}
	scriptboximg[1] = love.graphics.newImage("cursor/script1.png")
	scriptboximg[2] = love.graphics.newImage("cursor/script2.png")
	scriptboximg[3] = love.graphics.newImage("cursor/script3.png")
	scriptboximg[4] = love.graphics.newImage("cursor/script4.png")
	scriptboximg[6] = love.graphics.newImage("cursor/script6.png")
	scriptboximg[7] = love.graphics.newImage("cursor/script7.png")
	scriptboximg[8] = love.graphics.newImage("cursor/script8.png")
	scriptboximg[9] = love.graphics.newImage("cursor/script9.png")
	
	
	selectedtoolborder = love.graphics.newImage("selectedtool.png")
	unselectedtoolborder = love.graphics.newImage("unselectedtool.png")
	
	savebtn = love.graphics.newImage("save.png")
	loadbtn = love.graphics.newImage("load.png")
	newbtn = love.graphics.newImage("new.png")
	helpbtn = love.graphics.newImage("help.png")
	retbtn = love.graphics.newImage("ret.png")
	
	undobtn = love.graphics.newImage("undo.png")
	redobtn = love.graphics.newImage("redo.png")
	cutbtn = love.graphics.newImage("cut.png")
	copybtn = love.graphics.newImage("copy.png")
	pastebtn = love.graphics.newImage("paste.png")
	
	checkon = love.graphics.newImage("checkon.png")
	checkoff = love.graphics.newImage("checkoff.png")
	
	menupijltje = love.graphics.newImage("menupijltje.png")
	colorsel = love.graphics.newImage("colorsel.png")
	
	bggrid = love.graphics.newImage("bggrid.png")
	
	toolimg = {}
	toolimgicon = {}
	for t = 1, 17 do
		toolimg[t] = love.graphics.newImage("tools/" .. t .. ".png")
		toolimgicon[t] = love.image.newImageData("tools2/on/" .. t .. ".png")
	end
	
	-- But we also have subtools!
	subtoolimgs = {}
	subtoolimgs[1] = {st("1_1"), st("1_2"), st("1_3"), st("1_4"), st("1_5"), st("1_6"), st("1_7"), st("1_8")}
	subtoolimgs[2] = {st("2_1"), st("2_2"), st("2_3"), st("2_4"), st("2_5"), st("2_6"), st("2_7"), st("2_8")}
	subtoolimgs[3] = {st("3_1"), st("3_2"), st("3_3"), st("3_4"), }-- st("3_5"), st("3_6"), st("3_7"), st("3_8")}
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
	
	
	scrollup = love.graphics.newImage("scrollup.png")
	scrolldn = love.graphics.newImage("scrolldn.png")
	
	sideimg = love.graphics.newImage("sides.png");             smallsideimg = love.graphics.newImage("smallsides.png")
	
	sideline = {};                                             smallsideline = {}
	sideline[1] = love.graphics.newQuad(0, 0, 8, 8, 32, 8);    smallsideline[1] = love.graphics.newQuad(0, 0, 16, 16, 64, 16)
	sideline[2] = love.graphics.newQuad(8, 0, 8, 8, 32, 8);    smallsideline[2] = love.graphics.newQuad(16, 0, 16, 16, 64, 16)
	sideline[3] = love.graphics.newQuad(16, 0, 8, 8, 32, 8);   smallsideline[3] = love.graphics.newQuad(32, 0, 16, 16, 64, 16)
	sideline[4] = love.graphics.newQuad(24, 0, 8, 8, 32, 8);   smallsideline[4] = love.graphics.newQuad(48, 0, 16, 16, 64, 16)
	
	platformimg = love.graphics.newImage("platform.png")
	platformpart =
		{
		love.graphics.newQuad(0, 0, 8, 8, 24, 8),
		love.graphics.newQuad(8, 0, 8, 8, 24, 8),
		love.graphics.newQuad(16, 0, 8, 8, 24, 8)
		}
		
	-- The help has images too, but they shouldn't be loaded repetitively!
	helpimages = {}

	if s.smallerscreen then
		screenoffset = 32
	else
		screenoffset = 128
	end
	
	savedwindowtitle = ""
	
	-- Load the default tilesets - Will be done later when we have the custom level folder
	--loadtileset("tiles.png")
	--loadtileset("tiles2.png")
	-- loadtileset("tiles3.png") oops oversight
	
	-- Load the spriteset - This later too
	-- loadsprites("sprites.png", 64)
	--loadsprites("sprites.png", 32)
	
	-- eeeeeeeeee
	love.keyboard.setKeyRepeat(true)
	thingk()
	
	if love.system.getOS() == "OS X" then
		-- Cmd
		ctrl = "gui"
		dirsep = "/"
		macscrolling = true
		hook("love_load_mac")
		ved_require("filefunc_mac")
	elseif love.system.getOS() == "Windows" then
		-- Ctrl
		ctrl = "ctrl"
		dirsep = "\\"
		macscrolling = false
		hook("love_load_win")
		ved_require("filefunc_win")
	elseif love.system.getOS() == "Linux" then
		-- Ctrl
		ctrl = "ctrl"
		dirsep = "/"
		macscrolling = false
		hook("love_load_lin")
		ved_require("filefunc_lin")
		--require("filefunc_luv")
		--dialog.new("Full support for Linux will be added really soon!", "", 1, 1, 0)
	else
		-- This OS is unknown, so I suppose we will have to fall back on functions in love.filesystem.
		ctrl = "ctrl"
		dirsep = "/"
		macscrolling = false
		hook("love_load_luv")
		ved_require("filefunc_luv")
		dialog.new(langkeys(L.OSNOTRECOGNIZED, {anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}), "", 1, 1, 0)
	end
			
	--if love.getVersion ~= nil then
	local _, v, m = love.getVersion()
	if not (v == 9 and m == 0) then
		-- We're not using 0.9.0, so we can use love2d's openURL function instead of the command line
		function openurl(url)
			love.system.openURL(url)
		end
	end
	
	--if not love.filesystem.exists("temp") then
		--love.filesystem.createDirectory("temp")
	--end
	if not love.filesystem.exists("maps") then
		love.filesystem.createDirectory("maps")
	end
	
	if s.pcheckforupdates then
		updatecheckthread = love.thread.newThread("updatecheck.lua")
		
		verchannel = love.thread.getChannel("version")
		updatecheckthread:start(checkver)
		
		updatenotesavailable = false
	end
	
	hook("love_load_end")
end

function love.draw()
	if s.pscale ~= 1 then
		love.graphics.push()
		love.graphics.scale(s.pscale,s.pscale)
	end

	if state == -3 then
		-- Do-nothing state
	elseif state == -2 then
		tostate(6)
	elseif state == -1 then
		love.graphics.printf(L.FATALERROR .. anythingbutnil(errormsg) .. "\n\n" .. L.FATALEND, 10, 10, love.graphics.getWidth()-20, "left")
	elseif state == 0 then
		love.graphics.print("Placeholder main menu. Enter state: " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 10)
		startinputonce()
	elseif state == 1 then		
		drawmaineditor()
	elseif state == 2 then
		love.graphics.print("Syntax highlighting" .. input .. __, 10, 10)
		
		syntaxhl(input, 10, 30, false, true)
		startinputonce()
	elseif state == 3 then
		drawscripteditor()
	elseif state == 4 then
		love.graphics.print(metadata.Creator, 10, 10)
		love.graphics.print("That should say Unknown.", 10, 20)
	elseif state == 5 then
		love.graphics.print("Userprofile: " .. userprofile, 8, 8)
		for k,v in pairs(files) do
			love.graphics.print(v, 8, 16+8*k)
			
			lastk = k
		end
				
		love.graphics.print("Levels folder error: " .. lerror .. " (0 means no error)", 8, 16+8*lastk+16)
		love.graphics.print("Levels folder: " .. anythingbutnil(levelsfolder), 8, 16+8*lastk+24)
		love.graphics.print("Identity: " .. love.filesystem.getIdentity() .. "\nSaveDirectory: " .. love.filesystem.getSaveDirectory(), 8, 16+8*lastk+24+16)
	elseif state == 6 then
		drawlevelslist()
	elseif state == 7 then
		for y = 0, 7 do
			for x = 0, 23 do
				love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][(y*24)+x], x*32, y*32)
				
				if mouseon(x*32, y*32, 32, 32) then
					love.graphics.print((y*24)+x, love.graphics.getWidth()-24, love.graphics.getHeight()-8)
				end
			end
		end
	elseif state == 8 then
		love.graphics.print(L.ENTERNAMESAVE .. input .. __, 10, 10)
		startinputonce()
		if savedsuccess ~= nil then
			if savedsuccess == true then
				love.graphics.print(L.SAVESUCCESS, 10, 50)
			else
				love.graphics.print(L.SAVENOSUCCESS .. anythingbutnil(savederror), 10, 50)
			end
		end
	elseif state == 9 then
		love.graphics.print(youdidanswer .. "\nRight click menu return: " .. anythingbutnil(RCMreturn), 10, 10)
	elseif state == 10 then
		--[[
		j = -1
		for k,v in pairs(scripts) do
			j = j + 1
			hoverrectangle(128,128,128,128, 8, 8+(24*j), 640, 16)
			love.graphics.printf(k, 8, 8+(24*j)+4+2, 640, "center")
		end
		]]
		j = -1
		for rvnum = #scriptnames, 1, -1 do
			j = j + 1
			hoverrectangle(128,128,128,128, 8, scriptlistscroll+8+(24*j), screenoffset+640-8-24, 16)
			love.graphics.printf(scriptnames[rvnum], 8, scriptlistscroll+8+(24*j)+4+2, screenoffset+640-8-24, "center")
			
			-- Are we clicking on this?
			if not mousepressed and nodialog and mouseon(8, scriptlistscroll+8+(24*j), screenoffset+640-8-24, 16) then
				if love.mouse.isDown("l") then
					--##SCRIPT##  DONE
					scriptineditor(scriptnames[rvnum], rvnum)
					--scriptname = scriptnames[rvnum]
					--scriptlines = table.copy(scripts[scriptnames[rvnum]])
					--processflaglabels()
					--bumpscript(rvnum)
					--tostate(3)
				elseif love.mouse.isDown("r") then
					rightclickmenu.create({L.EDIT, L.EDITWOBUMPING, L.COPYNAME, L.COPYCONTENTS, L.DUPLICATE, L.RENAME, L.DELETE}, "spt_" .. rvnum)
				end
			end
		end
		
		-- Scrollbar
		local newperonetage = scrollbar(love.graphics.getWidth()-(128-8)-24, 8, love.graphics.getHeight()-16, (#scriptnames*24-8), ((-scriptlistscroll))/((#scriptnames*24-8)-(love.graphics.getHeight()-16)))
			
		if newperonetage ~= nil then
			--dialog.new("TODO SCROLL", "", 1, 1, 0)
			scriptlistscroll = -(newperonetage*((#scriptnames*24-8)-(love.graphics.getHeight()-16)))
		end
		
		rbutton(L.NEW, 0)
		rbutton(L.FLAGS, 1)
		
		-- Script count
		love.graphics.printf(L.COUNT .. #scriptnames .. "/500", love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-(24*2))+4+2, 128-16, "left")
		
		rbutton(L.RETURN, 0, nil, true)
		
		-- Buttons again
		if nodialog and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- New
				startmultiinput({""})
				dialog.new(L.NEWSCRIPTNAME, L.CREATENEWSCRIPT, 1, 4, 9)
			elseif onrbutton(1) then
				-- Flags
				mousepressed = true
				tostate(19, false)
			elseif not mousepressed and onrbutton(0, nil, true) then
				-- Return
				tostate(1, true)
			end
		end
	elseif state == 11 then
		drawsearch()
	elseif state == 12 then
		drawmap()
	elseif state == 13 then
		-- Options screen
		--love.graphics.draw(checkon, love.graphics.getWidth()-98, 50, 0, 2)
		--love.graphics.draw(checkoff, love.graphics.getWidth()-98, 70, 0, 2)
		love.graphics.print(L.VEDOPTIONS, 8, 8+4+2)
		
		hoverdraw((s.scale == 2 and checkon or checkoff), 8, 8+(24*1), 16, 16, 2)
		love.graphics.print(L.IIXSCALE, 8+16+8, 8+(24*1)+4+2)
		
		hoverdraw((s.dialoganimations and checkon or checkoff), 8, 8+(24*2), 16, 16, 2)
		love.graphics.print(L.DIALOGANIMATIONS, 8+16+8, 8+(24*2)+4+2)
		
		hoverdraw((s.flipsubtoolscroll and checkon or checkoff), 8, 8+(24*3), 16, 16, 2)
		love.graphics.print(L.FLIPSUBTOOLSCROLL, 8+16+8, 8+(24*3)+4+2)
		
		hoverdraw((s.adjacentroomlines and checkon or checkoff), 8, 8+(24*4), 16, 16, 2)
		love.graphics.print(L.ADJACENTROOMLINES, 8+16+8, 8+(24*4)+4+2)
		
		hoverdraw((s.askbeforequit and checkon or checkoff), 8, 8+(24*5), 16, 16, 2)
		love.graphics.print(L.ASKBEFOREQUIT, 8+16+8, 8+(24*5)+4+2)
		
		hoverdraw((s.coords0 and checkon or checkoff), 8, 8+(24*6), 16, 16, 2)
		love.graphics.print(L.COORDS0, 8+16+8, 8+(24*6)+4+2)
		
		hoverdraw((s.showfps and checkon or checkoff), 8, 8+(24*7), 16, 16, 2)
		love.graphics.print(L.SHOWFPS, 8+16+8, 8+(24*7)+4+2)
		
		hoverdraw((s.checkforupdates and checkon or checkoff), 8, 8+(24*8), 16, 16, 2)
		love.graphics.print(L.CHECKFORUPDATES, 8+16+8, 8+(24*8)+4+2)
		
		
		rbutton(L.BTN_OK, 0)
		
		rbutton(L.CUSTOMVVVVVVDIRECTORY, 2)
		rbutton(L.LANGUAGE, 3)
		rbutton(L.SYNTAXCOLORS, 4)
		
		rbutton(L.SENDFEEDBACK, 6)
		
		--hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8), 8+(24*1), 128-16, 16) -- love.graphics.getHeight()-(24*(X+1)) instead of 8+(24*X)
		--love.graphics.printf("Cancel", love.graphics.getWidth()-(128-8), (8+(24*1))+4+2, 128-16, "center")
		
		
		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if mouseon(8, 8+(24*1), 16, 16) then
				-- 2x scale
				if s.scale == 2 then
					s.scale = 1
				else
					s.scale = 2
				end
				dialog.new(L.SCALEREBOOT, "", 1, 1, 0)
			elseif mouseon(8, 8+(24*2), 16, 16) then
				-- Dialog animations
				s.dialoganimations = not s.dialoganimations
			elseif mouseon(8, 8+(24*3), 16, 16) then
				-- Flip subtool scrolling direction
				s.flipsubtoolscroll = not s.flipsubtoolscroll
			elseif mouseon(8, 8+(24*4), 16, 16) then
				-- Indicators of tiles in adjacent rooms
				s.adjacentroomlines = not s.adjacentroomlines
			elseif mouseon(8, 8+(24*5), 16, 16) then
				-- Ask before quitting
				s.askbeforequit = not s.askbeforequit
			elseif mouseon(8, 8+(24*6), 16, 16) then
				-- Coords0
				s.coords0 = not s.coords0
			elseif mouseon(8, 8+(24*7), 16, 16) then
				-- Show FPS
				s.showfps = not s.showfps
				savedwindowtitle = ""
			elseif mouseon(8, 8+(24*8), 16, 16) then
				-- Check for updates
				s.checkforupdates = not s.checkforupdates
				
			elseif onrbutton(0) then
				-- Save
				saveconfig()
				if oldstate == 6 and s.customvvvvvvdir ~= firstvvvvvvfolder then
					-- Immediately apply the new custom VVVVVV directory.
					tostate(6)
				else
					tostate(oldstate, true)
				end
			elseif onrbutton(2) then
				-- Custom VVVVVV folder
				local _, shouldbefolder = getlevelsfolder(true)
				startmultiinput({s.customvvvvvvdir})
				dialog.new(langkeys(L.CUSTOMVVVVVVDIRECTORYEXPL, {shouldbefolder}), "", 1, 4, 23)
			elseif onrbutton(3) then
				-- Language
				languageslist = getalllanguages()
				startmultiinput({s.lang})
				dialog.new(L.RESTARTVEDLANG, L.LANGUAGE, 1, 4, 24)
			elseif onrbutton(4) then
				-- Syntax colors
				olderstate = oldstate
				tostate(25)
			elseif not mousepressed and onrbutton(6) then
				openurl("http://ved.idea.informer.com/")
				
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
				drawentity(enemysprites[5*rrrrr+asdfg], 16+48*asdfg, 16+48*rrrrr)
			end
		end
		
		for rrrrr = 0, 1 do
			for asdfg = 0, 4 do
				drawentity(enemysprites[5*rrrrr+asdfg], 600+16*asdfg, 16+16*rrrrr, true)
			end
		end
	elseif state == 15 then
		drawhelp()
	elseif state == 16 then
		
	elseif state == 17 then
		love.graphics.print(love.filesystem.read("folderopendialog_return.txt"), 8, 8)
	elseif state == 18 then
		love.graphics.print("Undo stack:\n" .. undostacktext, 8, 8) -- Dev/testing/debug state, not translated
		love.graphics.print("Redo stack:\n" .. redostacktext, love.graphics.getWidth()/2 + 8, 8)
	elseif state == 19 then
		-- Columns 1 and 2
		for flcol = 8, love.graphics.getWidth()/2 + 8, love.graphics.getWidth()/2 do -- dit was misschien niet handig om te doen
			for flk = 0, 49 do
				local ax, ay, w, h = flcol-2, 24+flk*8, love.graphics.getWidth()/2 - 16, 8
				
				if nodialog and mouseon(ax, ay, w, h) then
					love.graphics.setColor(128,128,128,255)
					
					if not mousepressed and nodialog and love.mouse.isDown("l") then
						flgnum = flk + (flcol == 8 and 0 or 50) -- niet local, wordt gebruikt in dialog
						
						if vedmetadata == false then
							startmultiinput({""})
						else
							startmultiinput({vedmetadata.flaglabel[flgnum]})
						end
						dialog.new(langkeys(L.NAMEFORFLAG, {flgnum}), "", 1, 4, 15)
					
						mousepressed = true
					end
				else
					love.graphics.setColor(128,128,128,128)
				end
				
				love.graphics.rectangle("fill", ax, ay, w, h)
			end
		end
		
		love.graphics.setColor(255,255,255,255)
	
		love.graphics.print(L.FLAGS .. "\n\n" .. flagstextleft .. "\n\n" .. outofrangeflagstext, 8, 8+2)
		love.graphics.print(" \n\n" .. flagstextright, love.graphics.getWidth()/2 + 8, 8+2)
		
		rbutton(L.RETURN, 0, nil, true)

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
		
		love.graphics.print((box_exists and "Box exists" or "Box exists not") .. "\nPeri xywh " .. boxperi_x .. " " .. boxperi_y .. " " .. boxperi_w .. " " .. boxperi_h .. "\nBox xywh " .. box_x .. " " .. box_y .. " " .. box_w .. " " .. box_h .. "\nMoving HV: " .. box_moving_h .. box_moving_v .. "\n\nType " .. box_type .. "\nM for switching type -1/0\nV for shrinking the allowed perimeter\nR Reset\nE Re-enable", 10, 10)
		
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
		love.graphics.print(text21, 8, 8)
	elseif state == 22 then -- These are not translate-worthy I'm guessing
		love.graphics.printf("Filename to a script file (IN the 3DS format) (lines separated by dollars): " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\n\n\n\n\n\n\n\nIf you clicked Open by accident, F12 to 3 with shift", 10, 10, love.graphics.getWidth()-20, "left")
		startinputonce()
	elseif state == 23 then
		love.graphics.printf("Filename to a script file (NOT in the 3DS format) (lines separated by \\r\\n or \\n): " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\n\n\n\n\n\n\n\nIf you clicked Open by accident, F12 to 3 with shift", 10, 10, love.graphics.getWidth()-20, "left")
		startinputonce()
	elseif state == 24 then
		love.graphics.printf("Plugins\n\n\n" .. pluginstext, 8, 8, love.graphics.getWidth()-16, "left")
	elseif state == 25 then
		-- Syntax highlighting color settings
		love.graphics.print(L.SYNTAXCOLORSETTINGSTITLE, 8, 8+4+2)

		colorsetting(L.SYNTAXCOLOR_COMMAND,     1, s.syntaxcolor_command    )
		colorsetting(L.SYNTAXCOLOR_GENERIC,     2, s.syntaxcolor_generic    )
		colorsetting(L.SYNTAXCOLOR_SEPARATOR,   3, s.syntaxcolor_separator  )
		colorsetting(L.SYNTAXCOLOR_NUMBER,      4, s.syntaxcolor_number     )
		colorsetting(L.SYNTAXCOLOR_TEXTBOX,     5, s.syntaxcolor_textbox    )
		colorsetting(L.SYNTAXCOLOR_ERRORTEXT,   6, s.syntaxcolor_errortext  )
		colorsetting(L.SYNTAXCOLOR_CURSOR,      7, s.syntaxcolor_cursor     )
		colorsetting(L.SYNTAXCOLOR_FLAGNAME,    8, s.syntaxcolor_flagname   )
		colorsetting(L.SYNTAXCOLOR_NEWFLAGNAME, 9, s.syntaxcolor_newflagname)
		
		rbutton(L.BTN_OK, 0)
		rbutton(L.RESETCOLORS, 2)
		
		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if onrbutton(0) then
				-- Save
				saveconfig()
				tostate(oldstate, true)
				-- Just to make sure we don't get stuck in the settings
				oldstate = olderstate
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
			love.graphics.printf(editingcolor[1], love.graphics.getWidth()-160, love.graphics.getHeight()-263, 50, "center")
			love.graphics.printf(editingcolor[2], love.graphics.getWidth()-105, love.graphics.getHeight()-263, 50, "center")
			love.graphics.printf(editingcolor[3], love.graphics.getWidth()-50, love.graphics.getHeight()-263, 50, "center")
			
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
	else
		statecaught = false
		
		hook("love_draw_state")
		
		if not statecaught then
			fatalerror(langkeys(L.UNKNOWNSTATE, {state, oldstate}))
		end
	end
	
	if not RCMabovedialog then
		rightclickmenu.draw()
	end
	
	dialog.draw()
	
	if RCMabovedialog then
		rightclickmenu.draw()
	end
	
	love.graphics.setColor(255,255,255,255)
	
	-- Show debug code if wanted
	if allowdebug then
		
	end
	
	if fpscap == 1 then
		love.graphics.setColor(255,0,0)
		love.graphics.setFont(font16)
		love.graphics.print("60", love.graphics.getWidth()-32, love.graphics.getHeight()-16)
		love.graphics.setFont(font8)
		love.graphics.setColor(255,255,255)
	elseif fpscap == 2 then
		love.graphics.setColor(255,0,0)
		love.graphics.setFont(font16)
		love.graphics.print("30", love.graphics.getWidth()-32, love.graphics.getHeight()-16)
		love.graphics.setFont(font8)
		love.graphics.setColor(255,255,255)
	elseif fpscap == 3 then
		love.graphics.setColor(255,0,0)
		love.graphics.setFont(font16)
		love.graphics.print("15", love.graphics.getWidth()-32, love.graphics.getHeight()-16)
		love.graphics.setFont(font8)
		love.graphics.setColor(255,255,255)
	end
	
	-- Low FPS warning
	if s.lowfpswarning >= 0 and (love.timer.getTime()-begint >= 3) and love.timer.getFPS() <= s.lowfpswarning then
		love.graphics.setColor(255,160,0,192)
		love.graphics.rectangle("fill", 0, love.graphics.getHeight()-16, 128, 16)
		love.graphics.setColor(255,255,255,255)
		love.graphics.printf(L.FPS .. ": " .. love.timer.getFPS(), 0, love.graphics.getHeight()-10, 128, "center")
	end
	
	hook("love_draw_end")
	
	-- Are we displaying a replacement cursor?
	--if replacecursor ~= -1 then
		--cursorimg
	
	if s.pscale ~= 1 then
		love.graphics.pop()
	end
end

function love.update(dt)
	hook("love_update_start")
	--print(anythingbutnil0(context) .. " " .. anythingbutnil0(carg1) .. " " .. anythingbutnil0(carg2))

	if takinginput or sp_t > 0 then
		cursorflashtime = (cursorflashtime + dt) % 1
		--__ = (cursorflashtime <= .5 and "_" or (input_r:sub(1, 1) == "" and " " or firstUTF8(input_r))) .. input_r:sub(2, -1)
		firstchar = firstUTF8(input_r)
		if cursorflashtime <= .5 then
			__ = "_" .. input_r:sub(1 + firstchar:len())
		else
			__ = firstchar .. input_r:sub(1 + firstchar:len())
		end
	elseif __ ~= "_" then
		__ = "_"
	end
	
	if fpscap == 1 then
		if dt < 1/60 then
			love.timer.sleep(1/60 - dt)
		end
	elseif fpscap == 2 then
		if dt < 1/30 then
			love.timer.sleep(1/30 - dt)
		end
	elseif fpscap == 3 then
		if dt < 1/15 then
			love.timer.sleep(1/15 - dt)
		end
	end
	
	-- The timing for this doesn't really matter
	if temporaryroomnametimer > 0 then
		temporaryroomnametimer = temporaryroomnametimer - 1
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
		if allowdebug then
			love.window.setTitle(anythingbutnil(editingmap) .. (editingmap ~= nil and " - " or "") .. "Ved v" .. ver .. "  [" .. L.DEBUGMODEON .. "]  [" .. L.FPS .. ": " .. love.timer.getFPS() .. "] - " .. L.STATE .. ": " .. state .. " - " .. love.graphics.getWidth() .. "x" .. love.graphics.getHeight() .. " " .. L.MOUSE .. ": " .. love.mouse.getX() .. " " .. love.mouse.getY() .. "  [ LÖVE v0." .. (love.graphics.ellipse == nil and 9 or 10) .. " ]")
		elseif s.showfps then
			love.window.setTitle(anythingbutnil(editingmap) .. (editingmap ~= nil and " - " or "") .. "Ved v" .. ver .. "  [" .. L.FPS .. ": " .. love.timer.getFPS() .. "]")
		else
			local newtitle = anythingbutnil(editingmap) .. (editingmap ~= nil and " - " or "") .. "Ved v" .. ver
			if newtitle ~= savedwindowtitle then
				love.window.setTitle(newtitle)
				savedwindowtitle = newtitle
			end
		end
	end
	
	if state == 1 then
		if (editingbounds == -1 or editingbounds == 1) and selectedtool ~= 9 then
			editingbounds = 0
		elseif (editingbounds == -2 or editingbounds == 2) and selectedtool ~= 8 then
			editingbounds = 0
		end
		
		if levelmetadata[(roomy)*20 + (roomx+1)].warpdir ~= 0 and levelmetadata[(roomy)*20 + (roomx+1)].warpdir ~= 3 then
			warpbganimation = (warpbganimation + 3) % 32
		elseif levelmetadata[(roomy)*20 + (roomx+1)].warpdir == 3 then
			warpbganimation = (warpbganimation + 2) % 64
		end
		
		if vedmetadata == nil then
			cons("vedmetadata == nil! Setting to false.")
			vedmetadata = false
		end
	elseif state == 15 and s.smallerscreen then
		local leftpartw = 8+200+8-96-2
		if love.mouse.getX() <= leftpartw then
			onlefthelpbuttons = true
		elseif love.mouse.getX() > 25*8+16-28 then
			onlefthelpbuttons = false
		end
	end
	
	if coordsdialog.active or RCMactive or (DIAwindowani ~= 16) then
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
				elseif RCMreturn == L.PROPERTIES then
					-- Edit properties of this entity, whatever it is. But if we were editing room text or a name of something, stop that first.
					if editingroomtext > 0 then
						-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the properties of
						endeditingroomtext(tonumber(entdetails[3]))
					end
					
					thisentity = entitydata[tonumber(entdetails[3])]
					startmultiinput({thisentity.x, thisentity.y, thisentity.t, thisentity.p1, thisentity.p2, thisentity.p3, thisentity.p4, thisentity.p5, thisentity.p6, thisentity.data})
					dialog.new(L.RAWENTITYPROPERTIES .. "\n\nx\ny\nt\np1\np2\np3\np4\np5\np6\n" .. L.SMALLENTITYDATA, (allowdebug and "[ID: " .. tonumber(entdetails[3]) .. "] (do not rely on the ID)" or ""), 1, 5, 2) -- ID stuff is debug mode
				elseif tonumber(entdetails[2]) == 1 then
					-- Enemy
					if RCMreturn == L.CHANGEDIRECTION then
						entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 3, 0)
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 2 then
					-- Platform, moving/conveyor
					if RCMreturn == L.CYCLETYPE then
						if entitydata[tonumber(entdetails[3])].p1 < 4 then
							-- Moving platform
							entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 3, 0)
						else
							-- Conveyor
							entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 8, 5)
						end
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 10 then
					-- Checkpoint
					if RCMreturn == L.FLIP then
						entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 11 then
					-- Gravity line
					if RCMreturn == L.CHANGETOHOR then
						entitydata[tonumber(entdetails[3])].p1 = 0
						autocorrectlines()
					elseif RCMreturn == L.CHANGETOVER then
						entitydata[tonumber(entdetails[3])].p1 = 1
						autocorrectlines()
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 13 then
					-- Warp token
					if RCMreturn == L.GOTODESTINATION then
						gotoroom(math.floor(entitydata[tonumber(entdetails[3])].p1 / 40), math.floor(entitydata[tonumber(entdetails[3])].p2 / 30))
						love.mouse.setPosition(64+64 + (entitydata[tonumber(entdetails[3])].p1 - (roomx*40))*16 + 8, (entitydata[tonumber(entdetails[3])].p2 - (roomy*30))*16 + 8)
						cons("Destination token is at " .. entitydata[tonumber(entdetails[3])].p1 .. " " .. entitydata[tonumber(entdetails[3])].p2 .. "... So at " .. entitydata[tonumber(entdetails[3])].p1 - (roomx*40) .. " " .. entitydata[tonumber(entdetails[3])].p2 - (roomy*30) .. " in room " .. roomx .. " " .. roomy)
					elseif RCMreturn == L.GOTOENTRANCE then
						gotoroom(math.floor(entitydata[tonumber(entdetails[3])].x / 40), math.floor(entitydata[tonumber(entdetails[3])].y / 30))
						love.mouse.setPosition(64+64 + (entitydata[tonumber(entdetails[3])].x - (roomx*40))*16 + 8, (entitydata[tonumber(entdetails[3])].y - (roomy*30))*16 + 8)
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
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 15 then
					-- Rescuable crewmate
					if RCMreturn == L.CHANGECOLOR then
						entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 5, 0)
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				elseif tonumber(entdetails[2]) == 16 then
					-- Start point
					if RCMreturn == L.CHANGEDIRECTION then
						entitydata[tonumber(entdetails[3])].p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
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
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
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
							dialog.new(langkeys(L.SCRIPT404, {entitydata[tonumber(entdetails[3])].data}), "", 1, 1, 0)
						else
							--##SCRIPT##  DONE
							scriptineditor(entitydata[tonumber(entdetails[3])].data)
							--scriptname = entitydata[tonumber(entdetails[3])].data
							--scriptlines = table.copy(scripts[entitydata[tonumber(entdetails[3])].data])
							--processflaglabels()
							--tostate(3)
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
						--[[
						box_exists = true
						boxperi_x, boxperi_y, boxperi_w, boxperi_h = 128, 0, 640, 480
						box_x, box_y, box_w, box_h = 128+(entitydata[tonumber(entdetails[3])].x-roomx*40)*16, (entitydata[tonumber(entdetails[3])].x-roomy*30)*16, (entitydata[tonumber(entdetails[3])].p1-1)*16, (entitydata[tonumber(entdetails[3])].p2-1)*16
						box_type = 1
						box_movable = false -- nu nog wel
						box_outsideiscancel = true
						box_meta = tonumber(entdetails[3])
						]]
					elseif RCMreturn == toolnames[12] then
						local ret = namefound(entitydata[tonumber(entdetails[3])])
						if ret == 1 then
							s_nieuw(tonumber(entdetails[3]))
						elseif ret == -1 then
							p_nieuw(tonumber(entdetails[3]))
						end
					else
						dialog.new(RCMid .. " " .. RCMreturn .. " not supported yet.", "", 1, 1, 0)
					end
				else
					dialog.new(langkeys(L.UNKNOWNENTITYTYPE, {anythingbutnil(entdetails[2])}) .. ",\n\nID: " .. RCMid .. "\nReturn value: " .. RCMreturn, "", 1, 1, 0)
				end
			else
				dialog.new(langkeys(L.ENTITY404, {tonumber(entdetails[3])}), "", 1, 1, 0)
			end
		elseif RCMid == "savemap" then
			if RCMreturn == L.SAVEMAP then
				-- You could have just left clicked the button but this is to prevent confusion.
				savemapimage()
			elseif RCMreturn == L.SAVEFULLSIZEMAP then
				-- Save a big map!
				if not love.graphics.isSupported("canvas") then
					dialog.new(L.GRAPHICSCARDCANVAS, "", 1, 1, 0)
				else
					mapcanvas = love.graphics.newCanvas(320*metadata.mapwidth, 240*metadata.mapheight)
					love.graphics.setCanvas(mapcanvas)
					for mry = 0, metadata.mapheight-1 do
						for mrx = 0, metadata.mapwidth-1 do
							displayroom(mrx*0.5*640, mry*0.5*480, roomdata[mry][mrx], levelmetadata[(mry)*20 + (mrx+1)], 0.5) --mapscale
						end
					end
					saveas = (editingmap == "untitled\n" and "untitled" or editingmap) .. "_" .. os.time() .. "_fullsize.png"
					local _, v = love.getVersion()
					if v == 9 then
						mapcanvas:getImageData():encode("maps/" .. saveas)
					else
						mapcanvas:newImageData():encode("png", "maps/" .. saveas)
					end
					love.graphics.setCanvas()
					mapcanvas = nil
					
					-- Love2d bug regarding canvases and scissors?
					za,zb,zc = love.window.getMode()
					love.window.setMode(za,zb,zc)
					
					collectgarbage("collect")
					dialog.new(langkeys(L.MAPSAVEDAS, {saveas, love.filesystem.getSaveDirectory()}), "", 1, 1, 0)
				end
			else
				dialog.new(RCMid .. " " .. RCMreturn .. " unrecognized.", "", 1, 1, 0)
			end
		elseif RCMid:sub(1, 4) == "spt_" then
			local rvnum = tonumber(RCMid:sub(5, -1))
			
			if RCMreturn == L.EDIT then
				--##SCRIPT##  DONE
				scriptineditor(scriptnames[rvnum], rvnum)
				--scriptname = scriptnames[rvnum]
				--scriptlines = table.copy(scripts[scriptnames[rvnum]])
				--processflaglabels()
				--bumpscript(rvnum)
				--tostate(3)
			elseif RCMreturn == L.EDITWOBUMPING then
				--##SCRIPT##  DONE
				scriptineditor(scriptnames[rvnum], -1)
				--scriptname = scriptnames[rvnum]
				--scriptlines = table.copy(scripts[scriptnames[rvnum]])
				--processflaglabels()
				----bumpscript(rvnum)
				--tostate(3)
			elseif RCMreturn == L.COPYNAME then
				love.system.setClipboardText(scriptnames[rvnum])
			elseif RCMreturn == L.COPYCONTENTS then
				love.system.setClipboardText(table.concat(scripts[scriptnames[rvnum]], (love.system.getOS() == "Windows" and "\r\n" or "\n")))
			elseif RCMreturn == L.DUPLICATE then
				startmultiinput({""})
				dialog.new(L.NEWSCRIPTNAME, L.DUPLICATE, 1, 4, 22)
				input = rvnum
			elseif RCMreturn == L.DELETE then
				dialog.new(langkeys(L.SUREDELETESCRIPT, {scriptnames[rvnum]}), "", 1, 3, 17)
				input = rvnum
			elseif RCMreturn == L.RENAME then
				startmultiinput({scriptnames[rvnum]})
				dialog.new(L.NEWNAME, L.RENAMESCRIPT, 1, 4, 19)
				input = rvnum
			else
				dialog.new(RCMid .. " " .. RCMreturn .. " unrecognized.", "", 1, 1, 0)
			end
		elseif RCMid == "music" then
			for k,v in pairs(listmusicnamesids) do
				if RCMreturn == v[1] then
					multiinput[9] = v[2]
					break
				end
			end
		elseif RCMid == "language" then
			multiinput[1] = RCMreturn
		else
			dialog.new("Unhandled right click menu!\n\nID: " .. RCMid .. "\nReturn value: " .. RCMreturn, "", 1, 1, 0)
		end
		
		RCMreturn = ""
	end
	
	hook("love_update_end")
	
	dialog.update()
	boxupdate()
end

function love.textinput(char)
	-- Are we holding down windows/super? Won't matter on Windows, but could for Linux...
	if love.system.getOS() ~= "OS X" and (love.keyboard.isDown("lgui") or love.keyboard.isDown("rgui")) then
		return
	end

	-- Ved should really only accept printable ASCII only when typing...
	if s.acceptutf8 or (state == 13 or state == 15 or char:byte(2, 2) == nil) then
		if takinginput then
			-- Ugly, but at least won't need another global variable that appears here and there
			if (state == 1) and not nodialog and editingroomname and (char:lower() == "e") then
			else
				input = input .. char
			end
			
			cursorflashtime = 0
			
			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			elseif state == 6 then
				tabselected = 0
			end
		elseif currentmultiinput ~= 0 then
			multiinput[currentmultiinput] = multiinput[currentmultiinput] .. char
		end
	end
	
	if coordsdialog.active then
		coordsdialog.type(char)
	end
end

function love.keypressed(key)
	-- Global argument for hooks
	_G.key = key

	hook("love_keypressed_start")

	-- Your privacy is respected.
	keyva.keypressed(key)
	
	-- DEBUG FOR FPS CAP
	if allowdebug and key == "pagedown" and love.keyboard.isDown("r" .. ctrl) then
		fpscap = (fpscap + 1) % 4
	elseif allowdebug and key == "pageup" and love.keyboard.isDown("r" .. ctrl) then
		debug.debug()
	end
	
	if RCMactive and RCMabovedialog and not RCMturnedintofield then
		rightclickmenu.tofield()
	end

	if coordsdialog.active and key == "backspace" then
		coordsdialog.input = coordsdialog.input:sub(1, -2)
	elseif takinginput then
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
			elseif state == 15 then
				-- Exact same story here.
				if helparticlecontent[helpeditingline] == "" and helpeditingline ~= 1 then
					table.remove(helparticlecontent, helpeditingline)
					helpeditingline = helpeditingline - 1
					input = anythingbutnil(helparticlecontent[helpeditingline])
				else
					helparticlecontent[helpeditingline] = input
				end
			elseif state == 6 then
				tabselected = 0
			end
		elseif love.keyboard.isDown("l" .. ctrl) and love.keyboard.isDown("v") then
			input = input .. love.system.getClipboardText()
			
			if state == 3 then
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
		elseif key == "left" and not love.keyboard.isDown("l" .. ctrl) and not love.keyboard.isDown("r" .. ctrl) then
			input, input_r = leftspace(input, input_r)
			
			cursorflashtime = 0

			if state == 3 then
				scriptlines[editingline] = input
			elseif state == 15 and helpeditingline ~= 0 then
				helparticlecontent[helpeditingline] = input
			end
		elseif key == "right" and not love.keyboard.isDown("l" .. ctrl) and not love.keyboard.isDown("r" .. ctrl) then
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
		end
	--elseif currentmultiinput ~= 0 then
	elseif #multiinput > 0 then
		if key == "backspace" then
			multiinput[currentmultiinput] = backspace(multiinput[currentmultiinput])
		elseif love.keyboard.isDown("l" .. ctrl) and love.keyboard.isDown("v") then
			multiinput[currentmultiinput] = multiinput[currentmultiinput] .. love.system.getClipboardText()
		elseif love.keyboard.isDown("tab") and love.keyboard.isDown("lshift") then
			RCMactive = false
		
			if currentmultiinput <= 1 then
				currentmultiinput = #multiinput
			else
				currentmultiinput = currentmultiinput - 1
			end
		elseif love.keyboard.isDown("tab") then
			RCMactive = false
		
			if currentmultiinput >= #multiinput then
				currentmultiinput = 1
			else
				currentmultiinput = currentmultiinput + 1
			end
		end
		
		if RCMactive and RCMabovedialog and key == "return" then
			RCMactive = false
		end
	end
	
	handleScrolling(true, key)
	
	if DIAwindowani ~= 16 and DIAcanclose == 1 and key == "return" then
		dialog.push()
		DIAreturn = 1
	elseif DIAwindowani ~= 16 and DIAcanclose == 2 and key == "return" then
		dialog.push()
		DIAreturn = 1
		DIAquitting = 1
	elseif DIAwindowani ~= 16 and DIAcanclose == 4 and key == "return" then
		dialog.push()
		DIAreturn = 2
	elseif DIAwindowani ~= 16 and DIAcanclose == 5 and key == "return" then
		dialog.push()
		DIAreturn = 3
		
	elseif DIAwindowani ~= 16 and DIAcanclose == 3 and key == "y" then
		dialog.push()
		DIAreturn = 2
	elseif DIAwindowani ~= 16 and DIAcanclose == 3 and key == "n" then
		dialog.push()
		DIAreturn = 1
	elseif DIAwindowani ~= 16 and DIAcanclose == 4 and key == "escape" then
		dialog.push()
		DIAreturn = 1
	elseif DIAwindowani ~= 16 and DIAcanclose == 5 and key == "escape" then
		dialog.push()
		DIAreturn = 2
		
	elseif state == 0 and key == "return" and love.keyboard.isDown("lshift") then
		stopinput()
		tostate(input, true)
	elseif state == 0 and key == "return" then
		stopinput()
		tostate(input)
	--elseif (state == 1) and (key == "z") then -- temporary key, might change
		--zoomscale = 2
	--[[
	elseif nodialog and editingroomtext == 0 and (state == 1) and (key == "s") then -- again, but cycle tileset
		--metadata.tileset = cycle(metadata.tileset, 2)
		if usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset] == 1 then
			levelmetadata[(roomy)*20 + (roomx+1)].tileset = 1
		else
			levelmetadata[(roomy)*20 + (roomx+1)].tileset = 0
		end
	]]
	elseif sp_t ~= 0 and key == "escape" then
		sp_t = 0
		sp_go = true
	elseif sp_t ~= 0 and state == 1 and not (sp_go and sp_got <= 0) then
		--if sp_t > 0 and (key == "up" or key == "right" or key == "down" or key == "left") then
			--s_hoofdd = ({up=0, right=1, down=2, left=3})[key]
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
	elseif nodialog and editingroomtext == 0 and not editingroomname and state == 1 and love.keyboard.isDown("lshift") and love.keyboard.isDown("l" .. ctrl) then
		tilespicker = true
		tilespicker_shortcut = true
		
		if key == "left" then
			selectedtile = selectedtile - 1
		elseif key == "right" then
			selectedtile = (selectedtile + 1) % 1200
		elseif key == "up" then
			selectedtile = selectedtile - 40
		elseif key == "down" then
			selectedtile = (selectedtile + 40) % 1200
		end
		
		if selectedtile < 0 then
			selectedtile = selectedtile + 1200
		end
		
	elseif nodialog and editingroomtext == 0 and not editingroomname and (state == 1) and key == "," then
		if love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl) then
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
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			else
				selectedtool = 17
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			end
			updatewindowicon()
			toolscroll()
		end
	elseif nodialog and editingroomtext == 0 and not editingroomname and (state == 1) and key == "." then
		if love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl) then
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
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			else
				selectedtool = 1
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			end
			updatewindowicon()
			toolscroll()
		end
		
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "q" then
		coordsdialog.activate()
	elseif coordsdialog.active and key == "escape" then
		coordsdialog.active = false
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "m" then
		tostate(12)
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "/" then
		if love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl) then
			tonotepad()
		else
			tostate(10)
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "f" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
		tostate(11)
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "p" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
		gotostartpointroom()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "d" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
		tostate(6, nil, "secondlevel")
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "]" and mouselockx == -1 then
		mouselockx = love.mouse.getX()
	elseif nodialog and not editingroomname and editingroomtext == 0 and state == 1 and key == "[" and mouselocky == -1 then
		mouselocky = love.mouse.getY()
	elseif nodialog and editingbounds ~= 0 and state == 1 and key == "escape" then
		editingbounds = 0
	elseif nodialog and editingbounds ~= 0 and state == 1 and key == "delete" then
		if editingbounds == -1 or editingbounds == 1 then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx1, levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 = 0, 0
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx2, levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = 320, 240
		else
			levelmetadata[(roomy)*20 + (roomx+1)].platx1, levelmetadata[(roomy)*20 + (roomx+1)].platy1 = 0, 0
			levelmetadata[(roomy)*20 + (roomx+1)].platx2, levelmetadata[(roomy)*20 + (roomx+1)].platy2 = 320, 240
		end
		
		editingbounds = 0
	elseif nodialog and not editingroomname and editingroomtext == 0 and (state == 1) and (key == "right") then
		-->
		if editingbounds == 0 then
			if roomx+1 >= metadata.mapwidth then
				roomx = 0
			else
				roomx = roomx + 1
			end
			
			gotoroom_finish()
		--[[
		elseif editingbounds == -1 and  levelmetadata[(roomy)*20 + (roomx+1)].enemyx1+8 < levelmetadata[(roomy)*20 + (roomx+1)].enemyx2  then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 = levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 + 8
		elseif editingbounds == 1 and levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 < 320 then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 = levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 + 8
		elseif editingbounds == -2 and  levelmetadata[(roomy)*20 + (roomx+1)].platx1+8 < levelmetadata[(roomy)*20 + (roomx+1)].platx2  then
			levelmetadata[(roomy)*20 + (roomx+1)].platx1 = levelmetadata[(roomy)*20 + (roomx+1)].platx1 + 8
		elseif editingbounds == 2 and levelmetadata[(roomy)*20 + (roomx+1)].platx2 < 320 then
			levelmetadata[(roomy)*20 + (roomx+1)].platx2 = levelmetadata[(roomy)*20 + (roomx+1)].platx2 + 8
		]]
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and (state == 1) and (key == "left") then
		--<
		if editingbounds == 0 then
			if roomx+1 <= 1 then
				roomx = metadata.mapwidth-1
			else
				roomx = roomx - 1
			end
			
			gotoroom_finish()
		--[[
		elseif editingbounds == -1 and  levelmetadata[(roomy)*20 + (roomx+1)].enemyx2-8 > levelmetadata[(roomy)*20 + (roomx+1)].enemyx1  then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 = levelmetadata[(roomy)*20 + (roomx+1)].enemyx2 - 8
		elseif editingbounds == 1 and levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 > 0 then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 = levelmetadata[(roomy)*20 + (roomx+1)].enemyx1 - 8
		elseif editingbounds == -2 and  levelmetadata[(roomy)*20 + (roomx+1)].platx2-8 > levelmetadata[(roomy)*20 + (roomx+1)].platx1  then
			levelmetadata[(roomy)*20 + (roomx+1)].platx2 = levelmetadata[(roomy)*20 + (roomx+1)].platx2 - 8
		elseif editingbounds == 2 and levelmetadata[(roomy)*20 + (roomx+1)].platx1 > 0 then
			levelmetadata[(roomy)*20 + (roomx+1)].platx1 = levelmetadata[(roomy)*20 + (roomx+1)].platx1 - 8
		]]
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and (state == 1) and (key == "down") then
		--v
		if editingbounds == 0 then
			if roomy+1 >= metadata.mapheight then
				roomy = 0
			else
				roomy = roomy + 1
			end
			
			gotoroom_finish()
		--[[
		elseif editingbounds == -1 and  levelmetadata[(roomy)*20 + (roomx+1)].enemyy1+8 < levelmetadata[(roomy)*20 + (roomx+1)].enemyy2  then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 = levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 + 8
		elseif editingbounds == 1 and levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 < 240 then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 + 8
		elseif editingbounds == -2 and  levelmetadata[(roomy)*20 + (roomx+1)].platy1+8 < levelmetadata[(roomy)*20 + (roomx+1)].platy2  then
			levelmetadata[(roomy)*20 + (roomx+1)].platy1 = levelmetadata[(roomy)*20 + (roomx+1)].platy1 + 8
		elseif editingbounds == 2 and levelmetadata[(roomy)*20 + (roomx+1)].platy2 < 240 then
			levelmetadata[(roomy)*20 + (roomx+1)].platy2 = levelmetadata[(roomy)*20 + (roomx+1)].platy2 + 8
		]]
		end
	elseif nodialog and not editingroomname and editingroomtext == 0 and (state == 1) and (key == "up") then
		--^
		if editingbounds == 0 then
			if roomy+1 <= 1 then
				roomy = metadata.mapheight-1
			else
				roomy = roomy - 1
			end
			
			gotoroom_finish()
		--[[
		elseif editingbounds == -1 and  levelmetadata[(roomy)*20 + (roomx+1)].enemyy2-8 > levelmetadata[(roomy)*20 + (roomx+1)].enemyy1  then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 = levelmetadata[(roomy)*20 + (roomx+1)].enemyy2 - 8
		elseif editingbounds == 1 and levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 > 0 then
			levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 = levelmetadata[(roomy)*20 + (roomx+1)].enemyy1 - 8
		elseif editingbounds == -2 and  levelmetadata[(roomy)*20 + (roomx+1)].platy2-8 > levelmetadata[(roomy)*20 + (roomx+1)].platy1  then
			levelmetadata[(roomy)*20 + (roomx+1)].platy2 = levelmetadata[(roomy)*20 + (roomx+1)].platy2 - 8
		elseif editingbounds == 2 and levelmetadata[(roomy)*20 + (roomx+1)].platy1 > 0 then
			levelmetadata[(roomy)*20 + (roomx+1)].platy1 = levelmetadata[(roomy)*20 + (roomx+1)].platy1 - 8
		]]
		end
	elseif state == 1 and editingroomname and key == "return" then
		editingroomname = false
		stopinput()
		levelmetadata[(roomy)*20 + (roomx+1)].roomname = input
	elseif state == 1 and editingroomtext > 0 and key == "return" then
		endeditingroomtext()
	elseif allowdebug and state == 1 and key == "\\" and love.keyboard.isDown("lctrl") then
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
	elseif allowdebug and state == 1 and key == "'" then
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
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "f4") then
		-- Enemy bounds
		changeenemybounds()
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "f5") then
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
		if (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and editingmap ~= "untitled\n" then
			-- Quicksave- we have a name already
			
			-- Maybe we have a massive map... Or a slow computer
			temporaryroomname = L.BUSYSAVING
			temporaryroomnametimer = 9000 -- Surely saving a map won't take more than ~5 minutes, would it? I mean...
			
			love.graphics.clear(); love.draw(); love.graphics.present()
			
			-- Save now
			savedsuccess, savederror = savelevel(editingmap .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata)
			
			if not savedsuccess then
				-- Why not :c
				dialog.new(L.SAVENOSUCCESS .. anythingbutnil(savederror), "", 1, 1, 0)
			else
				temporaryroomname = langkeys(L.SAVEDLEVELAS, {editingmap})
				temporaryroomnametimer = 90
			end
		else
			startmultiinput({(editingmap ~= "untitled\n" and editingmap or ""), metadata.Title})
			dialog.new(L.ENTERNAMESAVE .. "\n\n\n" .. L.ENTERLONGOPTNAME, "", 1, 4, 10)
		end
	elseif nodialog and editingroomtext == 0 and editingroomname == false and (state == 1) and (key == "l") then
		-- Load
		--dialog.new(L.SURELOADLEVEL .. "\n\n(dialog will be save/don't save/cancel later)", "", 1, 3, 3)
		tostate(6)
	elseif nodialog and (state == 1 or state == 6) and key == "n" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
		-- New level?
		if state == 6 and not state6old1 then
			stopinput()
			triggernewlevel()
			-- Don't immediately trigger the dialog in state 1!
			nodialog = false
		else
			-- Else block also runs if state == 6 and state6old1, and thus makes a dialog appear; hey a free feature!
			dialog.new(L.SURENEWLEVEL, "", 1, 3, 7)
		end
	elseif nodialog and (editingroomtext == 0) and (editingroomname == false) and (state == 1) and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and love.keyboard.isDown("y") then
		-- No wait redo
		redo()
	elseif (not holdingzvx) and nodialog and (editingroomtext == 0) and (editingroomname == false) and (state == 1) and ((key == "c") or (key == "v") or (key == "z") or (key == "x") or (key == "h") or (key == "b")) then -- Tried cleaning this bit up, later I realized why it was like this
		if (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and love.keyboard.isDown("z") then
			-- We goofed, undo.
			undo()
		-- Redo code had to be moved
		elseif (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and love.keyboard.isDown("x") then
			-- Cut the room!
			cutroom()
		elseif (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and love.keyboard.isDown("c") then
			-- Copy the room!
			copyroom()
		elseif (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) and love.keyboard.isDown("v") then
			-- Try pasting
			pasteroom()
		elseif key == "z" then
			-- 3x3 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 5 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 or selectedtool == 10 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 2
				
				holdingzvx = true
			end
		elseif key == "x" then
			-- 5x5 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 3
				
				holdingzvx = true
			end
		elseif key == "c" then
			-- Alright, 7x7 brush
			if selectedtool == 1 or selectedtool == 2 or selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 4
				
				holdingzvx = true
			end
		elseif key == "v" then
			-- And 9x9 brush
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 5
				
				holdingzvx = true
			end
		elseif key == "h" then
			-- Horizontal
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 6
				
				holdingzvx = true
			end
		elseif key == "b" then
			-- Vertical
			if selectedtool == 1 or selectedtool == 2 then
				oldzxsubtool = selectedsubtool[selectedtool]
				selectedsubtool[selectedtool] = 7
				
				holdingzvx = true
			end
		end
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
	elseif state == 3 and key == "return" then
		-- We can split lines because the current line is in input and input_r.
		-- So input_r is simply transferred to the newly inserted line along with the cursor.
		table.insert(scriptlines, editingline+1, "")
		editingline = editingline + 1
		input = anythingbutnil(scriptlines[editingline])
		-- We also want to scroll the screen if necessary
		scriptlineonscreen()
	elseif state == 3 and key == "f3" then
		inscriptsearch(scriptsearchterm)
	elseif state == 3 and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
		if key == "left" and #scripthistorystack > 0 then
			editorjumpscript(scripthistorystack[#scripthistorystack][1], true, scripthistorystack[#scripthistorystack][2])
		elseif key == "right" and context == "flagscript" and carg2 ~= nil and carg2 ~= "" then
			editorjumpscript(carg2)
		elseif key == "right" and context == "script" then
			editorjumpscript(carg1)
		elseif key == "f" then
			startinscriptsearch()
		elseif key == "g" then
			startscriptgotoline()
		end
	elseif (state == 6) and key == "return" and tabselected == 0 then
		state6load(input)
	elseif (state == 6) and (((love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) and key == "tab") or key == "up") then
		if tabselected > 0 then
			tabselected = tabselected - 1
		end
	elseif (state == 6) and (key == "tab" or key == "down") then --and tabselected < #files then
		tabselected = tabselected + 1
	elseif (state == 6) and key == "escape" then
		if tabselected ~= 0 then
			tabselected = 0
		else
			if state6old1 then
				tostate(1, true)
			end
		end
	elseif (state == 8) and (key == "return") then
		stopinput()
		savedsuccess, savederror = savelevel(input .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata)
		editingmap = input
	elseif state == 10 and (key == "up" or key == "down") then
		handleScrolling(false, key == "up" and "wu" or "wd") -- 16px
	elseif state == 11 and key == "return" then
		searchscripts, searchrooms, searchnotes = searchtext(input)
		searchedfor = input
	elseif nodialog and (state == 10 or state == 11 or state == 12) and key == "escape" then
		tostate(1, true)
		nodialog = false
	elseif nodialog and (state == 15 or state == 19) and key == "escape" then
		tostate(oldstate, true)
		nodialog = false
	elseif nodialog and state == 3 and key == "escape" then
		leavescript_to_state = function()
			scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
			scripts[scriptname] = table.copy(scriptlines)
			tostate(10, true)
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
		elseif key == "down" and helparticlecontent[helpeditingline+1] ~= nil then
			helparticlecontent[helpeditingline] = input .. input_r
			input_r = ""
			__ = "_"
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
		elseif key == "return" then
			table.insert(helparticlecontent, helpeditingline+1, "")
			helpeditingline = helpeditingline + 1
			input = anythingbutnil(helparticlecontent[helpeditingline])
		elseif key == "insert" then
			input = input .. "¤"
			helparticlecontent[helpeditingline] = input
		end
	elseif allowdebug and (key == "f10") then
		
	elseif allowdebug and (key == "f11") then
		if love.keyboard.isDown("l" .. ctrl) then
			cons("You pressed " .. ctrl .. "+F11, you get a wall.\n\n***********************************\n* G L O B A L   V A R I A B L E S *\n***********************************\n")
			for k,v in pairs(_G) do
				if type(v) == "boolean" then
					print(k .. " = " .. (v and "true" or "false") .. "\t\t\t[boolean]")
				elseif type(v) == "function" then
					print(k .. "\t\t\t[function]")
				elseif type(v) == "table" then
					print(k .. "\t\t\t[table]")
				elseif type(v) == "userdata" then
					print(k .. "\t\t\t[userdata]")
				else
					print(k .. " = " .. v .. "\t\t\t[" .. type(v) .. "]")
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
				if selectedtool == k and k ~= 13 and k ~= 14 then
					-- We're re-pressing this button, so set the subtool to the first one.
					selectedsubtool[k] = 1
				elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					selectedtool = k
					updatewindowicon()
				end
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
				toolscroll()
			end
		end
	elseif (state == 22 or state == 23) and key == "return" then
		stopinput()
		scsuccess, sccontents = readlevelfile(input)
		if scsuccess then
			--##SCRIPT##  BIJZONDER
			scriptname = input
			scriptlines = explode((state == 22 and "%$" or "\r?\n"), sccontents) --table.copy(scripts[scriptnames[rvnum]])
			--processflaglabels()
			--bumpscript(rvnum)
			tostate(3)
		else
			dialog.new("Cannot open " .. input .. "\n\n" .. sccontents, "", 1, 1, 0)
			startinput()
		end
	end
end

function love.keyreleased(key)
	-- Global argument for hooks
	_G.key = key

	hook("love_keyreleased_start")

	if holdingzvx and (key == "z" or key == "x" or key == "c" or key == "v" or key == "h" or key == "b") then
		if selectedtool == 1 or selectedtool == 2 or ((selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9) and oldzxsubtool <= 4) or ((selectedtool == 5 or selectedtool == 10) and oldzxsubtool <= 2) then
			selectedsubtool[selectedtool] = oldzxsubtool
		end
		holdingzvx = false
	elseif key == "]" then
		mouselockx = -1
	elseif key == "[" then
		mouselocky = -1
	elseif tilespicker_shortcut and (key == "lshift" or key == "l" .. ctrl) then
		tilespicker = false
		tilespicker_shortcut = false
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
	
	if s.pscale ~= 1 then
		x, y = x*s.pscale^-1, y*s.pscale^-1
	end
	
	-- Global argument for hooks
	_G.x = x
	_G.y = y
	_G.button = button
	
	hook("love_mousepressed_start")
	

	if (DIAwindowani ~= 16) and (DIAbar == 1) and (button == "l") and (x >= DIAx) and (x <= DIAx+DIAwidth) and (y >= DIAy-17) and (y <= DIAy) then
		DIAmovingwindow = 1
		DIAmovedfromwx = DIAx
		DIAmovedfromwy = DIAy
		DIAmovedfrommx = x
		DIAmovedfrommy = y
	end
	
	--[[
	if DIAwindowani ~= 16 then
		if (DIAcanclose == 1) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
		elseif (DIAcanclose == 2) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
			DIAquitting = 1
		elseif (DIAcanclose == 3 or DIAcanclose == 4) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
		elseif (DIAcanclose == 5) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			DIAreturn = 1
		elseif (DIAcanclose == 3 or DIAcanclose == 4 or DIAcanclose == 5) and mousein(DIAx+DIAwidth-106, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-56, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 2
		elseif (DIAcanclose == 5) and mousein(DIAx+DIAwidth-161, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-106, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 3
		end
		
		return
	end
	]]
	
	if state == 1 then
		if x < 64 and not (love.keyboard.isDown("lctrl") or love.keyboard.isDown("lshift") or love.keyboard.isDown("rctrl") or love.keyboard.isDown("rshift")) then
			if button == "wu" then
				lefttoolscroll = lefttoolscroll + 16
				lefttoolscrollbounds()
			elseif button == "wd" then
				lefttoolscroll = lefttoolscroll - 16
				lefttoolscrollbounds()
			end
		--[[
		elseif mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-32-2-12-8, (6*16), 8+4) then -- tileset picker
			if dropdown == 1 then
				dropdown = 0
			else
				--dropdown = 1
				rightclickmenu.create({"#1", "Space St.", "#2", "Outside", "Lab", "Warp Zone", "Ship"}, "tileset")
			end
		]]
		elseif nodialog and mouseon(love.graphics.getWidth()-(7*16)-1, love.graphics.getHeight()-16-16-2-4-8, (6*16), 8+4) then -- show all tiles
			tilespicker = not tilespicker
			
		elseif nodialog and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("lshift") or love.keyboard.isDown("rctrl") or love.keyboard.isDown("rshift")) and button == flipscrollmore(macscrolling and "wd" or "wu") and mousein(0, 0, love.graphics.getWidth(), love.graphics.getHeight()) and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
			if selectedtool > 1 then
				selectedtool = selectedtool - 1
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			else
				selectedtool = 17
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			end
			updatewindowicon()
			toolscroll()
		elseif nodialog and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("lshift") or love.keyboard.isDown("rctrl") or love.keyboard.isDown("rshift")) and button == flipscrollmore(macscrolling and "wu" or "wd") and mousein(0, 0, love.graphics.getWidth(), love.graphics.getHeight()) and not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
			if selectedtool < 17 then
				selectedtool = selectedtool + 1
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			else
				selectedtool = 1
				--lefttoolscroll = math.max(16-(48*(selectedtool-1)), -368)
			end
			updatewindowicon()
			toolscroll()
		elseif nodialog and button == flipscrollmore(macscrolling and "wd" or "wu") and mousein(64, 0, love.graphics.getWidth(), love.graphics.getHeight()) and selectedtool ~= 14 then
			if selectedsubtool[selectedtool] > 1 then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] - 1
			else
				selectedsubtool[selectedtool] = #subtoolimgs[selectedtool]
			end
		elseif nodialog and button == flipscrollmore(macscrolling and "wu" or "wd") and mousein(64, 0, love.graphics.getWidth(), love.graphics.getHeight()) and selectedtool ~= 14 then
			if selectedsubtool[selectedtool] < #subtoolimgs[selectedtool] then
				selectedsubtool[selectedtool] = selectedsubtool[selectedtool] + 1
			else
				selectedsubtool[selectedtool] = 1
			end
		end
	elseif state == 6 and hoveringlevel ~= nil and button == "l" then
		-- Just like when going to a room by clicking on the map, we don't want to click the first tile we press.
		nodialog = false
		
		state6load(hoveringlevel)
	elseif state == 9 and button == "r" then -- TEST STATE
		rightclickmenu.create({"Delete", "Edit script", "Rename"}, "1")
	else
		handleScrolling(false, button)
	end
	
	boxmousepress()
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

	if s.pscale ~= 1 then
		x, y = x*s.pscale^-1, y*s.pscale^-1
	end
	
	-- Global argument for hooks
	_G.x = x
	_G.y = y
	_G.button = button
	
	hook("love_mousereleased_start")
	
	
	if state == 1 and undosaved ~= 0 and undobuffer[undosaved] ~= nil then
		undobuffer[undosaved].toredotiles = table.copy(roomdata[roomy][roomx])
		undosaved = 0
		cons("[UNRE] SAVED END RESULT FOR UNDO")
	end

	mousepressed = false
	minsmear = -1; maxsmear = -1
	toout = 0
	
	if DIAmovingwindow == 1 then
		DIAx = DIAmovedfromwx + (x-DIAmovedfrommx)
		DIAy = DIAmovedfromwy + (y-DIAmovedfrommy)
		DIAmovingwindow = 0
	end
	
	boxmouserelease()
end

function love.quit()
	if s.askbeforequit then
		if nodialog and not bypassdialog then
			dialog.new(L.SUREQUIT, "", 1, 3, 8)
			return true
		elseif not nodialog then
			return true
		end
	end
end

function love.threaderror(thread, errorstr)
	dialog.new(L.THREADERROR .. "\n\n" .. errorstr, "", 1, 1, 0)
end