--[[ A brief guide:

Create a new input by doing `input.create(<type>, <id>, [initial], [initial_x], [initial_y])`.

`<type>` is INPUT.ONELINE or INPUT.MULTILINE and `<id>` is a string
(but if you really wanted it could be anything that can be used as a table index)

`[initial]` is optional. Pass one string for oneline, or a table of strings for
multiline, to first set the input to whatever you give it.

`[initial_x]` is optional and defaults to the end of the initial line given.

`[initial_y]` is optional, is for multiline, and defaults to the first line.

Then for whatever you're editing, say a variable named `thingbeingedited`, all
you have to do is `thingbeingedited = inputs.<id>` (note the plural "inputs")

You also need to call `input.drawcas(<id>, <x>, <y>, [scale_x], [scale_y])`
with the top-left corner of whatever text you're drawing for the CAS (the
blinking cursor (aka caret), selection box, and other things) after you print
the text.
`[scale_x]` defaults to 1.
`[scale_y]` defaults to `[scale_x]`.

By default, the clicking area (the area will clicks, double-clicks, and
clicking-and-dragging will apply to the input) is set to be the current scissor
(from `love.graphics.getScissor()`), and if there is none, will just be the
smallest rectangle that surrounds the input (with 4px padding). You can
override this with `input.setmousearea(<id>, <x>, <y>, <width>, <height>)`. If
you don't want to be able to click on the input, you can effectively disable
clicking by doing `input.setmousearea(<id>, nil)`.

By default, the newline characters are set to `[\r\n]` (Lua pattern) to match
the conventional newline characters '\r' and '\n'. If you don't want this for
your input, you will need to call `input.newlinechars(<id>, <pattern>)` to set
the Lua pattern for newline characters. For example, VVVVVV input fields don't
use '\r' or '\n' as newline characters and allow these literal chars to be
embedded on a line. And especially more important, script lines use `|` as
their newline char (`$` on 3DS).

By default, the word separator is a space. You can set it to be any character
you want by doing `input.setwordseps(<id>, <sep>)`. `<sep>` can be a string, or
a table of strings to match any one of those strings (e.g. in the script
editor, you might want to set it to `{"(", ",", ")"}` to match any of the
command argument separators, unless you're in a `say`/`text` command).

If you want to blacklist or whitelist characters from your input, do
`input.blacklist(<id>, <pattern>)` or `input.whitelist(<id>, <pattern>)`
respectively. `<pattern>` is any Lua pattern, so you can (for example)
whitelist only number characters by doing `input.whitelist(<id>, "%d")`.

If you want to index by number (where the last number is the most
recently-opened input), then use `nth_input`. Use `input_ids` and `input_ns` to
convert between indexing by ID and indexing by number.

If you need the current position, for oneline it's `inputpos.<id>`
For multiline, the x-position is `inputpos.<id>[1]`,
the y-position `inputpos.<id>[2]`

When typing, the input prioritized will be the most recently-opened input.

If you need to temporarily stop taking input, just do `input.pause()`. Though
don't forget to do `input.resume()` when you want to enable it again (and don't
want to create a new input, which enables it automatically)

To focus an input so all further typing will go there, just do
`input.bump(<id>)`.

When you're done, close it by doing `input.close(<id>)`.

]]

input = {active = false}

inputs = {}
nth_input = {}
input_ids = {}
input_ns = {}

inputpos = {}
inputsrightmost = {}
inputselpos = {}

inputundo = {}
inputredo = {}

inputwordseps = {}

inputhex = {}

inputwhitelist = {}
inputblacklist = {}
inputnewlinechars = {}

inputareas = {}

