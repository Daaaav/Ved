function returnusedflags(usedflagsA, outofrangeflagsA, specificflag, specificflag_usages)
	-- if specificflag is not given, then all used flags will be stored in usedflagsA and outofrangeflagsA.
	-- else, a list of script names is put in specificflag_usages, which is all usages of that flag,
	-- and the number of usages is returned (including multiple usages in the same script).
	local specificflag_n_real_usages = 0
	for script_i = #scriptnames, 1, -1 do
		local script_inserted = false
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			v = scriptlinecasing(v)
			local explcommaline = explode(",", string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", ""))

			if (
				explcommaline[1] == "flag"
				or explcommaline[1] == "ifflag"
				or explcommaline[1] == "customifflag"
			) and explcommaline[2] ~= nil and tonumber(explcommaline[2]) ~= nil then
				if specificflag == nil then
					usedflagsA[tonumber(explcommaline[2])] = true

					if tonumber(explcommaline[2]) < 0 or tonumber(explcommaline[2]) >= limit.flags then
						outofrangeflagsA[tonumber(explcommaline[2])] = true
					end
				elseif specificflag == tonumber(explcommaline[2]) then
					specificflag_n_real_usages = specificflag_n_real_usages + 1

					if not script_inserted then
						table.insert(specificflag_usages, scriptnames[script_i])
						script_inserted = true
					end
				end
			end
		end
	end

	return specificflag_n_real_usages
end

function syntaxhl(text, x, y, thisistext, docolor, lasttextcolor, alttextcolor)
	local textscale = s.scripteditor_largefont and 2 or 1
	local fontsize = s.scripteditor_largefont and 16 or 8

	local thisiscomment = text:sub(1,1) == "#" or text:sub(1,2) == "//"
	if thisistext or thisiscomment then
		if thisistext and s.colored_textboxes then
			if alttextcolor then
				if alttextboxcolors[lasttextcolor] == nil then
					lasttextcolor = "gray"
				end
			elseif textboxcolors[lasttextcolor] == nil then
				lasttextcolor = "gray"
			end
			_= docolor and setColorArr(alttextcolor and alttextboxcolors[lasttextcolor] or textboxcolors[lasttextcolor])
		else
			_= docolor and setColorArr(thisistext and s.syntaxcolor_textbox or s.syntaxcolor_comment)
		end
		ved_print(docolor and text or text:sub(1, string.len(text)), x, y, textscale)
		offsetchars = utf8.len(text) + 1

		return nil
	else
		offsetchars = 0

		--if text ~= "" then
		-- Replace characters by one with which we will split.
		text2 = string.gsub(string.gsub(text, "%(", ","), "%)", ",")

		local partss = explode(",", text2)
		local partss_parsed = {}

		for k, v in pairs(partss) do
			v = v:gsub(" ", "")
			if k < #partss then
				table.insert(partss_parsed, v:lower())
			else
				table.insert(partss_parsed, v)
			end
		end

		if docolor then
			for k,v in pairs(partss) do
				local v_parsed = partss_parsed[k]
				if offsetchars == 0 then -- First word on the line, so it's a command.
					-- But is it recognized?
					-- `say` and `reply` are special and still work capitalized even with no argument separators
					local addcursor = false -- TODO scriptlines2021 don't start acting like a Java IDE
					if (addcursor and #partss == 1 and v:sub(-1, -1) ~= " ")
					or knowncommands[v_parsed]
					or knowninternalcommands[v_parsed]
					or v_parsed:lower() == "say" or v_parsed:lower() == "reply" then
						setColorArr(s.syntaxcolor_command)
					else
						setColorArr(s.syntaxcolor_errortext)
					end
				elseif tostring(tonumber(v_parsed)) == tostring(v_parsed) then -- It's a number!
					setColorArr(s.syntaxcolor_number)
				elseif k == 2 and (partss_parsed[1] == "flag" or partss_parsed[1] == "ifflag" or partss_parsed[1] == "customifflag") and tostring(tonumber(v_parsed)) ~= tostring(v_parsed) then
					-- if flag name is not used yet, newflagname
					for fl = 0, limit.flags-1 do
						if vedmetadata ~= false and vedmetadata.flaglabel[fl] == v_parsed then
							setColorArr(s.syntaxcolor_flagname)
							break
						end

						setColorArr(s.syntaxcolor_newflagname)
					end
				else
					setColorArr(s.syntaxcolor_generic)
				end
				ved_print(v, x+(offsetchars*fontsize), y, textscale)

				setColorArr(s.syntaxcolor_separator)
				ved_print(utf8.sub(text, 1+offsetchars+utf8.len(v), 1+offsetchars+utf8.len(v)), x+(offsetchars*fontsize)+(utf8.len(v)*fontsize), y, textscale)

				offsetchars = offsetchars + (utf8.len(v)+1)
			end
		else -- not docolor
			ved_print(text:sub(1, string.len(text)), x, y, textscale)
		end

		-- `say` and `reply` are exceptions - they still work when they're capitalized even with no argument separators
		if partss_parsed[1]:lower() == "say" then
			if partss[2] == nil or anythingbutnil0(tonumber(partss_parsed[2])) <= 1 then
				return 1, normalize_simplified_color(partss_parsed[3])
			else
				return tonumber(partss_parsed[2]), normalize_simplified_color(partss_parsed[3])
			end
		elseif partss_parsed[1]:lower() == "reply" then
			if partss[2] == nil or anythingbutnil0(tonumber(partss_parsed[2])) <= 1 then
				return 1, "player"
			else
				return tonumber(partss_parsed[2]), "player"
			end
		elseif partss_parsed[1] == "text" then
			if partss[5] == nil or anythingbutnil0(tonumber(partss_parsed[5])) <= 0 then
				return 0, partss_parsed[2]
			else
				return tonumber(partss_parsed[5]), partss_parsed[2]
			end
		end
	end
	--end
end

function justtext(text, thisistext)
	-- Only checks for starts of textboxes above the screen. Does not draw any text!
	-- This is not "the function used when syntax highlighting is turned off",
	-- nor "the function used for textbox content"
	if not thisistext then
		text = text:gsub(" ", "")
		text = scriptlinecasing(text)
		if text:sub(1, 3) == "say" or text:sub(1, 5) == "reply" or text:sub(1, 4) == "text" then
			text2 = string.gsub(string.gsub(text, "%(", ","), "%)", ",")

			partss = explode(",", text2)

			if partss[1] == "say" then
				if partss[2] == nil or anythingbutnil0(tonumber(partss[2])) <= 1 then
					return 1, normalize_simplified_color(partss[3])
				else
					return tonumber(partss[2]), normalize_simplified_color(partss[3])
				end
			elseif partss[1] == "reply" then
				if partss[2] == nil or anythingbutnil0(tonumber(partss[2])) <= 1 then
					return 1, "player"
				else
					return tonumber(partss[2]), "player"
				end
			elseif partss[1] == "text" then
				if partss[5] == nil or anythingbutnil0(tonumber(partss[5])) <= 0 then
					return 0, partss[2]
				else
					return tonumber(partss[5]), partss[2]
				end
			end
		end

		return nil -- also redundant
	end

	return nil -- redundant
end

function scriptcontext(text)
	local text2 = string.gsub(string.gsub(string.gsub(anythingbutnil(text), "%(", ","), "%)", ","), " ", "")
	text2 = scriptlinecasing(text2)

	parts = explode(",", text2)

	if parts[1] == "flag" and parts[2] ~= nil then
		return "flag", tonumber(parts[2]), nil, nil
	elseif (
		parts[1] == "iftrinkets"
		or parts[1] == "iftrinketsless"
		or parts[1] == "customiftrinkets"
		or parts[1] == "customiftrinketsless"
	) and parts[3] ~= nil and parts[3] ~= "" then
		return "script", parts[3], nil, nil
	elseif (
		parts[1] == "loadscript"
		or parts[1] == "ifskip"
	) and parts[2] ~= nil and parts[2] ~= "custom_" and string.sub(parts[2], 1, string.len("custom_")) == "custom_" then
		return "script", string.sub(parts[2], string.len("custom_")+1, string.len(parts[2])), nil
	elseif (
		parts[1] == "ifflag"
		or parts[1] == "customifflag"
	) and parts[2] ~= nil then
		return "flagscript", parts[2], parts[3], nil
	elseif (
		parts[1] == "ifcrewlost"
		or parts[1] == "iflast"
	) and parts[2] ~= nil and parts[3] ~= nil and parts[3] ~= "custom_" and string.sub(parts[3], 1, string.len("custom_")) == "custom_" then
		return "script", string.sub(parts[3], string.len("custom_")+1, string.len(parts[3])), nil, nil
	elseif parts[1] == "ifexplored" and parts[2] ~= nil and parts[3] ~= nil and parts[4] ~= nil and parts[4] ~= "custom_" and string.sub(parts[4], 1, string.len("custom_")) == "custom_" then
		local x, y = tonumber(parts[2]), tonumber(parts[3])
		if x == nil or y == nil then
			return "roomscript", x, y, nil
		end
		local script = string.sub(parts[4], string.len("custom_")+1, string.len(parts[4]))
		local roomnum = x + y*20
		if roomnum >= 0 and roomnum < 400 then
			local x_again, y_again
			y_again = math.floor(roomnum/20)
			x_again = roomnum % 20
			return "roomscript", x_again, y_again, script
		else
			return "roomnumscript", roomnum, script
		end
		return "roomscript", x, y, script
	elseif parts[1] == "gotoposition" and parts[2] ~= nil and parts[3] ~= nil then
		return "position", tonumber(parts[2]), tonumber(parts[3]), nil
	elseif parts[1] == "ifwarp" and parts[2] ~= nil and parts[3] ~= nil and parts[4] ~= nil and parts[5] ~= nil and parts[5] ~= "" then
		local x, y = tonumber(parts[2]), tonumber(parts[3])
		if x == nil or y == nil then
			return "roomscript", x, y, nil
		end
		local script = parts[5]
		local roomnum = x + y*20
		if roomnum >= 0 and roomnum < 400 then
			local x_again, y_again
			y_again = math.floor(roomnum/20)
			x_again = roomnum % 20
			return "roomscript", x_again, y_again, script
		else
			return "roomnumscript", roomnum, script
		end
	elseif (
		parts[1] == "gotoroom"
		or parts[1] == "hidecoordinates"
		or parts[1] == "showcoordinates"
	) and parts[2] ~= nil and parts[3] ~= nil then
		local x, y = tonumber(parts[2]), tonumber(parts[3])
		if x == nil or y == nil then
			return "room", x, y, nil
		end
		if parts[1] == "gotoroom" then
			x, y = x % metadata.mapwidth, y % metadata.mapheight
		elseif table.contains({"hidecoordinates", "showcoordinates"}, parts[1]) then
			local roomnum = x + y*20
			if roomnum >= 0 and roomnum < 400 then
				local x_again, y_again
				y_again = math.floor(roomnum/20)
				x_again = roomnum % 20
				return "room", x_again, y_again, nil
			else
				return "roomnum", roomnum
			end
		end
		return "room", x, y, nil
	elseif table.contains({"delay", "walk", "flash", "shake"}, parts[1]) and parts[2] ~= nil then
		local frames
		if parts[1] == "walk" then
			frames = parts[3]
		else
			frames = parts[2]
		end
		if tonumber(frames) == nil or tonumber(frames) <= 0 then
			return "frames", nil
		end
		return "frames", frames, nil, nil
	elseif table.contains({"music", "play", "stopmusic", "playremix"}, parts[1]) then
		if parts[1] == "stopmusic" then
			return "track", -1, nil, nil
		elseif parts[1] == "playremix" then
			return "track", 15, nil, nil
		end
		if parts[2] == nil or parts[2] == "" then
			return nil
		end
		local track
		if parts[1] == "music" and tonumber(parts[2]) ~= nil and tonumber(parts[2]) <= 11 then
			track = tonumber(parts[2])
			return "track", musicsimplifiedtointernal[track], nil, nil
		else
			track = parts[2]:match("^%d+")
			track = tonumber(track)
			if track ~= nil then
				if track < 0 then
					track = nil
				else
					track = track % 16
				end
			end
			return "track", track, nil, nil
		end
	else
		return nil, nil, nil, nil
	end
end

function script_decompile(raw_script)
	-- Run when OPENING the script for display and editing
	-- Takes the script as runnable by VVVVVV (raw_script) and returns "human-readable" conversion

	if keyboard_eitherIsDown("shift") then
		internalscript = false
		cutscenebarsinternalscript = false
		return raw_script
	end

	local readable_script = table.copy(raw_script)

	-- Scripts can be fully contentless- without even one line.
	if #readable_script == 0 then
		table.insert(readable_script, "")
	end

	for k,v in pairs(readable_script) do
		-- There needs to be at least one argument separator to be a flag, but don't explode it (yet)
		v = v:gsub(" ", "")
		if v:lower():match("^flag[%(,%)]") or v:lower():match("^ifflag[%(,%)]") or v:lower():match("^customifflag[%(,%)]") then
			-- Ok, how about now?
			text2 = string.gsub(string.gsub(v, "%(", ","), "%)", ",")

			-- We need to explode it anyways.
			local partss = explode(",", text2)

			if vedmetadata ~= false and vedmetadata.flaglabel[tonumber(partss[2])] ~= nil and vedmetadata.flaglabel[tonumber(partss[2])] ~= "" then
				-- This flag has a name
				readable_script[k] = readable_script[k]:gsub(" ", "")
				readable_script[k] = readable_script[k]:gsub(partss[2], vedmetadata.flaglabel[tonumber(partss[2])], 1)
			end
		end
	end

	-- Is this an internal script?
	if (readable_script[1] ~= nil and ((readable_script[1]:sub(1,4) == "say(" and readable_script[1]:sub(-4,-1) == ") #v") or (readable_script[1] == "squeak(off) #v" and readable_script[2]:sub(1,4) == "say(" and readable_script[2]:sub(-4,-1) == ") #v")) and (readable_script[#readable_script] == "text(1,0,0,4) #v" or readable_script[#readable_script] == "text(1,0,0,3) #v"))
	or (readable_script[1] == "squeak(off) #v" and readable_script[2] == "say(-1) #v" and readable_script[3] == "text(1,0,0,3) #v" and readable_script[4] ~= nil and readable_script[4]:sub(1,4) == "say(" and readable_script[4]:sub(-4,-1) == ") #v") then
		-- Quite so!
		if readable_script[2] == "say(-1) #v" and readable_script[3] == "text(1,0,0,3) #v" then
			internalscript = false
			cutscenebarsinternalscript = true
		else
			internalscript = true
			cutscenebarsinternalscript = false
		end

		if internalscript then
			if readable_script[#readable_script-1] == "loadscript(stop) #v" then
				table.remove(readable_script, #readable_script)
			end
			table.remove(readable_script, #readable_script)
			if readable_script[1] == "squeak(off) #v" then
				table.remove(readable_script, 1)
			end
			table.remove(readable_script, 1)
		elseif cutscenebarsinternalscript then
			if readable_script[#readable_script] == "loadscript(stop) #v" then
				table.remove(readable_script, #readable_script)
			end
			table.remove(readable_script, 1) -- squeak(off) #v
			table.remove(readable_script, 1) -- say(-1) #v
			table.remove(readable_script, 1) -- text(1,0,0,3) #v
			table.remove(readable_script, 1) -- say(n) #v
		end

		local removetheselines = {}

		for k,v in pairs(readable_script) do
			-- Remove any hashes we may have placed last time when replacing completely blank lines
			if v == "#" then
				readable_script[k] = ""
			elseif (v:sub(1,4) == "say(" and v:sub(-4,-1) == ") #v") or v == "text(1,0,0,4) #v" or v == "text(1,0,0,3) #v" then
				table.insert(removetheselines, k)
			end
		end

		-- Remove the lines we have to remove in reverse order, so the keys will remain the same for the items we're removing.
		for l = #removetheselines, 1, -1 do
			table.remove(readable_script, removetheselines[l])
		end
	else
		internalscript = false
		cutscenebarsinternalscript = false
	end

	return readable_script
end

function script_compile(readable_script)
	-- Run when LEAVING the script
	-- Converts flag labels to numbers, and if an internal script, convert to a format that works in VVVVVV
	-- Takes the "human-readable" script and returns success and conversion as runnable by VVVVVV (raw_script)

	local success = true

	-- Not a waste of a copy, this CAN go wrong in several ways.
	local raw_script = table.copy(readable_script)

	-- I don't think this can happen, but just in case
	if #raw_script == 0 then
		table.insert(raw_script, "")
	end

	local usedflags = {}
	local outofrangeflags = {}

	-- See which flags have been used in this level.
	returnusedflags(usedflags, outofrangeflags)

	-- Internal script handling!
	if internalscript or cutscenebarsinternalscript then
		local splithasfailed = false

		-- If we already end with (custom)?iftrinkets(0,... or loadscript(..., then we won't need the default loadscript(stop)
		local final_loadscript_n = 1
		local last_line = raw_script[#raw_script]
		last_line = last_line:gsub(" ", "")
		last_line = scriptlinecasing(last_line)
		if last_line:match("^iftrinkets[%(,%)]0+[%(,%)]")
		or last_line:match("^iftrinkets[%(,%)]0+$")
		or last_line:match("^customiftrinkets[%(,%)]0+[%(,%)]")
		or last_line:match("^customiftrinkets[%(,%)]0+$")
		or last_line:match("^loadscript[%(,%)]")
		or last_line:match("^loadscript$") then
			final_loadscript_n = 0
		end

		local splitpoints = {}
		local marksafe = true
		for k = #raw_script, 1, -1 do
			local v = raw_script[k]:gsub(" ", "")
			v = scriptlinecasing(v)

			if v:match("^speak$") or v:match("^speak[%(,%)]") or v:match("^speak_active$") or v:match("^speak_active[%(,%)]") then
				marksafe = false
			elseif v:match("^text[%(,%)]") then
				local _, sepcount = v:gsub("[%(,%)]", "")
				if sepcount >= 4 then
					marksafe = true
				end
			end

			splitpoints[k] = marksafe
		end

		local blocks = {} -- array of nnumbers
		local lineshad = 0
		while (#raw_script - lineshad) > 48 do
			local splitsuccessfully = false

			local finalblockline = 0

			for currentblockline = (lineshad+1)+48, lineshad+1, -1 do
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
			-- Just leave the script unconverted and disengage internal scripting mode. There's still flag names
			internalscript = false
			cutscenebarsinternalscript = false
			dialog.create(L.SPLITFAILED)
			success = false
		else
			-- Alright, what do we have left?
			table.insert(blocks, #raw_script - lineshad)

			cons("Blocks:" .. #blocks)

			for k,v in pairs(blocks) do
				cons("Block: " .. v)
			end

			if #blocks == 1 then
				-- We actually need to check for this unfortunately
				cons("There is only one block, so no splitting required")

				local saylines = #raw_script+final_loadscript_n

				table.insert(raw_script, 1, "say(" .. saylines .. ") #v")
				if cutscenebarsinternalscript then
					table.insert(raw_script, 1, "text(1,0,0,3) #v")
					table.insert(raw_script, 1, "say(-1) #v")
				end
				table.insert(raw_script, 1, "squeak(off) #v")
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
						table.insert(raw_script, blockstartsat, "say(" .. (blocks[k]+1+final_loadscript_n) .. ") #v") -- +1 because: add up either text(1,0,0,4) or the final loadscript(stop).
						table.insert(raw_script, blockstartsat, "text(1,0,0,3) #v")
					elseif k ~= 1 then
						table.insert(raw_script, blockstartsat, "say(" .. (blocks[k]+1) .. ") #v") -- +1 because: add up either text(1,0,0,4) or the final loadscript(stop).
						table.insert(raw_script, blockstartsat, "text(1,0,0,3) #v")
					else
						table.insert(raw_script, 1, "say(" .. (blocks[k]) .. ") #v") -- Not the +1 because: this is the first line so this is different.
						if cutscenebarsinternalscript then
							table.insert(raw_script, 1, "text(1,0,0,3) #v")
							table.insert(raw_script, 1, "say(-1) #v")
						end
						table.insert(raw_script, 1, "squeak(off) #v")
					end
				end
			end

			if final_loadscript_n ~= 0 then
				table.insert(raw_script, "loadscript(stop) #v")
			end
			if internalscript then
				table.insert(raw_script, "text(1,0,0,3) #v")
			end
		end
	end

	local noflagsleftwarning = false

	-- b1 fix for flag names being assigned flag numbers that are also used in that script for the first time. See below
	for k,v in pairs(raw_script) do
		local usev = v -- TODO scriptlines2021 simplify
		usev = usev:gsub(" ", "")
		usev = scriptlinecasing(usev)

		if usev:match("^flag[%(,%)]") or usev:match("^ifflag[%(,%)]") or usev:match("^customifflag[%(,%)]") then
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

	for k,v in pairs(raw_script) do
		local usev = v -- TODO scriptlines2021 simplify - and why sometimes usev and sometimes v down here?

		-- Okay, we'll have to split this. What's on this line?
		local partss
		if textlinestogo <= 0 then
			local text2 = string.gsub(string.gsub(usev, "%(", ","), "%)", ","):gsub(" ", "")
			partss = explode(",", text2)
		else
			partss = {""}
		end
		local partss_scriptcasing = {}
		for k, v in pairs(partss) do
			if k < #partss then
				table.insert(partss_scriptcasing, v:lower())
			else
				table.insert(partss_scriptcasing, v)
			end
		end

		-- Are we using internal scripting mode? If this line is blank it's not going to be taken well by VVVVVV itself unless we put something here..
		if (internalscript or cutscenebarsinternalscript) and v == "" and textlinestogo <= 0 then
			raw_script[k] = "#"
			usev = "#"
		end

		if textlinestogo > 0 then
			textlinestogo = textlinestogo - 1
		end

		if partss_scriptcasing[1] == "text" and partss[5] ~= nil and usev ~= "text(1,0,0,4) #v" and usev ~= "text(1,0,0,3) #v" then
			textlinestogo = anythingbutnil0(tonumber(partss[5]))
		end

		-- Would be a good idea to stop accidental script splits from happening... People could much better use the actual split button
		if (not s.dontpreventscriptsplits) and v:sub(-1,-1) == ":" then
			raw_script[k] = v .. " "
		end

		-- Same for "#" in internal scripts, people might want to put it in a text box... Issue #18
		if (internalscript or cutscenebarsinternalscript) and v == "#" then
			raw_script[k] = "# "
		end

		if partss_scriptcasing[1] == "flag" or partss_scriptcasing[1] == "ifflag" or partss_scriptcasing[1] == "customifflag" then
			cons(partss[1] .. " found at line " .. k)

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

				for flag = 0, limit.flags-1 do
					if vedmetadata.flaglabel[flag] == partss[2] then
						useflag = flag
						usedflags[flag] = true
						cons("Flag name for " .. partss[2] .. " already exists and found at flag number " .. flag)
						break
					end
				end

				if useflag == -1 then
					-- This flag name is new! Find a flag number to assign it to.
					cons("Flag name " .. partss[2] .. " is new!")
					for flag = 0, limit.flags-1 do
						if not usedflags[flag] then
							-- Ah, here we got one!
							useflag = flag
							usedflags[flag] = true
							vedmetadata.flaglabel[flag] = partss[2]
							cons("Associated flag #" .. flag .. " with this")
							break
						end
					end
				end

				if useflag == -1 then
					-- No flags left?
					if not noflagsleftwarning then
						dialog.create(L.NOFLAGSLEFT)
						noflagsleftwarning = true
						success = false
					end
				else					
					-- When replacing, make sure a flag named "flag" or similar won't replace the command itself. Also don't change the style of brackets/commas by imploding as x(y,z)
					-- And also, just remove all the spaces from the line if there are any
					usev = usev:gsub(" ", "")
					raw_script[k] = partss[1] .. usev:sub(partss[1]:len()+1, -1):gsub(escapegsub(partss[2], true), useflag, 1)
					cons("Substituted " .. partss[2] .. " (escaped gsub " .. escapegsub(partss[2]) .. ") by " .. useflag)
				end
			end
		end
	end

	return success, raw_script
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

function movescriptup(scriptid)
	-- Since Ved displays scripts descending, it will actually appear to move down
	local temp = scriptnames[scriptid]
	table.remove(scriptnames, scriptid)
	table.insert(scriptnames, scriptid-1, temp)
end

function movescriptdown(scriptid)
	-- Scripts in the script list are shown in reverse order, so it'll look like it's moving up
	local temp = scriptnames[scriptid]
	table.remove(scriptnames, scriptid)
	table.insert(scriptnames, scriptid+1, temp)
end

function scriptineditor(scriptnamearg, script_i)
	if script_i == nil then
		-- Find out which script it is
		for k,v in pairs(scriptnames) do
			if v == scriptnamearg then
				bumpscript(k)
			end
		end
	elseif script_i ~= -1 then
		bumpscript(script_i)
	end

	scriptname = scriptnamearg
	tostate(3)
end

function check_script_warnings(scriptname)
	if scrwarncache_script == scriptname then -- cached script name is nil if not checked yet
		return
	end
	entityuses, loadscriptuses, scriptuses = findscriptreferences(scriptname)

	-- Warn in case no script is referring to this one.
	scrwarncache_warn_noloadscript = #loadscriptuses == 0 -- only applies to internal scripts
	scrwarncache_warn_boxed = #entityuses > 0 -- only applies to internal scripts
	scrwarncache_warn_name = scriptname:match(".*[A-Z %(%),].*") ~= nil and #entityuses == 0
	scrwarncache_script = scriptname
end

function findscriptreferences(argscriptname)
	local entityuses = {} -- Contains entity IDs
	local loadscriptuses = {} -- Contains: {argscriptname, line}
	local scriptuses = {} -- Also contains: {argscriptname, line}

	for k,v in pairs(entitydata) do
		if (v.t == 18 or v.t == 19) and v.data == argscriptname then
			table.insert(entityuses, k)
		end
	end

	for script_i = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			local v2 = string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", "")
			v2 = scriptlinecasing(v2)

			local partss = explode(",", v2)

			local loadscriptcond = (
				(
					(partss[1] == "iftrinkets" or partss[1] == "iftrinketsless"
					or partss[1] == "customiftrinkets" or partss[1] == "customiftrinketsless"
					or partss[1] == "ifflag" or partss[1] == "customifflag") and partss[3] == argscriptname
				)
				or
				(partss[1] == "ifwarp" and partss[5] == argscriptname)
			)
			local scriptcond = (
				(partss[2] ~= nil and (partss[1] == "loadscript" or partss[1] == "ifskip") and string.sub(partss[2], string.len("custom_")+1, string.len(partss[2])) == argscriptname)
				or
				(partss[3] ~= nil and (partss[1] == "ifcrewlost" or partss[1] == "iflast") and string.sub(partss[3], string.len("custom_")+1, string.len(partss[3])) == argscriptname)
				or
				(partss[4] ~= nil and partss[1] == "ifexplored" and string.sub(partss[4], string.len("custom_")+1, string.len(partss[4])) == argscriptname)
			)

			if loadscriptcond or scriptcond then
				-- argscriptname is referred to in this script
				if loadscriptcond then
					table.insert(loadscriptuses, {scriptnames[script_i], k})
				end
				table.insert(scriptuses, {scriptnames[script_i], k})
				break
			end
		end
	end

	return entityuses, loadscriptuses, scriptuses
end

function findusedscripts()
	local usedscripts = {} -- the keys are the script names here, for an easier and more efficient (O(1)) lookup
	local count = 0

	for k,v in pairs(entitydata) do
		if (v.t == 18 or v.t == 19) and scripts[v.data] ~= nil then
			usedscripts[v.data] = true
		end
	end

	for script_i = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			local v2 = string.gsub(string.gsub(string.gsub(v, "%(", ","), "%)", ","), " ", "")
			v2 = scriptlinecasing(v2)

			local partss = explode(",", v2)

			local add = nil
			if partss[1] == "iftrinkets" or partss[1] == "iftrinketsless" or partss[1] == "customiftrinkets" or partss[1] == "customiftrinketsless" or partss[1] == "ifflag" or partss[1] == "customifflag" then
				add = partss[3]
			elseif partss[1] == "ifwarp" then
				add = partss[5]
			elseif (partss[1] == "loadscript" or partss[1] == "ifskip") and partss[2] ~= nil and string.sub(partss[2], 1, string.len("custom_")) == "custom_" then
				add = string.sub(partss[2], string.len("custom_")+1, string.len(partss[2]))
			elseif (partss[1] == "ifcrewlost" or partss[1] == "iflast") and partss[3] ~= nil and string.sub(partss[3], 1, string.len("custom_")) == "custom_" then
				add = string.sub(partss[3], string.len("custom_")+1, string.len(partss[3]))
			elseif partss[1] == "ifexplored" and partss[4] ~= nil and string.sub(partss[4], 1, string.len("custom_")) == "custom_" then
				add = string.sub(partss[4], string.len("custom_")+1, string.len(partss[4]))
			end

			if add ~= nil and scripts[add] ~= nil then
				usedscripts[add] = true
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
		dirty()
	else
		-- Go to script- but save the current script first!
		local success, raw_script = script_compile(inputs.script_lines)
		if success then
			if goingback then
				table.remove(scripthistorystack)
			else
				local _, editing_line = newinputsys.getpos("script_lines")
				table.insert(scripthistorystack, {scriptname, editing_line})
			end

			scripts[scriptname] = raw_script
			newinputsys.close("script_lines")

			scriptineditor(argscriptname)
			cons("Jumping to script " .. argscriptname .. " in editor, # history stack is now " .. (#scripthistorystack))

			if toline ~= nil then
				-- Also go back to the correct line!
				scriptgotoline(toline)
			end
		end
	end
end

function scriptgotoline(linenum, colnum)
	linenum = math.floor(linenum)

	if anythingbutnil0(linenum) < 1 then
		linenum = 1
	elseif linenum > #inputs.script_lines then
		linenum = #inputs.script_lines
	end

	local line_contents = anythingbutnil(inputs.script_lines[linenum])
	if colnum == nil then
		newinputsys.setpos("script_lines", utf8.len(line_contents), linenum)
	else
		local col_offset = utf8.offset(line_contents, colnum)
		if col_offset == nil then
			newinputsys.setpos("script_lines", utf8.len(line_contents), linenum)
		else
			newinputsys.setpos("script_lines", colnum, linenum)
		end
	end

	-- Now make sure the line is actually on screen!
	scriptlineonscreen()
end

function startinscriptsearch()
	dialog.create(
		L.SEARCHFOR,
		DBS.OKCANCEL,
		dialog.callback.scriptsearch,
		nil,
		dialog.form.simplename_make(scriptsearchterm)
	)
end

function startscriptgotoline()
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
		_, ln = newinputsys.getpos("script_lines")
	end

	if s.scripteditor_largefont then
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
		for kd = 0, limit.flags-1 do
			if kd ~= number and vedmetadata.flaglabel[kd] == name then
				-- This flag already exists!
				return langkeys(L.FLAGNAMEINUSE, {name, kd})
			end
		end
	end
end

function normalize_simplified_color(c)
	if c == "1" or c == "viridian" or c == "player" then
		c = "cyan"
	elseif c == "2" or c == "violet" or c == "pink" then
		c = "purple"
	elseif c == "3" or c == "vitellary" then
		c = "yellow"
	elseif c == "4" or c == "vermilion" then -- "vermillion" does not work in VVVVVV
		c = "red"
	elseif c == "5" or c == "verdigris" then
		c = "green"
	elseif c == "6" or c == "victoria" then
		c = "blue"
	end

	return c
end

function swapflags(flag1, flag2)
	if vedmetadata then
		vedmetadata.flaglabel[flag2], vedmetadata.flaglabel[flag1] = vedmetadata.flaglabel[flag1], vedmetadata.flaglabel[flag2]
	end

	local commands = {"flag", "ifflag", "customifflag"}
	for script_i = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			v = v:gsub(" ", "")
			v = scriptlinecasing(v)
			for _,command in pairs(commands) do
				local pattern = "^(" .. command .. "[%(,%)])0-"
				if #v > #command then
					if v:match(pattern .. flag1 .. "([%(,%)].*)$") then
						scripts[scriptnames[script_i]][k] = v:gsub(pattern .. flag1, "%1" .. flag2)
					elseif v:match(pattern .. flag1 .. "$") then
						scripts[scriptnames[script_i]][k] = v:gsub(pattern .. flag1, "%1" .. flag2)
					elseif v:match(pattern .. flag2 .. "([%(,%)].*)$") then
						scripts[scriptnames[script_i]][k] = v:gsub(pattern .. flag2, "%1" .. flag1)
					elseif v:match(pattern .. flag2 .. "$") then
						scripts[scriptnames[script_i]][k] = v:gsub(pattern .. flag2, "%1" .. flag1)
					end
				end
			end
		end
	end
end

function copyscript()
	love.system.setClipboardText(table.concat(inputs.script_lines, newline))
	setgenerictimer(1, .25)
end

function scriptinstack(script)
	if script == scriptname then
		return true
	end

	for _,v in pairs(scripthistorystack) do
		if script == v[1] then
			return true
		end
	end

	return false
end

function renamescriptline(line, pattern, newname)
	local endings = {"$", "([%(,%)].*)$"}
	if line:match(pattern .. endings[1]) then
		return line:gsub(pattern .. endings[1], "%1" .. newname)
	elseif line:match(pattern .. endings[2]) then
		return line:gsub(pattern .. endings[2], "%1" .. newname .. "%2")
	end
end

function updateroomline(line, pattern, transform, direction)
	local endings = {"$", "([%(,%)].*)$"}
	local match = {false, false}

	local _, x, _, y = line:match(pattern .. endings[1])
	if x == nil or y == nil then
		_, x, _, y = line:match(pattern .. endings[2])
		match[2] = true
	else
		match[1] = true
	end

	x, y = transform(x, y, direction)

	if x ~= nil and y ~= nil then
		if match[1] then
			return line:gsub(pattern .. endings[1], "%1" .. x .. "%3" .. y)
		elseif match[2] then
			return line:gsub(pattern .. endings[2], "%1" .. x .. "%3" .. y .. "%5")
		end
	end
end

function scriptlinecasing(line)
	if line:find("[%(,%)]") == nil then
		return line
	end

	-- Apparently VVVVVV lowercases script lines up until the last argument separator
	-- So "Flash" => "Flash", which is an invalid script command
	-- But "Flash(5" => "flash(5", which is a perfectly valid command
	-- More examples:
	--  "IftriNKETs(0,thiSScript)" => "iftrinkets(0,thisscript)"
	--  "iftrinkets(0,thiSScript" => "iftrinkets(0,thisscript"

	local lastargsep = line:reverse():find("[%(,%)]")

	line = line:sub(1, -lastargsep - 1):lower() .. line:sub(-lastargsep)

	return line
end

function loadflagslist()
	usedflags = {}
	outofrangeflags = {}

	-- Seee which flags have been used in this level.
	returnusedflags(usedflags, outofrangeflags)

	flags_outofrangeflagstext = ""

	for k,v in pairs(outofrangeflags) do
		if flags_outofrangeflagstext == "" then
			flags_outofrangeflagstext = L.USEDOUTOFRANGEFLAGS .. " " .. k
		else
			flags_outofrangeflagstext = flags_outofrangeflagstext .. ", " .. k
		end
	end
end

function delete_script(script_i)
	scripts[scriptnames[script_i]] = nil
	table.remove(scriptnames, script_i)
	dirty()

	-- We might have removed a script reference, so update usages
	usedscripts, n_usedscripts = findusedscripts()
end
