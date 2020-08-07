local ui = {name = "state0"}

function ui.load(...)
end

ui.elements = {
	
}

function ui.draw()
	ved_print("Placeholder main menu. Enter state: " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 10)
	startinputonce()
end

function ui.update(dt)
end

function ui.keypressed(key)
	if table.contains({"return", "kpenter"}, key) then
		stopinput()
		tostate(input, keyboard_eitherIsDown("shift"))
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
