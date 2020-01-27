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
			local char = helparticlecontent[helpeditingline]:sub(c, c):byte()

			remainingcols = remainingcols - 1

			if char <= 0x7F then -- 0xxxxxxx
				utf8colnum = utf8colnum + 1
			elseif char >= 0xC0 and char <= 0xDF then -- 110xxxxx
				utf8colnum = utf8colnum + 2
				remainingcols = remainingcols + 1
			elseif char >= 0xE0 and char <= 0xEF then -- 1110xxxx
				utf8colnum = utf8colnum + 3
				remainingcols = remainingcols + 2
			elseif char >= 0xF0 and char <= 0xF7 then -- 11110xxx
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
	stopinput()
	dialog.create(
		L.SEARCHFOR,
		DBS.OKCANCEL,
		dialog.callback.helpsearch,
		nil,
		dialog.form.simplename_make(helpsearchterm)
	)
end

function helplineonscreen(ln)
	if ln == nil then
		ln = helpeditingline
	end

	helparticlescroll = math.max(helparticlescroll, -(10*(ln-1)))
	helparticlescroll = math.min(helparticlescroll, -(10*ln-10*45))
end
