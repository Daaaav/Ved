-- theme/elements

local theme_elements = {}

local update_elements -- function

local function get_theme_element(name, active_in_position, n_active_themes)
	local move_buttons
	if active_in_position == nil or active_in_position == 1 then
		-- Inactive themes can't be moved, neither can the base theme
		move_buttons = Spacer(17, 0)
	else
		move_buttons = ListContainer(
			{
				LabelButton(
					arrow_up,
					function()
						theme:shift_theme_up(name)
						update_elements()
					end,
					nil, nil,
					function()
						if active_in_position >= n_active_themes then
							return true, false
						end
						return true, true
					end,
					nil, nil, 17
				),
				LabelButton(
					arrow_down,
					function()
						theme:shift_theme_down(name)
						update_elements()
					end,
					nil, nil,
					function()
						if active_in_position <= 2 then
							return true, false
						end
						return true, true
					end,
					nil, nil, 17
				),
			}, {}, 17, nil, ALIGN.CENTER, 0, 4
		)
	end

	local theme_info = theme:get_themes()[name].info

	return HorizontalListContainer(
		{
			Spacer(),
			move_buttons,
			ImageButton(
				active_in_position == nil and image.checkoff_hq or image.checkon_hq, 1,
				function()
					if active_in_position == nil then
						theme:enable_theme(name)
					else
						theme:disable_theme(name)
					end
					update_elements()
				end,
				nil, nil,
				function()
					if active_in_position == 1 then
						return true, false
					end
					return true, true
				end
			),
			DrawingFunction(
				function(x, y, w, h)
					love.graphics.setColor(128, 128, 128)
					love.graphics.rectangle("line", x+.5, y+.5, w-9, 57)

					love.graphics.setColor(0, 128, 0)
					love.graphics.rectangle("fill", x+1, y+1, 56, 56)

					love.graphics.setColor(255, 255, 255)
					font_ui:print(theme_info.name(), x+64, y+8)

					love.graphics.setColor(128, 128, 128)
					font_ui:print(theme_info.author(), x+64, y+18)

					local text_w = w-16-64
					love.graphics.setColor(255, 255, 255)
					font_ui:printf(theme_info.description(), x+64, y+34, text_w, "left")

					return w, 58
				end
			),
		}, {}, nil, 58, VALIGN.CENTER, 0, 8
	)
end

update_elements = function()
	table.clear(theme_elements)

	table.insert(theme_elements, WrappedText(L.ACTIVETHEMES))

	local active_themes = theme:get_active_themes()
	local n_active_themes = #active_themes

	for i = n_active_themes, 1, -1 do
		table.insert(theme_elements, get_theme_element(active_themes[i], i, n_active_themes))
	end

	local inactive_themes = {}
	for name, theme in pairs(theme:get_themes()) do
		if not table.contains(active_themes, name) then
			table.insert(inactive_themes, name)
		end
	end

	for i, name in ipairs(inactive_themes) do
		if i == 1 then
			table.insert(theme_elements, WrappedText(L.INACTIVETHEMES))
		end
		table.insert(theme_elements, get_theme_element(name, nil, nil))
	end

	uis[state].drawn = false
end

update_elements()


return {
	PaddingContainer(
		ListContainer(
			{
				WrappedText(L.THEMESTITLE),
				Spacer(),
				ScrollContainer(
					ListContainer(theme_elements, {}, nil, nil, ALIGN.LEFT, 0, 8),
					love.graphics.getWidth()-144, nil, false
				),
			},
			{}, nil, nil, ALIGN.LEFT, 4, 6
		), nil, nil, 8
	),
	RightBar(
		{
			LabelButton(L.BTN_OK,
				function()
					saveconfig()
					tostate(oldstate, true)
					oldstate = olderstate
				end,
				"b", hotkey("escape")
			),
		},
		{
		}
	)
}
