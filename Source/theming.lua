local self = {}

function self:init()
	self.themes = {}
	self.active_themes = {
		"default",
		"vvvvvv"
	}

	self.quads = {}

	self:load_themes()
end

function self:load_themes()
	self.themes = {}
	local folders = love.filesystem.getDirectoryItems("themes")
	for index, name in ipairs(folders) do
		if love.filesystem.isDirectory("themes/" .. name) then
			self.themes[name] = self:load_theme(name)
		end
	end

	-- if default theme is not found, error

	if not self.themes["default"] then
		error("Default theme not found.")
	end

	self:refresh_active_themes()
end

function self:load_theme(name)
	local theme = {
		name = name,
		assets = {},
		events = {},
		info = {
			author = "Unknown",
			description = "No description provided."
		}
	}

	-- commence recursive crawl!
	-- basically: if it's a png, save it as an image.
	self:load_theme_folder("themes/" .. name .. "/", "", theme)

	-- NOW: is there a theme.lua file? if so, load it.
	if love.filesystem.getInfo("themes/" .. name .. "/theme.lua") then
		local chunk = love.filesystem.load("themes/" .. name .. "/theme.lua")
		if chunk then
			local env = {}
			setmetatable(env, {__index = _G})
			setfenv(chunk, env)
			chunk()
			theme.events = env
			theme.info = env.info
		end
	end
	return theme
end

function self:load_theme_folder(base_path, path, theme)
	local full_path = base_path .. path
	local items = love.filesystem.getDirectoryItems(full_path)
	for index, name in ipairs(items) do
		local image_path = full_path .. "/" .. name
		local rel_path = path ~= "" and (path .. "/" .. name) or name
		if love.filesystem.isDirectory(image_path) then
			self:load_theme_folder(base_path, rel_path, theme)
		else
			local ext = name:match("^.+%.(.+)$")
			if ext == "png" then
				-- snip off file ext
				rel_path = rel_path:sub(1, -5)
				print("LOADING ASSET AT " .. image_path)
				local imagedata = love.image.newImageData(image_path)
				local image = love.graphics.newImage(imagedata)
				print(image)
				theme.assets[rel_path] = {
					image = image,
					imagedata = imagedata,
					width = image:getWidth(),
					height = image:getHeight(),
					name = rel_path
				}
			end
		end
	end
end

function self:refresh_active_themes()
	for i = #self.active_themes, 1, -1 do
		local theme = self.active_themes[i]
		if not self.themes[theme] then
			table.remove(self.active_themes, i)
		end
	end
end

function self:get_themes()
	return self.themes
end

function self:get_active_themes()
	return self.active_themes
end

function self:get_asset(name)
	for i = #self.active_themes, 1, -1 do
		local theme = self.active_themes[i]
		local asset = self.themes[theme].assets[name]
		if asset then
			return asset
		end
	end
end

function self:draw(asset, x, y, r, sx, sy)
	if type(asset) == "string" then
		asset = self:get_asset(asset)
	end

	if (self:call("draw", asset, x, y, r, sx, sy)) then return end

	if asset then
		love.graphics.draw(asset.image, x, y, r, sx, sy)
	end
end

function self:draw_nineslice(asset, x, y, x2, y2)
	if type(asset) == "string" then
		asset = self:get_asset(asset)
	end

	if (self:call("draw_nineslice", asset, x, y, x2, y2)) then return end

	if asset then
		local low_x = math.min(x, x2)
		local low_y = math.min(y, y2)
		local high_x = math.max(x, x2)
		local high_y = math.max(y, y2)

		-- draw nineslice, assuming all pieces are equal in size, so you can divide by 3
		local w, h = asset.width, asset.height
		local w2, h2 = w/3, h/3
		if (math.floor(w2) ~= w2) or (math.floor(h2) ~= h2) then
			error("Nineslice image " .. asset.name .. " is not divisible by 3.")
		end

		local draw_sprite_part = function(x, y, sx, sy, sw, sh)
			local quad = self:get_quad(sx, sy, sw, sh, w, h)
			love.graphics.draw(asset.image, quad, x, y)
		end

		-- draw the corners
		draw_sprite_part(low_x, low_y, 0, 0, w2, h2)
		draw_sprite_part(high_x - w2, low_y, w2*2, 0, w2, h2)
		draw_sprite_part(low_x, high_y - h2, 0, h2*2, w2, h2)
		draw_sprite_part(high_x - w2, high_y - h2, w2*2, h2*2, w2, h2)
		-- draw the edges, looping through the middle
		for i = low_x + w2, high_x - w2 * 2, w2 do
			draw_sprite_part(i, low_y, w2, 0, w2, h2)
			draw_sprite_part(i, high_y - h2, w2, h2*2, w2, h2)
		end

		for i = low_y + h2, high_y - h2 * 2, h2 do
			draw_sprite_part(low_x, i, 0, h2, w2, h2)
			draw_sprite_part(high_x - w2, i, w2*2, h2, w2, h2)
		end

		-- draw the middle, once again looping
		for i = low_x + w2, high_x - w2 * 2, w2 do
			for j = low_y + h2, high_y - h2 * 2, h2 do
				draw_sprite_part(i, j, w2, h2, w2, h2)
			end
		end
	end
end

function self:get_quad(x, y, w, h, image_width, image_height)
	local key = x .. "_" .. y .. "_" .. w .. "_" .. h .. "_" .. image_width .. "_" .. image_height

	if self.quads[key] then
		return self.quads[key]
	end

	self.quads[key] = love.graphics.newQuad(x, y, w, h, image_width, image_height)
	return self.quads[key]
end

function self:call(event, ...)
	for i = #self.active_themes, 1, -1 do
		local theme = self.active_themes[i]
		if self.themes[theme].events and self.themes[theme].events[event] then
			local result = self.themes[theme].events[event](...)
			if result then
				return result
			end
		end
	end
	return false
end

function self:setIcon(asset)
	if type(asset) == "string" then
		asset = self:get_asset(asset)
	end

	if asset then
		love.window.setIcon(asset.imagedata)
	end
end

return self