function input.create(type_, id, initial, ix, iy)
	input.active = true

	if inputs[id] ~= nil then
		return
	end

	if type_ == INPUT.ONELINE then
		initial = tostring(anythingbutnil(initial))
	elseif type_ == INPUT.MULTILINE then
		initial = initial or {""}
		if #initial == 0 or type(initial) ~= "table" then
			-- wtf, why would you take the time to type {} or anything else
			-- if you want it empty?
			initial = {""}
		end
		local tmp = {}
		for k,v in pairs(initial) do
			tmp[k] = tostring(anythingbutnil(v))
		end
		initial = table.copy(tmp)
	end

	iy = iy or 1
	if ix == nil then
		if type_ == INPUT.ONELINE then
			ix = #initial
		elseif type_ == INPUT.MULTILINE then
			ix = #initial[iy]
		end
	end

	inputs[id] = initial
	table.insert(nth_input, inputs[id])
	if type_ == INPUT.ONELINE then
		inputpos[id] = ix
	elseif type_ == INPUT.MULTILINE then
		inputpos[id] = {ix, iy}
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
	input_ids[#nth_input] = id
	input_ns[id] = #nth_input
	inputsrightmost[id] = false

	inputundo[id] = {}
	inputredo[id] = {}

	input.setnewlinechars(id, "[\r\n]")
	input.setwordseps(id, " ")
end

function input.close(id, updatemappings)
	if updatemappings == nil then
		updatemappings = true
	end

	local removethisn = input_ns[id]

	table.remove(nth_input, removethisn)
	inputs[id] = nil
	table.remove(input_ids, removethisn)
	input_ns[id] = nil
	inputpos[id] = nil

	if updatemappings then
		input.updatemappings()
	end

	if #nth_input == 0 then
		input.active = false
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
	inputsrightmost[id] = nil
	inputselpos[id] = nil

	inputundo = nil
	inputredo = nil

	inputwhitelist[id] = nil
	inputblacklist[id] = nil
	inputnewlinechars[id] = nil

	inputareas[id] = nil
end

function input.updatemappings()
	for n, id in pairs(input_ids) do
		input_ns[id] = n
	end
end

function input.closeall()
	for id in pairs(inputs) do
		input.close(id, false)
	end
end

function input.pause()
	input.active = false
end

function input.resume()
	if #nth_input > 0 then
		input.active = true
		cursorflashtime = 0
		inputcopiedtimer = 0
	end
end

function input.bump(id)
	input.active = true

	local oldn = input_ns[id]

	table.remove(nth_input, oldn)
	table.insert(nth_input, inputs[id])

	table.remove(input_ids, oldn)
	table.insert(input_ids, id)

	input.updatemappings()

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.drawcas(id, x, y, sx, sy)
	if not input.active then
		return
	end

	-- This function draws: the caret, the selection box, and the hexadecimal input
	-- This function also handles clicking, double-clicking, and clicking-and-dragging on text

	-- Make sure we're drawing the cas of the currently focused input
	if id ~= input_ids[#nth_input] then
		return
	end

	local multiline = type(inputs[id]) == "table"

	sx = sx or 1
	sy = sy or sx

	local thisfont = love.graphics.getFont()

	-- Clicking

	local area = inputareas[id]
	if area == nil then
		area = {love.graphics.getScissor()}
		if #area == 0 then -- Table is empty because getScissor() returned all nils because there's no scissor
			local width
			if multiline then
				local tmp = {}
				for _, l in pairs(inputs[id]) do
					table.insert(tmp, thisfont:getWidth(l))
				end
				width = math.max(unpack(tmp))
			else
				width = thisfont:getWidth(inputs[id])
			end

			local lines
			if multiline then
				lines = #inputs[id]
			else
				lines = 1
			end
			local height = thisfont:getHeight() * lines

			width = width * sx
			height = height * sy

			area = {x-4, y-4, width+8, height+8} -- 4px of padding added to be nice
		end
	end

	local mouseoninput
	if area ~= nil and #area > 0 then
		mouseoninput = mouseon(unpack(area))
	end

	if mouseoninput then
		love.mouse.setCursor(text_cursor)

		if love.mouse.isDown("l") then
			input.mousepressed(id, x, y, sx, sy)
		end
	else
		love.mouse.setCursor()
	end

	-- Selection

	if inputselpos[id] ~= nil then
		local selrects = {} -- each table in this table: {x (pixels), y (line), width (pixels)}
		local whichfirst -- 1 = caret pos, 2 = selection pos
		local startx, starty, endx, endy

		if multiline then
			local lines = inputs[id]
			local curx, cury = unpack(inputpos[id])
			local selx, sely = unpack(inputselpos[id])
			if inputsrightmost[id] then
				curx = utf8.len(lines[cury])
			end

			if cury < sely then
				whichfirst = 1
			elseif sely < cury then
				whichfirst = 2
			elseif curx < selx then
				whichfirst = 1
			elseif selx < curx then
				whichfirst = 2
			end

			if whichfirst == 1 then
				startx, starty = curx, cury
				endx, endy = selx, sely
			elseif whichfirst == 2 then
				startx, starty = selx, sely
				endx, endy = curx, cury
			end

			local curlinewidth = 0
			local firstoffset = 0

			local line

			local nested_break = false
			if whichfirst ~= nil then
				for l = starty, endy do
					line = lines[l]

					if l == starty then
						firstoffset = thisfont:getWidth(utf8.sub(line, 1, startx))
						if l == endy then
							curlinewidth = thisfont:getWidth(utf8.sub(line, startx+1, endx))
						else
							curlinewidth = thisfont:getWidth(utf8.sub(line, startx+1, utf8.len(line)))
							-- Add a small space to represent the newline
							curlinewidth = curlinewidth + 4
						end
						table.insert(selrects, {firstoffset, l-1, curlinewidth})
					else
						if l == endy then
							curlinewidth = thisfont:getWidth(utf8.sub(line, 1, endx))
						else
							curlinewidth = thisfont:getWidth(utf8.sub(line, 1, utf8.len(line)))
							-- Again, add a small space to represent the newline
							curlinewidth = curlinewidth + 4
						end
						table.insert(selrects, {0, l-1, curlinewidth})
					end
				end
			end
		else
			local line = inputs[id]
			local curx = inputpos[id]
			local selx = inputselpos[id]
			if inputsrightmost[id] then
				curx = utf8.len(line)
			end

			if curx < selx then
				whichfirst = 1
			elseif selx < curx then
				whichfirst = 2
			end

			if whichfirst == 1 then
				startx, endx = curx, selx
			elseif whichfirst == 2 then
				startx, endx = selx, curx
			end

			local curlinewidth = 0
			local firstoffset = 0

			if whichfirst ~= nil then
				firstoffset = thisfont:getWidth(utf8.sub(line, 1, startx))
				curlinewidth = thisfont:getWidth(utf8.sub(line, startx+1, endx))
				table.insert(selrects, {firstoffset, 0, curlinewidth})
			end
		end

		local oldcol = {love.graphics.getColor()}

		love.graphics.setColor(0, 127, 255, 127) -- Blue-ish, like a typical selection
		if inputcopiedtimer > 0 then
			love.graphics.setColor(255, 255, 127, 127) -- To let the user know they've copied the text
		end

		for _, rect in pairs(selrects) do
			love.graphics.rectangle("fill", x + rect[1]*sx, y + rect[2]*thisfont:getHeight()*sy, rect[3]*sx, thisfont:getHeight()*sy)
		end

		love.graphics.setColor(unpack(oldcol))
	end

	-- Caret

	if cursorflashtime > .5 and inputhex[id] == nil then
		return
	end

	local caretx, carety
	if multiline then
		carety = inputpos[id][2]
		local line = inputs[id][carety]
		local postoget = inputpos[id][1]
		if inputsrightmost[id] then
			postoget = utf8.len(line)
		end
		-- If we're coming from a line with more chars,
		-- treat it like it's at the end of the line
		postoget = math.min(postoget, utf8.len(line))

		caretx = thisfont:getWidth(utf8.sub(line, 1, postoget))
	else
		local line = inputs[id]
		local postoget = inputpos[id]
		if inputsrightmost[id] then
			postoget = utf8.len(line)
		end
		carety = 0

		caretx = thisfont:getWidth(utf8.sub(line, 1, postoget))
	end
	caretx = anythingbutnil0(caretx)
	carety = anythingbutnil0(carety)

	if multiline then
		carety = carety - 1 -- We've been doing our calculations as 1-indexing up until this point...
	end

	carety = carety * thisfont:getHeight() -- not accounting for other things like line height, I suppose

	caretx = caretx * sx
	carety = carety * sy

	-- Hex input, before the caret is actually drawn so it doesn't get in the way

	if inputhex[id] ~= nil then
		-- Not really the best look, but I don't want to reposition the caret,
		-- so I have to stop rendering it or cover it up somehow

		local oldcol = {love.graphics.getColor()}

		local prefix = "u" -- not like we're gonna change it LOL

		local text = prefix .. inputhex[id]

		local invertcol = {oldcol[1] - 255, oldcol[2] - 255, oldcol[3] - 255, oldcol[4]}
		love.graphics.setColor(unpack(invertcol))
		love.graphics.rectangle("fill", x + caretx, y + carety, thisfont:getWidth(text)*sx, thisfont:getHeight()*sy)

		love.graphics.setColor(unpack(oldcol))

		love.graphics.rectangle("line", x + caretx, y + carety, thisfont:getWidth(text)*sx, thisfont:getHeight()*sy)

		ved_print(text, x + caretx, y + carety, sx, sy)
		--love.graphics.line(x + caretx, y + carety + thisfont:getHeight()*sy, x + caretx + thisfont:getWidth(prefix)*sx, y + carety + thisfont:getHeight()*sy)
	elseif cursorflashtime <= .5 then
		love.graphics.line(x + caretx, y + carety, x + caretx, y + carety + thisfont:getHeight()*sy)
	end
end

function input.movex(id, chars)
	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	x = math.min(math.max(x, 0), utf8.len(line))
	x = x + chars
	x = math.min(math.max(x, 0), utf8.len(line))

	if multiline then
		inputpos[id][1] = x
	else
		inputpos[id] = x
	end

	cursorflashtime = 0
	inputcopiedtimer = 0

	inputsrightmost[id] = false

	if inputselpos[id] ~= nil then
		local conditional
		if multiline then
			conditional = x == inputselpos[id][1] and y == inputselpos[id][2]
		else
			conditional = x == inputselpos[id]
		end
		if conditional then
			input.clearselpos(id)
		end
	end
end

function input.movey(id, chars)
	local multiline = type(inputs[id]) == "table"

	if not multiline then
		if inputselpos[id] ~= nil then
			input.clearselpos(id)
		end
		return
	end

	local lines = inputs[id]
	local x, y = unpack(inputpos[id])

	if inputsrightmost[id] then
		x = utf8.len(inputs[id][y])
	end

	y = y + chars
	y = math.min(math.max(y, 1), #lines)

	inputpos[id][2] = y

	cursorflashtime = 0
	inputcopiedtimer = 0

	if inputselpos[id] ~= nil and x == inputselpos[id][1] and y == inputselpos[id][2] then
		input.clearselpos(id)
	end
end

function input.leftmost(id)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		inputpos[id][1] = 0
	else
		inputpos[id] = 0
	end

	cursorflashtime = 0
	inputcopiedtimer = 0

	inputsrightmost[id] = false

	if inputselpos[id] ~= nil then
		local conditional
		if multiline then
			conditional = inputpos[id][1] == inputselpos[id][1] and inputpos[id][2] == inputselpos[id][2]
		else
			conditional = inputpos[id] == inputselpos[id]
		end
		if conditional then
			input.clearselpos(id)
		end
	end
end

function input.rightmost(id)
	local multiline = type(inputs[id]) == "table"

	inputsrightmost[id] = true

	cursorflashtime = 0
	inputcopiedtimer = 0

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	x = utf8.len(line)

	if inputselpos[id] ~= nil then
		local conditional
		if multiline then
			conditional = x == inputselpos[id][1] and y == inputselpos[id][2]
		else
			conditional = x == inputselpos[id]
		end
		if conditional then
			input.clearselpos(id)
		end
	end
end

function input.deletechars(id, chars)
	if chars == 0 then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local x, y, line
	for _ = 1, math.abs(chars) do
		if multiline then
			x, y = unpack(inputpos[id])
			line = inputs[id][y]
		else
			x = inputpos[id]
			line = inputs[id]
		end

		if inputsrightmost[id] then
			x = utf8.len(line)
		end

		x = math.min(math.max(x, 0), utf8.len(line))

		if chars > 0 then
			if x == utf8.len(line) then
				if multiline and y < #inputs[id] then
					inputs[id][y] = inputs[id][y] .. inputs[id][y+1]
					table.remove(inputs[id], y+1)
				end
			else
				if multiline then
					inputs[id][y] = utf8.sub(inputs[id][y], 1, x) .. utf8.sub(inputs[id][y], x+2, utf8.len(inputs[id][y]))
				else
					inputs[id] = utf8.sub(inputs[id], 1, x) .. utf8.sub(inputs[id], x+2, utf8.len(inputs[id]))
				end
			end
		else
			if x == 0 then
				if multiline and y > 1 then
					local len_oldline = utf8.len(inputs[id][y-1])
					inputs[id][y] = inputs[id][y-1] .. inputs[id][y]
					table.remove(inputs[id], y-1)
					y = y - 1
					x = len_oldline
				end
			else
				if multiline then
					inputs[id][y] = utf8.sub(inputs[id][y], 1, x-1) .. utf8.sub(inputs[id][y], x+1, utf8.len(inputs[id][y]))
				else
					inputs[id] = utf8.sub(inputs[id], 1, x-1) .. utf8.sub(inputs[id], x+1, utf8.len(inputs[id]))
				end
				x = x - 1
			end
		end

		if multiline then
			inputpos[id] = {x, y}
		else
			inputpos[id] = x
		end

		inputsrightmost[id] = false
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.insertchars(id, text)
	if inputwhitelist[id] ~= nil then
		local tmp = {}
		for char in text:gmatch(inputwhitelist[id]) do
			table.insert(tmp, char)
		end
		text = table.concat(tmp)
	end

	if inputblacklist[id] ~= nil then
		text = text:gsub(inputblacklist[id], "")
	end

	if inputnewlinechars[id] ~= nil then
		local lines = text:split(inputnewlinechars[id])
		if #lines == 1 then
			input.actualinsertchars(id, lines[1])
			return
		end

		for l, line in pairs(lines) do
			if l ~= 1 then
				input.newline(id)
			end
			input.actualinsertchars(id, line)
		end
	else
		input.actualinsertchars(id, text)
	end
end

function input.actualinsertchars(id, text)
	if text == "" then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	line = utf8.sub(line, 1, x) .. text .. utf8.sub(line, x+1, utf8.len(line))

	if x < utf8.len(line) then
		x = x + utf8.len(text)
		x = math.min(x, utf8.len(line))
	end

	if multiline then
		inputpos[id] = {x, y}
		inputs[id][y] = line
	else
		inputs[id] = line
		inputpos[id] = x
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.newline(id)
	local multiline = type(inputs[id]) == "table"

	if not multiline then
		return
	end

	local x, y = unpack(inputpos[id])
	local line = inputs[id][y]

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	local restofline = utf8.sub(line, x+1, utf8.len(line))

	table.insert(inputs[id], y+1, restofline)
	inputs[id][y] = utf8.sub(line, 1, x)

	x = 0
	y = y + 1

	inputpos[id] = {x, y}

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.setselpos(id)
	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	x = math.min(math.max(x, 0), utf8.len(line))

	if multiline then
		inputselpos[id] = {x, y}
	else
		inputselpos[id] = x
	end
end

function input.clearselpos(id)
	inputselpos[id] = nil
end

function input.getseltext(id)
	if inputselpos[id] == nil then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local whichfirst -- 1 = caret pos, 2 = selection pos
	local startx, starty, endx, endy

	local rope = {}

	if multiline then
		local curx, cury = unpack(inputpos[id])
		local selx, sely = unpack(inputselpos[id])
		local lines = inputs[id]
		if inputsrightmost[id] then
			curx = utf8.len(lines[cury])
		end

		if cury < sely then
			whichfirst = 1
		elseif sely < cury then
			whichfirst = 2
		elseif curx < selx then
			whichfirst = 1
		elseif selx < curx then
			whichfirst = 2
		end

		if whichfirst == 1 then
			startx, starty = curx, cury
			endx, endy = selx, sely
		elseif whichfirst == 2 then
			startx, starty = selx, sely
			endx, endy = curx, cury
		end

		if whichfirst == nil then
			return ""
		end

		local line
		local thischar

		local nested_break = false
		for l = starty, endy do
			line = lines[l]
			if l == starty then
				if l == endy then
					table.insert(rope, utf8.sub(line, startx+1, endx))
				else
					table.insert(rope, utf8.sub(line, startx+1, utf8.len(line)))
				end
			else
				if l == endy then
					table.insert(rope, utf8.sub(line, 1, endx))
				else
					table.insert(rope, utf8.sub(line, 1, utf8.len(line)))
				end
			end

			if l < endy then
				table.insert(rope, newline)
			end
		end
	else
		local curx = inputpos[id]
		local selx = inputselpos[id]
		if inputsrightmost[id] then
			curx = utf8.len(inputs[id])
		end

		if curx < selx then
			whichfirst = 1
		elseif selx < curx then
			whichfirst = 2
		end

		if whichfirst == 1 then
			startx, endx = curx, selx
		elseif whichfirst == 2 then
			startx, endx = selx, curx
		end

		if whichfirst == nil then
			return ""
		end

		local thischar
		local line = inputs[id]

		table.insert(rope, utf8.sub(line, startx+1, endx))
	end

	return table.concat(rope)
end

function input.delseltext(id)
	if inputselpos[id] == nil then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local whichfirst -- 1 = caret pos, 2 = selection pos
	local startx, starty, endx, endy

	local deletethismanychars = 0

	if multiline then
		local curx, cury = unpack(inputpos[id])
		local selx, sely = unpack(inputselpos[id])
		local lines = inputs[id]
		if inputsrightmost[id] then
			curx = utf8.len(lines[cury])
		end

		if cury < sely then
			whichfirst = 1
		elseif sely < cury then
			whichfirst = 2
		elseif curx < selx then
			whichfirst = 1
		elseif selx < curx then
			whichfirst = 2
		end

		if whichfirst == 1 then
			startx, starty = curx, cury
			endx, endy = selx, sely
		elseif whichfirst == 2 then
			startx, starty = selx, sely
			endx, endy = curx, cury
		end

		if whichfirst == nil then
			return
		end

		local line

		local nested_break = false
		for l = starty, endy do
			line = lines[l]
			for thispos = 1, utf8.len(line) do
				if (l ~= endy or endx ~= 0) and (l > starty or thispos > startx) then
					deletethismanychars = deletethismanychars + 1
				end

				if l == endy and thispos == endx then
					nested_break = true
					break
				end
			end

			if nested_break then
				break
			end
		end

		-- Delete the newlines
		deletethismanychars = deletethismanychars + endy - starty
	else
		local curx = inputpos[id]
		local selx = inputselpos[id]
		if inputsrightmost[id] then
			curx = utf8.len(inputs[id])
		end

		if curx < selx then
			whichfirst = 1
		elseif selx < curx then
			whichfirst = 2
		end

		if whichfirst == 1 then
			startx, endx = curx, selx
		elseif whichfirst == 2 then
			startx, endx = selx, curx
		end

		if whichfirst == nil then
			return
		end

		deletethismanychars = endx - startx
	end

	if whichfirst == 1 then
		input.deletechars(id, deletethismanychars)
	elseif whichfirst == 2 then
		input.deletechars(id, -deletethismanychars)
	end

	input.clearselpos(id)
end

function input.setpos(id, x, y)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		inputpos[id] = {x, y}
	else
		inputpos[id] = x
	end

	inputsrightmost[id] = false
end

function input.selallright(id)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		input.setpos(id, 0, 1)
		input.setselpos(id)
		inputpos[id][2] = #inputs[id]
		inputsrightmost[id] = true
	else
		input.setpos(id, 0)
		input.setselpos(id)
		inputsrightmost[id] = true
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.selallleft(id)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		input.setpos(id, 0, #inputs[id])
		inputsrightmost[id] = true
		input.setselpos(id)
		input.setpos(id, 0, 1)
	else
		inputsrightmost[id] = true
		input.setselpos(id)
		input.setpos(id, 0)
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.deltoleftmost(id)
	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	if x == 0 then
		-- Fast path: we're already at the left end, so we don't need to do anything
		return
	end

	input.deletechars(id, -x)

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.deltorightmost(id)
	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		-- Fast path: This is already cleared, so we don't need to do anything
		return
	end

	if x == utf8.len(line) then
		-- Again, fast path, already cleared, don't need to do anything
		return
	end

	input.deletechars(id, utf8.len(line) - x)

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.removelines(id, lines)
	if lines == 0 then
		return
	end

	local multiline = type(inputs[id]) == "table"

	if not multiline then
		inputs[id] = ""
		cursorflashtime = 0
		inputcopiedtimer = 0
		return
	end

	local y = inputpos[id][2]
	for _ = 1, math.abs(lines) do
		if #inputs[id] > 1 then
			table.remove(inputs[id], y)
		else
			inputs[id][y] = ""
		end

		if lines > 0 then
			if y > #inputs[id] and y > 1 then
				y = y - 1
			end
		else
			y = math.max(y - 1, 1)
		end
	end

	inputpos[id][2] = y

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.sellinetoright(id)
	input.leftmost(id)
	input.setselpos(id)
	input.rightmost(id)
end

function input.sellinetoleft(id)
	input.rightmost(id)
	input.setselpos(id)
	input.leftmost(id)
end

function input.unre(id, oldinput, oldpos, oldrightmost, oldselpos)
	-- Insert an undoable action into the input's undo buffer
	inputredo[id] = {}

	local multiline = type(inputs[id]) == "table"

	local old
	if multiline then
		local oldinput2 = table.copy(oldinput)
		local oldpos2 = table.copy(oldpos)
		local oldselpos2
		if oldselpos ~= "" then
			oldselpos2 = table.copy(oldselpos)
		else
			oldselpos2 = ""
		end
		old = {oldinput2, oldpos2, oldrightmost, oldselpos2}
	else
		old = {oldinput, oldpos, oldrightmost, oldselpos}
	end

	local new
	if multiline then
		local newinput = table.copy(inputs[id])
		local newpos = table.copy(inputpos[id])
		local newselpos
		if inputselpos[id] ~= nil then
			newselpos = table.copy(inputselpos[id])
		else
			newselpos = ""
		end
		new = {newinput, newpos, inputsrightmost[id], newselpos}
	else
		local newselpos
		if inputselpos[id] ~= nil then
			newselpos = inputselpos[id]
		else
			newselpos = ""
		end
		new = {inputs[id], inputpos[id], inputsrightmost[id], newselpos}
	end

	table.insert(inputundo[id], {old = old, new = new})
end

function input.getstate(id)
	-- Not really a pure getstate, selpos will have to be "" because tables and nil don't mix
	-- (and it can't be -1 because numbers are already used for oneline positions)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		local stateinput = table.copy(inputs[id])
		local statepos = table.copy(inputpos[id])
		local stateselpos
		if inputselpos[id] ~= nil then
			stateselpos = table.copy(inputselpos[id])
		else
			stateselpos = ""
		end
		return stateinput, statepos, inputsrightmost[id], stateselpos
	else
		local stateselpos
		if inputselpos[id] ~= nil then
			stateselpos = inputselpos[id]
		else
			stateselpos = ""
		end
		return inputs[id], inputpos[id], inputsrightmost[id], stateselpos
	end
end

function input.tothisstate(id, state)
	local multiline = type(inputs[id]) == "table"

	if multiline then
		inputs[id] = table.copy(state[1])
		inputpos[id] = table.copy(state[2])
		inputsrightmost[id] = state[3]
		if state[4] ~= "" then
			inputselpos[id] = table.copy(state[4])
		else
			inputselpos[id] = nil
		end
	else
		inputs[id], inputpos[id], inputsrightmost[id], inputselpos[id] = unpack(state)
		if state[4] == "" then
			inputselpos[id] = nil
		end
	end

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.undo(id)
	if #inputundo[id] == 0 then
		return
	end

	local last = table.copy(inputundo[id][#inputundo[id]])

	input.tothisstate(id, last.old)

	table.remove(inputundo[id])
	table.insert(inputredo[id], table.copy(last))
end

function input.redo(id)
	if #inputredo[id] == 0 then
		return
	end

	local last = table.copy(inputredo[id][#inputredo[id]])

	input.tothisstate(id, last.new)

	table.remove(inputredo[id])
	table.insert(inputundo[id], table.copy(last))
end

function input.setwordseps(id, sep)
	if anythingbutnil(sep) ~= "" then
		inputwordseps[id] = sep
	end
end

function input.charsofoneword(issep, line, x, words)
	-- We have to use the somewhat inelegant "loop through each char of the string"
	-- instead of using something fancier like string.find()
	-- because string.find() isn't UTF-8 aware!
	-- (Also I'm not copypasting in / stealing yet another function from yet another library, fuck that shit)

	-- It'd be un-useful if we kept searching for separators when we're already on one
	local ignoreseps
	if words > 0 then
		ignoreseps = issep(utf8.sub(line, x + 1, x + 1))
	else
		ignoreseps = issep(utf8.sub(line, x, x))
	end
	local sepfound = false

	local counter = 0
	if words > 0 then
		for pos = x + 1, utf8.len(line) do
			if issep(utf8.sub(line, pos, pos)) then
				if not ignoreseps then
					x = pos - 1
					sepfound = true
					break
				else
					counter = counter + 1
				end
			else
				-- We've stumbled upon the actual next word, stop ignoring separators!
				ignoreseps = false
				counter = counter + 1
			end
		end

		if not sepfound then
			-- Must be at the end of the line
			counter = utf8.len(line) - x
		end
	else
		for pos = x, 1, -1 do
			if issep(utf8.sub(line, pos, pos)) then
				if not ignoreseps then
					x = pos
					sepfound = true
					break
				else
					counter = counter - 1
				end
			else
				-- New word detected
				ignoreseps = false
				counter = counter - 1
			end
		end

		if not sepfound then
			-- The word's at the end of the line
			counter = -x
		end
	end

	return counter
end

function input.movexwords(id, words)
	if words == 0 then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	if (words > 0 and x == utf8.len(line)) or (words < 0 and x == 0) then
		cursorflashtime = 0
		inputcopiedtimer = 0
		return
	end

	local wordsep = inputwordseps[id]

	local issep
	if type(wordsep) == "table" then
		issep = function(thing)
			return table.contains(wordsep, thing)
		end
	else
		issep = function(thing)
			return wordsep == thing
		end
	end

	for _ = 1, math.abs(words) do
		local counter = input.charsofoneword(issep, line, x, words)

		input.movex(id, counter)

		if multiline then
			x = inputpos[id][1]
		else
			x = inputpos[id]
		end
	end
end

function input.deletewords(id, words)
	-- The same as the above, except we use one different function

	if words == 0 then
		return
	end

	local multiline = type(inputs[id]) == "table"

	local x, y, line
	if multiline then
		x, y = unpack(inputpos[id])
		line = inputs[id][y]
	else
		x = inputpos[id]
		line = inputs[id]
	end

	if inputsrightmost[id] then
		x = utf8.len(line)
	end

	if (words > 0 and x == utf8.len(line)) or (words < 0 and x == 0) then
		cursorflashtime = 0
		inputcopiedtimer = 0
		return
	end

	local wordsep = inputwordseps[id]

	local issep
	if type(wordsep) == "table" then
		issep = function(thing)
			return table.contains(wordsep, thing)
		end
	else
		issep = function(thing)
			return wordsep == thing
		end
	end

	for _ = 1, math.abs(words) do
		local counter = input.charsofoneword(issep, line, x, words)

		input.deletechars(id, counter)

		if multiline then
			x = inputpos[id][1]
		else
			x = inputpos[id]
		end
	end
end

function input.starthex(id)
	inputhex[id] = ""
end

function input.stophex(id)
	inputhex[id] = nil

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.inserthexchars(id, text)
	local tmp = {}
	for char in text:gmatch("%x") do
		table.insert(tmp, char)
	end
	text = table.concat(tmp)

	inputhex[id] = inputhex[id] .. text

	inputhex[id] = inputhex[id]:sub(1, 8)

	cursorflashtime = 0
	inputcopiedtimer = 0
end

function input.deletehexchars(id, chars)
	-- Since you can only delete backwards, positive chars means backwards

	cursorflashtime = 0
	inputcopiedtimer = 0

	if chars == 0 then
		return
	end

	if chars > #inputhex[id] then
		input.stophex(id)
		return
	end

	if chars == #inputhex[id] then
		inputhex[id] = ""
		return
	end

	inputhex[id] = inputhex[id]:sub(1, #inputhex[id]-chars)
end

function input.finishhex(id)
	cursorflashtime = 0
	inputcopiedtimer = 0

	if anythingbutnil(inputhex[id]) == "" then
		input.stophex(id)
		return
	end

	local hex = tonumber(inputhex[id], 16)

	local MAXUNICODE = 0x10FFFF -- Magic constant, please don't forget to update if it updates

	if hex <= MAXUNICODE and hex ~= 0 --[[ we don't want nulls ]] then
		local char = utf8.char(hex)
		if inputselpos[id] ~= nil then
			input.delseltext(id)
		end
		input.insertchars(id, char)
	end

	input.stophex(id)
end

function input.whitelist(id, pattern)
	inputwhitelist[id] = pattern
end

function input.blacklist(id, pattern)
	inputblacklist[id] = pattern
end

function input.setnewlinechars(id, pattern)
	inputnewlinechars[id] = pattern
end

function input.setmousearea(id, ...)
	inputareas[id] = {...}
end

function input.mousepressed(id, x, y, sx, sy)
	local multiline = type(inputs[id]) == "table"
	local thisfont = love.graphics.getFont()

	if not keyboard_eitherIsDown("shift") and not mousepressed then
		input.clearselpos(id)
	end

	local posx, posy, line
	local mousex, mousey = love.mouse.getPosition()
	mousex = (mousex-x) / sx
	mousey = (mousey-y) / sy
	if multiline then
		posy = math.floor(mousey/thisfont:getHeight()) + 1
		posy = math.min(math.max(posy, 1), #inputs[id])
		line = inputs[id][posy]
	else
		line = inputs[id]
	end

	mousex = math.min(math.max(mousex, 0), thisfont:getWidth(line))

	local currentx = 0
	local thiswidth
	for thispos = 1, utf8.len(line) do
		thiswidth = thisfont:getWidth(utf8.sub(line, thispos, thispos))
		currentx = currentx + thiswidth

		if currentx - thiswidth/2 > mousex then
			posx = thispos - 1
			break
		end
	end

	if posx == nil then
		-- We've ruled out that the mouse is on the leftmost side,
		-- and we haven't reached the mouse even though we've gone through the entire line...
		-- The mouse must be on the rightmost end of the line!
		posx = utf8.len(line)
	end

	if multiline then
		inputpos[id] = {posx, posy}
	else
		inputpos[id] = posx
	end

	-- We want to reset the timer on the first click, but not when we're holding it
	if not mousepressed then
		inputcopiedtimer = 0
	end

	if inputdoubleclicktimer > 0 and not mousepressed then
		-- Double-click to select the word

		-- Copied from input.movexwords, bleh
		local wordsep = inputwordseps[id]

		local issep
		if type(wordsep) == "table" then
			issep = function(thing)
				return table.contains(wordsep, thing)
			end
		else
			issep = function(thing)
				return wordsep == thing
			end
		end

		if issep(utf8.sub(line, posx+1, posx+1)) then
			-- Do this highly complicated maneuver to select the space in between the words
			input.movexwords(id, -1)
			input.movexwords(id, 1)
			input.setselpos(id)
			input.movexwords(id, 1)
			input.movexwords(id, -1)
		else
			input.movexwords(id, -1)
			input.setselpos(id)
			input.movexwords(id, 1)
		end

		-- ???
		-- Seems like if this isn't constantly set to some nonzero value,
		-- if you keep holding down left-click when the timer runs out
		-- it'll cancel your double-click selection
		inputdoubleclicktimer = .1
	elseif not mousepressed then
		mousepressed = true
		inputdoubleclicktimer = .25
		input.setselpos(id)
	end

	inputsrightmost[id] = false

	cursorflashtime = 0
end
