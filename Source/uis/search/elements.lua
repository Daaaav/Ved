-- search/elements

local recentsearches_els = {}

function recentsearches_update_elements()
	table.clear(recentsearches_els)
	table.insert(recentsearches_els, Text(L.RECENT_SEARCHES))

	for k,v in pairs(s.recentsearches) do
		table.insert(recentsearches_els, 2,
			LabelButton(
				v,
				function()
					inputs.search = v
					newinputsys.setpos("search", nil, true)
					do_search()
				end,
				nil, nil, nil,
				function()
					table.remove(s.recentsearches, k)
					saveconfig()
					recentsearches_update_elements()
				end,
				nil, 400
			)
		)
	end

	uis[state].drawn = false
end

return {
	IfContainer(
		function()
			return previous_search == "" and #s.recentsearches > 0
		end,
		AlignContainer(
			ScreenContainer(
				{
					ListContainer(
						recentsearches_els,
						{}, nil, nil, ALIGN.CENTER, 0, 8
					)
				}, 400, 200
			), ALIGN.CENTER, VALIGN.CENTER
		)
	),
	RightBar(
		{
			LabelButton(L.RETURN,
				function()
					newinputsys.close("search")
					tostate(1, true)
					if love.mouse.isDown("l") then
						-- TODO remove when state 1 is on GUI overhaul
						mousepressed = true
					end
				end,
				"b", hotkey("escape")
			),
		},
		{
		}
	),
}
