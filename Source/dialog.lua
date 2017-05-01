-- Apart from just dialogs, this script also includes functions for the right click menu and scroll bar.

dialog = {}

function dialog.draw()
	-- Now come the dialogs!
	if DIAwindowani ~= 16 then
		-- Window contents
		setColorDIA(192,192,192,239)
		love.graphics.rectangle("fill", DIAx, DIAy+DIAwindowani, DIAwidth, DIAheight)
		-- Text
		setColorDIA(0,0,0,255)
		love.graphics.printf(DIAtext, DIAx+10, DIAy+DIAwindowani+10, DIAwidth-20, "left")
		
		-- Text boxes
		dialog.textboxes()
		
		-- Button, if enabled
		if DIAcanclose ~= 0 then
			local btnwidth = 72
			
			if mouseon(DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn1glow < 15) then
				DIAbtn1glow = DIAbtn1glow + 1
				
				if DIAwindowani == 0 and love.mouse.isDown("l") then
					if DIAcanclose == 2 then
						dialog.push()
						DIAreturn = 1
						DIAquitting = 1
					elseif DIAcanclose == 5 then
						DIAreturn = 1
					else
						dialog.push()
						DIAreturn = 1
					end
				end
			elseif DIAbtn1glow > 0 then
				DIAbtn1glow = DIAbtn1glow - 1
			end
			
			if DIAcanclose == 3 or DIAcanclose == 4 or DIAcanclose == 5 then
				if mouseon(DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn2glow < 15) then
					DIAbtn2glow = DIAbtn2glow + 1
					
					if DIAwindowani == 0 and love.mouse.isDown("l") then
						dialog.push()
						DIAreturn = 2
					end
				elseif DIAbtn2glow > 0 then
					DIAbtn2glow = DIAbtn2glow - 1
				end
			end
			
			if DIAcanclose == 5 then
				if mouseon(DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn3glow < 15) then
					DIAbtn3glow = DIAbtn3glow + 1
					
					if DIAwindowani == 0 and love.mouse.isDown("l") then
						dialog.push()
						DIAreturn = 3
					end
				elseif DIAbtn3glow > 0 then
					DIAbtn3glow = DIAbtn3glow - 1
				end
			end

			setColorDIA(64+(4*DIAbtn1glow),64+(4*DIAbtn1glow),64+(4*DIAbtn1glow),128)
			love.graphics.rectangle("fill", DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
			setColorDIA(0,0,0,255)
			if DIAcanclose == 1 then
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 2 then
				love.graphics.printf(L.BTN_QUIT, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 3 then
				love.graphics.printf(L.BTN_NO, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 4 then
				love.graphics.printf(L.BTN_CANCEL, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 5 then
				love.graphics.printf(L.BTN_APPLY, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end
			
			if DIAcanclose == 3 then
				setColorDIA(64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
				love.graphics.printf(L.BTN_YES, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 4 then
				setColorDIA(64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 5 then
				setColorDIA(64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
				love.graphics.printf(L.BTN_CANCEL, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end
			
			if DIAcanclose == 5 then
				setColorDIA(64+(4*DIAbtn3glow),64+(4*DIAbtn3glow),64+(4*DIAbtn3glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end
		end
		-- Window border
		setColorDIA(255,255,255,239)
		love.graphics.rectangle("line", DIAx, DIAy+DIAwindowani, DIAwidth, DIAheight)
		-- Bar, if enabled
		if DIAbar == 1 then
			setColorDIA(64,64,64,128)
			love.graphics.rectangle("fill", DIAx-1, DIAy+DIAwindowani-17, DIAwidth+2, 16)
			
			-- Also display the title text (if not empty). Shadow first
			setColorDIA(0,0,0,255)
			love.graphics.print(DIAbartext, DIAx-1+4+1, DIAy+DIAwindowani-17+6+1)
			setColorDIA(255,255,255,255)
			love.graphics.print(DIAbartext, DIAx-1+4, DIAy+DIAwindowani-17+6)
		end
	end
	
	if DIAwindowani < 0 then
		-- Window is opening
		DIAwindowani = math.min(DIAwindowani + (60/math.max(love.timer.getFPS(), 1)), 0)
	elseif (DIAwindowani > 0) and (DIAwindowani < 16) then
		-- Window is closing
		DIAwindowani = math.min(DIAwindowani + (60/math.max(love.timer.getFPS(), 1)), 16)
	-- else windowani == 16, window is gone
	elseif DIAwindowani == 16 then
		-- No dialog.
		if DIAquitting == 1 then
			love.timer.sleep(0.1)
			love.event.quit()
		end
	end
end

function dialog.textboxes()
	if DIAquestionid == 2 then
		-- Entity properties
		for box = 1, 10 do
			hoverdiatext(DIAx+10+16+24, DIAy+DIAwindowani+10+24+(8*(box-1)), 300, 8, multiinput[box], box, currentmultiinput == box)
		end
	elseif DIAquestionid == 5 then
		-- Level properties
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10, 20*8, 8, multiinput[1], 1, currentmultiinput == 1)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(1*8), 37*8, 8, multiinput[2], 2, currentmultiinput == 2)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(2*8), 40*8, 8, multiinput[3], 3, currentmultiinput == 3)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(4*8), 40*8, 8, multiinput[4], 4, currentmultiinput == 4)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(5*8), 40*8, 8, multiinput[5], 5, currentmultiinput == 5)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(6*8), 40*8, 8, multiinput[6], 6, currentmultiinput == 6)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(8*8), 3*8, 8, multiinput[7], 7, currentmultiinput == 7) -- 5
		hoverdiatext(DIAx+10+(12*8), DIAy+DIAwindowani+10+(8*8), 3*8, 8, multiinput[8], 8, currentmultiinput == 8) -- 9
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(10*8), 188, 8, multiinput[9], 9, currentmultiinput == 9, 1, listmusicnames, listmusicids, "music") -- 6
	elseif DIAquestionid == 9 or DIAquestionid == 11 or DIAquestionid == 12 or DIAquestionid == 13 or DIAquestionid == 15 or DIAquestionid == 19 or DIAquestionid == 20 or DIAquestionid == 21 or DIAquestionid == 22 then
		-- Create new script or note or anything else with a single-line
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(1*8), 40*8, 8, multiinput[1], 1, currentmultiinput == 1)
	elseif DIAquestionid == 10 then
		-- Save level
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(1*8), 40*8, 8, multiinput[1], 1, currentmultiinput == 1)
		
		--if namenotgiven then
			hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(4*8), 40*8, 8, multiinput[2], 2, currentmultiinput == 2)
		--end
	elseif DIAquestionid == 18 then
		-- Go to line
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(1*8), 5*8, 8, multiinput[1], 1, currentmultiinput == 1)
	elseif DIAquestionid == 23 then
		-- Custom VVVVVV dir, use the space we can get
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(8*8), 47*8, 8, multiinput[1], 1, currentmultiinput == 1)
	elseif DIAquestionid == 24 then
		-- Language
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(4*8), 188, 8, multiinput[1], 1, currentmultiinput == 1, 1, languageslist, nil, "language")
		
		-- Unique, not an input field, but specific to this text box
		setColorDIA(0,0,0,255)
		love.graphics.printf(L.TRANSLATIONCREDIT, DIAx+10, DIAy+DIAwindowani+10+(15*8), DIAwidth-(2*72)-6-10, "left") -- 72 is that btnwidth up there
	end
