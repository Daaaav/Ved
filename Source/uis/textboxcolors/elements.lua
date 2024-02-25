-- textboxcolors/elements


local color_elements_builtin = {}
local color_elements_custom = {}

function textboxcolors_update_elements()
	local color_names = {}

	for _,k in pairs(textboxcolors_order) do
		table.insert(color_names, {
				name = k,
				builtin = true,
				custom = extra.textboxcolors[k] ~= nil
			}
		)
	end
	for _,k in pairs(extra.textboxcolors_order) do
		if textboxcolors[k] == nil then
			table.insert(color_names, {
					name = k,
					builtin = false,
					custom = true
				}
			)
		end
	end

	table.clear(color_elements_builtin)
	table.clear(color_elements_custom)
	for k,v in pairs(color_names) do
		table.insert(
			v.builtin and color_elements_builtin or color_elements_custom,
			HorizontalListContainer(
				{
					ColorButton(
						function()
							return get_textbox_color(v.name)
						end,
						32, 16,
						function()
							textboxcolors_editingcolor = v.name
						end
					),
					Spacer(8, 0),
					Text(
						v.name,
						function()
							local alpha = (textboxcolors_editingcolor == v.name) and 255 or 128
							return alpha,alpha,alpha
						end,
						font_level
					),
					Text(
						function()
							if v.builtin and extra.textboxcolors[v.name] ~= nil then
								return " *"
							end
							return ""
						end,
						function()
							return 64,64,64
						end,
						font_level
					)
				}, {}, nil, 16
			)
		)
	end

	table.insert(
		color_elements_custom,
		ImageButton(
			image.newbtn, 1,
			create_textboxcolor_dialog(true, false),
			"N", hotkey("n")
		)
	)

	uis[state].drawn = false
end

function create_textboxcolor_dialog(create, rename)
	-- Create: (create=true, rename=false)
	-- Duplicate: (create=false, rename=false)
	-- Rename: (create=false, rename=true)
	return function()
		local title
		if create then
			title = L.TEXTBOXCOLORS_CREATE
		else
			if rename then
				title = L.TEXTBOXCOLORS_RENAME
			else
				title = L.TEXTBOXCOLORS_DUPLICATE
			end
			title = langkeys(title, {textboxcolors_editingcolor})
		end

		if create then
			textboxcolors_editingcolor = nil
		end

		dialog.create(
			L.NEWNAME,
			DBS.OKCANCEL,
			dialog.callback.create_textboxcolor,
			title,
			dialog.form.hidden_make(
				{rename=rename},
				dialog.form.simplename_make(rename and textboxcolors_editingcolor or "")
			)
		)
	end
end

return {
	HorizontalListContainer(
		{
			Spacer(8, 0), -- Left padding
			ListContainer(
				{
					WrappedText(L.TEXTBOXCOLORS_TITLE),
					Spacer(),
					HorizontalListContainer(
						{
							ListContainer(color_elements_builtin, {}, 220, nil, ALIGN.LEFT, 0, 8),
							ListContainer(color_elements_custom, {}, 220, nil, ALIGN.LEFT, 0, 8),
						},
						{},
						nil, nil, VALIGN.TOP
					),
				},
				{},
				nil,
				nil,
				ALIGN.LEFT, 8+4, 6
			),
		}, {}, nil, nil, VALIGN.TOP
	),
	FloatContainer(
		ListContainer(
			{
				DrawingFunction(
					function(x, y, maxw, maxh)
						if textboxcolors_editingcolor == nil then
							return 160, 0
						end

						local center = x + maxw/2
						local textbox_x = center - font_level:getWidth(textboxcolors_editingcolor) - 16
						local textbox_y = (86 - 32 - font_level:getHeight()*2) / 2

						vvvvvv_textbox(
							textboxcolors_editingcolor,
							textbox_x,
							textbox_y,
							{textboxcolors_editingcolor},
							true
						)

						return 160, 0
					end
				)
			},
			{
				LabelButton(L.DUPLICATE, create_textboxcolor_dialog(false, false), nil, nil,
					function()
						if textboxcolors_editingcolor == nil then
							return false, false
						end
						return true, true
					end
				),
				LabelButton(L.RENAME, create_textboxcolor_dialog(false, true), nil, nil,
					function()
						if textboxcolors_editingcolor == nil then
							return false, false
						end
						return true, extra.textboxcolors[textboxcolors_editingcolor] ~= nil
					end
				),
				LabelButton(
					function()
						if textboxcolors[textboxcolors_editingcolor] ~= nil then
							return L.RESET
						end
						return L.DELETE
					end,
					function()
						extra.textboxcolors[textboxcolors_editingcolor] = nil
						for k,v in pairs(extra.textboxcolors_order) do
							if v == textboxcolors_editingcolor then
								table.remove(extra.textboxcolors_order, k)
								break
							end
						end
						if textboxcolors[textboxcolors_editingcolor] == nil then
							-- Only "deselect" if this isn't a built-in color
							textboxcolors_editingcolor = nil
						end
						textboxcolors_update_elements()
						dirty()
					end,
					"DEL",
					hotkey("delete"),
					function()
						if textboxcolors_editingcolor == nil then
							return false, false
						end
						return true, extra.textboxcolors[textboxcolors_editingcolor] ~= nil
					end
				),
				LabelButtonSpacer(),
				ColorPicker(
					function()
						if textboxcolors_editingcolor ~= nil then
							return get_textbox_color(textboxcolors_editingcolor)
						end
					end,
					function(r, g, b)
						if extra.textboxcolors[textboxcolors_editingcolor] == nil then
							-- Color didn't exist yet...
							extra.textboxcolors[textboxcolors_editingcolor] = {}
							table.insert(extra.textboxcolors_order, textboxcolors_editingcolor)
						end
						extra.textboxcolors[textboxcolors_editingcolor][1] = r
						extra.textboxcolors[textboxcolors_editingcolor][2] = g
						extra.textboxcolors[textboxcolors_editingcolor][3] = b
						dirty()
					end
				),
			},
			nil, nil, ALIGN.CENTER, 0, 8
		),
		love.graphics.getWidth()-128-176,
		0,
		160,
		love.graphics.getHeight()
	),
	RightBar(
		{
		},
		{
			LabelButton(L.RETURN,
				function()
					-- TODO: Remove this when the buttons of state 10 have become Elements
					if not love.keyboard.isDown("escape") then
						mousepressed = true
					end
					tostate(oldstate, true)
				end,
				"b", hotkey("escape")
			),
		}
	)
}
