-- assetsmenu/draw

return function()
	local selecting
	for a = 0, 5 do
		local w, x, y
		w = love.graphics.getWidth()-128-32
		if a == 0 then
			x = 16
		else
			x = 40
			w = w - 24
		end
		y = 16+44*a

		love.graphics.setColor(128,128,128)
		love.graphics.rectangle("line", x+.5, y+.5, w, 33)

		if mouseon(x+1, y+1, w-1, 32) and not mousepressed and nodialog then
			love.graphics.setColor(48,48,48)
			love.graphics.rectangle("fill", x+1, y+1, w-1, 32)
			if love.mouse.isDown("l") then
				selecting = a
				mousepressed = true
			end
		end

		if a ~= 0 then
			-- Line coming from the top folder
			local line_start_y
			if a == 1 then
				line_start_y = y - 10
			else
				line_start_y = y - 27
			end
			local line_end_y = y + 16

			love.graphics.setColor(64,64,64)
			love.graphics.rectangle("fill", 24, line_start_y, 1, line_end_y-line_start_y)
			love.graphics.rectangle("fill", 24, line_end_y, 16, 1)
		end

		local exists = true
		if a == 1 then
			exists = musicfileexists(assetsmenu_music_prefix .. "vvvvvvmusic.vvv")
		elseif a == 2 then
			exists = musicfileexists(assetsmenu_music_prefix .. "mmmmmm.vvv")
		elseif a == 4 then
			exists = assetsmenu_soundsfolder_exists
		elseif a == 5 then
			exists = assetsmenu_graphicsfolder_exists
		end
		if exists then
			love.graphics.setColor(255,255,255)
		else
			love.graphics.setColor(255,255,255,128)
		end
		if a == 0 then
			theme:draw(image.smallfolder, x+5, y+5)
			if assetsmenu_show_level_assets then
				ved_print(langkeys(L.ASSETS_FOLDER_FOR_LEVEL, {editingmap}), x+17, y+5)
			else
				ved_print(L.CUSTOMVVVVVVDIRECTORY, x+17, y+5)
			end
			ved_print(assetsmenu_vvvvvvfolder_exists and L.ASSETS_FOLDER_EXISTS_YES or L.ASSETS_FOLDER_EXISTS_NO, x+17, y+21)
		elseif a == 1 then
			theme:draw(image.asset_pppppp, x+5, y+5)
			ved_print("vvvvvvmusic.vvv", x+17, y+5)
			ved_print(exists and L.MUSICEXISTSYES or L.MUSICEXISTSNO, x+17, y+21)
		elseif a == 2 then
			theme:draw(image.asset_mmmmmm, x+5, y+5)
			ved_print("mmmmmm.vvv", x+17, y+5)
			ved_print(exists and L.MUSICEXISTSYES or L.MUSICEXISTSNO, x+17, y+21)
		elseif a == 3 then
			theme:draw(image.asset_musiceditor, x+5, y+5)
			ved_print(L.MUSICEDITOR, x+17, y+5)
		elseif a == 4 then
			theme:draw(image.asset_sounds, x+5, y+5)
			ved_print(L.SOUNDS, x+17, y+5)
			if exists then
				ved_print(langkeys(L_PLU.NUM_SOUNDS_CUSTOMIZED, {assetsmenu_soundsfolder_num}), x+17, y+21)
			else
				ved_print(langkeys(L.NO_ASSETS_SUBFOLDER, {"sounds"}), x+17, y+21)
			end
		elseif a == 5 then
			theme:draw(image.asset_graphics, x+5, y+5)
			ved_print(L.GRAPHICS, x+17, y+5)
			if exists then
				ved_print(langkeys(L_PLU.NUM_GRAPHICS_CUSTOMIZED, {assetsmenu_graphicsfolder_num}), x+17, y+21)
			else
				ved_print(langkeys(L.NO_ASSETS_SUBFOLDER, {"graphics"}), x+17, y+21)
			end
		end

		love.graphics.setColor(255,255,255)
		if love.keyboard.isDown("f9") then
			local hotkey = ({"", "P", "sP", "M", "S", "G"})[a+1]
			if hotkey ~= "" then
				showhotkey(hotkey, x+w, y-2, ALIGN.RIGHT)
			end
		end
	end

	if love.keyboard.isDown("p") then
		if keyboard_eitherIsDown("shift") then
			selecting = 2
		else
			selecting = 1
		end
	elseif love.keyboard.isDown("m") then
		selecting = 3
	elseif love.keyboard.isDown("s") then
		selecting = 4
	elseif love.keyboard.isDown("g") then
		selecting = 5
	end

	if selecting == 0 then
		assets_create_or_explore_folder()
	elseif selecting == 1 then
		tostate(31, false, assetsmenu_music_prefix .. "vvvvvvmusic.vvv")
	elseif selecting == 2 then
		tostate(31, false, assetsmenu_music_prefix .. "mmmmmm.vvv")
	elseif selecting == 3 then
		tostate(31, false, "musiceditor")
	elseif selecting == 4 then
		tostate(31, false, assetsmenu_music_prefix .. "sounds")
	elseif selecting == 5 then
		tostate(32)
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)
	rbutton({L.RELOAD, "k"}, 2, nil, true)

	if nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(oldstate, true)
			mousepressed = true
		elseif onrbutton(2, nil, true) then
			-- Reload
			assets_reload_pressed()
			mousepressed = true
		end
	end
end
