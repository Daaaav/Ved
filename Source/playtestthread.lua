local path, args, levelcontents
path, args, levelcontents, L = ...

require("love.filesystem")
require("love.system")

-- Workaround for including const
require("corefunc")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local function push_result(success, err)
	if not success then
		outchannel:push(PLAYTESTING.ERROR)
		outchannel:push(err)
	else
		outchannel:push(PLAYTESTING.DONE)
	end
end


if love.system.getOS() == "Windows" then
	require("filefunc_win")
else
	require("filefunc_linmac")
end

--[[
	First do a version check.

	=== A brief history of command-line playtesting support in VVVVVV: ===
	[2.2 and earlier ~ 2.3-pre until 04/2020]
	No support, just idles on the loading/title screen
	[2.3 since 04/2020]
	Supports playtesting: position via args, level XML via stdin ("version 2.3")
	[2.4 since 06/2022]
	Supports "preloaded" playtesting: position inside level XML via stdin ("version 2.4")

	=== And of -version behavior: ===
	[2.2 and earlier ~ 2.3-pre until 08/2020]
	Doesn't care about -version at all, just idles on the loading/title screen
	[2.3 since 08/2020 ~ 2.3.6]
	Writes "Error: invalid option: -version" to stdOUT and exits 1
	[2.4 since .3 release ~ 2.4-pre until 05/2022]
	Writes "[ERROR] Error: invalid option: -version" to stdERR and exits 1
		[2.4-pre ~ 2.4-pre (fully within previous range)]
		Does the same but segfaults at the end
	[2.4 since 05/2022]
	Writes "VVVVVV v2.4" to stdOUT and exits 0

	So to summarize the mapping of -version behavior to playtesting support version:
	- If stdERR says "invalid option", it's early 2.4, counting as 2.3 (don't mind if it segfaults)
	- If it hasn't exited within 2 seconds, it's 2.2
	- If stdOUT gives any version number, it's 2.4 or later
	- If stdOUT says "invalid option", it's 2.3

	The version check thus breaks support for:
	- 2.3-pre between 04/2020 and 08/2020
	- Some specific commits of 2.4-pre in 05-06/2022 where -version existed but preloading
	  wasn't, or wasn't fully, supported yet
	- VVVVVV-CE, since it has --version and behaves like 2.2 on -version (but you should never
	  playtest VVVVVV levels in VVVVVV-CE anyway because of the differences in behavior)
]]
local version = 2.3
local version_process = cProcess:new{path=path, args_table={"-version"}, timeout=2, will_read=true}
local success, err = version_process:start()

if success then
	local exitcode, await_err = version_process:await_completion()

	-- Check stderr before termination status in case it's early 2.4 that segfaults from -version
	local stderr_data = version_process:read_stderr()
	if stderr_data ~= nil and stderr_data:find("Error: invalid option: -version", nil, true) ~= nil then
		-- Early 2.4
		version = 2.3
	elseif exitcode == nil then
		-- Possibly a timed out 2.2, or something else went wrong...
		version_process:cleanup()
		push_result(false, await_err)
		return
	else
		local stdout_data = version_process:read_stdout()
		if stdout_data ~= nil then
			local version_string = stdout_data:match("VVVVVV v([0-9%.]+)")
			if version_string ~= nil then
				-- Whether this is 2.4, 2.5, any future 3.0... we can only reason about 2.4 right now!
				version = 2.4
			else
				-- Any version of 2.3, probably. Otherwise, 2.3 is our best shot anyway...
				version = 2.3
			end
		end
	end
	version_process:cleanup()
end

local process = cProcess:new{path=path, args_table=args, will_write=true}
success, err = process:start()

if success then
	-- From now on, there could be multiple error messages simultaneously, I guess...
	local errs = {}
	local write_success, write_err = process:write_stdin(levelcontents)
	if not write_success then
		table.insert(errs, write_err)
	end

	local exitcode, await_err = process:await_completion()
	if exitcode == nil then
		table.insert(errs, await_err)
	elseif exitcode ~= 0 then
		table.insert(errs, langkeys(L.VVVVVV_EXITCODE_FAILURE, {exitcode}))
	end
	process:cleanup()

	if #errs ~= 0 then
		success = false
		err = table.concat(errs, "\n")
	end
end

push_result(success, err)
