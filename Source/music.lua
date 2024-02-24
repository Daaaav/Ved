ved_require("ogg_vorbis_metadata")
ved_require("music_vedsource")

local ffi = require("ffi")

ffi.cdef([[
	typedef struct _resourceheader
	{
		char name[48];
		int start; /* unused */
		int size;
		bool valid;
	} resourceheader;

	typedef struct _F_tip_short
	{
		uint8_t ver_minor;
		uint8_t ver_major;
	} F_tip_short;

	typedef struct _F_tip_long
	{
		uint8_t ver_minor;
		uint8_t ver_major;
		uint32_t export_time;
	} F_tip_long;
]])

function initvvvvvvmusic()
	music = {}
	music["musiceditor"] = {last_valid = 15}
	currentmusic = nil
	currentmusic_file = nil
	currentmusic_paused = false
	music_loaded = false
	level_music_loaded = false
end

function loadvvvvvvmusics()
	loadvvvvvvmusic("vvvvvvmusic.vvv")
	loadvvvvvvmusic("mmmmmm.vvv")
	loadvvvvvvsounds(false)
	music_loaded = true
end

function loadvvvvvvmusics_level()
	loadvvvvvvmusic("level/vvvvvvmusic.vvv")
	loadvvvvvvmusic("level/mmmmmm.vvv")
	loadvvvvvvsounds(true)
	level_music_loaded = true
end

function unloadvvvvvvmusic(file)
	stopmusic()
	music[file] = nil
end

function unloadvvvvvvmusics()
	if not music_loaded then
		return
	end

	if musicfileexists("vvvvvvmusic.vvv") then
		unloadvvvvvvmusic("vvvvvvmusic.vvv")
	end
	if musicfileexists("mmmmmm.vvv") then
		unloadvvvvvvmusic("mmmmmm.vvv")
	end
	unloadvvvvvvmusic("sounds")

	music_loaded = false
end

function unloadvvvvvvmusics_level()
	if not level_music_loaded then
		return
	end

	if musicfileexists("level/vvvvvvmusic.vvv") then
		unloadvvvvvvmusic("level/vvvvvvmusic.vvv")
	end
	if musicfileexists("level/mmmmmm.vvv") then
		unloadvvvvvvmusic("level/mmmmmm.vvv")
	end
	unloadvvvvvvmusic("level/sounds")

	level_music_loaded = false
end

local musicblobnames = {
	"data/music/0levelcomplete.ogg",
	"data/music/1pushingonwards.ogg",
	"data/music/2positiveforce.ogg",
	"data/music/3potentialforanything.ogg",
	"data/music/4passionforexploring.ogg",
	"data/music/5intermission.ogg",
	"data/music/6presentingvvvvvv.ogg",
	"data/music/7gamecomplete.ogg",
	"data/music/8predestinedfate.ogg",
	"data/music/9positiveforcereversed.ogg",
	"data/music/10popularpotpourri.ogg",
	"data/music/11pipedream.ogg",
	"data/music/12pressurecooker.ogg",
	"data/music/13pacedenergy.ogg",
	"data/music/14piercingthesky.ogg",
	"data/music/predestinedfatefinallevel.ogg",
}

