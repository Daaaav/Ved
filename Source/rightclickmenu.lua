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

				if not mousepressed and love.mouse.isDown("l") and mouseon(RCMx, (k-1)*16+RCMy, 188, 16) then
					RCMactive = false
					RCMreturn = v
					mousepressed = true
				end
			end
		end

		if not mousepressed and love.mouse.isDown("l") then
			RCMactive = false
			mousepressed = true
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
