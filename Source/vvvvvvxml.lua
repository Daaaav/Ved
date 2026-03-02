local vedxml = require("vedxml")

-- First some things that could as well have gone in const.lua but are here for easy reference.
metadataitems = {
	"Creator", -- name
	"Title",
	"Created", -- 2?
	"Modified", -- empty?
	"Modifiers", -- 2?
	"Desc1", "Desc2", "Desc3",
	"website"
}

function loadlevelmetadata(path)
	-- Returns (bool)success, (table)metadata, (VedXML)xml
	-- Map size and music is gonna move in with the metadata here.
	-- If loading isn't successful, metadata will be an error string.

	local success, contents = readlevelfile(levelsfolder .. dirsep .. path)

	if not success or contents == nil then
		return false, contents
	end

	local thismetadata = {}

	thismetadata.target = "V"

	local xml
	local errmsg
	success, errmsg = pcall(function()
		xml = vedxml.VedXML:new{string=contents, root="MapData"}

		-- First do the metadata.
		cons("Loading metadata...")
		local xdata = xml:find(nil, "Data")
		local xmetadata = xml:find(xdata, "MetaData")
		for _,v in pairs(metadataitems) do
			local m = xml:find(xmetadata, v)
			thismetadata[v] = xml:get_text(m)
		end

		-- These ones are optional.
		thismetadata.onewaycol_override = false
		thismetadata.font = "font"
		thismetadata.rtl = false
		local m = xml:find_or_nil(xmetadata, "onewaycol_override")
		if m ~= nil then
			thismetadata.onewaycol_override = xml:get_text(m) ~= "0"
		end
		m = xml:find_or_nil(xmetadata, "font")
		if m ~= nil then
			thismetadata.font = xml:get_text(m)
		end
		m = xml:find_or_nil(xmetadata, "rtl")
		if m ~= nil then
			thismetadata.rtl = xml:get_text(m) ~= "0"
		end

		-- But we'll have room size and music also move in with the metadata.
		cons("Loading room size and music...")
		for _,v in pairs({"mapwidth", "mapheight", "levmusic"}) do
			local m = xml:find(xdata, v)
			thismetadata[v] = tonumber(xml:get_text(m))
		end
	end)

	if not success then
		return false, L.MAL .. errmsg
	end

	return true, thismetadata, xml
end

