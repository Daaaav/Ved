-- levelslist/update

return function(dt)
	if updatecheck.scrolling_text ~= nil then
		updatecheck.scrolling_text_pos = updatecheck.scrolling_text_pos + 55*dt
		if updatecheck.scrolling_text_pos > font_8x8:getWidth(updatecheck.scrolling_text) + 112 then
			updatecheck.scrolling_text_pos = 0
		end
	end
	if current_scrolling_leveltitle_k ~= nil then
		current_scrolling_leveltitle_pos = current_scrolling_leveltitle_pos + 55*dt
		if current_scrolling_leveltitle_pos > current_scrolling_leveltitle_font:getWidth(
			anythingbutnil(current_scrolling_leveltitle_title)
		) + 168 then
			current_scrolling_leveltitle_pos = 0
		end
	end
	if current_scrolling_levelfilename_k ~= nil then
		current_scrolling_levelfilename_pos = current_scrolling_levelfilename_pos + 55*dt
		if current_scrolling_levelfilename_pos > font_ui:getWidth(current_scrolling_levelfilename_filename) + (s.psmallerscreen and 50-12 or 50)*8 then
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
