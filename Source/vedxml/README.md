# VedXML

This is the XML library made for use in Ved.

It's designed to be fast, robust, and not that hard to use.

It can output pretty-printed XML (with human-readable indentation and newlines between elements), but can also work with strict preservation of whitespace if needed.

# Example

```lua
local vedxml = require("vedxml")
vedxml.VedXMLDefault.preserve_all_whitespace = false

local doc = vedxml.VedXML:new{
	string=[[
		<roottag>
			<options>
				<color>
					<r>128</r>
					<g>255</g>
				</color>
			</options>
		</roottag>
	]],
	root="roottag"
}

local color = doc:find(nil, "options", "color")
for cur in doc:each_child_element(color) do
	local name = doc:get_name(cur)
	local value = tonumber(doc:get_text(cur))
	print(name, value)
end
local b = doc:add_element_in_last(color, "b")
doc:set_text(b, "64")

print(doc:export())
```

Output:
```
r	128
g	255
<?xml version="1.0" encoding="UTF-8"?>
<roottag>
    <options>
        <color>
            <r>128</r>
            <g>255</g>
            <b>64</b>
        </color>
    </options>
</roottag>

```

# XML conformance

VedXML aims to be as compliant with the [XML 1.0](https://www.w3.org/TR/2008/REC-xml-20081126/) specification as possible, **with the exception of DTDs**. This parser rejects any document containing a `<!DOCTYPE`.

Unless you need strict whitespace preservation, you're encouraged to set `VedXMLDefault.preserve_all_whitespace = false` to avoid creating text nodes if they contain just whitespace. In that case, only the amount of newlines before each node is preserved, and newly added nodes will be added in a pretty-printed way by default.

Note that the difference between a selfclosing tag (`<tag/>`) and empty opening and closing tags (`<tag></tag>`) is distinguished in the API by treating the text value of selfclosing tags as `nil` and of opening+closing tags as an empty string. This applies both to getting and setting the text content (and being able to open+close a selfclosing tag and vice versa). I wouldn't recommend relying on this behavior as data storage, since the XML specification treats them as completely equivalent and other parsers may automatically change one to the other when loading and saving the document.

# Options

These options can either be set globally via VedXMLDefault, or when creating/loading a document by passing it to `:new`.

By default, the options are set to strict conformance with the XML spec, but certain annoying or waste-of-time options can be changed if desired.

```lua
{
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
```

# API reference

These are all functions for the `VedXML` class (aka the document object).

<details>
<summary>Creating, loading and saving</summary>

```lua
:new(o)
	-- Create or load an XML document.
	-- For example, to load XML from its file contents:
	--   xml = VedXML:new{string=contents}
	-- To create a new XML with a root element <book/>:
	--   xml = VedXML:new{root="book"}
	-- You can also use `root` to assert that the root element has the expected name:
	--   xml = VedXML:new{string=contents, root="book"}
	-- Any options from VedXMLDefault can also be specified here.
```

```lua
:export(callback)
	-- Export the document to a string.
	-- If callback is specified, it is called for every part of the document, and the function returns nil.
	-- If callback is not specified, the document is simply returned as a string.
```

```lua
:tokenize_to_end()
	-- Tokenize the entire document now (rather than lazy-loading when used)
```

</details>

<details>
<summary>Navigating the document</summary>

```lua
:find(cur, ...)
	-- Get cursor to first matching element INSIDE the element pointed to by cur.
	-- Multiple elements can be chained, so if you use :find(nil, "e1", "e2", "e3"),
	-- we will find the first <e3> in the first <e2> in the first <e1> inside the root element.
	-- Raises an error if one of the elements in the chain doesn't exist.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:find_or_nil(cur, ...)
	-- Like :find, but if one of the elements in the chain doesn't exist, return nil
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:find_or_add(cur, ...)
	-- Like :find, but if the elements don't exist, make them automatically.
	-- The last element (name) in the list will be a selfclosing tag.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:each_child_element(cur, name)
	-- Iterate over each child instance that is called <name>.
	-- If `name` is missing, match elements with any name (but not comments).
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:each_child_node(cur)
	-- Iterate over each child element, comment, text, the lot, but do not get children OF child elements
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:each_child_token(cur, nodes_only)
	-- Mostly for internal usage, but can be used if you need it.
	-- If nodes_only is false, get every opening and closing tag separately and do not distinguish children of children.
	-- If nodes_only is true, this is basically :each_child_node(cur).
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:get_closing_token(cur)
	-- Get the closing tag that belongs to this opening tag.
	-- cur: TAG_OPENING, FILE_START
```

```lua
:is_inside_root(cur)
	-- Returns true if the cursor is inside the root element,
	-- false if outside (or the root opening/closing tag).
	-- cur: any
```

</details>

<details>
<summary>Getting and setting on existing elements/nodes</summary>

```lua
:get_type(cur)
	-- Get the type that this cursor is pointing to.
	-- cur: any
```

```lua
:get_type_name(cur)
	-- Get the name of the type that this cursor is pointing to, as a string ("TAG_OPENING", "TEXT", etc)
	-- cur: any
```

```lua
:has_child_elements(cur)
	-- Returns true if there are further elements inside this element (opening/closing/selfclosing tags),
	-- false if there's only text/comments or this is selfclosing
	-- cur: any
```

```lua
:get_name(cur)
	-- Get the name of this element (<element> -> "element").
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TAG_CLOSING
```

```lua
:has_name(cur, name)
	-- Check if the name of the current element equals the given name.
	-- name can also be a cursor pointing to another tag.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TAG_CLOSING
```

```lua
:set_name(cur, name)
	-- Set the name of this element.
	-- If given an opening tag, the closing tag will be changed too.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:get_text(cur, allow_nested)
	-- Get text content within element, processed/unescaped.
	-- cur must point to opening/selfclosing tag. Or to a text.
	-- <a></a> and <a/> are distinguished: the former gives an empty string, the latter gives nil.
	-- If allow_nested is true, ignore child elements ("some <b>more</b> text" -> "some more text")
	-- If allow_nested is false or unspecified, the presence of child elements is unexpected and raises an error.
	-- cur: TEXT, CDATA, TAG_OPENING, TAG_SELFCLOSING
```

```lua
:set_text(cur, text)
	-- Set the text content for a tag or text node.
	-- If given an opening tag, clears all children.
	-- Can be nil to change an opening tag into a self-closing tag
	-- (or to delete a specific TEXT/CDATA node completely).
	-- Can be a number, but it will be changed to a string.
	-- cur: TEXT, CDATA, TAG_OPENING, TAG_SELFCLOSING
```

```lua
:set_cdata(cur, do_set_cdata)
	-- Can change a TEXT into a CDATA and vice versa.
	-- cur: TEXT, CDATA
```

```lua
:get_attribute(cur, key)
	-- Get attribute value of element (unescaped).
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:set_attribute(cur, key, value)
	-- Set key="value" on the given tag. Can be nil to remove the attribute.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:get_attributes(cur)
	-- Get a table of all attributes belonging to this element.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:get_attributes_order(cur)
	-- Get the order in which the attributes on this element are currently placed.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:get_newlines_before(cur)
	-- Get the number of newlines before this token when output.
	-- If preserve_all_whitespace is true, this is always loaded from file as 0
	-- because whitespace (including newlines) are put in TEXT tokens instead.
	-- cur: any
```

```lua
:set_newlines_before(cur, newlines_before)
	-- Set the number of newlines before this token when output.
	-- cur: any
```

```lua
:get_comment(cur)
	-- Get the text inside a comment.
	-- cur: COMMENT
```

```lua
:set_comment(cur, comment)
	-- Set the text inside a comment.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: COMMENT
```

```lua
:get_pi(cur)
	-- Get the target and value of this Processing Instruction.
	-- cur: PI
```

```lua
:set_pi(cur, target, value)
	-- Set the target and/or value of this Processing Instruction.
	-- If target is nil, it is unchanged.
	-- If value is nil, it is removed.
	-- cur: PI
```

</details>

<details>
<summary>Changing the structure</summary>

```lua
:open_selfclosing_tag(cur)
	-- Change a selfclosing tag to an opening+closing one.
	-- If passed an opening tag, it is left unchanged, for convenience.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:clear_open(cur)
	-- Delete all child nodes of this element.
	-- If clearing an opening tag, it is left open, and NOT turned into a selfclosing tag.
	-- Selfclosing tags are left selfclosed.
	-- If clearing the FILE_START, the entire file is cleared and only a selfclosing root tag is left.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, FILE_START
```

```lua
:clear(cur)
	-- Delete all child nodes of this element.
	-- If clearing an opening tag, it is turned into a selfclosing tag.
	-- If clearing the FILE_START, the entire file is cleared and only a selfclosing root tag is left.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, FILE_START
```

```lua
:delete(cur)
	-- Delete the current element or node, and all of its children.
	-- Does not work on the root element.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_element_in_first(cur, name, newlines_after)
	-- Add an element (will be selfclosing) INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_element_in_last(cur, name, newlines_before)
	-- Add an element (will be selfclosing) INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_element_before(cur, name, newlines_after)
	-- Add an element (will be selfclosing) as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_element_after(cur, name, newlines_before)
	-- Add an element (will be selfclosing) as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_comment_in_first(cur, comment, newlines_after)
	-- Add a comment INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_comment_in_last(cur, comment, newlines_before)
	-- Add a comment INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_comment_before(cur, comment, newlines_after)
	-- Add a comment as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_comment_after(cur, comment, newlines_before)
	-- Add a comment as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- Note that comments cannot contain '--' and cannot end in a '-'.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_pi_in_first(cur, target, value, newlines_after)
	-- Add a processing instruction INSIDE the current element, to be the FIRST.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_pi_in_last(cur, target, value, newlines_before)
	-- Add a processing instruction INSIDE the current element, to be the LAST.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_pi_before(cur, target, value, newlines_after)
	-- Add a processing instruction as a SIBLING, BEFORE the current node.
	-- newlines_after defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_pi_after(cur, target, value, newlines_before)
	-- Add a processing instruction as a SIBLING, AFTER the current node.
	-- newlines_before defaults to 1 if preserve_all_whitespace is false, else 0.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_text_in_first(cur, text, is_cdata)
	-- Add a text or cdata INSIDE the current element, to be the FIRST.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_text_in_last(cur, text, is_cdata)
	-- Add a text or cdata INSIDE the current element, to be the LAST.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_text_before(cur, text, is_cdata)
	-- Add a text or cdata as a SIBLING, BEFORE the current node.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:add_text_after(cur, text, is_cdata)
	-- Add a text or cdata as a SIBLING, AFTER the current node.
	-- In the case of text, there is no check or protection against adding multiple text nodes
	-- next to each other that will be melted together when the document is saved and re-read.
	-- cur: TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

</details>

<details>
<summary>Utility</summary>

```lua
:xmlspecialchars(text)
	-- Return the given string with real special entities like < > &
	-- encoded into XML entities like &lt; &gt; &amp;
```

```lua
:unxmlspecialchars(text)
	-- Return the given string with XML entities like &lt; &gt; &amp;
	-- decoded into < > &
```

</details>

<details>
<summary>Internal functions</summary>

```lua
:assert_wellformed_name(name)
	-- Assert that a name is a well-formed XML name.
	-- Raises an error if it's not.
```

```lua
:assert_wellformed_chardata(text)
	-- Assert that a string only consists of [2] Char.
	-- Raises an error if it does not.
```

```lua
:assert_paras_for(tok_type, ...)
	-- Internal function.
	-- Given the same parameters as the patch_for_* functions,
	-- validates that all the parameters have acceptable values.
```

```lua
:raise_notice(message)
	-- Raise notice-level error: minor stuff like "did not find such an element"
```

```lua
:raise_fail(cur, message)
	-- Raise XML error: parsing the document failed (malformed, etc)
	-- This means the document is bad, or it exceeded parser limits.
	-- If cur ~= nil, it indicates which token we were in the middle of creating.
	-- That token will be set to ERROR, and the error message will contain the line number.
```

```lua
:raise_fail_char(cur, char, expected)
	-- Raise XML error: parsing the document failed because of an unexpected character
```

```lua
:raise_error(message)
	-- Raise programming error: such as trying to get the element name of a comment.
```

```lua
:raise_error_type(cur, level)
	-- Raise a programming error, because the cursor is the wrong type for this function
```

```lua
:ci(cur)
	-- Internal function - Cursor Index, ensure the cursor is within bounds, and turn nil into a root cursor
```

```lua
:ci_opening_selfclosing(cur)
	-- Internal function - Cursor Index and assert type
```

```lua
:find_mode(mode, cur, ...)
	-- Internal function - compiles :find, :find_or_add, :find_or_nil into one
```

```lua
:ll_insert(cur)
	-- Internal function: Insert one item after the current one in the linked list.
	-- This only concerns the linking, not population of data - you get allocated a row and get the cur to that row.
	-- cur: any
```

```lua
:ll_unlink(cur, till)
	-- Internal function: Unlink the node at the cursor in the linked list, and link its previous and next together.
	-- If a cursor is specified for the till argument, deletion will keep going up to but not including that cursor.
	-- This function has no protection against unbalancing the XML structure, and does not update spouse or parent values.
```

```lua
:ch_is_whitespace(ch)
	-- Returns true if the given character is whitespace (#x20 | #x9 | #xD | #xA)
```

```lua
:ch_in(ch, a, z)
	-- Returns true if the given character is >= a and <= z
```

```lua
:ch_is_name_start(ch)
	-- Returns whether a codepoint matches [4] NameStartChar
```

```lua
:ch_is_name(ch)
	-- Returns whether a codepoint matches [4a] NameChar
```

```lua
:ch_is_char(ch)
	-- Returns whether a given codepoint matches [2] Char
```

```lua
:ch_decode(str, byte_cursor, ch_offset)
	-- Internal function.
	-- Like :cur_ch(ch_offset), but gives more info:
	-- - the codepoint at the given offset
	-- - the value of byte_cursor (in bytes) after ch_offset (in codepoints) is applied
	-- This function basically converts a character/codepoint offset into a byte offset.
```

```lua
:cur_ch(ch_offset)
	-- Internal function.
	-- Get the char pointed to by self.string_cursor (the tokenization cursor), plus an offset
```

```lua
:advance_ch(ch_offset)
	-- Internal function.
	-- Move self.string_cursor a given number of characters
	-- Assumes you are not skipping over newlines!
```

```lua
:advance_whitespace()
	-- Internal function.
	-- Advance the cursor past any whitespace.
	-- Returns true if the cursor was moved (whitespace was encountered).
```

```lua
:advance_reference(new_cur)
	-- Internal function.
	-- Advance the cursor to the end of (not past...) this Reference (&x;).
	-- Why not past? Well, because there's another self:advance_ch(1)
	-- at the end of the tokenization loop. So just stop at the ;.
	-- Only thing we need to do right now is check the syntax - not convert it.
	-- If it's not well-formed, raise a failure
```

```lua
:tokenize_one()
	-- Internal function: Advance the tokenizer by one token.
```

```lua
:patch(cur)
	-- Internal function: Ensure the current node is in patched format.
	-- This means it's no longer referenced from self.string,
	-- but it's a structured Lua table that can be modified.
	-- cur: any
```

```lua
:insert_new_patched(cur, tok_type, ...)
	-- Internal function: insert a new token of type tok_type after cur,
	-- and add a patch for it as well.
	-- ... is passed to the corresponding patch_for_* function.
	-- Returns a cursor to the new token.
	-- You still need to fill in the parent (and maybe spouse etc) correctly!!!
	-- cur: any
```

```lua
:each_unpatched_attribute_indices(cur)
	-- For internal usage only: get string indices to the start and end of the name
	-- and value of each attribute in this (unpatched!) opening or selfclosing tag.
	-- The indexes you get are (of course based on their position in self.string, so you won't get 1):
	-- name = "value!"
	-- ^  ^    ^    ^
	-- 1  4    9    14
	-- This is made easier since we validated the tag syntax during tokenization, so we may cut lots of corners now.
	-- Cursor type checks and whatnot (including non-patchedness) assumed to be done by caller.
```

```lua
:xmlnumericentities(text)
	-- Return the given string with real control characters (<0x20)
	-- encoded into numeric XML entities like &#31;.
	-- Is used by :xmlspecialchars(text), use that for completeness.
```

```lua
:unxmlnumericentities(text)
	-- Return the given string with numeric XML entities (like &#32;)
	-- decoded into real characters.
	-- Is used by :unxmlspecialchars(text), use that for completeness.
```

```lua
:uncr(text)
	-- Internal function: Return the given string with CR removed
	-- as specified in "2.11 End-of-Line Handling"
```

```lua
:attribute_value_normalization(str)
	-- Takes the raw text from an attribute value from the XML
	-- and applies "3.3.3 Attribute-Value Normalization" to it
```

```lua
:add_child_token(cur, as_last, newlines_between, tok_type, ...)
	-- Internal function: add a token as a child inside this element.
	-- Much like :insert_new_patched, but you don't need to worry about setting the parent.
	-- ... is validated, and passed to the corresponding patch_for_* function.
	-- newlines_between acts as "before" if last, and "after" if first.
	-- Returns a cursor to the new token.
	-- cur: TAG_OPENING, TAG_SELFCLOSING
```

```lua
:add_sibling_token(cur, as_after, newlines_between, tok_type, ...)
	-- Internal function: add a token as a sibling next to this element.
	-- Much like :insert_new_patched, but you don't need to worry about setting the parent.
	-- ... is validated, and passed to the corresponding patch_for_* function.
	-- newlines_between acts as "before" if after, and "after" if before. Clear?
	-- There are some restrictions what you can place where,
	-- for example, elements and text can't be placed outside the root element,
	-- and you can't place something before FILE_START or after FILE_END.
	-- Returns a cursor to the new token.
	-- cur: FILE_START, FILE_END, TAG_OPENING, TAG_SELFCLOSING, TEXT, CDATA, COMMENT, PI
```

```lua
:utf16_to_utf8(big_endian)
	-- I know this is probably a waste of time, but for me it's a pretty easy
	-- (and fun) box to tick for being as compliant as possible...
```

</details>

