function drawhelp()
	-- Leaving room for a 16 px wide scrollbar. 4+16+8
	
	local screenxoffset = 0
	if s.smallerscreen then
		screenxoffset = -96
	end
	
	local linee = 0
	
	if helppages[helparticle] ~= nil then
		-- ...
		--sis = explode("\n", helppages[helparticle].cont)
		
		--for s in string.gmatch(LH[helparticle].cont, ".*\n") do
		love.graphics.setScissor(8+200+8+screenxoffset-2, 8, love.graphics.getWidth()-(8+200+8-4)-screenxoffset, love.graphics.getHeight()-16)
		love.graphics.setColor(192,192,192,255)

		for k,s in pairs(helparticlecontent) do
			if helpeditingline == k then
				love.graphics.print(s .. __, 8+200+8+screenxoffset, helparticlescroll+8+(10*linee)+4+2)
			elseif s:find("\\") then
				local imageshift = 0
				local imagex = 0
				
				local rowcolors = {}
				backgroundshift = false
				
				local doublesize = false -- Only used for background colors, the font is just set
				
				local singlecharmode = false
				
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
					elseif part2:sub(fl,fl) == "z" then
						insertrowcolor(rowcolors, {0,0,0})
					elseif part2:sub(fl,fl) == "Z" then
						insertrowcolor(rowcolors, {64,64,64})
					elseif part2:sub(fl,fl) == "n" then
						insertrowcolor(rowcolors, {192,192,192})
					elseif part2:sub(fl,fl) == "l" then
						insertrowcolor(rowcolors, {192,192,192})
					elseif part2:sub(fl,fl) == "&" then
						backgroundshift = true
					elseif part2:sub(fl,fl) == "-" then
						part1 = ("_"):rep(82)
					elseif part2:sub(fl,fl) == "(" then
						-- Leaving this thing undocumented except in the code.
						-- It basically allows single characters to colored between ¤s, as long as you put § after that character, and the § will not be shown.
						singlecharmode = true
					elseif part2:sub(fl,fl) == ")" then
						tostate(oldstate, true)
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
					local part1parts = {part1:match("(.*" .. ("[^¤])¤([^¤].*"):rep(numseparators) .. ")")} -- maybe the regex could be a little bit better?
					local textxoffset = 0
					
					for kn,vn in pairs(part1parts) do
						if singlecharmode and vn:sub(-2,-1) == "§" then
							vn = vn:sub(1, -3)
						end
						
						local currenttextxoffset = textxoffset
						textxoffset = textxoffset + love.graphics.getFont():getWidth(vn:gsub("¤¤","¤"))
						
						if rowcolors[kn] == nil then
							love.graphics.setColor(192,192,192,255)
						elseif #rowcolors[kn] >= 6 then
							love.graphics.setColor(rowcolors[kn][4], rowcolors[kn][5], rowcolors[kn][6])
							local bgx, bgy = 8+200+8+currenttextxoffset+screenxoffset-1, helparticlescroll+8+(10*linee)+3
							love.graphics.rectangle("fill", bgx, bgy, textxoffset-currenttextxoffset, doublesize and 20 or 10)
							
							setColorArr(rowcolors[kn])
						else
							setColorArr(rowcolors[kn])
						end
						
						love.graphics.print(vn:gsub("¤¤","¤"), 8+200+8+currenttextxoffset+screenxoffset, helparticlescroll+8+(10*linee)+4+2)
					end
				else
					if rowcolors[1] ~= nil then
						if #rowcolors[1] >= 6 then
							love.graphics.setColor(rowcolors[1][4], rowcolors[1][5], rowcolors[1][6])
							local bgx, bgy = 8+200+8+screenxoffset-1, helparticlescroll+8+(10*linee)+3
							love.graphics.rectangle("fill", bgx, bgy, love.graphics.getFont():getWidth(part1:gsub("¤¤","¤")), doublesize and 20 or 10)

							setColorArr(rowcolors[1])
						else
							setColorArr(rowcolors[1])
						end
					end
					
					love.graphics.print(part1:gsub("¤¤","¤"), 8+200+8+screenxoffset, helparticlescroll+8+(10*linee)+4+2)
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
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8)-16-4-(128-12)-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16)
				love.graphics.printf(L.RENAME, love.graphics.getWidth()-(128-8)-16-4-(128-12)-(128-12), (love.graphics.getHeight()-(24*1))+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8)-16-4-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16)
				love.graphics.printf(L.EDIT, love.graphics.getWidth()-(128-8)-16-4-(128-12), (love.graphics.getHeight()-(24*1))+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8)-16-4, love.graphics.getHeight()-(24*1), 128-16, 16)
				love.graphics.printf(L.DELETE, love.graphics.getWidth()-(128-8)-16-4, (love.graphics.getHeight()-(24*1))+4+2, 128-16, "center")
				
				if nodialog and love.mouse.isDown("l") then
					if not mousepressed and mouseon(love.graphics.getWidth()-(128-8)-16-4-(128-12)-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16) then
						-- Rename
						startmultiinput({helppages[helparticle].subj})
						dialog.new(L.NEWNAME, L.RENAMENOTE, 1, 4, 13)
					elseif not mousepressed and mouseon(love.graphics.getWidth()-(128-8)-16-4-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16) then
						-- Edit
						helpeditingline = 1
						input = anythingbutnil(helparticlecontent[helpeditingline])
						takinginput = true
						nodialog = false
					elseif not mousepressed and mouseon(love.graphics.getWidth()-(128-8)-16-4, love.graphics.getHeight()-(24*1), 128-16, 16) then
						-- Delete
						dialog.new(L.SUREDELETENOTE, "", 1, 3, 14)
					end
				end
			else
				-- We are currently editing it.
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8)-16-4-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16)
				love.graphics.printf(L.COPY, love.graphics.getWidth()-(128-8)-16-4-(128-12), (love.graphics.getHeight()-(24*1))+4+2, 128-16, "center")
				hoverrectangle(128,128,128,128, love.graphics.getWidth()-(128-8)-16-4, love.graphics.getHeight()-(24*1), 128-16, 16)
				love.graphics.printf(L.SAVE, love.graphics.getWidth()-(128-8)-16-4, (love.graphics.getHeight()-(24*1))+4+2, 128-16, "center")
				
				if nodialog and love.mouse.isDown("l") then
					if not mousepressed and mouseon(love.graphics.getWidth()-(128-8)-16-4-(128-12), love.graphics.getHeight()-(24*1), 128-16, 16) then
						-- Copy
						love.system.setClipboardText(table.concat(helparticlecontent, (love.system.getOS() == "Windows" and "\r\n" or "\n")))
					elseif not mousepressed and mouseon(love.graphics.getWidth()-(128-8)-16-4, love.graphics.getHeight()-(24*1), 128-16, 16) then
						-- Save
						helparticlecontent[helpeditingline] = input .. input_r
						helpeditingline = 0
						stopinput()
						takinginput = false
						helppages[helparticle].cont = table.concat(helparticlecontent, "\n")
						nodialog = false
					end
				end
			end
		end
	end
	
	if s.smallerscreen then
		-- Those buttons will overlap with the article content
		local leftpartw = 8+200+8+screenxoffset-2
		
		if onlefthelpbuttons then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("fill", leftpartw, 0, 25*8+16-28-leftpartw, love.graphics.getHeight())
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
		love.graphics.printf((helppages[rvnum] == nil and L.ADDNEWBTN or helppages[rvnum].subj), 8, helplistscroll+8+(24*j)+4+2, 25*8-28, "center")
		
		-- Are we clicking on this?
		if nodialog and helpeditingline == 0 and mouseon(8, helplistscroll+8+(24*j), 25*8-28, 16) then
			if love.mouse.isDown("l") then
				if helppages[rvnum] == nil then
					-- This is just the "add new" button.
					startmultiinput({""})
					dialog.new(L.NEWNOTENAME, L.CREATENEWNOTE, 1, 4, 12)
				else
					gotohelparticle(rvnum)
				end
			end
		end
	end
	
	if s.smallerscreen and not onlefthelpbuttons then
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