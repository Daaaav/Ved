-- Note to self: environment variables: set

-- These functions assume you're not on a school computer or anywhere where cmd is completely restricted.

function cp850toutf8(text)
	-- We're working with the command line...
	
	if text == nil then return nil end
	
	local extended = "ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»░▒▓│┤ÁÂÀ©╣║╗╝¢¥┐└┴┬├─┼ãÃ╚╔╩╦╠═╬¤ðÐÊËÈıÍÎÏ┘┌█▄¦Ì▀ÓßÔÒõÕµþÞÚÛÙýÝ¯´-±‗¾¶§÷¸°¨·¹³²■ "
	
	local convertedtext = {}
	
	for c = 1, text:len() do
		local chr = string.sub(text, c, c)
		local binarychar = toBinary(chr)
		
		if string.sub(binarychar, 1, 1) == "0" then
			table.insert(convertedtext, chr)
		else
			local seekthis = string.byte(chr) - 127
			
			local currentbytepos = 1
			local currentnumpos = 1
			
			while currentnumpos < seekthis do
				local extbinarychar = toBinary(string.sub(extended, currentbytepos, currentbytepos))
				
				if string.sub(extbinarychar, 1, 3) == "110" then
					currentbytepos = currentbytepos + 2
				elseif string.sub(extbinarychar, 1, 4) == "1110" then
					currentbytepos = currentbytepos + 3
				elseif string.sub(extbinarychar, 1, 5) == "11110" then
					currentbytepos = currentbytepos + 4
				else
					currentbytepos = currentbytepos + 1
				end
					
				currentnumpos = currentnumpos + 1
			end
			
			-- So currentbytepos should now have the start of the character we're looking for.
			
			--cons("AT POSITION " .. currentbytepos .. " #" .. currentnumpos)
			
			table.insert(convertedtext, firstUTF8(string.sub(extended, currentbytepos)))
		end
	end
	
	return table.concat(convertedtext)
	
	--[[
	local count1, count2, count3, count4 = 0, 0, 0, 0
	
	for c = 1, string.len(extended) do
		binarychar = toBinary(string.sub(extended, c, c))
		
		if string.sub(binarychar, 1, 1) == "0" then
			count1 = count1 + 1
		elseif string.sub(binarychar, 1, 3) == "110" then
			count2 = count2 + 1
		elseif string.sub(binarychar, 1, 4) == "1110" then
			count3 = count3 + 1
		elseif string.sub(binarychar, 1, 5) == "11110" then
			count4 = count4 + 1
		end
	end
	
	cons(count1 .. " - " .. count2 .. " - " .. count3 .. " - " .. count4)
	--cons(extended:len() .. "!!!!!!!!!!!!!!")
	]]
end

-- (http://stackoverflow.com/questions/5303174/get-list-of-directory-in-a-lua)
function listfiles(directory)
	local i, t, popen = 0, {}, io.popen
	--for filename in popen('ls -a "'..directory..'"'):lines() do
	
	-- Only do files.
	for filename in popen('dir "'..directory..'" /b /a-d'):lines() do
		i = i + 1
		--t[i] = filename
		t[i] = cp850toutf8(filename)
		
		--cons(filename)
	end
	return t
end

function getlevelsfolder(ignorecustom)
	-- Returns error, path
	-- 1: no documents, 2: no vvvvvv, 3: no levels folder

	if s.customvvvvvvdir == "" or ignorecustom then
		-- We know we're on Windows for a start...
		userprofile = os.getenv('USERPROFILE')
		
		-- Spawn less cmd windows
		if directory_exists(userprofile .. "\\Documents\\VVVVVV", "levels") then
			return 0, userprofile .. "\\Documents\\VVVVVV\\levels"
		elseif directory_exists(userprofile .. "\\My Documents\\VVVVVV", "levels") then
			return 0, userprofile .. "\\My Documents\\VVVVVV\\levels"
		else
			-- Also return what it should have been
			return 4, userprofile .. "\\(My) Documents\\VVVVVV\\levels"
		end
	else
		-- The user has supplied a custom directory.
		if directory_exists(s.customvvvvvvdir, "levels") then
			-- Fair enough
			return 0, s.customvvvvvvdir .. "\\levels"
		else
			-- What are you doing?
			return 4, s.customvvvvvvdir .. "\\levels"
		end
	end
end

function listdirs(directory)
	local i, t, popen = 0, {}, io.popen
	--for filename in popen('ls -a "'..directory..'"'):lines() do
	
	-- Only do folders.
	for filename in popen('dir "'..directory..'" /b /ad'):lines() do
		i = i + 1
		t[i] = filename
		
		--cons(filename)
	end
	return t
end

function directory_exists(where, what)
	local i, t, popen = 0, {}, io.popen
	
	for filename in popen('dir "'..where..'" /b /ad'):lines() do
		if filename == what then return true end
	end
	
	-- If we're here, then the dir doesn't exist.
	return false
end

function readlevelfile(path)
	-- returns success, contents

	fh, everr = io.open(path, "r")
	
	if fh == nil then
		return false, everr
	end
	
	local ficontents = fh:read("*a")
	
	fh:close()
	
	return true, ficontents
end

function writelevelfile(path, contents)
	-- returns success, (if not) error message

	fh, everr = io.open(path, "w")
	
	if fh == nil then
		return false, everr
	end
	
	local ficontents = fh:write(contents)
	
	fh:close()
	
	return true, nil
end

function readimage(levelsfolder, filename)
	-- returns success, contents

	fh, everr = io.open(levelsfolder:sub(1, -8) .. "\\graphics\\" .. filename, "rb")
	
	if fh == nil then
		return false, everr
	end
	
	local ficontents = fh:read("*a")
	
	fh:close()
	
	return true, ficontents
end

function openurl(url)
	os.execute("start " .. url)
end

--[[
function getdocuments(directory)
	local i, t, popen = 0, {}, io.popen
	local docs, mydocs

	-- Only do folders.
	for filename in popen('dir "'..directory..'" /b /ad'):lines() do
		if filename == "Documents" then docs = true end
		if filename == "My Documents" then mydocs = true end
	end
	
	if docs then
		return "Documents"
	elseif mydocs then
		return "My Documents"
	else
		return nil
	end
end

function directory_exists(directory)
	local i, t, popen = 0, {}, io.popen

	return popen('cd "' .. directory .. '"')
end
]]

function util_folderopendialog()
	-- love.filesystem.getSaveDirectory() = C:/Users/David/AppData/Roaming/LOVE/ved
	os.execute(love.filesystem.getSaveDirectory():gsub("/", "\\") .. "\\utils\\folderopendialog.exe")
end