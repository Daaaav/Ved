-- Scroll bars!
local scrollclickstart, savedfraction
local dragging_x, dragging_y, dragging_h

function scrollbar(x, y, height, scrollableheight, fraction, indialog)
	-- Returns nil if untouched, returns scroll value if moved
	-- New fraction maybe?
	local newfraction

	local setColor
	if indialog == nil then
		setColor = love.graphics.setColor
	else
		setColor = function(...)
			indialog:setColor(...)
		end
	end

	setColor(96,96,96,96)
	love.graphics.rectangle("fill", x, y, 16, height)

	if scrollableheight > height then
		-- Display an actual scrollable thing
		-- BUTTONheight: (height/scrollableheight)*height
		-- BUTTONy: (height-BUTTONheight)*fraction
		local buttonheight = (height/scrollableheight)*height

		local scrollclickoffset = 0
		if scrollclickstart ~= nil and dragging_x == x and dragging_y == y and dragging_h == height
		and love.mouse.isDown("l") then
			scrollclickoffset = love.mouse.getY()-scrollclickstart
		end

		if mouseon(x, y+(height-buttonheight)*fraction+scrollclickoffset, 16, buttonheight) and window_active() then
			setColor(224,224,224,255)
		else
			setColor(192,192,192,255)
		end

		if mouseon(x, y+(height-buttonheight)*fraction+scrollclickoffset, 16, buttonheight)
		and not mousepressed and (nodialog or indialog) and love.mouse.isDown("l") then
			if scrollclickstart == nil then
				scrollclickstart = love.mouse.getY()
				savedfraction = fraction
				dragging_x, dragging_y, dragging_h = x, y, height
			end

			mousepressed = true
		elseif not love.mouse.isDown("l") and scrollclickstart ~= nil then
			scrollclickstart = nil
			savedfraction = nil
			dragging_x, dragging_y, dragging_h = nil, nil, nil
		end

		local dispfraction = fraction
		if scrollclickstart ~= nil and dragging_x == x and dragging_y == y and dragging_h == height then
			newfraction = savedfraction + (scrollclickoffset/(height-buttonheight))
			dispfraction = savedfraction
		end

		love.graphics.rectangle(
			"fill",
			x,
			math.min(
				math.max(
					y+(height-buttonheight)*dispfraction+scrollclickoffset,
					y
				),
				(y+height)-buttonheight
			),
			16,
			buttonheight
		)
	end

	setColor(255,255,255,255)

	if newfraction ~= nil then
		return math.min(math.max(newfraction,0),1)
	end
end

function lefttoolscrollbounds()
	local max_scroll = 368
	if (lefttoolscroll < -max_scroll) then
		lefttoolscroll = -max_scroll
	elseif (lefttoolscroll > 16) then
		lefttoolscroll = 16
	end
end

function flipscrollmore(movement)
	-- Ok so on OSX by default scrolling is the opposite of Windows, which can feel natural because you're using two fingers instead of rolling a wheel
	-- Now this does not feel normal when you're switching between items instead of scrolling
	-- So on Mac we reverse that with the subtools but you can also reverse this way of scrolling, in which case our flipped code changes to the unnatural feeling one
	-- In which case you can change a setting in Ved to again reverse that
	if s.flipsubtoolscroll then
		return -movement
	else
		return movement
	end
end

function toolscroll()
	lefttoolscroll = math.max(16-(48*(selectedtool-1)), lefttoolscroll)--, lefttoolscroll+(love.graphics.getHeight()-32))--, -368)
	lefttoolscroll = math.min(16-(48*(selectedtool-1))+(love.graphics.getHeight()-32)-64, lefttoolscroll)
end

