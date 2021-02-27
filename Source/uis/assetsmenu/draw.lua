-- assetsmenu/draw

return function()
	local selecting
	for a = 0, 4 do
		love.graphics.setColor(128,128,128)
		love.graphics.rectangle("line", 16.5, 16.5+44*a, 744, 33)

		if mouseon(16.5, 16.5+44*a, 744, 33) and not mousepressed and nodialog then
			love.graphics.setColor(48,48,48)
			love.graphics.rectangle("fill", 17, 17+44*a, 743, 32)
			if love.mouse.isDown("l") then
				selecting = a
				mousepressed = true
			end
		end

		love.graphics.setColor(255,255,255)
		if a == 0 then
			love.graphics.draw(image.asset_pppppp, 21, 21)
			ved_print("vvvvvvmusic.vvv", 33, 21)
			ved_print(musicfileexists("vvvvvvmusic.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37)
		elseif a == 1 then
			love.graphics.draw(image.asset_mmmmmm, 21, 21+44)
			ved_print("mmmmmm.vvv", 33, 21+44)
			ved_print(musicfileexists("mmmmmm.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37+44)
		elseif a == 2 then
			love.graphics.draw(image.asset_musiceditor, 21, 21+88)
			ved_print(L.MUSICEDITOR, 33, 21+88)
			--ved_print(musicfileexists("mmmmmm.vvv") and L.MUSICEXISTSYES or L.MUSICEXISTSNO, 33, 37+88)
		elseif a == 3 then
			love.graphics.draw(image.asset_sounds, 21, 21+132)
			ved_print(L.SOUNDS, 33, 21+132)
		elseif a == 4 then
			love.graphics.draw(image.asset_graphics, 21, 21+176)
			ved_print(L.GRAPHICS, 33, 21+176)
		end

		if love.keyboard.isDown("f9") then
			local hotkey = ({"P", "sP", "M", "S", "G"})[a+1]
			showhotkey(hotkey, (17+744-1), (16+44*a)-2, ALIGN.RIGHT)
		end
	end

	if love.keyboard.isDown("p") then
		if keyboard_eitherIsDown("shift") then
			selecting = 1
		else
			selecting = 0
		end
	elseif love.keyboard.isDown("m") then
		selecting = 2
	elseif love.keyboard.isDown("s") then
		selecting = 3
	elseif love.keyboard.isDown("g") then
		selecting = 4
	end

	if selecting == 0 then
		tostate(31, false, "vvvvvvmusic.vvv")
	elseif selecting == 1 then
		tostate(31, false, "mmmmmm.vvv")
	elseif selecting == 2 then
		tostate(31, false, "musiceditor")
	elseif selecting == 3 then
		tostate(31, false, "sounds")
	elseif selecting == 4 then
		tostate(32)
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)

	if nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(oldstate, true)
			mousepressed = true
		end
	end
end
