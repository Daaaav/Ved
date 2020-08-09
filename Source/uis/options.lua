local ui = {name = "options"}

function ui.load()
	firstvvvvvvfolder = s.customvvvvvvdir
end

ui.elements = {
	RightBar(
		{
			LabelButton(L.BTN_OK, exitvedoptions, "b", hotkey("escape")),
			LabelButtonSpacer(),
			LabelButton(L.CUSTOMVVVVVVDIRECTORY,
				function()
					if vvvvvvfolder_expected == nil then
						dialog.create(
							langkeys(L.OSNOTRECOGNIZED,
								{anythingbutnil(love.system.getOS()), love.filesystem.getSaveDirectory()}
							)
						)
					else
						local explanation, buttons
						if s.customvvvvvvdir == "" then
							explanation = L.CUSTOMVVVVVVDIRECTORY_NOTSET
							buttons = {L.CHANGEVERB, DB.CANCEL}
						else
							explanation = langkeys(L.CUSTOMVVVVVVDIRECTORY_SET, {s.customvvvvvvdir})
							buttons = {L.CHANGEVERB, L.RESET, DB.CANCEL}
						end
						explanation = explanation .. langkeys(L.CUSTOMVVVVVVDIRECTORYEXPL, {vvvvvvfolder_expected})
						dialog.create(
							explanation,
							buttons,
							dialog.callback.customvvvvvvdir1
						)
					end
				end
			),
			LabelButton(L.LANGUAGE,
				function()
					olderstate = oldstate
					tostate(33)
				end
			),
			LabelButton(L.SYNTAXCOLORS,
				function()
					olderstate = oldstate
					tostate(25)
				end
			),
			LabelButton(L.DISPLAYSETTINGS,
				function()
					olderstate = oldstate
					tostate(27)
				end
			),
			LabelButtonSpacer(),
			LabelButton(L.SENDFEEDBACK,
				function()
					love.system.openURL("https://tolp.nl/ved/feedback")
				end
			),
		},
		{
		}
	)
}

function ui.draw()
	-- Options screen
	--love.graphics.draw(checkon, love.graphics.getWidth()-98, 50, 0, 2)
	--love.graphics.draw(checkoff, love.graphics.getWidth()-98, 70, 0, 2)
	ved_print(L.VEDOPTIONS, 8, 8+4)

	for k,v in pairs({
			"dialoganimations",
			"flipsubtoolscroll",
			"adjacentroomlines",
			"neveraskbeforequit",
			"coords0",
			"showfps",
			false,
			"checkforupdates",
			"pausedrawunfocused",
			"enableoverwritebackups",
			false,
			"autosavecrashlogs",
			"loadallmetadata",
			"usefontpng",
			"opaqueroomnamebackground"
		}
	) do
		if v then
			local label = L[v:upper()]
			if v == "usefontpng" then
				label = L.USEFONTPNG .. (not love_version_meets(10) and langkeys(L.REQUIRESHIGHERLOVE, {"0.10.0"}) or "")
			end

			checkbox(s[v], 8, 8+(24*k), v, label,
				function(key, newvalue)
					s[key] = newvalue
					if key == "showfps" then
						savedwindowtitle = ""
					elseif key == "usefontpng" and love_version_meets(10) then
						loadfonts()
						unloadlanguage()
						loadlanguage()
					end
				end
			)
		end
	end

	ved_print(L.FPSLIMIT, 8, 8+(24*7)+4)
	int_control(16+font8:getWidth(L.FPSLIMIT), 8+(24*7), "fpslimit_ix", 1, 4, nil, nil,
		function(value)
			local ret = ({"30", "60", "120", "---"})[value]
			if ret == nil then
				return "??"
			end
			return ret
		end, 24
	)

	if s.enableoverwritebackups then
		ved_print(L.AMOUNTOVERWRITEBACKUPS, 8, 8+(24*11)+4)
		int_control(16+font8:getWidth(L.AMOUNTOVERWRITEBACKUPS), 8+(24*11), "amountoverwritebackups", 0, 999)
	end

	ved_print(
		ERR_VEDVERSION .. " " .. ved_ver_human() .. "\n"
		.. ERR_LOVEVERSION .. " " .. love._version_major .. "." .. love._version_minor .. "." .. love._version_revision,
		8, love.graphics.getHeight()-23
	)
end

function ui.update(dt)
end

function ui.keypressed(key)
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
