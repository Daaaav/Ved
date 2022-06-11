local path, args, levelcontents
path, args, levelcontents, L = ...

require("love.filesystem")
require("love.system")

-- Workaround for including const
require("corefunc")

require("const")

local inchannel = love.thread.getChannel("playtestthread_in")
local outchannel = love.thread.getChannel("playtestthread_out")

if love.system.getOS() == "Windows" then
	require("filefunc_win")
else
	require("filefunc_linmac")
end

local process = cProcess:new{path=path, args_table=args, will_write=true}
local success, err = process:start()

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

if not success then
	outchannel:push(PLAYTESTING.ERROR)
	outchannel:push(err)
else
	outchannel:push(PLAYTESTING.DONE)
end
