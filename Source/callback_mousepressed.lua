function love.mousepressed(x, y, button)
	-- Love 0.10 compatibility
	if type(button) == "number" then
		if button == 1 then
			button = "l"
		elseif button == 2 then
			button = "r"
		elseif button == 3 then
			button = "m"
		end
	end

	-- However, we do now fully use love.wheelmoved.
	-- So it's 0.9-style love.mousepressed with "l", "r" and "m", and 0.10+-style love.wheelmoved.
	if button == "wu" or button == "wd" then
		love.wheelmoved(0, button == "wu" and 1 or -1)
		return
	end

	if focus_regained_timer < .1 then
		if not table.contains(skip_next_mouses, button) then
			table.insert(skip_next_mouses, button)
		end
		return
	end

	if s.pscale ~= 1 then
		x, y = math.floor(x*s.pscale^-1), math.floor(y*s.pscale^-1)
	end

	hook("love_mousepressed_start", {x, y, button})


	if rightclickmenu.mousepressed(x, y, button) then
		return
	end
	if dialog.is_open() and button == "l" then
		dialogs[#dialogs]:mousepressed(x, y)
	end

	if button == "m" then
		if middlescroll_x ~= -1 and middlescroll_y ~= -1 then
			unset_middlescroll()
		elseif is_scrollable(x, y) then
			set_middlescroll(x, y)
		end
	elseif button == "l" and middlescroll_x ~= -1 and middlescroll_y ~= -1 then
		unset_middlescroll()
	end

	boxmousepress()

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].mousepressed ~= nil then
		uis[state].mousepressed(x, y, button)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, x, y, button)
			if e.mousepressed ~= nil
			and e.px <= x and (e.pw == nil or e.px+e.pw > x)
			and e.py <= y and (e.ph == nil or e.py+e.ph > y) then
				e:mousepressed(x-e.px, y-e.py, button)
			end
		end
		-- If needed, you might want to change this to cycle through elements in reverse and catch clicks
		for k,v in elements_iter(uis[state].elements) do
			caller(v, x, y, button)
			if v.recurse ~= nil then
				v:recurse("mousepressed", caller, x, y, button)
			end
		end
	end
end
