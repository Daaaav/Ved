languages = {
	templates = "English",
	nl = "Nederlands",
	eo = "Esperanto",
	ru = "Русский",
	de = "Deutsch",
	fr = "Français",
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

function load_lua_lang(lang)
	-- Load the language file that is given by the first argument
	package.path = package.path .. ";" .. langdir_path .. "/" .. languages[lang] .. ".lua"
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