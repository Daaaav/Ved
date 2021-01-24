-- language/load

return function()
	alllanguages = getalllanguages()
	widestlang = 0
	for k,v in pairs(alllanguages) do
		local langname
		if langinfo[v] ~= nil then
			langname = langinfo[v].name
		else
			langname = v
		end
		local w = font8:getWidth(langname)
		if w > widestlang then
			widestlang = w
		end
	end
end
