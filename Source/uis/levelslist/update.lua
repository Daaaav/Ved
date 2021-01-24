-- levelslist/update

return function(dt)
	if updatescrollingtext ~= nil then
		updatescrollingtext_pos = updatescrollingtext_pos + 55*dt
		if updatescrollingtext_pos > font8:getWidth(updatescrollingtext) + 112 then
			updatescrollingtext_pos = 0
		end
	end
	if current_scrolling_leveltitle_k ~= nil then
		current_scrolling_leveltitle_pos = current_scrolling_leveltitle_pos + 55*dt
		if current_scrolling_leveltitle_pos > font8:getWidth(anythingbutnil(current_scrolling_leveltitle_title)) + 168 then
			current_scrolling_leveltitle_pos = 0
		end
	end
	if current_scrolling_levelfilename_k ~= nil then
		current_scrolling_levelfilename_pos = current_scrolling_levelfilename_pos + 55*dt
		if current_scrolling_levelfilename_pos > font8:getWidth(current_scrolling_levelfilename_filename) + (s.psmallerscreen and 50-12 or 50)*8 then
			current_scrolling_levelfilename_pos = 0
		end
	end

	local chanmessage = allmetadata_outchannel:pop()

	if chanmessage ~= nil and chanmessage.refresh == levels_refresh then
		-- This file could have been (visually) removed by the debug function Shift+F3
		if files[chanmessage.dir][chanmessage.id] ~= nil then
			files[chanmessage.dir][chanmessage.id].metadata = chanmessage
		end

		-- Is this also the metadata for any recent file? TODO: Support subdirectories
		for k,v in pairs(s.recentfiles) do
			if chanmessage.path == v .. ".vvvvvv" then
				recentmetadata_files[v] = chanmessage.id
			end
		end
	end
end
