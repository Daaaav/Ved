-- levelslist/draw

return function()
	if state6old1 and editorscreenshot ~= nil then
		-- Print the screenshot we took, use it as a background!
		love.graphics.setColor(128,128,128,128)
		love.graphics.draw(editorscreenshot, 0, 0, 0, s.pscale^-1)
		love.graphics.setColor(255,255,255,255)
	end

	if not backupscreen then
		ved_print(secondlevel and L.DIFFSELECT or L.LEVELSLIST, 8, 8)
	end

	if not lsuccess and not backupscreen then
		love.graphics.setColor(255,128,0)
		font_ui:printf(
			langkeys(L.COULDNOTGETCONTENTSLEVELFOLDER, {levelsfolder}),
			8, 24,
			love.graphics.getWidth()-136,
			font_ui:align_start()
		)
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
				ved_print(L.BACKUPS, 8, 2)
				currentdir = ".ved-sys" .. dirsep .. "backups"
			else
				ved_print(langkeys(L.BACKUPSOFLEVEL, {currentbackupdir:sub((".ved-sys/backups"):len()+2, -1)}), 8, 2)
				ved_print(L.LASTMODIFIEDTIME, 66, 13)
				ved_print(L.OVERWRITTENTIME, 408, 13)
				currentdir = currentbackupdir
			end
		else
			if inputs.levelname:find(dirsep) ~= nil then
				local lastindex = inputs.levelname:find(dirsep .. "[^" .. dirsep .. "]-$")
				currentdir = (inputs.levelname):sub(1, lastindex-1)
			end
		end
		local lessheight = 48
		local width = 50
		if s.psmallerscreen then
			width = width-12
		end
		if #s.recentfiles > 0 and currentdir == "" and inputs.levelname == "" then
			lessheight = lessheight + 16 + #s.recentfiles*12
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
			ved_print(L.RECENTLYOPENED, 18, love.graphics.getHeight()-(lessheight-23)+8)
			love.graphics.setScissor(8, love.graphics.getHeight()-(lessheight-23)+12, hoverarea, lessheight-48-12)

			local removerecent
			for k,v in pairs(s.recentfiles) do
				local mouseishovering = nodialog and not mousepressed and mouseon(8, love.graphics.getHeight()-(lessheight-23)+4+12*k, hoverarea, 12) and window_active()
				if mouseishovering then
					hoveringlevel = v
					hoveringlevel_k = (-#s.recentfiles)+(k-1)
				end
				if mouseishovering or tabselected == (-#s.recentfiles)+(k-1) then
					love.graphics.setColor(255,255,255,64)
					love.graphics.rectangle("fill", 8, love.graphics.getHeight()-(lessheight-23)+4+12*k, hoverarea, 12)
					love.graphics.setColor(255,255,0)
				end
				display_levels_list_string(
					displayable_filename(v) .. ".vvvvvv",
					18, love.graphics.getHeight()-(lessheight-23)+4+12*k+2,
					(-#s.recentfiles)+(k-1), width, current_scrolling_levelfilename_k, current_scrolling_levelfilename_pos
				)

				local actualfile = recentmetadata_files[v]
				if actualfile ~= nil and files[currentdir][actualfile] ~= nil and files[currentdir][actualfile].metadata ~= nil then
					local md = files[currentdir][actualfile].metadata
					if not md.success then
						theming:draw(image.smallunknown, 8, love.graphics.getHeight()-(lessheight-25)+4+12*k+2)
					else
						if not (mouseishovering or tabselected == (-#s.recentfiles)+(k-1)) then
							love.graphics.setColor(128,128,128)
						end
						display_levels_list_string(
							md.Title,
							metadatax, love.graphics.getHeight()-(lessheight-23)+4+12*k+2,
							(-#s.recentfiles)+(k-1), 21, current_scrolling_leveltitle_k, current_scrolling_leveltitle_pos
						)
					end
				end

				local lastmodified = metadata_lastmodified[v .. ".vvvvvv"]
				if lastmodified ~= nil then
					if not (mouseishovering or tabselected == k2) then
						love.graphics.setColor(128,128,128)
					end
					ved_print(format_date(lastmodified), lastmodifiedx, love.graphics.getHeight()-(lessheight-23)+4+12*k+2)
				end

				love.graphics.setColor(255,255,255)

				if tabselected == (-#s.recentfiles)+(k-1) and nodialog then
					if love.keyboard.isDown("return", "kpenter") and not returnpressed then
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
				if backupscreen or v.result_shown then
					if 16+12*k2+levellistscroll > -64 and 16+12*k2+levellistscroll < love.graphics.getHeight()+64 then
						local mouseishovering = nodialog and not mousepressed and mouseon(8, 10+12*k2+levellistscroll, hoverarea, 12) and mousein(0, 22, love.graphics.getWidth(), love.graphics.getHeight()-lessheight+21) and window_active()

						if mouseishovering then
							local trailingdirsep = ""
							if v.isdir then
								trailingdirsep = dirsep
							end
							hoveringlevel = prefix .. barename .. trailingdirsep
							hoveringlevel_k = k
							hoveringlevel_k_location = k2
						end

						if mouseishovering or tabselected == k2 then
							love.graphics.setColor(255,255,255,64)
							love.graphics.rectangle("fill", 8, 10+12*k2+levellistscroll, hoverarea, 12)
							love.graphics.setColor(255,255,0)
						end

						if v.isdir then
							theming:draw(image.smallfolder, 8, 10+12*k2+levellistscroll+2)
						end
						if backupscreen and not v.isdir then
							if v.bu_overwritten == 0 then
								-- This is kind of a weird place for that file.
								theming:draw(image.smallunknown, 8, 10+12*k2+levellistscroll+2)
								ved_print(displayable_filename(v.name), 18, 10+12*k2+levellistscroll+2)
							else
								-- Display the dates, we already know what the level is we're looking at.
								ved_print("[" .. k .. "]", 18, 10+12*k2+levellistscroll+2)
								ved_print(format_date(v.bu_lastmodified), 66, 10+12*k2+levellistscroll+2)
								ved_print(format_date(v.bu_overwritten), 408, 10+12*k2+levellistscroll+2)
							end
						else
							display_levels_list_string(
								displayable_filename(v.name),
								18, 10+12*k2+levellistscroll+2,
								k, width, current_scrolling_levelfilename_k, current_scrolling_levelfilename_pos
							)

							if v.metadata ~= nil then
								if not v.metadata.success then
									theming:draw(image.smallunknown, 8, 10+12*k2+levellistscroll+2)
								else
									if not (mouseishovering or tabselected == k2) then
										love.graphics.setColor(128,128,128)
									end
									display_levels_list_string(
										v.metadata.Title,
										metadatax, 10+12*k2+levellistscroll+2,
										k, 21, current_scrolling_leveltitle_k, current_scrolling_leveltitle_pos
									)
								end
							end

							if not (mouseishovering or tabselected == k2) then
								love.graphics.setColor(128,128,128)
							end
							ved_print(format_date(v.lastmodified), lastmodifiedx, 10+12*k2+levellistscroll+2)
						end


						love.graphics.setColor(255,255,255)
					end

					if tabselected == k2 then
						tabselected_k = k

						if love.keyboard.isDown("return", "kpenter") and nodialog and not returnpressed then
							local trailingdirsep = ""
							if v.isdir then
								trailingdirsep = dirsep
							end
							state6load(prefix .. barename .. trailingdirsep)
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
							topy = love.graphics.getHeight()-(lessheight-23)+16+12*(#s.recentfiles+preferred_k+1)
						end
					end
				elseif files[currentdir][preferred_k] ~= nil and files[currentdir][preferred_k].metadata ~= nil then
					md = files[currentdir][preferred_k].metadata
					topy = 22+12*preferred_k_location+levellistscroll
				end
				if preferred_k < 0 then
					filename = anythingbutnil(s.recentfiles[#s.recentfiles+preferred_k+1]) .. ".vvvvvv"
				else
					filename = anythingbutnil(anythingbutnil(files[currentdir][preferred_k]).name)
				end
				if preferred_k ~= current_scrolling_levelfilename_k then
					if font8:getWidth(displayable_filename(filename)) > width*8 then
						current_scrolling_levelfilename_k = preferred_k
						current_scrolling_levelfilename_filename = displayable_filename(filename)
					else
						current_scrolling_levelfilename_k = nil
					end
					current_scrolling_levelfilename_pos = width*8
				end
				if md ~= nil then
					if topy+48 > love.graphics.getHeight() then
						topy = topy-56
					end
					love.graphics.setColor(73,73,73,224)
					love.graphics.rectangle("fill", metadatax, topy, 40*8, 6*8)
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
						ved_print(L.OPTBY .. " " .. anythingbutnil(md.Creator), metadatax, topy)
						ved_printf(anythingbutnil(md.mapwidth) .. L.X .. anythingbutnil(md.mapheight), metadatax, topy, 40*8, "right")
						ved_print(anythingbutnil(md.website), metadatax, topy+8)
						ved_print(anythingbutnil(md.Desc1), metadatax, topy+24)
						ved_print(anythingbutnil(md.Desc2), metadatax, topy+32)
						ved_print(anythingbutnil(md.Desc3), metadatax, topy+40)
					else
						ved_printf(anythingbutnil(md.errmsg), metadatax, topy, 40*8, "left")
					end
				end
			else
				-- If we're not looking at any metadata, no title should scroll
				current_scrolling_leveltitle_k = nil
				current_scrolling_levelfilename_k = nil
			end
		end

		-- Scrollbar
		if max_levellistscroll ~= (k2-1)*12 then
			levellistscroll = 0
			max_levellistscroll = (k2-1)*12
		end
		local newfraction = scrollbar(16+hoverarea, 22, love.graphics.getHeight()-lessheight, max_levellistscroll, (-levellistscroll)/(max_levellistscroll-(love.graphics.getHeight()-lessheight)))

		if newfraction ~= nil then
			levellistscroll = -(newfraction*(max_levellistscroll-(love.graphics.getHeight()-lessheight)))
		end

		if ((love.keyboard.isDown("up") or (keyboard_eitherIsDown("shift") and love.keyboard.isDown("tab"))) and nodialog) then
			if tabselected == 0 and #s.recentfiles > 0 and currentdir == "" and inputs.levelname == "" then
				tabselected = -1
			elseif tabselected == 0 or tabselected < -#s.recentfiles then
				-- Start from the bottom.
				tabselected = k2-1
			end
		elseif tabselected >= k2 then
			if #s.recentfiles > 0 and currentdir == "" and inputs.levelname == "" then
				tabselected = -#s.recentfiles
			else
				tabselected = 1
			end
		end
	end

	if not backupscreen then
		local x_label, x_input = 10, 10
		if font_ui:is_rtl() then
			x_label = font_ui:getWidth(inputs.levelname) + 18 + 5
			if inputs.levelname ~= "" then
				love.graphics.setColor(255,255,255,48)
			end
		else
			x_input = font_ui:getWidth(L.LOADTHISLEVEL) + 18
		end
		font_ui:print(L.LOADTHISLEVEL, x_label, love.graphics.getHeight()-20)
		love.graphics.setColor(255,255,255,255)
		newinputsys.print("levelname", x_input, love.graphics.getHeight()-20)
	end

	if not secondlevel then
		hoverdraw(image.helpbtn, love.graphics.getWidth()-128+8, 8, 16, 16, 1)
		hoverdraw(image.refreshbtn, love.graphics.getWidth()-128+8+16, 8, 16, 16, 1)

		showhotkey("q", love.graphics.getWidth()-128+8+8-2, 16)
		showhotkey("t", love.graphics.getWidth()-128+8+16+8-2, 16)
	end
	if not state6old1 then
		hoverdraw(image.newbtn_hq, love.graphics.getWidth()-32, 0, 32, 32) -- -96
		showhotkey("cN", love.graphics.getWidth()-32-2, 32-8)
	else
		hoverdraw(image.retbtn_hq, love.graphics.getWidth()-32, 0, 32, 32)
		showhotkey("b", love.graphics.getWidth()-32-2, 32-8)
	end

	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if not secondlevel and mouseon(love.graphics.getWidth()-128+8, 8, 16, 16) then
			-- Help
			tostate(15)
			mousepressed = true
		elseif not secondlevel and mouseon(love.graphics.getWidth()-128+8+16, 8, 16, 16) then
			-- Refresh
			loadlevelsfolder()
			mousepressed = true
		elseif mouseon(love.graphics.getWidth()-32, 0, 32, 32) then -- -96
			if not state6old1 then
				-- New
				levelslist_close_input()
				triggernewlevel()
				-- Make sure we don't immediately click the next button
				nodialog = false
				mousepressed = true
			else
				-- Return to editor.
				levelslist_close_input()
				tostate(1, true)
				mousepressed = true
			end
		end
	end

	if not secondlevel then
		rbutton(L.VEDOPTIONS, 0, 40)
		rbutton(L.PLUGINS, 1, 40, nil, nil, unsupportedplugins > 0)
		rbutton(L.LANGUAGE, 2, 40)
		rbutton(L.SENDFEEDBACK, 6, 40, false, 20)
		if updatecheck.notes_available then
			rbutton(L.MOREINFO, 11, 40, false, 20)
		elseif not s.pcheckforupdates or updatecheck.check_error then
			rbutton(L.VERSIONCHECKNOW, 11, 40, false, 20)
		end
		if updatecheck.scrolling_text ~= nil then
			love.graphics.setScissor(love.graphics.getWidth()-120, 288, 112, 16)
			ved_print(updatecheck.scrolling_text, love.graphics.getWidth()-8-math.floor(updatecheck.scrolling_text_pos), 288+4)
			love.graphics.setScissor()
		end
		if backupscreen then
			rbutton(L.RETURN, 0, nil, true)
		else
			rbutton(L.BACKUPS, 0, nil, true)
			rbutton({L.OPENLEVELSFOLDER, "cF"}, 1, nil, true)
			rbutton({L.ASSETS, "cR"}, 2, nil, true)
		end

		if intermediate_version then
			love.graphics.setColor(255,128,0)
		end

		font_ui:printf(
			updatecheck.get_status(),
			love.graphics.getWidth()-(128-8), 215,
			128-16,
			font_ui:align_start()
		)
		if intermediate_version then
			love.graphics.setColor(255,255,255)
		end

		if not mousepressed and nodialog and love.mouse.isDown("l") then
			if onrbutton(0, 40) then
				-- Ved options
				tostate(13)

				mousepressed = true
			elseif onrbutton(1, 40) then
				-- Plugins
				tostate(15, nil, "plugins")
			elseif onrbutton(2, 40) then
				-- Language
				tostate(33)
			elseif not mousepressed and onrbutton(6, 40, false, 20) then
				-- Test BUT "SEND FEEDBACK" FOR NOW
				love.system.openURL("https://tolp.nl/ved/feedback")

				mousepressed = true
			elseif not mousepressed and onrbutton(11, 40, false, 20) then
				-- Update notes and such
				if updatecheck.notes_available then
					tostate(15, nil, {updatecheck.notes, false, updatecheck.notes_refreshable})
				elseif not s.pcheckforupdates or updatecheck.check_error then
					s.pcheckforupdates = true
					updatecheck.start_check()
				end
				mousepressed = true
			elseif not mousepressed and onrbutton(0, nil, true) then
				-- Backups/return
				if backupscreen and currentbackupdir ~= "" then
					currentbackupdir = ""
				else
					backupscreen = not backupscreen
					if backupscreen then
						currentbackupdir = ""
						newinputsys.pause()
					else
						newinputsys.resume()
					end
				end
				mousepressed = true
			-- See love.mousereleased for this
			--elseif not mousepressed and onrbutton(1, nil, true) and not backupscreen then
				--explore_lvl_dir()
				--mousepressed = true
			elseif not mousepressed and onrbutton(2, nil, true) and not backupscreen then
				-- Assets
				tostate(30)
				mousepressed = true
			end
		elseif oldstate == 13 and mousepressed and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), 40+120, 128-16, 16) then
			-- Not a bug, it's a feature
			allowdebug = true
		end
	end
end
