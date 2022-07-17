-- map/elements

return {
	RightBar(
		{
		},
		{
			DrawingFunction(
				function(x, y, maxw, maxh)
					ved_printf(L.MAP_STYLE, x, y, maxw, "center")
					for k,v in pairs({
						{"full", L.MAP_STYLE_FULL},
						{"minimap", L.MAP_STYLE_MINIMAP},
						{"vtools", L.MAP_STYLE_VTOOLS},
					}) do
						radio_wrap(s.mapstyle == v[1], x, y+(24*k)-4, v[1], v[2], 96,
							function(key)
								s.mapstyle = v[1]
								saveconfig()
								map_init()
								map_screen_init()
							end
						)
					end

					return 112, 20+24*3
				end
			),
			EditorIconBar(),
			LabelButton(L.COPYROOMS,
				function()
					selectingrooms = 1
					selected1x = -1; selected1y = -1
					selected2x = -1; selected2y = -1
				end
			),
			LabelButton(L.SWAPROOMS,
				function()
					selectingrooms = 2
					selected1x = -1; selected1y = -1
					selected2x = -1; selected2y = -1
				end
			),
			ScreenContainer(
				{
					DrawingFunction(
						function(x, y, maxw, maxh)
							ved_printf(L.SHIFTROOMS, x, y+6, 8*10, "center")
							hoverrectangle(128,128,128,128, x+8*10, y+10, 10, 10)
							hoverrectangle(128,128,128,128, x+8*13, y+10, 10, 10)
							hoverrectangle(128,128,128,128, x+8*11+4, y, 10, 10)
							hoverrectangle(128,128,128,128, x+8*11+4, y+10+8, 10, 10)
							ved_print(arrow_left, x+8*10+1, y+10+1)
							ved_print(arrow_right, x+8*13+1, y+10+1)
							ved_print(arrow_up, x+8*11+4+1, y+1)
							ved_print(arrow_down, x+8*11+4+1, y+10+8+1)
						end
					),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.LEFT, true) end), 8*10, 10),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.RIGHT, true) end), 8*13, 10),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.UP, true) end), 8*11+4, 0),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.DOWN, true) end), 8*11+4, 10+8),
				},
				114, 26
			),
			LabelButtonSpacer(),
			LabelButton(L.SAVEMAP, create_export_dialog, "S", hotkey("s")),
			LabelButton(L.RETURN, function() tostate(1, true) end, "b", hotkey("escape")),
		}
	),
}
