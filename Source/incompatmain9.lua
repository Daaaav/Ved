function love.load()
	love.window.setTitle("Ved")

	-- Get the strings from every language!
	local languagesarray = love.filesystem.getDirectoryItems("lang")
	message = ""

	for k,v in pairs(languagesarray) do
		if v:sub(-4,-1) == ".lua" then
			require("lang/" .. v:sub(1,-5))

			message = message .. L.OUTDATEDLOVE090 .. "\n\n\n"
		end
	end
end

function love.draw()
	love.graphics.printf(message, 10, 10, love.graphics.getWidth()-20, "left")
end
