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
	currentmusic = nil
	currentmusic_file = nil
	currentmusic_paused = false
	music_loaded = false
end

function loadvvvvvvmusics()
	loadvvvvvvmusic("vvvvvvmusic.vvv")
	loadvvvvvvmusic("mmmmmm.vvv")
	loadvvvvvvsounds()
	music["musiceditor"] = {}
	music_loaded = true
end

function unloadvvvvvvmusic(file)
	stopmusic()
	music[file] = nil
end

function loadvvvvvvmusic(file, realfile)
	-- file is the name to be stored in the table (one of vvvvvvmusic.vvv, mmmmmm.vvv, musiceditor or sounds)
	-- realfile is the actual path to load, if file is musiceditor.
	-- Filenames containing any directory separator will always be considered absolute.
	-- Thus, pass full paths wherever possible, unless you want to load vvvvvvmusic.vvv or mmmmmm.vvv.
	-- Returns success, errormessage.
	if file == "sounds" then
		return loadvvvvvvsounds()
	end

	errormessage = nil

	if realfile == nil then
		realfile = file
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

		local sum_mdlen = 0
		local md_possibly_valid = true
		local m_start = 1+sizeof_headers
		for m = 0, 127 do
			if not music_headers[m].valid then
				-- If one song is invalid, VVVVVV doesn't load the ones after
				break
			end

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
			loadmusicsong(file, m, ficontents:sub(m_start, m_end), false)
			m_start = m_end+1
		end

		local F_size = music_headers[127].start
		if md_possibly_valid and sum_mdlen + F_size == music_headers[127].size and F_size >= 2
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
						setmusicmeta_file(file, F_tip.export_time, unpack(strings))
					end

					-- Song metadata now.
					for m = 0, 127 do
						if not music_headers[m].valid then
							break
						end

						local m_end = m_start+music_headers[m].start-2
						local strings = explode("\0", ficontents:sub(m_start, m_end))
						m_start = m_end+2
						setmusicmeta_song(file, m, unpack(strings))
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

function loadvvvvvvsounds()
	music["sounds"] = {}

	for k,v in pairs(list_sound_ids) do
		local readsuccess, ficontents = readfile(soundsfolder .. dirsep .. v)
		if readsuccess then
			loadmusicsong("sounds", k, ficontents, false)
		end
	end

	return true
end

function loadmusicsong(file, song, data, edited)
	local m_filedata = love.filesystem.newFileData(data, "song" .. song .. (file == "sounds" and ".wav" or ".ogg"), "file")
	if m_filedata:getSize() <= 1 then
		-- Don't bother
		return
	end
	music[file][song] = {edited=edited, filedata=m_filedata, audio=nil}
	local m_success, maybe_source = pcall(love.audio.newSource, m_filedata, "stream")
	if not m_success then
		cons("Could not load song " .. song .. " from " .. file ..  " because " .. maybe_source)
	else
		music[file][song].audio = maybe_source
		if file ~= "sounds" and song ~= 0 and song ~= 7 then
			music[file][song].audio:setLooping(true)
		end
	end
end

function getmusicfiledata(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].filedata
end

function getmusicaudio(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].audio
end

function getmusicaudioplaying()
	if currentmusic_file == nil or currentmusic == nil then
		return
	end

	return getmusicaudio(currentmusic_file, currentmusic)
end

function getmusicedited(file, song)
	if music[file] == nil or music[file][song] == nil then
		return nil
	end

	return music[file][song].edited
end

function getmusicmeta_file(file)
	-- As second argument, returns whether any of the data is even set.
	if music[file] == nil or music[file].meta == nil then
		return nil, false
	end

	local anyset = false
	if music[file].meta.export_time ~= 0
	or music[file].meta.name ~= ""
	or music[file].meta.artist ~= ""
	or music[file].meta.notes ~= "" then
		anyset = true
	end

	return music[file].meta, anyset
end

function setmusicmeta_file(file, data_export_time, data_name, data_artist, data_notes)
	if music[file] == nil then
		return false
	end

	if music[file].meta == nil then
		music[file].meta = {
			export_tile = 0
		}
	end

	if data_export_time ~= nil then
		music[file].meta.export_time = data_export_time
	end
	music[file].meta.name = anythingbutnil(data_name)
	music[file].meta.artist = anythingbutnil(data_artist)
	music[file].meta.notes = anythingbutnil(data_notes)
end

function getmusicmeta_song(file, song)
	-- As second argument, returns whether any of the data is even set.
	if music[file] == nil or music[file].meta == nil or music[file].meta[song] == nil then
		return nil, false
	end

	local anyset = false
	if music[file].meta[song].name ~= ""
	or music[file].meta[song].filename ~= ""
	or music[file].meta[song].notes ~= "" then
		anyset = true
	end

	return music[file].meta[song], anyset
end

function setmusicmeta_song(file, song, data_name, data_filename, data_notes)
	if music[file] == nil then
		return false
	end

	if music[file].meta == nil then
		setmusicmeta_file(file, 0, "", "", "")
	end

	if music[file].meta[song] == nil then
		music[file].meta[song] = {
			name = "",
			filename = "",
			notes = ""
		}
	end

	if data_name ~= nil then
		music[file].meta[song].name = data_name
	end
	if data_filename ~= nil then
		music[file].meta[song].filename = data_filename
	end
	if data_notes ~= nil then
		music[file].meta[song].notes = data_notes
	end
end

function playmusic(file, song)
	stopmusic()

	local audio = getmusicaudio(file, song)
	if audio == nil then
		return false
	end

	audio:play()
	currentmusic_file = file
	currentmusic = song

	return true
end

function stopmusic()
	local audio = getmusicaudioplaying()
	if audio == nil then
		return
	end
	audio:stop()
	currentmusic_file = nil
	currentmusic = nil
	currentmusic_paused = false
end

function pausemusic()
	local audio = getmusicaudioplaying()
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

	local audio = getmusicaudioplaying()
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
end

function musicedit_replacesong(file, song, data)
	if currentmusic_file == file and currentmusic == song then
		stopmusic()
	end

	if music[file] == nil then
		music[file] = {}
	end

	return pcall(loadmusicsong, file, song, data, true)
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
		local filemeta = getmusicmeta_file(file)
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

	for m = 0, 15 do
		ffi.copy(music_headers[m].name, musicblobnames[m+1])
		local filedata = getmusicfiledata(file, m)
		if filedata == nil then
			music_headers[m].size = 1
		else
			music_headers[m].size = filedata:getSize()
		end
		music_headers[m].valid = true

		if savemetadata then
			local songmeta, anyset = getmusicmeta_song(file, m)
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

	-- Note that 16-126/127 will just be nulls, which is good
	local success, everr = multiwritefile_write(os_fh, ffi.string(music_headers, ffi.sizeof("resourceheader")*128))
	if not success then return false, everr end

	for m = 0, 15 do
		local filedata = getmusicfiledata(file, m)
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
