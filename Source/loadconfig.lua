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
	checkforupdates =
		{
		default = true,
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
	}

function saveconfig()
	--love.filesystem.write("settings.lua", 's.customvvvvvvdir = "' .. s.customvvvvvvdir .. '" -- do not include the directory called "levels" here, nor a trailing (back)slash\r\ns.language = "' .. s.language .. '"\r\ns.dialoganimations = ' .. boolstring(s.dialoganimations) .. '\ns.allowlimitbypass = ' .. boolstring(s.allowlimitbypass) .. '\ns.flipsubtoolscroll = ' .. boolstring(s.flipsubtoolscroll) .. '')
	writagearr = {}
	for k,v in pairs(configs) do
		table.insert(writagearr, "s." .. k .. " = " .. (v.type == "string" and "\"" .. ((s[k]):gsub("\\", "\\\\"):gsub("\"", "\\\"")) .. "\"" or (v.type == "bool" and boolstring(s[k]) or (v.type == "numbersarray" and "{" .. table.concat(s[k], ", ") .. "}" or s[k]))) .. (v.comment ~= nil and " -- " .. v.comment or ""))
	end
	love.filesystem.write("settings.lua", table.concat(writagearr, "\r\n"))
end

function boolstring(thebool)
	if thebool == nil then
		return "nil"
	elseif thebool == true then
		return "true"
	else
		return "false"
	end
end

function loaddefaultsettings()
	s = {}
	for k,v in pairs(configs) do
		s[k] = v.default
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

function windowfits(w, h, monitorres)
	return w <= monitorres[1] and h <= monitorres[2]
end

do
	local swidth = 896
	
	-- Maybe it's set for a smaller screen
	if s.smallerscreen then
		swidth = 800
	end

	-- We need to make sure that the Ved window will fit on the screen
	--if s.scale > 1 then
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
	--end
	
	if s.smallerscreen then
		_, _, graphicsflags = love.window.getMode()
		love.window.setMode(800, 480, graphicsflags)
	end
	
	s.pscale = s.scale
	s.pcheckforupdates = s.checkforupdates
end