function handle_scrolling(viakeyboard, mkinput, customdistance, x, y)
	local direction, distance

	if x == nil or y == nil then
		x, y = love.mouse.getPosition()
	end

	if viakeyboard then
		distance = 10*46
		if (takinginput or newinputsys.active) and table.contains({"home", "end"}, mkinput) then
			return
		elseif table.contains({"pageup", "home"}, mkinput) then
			direction = "u"
		elseif table.contains({"pagedown", "end"}, mkinput) then
			direction = "d"
		end
	else
		distance = 16
		if mkinput == "wu" then
			direction = "u"
		elseif mkinput == "wd" then
			direction = "d"
		end
	end
	if customdistance ~= nil then
		distance = customdistance
	end

	if direction == nil then
		return
	end

	if dialog.is_open() then
		local topdialog = dialogs[#dialogs]
		local k = topdialog:get_on_scrollable_field(x, y, viakeyboard)
		local cf = dialogs[#dialogs].currentfield
		local cfistext = anythingbutnil(dialogs[#dialogs].fields[cf])[DFP.T] == DF.TEXT
		if k ~= nil then
			if distance % 8 == 0 then
				-- Account for 12px high items, 16 scroll distance is jarring
				distance = distance * 1.5
			end
			local fieldscroll = topdialog.fields[k][DFP.FILES_LISTSCROLL]
			if direction == "u" then
				if mkinput == "home" and not cfistext then
					fieldscroll = 0
				else
					fieldscroll = fieldscroll + distance
					if fieldscroll > 0 then
						fieldscroll = 0
					end
				end
			elseif direction == "d" then
				local upperbound = (#topdialog.fields[k][DFP.FILES_MENUITEMS])*12-12*topdialog.fields[k][DFP.FILES_LIST_HEIGHT]
				if mkinput == "end" and not cfistext then
					fieldscroll = math.min(-upperbound, 0)
				else
					fieldscroll = fieldscroll - distance
					if -fieldscroll > upperbound then
						fieldscroll = math.min(-upperbound, 0)
					end
				end
			end
			dialogs[#dialogs].fields[k][DFP.FILES_LISTSCROLL] = fieldscroll
		end
	elseif state == 3 and not viakeyboard then
		if direction == "u" then
			scriptscroll = scriptscroll + distance
			if scriptscroll > 0 then
				scriptscroll = 0
			end
		elseif direction == "d" then
			scriptscroll = scriptscroll - distance
			local textscale = s.scripteditor_largefont and 2 or 1
			local font_height = font_level:getHeight()
			local upperbound = (((#inputs.script_lines*font_height+16)*textscale-(s.scripteditor_largefont and 24 or 0))-(love.graphics.getHeight()-24)) -- scrollableHeight - visiblePart
			if -scriptscroll > upperbound then
				scriptscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 6 then
		if distance % 8 == 0 then
			-- The levels list now has items that are 12 high... Which makes 16 scroll distance jarring
			distance = distance * 1.5
		end
		if direction == "u" then
			levellistscroll = levellistscroll + distance
			if levellistscroll > 0 then
				levellistscroll = 0
			end
		elseif direction == "d" then
			levellistscroll = levellistscroll - distance
			local lessheight = 48
			if #s.recentfiles > 0 and inputs.levelname == "" then
				lessheight = lessheight + 16 + #s.recentfiles*12
			end
			local upperbound = ((max_levellistscroll)-(love.graphics.getHeight()-lessheight))
			if -levellistscroll > upperbound then
				levellistscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 10 then
		if direction == "u" then
			if mkinput == "home" then
				scriptlistscroll = 0
			else
				scriptlistscroll = scriptlistscroll + distance
				if scriptlistscroll > 0 then
					scriptlistscroll = 0
				end
			end
		elseif direction == "d" then
			local ndisplayedscripts = 0
			if scriptdisplay_used and scriptdisplay_unused then
				ndisplayedscripts = #level.scriptnames
			elseif scriptdisplay_used then
				ndisplayedscripts = n_usedscripts
			elseif scriptdisplay_unused then
				ndisplayedscripts = #level.scriptnames - n_usedscripts
			end
			local upperbound = ((ndisplayedscripts*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
			if mkinput == "end" then
				scriptlistscroll = math.min(-upperbound, 0)
			else
				scriptlistscroll = scriptlistscroll - distance
				if -scriptlistscroll > upperbound then
					scriptlistscroll = math.min(-upperbound, 0)
				end
			end
		end
	elseif state == 11 then
		if direction == "u" then
			searchscroll = searchscroll + distance
			if searchscroll > 0 then
				searchscroll = 0
			end
		elseif direction == "d" then
			searchscroll = searchscroll - distance
			local upperbound = ((longestsearchlist*32)-2-(love.graphics.getHeight()-56)) -- scrollableHeight - visiblePart
			if -searchscroll > upperbound then
				searchscroll = math.min(-upperbound, 0)
			end
		end
	elseif state == 15 then
		local usethiscondition = x <= 25*8 and (x ~= 0 or y ~= 0)
		if s.psmallerscreen then
			usethiscondition = onlefthelpbuttons
		end

		if usethiscondition then
			if direction == "u" then
				if mkinput == "home" then
					helplistscroll = 0
				else
					helplistscroll = helplistscroll + distance
					if helplistscroll > 0 then
						helplistscroll = 0
					end
				end
			elseif direction == "d" then
				local upperbound = (((#helppages+(helpeditable and 2 or 1))*24)-(love.graphics.getHeight()-8)) -- scrollableHeight - visiblePart
				if mkinput == "end" then
					helplistscroll = math.min(-upperbound, 0)
				else
					helplistscroll = helplistscroll - distance
					if -helplistscroll > upperbound then
						helplistscroll = math.min(-upperbound, 0)
					end
				end
			end
		else
			if direction == "u" then
				if mkinput == "home" then
					helparticlescroll = 0
				else
					helparticlescroll = helparticlescroll + distance
					if helparticlescroll > 0 then
						helparticlescroll = 0
					end
				end
			elseif direction == "d" then
				-- #anythingbutnil(helparticlecontent) is very quirky; if the table helparticlecontent == nil, then we get an empty string, and #"" is 0, which is exactly what we want.
				-- The alternative is defining an extra anythingbutnil* function for returning an empty list, but #{}==#"" and if not nil, it just happily returns the table it got.
				local upperbound = ((#anythingbutnil(helparticlecontent)*10)-(love.graphics.getHeight()-32))
				if mkinput == "end" then
					helparticlescroll = math.min(-upperbound, 0)
				else
					helparticlescroll = helparticlescroll - distance
					if -helparticlescroll > upperbound then
						helparticlescroll = math.min(-upperbound, 0)
					end
				end
			end

			if helpeditingline ~= 0 and viakeyboard then
				helparticlecontent[helpeditingline] = input .. input_r
				input_r = ""
				__ = "_"
				if direction == "u" then
					helpeditingline = math.max(1, helpeditingline - 46)
				else
					helpeditingline = math.min(#helparticlecontent, helpeditingline + 46)
				end
				input = anythingbutnil(helparticlecontent[helpeditingline])
			end
		end
	else
		local el = get_scrollable_element(x, y)
		if el == nil then
			return
		end

		if direction == "u" then
			el.scroll = el.scroll + distance
			if el.scroll > 0 then
				el.scroll = 0
			end
		elseif direction == "d" then
			el.scroll = el.scroll - distance
			local upperbound = (el.child_ph - el.ph) -- scrollableHeight - visiblePart
			if -el.scroll > upperbound then
				el.scroll = math.min(-upperbound, 0)
			end
		end
	end
end

function is_scrollable(x, y)
	if dialog.is_open() then
		return dialogs[#dialogs]:get_on_scrollable_field(x, y) ~= nil
	end
	if state == 3 or state == 10 or state == 11 or state == 15 then
		return true
	end
	if state == 6 and x < love.graphics.getWidth()-128 then
		return true
	end
	if get_scrollable_element(x, y) ~= nil then
		return true
	end
	return false
end

function get_scrollable_element(x, y)
	if uis[state] == nil or uis[state].elements == nil then
		return nil
	end

	local found = nil

	local function caller(e)
		if e.is_scrollable and found == nil
		and x >= e.px and x < e.px+e.pw and y >= e.py and y < e.py+e.ph then
			found = e
		end
	end
	for k,v in elements_iter(uis[state].elements) do
		caller(v)
		if v.recurse ~= nil then
			v:recurse("is_scrollable", caller)
		end
	end

	return found
end

function set_middlescroll(x, y)
	if middlescroll_falling then return end

	middlescroll_x, middlescroll_y = x, y
	middlescroll_t = love.timer.getTime()
end

function unset_middlescroll()
	if middlescroll_falling then return end

	if love.timer.getTime() - middlescroll_t < 24 or middlescroll_y > love.graphics.getHeight()-16 then
		middlescroll_x, middlescroll_y = -1, -1
	else
		middlescroll_falling = true
	end
end

function middlescroll_fall_update(dt)
	middlescroll_v = middlescroll_v + 1200*dt
	middlescroll_y = middlescroll_y + middlescroll_v*dt

	if middlescroll_y > love.graphics.getHeight()-16 then
		if middlescroll_v > 500 then
			-- Shatter.
			snd_break:play()
			middlescroll_shatter = true
			for y = 0, 15 do
				for x = 0, 15 do
					table.insert(middlescroll_shatter_pieces, {
							x = middlescroll_x-16 + 4*x,
							y = love.graphics.getHeight()-16 + 4*y,
							ox = 4*x,
							oy = 4*y,
							vx = love.math.random(-50,50),
							vy = -middlescroll_v/1.5
						}
					)
				end
			end
		else
			-- Roll.
			snd_roll:play()
			middlescroll_rolling = (middlescroll_x < love.graphics.getWidth()/2) and -1 or 1
			middlescroll_rolling_x = middlescroll_x
		end
		middlescroll_x, middlescroll_y = -1, -1
		middlescroll_falling = false
		middlescroll_t, middlescroll_v = 0, 0
	end
end

function middleclick_shatter_update(dt)
	for k,v in pairs(middlescroll_shatter_pieces) do
		if v.y > love.graphics.getHeight()+64 then
			middlescroll_shatter = false
			middlescroll_shatter_pieces = {}
			break
		end

		middlescroll_shatter_pieces[k].x = v.x + v.vx*dt
		middlescroll_shatter_pieces[k].y = v.y + v.vy*dt
		middlescroll_shatter_pieces[k].vy = v.vy + 2400*dt
	end
end

function middleclick_roll_update(dt)
	middlescroll_v = middlescroll_v + 150*dt
	middlescroll_rolling_x = middlescroll_rolling_x + middlescroll_v*middlescroll_rolling*dt

	if middlescroll_rolling_x < -16 or middlescroll_rolling_x > love.graphics.getWidth() + 16 then
		snd_roll:stop()
		middlescroll_rolling = 0
		middlescroll_v = 0
	end
end

function inplacescroll(key)
	local usethisinput, usethisdistance
	if table.contains({"up", "pageup"}, key) then
		usethisinput = "wu"
	elseif table.contains({"down", "pagedown"}, key) then
		usethisinput = "wd"
	end
	if table.contains({"pageup", "pagedown"}, key) then
		usethisdistance = 10*46
	end
	handle_scrolling(false, usethisinput, usethisdistance)
end


local container_is_listening = false
local req_y, req_h

function scrollbar_before_contents()
	-- Prepare for the drawing code (inside a scrollable area)
	-- possibly calling scrollbar_request_visible.
	-- A scrollable container should call this right before
	-- calling its "child" drawing code.
	container_is_listening = true
	req_y, req_h = nil, nil
end

function scrollbar_request_visible(y, h)
	-- If you're inside a scrollable container,
	-- request that a certain segment gets scrolled onscreen.
	-- y and h signify the Y position and height of a rectangle
	-- at its current (possibly offscreen/scissored out) position.
	-- Has no effect if not in a (compatible) scrollable container.
	if not container_is_listening then
		return
	end
	req_y, req_h = y, h
end

function scrollbar_after_contents()
	-- Check whether the drawing code (inside a scrollable area)
	-- has called scrollbar_request_visible.
	-- If so, returns y and h, otherwise returns nil.
	-- A scrollable container should call this right after
	-- calling its "child" drawing code, and can use the returned
	-- y and h to change the scroll position.
	if not container_is_listening then
		return nil, nil
	end
	container_is_listening = false
	return req_y, req_h
end
