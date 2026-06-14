--[[

Two tables are made:

plugins = {
	[<PLUGIN NAME>] = {
		info = {
			id = 'string',
			shortname = 'string',
			longname = 'string',
			author = 'string',
			author_color = 'string',
			version = 'string',
			minimumved = 'string',
			description = 'string',
		},
		usedhooks = {
			<LIST OF HOOKS HERE>
		},
		status = "installed", -- see below
		status_pending = false, -- see below
		online = nil, -- see below
	}

hooks = {
	[<HOOK NAME>] = {
		[1] = <LOADED CODE>,
		[2] = <LOADED CODE>
	}
}


And for edits:

pluginfileedits = {
	[<FILENAME W/O .lua>] = {
		[1] = { -- edit 1 in that file
			find = 'string',
			replace = 'string',
			ignore_error = boolean, -- false by default
			luapattern = boolean, -- false by default
			plugin = 'string',
		}
		[2] = { -- edit 2 in that file
			...
		}
	}
	[<ANOTHER FILENAME>] = {
		...
	}
}

Now we also have a table with included files:

pluginincludes = {
	[<FILENAME W/O .lua>] = "full/path/to/file/in/plugin/folder"
}

(sourceedits file in a plugin contains a table similar to that, called sourceedits)


UIs:

plugin_uis = {
	[1] = {
		state_number = 101,
		ui_name = "my_screen",
		ui_path = pluginpath .. "/uis/my_screen/"
	},
	...
}
]]

function loadplugins()
	cons("--Loading plugins...")

	plugins = {}
	plugins_id_to_key = {}
	plugins_online = {}
	hooks = {}
	pluginfileedits = {}
	pluginincludes = {}
	plugin_uis = {}

	if not love.filesystem.exists("plugins") then
		love.filesystem.createDirectory("plugins")
	else
		-- The folder exists, go ahead and load any plugins in it!
		local folders = love.filesystem.getDirectoryItems("plugins")

		for k,v in pairs(folders) do
			if love.filesystem.isDirectory("plugins/" .. v)
			or (love_version_meets(9, 2) and love.filesystem.isSymlink("plugins/" .. v))
			or v:sub(-4, -1) == ".zip" then
				-- This is a plugin folder/zip, neat! But if it's a zip, then we first need to mount it.
				local pluginpath, pluginname
				local plugin_package_filename = v

				if v:sub(1,1) == "#" or v:sub(1,1) == "." then
					-- Plugins starting with a # or . are disabled!
				else

					if v:sub(-4, -1) == ".zip" then
						local mount_point = "plugins-zip/" .. v:sub(1, -5):gsub("%.", "_")
						assert(love.filesystem.mount("plugins/" .. v, mount_point), "Failed to mount plugin " .. v)
						pluginpath = mount_point
						pluginname = v:sub(1, -5)
					else
						pluginpath = "plugins/" .. v
						pluginname = v
					end
					local files = love.filesystem.getDirectoryItems(pluginpath)
					for k = #files, 1, -1 do
						local v = files[k]
						if table.contains({"#", "."}, v:sub(1, 1)) then
							table.remove(files, k)
						end
					end
					if #files == 1 and love.filesystem.isDirectory(pluginpath .. "/" .. files[1]) then
						-- Someone must've packaged this plugin incorrectly and nested it one level too deep... doesn't matter, we can deal with that.
						pluginpath = pluginpath .. "/" .. files[1]
					end

					cons("  Loading plugin " .. pluginname)

					plugins[pluginname] = {}
					-- Some defaults
					plugins[pluginname].info = {
						id = pluginname,
						shortname = pluginname:sub(1,21),
						longname = pluginname,
						author = "Unknown",
						author_color = "w",
						version = "N.A.",
						minimumved = "a58",
						description = "No description specified",
						descriptionimgs = {},
						overrideinfo = false,

						-- Not specified by the plugin developer.
						supported = true,
						failededits = 0,
						internal_pluginpath = pluginpath,
						filename = plugin_package_filename,
					}
					plugins[pluginname].usedhooks = {}

					-- Status can be:
					-- - "installed" (completely loaded and ready)
					-- - "missing" (online-only, or deleted)
					-- - "just_installed" (just installed or updated)
					plugins[pluginname].status = "installed"

					-- status_pending indicates Ved needs to be restarted for this plugin
					plugins[pluginname].status_pending = false

					-- .online can be either nil (no known online plugin),
					-- or a reference to an entry in plugins_online.
					-- This property does not exist in plugins_online entries,
					-- instead there's in_plugins (true/false)
					plugins[pluginname].online = nil

					-- So does this plugin have an info file?
					if love.filesystem.exists(pluginpath .. "/info.lua") then
						local infofile = love.filesystem.load(pluginpath .. "/info.lua")
						infofile(plugins[pluginname].info)
					end

					plugins_id_to_key[plugins[pluginname].info.id] = pluginname

					-- Is this plugin supported?
					local pver1, pver2 = plugins[pluginname].info.minimumved:match("^([0-9]+)%.([0-9]+)$")
					if (
						plugins[pluginname].info.minimumved:sub(1,1) == "a" or
						plugins[pluginname].info.minimumved:sub(1,1) == "b" or
						plugins[pluginname].info.minimumved:sub(1,2) == "1."
					) or (
						pver1 ~= nil and pver2 ~= nil and not (
							tonumber(pver1) > ved_ver_groups[1] or
							(tonumber(pver1) == ved_ver_groups[1] and tonumber(pver2) > ved_ver_groups[2])
						)
					) then
						-- It is!

						if love.filesystem.exists(pluginpath .. "/hooks") then
							-- There are hooks, yay
							local these_hooks = love.filesystem.getDirectoryItems(pluginpath .. "/hooks")

							for k2,v2 in pairs(these_hooks) do
								if v2:sub(1, 1) ~= "." then
									local hookname = v2:sub(1, -5)

									table.insert(plugins[pluginname].usedhooks, hookname)

									if hooks[hookname] == nil then
										hooks[hookname] = {}
									end

									table.insert(hooks[hookname], love.filesystem.load(pluginpath .. "/hooks/" .. v2))

									print("    -> Hook: " .. v2 .. " (" .. pluginpath .. "/hooks/" .. v2 .. ")")
								else
									print("    -> Ignoring hook " .. v2 .. " (" .. pluginpath .. "/hooks/" .. v2 .. ")")
								end
							end
						end

						-- Are we making file edits?
						if love.filesystem.exists(pluginpath .. "/sourceedits.lua") then
							cons("Plugin " .. pluginname .. " has a sourceedits file!")

							local editsfile = love.filesystem.load(pluginpath .. "/sourceedits.lua")
							--local fileedits

							editsfile()

							for k2,v2 in pairs(sourceedits) do -- For each edited file
								local key_dots = k2:gsub("/", ".")
								if pluginfileedits[key_dots] == nil then
									pluginfileedits[key_dots] = {}
								end

								for k3,v3 in pairs(v2) do -- For each edit in said file
									if v3.ignore_error == nil then v3.ignore_error = false end
									if v3.luapattern == nil then v3.luapattern = false end
									if v3.allowmultiple == nil then v3.allowmultiple = false end

									table.insert(pluginfileedits[key_dots], {
										["find"] = v3.find,
										["replace"] = v3.replace,
										ignore_error = v3.ignore_error,
										luapattern = v3.luapattern,
										allowmultiple = v3.allowmultiple,
										plugin = pluginname
									})
								end
							end
						end

						-- Including any files?
						if love.filesystem.exists(pluginpath .. "/include") then
							local plugin_includefrom -- can't be a single line since it's recursive
							plugin_includefrom = function(dir)
								local these_files = love.filesystem.getDirectoryItems(pluginpath .. "/include" .. dir)

								for k2,v2 in pairs(these_files) do
									if love.filesystem.isDirectory(pluginpath .. "/include" .. dir .. "/" .. v2) then
										-- Do this directory as well!
										plugin_includefrom(dir .. "/" .. v2)
									else
										local filename
										filename = dir:sub(2, -1) .. "/" .. v2:sub(1, -5)
										filename = filename:gsub("/", ".")

										local path = (pluginpath .. ".include." .. filename):gsub("/", ".")
										pluginincludes[filename] = path

										cons("Included " .. filename)
									end
								end
							end

							plugin_includefrom("")
						end

						-- Does this plugin have any 1.11.1+ UIs?
						if love.filesystem.exists(pluginpath .. "/uis") then
							local these_uis = love.filesystem.getDirectoryItems(pluginpath .. "/uis")

							for k2,v2 in pairs(these_uis) do
								if v2:sub(1, 1) ~= "." then
									local new_state_number = allocate_states(v2)
									table.insert(plugin_uis,
										{
											state_number = new_state_number,
											ui_name = v2,
											ui_path = pluginpath .. "/uis/" .. v2 .. "/"
										}
									)
								end
							end
						end
					else
						-- Unrecognized, this Ved must've been released before anyone heard of the minimum version for this plugin!
						plugins[pluginname].info.supported = false
						unsupportedplugins = unsupportedplugins + 1
					end
				end
			end
		end
	end

	cons("--Finished loading plugins.")
end

function hook(hookname, vars)
	if hooks[hookname] ~= nil then
		if vars == nil then
			vars = {}
		end
		for k,v in pairs(hooks[hookname]) do
			v(unpack(vars))
		end
	end
end

function plugin_author_and_version(info)
	-- Returns a (help) formatted version of the author and version for a plugin, if present.
	local col = info.author_color
	if col == nil or col:len() ~= 1 then
		col = "w"
	end

	local author = info.author
	if author == nil or author == "" then
		author = "?"
	end
	if author:len() == 1 then
		author = author .. "§"
		col = col .. "("
	end
	author = "¤" .. author .. "¤"
	col = "n" .. col .. "n"

	local text
	if info.version == nil or info.version == "" then
		text = langkeys(L.PLUGIN_AUTHOR, {author})
	else
		text = langkeys(L.PLUGIN_AUTHOR_VERSION, {author, info.version})
	end

	local splitter_nbytes = ("¤"):len()
	if text:sub(1,splitter_nbytes) == "¤" then
		text = text:sub(splitter_nbytes + 1)
		col = col:sub(2)
	end
	if text:sub(-splitter_nbytes) == "¤" then
		text = text:sub(1, -splitter_nbytes - 1)
		col = col:sub(1, -2)
	end

	return text .. "\\" .. col
end

function loadpluginpages()
	helppages = {}

	local any_plugins = false

	local short_list = {}

	table.insert(helppages, {subj=L.PLUGINS_INSTALLED, imgs={}, cont=""})

	for k,v in pairs(plugins) do
		table.insert(helppages, {
			subj = v.info.shortname,
			imgs = {},
			cont = (v.info.supported and "" or langkeys(L.PLUGIN_NOT_SUPPORTED, {v.info.minimumved}) .. "\n\n")
				.. (v.info.overrideinfo and v.info.description or v.info.longname .. "\\Gh#\n\n"
				.. plugin_author_and_version(v.info) .. "\n\\-\n\n"
				.. v.info.description
				),
			special = "plugin_installed",
			plugin_key = k
		})

		helppages[#helppages].imgs = table.copy(v.info.descriptionimgs)

		for k2,v2 in pairs(helppages[#helppages].imgs) do
			helppages[#helppages].imgs[k2] = v.info.internal_pluginpath .. "/" .. v2
		end

		table.insert(short_list,
			"- ¤" .. v.info.shortname .. "¤" .. v.info.longname .. "¤ " .. langkeys(L.PLUGIN_AUTHOR_VERSION, {v.info.author, v.info.version}) .. "\\yLwl"
		)

		any_plugins = true
	end

	if not any_plugins then
		table.insert(short_list, L.ALL_PLUGINS_NOPLUGINS)
	end

	local plugins_path = love.filesystem.getSaveDirectory() .. "/plugins"
	local plugins_path_disp
	if dirsep ~= "/" then
		plugins_path_disp = plugins_path:gsub("/", dirsep)
	else
		plugins_path_disp = plugins_path
	end
	table.insert(helppages, 1, {
		subj = L.ALL_PLUGINS,
		imgs = {},
		cont = L.ALL_PLUGINS .. "\\wh#\n\\C=\n\n\n"
			.. table.concat(short_list, "\n") .. "\n\n"
			.. (unsupportedplugins > 0 and langkeys(L_PLU.NUMUNSUPPORTEDPLUGINS, {unsupportedplugins}) .. "\\r\n\n" or "")
			.. "\\-\n\n"
			.. L.ALL_PLUGINS_MOREINFO .. "\n\n"
			.. L.ALL_PLUGINS_FOLDER .. "\n"
			.. "file://" .. plugins_path .. "¤" .. plugins_path_disp .. "\\LCl"
	})

	local any_available = false
	for k,v in pairs(plugins_online) do
		if not v.in_plugins then
			if not any_available then
				table.insert(helppages, {subj=L.PLUGINS_AVAILABLE, imgs={}, cont=""})
				any_available = true
			end

			table.insert(helppages, {
				subj = v.info.shortname,
				imgs = {},
				cont = (v.info.longname .. "\\Yh#\n\n"
					.. plugin_author_and_version(v.info) .. "\n\\-\n\n"
					.. v.info.description
					),
				special = "plugin_online",
				plugin_key = k
			})
		end
	end
end

function plugin_help_buttons(article)
	-- Takes a help article's special and plugin_key (on the plugins screen),
	-- and returns the buttons that this plugin should have (right to left).
	-- Available buttons are "install", "update" and "delete".

	local is_installed = article.special == "plugin_installed"
	local plugin
	if is_installed then
		plugin = plugins[article.plugin_key]
	elseif article.special == "plugin_online" then
		plugin = plugins_online[article.plugin_key]
	end

	if plugin.status == "installed" then
		-- Guaranteed is_installed for this status
		if plugin.online ~= nil and plugin.online.info.link ~= ""
		and plugin.online.info.version ~= plugin.info.version then
			return {"info", "delete","update"}, plugin.status_pending
		end
		return {"info", "delete"}, plugin.status_pending
	elseif plugin.status == "missing" then
		-- This plugin doesn't have a package file in our filesystem,
		-- but it may still be in plugins if we just deleted it!
		-- Or it may be in plugins_online because we never installed it.
		if (plugin.online ~= nil and plugin.online.info.link ~= "")
		or anythingbutnil(plugin.info.link) ~= "" then
			return {"info", "install"}, plugin.status_pending
		end
		return {"info"}, plugin.status_pending
	elseif plugin.status == "just_installed" then
		return {"info", "delete"}, plugin.status_pending
	end
	return {"info"}, plugin.status_pending
end

function plugin_help_action(article, pressed)
	local downloader = ved_require("downloader")

	local is_installed = article.special == "plugin_installed"
	local plugin
	local plugin_online
	if is_installed then
		plugin = plugins[article.plugin_key]
		plugin_online = plugins[article.plugin_key].online
	elseif article.special == "plugin_online" then
		plugin = plugins_online[article.plugin_key]
		plugin_online = plugin
	end

	if (pressed == "update" or pressed == "delete")
	and plugin.info.filename ~= nil
	and plugin.info.filename:sub(-4, -1) ~= ".zip" then
		-- These are operations we can't do on folders
		local plugins_path = love.filesystem.getSaveDirectory() .. "/plugins"
		dialog.create(
			L.CANNOT_DELETE_FOLDER_PLUGIN,
			{L.OPENFOLDER, DB.OK},
			function(button)
				if button == L.OPENFOLDER then
					love.system.openURL("file://" .. plugins_path)
				end
			end
		)
		return
	end

	if pressed == "install" or pressed == "update" then
		local download_id = string.format("plugin:%d:%s", os.time(), plugin.info.id)
		local kind = "plugin_install"
		local msg_top = L.CONFIRM_INSTALL_PLUGIN
		local msg_bot = L.NOTE_SAFE_PLUGINS
		local msg_version = plugin_online.info.version
		local btn_confirm = L.INSTALL
		local userdata = {
			plugin_id = plugin.info.id,
			new_filename = plugin_online.info.filename,
			done_msg = L.DONE_INSTALLING_PLUGIN
		}
		if pressed == "update" then
			kind = "plugin_update"
			userdata.old_filename = plugin.info.filename
			msg_top = L.CONFIRM_UPDATE_PLUGIN
			msg_bot = ""
			msg_version = plugin.info.version .. " " .. arrow_right .. " " .. plugin_online.info.version
			btn_confirm = L.UPDATE
		end

		dialog.create(
			msg_top .. "\n\n"
			.. plugin_online.info.longname .. "\n"
			.. langkeys(
				L.PLUGIN_AUTHOR_VERSION,
				{plugin_online.info.author, msg_version}
			) .. "\n\n"
			.. langkeys(L.DOWNLOAD_SIZE, {bytes_notation(plugin_online.info.size)})
			.. "\n\n\n" .. msg_bot,
			{btn_confirm, DB.CANCEL},
			function(button)
				if button == DB.CANCEL then
					return
				end

				downloader.request(
					kind,
					download_id,
					plugin_online.info.link,
					plugin_online.info.sha512,
					plugin_online.info.size,
					userdata
				)
			end
		)
	elseif pressed == "delete" then
		dialog.create(
			L.CONFIRM_DELETE_PLUGIN .. "\n\n"
			.. plugin.info.longname .. "\n"
			.. langkeys(
				L.PLUGIN_AUTHOR_VERSION,
				{plugin.info.author, plugin.info.version}
			) .. "\n\n\n" .. L.NOTE_RESTART_VED_DELETE,
			DBS.YESNO,
			function(button)
				if button ~= DB.YES then
					return
				end

				local filename = plugin.info.filename
				if filename == nil then
					filename = plugin_online.info.filename
				end

				if filename ~= nil and love.filesystem.remove("plugins/" .. filename) then
					plugin.status = "missing"
					plugin.status_pending = true
				else
					dialog.create(L.COORDS_OUT_OF_RANGE)
				end
			end
		)
	elseif pressed == "info" then
		local lines = {}
		table.insert(lines, L.PLUGININFO_INSTALLED_HEADER)
		table.insert(lines, "")
		if not is_installed then
			table.insert(lines, L.PLUGIN_NOT_INSTALLED)
		else
			table.insert(lines, langkeys(L.VERSION_IS, {plugin.info.version}))
			table.insert(lines, langkeys(L.INSTALLED_ON, {
				format_date(love.filesystem.getLastModified("plugins/" .. plugin.info.filename))
			}))
			table.insert(lines, L.MUSICFILENAME .. plugin.info.filename)
		end
		table.insert(lines, "")
		table.insert(lines, "")
		table.insert(lines, L.PLUGININFO_AVAILABLE_HEADER)
		table.insert(lines, "")
		if plugin_online == nil then
			table.insert(lines, L.PLUGIN_NOT_AVAILABLE)
		else
			local downloadable = plugin_online.info.link ~= ""
			if downloadable then
				table.insert(lines, langkeys(L.VERSION_IS, {plugin_online.info.version}))
			end
			table.insert(lines, langkeys(L.LAST_UPDATED, {
				format_date(plugin_online.info.time_updated)
			}))
			if downloadable then
				table.insert(lines, L.MUSICFILENAME .. plugin_online.info.filename)
				table.insert(lines, langkeys(L.DOWNLOAD_SIZE, {
					bytes_notation(plugin_online.info.size)
				}))
			else
				table.insert(lines, "")
				table.insert(lines, L.PLUGIN_NOT_DOWNLOADABLE)
			end
		end

		dialog.create(table.concat(lines, "\n"))
	end
end

function ved_require(reqfile)
	-- Replace slashes with dots
	local dots = reqfile:gsub("/", ".")
	if pluginincludes[dots] ~= nil then
		-- A plugin specifically included this version of this file!
		return require(pluginincludes[dots])
	elseif pluginfileedits[dots] == nil then
		-- No plugins want to edit this file!
		return require(dots)
	elseif not package.loaded[dots] then
		local readlua = love.filesystem.read(reqfile .. ".lua")

		for editk,editv in pairs(pluginfileedits[dots]) do
			-- Is this a plain string or a pattern?
			local find_original = editv.find
			local find = editv.find
			local replace = editv.replace
			if not editv.luapattern then
				find = escapegsub_plugin(find)
				replace = replace:gsub("%%", "%%%%")
			end

			if readlua:find(find) == nil then
				-- Something went wrong here! But should we complain loudly about it?
				if not editv.ignore_error then
					if plugins[editv.plugin] ~= nil then
						plugins[editv.plugin].info.failededits = plugins[editv.plugin].info.failededits + 1
					end
					pluginerror(dots, editv.plugin, "TO BE ADDED", find_original, editv.luapattern)
				end
			else
				-- Alright, this change can be done!
				readlua = "--[[## " .. reqfile .. " ##]] " .. readlua:gsub(find, replace)
			end
		end

		local module = assert(loadstring(readlua))
		-- We're here, so it loaded fine
		package.loaded[dots] = true
		return module()
	end

	return package.loaded[dots]
end

-- Plugins can allocate a number of states for their use, without clashing with other plugins
state_allocations = {} -- contains: {start, max}
state_alloc_pointer = 100

function allocate_states(name, amount)
	if amount == nil then
		amount = 1
	end
	assert(state_allocations[name] == nil, "Attempt to allocate states for '" .. name .. "' multiple times; plugin included twice?")
	assert(type(amount) == "number", "Attempt to allocate an amount of states for '" .. name .. "' that is " .. type(amount))
	assert(math.floor(amount) == amount, "Attempt to allocate a non-integer amount of states (" .. amount .. ") for '" .. name .. "'")
	assert(amount >= 0, "Attempt to allocate a negative amount of states (" .. amount .. ") for '" .. name .. "'")

	cons("Registering " .. amount .. " state(s) for '" .. name .. "' (" .. state_alloc_pointer .. "-" .. (state_alloc_pointer+amount-1) .. ")")

	local first_new_state = state_alloc_pointer
	state_allocations[name] = {first_new_state, amount-1}
	state_alloc_pointer = state_alloc_pointer + amount

	return first_new_state
end

function in_astate(name, s)
	if s == nil then
		s = 0
	end
	assert(state_allocations[name] ~= nil, "No states have been allocated for '" .. name .. "'")
	assert(s <= state_allocations[name][2], "State " .. s .. " is beyond upper bound for '" .. name .. "', only " .. state_allocations[name][2] .. " allocated (starting at 0)")

	return state == state_allocations[name][1] + s
end

function escapegsub_plugin(text) -- Almost the same as the one in func.lua, but different. (no :lower() and no ])
	return text
		:gsub("%%", "%%%%")
		:gsub("%(", "%%%(")
		:gsub("%)", "%%%)")
		:gsub("%.", "%%%.")
		:gsub("%+", "%%%+")
		:gsub("%-", "%%%-")
		:gsub("%*", "%%%*")
		:gsub("%?", "%%%?")
		:gsub("%[", "%%%[")
		:gsub("%]", "%%%]")
		:gsub("%^", "%%%^")
		:gsub("%$", "%%%$")
end
