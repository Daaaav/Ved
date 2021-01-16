function love.focus(f)
	if f then
		hook("love_focus_gained")
	else
		hook("love_focus_lost")
	end
	hook("love_focus", {f})
end
