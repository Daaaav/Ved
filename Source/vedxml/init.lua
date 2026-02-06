local ffi = require("ffi")

local utf8 = utf8
if utf8 == nil then
	utf8 = require("utf8")
end

-- Some options that will be used by default in new VedXML objects.
-- By default, the options are set to strict conformance with the XML spec,
-- but certain annoying or waste-of-time options can be changed if desired
local VedXMLDefault = {
	-- Create text nodes for all whitespace-only parts
	preserve_all_whitespace = true,
	-- Disable "3.3.3 Attribute-Value Normalization", leaving whitespace in attributes as-is
	disable_avn = false,
	-- Allow documents to use control chars (01-1F) that XML 1.0 prohibits.
	allow_control_chars = false,
	-- The string to use for one indentation level.
	-- This is not used if preserve_all_whitespace is true.
	indent = "    ",
	-- Whether to put a space before /> in a selfclosing token.
	-- This only applies to new/modified elements.
	space_before_selfclosing = false,
}

ffi.cdef([[
	typedef struct _token_list_item
	{
		uint32_t start;
		uint32_t length;
		uint8_t type;
		uint8_t newlines_before;
		bool is_patched;
		uint32_t spouse;
		uint32_t parent;
		uint32_t next;
		uint32_t prev;
	} token_list_item;
]])

local CH = {
	SP = string.byte(" "),
	TAB = string.byte("\t"),
	LF = string.byte("\n"),
	CR = string.byte("\r"),
	LT = string.byte("<"),
	GT = string.byte(">"),
	AMP = string.byte("&"),
	HASH = string.byte("#"),
	DASH = string.byte("-"),
	SLASH = string.byte("/"),
	EQ = string.byte("="),
	QUOT = string.byte("\""),
	APOS = string.byte("'"),
	BANG = string.byte("!"),
	HUH = string.byte("?"),
	COLON = string.byte(":"),
	SEMICOLON = string.byte(";"),
	UNDERSCORE = string.byte("_"),
	DOT = string.byte("."),
	RBRACK = string.byte("]"),
	UPPER_A = string.byte("A"),
	UPPER_Z = string.byte("Z"),
	LOWER_A = string.byte("a"),
	LOWER_Z = string.byte("z"),
	UPPER_F = string.byte("F"),
	LOWER_F = string.byte("f"),
	LOWER_X = string.byte("x"),
	ZERO = string.byte("0"),
	ONE = string.byte("1"),
	NINE = string.byte("9"),
}

local TOKEN_TYPE = {
	EMPTY = 0, -- the whole struct must be null-filled!
	ERROR = 1,
	FILE_START = 2,
	FILE_END = 3,
	TAG_OPENING = 4,
	TAG_CLOSING = 5,
	TAG_SELFCLOSING = 6,
	TEXT = 7,
	CDATA = 8,
	COMMENT = 9,
	PI = 10,
}


local VedXML =
{
	--== PUBLIC OPTIONS ==--
	-- The complete XML to load in
	string = nil,
	-- The name of the root tag.
	-- If creating a new XML document (no string to load in), this root tag will be created.
	-- Else it can be used to assert that the root element has the expected name (but this is optional)
	root = nil,
	-- Create text nodes for all whitespace-only parts (use VedXMLDefault value if nil)
	preserve_all_whitespace = nil,
	-- Disable "3.3.3 Attribute-Value Normalization", leaving whitespace in attributes as-is (use VedXMLDefault value if nil)
	disable_avn = nil,
	-- Allow documents to use control chars (01-1F) that XML 1.0 prohibits. (use VedXMLDefault value if nil)
	allow_control_chars = nil,
	-- The string to use for one indentation level. (use VedXMLDefault value if nil)
	-- This is not used if preserve_all_whitespace is true.
	indent = nil,
	-- Whether to put a space before /> in a selfclosing token. (use VedXMLDefault value if nil)
	-- This only applies to new/modified elements.
	space_before_selfclosing = nil,

	--== PRIVATE ==--
	string_cursor = 1, -- cursor in string
	string_cursor_line = 1, -- line number
	string_cursor_col = 1, -- column on line
	at_eof = false, -- also true if errfail
	any_cr = false,

	token_list = nil,
	last_token = 0,
	first_free_row = 1,
	token_capacity = 0,
	tokenizer_open_tags = {},
	root_element = nil,
	root_element_seen = false,
	xml_declaration_seen = false,

	patches = {},

	err = nil,
	errfail = false,
}

function VedXML:new(o)
	-- Create or load an XML document.
	-- For example, to load XML from its file contents:
	--   xml = VedXML:new{string=contents}
	-- To create a new XML with a root element <book/>:
	--   xml = VedXML:new{root="book"}
	-- You can also use `root` to assert that the root element has the expected name:
	--   xml = VedXML:new{string=contents, root="book"}
	-- Any options from VedXMLDefault can also be specified here.

	o = o or {}
	setmetatable(o, self)
	self.__index = self

	o.tokenizer_open_tags = {}
	o.patches = {}

	if o.preserve_all_whitespace == nil then
		o.preserve_all_whitespace = VedXMLDefault.preserve_all_whitespace
	end
	if o.disable_avn == nil then
		o.disable_avn = VedXMLDefault.disable_avn
	end
	if o.allow_control_chars == nil then
		o.allow_control_chars = VedXMLDefault.allow_control_chars
	end
	if o.indent == nil then
		o.indent = VedXMLDefault.indent
	end
	if o.space_before_selfclosing == nil then
		o.space_before_selfclosing = VedXMLDefault.space_before_selfclosing
	end

	if o.string == nil then
		if o.root ~= nil then
			self:assert_wellformed_name(o.root)
			o.string = "<" .. o.root .. "/>"
		else
			o:raise_error("Attempt to create an XML document without passing either a string or root tag name")
		end
	end

	-- If it's UTF-16, there must be a BOM, so...
	local is_utf16 = false
	if o.string:byte(1) == 0xFE and o.string:byte(2) == 0xFF then
		o:utf16_to_utf8(true)
		is_utf16 = true
	elseif o.string:byte(1) == 0xFF and o.string:byte(2) == 0xFE then
		o:utf16_to_utf8(false)
		is_utf16 = true
	end

	-- Is there a BOM?
	if o.string:byte(1) == 0xEF and o.string:byte(2) == 0xBB and o.string:byte(3) == 0xBF then
		o.string_cursor = 4
	end

	o.token_list = ffi.new("token_list_item[100000]")
	o.token_capacity = 100000
	o.token_list[0].type = TOKEN_TYPE.FILE_START

	-- The XML declaration shouldn't be tokenized, and it's in a pretty rigid order...
	-- So this whole block just verifies it.
	if o.string:sub(o.string_cursor, o.string_cursor+4) == "<?xml" then
		o.xml_declaration_seen = true
		o:advance_ch(5)
		if not o:advance_whitespace() then
			o:raise_fail_char(0, o:cur_ch(0), "whitespace")
		end
		-- 1: VersionInfo, 2: EncodingDecl/SDDecl, 3: SDDecl, 4: X_X
		for step = 1, 4 do
			-- We're now at the start of an "attribute" name
			local scur = o.string_cursor
			local attribute_len
			if step == 1 and o.string:sub(scur, scur+6) == "version" then
				attribute_len = 7
			elseif step == 2 and o.string:sub(scur, scur+7) == "encoding" then
				attribute_len = 8
			elseif (step == 2 or step == 3) and o.string:sub(scur, scur+9) == "standalone" then
				attribute_len = 10
			else
				o:raise_fail(0, "Unexpected attribute in XML declaration (the order is quite rigid)")
			end
			local attribute = o.string:sub(scur, scur+attribute_len-1)
			o:advance_ch(attribute_len)

			o:advance_whitespace()
			if o:cur_ch(0) ~= CH.EQ then
				o:raise_fail_char(0, o:cur_ch(0), "=")
			end
			o:advance_ch(1)
			o:advance_whitespace()

			local end_quote = o:cur_ch(0)
			if end_quote ~= CH.QUOT and end_quote ~= CH.APOS then
				o:raise_fail_char(0, end_quote, "\" or '")
			end
			o:advance_ch(1)

			-- Value of this attribute comes now...
			if attribute == "version" then
				if o:cur_ch(0) ~= CH.ONE or o:cur_ch(1) ~= CH.DOT then
					o:raise_fail(0, "Invalid XML version")
				end
				o:advance_ch(2)
				local any_number = false
				while o:ch_in(o:cur_ch(0), CH.ZERO, CH.NINE) do
					o:advance_ch(1)
					any_number = true
				end
				if not any_number then
					o:raise_fail(0, "Invalid XML version")
				end
			elseif attribute == "encoding" then
				scur = o.string_cursor
				if (not is_utf16 and o.string:sub(scur, scur+4):upper() ~= "UTF-8")
				or (is_utf16 and o.string:sub(scur, scur+5):upper() ~= "UTF-16") then
					o:raise_fail(0, "Unsupported or conflicting encoding")
				end
				o:advance_ch(5)
				if is_utf16 then
					o:advance_ch(1)
				end
			elseif attribute == "standalone" then
				scur = o.string_cursor
				if o.string:sub(scur, scur+2) == "yes" then
					o:advance_ch(3)
				elseif o.string:sub(scur, scur+1) == "no" then
					o:advance_ch(2)
				else
					o:raise_fail(0, "Invalid standalone value")
				end
			end

			-- On the end quote for this attribute (it has to be the same type of quote, of course)
			if o:cur_ch(0) ~= end_quote then
				o:raise_fail_char(0, o:cur_ch(0), string.char(end_quote))
			end
			o:advance_ch(1)

			-- Whew! Now there could be ?>, or the next attribute
			local any_whitespace = o:advance_whitespace()
			if o:cur_ch(0) == CH.HUH and o:cur_ch(1) == CH.GT then
				o:advance_ch(2)
				break
			end
			if not any_whitespace then
				-- There HAS to be whitespace before the next attribute
				o:raise_fail_char(0, o:cur_ch(0), "whitespace")
			end
		end
	end

	return o
end

function VedXML:assert_wellformed_name(name)
	-- Assert that a name is a well-formed XML name.
	-- Raises an error if it's not.
	if name == nil then
		self:raise_error("Name is nil")
	elseif name == "" then
		self:raise_error("Name is empty")
	end
	name = tostring(name)

	local byte_cur = 1
	local ch = self:ch_decode(name, byte_cur, 0)

	while ch ~= nil do
		if (byte_cur == 1 and not self:ch_is_name_start(ch))
		or (byte_cur ~= 1 and not self:ch_is_name(ch)) then
			self:raise_error("'" .. name .. "' is not a well-formed XML name")
		end
		ch, byte_cur = self:ch_decode(name, byte_cur, 1)
	end
end

function VedXML:assert_wellformed_chardata(text)
	-- Assert that a string only consists of [2] Char.
	-- Raises an error if it does not.
	if text == nil then
		self:raise_error("Text is nil")
	end
	text = tostring(text)

	local byte_cur = 1
	local ch = self:ch_decode(text, byte_cur, 0)

	while ch ~= nil do
		if not self:ch_is_char(ch) then
			self:raise_error(
				"Text contains an illegal character for XML (" .. string.format("U+%04X", ch) .. ")"
			)
		end
		ch, byte_cur = self:ch_decode(text, byte_cur, 1)
	end
