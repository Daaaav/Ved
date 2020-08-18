local ui = {name = "unreinfo"}

function ui.load()
	undostacktext = ""
	redostacktext = ""

	for k,v in pairs(undobuffer) do
		undostacktext = undostacktext .. v.undotype

		if v.undotype == "tiles" then
			undostacktext = undostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
		end

		undostacktext = undostacktext .. "\n"
	end

	for k,v in pairs(redobuffer) do
		redostacktext = redostacktext .. v.undotype

		if v.undotype == "tiles" then
			redostacktext = redostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
		end

		redostacktext = redostacktext .. "\n"
	end
end

ui.elements = {
	
}

function ui.draw()
	-- Dev/testing/debug state, not translated
	ved_print("Undo stack:\n" .. undostacktext, 8, 8)
	ved_print("Redo stack:\n" .. redostacktext, love.graphics.getWidth()/2 + 8, 8)
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
