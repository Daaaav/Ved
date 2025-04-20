--[[
	Usage example:

	local zip = cZipwriter:new{filename="/path/to/your.zip"}
	zip:add_file("one.txt", "wow", 3, true, os.time())
	zip:add_file("two.txt", "lol lol lol", 11, true, 1500000000)
	zip:finish()
]]

local ffi = require("ffi")

ffi.cdef([[
	/* Local file header */
	typedef struct __attribute__((__packed__)) _zip_lfh
	{
		char signature[4]; /* PK\3\4 */
		uint16_t version_needed;
		uint16_t flags;
		uint16_t compression;
		uint16_t mod_time;
		uint16_t mod_date;
		uint32_t crc32;
		uint32_t compressed_size;
		uint32_t uncompressed_size;
		uint16_t filename_len;
		uint16_t extrafield_len;
		/* filename */
		/* extrafield */
		char append[?];
	} zip_lfh;

	/* Central directory file header */
	typedef struct __attribute__((__packed__)) _zip_cdfh
	{
		char signature[4]; /* PK\1\2 */
		uint16_t version_made;
		uint16_t version_needed;
		uint16_t flags;
		uint16_t compression;
		uint16_t mod_time;
		uint16_t mod_date;
		uint32_t crc32;
		uint32_t compressed_size;
		uint32_t uncompressed_size;
		uint16_t filename_len;
		uint16_t extrafield_len;
		uint16_t filecomment_len;
		uint16_t disk_nr_start;
		uint16_t internal_attr;
		uint32_t external_attr;
		uint32_t local_header_offset;
		/* filename */
		/* extrafield */
		/* filecomment */
		char append[?];
	} zip_cdfh;

	/* End of central directory */
	typedef struct __attribute__((__packed__)) _zip_eocd
	{
		char signature[4]; /* PK\5\6 */
		uint16_t disk_nr;
		uint16_t disk_nr_with_cd_start;
		uint16_t disk_entries;
		uint16_t total_entries;
		uint32_t central_directory_size;
		uint32_t cd_wrt_starting_disk_offset;
		uint16_t zipcomment_len;
		/* zipcomment */
	} zip_eocd;
]])


local function make_dos_date(t)
	-- Similar to format_date(...), we can have either a {Y,M,D,H,M,S} table,
	-- or a Unix timestamp. Whichever we got, make it into a DOS date that ZIP uses.
	if t == nil or t == 0 then
		-- Just get the current time
		t = os.time()
	end

	if type(t) ~= "table" then
		-- Unix timestamp, convert it into a {Y,M,D,H,M,S}
		local lua_t = os.date("*t", t)
		t = {lua_t.year, lua_t.month, lua_t.day, lua_t.hour, lua_t.min, lua_t.sec}
	end

	if t[1] < 1980 then
		t = {1980, 1, 1, 0, 0, 0}
	elseif t[1] > 2107 then
		t = {2107, 12, 31, 23, 59, 58}
	end

	return (t[1]-1980)*0x200 + t[2]*0x20 + t[3], t[4]*0x800 + t[5]*0x20 + math.floor(t[6]/2)
end

cZipwriter =
{
	--== PUBLIC OPTIONS ==--
	filename = "",

	--== PRIVATE ==--
	os_fh = nil,

	n_files = 0,
	cur_size = 0,

	central_dir_headers = {},
	unique_filenames = {},
}

function cZipwriter:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	o.central_dir_headers = {}
	o.unique_filenames = {}

	local success, os_fh = multiwritefile_open(o.filename)
	if not success then
		error(os_fh, 0)
	end
	o.os_fh = os_fh

	return o
end

function cZipwriter:write(data, size)
	local success, everr = multiwritefile_write(self.os_fh, data)
	if not success then
		error(everr, 0)
	end
	self.cur_size = self.cur_size + size
end

function cZipwriter:write_lfh(cdfh, filename)
	-- Write a local file header based on a given central directory file header
	-- (a local file header is just a trimmed-down central directory file header)
	local lfh = ffi.new("zip_lfh", cdfh.filename_len, "PK\3\4")
	lfh.version_needed = cdfh.version_needed
	lfh.flags = cdfh.flags
	lfh.compression = cdfh.compression
	lfh.mod_time = cdfh.mod_time
	lfh.mod_date = cdfh.mod_date
	lfh.crc32 = cdfh.crc32
	lfh.compressed_size = cdfh.compressed_size
	lfh.uncompressed_size = cdfh.uncompressed_size
	lfh.filename_len = cdfh.filename_len
	lfh.extrafield_len = cdfh.extrafield_len
	ffi.copy(lfh.append, cdfh.append, cdfh.filename_len)

	local lfh_len = ffi.sizeof("zip_lfh", lfh.filename_len)
	self:write(ffi.string(lfh, lfh_len), lfh_len)
