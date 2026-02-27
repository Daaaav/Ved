-- This will load the config when loading Ved, or create it if it doesn't exist yet.

local vedxml = require("vedxml")

local sxml

configs = {
	{
		key = "customvvvvvvdir",
		default = "",
		["type"] = "string",
		comment = "Do not include the directory called \"levels\" here,\nnor a trailing (back)slash"
	},
	{
		key = "vvvvvv23",
		default = "",
		["type"] = "string",
		comment = "Do not put a trailing (back)slash.\nOn Windows, point this to the executable 'VVVVVV.exe'.\nOn Linux and macOS, point this to the executable 'VVVVVV'.",
	},
	{
		key = "default_save_folder_zip",
		default = "",
		["type"] = "string",
		comment = "The default folder to offer saving level ZIPs to.\nIf blank, uses the levels folder.",
	},
	{
		key = "lang",
		default = "en",
		["type"] = "string",
	},
	{
		key = "langchosen",
		default = false,
		["type"] = "bool",
	},
	{
		key = "new_dateformat",
		default = "YMD",
		["type"] = "string",
	},
	{
		key = "new_timeformat",
		default = 24,
		["type"] = "number",
	},
	{
		key = "dialoganimations",
		default = true,
		["type"] = "bool",
	},
	{
		key = "flipsubtoolscroll",
		default = false,
		["type"] = "bool",
	},
	{
		key = "mousescrollingspeed",
		default = 16,
		["type"] = "number",
	},
	{
		key = "neveraskbeforequit",
		default = false,
		["type"] = "bool",
	},
	{
		key = "scale",
		default = 1,
		["type"] = "number",
	},
	{
		key = "smallerscreen",
		default = false,
		["type"] = "bool",
		comment = "Make the resolution smaller by collapsing the\ntools menu on the left and adjusting other things"
	},
	{
		key = "forcescale",
		default = false,
		["type"] = "bool",
	},
	{
		key = "showfps",
		default = false,
		["type"] = "bool",
	},
	{
		key = "lowfpswarning",
		default = -1,
		["type"] = "number",
	},
	{
		key = "fpslimit_ix",
		default = 4,
		["type"] = "number",
	},
	{
		key = "pausedrawunfocused",
		default = true,
		["type"] = "bool",
	},
	{
		key = "autosavecrashlogs",
		default = true,
		["type"] = "bool",
	},
	{
		key = "checkforupdates",
		default = true,
		["type"] = "bool",
	},
	{
		key = "loadallmetadata",
		default = true,
		["type"] = "bool",
	},
	{
		key = "enableoverwritebackups",
		default = true,
		["type"] = "bool",
	},
	{
		key = "amountoverwritebackups",
		default = 10,
		["type"] = "number",
	},
	{
		key = "recentfiles",
		default = {},
		["type"] = "stringsarray",
	},
	{
		key = "dontpreventscriptsplits",
		default = false,
		["type"] = "bool",
		comment = "Enable to not let the editor add a space if\na colon is the last character on a line in a script"
	},
	{
		key = "loadscriptname",
		default = "$1_load",
		["type"] = "string",
	},
	{
		key = "colored_textboxes",
		default = true,
		["type"] = "bool",
	},
	{
		key = "scripteditor_largefont",
		default = false,
		["type"] = "bool",
	},
	{
		key = "bumpscriptsbydefault",
		default = true,
		["type"] = "bool"
	},
	{
		key = "syntaxcolor_command",
		default = {124, 112, 218},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_generic",
		default = {156, 158, 159},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_separator",
		default = {124, 43, 124},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_number",
		default = {250, 250, 88},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_textbox",
		default = {156, 158, 159},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_errortext",
		default = {255, 0, 0},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_wronglang",
		default = {160, 0, 0},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_flagname",
		default = {255, 128, 0},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_newflagname",
		default = {255, 192, 64},
		["type"] = "rgb",
	},
	{
		key = "syntaxcolor_comment",
		default = {0, 128, 0},
		["type"] = "rgb",
	},
	{
		key = "adjacentroomlines",
		default = true,
		["type"] = "bool",
	},
	{
		key = "coords0",
		default = false,
		["type"] = "bool",
	},
	{
		key = "opaqueroomnamebackground",
		default = false,
		["type"] = "bool",
	},
	{
		key = "mapstyle",
		default = "full",
		["type"] = "string"
	},
	{
		key = "new_level_font",
		default = "font",
		["type"] = "string",
		comment = "The default font to use for new levels"
	},
	{
		key = "new_level_rtl",
		default = false,
		["type"] = "bool",
		comment = "The default RTL setting to use for new levels"
	},
	{
		key = "volume",
		default = 1,
		["type"] = "number"
	},
	{
		key = "active_themes",
		default = {},
		["type"] = "stringsarray",
		comment = "The themes that are currently active"
	},
}

