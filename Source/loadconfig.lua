-- This will load the config when loading Ved, or create it if it doesn't exist yet.

configs = {
	customvvvvvvdir = {
		default = "",
		["type"] = "string",
		comment = "do not include the directory called \"levels\" here, nor a trailing (back)slash"
	},
	lang = {
		default = "en",
		["type"] = "string",
	},
	langchosen = {
		default = false,
		["type"] = "bool",
	},
	dateformat = {
		default = "%Y-%m-%d %H:%M:%S",
		["type"] = "string",
		comment = "Obsolete, no longer used for technical reasons."
	},
	new_dateformat = {
		default = "YMD",
		["type"] = "string",
	},
	new_timeformat = {
		default = 24,
		["type"] = "number",
	},
	dialoganimations = {
		default = true,
		["type"] = "bool",
	},
	flipsubtoolscroll = {
		default = false,
		["type"] = "bool",
	},
	mousescrollingspeed = {
		default = 16,
		["type"] = "number",
	},
	adjacentroomlines = {
		default = true,
		["type"] = "bool",
	},
	askbeforequit = {
		default = true,
		["type"] = "bool",
		comment = "Obsolete, remains in order to not automatically make old versions of Ved annoying after running 1.3+"
	},
	neveraskbeforequit = {
		default = false,
		["type"] = "bool",
	},
	scale = {
		default = 1,
		["type"] = "number",
	},
	coords0 = {
		default = false,
		["type"] = "bool",
	},
	acceptutf8 = {
		default = false,
		["type"] = "bool",
		comment = "Obsolete, controlled whether non-ASCII characters were typable in custom levels. Now always true."
	},
	smallerscreen = {
		default = false,
		["type"] = "bool",
		comment = "Make the resolution smaller by collapsing the tools menu on the left and adjusting other things"
	},
	dontpreventscriptsplits = {
		default = false,
		["type"] = "bool",
		comment = "Enable to not let the editor add a space if a colon is the last character on a line in a script"
	},
	loadscriptname = {
		default = "$1_load",
		["type"] = "string",
	},
	showfps = {
		default = false,
		["type"] = "bool",
	},
	lowfpswarning = {
		default = -1,
		["type"] = "number",
	},
	fpslimit_ix = {
		default = 4,
		["type"] = "number",
	},
	pausedrawunfocused = {
		default = true,
		["type"] = "bool",
	},
	autosavecrashlogs = {
		default = true,
		["type"] = "bool",
	},
	checkforupdates = {
		default = true,
		["type"] = "bool",
	},
	loadallmetadata = {
		default = true,
		["type"] = "bool",
	},
	enableoverwritebackups = {
		default = true,
		["type"] = "bool",
	},
	amountoverwritebackups = {
		default = 10,
		["type"] = "number",
	},
	forcescale = {
		default = false,
		["type"] = "bool",
	},
	recentfiles = {
		default = {},
		["type"] = "stringsarray",
	},
	usefontpng = {
		default = false,
		["type"] = "bool",
		comment = "Use graphics folder font.png. No longer used as of Ved 1.11.1, now always considered false"
	},
	uselevelfontpng = {
		default = true,
		["type"] = "bool",
		comment = "Use level-specific font. No longer used as of Ved 1.11.1, now always considered true"
	},
	colored_textboxes = {
		default = true,
		["type"] = "bool",
	},
	scripteditor_largefont = {
		default = false,
		["type"] = "bool",
	},
	visload_seen = {
		default = false,
		["type"] = "bool",
	},
	vis_firstseen = {
		default = false,
		["type"] = "bool",
	},
	syntaxcolor_command = {
		default = {124, 112, 218},
		["type"] = "numbersarray",
	},
	syntaxcolor_generic = {
		default = {156, 158, 159},
		["type"] = "numbersarray",
	},
	syntaxcolor_separator = {
		default = {124, 43, 124},
		["type"] = "numbersarray",
	},
	syntaxcolor_number = {
		default = {250, 250, 88},
		["type"] = "numbersarray",
	},
	syntaxcolor_textbox = {
		default = {156, 158, 159},
		["type"] = "numbersarray",
	},
	syntaxcolor_errortext = {
		default = {255, 0, 0},
		["type"] = "numbersarray",
	},
	syntaxcolor_wronglang = {
		default = {160, 0, 0},
		["type"] = "numbersarray",
	},
	syntaxcolor_cursor = {
		default = {255, 255, 255},
		["type"] = "numbersarray",
		comment = "Obsolete since new input system"
	},
	syntaxcolor_flagname = {
		default = {255, 128, 0},
		["type"] = "numbersarray",
	},
	syntaxcolor_newflagname = {
		default = {255, 192, 64},
		["type"] = "numbersarray",
	},
	syntaxcolor_comment = {
		default = {0, 128, 0},
		["type"] = "numbersarray",
	},
	allowbiggerthansizelimit = {
		default = false,
		["type"] = "bool",
		comment = "Enable to let the editor properly load bigger than 20x20 maps (for VVVVVV) and let smaller (20x20 or less) maps be resized to be bigger than 20x20. Does not allow you (easily) make new usable rooms you can place tiles in, or have more room properties. Also VVVVVV will segfault for any reason in the rooms outside 20x20. Read more in the confirmation dialog that pops up when attempting to make a bigger map.",
	},
	opaqueroomnamebackground = {
		default = false,
		["type"] = "bool",
	},
	vvvvvv23 = {
		default = "",
		["type"] = "string",
		comment = "Do not put a trailing (back)slash. On Windows, point this to the file 'VVVVVV.exe'. On Linux and macOS, point this to the file 'VVVVVV'.",
	},
	vvvvvvce = {
		default = "",
		["type"] = "string",
		comment = "VVVVVV-CE equivalent of vvvvvv23 option, now obsolete.",
	},
	default_save_folder_zip = {
		default = "",
		["type"] = "string",
		comment = "The default folder to offer saving level ZIPs to. If blank, uses the levels folder.",
	},
	mapstyle = {
		default = "full",
		["type"] = "string"
	},
	bumpscriptsbydefault = {
		default = true,
		["type"] = "bool"
	},
	new_level_font = {
		default = "font",
		["type"] = "string",
		comment = "The default font to use for new levels"
	},
	new_level_rtl = {
		default = false,
		["type"] = "bool",
		comment = "The default RTL setting to use for new levels"
	},
	active_themes = {
		default = {},
		["type"] = "stringsarray",
		comment = "The themes that are currently active"
	},
}

