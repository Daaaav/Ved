local ui = {name = "pluralformstest"}

function ui.load()
	plural_test = {val = 1}
end

ui.elements = {
}

function ui.draw()
	int_control(20, 20, "val", 0, 9999, nil, plural_test)
	ved_print(langkeys(L_PLU.NUMUNSUPPORTEDPLUGINS, {plural_test.val}), 20, 70)
	ved_print(langkeys(L_PLU.ROOMINVALIDPROPERTIES, {0, 0, plural_test.val}, 3), 20, 100)

	if nodialog and love.mouse.isDown("l") then
		-- Shrug
		mousepressed = true
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
end

function ui.mousereleased(x, y, button)
end

return ui
