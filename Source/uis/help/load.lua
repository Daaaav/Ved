-- help/load

return function(mode)
	helplistscroll = 0
	helparticle = 1
	helparticlescroll = 0
	helpeditingline = 0
	helprefreshable = false
	helpallowfileprot = false
	onlefthelpbuttons = false
	part1parts_cache = {}
	cachedlink = nil
	matching_url = nil
	matching_article = nil
	matching_anchor = nil
	matching_article_num = nil
	matching_anchor_line = nil

	-- Are we gonna use this for Ved help, for level notes, something else?
	if mode == nil then
		-- Just the Ved help
		helppages = LH
		helpeditable = false
		helparticlecontent = explode("\n", helppages[helparticle].cont)
	elseif mode == "plugins" then
		--helppages = {}
		loadpluginpages()
		helpeditable = false
		helpallowfileprot = true
		helparticlecontent = explode("\n", helppages[helparticle].cont)
	else
		-- Level notes (or something else because extradata is an array here!)
		helppages = mode[1]
		helpeditable = mode[2]
		helprefreshable = mode[3]
		if helppages[1] ~= nil then
			helparticlecontent = explode("\n", helppages[helparticle].cont)
		end
	end
end
