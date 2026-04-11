function load()
	-- Reeeeeally old version of love, I see
	love.load()

	draw = love.draw
end

function love.load()
	create_fallback_window()

	love.graphics.setFont(love.graphics.newFont(20))

	message = "Your version of LOVE (" .. love_ver_human() .. ") is outdated.\nPlease use version 0.9.1 or higher.\n\nYou can download the latest version of LOVE from:\nhttps://love2d.org/"
end

function love.draw()
	love.graphics.setColor(64,64,64)
	love.graphics.rectangle("fill", 40, 140, love.graphics.getWidth()-80, 200)
	love.graphics.setColor(255,255,255)

	love.graphics.printf(message, 10, 180, love.graphics.getWidth()-20, "center")
end
