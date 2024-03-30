updatecheck = {
	check_running = false,
	check_channel = love.thread.getChannel("version")
}

function updatecheck.start_check()
	if updatecheck.check_thread ~= nil then
		if updatecheck.check_thread:isRunning() then
			-- Be patient, it'll terminate by itself!
			return
		end
	else
		updatecheck.check_thread = love.thread.newThread("updatecheckthread.lua")
	end

	updatecheck.check_running = true
	updatecheck.check_error = false
	updatecheck.latest_version = ""
	updatecheck.notes = {}
	updatecheck.notes_available = false
	updatecheck.notes_refreshable = false
	updatecheck.scrolling_text = nil
	updatecheck.scrolling_text_pos = 0

	-- Determine the distribution method
	if love.filesystem.isFused() then
		local opsys = love.system.getOS()
		if opsys == "Windows" then
			updatecheck.dist_method = "fused_win"
		elseif opsys == "OS X" then
			updatecheck.dist_method = "fused_mac"
		elseif opsys == "Linux" then
			updatecheck.dist_method = "fused_lin"
		else
			updatecheck.dist_method = "fused_unknown"
		end
	elseif love.filesystem.getSource():sub(-5,-1) == ".love" then
		updatecheck.dist_method = "love"
	else
		updatecheck.dist_method = "rawfiles"
	end

	updatecheck.check_thread:start(checkver, commitversion, updatecheck.dist_method)
end

function updatecheck.await_response()
	if not updatecheck.check_running then
		return
	end

	local response_text = updatecheck.check_channel:peek()

	if response_text == nil then
		return
	end

	-- We got something!
	updatecheck.check_running = false

	if response_text == "connecterror" or response_text == "error" then
		updatecheck.check_error = true
		return
	end

	local current_article = 0
	local current_article_name
	local current_article_contents
	local article_lines = explode("\n", response_text)
	for k, v in pairs(article_lines) do
		if v:sub(1,3) == "!>>" then
			current_article_name = v:sub(4,-1)
			if (current_article_name:sub(1,1) ~= "_" or allowdebug) then
				if current_article == 0 then
					updatecheck.notes_available = true
				else
					-- Save the previous article
					updatecheck.notes[current_article].cont = table.concat(current_article_contents, "\n")
				end
				current_article_contents = {}
				current_article = current_article + 1
				updatecheck.notes[current_article] = {subj = current_article_name, imgs = {}, cont = nil}
			end
		else
			if current_article_name == "_VERSION" then
				updatecheck.latest_version = updatecheck.latest_version .. v
			elseif current_article_name == "_SHOWREFRESH" and v == "1" then
				updatecheck.notes_refreshable = true
			elseif current_article_name == "_SCROLLINGTEXT" then
				updatecheck.scrolling_text = unxmlspecialchars(v)
			end
			if current_article ~= nil and (current_article_name:sub(1,1) ~= "_" or allowdebug) then
				table.insert(current_article_contents, v)
			end
		end
	end
	if current_article ~= 0 then
		-- Save the last article
		updatecheck.notes[current_article].cont = table.concat(current_article_contents, "\n")
	end
end

function updatecheck.get_status()
	if not s.pcheckforupdates then
		return L.VERSIONDISABLED
	elseif updatecheck.check_running then
		return L.VERSIONCHECKING
	elseif updatecheck.check_error then
		return L.VERSIONERROR
	else
		if updatecheck.latest_version == "latest" then
			return L.VERSIONUPTODATE
		else
			return langkeys(L.VERSIONOLD, {updatecheck.latest_version})
		end
	end
end
