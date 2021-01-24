-- search/load

return function()
	if not resume_search then
		previous_search = ""
		searchscripts = {}; searchrooms = {}; searchnotes = {}
		showresults = math.huge
		searchscroll = 0
		longestsearchlist = 0
	else
		resume_search = false
	end
	newinputsys.create(INPUT.ONELINE, "search", previous_search)
end
