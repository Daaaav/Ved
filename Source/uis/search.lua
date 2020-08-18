local ui = {name = "TEMPLATE"}

function ui.load()
	startinput()
	searchscripts = {}; searchrooms = {}; searchnotes = {}
	searchedfor = "moot"
	showresults = math.huge
	searchscroll = 0
	longestsearchlist = 0
end

-- Any "UI elements" that need to be drawn in that order.
-- UI elements can be little things like buttons, but also entire drawing functions.
ui.elements = {
	DrawingFunction(drawsearch),
}

-- Just some functions called by their respective main callbacks.
function ui.draw()
end

function ui.update(dt)
end

function ui.keypressed(key)
	if table.contains({"return", "kpenter"}, key) then
		searchscripts, searchrooms, searchnotes = searchtext(input .. input_r)
		searchedfor = input .. input_r
	elseif key == "escape" then
		stopinput()
		tostate(1, true)
		nodialog = false
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
