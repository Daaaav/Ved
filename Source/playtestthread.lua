local path, args, levelcontents
path, args, levelcontents, L = ...

require("love.filesystem")
require("love.system")

-- Workaround for including const
require("corefunc")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

local retain_stdout, retain_stderr -- TEMP
if love.system.getOS() == "Windows" then
	require("filefunc_win")
	retain_stdout, retain_stderr = false, false
else
	require("filefunc_linmac")
	retain_stdout, retain_stderr = true, true
end

local err

local success, processinfo, stdin_write_end, stdout_read_end, stderr_read_end = start_process(
	path, args, 0, true, retain_stdout, retain_stderr
)
if not success then
	err = processinfo
else
	-- From now on, there could be multiple error messages simultaneously, I guess...
	local errs = {}
	local write_success, write_err = write_to_pipe(stdin_write_end, levelcontents)
	if not write_success then
		table.insert(errs, write_err)
	end

	local await_success, exitcode = await_process(processinfo, stderr_read_end)
	if not await_success then
		table.insert(errs, exitcode)
	elseif exitcode ~= 0 then
		table.insert(errs, langkeys(L.VVVVVV_EXITCODE_FAILURE, {exitcode}))
	end
	process_cleanup(nil, stdout_read_end, stderr_read_end)

	if #errs ~= 0 then
		success = false
		err = table.concat(errs, "\n")
	end
end

if not success then
	outchannel:push(PLAYTESTING.ERROR)
	outchannel:push(err)
else
	outchannel:push(PLAYTESTING.DONE)
end
