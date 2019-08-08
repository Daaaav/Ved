function drawhelp()
	-- Leaving room for a 16 px wide scrollbar. 4+16+8

	local screenxoffset = 0
	if s.psmallerscreen then
		screenxoffset = -96
	end

	local linee = 0

	if helppages[helparticle] ~= nil then
		-- ...
		--sis = explode("\n", helppages[helparticle].cont)

		--for s in string.gmatch(LH[helparticle].cont, ".*\n") do
		-- 8+200+8+...-2: 214, 8+200+8-4: 212
		love.graphics.setScissor(214+screenxoffset, 8, love.graphics.getWidth()-214-screenxoffset, love.graphics.getHeight()-16)
		love.graphics.setColor(192,192,192,255)

		local lastheaderwidth = 82
		local hoveringlink = nil

		for k,s in pairs(helparticlecontent) do
			if helparticlescroll+14+(10*linee) < -1024 or helparticlescroll+14+(10*linee) > 480 then
				-- Don't render
			elseif helpeditingline == k then
				love.graphics.print(s .. __, 8+200+8+screenxoffset, helparticlescroll+8+(10*linee)+4+2)
			elseif s:find("\\") then
				local imageshift = 0
				local imagex = 0

				local rowcolors = {}
				backgroundshift = false
				local rowlinkmodes = {}

				local doublesize = false -- Only used for background colors, the font is just set

				local singlecharmode = false
				local bgexpandmode = false

				local part1, part2 = s:match("(.*)\\(.*)")

				for fl = 1, part2:len() do
					if part2:sub(fl,fl) == "h" then
						love.graphics.setFont(font16)
						doublesize = true
					elseif part2:sub(fl,fl) == "#" then

					elseif tonumber(part2:sub(fl,fl)) ~= nil then
						local dodisplay = true

						if helpimages[helparticle .. "_" .. (imageshift+tonumber(part2:sub(fl,fl)))] == nil and helppages[helparticle].imgs[imageshift+tonumber(part2:sub(fl,fl))+1] ~= nil then
							if love.filesystem.exists(helppages[helparticle].imgs[imageshift+tonumber(part2:sub(fl,fl))+1]) then
								cons("Loading help image " .. helparticle .. "_" .. (imageshift+tonumber(part2:sub(fl,fl))))
								helpimages[helparticle .. "_" .. (imageshift+tonumber(part2:sub(fl,fl)))] = love.graphics.newImage(helppages[helparticle].imgs[imageshift+tonumber(part2:sub(fl,fl))+1])
							else
								dodisplay = false
								love.graphics.setColor(255,0,0,255)
								part1 = L.IMAGEERROR
							end
						elseif helppages[helparticle].imgs[imageshift+tonumber(part2:sub(fl,fl))+1] == nil then
							dodisplay = false
							love.graphics.setColor(255,0,0,255)
							part1 = L.IMAGEERROR
						end

						if dodisplay then
							love.graphics.draw(helpimages[helparticle .. "_" .. (imageshift+tonumber(part2:sub(fl,fl)))], 8+200+8+imagex+screenxoffset, helparticlescroll+8+(10*linee)+4)
						end
					elseif part2:sub(fl,fl) == "^" then
						imageshift = imageshift + 10
					elseif part2:sub(fl,fl) == "_" then
						imageshift = imageshift - 10
					elseif part2:sub(fl,fl) == ">" then
						imagex = imagex + 8
					elseif part2:sub(fl,fl) == "<" then
						imagex = imagex - 8
					elseif part2:sub(fl,fl) == "r" then
						insertrowcolor(rowcolors, {255,0,0})
					elseif part2:sub(fl,fl) == "g" then
						insertrowcolor(rowcolors, {128,128,128})
					elseif part2:sub(fl,fl) == "w" then
						insertrowcolor(rowcolors, {255,255,255})
					elseif part2:sub(fl,fl) == "b" then
						insertrowcolor(rowcolors, {64,64,255})
					elseif part2:sub(fl,fl) == "o" then
						insertrowcolor(rowcolors, {255,128,0})
					elseif part2:sub(fl,fl) == "v" then
						insertrowcolor(rowcolors, {0,255,0})

					elseif part2:sub(fl,fl) == "C" then
						insertrowcolor(rowcolors, {132, 181, 255})
					elseif part2:sub(fl,fl) == "P" then
						insertrowcolor(rowcolors, {255, 135, 255})
					elseif part2:sub(fl,fl) == "Y" then
						insertrowcolor(rowcolors, {255, 255, 135})
					elseif part2:sub(fl,fl) == "R" then
						insertrowcolor(rowcolors, {255, 61, 61})
					elseif part2:sub(fl,fl) == "G" then
						insertrowcolor(rowcolors, {144, 255, 144})
					elseif part2:sub(fl,fl) == "B" then
						insertrowcolor(rowcolors, {75, 75, 230})


					elseif part2:sub(fl,fl) == "y" then
						insertrowcolor(rowcolors, {255,255,0})
					elseif part2:sub(fl,fl) == "c" then
						insertrowcolor(rowcolors, {0,255,255})
					elseif part2:sub(fl,fl) == "p" then
						insertrowcolor(rowcolors, {178,0,255})
					elseif part2:sub(fl,fl) == "V" then
						insertrowcolor(rowcolors, {0,128,0})
					elseif part2:sub(fl,fl) == "z" then
						insertrowcolor(rowcolors, {0,0,0})
					elseif part2:sub(fl,fl) == "Z" then
						insertrowcolor(rowcolors, {64,64,64})
					elseif part2:sub(fl,fl) == "n" then
						insertrowcolor(rowcolors, {192,192,192})
					elseif part2:sub(fl,fl) == "l" then
						rowlinkmodes[math.max(#rowcolors, 1)] = 2
					elseif part2:sub(fl,fl) == "L" then
						insertrowcolor(rowcolors, {192,192,192})
						rowlinkmodes[#rowcolors] = 1
					elseif part2:sub(fl,fl) == "&" then
						backgroundshift = true
					elseif part2:sub(fl,fl) == "-" then
						part1 = ("_"):rep(doublesize and 41 or 82)
					elseif part2:sub(fl,fl) == "=" then
						part1 = ("_"):rep(lastheaderwidth)
					elseif part2:sub(fl,fl) == "+" then
						bgexpandmode = true
					elseif part2:sub(fl,fl) == "X" then
						part1 = unxmlspecialchars(part1)
					elseif part2:sub(fl,fl) == "(" then
						-- Leaving this thing undocumented except in the code.
						-- It basically allows single characters to colored between ¤s, as long as you put § after that character, and the § will not be shown.
						singlecharmode = true
					elseif part2:sub(fl,fl) == ")" and helparticle == 1 then
						tostate(oldstate, true)
						if state == 11 then
							-- Back to search results
							startinput()
							input = searchedfor
						end
						nodialog = false
					end
				end

				-- The first part now needs some handling as well!
				local _, numseparators = part1:gsub("¤","")
				local _, numnotseparators = part1:gsub("¤¤","")
				numseparators = numseparators - numnotseparators*2

				--cons("BECAUSE " .. (#{part1:match("¤")}) .. " and " .. (#{part1:match("¤¤")}))

				if numseparators > 0 then
					--cons(numseparators)
					if part1parts_cache[linee] == nil or part1 ~= part1parts_cache[linee][1] then
						part1parts_cache[linee] = {part1, {part1:match("(.*" .. ("[^¤])¤([^¤].*"):rep(numseparators) .. ")")}} -- maybe the regex could be a little bit better?
					end
					local textxoffset = 0
					local link = nil

					for kn,vn in pairs(part1parts_cache[linee][2]) do
						if singlecharmode and vn:sub(-2,-1) == "§" then
							vn = vn:sub(1, -3)
						end
						-- We never actually want that ugly # to show up if we're linking to anchors in the same article
						local startinghash = false
						if rowlinkmodes[kn] == 2 and vn:sub(1,1) == "#" then
							vn = vn:sub(2,-1)
							startinghash = true
						end

						if rowlinkmodes[kn] ~= 1 then
							-- It's not the link belonging to a link text
							local currenttextxoffset = textxoffset
							textxoffset = textxoffset + love.graphics.getFont():getWidth(vn:gsub("¤¤","¤"))
							local bgx, bgy = 8+200+8+currenttextxoffset+screenxoffset-1, helparticlescroll+8+(10*linee)+3

							if rowcolors[kn] == nil then
								love.graphics.setColor(192,192,192,255)
							elseif #rowcolors[kn] >= 6 then
								love.graphics.setColor(rowcolors[kn][4], rowcolors[kn][5], rowcolors[kn][6])
								if bgexpandmode and kn == #part1parts_cache[linee][2] then
									love.graphics.rectangle("fill", bgx, bgy, 656-currenttextxoffset, doublesize and 20 or 10)
								else
									love.graphics.rectangle("fill", bgx, bgy, textxoffset-currenttextxoffset, doublesize and 20 or 10)
								end

								setColorArr(rowcolors[kn])
							else
								setColorArr(rowcolors[kn])
							end

							love.graphics.print(vn:gsub("¤¤","¤"), 8+200+8+currenttextxoffset+screenxoffset, helparticlescroll+8+(10*linee)+4+2)

							if rowlinkmodes[kn] == 2 and mouseon(bgx, bgy, textxoffset-currenttextxoffset, doublesize and 20 or 10) then
								if link == nil then
									link = vn
								end
								hoveringlink = link
							end
						else
							-- Link which is not shown here
							link = vn
						end

						if startinghash then
							link = "#" .. link
						end
					end

					if doublesize then
						lastheaderwidth = textxoffset/8
					end
				else
					-- We never actually want that ugly # to show up if we're linking to anchors in the same article
					local startinghash = false
					if rowlinkmodes[1] == 2 and part1:sub(1,1) == "#" then
						part1 = part1:sub(2,-1)
						startinghash = true
					end
					local bgx, bgy = 8+200+8+screenxoffset-1, helparticlescroll+8+(10*linee)+3
					if rowcolors[1] ~= nil then
						if #rowcolors[1] >= 6 then
							love.graphics.setColor(rowcolors[1][4], rowcolors[1][5], rowcolors[1][6])
							love.graphics.rectangle("fill", bgx, bgy, bgexpandmode and 656 or love.graphics.getFont():getWidth(part1:gsub("¤¤","¤")), doublesize and 20 or 10)

							setColorArr(rowcolors[1])
						else
							setColorArr(rowcolors[1])
						end
					end

					love.graphics.print(part1:gsub("¤¤","¤"), 8+200+8+screenxoffset, helparticlescroll+8+(10*linee)+4+2)

					--love.graphics.rectangle("line", bgx, bgy, love.graphics.getFont():getWidth(part1:gsub("¤¤","¤")), doublesize and 20 or 10)
					if rowlinkmodes[1] == 2 and mouseon(bgx, bgy, love.graphics.getFont():getWidth(part1:gsub("¤¤","¤")), doublesize and 20 or 10) then
						hoveringlink = part1
						if startinghash then
							hoveringlink = "#" .. hoveringlink
						end
					end

					if doublesize then
						lastheaderwidth = love.graphics.getFont():getWidth(part1:gsub("¤¤","¤"))/8
					end
				end
				love.graphics.setFont(font8)
				love.graphics.setColor(192,192,192,255)
			else
				love.graphics.print(s, 8+200+8+screenxoffset, helparticlescroll+8+(10*linee)+4+2)
			end

			linee = linee + 1
		end
		love.graphics.setColor(255,255,255,255)
		love.graphics.setScissor()

		-- Scroll bar for the article itself
		local newperonetage = scrollbar(love.graphics.getWidth()-24, 8, love.graphics.getHeight()-16, (#helparticlecontent*10), ((-helparticlescroll))/((#helparticlecontent*10)-(love.graphics.getHeight()-32)))

		if newperonetage ~= nil then
			helparticlescroll = -(newperonetage*((#helparticlecontent*10)-(love.graphics.getHeight()-32)))
		end

		-- Is this note editable?
		if helpeditable then
			-- It is!
			if helpeditingline == 0 then
				-- We're not currently editing it.
				love.graphics.setColor(0,0,0,192)
				love.graphics.rectangle("fill", love.graphics.getWidth()-140-116-116-20-20-4, love.graphics.getHeight()-28, 116+116+116+20+24, 24)

				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140-116-116-20-20, love.graphics.getHeight()-24, 16, 16)
				love.graphics.printf(arrow_up, love.graphics.getWidth()-140-116-116-20-20, (love.graphics.getHeight()-24)+4+2, 16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140-116-116-20, love.graphics.getHeight()-24, 16, 16)
				love.graphics.printf(arrow_down, love.graphics.getWidth()-140-116-116-20, (love.graphics.getHeight()-24)+4+2, 16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140-116-116, love.graphics.getHeight()-24, 128-16, 16)
				love.graphics.printf(L.RENAME, love.graphics.getWidth()-140-116-116, (love.graphics.getHeight()-24)+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140-116, love.graphics.getHeight()-24, 128-16, 16)
				love.graphics.printf(L.EDIT, love.graphics.getWidth()-140-116, (love.graphics.getHeight()-24)+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140, love.graphics.getHeight()-24, 128-16, 16)
				love.graphics.printf(L.DELETE, love.graphics.getWidth()-140, (love.graphics.getHeight()-24)+4+2, 128-16, "center")

				if nodialog and love.mouse.isDown("l") then
					if not mousepressed and mouseon(love.graphics.getWidth()-140-116-116-20-20, love.graphics.getHeight()-24, 16, 16) then
						-- Move up
						if helparticle > 2 then
							local this_art = table.copy(helppages[helparticle])
							helppages[helparticle] = table.copy(helppages[helparticle-1])
							helppages[helparticle-1] = table.copy(this_art)
							helparticle = helparticle - 1
						end
						nodialog = false
					elseif not mousepressed and mouseon(love.graphics.getWidth()-140-116-116-20, love.graphics.getHeight()-24, 16, 16) then
						-- Move down
						if helparticle < #helppages then
							local this_art = table.copy(helppages[helparticle])
							helppages[helparticle] = table.copy(helppages[helparticle+1])
							helppages[helparticle+1] = table.copy(this_art)
							helparticle = helparticle + 1
						end
						nodialog = false
					elseif not mousepressed and mouseon(love.graphics.getWidth()-140-116-116, love.graphics.getHeight()-24, 128-16, 16) then
						-- Rename
						dialog.create(
							L.NEWNAME,
							DBS.OKCANCEL,
							dialog.callback.renamenote,
							L.RENAMENOTE,
							dialog.form.simplename_make(helppages[helparticle].subj)
						)
					elseif not mousepressed and mouseon(love.graphics.getWidth()-140-116, love.graphics.getHeight()-24, 128-16, 16) then
						-- Edit
						helpeditingline = 1
						input = anythingbutnil(helparticlecontent[helpeditingline])
						takinginput = true
						nodialog = false
					elseif not mousepressed and mouseon(love.graphics.getWidth()-140, love.graphics.getHeight()-24, 128-16, 16) then
						-- Delete
						dialog.create(
							L.SUREDELETENOTE,
							DBS.YESNO,
							dialog.callback.suredeletenote
						)
					end
				end
			else
				-- We are currently editing it.
				love.graphics.setColor(0,0,0,192)
				love.graphics.rectangle("fill", love.graphics.getWidth()-140-116-4, love.graphics.getHeight()-28, 116+116+4, 24)

				local yellow = false
				if generictimer_mode == 1 and generictimer > 0 then
					yellow = true
				end
				hoverrectangle(yellow and 160 or 128,yellow and 160 or 128,yellow and 0 or 128,128, love.graphics.getWidth()-140-116, love.graphics.getHeight()-24, 128-16, 16)
				love.graphics.printf(L.COPY, love.graphics.getWidth()-140-116, (love.graphics.getHeight()-24)+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-140, love.graphics.getHeight()-24, 128-16, 16)
				love.graphics.printf(L.SAVE, love.graphics.getWidth()-140, (love.graphics.getHeight()-24)+4+2, 128-16, "center")

				if nodialog and love.mouse.isDown("l") then
					if not mousepressed and mouseon(love.graphics.getWidth()-140-116, love.graphics.getHeight()-24, 128-16, 16) then
						-- Copy
						love.system.setClipboardText(table.concat(helparticlecontent, (love.system.getOS() == "Windows" and "\r\n" or "\n")))
						setgenerictimer(1, .25)
					elseif not mousepressed and mouseon(love.graphics.getWidth()-140, love.graphics.getHeight()-24, 128-16, 16) then
						-- Save
						helparticlecontent[helpeditingline] = input .. input_r
						helpeditingline = 0
						stopinput()
						takinginput = false
						helppages[helparticle].cont = table.concat(helparticlecontent, "\n")
						dirty()
						nodialog = false
					end
				end
			end
		end

		-- Were we hovering over a link?
		if hoveringlink ~= nil and nodialog then
			drawlink(hoveringlink)
			if not special_cursor or hoveringlink ~= cachedlink then
				matching_url = hoveringlink:match("^https?://[A-Za-z0-9%-%._~:/%?#%[%]@!%$&'%(%)%*%+,;=%%]+$") ~= nil
				matching_article = false
				matching_anchor = false
				if not matching_url then
					if hoveringlink:find("#") then
						local part1, part2 = hoveringlink:match("(.*)#(.*)")
						if part1 == "" then
							matching_article_num = helparticle -- current article
						else
							for rvnum = 1, #helppages do
								if part1 == helppages[rvnum].subj then
									matching_article_num = rvnum
									break
								end
							end
						end
						if part2 == "" then
							matching_anchor = true
							matching_anchor_line = 1
						elseif matching_article_num ~= nil then
							for k,s in pairs(explode("\n", helppages[matching_article_num].cont)) do
								if s:find("\\") and s:match(".*\\[^\\]*#[^\\]*") and part2 == s:match("(.*)\\.*"):gsub("¤", "") then
									matching_anchor = true
									matching_anchor_line = k
									break
								end
							end
						end
					else
						for rvnum = 1, #helppages do
							if hoveringlink == helppages[rvnum].subj then
								matching_article = true
								matching_article_num = rvnum
								break
							end
						end
					end
				end
				if matching_url or matching_article or matching_anchor then
					love.mouse.setCursor(hand_cursor)
				else
					love.mouse.setCursor(forbidden_cursor)
				end
				special_cursor = true
				cachedlink = hoveringlink
			end
			if not mousepressed and love.mouse.isDown("l") then
				if matching_url then
					love.system.openURL(hoveringlink)
				elseif matching_article then
					gotohelparticle(matching_article_num)
				elseif matching_anchor then
					gotohelparticle(matching_article_num)
					helparticlescroll = (matching_anchor_line-1)*-10
					handle_scrolling(false, "wd", 0)
				end
			elseif love.mouse.isDown("r") then
				if matching_url then
					rightclickmenu.create({L.COPYLINK}, "lnk_" .. hoveringlink)
				elseif not matching_article and not matching_anchor then
					rightclickmenu.create({L.COPYLINK}, "lnk_" .. hoveringlink)
				end
			end
		elseif special_cursor then
			love.mouse.setCursor()
			special_cursor = false
		end

		if love.mouse.isDown("l") and nodialog then
			mousepressed = true
		end
	end

	if s.psmallerscreen then
		-- Those buttons will overlap with the article content
		local leftpartw = 8+200+8+screenxoffset-2

		if onlefthelpbuttons then
			local extrawidth = 0
			if helprefreshable then
				extrawidth = 20
			end
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill", leftpartw, 0, 25*8+16-28-leftpartw+extrawidth, love.graphics.getHeight())
			love.graphics.setColor(255,255,255)
		else
			love.graphics.setScissor(0, 0, leftpartw, love.graphics.getHeight())
		end
	end

	j = -1
	for rvnum = 1, #helppages+(helpeditable and 1 or 0) do
		j = j + 1
		local buttoncolor = {128,128,128}
		if helparticle == rvnum then
			buttoncolor = {192,192,192}
		end
		if helpeditingline ~= 0 then
			love.graphics.setColor(buttoncolor[1],buttoncolor[2],buttoncolor[3],64) -- Unfortunately we cannot simply unpack() this because there are more arguments
			love.graphics.rectangle("fill", 8, helplistscroll+8+(24*j), 25*8-28, 16)
			love.graphics.setColor(255,255,255,128)
		else
			hoverrectangle(buttoncolor[1],buttoncolor[2],buttoncolor[3],128, 8, helplistscroll+8+(24*j), 25*8-28, 16)
		end
		local buttonlabel
		if helppages[rvnum] == nil then
			buttonlabel = L.ADDNEWBTN
		else
			buttonlabel = helppages[rvnum].subj
		end
		local textyoffset = 6
		if font8:getWidth(buttonlabel) > 25*8-28 or buttonlabel:find("\n") ~= nil then
			textyoffset = 2
		end
		love.graphics.printf(buttonlabel, 8, helplistscroll+8+(24*j)+textyoffset, 25*8-28, "center")

		-- Are we clicking on this?
		if nodialog and helpeditingline == 0 and mouseon(8, helplistscroll+8+(24*j), 25*8-28, 16) then
			if love.mouse.isDown("l") then
				if helppages[rvnum] == nil then
					-- This is just the "add new" button.
					dialog.create(
						L.NEWNOTENAME,
						DBS.OKCANCEL,
						dialog.callback.newnote,
						L.CREATENEWNOTE,
						dialog.form.simplename
					)
				else
					gotohelparticle(rvnum)
				end
			end
		end
	end

	-- If we're in "latest info", then we can refresh!
	if helprefreshable and not updatecheckthread:isRunning() then
		hoverdraw(refreshbtn, 25*8-16, 8, 16, 16)

		if nodialog and love.mouse.isDown("l") and mouseon(25*8-16, 8, 16, 16) then
			load_updatecheck(true)
			tostate(6)
		end
	end

	if s.psmallerscreen and not onlefthelpbuttons then
		local leftpartw = 8+200+8+screenxoffset-2 -- Ugh I keep setting this
		love.graphics.setColor(0,0,0,192)
		love.graphics.rectangle("fill", leftpartw-8, 0, 4, love.graphics.getHeight())
		love.graphics.setColor(0,0,0,224)
		love.graphics.rectangle("fill", leftpartw-4, 0, 4, love.graphics.getHeight())
		love.graphics.setColor(255,255,255,255)
		love.graphics.setScissor()
	end

	-- Scroll bar for list of articles
	--if scrollbar(8+(25*8-28)+4, 8, love.graphics.getHeight()-16, (love.graphics.getHeight()-16)*2, 0) then

	--end
end
