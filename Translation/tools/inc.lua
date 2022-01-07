languages = {
	templates = "en",
	nl = "nl",
	eo = "eo",
	ru = "ru",
	de = "de",
	fr = "fr",
	es_AR = "es_AR",
	id = "id",
}

langdir_path = "../../Source/lang" -- must not include a trailing /


function assert_lang_arg(argnum, allownone)
	-- If allownone is false/nil: Require that a valid language argument is given
	-- If allownone is true: Return true if a valid lang argument is given,
	--  require that it is valid if it is given, return false if nothing is given.
	if arg[argnum] == nil then
		if allownone then
			return false
		else
			print("Please give a language code as an argument")
			os.exit(0)
		end
	end
	if languages[arg[argnum]] == nil then
		print("\"" .. arg[argnum] .. "\" is not a valid language code. Choices are:")
		for k,v in pairs(languages) do
			print(k .. " (" .. v .. ")")
		end
		os.exit(0)
	end
	return true
end

orig_package_path = package.path
function load_lua_lang(lang)
	-- Load the language file that is given by the first argument
	package.path = orig_package_path .. ";" .. langdir_path .. "/" .. languages[lang] .. ".lua"
	require(languages[lang] .. ".lua")
end

function escape_lua_str(str)
	return str:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\n", "\\n")
end

function escape_lua_blockstr(str)
	str = str:gsub("]]", "]] .. \"]]\" .. [[")
	if str:sub(-1,-1) == "\n" then
		str = str:sub(1,-2)
	end
	return str
end

function escape_po_str(str)
	return str:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\n", "\\n")
end

function unescape_po_str(str)
	-- This function is only really to uncomplicate things, at the cost
	-- of a little bit of performance
	local bbn_token = "<BACKSLASH BACKSLASN N>"
	return str:gsub([[\\\n]], "\\\n"):gsub([[\\n]], bbn_token):gsub([[\n]], "\n"):gsub(bbn_token, "\\n"):gsub("\\\"", "\""):gsub("\\\\", "\\")
end

function split_help_page(str)
	--[[
		An article is (1), followed by (2) any amount >= 0 times:
		(1) A number >= 0 of blank lines
		(2) A number >= 1 of non-blank lines followed by a number >= of blank lines


		This is represented by two tables/lists, `paragraphs` and `blanklines`.

		If this comment from the first to the last lines of text were an article, it'd be:

		paragraphs		blanklines
		--------------------------
						0
		(3 lines)
						2
		(1 line)
						1
		(1 line)
						1
		(11 lines)
						0
	]]
	local paragraphs = {}
	local blanklines = {0}
	local now_blank = true

	for line in (str .. "\n"):gmatch("([^\n]*)\n") do
		if line == "" then
			if not now_blank then
				table.insert(blanklines, 0)
				now_blank = true
			end
			blanklines[#blanklines] = blanklines[#blanklines] + 1
		else
			if now_blank then
				table.insert(paragraphs, {})
				now_blank = false
			end
			table.insert(paragraphs[#paragraphs], line)
		end
	end

	if not now_blank then
		table.insert(blanklines, 0)
	end

	local paragraphs_str = {}
	for k,v in pairs(paragraphs) do
		table.insert(paragraphs_str, table.concat(v, "\n"))
	end

	return paragraphs_str, blanklines
end

function merge_help_page(paragraphs_str, blanklines)
	--[[
		Given the format of the return values of split_help_page, re-assembles an article.
	]]

	local lines = {} -- this is kind of a lie; the paragraphs are already multiple lines

	local max = #paragraphs_str + 1
	for k = 1, max do
		for blank = 1, blanklines[k] do
			table.insert(lines, "")
		end

		if k < max then
			table.insert(lines, paragraphs_str[k])
		end
	end

	return table.concat(lines, "\n")
end
