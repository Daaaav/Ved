local ui = {name = "fsinfo"}

function ui.load(...)
end

ui.elements = {
	
}

function ui.draw()
	ved_print("Userprofile: " .. userprofile, 8, 8)

	ved_print(
		"Levels folder: " .. anythingbutnil(levelsfolder) ..
		"\nGraphics folder: " .. anythingbutnil(graphicsfolder) ..
		"\nSounds folder: " .. anythingbutnil(soundsfolder),
		8, 32
	)
	ved_print(
		"Identity: " .. love.filesystem.getIdentity() .. 
		"\nSaveDirectory: " .. love.filesystem.getSaveDirectory(),
		8, 72
	)
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
