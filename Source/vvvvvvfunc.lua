-- Contains code partially decompiled from VVVVVV
-- But in Lua, of course

local o_UtilityClass = {
	glow = 0, -- 0 to 62, inclusive
	glowdir = 0, -- 0 or 1
	slowsine = 0, -- 0 to 63, inclusive
}

function o_UtilityClass:UtilityClass(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end


-- UtilityClass.cpp:UtilityClass()
function UtilityClass()
	return o_UtilityClass:UtilityClass()
end


local o_Graphics = {
	linestate = 0, -- 0 to 9, inclusive
	linedelay = 0, -- 0, 1, or 2. The game doesn't even initialize this
}

function o_Graphics:Graphics(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Graphics()
	return o_Graphics:Graphics()
end


-- Maths.h:fRandom()
local function fRandom()
	-- Just a random float between 0 and 1, which happens to be Lua's math.random() with no arguments
	return math.random()
end

-- Graphics.cpp:Graphics::RGBf()
local function RGBf(r, g, b)
	-- Basically this function darkens and slightly desaturates whatever color you give it
	return (r+128) / 3, (g+128) / 3, (b+128) / 3
end


-- UtilityClass.cpp:UtilityClass::updateglow()
-- Call this every 34/1000ths of a second
function o_UtilityClass:updateglow()
	local nextsine = self.slowsine + 1

	local newsine
	if nextsine < 64 then
		newsine = nextsine
	else
		newsine = 0
	end

	self.slowsine = newsine

	if self.glowdir == 0 then
		self.glow = self.glow + 2
		if self.glow > 61 then
			self.glowdir = 1
		end
	else
		self.glow = self.glow - 2
		if self.glow < 2 then
			self.glowdir = 0
		end
	end
end

-- This is from the start of Graphics.cpp:Graphics::drawentities()
-- Call this every 34/1000ths of a second, too
function o_Graphics:updatelinestate()
	if self.linedelay < 1 then
		self.linedelay = 2

		local nextlinestate
		if self.linestate < 9 then
			nextlinestate = self.linestate + 1
		else
			nextlinestate = 0
		end

		self.linestate = nextlinestate
	else
		self.linedelay = self.linedelay - 1
	end
end


-- Graphics.cpp:Graphics::setcol()
-- This function is copied straight from Terry's post of it on Distractionware,
-- complete with the comments
-- http://distractionware.com/forum/index.php?topic=1992.msg21312#msg21312
local function getcol(t, help)
	local temp

	-- Setup predefinied [sic] colours as per our zany palette
	if t == 0 then
		-- Player Normal
		return 160- help.glow/2 - (fRandom()*20), 200- help.glow/2, 220 - help.glow
	elseif t == 1 then
		-- Player Hurt
		return 196 - (fRandom() * 64), 10, 10
	elseif t == 2 then
		-- Enemies and stuff
		return 225-(help.glow/2), 75, 30
	elseif t == 3 then
		-- Trinket
		-- Editor's note: the source has something about `trinketcolset`, which I'm just going to ignore
		return 200 - (fRandom() * 64), 200 - (fRandom() * 128), 164 + (fRandom() * 60)
	elseif t == 4 then
		-- Inactive savepoint
		temp = (help.glow/2) + (fRandom() * 8)
		return 80 + temp, 80 + temp, 80 + temp
	elseif t == 5 then
		-- Active savepoint
		return 164+(fRandom()*64),164+(fRandom()*64), 255-(fRandom()*64)
	elseif t == 6 then
		-- Enemy : Red
		return 250 - help.glow/2, 60- help.glow/2, 60 - help.glow/2
	elseif t == 7 then
		-- Enemy : Green
		return 100 - help.glow/2 - (fRandom()*30), 250 - help.glow/2, 100 - help.glow/2 - (fRandom()*30)
	elseif t == 8 then
		-- Enemy : Purple
		return 250 - help.glow/2, 20, 128 - help.glow/2 + (fRandom()*30)
	elseif t == 9 then
		-- Enemy : Yellow
		return 250 - help.glow/2, 250 - help.glow/2, 20
	elseif t == 10 then
		-- Warp point (white)
		return 255 - (fRandom() * 64), 255 - (fRandom() * 64), 255 - (fRandom() * 64)
	elseif t == 11 then
		-- Enemy : Cyan
		return 20, 250 - help.glow/2, 250 - help.glow/2
	elseif t == 12 then
		-- Enemy : Blue
		return 90- help.glow/2, 90 - help.glow/2, 250 - help.glow/2

		-- Crew Members
	elseif t == 13 then
		-- green
		return 120- help.glow/4 - (fRandom()*20), 220 - help.glow/4, 120- help.glow/4
	elseif t == 14 then
		-- Yellow
		return 220- help.glow/4 - (fRandom()*20), 210 - help.glow/4, 120- help.glow/4
	elseif t == 15 then
		-- pink
		-- Editor's note: this is actually red
		return 255 - help.glow/8, 70 - help.glow/4, 70 - help.glow / 4
	elseif t == 16 then
		-- Blue
		return 75, 75, 255- help.glow/4 - (fRandom()*20)


	elseif t == 17 then
		-- Enemy : Orange
		return 250 - help.glow/2, 130 - help.glow/2, 20
	elseif t == 18 then
		-- Enemy : Gray
		return 130- help.glow/2, 130 - help.glow/2, 130 - help.glow/2
	elseif t == 19 then
		-- Enemy : Dark gray
		return 60- help.glow/8, 60 - help.glow/8, 60 - help.glow/8
	elseif t == 20 then
		-- Purple
		-- Editor's note: this is actually pink
		return 220 - help.glow / 4 - (fRandom() * 20), 120 - help.glow / 4, 210 - help.glow / 4

	elseif t == 21 then
		-- Enemy : Light Gray
		return 180- help.glow/2, 180 - help.glow/2, 180 - help.glow/2
	elseif t == 22 then
		-- Enemy : Indicator Gray
		return 230- help.glow/2, 230- help.glow/2, 230- help.glow/2
	elseif t == 23 then
		-- Enemy : Indicator Gray
		-- Editor's note: yes, this comment is a repeat of the one above
		return 255- help.glow/2 - (fRandom() * 40) , 255- help.glow/2 - (fRandom() * 40), 255- help.glow/2 - (fRandom() * 40)
		-- Editor's note: be warned that 24 through 29 simply don't exist

		-- Trophies
	elseif t == 30 then
		-- cyan
		return RGBf(160, 200, 220)
	elseif t == 31 then
		-- Purple
		return RGBf(220, 120, 210)
	elseif t == 32 then
		-- Yellow
		return RGBf(220, 210, 120)
	elseif t == 33 then
		-- red
		return RGBf(255, 70, 70)
	elseif t == 34 then
		-- green
		return RGBf(120, 220, 120)
	elseif t == 35 then
		-- Blue
		return RGBf(75, 75, 255)
	elseif t == 36 then
		-- Gold
		return 20, 120, 180
		-- Editor's note: Terry's post has the red and blue swapped around from what I found in the decompiled code
	elseif t == 37 then
		-- Trinket
		-- Editor's note: the difference between this and color 3 is that this one has RGBf() called on it
		return RGBf(getcol(3, help))
	elseif t == 38 then
		-- Silver
		return RGBf(196, 196, 196)
	elseif t == 39 then
		-- Bronze
		return RGBf(128, 64, 10)
		-- Awesome
		-- Editor's note: I don't know why the above comment exists
	elseif t == 40 then
		-- Teleporter in action!
		-- Editor's note: the difference between this and color 102 is that this one has RGBf() called on it
		return RGBf(getcol(102, help))
		-- Editor's note: be warned that 41 through 99 simply don't exist

	elseif t == 100 then
		-- Inactive Teleporter
		temp = (help.glow/2) + (fRandom() * 8)
		return 42 + temp, 42 + temp, 42 + temp
	elseif t == 101 then
		-- Active Teleporter
		return 164+(fRandom()*64),164+(fRandom()*64), 255-(fRandom()*64)
	elseif t == 102 then
		-- Teleporter in action!
		temp = fRandom() * 150
		if temp<33 then
			return 255 - (fRandom() * 64), 64 + (fRandom() * 64), 64 + (fRandom() * 64)
		elseif temp < 66 then
			return 64 + (fRandom() * 64), 255 - (fRandom() * 64), 64 + (fRandom() * 64)
		elseif temp < 100 then
			return 64 + (fRandom() * 64), 64 + (fRandom() * 64), 255 - (fRandom() * 64)
		else
			return 164+(fRandom()*64),164+(fRandom()*64), 255-(fRandom()*64)
		end
	else
		return 255, 255, 255
	end
end

-- This is from just the color-setting portion of Graphics.cpp:Graphics::drawgravityline()
local function getgravitylinecol(graphics)
	local t = graphics.linestate
	if t == 0 then
		return 180, 180, 180
	elseif t == 1 then
		return 215, 215, 195
	elseif t == 2 then
		return 195, 215, 215
	elseif t == 3 then
		return 180, 180, 154
	elseif t == 4 then
		return 176, 225, 204
	elseif t == 5 then
		return 176, 205, 185
	elseif t == 6 then
		return 154, 154, 154
	elseif t == 7 then
		return 185, 215, 195
	elseif t == 8 then
		return 195, 225, 185
	elseif t == 9 then
		return 215, 215, 215
	end
	-- The gravity line color when it's hit is 96, 96, 96
end

-- This is just from the roomname and roomtext color-setting portion of Graphics.cpp:Graphics::gamerender()
local function getroomprintcol(help)
	return 196, 196, 255 - help.glow
end


-- Exports
function o_Graphics:setcol(t, help)
	love.graphics.setColor(getcol(t, help))
end

function o_Graphics:setgravitylinecol()
	love.graphics.setColor(getgravitylinecol(self))
end

function o_Graphics:setroomprintcol(help)
	love.graphics.setColor(getroomprintcol(help))
end
