-- autoupdate/update

return function(dt)
	if autoupdate_started then
		local chanmessage = autoupdate_outchannel:pop()

		if chanmessage ~= nil and type(chanmessage) == "table" then
			if chanmessage.cmd == "quit" then
				love.event.quit()
			elseif chanmessage.cmd == "error" then
				no_more_quit_dialog = false
				autoupdate_started = false
				dialog.create(chanmessage.msg, nil, nil, L.AUTOUPDATE_ABORTED)
			end
		end
	end
end
