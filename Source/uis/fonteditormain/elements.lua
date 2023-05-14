-- map/elements

return {
	RightBar(
		{
			DrawingFunction(
				function(x, y, maxw, maxh)
					if fonteditor_is_loaded() then
						ved_printf(L.FONTFILTER, x, y, maxw, "center")
						for k,v in pairs({
							{"unicode", L.FONTFILTER_UNICODE},
							{"supported", L.FONTFILTER_SUPPORTED},
						}) do
							radio_wrap(fonteditor_filter == v[1], x, y+(24*k)-4, v[1], v[2], 96,
								function(key)
									fonteditor_filter = key
									fonteditor_scroll = 0
								end
							)
						end
					end

					return 112, 20+24*3
				end
			),
		},
		{
			LabelButton(
				L.REFERENCEFONT_BUTTON,
				function()
					dialog.create(
						L.REFERENCEFONT_DIALOGBODY,
						{L.REFERENCEFONT_LOADTTF, DB.OK},
						dialog.callback.referencefont,
						L.REFERENCEFONT_DIALOGTITLE,
						dialog.form.referencefont_make(),
						dialog.callback.referencefont_validate
					)
				end,
				nil, nil,
				fonteditor_is_loaded
			),
			LabelButtonSpacer(),
			LabelButton(
				L.SAVE,
				function()
					dialog.create(
						"",
						DBS.SAVECANCEL,
						nil,
						L.SAVEFONT,
						nil
					)
				end,
				"S", hotkey("s"),
				fonteditor_is_loaded
			),
			LabelButton(
				L.LOAD,
				function()
					dialog.create(
						"",
						DBS.LOADCANCEL,
						dialog.callback.loadfont,
						L.LOADFONT,
						dialog.form.files_make(assetsmenu_fontsfolder, "", ".png", true, 11, 0)
					)
				end,
				"L", hotkey("l")
			),
			LabelButton(
				L.NEW,
				function()
					dialog.create(
						"",
						DBS.CREATECANCEL,
						dialog.callback.newfont,
						L.NEWFONT,
						dialog.form.newfont_make(),
						dialog.callback.newfont_validate
					)
				end,
				"N", hotkey("n")
			),
			LabelButtonSpacer(),
			LabelButton(
				L.RETURN,
				function()
					tostate(30, true)
					oldstate = olderstate
					if love.mouse.isDown("l") then
						-- Remove when state 30 right bar uses elements
						mousepressed = true
					end
				end,
				"b", hotkey("escape")
			),
		}
	),
}
