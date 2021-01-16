function love.directorydropped(path)
	-- LÖVE 0.10+
	hook("love_directorydropped", {path})
end
