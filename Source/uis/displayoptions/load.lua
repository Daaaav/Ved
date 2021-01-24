-- displayoptions/load

return function()
	oldforcescale = s.forcescale
	nonintscale = s.scale ~= math.floor(anythingbutnil0(tonumber(s.scale)))
	if nonintscale then
		startinput()
		input = tostring(s.scale)
	end
end
