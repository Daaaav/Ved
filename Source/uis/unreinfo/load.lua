-- unreinfo/load

return function()
	undostacktext = ""
	redostacktext = ""

	for k,v in pairs(undobuffer) do
		undostacktext = undostacktext .. v.undotype

		if v.undotype == "tiles" then
			undostacktext = undostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
		end

		undostacktext = undostacktext .. "\n"
	end

	for k,v in pairs(redobuffer) do
		redostacktext = redostacktext .. v.undotype

		if v.undotype == "tiles" then
			redostacktext = redostacktext .. " (" .. L.ROOM .. " " .. v.rx .. "," .. v.ry .. ")"
		end

		redostacktext = redostacktext .. "\n"
	end
end
