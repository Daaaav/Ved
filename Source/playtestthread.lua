local path, editingmap
path, editingmap, L = ...

require("love.filesystem")
require("love.system")

-- Workaround for including const
require("corefunc")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local version = 2.3
local data_levelcontents = nil
local data_pos = nil
local continue_cmd = nil
local cancel_err = nil

local function push_result(success, err)
	if not success then
		outchannel:push(PT_RESULT.ERROR)
		outchannel:push(err)
	else
		outchannel:push(PT_RESULT.DONE)
	end
end

local function push_cancel()
	push_result(cancel_err == nil, cancel_err)
end

local function await_cmd()
	local cmd = inchannel:demand()

	if cmd == PT_CMD.DATA_LEVEL then
		data_levelcontents = inchannel:demand()
	elseif cmd == PT_CMD.DATA_POS then
		data_pos = inchannel:demand()
	elseif cmd == PT_CMD.GO then
		if data_levelcontents == nil or data_pos == nil then
			cancel_err = "Trying to start playtesting without all required data!"
			continue_cmd = PT_CMD.CANCEL
		else
			continue_cmd = cmd
		end
	elseif cmd == PT_CMD.CANCEL then
		continue_cmd = cmd
	else
		cancel_err = "Invalid playtesting command " .. tostring(cmd)
		continue_cmd = PT_CMD.CANCEL
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
	- If it hasn't exited within some seconds, it's 2.2
	- If stdOUT gives any version number, it's 2.4 or later
	- If stdOUT says "invalid option", it's 2.3

	The version check thus breaks support for:
	- 2.3-pre between 04/2020 and 08/2020
	- Some specific commits of 2.4-pre in 05-06/2022 where -version existed but preloading
	  wasn't, or wasn't fully, supported yet
	- VVVVVV-CE, since it has --version and behaves like 2.2 on -version (but you should never
	  playtest VVVVVV levels in VVVVVV-CE anyway because of the differences in behavior)
]]
local version_process = cProcess:new{path=path, args_table={"-version"}, timeout=5, will_read=true}
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

-- Now prepare for launching the real thing.
local args

if version <= 2.3 then
	while continue_cmd == nil do
		await_cmd()
	end
	if continue_cmd == PT_CMD.CANCEL then
		-- We haven't started anything yet
		push_cancel()
		return
	end

	args = {
		"-p",
		"special/stdin",
		"-playx",
		data_pos.x,
		"-playy",
		data_pos.y,
		"-playrx",
		data_pos.rx,
		"-playry",
		data_pos.ry,
		"-playgc",
		data_pos.gc,
		"-playmusic",
		data_pos.music
	}
else
	-- Version 2.4 or later
	args = {
		"-p",
		"special/stdin",
		"-leveldebugger"
	}
end

if editingmap ~= "untitled\n" then
	table.insert(args, "-playassets")
	if love.system.getOS() == "Windows" then
		-- On Windows the args are passed as a single string, and level names can contain spaces
		table.insert(args, "\"" .. editingmap .. "\"")
	else
		-- On Linux and macOS we basically directly control argv[]
		table.insert(args, editingmap)
	end
end


local process = cProcess:new{path=path, args_table=args, will_write=true}
success, err = process:start()

if success then
	-- From now on, there could be multiple error messages simultaneously, I guess...
	local errs = {}

	while continue_cmd == nil do
		await_cmd()
	end
	if continue_cmd == PT_CMD.CANCEL then
		-- First clean up
		process:write_stdin("")
		process:await_completion()
		process:cleanup()
		push_cancel()
		return
	end
	if version >= 2.4 then
		data_levelcontents = data_levelcontents:gsub(
			"</MapData>",
			"    <Playtest>\n" ..
			"        <playx>" .. data_pos.x .. "</playx>\n" ..
			"        <playy>" .. data_pos.y .. "</playy>\n" ..
			"        <playrx>" .. data_pos.rx .. "</playrx>\n" ..
			"        <playry>" .. data_pos.ry .. "</playry>\n" ..
			"        <playgc>" .. data_pos.gc .. "</playgc>\n" ..
			"        <playmusic>" .. data_pos.music .. "</playmusic>\n" ..
			"    </Playtest>\n" ..
			"</MapData>"
		)
	end

	local write_success, write_err = process:write_stdin(data_levelcontents)
	if not write_success then
		table.insert(errs, write_err)
	end

	outchannel:push(PT_RESULT.STARTED_PID)
	outchannel:push(process:get_pid())

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
