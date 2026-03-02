-- search/keypressed

return function(key)
	if table.contains({"return", "kpenter"}, key) then
		do_search()
	end
end