end

--[[
function dialog.keypressed()
	if (DIAwindowani ~= 16) and (DIAcanclose == 1) and (key == "return") then
		dialog.push()
		DIAreturn = 1
	elseif (DIAwindowani ~= 16) and (DIAcanclose == 2) and (key == "return") then
		dialog.push()
		DIAreturn = 1
		DIAquitting = 1
	end
end
]]

function dialog.update()
	if (DIAcanclose == 5 and DIAreturn == 1) --[[ apply ]] or (DIAwindowani == 16 and DIAquestionid ~= 0) then
		if (DIAquestionid == 1) then -- State 9 test
			-- Do something
			-- if DIAreturn == 1 then
			youdidanswer = "You answered: " .. DIAreturn
		elseif (DIAquestionid == 2) then
			-- Save entity properties
			if DIAreturn == 2 or DIAreturn == 3 then -- cancel/ok
				stopinput()
			end
			
			if DIAreturn == 1 or DIAreturn == 3 then -- apply or ok
				-- entdetails[3] is still the ID of this entity
				local correctlines = false
				if (entitydata[tonumber(entdetails[3])].t == 11 or entitydata[tonumber(entdetails[3])].t == 50) -- gravity line or warp line
				and entitydata[tonumber(entdetails[3])].p1 == anythingbutnil0(tonumber(multiinput[4]))
				and entitydata[tonumber(entdetails[3])].p2 == anythingbutnil0(tonumber(multiinput[5]))
				and entitydata[tonumber(entdetails[3])].p3 == anythingbutnil0(tonumber(multiinput[6])) then
					correctlines = true
				end
				
				local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6"}
				for i = 1, 9 do
					entitydata[tonumber(entdetails[3])][entitypropkeys[i]] = anythingbutnil0(tonumber(multiinput[i]))
				end
				entitydata[tonumber(entdetails[3])].data = multiinput[10]
				
				if correctlines then
					autocorrectlines()
					
					-- Do keep the fields in sync, if we're only applying
					if DIAreturn == 1 then
						multiinput[4] = entitydata[tonumber(entdetails[3])].p1
						multiinput[5] = entitydata[tonumber(entdetails[3])].p2
						multiinput[6] = entitydata[tonumber(entdetails[3])].p3
						mousepressed = true
					end
				end
			end
		elseif (DIAquestionid == 3) then
			-- load a level or not
			if DIAreturn == 2 then -- yes
				tostate(6)
			end
		elseif (DIAquestionid == 4) and (DIAreturn == 2) then
			-- Add a 21st trinket
			cons("Trinket: " .. atx .. " " .. aty)
			
			table.insert(entitydata, count.entity_ai,
				{
				x = 40*roomx + atx,
				y = 30*roomy + aty,
				t = 9,
				p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 320, p6 = 240,
				data = ""
				})
				
			count.trinkets = count.trinkets + 1
			count.entities = count.entities + 1
			count.entity_ai = count.entity_ai + 1
		elseif (DIAquestionid == 5) then
			stopinput()
			if DIAreturn == 2 then
				-- Level properties
				metadata.Title = multiinput[1]
				metadata.Creator = multiinput[2]
				metadata.website = multiinput[3]
				metadata.Desc1 = multiinput[4]
				metadata.Desc2 = multiinput[5]
				metadata.Desc3 = multiinput[6]
				--if ( (tonumber(multiinput[7]) > 20) or (tonumber(multiinput[8]) > 20) ) and ( (tonumber(multiinput[7]) < metadata.mapwidth) or (tonumber(multiinput[8]) < metadata.mapheight) ) then
					-- On one side you're making the map size too large and on the other you're making it smaller than it is...
					
				--v elseif
				if (tonumber(multiinput[7]) ~= nil and tonumber(multiinput[8]) ~= nil) then
					if (tonumber(multiinput[7]) < 1) then
						multiinput[7] = 1
					end
					if (tonumber(multiinput[8]) < 1) then
						multiinput[8] = 1
					end

					if (tonumber(multiinput[7]) > 20) or (tonumber(multiinput[8]) > 20) then
						-- Ok hold on a second. Do you really want that?
						if s.allowlimitbypass then
							dialog.new(L.SIZELIMITSURE, "", 1, 3, 6)
							replacedialog = true
						else
							dialog.new(langkeys(L.SIZELIMIT, {math.min(20, tonumber(multiinput[7])), math.min(20, tonumber(multiinput[8]))}), "", 1, 1, 0)
							metadata.mapwidth = math.min(20, tonumber(multiinput[7]))
							metadata.mapheight = math.min(20, tonumber(multiinput[8]))
							addrooms(metadata.mapwidth, metadata.mapheight)
							gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
						end
					--elseif (tonumber(multiinput[7]) < metadata.mapwidth) or (tonumber(multiinput[8]) < metadata.mapheight) then
						-- We're making the map smaller
						--dialog.new("Are you sure you wish to make the map smaller?
					else
						-- Just do it
						metadata.mapwidth = math.min(20, tonumber(multiinput[7]))
						metadata.mapheight = math.min(20, tonumber(multiinput[8]))
						addrooms(metadata.mapwidth, metadata.mapheight)
						gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
					end
				end
				metadata.levmusic = multiinput[9]
			end
		elseif (DIAquestionid == 6) and (DIAreturn == 2) then
			-- Yes, I do want to change the level size to this. If I set it to lower than the existing size I might lose rooms - or if I bypass the 20x20 limit this level will become nuclear.
			metadata.mapwidth = tonumber(multiinput[7])
			metadata.mapheight = tonumber(multiinput[8])
			addrooms(metadata.mapwidth, metadata.mapheight)
			gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
		elseif (DIAquestionid == 7) and (DIAreturn == 2) then
			-- Yes, create a new blank map, I'll lose any unsaved content
			-- Make a dialog for options right away later
			triggernewlevel()
		elseif (DIAquestionid == 8) and (DIAreturn == 2) then
			-- Yes, quit. I'll lose any unsaved content.
			bypassdialog = true
			love.event.quit()
		elseif (DIAquestionid == 9 or DIAquestionid == 11 or DIAquestionid == 21 or DIAquestionid == 22) then
			--     new script (list)    new script (editor)          split (editor)        duplicate (list)
			stopinput()
			if DIAreturn == 2 then
				-- Add a script with this name. In case we're making a new script while editing one already that uses an unused flag name and all flags are occupied, make this all a function.
				
				leavescript_to_state = function()
					if DIAquestionid == 11 then -- making new script from editor, not in script list
						-- We're currently already editing a script so save that before jumping to a new one!
						scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
						scripts[scriptname] = table.copy(scriptlines)
					elseif DIAquestionid == 21 then
						-- Splitting a script, but we already saved the input earlier
						scripts[scriptname] = table.copy(scriptlines)
					end
					
					if scripts[multiinput[1]] == nil then
						table.insert(scriptnames, multiinput[1])
						if DIAquestionid ~= 21 and DIAquestionid ~= 22 then
							-- Creating an empty script
							scripts[multiinput[1]] = {""}
							
							--##SCRIPT##  ACCEPTABLE
							scriptlines = {""}

							-- Also make sure internal scripting mode doesn't stick
							internalscript = false
						else
							-- Splitting/duplicating the current script
							local keepinternal
							if DIAquestionid == 21 then
								-- Splitting, meaning in editor
								scripts[multiinput[1]] = originalscript -- We now have a duplicate. Might as well leave this as a reference.
								
								-- Now cut off the top part of the new script
								for i = 1, spl_originaleditingline-1 do
									table.remove(scripts[multiinput[1]], 1)
								end
								
								-- Oh, was the script an internal script by the way?
								keepinternal = internalscript
							else
								-- Duplicating, meaning in menu
								input = tonumber(input)
								scripts[multiinput[1]] = table.copy(scripts[scriptnames[input]])
							end
							
							scriptlines = table.copy(scripts[multiinput[1]])
							
							processflaglabels()
							if DIAquestionid == 21 then
								-- Splitting
								internalscript = keepinternal
							end
						end
						scriptname = multiinput[1]
						tostate(3)
					else
						dialog.new(langkeys(L.SCRIPTALREADYEXISTS, {multiinput[1]}), "", 1, 1, 0)
						if DIAquestionid ~= 21 then
							-- Not splitting
							replacedialog = true
							
							--##SCRIPT##  DONE
							scriptineditor(multiinput[1])
						else
							-- Splitting
						end
					end
				end
				
				if DIAquestionid == 21 and scripts[multiinput[1]] == nil then
					-- Splitting
					scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
					spl_originaleditingline = editingline
					editingline = 1
					input, input_r = scriptlines[1], ""
					originalscript = table.copy(scriptlines) -- We need to have the unconverted version
					local totalnumberlines = #scriptlines
					
					-- Before we save the current (possibly internal) script, split the contents of the old script.
					for i = spl_originaleditingline, totalnumberlines do
						table.remove(scriptlines)
					end
				end
				
				if (DIAquestionid ~= 11 and DIAquestionid ~= 21) or (not processflaglabelsreverse()) then
					leavescript_to_state()
				else
					replacedialog = true
				end
			elseif DIAquestionid == 11 or DIAquestionid == 21 then
				-- We were already editing a script so re-enable input for that!
				takinginput = true
			end
		elseif (DIAquestionid == 10) then
			stopinput()
			if DIAreturn == 2 then
				-- Save the level with this name. But first apply the title!
				metadata.Title = multiinput[2]
				
				savedsuccess, savederror = savelevel(multiinput[1] .. ".vvvvvv", metadata, roomdata, entitydata, levelmetadata, scripts, vedmetadata)
				editingmap = multiinput[1]
				
				if not savedsuccess then
					-- Why not :c
					dialog.new(L.SAVENOSUCCESS .. anythingbutnil(savederror), "", 1, 1, 0)
					replacedialog = true
				end
			end
		-- DIAQUESTIONID 11 IS HANDLED ABOVE (ALMOST EQUAL TO 9)
		elseif (DIAquestionid == 12) then
			stopinput()
			if DIAreturn == 2 then
				-- Add a note with this name.
				stopinput()
				
				-- We're currently already editing a script so save that before jumping to a new one!
				--scripts[scriptname] = scriptlines .
				
				local newname = uniquenotename(multiinput[1])
				
								-- v by reference anyways
				table.insert(helppages, {subj = newname, imgs = {}, cont = [[
]] .. multiinput[1] .. [[\wh#

]] .. L.CONTENTFILLER})

				helparticle = #helppages
				helpeditingline = 3
				takinginput = true
				helparticlecontent = explode("\n", helppages[#helppages].cont)
				input = anythingbutnil(helparticlecontent[3])
			end
		elseif (DIAquestionid == 13) then
			stopinput()
			if DIAreturn == 2 then
				-- Rename this note
				
				local newname = uniquenotename(multiinput[1], helppages[helparticle].subj)
				
				helppages[helparticle].subj = newname
				
				--[[
				if helpeditingline ~= 0 then
					takinginput = true
				end
				]]
			end
		elseif (DIAquestionid == 14) and (DIAreturn == 2) then
			-- Yes, delete this note
			table.remove(helppages, helparticle)
			if helppages[helparticle] == nil then
				helparticle = helparticle - 1
			end
			
			-- Go to the new article (removing this line will cause the deleted article to be left on the screen, along with its buttons, but not the button in the left menu for it)
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		elseif (DIAquestionid == 15) then
			stopinput()
			if DIAreturn == 2 then
				-- Is the name valid?
				if tostring(tonumber(multiinput[1])) == tostring(multiinput[1]) then
					-- This is a number
					dialog.new(L.FLAGNAMENUMBERS, "", 1, 1, 0)
					replacedialog = true
				elseif multiinput[1]:find("%(") or multiinput[1]:find("%)") or multiinput[1]:find(",") or multiinput[1]:find(" ") then
					-- This contains illegal characters
					dialog.new(L.FLAGNAMECHARS, "", 1, 1, 0)
					replacedialog = true
				else
					-- Final check: check if this flag hasn't been used already.
					for kd = 0, 99 do
						if kd ~= flnum and multiinput[1] ~= "" and vedmetadata ~= false and vedmetadata.flaglabel[kd] == multiinput[1] then
							-- This flag already exists!
							dialog.new(langkeys(L.FLAGNAMEINUSE, {multiinput[1], kd}), "", 1, 1, 0)
							replacedialog = true
						end
					end
				
					if not replacedialog then
						-- Give a name to this flag, but first check if we actually have vedmetadata
						if vedmetadata == false then
							vedmetadata = createmde()
						end
						
						vedmetadata.flaglabel[flgnum] = multiinput[1]
						
						-- Refresh the state so it shows the correct label now
						loadstate(state)
					end
				end
			end
		elseif DIAquestionid == 16 and DIAreturn == 2 then
			-- Leave the editor even though a flag label doesn't have a number now.
			leavescript_to_state()
		elseif DIAquestionid == 17 and DIAreturn == 2 then
			-- Delete this script!
			-- input is the 'number' of the script
			
			scripts[scriptnames[input]] = nil
			table.remove(scriptnames, input)
			
			-- The script number is input
			--table.remove(scripts, scriptnames[input])
			--table.remove(scriptnames, input)
		elseif DIAquestionid == 18 then
			--stopinput()
			currentmultiinput = 0
			if DIAreturn == 2 then
				-- Go to line in script
				scriptgotoline(tonumber(multiinput[1]))
			end
			-- Take input again!
			takinginput = true
		elseif DIAquestionid == 19 then
			stopinput()
			-- Be a number, you input!
			input = tonumber(input)
			if DIAreturn == 2 then
				-- Rename this script... As long as the names aren't the same, because then we'd end up *removing* the script (just read the code)
				-- And of course, as long as a script with that name doesn't already exist.
				-- input is the 'number' of the script
				if scripts[multiinput[1]] ~= nil and multiinput[1] ~= scriptnames[input] then
					dialog.new(langkeys(L.SCRIPTALREADYEXISTS, {multiinput[1]}), "", 1, 1, 0)
					replacedialog = true
				elseif multiinput[1] ~= scriptnames[input] then
					scripts[multiinput[1]] = scripts[scriptnames[input]] -- Copy script from old to new name
					scripts[scriptnames[input]] = nil -- Remove old name
					
					scriptnames[input] = multiinput[1] -- Administrative rename
				end
			end
		elseif DIAquestionid == 20 then
			currentmultiinput = 0 -- Not stopping input on purpose
			if DIAreturn == 2 then
				scriptsearchterm = multiinput[1]
				inscriptsearch(multiinput[1])
			end
			takinginput = true
		-- 21 AND 22 HANDLED ABOVE AT 9 AND 11 (21 is script split, 22 is script duplicate)
		elseif DIAquestionid == 23 then
			stopinput()
			if DIAreturn == 2 then
				-- Set the custom VVVVVV directory to this
				s.customvvvvvvdir = multiinput[1]
			end
		elseif DIAquestionid == 24 then
			stopinput()
			if DIAreturn == 2 then
				-- Set the language
				s.lang = multiinput[1]
				saveconfig()
			end
		end
		
		-- The answer to the question has been handled now. Or has it?
		if replacedialog == nil then
			if not (DIAcanclose == 5 and DIAreturn == 1) then
				DIAquestionid = 0
				multiinput = {}
			end
			--replacedialog = nil
		end
		replacedialog = nil
		DIAreturn = 0
	end
	
	if DIAmovingwindow == 1 then
		DIAx = DIAmovedfromwx + (love.mouse.getX()-DIAmovedfrommx)
		DIAy = DIAmovedfromwy + (love.mouse.getY()-DIAmovedfrommy)
	end
end

--[[
function dialog.mousepressed()
	if (DIAwindowani ~= 16) and (DIAbar == 1) and (mouseb == "l") and (mousex >= DIAx) and (mousex <= DIAx+DIAwidth) and (mousey >= DIAy-17) and (mousey <= DIAy) then
		DIAmovingwindow = 1
		DIAmovedfromwx = DIAx
		DIAmovedfromwy = DIAy
		DIAmovedfrommx = mousex
		DIAmovedfrommy = mousey
	end
	
	if DIAwindowani ~= 16 then
		if (DIAcanclose == 1) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
		elseif (DIAcanclose == 2) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
			DIAquitting = 1
		elseif (DIAcanclose == 3) and mousein(DIAx+DIAwidth-51, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-1, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 1
		elseif (DIAcanclose == 3) and mousein(DIAx+DIAwidth-106, DIAy+DIAwindowani+DIAheight-26, DIAx+DIAwidth-56, DIAy+DIAwindowani+DIAheight-1) then
			dialog.push()
			DIAreturn = 2
		end
		
		return
	end
end
]]

function dialog.new(message, title, showbar, canclose, questionid)
	dialog.init()
	DIAbartext = title
	DIAtext = message
	DIAbar = showbar
	DIAcanclose = canclose
	if s.dialoganimations then
		DIAwindowani = -15
	else
		DIAwindowani = 0
	end
	
	if (questionid ~= nil) then
		DIAquestionid = questionid
	else
		DIAquestionid = 0
	end
	
	DIAreturn = 0
end

function dialog.push()
	if s.dialoganimations then
		DIAwindowani = DIAwindowani + 1
	else
		DIAwindowani = 16
	end
end

function setColorDIA(rood, groen, blauw, alfa)
	if math.floor(DIAwindowani) < 0 then
		love.graphics.setColor(rood,groen,blauw,((math.floor(DIAwindowani)+15)/15)*alfa)
	elseif math.floor(DIAwindowani) == 0 then
		love.graphics.setColor(rood,groen,blauw,alfa)
	elseif (math.floor(DIAwindowani) > 0) and (math.floor(DIAwindowani) < 16) then
		love.graphics.setColor(rood,groen,blauw,((15-math.floor(DIAwindowani))/15)*alfa)
	end
end

function dialog.init()
	-- DIAx = 200
	-- DIAy = 225
	DIAx = (love.graphics.getWidth()-400)/2
	DIAy = (love.graphics.getHeight()-150)/2
	DIAwidth = 400
	DIAheight = 150
	DIAmovingwindow = 0
	DIAmovedfromwx = 100
	DIAmovedfromwy = 100
	DIAmovedfrommx = 0
	DIAmovedfrommy = 0
	DIAquitting = 0
	DIAwindowani = 16
	DIAbtn1glow = 0
	DIAbtn2glow = 0
	DIAbtn3glow = 0
	DIAquestionid = 0
	
	DIAbar = 1
	DIAcanclose = 1 -- Can be closed. This is actually the button type, 0 is none - dialog can't be closed, 1 is OK, 2 is Quit, 3 is yes or no.
	
	DIAreturn = 0 -- Button pressed, which could be used afterwards.
	
	DIAbartext = "UNDEFINED"
	DIAtext = "UNDEFINED"
end

-- And here some stuff for the right click menu
rightclickmenu = {}
function rightclickmenu.create(items, menuid, menuposx, menuposy, abovedialog)
	if menuposx == nil then
		menuposx = love.mouse.getX()
	end if menuposy == nil then
		menuposy = love.mouse.getY()
	end

	RCMactive = true
	RCMx = math.min(menuposx, love.graphics.getWidth()-188)
	RCMy = math.min(menuposy, love.graphics.getHeight()-(#items*16))
	RCMactualy = menuposy -- In case we want to have this back
	RCMitems = items
	RCMid = menuid -- can be anything, really
	RCMreturn = ""
	RCMabovedialog = abovedialog == true
	RCMturnedintofield = false -- If you start typing while one of these is up for a multiinput, it'll turn into a thing that looks like an autocorrect field. Or some kind of other input method.
end

function rightclickmenu.draw()
	if RCMactive == true then
		for k,v in pairs(RCMitems) do
			if v:sub(1, 1) == "#" or RCMturnedintofield then
				love.graphics.setColor(128,128,128,192)
				love.graphics.rectangle("fill", RCMx, (k-1)*16+RCMy, 188, 16) -- 150 -> 188
				love.graphics.setColor(192,192,192,255)
				if not RCMturnedintofield then
					love.graphics.print(v:sub(2, -1), RCMx+1, (k-1)*16+RCMy+6)
				elseif RCMid == "music" then
					love.graphics.print(anythingbutnil(multiinput[9]) .. __, RCMx+1, (k-1)*16+RCMy+6)
					-- Right
					if multiinput[9] == nil then
						RCMactive = false
					end
				end
				love.graphics.setColor(255,255,255,255)
			else
				hoverrectangle(128,128,128,192, RCMx, (k-1)*16+RCMy, 188, 16, true)
				love.graphics.print(v, RCMx+1, (k-1)*16+RCMy+6)
				
				if not mousepressed and love.mouse.isDown("l") and mouseon(RCMx, (k-1)*16+RCMy, 150, 16) then
					RCMreturn = v
				end
			end
		end
		
		if not mousepressed and love.mouse.isDown("l") then
			RCMactive = false
		end
	end
end

function rightclickmenu.tofield()
	-- Turn into a box thing!
	RCMturnedintofield = true
	newitems = {}
	table.insert(newitems, "#_")
	RCMitems = newitems
	RCMy = math.min(RCMactualy, love.graphics.getHeight()-16)
	
	if RCMid == "music" then
		multiinput[9] = ""
	end
end

-- Scroll bars!
function scrollbar(x, y, height, scrollableheight, peronetage)
	-- Returns nil if untouched, returns scroll value if moved
	-- New peronetage maybe?
	local newperonetage
	
	love.graphics.setColor(96,96,96,96)
	love.graphics.rectangle("fill", x, y, 16, height)
	
	if scrollableheight > height then
		-- Display an actual scrollable thing
		-- BUTTONheight: (height/scrollableheight)*height
		-- BUTTONy: (height-BUTTONheight)*peronetage
		local buttonheight = (height/scrollableheight)*height
		
		local scrollclickoffset = 0
		if scrollclickstart ~= nil then
			scrollclickoffset = love.mouse.getY()-scrollclickstart
		end
		
		if mouseon(x, y+(height-buttonheight)*peronetage+scrollclickoffset, 16, buttonheight) then
			love.graphics.setColor(224,224,224,255)
		else
			love.graphics.setColor(192,192,192,255)
			--[[
			if not mousepressed and love.mouse.isDown("l") then
				if scrollclickstart == nil then
					scrollclickstart = love.mouse.getY()
				end
			elseif scrollclickstart ~= nil then
				scrollclickstart = nil
			end
			]]
			--[[
			if not (not mousepressed and love.mouse.isDown("l")) then
				scrollclickstart = love.mouse.getY()
			end
			]]
		end
		
		if mouseon(x, y+(height-buttonheight)*peronetage+scrollclickoffset, 16, buttonheight) and not mousepressed and nodialog and love.mouse.isDown("l") then
			if scrollclickstart == nil then
				scrollclickstart = love.mouse.getY()
				savedperonetage = peronetage
			end
			
			mousepressed = true
		elseif not love.mouse.isDown("l") and scrollclickstart ~= nil then
			scrollclickstart = nil
			savedperonetage = nil
		end
		
		if scrollclickstart ~= nil then
			newperonetage = savedperonetage + (scrollclickoffset/(height-buttonheight))
		end
		
		love.graphics.rectangle("fill", x, math.min(math.max(y+(height-buttonheight)*(savedperonetage == nil and peronetage or savedperonetage)+scrollclickoffset, y), (y+height)-buttonheight), 16, buttonheight)
	end
	
	love.graphics.setColor(255,255,255,255)
	
	--[[
	if newperonetage ~= nil then
		cons("Returning " .. newperonetage)
	end
	]]
	
	if newperonetage ~= nil then
		return math.min(math.max(newperonetage,0),1)
	end
end


coordsdialog =
{
	active = false,
	input = ""
}
function coordsdialog.draw()
	love.graphics.setColor(64,64,64,128)
	love.graphics.rectangle("fill", (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2, 7*16, 3*16)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setFont(font16)
	love.graphics.print(" " .. coordsdialog.print(), (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2+16+3)
	love.graphics.setFont(font8)
end

function coordsdialog.activate()
	coordsdialog.active = true
	coordsdialog.input = ""
end

function coordsdialog.type(what)
	if tostring(what) == tostring(tonumber(what)) then
		coordsdialog.input = coordsdialog.input .. what
	end
	
	if coordsdialog.input:len() == 4 then
		gotoroom(
			math.min(math.max(tonumber(coordsdialog.input:sub(1,2))-(not s.coords0 and 1 or 0), 0), metadata.mapwidth-1),
			math.min(math.max(tonumber(coordsdialog.input:sub(3,4))-(not s.coords0 and 1 or 0), 0), metadata.mapheight-1)
		)
		
		coordsdialog.active = false
	end
end

function coordsdialog.print()
	-- Ugly, but easy
	if coordsdialog.input:len() == 0 then
		return "__,__"
	elseif coordsdialog.input:len() == 1 then
		return coordsdialog.input .. "_,__"
	elseif coordsdialog.input:len() == 2 then
		return coordsdialog.input .. ",__"
	elseif coordsdialog.input:len() == 3 then
		return coordsdialog.input:sub(1,2) .. "," .. (coordsdialog.input:sub(3,3)) .. "_"
	elseif coordsdialog.input:len() == 4 then
		return coordsdialog.input:sub(1,2) .. "," .. (coordsdialog.input:sub(3,4))
	else
		return coordsdialog.input
	end
end