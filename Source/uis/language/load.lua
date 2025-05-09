-- language/load

return function()
	all_languages = get_all_languages()
	widestlang = 0
	for k,v in pairs(all_languages) do
		local langname, font
		if langinfo[v] ~= nil then
			langname = langinfo[v].name
			font = fonts_main[langinfo[v].font]
		else
			langname = v
		end
		if font == nil then
			font = font_8x8
		end
		local w = font:getWidth(langname)
		if w > widestlang then
			widestlang = w
		end
	end
end
