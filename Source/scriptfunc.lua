function return_used_flags(usedflagsA, outofrangeflagsA, specificflag, specificflag_usages)
	-- if specificflag is not given, then all used flags will be stored in usedflagsA and outofrangeflagsA.
	-- else, a list of script names is put in specificflag_usages, which is all usages of that flag,
	-- and the number of usages is returned (including multiple usages in the same script).
	local specificflag_n_real_usages = 0
	for script_i = #scriptnames, 1, -1 do
		local script_inserted = false
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			v = scriptlinecasing(v)
			local explcommaline = explode(",", v:gsub("%(", ","):gsub("%)", ","):gsub(" ", ""))

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

function parse_textbox_line_count(count)
	if count == nil then
		return nil
	end

	if count:sub(-1):lower() == "l" then
		return tonumber(count:sub(1,-2))
	end
	return tonumber(count)
end

function get_createcrewman_r(name)
	-- Basically implements VVVVVV's getcolorfromname(name).
	if name == "player" or name == "cyan" or name == "customcyan" then
		return 0
	elseif name == "red" then
		return 15
	elseif name == "green" then
		return 13
	elseif name == "yellow" then
		return 14
	elseif name == "blue" then
		return 16
	elseif name == "purple" then
		return 20
	elseif name == "teleporter" then
		return 102
	end

	-- If a number, then it's that number
	local n = tonumber(name)
	if n ~= nil and n >= 0 then
		return n
	end

	-- Gray, or anything unrecognized
	return 19
end

function get_textbox_color(text_color, alttextcolor)
	local r, g, b
	if extra.textboxcolors[text_color] == nil and textboxcolors[text_color] == nil then
		text_color = "gray"
	end
	if extra.textboxcolors[text_color] ~= nil then
		r, g, b = unpack(extra.textboxcolors[text_color])
	else
		r, g, b = unpack(textboxcolors[text_color])
	end
	if alttextcolor ~= nil then
		r = get_createcrewman_r(alttextcolor)
	end
	return r, g, b
end

function set_textbox_color(text_color, alttextcolor)
	local r, g, b = get_textbox_color(text_color, alttextcolor)
	if r == 0 and g == 0 and b == 0 then
		v6_setroomprintcol()
	else
		love.graphics.setColor(r, g, b)
	end
end

