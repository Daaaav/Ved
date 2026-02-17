-- specialroomnames/elements


local function save_current_roomname()
	if specialroomnames_editing == nil then
		return
	elseif specialroomnames_editing == 0 then
		editingroomname = true
		if levelmetadata_get(roomx, roomy).roomname ~= inputs.roomname then
			saveroomname()
		else
			cancel_editing_roomname()
		end
		specialroomnames_editing = nil
		return
	end

	local mode = level.specialroomnames[roomy][roomx][specialroomnames_editing].mode
	if mode == "static" or mode == "transform" then
		level.specialroomnames[roomy][roomx][specialroomnames_editing].name = inputs.roomname
		newinputsys.close("roomname")
	elseif mode == "glitch" then
		level.specialroomnames[roomy][roomx][specialroomnames_editing].name = {
			inputs.roomname, inputs.roomname2
		}
		newinputsys.close("roomname")
		newinputsys.close("roomname2")
	end
	specialroomnames_editing = nil
end

function start_editing_specialroomname(k)
	local roomnames = level.specialroomnames[roomy][roomx]
	if k == 0 then
		newinputsys.create(INPUT.ONELINE, "roomname", levelmetadata_get(roomx, roomy).roomname)
	elseif roomnames[k].mode == "static" then
		newinputsys.create(INPUT.ONELINE, "roomname", roomnames[k].name)
	elseif roomnames[k].mode == "glitch" then
		newinputsys.create(INPUT.ONELINE, "roomname2", roomnames[k].name[2])
		newinputsys.setcallback("roomname2", "text_changed",
			function(id, event)
				dirty()
			end
		)
		newinputsys.create(INPUT.ONELINE, "roomname",  roomnames[k].name[1])
		specialroomnames_currentinput = "roomname"
	else
		newinputsys.create(INPUT.MULTILINE, "roomname", roomnames[k].name)
		newinputsys.setcallback("roomname", "pos_changed",
			function(id, event)
				-- TODO ensure the scroll stays onscreen
			end
		)
	end
	if k ~= 0 then
		newinputsys.setcallback("roomname", "text_changed",
			function(id, event)
				dirty()
			end
		)
	end
	specialroomnames_editing = k
end

local roomname_elements = {}

