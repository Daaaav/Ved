local ui = {name = "search"}

function ui.load()
	if not resume_search then
		previous_search = ""
		searchscripts = {}; searchrooms = {}; searchnotes = {}
		showresults = math.huge
		searchscroll = 0
		longestsearchlist = 0
	else
		resume_search = false
	end
	newinputsys.create(INPUT.ONELINE, "search", previous_search)
end

-- Any "UI elements" that need to be drawn in that order.
-- UI elements can be little things like buttons, but also entire drawing functions.
ui.elements = {
	DrawingFunction(drawsearch),
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

-- Just some functions called by their respective main callbacks.
function ui.draw()
end

function ui.update(dt)
end

function ui.keypressed(key)
	if table.contains({"return", "kpenter"}, key) then
		searchscripts, searchrooms, searchnotes = searchtext(inputs.search)
		previous_search = inputs.search
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
