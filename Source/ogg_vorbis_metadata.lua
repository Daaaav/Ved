local ffi = require("ffi")

function ogg_vorbis_metadata(filedata)
	-- Takes the raw file data of an Ogg Vorbis file, and gives some metadata we care about
	-- Relevant documentation:
	-- Ogg: https://datatracker.ietf.org/doc/html/rfc3533#section-6
	-- Vorbis: https://www.xiph.org/vorbis/doc/Vorbis_I_spec.html

	local data_size = filedata:getSize()
	local data_pointer
	if love_version_meets(11,3) then
		data_pointer = filedata:getFFIPointer()
	else
		data_pointer = filedata:getPointer()
	end
	data_pointer = ffi.cast("unsigned char *", data_pointer)
	local offset = 0

	local ogg_page_size_remaining = 0

	local audio_metadata = {comments={}}

	local function ogg_load_page()
		-- Set up information for the data location and size of the next Ogg page.
		-- Called when no data is remaining (that includes at the start of the file)
		-- The offset will be pointed to the start of the data, and ogg_page_size_remaining will be set.
		-- This is also where the file bounds checking is done - if there's not "enough file" left for
		-- the claimed page size, don't go beyond the end of the file.

		-- Just a sanity check
		if ogg_page_size_remaining ~= 0 then
			error("Illegal Ogg state: ogg_page_size_remaining should be 0 when loading a page!", 0)
		end

		-- An Ogg page header starts with 27 firm bytes
		if data_size - offset < 27 or ffi.string(data_pointer + offset, 4) ~= "OggS" then
			error("Ogg page doesn't have \"OggS\" magic or file is too short", 0)
		end
		offset = offset + 4

		-- Ogg version number, just to be future-proof
		if tonumber(data_pointer[offset]) ~= 0 then
			error("Ogg version is not 0", 0)
		end

		-- Jump to the segment table size
		offset = offset + 22
		local segment_table_size = tonumber(data_pointer[offset])
		offset = offset + 1

		-- And now we're at the segment table itself
		if data_size - offset < segment_table_size then
			error("File too short for segment table in Ogg page", 0)
		end
		-- Every byte in the segment table defines the length of a segment,
		-- though the exact breakdown doesn't matter for us. Probably.
		for s = 1, segment_table_size do
			ogg_page_size_remaining = ogg_page_size_remaining + tonumber(data_pointer[offset])
			offset = offset + 1
		end

		-- We should now be pointing to the actual data in this page, but is it fully there?
		if data_size - offset < ogg_page_size_remaining then
			error("File too short for data in Ogg page", 0)
		end
	end

	local function vorbis_read_bytes(size)
		-- Read `size` bytes of Vorbis data and advance the offset.
		-- Reads across Ogg pages if necessary
		-- Return char[size] of data
		local bytes = ffi.new("char[?]",size)

		local size_remaining = size
		while size_remaining > 0 do
			local copyable_size = math.min(size_remaining, ogg_page_size_remaining)
			if copyable_size > 0 then
				ffi.copy(
					bytes + (size-size_remaining),
					data_pointer + offset,
					copyable_size
				)
				size_remaining = size_remaining - copyable_size
				ogg_page_size_remaining = ogg_page_size_remaining - copyable_size
				offset = offset + copyable_size
			end
			if size_remaining > 0 then
				ogg_load_page()
			end
		end

		return bytes
	end

	local function vorbis_read_u32()
		return tonumber(ffi.cast("uint32_t *", vorbis_read_bytes(4))[0])
	end

	local function vorbis_read_u8()
		return tonumber(ffi.cast("uint8_t *", vorbis_read_bytes(1))[0])
	end

	local function read_all()
		-- The main decoding function, operating fully on the Vorbis layer.
		local need_more_vorbis_headers = true
		while need_more_vorbis_headers do
			local vorbis_packet_type = vorbis_read_u8()
			local vorbis_magic = vorbis_read_bytes(6)
			if ffi.string(vorbis_magic, 6) ~= "vorbis" then
				error("Vorbis header doesn't have \"vorbis\" magic", 0)
			end
			if vorbis_packet_type == 1 then
				-- Identification header. This contains some stuff like channel count, sample rate, etc.
				-- We could skip over this, but now we're here anyway, right?
				audio_metadata.vorbis_version = vorbis_read_u32()
				if audio_metadata.vorbis_version ~= 0 then
					error("Vorbis version is not 0", 0)
				end
				audio_metadata.audio_channels = vorbis_read_u8()
				audio_metadata.audio_sample_rate = vorbis_read_u32()
				audio_metadata.bitrate_maximum = vorbis_read_u32()
				audio_metadata.bitrate_nominal = vorbis_read_u32()
				audio_metadata.bitrate_minimum = vorbis_read_u32()
				audio_metadata.blocksizes = vorbis_read_u8()
				local framing_bit = vorbis_read_u8() % 2
				if framing_bit ~= 1 then
					error("Vorbis identification header framing bit is not set", 0)
				end
			elseif vorbis_packet_type == 3 then
				-- Comment header. This may contain interesting stuff, such as loop points.
				local vendor_length = vorbis_read_u32()
				local vendor_bytes = vorbis_read_bytes(vendor_length)
				audio_metadata.vendor_string = ffi.string(vendor_bytes, vendor_length)

				local n_comments = vorbis_read_u32()
				for c = 1, n_comments do
					local comment_length = vorbis_read_u32()

					local comment_bytes = vorbis_read_bytes(comment_length)
					local comment = ffi.string(comment_bytes, comment_length)

					-- Now match it: 0x20 through 0x7D excluding `=`, `=`, any text
					local key, value = comment:match("^([ -<>-}]*)=(.*)$")

					-- Maybe don't keep around album art? Otherwise we're good to go.
					if key ~= nil and key ~= "METADATA_BLOCK_PICTURE" and key ~= "COVERART" then
						table.insert(audio_metadata.comments, {key, value})
					end
				end
				local framing_bit = vorbis_read_u8() % 2
				if framing_bit ~= 1 then
					error("Vorbis comment header framing bit is not set", 0)
				end

				need_more_vorbis_headers = false
			else
				-- Unexpected header. 5 is also a thing (setup header), but we must encounter 3 *first*, and there we stop...
				need_more_vorbis_headers = false
			end
		end
	end

	local function parse_loop_time(value)
		-- In addition to samples, SDL_mixer supports (as of 2019) HH:MM:SS.mmm format

		if value:match("^%d+$") ~= nil then
			-- Just sample count
			return tonumber(value)
		end

		local h, m, s
		h, m, s = value:match("^(%d*):(%d*):([%d%.]*)$")
		if h == nil then
			h = 0
			m, s = value:match("^(%d*):([%d%.]*)$")
		end
		if m == nil then
			m = 0
			s = value:match("^([%d%.]*)$")
		end

		h, m, s = tonumber(h), tonumber(m), tonumber(s)
		if h == nil then h = 0 end
		if m == nil then m = 0 end
		if s == nil then s = 0 end

		return math.floor((h*3600 + m*60 + s) * audio_metadata.audio_sample_rate)
	end

	-- Call the main decoding function
	local status, err = pcall(read_all)
	if not status then
		cons("Ogg/Vorbis metadata error: " .. err)
	end

	-- Now check if we have loop points!
	local loop_start, loop_length, loop_end = 0, 0, 0
	local is_loop_length = false

	for k,v in pairs(audio_metadata.comments) do
		local key, value = v[1]:upper(), v[2]
		if key:sub(1,5) == "LOOP_" or key:sub(1,5) == "LOOP-" then
			key = "LOOP" .. key:sub(6,-1)
		end
		if key == "LOOPSTART" then
			loop_start = parse_loop_time(value)
		elseif key == "LOOPLENGTH" then
			loop_length = parse_loop_time(value)
			is_loop_length = true
		elseif key == "LOOPEND" then
			loop_end = parse_loop_time(value)
			is_loop_length = false
		end
	end

	if is_loop_length then
		loop_end = loop_start + loop_length
	else
		loop_length = loop_end - loop_start
	end

	-- Ignore invalid loop tag
	if loop_start < 0 or loop_length < 0 or loop_end < 0 then
		loop_start, loop_length, loop_end = 0, 0, 0
	end

	-- Possible todo: also check loop_end <= full_length
	if loop_end > 0 and loop_start < loop_end then
		audio_metadata.loop_start = loop_start
		audio_metadata.loop_length = loop_length
		audio_metadata.loop_end = loop_end
	end

	return audio_metadata
end
