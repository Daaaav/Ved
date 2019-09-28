rightclickmenu = {}
function rightclickmenu.create(items, menuid, menuposx, menuposy, abovedialog)
	if menuposx == nil then
		menuposx = love.mouse.getX()
	end if menuposy == nil then
		menuposy = love.mouse.getY()
	end

	RCMactive = true
	RCMx = math.min(menuposx, love.graphics.getWidth()-240)
	RCMy = math.min(menuposy, love.graphics.getHeight()-(#items*16))
	RCMactualy = menuposy -- In case we want to have this back
	RCMitems = items
	RCMid = menuid -- can be anything, really
	RCMreturn = ""
	RCMabovedialog = abovedialog == true
end

function rightclickmenu.draw()
	if RCMactive then
		for k,v in pairs(RCMitems) do
			if v:sub(1, 1) == "#" then
				love.graphics.setColor(128,128,128,192)
				love.graphics.rectangle("fill", RCMx, (k-1)*16+RCMy, 240, 16) -- 150 -> 188 -> 240
				love.graphics.setColor(192,192,192,255)
				ved_print(v:sub(2, -1), RCMx+1, (k-1)*16+RCMy+4)
				love.graphics.setColor(255,255,255,255)
			else
				hoverrectangle(128,128,128,192, RCMx, (k-1)*16+RCMy, 240, 16, true)
				ved_print(v, RCMx+1, (k-1)*16+RCMy+4)

				if not mousepressed and love.mouse.isDown("l") and mouseon(RCMx, (k-1)*16+RCMy, 240, 16) then
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
