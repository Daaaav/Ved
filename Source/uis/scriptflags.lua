local ui = {name = "scriptflags"}

function ui.load()
	flags_digits = tostring(limit.flags-1):len()
	flags_page = 0

	loadflagslist()
end

ui.elements = {
	
}

function ui.draw()
	-- Columns 1 and 2
	for flcol = 8, love.graphics.getWidth()/2 + 8, love.graphics.getWidth()/2 do -- dit was misschien niet handig om te doen
		for flk = 0, 49 do
			local flag = flk + (flcol == 8 and 0 or 50) + flags_page*100
			if flag >= limit.flags then
				break
			end
			local ax, ay, w, h = flcol-2, 24+flk*8, love.graphics.getWidth()/2 - 16, 8

			if nodialog and mouseon(ax, ay, w, h) then
				love.graphics.setColor(128,128,128,255)

				if not mousepressed and nodialog and mousereleased_flag then
					flgnum = flag -- not local, is used in dialog

					if mousepressed_flag_num ~= -1 and flgnum ~= mousepressed_flag_num then
						cons("We dropped flag " .. mousepressed_flag_num .. " onto flag " .. flgnum)
						swapflags(flgnum, mousepressed_flag_num)
						dirty()
						mousepressed_flag_x = -1
						mousepressed_flag_y = -1
						mousepressed_flag_num = -1
						mousepressed_flag_name = ""
						-- We have to redraw the flags screen somehow
						loadflagslist()
					else
						mousepressed_flag_x = -1
						mousepressed_flag_y = -1
						mousepressed_flag_num = -1
						mousepressed_flag_name = ""

						local field_default = ""
						if vedmetadata ~= false then
							field_default = vedmetadata.flaglabel[flgnum]
						end

						-- We also want to know where this was used.
						local usages = {}
						local n_usages = returnusedflags(nil, nil, flgnum, usages)

						dialog.create(
							langkeys(L.NAMEFORFLAG, {flgnum}) .. "\n\n\n"
							.. langkeys(L_PLU.FLAGUSAGES, {n_usages, table.concat(usages, ", ")}),
							DBS.OKCANCEL,
							dialog.callback.changeflagname,
							nil,
							dialog.form.simplename_make(field_default),
							dialog.callback.changeflagname_validate
						)
					end

					mousereleased_flag = false
				elseif not mousepressed and nodialog and love.mouse.isDown("l") then
					mousepressed = true
					mousepressed_flag = true
					mousepressed_flag_x = love.mouse.getX()
					mousepressed_flag_y = love.mouse.getY()
					mousepressed_flag_num = flag
					if vedmetadata then
						mousepressed_flag_name = vedmetadata.flaglabel[mousepressed_flag_num]
					end
				end
			else
				love.graphics.setColor(64,64,64,128)

				local flgnum2 = flag
				local used = usedflags[flgnum2]
				if used then
					love.graphics.setColor(128,128,128,128)
				end
			end

			love.graphics.rectangle("fill", ax, ay, w, h)
			love.graphics.setColor(255,255,255,255)

			local text = fixdig(flag, flags_digits, " ") .. " - " .. (usedflags[flag] and L.FLAGUSED or L.FLAGNOTUSED)
			if vedmetadata ~= false then
				text = text .. " - " .. (
					vedmetadata.flaglabel[flag] ~= ""
					and anythingbutnil(vedmetadata.flaglabel[flag])
					or L.FLAGNONAME
				)
			end
			ved_print(text, ax+2, ay)
		end
	end

	-- Catch anyone dropping flags into the void and then moving back to a flag
	if nodialog and mousereleased_flag and not (mouseon(8-2, 24, love.graphics.getWidth()/2 - 16, 8*50) or mouseon(love.graphics.getWidth()/2 + 8-2, 24, love.graphics.getWidth()/2 - 16, 8*50)) then
		mousereleased_flag = false
		mousepressed_flag_x = -1
		mousepressed_flag_y = -1
		mousepressed_flag_num = -1
		mousepressed_flag_name = ""
	end

	love.graphics.setColor(255,255,255,255)

	ved_print(L.FLAGS, 8, 8)
	ved_print(flags_outofrangeflagstext, 8, 432)

	if nodialog and mousepressed_flag_x ~= -1 and mousepressed_flag_y ~= -1 and (mousepressed_flag_x ~= love.mouse.getX() or mousepressed_flag_y ~= love.mouse.getY()) then
		local t = mousepressed_flag_num .. " - " .. (anythingbutnil(mousepressed_flag_name) ~= "" and anythingbutnil(mousepressed_flag_name) or L.FLAGNONAME)
		love.graphics.setColor(128,128,128,128)
		love.graphics.rectangle("fill", love.mouse.getX() + 8, love.mouse.getY(), 8*#t, 8)
		love.graphics.setColor(255,255,255,255)
		ved_print(t, love.mouse.getX() + 8, love.mouse.getY())
	end

	if limit.flags > 100 then
		for page = 0, (limit.flags-1)/100 do
			local btn_x, btn_y = 8+72*page, love.graphics.getHeight()-24
			if flags_page == page then
				love.graphics.setColor(32,32,32)
				love.graphics.rectangle("fill", btn_x, btn_y, 64, 16)
				love.graphics.setColor(64,64,64)
			else
				hoverrectangle(128,128,128,128, btn_x, btn_y, 64, 16)
			end
			ved_printf(page*100 .. "-" .. page*100+99, btn_x+1, btn_y+4, 64, "center")
			love.graphics.setColor(255,255,255,255)

			if nodialog and love.mouse.isDown("l") and mouseon(btn_x, btn_y, 64, 16) then
				flags_page = page
			end
		end
	end

	rbutton({L.RETURN, "b"}, 0, nil, true)

	if nodialog and love.mouse.isDown("l") then
		if onrbutton(0, nil, true) then
			-- Return
			tostate(oldstate, true) -- keep the scrollbar "farness"
			mousepressed = true
		end
	end
end

function ui.update(dt)
end

function ui.keypressed(key)
	if key == "escape" then
		tostate(oldstate, true)
		nodialog = false
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
