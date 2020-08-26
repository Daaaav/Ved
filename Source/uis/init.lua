local ui = {name = "init"}

function ui.load()
	-- Not called for this state on startup!
end

ui.elements = {
}

function ui.draw()
end

function ui.update(dt)
	if settings_ok then
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

function ui.keypressed(key)
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
