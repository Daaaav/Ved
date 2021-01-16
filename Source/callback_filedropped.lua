function love.filedropped(file)
	-- LÖVE 0.10+
	hook("love_filedropped", {file})

	if state == 32 then
		-- Maybe make a UI callback for this?
		local path = file:getFilename()
		-- A bit annoying that we have to do this manually, but oh well
		local last_dirsep = path:reverse():find(dirsep, 1, true)
		local filename
		if last_dirsep == nil then
			filename = path
		else
			filename = path:sub(-last_dirsep+1, -1)
		end
		assets_openimage(path, filename)
	end
end
