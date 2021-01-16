function love.quit()
	if not s.neveraskbeforequit and has_unsaved_changes() then
		if love.window.requestAttention ~= nil and not window_active() then
			love.window.requestAttention(true)
		end

		if dialog.is_open() and dialogs[#dialogs].identifier == "quit" then
			-- There's already a quit dialog right in front (only top layer though, for convenience)
			return true
		end

		dialog.create(
			L.SUREQUITNEW, DBS.SAVEDISCARDCANCEL,
			dialog.callback.surequit, nil, nil,
			dialog.callback.noclose_on.save, "quit"
		)

		return true
	end
end
