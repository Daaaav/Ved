function int_control(x, y, setting, minval, maxval, warnval,  cs, formatter, maxvalwidth)
	if cs == nil then
		-- custom s, aka the table that is used for settings here
		cs = s
	end
	if maxvalwidth == nil then
		maxvalwidth = math.floor(math.log10(maxval)+1)*8
	end

	hoverrectangle(128,128,128,128, x, y, 16, 16, false)
	love.graphics.print("-", x+4, y+6)
	hoverrectangle(128,128,128,128, x+24+maxvalwidth, y, 16, 16, false)
	love.graphics.print("+", x+28+maxvalwidth, y+6)
	if nodialog and mouseon(x, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) and cs[setting] > minval then
		cs[setting] = cs[setting] - 1
		mousepressed = true
	end
	if nodialog and mouseon(x+24+maxvalwidth, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) and cs[setting] < maxval then
		cs[setting] = cs[setting] + 1
		mousepressed = true
	end

	-- Are there any "danger" values?
	local setcolor = false
	if warnval ~= nil and warnval(cs[setting]) then
		love.graphics.setColor(255,0,0)
		setcolor = true
	end

	local display
	if formatter ~= nil then
		display = formatter(cs[setting])
	else
		display = cs[setting]
	end
	love.graphics.printf(display, x+17, y+6, maxvalwidth+8, "center")

	if setcolor then
		love.graphics.setColor(255,255,255)
	end
end

function custom_int_control(x, y, decrementor, incrementor, warnval,  formatter, maxvalwidth)
	hoverrectangle(128,128,128,128, x, y, 16, 16, false)
	love.graphics.print("-", x+4, y+6)
	hoverrectangle(128,128,128,128, x+24+maxvalwidth, y, 16, 16, false)
	love.graphics.print("+", x+28+maxvalwidth, y+6)
	if nodialog and mouseon(x, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) then
		decrementor()
		mousepressed = true
	end
	if nodialog and mouseon(x+24+maxvalwidth, y, 16, 16) and love.mouse.isDown("l") and (keyboard_eitherIsDown("shift") or not mousepressed) then
		incrementor()
		mousepressed = true
	end

	-- Are there any "danger" values?
	local setcolor = false
	if warnval ~= nil and warnval() then
		love.graphics.setColor(255,0,0)
		setcolor = true
	end

	love.graphics.printf(formatter(), x+17, y+6, maxvalwidth+8, "center")

	if setcolor then
		love.graphics.setColor(255,255,255)
	end
end
