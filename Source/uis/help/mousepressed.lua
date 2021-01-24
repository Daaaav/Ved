-- help/mousepressed

return function(x, y, button)
	if helpeditingline ~= 0 and button == "l" and mouseon(
		214+(s.psmallerscreen and -96 or 0),
		8,
		love.graphics.getWidth()-238-(s.psmallerscreen and -96 or 0),
		love.graphics.getHeight()-16
	) then
		local chr, line
		local screenxoffset = 0
		if s.psmallerscreen then
			screenxoffset = -96
		end
		chr = math.floor((x-216-screenxoffset)/8) + 1
		line = math.floor(((y-8)-helparticlescroll-3)/10) + 1
		helpgotoline(line, chr)
	end
end