function specialroomnames_update_elements()
	table.clear(roomname_elements)

	local n_roomnames = 0
	local roomnames
	if level.specialroomnames[roomy] ~= nil and level.specialroomnames[roomy][roomx] ~= nil then
		roomnames = level.specialroomnames[roomy][roomx]
		n_roomnames = #roomnames
	end

	-- Which one is the last roomname that has no flag associated (-1), or a specific flag?
	-- (meaning all the ones above are never used)
	local last_for_flag = {
		[-1] = 0
	}
	for k = 1, n_roomnames do
		last_for_flag[roomnames[k].flag] = k
	end

	for k = 0, n_roomnames do
		-- Persistent variable for this item
		local was_hovering = false

		table.insert(
			roomname_elements,
			DrawingFunction(
				function(x, y, maxw, maxh)
					local button_rgb = 128
					local button_a = 128
					if specialroomnames_editing == k then
						button_rgb = 192
						button_a = 255
					end
					local hovering = hoverrectangle(button_rgb,button_rgb,button_rgb,button_a, x, y, 324, 32)
					love.graphics.setColor(0, 0, 0)
					love.graphics.rectangle("fill", x+2, y+18, 320, 12)
					local never_used = false
					local flag = -1
					if k ~= 0 then
						flag = roomnames[k].flag
					end
					local oldsc_x, oldsc_y, oldsc_w, oldsc_h = love.graphics.getScissor()
					if k < last_for_flag[-1] or last_for_flag[flag] == nil or k < last_for_flag[flag] then
						never_used = true
						love.graphics.setScissor(x+2, y+18, 320, 12)
						love.graphics.setColor(64, 0, 0)
						love.graphics.line(x+2, y+18+12, x+2+320, y+18)
						love.graphics.setScissor(oldsc_x, oldsc_y, oldsc_w, oldsc_h)
					end
					love.graphics.setColor(255, 255, 255)

					local name
					if k == 0 then
						font_ui:print(L.STANDARD_ROOMNAME, x+4, y+4)
						if specialroomnames_editing ~= k then
							name = levelmetadata_get(roomx, roomy).roomname
						else
							name = inputs.roomname
						end
					else
						if roomnames[k].flag ~= -1 then
							font_8x8:print("⚑", x+4, y+4)
							font_level:print(roomnames[k].flag, x+16, y+4)
						end
						if roomnames[k].mode == "static" then
							if specialroomnames_editing ~= k then
								name = roomnames[k].name
							else
								name = inputs.roomname
							end
						elseif roomnames[k].mode == "glitch" then
							if specialroomnames_editing ~= k then
								name = roomnames[k].name[specialroomnames_glitchprogress + 1]
							elseif specialroomnames_glitchprogress == 0 then
								name = inputs.roomname
							else
								name = inputs.roomname2
							end
						elseif roomnames[k].mode == "transform" then
							if hovering and not was_hovering and not roomnames[k].loop then
								roomnames[k].progress = 0
							end
							if specialroomnames_editing ~= k then
								name = roomnames[k].name[roomnames[k].progress + 1]
							else
								name = inputs.roomname[math.min(#inputs.roomname, roomnames[k].progress + 1)]
							end
						end
					end

					if never_used then
						love.graphics.setColor(128, 128, 128)
					end

					if name ~= nil then
						local text_width = math.min(font_level:getWidth(name), 320)
						local text_x = math.floor(x+2 + 160 - text_width/2)
						love.graphics.setScissor(x+2, y+18, 320, 12)
						font_level:print(name, text_x, y+20)
						love.graphics.setScissor(oldsc_x, oldsc_y, oldsc_w, oldsc_h)
					end

					love.graphics.setColor(255, 255, 255)

					if hovering and not mousepressed and love.mouse.isDown("l") then
						if specialroomnames_editing ~= k then
							save_current_roomname()
							start_editing_specialroomname(k)
						end
						mousepressed = true
					end

					was_hovering = hovering

					return 324, 32
				end
			)
		)
	end

	table.insert(
		roomname_elements,
		ImageButton(
			image.newbtn, 1,
			function()
				save_current_roomname()
				specialroomnames_editing = nil
				dialog.create(
					"",
					DBS.OKCANCEL,
					dialog.callback.create_specialroomname,
					L.ADD_SPECIALROOMNAME,
					dialog.form.create_specialroomname_make()
				)
			end,
			"cN", hotkey("n", ctrl)
		)
	)

	table.insert(
		roomname_elements,
		Text(L.HINT_LAST_ROOMNAME, function() return 64, 64, 64 end)
	)

	uis[state].drawn = false
end

local function roomname_inputfield(is_second)

	-- Persists in the UI.
	-- Used for the double textbox for glitch names:
	-- true if this field set the cursor to switch to it
	local switch_ibeam_set = false

	return DrawingFunction(
		function(x, y, maxw, maxh)
			local input_id = "roomname"
			local clickable = false
			local multiline = false
			if specialroomnames_editing == 0 then
				-- Input roomname"
			else
				local mode = level.specialroomnames[roomy][roomx][specialroomnames_editing].mode
				if mode == "static" then
					-- Input "roomname"
				elseif mode == "glitch" then
					-- Both frame 1 and frame 2 are clickable
					clickable = true
					if is_second then
						input_id = "roomname2"
					end
				elseif mode == "transform" then
					multiline = true
				end
			end
			local height = font_level:getHeight()
			if multiline then
				height = height * #inputs[input_id]
			end
			height = height + 2 -- inner padding so the text doesn't touch the border
			if clickable and specialroomnames_currentinput ~= input_id and mouseon(x, y, 348, height+2) then
				if love.mouse.isDown("l") then
					if input_id == "roomname" then
						specialroomnames_currentinput = "roomname"
					else
						specialroomnames_currentinput = "roomname2"
					end
					newinputsys.bump(input_id)
					switch_ibeam_set = false
				elseif not switch_ibeam_set then
					love.mouse.setCursor(text_cursor)
					special_cursor = true
					switch_ibeam_set = true
				end
			elseif switch_ibeam_set then
				reset_special_cursor()
				switch_ibeam_set = false
			end
			local box_x = x+24
			love.graphics.setColor(64, 64, 64)
			love.graphics.rectangle("line", box_x+.5, y+.5, 323, height+1)
			love.graphics.setColor(16, 16, 16)
			love.graphics.rectangle("fill", box_x+1, y+1, 322, height)
			love.graphics.setColor(255, 255, 255)
			local sc_x, sc_y, sc_w, sc_h = love.graphics.getScissor()
			if multiline then
				-- Line numbers
				love.graphics.setColor(96, 96, 96)
				local font_height = font_level:getHeight()
				for ln = 1, #inputs.roomname do
					local ln_y = y+2 + font_height*(ln-1) + (font_height-8)/2
					if ln_y >= sc_y or ln_y <= sc_y+sc_h then
						local ln_x = x
						if ln > 99 and ln <= 999 then
							-- Align the tinyfont with the 8x8 font
							-- but give room when we hit 1000
							ln_x = x - 1
						end
						if ln > 99 then
							tinyfont:printf(
								fixdig(ln, 4, ""),
								ln_x, ln_y+1,
								16, "right"
							)
						else
							font_8x8:printf(
								fixdig(ln, 2, ""),
								ln_x, ln_y,
								16, "right"
							)
						end
					end
				end
				love.graphics.setColor(255, 255, 255)

				-- Make sure we can still click the scrollbar...
				newinputsys.setmousearea(input_id, sc_x, sc_y, sc_w-16, sc_h)
			else
				love.graphics.setScissor(x, y, 368, height+2)
			end
			newinputsys.print(input_id, box_x+2, y+2, font_level, "cjk_low")
			if not multiline then
				love.graphics.setScissor(sc_x, sc_y, sc_w, sc_h)
			end
			return 348, height+2
		end
	)
end

return {
	PaddingContainer(
		ListContainer(
			{
				WrappedText(L.SPECIALROOMNAMES_TITLE),
				Spacer(),
				ScrollContainer(
					ListContainer(roomname_elements, {}, 220, nil, ALIGN.LEFT, 0, 8),
					344, nil, false
				),
			},
			{},
			nil,
			nil,
			ALIGN.LEFT, 4, 6
		), nil, nil, 8
	),
	IfContainer(
		function()
			return specialroomnames_editing ~= nil
		end,
		PaddingContainer(
			ListContainer(
				{
					Text(
						function()
							if specialroomnames_editing == 0 then
								return L.STANDARD_ROOMNAME
							end

							local mode = level.specialroomnames[roomy][roomx][specialroomnames_editing].mode
							if mode == "glitch" then
								return L.SPECIALROOMNAME_GLITCH
							elseif mode == "transform" then
								return L.SPECIALROOMNAME_TRANSFORM
							else
								return L.SPECIALROOMNAME_STATIC
							end
						end
					),
					Spacer(0, 12),
					HorizontalListContainer(
						{
							LabelButton(
								arrow_up,
								function() dialog.create("up") end, -- and dirty
								nil, nil,
								function()
									if specialroomnames_editing <= 1 then
										return true, false
									end
									return true, true
								end,
								nil, nil, 17
							),
							LabelButton(
								arrow_down,
								function() dialog.create("down") end, -- and dirty
								nil, nil,
								function()
									if specialroomnames_editing == 0
									or specialroomnames_editing >= #level.specialroomnames[roomy][roomx] then
										return true, false
									end
									return true, true
								end,
								nil, nil, 17
							),
							LabelButton(
								function()
									return L.DELETE
								end,
								function() dialog.create("delete?") end, -- and dirty
								nil, nil,
								function()
									if specialroomnames_editing == 0 then
										return true, false
									end
									return true, true
								end
							),
						},
						{}, nil, 16, VALIGN.TOP, 0, 4
					),
					Spacer(0, 12),
					WrappedText(L.SPECIALROOMNAME_THIS_FLAG),
					Spacer(0, 6),
					LabelButton(
						function()
							if specialroomnames_editing == 0 then
								return L.SPECIALROOMNAME_NO_FLAG
							end
							local flag = level.specialroomnames[roomy][roomx][specialroomnames_editing].flag
							if flag == -1 then
								return L.SPECIALROOMNAME_NO_FLAG
							end
							return tostring(flag)
						end,
						function() end, -- don't forget dirty
						nil, nil,
						function()
							if specialroomnames_editing == 0 then
								return true, false
							end
							return true, true
						end,
						nil, nil, 230
					),
					Spacer(0, 18),

					-- Standard roomname or static
					IfContainer(
						function()
							return specialroomnames_editing == 0 or
								level.specialroomnames[roomy][roomx][specialroomnames_editing].mode == "static"
						end,
						ListContainer(
							{
								Text(L.SPECIALROOMNAME_ROOMNAME),
								roomname_inputfield(false)
							},
							{}, nil, nil, ALIGN.LEFT, 0, 6
						)
					),

					-- Glitch
					IfContainer(
						function()
							return specialroomnames_editing ~= 0 and
								level.specialroomnames[roomy][roomx][specialroomnames_editing].mode == "glitch"
						end,
						ListContainer(
							{
								Text(L.SPECIALROOMNAME_FRAME1),
								roomname_inputfield(false),
								Text(L.SPECIALROOMNAME_FRAME2),
								roomname_inputfield(true)
							},
							{}, nil, nil, ALIGN.LEFT, 0, 6
						)
					),

					-- Transform
					IfContainer(
						function()
							return specialroomnames_editing ~= 0 and
								level.specialroomnames[roomy][roomx][specialroomnames_editing].mode == "transform"
						end,
						ListContainer(
							{
								DrawingFunction(
									function(x, y, maxw, maxh)
										checkbox(
											level.specialroomnames[roomy][roomx][specialroomnames_editing].loop,
											x, y, "loop", L.SPECIALROOMNAME_LOOP,
											function(key, newvalue)
												dirty()
												level.specialroomnames[roomy][roomx][specialroomnames_editing].loop = newvalue
											end
										)

										return 0, 16
									end
								),
								Spacer(),
								Text(L.SPECIALROOMNAME_FRAMES),
								ScrollContainer(
									roomname_inputfield(false),
									368, nil, false
								),
							},
							{}, nil, nil, ALIGN.LEFT, 0, 6
						)
					),
				},
				{}, nil, nil, ALIGN.LEFT, 0, 0
			), nil, nil, 32, 358, 8, 128
		)
	),
	RightBar(
		{
		},
		{
			LabelButton(L.RETURN,
				function()
					save_current_roomname()
					tostate(oldstate, true)
				end,
				"b", hotkey("escape")
			),
		}
	)
}
