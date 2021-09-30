rightclickmenu = {}
function rightclickmenu.create(items, menuid, menuposx, menuposy, abovedialog)
	if menuposx == nil then
		menuposx = love.mouse.getX()
	end
	if menuposy == nil then
		menuposy = love.mouse.getY()
	end

	RCMactive = true
	RCMx = math.min(menuposx, love.graphics.getWidth()-240)
	RCMy = math.min(menuposy, love.graphics.getHeight()-(#items*16))
	RCMactualy = menuposy -- In case we want to have this back
	RCMitems = items
	RCMid = menuid -- can be anything, really
	RCMabovedialog = abovedialog == true
	RCMwidth = 240
	for k,v in pairs(items) do
		local w = font8:getWidth(v)+8
		if w > RCMwidth then
			RCMwidth = w
		end
	end
end

function rightclickmenu.draw()
	if not RCMactive then
		return
	end

	for k,v in pairs(RCMitems) do
		if v:sub(1, 1) == "#" then
			love.graphics.setColor(112,112,112,216)
			love.graphics.rectangle("fill", RCMx, (k-1)*16+RCMy, RCMwidth, 16)
			love.graphics.setColor(192,192,192,255)
			if v == "#-" then
				love.graphics.rectangle("fill", RCMx+1, (k-1)*16+RCMy+8, RCMwidth-2, 1)
			else
				ved_print(v:sub(2, -1), RCMx+5, (k-1)*16+RCMy+4)
			end
			love.graphics.setColor(255,255,255,255)
		else
			if hoverrectangle(112,112,112,216, RCMx, (k-1)*16+RCMy, RCMwidth, 16, true) then
				love.graphics.setColor(255,255,128,255)
			end
			ved_print(v, RCMx+5, (k-1)*16+RCMy+4)
			love.graphics.setColor(255,255,255,255)
		end
	end

	if not mousepressed and love.mouse.isDown("l") then
		RCMactive = false
		mousepressed = true
		newinputsys.ignoremousepressed = true
	end
end

function rightclickmenu.mousepressed(x, y, button)
	-- Returns true if click caught.
	if not RCMactive then
		return false
	end

	if button == "l" and mouseon(RCMx, RCMy, RCMwidth, #RCMitems*16) then
		local item = RCMitems[math.floor((y-RCMy)/16)+1]
		if item:sub(1, 1) == "#" then
			return true
		end
		rightclickmenu.handler(item)
	end

	RCMactive = false
	mousepressed = true
	return true
end

function rightclickmenu.handler(RCMreturn)
	if RCMreturn == nil or RCMreturn == "" then
		return
	end

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
					L.RAWENTITYPROPERTIES,
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
				end
			elseif tonumber(entdetails[2]) == 2 then
				-- Platform, moving/conveyor
				if RCMreturn == L.CYCLETYPE then
					local new_p1
					if entitydata[tonumber(entdetails[3])].p1 <= 4 then
						-- Moving platform
						new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 3, 0)
					else
						-- Conveyor
						new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 8, 5)
					end
					rcm_changingentity(entdetails, {p1 = new_p1})
					entitydata[tonumber(entdetails[3])].p1 = new_p1
				end
			elseif tonumber(entdetails[2]) == 10 then
				-- Checkpoint
				if RCMreturn == L.FLIP then
					local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
					rcm_changingentity(entdetails, {p1 = new_p1})
					entitydata[tonumber(entdetails[3])].p1 = new_p1
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
				end
			elseif tonumber(entdetails[2]) == 15 then
				-- Rescuable crewmate
				if RCMreturn == L.CHANGECOLOR then
					local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 5, 0)
					rcm_changingentity(entdetails, {p1 = new_p1})
					entitydata[tonumber(entdetails[3])].p1 = new_p1
				end
			elseif tonumber(entdetails[2]) == 16 then
				-- Start point
				if RCMreturn == L.CHANGEDIRECTION then
					local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
					rcm_changingentity(entdetails, {p1 = new_p1})
					entitydata[tonumber(entdetails[3])].p1 = new_p1
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
				end
			elseif tonumber(entdetails[2]) == 18 or tonumber(entdetails[2]) == 19 then
				-- Terminal or script box
				if table.contains({L.EDITSCRIPT, L.EDITSCRIPTWOBUMPING}, RCMreturn) then
					-- Were we already editing roomtext or a name?
					if editingroomtext > 0 then
						-- The argument here is the number of the entity not to make nil- the entity we currently want to edit the script of
						endeditingroomtext(tonumber(entdetails[3]))
					end

					local script_i
					if RCMreturn == L.EDITSCRIPTWOBUMPING then
						script_i = -1
					end
					if scripts[entitydata[tonumber(entdetails[3])].data] == nil then
						dialog.create(langkeys(L.SCRIPT404, {entitydata[tonumber(entdetails[3])].data}))
					else
						scriptineditor(entitydata[tonumber(entdetails[3])].data, script_i)
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
				elseif RCMreturn == L.FLIP then -- only for terminals obviously
					local new_p1 = cycle(entitydata[tonumber(entdetails[3])].p1, 1, 0)
					rcm_changingentity(entdetails, {p1 = new_p1})
					entitydata[tonumber(entdetails[3])].p1 = new_p1
				elseif RCMreturn == toolnames[12] then
					local ret = namefound(entitydata[tonumber(entdetails[3])])
					if ret == 1 then
						s_nieuw(tonumber(entdetails[3]))
					elseif ret == -1 then
						p_nieuw(tonumber(entdetails[3]))
					end
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
		local script_i = tonumber(RCMid:sub(5, -1))

		if RCMreturn == L.EDIT then
			scriptineditor(scriptnames[script_i], script_i)
		elseif RCMreturn == L.EDITWOBUMPING then
			scriptineditor(scriptnames[script_i], -1)
		elseif RCMreturn == L.COPYNAME then
			love.system.setClipboardText(scriptnames[script_i])
		elseif RCMreturn == L.COPYCONTENTS then
			love.system.setClipboardText(table.concat(scripts[scriptnames[script_i]], (love.system.getOS() == "Windows" and "\r\n" or "\n")))
		elseif RCMreturn == L.DUPLICATE then
			dialog.create(
				L.NEWSCRIPTNAME, DBS.OKCANCEL,
				dialog.callback.newscript, L.DUPLICATE, dialog.form.hidden_make({script_i=script_i}, dialog.form.simplename),
				dialog.callback.newscript_validate, "duplicate_list"
			)
		elseif RCMreturn == L.DELETE then
			if keyboard_eitherIsDown("shift") then
				delete_script(script_i)
			else
				dialog.create(
					langkeys(L.SUREDELETESCRIPT, {scriptnames[script_i]}), DBS.YESNO,
					dialog.callback.suredeletescript, nil, dialog.form.hidden_make({script_i=script_i})
				)
			end
		elseif RCMreturn == L.RENAME then
			dialog.create(
				L.NEWNAME, DBS.OKCANCEL,
				dialog.callback.renamescript, L.RENAMESCRIPT,
				{
					{"name", 0, 1, 40, scriptnames[script_i], DF.TEXT},
					{"references", 0, 3, 2+font8:getWidth(L.RENAMESCRIPTREFERENCES)/8, true, DF.CHECKBOX},
					{"", 2, 3, 40, L.RENAMESCRIPTREFERENCES, DF.LABEL},
					{"script_i", 0, 0, 0, script_i, DF.HIDDEN},
				},
				dialog.callback.renamescript_validate
			)
		end
	elseif RCMid:sub(1, 4) == "bul_" then
		if RCMreturn == L.SAVEBACKUP then
			dialog.create(
				L.ENTERNAMESAVE .. "\n\n\n" .. L.SAVEBACKUPNOBACKUP, DBS.OKCANCEL,
				dialog.callback.savebackup, L.SAVEBACKUP, dialog.form.hidden_make({filename=RCMid:sub(5, -1)}, dialog.form.simplename)
			)
		end
	elseif RCMid:sub(1, 4) == "lnk_" then
		if RCMreturn == L.COPYLINK then
			love.system.setClipboardText(RCMid:sub(5, -1))
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
		end
	elseif RCMid:sub(1, 5) == "input" and newinputsys ~= nil and --[[ nil check only because we're slowly transitioning to the new system ]] newinputsys.active then
		local id = newinputsys.input_ids[#newinputsys.nth_input] -- Sidestep putting the id in RCMid, because if we did it'd convert it to a string
		if RCMreturn == L.UNDO then
			newinputsys.undo(id)
		elseif RCMreturn == L.REDO then
			newinputsys.redo(id)
		elseif table.contains({L.COPY, L.CUT}, RCMreturn) then
			newinputsys.atomiccopycut(id, RCMreturn == L.CUT)
		elseif RCMreturn == L.PASTE then
			newinputsys.atomicpaste(id)
		elseif RCMreturn == L.DELETE then
			newinputsys.atomicdelete(id)
		elseif RCMreturn == L.MOVELINEUP then
			newinputsys.atomicmovevertical(id, -1)
		elseif RCMreturn == L.MOVELINEDOWN then
			newinputsys.atomicmovevertical(id, 1)
		elseif RCMreturn == L.DUPLICATELINE then
			newinputsys.atomicdupeline(id)
		elseif RCMreturn == L.SELECTWORD then
			newinputsys.selectword(id, ({newinputsys.getpos(id)})[1])
		elseif RCMreturn == L.SELECTLINE then
			newinputsys.sellinetoright(id)
		elseif RCMreturn == L.SELECTALL then
			newinputsys.selallright(id)
		elseif RCMreturn == L.INSERTRAWHEX then
			newinputsys.starthex(id)
		end
	else
		dialog.create("Unhandled right click menu!\n\nID: " .. RCMid .. "\nReturn value: " .. RCMreturn)
	end
end