function loadvvvvvvmusic(file, realfile)
	-- file is the name to be stored in the table
	-- (one of vvvvvvmusic.vvv, mmmmmm.vvv, musiceditor, sounds,
	-- level/vvvvvvmusic.vvv, level/mmmmmm.vvv, or level/sounds.)
	-- realfile is the actual path to load, if file is musiceditor or a level/ path.
	-- Filenames containing any directory separator will always be considered absolute.
	-- Thus, pass full paths wherever possible, unless you want to load vvvvvvmusic.vvv or mmmmmm.vvv.
	-- Returns success, errormessage.
	if file == "sounds" then
		return loadvvvvvvsounds(false)
	elseif file == "level/sounds" then
		return loadvvvvvvsounds(true)
	end

	errormessage = nil

	if realfile == nil then
		if file:sub(1, 6) == "level/" then
			realfile = assetsmenu_vvvvvvfolder .. dirsep .. file:sub(7)
		else
			realfile = file
		end
	end

	stopmusic()

	-- If status, then maybe_status2 is the inner function's status.
	-- If not status, then maybe_status2 is an error message.
	-- Blame pcall for this naming dilemma.
	local status, maybe_status2 = pcall(function()
		if realfile:find(dirsep, 1, true) == nil then
			realfile = vvvvvvfolder .. dirsep .. realfile
		end
		local readsuccess, ficontents = readfile(realfile)
		if not readsuccess then
			cons("No " .. file .. ", " .. anythingbutnil(ficontents))
			unloadvvvvvvmusic(file)
			errormessage = ficontents
			return false
		end

		music[file] = {}

		local music_headers = ffi.new("resourceheader[128]")
		local sizeof_headers = ffi.sizeof("resourceheader")*128
		local ficontents_len = ficontents:len()

		if ficontents_len < sizeof_headers then
			cons(file .. " is way too small")
			errormessage = L.MUSICLOADERROR_TOOSMALL
			return false
		end

		ffi.copy(music_headers, ficontents, sizeof_headers)

		-- First do some boring validation steps on the headers so we don't have to later
		local last_name_char = ffi.sizeof(music_headers[0].name)-1
		for m = 0, 127 do
			-- "/* Name can be stupid, just needs to be terminated */"
			music_headers[m].name[last_name_char] = 0

			if music_headers[m].size < 1 then
				music_headers[m].valid = false
			end
		end

		-- 2.3: All valid headers are considered, an invalid header no longer terminates the list.
		-- First all named songs are looked up and added to the songs vector,
		-- then all remaining (unrecognized) songs are added to the end of this vector.
		-- So, we first make a mapping from header index to the resulting vector index. (-1 is null)
		-- Ved will use and save with the vector index because there's no reason to do anything else
		local vector_mapping = ffi.new("int8_t[128]", -1)
		local next_vector_index = 0
		for k,v in pairs(musicblobnames) do
			for m = 0, 127 do
				if music_headers[m].valid and vector_mapping[m] == -1
				and ffi.string(music_headers[m].name) == v then
					vector_mapping[m] = next_vector_index
					next_vector_index = next_vector_index + 1
					break
				end
			end
		end
		-- Now the unnamed songs
		for m = 0, 127 do
			if music_headers[m].valid and vector_mapping[m] == -1 then
				vector_mapping[m] = next_vector_index
				next_vector_index = next_vector_index + 1
			end
		end

		music[file].last_valid = next_vector_index - 1

		local sum_mdlen = 0
		local md_possibly_valid = true
		local m_start = 1+sizeof_headers
		for m = 0, 127 do
			-- If this song is valid, we gave it a vector mapping
			if vector_mapping[m] ~= -1 then
				if m_start > ficontents_len then
					cons("Song " .. m .. " in " .. file .. " is completely out of range")
					md_possibly_valid = false
					break
				end

				if music_headers[m].start < 0 or music_headers[m].start > 0xFFFFFF then
					md_possibly_valid = false
				else
					sum_mdlen = sum_mdlen + music_headers[m].start
				end

				local m_end = m_start+music_headers[m].size-1
				if m_end > ficontents_len then
					cons(file .. " abruptly ended at song " .. m)
					m_end = ficontents_len
				end
				loadmusicsong(file, vector_mapping[m], ficontents:sub(m_start, m_end), false)
				m_start = m_end+1
			end
		end

		local F_size = music_headers[127].start
		if md_possibly_valid and not music_headers[127].valid
		and sum_mdlen + F_size == music_headers[127].size and F_size >= 2
		and m_start+sum_mdlen+F_size > ficontents_len then
			-- Okay, metadata seems to be valid.
			local F_long, sizeof_F_tip
			local F_tip
			if F_size == 2 then
				-- Short file metadata format
				F_long, sizeof_F_tip = false, ffi.sizeof("F_tip_short")
				F_tip = ffi.new("F_tip_short")
			else
				-- Long file metadata format
				F_long, sizeof_F_tip = true, ffi.sizeof("F_tip_long")
				F_tip = ffi.new("F_tip_long")
			end

			if F_size >= sizeof_F_tip then
				local m_end = m_start+sizeof_F_tip-1
				ffi.copy(F_tip, ficontents:sub(m_start, m_end), sizeof_F_tip)
				m_start = m_end+1

				if F_tip.ver_major <= 1 then
					-- Okay now extra metadata should really be valid.
					if F_long then
						-- We weren't done with that file metadata yet!
						local m_end = m_start+(F_size-sizeof_F_tip)-2
						local strings = explode("\0", ficontents:sub(m_start, m_end))
						m_start = m_end+2
						music_set_file_vvv_metadata(file, F_tip.export_time, unpack(strings))
					end

					-- Song metadata now.
					for m = 0, 127 do
						if vector_mapping[m] ~= -1 then
							local m_end = m_start+music_headers[m].start-2
							local strings = explode("\0", ficontents:sub(m_start, m_end))
							m_start = m_end+2
							music_set_song_vvv_metadata(file, vector_mapping[m], unpack(strings))
						end
					end
				end
			end
		else
			cons("[DEBUG] EXTRA METADATA NOT BEING LOADED PROBABLY BECAUSE OF one of the following things:")
			cons("sum_mdlen + F_size = " .. (sum_mdlen + F_size) .. ", music_headers[127].size = " .. music_headers[127].size)
			cons("m_start+sum_mdlen = " .. (m_start+sum_mdlen) .. ", ficontents_len+1 = " .. (ficontents_len+1))
		end

		return true
	end)

	if not status then
		cons("Couldn't load " .. file .. " because " .. anythingbutnil(maybe_status2))
		errormessage = maybe_status2
	end

	local success = status and maybe_status2
	if success then
		cons("Successfully loaded " .. file)
	end

	return success, errormessage
