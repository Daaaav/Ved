-- options/draw

return function()
	font_ui:print(L.VEDOPTIONS, 8, 8+4)

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
			"opaqueroomnamebackground",
			false,
			"bumpscriptsbydefault",
		}
	) do
		if v then
			local label = L[v:upper()]

			checkbox(s[v], 8, 8+(22*k), v, label,
				function(key, newvalue)
					s[key] = newvalue
					if key == "showfps" then
						savedwindowtitle = ""
					end
				end
			)
		end
	end

	font_ui:print(L.FPSLIMIT, 8, 8+(22*7)+4)
	int_control(16+font_ui:getWidth(L.FPSLIMIT), 8+(22*7), "fpslimit_ix", 1, 4, nil, nil,
		function(value)
			local ret = ({"30", "60", "120", "---"})[value]
			if ret == nil then
				return "??"
			end
			return ret
		end, 24
	)

	if s.enableoverwritebackups then
		font_ui:print(L.AMOUNTOVERWRITEBACKUPS, 8, 8+(22*11)+4)
		int_control(16+font_ui:getWidth(L.AMOUNTOVERWRITEBACKUPS), 8+(22*11), "amountoverwritebackups", 0, 999)
	end

	font_ui:print(L.MOUSESCROLLINGSPEED, 8, 8+(22*15)+4)
	int_control(16+font_ui:getWidth(L.MOUSESCROLLINGSPEED), 8+(22*15), "mousescrollingspeed", -999, 999)

	font_ui:print(
		ERR_VEDVERSION .. " " .. ved_ver_human() .. "\n"
		.. ERR_LOVEVERSION .. " " .. love_ver_human(),
		8, love.graphics.getHeight()-23
	)
end
