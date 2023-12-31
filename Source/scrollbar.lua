-- Scroll bars!
function scrollbar(x, y, height, scrollableheight, fraction, indialog)
	-- Returns nil if untouched, returns scroll value if moved
	-- New fraction maybe?
	local newfraction

	local setColor
	if indialog == nil then
		setColor = love.graphics.setColor
	else
		setColor = function(...)
			indialog:setColor(...)
		end
	end

	setColor(96,96,96,96)
	love.graphics.rectangle("fill", x, y, 16, height)

	if scrollableheight > height then
		-- Display an actual scrollable thing
		-- BUTTONheight: (height/scrollableheight)*height
		-- BUTTONy: (height-BUTTONheight)*fraction
		local buttonheight = (height/scrollableheight)*height

		local scrollclickoffset = 0
		if scrollclickstart ~= nil then
			scrollclickoffset = love.mouse.getY()-scrollclickstart
		end

		if mouseon(x, y+(height-buttonheight)*fraction+scrollclickoffset, 16, buttonheight) and window_active() then
			setColor(224,224,224,255)
		else
			setColor(192,192,192,255)
			--[[
			if not mousepressed and love.mouse.isDown("l") then
				if scrollclickstart == nil then
					scrollclickstart = love.mouse.getY()
				end
			elseif scrollclickstart ~= nil then
				scrollclickstart = nil
			end
			]]
			--[[
			if not (not mousepressed and love.mouse.isDown("l")) then
				scrollclickstart = love.mouse.getY()
			end
			]]
		end

		if mouseon(x, y+(height-buttonheight)*fraction+scrollclickoffset, 16, buttonheight) and not mousepressed and (nodialog or indialog) and love.mouse.isDown("l") then
			if scrollclickstart == nil then
				scrollclickstart = love.mouse.getY()
				savedfraction = fraction
			end

			mousepressed = true
		elseif not love.mouse.isDown("l") and scrollclickstart ~= nil then
			scrollclickstart = nil
			savedfraction = nil
		end

		if scrollclickstart ~= nil then
			newfraction = savedfraction + (scrollclickoffset/(height-buttonheight))
		end

		love.graphics.rectangle("fill", x, math.min(math.max(y+(height-buttonheight)*(savedfraction == nil and fraction or savedfraction)+scrollclickoffset, y), (y+height)-buttonheight), 16, buttonheight)
	end

	setColor(255,255,255,255)

	--[[
	if newfraction ~= nil then
		cons("Returning " .. newfraction)
	end
	]]

	if newfraction ~= nil then
		return math.min(math.max(newfraction,0),1)
	end
end
