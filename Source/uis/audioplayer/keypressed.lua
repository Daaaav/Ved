-- audioplayer/keypressed

return function(key)
	if key == "escape" then
		tostate(oldstate, true)
		if state == 30 then
			oldstate = olderstate
		end
		nodialog = false
	elseif key == " " or key == "space" or key == "kp5" then
		if currentmusic_paused then
			resumemusic()
		else
			pausemusic()
		end
	elseif musiceditor and key == "s" then
		assets_musicsavedialog()
	elseif musiceditor and key == "m" then
		assets_metadataeditordialog()
	elseif not musiceditor and file_metadata_anyset and key == "m" then
		assets_metadataplayerdialog()
	elseif musiceditor and key == "l" then
		assets_musicloaddialog()
	elseif not musiceditor and key == "l" then
		assets_musicreload()
	elseif key == "home" or key == "kp7" then
		local current_audio = music_get_audio_playing()
		if current_audio ~= nil then
			current_audio:seek(0)
		end
	elseif love_version_meets(10) and (key == "left" or key == "kp4" or key == "right" or key == "kp6") then
		local seconds = 0
		if key == "left" or key == "kp4" then
			seconds = -5
		elseif key == "right" or key == "kp6" then
			seconds = 5
		end
		if keyboard_eitherIsDown("shift") then
			seconds = seconds * 2
		end
		local current_audio = music_get_audio_playing()
		if current_audio ~= nil then
			local duration = current_audio:getDuration("seconds")
			if duration ~= nil and duration > 0 then
				local seek = math.max(current_audio:tell("seconds") + seconds, 0)
				if seek > duration then
					seek = 0
				end
				current_audio:seek(seek, "seconds")
			end
		end
	end
end
