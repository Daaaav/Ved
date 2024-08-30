function autoupdate_start()
	if has_unsaved_changes() then
		dialog.create(
			L.SUREAUTOUPDATE, DBS.SAVEDISCARDCANCEL,
			dialog.callback.sureautoupdate, nil, nil,
			dialog.callback.noclose_on_make(DB.SAVE)
		)
		return
	end

	autoupdate_start_nowayback()
end

function autoupdate_start_nowayback()
	autoupdate_started = true

	local autoupdate_thread = love.thread.newThread("autoupdate_thread.lua")
	autoupdate_thread:start(L, "url", "hash", "length")
end
