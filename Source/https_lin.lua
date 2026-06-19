local https_lin = {}

function https_lin.request(url)
	-- We could assume the URL is trusted and doesn't need to be escaped, but just in case
	if url:find("'") ~= nil then
		return nil
	end

	local total_bytes = 0

	local pfile = io.popen("wget -qO- '" .. url .. "' --https-only")
	local lua_string_data = {}
	while true do
		local response_text = pfile:read(50000)
		if response_text == nil then
			break
		end

		total_bytes = total_bytes + response_text:len()
		table.insert(lua_string_data, response_text)
	end
	pfile:close()

	return table.concat(lua_string_data)
end

return https_lin
