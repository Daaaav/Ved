-- A wrapper for a regular LÖVE Source
cVedSource =
{
	love_source = nil
}

function cVedSource:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function cVedSource:init(file, song)
	local success, maybe_source = pcall(love.audio.newSource, music[file][song].filedata, "stream")
	if not success then
		cons("Could not load song " .. song .. " from " .. file .. " because " .. maybe_source)
		return false
	end

	self.love_source = maybe_source

	if file ~= "sounds" and song ~= 0 and song ~= 7 then
		self.love_source:setLooping(true)
	end

	return true
end

function cVedSource:tell(unit)
	return self.love_source:tell(unit)
end

function cVedSource:seek(offset, unit)
	return self.love_source:seek(offset, unit)
end

function cVedSource:getDuration(unit)
	if not love_version_meets(10) then
		return nil
	end
	return self.love_source:getDuration(unit)
end

function cVedSource:play()
	return self.love_source:play()
end

function cVedSource:stop()
	return self.love_source:stop()
end

function cVedSource:pause()
	return self.love_source:pause()
end

function cVedSource:update()

end


--[[
	A wrapper for a LÖVE QueueableSource to have loop points with a regular Source-like interface.

	We have 3 buffers, and we only add the intro or the looping part in full.
	The buffer arrangement is either [intro][loop][loop], or [loop][loop].
	This allows us to recognize whether the intro or the loop is currently playing (via :getFreeBufferCount()).

	QueueableSources are also kinda quirky and a bit in need of more documentation:
	- :stop() is the only way to discard buffers, and this only works if it HAS played
	- :getDuration() gives the total length of all stored buffers, but doesn't reset after :stop()
	- :tell() and :seek() work with the currently-playing buffer, so position resets to 0 when going to the next buffer.
]]
cVedQueueableSource =
{
	love_sounddata = nil,
	love_queueablesource = nil,

	loop_start_samples = nil,
	loop_length_samples = nil,

	loop_start_sec = nil,
	loop_length_sec = nil,

	stopped = true,
}

function cVedQueueableSource:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function cVedQueueableSource:init(file, song)
	-- TODO: maybe use a Decoder instead of a SoundData so we only load SoundData when we actually play
	local success, maybe_sounddata = pcall(love.sound.newSoundData, music[file][song].filedata)
	if not success then
		cons("Could not load sounddata for song " .. song .. " from " .. file .. " because " .. maybe_sounddata)
		return false
	end

	self.love_sounddata = maybe_sounddata

	self.love_queueablesource = love.audio.newQueueableSource(
		self.love_sounddata:getSampleRate(),
		self.love_sounddata:getBitDepth(),
		self.love_sounddata:getChannelCount(),
		3
	)

	local n_samples = self.love_sounddata:getSampleCount()
	self.loop_start_samples = math.min(
		n_samples-1,
		music[file][song].audio_metadata.loop_start
	)
	self.loop_length_samples = math.min(
		n_samples-self.loop_start_samples,
		music[file][song].audio_metadata.loop_length
	)

	local sample_rate = self.love_sounddata:getSampleRate()
	self.loop_start_sec = self.loop_start_samples / sample_rate
	self.loop_length_sec = self.loop_length_samples / sample_rate

	return true
end

function cVedQueueableSource:tell(unit)
	if self.stopped then
		return 0
	end

	local offset
	if self.love_queueablesource:getFreeBufferCount() == 0 then
		offset = self.love_queueablesource:tell("samples")
	else
		offset = self.loop_start_samples + self.love_queueablesource:tell("samples")
	end

	if unit == nil or unit == "seconds" then
		return offset / self.love_sounddata:getSampleRate()
	end

	return offset
end

function cVedQueueableSource:seek(offset, unit)
	if self.stopped then
		-- Don't allow seeking in a stopped source
		return
	end

	if unit == nil or unit == "seconds" then
		-- Work with samples instead
		offset = math.floor(offset * self.love_sounddata:getSampleRate())
	end

	if self.love_queueablesource:getFreeBufferCount() >= 1 and offset < self.loop_start_samples then
		-- Already playing the loop, but seeking to intro
		self.love_queueablesource:stop()
		self:fillBuffers(true)
	elseif self.love_queueablesource:getFreeBufferCount() == 0 and offset >= self.loop_start_samples then
		-- Already playing the intro, but seeking to loop
		self.love_queueablesource:stop()
		self:fillBuffers(false)
	end

	if offset < self.loop_start_samples then
		-- Seeking to intro
		self.love_queueablesource:seek(offset, "samples")
	elseif offset >= self.loop_start_samples then
		-- Seeking to loop
		self.love_queueablesource:seek((offset-self.loop_start_samples) % self.loop_length_samples, "samples")
	end
end

function cVedQueueableSource:getDuration(unit)
	return self.love_sounddata:getDuration(unit)
end

function cVedQueueableSource:play()
	if not self.stopped then
		self.love_queueablesource:play()
		return true
	end

	local success = self:fillBuffers(true)
	if success then
		self.stopped = false
	end
	return success
end

function cVedQueueableSource:stop()
	self.love_queueablesource:stop()
	self.stopped = true
end

function cVedQueueableSource:pause()
	self.love_queueablesource:pause()
end

function cVedQueueableSource:update()
	if not self.stopped then
		self:fillBuffers(false)
	end
end

function cVedQueueableSource:samplesToBytes(samples)
	return samples * self.love_sounddata:getChannelCount() * self.love_sounddata:getBitDepth() / 8
end

function cVedQueueableSource:fillBuffers(intro)
	-- If intro: Queue one intro and loops to fill all buffers (0 left)
	-- Else: Queue loops to fill all but one buffers (1 left)
	-- Returns false if :play() fails

	local loop_start_bytes = self:samplesToBytes(self.loop_start_samples)
	local loop_length_bytes = self:samplesToBytes(self.loop_length_samples)
	local fill_to = 1

	if intro then
		self.love_queueablesource:queue(self.love_sounddata, 0, loop_start_bytes)
		fill_to = 0
	end

	local any_added = false
	while self.love_queueablesource:getFreeBufferCount() > fill_to do
		self.love_queueablesource:queue(self.love_sounddata, loop_start_bytes, loop_length_bytes)
		any_added = true
	end
	if any_added then
		-- If you run out of buffers, a QueueableSource stops automatically, even when calling :queue().
		return self.love_queueablesource:play()
	end

	return true
end
