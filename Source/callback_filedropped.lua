function love.filedropped(file)
	-- LÖVE 0.10+
	hook("love_filedropped", {file})

	-- TODO: Maybe make a UI callback for this?

	local path = file:getFilename()
	local ext = path:match("^.+(%..+)$")
	if ext == ".vvvvvv" then
		-- Load a level file
		local levelname = path:sub(levelsfolder:len()+2, -8)

		if has_unsaved_changes() then
			dialog.create(
				L.SUREOPENLEVEL, DBS.SAVEDISCARDCANCEL,
				dialog.callback.sureopenlevel,
				nil,
				dialog.form.hidden_make({levelname=levelname}),
				dialog.callback.noclose_on.save
			)
		else
			state6load(levelname)
		end
	elseif state == 32 or state == 36 then
		-- A bit annoying that we have to do this manually, but oh well
		-- TODO: Instead of duplicating the code, maybe just make one shared function for getting the parts;
		-- this is already copy-pasted between filefunc and here!
		local last_dirsep = path:reverse():find(dirsep, 1, true)
		local filename
		if last_dirsep == nil then
			filename = path
		else
			filename = path:sub(-last_dirsep+1, -1)
		end
		if state == 32 then
			assets_openimage(path, filename)
		elseif state == 36 then
			fonteditor_load_font(path, filename)
		end
	end
end