function saveconfig()
	local writagearr = {}
	for k,v in pairs(configs) do
		local value
		if v.type == "string" then
			value = encodestring(s[k])
		elseif v.type == "bool" then
			value = boolstring(s[k])
		elseif v.type == "numbersarray" then
			value = "{" .. table.concat(s[k], ", ") .. "}"
		elseif v.type == "stringsarray" then
			value = "{"
			local first = true
			for k2,v2 in pairs(s[k]) do
				if not first then
					value = value .. ", "
				else
					first = false
				end
				value = value .. encodestring(v2)
			end
			value = value .. "}"
		else
			value = s[k]
		end
		table.insert(writagearr, "s." .. k .. " = " .. value .. (v.comment ~= nil and " -- " .. v.comment or ""))
	end
	love.filesystem.write("settings.lua", table.concat(writagearr, "\r\n"))
end

function boolstring(thebool)
	if thebool == nil then
		return "nil"
	elseif thebool then
		return "true"
	else
		return "false"
	end
end

function encodestring(thestring)
	if thestring == nil then
		return "nil"
	else
		return "\"" .. ((thestring):gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\r", "\\r"):gsub("\n", "\\n")) .. "\""
	end
end

function loaddefaultsettings()
	s = {}
	for k,v in pairs(configs) do
		if type(v.default) == "table" then
			s[k] = table.copy(v.default)
		else
			s[k] = v.default
		end
	end
end

loaddefaultsettings()

if love.filesystem.exists("settings.lua") then
	-- It exists
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
	-- It doesn't exist, create it.
	print("Making new config file")
	saveconfig()
	settings_ok = true
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
