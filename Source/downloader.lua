local downloader = {}

local n_awaiting = 0

local channel_progress = love.thread.getChannel("downloader_progress")
local channel_data = love.thread.getChannel("downloader_data")

--[[
The queue can consist of multiple downloads that all have to succeed.
We're assuming anything in the queue at the same time belongs together
(i.e. a few plugin updates and an update for Ved itself)
and if any of them fail, they should all be rejected.
Only if all of them have succeeded, should any of them be processed.

queue[id] = {
	kind = "plugin_install" | "plugin_update", -- (and later "autoupdate")
	done = false,
	-- (for plugin_install and plugin_update):
	plugin_id = "Dav999:ExamplePlugin",
	new_filename = "example_plugin_v1.1.zip",
	-- (for plugin_update):
	old_filename = "example_plugin_v1.0.zip",
}
]]
local queue = {}

function downloader.request(kind, id, url, sha512, size, userdata)
	-- Start a download!
	-- Userdata is a table that will be added to the queue

	userdata.kind = kind
	userdata.done = false

	queue[id] = userdata

	n_awaiting = n_awaiting + 1
	local thread = love.thread.newThread("downloader_thread.lua")
	thread:start(L, id, url, sha512, size)
end

local function handle_progress_msg(msg)
	-- Handle one message from the progress channel.
	-- Returns true if this is the final update for this ID
	-- (false may be used for percentage status updates, for example)

	-- If we don't have this in the queue, then forget about it
	if queue[msg.id] == nil then
		return true
	end

	if msg.fail then
		-- Invalidate the whole queue
		queue = {}
		dialog.create(msg.fail)
		return true
	end

	if msg.done then
		queue[msg.id].done = true
	end

	return true
end

function install_whole_queue()
	-- Called once a whole queue has been successfully downloaded.
	-- Here we install plugins.

	local msg = channel_data:pop()
	if msg == nil then
		return
	end

	if queue[msg.id] ~= nil then
		local q = queue[msg.id]
		if q.kind == "plugin_update" then
			love.filesystem.remove("plugins/" .. q.old_filename)
		end

		if q.kind == "plugin_update"
		or q.kind == "plugin_install" then
			local success, errmsg = love.filesystem.write("plugins/" .. q.new_filename, msg.data)
			if not success then
				dialog.create(errmsg, nil, nil, q.new_filename)
			end

			-- Now we need to set the plugin's status to "just_installed"
			if plugins_id_to_key[q.plugin_id] ~= nil then
				plugins[plugins_id_to_key[q.plugin_id]].status = "just_installed"
				plugins[plugins_id_to_key[q.plugin_id]].status_pending = true
				plugins[plugins_id_to_key[q.plugin_id]].info.filename = q.new_filename -- make sure deletion works
			else
				-- Might be an online-only plugin... Not until we restart!
				for k,v in pairs(plugins_online) do
					if v.info.id == q.plugin_id then
						v.status = "just_installed"
						v.status_pending = true
					end
				end
			end
		elseif q.kind == "test" then
			dialog.create(msg.data)
		end

		if q.done_msg ~= nil then
			dialog.create(q.done_msg)
		end
	end

	-- Tail recursion for the next entry
	return install_whole_queue()
end

function downloader.await_response()
	-- Called in love.update to handle progress messages from downloads
	if n_awaiting <= 0 then
		return
	end

	local msg = channel_progress:pop()
	if msg == nil then
		return
	end

	if handle_progress_msg(msg) then
		n_awaiting = n_awaiting - 1
	end

	-- Check if everything in the queue is done
	local all_done = true
	for k,v in pairs(queue) do
		if not v.done then
			all_done = false
			break
		end
	end
	if all_done then
		install_whole_queue()
		queue = {}
		return
	end

	-- Tail recursion (since we had a message, we might have more)
	return downloader.await_response()
end

return downloader
