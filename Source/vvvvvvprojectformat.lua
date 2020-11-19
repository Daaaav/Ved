-- Filesystem constants

PROJECT_FILE = "project.vproj"
METADATA_FILE = "base_metadata.vmeta"
VEDMETADATA_DIR = "ved_metadata"
LEVELNOTES_DIR = "level_notes"
FLAGNAMES_FILE = "flag_names.vmeta"
ROOMS_DIR = "rooms"
ROOMPROPERTIES_FILE = "properties.vmeta"
ROOMCONTENTS_FILE = "contents.tmap"
ROOMEDENTITIES_FILE = "edentities.vobj"
SCRIPTS_DIR = "scripts"


-- Type enums, for use in key validation tables
local TYPE = {
	STRING = 1,
	INT = 2,
}

-- Whether a string is quoted or not
-- `"20"` isn't a valid integer value but `20` is
local QUOTES = {
	UNQUOTED = 1,
	QUOTED = 2,
}


-- File format parsing utilities

local function parse_string_literal(str)
	-- Decode a string literal, such as "    this string starts with four spaces"
	-- and 'I have\x0aa newline in this string'
	-- Returns the decoded string, and if it was a quoted string or not.
	-- Errors if there was an error in parsing.

	local single_quotes = str:sub(1) == "'" and str:sub(-1) == "'"
	local double_quotes = str:sub(1) == '"' and str:sub(-1) == '"'
	if not single_quotes and not double_quotes then
		-- Not a quoted string literal
		return true, str, QUOTES.UNQUOTED
	end

	-- Remove quotes
	str = str:sub(2, -2)

	-- And parse escape sequences
	local rope = {}
	local i = 1
	while i <= utf8.len(str) do
		local chr = utf8.sub(str, i, i)

		if chr == "\\" then
			local nextchr = utf8.sub(str, i + 1, i + 1)

			if nextchr == "" then
				return false, i, L.INCOMPLETEBACKSLASHESCAPE
			end

			i = i + 1

			if table.contains({"\\", "'", '"'}, nextchr) then
				table.insert(rope, nextchr)
			elseif nextchr == "x" then
				local hexchar1 = utf8.sub(str, i + 1, i + 1)
				local hexchar2 = utf8.sub(str, i + 2, i + 2)

				if hexchar1 == "" or hexchar2 == "" then
					return false, i, L.INCOMPLETEHEXADECMIALESCAPE
				end

				local char = tonumber(hexchar1 .. hexchar2, 16)
				if char == 0 then
					-- No nulls allowed
					return false, i, L.HEXADECIMALNONULL
				end
				table.insert(rope, string.char(char))

				i = i + 2
			else
				return false, i, L.INVALIDBACKSLASHESCAPE
			end
		else
			table.insert(rope, chr)
		end

		i = i + 1
	end

	return true, table.concat(rope), QUOTES.QUOTED
end

local function parse_vmeta_keyvalue(str)
	-- Parse a key-value string, such as `mymetadata: myvalue`
	-- or `mymetadata: "myvalue "`
	-- Returns the key, its value, and if its value was quoted or not.
	-- Errors if there was an error in parsing.

	local colon = str:find(":")

	if colon == nil then
		local column_num = nil
		return false, column_num, L.COLON404
	end

	local key = str:sub(1, colon - 1)
	local value = str:sub(colon)

	local value_offset
	key = trim(key)
	value, value_offset = trim(value)

	local success, ret2, ret3 = parse_string_literal(value)
	if not success then
		local column_num, errormsg = ret2, ret3
		column_num = column_num + colon + value_offset
		return false, column_num, errormsg
	end
	value, quotes = ret2, ret3

	return true, key, value, quotes
end

local function parse_vmeta(contents)
	-- Parse an entire vmeta file.
	-- Returns a table with the parsed values.
	-- Each value in the table is a table, [1] is value, [2] is if the value was quoted or not.
	-- Does not perform validation of any kind otherwise.
	-- Errors if there was an error in parsing.

	local retval = {}

	-- Keep track of which line number a key was defined on.
	local key_lines = {}

	local line_num = 1 -- Can't use pairs() on string.gmatch()

	for line in iterlines(contents) do
		if line ~= "" then
			local success, ret2, ret3, ret4 = parse_vmeta_keyvalue(line)

			if not success then
				local column_num, errormsg = ret2, ret3
				return false, line_num, column_num, errormsg
			end

			local key, value, quotes = ret2, ret3, ret4

			if retval[key] ~= nil then
				local column_num = nil
				local errormsg = langkeys(L.DUPLICATEKEY, {key, key_lines[key]})
				return false, line_num, column_num, errormsg
			end

			retval[key] = {value, quotes}
			key_lines[key] = line_num

			line_num = line_num + 1
		end
	end

	return true, retval, key_lines
end


-- vmeta key validation functions

