-- scripteditor/draw

return function()
	love.graphics.setColor(255,255,255,255)
	ved_print(L.SCRIPTEDITOR .. " - " .. scriptname, 28, 8)

	-- This can roll over, prevent that!
	local textlinestogo = 0

	-- Display a line for the maximum line size that will fit in VVVVVV!
	if s.scripteditor_largefont then
		love.graphics.line(43*16-9, 24, 43*16-9, love.graphics.getHeight())
	else
		love.graphics.line(43*8, 24, 43*8, love.graphics.getHeight())
	end

	love.graphics.setScissor(0, 24, love.graphics.getWidth()-128-16, love.graphics.getHeight()-24)

	local textq, textc, alttextcolor, lasttextcolor
	local _, editing_line = newinputsys.getpos("script_lines")

	for k = 1, table.maxn(inputs.script_lines) do
		v = anythingbutnil(inputs.script_lines[k])

		local text2 = v:gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
		local partss = explode(",", text2)
		if partss[1] == "text" and textlinestogo == 0 then
			textlinestogo = math.max(anythingbutnil0(tonumber(partss[5])), 0)

			if textlinestogo > 0 then
				-- Search forward for a createcrewman unless we hit a speak(_active) first
				local i = k + textlinestogo + 1
				local l
				while inputs.script_lines[i] ~= nil do
					l = (inputs.script_lines[i]):gsub(" ", "")
					if (l:len() > 13 and l:match("^createcrewman[%(,%)]")) or l == "createcrewman" then
						alttextcolor = true
						break
					elseif ((l:len() > 5 and l:match("^speak[%(,%)]")) or l == "speak")
					or ((l:len() > 12 and l:match("^speak_active[%(,%)]")) or l == "speak_active")
					or ((l:len() > 4 and l:match("^text[%(,%)]")) or l == "text") then
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
			if editing_line == k then
				love.graphics.setColor(255,255,255,255)
			else
				love.graphics.setColor(128,128,128,255)
			end

			if s.scripteditor_largefont then
				ved_print(fixdig(k, 4, " "), 8, scriptscroll+24+(16*k)-8, 2)
				textq, textc = syntax_hl(
					v,
					104,
					scriptscroll+24+(16*k)-8,
					textlinestogo > 0,
					editing_line == k,
					syntaxhlon,
					lasttextcolor,
					alttextcolor
				)
			else
				ved_print(fixdig(k, 4, " "), 8, scriptscroll+24+(8*k))
				textq, textc = syntax_hl(
					v,
					56,
					scriptscroll+24+(8*k),
					textlinestogo > 0,
					editing_line == k,
					syntaxhlon,
					lasttextcolor,
					alttextcolor
				)
			end
		elseif (scriptscroll+24+(8*k) < 16) then
			-- Ok, we could still impact performance if we have TOO MANY say/reply/text commands laying around above this point
			textq, textc = just_text(v, textlinestogo > 0)
		end

		if editing_line == k then
			context, carg1, carg2, carg3 = script_context(inputs.script_lines[k], textlinestogo)
		end

		if textq ~= nil then
			textlinestogo = textq
			lasttextcolor = textc

			-- Dialog bar

			-- Let's figure out where the dialog ends horizontally
			local maxwidthtextbox = 0
			local l
			for i = k+1, k+textlinestogo do
				l = inputs.script_lines[i]

				if l == nil then
					break
				end

				if utf8.len(l) > maxwidthtextbox then
					maxwidthtextbox = utf8.len(l)
				end
			end

			if k < table.maxn(inputs.script_lines) and syntaxhlon then
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

	love.graphics.setColor(255,255,255,255)

	if s.scripteditor_largefont then
		newinputsys.drawcas("script_lines", 104, scriptscroll+24+16-8, 2)
	else
		newinputsys.drawcas("script_lines", 56, scriptscroll+24+8)
	end

	love.graphics.setScissor()

	-- Any warnings?
	check_script_warnings(scriptname)
	draw_script_warn_light(
		"loadscript_required",
		love.graphics.getWidth()-168,
		4,
		internalscript and scrwarncache_warn_noloadscript
	)
	draw_script_warn_light(
		"direct_reference",
		love.graphics.getWidth()-168-28,
		4,
		internalscript and scrwarncache_warn_boxed
	)
	draw_script_warn_light(
		"name",
		love.graphics.getWidth()-168-(28*2),
		4,
		scrwarncache_warn_name
	)

	-- Simplified/Internal scripting mode icon
	local ic_icon, ic_explanation, ic_r, ic_g, ic_b
	if internalscript or cutscenebarsinternalscript then
		ic = image.intsc_on
		ic_explanation = L.INTERNALON_LONG
		ic_r, ic_g, ic_b = 64, 64, 255
	else
		ic = image.intsc_off
		ic_explanation = L.INTERNALOFF_LONG
		ic_r, ic_g, ic_b = 0, 160, 0
	end
	love.graphics.setColor(ic_r, ic_g, ic_b, 255)
	love.graphics.draw(ic, 8, 4)

	if mouseon(8, 4, script_warn_lights.direct_reference.img:getDimensions()) then
		local box_w, box_h = tooltip_box_dimensions(ic_explanation, "", nil)
		tooltip_box_draw(
			ic_explanation,
			"",
			nil,
			8, 4+script_warn_lights.direct_reference.img:getHeight()+1,
			box_w, box_h,
			ic_r, ic_g, ic_b
		)
	end

	love.graphics.setColor(255,255,255,255)

	-- Now let's put a scrollbar in sight! -- -144: -(128-8)-24, -32: -24-8
	local textscale = s.scripteditor_largefont and 2 or 1
	local newfraction = scrollbar(
		love.graphics.getWidth()-144,
		24,
		love.graphics.getHeight()-32,
		(#inputs.script_lines*8+8)*textscale,
		((-scriptscroll))/(((#inputs.script_lines*8)*textscale)-(love.graphics.getHeight()-32))
	)

	if newfraction ~= nil then
		scriptscroll = -(newfraction*(((#inputs.script_lines*8)*textscale)-(love.graphics.getHeight()-32)))
	end

	-- Now put some buttons on the right!
	hoverdraw(image.helpbtn, love.graphics.getWidth()-24, 8, 16, 16, 1)
	showhotkey("q", love.graphics.getWidth()-24+8-2, 8-2)
	ved_printf(L.FILE, love.graphics.getWidth()-(128-8), 8+(24*0)+4, 128-16, "center")
	rbutton(L.SCRIPTUSAGES, 1)
	ved_printf(L.EDITTAB, love.graphics.getWidth()-(128-8), 8+(24*2)+4, 128-16, "center")
	rbutton({L.COPYSCRIPT, "cA"}, 3, nil, nil, nil, generictimer_mode == 1 and generictimer > 0)
	rbutton(L.SCRIPTSPLIT, 4)
	rbutton({L.SEARCHSCRIPT, "cF"}, 5)
	rbutton({L.GOTOLINE, "cG"}, 6)
	rbutton(
		{(internalscript or cutscenebarsinternalscript) and L.INTERNALON or L.INTERNALOFF, "cI"},
		7, nil, nil, nil,
		internalscript or cutscenebarsinternalscript
	)
	if internalscript or cutscenebarsinternalscript then
		rbutton(
			{
				internalscript and L.INTERNALNOBARS
				or cutscenebarsinternalscript and L.INTERNALYESBARS
				or L.INTERNALOFF, "cI"
			},
			8, nil, nil, nil,
			cutscenebarsinternalscript
		)
	end
	ved_printf(L.VIEW, love.graphics.getWidth()-(128-8), 8+(24*9)+4, 128-16, "center")
	rbutton(syntaxhlon and L.SYNTAXHLOFF or L.SYNTAXHLON, 10)
	rbutton(s.scripteditor_largefont and L.TEXTSIZEL or L.TEXTSIZEN, 11)

	-- Column
	local x = newinputsys.getpos("script_lines")
	ved_printf(
		L.COLUMN .. (x+1),
		love.graphics.getWidth()-(128-8),
		(love.graphics.getHeight()-(24*2))+4,
		128-16,
		"left"
	)

	rbutton({L.RETURN, "b"}, 0, nil, true)

	-- First make these buttons do things
	if nodialog and love.mouse.isDown("l") then
		if mouseon(love.graphics.getWidth()-24, 8, 16, 16) then
			-- Help
			tostate(15)
		elseif onrbutton(1) then
			-- Usages
			local uentityuses, uloadscriptuses, uscriptuses = find_script_references(scriptname)

			local roomsstr, scriptsstr = "", ""
			local co = not s.coords0 and 1 or 0 -- coordoffset

			for k,v in pairs(uentityuses) do
				roomsstr = roomsstr .. (roomsstr == "" and "" or ", ") .. "("
					.. (math.floor(entitydata[v].x/40)+co) .. ","
					.. (math.floor(entitydata[v].y/30)+co) .. ")"
			end

			for k,v in pairs(uscriptuses) do
				scriptsstr = scriptsstr .. (scriptsstr == "" and "" or ", ") .. v[1] .. ":" .. v[2]
			end

			dialog.create(
				langkeys(L_PLU.SCRIPTUSAGESROOMS, {#uentityuses, roomsstr}) .. "\n\n"
				.. langkeys(L_PLU.SCRIPTUSAGESSCRIPTS, {#uscriptuses, scriptsstr})
			)
		elseif onrbutton(3) then
			-- Copy script
			copyscript()
		elseif onrbutton(4) then
			-- Split scripts
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
			local success, raw_script = script_compile(inputs.script_lines)
			if success then
				scripts[scriptname] = raw_script
				newinputsys.close("script_lines")
				if scriptfromsearch then
					resume_search = true
					tostate(11)
				else
					tostate(10)
				end
			end

			mousepressed = true
		end
	end

	if table.contains({"syntaxcolor_wronglang", "syntaxcolor_errortext"}, context) then
		setColorArr(s[context])
		ved_printf(L[context:upper()], love.graphics.getWidth()-(128-8), 8+(24*12)+4, 128-16, "center")
	elseif context == "script" then
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
	elseif context == "room" or context == "roomcoords" then
		local rx, ry
		local cx, cy
		local valid = false
		if context == "room" then
			rx, ry = carg1, carg2
			valid = rx ~= nil and ry ~= nil
		elseif context == "roomcoords" then
			rx, ry = roomx, roomy
			cx, cy = carg1, carg2
			valid = cx ~= nil and cy ~= nil
		end
		if valid then
			local map_x, map_y = love.graphics.getWidth()-(128-8)+16, 8+(24*12)+4
			love.graphics.setColor(128,128,128)
			love.graphics.rectangle("line", map_x-.5, map_y-.5, 81, 61)
			love.graphics.setColor(255,255,255)
			if rx >= 0 and rx < metadata.mapwidth
			and ry >= 0 and ry < metadata.mapheight
			and rooms_map[ry] ~= nil
			and rooms_map[ry][rx] ~= nil
			and rooms_map[ry][rx].map ~= nil then
				local room_scale
				if s.mapstyle == "minimap" then
					local zoom = getminimapzoom(metadata)
					room_scale = 320/(12*zoom)
				elseif s.mapstyle == "vtools" then
					room_scale = 8
				else
					room_scale = 1
				end
				love.graphics.draw(rooms_map[ry][rx].map, map_x, map_y, 0, room_scale/4)
				if context == "roomcoords" then
					love.graphics.draw(image.crosshair_mini, map_x+round(cx/4)-2, map_y+round(cy/4)-2)
					love.graphics.setColor(255,255,255)
				end

				if nodialog and mouseon(map_x, map_y, 80, 60) then
					local hover_x, hover_y = love.mouse.getX()-380, love.mouse.getY()-120
					love.graphics.setColor(128,128,128)
					love.graphics.rectangle("line", hover_x-.5, hover_y-.5, 321, 241)
					love.graphics.setColor(0,0,0)
					love.graphics.rectangle("fill", hover_x, hover_y, 320, 240)
					love.graphics.setColor(255,255,255)
					love.graphics.draw(rooms_map[ry][rx].map, hover_x, hover_y, 0, room_scale)

					if context == "roomcoords" then
						love.graphics.draw(image.crosshair_gigantic, hover_x+cx-3, hover_y+cy-3)
						love.graphics.setColor(255,255,255)
					end

					if not mousepressed and love.mouse.isDown("l") then
						local click_x = (love.mouse.getX() - map_x) * 4
						local click_y = (love.mouse.getY() - map_y) * 4

						-- FIXME: Make a proper function for replacing command arguments
						-- (there is already updateroomline, but it's too specifically about gotorooms)
						local _, editing_line = newinputsys.getpos("script_lines")
						local first_coord_arg = carg3
						local pattern
						if first_coord_arg == 2 then
							pattern = "^([^%(,%)]-[%(,%)])[0-9]+([%(,%)])[0-9]+"
						elseif first_coord_arg == 3 then
							pattern = "^([^%(,%)]*[%(,%)][^%(,%)]*[%(,%)])[0-9]+([%(,%)])[0-9]+"
						end
						inputs.script_lines[editing_line] = inputs.script_lines[editing_line]:gsub(
							pattern,
							"%1" .. click_x .. "%2" .. click_y
						)
						dirty()
					end
				end
			else
				love.graphics.draw(image.covered_80x60, map_x, map_y)
			end

			local disp_rx, disp_ry
			if s.coords0 then
				disp_rx = rx
				disp_ry = ry
			else
				disp_rx = rx+1
				disp_ry = ry+1
			end
			if context == "room" then
				ved_printf(disp_rx .. "," .. disp_ry, map_x, map_y+62, 80, "center")
			elseif context == "roomcoords" then
				ved_printf(cx .. "," .. cy, map_x, map_y+62, 80, "center")
			end
		end
	elseif context == "frames" then
		carg1 = tonumber(carg1)
		if carg1 ~= nil then
			local seconds = carg1 * 34 / 1000
			seconds = round(seconds, 2)
			ved_printf(
				langkeys(L.FRAMESTOSECONDS, {carg1, seconds}),
				love.graphics.getWidth()-(128-8),
				8+(24*12)+4,
				128-16,
				"center"
			)
		end
	elseif context == "sound" then
		carg1 = tonumber(carg1)
		local ef_name = list_sound_ids[carg1]
		local ef_name_displayed = ef_name
		if ef_name_displayed == nil then
			ef_name_displayed = langkeys(L.SOUNDNUM, {carg1})
		elseif carg1 == 3 then
			-- This single one is too long to fit (even without .wav), so make it have a newline :I
			ef_name_displayed = "souleyemini\njingle.wav"
		end
		ved_printf(
			ef_name_displayed,
			love.graphics.getWidth()-(128-8),
			8+(24*12)+4,
			128-16,
			"center"
		)
		rbutton(L.PLAYSOUND, 13)

		if not mousepressed and nodialog and love.mouse.isDown("l") and onrbutton(13) then
			-- Play
			if not level_music_loaded then
				-- FIXME a bit of copy-pasting from uis/assetsmenu/load, since sound effects
				-- right now are hooked into "from where are you opening the assets menu",
				-- but this should be replaced with an Assets object.
				assetsmenu_vvvvvvfolder = levelsfolder .. dirsep .. editingmap
				assetsmenu_soundsfolder = assetsmenu_vvvvvvfolder .. soundsfolder_rel
				assetsmenu_music_prefix = "level/"

				loadvvvvvvmusics_level()
			end

			local success = false
			local audio = music_get_audio("level/sounds", carg1)
			if audio ~= nil then
				success = playmusic("level/sounds", carg1)
			end

			if not success and ef_name ~= nil then
				-- Play the built-in one. Except we use .ogg files instead of .wav
				ef_name = ef_name:sub(1,-5) .. ".ogg"
				if v6_sounds[ef_name] == nil then
					v6_sounds[ef_name] = love.audio.newSource("sounds/" .. ef_name, "static")
				end
				v6_sounds[ef_name]:stop()
				v6_sounds[ef_name]:play()
			end
			mousepressed = true
		end
	elseif context == "track" then
		carg1 = tonumber(carg1)
		if carg1 ~= nil then
			if carg1 == -1 then
				ved_printf(
					L.STOPSMUSIC,
					love.graphics.getWidth()-(128-8),
					8+(24*12)+4,
					128-16,
					"center"
				)
			else
				local trackname = ""
				if list_music_commands_ids[carg1] ~= nil then
					trackname = "\n\n" .. list_music_commands_ids[carg1]
				end
				ved_printf(
					langkeys(L.TRACKNUM, {carg1}) .. trackname,
					love.graphics.getWidth()-(128-8),
					8+(24*12)+4,
					128-16,
					"center"
				)
			end
		end
	end
end
