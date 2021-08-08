function love.mousereleased(x, y, button)
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

	for k,v in pairs(skip_next_mouses) do
		if v == button then
			table.remove(skip_next_mouses, k)
			return
		end
	end

	if s.pscale ~= 1 then
		x, y = x*s.pscale^-1, y*s.pscale^-1
	end

	hook("love_mousereleased_start", {x, y, button})

	mousepressed = false
	mousepressed_custombrush = false
	if mousepressed_flag then
		mousepressed_flag = false
		mousereleased_flag = true
	end
	minsmear = -1; maxsmear = -1
	toout = 0

	if newinputsys ~= nil and --[[ nil check only because we're in a transition ]] newinputsys.active and newinputsys.getfocused() ~= nil then
		newinputsys.ignoremousepressed = false

		local id = newinputsys.getfocused()
		local multiline = type(inputs[id]) == "table"

		if newinputsys.selpos[id] ~= nil then
			local whichfirst
			if multiline then
				local curx, cury = unpack(newinputsys.pos[id])
				local selx, sely = unpack(newinputsys.selpos[id])
				local lines = inputs[id]
				if newinputsys.rightmosts[id] then
					curx = utf8.len(lines[cury])
				end

				if cury < sely then
					whichfirst = 1
				elseif sely < cury then
					whichfirst = 2
				elseif curx < selx then
					whichfirst = 1
				elseif selx < curx then
					whichfirst = 2
				end
			else
				local curx = newinputsys.pos[id]
				local selx = newinputsys.selpos[id]
				if newinputsys.rightmosts[id] then
					curx = utf8.len(inputs[id])
				end

				if curx < selx then
					whichfirst = 1
				elseif selx < curx then
					whichfirst = 2
				end
			end

			if whichfirst == nil then
				newinputsys.clearselpos(id)
			end
		end
	end

	for k,v in pairs(dialogs) do
		v:mousereleased(x, y)
	end

	if button == "m" and middlescroll_x ~= -1 and middlescroll_y ~= -1 and not mouseon(middlescroll_x-16, middlescroll_y-16, 32, 32) then
		unset_middlescroll()
	end

	boxmouserelease()

	if coordsdialog.active or RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].mousereleased ~= nil then
		uis[state].mousereleased(x, y, button)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, x, y, button)
			if e.mousereleased ~= nil
			and e.px <= x and (e.pw == nil or e.px+e.pw > x)
			and e.py <= y and (e.ph == nil or e.py+e.ph > y) then
				e:mousereleased(x-e.px, y-e.py, button)
			end
		end
		-- If needed, you might want to change this to cycle through elements in reverse and catch clicks
		-- Also, since this is mouse released, maybe only call this iff we already called mousepressed??
		for k,v in pairs(uis[state].elements) do
			caller(v, x, y, button)
			if v.recurse ~= nil then
				v:recurse("mousereleased", caller, x, y, button)
			end
		end
	end
end
