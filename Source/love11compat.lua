-- Compatibility with love2d 11.x and above

love.graphics.setColor11 = love.graphics.setColor

love.graphics.setColor = function(r,g,b,a)
	if type(r) == "table" then
		r, g, b, a = unpack(r)
	end
	love.graphics.setColor11(r/255, g/255, b/255, (a or 255) / 255)
end

love.graphics.setBackgroundColor11 = love.graphics.setBackgroundColor

love.graphics.setBackgroundColor = function(r,g,b,a)
	if type(r) == "table" then
		r, g, b, a = unpack(r)
	end
	love.graphics.setBackgroundColor11(r/255, g/255, b/255, (a or 255) / 255)
end

love.filesystem.exists = function(filename)
	return love.filesystem.getInfo(filename) ~= nil
end

love.filesystem.isDirectory = function(filename)
	return love.filesystem.getInfo(filename, "directory") ~= nil
end


-- So this was a bug in love, not in the font?
function love11_tempfixfontpos(func, ...)
	local args = {...}
	local currentfont = love.graphics.getFont()
	if currentfont == font8 then
		args[3] = args[3] - 2 -- y
	elseif currentfont == font16 then
		args[3] = args[3] - 3
	end
	func(unpack(args))
end

love.graphics.print11 = love.graphics.print

love.graphics.print = function(...)
	love11_tempfixfontpos(love.graphics.print11, ...)
end

love.graphics.printf11 = love.graphics.printf

love.graphics.printf = function(...)
	love11_tempfixfontpos(love.graphics.printf11, ...)
end
