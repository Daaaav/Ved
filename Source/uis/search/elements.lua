-- search/elements

return {
	RightBar(
		{
			LabelButton(L.RETURN,
				function()
					newinputsys.close("search")
					tostate(1, true)
					if love.mouse.isDown("l") then
						-- Trade the one ugly code for the other TEMPORARY ugly code, TODO remove when state 1 is on GUI overhaul
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
