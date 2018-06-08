-- Languages haven't been loaded yet.
ERR_VEDHASCRASHED = "Ved has crashed!"
ERR_VEDVERSION = "Ved version:"
ERR_LOVEVERSION = "LÖVE version:"
ERR_STATE = "State:"
ERR_OS = "OS:"
ERR_TIMESINCESTART = "Time since start:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(not loaded)"
ERR_PLUGINSNONE = "(none)"
ERR_PLEASETELLDAV = "Please tell Dav999 about this problem.\n\n\nDetails: (press ctrl/cmd+C to copy to the clipboard)\n\n"
ERR_INTERMEDIATE = " (intermediate version)"
ERR_TOONEW = " (too new)"

ERR_PLUGINERROR = "Plugin error!"
ERR_FILE = "File to be edited:"
ERR_FILEEDITORS = "Plugins that edit this file:"
ERR_CURRENTPLUGIN = "Plugin that triggered the error:"
ERR_PLEASETELLAUTHOR = "A plugin was supposed to make an edit to code in Ved, but the code to be replaced was not found.\nIt is possible that this was caused by a conflict between two plugins, or a Ved update broke\nthis plugin.\n\nDetails: (press ctrl/cmd+C to copy to the clipboard)\n\n"
ERR_CONTINUE = "You can continue by pressing ESC or enter, but note this failed edit may cause issues."
ERR_REPLACECODE = "Failed to find this in %s.lua:"
ERR_REPLACECODEPATTERN = "Failed to find this in %s.lua (as pattern):"
ERR_LINESTOTAL = "%i lines in total"

ERR_SAVELEVEL = "To save a copy of your level, press S"
ERR_SAVESUCC = "Level saved successfully as %s!"
ERR_SAVEERROR = "Save error! %s"
ERR_LOGSAVED = "More information can be found in the crash log:\n%s"


function error_printer(msg, layer)
	--return debug.traceback("Error: " .. tostring(msg), 1+(layer or 1)):gsub("\n[^\n]+$", "")
	return debug.traceback()
end

function love.errhand(msg)
	local status, err = pcall(ved_showerror, msg)

	if not status then
		-- What, the crash screen has also crashed! Maybe a very basic crash screen doesn't?
		if type(msg) ~= "string" then
			msg = "[msg not string]"
		end
		if type(err) ~= "string" then
			err = "[err not string]"
		end

		print("* * * B O N U S   E R R O R * * *\n" .. msg .. " / " .. err)

		love.graphics.reset()
		love.graphics.origin()
		love.graphics.clear(0,0,0)
		love.graphics.setColor(255,0,0)
		love.graphics.printf("Ved's crash screen has crashed.\n\n" .. msg .. "\n\n" .. err, 10, 10, love.graphics.getWidth()-20, "left")
		love.graphics.present()
		while true do
			love.event.pump()

			for e, a, b, c in love.event.poll() do
				if e == "quit" then
					return
				end
			end

			if love.timer then
				love.timer.sleep(1/60)
			end
		end
	end
end

