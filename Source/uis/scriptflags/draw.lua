-- scriptflags/draw

return function()
	-- We have 4 columns
	local btn_width = (love.graphics.getWidth()-8)/4
	for flcol = 0, 3 do
		local pos_x = 8 + flcol*btn_width
		for flk = 0, 24 do
			local flag = flk + (flcol*25) + flags_page*100
			if flag >= flags_page*100 + 100 or flag >= limit.flags then
				break
			end
			local ax, ay, w, h = pos_x, 24+flk*16, btn_width - 8, 16

			if nodialog and mouseon(ax, ay, w, h) then
				love.graphics.setColor(128,128,128,255)

				if not mousepressed and nodialog and mousereleased_flag then
					flgnum = flag -- not local, is used in dialog, TODO make it just passed to the dialog in a way

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
						local n_usages = return_used_flags(nil, nil, flgnum, usages)

						dialog.create(
							langkeys(L.NAMEFORFLAG, {flgnum}) .. "\n\n\n\n"
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

			local text = fixdig(flag, flags_digits, " ")
			font_ui:printf(text, ax+2, ay+4, w-4, font_ui:align_start())
			if vedmetadata ~= false then
				if anythingbutnil(vedmetadata.flaglabel[flag]) == "" then
					font_ui:printf(L.FLAGNONAME, ax+2, ay+4, w-4, font_ui:align_end())
				else
					font_level:printf(vedmetadata.flaglabel[flag], ax+2, ay+4, w-4, font_ui:align_end())
				end
			end
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

	font_ui:print(L.FLAGS, 8, 8)
	font_ui:printf(flags_usedtext, 8, 8, love.graphics.getWidth()-16, "right")
	font_ui:print(flags_outofrangeflagstext, 8, 440)

	if nodialog and mousepressed_flag_x ~= -1 and mousepressed_flag_y ~= -1 and (mousepressed_flag_x ~= love.mouse.getX() or mousepressed_flag_y ~= love.mouse.getY()) then
		local t = mousepressed_flag_num .. " - " .. (anythingbutnil(mousepressed_flag_name) ~= "" and anythingbutnil(mousepressed_flag_name) or L.FLAGNONAME)
		love.graphics.setColor(128,128,128,128)
		love.graphics.rectangle(
			"fill",
			love.mouse.getX() + 8, love.mouse.getY(),
			font_level:getWidth(t), font_level:getHeight()
		)
		love.graphics.setColor(255,255,255,255)
		font_level:print(t, love.mouse.getX() + 8, love.mouse.getY())
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
			font_8x8:printf(page*100 .. "-" .. page*100+99, btn_x+1, btn_y+4, 64, "center")
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
