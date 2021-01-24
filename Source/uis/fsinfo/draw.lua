-- fsinfo/draw

return function()
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
