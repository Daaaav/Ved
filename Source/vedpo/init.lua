local VedPO = {}

local function each_part(str, separator)
	return str:gmatch(" *([^" .. separator .. "]+)")
end

local function unescape(str)
	return (
		str:gsub(
			'\\[rnt"\\]',
			function(match)
				if match == "\\r" then
					return "\r"
				elseif match == "\\n" then
					return "\n"
				elseif match == "\\t" then
					return "\t"
				elseif match == '\\"' then
					return '"'
				elseif match == "\\\\" then
					return "\\"
				end
			end
		)
	)
end

local function escape(str, allow_split)
	local escaped_newline = "\\n"
	local ends_with_newline = str:byte(-1) == 0x0A
	if allow_split then
		escaped_newline = '\\n"\n"'
	end
	str = str
		:gsub("\\", "\\\\")
		:gsub('"', '\\"')
		:gsub("\t", "\\t")
		:gsub("\n", escaped_newline)
		:gsub("\r", "\\r")

	if allow_split and ends_with_newline then
		-- Special case: the last "" should be removed, which,
		-- in this string, is "\n" at the end of the string (quote-newline-quote)
		return str:sub(1,-4)
	end

	return str
end

function VedPO:new(line_iterator, load_plural_function)
	-- Create or load a PO document.
	-- To start a new one:
	--   po = VedPO:new()
	-- To load an existing one:
	--   po = VedPO:new(io.lines(filename))
	--   po = VedPO:new(love.filesystem.lines(filename))
	-- If load_plural_function is true, the plural equation from the PO header
	-- will be parsed and be callable as a function VedPO.plural_equation.

	local o = {}
	setmetatable(o, self)
	self.__index = self

	o.entries = {}

	o.nplurals = nil
	o.plural_equation = nil
	o.load_plural_function = load_plural_function

	o.has_errors = false
	o.errors = {}

	if line_iterator == nil then
		-- Do not load a file
		return o
	end

	local entry = nil

	-- Entry progress keeps track of where we are in an entry.
	-- 0: Blank line
	-- 1: All # comments (including flags)
	-- 2: msgctxt, msgid, msgid_plural
	-- 3: msgstr, msgstr[*]
	-- If this number goes back, terminate the existing entry
	local entry_progress_n = 0

	local cmd = nil -- for example "msgstr"
	local cmd_i = nil -- for example 0 for msgstr[0], or nil for msgstr

	local function entry_progress(new)
		if new < entry_progress_n and entry ~= nil then
			o:add_entry(entry)
			entry = nil
			cmd = nil
			cmd_i = nil
		end
		if new > 0 and entry == nil then
			entry = {
				comments = {},
				fuzzy = false
			}
		end
		entry_progress_n = new
	end

	o.line_number = 0
	for line in line_iterator do
		o.line_number = o.line_number + 1
		line = line
			:gsub("\t", " ")
			:gsub("[\r\n]", "")
			:gsub("^ *", "")
			:gsub(" *$", "")

		if line == "" then
			entry_progress(0)
		elseif line:byte(1) == 0x23 then -- #
			entry_progress(1)

			table.insert(entry.comments, line)

			local second = line:byte(2)
			if second == 0x2C or second == 0x3D then -- #, or #=
				for flag in each_part(line:sub(3), ",") do
					if flag == "fuzzy" then
						entry.fuzzy = true
					end
				end
			end
		elseif line:byte(1) == 0x22 and line:byte(-1) == 0x22 then
			-- Continuation string
			-- Make sure we have something to continue and then continue it
			if cmd == nil then
				o:expect(false, "Unexpected continuation string")
			else
				local str = unescape(line:sub(2,-2))
				if cmd_i ~= nil then
					table.insert(entry[cmd][cmd_i], str)
				else
					table.insert(entry[cmd], str)
				end
			end
		else
			-- Some kind of "command" (like msgid) followed by a string
			-- Let's try msgstr[*] first and then fall back to any other one
			local str
			cmd, cmd_i, str = line:match('^(msgstr)%[([0-9]+)%] +"(.*)"$')
			if cmd == nil then
				cmd, str = line:match('^([a-z_]+) +"(.*)"$')
				cmd_i = nil
			end

			if str ~= nil then
				str = unescape(str)
			end

			if cmd == "msgctxt" or cmd == "msgid" or cmd == "msgid_plural" then
				entry_progress(2)
				o:expect(entry[cmd] == nil, "Duplicate " .. cmd)
				entry[cmd] = {str}
			elseif cmd == "msgstr" then
				entry_progress(3)
				if cmd_i ~= nil then
					-- msgstr[n]
					cmd_i = tonumber(cmd_i)
					if cmd_i == nil then
						o:expect(false, "Invalid msgstr plural index")
					elseif entry.msgid_plural == nil then
						o:expect(false, "Cannot accept msgstr[" .. cmd_i .. "] if msgid_plural is missing")
					else
						if entry.msgstr == nil then
							entry.msgstr = {}
						end
						o:expect(entry.msgstr[cmd_i] == nil, "Duplicate msgstr[" .. cmd_i .. "]")
						entry.msgstr[cmd_i] = {str}
					end
				elseif entry.msgid_plural ~= nil then
					o:expect(false, "Cannot accept bare msgstr if msgid_plural is present")
				else
					o:expect(entry.msgstr == nil, "Duplicate msgstr")
					entry.msgstr = {str}
				end
			else
				-- Also catches unparseable lines where cmd == nil
				o:expect(false, "Unrecognized line")
				cmd = nil
			end
		end
	end

	entry_progress(0)

	return o
