-- levelslist/load

return function(special_mode)
	if oldstate == 1 and levelmetadata ~= nil then -- if levelmetadata is nil, it's clear we don't have a level loaded so going "back" to the editor will be a small disaster
		-- We'll be able to go back. Show this by making a screenshot
		if love_version_meets(11) then
			love.graphics.captureScreenshot(
				function(imgdata)
					editorscreenshot = love.graphics.newImage(imgdata)
				end
			)
			-- Make sure the screenshot is of the correct state!
			love.graphics.present()
		else
			editorscreenshot = love.graphics.newImage(love.graphics.newScreenshot())
		end
		state6old1 = true
	end

	-- Maybe we want to compare a level to another one?
	secondlevel = special_mode == "secondlevel"

	-- Input should've been stopped, but it isn't always stopped apparently.
	stopinput()
	input = ""
	input_r = ""

	--loadlevelsfolder()

	oldinput = ""
	tabselected = 0
	backupscreen = false
	currentbackupdir = ""
	levellistscroll = 0
	max_levellistscroll = 0
end
