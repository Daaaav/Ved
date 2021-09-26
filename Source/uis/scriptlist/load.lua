-- scriptlist/load

return function()
	if oldstate ~= 3 or scriptlistscroll == nil then
		scriptlistscroll = 0
		scriptdisplay_used = true
		scriptdisplay_unused = true
	end
	usedscripts, n_usedscripts = find_used_scripts()
end