end

function VedXML:assert_paras_for(tok_type, ...)
	-- Internal function.
	-- Given the same parameters as the patch_for_* functions,
	-- validates that all the parameters have acceptable values.

	if tok_type == TOKEN_TYPE.TAG_OPENING
	or tok_type == TOKEN_TYPE.TAG_SELFCLOSING
	or tok_type == TOKEN_TYPE.TAG_CLOSING then
		-- Possible attributes and attributes_order are not checked,
		-- they should only have data already from the checked document
		local name = ...
		self:assert_wellformed_name(name)
	elseif tok_type == TOKEN_TYPE.TEXT or tok_type == TOKEN_TYPE.CDATA then
		local text = ...
		self:assert_wellformed_chardata(text)
	elseif tok_type == TOKEN_TYPE.COMMENT then
		local comment = ...
		self:assert_wellformed_chardata(comment)
		comment = tostring(comment)
		if comment:find("--", 1, true) or comment:byte(-1) == CH.DASH then
			self:raise_error("XML comments cannot contain '--'")
		end
	elseif tok_type == TOKEN_TYPE.PI then
		local target, value = ...
		self:assert_wellformed_name(target)
		target = tostring(target)
		if target:lower() == "xml" then
			self:raise_error("Processing Instruction target cannot be \"" .. target .. "\"")
		end
		if value ~= nil then
			self:assert_wellformed_chardata(value)
			value = tostring(value)
			if value:find("?>", 1, true) then
				self:raise_error("Processing Instruction values cannot contain ?>")
			end
		end
	end
end

function VedXML:export(callback)
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

	self:tokenize_to_end()

	callback('<?xml version="1.0" encoding="UTF-8"?>')
	if not self.xml_declaration_seen then
		callback("\n")
	end

	local indent_level = 0
	local cur = 0
	local space_before_comment = false
	while true do
		local tok_type = self.token_list[cur].type

		if tok_type == TOKEN_TYPE.TAG_CLOSING then
			indent_level = indent_level - 1
		end

		local newlines_before = self.token_list[cur].newlines_before
		if newlines_before > 0 then
			callback(("\n"):rep(newlines_before))
			if indent_level > 0 then
				callback(self.indent:rep(indent_level))
			end
		elseif tok_type == TOKEN_TYPE.COMMENT and space_before_comment then
			callback(" ")
		end

		if tok_type == TOKEN_TYPE.TAG_OPENING then
			indent_level = indent_level + 1
		end

		if tok_type == TOKEN_TYPE.FILE_START then
			-- pass
		elseif tok_type == TOKEN_TYPE.FILE_END then
			break
		elseif tok_type == TOKEN_TYPE.EMPTY or tok_type == TOKEN_TYPE.ERROR then
			error("Error token when exporting document")
		else
			if not self.token_list[cur].is_patched then
				callback(
					self.string:sub(
						self.token_list[cur].start,
						self.token_list[cur].start + self.token_list[cur].length - 1
					)
				)
			elseif tok_type == TOKEN_TYPE.TAG_OPENING or tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
				callback("<")
				callback(self.patches[cur].name)
				for k,v in pairs(self.patches[cur].attributes_order) do
					callback(" ")
					callback(v)
					callback('="')
					callback(self:xmlspecialchars(self.patches[cur].attributes[v]))
					callback('"')
				end
				if tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
					if self.space_before_selfclosing then
						callback(" />")
					else
						callback("/>")
					end
				else
					callback(">")
				end
			elseif tok_type == TOKEN_TYPE.TAG_CLOSING then
				callback("</")
				callback(self.patches[cur].name)
				callback(">")
			elseif tok_type == TOKEN_TYPE.TEXT then
				callback(self:xmlspecialchars(self.patches[cur].text))
			elseif tok_type == TOKEN_TYPE.CDATA then
				callback("<![CDATA[")
				callback((self.patches[cur].text:gsub("]]>", "]]>]]&gt;<![CDATA[")))
				callback("]]>")
			elseif tok_type == TOKEN_TYPE.COMMENT then
				callback("<!--")
				callback(self.patches[cur].comment)
				callback("-->")
			elseif tok_type == TOKEN_TYPE.PI then
				callback("<?")
				callback(self.patches[cur].target)
				callback(" ")
				callback(self.patches[cur].value)
				callback("?>")
			end
		end

		if self.preserve_all_whitespace
		or tok_type == TOKEN_TYPE.FILE_START
		or tok_type == TOKEN_TYPE.TEXT
		or tok_type == TOKEN_TYPE.CDATA then
			space_before_comment = false
		else
			space_before_comment = true
		end

		cur = self.token_list[cur].next
	end

	if returning_string then
		return table.concat(parts)
	end
end

function VedXML:raise_notice(message)
	-- Raise notice-level error: minor stuff like "did not find such an element"
	self.err = message
	error(message, 0)
end

function VedXML:raise_fail(cur, message)
	-- Raise XML error: parsing the document failed (malformed, etc)
	-- This means the document is bad, or it exceeded parser limits.
	-- If cur ~= nil, it indicates which token we were in the middle of creating.
	-- That token will be set to ERROR, and the error message will contain the line number.
	self.err = message
	self.errfail = true
	self.at_eof = true
	if cur ~= nil then
		self.token_list[cur].type = TOKEN_TYPE.ERROR
		message = "Line " .. self.string_cursor_line .. " col " .. self.string_cursor_col .. ": " .. message
	end
	error(message, 0)
end

function VedXML:raise_fail_char(cur, char, expected)
	-- Raise XML error: parsing the document failed because of an unexpected character
	local msg_char
	if char == nil then
		msg_char = "end of file"
	elseif char >= 0x21 and char <= 0x7E then
		msg_char = utf8.char(char)
	else
		msg_char = string.format("U+%04X", char)
	end
	local msg_expected = ""
	if expected ~= nil then
		msg_expected = ", expected " .. expected
	end
	self:raise_fail(cur, "Unexpected character (" .. msg_char .. ")" .. msg_expected)
end

function VedXML:raise_error(message)
	-- Raise programming error: such as trying to get the element name of a comment.
	self.err = message
	error(message, 0)
end

function VedXML:raise_error_type(cur, level)
	-- Raise a programming error, because the cursor is the wrong type for this function
	self:raise_error("Trying to call :" .. debug.getinfo(level+1, "n").name .. " on type " .. self:get_type_name(cur))
end

function VedXML:ci(cur)
	-- Internal function - Cursor Index, ensure the cursor is within bounds, and turn nil into a root cursor
	if cur == nil then
		while self.root_element == nil do
			if self.at_eof then
				-- This shouldn't really happen, but maybe you ignored an error or something...
				self:raise_error("Could not find root element")
			end
			self:tokenize_one()
		end
		return self.root_element
	end
	if type(cur) ~= "number"
	or cur < 0
	or cur >= self.token_capacity
	or self.token_list[cur].type == TOKEN_TYPE.EMPTY then
		self:raise_error("Invalid cur given to :" .. debug.getinfo(2, "n").name)
	end
	return cur
end

function VedXML:ci_opening_selfclosing(cur)
	-- Internal function - Cursor Index and assert type
	cur = self:ci(cur)

	local tok_type = self.token_list[cur].type
	if  tok_type ~= TOKEN_TYPE.TAG_OPENING
	and tok_type ~= TOKEN_TYPE.TAG_SELFCLOSING then
		self:raise_error_type(cur, 2)
	end

	return cur
end

local FIND_MODE_ERROR = 0
local FIND_MODE_NIL = 1
local FIND_MODE_ADD = 2

function VedXML:find_mode(mode, cur, ...)
	-- Internal function - compiles :find, :find_or_add, :find_or_nil into one
	local elements = {...}

	for k,v in pairs(elements) do
		-- Name of the next element
		local any = false
		for cur2 in self:each_child_element(cur, elements[k]) do
			any = true
			cur = cur2
			break
		end
		if not any then
			if mode == FIND_MODE_ERROR then
				self:raise_notice("<" .. tostring(v) .. "> is missing")
			elseif mode == FIND_MODE_NIL then
				return nil
			else
				cur = self:add_element_in_last(cur, elements[k])
			end
		end
	end

	return cur
end

function VedXML:find(cur, ...)
	-- Get cursor to first matching element INSIDE the element pointed to by cur.
	-- Multiple elements can be chained, so if you use :find(nil, "e1", "e2", "e3"),
	-- we will find the first <e3> in the first <e2> in the first <e1> inside the root element.
	-- Raises an error if one of the elements in the chain doesn't exist.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:find_mode(FIND_MODE_ERROR, cur, ...)
end

function VedXML:find_or_nil(cur, ...)
	-- Like :find, but if one of the elements in the chain doesn't exist, return nil
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:find_mode(FIND_MODE_NIL, cur, ...)
end

function VedXML:find_or_add(cur, ...)
	-- Like :find, but if the elements don't exist, make them automatically.
	-- The last element (name) in the list will be a selfclosing tag.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:find_mode(FIND_MODE_ADD, cur, ...)
end

function VedXML:each_child_element(cur, name)
	-- Iterate over each child instance that is called <name>.
	-- If `name` is missing, match elements with any name (but not comments).
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	local iter = self:each_child_node(cur)

	return function()
		local cur2
		while true do
			cur2 = iter()

			if cur2 == nil then
				return nil
			end

			local tok_type = self.token_list[cur2].type

			if (tok_type == TOKEN_TYPE.TAG_OPENING or tok_type == TOKEN_TYPE.TAG_SELFCLOSING)
			and (name == nil or self:has_name(cur2, name)) then
				return cur2
			end
		end
	end
end

function VedXML:each_child_node(cur)
	-- Iterate over each child element, comment, text, the lot, but do not get children OF child elements
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:each_child_token(cur, true)
end

function VedXML:each_child_token(cur, nodes_only)
	-- Mostly for internal usage, but can be used if you need it.
	-- If nodes_only is false, get every opening and closing tag separately and do not distinguish children of children.
	-- If nodes_only is true, this is basically :each_child_node(cur).
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	local none = function()
		return nil
	end

	cur = self:ci(cur)

	local tok_type = self.token_list[cur].type
	if tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		return none
	end
	if tok_type ~= TOKEN_TYPE.TAG_OPENING then
		self:raise_error_type(cur, 1)
	end

	local cur_start = cur

	-- We know there's nothing unexpected now like EOF, so let's go!
	local first = true
	return function()
		local next_token_of
		if not first and nodes_only and self.token_list[cur].type == TOKEN_TYPE.TAG_OPENING then
			next_token_of = self:get_closing_token(cur)
		else
			next_token_of = cur
		end

		if cur == self.last_token then
			self:tokenize_one()
		end
		cur = self.token_list[cur].next

		-- The start token's spouse might still be 0 if it's not tokenized yet,
		-- but as soon as we tokenize its spouse, we'll find out we reached it here.
		if cur == self.token_list[cur_start].spouse then
			return nil
		end

		first = false
		return cur
	end
end

function VedXML:get_closing_token(cur)
	-- Get the closing tag that belongs to this opening tag.
	-- cur: TAG_OPENING, FILE_START
	local tok_type = self.token_list[self:ci(cur)].type
	if tok_type ~= TOKEN_TYPE.TAG_OPENING and tok_type ~= TOKEN_TYPE.FILE_START then
		self:raise_error("Attempt to get closing token of a token of type " .. self:get_type_name(cur))
	end

	while self.token_list[self:ci(cur)].spouse == 0 do
		if self.at_eof then
			self:raise_error("Could not find closing token")
		end
		self:tokenize_one()
	end

	return self.token_list[self:ci(cur)].spouse
