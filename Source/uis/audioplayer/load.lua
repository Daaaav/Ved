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
	elseif mode == "sounds" then
		soundviewer = true
		musicplayerfile = "sounds"
	else
		musicplayerfile = mode
	end
end
