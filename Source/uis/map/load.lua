-- map/load

return function()
	mapscale = math.min(1/metadata.mapwidth, 1/metadata.mapheight)
	--mapxoffset = (640-(((1/mapscale)-metadata.mapwidth)*mapscale*640))/2
	--mapyoffset = (480-(((1/mapscale)-metadata.mapheight)*mapscale*480))/2
	mapxoffset = (((1/mapscale)-metadata.mapwidth)*mapscale*640)/2
	mapyoffset = (((1/mapscale)-metadata.mapheight)*mapscale*480)/2

	selectingrooms = 0
	selected1x = -1; selected1y = -1
	selected2x = -1; selected2y = -1

	mapmovedroom = false

	setgenerictimer(2, 2.75)

	locatetrinketscrewmates()

	if editingbounds ~= 0 then
		if editingbounds == 1 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (map canceled)")
		elseif editingbounds == 2 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (map canceled)")
		end

		editingbounds = 0
	end
end
