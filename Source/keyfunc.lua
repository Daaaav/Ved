local mt = {
	__index = function(table, key)
		local value = getfenv(0)[key]
		rawset(table, key, value)
		return value
	end
}
local env = setmetatable({}, mt)
setfenv(1, env)

ce = {"up", "up", "down", "down", "left", "right", "left", "right", "b", "a"}
progress = 0

function keypressed(key)
	if key == ce[progress + 1] then
		progress = progress + 1

		if progress == #ce then
			callback()
			progress = 0
		end
	else
		progress = 0
	end
end

return function(func)
	callback = func
	return env
end