end

function VedXML:ll_insert(cur)
	-- Internal function: Insert one item after the current one in the linked list.
	-- This only concerns the linking, not population of data - you get allocated a row and get the cur to that row.
	-- cur: any
	cur = self:ci(cur)

	local new_row = self.first_free_row
	while self.token_list[new_row].type ~= TOKEN_TYPE.EMPTY do
		new_row = new_row + 1
		if new_row >= self.token_capacity then
			-- Double the capacity
			self.token_capacity = self.token_capacity * 2
			--print("Doubling the capacity to " .. self.token_capacity)
			local new_token_list = ffi.new("token_list_item[?]", self.token_capacity)
			ffi.copy(new_token_list, self.token_list, ffi.sizeof(self.token_list))
			self.token_list = new_token_list
			break
		end
	end
	self.first_free_row = math.min(self.token_capacity - 1, new_row + 1)

	local cur_old_next = self.token_list[cur].next
	self.token_list[new_row].next = cur_old_next
	self.token_list[cur_old_next].prev = new_row

	self.token_list[cur].next = new_row
	self.token_list[new_row].prev = cur

	return new_row
end

function VedXML:ll_unlink(cur, till)
	-- Internal function: Unlink the node at the cursor in the linked list, and link its previous and next together.
	-- If a cursor is specified for the till argument, deletion will keep going up to but not including that cursor.
	-- This function has no protection against unbalancing the XML structure, and does not update spouse or parent values.

	local prev = self.token_list[cur].prev

	if till == nil then
		till = self.token_list[cur].next
	end

	local next_cur = cur
	while next_cur ~= till do
		cur = next_cur
		next_cur = self.token_list[cur].next

		if cur == 0 then
			self:raise_error("Attempt to delete token 0 (FILE_START)!")
		end

		if cur < self.first_free_row then
			self.first_free_row = cur
		end

		if self.token_list[cur].is_patched then
			self.patches[cur] = nil
		end

		ffi.fill(self.token_list[cur], ffi.sizeof("token_list_item"))
	end

	self.token_list[prev].next = till
	self.token_list[till].prev = prev
end

