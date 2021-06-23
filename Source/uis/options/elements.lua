-- options/elements

return {
	RightBar(
		{
			LabelButton(L.BTN_OK,
				function()
					saveconfig()
					if oldstate == 6 and s.customvvvvvvdir ~= firstvvvvvvfolder then
						-- Immediately apply the new custom VVVVVV directory.
						loadlevelsfolder()
						tostate(6)
					else
						tostate(oldstate, true)
					end

					-- TODO: Remove this when the buttons of states 1 and 6 have become Elements
					if not love.keyboard.isDown("escape") then
						mousepressed = true
					end
				end,
				"b", hotkey("escape")
			),
			LabelButtonSpacer(),
			LabelButton(L.CUSTOMVVVVVVDIRECTORY,
				function()
					if vvvvvvfolder_expected == nil then
						dialog.create(
							langkeys(L.OSNOTRECOGNIZED,
								{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
							)
						)
					else
						local explanation, buttons
						if s.customvvvvvvdir == "" then
							explanation = L.CUSTOMVVVVVVDIRECTORY_NOTSET
							buttons = {L.CHANGEVERB, DB.CANCEL}
						else
							explanation = langkeys(L.CUSTOMVVVVVVDIRECTORY_SET, {s.customvvvvvvdir})
							buttons = {L.CHANGEVERB, L.RESET, DB.CANCEL}
						end
						explanation = explanation .. langkeys(L.CUSTOMVVVVVVDIRECTORYEXPL, {vvvvvvfolder_expected})
						dialog.create(
							explanation,
							buttons,
							dialog.callback.customvvvvvvdir1
						)
					end
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