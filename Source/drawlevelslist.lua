function drawlevelslist()
	if state6old1 and editorscreenshot ~= nil then
		-- Print the screenshot we took, use it as a background!
		love.graphics.setColor(128,128,128,128)
		love.graphics.draw(editorscreenshot, 0, 0, 0, s.pscale^-1)
		love.graphics.setColor(255,255,255,255)
	end

	if not backupscreen then
		love.graphics.print(secondlevel and L.DIFFSELECT or L.LEVELSLIST, 8, 8)
	end

	if not lsuccess and not backupscreen then
		love.graphics.setColor(255,128,0)
		love.graphics.printf(langkeys(L.COULDNOTGETCONTENTSLEVELFOLDER, {levelsfolder}), 8, 24, love.graphics.getWidth()-136, "left")
		love.graphics.setColor(255,255,255)
	else
		hoveringlevel = nil
		hoveringlevel_k = nil
		hoveringlevel_k_location = nil
		tabselected_k = tabselected
		local hoverarea = 734
		local metadatax = 422
		local lastmodifiedx = 598
		if s.psmallerscreen then
			hoverarea = hoverarea - 96
			metadatax = metadatax - 96
			lastmodifiedx = lastmodifiedx - 96
		end
		-- Are we in the root, or is there a subfolder we're supposed to look in?
		local currentdir = ""

		if backupscreen then
			if currentbackupdir == "" then
				love.graphics.print(L.BACKUPS, 8, 4)
				currentdir = ".ved-sys" .. dirsep .. "backups"
			else
				love.graphics.print(langkeys(L.BACKUPSOFLEVEL, {currentbackupdir:sub((".ved-sys/backups"):len()+2, -1)}), 8, 4)
				love.graphics.print(L.LASTMODIFIEDTIME, 66, 15)
				love.graphics.print(L.OVERWRITTENTIME, 408, 15)
				currentdir = currentbackupdir
			end
		else
			if string.find(input .. input_r, dirsep) ~= nil then
				local lastindex = string.find(input .. input_r, dirsep .. "[^" .. dirsep .. "]-$")
				currentdir = (input .. input_r):sub(1, lastindex-1)
			end
		end
		local lessheight = 48
		if #s.recentfiles > 0 and currentdir == "" and input == "" and input_r == "" then
			lessheight = lessheight + 16 + #s.recentfiles*8
			love.graphics.setColor(64,64,64)
			--love.graphics.rectangle("line", 7.5, love.graphics.getHeight()-lessheight+34.5, hoverarea+1, lessheight-59)
			--love.graphics.setColor(255,0,0)
			love.graphics.line(
				13.5, love.graphics.getHeight()-lessheight+34.5,
				7.5, love.graphics.getHeight()-lessheight+34.5,
				7.5, love.graphics.getHeight()-24.5,
				8.5+hoverarea, love.graphics.getHeight()-24.5,
				8.5+hoverarea, love.graphics.getHeight()-lessheight+34.5,
				20.5+font8:getWidth(L.RECENTLYOPENED), love.graphics.getHeight()-lessheight+34.5
			)
			love.graphics.setColor(255,255,255)
			love.graphics.print(L.RECENTLYOPENED, 18, love.graphics.getHeight()-(lessheight-25)+8)
			love.graphics.setScissor(8, love.graphics.getHeight()-(lessheight-23)+12, hoverarea, lessheight-48-12)

			local removerecent
			for k,v in pairs(s.recentfiles) do
				local mouseishovering = nodialog and not mousepressed and mouseon(8, love.graphics.getHeight()-(lessheight-23)+8+8*k, hoverarea, 8)
				if mouseishovering then
					hoveringlevel = v
					hoveringlevel_k = (-#s.recentfiles)+(k-1)
				end
				if mouseishovering or tabselected == (-#s.recentfiles)+(k-1) then
					love.graphics.setColor(255,255,255,64)
					love.graphics.rectangle("fill", 8, love.graphics.getHeight()-(lessheight-23)+8+8*k, hoverarea, 8)
					love.graphics.setColor(255,255,0)
				end
				display_levels_list_filename(displayable_filename(v) .. ".vvvvvv", 18, love.graphics.getHeight()-(lessheight-25)+8+8*k, (-#s.recentfiles)+(k-1))

				local actualfile = recentmetadata_files[v]
				if actualfile ~= nil and files[currentdir][actualfile] ~= nil and files[currentdir][actualfile].metadata ~= nil then
					local md = files[currentdir][actualfile].metadata
					if not md.success then
						love.graphics.draw(smallunknown, 8, love.graphics.getHeight()-(lessheight-25)+8+8*k)
					else
						if not (mouseishovering or tabselected == (-#s.recentfiles)+(k-1)) then
							love.graphics.setColor(128,128,128)
						end
						display_levels_list_title(md.Title, metadatax, love.graphics.getHeight()-(lessheight-25)+8+8*k, (-#s.recentfiles)+(k-1))
					end
				end

				local lastmodified = metadata_lastmodified[v .. ".vvvvvv"]
				if lastmodified ~= nil then
					if not (mouseishovering or tabselected == k2) then
						love.graphics.setColor(128,128,128)
					end
					love.graphics.print(format_date(lastmodified), lastmodifiedx, love.graphics.getHeight()-(lessheight-25)+8+8*k)
				end

				love.graphics.setColor(255,255,255)

				if tabselected == (-#s.recentfiles)+(k-1) and nodialog then
					if love.keyboard.isDown("return") and not returnpressed then
						state6load(v)
						return
					elseif love.keyboard.isDown("delete") then
						removerecent = k
					end
				end
			end
			if removerecent ~= nil then
				table.remove(s.recentfiles, removerecent)
				tabselected = 0
				saveconfig()
			end

			love.graphics.setScissor()
		end
		local k2 = 1
		if files[currentdir] ~= nil then
			love.graphics.setScissor(0, 22, love.graphics.getWidth()-128, love.graphics.getHeight()-lessheight)
			local prefix
			if currentdir == "" then
				prefix = ""
			else
				prefix = currentdir .. dirsep
			end
			search_levels_list(currentdir, prefix)
			for k,v in pairs(files[currentdir]) do
				local barename = v.name:sub(1, -8)
				if v.isdir then
					barename = v.name
				end
				if s.loadallmetadata and not metadataloaded_folders[currentdir] and not v.isdir and not backupscreen then
					-- Request all the metadata for this level (It's not disabled if we're here)
					allmetadata_inchannel:push(
						{
							path = prefix .. v.name,
							dir = currentdir,
							id = k,
							refresh = levels_refresh
						}
					)
				end
				--if backupscreen or (input == "" and input_r == "") or (prefix .. v.name):lower():find("^" .. escapegsub(input .. input_r)) then
				--if backupscreen or (input == "" and input_r == "") or (prefix .. v.name):lower():sub(1, (input .. input_r):len()) == input .. input_r then
				if backupscreen or v.result_shown then
					if 16+8*k2+levellistscroll > -64 and 16+8*k2+levellistscroll < love.graphics.getHeight()+64 then
						local mouseishovering = nodialog and not mousepressed and mouseon(8, 14+8*k2+levellistscroll, hoverarea, 8) and mousein(0, 22, love.graphics.getWidth(), love.graphics.getHeight()-lessheight+21)

						if mouseishovering then
							hoveringlevel = prefix .. barename
							hoveringlevel_k = k
							hoveringlevel_k_location = k2
						end

						if mouseishovering or tabselected == k2 then
							love.graphics.setColor(255,255,255,64)
							love.graphics.rectangle("fill", 8, 14+8*k2+levellistscroll, hoverarea, 8)
							love.graphics.setColor(255,255,0)
						end

						if v.isdir then
							love.graphics.draw(smallfolder, 8, 14+8*k2+levellistscroll)
						end
						if backupscreen and not v.isdir then
							if v.bu_overwritten == 0 then
								-- This is kind of a weird place for that file.
								love.graphics.draw(smallunknown, 8, 14+8*k2+levellistscroll)
								love.graphics.print(displayable_filename(v.name), 18, 16+8*k2+levellistscroll)
							else
								-- Display the dates, we already know what the level is we're looking at.
								love.graphics.print("[" .. k .. "]", 18, 16+8*k2+levellistscroll)
								love.graphics.print(format_date(v.bu_lastmodified), 66, 16+8*k2+levellistscroll)
								love.graphics.print(format_date(v.bu_overwritten), 408, 16+8*k2+levellistscroll)
							end
						else
							display_levels_list_filename(v.name, 18, 16+8*k2+levellistscroll, k)

							if v.metadata ~= nil then
								if not v.metadata.success then
									love.graphics.draw(smallunknown, 8, 14+8*k2+levellistscroll)
								else
									if not (mouseishovering or tabselected == k2) then
										love.graphics.setColor(128,128,128)
									end
									display_levels_list_title(v.metadata.Title, metadatax, 16+8*k2+levellistscroll, k)
								end
							end

							if not (mouseishovering or tabselected == k2) then
								love.graphics.setColor(128,128,128)
							end
							love.graphics.print(format_date(v.lastmodified), lastmodifiedx, 16+8*k2+levellistscroll)
						end


						love.graphics.setColor(255,255,255)
					end

					--[[
					if k2 == 1 and love.keyboard.isDown("tab") then
						input = v.name:sub(1, -8)
					end
					]]
					if tabselected == k2 then
						tabselected_k = k

						if love.keyboard.isDown("return") and nodialog and not returnpressed then
							state6load(prefix .. barename)
							return
						end
					end

					k2 = k2 + 1
				end

				lastk = k
			end
			love.graphics.setScissor()
			if s.loadallmetadata and not metadataloaded_folders[currentdir] then
				metadataloaded_folders[currentdir] = true
			end

			-- Draw level metadata
			local preferred_k, preferred_k_location, md, topy, filename
			if hoveringlevel_k ~= nil then
				preferred_k = hoveringlevel_k
				preferred_k_location = hoveringlevel_k_location
			elseif tabselected ~= nil then
				preferred_k = tabselected_k
				preferred_k_location = tabselected
			end
			if preferred_k ~= nil and preferred_k ~= 0 then
				if preferred_k < 0 then
					local recentname = s.recentfiles[#s.recentfiles+preferred_k+1]
					-- No "falsy" nonsense here, I only want the real "false"
					if recentmetadata_files[recentname] ~= false then
						if recentmetadata_files[recentname] == nil then
							-- Wasn't found, apparently
						elseif files[currentdir][recentmetadata_files[recentname]] ~= nil and files[currentdir][recentmetadata_files[recentname]].metadata ~= nil then
							md = files[currentdir][recentmetadata_files[recentname]].metadata
							topy = love.graphics.getHeight()-(lessheight-25)+16+8*(#s.recentfiles+preferred_k+1)
						end
					end
				elseif files[currentdir][preferred_k] ~= nil and files[currentdir][preferred_k].metadata ~= nil then
					md = files[currentdir][preferred_k].metadata
					topy = 24+8*preferred_k_location+levellistscroll
				end
				if preferred_k < 0 then
					filename = s.recentfiles[#s.recentfiles+preferred_k+1] .. ".vvvvvv"
				else
					filename = files[currentdir][preferred_k].name
				end
				if preferred_k ~= current_scrolling_levelfilename_k then
					if font8:getWidth(displayable_filename(filename)) > 50*8 then
						current_scrolling_levelfilename_k = preferred_k
						current_scrolling_levelfilename_filename = displayable_filename(filename)
					else
						current_scrolling_levelfilename_k = nil
					end
					current_scrolling_levelfilename_pos = 400
				end
				if md ~= nil then
					if topy+48 > love.graphics.getHeight() then
						topy = topy-56
					end
					love.graphics.setColor(73,73,73,224)
					love.graphics.rectangle("fill", metadatax, topy-2, 40*8, 6*8)
					love.graphics.setColor(255,255,255,255)
					if md.success then
						if preferred_k ~= current_scrolling_leveltitle_k then
							if font8:getWidth(anythingbutnil(md.Title)) > 21*8 then
								current_scrolling_leveltitle_k = preferred_k
								current_scrolling_leveltitle_title = md.Title
							else
								-- Reposition whatever was scrolling
								current_scrolling_leveltitle_k = nil
							end
							current_scrolling_leveltitle_pos= 168
						end
						love.graphics.print(L.OPTBY .. " " .. anythingbutnil(md.Creator), metadatax, topy)
						love.graphics.printf(anythingbutnil(md.mapwidth) .. L.X .. anythingbutnil(md.mapheight), metadatax, topy, 40*8, "right")
						love.graphics.print(anythingbutnil(md.website), metadatax, topy+8)
						love.graphics.print(anythingbutnil(md.Desc1), metadatax, topy+24)
						love.graphics.print(anythingbutnil(md.Desc2), metadatax, topy+32)
						love.graphics.print(anythingbutnil(md.Desc3), metadatax, topy+40)
					else
						love.graphics.printf(anythingbutnil(md.errmsg), metadatax, topy, 40*8, "left")
					end
				end
			elseif current_scrolling_leveltitle_k ~= nil or current_scrolling_levelfilename_k ~= nil then
				-- If we're not looking at any metadata, no title should scroll
				if current_scrolling_leveltitle_k ~= nil then
					current_scrolling_leveltitle_k = nil
				elseif current_scrolling_levelfilename_k ~= nil then
					current_scrolling_levelfilename_k = nil
				end
			end
		end

		-- Scrollbar
		if max_levellistscroll ~= (k2-1)*8 then
			levellistscroll = 0
			max_levellistscroll = (k2-1)*8
		end
		local newperonetage = scrollbar(16+hoverarea, 22, love.graphics.getHeight()-lessheight, max_levellistscroll, (-levellistscroll)/(max_levellistscroll-(love.graphics.getHeight()-lessheight)))

		if newperonetage ~= nil then
			levellistscroll = -(newperonetage*(max_levellistscroll-(love.graphics.getHeight()-lessheight)))
		end

		if (love.keyboard.isDown("up") or (keyboard_eitherIsDown("shift") and love.keyboard.isDown("tab")) and nodialog) then
			if tabselected == 0 and #s.recentfiles > 0 and currentdir == "" and input == "" and input_r == "" then
				tabselected = -1
			elseif tabselected == 0 or tabselected < -#s.recentfiles then
				-- Start from the bottom.
				tabselected = k2-1
			end
		elseif tabselected >= k2 then
			if #s.recentfiles > 0 and currentdir == "" and input == "" and input_r == "" then
				tabselected = -#s.recentfiles
			else
				tabselected = 1
			end
		end
	end

	if not backupscreen then
		love.graphics.print(L.LOADTHISLEVEL .. input .. __, 10, love.graphics.getHeight()-18)
		if nodialog then
			startinputonce()
		end
	end

	if not secondlevel then
		hoverdraw(helpbtn, love.graphics.getWidth()-128+8, 8, 16, 16, 1)
		hoverdraw(refreshbtn, love.graphics.getWidth()-128+8+16, 8, 16, 16, 1)

		showhotkey("q", love.graphics.getWidth()-128+8+8-2, 16)
		showhotkey("t", love.graphics.getWidth()-128+8+16+8-2, 16)
	end
	if not state6old1 then
		hoverdraw(newbtn, love.graphics.getWidth()-32, 0, 32, 32, 2) -- -96
		showhotkey("cN", love.graphics.getWidth()-32-2, 32-8)
	else
		hoverdraw(retbtn, love.graphics.getWidth()-32, 0, 32, 32, 2)
		showhotkey("b", love.graphics.getWidth()-32-2, 32-8)
	end

	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if not secondlevel and mouseon(love.graphics.getWidth()-128+8, 8, 16, 16) then
			-- Help
			stopinput()
			tostate(15)
			mousepressed = true
		elseif not secondlevel and mouseon(love.graphics.getWidth()-128+8+16, 8, 16, 16) then
			-- Refresh
			loadlevelsfolder()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-32, 0, 32, 32) then -- -96
			if not state6old1 then
				-- New
				stopinput()
				triggernewlevel()
				-- Make sure we don't immediately click the next button
				nodialog = false
				mousepressed = true
			else
				-- Return to editor.
				stopinput()
				tostate(1, true)
				mousepressed = true
			end
		end
	end

	--love.graphics.print("Levels folder error: " .. lerror .. " (0 means no error)", 8, 16+8*lastk+16)
	--love.graphics.print("Levels folder: " .. anythingbutnil(levelsfolder), 8, 16+8*lastk+24)

	if not secondlevel then
		rbutton(L.VEDOPTIONS, 0, 40)
		rbutton(L.PLUGINS, 1, 40)
		rbutton(L.LANGUAGE, 2, 40)
		rbutton(L.SENDFEEDBACK, 6, 40, false, 20)
		if updatenotesavailable then
			rbutton(L.MOREINFO, 11, 40, false, 20)
		end
		if updatescrollingtext ~= nil then
			love.graphics.setScissor(love.graphics.getWidth()-120, 288, 112, 16)
			love.graphics.print(updatescrollingtext, love.graphics.getWidth()-8-math.floor(updatescrollingtext_pos), 288+6)
			love.graphics.setScissor()
		end
		if backupscreen then
			rbutton(L.RETURN, 0, nil, true)
		else
			rbutton(L.BACKUPS, 0, nil, true)
			rbutton({L.OPENLEVELSFOLDER, "cD"}, 1, nil, true)
			rbutton({L.ASSETS, "cA"}, 2, nil, true)
		end

		if s.pcheckforupdates and not opt_disableversioncheck then
			versionchecked = verchannel:peek()
		end

		local unsupportedpluginstext = ""

		if unsupportedplugins > 0 then
			unsupportedpluginstext = "\n\n" .. langkeys(L_PLU.NUMUNSUPPORTEDPLUGINS, {unsupportedplugins})
		end

		if intermediate_version then
			love.graphics.setColor(255,128,0)
		end
		if not s.pcheckforupdates or opt_disableversioncheck then
			love.graphics.printf(L.VERSIONDISABLED .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 217, 128-16, "left") -- 40+120+16+3+8+30 = 217
		elseif versionchecked ~= nil then		
			if versionchecked == "connecterror" or versionchecked == "error" then
				love.graphics.printf(L.VERSIONERROR .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 217, 128-16, "left")
			else
				if updateversion == nil then
					updateversion = ""
					local currentarticle = 1
					local currentarticlename = nil
					local currentarticlecontents
					local articlelines = explode("\n", versionchecked)
					for k, v in pairs(articlelines) do
						if v:sub(1,3) == "!>>" then
							currentarticlename = v:sub(4,-1)
							if (currentarticlename:sub(1,1) ~= "_" or allowdebug) then
								if currentarticle == 1 then
									updatenotesavailable = true
								else
									updatenotes[currentarticle].cont = table.concat(currentarticlecontents, "\n")
								end
								currentarticlecontents = {}
								currentarticle = currentarticle + 1
								updatenotes[currentarticle] = {subj = currentarticlename, imgs = {}, cont = nil}
							end
						else
							if currentarticlename == "_VERSION" then
								updateversion = updateversion .. v
							elseif currentarticlename == "_SHOWREFRESH" and v == "1" then
								updatenotesrefreshable = true
							elseif currentarticlename == "_SCROLLINGTEXT" then
								updatescrollingtext = unxmlspecialchars(v)
							end
							if currentarticle ~= nil and (currentarticlename:sub(1,1) ~= "_" or allowdebug) then
								table.insert(currentarticlecontents, v)
							end
						end
					end
					if currentarticle ~= 1 then
						updatenotes[currentarticle].cont = table.concat(currentarticlecontents, "\n")
					end
				end
				if updateversion == "latest" then
					love.graphics.printf(L.VERSIONUPTODATE .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 217, 128-16, "left")
				else
					love.graphics.printf(langkeys(L.VERSIONOLD, {updateversion}) .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 217, 128-16, "left")
					updatebutton = true
				end
			end
		else
			love.graphics.printf(L.VERSIONCHECKING .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 217, 128-16, "left")
		end
		if intermediate_version then
			love.graphics.setColor(255,255,255)
		end

		if not mousepressed and nodialog and love.mouse.isDown("l") then
			if onrbutton(0, 40) then
				-- Ved options
				stopinput()
				tostate(13)

				mousepressed = true
			elseif onrbutton(1, 40) then
				-- Plugins
				stopinput()
				tostate(15, nil, "plugins")
			elseif onrbutton(2, 40) then
				-- Language
				languagedialog()
			elseif not mousepressed and onrbutton(6, 40, false, 20) then
				-- Test BUT "SEND FEEDBACK" FOR NOW
				love.system.openURL("https://tolp.nl/ved/feedback")

				mousepressed = true
			elseif updatenotesavailable and not mousepressed and onrbutton(11, 40, false, 20) then
				-- Update notes and such
				stopinput()
				tostate(15, nil, {updatenotes, false, updatenotesrefreshable})
			elseif not mousepressed and onrbutton(0, nil, true) then
				-- Backups/return
				if backupscreen and currentbackupdir ~= "" then
					currentbackupdir = ""
				else
					backupscreen = not backupscreen
					if backupscreen then
						input, input_r = "", ""
						currentbackupdir = ""
						stopinput()
					end
				end
				mousepressed = true
			-- See love.mousereleased for this
			--elseif not mousepressed and onrbutton(1, nil, true) and not backupscreen then
				--explore_lvl_dir()
				--mousepressed = true
			elseif not mousepressed and onrbutton(2, nil, true) and not backupscreen then
				-- Assets
				stopinput()
				tostate(30)
				mousepressed = true
			end
		elseif oldstate == 13 and mousepressed and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), 40+120, 128-16, 16) then
			-- Not a bug, it's a feature
			allowdebug = true
		end
	end
end
