-- scripteditor/load

return function()
	-- Scripts can be fully contentless- without even one line.
	if #scriptlines == 0 then
		table.insert(scriptlines, "")
	end

	editingline = 1 --#scriptlines
	textlinestogo = 0
	startinput()
	scriptscroll = 0
	input = scriptlines[editingline]
	syntaxhlon = true

	-- Little bit of caching
	rememberflagnumber = -1

	-- Make sure we don't keep checking for script warnings when we can do it once.
	scrwarncache_script = nil
	scrwarncache_warn_noloadscript = false
	scrwarncache_warn_boxed = false
	scrwarncache_warn_name = false

	if oldstate ~= 3 then
		scripthistorystack = {}
	end
	scriptfromsearch = false
end
