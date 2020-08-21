local ui = {name = "state0"}

function ui.load(...)
end

ui.elements = {
	
}

function ui.draw()
	ved_print("Placeholder main menu. Enter state: " .. input .. __ .. "\n\n\n\n\n\n\n\nENTER: Go\nShift+ENTER: Go without loadstate() (tostate(x, true))", 10, 10)

	local state_y = 16
	for k,v in pairs(uis) do
		ved_print(k .. " - " .. v.name, love.graphics.getWidth()-280, state_y)
		state_y = state_y + 10
	end

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
