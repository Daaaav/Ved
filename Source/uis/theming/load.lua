-- theming/load

return function()
	oldforcescale = s.forcescale
	nonintscale = s.scale ~= math.floor(anythingbutnil0(s.scale))
	if nonintscale then
		newinputsys.create(INPUT.ONELINE, "scale", tostring(s.scale))
	end
end
