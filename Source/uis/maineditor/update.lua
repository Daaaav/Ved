-- maineditor/update

return function(dt)
	if (editingbounds == -1 or editingbounds == 1) and selectedtool ~= 9 then
		if editingbounds == 1 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (tool canceled)")
		end

		editingbounds = 0
	elseif (editingbounds == -2 or editingbounds == 2) and selectedtool ~= 8 then
		if editingbounds == 2 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (tool canceled)")
		end

		editingbounds = 0
	end

	if sp_t ~= 0 and not sp_go then
		sp_tim = sp_tim + dt
		if sp_tim > .33 then
			sp_tim = 0
			sp_tap()
		end
	end
	if sp_t ~= 0 and sp_go and sp_got > 0 then
		sp_got = sp_got - dt
	end

	if levelmetadata_get(roomx, roomy).warpdir == 3 then
		warpbganimation = (warpbganimation + 2) % 64
	elseif levelmetadata_get(roomx, roomy).warpdir ~= 0 then
		warpbganimation = (warpbganimation + 3) % 32
	end

	if vedmetadata == nil then
		cons("vedmetadata == nil! Setting to false.")
		vedmetadata = false
	end

	if keyboardmode and love.timer.getTime() % 0.02 < 0.007 then
		--[[ Experimental and still very annoying.
		You want to be able to:
		* Move one tile by pressing once
		* Smoothly move multiple times at a reasonable speed, not too fast not too slow
		* Move diagonally and such
		]]
		local x, y = love.mouse.getPosition(x,y)
		local changed = false
		if love.keyboard.isDown("right") or love.keyboard.isDown("kp6") then
			x = x + 16
			changed = true
		end
		if love.keyboard.isDown("left") or love.keyboard.isDown("kp4") then
			x = x - 16
			changed = true
		end
		if love.keyboard.isDown("down") or love.keyboard.isDown("kp2") then
			y = y + 16
			changed = true
		end
		if love.keyboard.isDown("up") or love.keyboard.isDown("kp8") then
			y = y - 16
			changed = true
		end
		if changed then
			love.mouse.setPosition(x,y)
		end
	end
end
