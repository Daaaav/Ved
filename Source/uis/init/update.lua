-- init/update

return function(dt)
	if settings_ok and lib_load_errmsg == nil then
		if not s.langchosen or opt_forcelanguagescreen then
			opt_forcelanguagescreen = false
			tostate(33)
		elseif opt_loadlevel ~= nil then
			if opt_loadlevel:sub(1, levelsfolder:len()) == levelsfolder then
				opt_loadlevel = opt_loadlevel:sub(levelsfolder:len()+2, -1)
			end
			state6load(opt_loadlevel:sub(1,-8))
			opt_loadlevel = nil -- If the level was invalid, we will still be in this state, and be redirected to state 6
		elseif opt_newlevel then
			triggernewlevel()
			opt_newlevel = false
		else
			tostate(6)
		end
	end
end
