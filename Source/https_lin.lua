function https_request(url)
	-- We could assume the URL is trusted and doesn't need to be escaped, but just in case
	if url:find("'") ~= nil then
		return nil
	end

	local pfile = io.popen("wget -qO- '" .. url .. "' --https-only")
	response_text = pfile:read("*a")
	pfile:close()

	return response_text
end
