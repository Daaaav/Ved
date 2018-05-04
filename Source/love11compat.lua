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
	trace_print("print")
end

love.graphics.printf11 = love.graphics.printf

love.graphics.printf = function(...)
	love11_tempfixfontpos(love.graphics.printf11, ...)
	trace_print("printf")
end

-- This is just for my development purposes!
function trace_print(func)
	local trace = debug.traceback()
	--[[
	print(trace)
	print("So this matches: ")
	print(trace:match(".-\n.-\n.-\n\t(.-:.-):.-\n"))
	]]
	local currentfonttxt = "unknown"
	local currentfont = love.graphics.getFont()
	if currentfont == font8 then
		currentfonttxt = "font8"
	elseif currentfont == font16 then
		currentfonttxt = "font16"
	elseif currentfont == tinynumbers then
		currentfonttxt = "tinynumbers"
	end
	print_traces[trace:match(".-\n.-\n.-\n\t(.-:.-):.-\n")] = func .. "/" .. currentfonttxt
end

function get_print_traces()
	local fulltextarr = {}
	for k,v in pairs(print_traces) do
		table.insert(fulltextarr, k .. "/" .. v)
	end
	love.system.setClipboardText(table.concat(fulltextarr, "\n"))
end

print_traces = {}
