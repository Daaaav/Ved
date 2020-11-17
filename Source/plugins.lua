--[[

Two arrays are made:

plugins = {
	[<PLUGIN NAME>] = {
		info = {
			shortname = 'string',
			longname = 'string',
			author = 'string',
			version = 'string',
			minimumved = 'string',
			description = 'string',
		},
		usedhooks = {
			<LIST OF HOOKS HERE>
		}
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

Now we also have an array with included files:

pluginincludes = {
	[<FILENAME W/O .lua>] = "full/path/to/file/in/plugin/folder"
}

(sourceedits file in a plugin contains an array similar to that, called sourceedits)
]]

function loadplugins()
	cons("--Loading plugins...")

	plugins = {}
	hooks = {}
	pluginfileedits = {}
	pluginincludes = {}

	if not love.filesystem.exists("plugins") then
		love.filesystem.createDirectory("plugins")
	else
		-- The folder exists, go ahead and load any plugins in it!
		folders = love.filesystem.getDirectoryItems("plugins")

		for k,v in pairs(folders) do
			if love.filesystem.isDirectory("plugins/" .. v) or v:sub(-4, -1) == ".zip" then
				-- This is a plugin folder/zip, neat! But if it's a zip, then we first need to mount it.
				local pluginpath, pluginname

				if v:sub(1,1) == "#" or v:sub(1,1) == "." then
					-- Plugins starting with a # or . are disabled!
				else

					if v:sub(-4, -1) == ".zip" then
						assert(love.filesystem.mount("plugins/" .. v, "plugins-zip/" .. v:sub(1, -5)), "Failed to mount plugin " .. v)
						pluginpath = "plugins-zip/" .. v:sub(1, -5)
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
						shortname = pluginname:sub(1,21),
						longname = pluginname,
						author = "Unknown",
						version = "N.A.",
						minimumved = "a58",
						description = "No description specified",
						descriptionimgs = {},
						overrideinfo = false,

						-- Not specified by the plugin developer.
						supported = true,
						failededits = 0,
						internal_pluginpath = pluginpath,
					}
					plugins[pluginname].usedhooks = {}

					-- So does this plugin have an info file?
					if love.filesystem.exists(pluginpath .. "/info.lua") then
						local infofile = love.filesystem.load(pluginpath .. "/info.lua")
						infofile(plugins[pluginname].info)
					end

					-- Is this plugin supported?
					--alphabetaver = tonumber(plugins[pluginname].info.minimumved:sub(2,-1))
					pver1, pver2 = plugins[pluginname].info.minimumved:match("^1%.([0-9]+)%.([0-9]+)$")
					if (plugins[pluginname].info.minimumved:sub(1,1) == "a" or plugins[pluginname].info.minimumved:sub(1,1) == "b")
					or (pver1 ~= nil and pver2 ~= nil and not (tonumber(pver1) > vergroups[1] or (tonumber(pver1) == vergroups[1] and tonumber(pver2) > vergroups[2]))) then
						-- It is!

						if love.filesystem.exists(pluginpath .. "/hooks") then
							-- There are hooks, yay
							thesehooks = love.filesystem.getDirectoryItems(pluginpath .. "/hooks")

							for k2,v2 in pairs(thesehooks) do
								if v2:sub(1, 1) ~= "." then
									hookname = v2:sub(1, -5)

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
								if pluginfileedits[k2] == nil then
									pluginfileedits[k2] = {}
								end

								for k3,v3 in pairs(v2) do -- For each edit in said file
									if v3.ignore_error == nil then v3.ignore_error = false end
									if v3.luapattern == nil then v3.luapattern = false end
									if v3.allowmultiple == nil then v3.allowmultiple = false end

									table.insert(pluginfileedits[k2], {
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
							plugin_includefrom = function(dir)
								thesefiles = love.filesystem.getDirectoryItems(pluginpath .. "/include" .. dir)

								for k2,v2 in pairs(thesefiles) do
									if love.filesystem.isDirectory(pluginpath .. "/include" .. dir .. "/" .. v2) then
										-- Do this directory as well!
										plugin_includefrom(dir .. "/" .. v2)
									else
										local filename
										filename = dir:sub(2, -1) .. "/" .. v2:sub(1, -5)

										pluginincludes[filename] = pluginpath .. "/include/" .. filename

										cons("Included " .. filename)
									end
								end
							end

							plugin_includefrom("")
						end
						plugin_includefrom = nil
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

function loadpluginpages()
	helppages = {}

	table.insert(helppages, {
		subj = "Return",
		imgs = {},
		cont = [[
\)
]]
	})

	local i = false

	for k,v in pairs(plugins) do
		table.insert(helppages, {
			subj = v.info.shortname,
			imgs = {},
			cont = (v.info.supported and "" or [[
[This plugin is not supported because it requires Ved ]] .. v.info.minimumved .. [[ or higher!]\r

]]) .. (v.info.overrideinfo and v.info.description or [[
]] .. v.info.longname .. [[\wh#

by ]] .. v.info.author .. [[, version ]] .. v.info.version .. [[

\-

]] .. v.info.description .. [[
]])
		})

		helppages[#helppages].imgs = table.copy(v.info.descriptionimgs)

		for k2,v2 in pairs(helppages[#helppages].imgs) do
			helppages[#helppages].imgs[k2] = v.info.internal_pluginpath .. "/" .. v2
		end

		i = true
	end

	--if not i then
		table.insert(helppages, 2, {
			subj = "PLUGINS INFO",
			imgs = {},
			cont = (i and [[
Plugins\wh#

Please go to ¤https://tolp.nl/ved/plugins.php\nCl
for more information about plugins and hooks.
]] or [[
No plugins\wh#

You do not have any plugins yet. Please go to ¤https://tolp.nl/ved/plugins.php\nCl
for more information about plugins and hooks.
]]) .. [[

Your plugins folder is:
]] .. love.filesystem.getSaveDirectory() .. "/plugins\\Y"
		})
	--end
end

local function require_with_args(reqfile, ...)
	if not package.loaded[reqfile] then
		local module = assert(loadfile(reqfile .. ".lua"))
		-- We're still here, so it loaded successfully
		package.loaded[reqfile] = true
		return module(...)
	end
end

function ved_require(reqfile, ...)
	if pluginincludes[reqfile] ~= nil then
		-- A plugin specifically included this version of this file!
		return require_with_args(pluginincludes[reqfile], ...)
	elseif pluginfileedits[reqfile] == nil then
		-- No plugins want to edit this file!
		return require_with_args(reqfile, ...)
	elseif not package.loaded[reqfile] then
		local readlua = love.filesystem.read(reqfile .. ".lua")

		for editk,editv in pairs(pluginfileedits[reqfile]) do
			-- Is this a plain string or a pattern?
			if not editv.luapattern then
				editv.findoriginal = editv.find
				editv.find = escapegsub_plugin(editv.find)
				editv.replace = editv.replace:gsub("%%", "%%%%")
			end

			if readlua:find(editv.find) == nil then
				-- Something went wrong here! But should we complain loudly about it?
				if not editv.ignore_error then
					if plugins[editv.plugin] ~= nil then
						plugins[editv.plugin].info.failededits = plugins[editv.plugin].info.failededits + 1
					end
					pluginerror(reqfile, editv.plugin, "TO BE ADDED", (editv.luapattern and editv.find or editv.findoriginal), editv.luapattern)
				end
			else
				-- Alright, this change can be done!
				readlua = "--[[## " .. reqfile .. " ##]] " .. readlua:gsub(editv.find, editv.replace)
			end
		end

		--[[
		local succ, errormsg
		succ, errormsg = loadstring(readlua)
		assert(succ, errormsg)
		]]
		local module = assert(loadstring(readlua))
		-- We're here, so it loaded fine
		package.loaded[reqfile] = true
		return module(...)
	end
end

-- Plugins can allocate a number of states for their use, without clashing with other plugins
state_allocations = {} -- contains: {start, max}
state_alloc_pointer = 100

function allocate_states(name, amount)
	if amount == nil then
		amount = 1
	end
	--assert(name == nil or amount == nil, "Attempt to allocate nil states, or attempt to allocate states for name nil") -- That crash will happen anyway
	assert(state_allocations[name] == nil, "Attempt to allocate states for '" .. name .. "' multiple times; plugin included twice?")
	assert(type(amount) == "number", "Attempt to allocate an amount of states for '" .. name .. "' that is " .. type(amount))
	assert(math.floor(amount) == amount, "Attempt to allocate a non-integer amount of states (" .. amount .. ") for '" .. name .. "'")
	assert(amount >= 0, "Attempt to allocate a negative amount of states (" .. amount .. ") for '" .. name .. "'")

	cons("Registering " .. amount .. " state(s) for '" .. name .. "' (" .. state_alloc_pointer .. "-" .. (state_alloc_pointer+amount-1) .. ")")

	state_allocations[name] = {state_alloc_pointer, amount-1}
	state_alloc_pointer = state_alloc_pointer + amount
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