function VedXML:ch_is_whitespace(ch)
	-- Returns true if the given character is whitespace (#x20 | #x9 | #xD | #xA)
	return ch == CH.SP or ch == CH.TAB or ch == CH.LF or ch == CH.CR
end

function VedXML:ch_in(ch, a, z)
	-- Returns true if the given character is >= a and <= z
	return ch >= a and ch <= z
end

function VedXML:ch_is_name_start(ch)
	-- Returns whether a codepoint matches [4] NameStartChar
	return ch == CH.COLON
	or self:ch_in(ch, CH.UPPER_A, CH.UPPER_Z) or ch == CH.UNDERSCORE
	or self:ch_in(ch, CH.LOWER_A, CH.LOWER_Z)
	or self:ch_in(ch, 0xC0, 0xD6)
	or self:ch_in(ch, 0xD8, 0xF6)
	or self:ch_in(ch, 0xF8, 0x2FF)
	or self:ch_in(ch, 0x370, 0x37D)
	or self:ch_in(ch, 0x37F, 0x1FFF)
	or self:ch_in(ch, 0x200C, 0x200D)
	or self:ch_in(ch, 0x2070, 0x218F)
	or self:ch_in(ch, 0x2C00, 0x2FEF)
	or self:ch_in(ch, 0x3001, 0xD7FF)
	or self:ch_in(ch, 0xF900, 0xFDCF)
	or self:ch_in(ch, 0xFDF0, 0xFFFD)
	or self:ch_in(ch, 0x10000, 0xEFFFF)
end

function VedXML:ch_is_name(ch)
	-- Returns whether a codepoint matches [4a] NameChar
	return self:ch_is_name_start(ch)
	or ch == CH.DASH or ch == CH.DOT
	or self:ch_in(ch, CH.ZERO, CH.NINE)
	or ch == 0xB7
	or self:ch_in(ch, 0x0300, 0x036F)
	or self:ch_in(ch, 0x203F, 0x2040)
end

function VedXML:ch_is_char(ch)
	-- Returns whether a given codepoint matches [2] Char
	if self.allow_control_chars then
		-- If allow_control_chars, use XML 1.1's [2] Char
		return self:ch_in(ch, 0x1, 0xD7FF)
		or self:ch_in(ch, 0xE000, 0xFFFD)
		or self:ch_in(ch, 0x10000, 0x10FFFF)
	end

	return ch == 0x9 or ch == 0xA or ch == 0xD
	or self:ch_in(ch, 0x20, 0xD7FF)
	or self:ch_in(ch, 0xE000, 0xFFFD)
	or self:ch_in(ch, 0x10000, 0x10FFFF)
end

-- Some UTF-8 helpers
local function starts_0(byte) return byte < 0x80 end
local function starts_10(byte) return byte >= 0x80 and byte < 0xC0 end
local function starts_110(byte) return byte >= 0xC0 and byte < 0xE0 end
local function starts_1110(byte) return byte >= 0xE0 and byte < 0xF0 end
local function starts_11110(byte) return byte >= 0xF0 and byte < 0xF8 end

function VedXML:ch_decode(str, byte_cursor, ch_offset)
	-- Internal function.
	-- Like :cur_ch(ch_offset), but gives more info:
	-- - the codepoint at the given offset
	-- - the value of byte_cursor (in bytes) after ch_offset (in codepoints) is applied
	-- This function basically converts a character/codepoint offset into a byte offset.

	-- Also, I'm ignoring the utf8 library because reasons.
	-- Don't mind me writing yet another UTF-8 decoder this is one of my specialties

	while ch_offset < 0 do
		-- We just need to make sure to get the ch_offset to 0.
		-- Travelling backwards, jump over 10xxxxxxx (continuation byte).
		-- We can assume we've seen everything that comes before the string cursor is valid UTF-8
		local byte
		repeat
			byte_cursor = byte_cursor - 1
			byte = str:byte(byte_cursor)
			if byte == nil then
				-- Avoid string:byte(-1), because then we'll start at the end of the string.
				-- Giving nil for too far left (as :byte(0) does) is fine
				return nil, byte_cursor
			end
		until not starts_10(byte)
		ch_offset = ch_offset + 1
	end

	while true do
		-- Now start decoding forwards, whether ch_offset is 0 or higher
		local codepoint, nbytes
		local first = str:byte(byte_cursor)

		if first == nil then
			-- Must be the end of the string entirely, at a UTF-8-valid point...
			return nil, byte_cursor
		elseif starts_0(first) then
			-- 0xxx xxxx - ASCII
			nbytes = 1
			codepoint = first
		elseif starts_10(first) then
			-- 10xx xxxx - unexpected continuation byte
			self:raise_error("Invalid UTF-8")
		elseif starts_110(first) then
			-- 110x xxxx - 2-byte sequence
			nbytes = 2
			local second = str:byte(byte_cursor + 1)
			if second == nil or not starts_10(second) then
				self:raise_error("Invalid UTF-8")
			end
			codepoint = (first-0xC0)*64 + (second-0x80)
		elseif starts_1110(first) then
			-- 1110 xxxx - 3-byte sequence
			nbytes = 3
			local second = str:byte(byte_cursor + 1)
			local third = str:byte(byte_cursor + 2)
			if second == nil or third == nil
			or not starts_10(second) or not starts_10(third) then
				self:raise_error("Invalid UTF-8")
			end
			codepoint = (first-0xE0)*4096 + (second-0x80)*64 + (third-0x80)
		elseif starts_11110(first) then
			-- 1111 0xxx - 4-byte sequence
			nbytes = 4
			local second = str:byte(byte_cursor  + 1)
			local third = str:byte(byte_cursor  + 2)
			local fourth = str:byte(byte_cursor  + 3)
			if second == nil or third == nil or fourth == nil
			or not starts_10(second) or not starts_10(third) or not starts_10(fourth) then
				self:raise_error("Invalid UTF-8")
			end
			codepoint = (first-0xF0)*262144 + (second-0x80)*4096 + (third-0x80)*64 + (fourth-0x80)
		else
			-- 1111 1xxx - invalid
			self:raise_error("Invalid UTF-8")
		end

		-- Overlong sequence?
		if (codepoint <= 0x7F and nbytes > 1)
		or (codepoint > 0x7F and codepoint <= 0x7FF and nbytes > 2)
		or (codepoint > 0x7FF and codepoint <= 0xFFFF and nbytes > 3) then
			self:raise_error("Invalid UTF-8: overlong sequence")
		end

		-- UTF-16 surrogates are invalid, so are codepoints after 10FFFF.
		-- We can actually test for [2] Char by this point
		if not self:ch_is_char(codepoint) then
			self:raise_error(
				"Illegal character encountered for XML (" .. string.format("U+%04X", codepoint) .. ")"
			)
		end

		-- Right, is this the character we needed, or do we need a later one?
		if ch_offset == 0 then
			return codepoint, byte_cursor
		end

		byte_cursor = byte_cursor + nbytes
		ch_offset = ch_offset - 1
	end
end

function VedXML:cur_ch(ch_offset)
	-- Internal function.
	-- Get the char pointed to by self.string_cursor (the tokenization cursor), plus an offset
	return (self:ch_decode(self.string, self.string_cursor, ch_offset))
end

function VedXML:advance_ch(ch_offset)
	-- Internal function.
	-- Move self.string_cursor a given number of characters
	-- Assumes you are not skipping over newlines!
	local codepoint
	codepoint, self.string_cursor = self:ch_decode(self.string, self.string_cursor, ch_offset)
	self.string_cursor_col = self.string_cursor_col + ch_offset
end

function VedXML:advance_whitespace()
	-- Internal function.
	-- Advance the cursor past any whitespace.
	-- Returns true if the cursor was moved (whitespace was encountered).
	local any_whitespace = false
	while true do
		local ch = self:cur_ch(0)
		if not self:ch_is_whitespace(ch) then
			return any_whitespace
		end

		any_whitespace = true

		if ch == CH.LF then
			self.string_cursor_line = self.string_cursor_line + 1
			self.string_cursor_col = 0 -- not 1 - we'll advance the cursor which advances this
		end

		self:advance_ch(1)
	end
end

function VedXML:advance_reference(new_cur)
	-- Internal function.
	-- Advance the cursor to the end of (not past...) this Reference (&x;).
	-- Why not past? Well, because there's another self:advance_ch(1)
	-- at the end of the tokenization loop. So just stop at the ;.
	-- Only thing we need to do right now is check the syntax - not convert it.
	-- If it's not well-formed, raise a failure

	if self:cur_ch(1) == CH.HASH then
		-- &#8604; or &#x219C;
		self:advance_ch(2)
		local hex = false
		if self:cur_ch(0) == CH.LOWER_X then
			hex = true
			self:advance_ch(1)
		end

		local codepoint_start = self.string_cursor

		repeat
			if not self:ch_in(self:cur_ch(0), CH.ZERO, CH.NINE)
			and not (hex and (
				self:ch_in(self:cur_ch(0), CH.UPPER_A, CH.UPPER_F) or
				self:ch_in(self:cur_ch(0), CH.LOWER_A, CH.LOWER_F)
			)) then
				self:raise_fail(new_cur, "Malformed character reference (&)")
			end

			self:advance_ch(1)
		until self:cur_ch(0) == CH.SEMICOLON

		-- Now make sure it's an allowed codepoint...
		local codepoint = self.string:sub(codepoint_start, self.string_cursor-1)
		if hex then
			codepoint = tonumber(codepoint, 16)
		else
			codepoint = tonumber(codepoint)
		end
		if codepoint == nil or not self:ch_is_char(codepoint) then
			self:raise_fail(
				new_cur,
				"Character reference (&) has an illegal character for XML (" .. string.format("U+%04X", codepoint) .. ")"
			)
		end
	else
		self:advance_ch(1)
		local two = self.string:sub(self.string_cursor, self.string_cursor+2)
		if two == "lt;" or two == "gt;" then
			self:advance_ch(2)
		else
			local three = self.string:sub(self.string_cursor, self.string_cursor+3)
			if three == "amp;" then
				self:advance_ch(3)
			else
				local four = self.string:sub(self.string_cursor, self.string_cursor+4)
				if four == "apos;" or four == "quot;" then
					self:advance_ch(4)
				else
					self:raise_fail(new_cur, "Unrecognized or malformed entity (&)")
				end
			end
		end
	end
end

function VedXML:tokenize_to_end()
	-- Tokenize the entire document now (rather than lazy-loading when used)
	while not self.at_eof do
		self:tokenize_one()
	end
end

-- Tokenizer states
local T_STATE_INIT = 0
local T_STATE_IN_TAG = 1
local T_STATE_IN_CLOSING_TAG = 2
local T_STATE_IN_COMMENT = 3
local T_STATE_IN_TEXT = 4
local T_STATE_IN_CDATA = 5
local T_STATE_IN_PI = 6

-- Tokenizer substates - different per state, but T_SUBSTATE_INIT is where each state starts
local T_SUBSTATE_INIT = 0
local T_SUBSTATE_INIT2 = 1
local T_SUBSTATE_IN_TAG_ATTNAME = 2
local T_SUBSTATE_IN_TAG_ATTNAME2 = 3
local T_SUBSTATE_IN_TAG_ATTEQ = 4
local T_SUBSTATE_IN_TAG_ATTQUOT = 5
local T_SUBSTATE_IN_TAG_ATTAPOS = 6

function VedXML:tokenize_one()
	-- Internal function: Advance the tokenizer by one token.
	if self.at_eof then
		return
	end

	local tokenizer_state = T_STATE_INIT
	local tokenizer_substate = T_SUBSTATE_INIT

	local new = self:ll_insert(self.last_token)
	self.last_token = new

	local new_start_line = self.string_cursor_line

	local function set_t_state(new_state)
		tokenizer_state = new_state
		tokenizer_substate = T_SUBSTATE_INIT
		new_start_line = self.string_cursor_line
	end

	-- The character position the current token starts, for example, where the < of the tag is
	self.token_list[new].start = self.string_cursor

	local parent = 0
	if #self.tokenizer_open_tags > 0 then
		parent = self.tokenizer_open_tags[#self.tokenizer_open_tags]
	end
	self.token_list[new].parent = parent

	local check_root = false

	local attname_start
	local attname_index

	while true do
		local ch = self:cur_ch(0)
		if ch == nil then
			self.at_eof = true
			if tokenizer_state ~= T_STATE_INIT then
				self:raise_fail(new, "Unexpected end of file, in type " .. self:get_type_name(new) .. " starting on line " .. new_start_line)
			elseif #self.tokenizer_open_tags > 0 then
				self:raise_fail(new, "End of file reached with tags left open")
			elseif not self.root_element_seen then
				self:raise_fail(new, "Root element is missing")
			end
			self.token_list[new].start = self.string_cursor
			self.token_list[new].length = 1
			self.token_list[new].type = TOKEN_TYPE.FILE_END
			self.token_list[new].spouse = 0
			self.token_list[0].spouse = new
			return
		end
		local whitespace = false
		if self:ch_is_whitespace(ch) then
			if ch == CH.LF then
				self.string_cursor_line = self.string_cursor_line + 1
				self.string_cursor_col = 0 -- we're still on the LF, cursor increment will set this to 1
				if tokenizer_state == T_STATE_INIT
				and self.token_list[new].newlines_before < 255 then
					self.token_list[new].newlines_before = self.token_list[new].newlines_before + 1
				end
			elseif ch == CH.CR then
				-- Sigh, now we have to do find-and-replace when getting text
				self.any_cr = true
			end
			whitespace = true
		end

		if tokenizer_state == T_STATE_INIT then
			if ch == CH.LT then
				-- Great, a tag! What kind of tag is it?
				-- <aa>? </aa>? <aa/>? <!--aa-->? <![CDATA[? <? ?>?
				self.token_list[new].start = self.string_cursor
				local ch_second = self:cur_ch(1)
				if ch_second == CH.SLASH then
					-- </
					-- Verify the name starts with a NameStartChar
					local ch_third = self:cur_ch(2)
					if not self:ch_is_name_start(ch_third) then
						self:raise_fail_char(new, ch_third, "a tag name")
					end
					set_t_state(T_STATE_IN_CLOSING_TAG)
					self.token_list[new].type = TOKEN_TYPE.TAG_CLOSING
					self:advance_ch(1)
				elseif ch_second == CH.BANG then
					if self.string:sub(self.string_cursor+2, self.string_cursor+3) == "--" then
						-- <!--
						set_t_state(T_STATE_IN_COMMENT)
						self.token_list[new].type = TOKEN_TYPE.COMMENT
						self:advance_ch(3)
					elseif self.string:sub(self.string_cursor+2, self.string_cursor+8) == "[CDATA[" then
						-- <![CDATA[
						if #self.tokenizer_open_tags == 0 then
							-- This is before or after the root element - bad
							self:raise_fail(new, "CDATA found outside of root element")
						end
						set_t_state(T_STATE_IN_CDATA)
						self.token_list[new].type = TOKEN_TYPE.CDATA
						self:advance_ch(8)
					else
						-- Anything else is unsupported (<!DOCTYPE, stuff like that)
						self:raise_fail(new, "Unsupported <! tag. DTD (<!DOCTYPE) is not supported.")
					end
				elseif ch_second == CH.HUH then
					-- <?, processing instruction
					-- Verify the target starts with a NameStartChar
					local ch_third = self:cur_ch(2)
					if not self:ch_is_name_start(ch_third) then
						self:raise_fail_char(new, ch_third, "a Processing Instruction target")
					end
					set_t_state(T_STATE_IN_PI)
					self.token_list[new].type = TOKEN_TYPE.PI

					-- Since we already checked the first char is a NameStartChar...
					self:advance_ch(2)
				elseif self:ch_is_name_start(ch_second) then
					-- <aa> or <aa/>
					-- Ensure we haven't already seen a root element closed (if none seen yet, this is the one)
					if not self.root_element_seen then
						self.root_element = new
						self.root_element_seen = true
						if self.root ~= nil then
							-- We want to assert that the name is as expected! Do that below, in T_STATE_IN_TAG
							check_root = true
						end
					elseif self.root_element_seen and #self.tokenizer_open_tags == 0 then
						self:raise_fail(new, "Multiple root elements")
					end
					set_t_state(T_STATE_IN_TAG)
					self.token_list[new].type = TOKEN_TYPE.TAG_OPENING
					attname_index = {}

					-- Since we already checked the first char is a NameStartChar...
					self:advance_ch(1)
				else
					if ch_second == nil then
						self:raise_fail(new, "Unexpected end of file after '<'")
					else
						self:raise_fail_char(new, ch_second, "something different after '<'")
					end
				end
			else
				-- Not a tag, so it's probably text
				if #self.tokenizer_open_tags == 0 then
					if not whitespace then
						-- This is before or after the root element - bad
						self:raise_fail(new, "Text found outside of root element")
					end
				elseif not whitespace or self.preserve_all_whitespace then
					set_t_state(T_STATE_IN_TEXT)
					self.token_list[new].type = TOKEN_TYPE.TEXT

					-- These are just part of the text now
					self.token_list[new].newlines_before = 0

					-- Make sure the IN_TEXT state sees the first character!
					-- Because don't forget we just already verified it was text,
					-- and there's another :advance_ch(1) at the end of the loop...
					self:advance_ch(-1)
					if ch == CH.LF then
						self.string_cursor_line = self.string_cursor_line - 1
					end
				end
			end
		elseif tokenizer_state == T_STATE_IN_TAG then
			-- In an opening or self-closing tag, just need to wait for the > or />
			-- Substates:
			-- T_SUBSTATE_INIT: in tag name, expect more NameChar or whitespace or > or />
			-- T_SUBSTATE_INIT2: name was terminated with whitespace (attribute NameStartChar expected, or whitespace or > or />
			-- T_SUBSTATE_IN_TAG_ATTNAME: inside an attribute name now, expect NameChar or whitespace or =
			-- T_SUBSTATE_IN_TAG_ATTNAME2: attribute name was terminated with whitespace, expect whitespace or =
			-- T_SUBSTATE_IN_TAG_ATTEQ: = happened, expect whitespace or " or '
			-- T_SUBSTATE_IN_TAG_ATTQUOT: in attribute value now, delimited with "
			-- T_SUBSTATE_IN_TAG_ATTAPOS: same but delimited with '

			local done = false
			local is_selfclosing = false

			if tokenizer_substate == T_SUBSTATE_INIT or tokenizer_substate == T_SUBSTATE_INIT2 then
				if whitespace then
					tokenizer_substate = T_SUBSTATE_INIT2
				elseif ch == CH.GT then
					done = true
					self:advance_ch(1)
				elseif ch == CH.SLASH and self:cur_ch(1) == CH.GT then
					done = true
					is_selfclosing = true
					self.token_list[new].type = TOKEN_TYPE.TAG_SELFCLOSING
					self:advance_ch(2)
				elseif tokenizer_substate == T_SUBSTATE_INIT and self:ch_is_name(ch) then
					-- part of name, pass
				elseif tokenizer_substate == T_SUBSTATE_INIT2 and self:ch_is_name_start(ch) then
					-- start of attribute name
					tokenizer_substate = T_SUBSTATE_IN_TAG_ATTNAME
					attname_start = self.string_cursor
				else
					self:raise_fail_char(new, ch, ">")
				end
			elseif tokenizer_substate == T_SUBSTATE_IN_TAG_ATTNAME or tokenizer_substate == T_SUBSTATE_IN_TAG_ATTNAME2 then
				local check_attname = false
				if whitespace then
					if tokenizer_substate == T_SUBSTATE_IN_TAG_ATTNAME then
						check_attname = true
						tokenizer_substate = T_SUBSTATE_IN_TAG_ATTNAME2
					end
				elseif ch == CH.EQ then
					if tokenizer_substate == T_SUBSTATE_IN_TAG_ATTNAME then
						check_attname = true
					end
					tokenizer_substate = T_SUBSTATE_IN_TAG_ATTEQ
				elseif tokenizer_substate == T_SUBSTATE_IN_TAG_ATTNAME2 or not self:ch_is_name(ch) then
					self:raise_fail_char(new, ch, "=")
				end

				if check_attname then
					-- We have a full attribute name now - check that it's unique
					local attname = self.string:sub(attname_start, self.string_cursor - 1)
					if attname_index[attname] then
						self:raise_fail(new, "Attribute name '" .. attname .. "' appears multiple times")
					end
					attname_index[attname] = true
				end
			elseif tokenizer_substate == T_SUBSTATE_IN_TAG_ATTEQ then
				if whitespace then
					-- pass
				elseif ch == CH.QUOT then
					tokenizer_substate = T_SUBSTATE_IN_TAG_ATTQUOT
				elseif ch == CH.APOS then
					tokenizer_substate = T_SUBSTATE_IN_TAG_ATTAPOS
				else
					self:raise_fail_char(new, ch, "\" or '")
				end
			elseif tokenizer_substate == T_SUBSTATE_IN_TAG_ATTQUOT or tokenizer_substate == T_SUBSTATE_IN_TAG_ATTAPOS then
				if ch == CH.LT then
					self:raise_fail(new, "Unexpected '<' in attribute value")
				elseif ch == CH.AMP then
					-- Entity, verify it's well-formed.
					self:advance_reference(new)
				elseif (tokenizer_substate == T_SUBSTATE_IN_TAG_ATTQUOT and ch == CH.QUOT)
				or     (tokenizer_substate == T_SUBSTATE_IN_TAG_ATTAPOS and ch == CH.APOS) then
					-- Okay, instead of making an INIT3 (attribute was just ended so no NameChar but
					-- also first expecting whitespace), can I just confirm something for a sec?
					if self:ch_is_name(self:cur_ch(1)) then
						self:raise_fail(new, "Unexpected name right after attribute value")
					end
					tokenizer_substate = T_SUBSTATE_INIT2
				end
			end

			if done then
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				if not is_selfclosing then
					-- Push (the cursor to) this opening tag as an open tag.
					table.insert(self.tokenizer_open_tags, new)
				end
				if check_root and not self:has_name(new, self.root) then
					self:raise_fail(new,
						"Root element is <" .. self:get_name(new) .. ">, expected <" .. self.root .. ">"
					)
				end
				return
			end
		elseif tokenizer_state == T_STATE_IN_CLOSING_TAG then
			-- Just need to wait for the >
			-- Any non-name character is invalid, there can be whitespace before the >
			if ch == CH.GT then
				self:advance_ch(1)
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				if #self.tokenizer_open_tags == 0 then
					self:raise_fail(new, "Unexpected closing </" .. self:get_name(new) .. "> tag")
				end
				local opener = table.remove(self.tokenizer_open_tags)

				-- Check if closing tag matches last open tag...
				if not self:has_name(opener, new) then
					self:raise_fail(new,
						"Name of closing </" .. self:get_name(new)
						.. "> tag doesn't match opening <" .. self:get_name(opener) .. "> tag"
					)
				end

				self.token_list[opener].spouse = new
				self.token_list[new].spouse = opener
				self.token_list[new].parent = self.token_list[opener].parent
				return
			elseif whitespace then
				-- Not allowed to continue the name anymore!
				tokenizer_substate = T_SUBSTATE_INIT2
			elseif tokenizer_substate == T_SUBSTATE_INIT2 or not self:ch_is_name(ch) then
				self:raise_fail_char(new, ch, ">")
			end
		elseif tokenizer_state == T_STATE_IN_COMMENT then
			-- Just wait for the -->
			if ch == CH.DASH and self:cur_ch(1) == CH.DASH then
				-- If we have another dash, it MUST have > after it
				if self:cur_ch(2) ~= CH.GT then
					self:raise_fail(new, "Malformed XML comment containing '--'")
				end
				self:advance_ch(3)
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				return
			end
		elseif tokenizer_state == T_STATE_IN_TEXT then
			if ch == CH.LT then
				-- Oh, the next tag, stop stop stop
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				return
			elseif ch == CH.GT then
				-- Okay, this can happen, but ]]> can't
				if self:cur_ch(-1) == CH.RBRACK and self:cur_ch(-2) == CH.RBRACK then
					self:raise_fail(new, "']]>' encountered in text, which does not close a CDATA")
				end
			elseif ch == CH.AMP then
				-- Entity, verify it's well-formed.
				self:advance_reference(new)
			end
		elseif tokenizer_state == T_STATE_IN_CDATA then
			-- Just wait for the ]]>
			if ch == CH.RBRACK and self:cur_ch(1) == CH.RBRACK and self:cur_ch(2) == CH.GT then
				self:advance_ch(3)
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				return
			end
		elseif tokenizer_state == T_STATE_IN_PI then
			-- This can be either <?target value?> or <?target?>.
			-- The target is not allowed to be any form of "xml".
			-- Substates:
			-- T_SUBSTATE_INIT: in target name, expect more NameChar or whitespace or ?>
			-- T_SUBSTATE_INIT2: target was terminated with whitespace, just wait for the ?>

			local check_full_target = false
			local done = false

			if ch == CH.HUH and self:cur_ch(1) == CH.GT then
				-- ?> found
				if tokenizer_substate == T_SUBSTATE_INIT then
					-- We were in the target, so check the target name
					check_full_target = true
				end
				done = true
			elseif tokenizer_substate == T_SUBSTATE_INIT and self:ch_is_name(ch) then
				-- part of target, pass
			elseif tokenizer_substate == T_SUBSTATE_INIT and whitespace then
				tokenizer_substate = T_SUBSTATE_INIT2
				check_full_target = true
			elseif tokenizer_substate == T_SUBSTATE_INIT then
				self:raise_fail_char(new, ch, "?>")
			end

			if check_full_target then
				local target = self.string:sub(self.token_list[new].start+2, self.string_cursor-1)
				if target:lower() == "xml" then
					self:raise_fail(new, "Non-well-formed <?" .. target .. "?>")
				end
			end

			if done then
				self:advance_ch(2)
				self.token_list[new].length = self.string_cursor - self.token_list[new].start
				return
			end
		end

		self:advance_ch(1)
	end
end

local function patch_for_tag_opening(name, attributes, attributes_order)
	-- Get a patch structure for TAG_OPENING or TAG_SELFCLOSING
	if attributes == nil and attributes_order == nil then
		attributes = {}
		attributes_order = {}
	end
	return {
		name = tostring(name),
		attributes = attributes,
		attributes_order = attributes_order
	}
end

local function patch_for_tag_closing(name)
	-- Get a patch structure for TAG_CLOSING
	return {
		name = tostring(name)
	}
end

local function patch_for_text(text)
	-- Get a patch structure for TEXT or CDATA
	-- Reminder: Whether it's TEXT or CDATA is visible by the type
	return {
		text = tostring(text)
	}
end

local function patch_for_comment(comment)
	-- Get a patch structure for COMMENT
	return {
		comment = tostring(comment)
	}
end

local function patch_for_pi(target, value)
	-- Get a patch structure for PI
	if value ~= nil then
		value = tostring(value)
	end
	return {
		target = tostring(target),
		value = value
	}
end

function VedXML:patch(cur)
	-- Internal function: Ensure the current node is in patched format.
	-- This means it's no longer referenced from self.string,
	-- but it's a structured Lua table that can be modified.
	-- cur: any
	cur = self:ci(cur)

	if self.token_list[cur].is_patched then
		return
	end

	local tok_type = self.token_list[cur].type
	if tok_type == TOKEN_TYPE.TAG_OPENING or tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		self.patches[cur] = patch_for_tag_opening(self:get_name(cur), self:get_attributes(cur), self:get_attributes_order(cur))
	elseif tok_type == TOKEN_TYPE.TAG_CLOSING then
		self.patches[cur] = patch_for_tag_closing(self:get_name(cur))
	elseif tok_type == TOKEN_TYPE.TEXT or tok_type == TOKEN_TYPE.CDATA then
		self.patches[cur] = patch_for_text(self:get_text(cur))
	elseif tok_type == TOKEN_TYPE.COMMENT then
		self.patches[cur] = patch_for_comment(self:get_comment(cur))
	elseif tok_type == TOKEN_TYPE.PI then
		self.patches[cur] = patch_for_pi(self:get_pi(cur))
	else
		self:raise_error("Attempt to patch token of type " .. self:get_type_name(cur))
	end

	self.token_list[cur].length = 0
	self.token_list[cur].is_patched = true
end

function VedXML:insert_new_patched(cur, tok_type, ...)
	-- Internal function: insert a new token of type tok_type after cur,
	-- and add a patch for it as well.
	-- ... is passed to the corresponding patch_for_* function.
	-- Returns a cursor to the new token.
	-- You still need to fill in the parent (and maybe spouse etc) correctly!!!
	-- cur: any
	cur = self:ci(cur)

	local patch_for
	if tok_type == TOKEN_TYPE.TAG_OPENING or tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		patch_for = patch_for_tag_opening
	elseif tok_type == TOKEN_TYPE.TAG_CLOSING then
		patch_for = patch_for_tag_closing
	elseif tok_type == TOKEN_TYPE.TEXT or tok_type == TOKEN_TYPE.CDATA then
		patch_for = patch_for_text
	elseif tok_type == TOKEN_TYPE.COMMENT then
		patch_for = patch_for_comment
	elseif tok_type == TOKEN_TYPE.PI then
		patch_for = patch_for_pi
	else
		self:raise_error("Attempt to insert patched token of type " .. tostring(tok_type))
	end

	local new = self:ll_insert(cur)
	self.token_list[new].type = tok_type
	self.token_list[new].is_patched = true
	self.patches[new] = patch_for(...)

	return new
end

function VedXML:each_unpatched_attribute_indices(cur)
	-- For internal usage only: get string indices to the start and end of the name
	-- and value of each attribute in this (unpatched!) opening or selfclosing tag.
	-- The indexes you get are (of course based on their position in self.string, so you won't get 1):
	-- name = "value!"
	-- ^  ^    ^    ^
	-- 1  4    9    14
	-- This is made easier since we validated the tag syntax during tokenization, so we may cut lots of corners now.
	-- Cursor type checks and whatnot (including non-patchedness) assumed to be done by caller.
	local none = function()
		return nil, nil, nil, nil
	end

	-- We're sure we can skip '<'...
	local str_cur = self.token_list[self:ci(cur)].start + 1

	local ch = self:ch_decode(self.string, str_cur, 0)
	while self:ch_is_name(ch) do
		ch, str_cur = self:ch_decode(self.string, str_cur, 1)
	end

	return function()
		-- We're either one beyond the tag's name, or one beyond the final quote of the last value
		while self:ch_is_whitespace(ch) do
			ch, str_cur = self:ch_decode(self.string, str_cur, 1)
		end

		-- Either NameStartChar, or / or >
		if ch == CH.SLASH or ch == CH.GT then
			return nil, nil, nil, nil
		end

		-- Definitely NameStartChar now!
		local name_start = str_cur
		while self:ch_is_name(ch) do
			ch, str_cur = self:ch_decode(self.string, str_cur, 1)
		end

		-- Just after the last NameChar... (so maybe an =)
		local name_end = str_cur - 1

		-- We are gonna be throwing this character (just after last NameChar) away...
		-- But there MUST be at minimum an = anyway.
		local is_apos = false
		while true do
			ch, str_cur = self:ch_decode(self.string, str_cur, 1)
			if ch == CH.QUOT then
				break
			elseif ch == CH.APOS then
				is_apos = true
				break
			end
		end

		-- On the opening " or '...
		local value_start = str_cur + 1

		while true do
			ch, str_cur = self:ch_decode(self.string, str_cur, 1)
			if (not is_apos and ch == CH.QUOT)
			or (is_apos and ch == CH.APOS) then
				break
			end
		end

		-- On the closing " or '...
		-- Note that on an empty value, value_end == value_start - 1, which is correct with :sub() and such.
		local value_end = str_cur - 1

		ch, str_cur = self:ch_decode(self.string, str_cur, 1)

		return name_start, name_end, value_start, value_end
	end
end

function VedXML:get_type(cur)
	-- Get the type that this cursor is pointing to.
	-- cur: any
	return self.token_list[self:ci(cur)].type
end

local function token_type_to_string(tok_type)
	for k,v in pairs(TOKEN_TYPE) do
		if v == tok_type then
			return k
		end
	end
	return tostring(tok_type)
end

function VedXML:get_type_name(cur)
	-- Get the name of the type that this cursor is pointing to, as a string ("TAG_OPENING", "TEXT", etc)
	-- cur: any
	return token_type_to_string(self:get_type(cur))
end

function VedXML:has_child_elements(cur)
	-- Returns true if there are further elements inside this element (opening/closing/selfclosing tags),
	-- false if there's only text/comments or this is selfclosing
	-- cur: any
	local tok_type = self:get_type(cur)
	if tok_type ~= TOKEN_TYPE.TAG_OPENING then
		return false
	end

	for cur2 in self:each_child_token(cur, false) do
		tok_type = self.token_list[cur2].type
		if tok_type == TOKEN_TYPE.TAG_OPENING
		or tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
			return true
		end
	end

	return false
end

function VedXML:get_name(cur)
	-- Get the name of this element (<element> -> "element").
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TAG_CLOSING

	cur = self:ci(cur)

	local tok_type = self.token_list[cur].type
	local name_offset -- for non-patched
	if tok_type == TOKEN_TYPE.TAG_OPENING or tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		-- <
		name_offset = 1
	elseif tok_type == TOKEN_TYPE.TAG_CLOSING then
		-- </
		name_offset = 2
	else
		self:raise_error("Trying to call :get_name on type " .. self:get_type_name(cur))
	end

	if self.token_list[cur].is_patched then
		return self.patches[cur].name
	end

	local name_start = self.token_list[cur].start + name_offset

	-- The name is terminated with either whitespace, '>', or '/'
	-- It also HAS to have at least one character (we validated that earlier)
	name_end = name_start
	while true do
		local ch = self.string:byte(name_end+1)
		if self:ch_is_whitespace(ch) or ch == CH.GT or ch == CH.SLASH then
			return self.string:sub(name_start, name_end)
		end
		name_end = name_end + 1
	end
end

function VedXML:has_name(cur, name)
	-- Check if the name of the current element equals the given name.
	-- name can also be a cursor pointing to another tag.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TAG_CLOSING

	if type(name) == "number" then
		return self:get_name(cur) == self:get_name(name)
	end
	return self:get_name(cur) == name
end

function VedXML:set_name(cur, name)
	-- Set the name of this element.
	-- If given an opening tag, the closing tag will be changed too.
	-- cur: TAG_OPENING, TAG_SELFCLOSING

	cur = self:ci(cur)

	local tok_type = self.token_list[cur].type
	if tok_type ~= TOKEN_TYPE.TAG_OPENING
	and tok_type ~= TOKEN_TYPE.TAG_SELFCLOSING then
		self:raise_error("Trying to call :set_name on type " .. self:get_type_name(cur))
	end

	self:assert_wellformed_name(name)
	name = tostring(name)
	self:patch(cur)
	self.patches[cur].name = name

	if tok_type == TOKEN_TYPE.TAG_OPENING then
		-- Also change the name of the closing tag
		local cur_end = self:get_closing_token(cur)
		self:patch(cur_end)
		self.patches[cur_end].name = name
	end
end

function VedXML:xmlnumericentities(text)
	-- Return the given string with real control characters (<0x20)
	-- encoded into numeric XML entities like &#31;.
	-- Is used by :xmlspecialchars(text), use that for completeness.
	return (
		text:gsub(
			"%c",
			function(c)
				return "&#" .. string.byte(c) .. ";"
			end
		)
	)
end

function VedXML:unxmlnumericentities(text)
	-- Return the given string with numeric XML entities (like &#32;)
	-- decoded into real characters.
	-- Is used by :unxmlspecialchars(text), use that for completeness.
	return (
		text:gsub(
			"&#(%d+);",
			function(n)
				return utf8.char(tonumber(n))
			end
		):gsub(
			"&#x(%x+);",
			function(n)
				return utf8.char(tonumber(n,16))
			end
		)
	)
end

function VedXML:xmlspecialchars(text)
	-- Return the given string with real special entities like < > &
	-- encoded into XML entities like &lt; &gt; &amp;
	return self:xmlnumericentities(
		text
		:gsub("&", "&amp;")
		:gsub("\"", "&quot;")
		:gsub("'", "&apos;")
		:gsub("<", "&lt;")
		:gsub(">", "&gt;")
	)
end

function VedXML:unxmlspecialchars(text)
	-- Return the given string with XML entities like &lt; &gt; &amp;
	-- decoded into < > &
	return (
		self:unxmlnumericentities(text)
		:gsub("&gt;", ">")
		:gsub("&lt;", "<")
		:gsub("&apos;", "'")
		:gsub("&quot;", "\"")
		:gsub("&amp;", "&")
	)
end

function VedXML:uncr(text)
	-- Internal function: Return the given string with CR removed
	-- as specified in "2.11 End-of-Line Handling"
	if not self.any_cr then
		return text
	end

	return (
		text
		:gsub("\r\n", "\n")
		:gsub("\r", "\n")
	)
end

function VedXML:get_text_or_nil(cur, allow_nested)
	-- Get text content within element, processed/unescaped.
	-- cur must point to opening/selfclosing tag. Or to a text.
	-- <a></a> and <a/> are distinguished: the former gives an empty string, the latter gives nil.
	-- To get an empty string rather than nil, use :get_text instead.
	-- If allow_nested is true, ignore child elements ("some <b>more</b> text" -> "some more text")
	-- If allow_nested is false or unspecified, the presence of child elements is unexpected and raises an error.
	-- cur: TEXT, CDATA, TAG_OPENING, TAG_SELFCLOSING

	cur = self:ci(cur)
	local tok_type = self.token_list[cur].type

	if tok_type == TOKEN_TYPE.TEXT then
		-- Aa
		if self.token_list[cur].is_patched then
			return self.patches[cur].text
		end
		local start = self.token_list[cur].start
		local length = self.token_list[cur].length
		return self:unxmlspecialchars(self:uncr(self.string:sub(start, start+length-1)))
	elseif tok_type == TOKEN_TYPE.CDATA then
		-- <![CDATA[Aa]]>
		if self.token_list[cur].is_patched then
			return self.patches[cur].text
		end
		local start = self.token_list[cur].start + 9
		local length = self.token_list[cur].length - 12
		return self:uncr(self.string:sub(start, start+length-1))
	elseif tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		return nil
	elseif tok_type == TOKEN_TYPE.TAG_OPENING then
		local text_table = {}
		for cur2 in self:each_child_token(cur, false) do
			tok2_type = self.token_list[cur2].type

			if tok2_type == TOKEN_TYPE.TEXT or tok2_type == TOKEN_TYPE.CDATA then
				table.insert(text_table, self:get_text(cur2))
			elseif tok2_type == TOKEN_TYPE.COMMENT or tok2_type == TOKEN_TYPE.PI then
				-- Ignore no matter what
			elseif (
				tok2_type == TOKEN_TYPE.TAG_OPENING or
				tok2_type == TOKEN_TYPE.TAG_CLOSING or
				tok2_type == TOKEN_TYPE.TAG_SELFCLOSING
			) then
				if not allow_nested then
					self:raise_error(
						"There's a <" .. self:get_name(cur2) .. "> tag inside <"
						.. self:get_name(cur) .. ">, instead of just text"
					)
				end
			else
				-- What is this?
				self:raise_error(
					"There's an unexpected child of type " .. self:get_type_name(cur2)
					.. " inside <" .. self:get_name(cur) .. ">, instead of just text"
				)
			end
		end
		return table.concat(text_table)
	end

	self:raise_error("Trying to call :get_text or :get_text_or_nil on type " .. self:get_type_name(cur))
end

function VedXML:get_text(cur, allow_nested)
	-- Get text content within element, processed/unescaped.
	-- cur must point to opening/selfclosing tag. Or to a text.
	-- If given a selfclosing tag, returns an empty string.
	-- If allow_nested is true, ignore child elements ("some <b>more</b> text" -> "some more text")
	-- If allow_nested is false or unspecified, the presence of child elements is unexpected and raises an error.
	-- cur: TEXT, CDATA, TAG_OPENING, TAG_SELFCLOSING
	local text = self:get_text_or_nil(cur, allow_nested)
	if text == nil then
		return ""
	end
	return text
end

function VedXML:set_text(cur, text)
	-- Set the text content for a tag or text node.
	-- If given an opening tag, clears all children.
	-- Can be nil to change an opening tag into a self-closing tag
	-- (or to delete a specific TEXT/CDATA node completely).
	-- Can be a number, but it will be changed to a string.
	-- cur: TEXT, CDATA, TAG_OPENING, TAG_SELFCLOSING

	cur = self:ci(cur)
	local tok_type = self.token_list[cur].type

	if text ~= nil then
		self:assert_paras_for(TOKEN_TYPE.TEXT, text)
	end

	if tok_type == TOKEN_TYPE.TEXT or tok_type == TOKEN_TYPE.CDATA then
		if text == nil then
			self:delete(cur)
			return
		else
			self:patch(cur)
			self.patches[cur].text = tostring(text)
			return
		end
	elseif tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		if text == nil then
			return
		end

		self:open_selfclosing_tag(cur)
	elseif tok_type == TOKEN_TYPE.TAG_OPENING then
		if text == nil then
			self:clear(cur)
			return
		end

		self:clear_open(cur)
	else
		self:raise_error("Trying to call :set_text on type " .. self:get_type_name(cur))
	end

	-- We now know we have an empty opening tag that needs a text node inserted!
	local new = self:insert_new_patched(cur, TOKEN_TYPE.TEXT, text)
	self.token_list[new].parent = cur
end

function VedXML:set_cdata(cur, do_set_cdata)
	-- Can change a TEXT into a CDATA and vice versa.
	-- cur: TEXT, CDATA

	cur = self:ci(cur)
	local tok_type = self.token_list[cur].type

	if tok_type == TOKEN_TYPE.TEXT and do_set_cdata then
		self:patch(cur)
		self.token_list[cur].type = TOKEN_TYPE.CDATA
	elseif tok_type == TOKEN_TYPE.CDATA and not do_set_cdata then
		self:patch(cur)
		self.token_list[cur].type = TOKEN_TYPE.TEXT
	elseif tok_type ~= TOKEN_TYPE.TEXT and tok_type ~= TOKEN_TYPE.CDATA then
		self:raise_error("Trying to call :get_cdata on type " .. self:get_type_name(cur))
	end
end

function VedXML:attribute_value_normalization(str)
	-- Takes the raw text from an attribute value from the XML
	-- and applies "3.3.3 Attribute-Value Normalization" to it

	if self.disable_avn then
		return self:unxmlspecialchars(self:uncr(str))
	end

	if self.any_cr then
		return self:unxmlspecialchars(
			str
			:gsub("\r\n", " ")
			:gsub("\r", " ")
			:gsub("\n", " ")
			:gsub("\t", " ")
		)
	end

	return self:unxmlspecialchars(
		str
		:gsub("\n", " ")
		:gsub("\t", " ")
	)
end

function VedXML:get_attribute(cur, key)
	-- Get attribute value of element (unescaped).
	-- cur: TAG_OPENING, TAG_SELFCLOSING

	if key == nil then
		self:raise_error("Trying to call :get_attribute with nil key")
	end

	cur = self:ci_opening_selfclosing(cur)

	if self.token_list[cur].is_patched then
		return self.patches[cur].attributes[key]
	end

	for name_start, name_end, value_start, value_end in self:each_unpatched_attribute_indices(cur) do
		if self.string:sub(name_start, name_end) == key then
			return self:attribute_value_normalization(self.string:sub(value_start, value_end))
		end
	end

	return nil
end

function VedXML:set_attribute(cur, key, value)
	-- Set key="value" on the given tag. Can be nil to remove the attribute.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	cur = self:ci_opening_selfclosing(cur)

	self:assert_wellformed_name(key)
	key = tostring(key)
	if value ~= nil then
		self:assert_wellformed_chardata(value)
		value = tostring(value)
	end

	self:patch(cur)

	local exists = self.patches[cur].attributes[key] ~= nil
	if exists and value == nil then
		-- Removing the attribute, so remove it from the order table too
		for k,v in pairs(self.patches[cur].attributes_order) do
			if key == v then
				table.remove(self.patches[cur].attributes_order, k)
				break
			end
		end
	end

	self.patches[cur].attributes[key] = value

	if not exists and value ~= nil then
		table.insert(self.patches[cur].attributes_order, key)
	end
end

function VedXML:get_attributes(cur)
	-- Get a table of all attributes belonging to this element.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	cur = self:ci_opening_selfclosing(cur)

	if self.token_list[cur].is_patched then
		return self.patches[cur].attributes
	end

	local attributes = {}
	for name_start, name_end, value_start, value_end in self:each_unpatched_attribute_indices(cur) do
		local name = self.string:sub(name_start, name_end)
		attributes[name] = self:attribute_value_normalization(self.string:sub(value_start, value_end))
	end

	return attributes
end

function VedXML:get_attributes_order(cur)
	-- Get the order in which the attributes on this element are currently placed.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	cur = self:ci_opening_selfclosing(cur)

	if self.token_list[cur].is_patched then
		return self.patches[cur].attributes_order
	end

	local attributes_order = {}
	for name_start, name_end, value_start, value_end in self:each_unpatched_attribute_indices(cur) do
		local name = self.string:sub(name_start, name_end)
		table.insert(attributes_order, name)
	end

	return attributes_order
end

function VedXML:open_selfclosing_tag(cur)
	-- Change a selfclosing tag to an opening+closing one.
	-- If passed an opening tag, it is left unchanged, for convenience.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	cur = self:ci(cur)

	if self.token_list[cur].type == TOKEN_TYPE.TAG_OPENING then
		return
	elseif self.token_list[cur].type ~= TOKEN_TYPE.TAG_SELFCLOSING then
		self:raise_error("Trying to call :open_selfclosing_tag on type " .. self:get_type_name(cur))
	end

	self:patch(cur)
	self.token_list[cur].type = TOKEN_TYPE.TAG_OPENING
	local new = self:insert_new_patched(cur, TOKEN_TYPE.TAG_CLOSING, self:get_name(cur))
	self.token_list[new].parent = self.token_list[cur].parent
	self.token_list[cur].spouse = new
	self.token_list[new].spouse = cur
end

function VedXML:clear_open(cur)
	-- Delete all child nodes of this element.
	-- If clearing an opening tag, it is left open, and NOT turned into a selfclosing tag.
	-- Selfclosing tags are left selfclosed.
	-- If clearing the FILE_START, the entire file is cleared and only a selfclosing root tag is left.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, FILE_START
	cur = self:ci(cur)

	local tok_type = self.token_list[cur].type
	if tok_type == TOKEN_TYPE.TAG_SELFCLOSING then
		-- Convenience
		return
	elseif tok_type == TOKEN_TYPE.FILE_START then
		-- Clearing the entire file means leaving just a root tag. This is basically a complete reset
		local root_name = self:get_name(nil)
		self.string = "<" .. root_name .. "/>"
		self.string_cursor = 1
		self.string_cursor_line = 1
		self.string_cursor_col = 1
		self.at_eof = false
		self.any_cr = false
		local sizeof_item = ffi.sizeof("token_list_item")
		for t = 0, self.last_token do
			ffi.fill(self.token_list[t], sizeof_item)
		end
		self.token_list[0].type = TOKEN_TYPE.FILE_START
		self.last_token = 0
		self.first_free_row = 1
		self.tokenizer_open_tags = {}
		self.root_element = nil
		self.root_element_seen = false
		self.xml_declaration_seen = false
		self.patches = {}
		self.err = nil
		self.errfail = false
		return
	elseif tok_type ~= TOKEN_TYPE.TAG_OPENING then
		self:raise_error_type(cur, 1)
	end

	-- Now we know we have an opening tag!
	-- Delete everything from its first child, up to but not including its closing tag.
	local cur_closing = self:get_closing_token(cur)
	self:ll_unlink(self.token_list[cur].next, cur_closing)

	self:set_newlines_before(cur_closing, 0)
end

function VedXML:clear(cur)
	-- Delete all child nodes of this element.
	-- If clearing an opening tag, it is turned into a selfclosing tag.
	-- If clearing the FILE_START, the entire file is cleared and only a selfclosing root tag is left.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, FILE_START
	cur = self:ci(cur)

	self:clear_open(cur)

	if self.token_list[cur].type == TOKEN_TYPE.TAG_OPENING then
		self:patch(cur)
		self:ll_unlink(self:get_closing_token(cur))
		self.token_list[cur].type = TOKEN_TYPE.TAG_SELFCLOSING
		self.token_list[cur].spouse = 0
	end
end

function VedXML:delete(cur)
	-- Delete the current element or node, and all of its children.
	-- Does not work on the root element.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	cur = self:ci(cur)

	-- Never delete the root element
	if self.root_element_seen and cur == self.root_element then
		self:raise_error("Attempt to delete root element")
	end

	local tok_type = self.token_list[cur].type
	if tok_type == TOKEN_TYPE.TAG_OPENING then
		self:clear(cur)
	elseif tok_type ~= TOKEN_TYPE.TAG_SELFCLOSING
	and    tok_type ~= TOKEN_TYPE.TEXT
	and    tok_type ~= TOKEN_TYPE.CDATA
	and    tok_type ~= TOKEN_TYPE.COMMENT
	and    tok_type ~= TOKEN_TYPE.PI then
		self:raise_error("Attempt to delete token of type " .. self:get_type_name(cur))
	end

	-- This can't point to an opening tag anymore - self:clear(cur) makes it self-closing
	self:ll_unlink(cur)
end

function VedXML:get_newlines_before(cur)
	-- Get the number of newlines before this token when output.
	-- If preserve_all_whitespace is true, this is always loaded from file as 0
	-- because whitespace (including newlines) are put in TEXT tokens instead.
	-- cur: any
	return self.token_list[self:ci(cur)].newlines_before
end

function VedXML:set_newlines_before(cur, newlines_before)
	-- Set the number of newlines before this token when output.
	-- cur: any
	if newlines_before < 0 or newlines_before >= 255 then
		self:raise_error("newlines_before must be between 0-255")
	end
	self.token_list[self:ci(cur)].newlines_before = newlines_before
end

function VedXML:get_comment(cur)
	-- Get the text inside a comment.
	-- cur: COMMENT
	cur = self:ci(cur)

	if self.token_list[cur].type ~= TOKEN_TYPE.COMMENT then
		self:raise_error("Trying to call :get_comment on type " .. self:get_type_name(cur))
	end

	if self.token_list[cur].is_patched then
		return self.patches[cur].comment
	end

	-- <!--Aa-->
	local start = self.token_list[cur].start + 4
	local length = self.token_list[cur].length - 7
	return self:uncr(self.string:sub(start, start+length-1))
end

function VedXML:set_comment(cur, comment)
	-- Set the text inside a comment.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: COMMENT
	cur = self:ci(cur)

	if self.token_list[cur].type ~= TOKEN_TYPE.COMMENT then
		self:raise_error("Trying to call :set_comment on type " .. self:get_type_name(cur))
	end

	self:assert_paras_for(TOKEN_TYPE.COMMENT, comment)

	self:patch(cur)
	self.patches[cur].comment = tostring(comment)
end

function VedXML:get_pi(cur)
	-- Get the target and value of this Processing Instruction.
	-- cur: PI
	cur = self:ci(cur)

	if self.token_list[cur].type ~= TOKEN_TYPE.PI then
		self:raise_error("Trying to call :get_pi on type " .. self:get_type_name(cur))
	end

	if self.token_list[cur].is_patched then
		return self.patches[cur].target, self.patches[cur].value
	end

	local start = self.token_list[cur].start + 2
	local length = self.token_list[cur].length - 4

	local first_whitespace = nil
	for i = start, start+length-1 do
		local ch = self.string:byte(i)
		if self:ch_is_whitespace(ch) then
			first_whitespace = i
			break
		end
	end
	if first_whitespace == nil then
		-- <?target?>
		return self.string:sub(start, start+length-1), nil
	else
		-- <?target value?>
		return self.string:sub(start, first_whitespace-1), self:uncr(self.string:sub(first_whitespace+1, start+length-1))
	end
end

function VedXML:set_pi(cur, target, value)
	-- Set the target and/or value of this Processing Instruction.
	-- If target is nil, it is unchanged.
	-- If value is nil, it is removed.
	-- cur: PI
	cur = self:ci(cur)

	if self.token_list[cur].type ~= TOKEN_TYPE.PI then
		self:raise_error("Trying to call :set_pi on type " .. self:get_type_name(cur))
	end

	if target ~= nil then
		self:assert_wellformed_name(target)
		target = tostring(target)
		if target:lower() == "xml" then
			self:raise_error("Processing Instruction target cannot be \"" .. target .. "\"")
		end
	end
	if value ~= nil then
		self:assert_wellformed_chardata(value)
		value = tostring(value)
		if value:find("?>", 1, true) then
			self:raise_error("Processing Instruction values cannot contain ?>")
		end
	end

	self:patch(cur)
	if target ~= nil then
		self.patches[cur].target = target
	end
	self.patches[cur].value = value
end

function VedXML:is_inside_root(cur)
	-- Returns true if the cursor is inside the root element,
	-- false if outside (or the root opening/closing tag).
	-- cur: any
	cur = self:ci(cur)

	if not self.root_element_seen then
		return false
	end

	local cmp = 0
	while cmp ~= self.root_element do
		cmp = self.token_list[cmp].next

		if cmp == cur then
			return false
		end
	end

	if self.token_list[cmp].type == TOKEN_TYPE.TAG_SELFCLOSING then
		-- If the root tag is selfclosing, and we have a cursor in our hands, must be beyond
		return false
	end

	if self.token_list[cmp].spouse == 0 then
		-- Okay so, we have a cursor in our hands,
		-- and we haven't seen the root closing tag yet,
		-- which means it's inside the root.
		return true
	end

	cmp = self.token_list[cmp].spouse

	while cmp ~= self.last_token and self.token_list[cmp].type ~= TOKEN_TYPE.FILE_END do
		cmp = self.token_list[cmp].next

		if cmp == cur then
			return false
		end
	end

	-- We've seen everything outside the root tag, so it must be inside
	return true
end

function VedXML:add_child_token(cur, as_last, newlines_between, tok_type, ...)
	-- Internal function: add a token as a child inside this element.
	-- Much like :insert_new_patched, but you don't need to worry about setting the parent.
	-- ... is validated, and passed to the corresponding patch_for_* function.
	-- newlines_between acts as "before" if last, and "after" if first.
	-- Returns a cursor to the new token.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	cur = self:ci_opening_selfclosing(cur)

	self:assert_paras_for(tok_type, ...)

	if  tok_type ~= TOKEN_TYPE.TAG_SELFCLOSING
	and tok_type ~= TOKEN_TYPE.TEXT
	and tok_type ~= TOKEN_TYPE.CDATA
	and tok_type ~= TOKEN_TYPE.COMMENT
	and tok_type ~= TOKEN_TYPE.PI then
		self:raise_error("Trying to add " .. token_type_to_string(tok_type) .. " as child token")
	end

	if newlines_between == nil then
		if self.preserve_all_whitespace then
			newlines_between = 0
		else
			newlines_between = 1
		end
	end
	if newlines_between < 0 or newlines_between >= 255 then
		self:raise_error("newlines_between must be between 0-255")
	end

	self:open_selfclosing_tag(cur)
	local cur_closing = self:get_closing_token(cur)
	if not self.preserve_all_whitespace and newlines_between ~= 0 and self:get_newlines_before(cur_closing) == 0 then
		self:set_newlines_before(cur_closing, 1)
	end

	local token_before = cur
	if as_last then
		token_before = self.token_list[cur_closing].prev
	end

	local new = self:insert_new_patched(token_before, tok_type, ...)
	self.token_list[new].parent = cur
	if not as_last then
		-- As first - we don't have newlines_after
		self.token_list[new].newlines_before = self.token_list[self.token_list[new].next].newlines_before
		self.token_list[self.token_list[new].next].newlines_before = newlines_between
	else
		-- As last
		self.token_list[new].newlines_before = newlines_between
	end

	return new
end

function VedXML:add_sibling_token(cur, as_after, newlines_between, tok_type, ...)
	-- Internal function: add a token as a sibling next to this element.
	-- Much like :insert_new_patched, but you don't need to worry about setting the parent.
	-- ... is validated, and passed to the corresponding patch_for_* function.
	-- newlines_between acts as "before" if after, and "after" if before. Clear?
	-- There are some restrictions what you can place where,
	-- for example, elements and text can't be placed outside the root element,
	-- and you can't place something before FILE_START or after FILE_END.
	-- Returns a cursor to the new token.
	-- cur: FILE_START, FILE_END, TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	cur = self:ci(cur)

	self:assert_paras_for(tok_type, ...)

	local cur_tok_type = self.token_list[cur].type
	if cur_tok_type == TOKEN_TYPE.FILE_START then
		if not as_after then
			self:raise_error("Trying to add something before the start of the file")
		end
	elseif cur_tok_type == TOKEN_TYPE.FILE_END then
		if as_after then
			self:raise_error("Trying to add something after the end of the file")
		end
	elseif cur_tok_type ~= TOKEN_TYPE.TAG_OPENING
	and    cur_tok_type ~= TOKEN_TYPE.TAG_SELFCLOSING
	and    cur_tok_type ~= TOKEN_TYPE.TEXT
	and    cur_tok_type ~= TOKEN_TYPE.CDATA
	and    cur_tok_type ~= TOKEN_TYPE.COMMENT
	and    cur_tok_type ~= TOKEN_TYPE.PI then
		self:raise_error("Trying to add sibling to " .. self:get_type_name(cur) .. " token")
	end

	if tok_type == TOKEN_TYPE.TAG_SELFCLOSING
	or tok_type == TOKEN_TYPE.TEXT
	or tok_type == TOKEN_TYPE.CDATA then
		-- Cannot add this outside of root
		if not self:is_inside_root(cur) then
			self:raise_error("Trying to add " .. token_type_to_string(tok_type) .. " outside of root element")
		end
	elseif tok_type ~= TOKEN_TYPE.COMMENT
	and    tok_type ~= TOKEN_TYPE.PI then
		self:raise_error("Trying to add " .. token_type_to_string(tok_type) .. " as sibling token")
	end

	if newlines_between == nil then
		if self.preserve_all_whitespace then
			newlines_between = 0
		else
			newlines_between = 1
		end
	end
	if newlines_between < 0 or newlines_between >= 255 then
		self:raise_error("newlines_between must be between 0-255")
	end

	-- All checks clear - now, where do we place it?
	local token_before
	if as_after then
		-- Place it after this token, but make sure it's a sibling!
		if cur_tok_type == TOKEN_TYPE.TAG_OPENING then
			-- Place it after our closing tag
			token_before = self:get_closing_token(cur)
		else
			-- No deeper level here
			token_before = cur
		end
	else
		-- Place it before this token, we don't allow targetting closing tags so no deeper level here!
		token_before = self.token_list[cur].prev
	end

	local new = self:insert_new_patched(token_before, tok_type, ...)
	self.token_list[new].parent = self.token_list[cur].parent
	if not as_after then
		-- As before - we don't have newlines_after
		self.token_list[new].newlines_before = self.token_list[cur].newlines_before
		self.token_list[cur].newlines_before = newlines_between
	else
		-- As after
		self.token_list[new].newlines_before = newlines_between
	end

	return new
end

function VedXML:add_element_in_first(cur, name, newlines_after)
	-- Add an element (will be selfclosing) INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, false, newlines_after, TOKEN_TYPE.TAG_SELFCLOSING, name)
end

function VedXML:add_element_in_last(cur, name, newlines_before)
	-- Add an element (will be selfclosing) INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, true, newlines_before, TOKEN_TYPE.TAG_SELFCLOSING, name)
end

function VedXML:add_element_before(cur, name, newlines_after)
	-- Add an element (will be selfclosing) as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, false, newlines_after, TOKEN_TYPE.TAG_SELFCLOSING, name)
end

function VedXML:add_element_after(cur, name, newlines_before)
	-- Add an element (will be selfclosing) as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, true, newlines_before, TOKEN_TYPE.TAG_SELFCLOSING, name)
end

function VedXML:add_comment_in_first(cur, comment, newlines_after)
	-- Add a comment INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, false, newlines_after, TOKEN_TYPE.COMMENT, comment)
