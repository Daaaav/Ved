-- This will load the config when loading Ved, or create it if it doesn't exist yet.

configs =
	{
	customvvvvvvdir =
		{
		default = "",
		["type"] = "string",
		comment = "do not include the directory called \"levels\" here, nor a trailing (back)slash"
		},
	lang =
		{
		default = "English",
		["type"] = "string",
		},
	dateformat =
		{
		default = "%Y-%m-%d %H:%M:%S",
		["type"] = "string",
		},
	dialoganimations =
		{
		default = true,
		["type"] = "bool",
		},
	allowlimitbypass =
		{
		default = false,
		["type"] = "bool",
		},
	flipsubtoolscroll =
		{
		default = false,
		["type"] = "bool",
		},
	adjacentroomlines =
		{
		default = true,
		["type"] = "bool",
		},
	askbeforequit =
		{
		default = true,
		["type"] = "bool",
		comment = "Obsolete, remains in order to not automatically make old versions of Ved annoying after running 1.3+"
		},
	neveraskbeforequit =
		{
		default = false,
		["type"] = "bool",
		},
	scale =
		{
		default = 1,
		["type"] = "number",
		},
	coords0 =
		{
		default = false,
		["type"] = "bool",
		},
	acceptutf8 =
		{
		default = false,
		["type"] = "bool",
		--comment = "in case you want to be able to type any non-ASCII characters outside of the level notes. Please note this is pretty much useless as it will not show up correctly in VVVVVV, and will crash older versions of VVVVVV."
		comment = "Pretty much useless. (In case you want to be able to type any non-ASCII characters outside of the level notes. These will not show up correctly in VVVVVV, and will crash older versions of VVVVVV.)"
		},
	smallerscreen =
		{
		default = false,
		["type"] = "bool",
		comment = "Make the resolution smaller by collapsing the tools menu on the left and adjusting other things"
		},
	dontpreventscriptsplits =
		{
		default = false,
		["type"] = "bool",
		comment = "Enable to not let the editor add a space if a colon is the last character on a line in a script"
		},
	loadscriptname =
		{
		default = "$1_load",
		["type"] = "string",
		},
	showfps =
		{
		default = false,
		["type"] = "bool",
		},
	lowfpswarning =
		{
		default = -1,
		["type"] = "number",
		},
	fpslimit_ix =
		{
		default = 4,
		["type"] = "number",
		},
	pausedrawunfocused =
		{
		default = true,
		["type"] = "bool",
		},
	autosavecrashlogs =
		{
		default = true,
		["type"] = "bool",
		},
	checkforupdates =
		{
		default = true,
		["type"] = "bool",
		},
	loadallmetadata =
		{
		default = true,
		["type"] = "bool",
		},
	enableoverwritebackups =
		{
		default = true,
		["type"] = "bool",
		},
	amountoverwritebackups =
		{
		default = 5,
		["type"] = "number",
		},
	forcescale =
		{
		default = false,
		["type"] = "bool",
		},
	recentfiles =
		{
		default = {},
		["type"] = "stringsarray",
		},
	usefontpng =
		{
		default = false,
		["type"] = "bool",
		},
	visload_seen =
		{
		default = false,
		["type"] = "bool",
		},
	vis_firstseen =
		{
		default = false,
		["type"] = "bool",
		},
	syntaxcolor_command =
		{
		default = {124, 112, 218},
		["type"] = "numbersarray",
		},
	syntaxcolor_generic =
		{
		default = {156, 158, 159},
		["type"] = "numbersarray",
		},
	syntaxcolor_separator =
		{
		default = {124, 43, 124},
		["type"] = "numbersarray",
		},
	syntaxcolor_number =
		{
		default = {250, 250, 88},
		["type"] = "numbersarray",
		},
	syntaxcolor_textbox =
		{
		default = {156, 158, 159},
		["type"] = "numbersarray",
		},
	syntaxcolor_errortext =
		{
		default = {255, 0, 0},
		["type"] = "numbersarray",
		},
	syntaxcolor_cursor =
		{
		default = {255, 255, 255},
		["type"] = "numbersarray",
		},
	syntaxcolor_flagname =
		{
		default = {255, 128, 0},
		["type"] = "numbersarray",
		},
	syntaxcolor_newflagname =
		{
		default = {255, 192, 64},
		["type"] = "numbersarray",
		},
	syntaxcolor_comment =
		{
		default = {0, 128, 0},
		["type"] = "numbersarray",
		}
	}

function saveconfig()
	--love.filesystem.write("settings.lua", 's.customvvvvvvdir = "' .. s.customvvvvvvdir .. '" -- do not include the directory called "levels" here, nor a trailing (back)slash\r\ns.language = "' .. s.language .. '"\r\ns.dialoganimations = ' .. boolstring(s.dialoganimations) .. '\ns.allowlimitbypass = ' .. boolstring(s.allowlimitbypass) .. '\ns.flipsubtoolscroll = ' .. boolstring(s.flipsubtoolscroll) .. '')
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
		return "\"" .. ((thestring):gsub("\\", "\\\\"):gsub("\"", "\\\"")) .. "\""
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
	love.filesystem.load("settings.lua")()
else
	-- It doesn't exist, create it.
	print("Making new config file")
	saveconfig()
end



--- Handling of scaling options

do
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

	if s.smallerscreen then
		_, _, graphicsflags = love.window.getMode()
		love.window.setMode(800, 480, graphicsflags)
	end

	s.pscale = s.scale
	s.psmallerscreen = s.smallerscreen
	s.pcheckforupdates = s.checkforupdates
	s.plang = s.lang
end