end

function VedPO:expect(condition, message)
	-- Internal function used when parsing.
	-- Checks if a condition is true, if not, store an error message for this line number
	if not condition then
		self.has_errors = true
		table.insert(self.errors, "Line " .. self.line_number .. ": " .. message)
	end
end

local function stringize(t, k)
	if type(t[k]) == "table" then
		t[k] = table.concat(t[k])
	end
end

function VedPO:add_entry(entry)
	-- Add an entry at the end of the table.
	-- An entry is a table with:
	--   `comments`: a table of all lines that start with #
	--   `fuzzy`: true or false (if true, there's expected to also be a fuzzy flag in a comment)
	--   optionally, any selection of `msgctxt`, `msgid`, `msgid_plural` and `msgstr`.
	-- Those last ones can have the string as either a table for each line
	-- (which will be concatenated), or strings as normal.
	-- Plural strings are indexed by N for msgstr[N] (so starting from 0).
	-- This function does no checks to make sure every string in the file is unique,
	-- and also doesn't check that the given entry is valid (the presence of msgid_plural
	-- matches the presence of msgstr[N] tags and vice versa) - it just adds as requested.

	stringize(entry, "msgctxt")
	stringize(entry, "msgid")
	stringize(entry, "msgid_plural")
	if entry.msgid_plural == nil then
		stringize(entry, "msgstr")
	else
		for k,v in pairs(entry.msgstr) do
			stringize(entry.msgstr, k)
		end
	end

	table.insert(self.entries, entry)

	if entry.msgid == "" and entry.msgstr ~= nil and self.load_plural_function then
		-- This is the PO header
		for line in each_part(entry.msgstr, "\n") do
			if line:sub(1,13):lower() == "plural-forms:" then
				for stmt in each_part(line:sub(14):lower(), ";") do
					local k, v = stmt:match("^([a-z_]+) *= *(.*)$")
					if k == "nplurals" then
						self.nplurals = tonumber(v)
					elseif k == "plural" then
						v = v
							:gsub("%?", "and")
							:gsub(":", "or")
							:gsub("&&", "and")
							:gsub("||", "or")
							:gsub("!=", "~=")

						local fn, err = loadstring("return function(n) return (" .. v .. ") end")
						if fn == nil then
							self:expect(false, "Error in plural equation: " .. err)
						else
							self.plural_equation = fn()
						end
					end
				end
			end
		end
	end
end

function VedPO:export(callback)
	-- Export the document to a string.
	-- If callback is specified, it is called for every part of the document, and the function returns nil.
	-- If callback is not specified, the document is simply returned as a string.
	local parts = {}
	local returning_string = false

	if callback == nil then
		callback = function(part)
			table.insert(parts, part)
		end
		returning_string = true
	end

	local function callback_string(cmd, str, allow_split)
		if str == nil then
			return
		end

		callback(cmd)

		local found_newlines = str:find("\n", 1, true) ~= nil

		local str = escape(str, allow_split)

		if allow_split and found_newlines then
			-- Start the string with a "" line
			callback(' ""\n"')
		else
			callback(' "')
		end
		callback(str)
		callback('"\n')
	end

	local first = true
	for i,entry in ipairs(self.entries) do
		if not first then
			callback("\n")
		end
		first = false

		-- First show all the comments
		for j,line in ipairs(entry.comments) do
			callback(line)
			callback("\n")
		end

		-- Then, in order, if they exist: msgctxt, msgid, msgid_plural, msgstr
		-- I don't dare to split the msgctxt into multiple lines, but for the others I do of course
		callback_string("msgctxt", entry.msgctxt)
		callback_string("msgid", entry.msgid, true)
		callback_string("msgid_plural", entry.msgid_plural, true)

		if type(entry.msgstr) == "table" then
			-- So pairs doesn't give the right order since it starts from 0,
			-- and ipairs drops 0 altogether. So let's do this more manually.
			local highest = -1
			for k,v in pairs(entry.msgstr) do
				if k > highest then
					highest = k
				end
			end
			for k = 0, highest do
				callback_string("msgstr[" .. k .. "]", entry.msgstr[k], true)
			end
		else
			callback_string("msgstr", entry.msgstr, true)
		end
	end

	if returning_string then
		return table.concat(parts)
	end
end

return {
	VedPO = VedPO
}
