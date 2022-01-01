require("corefunc")
require("coretext")

if love_version_meets(10) then
	love.window.setDisplaySleepEnabled(true)
end

allowdebug = false
opt_disableversioncheck = false
opt_loadlevel = nil
opt_newlevel = false
opt_forcelanguagescreen = false

vergroups = {9,1}

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

if love.setDeprecationOutput ~= nil then
	love.setDeprecationOutput(allowdebug or intermediate_version)
end

-- So that zooming in won't make tiles blurry, thanks TurtleP
if love.graphics.setDefaultFilter ~= nil then
	love.graphics.setDefaultFilter("linear", "nearest")
end

-- Avoiding chicken-and-egg problems here
function dodisplaysettings(reload)
	if reload then
		constraindisplaysettings(true)
	end

	local za,zb,zc = love.window.getMode()
	if s.psmallerscreen then
		za = 800
	else
		za = 896
	end
	zb = 480
	if reload or s.psmallerscreen or s.pscale ~= 1 then
		if love_version_meets(9,2) then
			local zd,ze,zf = love.window.getPosition()
			local zwidth,zheight = love.window.getDesktopDimensions(zf)
			love.window.setMode(za*s.pscale,zb*s.pscale,zc)
			love.window.setPosition((zwidth-za*s.pscale)/2,(zheight-zb*s.pscale)/2,zf)
		else
			love.window.setMode(za*s.pscale,zb*s.pscale,zc)
		end
	end

	if s.psmallerscreen then
		screenoffset = 32
	else
		screenoffset = 128
	end

	if reload then
		package.loaded.scaling = false
		love.graphics.push()
		love.graphics.scale(s.pscale,s.pscale)

		-- Do this or tiles will be white, and that's not really right!
		-- (I am a rhyming legend)
		-- (If you're going to sing the above, "tiles will be white" and
		-- "that's not really right" should be 4 sixteenth notes and 1 eighth note)
		loadtilesets()
		tile_batch_texture_needs_update = true

		-- Also do this or we'll have a blank map (no clever rhymes here)
		if metadata ~= nil then
			map_init()
		end
	else
		ved_require("scaling")
	end
end

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

love.graphics.clear()
local loadingimg = love.graphics.newImage("images/loading.png")
love.graphics.draw(loadingimg,
	(love.graphics.getWidth()-loadingimg:getWidth())/2,
	(love.graphics.getHeight()-loadingimg:getHeight())/2
)
love.graphics.present()

if love.window == nil then
	loadfonts()
	require("incompatmain8")
elseif not love_version_meets(9,1) then
	loadfonts()
	require("incompatmain9")
else
	-- How recent is our love2d version?
	if love_version_meets(10) then
		require("love10compat")

		if love_version_meets(11) then
			require("love11compat")
		end
	end
	require("errorhandler")

	require("plugins")
	loadplugins()

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

	ved_require("callback_load")
	ved_require("callback_draw")
	ved_require("callback_update")
	ved_require("callback_textinput")
	ved_require("callback_keypressed")
	ved_require("callback_keyreleased")
	ved_require("callback_mousepressed")
	ved_require("callback_mousereleased")
	ved_require("callback_directorydropped")
	ved_require("callback_filedropped")
	ved_require("callback_focus")
	ved_require("callback_quit")
	ved_require("callback_threaderror")
end
