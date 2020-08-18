local ui = {name = "overlapentinfo"}

function ui.load()
	overlappingentities = {}
	listoverlappingentities(overlappingentities)
	text21 = ""
	for k,v in pairs(overlappingentities) do
		text21 = text21 .. "Entity #" .. k .. " type " .. v.t .. " in room " .. (v.x/40) .. "," .. (v.y/30) .. "\n"
	end
end

ui.elements = {
	
}

function ui.draw()
	ved_print(text21, 8, 8)
end

function ui.update(dt)
end

function ui.keypressed(key)
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
