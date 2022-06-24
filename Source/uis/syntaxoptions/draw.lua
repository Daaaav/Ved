-- syntaxoptions/draw

return function()
	ved_print(L.SYNTAXCOLORSETTINGSTITLE, 8, 8+4)

	color_setting(L.SYNTAXCOLOR_COMMAND,     1, s.syntaxcolor_command    )
	color_setting(L.SYNTAXCOLOR_GENERIC,     2, s.syntaxcolor_generic    )
	color_setting(L.SYNTAXCOLOR_SEPARATOR,   3, s.syntaxcolor_separator  )
	color_setting(L.SYNTAXCOLOR_NUMBER,      4, s.syntaxcolor_number     )
	color_setting(L.SYNTAXCOLOR_TEXTBOX,     5, s.syntaxcolor_textbox    )
	color_setting(L.SYNTAXCOLOR_ERRORTEXT,   6, s.syntaxcolor_errortext  )
	color_setting(L.SYNTAXCOLOR_WRONGLANG,   7, s.syntaxcolor_wronglang  )
	color_setting(L.SYNTAXCOLOR_FLAGNAME,    8, s.syntaxcolor_flagname   )
	color_setting(L.SYNTAXCOLOR_NEWFLAGNAME, 9, s.syntaxcolor_newflagname)
	color_setting(L.SYNTAXCOLOR_COMMENT,    10, s.syntaxcolor_comment    )

	checkbox(s.colored_textboxes, 8, 8+(24*12), "colored_textboxes", L.COLORED_TEXTBOXES,
		function(key, newvalue)
			s[key] = newvalue
		end
	)

	rbutton({L.BTN_OK, "b"}, 0)
	rbutton(L.RESETCOLORS, 2)

	if nodialog and not mousepressed and love.mouse.isDown("l") then
		if onrbutton(0) then
			-- Save
			exitsyntaxcoloroptions()
		elseif onrbutton(2) then
			-- Reset colors
			for k,v in pairs(s) do
				if k:sub(1,12) == "syntaxcolor_" then
					s[k] = table.copy(configs[k].default)
				end
			end
			editingcolor = nil
		end

		mousepressed = true
	end

	if editingcolor ~= nil then
		for colb = 0, 255 do
			love.graphics.setColor(colb,0,0)
			love.graphics.rectangle("fill", love.graphics.getWidth()-160, love.graphics.getHeight()-(colb+1), 50, 1)
			love.graphics.setColor(0,colb,0)
			love.graphics.rectangle("fill", love.graphics.getWidth()-105, love.graphics.getHeight()-(colb+1), 50, 1)
			love.graphics.setColor(0,0,colb)
			love.graphics.rectangle("fill", love.graphics.getWidth()-50, love.graphics.getHeight()-(colb+1), 50, 1)
		end

		-- A colored block at the top
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill", love.graphics.getWidth()-160, love.graphics.getHeight()-263-20, 160, 16)
		love.graphics.setColor(editingcolor[1],editingcolor[2],editingcolor[3])
		love.graphics.rectangle("fill", love.graphics.getWidth()-159, love.graphics.getHeight()-263-19, 158, 14)

		-- The numbers
		love.graphics.setColor(255,255,255)
		ved_printf(editingcolor[1], love.graphics.getWidth()-160, love.graphics.getHeight()-265, 50, "center")
		ved_printf(editingcolor[2], love.graphics.getWidth()-105, love.graphics.getHeight()-265, 50, "center")
		ved_printf(editingcolor[3], love.graphics.getWidth()-50, love.graphics.getHeight()-265, 50, "center")
		ved_printf(
			string.format("#%02x%02x%02x", unpack(editingcolor)),
			love.graphics.getWidth()-160, love.graphics.getHeight()-295,
			160, "center"
		)

		-- The arrows
		love.graphics.draw(image.colorsel, love.graphics.getWidth()-164, love.graphics.getHeight()-editingcolor[1]-4)
		love.graphics.draw(image.colorsel, love.graphics.getWidth()-109, love.graphics.getHeight()-editingcolor[2]-4)
		love.graphics.draw(image.colorsel, love.graphics.getWidth()-54, love.graphics.getHeight()-editingcolor[3]-4)

		-- Are we clicking?
		if love.mouse.isDown("l") then
			if mouseon(love.graphics.getWidth()-160, love.graphics.getHeight()-256, 50, 256) then
				editingcolor[1] = love.graphics.getHeight()-love.mouse.getY() - 1
			elseif mouseon(love.graphics.getWidth()-105, love.graphics.getHeight()-256, 50, 256) then
				editingcolor[2] = love.graphics.getHeight()-love.mouse.getY() - 1
			elseif mouseon(love.graphics.getWidth()-50, love.graphics.getHeight()-256, 50, 256) then
				editingcolor[3] = love.graphics.getHeight()-love.mouse.getY() - 1
			end
		end
	end
end
