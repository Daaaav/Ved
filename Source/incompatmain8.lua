function load()
	-- Reeeeeally old version of love, I see
	love.load()

	draw = love.draw
end

function love.load()
	create_fallback_window()

	loadfonts()

	-- Get the strings from every language!
	local languagesarray = love.filesystem.enumerate("lang")
	message = ""

	for k,v in pairs(languagesarray) do
		if v:sub(-4,-1) == ".lua" then
			require("lang/" .. v:sub(1,-5))

			message = message .. L.OUTDATEDLOVE .. "\n\n\n"
		end
	end
end

function love.draw()
	love.graphics.printf(message, 10, 10, love.graphics.getWidth()-20, "center")

	love.graphics.print(
		"Ved version: " .. ved_ver_human() .. "\n"
		.. "LÖVE version: " .. love_ver_human(),
		8, love.graphics.getHeight()-21
	)
end
