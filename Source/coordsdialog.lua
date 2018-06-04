coordsdialog =
{
	active = false,
	input = ""
}
function coordsdialog.draw()
	love.graphics.setColor(64,64,64,128)
	love.graphics.rectangle("fill", (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2, 7*16, 3*16)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setFont(font16)
	love.graphics.print(" " .. coordsdialog.print(), (love.graphics.getWidth()-7*16)/2, (love.graphics.getHeight()-3*16)/2+16+3)
	love.graphics.setFont(font8)
end

function coordsdialog.activate()
	coordsdialog.active = true
	coordsdialog.input = ""
end

function coordsdialog.type(what)
	if tostring(what) == tostring(tonumber(what)) then
		coordsdialog.input = coordsdialog.input .. what
	end

	if coordsdialog.input:len() == 4 then
		gotoroom(
			math.min(math.max(tonumber(coordsdialog.input:sub(1,2))-(not s.coords0 and 1 or 0), 0), metadata.mapwidth-1),
			math.min(math.max(tonumber(coordsdialog.input:sub(3,4))-(not s.coords0 and 1 or 0), 0), metadata.mapheight-1)
		)

		coordsdialog.active = false
	end
end

function coordsdialog.print()
	-- Ugly, but easy
	if coordsdialog.input:len() == 0 then
		return "__,__"
	elseif coordsdialog.input:len() == 1 then
		return coordsdialog.input .. "_,__"
	elseif coordsdialog.input:len() == 2 then
		return coordsdialog.input .. ",__"
	elseif coordsdialog.input:len() == 3 then
		return coordsdialog.input:sub(1,2) .. "," .. (coordsdialog.input:sub(3,3)) .. "_"
	elseif coordsdialog.input:len() == 4 then
		return coordsdialog.input:sub(1,2) .. "," .. (coordsdialog.input:sub(3,4))
	else
		return coordsdialog.input
	end
end
