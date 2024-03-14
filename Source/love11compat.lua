-- Compatibility with love2d 11.x and above

love.graphics.setColor11 = love.graphics.setColor

love.graphics.setColor = function(r,g,b,a)
	if type(r) == "table" then
		r, g, b, a = unpack(r)
	end
	love.graphics.setColor11(r/255, g/255, b/255, (a or 255) / 255)
end

love.graphics.getColor11 = love.graphics.getColor

love.graphics.getColor = function()
	local r, g, b, a = love.graphics.getColor11()
	return r*255, g*255, b*255, a*255
end

love.graphics.setBackgroundColor11 = love.graphics.setBackgroundColor

love.graphics.setBackgroundColor = function(r,g,b,a)
	if type(r) == "table" then
		r, g, b, a = unpack(r)
	end
	love.graphics.setBackgroundColor11(r/255, g/255, b/255, (a or 255) / 255)
end

love.filesystem.exists12 = love.filesystem.exists -- Keep this around for the love12compat file
love.filesystem.exists = function(filename)
	return love.filesystem.getInfo(filename) ~= nil
end

love.filesystem.isDirectory = function(filename)
	return love.filesystem.getInfo(filename, "directory") ~= nil
end

love.filesystem.isFile = function(filename)
	return love.filesystem.getInfo(filename, "file") ~= nil
end

love.filesystem.isSymlink = function(filename)
	return love.filesystem.getInfo(filename, "symlink") ~= nil
end

love.filesystem.getLastModified = function(filename)
	local info = love.filesystem.getInfo(filename)
	if info == nil then return nil end
	return info.modtime
end

love.mouse.hasCursor = function()
	return love.mouse.isCursorSupported()
end
