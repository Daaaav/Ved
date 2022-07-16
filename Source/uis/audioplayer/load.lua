-- audioplayer/load

return function(mode)
	musiceditor = false
	soundviewer = false
	if mode == "musiceditor" then
		musiceditor = true
		if musiceditorfile_forcevvvvvvfolder then
			musicplayerfile = musiceditorfile
		else
			musicplayerfile = "musiceditor"
		end
	elseif mode == "sounds" or mode == "level/sounds" then
		soundviewer = true
		musicplayerfile = mode
	else
		musicplayerfile = mode
	end

	music_page = 0
end