function loadlevel(path)
	-- Returns (bool)success, (Level)level
	-- Map size and music is gonna move in with the metadata here.
	-- Roomdata is the tiles, and is a 3D table indexed [roomy][roomx][1-1200]
	-- Entities consists of tables (entity contents are table item data)
	-- Levelmetadata is a 3D table indexed [roomy][roomx][property] (roomname is table item roomname)
	-- Scripts are pre-exploded and scripts[scriptname] = (table)contents
	-- count will return the count of trinkets, crewmates and entities to keep everything within limits. It also contains the ID of the start point so it can be removed in case we place a new one.
	-- scriptnames is used to keep the names in order of opening scripts
	-- vedmetadata has flag names (.flaglabel)
	-- If loading isn't successful, we return false and an error string.

	local success, thismetadata, xml = loadlevelmetadata(path)

	if not success then
		return false, thismetadata
	end

	local function cons_fc(list, text)
		table.insert(list, text)
		cons("[CHECK] " .. text)
	end

	local lvl = Level:new()

	-- FC = Failed Checks
	local FC = 0
	local FClist = {}

	local n_roommetadata = 0

	local errmsg
	success, errmsg = pcall(function()
		-- Get any well-formedness problems out of the way
		xml:tokenize_to_end()

		-- This isn't a VCE level, right?
		if xml:get_attribute(nil, "vceversion") ~= nil then
			FC = FC + 1
			cons_fc(FClist, L.VCE_REMOVED)
		end

		local xdata = xml:find(nil, "Data")

		-- Now, the contents!
		cons("Loading all the contents...")

		-- Ok, explode() is far too inefficient, what else have we got?
		local alltiles = {}
		local csv = xml:get_text(xml:find(xdata, "contents"))
		for num in csv:gmatch("([^,]*),") do
			table.insert(alltiles, num)
		end

		cons("Contents split (setting all rooms now)")

		-- Ok we need to correctly set all rooms... Rooms have 1200 tiles
		local failedtiles = 0
		local t
		for yk = 0, math.min(thismetadata.mapheight, lvl.limit.mapheight)-1 do
			--print("Y: " .. yk)
			lvl.tiles[yk] = {}
			for xk = 0, math.min(thismetadata.mapwidth, lvl.limit.mapwidth)-1 do
				lvl.tiles[yk][xk] = {}
				for yt = 0, 29 do
					for xt = 0, 39 do
						t = tonumber(alltiles[(yk*1200*thismetadata.mapwidth) + (xk*40) + (yt*thismetadata.mapwidth*40) + xt + 1])
						if t == nil or t < 0 then
							t = 0
							failedtiles = failedtiles + 1
						elseif math.floor(t) ~= t then
							t = math.floor(t)
							failedtiles = failedtiles + 1
						end

						lvl.tiles[yk][xk][(40*yt) + xt + 1] = t
					end
				end
			end
		end

		if failedtiles > 0 then
			FC = FC + 1
			cons_fc(FClist, langkeys(L_PLU.NOTALLTILESVALID, {failedtiles}))
		end

		-- Entities.
		cons("Loading entities...")

		local entityid = 0
		local morethanonestartpoint = false

		local xentities = xml:find(xdata, "edEntities")
		for entity in xml:each_child_element(xentities, "edentity") do
			entityid = entityid + 1
			lvl.entities[entityid] = {}

			local attributes = xml:get_attributes(entity)
			for k,v in pairs(attributes) do
				lvl.entities[entityid][k] = tonumber(v)
			end

			-- Now we only need the data...
			-- In VVVVVV 2.2 and below, there used to be a newline
			-- and 12 spaces at the end of every edentity tag.
			-- Nowadays we just chop that off if present.
			local data = xml:get_text(entity)
			if data ~= "" and data:match("\n            $") ~= nil then
				data = data:sub(1,-14)
			end
			lvl.entities[entityid].data = data

			-- Now before we go to the next one, if it's a trinket or crewmate,
			-- add it up, because we can only have 100 in a level. Officially.
			-- Also, parse the special data entity here if we found it.
			if lvl.entities[entityid].t == 9 then
				lvl.count.trinkets = lvl.count.trinkets + 1
			elseif lvl.entities[entityid].t == 15 then
				lvl.count.crewmates = lvl.count.crewmates + 1
			elseif lvl.entities[entityid].t == 16 then
				if lvl.count.startpoint == nil then
					lvl.count.startpoint = entityid
				else
					-- Multiple start points in a level is weird
					-- VVVVVV will pick the first one anyway, and we've already picked the first one, so no need to change it
					if not morethanonestartpoint then
						morethanonestartpoint = true
						FC = FC + 1
						cons_fc(FClist, L.MORETHANONESTARTPOINT)
					end
					lvl.entities[entityid] = nil
					lvl.count.entities = lvl.count.entities - 1
				end
			elseif ((lvl.entities[entityid].x == 800 and lvl.entities[entityid].y == 600)
			or (lvl.entities[entityid].x == 4000 and lvl.entities[entityid].y == 3000))
			and lvl.entities[entityid].t == 17 then
				-- This is the metadata entity!
				local explodedmetadata = explode("|", lvl.entities[entityid].data:gsub("\n", ""))

				lvl.vedmetadata = createmde(lvl.limit)

				lvl.vedmetadata.mdeversion = anythingbutnil0(explodedmetadata[1])

				if lvl.vedmetadata.mdeversion > thismdeversion then
					dialog.create(L.MDEVERSIONWARNING)
				end

				if lvl.vedmetadata.mdeversion >= 2 and explodedmetadata[2] ~= nil then
					local explodedflags = explode("%$", explodedmetadata[2])
					local f = -1
					for k,v in pairs(explodedflags) do
						-- Make sure the numbers start with 0
						f = k-1
						lvl.vedmetadata.flaglabel[f] = undespecialchars(v)
					end
					for i = f+1, lvl.limit.flags-1 do
						lvl.vedmetadata.flaglabel[i] = ""
					end
				else
					for f = 0, lvl.limit.flags-1 do
						lvl.vedmetadata.flaglabel[f] = ""
					end
				end

				if lvl.vedmetadata.mdeversion >= 3 and explodedmetadata[4] ~= "" and explodedmetadata[4] ~= nil then
					local explodedvars = explode("%$", explodedmetadata[4])
					for k,v in pairs(explodedvars) do
						local explodedvar = explode("@", v)
						local key = undespecialchars(explodedvar[1])
						if explodedvar[2] == "t" then
							table.remove(explodedvar, 1); table.remove(explodedvar, 1)
							for k2, v2 in pairs(explodedvar) do
								if k2 % 2 == 0 then
									explodedvar[k2] = undespecialchars(v2)
								end
							end
							lvl.vedmetadata.vars[key] = {
								["type"] = "t",
								value = explodedvar
							}
						elseif (#explodedvar) >= 3 then
							lvl.vedmetadata.vars[key] = {
								["type"] = explodedvar[2],
								value = undespecialchars(explodedvar[3])
							}
						end
					end
				end

				if explodedmetadata[5] ~= "" and explodedmetadata[5] ~= nil then
					local explodednotes = explode("%$", explodedmetadata[5])
					for k,v in pairs(explodednotes) do
						local explodednote = explode("@", v)
						--lvl.vedmetadata.notes[undespecialchars(explodednote[1])] = undespecialchars(explodednote[2])
						table.insert(lvl.vedmetadata.notes,
							{
								subj = undespecialchars(explodednote[1]),
								imgs = {},
								cont = undespecialchars(explodednote[2])
							}
						)
					end
				end

				-- Nil this entity now so we don't store multiple ones when saving
				lvl.entities[entityid] = nil
			end

			-- It's an entity, that's for sure!
			lvl.count.entities = lvl.count.entities + 1

			local oldFCcount = FC

			-- We might have just nil'd this entity because it was the data entity.
			if lvl.entities[entityid] ~= nil then
				if lvl.entities[entityid].x == nil or type(lvl.entities[entityid].x) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].x = 0
				end
				if lvl.entities[entityid].y == nil or type(lvl.entities[entityid].y) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].y = 0
				end
				if lvl.entities[entityid].t == nil or type(lvl.entities[entityid].t) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].t = 0
				end
				if lvl.entities[entityid].p1 == nil or type(lvl.entities[entityid].p1) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p1 = 0
				end
				if lvl.entities[entityid].p2 == nil or type(lvl.entities[entityid].p2) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p2 = 0
				end
				if lvl.entities[entityid].p3 == nil or type(lvl.entities[entityid].p3) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p3 = 0
				end
				if lvl.entities[entityid].p4 == nil or type(lvl.entities[entityid].p4) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p4 = 0
				end
				if lvl.entities[entityid].p5 == nil or type(lvl.entities[entityid].p5) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p5 = 0
				end
				if lvl.entities[entityid].p6 == nil or type(lvl.entities[entityid].p6) ~= "number" then
					FC = FC + 1
					lvl.entities[entityid].p6 = 0
				end
			end

			if oldFCcount < FC then
				cons_fc(
					FClist,
					langkeys(
						L_PLU.ENTITYINVALIDPROPERTIES,
						{
							anythingbutnil(lvl.entities[entityid].x),
							anythingbutnil(lvl.entities[entityid].y),
							(FC-oldFCcount)
						},
						3
					)
				)
			end
		end

		-- See this as MySQL's AUTO_INCREMENT
		lvl.count.entity_ai = entityid + 1

		-- Level meta data - get every room now.
		cons("Loading room metadata...")

		local all_platvs = {}
		local lmd_width = 20
		local rx, ry = lmd_width-1, -1
		local inboundsroom = 0
		local inbounds

		local xlevelmetadata = xml:find(xdata, "levelMetaData")
		for room in xml:each_child_element(xlevelmetadata, "edLevelClass") do
			n_roommetadata = n_roommetadata + 1
			rx = rx + 1
			if rx >= lmd_width then
				rx = 0
				ry = ry + 1
				lvl.roommetadata[ry] = {}
			end
			if rx < thismetadata.mapwidth and ry < thismetadata.mapheight then
				inbounds = true
				inboundsroom = inboundsroom + 1
			else
				inbounds = false
			end
			lvl.roommetadata[ry][rx] = {}

			local attributes = xml:get_attributes(room)
			for k,v in pairs(attributes) do
				if k == "platv" then
					-- Unfortunately platv is very special.
					table.insert(all_platvs, tonumber(v))
					if inbounds then
						lvl.roommetadata[ry][rx].platv = all_platvs[inboundsroom]
					else
						lvl.roommetadata[ry][rx].platv = 4
					end
				else
					lvl.roommetadata[ry][rx][k] = tonumber(v)
				end
			end

			-- Now we only need the room name...
			lvl.roommetadata[ry][rx].roomname = xml:get_text(room)

			-- And make sure directmode isn't nil for 2.0 levels
			if lvl.roommetadata[ry][rx].directmode == nil then
				lvl.roommetadata[ry][rx].directmode = 0
			end

			local oldFCcount = FC

			if lvl.roommetadata[ry][rx].tileset == nil
			or type(lvl.roommetadata[ry][rx].tileset) ~= "number"
			or (lvl.roommetadata[ry][rx].tileset > 4) then
				FC = FC + 1
				lvl.roommetadata[ry][rx].tileset = 0
			end
			if lvl.roommetadata[ry][rx].tilecol == nil
			or type(lvl.roommetadata[ry][rx].tilecol) ~= "number"
			or ((lvl.roommetadata[ry][rx].tileset == 0 and lvl.roommetadata[ry][rx].tilecol < -1)
			or (lvl.roommetadata[ry][rx].tileset ~= 0 and lvl.roommetadata[ry][rx].tilecol < 0))
			or lvl.roommetadata[ry][rx].tileset == 0 and lvl.roommetadata[ry][rx].tilecol > 31
			or lvl.roommetadata[ry][rx].tileset == 1 and lvl.roommetadata[ry][rx].tilecol > 7
			or lvl.roommetadata[ry][rx].tileset == 2 and lvl.roommetadata[ry][rx].tilecol > 6
			or lvl.roommetadata[ry][rx].tileset == 3 and lvl.roommetadata[ry][rx].tilecol > 6
			or lvl.roommetadata[ry][rx].tileset == 4 and lvl.roommetadata[ry][rx].tilecol > 5
			or lvl.roommetadata[ry][rx].tileset == 5 and lvl.roommetadata[ry][rx].tilecol > 29 then
				FC = FC + 1
				lvl.roommetadata[ry][rx].tilecol = 0
			end
			if lvl.roommetadata[ry][rx].platx1 == nil or type(lvl.roommetadata[ry][rx].platx1) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].platx1 = 0
			end
			if lvl.roommetadata[ry][rx].platy1 == nil or type(lvl.roommetadata[ry][rx].platy1) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].platy1 = 0
			end
			if lvl.roommetadata[ry][rx].platx2 == nil or type(lvl.roommetadata[ry][rx].platx2) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].platx2 = 0
			end
			if lvl.roommetadata[ry][rx].platy2 == nil or type(lvl.roommetadata[ry][rx].platy2) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].platy2 = 0
			end
			if lvl.roommetadata[ry][rx].platv == nil or type(lvl.roommetadata[ry][rx].platv) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].platv = 0
			end
			if lvl.roommetadata[ry][rx].enemyx1 == nil or type(lvl.roommetadata[ry][rx].enemyx1) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].enemyx1 = 0
			end
			if lvl.roommetadata[ry][rx].enemyy1 == nil or type(lvl.roommetadata[ry][rx].enemyy1) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].enemyy1 = 0
			end
			if lvl.roommetadata[ry][rx].enemyx2 == nil or type(lvl.roommetadata[ry][rx].enemyx2) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].enemyx2 = 0
			end
			if lvl.roommetadata[ry][rx].enemyy2 == nil or type(lvl.roommetadata[ry][rx].enemyy2) ~= "number" then
				FC = FC + 1
				lvl.roommetadata[ry][rx].enemyy2 = 0
			end
			if lvl.roommetadata[ry][rx].enemytype == nil or type(lvl.roommetadata[ry][rx].enemytype) ~= "number"
			or lvl.roommetadata[ry][rx].enemytype < 0 or lvl.roommetadata[ry][rx].enemytype > 9 then
				FC = FC + 1
				lvl.roommetadata[ry][rx].enemytype = 0
			end
			if lvl.roommetadata[ry][rx].warpdir == nil or type(lvl.roommetadata[ry][rx].warpdir) ~= "number"
			or lvl.roommetadata[ry][rx].warpdir < 0 or lvl.roommetadata[ry][rx].warpdir > 3 then
				FC = FC + 1
				lvl.roommetadata[ry][rx].warpdir = 0
			end

			lvl.roommetadata[ry][rx].auto2mode = 0

			if oldFCcount < FC then
				local co = not s.coords0 and 1 or 0
				cons_fc(FClist, langkeys(L_PLU.ROOMINVALIDPROPERTIES , {rx+co, ry+co, (FC-oldFCcount)}, 3))
			end

			-- If you select a higher tilecol in space station and then go to another tileset,
			-- VVVVVV will still save the out-of-range tilecol.
			if tilesetblocks[lvl.roommetadata[ry][rx].tileset].colors[lvl.roommetadata[ry][rx].tilecol] == nil then
				lvl.roommetadata[ry][rx].tilecol = 0
			end
		end

		-- Scripts
		cons("Loading scripts...")
		local scriptdata = xml:get_text(xml:find(xdata, "script"))
		if scriptdata:sub(-1,-1) ~= "|" then
			scriptdata = scriptdata .. "|"
		end
		local scriptlines = {}
		for ln in scriptdata:gmatch("([^|]*)|") do
			table.insert(scriptlines, ln)
		end
		cons("There are " .. (#scriptlines) .. " lines of scripting! Loading all of that...")

		if #scriptlines > 1 then
			-- We don't want a crash now do we?
			local currentscript, sline = "", 1

			for k,v in pairs(scriptlines) do
				if v:sub(-1, -1) == ":" then
					-- This is a script name!
					currentscript = v:sub(1, -2)
					if lvl.scripts[currentscript] == nil then
						table.insert(lvl.scriptnames, currentscript)
					else
						-- We've seen this script before, that's not good
						FC = FC + 1
						cons_fc(FClist, langkeys(L.DUPLICATESCRIPT, {currentscript}))
					end
					lvl.scripts[currentscript] = {}
					sline = 1
				else
					-- This is just a line. But have we encountered a script name before?
					if lvl.scripts[currentscript] ~= nil then
						lvl.scripts[currentscript][sline] = v
						sline = sline + 1
					else
						FC = FC + 1
						cons_fc(FClist, langkeys(L.UNEXPECTEDSCRIPTLINE, {anythingbutnil(v)}))
					end
				end
			end
		end

		-- Some things that for now we'll have to hardcode carrying over...
		-- If not found, they'll be nil, and we won't insert them later.
		cons("Loading possible TextboxColours and SpecialRoomnames...")

		local xtextboxcolors = xml:find_or_nil(xdata, "TextboxColours")
		if xtextboxcolors ~= nil then
			for color in xml:each_child_element(xtextboxcolors, "colour") do
				local attr = xml:get_attributes(color)
				if attr.name ~= nil then
					local r, g, b = 255, 255, 255
					if attr.r ~= nil then
						r = tonumber(attr.r)
					end
					if attr.g ~= nil then
						g = tonumber(attr.g)
					end
					if attr.b ~= nil then
						b = tonumber(attr.b)
					end

					if lvl.textboxcolors[attr.name] == nil then
						table.insert(lvl.textboxcolors_order, attr.name)
					end
					lvl.textboxcolors[attr.name] = {r, g, b}
				end
			end
		end

		local xspecialroomnames = xml:find_or_nil(xdata, "SpecialRoomnames")
		if xspecialroomnames ~= nil then
			for roomname in xml:each_child_element(xspecialroomnames) do
				local mode = xml:get_name(roomname)
				local attr = xml:get_attributes(roomname)
				local rx, ry, flag = tonumber(attr.x), tonumber(attr.y), tonumber(attr.flag)
				if rx == nil then rx = 0 end
				if ry == nil then ry = 0 end
				if flag == nil then flag = -1 end
				local loop = attr.loop == "1"

				local name
				if mode == "transform" or mode == "glitch" then
					name = {}
					for child in xml:each_child_element(roomname, "text") do
						table.insert(name, xml:get_text(child))
					end
					if mode == "transform" then
						if #name < 1 then
							table.insert(name, "")
						end
					else
						while #name < 2 do
							table.insert(name, "")
						end
					end
				else
					mode = "static"
					name = xml:get_text(roomname)
				end

				if lvl.specialroomnames[ry] == nil then
					lvl.specialroomnames[ry] = {}
				end
				if lvl.specialroomnames[ry][rx] == nil then
					lvl.specialroomnames[ry][rx] = {}
					table.insert(lvl.specialroomnames_order, {x=rx, y=ry})
				end
				table.insert(lvl.specialroomnames[ry][rx],
					{
						mode = mode,
						flag = flag,
						loop = loop,
						name = name,
						progress = 0
					}
				)
			end
		end
	end)

	if not success then
		return false, L.MAL .. errmsg
	end

	cons("Done loading!")

	-- As many of the integrity checks as possible here
	if (type(thismetadata.mapwidth) ~= "number") or (thismetadata.mapwidth < 1) then
		FC = FC + 1
		cons_fc(FClist, langkeys(L.MAPWIDTHINVALID, {anythingbutnil(thismetadata.mapwidth)}))
		thismetadata.mapwidth = 1
	end
	if (type(thismetadata.mapheight) ~= "number") or (thismetadata.mapheight < 1) then
		FC = FC + 1
		cons_fc(FClist, langkeys(L.MAPHEIGHTINVALID, {anythingbutnil(thismetadata.mapheight)}))
		thismetadata.mapheight = 1
	end
	if ((thismetadata.mapwidth > lvl.limit.mapwidth) or (thismetadata.mapheight > lvl.limit.mapheight)) then
		FC = FC + 1
		cons_fc(
			FClist,
			langkeys(L.MAPBIGGERTHANSIZELIMIT,
				{
					anythingbutnil(thismetadata.mapwidth),
					anythingbutnil(thismetadata.mapheight),
					lvl.limit.mapwidth,
					lvl.limit.mapheight
				}
			)
		)
		thismetadata.mapwidth = math.min(thismetadata.mapwidth, lvl.limit.mapwidth)
		thismetadata.mapheight = math.min(thismetadata.mapheight, lvl.limit.mapheight)
	end
	if (thismetadata.levmusic == nil) or (thismetadata.levmusic == "") then
		FC = FC + 1
		cons_fc(FClist, L.LEVMUSICEMPTY)
		thismetadata.levmusic = 0
	end
	if n_roommetadata ~= 400 then
		FC = FC + 1
		cons_fc(FClist, L.NOT400ROOMS)

		--[[ TODO: Think about readding this later, after converting it to the 3D table
		if #lvl.roommetadata < 400 then
			for croom = #lvl.roommetadata+1, 400 do
				lvl.roommetadata[croom] = {
					tileset = 0,
					tilecol = ((croom-1) % 20 + (math.floor((croom-1)/20))) % 32,
					platx1 = 0,
					platy1 = 0,
					platx2 = 320,
					platy2 = 240,
					platv = 4,
					enemyx1 = 0,
					enemyy1 = 0,
					enemyx2 = 320,
					enemyy2 = 240,
					enemytype = 0,
					directmode = 0,
					warpdir = 0,
					roomname = "",
					auto2mode = 0,
				}
			end
		end
		]]
	end

	if FC ~= 0 then
		local FClisttext = ""

		for k,v in pairs(FClist) do
			if k > 5 then
				FClisttext = FClisttext .. "... " .. langkeys(L.MOREERRORS, {(#FClist-5)})
				break
			end

			FClisttext = FClisttext .. arrow_right .. " " .. v .. "\n"
		end

		dialog.create(langkeys(L_PLU.LEVELFAILEDCHECKS, {FC}) .. "\n\n" .. FClisttext)
	end

	lvl.metadata = thismetadata
	lvl.xml = xml

	return true, lvl
end


function savelevel(path, lvl, crashed, invvvvvvfolder)
	-- Assumes we've already checked whether the file already exists and whatnot, immediately saves!
	-- Returns success, (if not) error message
	if (path == "") then
		return false, L.FORGOTPATH
	end

	if invvvvvvfolder == nil then
		invvvvvvfolder = true
	end

	-- First make a backup of the file we'll overwrite - if it exists and we haven't crashed.
	if not crashed and s.enableoverwritebackups and path ~= nil then
		backup_level(levelsfolder, path:sub(1, -8))
	end

	lvl.xml:set_attribute(nil, "version", 2)
	local xdata = lvl.xml:find_or_add(nil, "Data")

	cons("Placing metadata...")

	local xmetadata = lvl.xml:find_or_add(xdata, "MetaData")
	for k,v in pairs(metadataitems) do
		cons("Doing " .. v)
		local el = lvl.xml:find_or_add(xmetadata, v)
		lvl.xml:set_text(el, anythingbutnil(lvl.metadata[v]))
	end

	-- Special cases of metadata that may or may not be stored...
	if lvl.metadata.onewaycol_override then
		local el = lvl.xml:find_or_add(xmetadata, "onewaycol_override")
		lvl.xml:set_text(el, 1)
	else
		lvl.xml:delete_each_child_element(xmetadata, "onewaycol_override")
	end
	if lvl.metadata.font ~= "" and lvl.metadata.font ~= "font" then
		local el = lvl.xml:find_or_add(xmetadata, "font")
		lvl.xml:set_text(el, lvl.metadata.font)
	else
		lvl.xml:delete_each_child_element(xmetadata, "font")
	end
	if lvl.metadata.rtl then
		local el = lvl.xml:find_or_add(xmetadata, "rtl")
		lvl.xml:set_text(el, 1)
	else
		lvl.xml:delete_each_child_element(xmetadata, "rtl")
	end

	-- Hold on for a second, we need the map size and music too!
	lvl.xml:set_text(lvl.xml:find_or_add(xdata, "mapwidth"), lvl.metadata.mapwidth)
	lvl.xml:set_text(lvl.xml:find_or_add(xdata, "mapheight"), lvl.metadata.mapheight)
	lvl.xml:set_text(lvl.xml:find_or_add(xdata, "levmusic"), lvl.metadata.levmusic)

	-- The contents are gonna be the hardest!
	cons("Assembling contents......")
	local thenewcontents = {}
	for lroomy = 0, lvl.metadata.mapheight-1 do
		-- We now have each y.....
		cons("Y: " .. lroomy)
		for line = 0, 29 do
			-- (each line)
			for lroomx = 0, lvl.metadata.mapwidth-1 do
				-- .....And each x for each line
				table.insert(thenewcontents, table.concat({unpack(lvl.tiles[lroomy][lroomx], (line*40)+1, (line*40)+40)}, ","))
			end
		end
	end
	local xcontents = lvl.xml:find_or_add(xdata, "contents")
	lvl.xml:set_text(xcontents, table.concat(thenewcontents, ",") .. ",")

	-- Now do all entities, if we have any!
	cons("Saving entities...")

	local xentities = lvl.xml:find_or_add(xdata, "edEntities")
	lvl.xml:clear(xentities)

	local entitiessaved = 0
	-- No pairs(lvl.entities) here, that might end iterating at a nil
	for k = 1, lvl.count.entity_ai-1 do
		if lvl.entities[k] ~= nil then
			local v = lvl.entities[k]
			local data = v.data
			if v.t ~= 17 and v.t ~= 18 and v.t ~= 19 and data:len() > 40 then
				-- VVVVVV has saved a lot of data to this entity, which shouldn't even have data - let's save some space.
				entitiessaved = entitiessaved + data:len()
				data = ""
			end
			local entity = lvl.xml:add_element_in_last(xentities, "edentity")
			-- I do wanna keep the attribute order the same, but also preserve any additional ones...
			lvl.xml:set_attribute(entity, "x", v.x)
			lvl.xml:set_attribute(entity, "y", v.y)
			lvl.xml:set_attribute(entity, "t", v.t)
			lvl.xml:set_attribute(entity, "p1", v.p1)
			lvl.xml:set_attribute(entity, "p2", v.p2)
			lvl.xml:set_attribute(entity, "p3", v.p3)
			lvl.xml:set_attribute(entity, "p4", v.p4)
			lvl.xml:set_attribute(entity, "p5", v.p5)
			lvl.xml:set_attribute(entity, "p6", v.p6)
			for ak,av in pairs(v) do
				if ak ~= "x" and ak ~= "y" and ak ~= "t"
				and ak ~= "p1" and ak ~= "p2" and ak ~= "p3"
				and ak ~= "p4" and ak ~= "p5" and ak ~= "p6"
				and ak ~= "data" then
					lvl.xml:set_attribute(entity, ak, av)
				end
			end
			lvl.xml:set_text(entity, data)
		end
	end

	if lvl.vedmetadata ~= false and lvl.vedmetadata ~= nil then
		-- We have a metadata entity to save!
		-- As for flag names concatenation, table.concat expects all tables to start at index 1.
		local mdedata = thismdeversion .. "|"

		local max_labeled_flag = -1
		for f = lvl.limit.flags-1, 0, -1 do
			if lvl.vedmetadata.flaglabel[f] ~= "" then
				max_labeled_flag = f
				break
			end
		end
		if max_labeled_flag ~= -1 then
			mdedata = mdedata .. despecialchars(lvl.vedmetadata.flaglabel[0])

			for k = 1, max_labeled_flag do -- 0 added above
				mdedata = mdedata .. "$" .. despecialchars(lvl.vedmetadata.flaglabel[k])
			end
		end

		mdedata = mdedata .. "||"

		-- Vars
		local varsdata = {}

		for k,v in pairs(lvl.vedmetadata.vars) do
			if v["type"] == "t" then
				local values = ""
				for k2,v2 in pairs(v.value) do
					if k2 % 2 == 0 then
						v2 = despecialchars(v2)
					end
					values = values .. "@" .. v2
				end
				table.insert(varsdata, despecialchars(k) .. "@t" .. values)
			else
				table.insert(varsdata, despecialchars(k) .. "@" .. v["type"] .. "@" .. despecialchars(v.value))
			end
		end

		mdedata = mdedata .. table.concat(varsdata, "$") .. "|"

		-- Now add the notes to it!
		local notesdata = {}

		for k,v in pairs(lvl.vedmetadata.notes) do
			table.insert(notesdata, despecialchars(v.subj) .. "@" .. despecialchars(v.cont))
		end

		mdedata = mdedata .. table.concat(notesdata, "$")

		local entity = lvl.xml:add_element_in_last(xentities, "edentity")
		lvl.xml:set_attribute(entity, "x", 4000)
		lvl.xml:set_attribute(entity, "y", 3000)
		lvl.xml:set_attribute(entity, "t", 17)
		lvl.xml:set_attribute(entity, "p1", 0)
		lvl.xml:set_attribute(entity, "p2", 0)
		lvl.xml:set_attribute(entity, "p3", 0)
		lvl.xml:set_attribute(entity, "p4", 0)
		lvl.xml:set_attribute(entity, "p5", 320)
		lvl.xml:set_attribute(entity, "p6", 240)
		lvl.xml:set_text(entity, mdedata)
	end

	if entitiessaved > 0 then
		cons("Done with entities, " .. entitiessaved .. " bytes were saved from unnecessary entity data.")
	else
		cons("Done with entities.")
	end

	-- Now all room metadata, aka levelclass
	cons("Saving room metadata...")

	local xlevelmetadata = lvl.xml:find_or_add(xdata, "levelMetaData")
	lvl.xml:clear_open(xlevelmetadata)

	local all_platvs = {}
	for y = 0, lvl.metadata.mapheight-1 do
		for x = 0, lvl.metadata.mapwidth-1 do
			-- platv needs special handling, unfortunately.
			table.insert(all_platvs, lvl.roommetadata[y][x].platv)
		end
	end
	local i = 1
	local lmd_w, lmd_h = 20, 20
	for y = 0, lmd_h-1 do
		for x = 0, lmd_w-1 do
			local v = lvl.roommetadata[y][x]
			local my_platv
			my_platv = all_platvs[i]
			if my_platv == nil then
				my_platv = 4
			end
			local room = lvl.xml:add_element_in_last(xlevelmetadata, "edLevelClass")
			lvl.xml:set_attribute(room, "tileset", v.tileset)
			lvl.xml:set_attribute(room, "tilecol", v.tilecol)
			lvl.xml:set_attribute(room, "platx1", v.platx1)
			lvl.xml:set_attribute(room, "platy1", v.platy1)
			lvl.xml:set_attribute(room, "platx2", v.platx2)
			lvl.xml:set_attribute(room, "platy2", v.platy2)
			lvl.xml:set_attribute(room, "platv", my_platv)
			lvl.xml:set_attribute(room, "enemyx1", v.enemyx1)
			lvl.xml:set_attribute(room, "enemyy1", v.enemyy1)
			lvl.xml:set_attribute(room, "enemyx2", v.enemyx2)
			lvl.xml:set_attribute(room, "enemyy2", v.enemyy2)
			lvl.xml:set_attribute(room, "enemytype", v.enemytype)
			lvl.xml:set_attribute(room, "directmode", (v.auto2mode == 0 and anythingbutnil0(v.directmode) or 1))
			lvl.xml:set_attribute(room, "warpdir", v.warpdir)
			for ak,av in pairs(v) do
				if ak ~= "tileset" and ak ~= "tilecol"
				and ak ~= "platx1" and ak ~= "platy1" and ak ~= "platx2" and ak ~= "platy2" and ak ~= "platv"
				and ak ~= "enemyx1" and ak ~= "enemyy1" and ak ~= "enemyx2" and ak ~= "enemyy2"
				and ak ~= "enemytype" and ak ~= "directmode" and ak ~= "warpdir"
				and ak ~= "auto2mode" and ak ~= "roomname" then
					lvl.xml:set_attribute(room, ak, av)
				end
			end
			lvl.xml:set_text(room, v.roomname)

			i = i+1
		end
	end

	-- Now all the scripts!
	cons("Assembling scripts...")
	local allallscripts = {}
	for script_i = 1, #lvl.scriptnames do
		local k, v = lvl.scriptnames[script_i], lvl.scripts[lvl.scriptnames[script_i]]
		table.insert(allallscripts, k .. ":|" .. table.concat(v, "|") .. "|")
	end

	lvl.xml:set_text(lvl.xml:find_or_add(xdata, "script"), table.concat(allallscripts, ""))

	-- Now all the 2.4 stuff...
	cons("Assembling possible TextboxColours and SpecialRoomnames...")
	local replace_specialroomnames = ""

	local any_color_tag = false
	local xtextboxcolors = nil
	for k,v in pairs(lvl.textboxcolors_order) do
		local color = lvl.textboxcolors[v]
		if not any_color_tag then
			-- This is the first <colour> tag - so we need a <TextboxColours> to contain it and any more!
			xtextboxcolors = lvl.xml:find_or_add(xdata, "TextboxColours")
			lvl.xml:clear_open(xtextboxcolors)
			any_color_tag = true
		end
		local xcolor = lvl.xml:add_element_in_last(xtextboxcolors, "colour")
		lvl.xml:set_attribute(xcolor, "r", color[1])
		lvl.xml:set_attribute(xcolor, "g", color[2])
		lvl.xml:set_attribute(xcolor, "b", color[3])
		lvl.xml:set_attribute(xcolor, "name", v)
	end
	if not any_color_tag then
		lvl.xml:delete_each_child_element(xdata, "TextboxColours")
	end

	local any_roomname_tag = false
	local xspecialroomnames
	for _,room in pairs(lvl.specialroomnames_order) do
		for k,roomname in pairs(lvl.specialroomnames[room.y][room.x]) do
			if not any_roomname_tag then
				-- Like <colour> above - this is the first special roomname tag!
				xspecialroomnames = lvl.xml:find_or_add(xdata, "SpecialRoomnames")
				lvl.xml:clear_open(xspecialroomnames)
				any_roomname_tag = true
			end
			local xroomname = lvl.xml:add_element_in_last(xspecialroomnames, roomname.mode)
			lvl.xml:set_attribute(xroomname, "x", room.x)
			lvl.xml:set_attribute(xroomname, "y", room.y)
			if roomname.flag ~= -1 then
				lvl.xml:set_attribute(xroomname, "flag", roomname.flag)
			end
			if roomname.mode == "transform" then
				lvl.xml:set_attribute(xroomname, "loop", roomname.loop and "1" or "0")
			end
			if roomname.mode == "transform" or roomname.mode == "glitch" then
				for k2,item in pairs(roomname.name) do
					local item_tag = lvl.xml:add_element_in_last(xroomname, "text")
					if item:gsub(" ", "") == "" then
						-- Workaround TinyXML gotcha with a CDATA...
						lvl.xml:add_text_in_first(item_tag, item, true)
					else
						lvl.xml:set_text(item_tag, item)
					end
				end
			else
				if roomname.name:gsub(" ", "") == "" then
					-- Workaround TinyXML gotcha with a CDATA...
					lvl.xml:add_text_in_first(xroomname, roomname.name, true)
				else
					lvl.xml:set_text(xroomname, roomname.name)
				end
			end
		end
	end
	if not any_roomname_tag then
		lvl.xml:delete_each_child_element(xdata, "SpecialRoomnames")
	end

	-- Alright, let's save!
	cons("Saving file...")
	local success, iferrmsg
	if path ~= nil then
		local usethispath
		if invvvvvvfolder then
			usethispath = levelsfolder .. dirsep .. path
		else
			usethispath = path
		end
		success, iferrmsg = writelevelfile(usethispath, lvl.xml:export())
	else
		success = true
		iferrmsg = lvl.xml:export()
	end

	if success and path ~= nil then
		update_recents(s.recentfiles, path:sub(1, -8))

		if undobuffer ~= nil then
			saved_at_undo = #undobuffer
		end
		unsavedchanges = false
	end

	return success, iferrmsg
end


function despecialchars(text)
	return text:gsub("`", "`g"):gsub("\r?\n", "`n"):gsub("|", "`p"):gsub("%$", "`d"):gsub("@", "`a"):gsub("  ", "`_")
end

function undespecialchars(text)
	return text:gsub("`_", "  "):gsub("`a", "@"):gsub("`d", "$"):gsub("`p", "|"):gsub("`n", "\n"):gsub("`g", "`")
end


function createblanklevel(lvwidth, lvheight)
	-- There should be a list of tileset options and such
	-- - Same as in VVVVVV
	-- - Completely random
	-- - Random from tileset: X
	-- - All: X X

	local lvl = Level:new()

	-- First do the metadata.
	lvl.metadata = {
		Creator = "Unknown",
		Title = "Untitled Level",
		Created = "2",
		Modified = "",
		Modifiers = "2",
		Desc1 = "", Desc2 = "", Desc3 = "",
		website = "",
		onewaycol_override = false,
		font = s.new_level_font,
		rtl = s.new_level_rtl,
		mapwidth = lvwidth,
		mapheight = lvheight,
		levmusic = 0,
		target = "V"
	}

	-- Now, the contents!
	-- Ok we need to correctly set all rooms... Rooms have 1200 tiles
	for yk = 0, lvl.metadata.mapheight-1 do
		--print("Y: " .. yk)
		lvl.tiles[yk] = {}
		for xk = 0, lvl.metadata.mapwidth-1 do
			lvl.tiles[yk][xk] = {}
			for yt = 0, 29 do
				for xt = 0, 39 do
					lvl.tiles[yk][xk][(40*yt) + xt + 1] = 0
				end
			end
		end
	end

	-- Level meta data, get every room now.
	for ry = 0, 19 do
		lvl.roommetadata[ry] = {}
		for rx = 0, 19 do
			lvl.roommetadata[ry][rx] = default_roommetadata(rx, ry)
		end
	end

	-- Make a blank XML document - it'll be filled in properly when saving!
	lvl.xml = vedxml.VedXML:new{root="MapData"}

	cons("Done loading!")

	return lvl
end

function default_roommetadata(rx, ry)
	return {
		tileset = 0,
		tilecol = (rx + ry) % 32,
		platx1 = 0,
		platy1 = 0,
		platx2 = 320,
		platy2 = 240,
		platv = 4,
		enemyx1 = 0,
		enemyy1 = 0,
		enemyx2 = 320,
		enemyy2 = 240,
		enemytype = 0,
		directmode = 0,
		warpdir = 0,
		roomname = "",
		auto2mode = 0,
	}
end
