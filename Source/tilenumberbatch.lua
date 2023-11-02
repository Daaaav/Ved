local ffi = require("ffi")

ffi.cdef([[
	typedef struct _tilenumberbatch_cache
	{
		unsigned tile;
		short x;
		short y;
	} tilenumberbatch_cache;
]])

local self = {}

self.batch_normal = nil
self.batch_shadow = nil

self.cache = nil
self.cache_dirty = true
self.cache_cur = 0
self.cache_len = 0

function self:init()
	self.batch_normal = love.graphics.newSpriteBatch(tinyfont.image, 9600, "dynamic")
	self.batch_shadow = love.graphics.newSpriteBatch(tinyfont.image, 9600, "dynamic")

	self.cache = ffi.new("tilenumberbatch_cache[1200]")
end

function self:prepare()
	self.cache_cur = 0
end

function self:add(t, x, y)
	if self.cache_cur >= 1200 then
		return
	end

	local cur = self.cache_cur

	if self.cache_dirty
	or self.cache[cur].tile ~= t
	or self.cache[cur].x ~= x
	or self.cache[cur].y ~= y then
		self.cache_dirty = true
		self.cache[cur].tile = t
		self.cache[cur].x = x
		self.cache[cur].y = y
	end

	self.cache_cur = cur + 1
end

function self:draw()
	if self.cache_dirty or self.cache_cur ~= self.cache_len then
		self.cache_dirty = false
		self.cache_len = self.cache_cur

		self.batch_normal:clear()
		self.batch_shadow:clear()

		spritebatch_set_color(self.batch_shadow, 0, 0, 0)

		-- Print each tile number in the "fading" style.
		for add = 0, self.cache_len-1 do
			local st = tostring(self.cache[add].tile)

			if st:len() > 8 then
				st = ("9"):rep(8)
			end

			for i = 0, st:len()-1 do
				local print_y = math.floor(i/4)
				local col = 255 - 32*i + 32*print_y

				spritebatch_set_color(self.batch_normal, col, col, col)

				local glyph = tinyfont:get_glyph(string.byte(st, i+1))
				if glyph ~= nil then
					local px, py = self.cache[add].x+(i%4)*4, self.cache[add].y+print_y*7
					self.batch_normal:add(glyph.quad, px, py)
					self.batch_shadow:add(glyph.quad, px, py)
				end
			end
		end
	end

	love.graphics.draw(self.batch_shadow, 0, -1)
	love.graphics.draw(self.batch_shadow, -1, 0)
	love.graphics.draw(self.batch_shadow, 1, 0)
	love.graphics.draw(self.batch_shadow, 0, 1)
	love.graphics.draw(self.batch_normal)
end

return self
