-- help/update

return function(dt)
	if s.psmallerscreen then
		local leftpartw = 8+200+8-96-2
		local extrawidth = 0
		if helprefreshable then
			extrawidth = 20
		end
		if love.mouse.getX() <= leftpartw then
			onlefthelpbuttons = true
		elseif love.mouse.getX() > 25*8+16-28+extrawidth then
			onlefthelpbuttons = false
		end
	end
end
