-- state0/load

return function()
	newinputsys.create(INPUT.ONELINE, "state")
	newinputsys.whitelist("state", "[-%d]")
end