end

function VedXML:add_comment_in_last(cur, comment, newlines_before)
	-- Add a comment INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, true, newlines_before, TOKEN_TYPE.COMMENT, comment)
end

function VedXML:add_comment_before(cur, comment, newlines_after)
	-- Add a comment as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, false, newlines_after, TOKEN_TYPE.COMMENT, comment)
end

function VedXML:add_comment_after(cur, comment, newlines_before)
	-- Add a comment as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, true, newlines_before, TOKEN_TYPE.COMMENT, comment)
end

function VedXML:add_pi_in_first(cur, target, value, newlines_after)
	-- Add a processing instruction INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, false, newlines_after, TOKEN_TYPE.PI, target, value)
end

function VedXML:add_pi_in_last(cur, target, value, newlines_before)
	-- Add a processing instruction INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	return self:add_child_token(cur, true, newlines_before, TOKEN_TYPE.PI, target, value)
end

function VedXML:add_pi_before(cur, target, value, newlines_after)
	-- Add a processing instruction as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, false, newlines_after, TOKEN_TYPE.PI, target, value)
end

function VedXML:add_pi_after(cur, target, value, newlines_before)
	-- Add a processing instruction as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	return self:add_sibling_token(cur, true, newlines_before, TOKEN_TYPE.PI, target, value)
