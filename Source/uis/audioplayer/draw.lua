-- audioplayer/draw

return function()
	if musiceditor then
		if musiceditorfile == "" then
			ved_print(L.MUSICEDITOR, 16, 12)
		else
			ved_print(L.MUSICEDITOR .. " - " .. musiceditorfile, 16, 12)
		end
	elseif soundviewer then
		ved_print(L.SOUNDS, 16, 12)
	else
		ved_print(musicplayerfile, 16, 12)
	end
	file_metadata, file_metadata_anyset = getmusicmeta_file(musicplayerfile)
	local musicnamex_offset
	if musiceditor then
		musicnamex_offset = 76
	elseif file_metadata ~= nil then
		musicnamex_offset = 44
	else
		musicnamex_offset = 28
	end
	for mx = 0, (soundviewer and 1 or 0) do
		local musicx = mx == 0 and 16 or 396
		local musicnamex = musicx + musicnamex_offset
		local musicsizerx = soundviewer and musicx+316 or musicx+680
		local musicdurationx = soundviewer and musicx+332 or musicx+712
		if s.psmallerscreen and not soundviewer then
			musicsizerx = musicsizerx - 128 + 16
			musicdurationx = musicdurationx - 128 + 16
		end
		for my = 0, 15 do
			local m = mx*16 + my
			if (soundviewer and m > 27) or (not soundviewer and m > 15) then
				break
			end
			local audio = getmusicaudio(musicplayerfile, m)
			if audio == nil then
				love.graphics.setColor(64,64,64)
				love.graphics.draw(image.sound_play, musicx, 32+24*my)
				love.graphics.setColor(255,255,255)
			elseif currentmusic_file == musicplayerfile and currentmusic == m then
				hoverdraw(image.sound_play_current, musicx, 32+24*my, 16, 16)
			else
				hoverdraw(image.sound_play, musicx, 32+24*my, 16, 16)
			end
			local song_metadata, song_metadata_anyset
			if musiceditor or file_metadata ~= nil then
				song_metadata, song_metadata_anyset = getmusicmeta_song(musicplayerfile, m)
				if not musiceditor and not song_metadata_anyset then
					love.graphics.setColor(64,64,64)
					love.graphics.draw(image.infograybtn, musicx+16, 32+24*my)
					love.graphics.setColor(255,255,255)
				else
					local notes_set = song_metadata_anyset and song_metadata.notes ~= ""
					hoverdraw(notes_set and image.infobtn or image.infograybtn, musicx+16, 32+24*my, 16, 16)
				end
			end
			local can_remove = false
			local filedata = getmusicfiledata(musicplayerfile, m)
			if musiceditor then
				can_remove = filedata ~= nil
				hoverdraw(image.loadbtn, musicx+32, 32+24*my, 16, 16)
				if not can_remove then
					love.graphics.setColor(64,64,64)
					love.graphics.draw(image.eraser, musicx+48, 32+24*my)
					love.graphics.setColor(255,255,255)
				else
					hoverdraw(image.eraser, musicx+48, 32+24*my, 16, 16)
				end
			end
			if love.mouse.isDown("l") and not mousepressed and nodialog then
				if mouseon(musicx, 32+24*my, 16, 16) then
					-- Play
					if audio == nil then
						dialog.create(soundviewer and L.SOUNDPLAYERROR or L.MUSICPLAYERROR)
					else
						playmusic(musicplayerfile, m)
						mousepressed = true
					end
				elseif musiceditor and mouseon(musicx+16, 32+24*my, 16, 16) then
					-- Song metadata (editor)
					input = m
					dialog.create(
						"",
						DBS.OKCANCEL,
						dialog.callback.songmetadata,
						langkeys(L.SONGMETADATA, {m}),
						dialog.form.songmetadata_make(song_metadata)
					)
				elseif song_metadata_anyset and mouseon(musicx+16, 32+24*my, 16, 16) then
					-- Song metadata (player)
					dialog.create(
						L.MUSICTITLE .. song_metadata.name .. "\n\n"
						.. L.MUSICFILENAME .. song_metadata.filename .. "\n\n"
						.. L.MUSICNOTES .. "\n" .. song_metadata.notes
					)
				elseif musiceditor and mouseon(musicx+32, 32+24*my, 16, 16) then
					-- Replace
					input = m
					dialog.create(
						"",
						DBS.LOADCANCEL,
						dialog.callback.replacesong,
						langkeys(L.INSERTSONG, {m}),
						dialog.form.files_make(userprofile, "", ".ogg", true, 11)
					)
				elseif can_remove and mouseon(musicx+48, 32+24*my, 16, 16) then
					-- Remove
					input = m
					dialog.create(langkeys(L.SUREDELETESONG, {m}), DBS.YESNO, dialog.callback.suredeletesong)
				end
			end
			if getmusicedited(musicplayerfile, m) then
				love.graphics.setColor(255,0,0)
			end
			if soundviewer then
				ved_print(
					"[" .. fixdig(m, 2) .. "] " .. listsoundids[m]:sub(1, -5),
					musicnamex, 36+24*my
				)
			else
				ved_print(
					"[" .. fixdig(m, 2) .. "] " .. (m == 0 and "Path Complete" or listmusicids[m]),
					musicnamex, 36+24*my
				)
			end
			if song_metadata_anyset then
				local shown_name
				if song_metadata.name == "" then
					shown_name = song_metadata.filename
				else
					shown_name = song_metadata.name
				end
				love.graphics.setScissor(musicnamex+248, 36+24*my, 256, 8)
				ved_print(shown_name, musicnamex+248, 36+24*my)
				love.graphics.setScissor()
			end
			if not love_version_meets(10) then
				ved_print("?:??", musicdurationx, 36+24*my)
			elseif audio == nil then
				ved_print("-:--", musicdurationx, 36+24*my)
			else
				ved_print(mmss_duration(audio:getDuration()), musicdurationx, 36+24*my)
			end
			if filedata ~= nil then
				local readable_size = bytes_notation(filedata:getSize())
				love.graphics.setColor(128,128,128)
				ved_print(readable_size, musicsizerx-font8:getWidth(readable_size), 36+24*my)
			end
			love.graphics.setColor(255,255,255)
		end
	end

	local current_audio = getmusicaudioplaying()
	local cura_y = love.graphics.getHeight()-32
	local width = 568
	if s.psmallerscreen then
		width = width - 128 + 16
	end
	if current_audio == nil then
		love.graphics.setColor(64,64,64)
		love.graphics.draw(image.sound_play, 16, cura_y)
		love.graphics.draw(image.sound_stop, 32, cura_y)
		love.graphics.draw(image.sound_rewind, 48, cura_y)
		ved_print("[--] -:--", 72, cura_y+4)
		love.graphics.rectangle("fill", 152, cura_y+4, width, 8)
		ved_print("-:--", width+160, cura_y+4)
		love.graphics.setColor(255,255,255)
	else
		hoverdraw(currentmusic_paused and image.sound_play or image.sound_pause, 16, cura_y, 16, 16)
		hoverdraw(image.sound_stop, 32, cura_y, 16, 16)
		hoverdraw(image.sound_rewind, 48, cura_y, 16, 16)
		local elapsed = current_audio:tell()
		local duration
		if love_version_meets(10) then
			duration = current_audio:getDuration()
		end
		if duration ~= nil and duration ~= 0 then
			-- LÖVE can sometimes fail to reset the time to 0 when looping if we started playing close to the end
			elapsed = elapsed % duration
		end
		ved_print("[" .. fixdig(currentmusic, 2) .. "] " .. mmss_duration(elapsed), 72, cura_y+4)
		if nodialog and not mousepressed and love.mouse.isDown("l") then
			if mouseon(16, cura_y, 16, 16) then
				-- Play/pause
				if currentmusic_paused then
					resumemusic()
				else
					pausemusic()
				end
				mousepressed = true
			elseif mouseon(32, cura_y, 16, 16) then
				-- Stop
				stopmusic()
				mousepressed = true
			elseif mouseon(48, cura_y, 16, 16) then
				-- Rewind
				current_audio:seek(0)
				mousepressed = true
			end
		end
		love.graphics.setColor(128,128,128)
		love.graphics.rectangle("fill", 152, cura_y+4, width, 8)
		love.graphics.setColor(255,255,255)
		if duration ~= nil and duration ~= 0 then
			love.graphics.rectangle("fill", 152, cura_y+4, (elapsed/duration)*width, 8)
			if nodialog and not mousepressed and mouseon(152, cura_y+4, width, 8) then
				local mouse_elapsed = ((love.mouse.getX()-152)/width)*duration
				ved_print(mmss_duration(mouse_elapsed), love.mouse.getX()-16, cura_y-10)
				if love.mouse.isDown("l") then
					current_audio:seek(mouse_elapsed)
					mousepressed = true
				end
			end
		end
		ved_print(mmss_duration(duration), width+160, cura_y+4)
		showhotkey(" ", 16+16, cura_y-2, ALIGN.RIGHT)
		showhotkey("h", 48+16, cura_y-2, ALIGN.RIGHT)
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)
	rbutton({musiceditor and L.LOAD or (musicfileexists(musicplayerfile) and L.RELOAD or L.LOAD), "L"}, 2, nil, true, nil, generictimer_mode == 1 and generictimer > 0)
	if musiceditor then
		rbutton({L.SAVE, "S"}, 3, nil, true)
	end
	if musiceditor then
		rbutton({L.MUSICFILEMETADATA, "M"}, 5, nil, true)
	elseif file_metadata_anyset then
		rbutton({L.MUSICFILEMETADATA, "M"}, 4, nil, true)
	end

	if nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(30, true)
			oldstate = olderstate
			mousepressed = true
		elseif onrbutton(2, nil, true) then
			-- Reload/Load
			if musiceditor then
				assets_musicloaddialog()
			else
				assets_musicreload()
			end
			mousepressed = true
		elseif musiceditor and onrbutton(3, nil, true) then
			-- Save
			assets_savedialog()
		elseif musiceditor and onrbutton(5, nil, true) then
			-- File metadata (editor)
			assets_metadataeditordialog()
		elseif not musiceditor and file_metadata_anyset and onrbutton(4, nil, true) then
			-- File metadata (player)
			assets_metadataplayerdialog()
		end
	elseif nodialog and love.mouse.isDown("r") and onrbutton(2, nil, true) and musicfileexists(musicplayerfile) then
		-- Reload right click menu
		rightclickmenu.create({"#" .. musicplayerfile, L.UNLOAD}, "assets_music_load")
	end
end
