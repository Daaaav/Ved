-- overlapentinfo/load

return function()
	overlappingentities = {}
	listoverlappingentities(overlappingentities)
	text21 = ""
	for k,v in pairs(overlappingentities) do
		text21 = text21 .. "Entity #" .. k .. " type " .. v.t .. " in room " .. (v.x/40) .. "," .. (v.y/30) .. "\n"
	end
end