function ved_showerror(msg)
	print("* * * E R R O R * * *\n" .. msg)

	msg = tostring(msg)

	local levelsavemsg = ERR_SAVELEVEL
	local alreadysaved = false

	if ctrl == nil then
		ctrl = "ctrl"
	end

	local trace = error_printer(msg, 2)

	-- Decide what's going to be in the message
	local mainmessage = msg:gsub("\n", ".") .. "\n\n" .. "    " .. anythingbutnil(ERR_VEDVERSION) .. " " .. anythingbutnil(checkver) .. (intermediate_version and ERR_INTERMEDIATE or "") .. "\n" .. "    " .. anythingbutnil(ERR_LOVEVERSION) .. " " .. love._version_major .. "." .. love._version_minor .. "." .. love._version_revision .. (love._version_major >= 12 and ERR_TOONEW or "") .. "\n" .. "    " .. anythingbutnil(ERR_STATE) .. " " .. (state == nil and "nil" or state) .. "\n    " .. anythingbutnil(ERR_OS) .. " " .. love.system.getOS() .. "\n    " .. anythingbutnil(ERR_TIMESINCESTART) .. " " .. (love.timer.getTime()-begint) .. "\n    " .. anythingbutnil(ERR_PLUGINS) .. " "

	local hasplugins = false
	if type(plugins) ~= "table" then
		mainmessage = mainmessage .. anythingbutnil(ERR_PLUGINSNOTLOADED)
	else
		local i = false

		for k,v in pairs(plugins) do
			if not i then
				mainmessage = mainmessage .. anythingbutnil(k) .. " (" .. anythingbutnil(v.info.version) .. ")"
			else
				mainmessage = mainmessage .. ", " .. anythingbutnil(k) .. " (" .. anythingbutnil(v.info.version) .. ")"
			end
			i = true
			hasplugins = true
		end

		if not i then
			mainmessage = mainmessage .. anythingbutnil(ERR_PLUGINSNONE)
		end
	end

	-- Save the error to a crash log, if enabled. Do we even know if it's enabled?
	local logwassaved = nil
	if (s == nil or s.autosavecrashlogs) and love.filesystem.exists("crash_logs") then
		-- Make a file with a name of, for example, 1500000000_1.2.3_drawmaineditor_436.txt
		local errorfile, errorline = msg:match("([^ ]+)%.lua:([0-9]+): .*")
		local logfilename = "crash_logs/" .. os.time() .. "_" .. anythingbutnil(checkver) .. (intermediate_version and "-pre" or "") .. "_" .. anythingbutnil(errorfile):gsub("/", "__") .. "_" .. anythingbutnil(errorline) .. ".txt"
		local pluginreport = ""
		if hasplugins then
			pluginreport = pluginreport .. "\n\nPlugin info:"
			for k,v in pairs(plugins) do
				pluginreport = pluginreport .. ("\n\t[" .. k .. "]\n"
					.. "\t| Full name: " .. anythingbutnil(v.info.longname) .. "\n"
					.. "\t| Author: " .. anythingbutnil(v.info.author) .. "\n"
					.. "\t| Version: " .. anythingbutnil(v.info.version) .. "\n"
					.. "\t| Supported: " .. (v.info.supported and "true" or "false") .. "\n"
					.. "\t| Failed edits: " .. anythingbutnil(v.info.failededits) .. "\n"
					.. "\t| Used hooks:"
				)
				local i = false
				for k2,v2 in pairs(v.usedhooks) do
					pluginreport = pluginreport .. "\n\t" .. (k2 == #v.usedhooks and "\\ \\ " or "| | ") .. v2
					i = true
				end
				if not i then
					pluginreport = pluginreport .. "\n\t\\ \\ (none)"
				end
			end

			pluginreport = pluginreport .. "\n\nFiles edited by plugins:"
			for k,v in pairs(pluginfileedits) do
				pluginreport = pluginreport .. "\n\t[" .. k .. "]"
				for k2,v2 in pairs(v) do
					pluginreport = pluginreport .. "\n\t" .. (k2 == #v and "\\ " or "| ") .. v2.plugin
				end
			end
		end
		local contents = (mainmessage:gsub("\n    ", "\n") .. "\n"
			.. "\n"
			.. "Time: " .. os.date("%Y-%m-%d %H:%M:%S") .. " (" .. os.time() .. ")\n"
			.. "Debug mode: " .. (allowdebug and "enabled" or "disabled") .. "\n"
			.. "Crash log reason: " .. (s == nil and "settings are nil" or "enabled normally") .. "\n"
			.. "\n"
			.. trace
			.. pluginreport
			.. "\n\nEOF"
		)
		if love.system.getOS() == "Windows" then
			contents = contents:gsub("\n", "\r\n")
		end
		
		if love.filesystem.exists(logfilename) then
			love.filesystem.append(logfilename, contents)
		else
			love.filesystem.write(logfilename, contents)
		end
		print("Written crash log: " .. logfilename)
		logwassaved = logfilename
	end

	if not love.window or not love.graphics or not love.event then
		return
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		if love.mouse.setRelativeMode ~= nil then
			love.mouse.setRelativeMode(false)
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end
	if love.audio then love.audio.stop() end

	-- I first want to make a screenshot of the current screen.
	local crashscreenshot
	if love.graphics.newImage then
		if love.graphics.newScreenshot then
			crashscreenshot = love.graphics.newImage(love.graphics.newScreenshot())
		--[[ I don't think this works, since love.draw never gets run again...
		elseif love.graphics.captureScreenshot then
			love.graphics.captureScreenshot(
				function(imgdata)
					crashscreenshot = love.graphics.newImage(imgdata)
				end
			)
		]]
		end
	end

	love.graphics.reset()
	--local font = love.graphics.setNewFont(math.floor(love.window.toPixels(14)))

	local font8 = love.graphics.newFont("Space Station.ttf", 8)
	local font16 = love.graphics.newFont("Space Station.ttf", 16)

	--love.graphics.setBackgroundColor(89, 157, 220)
	love.graphics.setBackgroundColor(255, 0, 0)
	love.graphics.setColor(255, 255, 255, 255)

	if love.graphics.clearOR ~= nil then
		love.graphics.clear = love.graphics.clearOR
	end

	--local trace = debug.traceback()
	local trace = ""

	love.graphics.clear(love.graphics.getBackgroundColor())
	love.graphics.origin()

	local err = {}

	if ctrl == nil then
		ctrl = "ctrl"
	end


	table.insert(err, ERR_PLEASETELLDAV)
	--[[
	table.insert(err, "    " .. msg:gsub("\n", ".") .. "\n") --.."\n\n")
	table.insert(err, "    Ved version: a" .. ver)
	table.insert(err, "    LÖVE version: v0." .. (love.graphics.ellipse == nil and 9 or 10))
	table.insert(err, "    State: " .. (state == nil and "nil" or state) .. "\n")
	]]
	table.insert(err, "    " .. mainmessage)

	for l in string.gmatch(trace, "(.-)\n") do
		if not string.match(l, "boot.lua") then
			l = string.gsub(l, "stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = string.gsub(p, "\t", "")
	p = string.gsub(p, "%[string \"(.-)\"%]", "%1")

	-- Was this file edited by a plugin?
	--if p:sub(1, 6) == "--[[##" then maybe have a keyboard shortcut to copy the edited source for debugging purposes.


	local function draw()
		local pos = 40
		love.graphics.clear(love.graphics.getBackgroundColor())
		love.graphics.setColor(255,255,255,64)
		if crashscreenshot ~= nil then
			love.graphics.draw(crashscreenshot, 0, 0) --, 0, s.pscale^-1)
		end

		-- Title
		love.graphics.setFont(font16)
		love.graphics.setColor(0,0,0,255)
		love.graphics.print(ERR_VEDHASCRASHED, pos+4, pos+4)
		love.graphics.setColor(255,255,255,255)
		love.graphics.print(ERR_VEDHASCRASHED, pos, pos)

		-- Draw a box for the important details
		love.graphics.setColor(255,92,92,208) -- 225 is gebruikt
		love.graphics.rectangle("fill", pos-2, pos+40+40-1, love.graphics.getWidth()-(2*pos)+4, 80)

		-- Main text
		love.graphics.setFont(font8)
		love.graphics.setColor(0,0,0,255)
		love.graphics.printf(p, pos+2, pos+40+2, love.graphics.getWidth() - pos + 2)
		love.graphics.setColor(255,255,255,255)
		love.graphics.printf(p, pos, pos+40, love.graphics.getWidth() - pos)

		if metadata ~= nil and roomdata ~= nil and entitydata ~= nil and levelmetadata ~= nil and scripts ~= nil and scriptnames ~= nil and vedmetadata ~= nil then
			-- Show something so you can save your level
			love.graphics.setColor(255,255,0,255)
			love.graphics.printf(anythingbutnil(levelsavemsg), pos, pos+40+(17*8), love.graphics.getWidth() - pos)
			love.graphics.setColor(255,255,255,255)
		--else
			--love.graphics.print("No level or so", pos, love.graphics.getHeight()-40-20, 30, 20)
		end

		if logwassaved ~= nil then
			local text = string.format(ERR_LOGSAVED, love.filesystem.getSaveDirectory() .. "/" .. logwassaved)
			if love.system.getOS() == "Windows" then
				text = text:gsub("/", "\\")
			end
			love.graphics.setColor(0,0,0,255)
			love.graphics.print(text, pos+2, (love.graphics.getHeight()-24)+2)
			love.graphics.setColor(255,255,255,255)
			love.graphics.print(text, pos, love.graphics.getHeight()-24)
		end

		--path, thismetadata, theserooms, allentities, theselevelmetadata, allscripts, vedmetadata
		--success, metadata, roomdata, entitydata, levelmetadata, scripts, count, scriptnames, vedmetadata		
		--love.graphics.print("success: " .. (success == nil and "nil" or "not nil") .. "\nmetadata: " .. (metadata == nil and "nil" or "not nil") .. "\nroomdata: " .. (roomdata == nil and "nil" or "not nil") .. "\nentitydata: " .. (entitydata == nil and "nil" or "not nil") .. "\nlevelmetadata: " .. (levelmetadata == nil and "nil" or "not nil") .. "\nscripts: " .. (scripts == nil and "nil" or "not nil") .. "\ncount: " .. (count == nil and "nil" or "not nil") .. "\nscriptnames: " .. (scriptnames == nil and "nil" or "not nil") .. "\n")

		--dialog.draw()
		--love.graphics.setColor(255,255,255,255)

		love.graphics.present()
	end
	local function update()
		--dialog.update()
	end

	while true do
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return
			elseif e == "keypressed" and (a == "escape") then
				return
			elseif e == "keypressed" and a == "c" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
				love.system.setClipboardText(mainmessage:gsub("\n    ", "\n"))
			elseif e == "keypressed" and a == "s" and not alreadysaved
			and metadata ~= nil and roomdata ~= nil and entitydata ~= nil and levelmetadata ~= nil and scripts ~= nil and scriptnames ~= nil and vedmetadata ~= nil then
				if editingmap == "untitled\n" or editingmap == nil then
					editingmap = "untitled"
				end

				editingmap = editingmap .. "_" .. os.time()

				savedsuccess, savederror = savelevel(editingmap .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata, true)

				if not savedsuccess then
					levelsavemsg = string.format(ERR_SAVEERROR, anythingbutnil(savederror))
				else
					levelsavemsg = string.format(ERR_SAVESUCC, editingmap .. ".vvvvvv")
					alreadysaved = true
				end
			elseif e == "keypressed" and a == "r" and alreadysaved then
				alreadysaved = false
			elseif e == "keypressed" and a == "pageup" then
				if love.keyboard.isDown("r" .. ctrl) then
					debug.debug()
				end
			elseif e == "touchpressed" then
				local name = love.window.getTitle()
				if #name == 0 or name == "Untitled" then name = "Game" end
				local buttons = {"OK", "Cancel"}
				local pressed = love.window.showMessageBox("Quit "..name.."?", "", buttons)
				if pressed == 1 then
					return
				end
			end
		end

		--update()
		draw()

		if love.timer then
			love.timer.sleep(1/60)
		end
	end
end

function pluginerror(fileerror, currentplugin, fileeditors, findthis, aspattern)
	print("* * * P L U G I N   E R R O R * * *\n")

	--msg = tostring(msg)

	-- I first want to make a screenshot of the current screen.
	local crashscreenshot
	if love.graphics.newImage and love.graphics.newScreenshot then
		crashscreenshot = love.graphics.newImage(love.graphics.newScreenshot())
	end

	love.graphics.reset()
	--local font = love.graphics.setNewFont(math.floor(love.window.toPixels(14)))

	-- We may need that line again
	if love.graphics.setDefaultFilter ~= nil then
		love.graphics.setDefaultFilter("nearest", "nearest")
	end

	local font8 = love.graphics.newFont("Space Station.ttf", 8)
	local font16 = love.graphics.newFont("Space Station.ttf", 16)

	--love.graphics.setBackgroundColor(89, 157, 220)
	love.graphics.setBackgroundColor(255, 128, 0)
	love.graphics.setColor(255, 255, 255, 255)

	--local trace = debug.traceback()
	local trace = ""

	love.graphics.clear(love.graphics.getBackgroundColor())
	love.graphics.origin()

	local err = {}

	if ctrl == nil then
		ctrl = "ctrl"
	end


	local mainmessage = anythingbutnil(ERR_VEDVERSION) .. " " .. anythingbutnil(checkver) .. (intermediate_version and ERR_INTERMEDIATE or "") .. "\n" .. "    " .. anythingbutnil(ERR_FILE) .. " " .. anythingbutnil(fileerror) .. "\n" .. "    " .. anythingbutnil(ERR_CURRENTPLUGIN) .. " " .. anythingbutnil(currentplugin) .. "\n    " .. anythingbutnil(ERR_FILEEDITORS) .. " " .. anythingbutnil(fileeditors) .. "\n    " .. anythingbutnil(ERR_PLUGINS) .. " "

	if type(plugins) ~= "table" then
		mainmessage = mainmessage .. anythingbutnil(ERR_PLUGINSNOTLOADED)
	else
		local i = false

		for k,v in pairs(plugins) do
			if not i then
				mainmessage = mainmessage .. anythingbutnil(k) .. " (" .. anythingbutnil(v.info.version) .. ")"
			else
				mainmessage = mainmessage .. ", " .. anythingbutnil(k) .. " (" .. anythingbutnil(v.info.version) .. ")"
			end
			i = true
		end

		if not i then
			mainmessage = mainmessage .. anythingbutnil(ERR_PLUGINSNONE)
		end
	end

	table.insert(err, ERR_PLEASETELLAUTHOR)
	--[[
	table.insert(err, "    " .. msg:gsub("\n", ".") .. "\n") --.."\n\n")
	table.insert(err, "    Ved version: a" .. ver)
	table.insert(err, "    LÖVE version: v0." .. (love.graphics.ellipse == nil and 9 or 10))
	table.insert(err, "    State: " .. (state == nil and "nil" or state) .. "\n")
	]]
	table.insert(err, "    " .. mainmessage)
	table.insert(err, "\n\n" .. string.format(aspattern and ERR_REPLACECODEPATTERN or ERR_REPLACECODE, anythingbutnil(fileerror)) .. "\n\n")

	-- We also want to include at least part of the code that wasn't found.
	local _, numberlines = string.gsub(anythingbutnil(findthis) .. "\n", "\n", "")

	linesdone = 0
	limitedlines = ""
	for line in string.gmatch(anythingbutnil(findthis) .. "\n", "[^\n]*\n") do --"[^\n]+\n"
		line = line:gsub("\t", "  ")

		if line:len() > 86 then
			limitedlines = limitedlines .. line:sub(1, 81) .. "[...]\n"
		else
			limitedlines = limitedlines .. line
		end
		linesdone = linesdone + 1
		if linesdone >= 5 then
			if numberlines > 5 then
				limitedlines = limitedlines .. "... (" .. string.format(ERR_LINESTOTAL, numberlines) .. ")"
			end
			break
		end
	end

	-- Were there less lines?
	for linesleft = 1, 5-numberlines do
		limitedlines = limitedlines .. "\n"
	end

	table.insert(err, limitedlines .. "\n")

	table.insert(err, "\n\n\n" .. ERR_CONTINUE)

	for l in string.gmatch(trace, "(.-)\n") do
		if not string.match(l, "boot.lua") then
			l = string.gsub(l, "stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = string.gsub(p, "\t", "")
	p = string.gsub(p, "%[string \"(.-)\"%]", "%1")


	local function draw()
		local pos = 40
		love.graphics.clear(love.graphics.getBackgroundColor())
		love.graphics.setColor(255,255,255,64)
		if crashscreenshot ~= nil then
			love.graphics.draw(crashscreenshot, 0, 0) --, 0, s.pscale^-1)
		end

		-- Title
		love.graphics.setFont(font16)
		love.graphics.setColor(0,0,0,255)
		--love.graphics.print(ERR_PLUGINERROR, pos+4, pos+4)
		love.graphics.setColor(255,255,255,255)
		love.graphics.print(ERR_PLUGINERROR, pos, pos)

		-- Draw boxes for the important details
		love.graphics.setColor(255,174,92,208) -- 225 is gebruikt
		love.graphics.rectangle("fill", pos-2, pos+40+48-1, love.graphics.getWidth()-(2*pos)+4, 56)
		love.graphics.setColor(255,174,92,208) -- 225 is gebruikt
		love.graphics.rectangle("fill", pos-2, pos+40+47+80, love.graphics.getWidth()-(2*pos)+4, 56+8)

		-- Main text
		love.graphics.setFont(font8)
		love.graphics.setColor(0,0,0,255)
		--love.graphics.printf(p, pos+2, pos+40+2, love.graphics.getWidth() - pos + 2)
		love.graphics.setColor(255,255,255,255)
		love.graphics.printf(p, pos, pos+40, love.graphics.getWidth() - pos)

		--dialog.draw()
		love.graphics.setColor(255,255,255,255)

		love.graphics.present()
	end
	local function update()
		--dialog.update()
	end

	while true do
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				love.event.quit()
				return
			elseif e == "keypressed" and (a == "escape" or a == "return") then
				love.graphics.setBackgroundColor(0,0,0)
				love.graphics.clear()

				return
			elseif e == "keypressed" and a == "c" and (love.keyboard.isDown("l" .. ctrl) or love.keyboard.isDown("r" .. ctrl)) then
				love.system.setClipboardText(mainmessage:gsub("\n    ", "\n"))
			end
		end

		--update()
		draw()

		if love.timer then
			love.timer.sleep(1/60)
		end
	end
end