end

function loadvvvvvvsounds(is_level_assets)
	local file, folder_prefix
	if is_level_assets then
		file = "level/sounds"
		folder_prefix = assetsmenu_soundsfolder .. dirsep
	else
		file = "sounds"
		folder_prefix = soundsfolder .. dirsep
	end
	music[file] = {last_valid = 27}

	for k,v in pairs(list_sound_ids) do
		local readsuccess, ficontents = readfile(folder_prefix .. v)
		if readsuccess then
			loadmusicsong(file, k, ficontents, false)
		end
	end

	return true
end

function loadmusicsong(file, song, data, edited)
	local is_ogg = data:sub(1,4) == "OggS"
	local m_filedata = love.filesystem.newFileData(data, "song" .. song .. (is_ogg and ".ogg" or ".wav"), "file")
	if m_filedata:getSize() <= 1 then
		-- Don't bother
		return
	end
	local audio_metadata
	local is_sounds = file == "sounds" or file == "level/sounds"
	if not is_sounds and is_ogg then
		audio_metadata = ogg_vorbis_metadata(m_filedata)
	else
		audio_metadata = {}
	end
	music[file][song] = {
		edited=edited,
		filedata=m_filedata,
		audio_metadata=audio_metadata,
		vvv_metadata=nil,
		audio=nil,
	}

	local vedsource
	if audio_metadata.loop_start ~= nil and love_version_meets(11) then
		vedsource = cVedQueueableSource:new()
	else
		vedsource = cVedSource:new()
	end
	local init_success = vedsource:init(file, song)
	if init_success then
		music[file][song].audio = vedsource
	end
end

function music_get_filedata(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].filedata
end

function music_get_audio(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].audio
end

function music_get_audio_playing()
	if currentmusic_file == nil or currentmusic == nil then
		return
	end

	return music_get_audio(currentmusic_file, currentmusic)
end

function music_get_edited(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].edited
end

function music_get_file_vvv_metadata(file)
	-- As second argument, returns whether any of the data is even set.
	if music[file] == nil or music[file].vvv_metadata == nil then
		return nil, false
	end

	local anyset = false
	if music[file].vvv_metadata.export_time ~= 0
	or music[file].vvv_metadata.name ~= ""
	or music[file].vvv_metadata.artist ~= ""
	or music[file].vvv_metadata.notes ~= "" then
		anyset = true
	end

	return music[file].vvv_metadata, anyset
end

function music_set_file_vvv_metadata(file, data_export_time, data_name, data_artist, data_notes)
	if music[file] == nil then
		return false
	end

	if music[file].vvv_metadata == nil then
		music[file].vvv_metadata = {
			export_tile = 0
		}
	end

	if data_export_time ~= nil then
		music[file].vvv_metadata.export_time = data_export_time
	end
	music[file].vvv_metadata.name = anythingbutnil(data_name)
	music[file].vvv_metadata.artist = anythingbutnil(data_artist)
	music[file].vvv_metadata.notes = anythingbutnil(data_notes)
end

function music_get_song_vvv_metadata(file, song)
	-- As second argument, returns whether any of the data is even set.
	if music[file] == nil or music[file].vvv_metadata == nil or music[file].vvv_metadata[song] == nil then
		return nil, false
	end

	local anyset = false
	if music[file].vvv_metadata[song].name ~= ""
	or music[file].vvv_metadata[song].filename ~= ""
	or music[file].vvv_metadata[song].notes ~= "" then
		anyset = true
	end

	return music[file].vvv_metadata[song], anyset
end

function music_set_song_vvv_metadata(file, song, data_name, data_filename, data_notes)
	if music[file] == nil then
		return false
	end

	if music[file].vvv_metadata == nil then
		music_set_file_vvv_metadata(file, 0, "", "", "")
	end

	if music[file].vvv_metadata[song] == nil then
		music[file].vvv_metadata[song] = {
			name = "",
			filename = "",
			notes = ""
		}
	end

	if data_name ~= nil then
		music[file].vvv_metadata[song].name = data_name
	end
	if data_filename ~= nil then
		music[file].vvv_metadata[song].filename = data_filename
	end
	if data_notes ~= nil then
		music[file].vvv_metadata[song].notes = data_notes
	end
end

function music_get_last_valid(file)
	if music[file] == nil or music[file].last_valid == nil then
		return -1
	end
	return music[file].last_valid
end

