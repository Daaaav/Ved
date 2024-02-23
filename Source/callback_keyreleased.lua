function love.keyreleased(key)
	for k,v in pairs(skip_next_keys) do
		if v == key then
			table.remove(skip_next_keys, k)
			return
		end
	end

	hook("love_keyreleased_start", {key})

	if holdingzvx and (key == "z" or key == "x" or key == "c" or key == "v" or key == "h" or key == "b" or key == "f") then
		if selectedtool == 1 or selectedtool == 2
		or ((selectedtool == 3 or selectedtool == 7 or selectedtool == 8 or selectedtool == 9) and oldzxsubtool <= 4)
		or ((selectedtool == 5 or selectedtool == 10 or selectedtool == 12) and oldzxsubtool <= 2) then
			selectedsubtool[selectedtool] = oldzxsubtool
		end
		holdingzvx = false
	elseif key == "]" then
		mouselockx = -1
	elseif key == "[" then
		mouselocky = -1
	elseif nodialog and (key == "lshift" or key == lctrl) then
		tilespicker = false
		tilespicker_shortcut = false
	elseif table.contains({"return", "kpenter"}, key) then
		returnpressed = false
	end

	if RCMactive or dialog.is_open() then
		return
	end

	local callback_state = state
	if uis[state] ~= nil and uis[state].keyreleased ~= nil then
		uis[state].keyreleased(key)
	end
	if callback_state == state and uis[state] ~= nil and uis[state].elements ~= nil then
		local function caller(e, key)
			if e.keyreleased ~= nil then
				e:keyreleased(key)
			end
		end
		for k,v in elements_iter(uis[state].elements) do
			caller(v, key)
			if v.recurse ~= nil then
				v:recurse("keyreleased", caller, key)
			end
		end
	end
end
