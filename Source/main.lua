--[[ bitmap font
font_scale1 = love.graphics.newImageFont("font_scale1.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
font_scale2 = love.graphics.newImageFont("font_scale2.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
love.graphics.setFont(font_scale1)
print("BITMAP")
]]

allowdebug = false
opt_disableversioncheck = false
opt_loadlevel = nil
opt_newlevel = false

fpscap = 0

ver = "1.2.5" -- Displayed in title and used in plugin minimum version check ([^otek]ver[^sct])
checkver = ver -- update check, displayed in crash (used to have a or b as opposed to ver)

vergroups = {2,5} -- This'll be pattern-matched later

intermediate_version = true -- If true, this is a WIP version (this just affects display)

thismdeversion = 2

unsupportedplugins = 0

--checkver = "10241"
--versys = "1"

-- So that zooming in won't make tiles blurry, thanks TurtleP
if love.graphics.setDefaultFilter ~= nil then
	love.graphics.setDefaultFilter("nearest", "nearest")
end

-- TTF
font8 = love.graphics.newFont("Space Station.ttf", 8)
font16 = love.graphics.newFont("Space Station.ttf", 16)

-- Since the other fonts are done here anyways
tinynumbers = love.graphics.newImageFont("tinynumbersfont.png", "0123456789.,~RTYUIOPZXCVHBLSF{}ADEGJKMNQWcsamqwertyuiopkl<>/[]zxnb")

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
	require("incompatmain")
else
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

	if not love.keyboard.isDown("lctrl") and not defaulterrhand then
		require("errorhandler")
	end
	--love.errhand("Error handler triggered manually...")
	ved_require("main2")
end
