-- search/draw

return function()
	font_ui:print(L.SEARCHFOR, 12, 10)
	newinputsys.print("search", font8:getWidth(L.SEARCHFOR)+20, 10, font_level)

	font_ui:printf(langkeys(L.SEARCHRESULTS_SCRIPTS, {#searchscripts}), 8, 32+4, 284, "center")
	font_ui:printf(langkeys(L.SEARCHRESULTS_ROOMS, {#searchrooms}), 8+284+4, 32+4, 284, "center")
	font_ui:printf(langkeys(L.SEARCHRESULTS_NOTES, {#searchnotes}), 8+284+4+284+4, 32+4, 284, "center")

	for k,v in pairs(searchscripts) do
		if k <= showresults and 32*k+16+searchscroll+30 >= 48 and 32*k+16+searchscroll <= love.graphics.getHeight() then
			love.graphics.setScissor(8, math.max(48, 32*k+16+searchscroll), 284, 30)
			hoverrectangle(128,128,128,128, 8, 32*k+16+searchscroll, 284, 30)
			highlightresult(v.name, previous_search, 12, 32*k+16+searchscroll+5)
			if v.foundline ~= 0 then
				local namewidth = font_level:getWidth(v.name)
				font_ui:print("\u{200e} - " .. L.LINE .. v.foundline, 12+namewidth, 32*k+16+searchscroll+5)
				highlightresult(v.foundlinecontent, previous_search, 12, 32*k+16+searchscroll+8+5)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8, 32*k+16+searchscroll, 284, 30) then
				newinputsys.close("search")
				scriptineditor(v.name)
				scriptfromsearch = true

				if v.foundline ~= 0 then
					scriptgotoline(v.foundline)
				end

				mousepressed = true
				nodialog = false
			end
		end
	end

	for k,v in pairs(searchrooms) do
		if k <= showresults and 32*k+16+searchscroll+30 >= 48 and 32*k+16+searchscroll <= love.graphics.getHeight() then
			love.graphics.setScissor(8+284+4, math.max(48, 32*k+16+searchscroll), 284, 30)
			hoverrectangle(128,128,128,128, 8+284+4, 32*k+16+searchscroll, 284, 30)
			if s.coords0 then
				font_ui:print("(" .. v.x .. "," .. v.y .. ")", 12+284+4, 32*k+16+searchscroll+5)
			else
				font_ui:print("(" .. (v.x+1) .. "," .. (v.y+1) .. ")", 12+284+4, 32*k+16+searchscroll+5)
			end
			highlightresult(v.name, previous_search, 12+284+4, 32*k+16+searchscroll+8+5)

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8+284+4, 32*k+16+searchscroll, 284, 30) then
				newinputsys.close("search")
				gotoroom(v.x, v.y)

				tostate(1, true)

				mousepressed = true
				nodialog = false
			end
		end
	end

	if vedmetadata ~= false then
		for k,v in pairs(searchnotes) do
			if k <= showresults and 32*k+16+searchscroll+30 >= 48 and 32*k+16+searchscroll <= love.graphics.getHeight() then
				love.graphics.setScissor(8+284+4+284+4, math.max(48, 32*k+16+searchscroll), 284, 30)
				hoverrectangle(128,128,128,128, 8+284+4+284+4, 32*k+16+searchscroll, 284, 30)
				highlightresult(v.name, previous_search, 12+284+4+284+8, 32*k+16+searchscroll+5)
				if v.foundline ~= 0 then
					local namewidth = font_level:getWidth(v.name)
					font_ui:print("\u{200e} - " .. L.LINE .. v.foundline, 12+284+4+284+4+namewidth, 32*k+16+searchscroll+5)
					highlightresult(v.foundlinecontent, previous_search, 12+284+4+284+4, 32*k+16+searchscroll+8+5)
				end

				if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8+284+4+284+4, 32*k+16+searchscroll, 284, 30) then
					newinputsys.close("search")
					tostate(15, nil, {vedmetadata.notes, true})
				end
			end
		end
	end

	love.graphics.setScissor()

	local newfraction = scrollbar(
		love.graphics.getWidth()-24, 48, love.graphics.getHeight()-56,
		(longestsearchlist*32)-2,
		(-searchscroll)/((longestsearchlist*32)-2-(love.graphics.getHeight()-56))
	)

	if newfraction ~= nil then
		searchscroll = -(newfraction*((longestsearchlist*32)-2-(love.graphics.getHeight()-56)))
	end
end