function syntax_hl(text, x, y, thisistext, current_line, docolor, lasttextcolor, alttextcolor)
	local textscale = s.scripteditor_largefont and 2 or 1

	local thisiscomment = text:sub(1,1) == "#" or text:sub(1,2) == "//"
	if thisistext or thisiscomment then
		if docolor and thisistext and s.colored_textboxes then
			set_textbox_color(lasttextcolor, alttextcolor)
		elseif docolor then
			setColorArr(thisistext and s.syntaxcolor_textbox or s.syntaxcolor_comment)
		end
		font_level:print(text, x, y, nil, textscale)

		return nil
	else
		local offset_chars = 0
		local offset_width = 0

		-- Replace characters by one with which we will split.
		text2 = text:gsub("%(", ","):gsub("%)", ",")

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
				if offset_chars == 0 then -- First word on the line, so it's a command.
					-- But is it recognized?
					-- `say` and `reply` are special and still work capitalized even with no argument separators
					local editing_command = false
					if current_line then
						local line_x = newinputsys.getpos("script_lines")
						editing_command = line_x <= utf8.len(v)
					end

					local intsc = internalscript or cutscenebarsinternalscript
					local is_sim = knowncommands[v_parsed:lower()]
					local is_int = knowninternalcommands[v_parsed]

					if (not intsc and is_sim)
					or (intsc and is_int) then
						setColorArr(s.syntaxcolor_command)
					elseif is_sim or is_int then
						setColorArr(s.syntaxcolor_wronglang)
					elseif editing_command then
						setColorArr(s.syntaxcolor_command)
					else
						setColorArr(s.syntaxcolor_errortext)
					end
				elseif parse_textbox_line_count(v_parsed) ~= nil then
					-- It's a number! It might be suffixed L, used in long textboxes
					setColorArr(s.syntaxcolor_number)
				elseif k == 2 and (
					partss_parsed[1] == "flag"
					or partss_parsed[1] == "ifflag"
					or partss_parsed[1] == "customifflag"
				) and tostring(tonumber(v)) ~= tostring(v) then
					-- if flag name is not used yet, newflagname
					for fl = 0, limit.flags-1 do
						if vedmetadata ~= false and vedmetadata.flaglabel[fl] == v then
							setColorArr(s.syntaxcolor_flagname)
							break
						end

						setColorArr(s.syntaxcolor_newflagname)
					end
				else
					setColorArr(s.syntaxcolor_generic)
				end

				-- First print the non-separator word!
				font_level:print(v, x+offset_width, y, nil, textscale)

				offset_chars = offset_chars + utf8.len(v)
				offset_width = offset_width + font_level:getWidth(v)*textscale

				-- Then the separator that follows it! (If present)
				local separator = utf8.sub(text, 1+offset_chars, 1+offset_chars)
				local separator_width = font_level:getWidth(separator)*textscale
				setColorArr(s.syntaxcolor_separator)
				font_level:print(
					separator,
					x + offset_width,
					y,
					nil,
					textscale
				)

				offset_chars = offset_chars + 1
				offset_width = offset_width + separator_width
			end
		else -- not docolor
			font_level:print(text:sub(1, text:len()), x, y, nil, textscale)
		end

		-- `say` and `reply` are exceptions - they still work when they're capitalized even with no argument separators
		-- Also, the default number of lines for `say` and `reply` is 1.
		-- But if the argument is empty (and not a trailing argument!) then it's 0!
		-- So:
		-- say    -> 1
		-- say(   -> 1
		-- say()  -> 0
		-- We check for this with partss[3] == nil
		if partss_parsed[1] == "say" then
			if partss[2] == nil or (partss_parsed[2] == "" and partss[3] == nil) then
				return 1, normalize_simplified_color(partss_parsed[3])
			else
				local lines = math.max(0, anythingbutnil0(parse_textbox_line_count(partss_parsed[2])))
				return lines, normalize_simplified_color(partss_parsed[3])
			end
		elseif partss_parsed[1] == "reply" then
			if partss[2] == nil or (partss_parsed[2] == "" and partss[3] == nil) then
				return 1, "player"
			else
				local lines = math.max(0, anythingbutnil0(parse_textbox_line_count(partss_parsed[2])))
				return lines, "player"
			end
		elseif partss_parsed[1] == "text" then
			if partss[5] == nil or anythingbutnil0(parse_textbox_line_count(partss_parsed[5])) <= 0 then
				return 0, partss_parsed[2]
			else
				return parse_textbox_line_count(partss_parsed[5]), partss_parsed[2]
			end
		elseif partss_parsed[1] == "setactivitytext" then
			return 1, "orange"
		elseif partss_parsed[1] == "setroomname" then
			return 1, "white"
		end
	end
end

function just_text(text, thisistext)
	-- Only checks for starts of textboxes above the screen. Does not draw any text!
	-- This is not "the function used when syntax highlighting is turned off",
	-- nor "the function used for textbox content"
	if not thisistext then
		text = text:gsub(" ", "")
		text = scriptlinecasing(text)
		if text:sub(1, 3) == "say" or text:sub(1, 5) == "reply" or text:sub(1, 4) == "text" then
			text2 = text:gsub("%(", ","):gsub("%)", ",")

			partss = explode(",", text2)
			local partss_parsed = {}

			for k, v in pairs(partss) do
				v = v:gsub(" ", "")
				if k < #partss then
					table.insert(partss_parsed, v:lower())
				else
					table.insert(partss_parsed, v)
				end
			end

			if partss_parsed[1] == "say" then
				if partss[2] == nil or anythingbutnil0(parse_textbox_line_count(partss_parsed[2])) <= 1 then
					return 1, normalize_simplified_color(partss_parsed[3])
				else
					return parse_textbox_line_count(partss_parsed[2]), normalize_simplified_color(partss_parsed[3])
				end
			elseif partss_parsed[1] == "reply" then
				if partss[2] == nil or anythingbutnil0(parse_textbox_line_count(partss_parsed[2])) <= 1 then
					return 1, "player"
				else
					return parse_textbox_line_count(partss_parsed[2]), "player"
				end
			elseif partss_parsed[1] == "text" then
				if partss[5] == nil or anythingbutnil0(parse_textbox_line_count(partss_parsed[5])) <= 0 then
					return 0, partss_parsed[2]
				else
					return parse_textbox_line_count(partss_parsed[5]), partss_parsed[2]
				end
			elseif partss_parsed[1] == "setactivitytext" then
				return 1, "orange"
			elseif partss_parsed[1] == "setroomname" then
				return 1, "white"
			end
		end

		return nil -- also redundant
	end

	return nil -- redundant
end

function script_context(text, textlinestogo)
	if textlinestogo ~= 0 or text:sub(1,1) == "#" or text:sub(1,2) == "//" then
		return nil
	end

	local text2 = anythingbutnil(text):gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
	text2 = scriptlinecasing(text2)

	parts = explode(",", text2)

	local function get_wrapped_coords(thex, they)
		local roomnum = thex + they*limit.mapwidth
		if roomnum < 0 or roomnum >= limit.mapwidth * limit.mapheight then
			return nil
		end
		they = math.floor(roomnum/limit.mapwidth)
		thex = roomnum % limit.mapwidth
		return thex, they
	end

	local line_x = newinputsys.getpos("script_lines")
	local editing_command = line_x <= utf8.len(parts[1])
	do
		local intsc = internalscript or cutscenebarsinternalscript
		local is_sim = knowncommands[parts[1]:lower()]
		local is_int = knowninternalcommands[parts[1]]

		if (not intsc and is_sim)
		or (intsc and is_int) then
			-- pass
		elseif is_sim or is_int then
			return "syntaxcolor_wronglang", parts[1]
		elseif editing_command then
			-- No Java IDE behavior, the cursor is on the command
			return nil
		else
			return "syntaxcolor_errortext", parts[1]
		end
	end

	if parts[1] == "flag" and parts[2] ~= nil then
		return "flag", tonumber(parts[2]), nil, nil
	elseif (
		parts[1] == "iftrinkets"
		or parts[1] == "iftrinketsless"
		or parts[1] == "customiftrinkets"
		or parts[1] == "customiftrinketsless"
		or parts[1] == "iflang"
	) and parts[3] ~= nil and parts[3] ~= "" then
		return "script", parts[3], nil, nil
	elseif (
		parts[1] == "loadscript"
		or parts[1] == "ifskip"
		or parts[1] == "teleportscript"
	) and parts[2] ~= nil and parts[2] ~= "custom_"
	and parts[2]:sub(1, ("custom_"):len()) == "custom_" then
		return "script", parts[2]:sub(("custom_"):len()+1, parts[2]:len()), nil
	elseif (
		parts[1] == "ifflag"
		or parts[1] == "customifflag"
	) and parts[2] ~= nil then
		return "flagscript", parts[2], parts[3], nil
	elseif (
		parts[1] == "ifcrewlost"
		or parts[1] == "iflast"
	) and parts[2] ~= nil and parts[3] ~= nil and parts[3] ~= "custom_"
	and parts[3]:sub(1, ("custom_"):len()) == "custom_" then
		return "script", parts[3]:sub(("custom_"):len()+1, parts[3]:len()), nil, nil
	elseif parts[1] == "ifexplored"
	and parts[2] ~= nil and parts[3] ~= nil and parts[4] ~= nil and parts[4] ~= "custom_"
	and parts[4]:sub(1, ("custom_"):len()) == "custom_" then
		local x, y = tonumber(parts[2]), tonumber(parts[3])
		if x == nil or y == nil then
			return "roomscript", x, y, nil
		end
		local script = parts[4]:sub(("custom_"):len()+1, parts[4]:len())
		x, y = get_wrapped_coords(x, y)
		return "roomscript", x, y, script
	elseif parts[1] == "ifwarp"
	and parts[2] ~= nil
	and parts[3] ~= nil
	and parts[4] ~= nil
	and parts[5] ~= nil
	and parts[5] ~= "" then
		local x, y = tonumber(parts[2]), tonumber(parts[3])
		if x == nil or y == nil then
			return "roomscript", x, y, nil
		end
		local script = parts[5]
		x, y = get_wrapped_coords(x, y)
		return "roomscript", x, y, script
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
			if x > metadata.mapwidth - 1 then
				x = 0
			end
			if y > metadata.mapheight - 1 then
				y = 0
			end
			if x < 0 then
				x = metadata.mapwidth - 1
			end
			if y < 0 then
				y = metadata.mapheight - 1
			end
		elseif table.contains({"hidecoordinates", "showcoordinates"}, parts[1]) then
			x, y = get_wrapped_coords(x, y)
		end
		return "room", x, y, nil
	elseif table.contains({"createentity", "createcrewman", "gotoposition"}, parts[1])
	and parts[2] ~= nil and parts[3] ~= nil then
		return "roomcoords", tonumber(parts[2]), tonumber(parts[3]), 2
	elseif table.contains({"text"}, parts[1])
	and tonumber(parts[3]) ~= nil and tonumber(parts[4]) ~= nil
	and tonumber(parts[3]) > 0
	and tonumber(parts[4]) > 0 then
		return "roomcoords", tonumber(parts[3]), tonumber(parts[4]), 3
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
	elseif parts[1] == "playef" and tonumber(parts[2]) ~= nil then
		return "sound", tonumber(parts[2]), nil, nil
	elseif parts[1] == "squeak" and parts[2] ~= nil then
		local effect = squeak_sounds[parts[2]]
		if effect ~= nil then
			return "sound", effect, nil, nil
		end
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
			return "track", music_simplified_to_internal[track], nil, nil
		else
			track = parts[2]:match("^%d+")
			track = tonumber(track)
			if track ~= nil then
				if track < 0 then
					track = nil
				else
					track = track
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
		if v:lower():match("^flag[%(,%)]")
		or v:lower():match("^ifflag[%(,%)]")
		or v:lower():match("^customifflag[%(,%)]") then
			-- Ok, how about now?
			text2 = v:gsub("%(", ","):gsub("%)", ",")

			-- We need to explode it anyways.
			local partss = explode(",", text2)

			if vedmetadata ~= false
			and vedmetadata.flaglabel[tonumber(partss[2])] ~= nil
			and vedmetadata.flaglabel[tonumber(partss[2])] ~= "" then
				-- This flag has a name
				readable_script[k] = readable_script[k]:gsub(" ", "")
				readable_script[k] = readable_script[k]:gsub(
					partss[2],
					vedmetadata.flaglabel[tonumber(partss[2])],
					1
				)
			end
		end
	end

	-- Is this an internal script?
	if (
		readable_script[1] ~= nil
		and (
			(
				readable_script[1]:sub(1,4) == "say("
				and readable_script[1]:sub(-4,-1) == ") #v"
			) or (
				readable_script[1] == "squeak(off) #v"
				and readable_script[2]:sub(1,4) == "say("
				and readable_script[2]:sub(-4,-1) == ") #v"
			)
		) and (
			readable_script[#readable_script] == "text(1,0,0,4) #v"
			or readable_script[#readable_script] == "text(1,0,0,3) #v"
		)
	) or (
		readable_script[1] == "squeak(off) #v"
		and readable_script[2] == "say(-1) #v"
		and readable_script[3] == "text(1,0,0,3) #v"
		and readable_script[4] ~= nil
		and readable_script[4]:sub(1,4) == "say("
		and readable_script[4]:sub(-4,-1) == ") #v"
	) then
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
			elseif (
				v:sub(1,4) == "say(" and v:sub(-4,-1) == ") #v"
			) or v == "text(1,0,0,4) #v" or v == "text(1,0,0,3) #v" then
				table.insert(removetheselines, k)
			end
		end

		-- Remove the lines we have to remove in reverse order,
		-- so the keys will remain the same for the items we're removing.
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
	return_used_flags(usedflags, outofrangeflags)

	-- Internal script handling!
	if internalscript or cutscenebarsinternalscript then
		local splithasfailed = false

		-- If we already end with (custom)?iftrinkets(0,... or loadscript(...,
		-- then we won't need the default loadscript(stop)
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

			if v:match("^speak$")
			or v:match("^speak[%(,%)]")
			or v:match("^speak_active$")
			or v:match("^speak_active[%(,%)]") then
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
			-- Just leave the script unconverted. There's still flag names
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
			local text2 = usev:gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
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
			local text2 = usev:gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
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
			textlinestogo = anythingbutnil0(partss[5])
		elseif partss_scriptcasing[1] == "setroomname" or partss_scriptcasing[1] == "setactivitytext" then
			textlinestogo = 1
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

function scriptineditor(scriptnamearg, script_i, invert_bump_preference)
	local should_bump = s.bumpscriptsbydefault
	if invert_bump_preference then
		should_bump = not should_bump
	end
	if should_bump then
		if script_i == nil then
			-- Find out which script it is
			for k,v in pairs(scriptnames) do
				if v == scriptnamearg then
					bumpscript(k)
				end
			end
		else
			bumpscript(script_i)
		end
	end

	scriptname = scriptnamearg
	tostate(3)
end

function check_script_warnings(scriptname)
	if scrwarncache_script == scriptname then -- cached script name is nil if not checked yet
		return
	end
	entityuses, loadscriptuses, scriptuses = find_script_references(scriptname)

	-- Warn in case no script is referring to this one.
	scrwarncache_warn_noloadscript = #loadscriptuses == 0 -- only applies to internal scripts
	scrwarncache_warn_boxed = #entityuses > 0 -- only applies to internal scripts
	scrwarncache_warn_name = scriptname:match(".*[A-Z %(%),].*") ~= nil and #entityuses == 0
	scrwarncache_script = scriptname
end

function find_script_references(argscriptname)
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
			local v2 = v:gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
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
				(
					partss[2] ~= nil
					and (partss[1] == "loadscript" or partss[1] == "ifskip" or partss[1] == "teleportscript")
					and partss[2]:sub(("custom_"):len()+1, partss[2]:len()) == argscriptname
				) or (
					partss[3] ~= nil
					and (partss[1] == "ifcrewlost" or partss[1] == "iflast")
					and partss[3]:sub(("custom_"):len()+1, partss[3]:len()) == argscriptname
				) or (
					partss[4] ~= nil
					and partss[1] == "ifexplored"
					and partss[4]:sub(("custom_"):len()+1, partss[4]:len()) == argscriptname
				)
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

function find_used_scripts()
	local usedscripts = {} -- the keys are the script names here, for an easier and more efficient (O(1)) lookup
	local count = 0

	for k,v in pairs(entitydata) do
		if (v.t == 18 or v.t == 19) and scripts[v.data] ~= nil then
			usedscripts[v.data] = true
		end
	end

	for script_i = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[script_i]]) do
			local v2 = v:gsub("%(", ","):gsub("%)", ","):gsub(" ", "")
			v2 = scriptlinecasing(v2)

			local partss = explode(",", v2)

			local add = nil
			if partss[1] == "iftrinkets"
			or partss[1] == "iftrinketsless"
			or partss[1] == "customiftrinkets"
			or partss[1] == "customiftrinketsless"
			or partss[1] == "ifflag"
			or partss[1] == "customifflag" then
				add = partss[3]
			elseif partss[1] == "ifwarp" then
				add = partss[5]
			elseif (
				partss[1] == "loadscript"
				or partss[1] == "ifskip"
				or partss[1] == "teleportscript"
			) and partss[2] ~= nil and partss[2]:sub(1, ("custom_"):len()) == "custom_" then
				add = partss[2]:sub(("custom_"):len()+1, partss[2]:len())
			elseif (
				partss[1] == "ifcrewlost"
				or partss[1] == "iflast"
			) and partss[3] ~= nil and partss[3]:sub(1, ("custom_"):len()) == "custom_" then
				add = partss[3]:sub(("custom_"):len()+1, partss[3]:len())
			elseif partss[1] == "ifexplored" and partss[4] ~= nil and partss[4]:sub(1, ("custom_"):len()) == "custom_" then
				add = partss[4]:sub(("custom_"):len()+1, partss[4]:len())
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
		newinputsys.setpos("script_lines", 0, linenum, true)
	else
		local col_offset = utf8.offset(line_contents, colnum)
		if col_offset == nil then
			newinputsys.setpos("script_lines", 0, linenum, true)
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
			{"line", 0, 1, 8, "", DF.TEXT}
		},
		dialog.callback.scriptgotoline_validate
	)
end

function scriptlineonscreen(ln)
	if ln == nil then
		_, ln = newinputsys.getpos("script_lines")
	end

	local font_height = font_level:getHeight()
	local textscale = s.scripteditor_largefont and 2 or 1
	local font_height_sc = font_height * textscale

	-- How high is the part where commands are displayed? And keep a bit of space from the borders...
	local fitting_height = love.graphics.getHeight()-24 - 16

	scriptscroll = math.max(scriptscroll, -(font_height_sc*(ln-1)))
	scriptscroll = math.min(scriptscroll, -(font_height_sc*ln-fitting_height))
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

	-- See which flags have been used in this level.
	return_used_flags(usedflags, outofrangeflags)

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
	usedscripts, n_usedscripts = find_used_scripts()
end
