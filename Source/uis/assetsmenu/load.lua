-- assetsmenu/load

return function(show_level_assets)
	olderstate = oldstate
	assetsmenu_show_level_assets = show_level_assets
	assetsmenu_unsaved_level = false
	if show_level_assets then
		assetsmenu_vvvvvvfolder = levelsfolder .. dirsep .. editingmap
		assetsmenu_graphicsfolder = assetsmenu_vvvvvvfolder .. graphicsfolder_rel
		assetsmenu_soundsfolder = assetsmenu_vvvvvvfolder .. soundsfolder_rel
		assetsmenu_music_prefix = "level/"

		assetsmenu_unsaved_level = editingmap == "untitled\n"
	else
		assetsmenu_vvvvvvfolder = vvvvvvfolder
		assetsmenu_graphicsfolder = graphicsfolder
		assetsmenu_soundsfolder = soundsfolder
		assetsmenu_music_prefix = ""
	end

	assetsmenu_vvvvvvfolder_exists = false
	assetsmenu_graphicsfolder_exists = false
	assetsmenu_soundsfolder_exists = false
	assetsmenu_graphicsfolder_num = 0
	assetsmenu_soundsfolder_num = 0

	if not assetsmenu_unsaved_level then
		assetsmenu_vvvvvvfolder_exists = directory_exists(assetsmenu_vvvvvvfolder)
		assetsmenu_graphicsfolder_exists = directory_exists(assetsmenu_graphicsfolder)
		assetsmenu_soundsfolder_exists = directory_exists(assetsmenu_soundsfolder)

		if not musiceditorfolder_set then
			musiceditorfolder = assetsmenu_vvvvvvfolder
		end

		if not show_level_assets and not music_loaded then
			loadvvvvvvmusics()
		elseif show_level_assets and not level_music_loaded then
			loadvvvvvvmusics_level()
		end
	end

	if assetsmenu_graphicsfolder_exists then
		local success, files = listfiles_generic(assetsmenu_graphicsfolder, ".png", true)
		for k,file in pairs(files) do
			for k_image,image_name in pairs(list_graphics_files) do
				if file.name == image_name then
					assetsmenu_graphicsfolder_num = assetsmenu_graphicsfolder_num + 1
				end
			end
		end
	end

	if assetsmenu_soundsfolder_exists then
		local success, files = listfiles_generic(assetsmenu_soundsfolder, ".wav", true)
		for k,file in pairs(files) do
			for k_sound,sound_name in pairs(list_sound_ids) do
				if file.name == sound_name then
					assetsmenu_soundsfolder_num = assetsmenu_soundsfolder_num + 1
				end
			end
		end
	end
end
