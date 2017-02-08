cons("Scaling modifications included")

love.graphics.setScissorOR = love.graphics.setScissor

love.graphics.setScissor = function(x,y,width,height)
	if x == nil then
		love.graphics.setScissorOR()
	else
		love.graphics.setScissorOR(x*s.pscale, y*s.pscale, width*s.pscale, height*s.pscale)
	end
end


love.graphics.getWidthOR = love.graphics.getWidth

love.graphics.getWidth = function()
	--return love.graphics.getWidthOR()
	if s.smallerscreen then
		return 800
	end
	return 64+640+192
end


love.graphics.getHeightOR = love.graphics.getHeight

love.graphics.getHeight = function()
	--return love.graphics.getHeightOR()
	return 480
end


love.mouse.getXOR = love.mouse.getX

love.mouse.getX = function()
	return love.mouse.getXOR()*s.pscale^-1
end


love.mouse.getYOR = love.mouse.getY

love.mouse.getY = function()
	return love.mouse.getYOR()*s.pscale^-1
end