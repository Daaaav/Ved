-- scriptlist/draw

return function()
	local j = -1
	local newscroll
	for script_i = #scriptnames, 1, -1 do
		if scriptdisplay_used and scriptdisplay_unused
		or scriptdisplay_used and usedscripts[scriptnames[script_i]]
		or scriptdisplay_unused and not usedscripts[scriptnames[script_i]]
		then
			j = j + 1
			local y = scriptlistscroll+8+(24*j)
			if skipnextscripthoverrect then
				skipnextscripthoverrect = nil
			elseif y >= -16 and y <= love.graphics.getHeight() then
				local used = usedscripts[scriptnames[script_i]]
				hoverrectangle(128,128,128, used and 128 or 64, 8, y, screenoffset+640-8-24 -36, 16)
				font_level:printf(scriptnames[script_i], 8, y+4, screenoffset+640-8-36, "center")
				if script_i == #scriptnames then
					showhotkey("/", 8+screenoffset+640-8-24 -36, y-2, ALIGN.RIGHT)
				end

				if script_i ~= #scriptnames then
					hoverrectangle(128,128,128,128, 8+screenoffset+640-8-24 -36 +4, y, 16, 16)
					font_8x8:printf(arrow_up, 8+screenoffset+640-8-24 -36 +4, y+4, 16, "center")
				end
				if script_i ~= 1 then
					hoverrectangle(128,128,128,128, 8+screenoffset+640-8-24 -36 +4 +16 +4, y, 16, 16)
					font_8x8:printf(arrow_down, 8+screenoffset+640-8-24 -36 +4 +16 +4, y+4, 16, "center")
				end
			end

			-- Are we clicking on this?
			if mousepressed or not nodialog then
			elseif mouseon(8, scriptlistscroll+8+(24*j), screenoffset+640-8-24 -36, 16) then
				if love.mouse.isDown("l") then
					scriptineditor(scriptnames[script_i], script_i)
				elseif love.mouse.isDown("r") then
					local inverted_bump_option
					if s.bumpscriptsbydefault then
						inverted_bump_option = L.EDITWOBUMPING
					else
						inverted_bump_option = L.EDITWBUMPING
					end
					rightclickmenu.create({L.EDIT, inverted_bump_option, L.COPYNAME, L.COPYCONTENTS, L.DUPLICATE, L.RENAME, L.DELETE}, "spt_" .. script_i)
				end
			elseif script_i ~= #scriptnames and mouseon(8+screenoffset+640-8-24 -36 +4, scriptlistscroll+8+(24*j), 16, 16) and love.mouse.isDown("l") then
				movescriptdown(script_i)
				mousepressed = true
				local nextscriptvisible = (scriptdisplay_used and scriptdisplay_unused) or (scriptdisplay_used and usedscripts[scriptnames[script_i]]) or (scriptdisplay_unused and not usedscripts[scriptnames[script_i]])
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
			elseif script_i ~= 1 and mouseon(8+screenoffset+640-8-24 -36 +4 +16 +4, scriptlistscroll+8+(24*j), 16, 16) and love.mouse.isDown("l") then
				movescriptup(script_i)
				mousepressed = true
				local nextscriptvisible = (scriptdisplay_used and scriptdisplay_unused) or (scriptdisplay_used and usedscripts[scriptnames[script_i]]) or (scriptdisplay_unused and not usedscripts[scriptnames[script_i]])
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
	local newfraction = scrollbar(love.graphics.getWidth()-(128-8)-24, 8, love.graphics.getHeight()-16, ((j+1)*24-8), (-scriptlistscroll)/(((j+1)*24-8)-(love.graphics.getHeight()-16)))

	if newfraction ~= nil then
		scriptlistscroll = -(newfraction*(((j+1)*24-8)-(love.graphics.getHeight()-16)))
	end
	if newscroll ~= nil then
		scriptlistscroll = newscroll -- to prevent flickering
	end

	rbutton({L.NEW, "N"}, 0)
	rbutton({L.FLAGS, "F"}, 1)
	rbutton({L.TEXTBOXCOLORS_BUTTON, "C"}, 2)

	font_ui:printf(L.SCRIPTDISPLAY, love.graphics.getWidth()-120, 108, 112, "center")
	checkbox(scriptdisplay_used, love.graphics.getWidth()-120, 128, nil, L.SCRIPTDISPLAY_USED,
		function(key, newvalue)
			scriptdisplay_used = newvalue
			if not scriptdisplay_used and not scriptdisplay_unused then
				scriptdisplay_unused = true
			end
			changed_scriptdisplay = true
		end
	)
	checkbox(scriptdisplay_unused, love.graphics.getWidth()-120, 152, nil, L.SCRIPTDISPLAY_UNUSED,
		function(key, newvalue)
			scriptdisplay_unused = newvalue
			if not scriptdisplay_used and not scriptdisplay_unused then
				scriptdisplay_used = true
			end
			changed_scriptdisplay = true
		end
	)

	if not (scriptdisplay_used and scriptdisplay_unused) then
		font_ui:printf(langkeys(L_PLU.SCRIPTDISPLAY_SHOWING, {j+1}), love.graphics.getWidth()-120, 204, 112, "center")
	end

	-- Script count
	font_ui:printf(
		L.COUNT .. #scriptnames,
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
		elseif onrbutton(2) then
			-- Text colors
			mousepressed = true
			tostate(36)
		elseif onrbutton(0, nil, true) then
			-- Return
			tostate(1, true)
		end
		if changed_scriptdisplay then
			scriptlistscroll = 0
			if usedscripts == nil then
				usedscripts, n_usedscripts = find_used_scripts()
			end
		end

		mousepressed = true
	end
end
