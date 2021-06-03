-- language/keypressed

return function(key)
	if key == "escape" or key == "return" then
		exitlanguageoptions()
	elseif key == "up" or key == "down" then
		local curlang
		for k,v in pairs(all_languages) do
			if v == s.lang then
				curlang = k
				break
			end
		end
		if curlang == nil then
			changelanguage("en")
		else
			local newlang
			if key == "up" then
				newlang = curlang - 1
				if newlang < 1 then
					newlang = #all_languages
				end
			elseif key == "down" then
				newlang = curlang + 1
				if newlang > #all_languages then
					newlang = 1
				end
			end
			changelanguage(all_languages[newlang])
		end
	end
end
