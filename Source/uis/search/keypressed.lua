-- search/keypressed

return function(key)
	if table.contains({"return", "kpenter"}, key) then
		searchscripts, searchrooms, searchnotes = searchtext(inputs.search)
		previous_search = inputs.search
	end
end
