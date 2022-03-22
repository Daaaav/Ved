-- Compatibility with love2d 0.10.x and above

love.mouse.isDown10 = love.mouse.isDown

love.mouse.isDown = function(button)
	if button == "l" then
		return love.mouse.isDown10(1)
	elseif button == "r" then
		return love.mouse.isDown10(2)
	elseif button == "m" then
		return love.mouse.isDown10(3)
	end
end


function love.wheelmoved(x, y)
	if y > 0 then
		love.mousepressed(love.mouse.getX(), love.mouse.getY(), "wu")
	elseif y < 0 then
		love.mousepressed(love.mouse.getX(), love.mouse.getY(), "wd")
	end
end

function love.graphics.isSupported()
	-- Only used for canvas in Ved as far as I know
	return true
end

function love.graphics.getSystemLimit(limittype)
	return love.graphics.getSystemLimits()[limittype]
end

love.graphics.setBlendMode10 = love.graphics.setBlendMode

-- In 0.9.x, this function only takes a single parameter
function love.graphics.setBlendMode(mode)
	if mode == "premultiplied" then
		love.graphics.setBlendMode10("alpha", "premultiplied")
	else
		love.graphics.setBlendMode10(mode)
	end
end

love.window.isCreated = love.window.isOpen