function saveconfig()
	sxml:set_attribute(nil, "version", ved_ver_human())
	local xmain = sxml:find_or_add(nil, "main")
	local xlastsetting = nil -- cursor to last setting
	for k,v in pairs(configs) do
		local xsetting = sxml:find_or_nil(xmain, v.key)
		if xsetting == nil then
			-- Add a new one, but where?
			if xlastsetting == nil then
				-- It's the first one!
				xsetting = sxml:add_element_in_first(xmain, v.key)
			else
				-- Add it right after the previous one to keep the determined order
				xsetting = sxml:add_element_after(xlastsetting, v.key, 2)
			end
		else
			sxml:clear_open(xsetting)
		end

		if v.comment ~= nil then
			local comment = v.comment:gsub("\n", "\n\t\t\t")
			sxml:add_comment_in_first(xsetting, " " .. comment .. " ")
		end

		if v.type == "rgb" then
			sxml:set_text(sxml:add_element_in_last(xsetting, "r", 1), s[v.key][1])
			sxml:set_text(sxml:add_element_in_last(xsetting, "g", 0), s[v.key][2])
			sxml:set_text(sxml:add_element_in_last(xsetting, "b", 0), s[v.key][3])
		elseif v.type == "numbersarray" or v.type == "stringsarray" then
			for k2,v2 in pairs(s[v.key]) do
				sxml:set_text(sxml:add_element_in_last(xsetting, "item"), v2)
			end
		else
			local value = s[v.key]
			if v.type == "bool" then
				value = (value and "true" or "false")
			end
			sxml:set_text(sxml:add_element_in_last(xsetting, "value"), value)
		end

		xlastsetting = xsetting
	end
	love.filesystem.write("ved_settings.xml", sxml:export())
end

function loaddefaultsettings()
	s = {}
	for k,v in pairs(configs) do
		if type(v.default) == "table" then
			s[v.key] = table.copy(v.default)
		else
			s[v.key] = v.default
		end
	end
end

loaddefaultsettings()

if love.filesystem.exists("ved_settings.xml") then
	-- Load the new settings file
	settings_ok, settings_err = pcall(function()
		sxml = vedxml.VedXML:new{string=(love.filesystem.read("ved_settings.xml")), root="ved_settings", indent="\t"}

		local xmain = sxml:find(nil, "main")
		for k,v in pairs(configs) do
			local xsetting = sxml:find_or_nil(xmain, v.key)
			if xsetting ~= nil then
				if v.type == "rgb" then
					s[v.key] = {
						anythingbutnil0(sxml:get_text(sxml:find(xsetting, "r"))),
						anythingbutnil0(sxml:get_text(sxml:find(xsetting, "g"))),
						anythingbutnil0(sxml:get_text(sxml:find(xsetting, "b"))),
					}
				elseif v.type == "numbersarray" or v.type == "stringsarray" then
					s[v.key] = {}
					for xitem in sxml:each_child_element(xsetting, "item") do
						local value = sxml:get_text(xitem)
						if v.type == "numbersarray" then
							value = anythingbutnil0(value)
						end
						table.insert(s[v.key], value)
					end
				else
					local value = sxml:get_text(sxml:find(xsetting, "value"))
					if v.type == "bool" then
						value = (value == "true" or value == "1")
					elseif v.type == "number" then
						value = anythingbutnil0(value)
					end
					s[v.key] = value
				end
			end
		end

		sxml:tokenize_to_end()
	end)

	if not settings_ok then
		love.filesystem.write("crash_logs/" .. os.time() .. "_" .. ved_ver_human() .. "_SETTINGS.txt",
			"Error in ved_settings.xml: " .. anythingbutnil(settings_err) .. "\r\n\r\nFull file contents:\r\n"
			.. love.filesystem.read("ved_settings.xml") .. "\r\n\r\nEOF"
		)
		sxml = nil
	end
else
	if love.filesystem.exists("settings.lua") then
		-- An old settings.lua exists, load it so we can save XML next time
		local settings_chunk
		settings_ok, settings_chunk = pcall(love.filesystem.load, "settings.lua")
		if settings_ok then
			settings_ok, settings_err = pcall(settings_chunk)
		else
			settings_err = settings_chunk
		end
		if not settings_ok then
			love.filesystem.write("crash_logs/" .. os.time() .. "_" .. ved_ver_human() .. "_SETTINGS.txt",
				"Error in settings.lua: " .. anythingbutnil(settings_err) .. "\r\n\r\nFull file contents:\r\n"
				.. love.filesystem.read("settings.lua") .. "\r\n\r\nEOF"
			)
		end
	else
		-- That doesn't exist either, we'll create a new one below.
		print("Making new config file")
		settings_ok = true
	end
end

if sxml == nil then
	-- Make an XML document from scratch
	sxml = vedxml.VedXML:new{root="ved_settings", indent="\t"}
	sxml:add_comment_before(nil, " Settings file used by Ved 2.0 and above ")
	if settings_ok then
		saveconfig()
	end
end



--- Handling of scaling options

function constraindisplaysettings(reload)
	s.scale = tonumber(s.scale)
	if s.scale == nil or s.scale <= 0 then
		s.scale = 1
	end

	local function windowfits(w, h, monitorres)
		return w <= monitorres[1] and h <= monitorres[2]
	end

	local swidth = 896

	-- Maybe it's set for a smaller screen
	if s.smallerscreen then
		swidth = 800
	end

	if not s.forcescale then
		-- We need to make sure that the Ved window will fit on the screen
		local fits = false
		local fits896 = false

		for mon = 1, love.window.getDisplayCount() do
			local monw, monh = love.window.getDesktopDimensions(mon)

			if windowfits(swidth*s.scale, 480*s.scale, {monw, monh}) then
				fits = true
			end
			if monw >= 896 then
				fits896 = true
			end
		end

		if s.scale > 1 and not fits then
			print("Scale setting kicked back from " .. s.scale .. "!")
			s.scale = 1
		end

		if not fits896 then
			print("No monitor with width >= 896 found, setting smaller screen!")
			s.smallerscreen = true
		end
	end

	s.pscale = s.scale
	s.psmallerscreen = s.smallerscreen
end
constraindisplaysettings()

s.pcheckforupdates = s.checkforupdates and not opt_disableversioncheck
