function searchtext(this)
	--[[ Searches scripts (and script names), room names and roomtext
		Returns (array)searchscripts, (array)searchrooms and (array)searchnotes (formerly searchroomtext)

		Arrays look as follows:

		searchscripts =
			{
			[1] =
				{
				name = "scriptname",
				foundline = 1, -- 0 for script name match
				foundlinecontent = "The content of the found line"
				}
			}

		searchrooms =
			{
			[1] =
				{
				x = 0,
				y = 0,
				name = "Room name if present"
				-- Maybe in a later stage add a preview of the room for a thumbnail?
				}
			}

		searchroomtext =
			{
			[1] =
				{
				x = 1, -- Just the room
				y = 1, -- in which it was found
				data = "The actual roomtext"
				}
			}

		searchnotes =
			{
			[1] =
				{
				name = "Note name",
				foundline = 1, -- 0 for note name match
				foundlinecontent = "The content of the found line" -- Maybe this needs to be truncated?
				}
			}
	]]

	searchscripts = {}; searchrooms = {}; searchnotes = {}

	if this ~= "" then
		this = escapegsub(this)

		-- Scripts
		for script_i = #scriptnames, 1, -1 do
			-- Do this in order of last edited script first.
			-- Or maybe the opposite because an oldest script might be what's harder to recall/find?
			-- Ah well, be specific for now.
			if scriptnames[script_i]:lower():find(this) ~= nil then
				table.insert(searchscripts, {name=scriptnames[script_i], foundline=0, foundlinecontent=""})
			end

			for k,v in pairs(scripts[scriptnames[script_i]]) do
				if v:lower():find(this) ~= nil then
					table.insert(searchscripts, {name=scriptnames[script_i], foundline=k, foundlinecontent=v})
				end
			end
		end

		-- Room names
		for ky,vy in pairs(levelmetadata) do
			for kx,vx in pairs(vy) do
				if vx.roomname:lower():find(this) ~= nil then
					table.insert(searchrooms, {x=kx, y=ky, name=vx.roomname})
				end
			end
		end

		-- Notes
		if vedmetadata ~= false then
			for k,v in pairs(vedmetadata.notes) do
				if v.subj:lower():find(this) ~= nil then
					table.insert(searchnotes, {name=v.subj, foundline=0, foundlinecontent=""})
				end

				-- Kind of intensive, but we shouldn't have too many notes.
				local thisexplodednote = explode("\n", v.cont)

				for k2,v2 in pairs(thisexplodednote) do
					if v2:lower():find(this) ~= nil then
						table.insert(searchnotes, {name=v.subj, foundline=k2, foundlinecontent=v2})
					end
				end
			end
		end
	end

	searchscroll = 0
	longestsearchlist = math.min(showresults, math.max(#searchscripts, #searchrooms, #searchnotes))

	return searchscripts, searchrooms, searchnotes
end

function highlightresult(text, result, x, y)
	offsetchars = 1

	result = escapegsub(result)

	-- Well then, this changed into some awkward code
	if result == "" or text:lower():find(result, 1) == nil then
		ved_print(text, x+(offsetchars-1)*8, y)
	else
		repeat
			pos, endpos = text:lower():find(result, offsetchars)
			ved_print(text:sub(offsetchars, pos-1), x+(offsetchars-1)*8, y)
			love.graphics.setColor(255,255,0,255)
			ved_print(text:sub(pos, endpos), x+(pos-1)*8, y)
			love.graphics.setColor(255,255,255,255)
			offsetchars = endpos + 1
		until text:lower():find(result, offsetchars) == nil

		ved_print(text:sub(endpos+1, -1), x+endpos*8, y)
	end
end

function inscriptsearch(this)
	-- Sets the text cursor to the first occurrence of the string after the cursor
	if this ~= "" then
		this = escapegsub(this)

		local editing_column, editing_line = newinputsys.getpos("script_lines")
		local searching_line = editing_line

		local found_line, after_found = 0, 0

		repeat
			if searching_line == editing_line then
				local line = inputs.script_lines[editing_line]
				_, after_found = line:lower():find(this, utf8.offset(line, editing_column))
			else
				_, after_found = inputs.script_lines[searching_line]:lower():find(this)
			end

			if after_found ~= nil then
				found_line = searching_line
				break
			end

			searching_line = searching_line + 1

			if searching_line > #inputs.script_lines then
				searching_line = 1
			end
		until searching_line == editing_line

		if found_line == 0 then
			-- Also search that part before the cursor, then. And after once more, but that doesn't matter.
			_, after_found = inputs.script_lines[editing_line]:lower():find(this)

			if after_found ~= nil then
				found_line = editing_line
			end
		end

		if found_line == 0 then
			-- Still not found?
			dialog.create(langkeys(L.STRINGNOTFOUND, {scriptsearchterm}))
			return
		end

		-- Jump to the line!
		scriptgotoline(found_line, after_found)
	end
end

function inhelpsearch(this)

end
