-- levelslist/mousepressed

return function(x, y, button)
	if hoveringlevel ~= nil and button == "l" then
		-- Just like when going to a room by clicking on the map, we don't want to click the first tile we press.
		nodialog = false

		state6load(hoveringlevel)
	elseif hoveringlevel ~= nil and button == "r" then
		if backupscreen and currentbackupdir ~= "" then
			rightclickmenu.create({"#[" .. hoveringlevel_k .. "]", L.SAVEBACKUP}, "bul_" .. hoveringlevel:sub((".ved-sys/backups"):len()+2, -1))
		end
	end
end
