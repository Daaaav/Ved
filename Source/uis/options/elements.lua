-- options/elements

return {
	RightBar(
		{
			LabelButton(L.BTN_OK,
				function()
					saveconfig()
					tostate(oldstate, true)

					-- TODO: Remove this when the buttons of states 1 and 6 have become Elements
					if not love.keyboard.isDown("escape") then
						mousepressed = true
					end
				end,
				"b", hotkey("escape")
			),
			LabelButtonSpacer(),
			LabelButton(L.VVVVVVSETUP,
				function()
					olderstate = oldstate
					tostate(35)
				end
			),
			LabelButton(L.LANGUAGE,
				function()
					olderstate = oldstate
					tostate(33)
				end
			),
			LabelButton(L.SYNTAXCOLORS,
				function()
					olderstate = oldstate
					tostate(25)
				end
			),
			LabelButton(L.DISPLAYSETTINGS,
				function()
					olderstate = oldstate
					tostate(27)
				end
			),
			LabelButton(L.THEMING,
				function()
					olderstate = oldstate
					tostate(37)
				end
			),
			LabelButtonSpacer(),
			LabelButton(L.SENDFEEDBACK,
				function()
					love.system.openURL("https://tolp.nl/ved/feedback")
				end
			),
		},
		{
		}
	)
}
