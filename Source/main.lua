--[[ bitmap font
font_scale1 = love.graphics.newImageFont("font_scale1.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
font_scale2 = love.graphics.newImageFont("font_scale2.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
love.graphics.setFont(font_scale1)
print("BITMAP")
]]

require("corefunc")

allowdebug = false
opt_disableversioncheck = false
opt_loadlevel = nil
opt_newlevel = false

vergroups = {6,2}

ver = "1." .. vergroups[1] .. "." .. vergroups[2] -- Displayed in title and used in plugin minimum version check (egrep [^aotepk]ver[^socmdygwt] *.lua -i)
checkver = ver -- update check, displayed in crash (used to have a or b as opposed to ver)

intermediate_version = true -- If true, this is a WIP version

if intermediate_version then
	-- Extra pair of brackets to not turn the number of bytes into the base for tonumber
	commitversion = anythingbutnil0(tonumber((love.filesystem.read("commitversion"))))
end

thismdeversion = 3

unsupportedplugins = 0

fontpng_works = false

--checkver = "10241"
--versys = "1"

if love.setDeprecationOutput ~= nil then
	love.setDeprecationOutput(allowdebug or intermediate_version)
end

-- So that zooming in won't make tiles blurry, thanks TurtleP
if love.graphics.setDefaultFilter ~= nil then
	love.graphics.setDefaultFilter("linear", "nearest")
end

-- TTF
font8 = love.graphics.newFont("Space Station.ttf", 8)
font16 = love.graphics.newFont("Space Station.ttf", 16)

-- Since the other fonts are done here anyways
tinynumbers = love.graphics.newImageFont("tinynumbersfont.png", "", love_version_meets(10) and 1 or nil)
tinynumbers_all = love.graphics.newImageFont("tinynumbersfont.png", "0123456789.,~RTYUIOPZXCVHBLSF{}ADEGJKMNQWcsaqwertyuiopkl<>/[]zxnbf+-", love_version_meets(10) and 1 or nil)
tinynumbers_cmd = love.graphics.newImageFont("tinynumbersfont_cmd.png", "c", love_version_meets(10) and 1 or nil)
tinynumbers_strg = love.graphics.newImageFont("tinynumbersfont_strg.png", "c", love_version_meets(10) and 1 or nil)
tinynumbers_fallbacks = {}
-- Fallback is handled when config is loaded, because we need to know the language

love.graphics.setFont(font8)

-- We also want this font on a possible crash screen...
--love.graphics.setNewFont = function() end

begint = love.timer.getTime()
sincet = begint

print([[

@@  @@  @@@@@@  @@@@    The
@@  @@  @@      @@ @@       External
@@  @@  @@@@@@  @@  @@               VVVVVV
 @@@@   @@      @@ @@                       Level
  @@    @@@@@@  @@@@                              Editor
]])

print(_VERSION)

print("begint: " .. begint)

love.graphics.print("Loading...", 408, 236)

love.graphics.present()

if love.window == nil then
	require("incompatmain8")
elseif not love_version_meets(9,1) then
	require("incompatmain9")
else
	-- How recent is our love2d version?
	if love_version_meets(10) then
		require("love10compat")

		if love_version_meets(11) then
			require("love11compat")
		end
	end

	require("plugins")
	loadplugins()

	defaulterrhand = false

	-- Let's do some command line argument parsing!
	if #arg > 0 then
		local clargs = ved_require("clargs")

		local nextpartto = nil

		for k,v in pairs(arg) do
			if k < 0 then
				-- Won't be looking at this one
			elseif v:sub(-7,-1) == ".vvvvvv" then
				opt_loadlevel = v
			elseif v:sub(1,2) == "--" then
				local a = v:sub(3,-1)
				if clargs[a] ~= nil and clargs[a].func ~= nil then
					clargs[a].func()
				end
			elseif v:sub(1,1) == "-" then
				for c = 2, v:len() do
					local a = clargs[v:sub(c,c)]
					if a ~= nil and clargs[a] ~= nil and clargs[a].func ~= nil then
						clargs[a].func()
					end
				end
			end
		end
	end

	if not love.filesystem.exists("crash_logs") then
		love.filesystem.createDirectory("crash_logs")
	end
	if not love.keyboard.isDown("lctrl") and not defaulterrhand then
		require("errorhandler")
	end
	--love.errhand("Error handler triggered manually...")
	ved_require("main2")
end