end

function VedXML:add_text_in_first(cur, text, is_cdata)
	-- Add a text or cdata INSIDE the current element, to be the FIRST.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	local tok_type = TOKEN_TYPE.TEXT
	if is_cdata then
		tok_type = TOKEN_TYPE.CDATA
	end
	return self:add_child_token(cur, false, 0, tok_type, text)
end

function VedXML:add_text_in_last(cur, text, is_cdata)
	-- Add a text or cdata INSIDE the current element, to be the LAST.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
	local tok_type = TOKEN_TYPE.TEXT
	if is_cdata then
		tok_type = TOKEN_TYPE.CDATA
	end
	return self:add_child_token(cur, true, 0, tok_type, text)
end

function VedXML:add_text_before(cur, text, is_cdata)
	-- Add a text or cdata as a SIBLING, BEFORE the current node.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	local tok_type = TOKEN_TYPE.TEXT
	if is_cdata then
		tok_type = TOKEN_TYPE.CDATA
	end
	return self:add_sibling_token(cur, false, 0, tok_type, text)
end

function VedXML:add_text_after(cur, text, is_cdata)
	-- Add a text or cdata as a SIBLING, AFTER the current node.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
	local tok_type = TOKEN_TYPE.TEXT
	if is_cdata then
		tok_type = TOKEN_TYPE.CDATA
	end
	return self:add_sibling_token(cur, true, 0, tok_type, text)
