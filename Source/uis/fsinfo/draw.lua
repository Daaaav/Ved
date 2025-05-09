-- fsinfo/draw

return function()
	font_8x8:print("Userprofile: " .. userprofile, 8, 8)

	font_8x8:print(
		"Levels folder: " .. anythingbutnil(levelsfolder) ..
		"\nGraphics folder: " .. anythingbutnil(graphicsfolder) ..
		"\nSounds folder: " .. anythingbutnil(soundsfolder),
		8, 32
	)
	font_8x8:print(
		"Identity: " .. love.filesystem.getIdentity() .. 
		"\nSaveDirectory: " .. love.filesystem.getSaveDirectory(),
		8, 72
	)
	font_8x8:print(
		"Source path: " .. love.filesystem.getSource() ..
		"\nSource base directory: " .. love.filesystem.getSourceBaseDirectory() ..
		"\nFused? " .. tostring(love.filesystem.isFused()),
		8, 104
	)
end