local function validate_key_mappings(filename, table_, key_lines, keys)
	-- Validate that a list of given keys is (1) in the provided table
	-- and (2) have the correct types,
	-- then returns the validated table, plus a different table
	-- of any leftovers that weren't in the given list of keys.
	-- Errors if there is a missing key.
	-- TODO: Value `"20"` shouldn't be valid, only `20` should be

	local retval = {}

	for key, type_ in pairs(keys) do
		local value, quotes = unpack(table_[key])

		if value == nil then
			local errormsg = {}

			table.insert(errormsg, langkeys(L.ERRORINFILE, {filename}))
			table.insert(errormsg, langkeys(L.KEY404, {key}))

			return false, table.concat(errormsg)
		end

		if type_ == TYPE.INT then
			if not isinteger(value) or quotes == QUOTES.QUOTED then
				local errormsg = {}

				table.insert(errormsg, langkeys(L.ERRORINFILELINE, {filename, key_lines[key]}))
				table.insert(errormsg, langkeys(L.INVALIDINTEGERKEYVALUE, {key}))

				return false, table.concat(errormsg)
			end
			value = tonumber(value)
		end

		retval[key] = value

		-- Remove it from the table, any ones left are unused and will be warned
		table_[key] = nil
	end

	local leftovers = table_
	return true, retval, leftovers
end

local function validate_key_flags(filename, table_, key_lines)
	-- Convert all string keys that can be parsed as a number to be actual numbers.
	-- All keys have to be non-negative integers.
	-- Returns the converted table.
	-- Errors if there is an invalid key.

	local retval = {}

	for key in pairs(table_) do
		if not isinteger(key) then
			local errormsg = {}

			table.insert(errormsg, langkeys(L.ERRORINFILELINE, {filename, key_lines[key]}))
			table.insert(errormsg, langkeys(L.INVALIDFLAGINTEGER, {key}))

			return false, table.concat(errormsg)
		end

		if tonumber(key) < 0 then
			local errormsg = {}

			table.insert(errormsg, langkeys(L.ERRORINFILELINE, {filename, key_lines[key]}))
			table.insert(errormsg, langkeys(L.INVALIDFLAGNONNEGATIVE, {key}))

			return false, table.concat(errormsg)
		end

		local value = unpack(table_[key])

		retval[key] = value
	end

	return true, retval
end


-- File format processors

local function process_vmeta_file(filename, contents)
	-- Wrapper around parse_vmeta() that gives a readable error message if there was an error.

	local success, ret2, ret3, ret4 = parse_vmeta(contents)
	if not success then
		local line_num, column_num, errormsg = ret2, ret3, ret4

		local reterror
		if column_num == nil then
			reterror = langkeys(L.ERRORINFILELINE, {filename, line_num})
		else
			reterror = langkeys(L.ERRORINFILELINECOLUMN, {filename, line_num, column_num})
		end

		return false, reterror .. errormsg
	end

	local retval = ret2
	return true, retval
end