end

local function crunch_data(contents, size, do_compress)
	-- This function does all the mathy compression and checksumming
	-- and by "does" I mean "lets LÖVE do it"
	-- The gzip format has the DEFLATE compression we need as well as the CRC-32 we also need
	local level = do_compress and 9 or 0
	local data
	if love_version_meets(11) then
		data = love.data.compress("data", "gzip", contents, level)
	else
		data = love.math.compress(contents, "gzip", level)
	end

	-- See RFC 1952 (it's actually pretty short!)
	local data_pointer
	if love_version_meets(11,3) then
		data_pointer = data:getFFIPointer()
	else
		data_pointer = data:getPointer()
	end
	data_pointer = ffi.cast("unsigned char*", data_pointer)

	-- We'll accept FTEXT (bit 1), but anything else will add extra headers which LÖVE/zlib hasn't been adding?
	if data_pointer[3] > 1 then
		error("Got unexpected GZIP FLG (0x" .. string.format("%02x", data_pointer[3]) .. "), please tell Dav")
	end

	-- Now we know the header is 10 bytes, also the trailer is 8 bytes
	local gzip_size = data:getSize()
	local compressed_size = gzip_size - 18

	local crc32 = tonumber(ffi.cast("uint32_t*", data_pointer + (gzip_size-8))[0])

	if do_compress then
		return crc32, compressed_size, data:getString():sub(11, 10+compressed_size)
	end
	return crc32, size
end

function cZipwriter:add_file(filename, contents, size, do_compress, lastmodified)
	-- do_compress: true to use deflate, false to store
	-- lastmodified: timestamp from our filefunc functions

	if size > 0xFFFFFFFF then
		-- ZIP64 is a thing, but no way we'll need 4 GiB+ files for VVVVVV levels
		error(L.INVALIDFILESIZE, 0)
	end

	if self.unique_filenames[filename] then
		error("Duplicate file \"" .. filename .. "\"");
	end
	self.unique_filenames[filename] = true

	local filename_len = filename:len()
	local crc32, compressed_size, contents_compressed = crunch_data(contents, size, do_compress)

	local cdfh = ffi.new("zip_cdfh", filename_len, "PK\1\2")
	cdfh.version_made = 63
	cdfh.version_needed = 20
	-- 0x800: UTF-8 (that was simple!)
	cdfh.flags = 0x800
	if do_compress then
		-- 0x2: Maximum compression was used
		cdfh.flags = cdfh.flags + 2
		cdfh.compression = 8
	else
		cdfh.compression = 0
	end
	cdfh.mod_date, cdfh.mod_time = make_dos_date(lastmodified)
	cdfh.crc32 = crc32
	cdfh.compressed_size = compressed_size
	cdfh.uncompressed_size = size
	cdfh.filename_len = filename_len
	cdfh.local_header_offset = self.cur_size
	ffi.copy(cdfh.append, filename, filename_len)

	self:write_lfh(cdfh, filename)
	if do_compress then
		self:write(contents_compressed, compressed_size)
	else
		self:write(contents, size)
	end

	table.insert(self.central_dir_headers, cdfh)
	self.n_files = self.n_files + 1
end

function cZipwriter:finish()
	-- Time to write the central directory
	local central_directory_start = self.cur_size
	for i = 1, self.n_files do
		local cdfh_len = ffi.sizeof("zip_cdfh", self.central_dir_headers[i].filename_len)
		self:write(ffi.string(self.central_dir_headers[i], cdfh_len), cdfh_len)
	end

	local eocd = ffi.new("zip_eocd", "PK\5\6")
	eocd.disk_entries = self.n_files
	eocd.total_entries = self.n_files
	eocd.central_directory_size = self.cur_size - central_directory_start
	eocd.cd_wrt_starting_disk_offset = central_directory_start
	local eocd_len = ffi.sizeof("zip_eocd")
	self:write(ffi.string(eocd, eocd_len), eocd_len)

	multiwritefile_close(self.os_fh)
end
