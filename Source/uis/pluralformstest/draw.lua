-- pluralformstest/draw

return function()
	int_control(20, 20, "val", 0, 9999, nil, plural_test)
	font_ui:print(langkeys(L_PLU.NUMUNSUPPORTEDPLUGINS, {plural_test.val}), 20, 70)
	font_ui:print(langkeys(L_PLU.ROOMINVALIDPROPERTIES, {0, 0, plural_test.val}, 3), 20, 100)

	if nodialog and love.mouse.isDown("l") then
		-- Shrug
		mousepressed = true
	end
end
