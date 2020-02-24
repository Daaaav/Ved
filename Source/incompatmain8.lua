function load()
	-- Reeeeeally old version of love, I see
	love.load()

	draw = love.draw
end

function love.load()
	love.graphics.setCaption("Ved")

	-- Get the strings from every language!
	local languagesarray = love.filesystem.enumerate("lang")
	message = ""

	for k,v in pairs(languagesarray) do
		if v:sub(-4,-1) == ".lua" then
			require("lang/" .. v:sub(1,-5))

			message = message .. L.OUTDATEDLOVE .. "\n\n\n"
		end
	end

	if love._version_major == nil then
		love_version = "0.7.x or lower"
	else
		love_version = love._version_major .. "." .. love._version_minor .. "." .. love._version_revision
	end
end

function love.draw()
	love.graphics.printf(message, 10, 10, love.graphics.getWidth()-20, "center")

	love.graphics.print(
		"Ved version: " .. ved_ver_human() .. "\n"
		.. "LÖVE version: " .. love_version,
		8, love.graphics.getHeight()-21
	)
end
