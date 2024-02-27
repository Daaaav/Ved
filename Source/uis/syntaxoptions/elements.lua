-- syntaxoptions/elements

local color_options = {
	"command",
	"generic",
	"separator",
	"number",
	"textbox",
	"errortext",
	"wronglang",
	"flagname",
	"newflagname",
	"comment"
}

local color_elements = {}

for k,v in pairs(color_options) do
	table.insert(color_elements,
		HorizontalListContainer(
			{
				ColorButton(
					function()
						return unpack(s["syntaxcolor_" .. v])
					end,
					32, 16,
					function()
						syntaxoptions_editingcolor = "syntaxcolor_" .. v
					end
				),
				Spacer(8, 0),
				Text(
					L["SYNTAXCOLOR_" .. v:upper()],
					function()
						local alpha = (syntaxoptions_editingcolor == "syntaxcolor_" .. v) and 255 or 128
						return alpha,alpha,alpha
					end
				),
			}, {}, nil, 16
		)
	)
end

return {
	HorizontalListContainer(
		{
			Spacer(8, 0), -- Left padding
			ListContainer(
				{
					WrappedText(L.SYNTAXCOLORSETTINGSTITLE),
					Spacer(0, 12),
					ListContainer(color_elements, {}, nil, nil, ALIGN.LEFT, 0, 8),
					Spacer(0, 32),
					DrawingFunction(
						function(x, y, maxw, maxh)
							checkbox(s.colored_textboxes, x, y, "colored_textboxes", L.COLORED_TEXTBOXES,
								function(key, newvalue)
									s[key] = newvalue
								end
							)
						end
					)
				},
				{}, nil, nil, ALIGN.LEFT, 8+4
			),
		}, {}, nil, nil, VALIGN.TOP
	),
	AlignContainer(
		ColorPicker(
			function()
				if syntaxoptions_editingcolor ~= nil then
					return unpack(s[syntaxoptions_editingcolor])
				end
			end,
			function(r, g, b)
				s[syntaxoptions_editingcolor][1] = r
				s[syntaxoptions_editingcolor][2] = g
				s[syntaxoptions_editingcolor][3] = b
			end
		),
		ALIGN.RIGHT, VALIGN.BOTTOM
	),
	RightBar(
		{
			LabelButton(L.BTN_OK,
				function()
					saveconfig()
					tostate(oldstate, true)
					-- Just to make sure we don't get stuck in the settings
					oldstate = olderstate
				end,
				"b", hotkey("escape")
			),
			LabelButtonSpacer(),
			LabelButton(L.RESETCOLORS,
				function()
					for k,v in pairs(s) do
						if k:sub(1,12) == "syntaxcolor_" then
							s[k] = table.copy(configs[k].default)
						end
					end
					syntaxoptions_editingcolor = nil
				end
			),
		},
		{
		}
	)
}
