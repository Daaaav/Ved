function drawscripteditor()
	love.graphics.setColor(255,255,255,255)
	ved_print(L.SCRIPTEDITOR .. " - " .. scriptname, 8, 8)

	-- This can roll over, prevent that!
	local textlinestogo = 0

	-- Display a line for the maximum line size that will fit in VVVVVV!
	if s.scripteditor_largefont then
		love.graphics.line(43*16-9, 24, 43*16-9, love.graphics.getHeight())
	else
		love.graphics.line(43*8, 24, 43*8, love.graphics.getHeight())
	end

	-- The comment below is a bad way of doing it.
	love.graphics.setScissor(0, 24, love.graphics.getWidth(), love.graphics.getHeight()-24)

	local textq, textc, alttextcolor, lasttextcolor

	-- -- Make sure to display all lines but if we put the cursor further, then do display line numbers
	-- I could make it #scriptlines now
	for k = 1, math.max(table.maxn(scriptlines), editingline) do
		v = anythingbutnil(scriptlines[k])
		local text_r
		if k == editingline then
			v = v .. anythingbutnil(input_r)
			text_r = input_r
		end

		local text2 = string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", "")
		local partss = explode(",", text2)
		if partss[1] == "text" and textlinestogo == 0 then
			textlinestogo = math.max(anythingbutnil0(tonumber(partss[5])), 0)

			if textlinestogo > 0 then
				-- Search forward for a createcrewman unless we hit a speak(_active) first
				local i = k + textlinestogo + 1
				local l
				while scriptlines[i] ~= nil do
					if i == editingline then
						l = (input .. input_r):gsub(" ", "")
					else
						l = (scriptlines[i]):gsub(" ", "")
					end
					if (l:len() > 13 and l:match("^createcrewman[%(,%)]")) or l == "createcrewman" then
						alttextcolor = true
						break
					elseif ((l:len() > 5 and l:match("^speak[%(,%)]")) or l == "speak") or ((l:len() > 12 and l:match("^speak_active[%(,%)]")) or l == "speak_active") or ((l:len() > 4 and l:match("^text[%(,%)]")) or l == "text") then
						alttextcolor = false
						break
					end

					i = i + 1
				end
				textlinestogo = 0
			end
		end

		-- Save the whales, only display this line if we can see it!
		local fontsize = s.scripteditor_largefont and 16 or 8
		if (scriptscroll+24+(fontsize*k) >= 16) and (scriptscroll+24+(fontsize*k) <= love.graphics.getHeight()) then
			if k >= limit.scriptlines and editingline == k then
				love.graphics.setColor(255,128,128,255) -- 255 64 64?
			elseif editingline == k then
				love.graphics.setColor(255,255,255,255)
			elseif k >= limit.scriptlines then
				love.graphics.setColor(255,0,0,255)
			else
				love.graphics.setColor(128,128,128,255)
			end

			if s.scripteditor_largefont then
				ved_print(fixdig(k, 4, " "), 8, scriptscroll+24+(16*k)-8, 2)
				textq, textc = syntaxhl(v, 104, scriptscroll+24+(16*k)-8, textlinestogo > 0, editingline == k, syntaxhlon, lasttextcolor, text_r, alttextcolor)
			else
				ved_print(fixdig(k, 4, " "), 8, scriptscroll+24+(8*k))
				textq, textc = syntaxhl(v, 56, scriptscroll+24+(8*k), textlinestogo > 0, editingline == k, syntaxhlon, lasttextcolor, text_r, alttextcolor)
			end
		elseif (scriptscroll+24+(8*k) < 16) then
			-- Ok, we could still impact performance if we have TOO MANY say/reply/text commands laying around above this point
			textq, textc = justtext(v, textlinestogo > 0)
		end

		if editingline == k then --and textlinestogo == 0 then
			context, carg1, carg2, carg3 = scriptcontext(input .. input_r)
		end

		if textq ~= nil then
			textlinestogo = textq
			lasttextcolor = textc

			-- Dialog bar

			-- Let's figure out where the dialog ends horizontally
			local maxwidthtextbox = 0
			local l
			for i = k+1, k+textlinestogo do
				if i == editingline then
					l = input .. input_r
				else
					l = scriptlines[i]
				end

				if l == nil then
					break
				end

				if utf8.len(l) > maxwidthtextbox then
					maxwidthtextbox = utf8.len(l)
				end
			end

			if k < table.maxn(scriptlines) and syntaxhlon then
				if alttextcolor then
					if alttextboxcolors[textc] == nil then
						textc = "gray"
					end
				elseif textboxcolors[textc] == nil then
					textc = "gray"
				end
				love.graphics.setColor(alttextcolor and alttextboxcolors[textc] or textboxcolors[textc])
				if s.scripteditor_largefont then
					love.graphics.rectangle("fill", 92, scriptscroll+24+(16*k)+8, 6, textq*16)
					love.graphics.rectangle("fill", 92+16*(maxwidthtextbox+1), scriptscroll+24+(16*k)+8, 6, textq*16)
				else
					love.graphics.rectangle("fill", 50, scriptscroll+24+(8*k)+8, 3, textq*8)
					love.graphics.rectangle("fill", 50+8*(maxwidthtextbox+1), scriptscroll+24+(8*k)+8, 3, textq*8)
				end
			end
		elseif textlinestogo > 0 then
			textlinestogo = textlinestogo - 1
		else
			alttextcolor = false
		end
	end

	love.graphics.setScissor()

	-- Any warnings?
	if internalscript and intscrwarncache_script ~= scriptname then -- is nil if not checked yet
		checkintscrloadscript(scriptname)
	end
	draw_script_warn_light("loadscript_required", love.graphics.getWidth()-168, 4, internalscript and intscrwarncache_warn_noloadscript)
	draw_script_warn_light("direct_reference", love.graphics.getWidth()-168-28, 4, internalscript and intscrwarncache_warn_boxed)
	--draw_script_warn_light("name", love.graphics.getWidth()-168-(28*2), 4, false)

	love.graphics.setColor(255,255,255,255)

	-- Now let's put a scrollbar in sight! -- -144: -(128-8)-24, -32: -24-8
	local textscale = s.scripteditor_largefont and 2 or 1
	local newfraction = scrollbar(love.graphics.getWidth()-144, 24, love.graphics.getHeight()-32, (#scriptlines*8+8)*textscale, ((-scriptscroll))/(((#scriptlines*8)*textscale)-(love.graphics.getHeight()-32)))

	if newfraction ~= nil then
		scriptscroll = -(newfraction*(((#scriptlines*8)*textscale)-(love.graphics.getHeight()-32)))
	end

	-- Now put some buttons on the right!
	hoverdraw(helpbtn, love.graphics.getWidth()-24, 8, 16, 16, 1)
	showhotkey("q", love.graphics.getWidth()-24+8-2, 8-2)
	ved_printf(L.FILE, love.graphics.getWidth()-(128-8), 8+(24*0)+4, 128-16, "center")
	--rbutton(L.NEW, 1)
	rbutton(L.SCRIPTUSAGES, 1)
	ved_printf(L.EDITTAB, love.graphics.getWidth()-(128-8), 8+(24*2)+4, 128-16, "center")
	rbutton({L.COPYSCRIPT, "cA"}, 3, nil, nil, nil, generictimer_mode == 1 and generictimer > 0)
	rbutton(L.SCRIPTSPLIT, 4)
	rbutton({L.SEARCHSCRIPT, "cF"}, 5)
	rbutton({L.GOTOLINE, "cG"}, 6)
	rbutton({(internalscript or cutscenebarsinternalscript) and L.INTERNALON or L.INTERNALOFF, "cI"}, 7, nil, nil, nil, internalscript or cutscenebarsinternalscript)
	if internalscript or cutscenebarsinternalscript then
		rbutton({internalscript and L.INTERNALNOBARS or cutscenebarsinternalscript and L.INTERNALYESBARS or L.INTERNALOFF, "cI"}, 8, nil, nil, nil, cutscenebarsinternalscript)
	end
	ved_printf(L.VIEW, love.graphics.getWidth()-(128-8), 8+(24*9)+4, 128-16, "center")
	rbutton(syntaxhlon and L.SYNTAXHLOFF or L.SYNTAXHLON, 10)
	rbutton(s.scripteditor_largefont and L.TEXTSIZEL or L.TEXTSIZEN, 11)

	-- Column
	ved_printf(L.COLUMN .. (input:len()+1), love.graphics.getWidth()-(128-8), (love.graphics.getHeight()-(24*2))+4, 128-16, "left")

	rbutton({L.RETURN, "b"}, 0, nil, true)

	-- First make these buttons do things
	if nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-24, 8, 16, 16) then
			-- Help
			tostate(15)
		--[[
		elseif onrbutton(1) then
			-- New
			stopinput()
			scriptlines[editingline] = input
			dialog.create(
				L.NEWSCRIPTNAME, DBS.OKCANCEL,
				dialog.callback.newscript, L.CREATENEWSCRIPT, dialog.form.simplename,
				dialog.callback.newscript_validate, "newscript_editor"
			)
		]]
		elseif onrbutton(1) then
			-- Usages
			local uentityuses, uloadscriptuses, uscriptuses = findscriptreferences(scriptname)

			local roomsstr, scriptsstr = "", ""
			local co = not s.coords0 and 1 or 0 -- coordoffset

			for k,v in pairs(uentityuses) do
				roomsstr = roomsstr .. (roomsstr == "" and "" or ", ") .. "(" .. (math.floor(entitydata[v].x/40)+co) .. "," .. (math.floor(entitydata[v].y/30)+co) .. ")"
			end

			for k,v in pairs(uscriptuses) do
				scriptsstr = scriptsstr .. (scriptsstr == "" and "" or ", ") .. v[1] .. ":" .. v[2]
			end

			dialog.create(langkeys(L_PLU.SCRIPTUSAGESROOMS, {#uentityuses, roomsstr}) .. "\n\n" .. langkeys(L_PLU.SCRIPTUSAGESSCRIPTS, {#uscriptuses, scriptsstr}))
		elseif onrbutton(3) then
			-- Copy script
			copyscript()
		elseif onrbutton(4) then
			-- Split scripts
			stopinput()
			scriptlines[editingline] = input
			dialog.create(
				L.NEWSCRIPTNAME, DBS.OKCANCEL,
				dialog.callback.newscript, L.SPLITSCRIPT, dialog.form.simplename,
				dialog.callback.newscript_validate, "split_editor"
			)
		elseif onrbutton(5) then
			-- Search
			startinscriptsearch()
		elseif onrbutton(6) then
			-- Go to line
			startscriptgotoline()
		elseif not mousepressed and onrbutton(7) then
			-- Internal scripting on/off
			if internalscript or cutscenebarsinternalscript then
				internalscript = false
				cutscenebarsinternalscript = false
			else
				internalscript = true
			end
			dirty()

			mousepressed = true
		elseif (internalscript or cutscenebarsinternalscript) and not mousepressed and onrbutton(8) then
			-- Internal scripting method
			if internalscript then
				internalscript = false
				cutscenebarsinternalscript = true
			else
				internalscript = true
				cutscenebarsinternalscript = false
			end
			dirty()

			mousepressed = true
		elseif not mousepressed and onrbutton(10) then
			-- Syntax HL
			syntaxhlon = not syntaxhlon

			mousepressed = true
		elseif not mousepressed and onrbutton(11) then
			-- Text size
			s.scripteditor_largefont = not s.scripteditor_largefont
			saveconfig()

			if s.scripteditor_largefont then
				scriptscroll = scriptscroll*2
			else
				scriptscroll = scriptscroll/2
			end

			mousepressed = true
		elseif not mousepressed and onrbutton(0, nil, true) then
			-- Return
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
			end

			if not processflaglabelsreverse() then
				leavescript_to_state()
			end

			mousepressed = true
		end
	end

	if context == "script" then
		ved_printf(carg1, love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
		if not scriptinstack(carg1) then
			rbutton({(scripts[carg1] == nil and L.CREATE or L.GOTO), "ax"}, 13)

			if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
				editorjumpscript(carg1)
				mousepressed = true
			end
		end
	elseif context == "flagscript" then
		if carg2 ~= nil and carg2 ~= "" then
			ved_printf(carg2, love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
			if not scriptinstack(carg2) then
				rbutton({(scripts[carg2] == nil and L.CREATE or L.GOTO), "ax"}, 13)

				if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
					editorjumpscript(carg2)
					mousepressed = true
				end
			end
		end
	elseif context == "roomscript" then
		if carg3 ~= nil and carg3 ~= "" then
			ved_printf(carg3, love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
			if not scriptinstack(carg3) then
				rbutton({(scripts[carg3] == nil and L.CREATE or L.GOTO), "ax"}, 13)

				if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
					editorjumpscript(carg3)
					mousepressed = true
				end
			end
		end
	elseif context == "room" then
		carg1, carg2 = tonumber(carg1), tonumber(carg2)
		if carg1 ~= nil and carg2 ~= nil then
			local map_x, map_y = love.graphics.getWidth()-(128-8)+16, 8+(24*12)+4
			love.graphics.setColor(128,128,128)
			love.graphics.rectangle("line", map_x-.5, map_y-.5, 81, 61)
			love.graphics.setColor(255,255,255)
			if carg1 >= 0 and carg1 < metadata.mapwidth
			and carg2 >= 0 and carg2 < metadata.mapheight
			and rooms_map[carg2][carg1].map ~= nil then
				love.graphics.draw(rooms_map[carg2][carg1].map, map_x, map_y, 0, 0.25)

				if mouseon(map_x, map_y, 80, 60) then
					love.graphics.setColor(128,128,128)
					love.graphics.rectangle("line", love.mouse.getX()-380.5, love.mouse.getY()-120.5, 321, 241)
					love.graphics.setColor(0,0,0)
					love.graphics.rectangle("fill", love.mouse.getX()-380, love.mouse.getY()-120, 320, 240)
					love.graphics.setColor(255,255,255)
					love.graphics.draw(rooms_map[carg2][carg1].map, love.mouse.getX()-380, love.mouse.getY()-120)
				end
			else
				love.graphics.draw(covered_80x60, map_x, map_y)
			end

			local disp_carg1, disp_carg2
			if s.coords0 then
				disp_carg1 = carg1
				disp_carg2 = carg2
			else
				disp_carg1 = carg1+1
				disp_carg2 = carg2+1
			end
			ved_printf(disp_carg1 .. "," .. disp_carg2, map_x, map_y+62, 80, "center")
		end
	elseif context == "frames" then
		carg1 = tonumber(carg1)
		if carg1 ~= nil then
			local seconds = carg1 * 34 / 1000
			seconds = round(seconds, 2)
			ved_printf(langkeys(L.FRAMESTOSECONDS, {carg1, seconds}), love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
		end
	elseif context == "roomnum" then
		carg1 = tonumber(carg1)
		if carg1 ~= nil then
			ved_printf(langkeys(L.ROOMNUM, {carg1}), love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
		end
	elseif context == "track" then
		carg1 = tonumber(carg1)
		if carg1 ~= nil then
			if carg1 == -1 then
				ved_printf(L.STOPSMUSIC, love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
			else
				ved_printf(langkeys(L.TRACKNUM, {carg1}) .. "\n\n" .. listmusiccommandsids[carg1], love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
			end
		end
	end
end
