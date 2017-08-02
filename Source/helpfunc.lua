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
		input, input_r = anythingbutnil(helparticlecontent[helpeditingline]):sub(1,colnum-1), anythingbutnil(helparticlecontent[helpeditingline]):sub(colnum,-1)
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