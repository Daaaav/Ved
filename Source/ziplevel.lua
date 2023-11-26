local function add_files_from_folder(zip, path, relative_dir)
	local success, files, err = listfiles_generic(path, "", true)
	if not success then
		cons("Cannot add files from " .. path .. ": " .. err)
		return
	end

	for k,file in pairs(files) do
		-- path starts out ending in /levelname or \levelname
		-- relative_dir starts out empty
		local real_path = path .. dirsep .. file.name
		local zip_path = relative_dir .. file.name

		if file.isdir then
			add_files_from_folder(
				zip,
				real_path,
				zip_path .. "/" 
			)
		else
			cons("Adding file " .. real_path .. " as " .. zip_path)
			local file_success, file_contents = readfile(real_path)
			if not file_success then
				cons("Error adding file: " .. file_contents)
				error(file_contents)
			end
			local do_compress = true
			zip:add_file(
				zip_path,
				file_contents,
				file_contents:len(),
				do_compress,
				file.lastmodified
			)
		end
	end
end

function zip_level(editingmap, save_filepath, save_filename)
	-- Make a zip of the level named editingmap, along with all its assets
	-- Returns true if succeeded, false,err if failed

	return pcall(function()
		local zip = cZipwriter:new{filename=save_filepath}
		cons("Starting zip at " .. zip.filename)

		-- Name the level the same as the zip (for 2.3's more strict checks)
		-- unless the zip has a weird filename
		local level_filename
		if save_filename:sub(-4) == ".zip" then
			levelname = save_filename:sub(1,-5) .. ".vvvvvv"
		else
			levelname = editingmap .. ".vvvvvv"
		end

		local real_level_file = levelsfolder .. dirsep .. editingmap .. ".vvvvvv"
		local level_success, level_contents = readlevelfile(real_level_file)
		if not level_success then
			error(level_contents)
		end
		zip:add_file(
			levelname,
			level_contents,
			level_contents:len(),
			true,
			getmodtime(real_level_file)
		)

		add_files_from_folder(zip, levelsfolder .. dirsep .. editingmap, "")

		zip:finish()
		cons("Finished zip!")
	end)
end
