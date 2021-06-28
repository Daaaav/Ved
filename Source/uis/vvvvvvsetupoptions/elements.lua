-- vvvvvvsetupoptions/elements

return {
	HorizontalListContainer(
		{
			Spacer(8, 0), -- Left padding
			ListContainer(
				{
					WrappedText(L.CUSTOMVVVVVVDIRECTORY),
					Spacer(),
					WrappedText(
						function()
							if vvvvvvfolder_expected == nil then
								return langkeys(L.OSNOTRECOGNIZED,
									{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
								)
							else
								local explanation
								if s.customvvvvvvdir == "" then
									explanation = L.CUSTOMVVVVVVDIRECTORY_NOTSET
								else
									explanation = langkeys(L.CUSTOMVVVVVVDIRECTORY_SET, {s.customvvvvvvdir})
								end
								return explanation .. langkeys(L.CUSTOMVVVVVVDIRECTORYEXPL, {vvvvvvfolder_expected})
							end
						end
					),
					Spacer(),
					HorizontalListContainer(
						{
							LabelButton(L.CHANGEVERB,
								function()
									local start = s.customvvvvvvdir
									if start == "" then
										start = userprofile
									end
									dialog.create(
										"",
										DBS.OKCANCEL,
										dialog.callback.customvvvvvvdir,
										L.CUSTOMVVVVVVDIRECTORY,
										dialog.form.files_make(start, "", dirsep, true, 12)
									)
								end,
								nil, nil,
								function()
									return true, vvvvvvfolder_expected ~= nil
								end
							),
							LabelButton(L.RESET,
								function()
									s.customvvvvvvdir = ""
								end,
								nil, nil,
								function()
									return true, s.customvvvvvvdir ~= ""
								end
							),
						},
						{},
						nil, 16, VALIGN.TOP, 0, 8
					),
					Spacer(0, 24),
					WrappedText(L.PLAYTESTINGOPTIONS),
					Spacer(),
					WrappedText(
						function()
							if not playtesting_available then
								return langkeys(L.PLAYTESTUNAVAILABLE, {love.system.getOS()})
							end

							if s.vvvvvv23 == nil or s.vvvvvv23 == "" then
								return langkeys(L.PLAYTESTING_EXECUTABLE_NOTSET, {"VVVVVV 2.3", "VVVVVV"})
							end

							return langkeys(L.PLAYTESTING_EXECUTABLE_SET, {"VVVVVV 2.3", s.vvvvvv23})
						end
					),
					Spacer(),
					HorizontalListContainer(
						{
							LabelButton(L.CHANGEVERB,
								function()
									playtesting_ask_path("V", false)
								end,
								nil, nil,
								function()
									return true, playtesting_available
								end
							),
							LabelButton(L.RESET,
								function()
									s.vvvvvv23 = ""
								end,
								nil, nil,
								function()
									return true, s.vvvvvv23 ~= ""
								end
							),
						},
						{},
						nil, 16, VALIGN.TOP, 0, 8
					),
					Spacer(),
					WrappedText(
						function()
							if not playtesting_available then
								return langkeys(L.PLAYTESTUNAVAILABLE, {love.system.getOS()})
							end

							if s.vvvvvvce == nil or s.vvvvvvce == "" then
								return langkeys(L.PLAYTESTING_EXECUTABLE_NOTSET, {"VVVVVV-CE", "VVVVVV-CE"})
							end

							return langkeys(L.PLAYTESTING_EXECUTABLE_SET, {"VVVVVV-CE", s.vvvvvvce})
						end
					),
					Spacer(),
					HorizontalListContainer(
						{
							LabelButton(L.CHANGEVERB,
								function()
									dialog.create(L.VCE_DEPRECATED, DBS.OKCANCEL,
										function(button)
											if button == DB.OK then
												playtesting_ask_path("VCE", false)
											end
										end
									)
								end,
								nil, nil,
								function()
									return true, playtesting_available
								end
							),
							LabelButton(L.RESET,
								function()
									s.vvvvvvce = ""
								end,
								nil, nil,
								function()
									return true, s.vvvvvvce ~= ""
								end
							),
						},
						{},
						nil, 16, VALIGN.TOP, 0, 8
					),
				},
				{},
				love.graphics.getWidth()-128, -- maybe make a container like RightBar for the left part
				nil,
				ALIGN.LEFT, 8+4, 8
			)
		}, {}, nil, nil, VALIGN.TOP
	),
	RightBar(
		{
			LabelButton(L.BTN_OK,
				function()
					saveconfig()
					if s.customvvvvvvdir ~= firstvvvvvvfolder then
						-- Immediately apply the new custom VVVVVV directory.
						setvvvvvvpaths()
						loadlevelsfolder()
					end
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
