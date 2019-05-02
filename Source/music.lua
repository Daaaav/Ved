local ffi = require("ffi")

ffi.cdef([[
	typedef struct _resourceheader
	{
		char name[48];
		int start; /* unused */
		int size;
		bool valid;
	} resourceheader;
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
	music["musiceditor"] = {}
	music_loaded = true
end

function unloadvvvvvvmusic(file)
	music[file] = nil
end

function loadvvvvvvmusic(file, realfile)
	-- file is the name to be stored in the table (one of vvvvvvmusic.vvv, mmmmmm.vvv or musiceditor)
	-- realfile is the actual path to load, if file is musiceditor
	-- Returns success, errormessage.
	errormessage = nil

	if realfile == nil then
		realfile = file
	end

	stopmusic()

	-- If status, then maybe_status2 is the inner function's status.
	-- If not status, then maybe_status2 is an error message.
	-- Blame pcall for this naming dilemma.
	local status, maybe_status2 = pcall(function()
		local fh, everr = io.open(levelsfolder:sub(1, -8) .. dirsep .. realfile, "rb") -- TODO: Use filefunc
		if fh == nil then
			cons("No " .. file .. ", " .. anythingbutnil(everr))
			unloadvvvvvvmusic(file)
			errormessage = everr
			return false
		end
		local ficontents = fh:read("*a")
		fh:close()

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

		local m_start = 1+sizeof_headers
		for m = 0, 127 do
			if not music_headers[m].valid then
				-- If one song is invalid, VVVVVV doesn't load the ones after
				break
			end

			local m_end = m_start+music_headers[m].size-1
			if m_end > ficontents_len then
				cons(file .. " abruptly ended at song " .. m)
				break
			end
			loadmusicsong(file, m, ficontents:sub(m_start, m_end), false)
			m_start = m_end+1
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

function loadmusicsong(file, song, data, edited)
	local m_filedata = love.filesystem.newFileData(
		data, "song" .. song .. ".ogg", "file"
	)
	music[file][song] = {edited=edited, filedata=m_filedata, audio=nil}
	if m_filedata:getSize() == 0 then
		-- Don't bother
		return
	end
	local m_success, maybe_source = pcall(love.audio.newSource, m_filedata, "stream")
	if not m_success then
		cons("Could not load song " .. song .. " from " .. file ..  " because " .. maybe_source)
	else
		music[file][song].audio = maybe_source
		if song ~= 0 and song ~= 7 then
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

function savevvvvvvmusic(file, realfile)
	-- Again, file is one of three possible values including "musiceditor", realfile is an actual filename
	local fh, everr = io.open(levelsfolder:sub(1, -8) .. dirsep .. realfile, "wb") -- same TODO as always
	if fh == nil then
		return false, everr
	end
	local music_headers = ffi.new("resourceheader[128]")
	for m = 0, 15 do
		ffi.copy(music_headers[m].name, musicblobnames[m+1])
		local filedata = getmusicfiledata(file, m)
		if filedata ~= nil then
			music_headers[m].size = filedata:getSize()
		end
		music_headers[m].valid = true
	end

	-- Note that 16-127 will just be nulls, which is good
	fh:write(ffi.string(music_headers, ffi.sizeof("resourceheader")*128))

	for m = 0, 15 do
		local filedata = getmusicfiledata(file, m)
		if filedata ~= nil then
			fh:write(filedata:getString())
		end
	end

	fh:close()

	return true
end