local function process_and_verify_vmeta(filename, contents, keyvalidfunc, keys)
	-- Processes the vmeta file, then runs it through a given validation function.
	-- Errors if there was an error in processing or validation.
	-- Warns if there are any unused keys after validation.

	local success, ret2, ret3 = process_vmeta_file(filename, contents)
	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local parsed, key_lines = ret2, ret3

	local success, ret2, ret3 = keyvalidfunc(filename, parsed, key_lines, keys)
	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local retval, leftovers = ret2, ret3
	leftovers = leftovers or {}

	-- Any unused keys?
	local unused_keys = {}
	for unused_key in pairs(leftovers) do
		table.insert(unused_keys, unused_key)
	end

	local warnmsg

	if #unused_keys > 0 then
		warnmsg = {}

		table.insert(warnmsg, langkeys(L.WARNINGINFILE, {filename}))
		table.insert(warnmsg, langkeys(L_PLU.UNUSEDKEYS, {#unused_keys}))
		table.insert(warnmsg, table.concat(unused_keys, ", "))

		warnmsg = table.concat(warnmsg)
	end

	return true, retval, warnmsg
end


-- Specific file readers

local function read_basemetadata(filename, contents)
	-- Reads the base metadata file.
	-- Returns parsed metadata along with a warning message, if any.
	-- Errors if there was an error in parsing or validation.

	local BASE_METADATA_KEYS = {
		title = TYPE.STRING,
		creator = TYPE.STRING,
		website = TYPE.STRING,
		desc1 = TYPE.STRING,
		desc2 = TYPE.STRING,
		desc3 = TYPE.STRING,
		mapwidth = TYPE.INT,
		mapheight = TYPE.INT,
		levmusic = TYPE.INT,
	}

	local success, ret2, ret3 = process_and_verify_vmeta(filename, contents, validate_key_mappings, BASE_METADATA_KEYS)
	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local retval, warnmsg = ret2, ret3

	-- Ugh, the rest of Ved still uses capitalized names for some of these
	-- So we'll just convert it here
	local BASE_METADATA_CONVERSIONS = {
		title = "Title",
		creator = "Creator",
		desc1 = "Desc1",
		desc2 = "Desc2",
		desc3 = "Desc3",
	}

	for key, conversion in pairs(BASE_METADATA_CONVERSIONS) do
		if retval[key] ~= nil then
			local value = retval[key]
			retval[key] = nil
			retval[conversion] = value
		end
	end

	return true, retval, warnmsg
end

local function read_flagnames(filename, contents)
	-- Reads the flag names file.
	-- Returns the parsed flag names.
	-- Errors if there was an error in parsing or validation.

	local success, ret2, ret3 = process_and_verify_vmeta(filename, contents, validate_key_flags)
	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local retval = ret2

	return true, retval
end

local function read_roomproperties(filename, contents)
	-- Reads a room properties file.
	-- Returns the parsed room properties, along with a warning message, if any.
	-- Errors if there was an error in parsing or validation.

	local ROOM_PROPERTIES_KEYS = {
		tileset = TYPE.INT,
		tilecol = TYPE.INT,
		platx1 = TYPE.INT,
		platy1 = TYPE.INT,
		platx2 = TYPE.INT,
		platy2 = TYPE.INT,
		platv = TYPE.INT,
		enemyx1 = TYPE.INT,
		enemyy1 = TYPE.INT,
		enemyx2 = TYPE.INT,
		enemyy2 = TYPE.INT,
		enemytype = TYPE.INT,
		directmode = TYPE.INT,
		warpdir = TYPE.INT,
		roomname = TYPE.STRING,
		auto2mode = TYPE.INT,
	}

	local success, ret2, ret3 = process_and_verify_vmeta(filename, contents, validate_key_mappings, ROOM_PROPERTIES_KEYS)
	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local retval, warnmsg = ret2, ret3
	return true, retval, warnmsg
end

local function read_roomtilemap(filename, contents)
	-- Reads a room tilemap.
	-- Returns the parsed tilemap.
	-- Errors if there was an error in parsing or validation.

	local retval = {}
	local line_num = 1

	local ROW_WIDTH = 40
	local NUM_ROWS = 30

	for line in iterlines(contents) do
		if line == "" then
			return false, langkeys(L.ERRORINFILELINE, {filename, line_num}) .. L.LINEISBLANK
		end

		if line:sub(-1) ~= "," then
			return false, langkeys(L.ERRORINFILELINE, {filename, line_num}) .. L.NOENDINGCOMMA
		end

		local tile_column_num, char_column_num = 1, 1
		for tile_str in line:gmatch("(.-),") do
			if not isinteger(tile) then
				local errormsg = {}

				table.insert(errormsg, langkeys(L.ERRORINFILELINECOLUMN, {filename, line_num, char_column_num}))
				table.insert(errormsg, langkeys(L.INVALIDTILEINTEGER, {tile}))

				return false, table.concat(errormsg)
			end

			tile_num = tonumber(tile_str)

			if tile < 0 then
				local errormsg = {}

				table.insert(errormsg, langkeys(L.ERRORINFILELINECOLUMN, {filename, line_num, char_column_num}))
				table.insert(errormsg, langkeys(L.INVALIDTILENONNEGATIVE, {tile_num}))

				return false, table.concat(errormsg)
			end

			table.insert(retval, tile)

			tile_column_num = tile_column_num + 1
			char_column_num = char_column_num + utf8.len(tile)
		end

		local errormsg = {}

		if tile_column_num ~= ROW_WIDTH then
			table.insert(errormsg, langkeys(L.ERRORINFILELINE, {filename, line_num}))
		end

		if tile_column_num < ROW_WIDTH then
			table.insert(errormsg, langkeys(L_PLU.TOOFEWTILES, {ROW_WIDTH - tile_column_num}))
		elseif tile_column_num > ROW_WIDTH then
			table.insert(errormsg, langkeys(L_PLU.TOOMANYTILES, {tile_column_num - ROW_WIDTH}))
		end

		if #errormsg > 0 then
			return false, table.concat(errormsg)
		end
	end

	local errormsg = {}

	if line_num ~= NUM_ROWS then
		table.insert(errormsg, langkeys(L.ERRORINFILE, {filename}))
	end

	if line_num < NUM_ROWS then
		table.insert(errormsg, langkeys(L_PLU.TOOFEWROWS, {NUM_ROWS - line_num}))
	elseif line_num > NUM_ROWS then
		table.insert(errormsg, langkeys(L_PLU.TOOMANYROWS, {line_num - NUM_ROWS}))
	end

	if #errormsg > 0 then
		return false, table.concat(errormsg)
	end

	return true, retval
end


-- Load functions

function loadproject(path)
	-- Returns the same thing as loadlevel():
	-- success, metadata, limit, roomdata, entities, levelmetadata, scripts, count, scriptnames, vedmetadata, extra

	local success, ret2 = readprojectversion(path)

	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local version = ret2
	version = tonumber(version)

	if version == nil then
		return false, L.PROJECT_INVALIDVERSION
	end

	-- Project Format only has version 0 at this time
	if version > 0 then
		return false, L.PROJECT_TOONEW
	end

	local success, ret2, ret3 = readprojectfolder(path)

	if not success then
		local errormsg = ret2
		return false, errormsg
	end

	local project_tree, project_tree_errors = ret2, ret3

	local limit = limit_v

	local x = {} -- Just a grab bag of all our variables?
	local mycount = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil, FC = 0} -- FC = Failed Checks
	local FClist = {}

end
