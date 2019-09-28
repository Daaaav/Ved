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

You also need to call `input.drawcaret(<id>, <x>, <y>, [scale], [limit], [align])`
with the top-left corner of whatever text you're drawing for the blinking cursor
(aka caret), after you print the text.
`[scale]` defaults to 1.
`[align]` is either ALIGN.LEFT or ALIGN.CENTER, defaults to ALIGN.LEFT.
`[align]` and `[limit]` are ignored for multiline inputs, and all multiline
inputs should be left-aligned.

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

When you're done, close it by doing `input.close(<id>)`.

]]

input = {active = false}

inputs = {}
nth_input = {}
input_ids = {}
input_ns = {}

inputpos = {}
inputflash = {}

function input.create(type_, id, initial, ix, iy)
	input.active = true

	if inputs[id] ~= nil then
		return
	end

	if type_ == INPUT.ONELINE then
		initial = tostring(anythingbutnil(initial))
	elseif type_ == INPUT.MULTILINE then
		initial = initial or {""}
		if initial == {} or type(initial) ~= "table" then
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

	inputflash[id] = 0
	input_ids[#nth_input] = id
	input_ns[id] = #nth_input
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
	inputflash[id] = nil

	if updatemappings then
		input.updatemappings()
	end

	if #nth_input == 0 then
		input.active = false
	end
end

function input.updatemappings()
	local function get_n(id)
		for n in pairs(nth_input) do
			if nth_input[n] == inputs[id] then
				return n
			end
		end
	end

	for id_ in pairs(input_ns) do
		input_ns[id_] = get_n(id_)
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
		inputflash[input_ids[#nth_input]] = 0
	end
end

function input.bump(id)
	input.active = true

	local oldn = input_ns[id]

	table.remove(nth_input, oldn)
	input_ids[oldn] = nil

	table.insert(nth_input, inputs[id])
	input_ids[#nth_input] = id
	input_ns[id] = #nth_input

	input.updatemappings()
end

function input.drawcaret(id, x, y, scale, limit, align)
	-- TODO: Can't use this in LÖVE 0.9.x and lower,
	-- due to lack of ability to get the wrapped text from Font:getWrap()
	if not love_version_meets(10) then
		return
	end

	if not input.active then
		return
	end

	if inputflash[id] > .5 then
		return
	end

	scale = scale or 1
	align = align or ALIGN.LEFT
	if type(inputs[id]) == "table" then
		align = ALIGN.LEFT
	end

	local lines = {}
	local thisfont = love.graphics.getFont()
	if type(inputs[id]) == "table" then
		lines = inputs[id]
	elseif limit ~= nil then
		-- TODO: Deal with LÖVE 0.9.x and lower, later
		_, lines = thisfont:getWrap(inputs[id], limit)
	else
		lines = {inputs[id]}
	end

	local caretx, carety = 0, 0
	if type(inputs[id]) == "table" then
		carety = inputpos[id][2]
		local thispos = 0
		local thischar = 0
		local line = inputs[id][carety]
		for _ = 1, #line do
			thispos = thispos + 1
			thischar = thischar + thisfont:getWidth(line:sub(thispos,thispos))
			if thispos == inputpos[id][1] then
				caretx = thischar
				break
			end
		end
	elseif #lines > 0 then
		local thispos = 0
		local thischar = 0
		local nested_break = false
		for n, line in pairs(lines) do
			for _ = 1, #line do
				thispos = thispos + 1
				thischar = thischar + thisfont:getWidth(line:sub(thispos,thispos))
				if thispos == inputpos[id] then
					caretx = thischar
					carety = n - 1
					nested_break = true
					break
				end
			end
			if nested_break then
				break
			end
		end
	end
	carety = carety * thisfont:getHeight() -- not accounting for other things like line height, I suppose

	love.graphics.line(x + caretx, y + carety, x + caretx, y + carety + thisfont:getHeight())
end
