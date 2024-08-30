-- autoupdate/elements

-- Any "UI elements" that need to be drawn in that order.
-- UI elements can be little things like buttons, but also entire drawing functions.
return {
	AlignContainer(
		ListContainer(
			{
				WrappedText("Update to Ved X.Y", nil, nil, nil, nil, 2),
				Spacer(),
				WrappedText("This will update your Ved, yeah (this is the update notes)"),
				Spacer(),
				LabelButton("UPDATE", autoupdate_start, "n", hotkey("return")),
				WrappedText("[ Progress bars here ]"),
			},
			{},
			love.graphics.getWidth()-48,
			nil,
			ALIGN.LEFT, 24+4, 10
		),
		ALIGN.CENTER,
		VALIGN.TOP
	),
	RightBar(
		{
		},
		{
			LabelButton(L.RETURN,
				function()
					tostate(oldstate, true)

					-- TODO: Remove this when the buttons of state 6 have become Elements
					if not love.keyboard.isDown("escape") then
						mousepressed = true
					end
				end,
				"b", hotkey("escape"),
				function()
					return true, not autoupdate_started
				end
			),
		}
	)

}