end

function VedXML:utf16_to_utf8(big_endian)
	-- I know this is probably a waste of time, but for me it's a pretty easy
	-- (and fun) box to tick for being as compliant as possible...

	local len = self.string:len()
	if len % 2 ~= 0 then
		self:raise_error("Invalid UTF-16: odd number of bytes")
	end

	local utf8_table = {}
	local cur = 1
	local surrogate_1 = nil

	while cur < len do
		local code
		if big_endian then
			code = self.string:byte(cur)*256 + self.string:byte(cur+1)
		else
			code = self.string:byte(cur+1)*256 + self.string:byte(cur)
		end

		if code >= 0xD800 and code <= 0xDBFF then
			if surrogate_1 ~= nil or cur + 2 >= len then
				self:raise_error("Invalid UTF-16: Unexpected leading surrogate")
			end
			surrogate_1 = code
			code = nil
		elseif code >= 0xDC00 and code <= 0xDFFF then
			if surrogate_1 == nil then
				self:raise_error("Invalid UTF-16: Unexpected trailing surrogate")
			end
			code = 0x10000 + (surrogate_1-0xD800)*1024 + (code-0xDC00)
			surrogate_1 = nil
		elseif surrogate_1 ~= nil then
			self:raise_error("Invalid UTF-16: Incomplete surrogate pair")
		end

		if code ~= nil then
			table.insert(utf8_table, utf8.char(code))
		end

		cur = cur + 2
	end

	self.string = table.concat(utf8_table)
end

return {
	VedXMLDefault = VedXMLDefault,
	VedXML = VedXML,
	TOKEN_TYPE = TOKEN_TYPE
}
