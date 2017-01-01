--[[ bitmap font
font_scale1 = love.graphics.newImageFont("font_scale1.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
font_scale2 = love.graphics.newImageFont("font_scale2.png", " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~§") -- {|}~ öäÁå
love.graphics.setFont(font_scale1)
print("BITMAP")
]]

allowdebug = false

fpscap = 0

ver = "1.0.0" -- Displayed in title and used in plugin minimum version check ([^otek]ver[^sct])
checkver = ver -- update check, displayed in crash (used to have a or b as opposed to ver)

vergroups = {0,0} -- This'll be pattern-matched later

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
tinynumbers = love.graphics.newImageFont("tinynumbersfont.png", "0123456789.,RTYUIOPZXCVHBL")

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

	if not love.keyboard.isDown("lctrl") then
		require("errorhandler")
	end
	--love.errhand("Error handler triggered manually...")
	ved_require("main2")
end