-- scripteditor/mousepressed

return function(x, y, button)
	if button == "l" and mouseon(56, 24, love.graphics.getWidth()-200, love.graphics.getHeight()-24) then
		local chr, line
		if s.scripteditor_largefont then
			chr = math.floor((x-104)/16) + 1
			line = math.floor(((y-24)-scriptscroll-4)/16) + 1
		else
			chr = math.floor((x-56)/8) + 1
			line = math.floor(((y-24)-scriptscroll-6)/8) + 1
		end
		if chr < 1 then
			chr = 1
		end
		scriptgotoline(line, chr)
	end
end
