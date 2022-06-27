function love.wheelmoved(xm, ym)
	-- xm and ym are the amount of movement, not the mouse position!

	if s.pausedrawunfocused and not window_active() then
		-- When drawing is paused it won't look like the scrollbar has moved,
		-- so just don't move it so the visual will be accurate
		return
	end

	hook("love_wheelmoved_start", {xm, ym})

	if RCMactive then
		RCMactive = false
	end

	if ym < 0 or ym > 0 then
		local use_ym = ym
		if s.mousescrollingspeed < 0 then
			-- Alright, I guess you want opposite scrolling in Ved than in the rest of your system!
			-- (Especially with trackpads there might be usecases where this makes sense)
			use_ym = -ym
		end
		handle_scrolling(false, use_ym > 0 and "wu" or "wd", round(math.abs(ym)*math.abs(s.mousescrollingspeed)))
	end

	if coordsdialog.active or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].wheelmoved ~= nil then
		uis[state].wheelmoved(xm, ym)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, xm, ym, pos_x, pos_y)
			if e.wheelmoved ~= nil
			and e.px <= pos_x and (e.pw == nil or e.px+e.pw > pos_x)
			and e.py <= pos_y and (e.ph == nil or e.py+e.ph > pos_y) then
				e:wheelmoved(xm, ym)
			end
		end

		local pos_x, pos_y = love.mouse.getPosition()

		-- If needed, you might want to change this to cycle through elements in reverse and catch scrolls
		for k,v in pairs(uis[state].elements) do
			caller(v, xm, ym, pos_x, pos_y)
			if v.recurse ~= nil then
				v:recurse("wheelmoved", caller, xm, ym, pos_x, pos_y)
			end
		end
	end

end
