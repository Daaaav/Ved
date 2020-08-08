local ui = {name = "dialogtest"}

function ui.load()
end

ui.elements = {
	
}

function ui.draw()
	vvvvvv_textbox("cyan", 0, 25, {"Cyan"})
	vvvvvv_textbox("red", 0, 50, {"Red"})
	vvvvvv_textbox("yellow", 0, 75, {"Yellow"})
	vvvvvv_textbox("green", 0, 100, {"Green"})
	vvvvvv_textbox("blue", 0, 125, {"Blue"})
	vvvvvv_textbox("purple", 0, 150, {"Purple"})
	vvvvvv_textbox("gray", 0, 175, {"Gray"})

	for k,v in pairs(vvvvvv_textboxes) do
		vvvvvv_textbox(unpack(v))
	end
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
	if button == "r" then
		rightclickmenu.create({"Delete", "Edit script", "Rename"}, "1")
	elseif button == "l" and nodialog then
		tbx, tby = math.floor((x-screenoffset)/2), math.floor(y/2)
		table.insert(vvvvvv_textboxes, {({"cyan", "red", "yellow", "green", "blue", "purple", "gray"})[math.random(1,7)], tbx, tby, {"Text!", tbx .. "," .. tby}})
	end
end

function ui.mousereleased(x, y, button)
end

return ui
