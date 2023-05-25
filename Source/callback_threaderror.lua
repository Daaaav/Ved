function love.threaderror(thread, errorstr)
	dialog.create(L.THREADERROR .. "\n\n" .. errorstr)
	cons("Thread error: " .. errorstr)
end
