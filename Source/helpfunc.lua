function helpgotoline(linenum, colnum, correctcol)
	linenum = math.floor(linenum)

	if anythingbutnil0(linenum) < 1 then
		linenum = 1
	elseif linenum > #helparticlecontent then
		linenum = #helparticlecontent
	end

	helparticlecontent[helpeditingline] = input .. input_r
	__ = "_"
	helpeditingline = linenum
	if colnum == nil then
		input, input_r = anythingbutnil(helparticlecontent[helpeditingline]), ""
	else
		if correctcol then
			-- We want to go to a certain visible column, not just the xth character in the string.
			-- TODO
		end
		-- We must account for UTF-8 here, level notes can contain any character, and ¤ in particular
		local utf8colnum = 1
		local remainingcols = colnum-1
		local c = 1
		while remainingcols > 0 and c <= anythingbutnil(helparticlecontent[helpeditingline]):len() do
			binarychar = toBinary(string.sub(helparticlecontent[helpeditingline], c, c))

			remainingcols = remainingcols - 1

			if string.sub(binarychar, 1, 1) == "0" then
				utf8colnum = utf8colnum + 1
			elseif string.sub(binarychar, 1, 3) == "110" then
				utf8colnum = utf8colnum + 2
				remainingcols = remainingcols + 1
			elseif string.sub(binarychar, 1, 4) == "1110" then
				utf8colnum = utf8colnum + 3
				remainingcols = remainingcols + 2
			elseif string.sub(binarychar, 1, 5) == "11110" then
				utf8colnum = utf8colnum + 4
				remainingcols = remainingcols + 3
			end
			c = c + 1
		end
		input, input_r = anythingbutnil(helparticlecontent[helpeditingline]):sub(1,utf8colnum-1), anythingbutnil(helparticlecontent[helpeditingline]):sub(utf8colnum,-1)
		helparticlecontent[helpeditingline] = input
	end

	-- Now make sure the line is actually on screen!
	helplineonscreen()
end

function startinhelpsearch()
	startmultiinput({helpsearchterm})
	dialog.new(L.SEARCHFOR, "", 1, 4, 25)
	currentmultiinput = 1
end

--[[
function startscriptgotoline()
	startmultiinput({""})
	dialog.new(L.GOTOLINE2, "", 1, 4, 18)
	currentmultiinput = 1
end
]]

function helplineonscreen(ln)
	if ln == nil then
		ln = helpeditingline
	end

	helparticlescroll = math.max(helparticlescroll, -(10*(ln-1)))
	helparticlescroll = math.min(helparticlescroll, -(10*ln-10*45))
end