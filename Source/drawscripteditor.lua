function drawscripteditor()
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(L.SCRIPTEDITOR .. " - " .. scriptname, 8, 8)
	--love.graphics.print(L.FILE .. "   " .. L.EDIT .. "   " .. L.INSERT .. "   " .. L.HELP, 8, 24)
	-- Script display starts at 8, 48 --- now 24 instead of 48
	--for k,v in pairs(scriptlines) do

	-- This can roll over, prevent that!
	textlinestogo = 0

	-- Display a line for the maximum line size that will fit in VVVVVV!
	if textsize then
		love.graphics.line(42*16-9, 24, 42*16-9, love.graphics.getHeight())
	else
		love.graphics.line(42*8, 24, 42*8, love.graphics.getHeight())
	end

	-- The comment below is a bad way of doing it.
	love.graphics.setScissor(0, 24, love.graphics.getWidth(), love.graphics.getHeight()-24)

	-- Are we displaying with large text?
	if textsize then
		love.graphics.setFont(font16)
	end

	-- -- Make sure to display all lines but if we put the cursor further, then do display line numbers
	-- I could make it #scriptlines now
	for k = 1, math.max(table.maxn(scriptlines), editingline) do
		v = anythingbutnil(scriptlines[k])

		-- Save the whales, only display this line if we can see it!
		if (scriptscroll+24+((textsize and 16 or 8)*k) >= 16) and (scriptscroll+24+((textsize and 16 or 8)*k) <= love.graphics.getHeight()) then
			if k >= 500 and editingline == k then
				love.graphics.setColor(255,128,128,255) -- 255 64 64?
			elseif editingline == k then
				love.graphics.setColor(255,255,255,255)
			elseif k >= 500 then
				love.graphics.setColor(255,0,0,255)
			else
				love.graphics.setColor(128,128,128,255)
			end

			if textsize then
				love.graphics.print(fixdig(k, 3), 8, scriptscroll+24+(16*k)-8)
				textq = syntaxhl(v, 48+40, scriptscroll+24+(16*k)-8, textlinestogo > 0, editingline == k, syntaxhlon)
			else
				love.graphics.print(fixdig(k, 3), 8, scriptscroll+24+(8*k))
				textq = syntaxhl(v, 48, scriptscroll+24+(8*k), textlinestogo > 0, editingline == k, syntaxhlon)
			end
		elseif (scriptscroll+24+(8*k) < 16) then
			-- Ok, we could still impact performance if we have TOO MANY say/reply/text commands laying around above this point
			textq = justtext(v, textlinestogo > 0)
		end

		if editingline == k then --and textlinestogo == 0 then
			context, carg1, carg2 = scriptcontext(v)
		end

		if textq ~= nil then
			textlinestogo = textq
		elseif textlinestogo > 0 then
			textlinestogo = textlinestogo - 1
		end
	end

	-- Put an end to the madness
	if textsize then
		love.graphics.setFont(font8)
	end

	love.graphics.setScissor()

	love.graphics.setColor(255,255,255,255)

	-- Now let's put a scrollbar in sight! -- -144: -(128-8)-24, -32: -24-8
	local newperonetage = scrollbar(love.graphics.getWidth()-144, 24, love.graphics.getHeight()-32, (#scriptlines*8+8)*(textsize and 2 or 1), ((-scriptscroll))/(((#scriptlines*8)*(textsize and 2 or 1))-(love.graphics.getHeight()-32)))

	if newperonetage ~= nil then
		scriptscroll = -(newperonetage*(((#scriptlines*8)*(textsize and 2 or 1))-(love.graphics.getHeight()-32)))
	end

	-- Now put some buttons on the right!
	hoverdraw(helpbtn, love.graphics.getWidth()-24, 8, 16, 16, 1)
	love.graphics.printf(L.FILE, love.graphics.getWidth()-(128-8), 8+(24*0)+4+2, 128-16, "center")
	if not PleaseDo3DSHandlingThanks then
		rbutton(L.NEW, 1)
		rbutton(L.SCRIPTUSAGES, 2)
	else
		rbutton(L.OPEN, 2)
	end
	love.graphics.printf(L.EDITTAB, love.graphics.getWidth()-(128-8), 8+(24*3)+4+2, 128-16, "center")
	rbutton(L.COPYSCRIPT, 4, nil, nil, nil, generictimer_mode == 1 and generictimer > 0)
	if not PleaseDo3DSHandlingThanks then
		rbutton(L.SCRIPTSPLIT, 5)
	end
	rbutton({L.SEARCHSCRIPT, "cF"}, 6)
	rbutton({L.GOTOLINE, "cG"}, 7)
	rbutton({internalscript and L.INTERNALOFF or L.INTERNALON, "cI"}, 8, nil, nil, nil, internalscript)
	--hoverrectangle(internalscript and 160 or 128, internalscript and 160 or 128, internalscript and 0 or 128,128, love.graphics.getWidth()-(128-8), 8+(24*8), 128-16, 16)
	--love.graphics.printf((internalscript and L.INTERNALOFF or L.INTERNALON), love.graphics.getWidth()-(128-8), 8+(24*8)+4+2, 128-16, "center")
	--hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8), 8+(24*8), 128-16, 16)
	love.graphics.printf(L.VIEW, love.graphics.getWidth()-(128-8), 8+(24*9)+4+2, 128-16, "center")
	rbutton(syntaxhlon and L.SYNTAXHLOFF or L.SYNTAXHLON, 10)
	rbutton(textsize and L.TEXTSIZEL or L.TEXTSIZEN, 11)

	-- Internal scripting load script warning
	if internalscript then
		if intscrwarncache_script ~= scriptname then -- is nil if not checked yet
			checkintscrloadscript(scriptname)
		elseif intscrwarncache_warn_noloadscript or intscrwarncache_warn_boxed then
			love.graphics.setColor(255,128,0)
			local warnmessage = ""
			if intscrwarncache_warn_boxed then
				warnmessage = warnmessage .. L.INTSCRWARNING_BOXED
			end
			if intscrwarncache_warn_noloadscript then
				warnmessage = warnmessage .. L.INTSCRWARNING_NOLOADSCRIPT
			end
			love.graphics.printf(warnmessage, love.graphics.getWidth()-(128-8), ((love.graphics.getHeight()-(24*2))+4+2)-24-40, 128-16, "left")
			love.graphics.setColor(255,255,255)
		end
	end

	-- Column
	love.graphics.printf(L.COLUMN .. (input:len()+1), love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-(24*2))+4+2, 128-16, "left")

	if not PleaseDo3DSHandlingThanks then
		rbutton({L.RETURN, "b"}, 0, nil, true)
	else
		rbutton("Copy with $s", 0, nil, true) -- not translating I suppose
	end

	-- First make these buttons do things
	if nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-24, 8, 16, 16) then
			-- Help
			tostate(15)
		elseif not PleaseDo3DSHandlingThanks and onrbutton(1) then
			-- New
			stopinput()
			scriptlines[editingline] = input
			dialog.create(
				L.NEWSCRIPTNAME, DBS.OKCANCEL,
				dialog.callback.newscript, L.CREATENEWSCRIPT, dialog.form.simplename,
				dialog.callback.newscript_validate, "newscript_editor"
			)
		elseif PleaseDo3DSHandlingThanks and onrbutton(2) then
			-- Open ($script)
			tostate(22)
		elseif not PleaseDo3DSHandlingThanks and onrbutton(2) then
			-- Usages
			local uentityuses, uscriptuses = findscriptreferences(scriptname)

			local roomsstr, scriptsstr = "", ""
			local co = not s.coords0 and 1 or 0 -- coordoffset

			for k,v in pairs(uentityuses) do
				roomsstr = roomsstr .. (roomsstr == "" and "" or ", ") .. "(" .. (math.floor(entitydata[v].x/40)+co) .. "," .. (math.floor(entitydata[v].y/30)+co) .. ")"
			end

			for k,v in pairs(uscriptuses) do
				scriptsstr = scriptsstr .. (scriptsstr == "" and "" or ", ") .. v[1] .. ":" .. v[2]
			end

			dialog.create(langkeys(L_PLU.SCRIPTUSAGESROOMS, {#uentityuses, roomsstr}) .. "\n\n" .. langkeys(L_PLU.SCRIPTUSAGESSCRIPTS, {#uscriptuses, scriptsstr}))
		elseif onrbutton(4) then
			-- Copy script
			love.system.setClipboardText(table.concat(scriptlines, (love.system.getOS() == "Windows" and "\r\n" or "\n")))
			setgenerictimer(1, .25)
		elseif not PleaseDo3DSHandlingThanks and onrbutton(5) then
			-- Split scripts
			stopinput()
			scriptlines[editingline] = input
			dialog.create(
				L.NEWSCRIPTNAME, DBS.OKCANCEL,
				dialog.callback.newscript, L.SPLITSCRIPT, dialog.form.simplename,
				dialog.callback.newscript_validate, "split_editor"
			)
		elseif onrbutton(6) then
			-- Search
			startinscriptsearch()
		elseif onrbutton(7) then
			-- Go to line
			startscriptgotoline()
		elseif not mousepressed and onrbutton(8) then
			-- Internal scripting
			internalscript = not internalscript
			dirty()

			mousepressed = true
		elseif not mousepressed and onrbutton(10) then
			-- Syntax HL
			syntaxhlon = not syntaxhlon

			mousepressed = true
		elseif not mousepressed and onrbutton(11) then
			-- Text size
			textsize = not textsize

			if textsize then
				scriptscroll = scriptscroll*2
			else
				scriptscroll = scriptscroll/2
			end

			mousepressed = true
		elseif not mousepressed and not PleaseDo3DSHandlingThanks and onrbutton(0, nil, true) then
			-- Return
			leavescript_to_state = function()
				stopinput()
				scriptlines[editingline] = input
				scripts[scriptname] = table.copy(scriptlines)
				tostate(10)
			end

			if not processflaglabelsreverse() then
				leavescript_to_state()
			end

			mousepressed = true
		elseif PleaseDo3DSHandlingThanks and onrbutton(0, nil, true) then
			-- Copy script with dollars
			love.system.setClipboardText(table.concat(scriptlines, "$"))
		end
	end

	if context == "script" then
		love.graphics.printf(carg1, love.graphics.getWidth()-(128-8), 8+(24*12)+4+2, 128-16, "center")
		rbutton((scripts[carg1] == nil and L.CREATE or L.GOTO), 13)

		if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
			editorjumpscript(carg1)
			mousepressed = true
		end
	elseif context == "flagscript" then
		if carg2 ~= nil and carg2 ~= "" then
			love.graphics.printf(carg2, love.graphics.getWidth()-(128-8), 8+(24*12)+4+2, 128-16, "center")
			rbutton((scripts[carg2] == nil and L.CREATE or L.GOTO), 13)

			if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
				editorjumpscript(carg2)
				mousepressed = true
			end
		end
	end
end
