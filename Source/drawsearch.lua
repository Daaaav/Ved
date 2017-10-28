function drawsearch()
	love.graphics.print(L.SEARCHFOR .. input .. __, 12, 12) -- Temporary location and temporary untextbox

	rbutton({L.RETURN, "b"}, 0)

	if nodialog and not mousepressed and love.mouse.isDown("l") and onrbutton(0) then
		tostate(1, true)
		mousepressed = true
	end

	for k,v in pairs(searchscripts) do
		if k <= showresults then
			love.graphics.setScissor(8, 32*k, 288, 30)
			hoverrectangle(128,128,128,128, 8, 32*k, 288, 30)
			--love.graphics.print(v.name, 12, 32*k+7)
			highlightresult(v.name, searchedfor, 12, 32*k+7)
			if v.foundline ~= 0 then
				--love.graphics.print(v.foundline .. ": " .. v.foundlinecontent, 12, 32*k+8+7)
				love.graphics.print(", " .. L.LINE .. v.foundline, 12+v.name:len()*8, 32*k+7)
				highlightresult(v.foundlinecontent, searchedfor, 12, 32*k+8+7)
			end

			if nodialog and love.mouse.isDown("l") and mouseon(8, 32*k, 288, 30) then
				--##SCRIPT##  DONE
				scriptineditor(v.name)
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
		if k <= showresults then
			love.graphics.setScissor(8+288+8, 32*k, 288, 30)
			hoverrectangle(128,128,128,128, 8+288+8, 32*k, 288, 30)
			if s.coords0 then
				love.graphics.print("(" .. (v.x-1) .. "," .. (v.y-1) .. ")", 12+288+8, 32*k+7)
			else
				love.graphics.print("(" .. v.x .. "," .. v.y .. ")", 12+288+8, 32*k+7)
			end
			highlightresult(v.name, searchedfor, 12+288+8, 32*k+8+7)

			if nodialog and love.mouse.isDown("l") and mouseon(8+288+8, 32*k, 288, 30) then
				gotoroom(v.x - 1, v.y - 1)

				tostate(1, true)

				mousepressed = true
				nodialog = false
			end
		end
	end

	if vedmetadata ~= false then
		for k,v in pairs(searchnotes) do
			if k <= showresults then
				love.graphics.setScissor(8+288+8+288+8, 32*k, 288, 30)
				hoverrectangle(128,128,128,128, 8+288+8+288+8, 32*k, 288, 30)
				--love.graphics.print(v.name, 12, 32*k+7)
				highlightresult(v.name, searchedfor, 12+288+8+288+8, 32*k+7)
				if v.foundline ~= 0 then
					--love.graphics.print(v.foundline .. ": " .. v.foundlinecontent, 12, 32*k+8+7)
					love.graphics.print(", " .. L.LINE .. v.foundline, 12+288+8+288+8+v.name:len()*8, 32*k+7)
					highlightresult(v.foundlinecontent, searchedfor, 12+288+8+288+8, 32*k+8+7)
				end

				if nodialog and love.mouse.isDown("l") and mouseon(8+288+8+288+8, 32*k, 288, 30) then
					--[[
					scriptname = v.name
					scriptlines = table.copy(scripts[v.name])
					processflaglabels()
					--bumpscript(rvnum) do bump later though
					tostate(3)

					if v.foundline ~= 0 then
						editingline = v.foundline
					end

					mousepressed = true
					nodialog = false
					]]
					tostate(15, nil, {vedmetadata.notes, true})

				end
			end
		end
	end

	love.graphics.setScissor()

	--love.graphics.rectangle("fill", 8, 32, 288, 32)
	--love.graphics.rectangle("fill", 8+288+8, 32, 288, 32)
	--love.graphics.rectangle("fill", 8+288+8+288+8, 32, 288, 32)
end
