local utf8

if love_version_meets(9, 2) then
	utf8 = require("utf8")
else
	-- Don't have the utf8 lib? Just make it ourselves, I guess
	utf8 = require("utf8lib_fallback9")
end

-- Can we actually get a complete library without having to find the missing pieces ourselves? Jesus fucking christ
-- http://lua-users.org/lists/lua-l/2014-04/msg00590.html
function utf8.sub(s,i,j)
	i = i or 1
	j = j or -1
	if i<1 or j<1 then
		local n = utf8.len(s)
		if not n then return nil end
		if i<0 then i = n+1+i end
		if j<0 then j = n+1+j end
		if i<0 then i = 1 elseif i>n then i = n end
		if j<0 then j = 1 elseif j>n then j = n end
	end
	if j<i then return "" end
	i = utf8.offset(s,i)
	j = utf8.offset(s,j+1)
	if i and j then return s:sub(i,j-1)
	elseif i then return s:sub(i)
	else return ""
	end
end

return utf8
