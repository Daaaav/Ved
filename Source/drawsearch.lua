function drawsearch()
	love.graphics.print(L.SEARCHFOR .. input .. __, 12, 12) -- Temporary location and temporary untextbox

	rbutton({L.RETURN, "b"}, 0)

	if nodialog and not mousepressed and love.mouse.isDown("l") and onrbutton(0) then
		stopinput()
		tostate(1, true)
		mousepressed = true
	end

	love.graphics.printf(langkeys(L.SEARCHRESULTS_SCRIPTS, {#searchscripts}), 8, 32+4+2, 284, "center")
	love.graphics.printf(langkeys(L.SEARCHRESULTS_ROOMS, {#searchrooms}), 8+284+4, 32+4+2, 284, "center")
	love.graphics.printf(langkeys(L.SEARCHRESULTS_NOTES, {#searchnotes}), 8+284+4+284+4, 32+4+2, 284, "center")

	for k,v in pairs(searchscripts) do
		if k <= showresults and 32*k+16+searchscroll+30 >= 48 and 32*k+16+searchscroll <= love.graphics.getHeight() then
			love.graphics.setScissor(8, math.max(48, 32*k+16+searchscroll), 284, 30)
			hoverrectangle(128,128,128,128, 8, 32*k+16+searchscroll, 284, 30)
			--love.graphics.print(v.name, 12, 32*k+16+searchscroll+7)
			highlightresult(v.name, searchedfor, 12, 32*k+16+searchscroll+7)
			if v.foundline ~= 0 then
				--love.graphics.print(v.foundline .. ": " .. v.foundlinecontent, 12, 32*k+16+searchscroll+8+7)
				love.graphics.print(", " .. L.LINE .. v.foundline, 12+v.name:len()*8, 32*k+16+searchscroll+7)
				highlightresult(v.foundlinecontent, searchedfor, 12, 32*k+16+searchscroll+8+7)
			end

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8, 32*k+16+searchscroll, 284, 30) then
				stopinput()
				--##SCRIPT##  DONE
				scriptineditor(v.name)
				scriptfromsearch = true
				--scriptname = v.name
				--scriptlines = table.copy(scripts[v.name])
				--processflaglabels()
				--bumpscript(rvnum) do bump later though
				--tostate(3)

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
				love.graphics.print("(" .. (v.x-1) .. "," .. (v.y-1) .. ")", 12+284+4, 32*k+16+searchscroll+7)
			else
				love.graphics.print("(" .. v.x .. "," .. v.y .. ")", 12+284+4, 32*k+16+searchscroll+7)
			end
			highlightresult(v.name, searchedfor, 12+284+4, 32*k+16+searchscroll+8+7)

			if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8+284+4, 32*k+16+searchscroll, 284, 30) then
				stopinput()
				gotoroom(v.x - 1, v.y - 1)

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
				--love.graphics.print(v.name, 12, 32*k+16+searchscroll+7)
				highlightresult(v.name, searchedfor, 12+284+4+284+8, 32*k+16+searchscroll+7)
				if v.foundline ~= 0 then
					--love.graphics.print(v.foundline .. ": " .. v.foundlinecontent, 12, 32*k+16+searchscroll+8+7)
					love.graphics.print(", " .. L.LINE .. v.foundline, 12+284+4+284+4+v.name:len()*8, 32*k+16+searchscroll+7)
					highlightresult(v.foundlinecontent, searchedfor, 12+284+4+284+4, 32*k+16+searchscroll+8+7)
				end

				if nodialog and not mousepressed and love.mouse.isDown("l") and mouseon(8+284+4+284+4, 32*k+16+searchscroll, 284, 30) then
					stopinput()
					tostate(15, nil, {vedmetadata.notes, true})

				end
			end
		end
	end

	love.graphics.setScissor()

	local newperonetage = scrollbar(
		love.graphics.getWidth()-24, 48, love.graphics.getHeight()-56,
		(longestsearchlist*32)-2,
		(-searchscroll)/((longestsearchlist*32)-2-(love.graphics.getHeight()-56))
	)

	if newperonetage ~= nil then
		searchscroll = -(newperonetage*((longestsearchlist*32)-2-(love.graphics.getHeight()-56)))
	end
end
