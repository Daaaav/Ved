coordsdialog =
{
	active = false,
	lettermode = false,
	input = ""
}
function coordsdialog.draw()
	love.graphics.setColor(64,64,64,128)
	love.graphics.rectangle("fill", (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2, 7*16, 3*16)
	love.graphics.setColor(255,255,255,255)
	font_8x8:print(" " .. coordsdialog.print(), (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2+16, nil, 2)
	font_ui:printf(L.GOTOROOM, 0, (love.graphics.getHeight()-3*16)/2-32-3, love.graphics.getWidth(), "center", nil, 2)
	font_ui:printf(L.ESCTOCANCEL, 0, (love.graphics.getHeight()+3*16)/2+48-2, love.graphics.getWidth(), "center")
end

function coordsdialog.activate()
	coordsdialog.active = true
	coordsdialog.lettermode = false
	coordsdialog.input = ""
end

function coordsdialog.type(what)
	local input_len = coordsdialog.input:len()
	if tostring(what) == tostring(tonumber(what)) and input_len < 4 and not coordsdialog.lettermode then
		coordsdialog.input = coordsdialog.input .. what
	elseif (what == "," or what == ";") and input_len == 1 then
		coordsdialog.input = "0" .. coordsdialog.input
	elseif input_len == 0 or (input_len == 2 and coordsdialog.lettermode) and what:len() == 1 then
		-- This was mostly a silly addition, in case we added an Excel-style coordinate system
		-- in the future (A1 through T20). However, small problem: the numbers you input would
		-- still be interpreted differently depending on your coords0 setting, which is unwanted.
		-- A01 should always go to [0,0] and not sometimes [0,1].
		-- So, for now, let's not let letters and numbers mix: if you use letters you have to
		-- type AA through TT. Which is actually pretty comfortable in my opinion! And unambiguous.
		local code = what:byte()
		local letter = nil
		if code >= 0x41 and code <= 0x54 then -- A-T
			letter = code - 0x41
		elseif code >= 0x61 and code <= 0x74 then -- a-t
			letter = code - 0x61
		end
		if letter ~= nil then
			if not s.coords0 then
				letter = letter + 1
			end
			coordsdialog.input = coordsdialog.input .. string.format("%02d", letter)
			coordsdialog.lettermode = true
		end
	end
end

function coordsdialog.keyreleased()
	if coordsdialog.input:len() ~= 4 then
		return
	end

	gotoroom(
		math.min(
			math.max(
				tonumber(coordsdialog.input:sub(1,2))-(not s.coords0 and 1 or 0),
				0
			),
			level.metadata.mapwidth-1
		),
		math.min(
			math.max(
				tonumber(coordsdialog.input:sub(3,4))-(not s.coords0 and 1 or 0),
				0
			),
			level.metadata.mapheight-1
		)
	)

	coordsdialog.active = false
end

function coordsdialog.print()
	-- Ugly, but easy
	local comma
	if s.coords0 then
		comma = ","
	else
		comma = ";"
	end
	if coordsdialog.input:len() == 0 then
		return "__" .. comma .. "__"
	elseif coordsdialog.input:len() == 1 then
		return coordsdialog.input .. "_" .. comma .. "__"
	elseif coordsdialog.input:len() == 2 then
		return coordsdialog.input .. comma .. "__"
	elseif coordsdialog.input:len() == 3 then
		return coordsdialog.input:sub(1,2) .. comma .. (coordsdialog.input:sub(3,3)) .. "_"
	elseif coordsdialog.input:len() == 4 then
		return coordsdialog.input:sub(1,2) .. comma .. (coordsdialog.input:sub(3,4))
	else
		return coordsdialog.input
	end
end
