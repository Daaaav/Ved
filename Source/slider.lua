function int_control(x, y, setting, minval, maxval, warnval)
	local maxvalwidth = math.floor(math.log10(maxval)+1)*8

	hoverrectangle(128,128,128,128, x, y, 16, 16, false)
	love.graphics.print("-", x+4, y+6)
	hoverrectangle(128,128,128,128, x+24+maxvalwidth, y, 16, 16, false)
	love.graphics.print("+", x+28+maxvalwidth, y+6)
	if nodialog and mouseon(x, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) and s[setting] > minval then
		s[setting] = s[setting] - 1
	end
	if nodialog and mouseon(x+24+maxvalwidth, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) and s[setting] < maxval then
		s[setting] = s[setting] + 1
	end

	-- Are there any "danger" values?
	local setcolor = false
	if warnval ~= nil and warnval(s[setting]) then
		love.graphics.setColor(255,0,0)
		setcolor = true
	end

	love.graphics.printf(s[setting], x+17, y+6, maxvalwidth+8, "center")

	if setcolor then
		love.graphics.setColor(255,255,255)
	end
end