function returnusedflags(usedflagsA, outofrangeflagsA, specificflag, specificflag_usages)
	-- if specificflag is not given, then all used flags will be stored in usedflagsA and outofrangeflagsA.
	-- else, a list of script names is put in specificflag_usages, which is all usages of that flag,
	-- and the number of usages is returned (including multiple usages in the same script).
	local specificflag_n_real_usages = 0
	for rvnum = #scriptnames, 1, -1 do
		local script_inserted = false
		for k,v in pairs(scripts[scriptnames[rvnum]]) do
			local explcommaline = explode(",", string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", ""))

			if (
				explcommaline[1] == "flag"
				or explcommaline[1] == "ifflag"
				or explcommaline[1] == "customifflag"
			) and explcommaline[2] ~= nil and tonumber(explcommaline[2]) ~= nil then
				if specificflag == nil then
					usedflagsA[tonumber(explcommaline[2])] = true

					if tonumber(explcommaline[2]) < 0 or tonumber(explcommaline[2]) > 99 then
						outofrangeflagsA[tonumber(explcommaline[2])] = true
					end
				elseif specificflag == tonumber(explcommaline[2]) then
					specificflag_n_real_usages = specificflag_n_real_usages + 1

					if not script_inserted then
						table.insert(specificflag_usages, scriptnames[rvnum])
						script_inserted = true
					end
				end
			end
		end
	end

	return specificflag_n_real_usages
end

function syntaxhl(text, x, y, thisistext, addcursor, docolor)
	local thisiscomment = text:sub(1,1) == "#" or text:sub(1,2) == "//"
	if thisistext or thisiscomment then
		_= docolor and setColorArr(thisistext and s.syntaxcolor_textbox or s.syntaxcolor_comment)
		love.graphics.print(text, x, y)
		offsetchars = string.len(text) + 1

		if addcursor then
			setColorArr(s.syntaxcolor_cursor)
			love.graphics.print(__, x+((offsetchars-1)*(textsize and 16 or 8)), y)
		end

		return nil
	else
		offsetchars = 0

		--if text ~= "" then
		-- Replace characters by one with which we will split.
		text2 = string.gsub(string.gsub(string.gsub(text, "%(", ","), "%)", ","), " ", ",")

		partss = explode(",", text2)

		for k,v in pairs(partss) do
			if offsetchars == 0 then -- First word on the line, so it's a command.
				-- But is it recognized?
				if (addcursor and #partss == 1) or knowncommands[v] or knowninternalcommands[v] then
					_= docolor and setColorArr(s.syntaxcolor_command)
				else
					_= docolor and setColorArr(s.syntaxcolor_errortext)
				end
			elseif tostring(tonumber(v)) == tostring(v) then -- It's a number!
				_= docolor and setColorArr(s.syntaxcolor_number)
			--elseif string.sub(v, 1, 1) == "$" then
			elseif k == 2 and (partss[1] == "flag" or partss[1] == "ifflag" or partss[1] == "customifflag") and tostring(tonumber(v)) ~= tostring(v) then
				-- if flag name is not used yet, newflagname
				for fl = 0, 99 do
					if vedmetadata ~= false and vedmetadata.flaglabel[fl] == v then
						_= docolor and setColorArr(s.syntaxcolor_flagname)
						break
					end

					_= docolor and setColorArr(s.syntaxcolor_newflagname)
				end
			else
				_= docolor and setColorArr(s.syntaxcolor_generic)
			end
			love.graphics.print(v, x+(offsetchars*(textsize and 16 or 8)), y)

			_= docolor and setColorArr(s.syntaxcolor_separator)
			love.graphics.print(string.sub(text, 1+offsetchars+string.len(v), 1+offsetchars+string.len(v)), x+(offsetchars*(textsize and 16 or 8))+(string.len(v)*(textsize and 16 or 8)), y)

			offsetchars = offsetchars + (string.len(v)+1)
		end

		if addcursor then
			setColorArr(s.syntaxcolor_cursor)
			love.graphics.print(__, x+((offsetchars-1)*(textsize and 16 or 8)), y)
		end

		if partss[1] == "say" or partss[1] == "reply" then
			if partss[2] == nil then
				return 1
			else
				return tonumber(partss[2])
			end
		elseif partss[1] == "text" then
			if partss[5] == nil then
				return 1
			else
				return tonumber(partss[5])
			end
		end
	end
	--end
end

function justtext(text, thisistext)
	if not thisistext then
		if text:sub(1, 3) == "say" or text:sub(1, 5) == "reply" or text:sub(1, 4) == "text" then
			text2 = string.gsub(string.gsub(string.gsub(text, "%(", ","), "%)", ","), " ", ",")

			partss = explode(",", text2)

			if partss[1] == "say" or partss[1] == "reply" then
				if partss[2] == nil then
					return 1
				else
					return tonumber(partss[2])
				end
			elseif partss[1] == "text" then
				if partss[5] == nil then
					return 1
				else
					return tonumber(partss[5])
				end
			end
		end

		return nil -- also redundant
	end

	return nil -- redundant
end

function scriptcontext(text)
	local text2 = string.gsub(string.gsub(string.gsub(anythingbutnil(text), "%(", ","), "%)", ","), " ", "")

	parts = explode(",", text2)

	if parts[1] == "flag" and parts[2] ~= nil then
		return "flag", tonumber(parts[2]), nil
	elseif (parts[1] == "iftrinkets" or parts[1] == "customiftrinkets") and parts[3] ~= nil and parts[3] ~= "" then
		return "script", parts[3], nil
	elseif (parts[1] == "ifflag" or parts[1] == "customifflag") and parts[2] ~= nil then
		return "flagscript", parts[2], parts[3]
	elseif parts[1] == "gotoposition" and parts[2] ~= nil and parts[3] ~= nil then
		return "position", tonumber(parts[2]), tonumber(parts[3])
	elseif (parts[1] == "gotoroom" or parts[1] == "hidecoordinates" or parts[1] == "showcoordinates") and parts[2] ~= nil and parts[3] ~= nil then
		return "room", tonumber(parts[2]), tonumber(parts[3])
	else
		return nil, nil, nil
	end
end

function processflaglabels()
	-- Run when OPENING the script for display and editing

	if not keyboard_eitherIsDown("shift") then
		-- scriptlines assumed non-empty table of lines
		for k,v in pairs(scriptlines) do
			-- I could split it into parts and then check everything with that, but this is far easier and better performing.
			--if v:sub(1,5) == "flag(" or v:sub(1,7) == "ifflag(" or v:sub(1,13) == "customifflag(" then
			if v:sub(1,4) == "flag" or v:sub(1,6) == "ifflag" or v:sub(1,12) == "customifflag" then
				-- Ok, how about now?
				text2 = string.gsub(string.gsub(v, "%(", ","), "%)", ",")

				-- We need to explode it anyways.
				partss = explode(",", text2)

				if vedmetadata ~= false and vedmetadata.flaglabel[tonumber(partss[2])] ~= nil and vedmetadata.flaglabel[tonumber(partss[2])] ~= "" then
					-- This flag has a name
					scriptlines[k] = scriptlines[k]:gsub(partss[2], vedmetadata.flaglabel[tonumber(partss[2])], 1)
				end
			end
		end

		-- Is this an internal script?
		if scriptlines[1] ~= nil and ((scriptlines[1]:sub(1,4) == "say(" and scriptlines[1]:sub(-4,-1) == ") #v") or (scriptlines[1] == "squeak(off) #v" and scriptlines[2]:sub(1,4) == "say(" and scriptlines[2]:sub(-4,-1) == ") #v")) and scriptlines[#scriptlines-1] == "loadscript(stop) #v" and (scriptlines[#scriptlines] == "text(1,0,0,4) #v" or scriptlines[#scriptlines] == "text(1,0,0,3) #v") then
			-- Quite so!
			table.remove(scriptlines, #scriptlines)
			table.remove(scriptlines, #scriptlines)
			if scriptlines[1] == "squeak(off) #v" then
				table.remove(scriptlines, 1)
			end
			table.remove(scriptlines, 1)

			local removetheselines = {}

			for k,v in pairs(scriptlines) do
				-- Remove any hashes we may have placed last time when replacing completely blank lines
				if v == "#" then
					scriptlines[k] = ""
				elseif (v:sub(1,4) == "say(" and v:sub(-4,-1) == ") #v") or v == "text(1,0,0,4) #v" or v == "text(1,0,0,3) #v" then
					table.insert(removetheselines, k)
				end
			end

			-- Remove the lines we have to remove in reverse order, so the keys will remain the same for the items we're removing.
			for l = #removetheselines, 1, -1 do
				table.remove(scriptlines, removetheselines[l])
			end

			internalscript = true
		else
			internalscript = false
		--else
			--cons(scriptlines[1]:sub(1,4) == "say("); cons(scriptlines[1]:sub(-4,-1) == ") #v"); cons(scriptlines[#scriptlines-1] == "loadscript(stop) #v"); cons(scriptlines[#scriptlines] == "text(1,0,0,4) #v")
		end
	else
		internalscript = false
	end
end

function processflaglabelsreverse()
	-- Run when LEAVING the script
	-- Converts flag labels to numbers, and if an internal script, convert to a format that works in VVVVVV
	-- scriptlines assumed non-empty table of lines

	usedflags = {}
	outofrangeflags = {}

	-- See which flags have been used in this level.
	returnusedflags(usedflags, outofrangeflags)

	-- Internal script handling!
	if internalscript then
		-- Backup first!
		local scriptlinesbackup = table.copy(scriptlines)
		local splithasfailed = false

		-- Add the magic lines.
		local saylines = #scriptlines+1

		-- Alright, figured out what the sorcery was... DIT IS NU HELAAS NIET MEER ZO SIMPEL!
		--editingline = editingline + 1

		-- First actually set the line, then we'll talk.
		scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
		editingline = 3
		input, input_r = scriptlines[1], ""

		--table.insert(scriptlines, 1, "say(" .. saylines .. ") #v")

		-- I see something coming here...
		if input == "" then
			-- Make sure it's not changed back to an empty line by a leavescript_to_state.
			input = "#"
		end

		-- INSERT loadscript(stop) #v HIER ----- NIET DUS
		--table.insert(scriptlines, "loadscript(stop) #v")

		local splitpoints = {}
		local marksafe = true
		for k = #scriptlines, 1, -1 do
			local v = scriptlines[k]

			if v:sub(1,5) == "speak" then
				marksafe = false
			elseif v:sub(1,4) == "text" then
				marksafe = true
			end

			splitpoints[k] = marksafe
		end

		local blocks = {} -- array of nnumbers
		local lineshad = 0
		while (#scriptlines - lineshad) > 48 do
			local splitsuccessfully = false

			local finalblockline = 0

			for currentblockline = (lineshad+1)+48, lineshad+1, -1 do
				--cons("CHECKING LINE " .. currentblockline)
				if splitpoints[currentblockline] then
					-- We can split here!
					splitsuccessfully = true
					finalblockline = currentblockline-lineshad
					table.insert(blocks, finalblockline)
					break
				end
			end

			if not splitsuccessfully then
				splithasfailed = true
				break
			end

			lineshad = lineshad + finalblockline
		end

		if splithasfailed then
			-- Just restore the script from the backup we made and disengage internal scripting mode
			scriptlines = table.copy(scriptlinesbackup)
			internalscript = false -- even though it's already gone by not converting it, but it can't hurt
			dialog.create(L.SPLITFAILED)
		else
			-- Alright, what do we have left?
			table.insert(blocks, #scriptlines - lineshad)

			cons("Blocks:" .. #blocks)

			for k,v in pairs(blocks) do
				cons("Block: " .. v)
			end

			if #blocks == 1 then
				-- We actually need to check for this unfortunately
				cons("There is only one block, so no splitting required")

				table.insert(scriptlines, 1, "say(" .. saylines .. ") #v")
				table.insert(scriptlines, 1, "squeak(off) #v")
			else
				-- ACTUALLY SPLIT EVERYTHING YAY
				for k = #blocks, 1, -1 do
					-- We're in the kth block.
					local blockstartsat = 0

					for blu = k-1, 1, -1 do
						cons("Adding block " .. blu)
						blockstartsat = blockstartsat + blocks[blu]
					end

					cons("Final start of block " .. k .. " with length " .. (blocks[k]) .. ": " .. (blockstartsat+1))

					if k == #blocks then
						-- This is the last one so this also behaves slightly differently because it's observed to do so.
						table.insert(scriptlines, blockstartsat, "say(" .. (blocks[k]+2) .. ") #v") -- +1 want: reken ofwel text(1,0,0,4) erbij of de uiteindelijke loadscript(stop). +2 want het is nodig ofzo!
						table.insert(scriptlines, blockstartsat, "text(1,0,0,3) #v")
					elseif k ~= 1 then
						table.insert(scriptlines, blockstartsat, "say(" .. (blocks[k]+1) .. ") #v") -- +1 want: reken ofwel text(1,0,0,4) erbij of de uiteindelijke loadscript(stop).
						table.insert(scriptlines, blockstartsat, "text(1,0,0,3) #v")
					else
						table.insert(scriptlines, 1, "say(" .. (blocks[k]) .. ") #v") -- Niet de +1 want: dit is de eerste regel dus dit is anders.
						table.insert(scriptlines, 1, "squeak(off) #v")
					end
				end
			end

			table.insert(scriptlines, "loadscript(stop) #v")
			table.insert(scriptlines, "text(1,0,0,3) #v")
		end
	end

	local noflagsleftwarning = false

	-- b1 fix for flag names being assigned flag numbers that are also used in that script for the first time. See below
	for k,v in pairs(scriptlines) do
		if k == editingline then
			usev = anythingbutnil(input) .. anythingbutnil(input_r)
		else
			usev = v
		end

		if usev:sub(1,4) == "flag" or usev:sub(1,6) == "ifflag" or usev:sub(1,12) == "customifflag" then
			local text2 = string.gsub(string.gsub(usev, "%(", ","), "%)", ","):gsub(" ", "")
			local partss = explode(",", text2)

			if tostring(tonumber(partss[2])) == tostring(partss[2]) and tonumber(partss[2]) ~= nil then
				-- This is a flag number, so make sure we don't assign a flag name to it!
				usedflags[tonumber(partss[2])] = true
				cons(partss[2] .. " is a flag number!")
			end
		end
	end

	local textlinestogo = 0

	for k,v in pairs(scriptlines) do
		if k == editingline then
			usev = anythingbutnil(input) .. anythingbutnil(input_r)
		else
			usev = v
		end

		-- Okay, we'll have to split this. What's on this line?
		local partss
		if textlinestogo <= 0 then
			local text2 = string.gsub(string.gsub(usev, "%(", ","), "%)", ","):gsub(" ", "")
			partss = explode(",", text2)
		else
			partss = {""}
		end

		-- Are we using internal scripting mode? If this line is blank it's not going to be taken well by VVVVVV itself unless we put something here..
		if internalscript and v == "" and textlinestogo <= 0 then
			scriptlines[k] = "#"
			usev = "#"
		end

		if textlinestogo > 0 then
			textlinestogo = textlinestogo - 1
		end

		if partss[1] == "text" and partss[5] ~= nil then
			textlinestogo = anythingbutnil0(tonumber(partss[5]))
		end

		-- Would be a good idea to stop accidental script splits from happening... People could much better use the actual split button
		if (not s.dontpreventscriptsplits) and v:sub(-1,-1) == ":" then
			scriptlines[k] = v .. " "
		end

		if partss[1] == "flag" or partss[1] == "ifflag" or partss[1] == "customifflag" then
			cons("" .. partss[1] .. " found at line " .. k)

			if tostring(tonumber(partss[2])) ~= tostring(partss[2]) then --vedmetadata.flaglabel[tonumber(partss[2])] ~= nil then
				-- This is not a flag number, check if this label already exists

				-- But first check if vedmetadata is enabled
				if vedmetadata == false then
					vedmetadata = createmde()
				end

				local useflag = -1

				-- The flag name must not be empty.
				if partss[2] == "" then
					cons("Flag name is empty, skipping")
					break
				end

				for vlag = 0, 99 do
					if vedmetadata.flaglabel[vlag] == partss[2] then
						useflag = vlag
						cons("Flag name for " .. partss[2] .. " already exists and found at flag number " .. vlag)
						break
					end
				end

				if useflag == -1 then
					-- This flag name is new! Find a flag number to assign it to.
					cons("Flag name " .. partss[2] .. " is new!")
					for vlag = 0, 99 do
						if not usedflags[vlag] then
							-- Ah, here we got one!
							useflag = vlag
							usedflags[vlag] = true
							vedmetadata.flaglabel[vlag] = partss[2]
							cons("Associated flag #" .. vlag .. " with this")
							break
						end
					end
				end

				if useflag == -1 then
					-- No flags left?
					if not noflagsleftwarning then
						dialog.create(
							L.NOFLAGSLEFT,
							DBS.YESNO,
							dialog.callback.noflagsleft
						)
						noflagsleftwarning = true
					end
				else					
					-- When replacing, make sure a flag named "flag" or similar won't replace the command itself. Also don't change the style of brackets/commas by imploding as x(y,z)
					scriptlines[k] = partss[1] .. usev:sub(partss[1]:len()+1, -1):gsub(escapegsub(partss[2], true), useflag, 1)
					cons("Substituted " .. partss[2] .. " (escaped gsub " .. escapegsub(partss[2]) .. ") by " .. useflag)

					if k == editingline then
						-- This is a line we were editing, so update it first... Sigh
						input = scriptlines[k]
						input_r = ""
						cons("This was the line we were editing (" .. k .. ")")
					end
				end
			end
		end
	end

	return noflagsleftwarning
end

function bumpscript(scriptid)
	-- Puts a script at the end of the array, making it appear at the top.
	--local temp = scripts[script]
	--table.remove(scripts, script)
	--scripts[script] = temp

	-- id is the index of the script in scriptnames!
	local temp = scriptnames[scriptid]
	table.remove(scriptnames, scriptid)
	table.insert(scriptnames, temp)
end

function scriptineditor(scriptnamearg, rvnum)
	if rvnum == nil then
		-- Zoek hier uit wat rvnum is
		for k,v in pairs(scriptnames) do
			if v == scriptnamearg then
				bumpscript(k)
			end
		end
	elseif rvnum ~= -1 then
		bumpscript(rvnum)
	end

	scriptname = scriptnamearg
	scriptlines = table.copy(scripts[scriptname])
	processflaglabels()
	tostate(3)
end

function checkintscrloadscript(scriptname)
	entityuses, scriptuses = findscriptreferences(scriptname)

	-- Warn in case no script is referring to this one.
	intscrwarncache_warn_noloadscript = #scriptuses == 0
	intscrwarncache_warn_boxed = #entityuses > 0
	intscrwarncache_script = scriptname
end

function findscriptreferences(argscriptname)
	local entityuses = {} -- Contains entity IDs
	local scriptuses = {} -- Contains: {argscriptname, line}

	for k,v in pairs(entitydata) do
		if (v.t == 18 or v.t == 19) and v.data == argscriptname then
			table.insert(entityuses, k)
		end
	end

	for rvnum = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[rvnum]]) do
			v2 = string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", "")

			partss = explode(",", v2)

			if (partss[1] == "iftrinkets" or partss[1] == "customiftrinkets" or partss[1] == "ifflag" or partss[1] == "customifflag") and partss[3] == argscriptname then
				-- argscriptname is referred to in this script
				table.insert(scriptuses, {scriptnames[rvnum], k})
				break
			end
		end
	end

	return entityuses, scriptuses
end

function findusedscripts()
	local usedscripts = {} -- the keys are the script names here, for an easier and more efficient (O(1)) lookup
	local count = 0

	for k,v in pairs(entitydata) do
		if (v.t == 18 or v.t == 19) and scripts[v.data] ~= nil then
			usedscripts[v.data] = true
		end
	end

	for rvnum = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[rvnum]]) do
			v2 = string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", "")

			partss = explode(",", v2)

			if (partss[1] == "iftrinkets" or partss[1] == "customiftrinkets" or partss[1] == "ifflag" or partss[1] == "customifflag") and partss[3] ~= nil and scripts[partss[3]] ~= nil then
				usedscripts[partss[3]] = true
			end
		end
	end

	-- Now count the amount of items, because unfortunately # doesn't work well for tables with non-sequential keys
	for _ in pairs(usedscripts) do
		count = count + 1
	end

	return usedscripts, count
end

function editorjumpscript(argscriptname, goingback, toline)
	if scripts[argscriptname] == nil then
		-- Create script (but do not immediately go to it as we can just easily click again)
		scripts[argscriptname] = {""}
		table.insert(scriptnames, argscriptname)
	else
		-- Go to script- but save the current script first!
		leavescript_to_state = function()
			scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
			scripts[scriptname] = table.copy(scriptlines)

			if goingback then
				table.remove(scripthistorystack)
			else
				table.insert(scripthistorystack, {scriptname, visibleeditingline})
			end

			scriptineditor(argscriptname)
			cons("Jumping to script " .. argscriptname .. " in editor, # history stack is now " .. (#scripthistorystack))

			if toline ~= nil then
				-- Also go back to the correct line!
				scriptgotoline(toline)
			end
		end

		-- So that processflaglabelsreverse() doesn't modify this for internal scripts
		visibleeditingline = editingline

		if not processflaglabelsreverse() then
			leavescript_to_state()
		end
	end
end

function scriptgotoline(linenum, colnum)
	linenum = math.floor(linenum)

	if anythingbutnil0(linenum) < 1 then
		linenum = 1
	elseif linenum > #scriptlines then
		linenum = #scriptlines
	end

	scriptlines[editingline] = input .. input_r
	__ = "_"
	editingline = linenum
	if colnum == nil then
		input, input_r = anythingbutnil(scriptlines[editingline]), ""
	else
		input, input_r = anythingbutnil(scriptlines[editingline]):sub(1,colnum-1), anythingbutnil(scriptlines[editingline]):sub(colnum,-1)
		scriptlines[editingline] = input
	end

	-- Now make sure the line is actually on screen!
	scriptlineonscreen()
end

function startinscriptsearch()
	stopinput()
	scriptlines[editingline] = input

	dialog.create(
		L.SEARCHFOR,
		DBS.OKCANCEL,
		dialog.callback.scriptsearch,
		nil,
		dialog.form.simplename_make(scriptsearchterm)
	)
end

function startscriptgotoline()
	stopinput()
	scriptlines[editingline] = input

	dialog.create(
		L.GOTOLINE2,
		DBS.OKCANCEL,
		dialog.callback.scriptgotoline,
		nil,
		{
			{"line", 0, 1, 5, ""}
		},
		dialog.callback.scriptgotoline_validate
	)
end

function scriptlineonscreen(ln)
	if ln == nil then
		ln = editingline
	end

	if textsize then
		scriptscroll = math.max(scriptscroll, -(16*(ln-1)))
		scriptscroll = math.min(scriptscroll, -(16*ln-16*28))
	else
		scriptscroll = math.max(scriptscroll, -(8*(ln-1)))
		scriptscroll = math.min(scriptscroll, -(8*ln-8*56))
	end
end

function flagname_illegal_chars(name)
	return name:find("%(") or name:find("%)") or name:find(",") or name:find(" ")
end

function flagname_check_problem(name, number)
	-- Returns a string describing the problem with a flag name for a flag number if there is a problem
	-- Returns nil if there's no problem
	if name == "" then
		return
	end

	if tostring(tonumber(name)) == tostring(name) then
		-- This is a number
		return L.FLAGNAMENUMBERS
	elseif flagname_illegal_chars(name) then
		-- This contains illegal characters
		return L.FLAGNAMECHARS
	elseif vedmetadata ~= false then
		-- Final check: check if this flag hasn't been used already.
		for kd = 0, 99 do
			if kd ~= number and vedmetadata.flaglabel[kd] == name then
				-- This flag already exists!
				return langkeys(L.FLAGNAMEINUSE, {name, kd})
			end
		end
	end
end
