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

	if not lsuccess then
		love.graphics.setColor(255,128,0)
		love.graphics.printf(langkeys(L.COULDNOTGETCONTENTSLEVELFOLDER, {levelsfolder}), 8, 24, love.graphics.getWidth()-16, "left")
		love.graphics.setColor(255,255,255)
	else
		hoveringlevel = nil
		local hoverarea = 758
		if s.smallerscreen then
			hoverarea = hoverarea - 96
		end
		-- Are we in the root, or is there a subfolder we're supposed to look in?
		local currentdir = ""

		if backupscreen then
			if currentbackupdir == "" then
				love.graphics.print(L.BACKUPS, 8, 8)
				currentdir = ".ved-sys" .. dirsep .. "backups"
			else
				love.graphics.print(langkeys(L.BACKUPSOFLEVEL, {currentbackupdir:sub((".ved-sys/backups"):len()+2, -1)}), 8, 8)
				love.graphics.print(L.LASTMODIFIEDTIME, 18, 16)
				love.graphics.print(L.OVERWRITTENTIME, 388, 16)
				currentdir = currentbackupdir
			end
		else
			if string.find(input .. input_r, dirsep) ~= nil then
				local lastindex = string.find(input .. input_r, dirsep .. "[^" .. dirsep .. "]-$")
				currentdir = (input .. input_r):sub(1, lastindex-1)
			end
		end
		local k2 = 1
		if files[currentdir] ~= nil then
			for k,v in pairs(files[currentdir]) do
				local prefix
				if currentdir == "" then
					prefix = ""
				else
					prefix = currentdir .. dirsep
				end
				local barename = v.name:sub(1, -8)
				if v.isdir then
					barename = v.name
				end
				if input .. input_r == "" or (prefix .. v.name):lower():find("^" .. escapegsub(input .. input_r)) then
					local mouseishovering = nodialog and not mousepressed and mouseon(8, 14+8*k2, hoverarea, 8) and love.mouse.getY() < love.graphics.getHeight()-26

					if mouseishovering then
						hoveringlevel = prefix .. barename
					end
					if mouseishovering or tabselected == k2 then
						love.graphics.setColor(255,255,255,64)
						love.graphics.rectangle("fill", 8, 14+8*k2, hoverarea, 8)
						love.graphics.setColor(255,255,0)
					end

					if v.isdir then
						love.graphics.draw(smallfolder, 8, 14+8*k2)
					end
					if backupscreen and not v.isdir then
						-- Display the dates, we already know what the level is we're looking at.
						love.graphics.print(format_date(v.lastmodified), 18, 16+8*k2)
						love.graphics.print(format_date(v.overwritten), 388, 16+8*k2)
					else
						love.graphics.print(v.name, 18, 16+8*k2) -- y = 16+8*k
					end


					love.graphics.setColor(255,255,255)

					--[[
					if k2 == 1 and love.keyboard.isDown("tab") then
						input = v.name:sub(1, -8)
					end
					]]
					if tabselected == k2 and love.keyboard.isDown("return") and nodialog then
						state6load(prefix .. barename)
					end

					k2 = k2 + 1
				end

				lastk = k
			end
		end

		if tabselected == 0 and (love.keyboard.isDown("up") or (keyboard_eitherIsDown("shift") and love.keyboard.isDown("tab"))) then
			-- Start from the bottom.
			tabselected = k2-1
		elseif tabselected >= k2 then
			tabselected = 1
		end
	end

	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight()-26, love.graphics.getWidth(), 26)
	love.graphics.setColor(255,255,255)

	if not backupscreen then
		love.graphics.print(L.LOADTHISLEVEL .. input .. __, 10, love.graphics.getHeight()-18)
		if nodialog then
			startinputonce()
		end
	end

	if not secondlevel then
		hoverdraw(helpbtn, love.graphics.getWidth()-128+8, 8, 16, 16, 1)
	end
	if not state6old1 then
		hoverdraw(newbtn, love.graphics.getWidth()-32, 0, 32, 32, 2) -- -96
	else
		hoverdraw(retbtn, love.graphics.getWidth()-32, 0, 32, 32, 2)
	end

	if not mousepressed and nodialog and love.mouse.isDown("l") then
		if not secondlevel and mouseon(love.graphics.getWidth()-128+8, 8, 16, 16) then
			tostate(15)
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
		if backupscreen then
			rbutton(L.RETURN, 0, nil, true)
		else
			rbutton(L.BACKUPS, 0, nil, true)
		end

		if s.pcheckforupdates and not opt_disableversioncheck then
			versionchecked = verchannel:peek()
		end

		local unsupportedpluginstext = ""

		if unsupportedplugins > 0 then
			unsupportedpluginstext = "\n\n" .. langkeys(L.NUMUNSUPPORTEDPLUGINS, {unsupportedplugins})
		end

		if not s.pcheckforupdates or opt_disableversioncheck then
			love.graphics.printf(L.VERSIONDISABLED .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 40+120+16+3+8, 128-16, "left")
		elseif versionchecked ~= nil then		
			if versionchecked == "connecterror" or versionchecked == "error" then
				love.graphics.printf(L.VERSIONERROR .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 40+120+16+3+8, 128-16, "left")
			elseif versionchecked == "latest" then
				love.graphics.printf(L.VERSIONUPTODATE .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 40+120+16+3+8, 128-16, "left")
			else
				love.graphics.printf(langkeys(L.VERSIONOLD, {versionchecked}) .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 40+120+16+3+8, 128-16, "left")
				updatebutton = true
			end
		else
			love.graphics.printf(L.VERSIONCHECKING .. unsupportedpluginstext, love.graphics.getWidth()-(128-8), 40+120+16+3+8, 128-16, "left")
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
				languagedialog()
			elseif not mousepressed and onrbutton(6, 40, false, 20) then
				-- Test BUT "SEND FEEDBACK" FOR NOW
				--dialog.new("Auto-creation of a save file for VVVVVV coming soon!", "", 1, 1, 0)
				openurl("http://ved.idea.informer.com/")

				mousepressed = true
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
			end
		elseif oldstate == 13 and mousepressed and love.mouse.isDown("r") and mouseon(love.graphics.getWidth()-(128-8), 40+120, 128-16, 16) then
			-- Not a bug, it's a feature
			allowdebug = true
		end
	end
end