function music_calculate_last_valid(file)
	if music[file] == nil then
		return
	end

	-- What is the last valid song?
	-- In other words, from which song onward are no more songs valid?
	-- Always consider song 127 invalid, at least for now (for metadata)
	-- Always consider songs 0-15 valid (for historical reasons, but this is debatable)
	local last_valid = 15
	for m = 126, 16, -1 do
		if music_get_filedata(file, m) ~= nil then
			last_valid = m
			break
		end
	end
	music[file].last_valid = last_valid
	return last_valid
end

function playmusic(file, song)
	stopmusic()

	local audio = music_get_audio(file, song)
	if audio == nil then
		return false
	end

	if audio:play() then
		currentmusic_file = file
		currentmusic = song
		return true
	end

	return false
end

function stopmusic()
	local audio = music_get_audio_playing()
	if audio == nil then
		return
	end
	audio:stop()
	currentmusic_file = nil
	currentmusic = nil
	currentmusic_paused = false
end

function pausemusic()
	local audio = music_get_audio_playing()
	if audio == nil then
		return
	end
	audio:pause()
	currentmusic_paused = true
end

function resumemusic()
	if not currentmusic_paused then
		return false
	end

	local audio = music_get_audio_playing()
	if audio == nil then
		return false
	end
	audio:play()
	currentmusic_paused = false
	return true
end

function musicfileexists(file)
	return music[file] ~= nil
end

function musicedit_deletesong(file, song)
	if music[file] == nil then
		return
	end

	if currentmusic_file == file and currentmusic == song then
		stopmusic()
	end

	music[file][song] = nil

	music_calculate_last_valid(file)
end

function musicedit_replacesong(file, song, data)
	if currentmusic_file == file and currentmusic == song then
		stopmusic()
	end

	if music[file] == nil then
		music[file] = {}
	end

	local success, err = pcall(loadmusicsong, file, song, data, true)

	music_calculate_last_valid(file)

	return success, err
end

function savevvvvvvmusic(file, realfile, savemetadata)
	-- Again, file is one of three possible values including "musiceditor", realfile is an actual filename
	local success, os_fh = multiwritefile_open(realfile)
	if not success then
		return false, os_fh -- os_fh is error message here
	end
	local music_headers = ffi.new("resourceheader[128]")

	local metadatablobtable
	if savemetadata then
		local F_tip = ffi.new("F_tip_long")
		F_tip.ver_minor = 0
		F_tip.ver_major = 1
		F_tip.export_time = os.time()
		local name, artist, notes
		local filemeta = music_get_file_vvv_metadata(file)
		if filemeta ~= nil then
			name = filemeta.name
			artist = filemeta.artist
			notes = filemeta.notes
		end
		-- This thing will be fully concatenated at the end.
		metadatablobtable = {
			ffi.string(F_tip, ffi.sizeof("F_tip_long")),
			anythingbutnil(name), "\0", anythingbutnil(artist), "\0", anythingbutnil(notes), "\0"
		}
		music_headers[127].start = table.concat(metadatablobtable):len()
	end

	local last_valid = music_calculate_last_valid(file)

	for m = 0, last_valid do
		if m <= 15 then
			ffi.copy(music_headers[m].name, musicblobnames[m+1])
		end
		local filedata = music_get_filedata(file, m)
		if filedata == nil then
			music_headers[m].size = 1
		else
			music_headers[m].size = filedata:getSize()
		end
		music_headers[m].valid = true

		if savemetadata then
			local songmeta, anyset = music_get_song_vvv_metadata(file, m)
			if songmeta ~= nil and anyset then
				local data = anythingbutnil(songmeta.name) .. "\0"
					.. anythingbutnil(songmeta.filename) .. "\0"
					.. anythingbutnil(songmeta.notes) .. "\0"
				table.insert(metadatablobtable, data)
				music_headers[m].start = data:len()
			end
		end
	end

	local metadatablob
	if savemetadata then
		metadatablob = table.concat(metadatablobtable)
		music_headers[127].size = metadatablob:len()
	end

	-- Note that unset/invalid headers will just be nulls, which is good
	local success, everr = multiwritefile_write(os_fh, ffi.string(music_headers, ffi.sizeof("resourceheader")*128))
	if not success then return false, everr end

	for m = 0, last_valid do
		local filedata = music_get_filedata(file, m)
		local write
		if filedata == nil then
			write = "\0"
			cons("Song " .. m .. " has nil filedata! So writing one null byte.")
		else
			write = filedata:getString()
		end
		local success, everr = multiwritefile_write(os_fh, write)
		if not success then return false, everr end
	end

	if savemetadata then
		local success, everr = multiwritefile_write(os_fh, metadatablob)
		if not success then return false, everr end
	end

	multiwritefile_close(os_fh)

	return true
end
