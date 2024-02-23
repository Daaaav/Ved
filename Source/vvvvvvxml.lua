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
	-- Returns (bool)success, (table)metadata, (table)limit, contents
	-- Map size and music is gonna move in with the metadata here.
	-- If loading isn't successful, metadata will be an error string.

	local success, contents = readlevelfile(levelsfolder .. dirsep .. path)

	if not success or contents == nil then
		return false, contents
	end

	local thismetadata = {}
	local thislimit

	thismetadata.target = "V"
	thislimit = limit_v

	-- First do the metadata.
	cons("Loading metadata...")
	local xmetadata = contents:match("<MetaData>(.*)</MetaData>")
	if xmetadata == nil then
		return false, L.MAL .. L.METADATACORRUPT
	end
	for _,v in pairs(metadataitems) do
		local m = xmetadata:match("<" .. v .. ">(.*)</" .. v .. ">")
		if m == nil then
			cons("mdcorr for "..v)
			return false, L.MAL .. langkeys(L.METADATAITEMCORRUPT, {v})
		end
		thismetadata[v] = unxmlspecialchars(m)
	end

	-- These ones are optional.
	thismetadata.onewaycol_override = false
	thismetadata.font = "font"
	thismetadata.rtl = false
	local m = xmetadata:match("<onewaycol_override>(.*)</onewaycol_override>")
	if m ~= nil then
		thismetadata.onewaycol_override = m ~= "0"
	end
	m = xmetadata:match("<font>(.*)</font>")
	if m ~= nil then
		thismetadata.font = m
	end
	m = xmetadata:match("<rtl>(.*)</rtl>")
	if m ~= nil then
		thismetadata.rtl = m ~= "0"
	end

	-- But we'll have room size and music also move in with the metadata.
	cons("Loading room size and music...")
	for _,v in pairs({"mapwidth", "mapheight", "levmusic"}) do
		local m = contents:match("<" .. v .. ">(.*)</" .. v .. ">")
		if m == nil then
			return false, L.MAL .. langkeys(L.METADATAITEMCORRUPT, {v})
		end
		thismetadata[v] = tonumber(m)
	end

	return true, thismetadata, thislimit, contents
end

function loadlevel(path)
	-- Returns (bool)success, (table)metadata, (table)limit, (table)roomdata, (table)entities, (table)levelmetadata, (table)scripts, (table)count, (table)scriptnames, (table)vedmetadata, (table)extra
	-- Map size and music is gonna move in with the metadata here.
	-- Roomdata is the tiles, and is a 3D table indexed [roomy][roomx][1-1200]
	-- Entities consists of tables (entity contents are table item data)
	-- Levelmetadata is a 3D table indexed [roomy][roomx][property] (roomname is table item roomname)
	-- Scripts are pre-exploded and scripts[scriptname] = (table)contents
	-- count will return the count of trinkets, crewmates and entities to keep everything within limits. It also contains the ID of the start point so it can be removed in case we place a new one.
	-- scriptnames is used to keep the names in order of opening scripts
	-- vedmetadata has flag names (.flaglabel)
	-- If loading isn't successful, metadata will be an error string.

	local success, thismetadata, thislimit, contents = loadlevelmetadata(path)

	if not success then
		return false, thismetadata
	end

	local function cons_fc(list, text)
		table.insert(list, text)
		cons("[CHECK] " .. text)
	end

	local x = {}
	local mycount = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil, FC = 0} -- FC = Failed Checks
	local FClist = {}

	local thisextra = {}

	-- This isn't a VCE level, right?
	local vce_m = contents:match("<MapData version=\"2\" vceversion=\"([0-9]+)\">")
	if vce_m ~= nil then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, L.VCE_REMOVED)
	end

	-- Now, the contents!
	cons("Loading all the contents...")
	--x.alltiles = explode(",", contents:match("<contents>(.*)</contents>"))

	-- Remove all literal '\0's, we'll remove '&#0;'s or '&#x0's later
	local numliteralnullbytes = 0
	if contents:match("%z") then
		contents, numliteralnullbytes = contents:gsub("%z", "")
	end

	-- Ok, explode() is far too inefficient, what else have we got?
	x.alltiles = {}
	local m = contents:match("<contents>(.*)</contents>")
	if m == nil then
		return false, L.MAL .. L.TILESCORRUPT
	end
	for num in m:gmatch("([^,]*),") do
		table.insert(x.alltiles, num)
	end

	cons("Contents split (setting all rooms now)")

	-- Ok we need to correctly set all rooms... Rooms have 1200 tiles
	local theserooms = {}
	local failedtiles = 0
	local t
	for yk = 0, math.min(thismetadata.mapheight, thislimit.mapheight)-1 do
		--print("Y: " .. yk)
		theserooms[yk] = {}
		for xk = 0, math.min(thismetadata.mapwidth, thislimit.mapwidth)-1 do
			theserooms[yk][xk] = {}
			for yt = 0, 29 do
				for xt = 0, 39 do
					t = tonumber(x.alltiles[(yk*1200*thismetadata.mapwidth) + (xk*40) + (yt*thismetadata.mapwidth*40) + xt + 1])
					if t == nil or t < 0 then
						t = 0
						failedtiles = failedtiles + 1
					elseif math.floor(t) ~= t then
						t = math.floor(t)
						failedtiles = failedtiles + 1
					end

					theserooms[yk][xk][(40*yt) + xt + 1] = t
				end
			end
		end
	end

	if failedtiles > 0 then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L_PLU.NOTALLTILESVALID, {failedtiles}))
	end

	-- Entities.
	local allentities = {}
	local myvedmetadata = false

	local numxmlnullbytes = 0

	cons("Loading entities...")
	if contents:find("<edEntities ?/>") == nil then
		-- We have entities!
		x.entities = contents:match("<edEntities>(.*)</edEntities>")
		if x.entities == nil then
			return false, L.MAL .. L.ENTITIESCORRUPT
		end

		-- Get all entities
		--.
		entityid = 0
		local morethanonestartpoint = false
		local duplicatestartpoints = {}
		for entity in x.entities:gmatch("<edentity (.-)</edentity>") do
			entityid = entityid + 1
			allentities[entityid] = {}

			-- We now got x="x" ... p6="x">Data... Attributes to the left of the >, data to the right of it.
			local metaparts = explode(">", entity)

			-- Explode more
			local attributes = parsexmlattributes(metaparts[1])

			for k,v in pairs(attributes) do
				allentities[entityid][k] = tonumber(v)
			end

			-- Now we only need the data...
			allentities[entityid].data = unxmlspecialchars(metaparts[2]:match("^[ \r\n]*(.-)[ \r\n]*$"))
			if allentities[entityid].data:match("%z") then
				local tmp
				allentities[entityid].data, tmp = allentities[entityid].data:gsub("%z", "")
				numxmlnullbytes = numxmlnullbytes + tmp
			end

			-- Now before we go to the next one, if it's a trinket or crewmate, add it up, because we can only have 20 in a level. Officially. Also, parse the special data entity here if we found it.
			if allentities[entityid].t == 9 then
				mycount.trinkets = mycount.trinkets + 1
			elseif allentities[entityid].t == 15 then
				mycount.crewmates = mycount.crewmates + 1
			elseif allentities[entityid].t == 16 then
				if mycount.startpoint == nil then
					mycount.startpoint = entityid
				else
					-- Multiple start points in a level is weird
					-- VVVVVV will pick the first one anyway, and we've already picked the first one, so no need to change it
					if not morethanonestartpoint then
						morethanonestartpoint = true
						mycount.FC = mycount.FC + 1
						cons_fc(FClist, L.MORETHANONESTARTPOINT)
					end
					table.insert(duplicatestartpoints, entityid)
				end
			elseif ((allentities[entityid].x == 800 and allentities[entityid].y == 600)
			or (allentities[entityid].x == 4000 and allentities[entityid].y == 3000))
			and allentities[entityid].t == 17 then
				-- This is the metadata entity!
				local explodedmetadata = explode("|", allentities[entityid].data:gsub("\n", ""))

				myvedmetadata = createmde(thislimit)

				myvedmetadata.mdeversion = anythingbutnil0(explodedmetadata[1])

				if myvedmetadata.mdeversion > thismdeversion then
					dialog.create(L.MDEVERSIONWARNING)
				end

				if myvedmetadata.mdeversion >= 2 and explodedmetadata[2] ~= nil then
					local explodedflags = explode("%$", explodedmetadata[2])
					local f = -1
					for k,v in pairs(explodedflags) do
						-- Make sure the numbers start with 0
						f = k-1
						myvedmetadata.flaglabel[f] = undespecialchars(v)
					end
					for i = f+1, thislimit.flags-1 do
						myvedmetadata.flaglabel[i] = ""
					end
				else
					for f = 0, thislimit.flags-1 do
						myvedmetadata.flaglabel[f] = ""
					end
				end

				if myvedmetadata.mdeversion >= 3 and explodedmetadata[4] ~= "" and explodedmetadata[4] ~= nil then
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
							myvedmetadata.vars[key] = {
								["type"] = "t",
								value = explodedvar
							}
						elseif (#explodedvar) >= 3 then
							myvedmetadata.vars[key] = {
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
						--myvedmetadata.notes[undespecialchars(explodednote[1])] = undespecialchars(explodednote[2])
						table.insert(myvedmetadata.notes,
							{
								subj = undespecialchars(explodednote[1]),
								imgs = {},
								cont = undespecialchars(explodednote[2])
							}
						)
					end
				end

				-- Nil this entity now so we don't store multiple ones when saving
				allentities[entityid] = nil
			end

			-- It's an entity, that's for sure!
			mycount.entities = mycount.entities + 1

			local oldFCcount = mycount.FC

			-- We might have just nil'd this entity because it was the data entity.
			if allentities[entityid] ~= nil then
				if allentities[entityid].x == nil or type(allentities[entityid].x) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].x = 0
				end
				if allentities[entityid].y == nil or type(allentities[entityid].y) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].y = 0
				end
				if allentities[entityid].t == nil or type(allentities[entityid].t) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].t = 0
				end
				if allentities[entityid].p1 == nil or type(allentities[entityid].p1) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p1 = 0
				end
				if allentities[entityid].p2 == nil or type(allentities[entityid].p2) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p2 = 0
				end
				if allentities[entityid].p3 == nil or type(allentities[entityid].p3) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p3 = 0
				end
				if allentities[entityid].p4 == nil or type(allentities[entityid].p4) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p4 = 0
				end
				if allentities[entityid].p5 == nil or type(allentities[entityid].p5) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p5 = 0
				end
				if allentities[entityid].p6 == nil or type(allentities[entityid].p6) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p6 = 0
				end
			end

			if oldFCcount < mycount.FC then
				cons_fc(FClist, langkeys(L_PLU.ENTITYINVALIDPROPERTIES, {anythingbutnil(allentities[entityid].x), anythingbutnil(allentities[entityid].y), (mycount.FC-oldFCcount)}, 3))
			end
		end

		for idx = #duplicatestartpoints, 1, -1 do
			-- This table.remove() gets inefficient really quickly if we have a lot of start points
			-- Please no one ever make a level with 1,000 start points
			table.remove(allentities, duplicatestartpoints[idx])
			entityid = entityid - 1
			mycount.entities = mycount.entities - 1
		end

		-- See this as MySQL's AUTO_INCREMENT
		mycount.entity_ai = entityid + 1
	end

	-- Level meta data
	cons("Loading room metadata...")
	x.levelmetadata = contents:match("<levelMetaData>(.*)</levelMetaData>")
	if x.levelmetadata == nil then
		return false, L.MAL .. L.LEVELMETADATACORRUPT
	end

	-- Get every room now.
	local theselevelmetadata = {}
	local all_platvs = {}
	local lmd_width = 20
	local rx, ry = lmd_width-1, -1
	local n_levelmetadata = 0
	local inboundsroom = 0
	local inbounds
	for room in x.levelmetadata:gmatch("<edLevelClass (.-)</edLevelClass>") do
		n_levelmetadata = n_levelmetadata + 1
		rx = rx + 1
		if rx >= lmd_width then
			rx = 0
			ry = ry + 1
			theselevelmetadata[ry] = {}
		end
		if rx < thismetadata.mapwidth and ry < thismetadata.mapheight then
			inbounds = true
			inboundsroom = inboundsroom + 1
		else
			inbounds = false
		end
		theselevelmetadata[ry][rx] = {}

		-- We now got tileset="x" ... warpdir="x">Roomname... Attributes to the left of the >, roomname to the right of it.
		local metaparts = explode(">", room)

		-- Explode more
		local attributes = parsexmlattributes(metaparts[1])

		for k,v in pairs(attributes) do
			if k == "platv" then
				-- Unfortunately platv is very special.
				table.insert(all_platvs, tonumber(v))
				if inbounds then
					theselevelmetadata[ry][rx].platv = all_platvs[inboundsroom]
				else
					theselevelmetadata[ry][rx].platv = 4
				end
			else
				theselevelmetadata[ry][rx][k] = tonumber(v)
			end
		end

		-- Now we only need the room name...
		theselevelmetadata[ry][rx].roomname = unxmlspecialchars(metaparts[2])
		if theselevelmetadata[ry][rx].roomname:match("%z") then
			local tmp
			theselevelmetadata[ry][rx].roomname, tmp = theselevelmetadata[ry][rx].roomname:gsub("%z", "")
			numxmlnullbytes = numxmlnullbytes + tmp
		end

		-- And make sure directmode isn't nil for 2.0 levels
		if theselevelmetadata[ry][rx].directmode == nil then
			theselevelmetadata[ry][rx].directmode = 0
		end

		local oldFCcount = mycount.FC

		if theselevelmetadata[ry][rx].tileset == nil
		or type(theselevelmetadata[ry][rx].tileset) ~= "number"
		or (theselevelmetadata[ry][rx].tileset > 4) then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].tileset = 0
		end
		if theselevelmetadata[ry][rx].tilecol == nil
		or type(theselevelmetadata[ry][rx].tilecol) ~= "number"
		or ((theselevelmetadata[ry][rx].tileset == 0 and theselevelmetadata[ry][rx].tilecol < -1)
		or (theselevelmetadata[ry][rx].tileset ~= 0 and theselevelmetadata[ry][rx].tilecol < 0))
		or theselevelmetadata[ry][rx].tileset == 0 and theselevelmetadata[ry][rx].tilecol > 31
		or theselevelmetadata[ry][rx].tileset == 1 and theselevelmetadata[ry][rx].tilecol > 7
		or theselevelmetadata[ry][rx].tileset == 2 and theselevelmetadata[ry][rx].tilecol > 6
		or theselevelmetadata[ry][rx].tileset == 3 and theselevelmetadata[ry][rx].tilecol > 6
		or theselevelmetadata[ry][rx].tileset == 4 and theselevelmetadata[ry][rx].tilecol > 5
		or theselevelmetadata[ry][rx].tileset == 5 and theselevelmetadata[ry][rx].tilecol > 29 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].tilecol = 0
		end
		if theselevelmetadata[ry][rx].platx1 == nil or type(theselevelmetadata[ry][rx].platx1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].platx1 = 0
		end
		if theselevelmetadata[ry][rx].platy1 == nil or type(theselevelmetadata[ry][rx].platy1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].platy1 = 0
		end
		if theselevelmetadata[ry][rx].platx2 == nil or type(theselevelmetadata[ry][rx].platx2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].platx2 = 0
		end
		if theselevelmetadata[ry][rx].platy2 == nil or type(theselevelmetadata[ry][rx].platy2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].platy2 = 0
		end
		if theselevelmetadata[ry][rx].platv == nil or type(theselevelmetadata[ry][rx].platv) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].platv = 0
		end
		if theselevelmetadata[ry][rx].enemyx1 == nil or type(theselevelmetadata[ry][rx].enemyx1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].enemyx1 = 0
		end
		if theselevelmetadata[ry][rx].enemyy1 == nil or type(theselevelmetadata[ry][rx].enemyy1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].enemyy1 = 0
		end
		if theselevelmetadata[ry][rx].enemyx2 == nil or type(theselevelmetadata[ry][rx].enemyx2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].enemyx2 = 0
		end
		if theselevelmetadata[ry][rx].enemyy2 == nil or type(theselevelmetadata[ry][rx].enemyy2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].enemyy2 = 0
		end
		if theselevelmetadata[ry][rx].enemytype == nil or type(theselevelmetadata[ry][rx].enemytype) ~= "number" or theselevelmetadata[ry][rx].enemytype < 0 or theselevelmetadata[ry][rx].enemytype > 9 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].enemytype = 0
		end
		if theselevelmetadata[ry][rx].warpdir == nil or type(theselevelmetadata[ry][rx].warpdir) ~= "number" or theselevelmetadata[ry][rx].warpdir < 0 or theselevelmetadata[ry][rx].warpdir > 3 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[ry][rx].warpdir = 0
		end

		theselevelmetadata[ry][rx].auto2mode = 0

		if oldFCcount < mycount.FC then
			local co = not s.coords0 and 1 or 0
			cons_fc(FClist, langkeys(L_PLU.ROOMINVALIDPROPERTIES , {rx+co, ry+co, (mycount.FC-oldFCcount)}, 3))
		end

		-- If you select a higher tilecol in space station and then go to another tileset, VVVVVV will still save the out-of-range tilecol.
		if tilesetblocks[theselevelmetadata[ry][rx].tileset].colors[theselevelmetadata[ry][rx].tilecol] == nil then
			theselevelmetadata[ry][rx].tilecol = 0
		end
	end

	-- Scripts
	cons("Loading scripts...")
	x.allscripts = {}
	local m = contents:match("<script>(.*)</script>")
	if m == nil then
		return false, L.MAL .. L.SCRIPTCORRUPT
	end
	if m:sub(-1,-1) ~= "|" then
		m = m .. "|"
	end
	for ln in unxmlspecialchars(m):gmatch("([^|]*)|") do
		--print(num)
		if ln:match("%z") then
			local tmp
			ln, tmp = ln:gsub("%z", "")
			numxmlnullbytes = numxmlnullbytes + tmp
		end
		table.insert(x.allscripts, ln)
	end
	cons("There are " .. (#x.allscripts) .. " lines of scripting! Loading all of that...")

	local allscripts = {}
	local myscriptnames = {}

	if #x.allscripts > 1 then
		-- We don't want a crash now do we?
		currentscript = ""; sline = 1

		for k,v in pairs(x.allscripts) do
			if v:sub(-1, -1) == ":" then
				-- This is a script name!
				currentscript = v:sub(1, -2)
				if allscripts[currentscript] == nil then
					table.insert(myscriptnames, currentscript)
				else
					-- We've seen this script before, that's not good
					mycount.FC = mycount.FC + 1
					cons_fc(FClist, langkeys(L.DUPLICATESCRIPT, {currentscript}))
				end
				allscripts[currentscript] = {}
				sline = 1
			else
				-- This is just a line. But have we encountered a script name before?
				if allscripts[currentscript] ~= nil then
					allscripts[currentscript][sline] = v
					sline = sline + 1
				else
					mycount.FC = mycount.FC + 1
					cons_fc(FClist, langkeys(L.UNEXPECTEDSCRIPTLINE, {anythingbutnil(v)}))
				end
			end
		end
	end

	-- Some things that for now we'll have to hardcode carrying over...
	-- If not found, they'll be nil, and we won't insert them later.
	cons("Loading possible TextboxColours and SpecialRoomnames...")

	x.textboxcolors = contents:match("<TextboxColours>(.*)</TextboxColours>")
	thisextra.textboxcolors = {}

	-- <colour> has already appeared in both self-closing form and not, so...
	-- Temporary Lua pattern moment
	for color in x.textboxcolors:gmatch("<colour (.-)>?<?/c?o?l?o?u?r?>") do
		local attr = parsexmlattributes(color)
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

			thisextra.textboxcolors[attr.name] = {r, g, b}
		end
	end

	thisextra.specialroomnames_xml = contents:match("<SpecialRoomnames>(.*)</SpecialRoomnames>")

	cons("Done loading!")

	-- As many of the integrity checks as possible here
	if (type(thismetadata.mapwidth) ~= "number") or (thismetadata.mapwidth < 1) then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L.MAPWIDTHINVALID, {anythingbutnil(thismetadata.mapwidth)}))
		thismetadata.mapwidth = 1
	end
	if (type(thismetadata.mapheight) ~= "number") or (thismetadata.mapheight < 1) then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L.MAPHEIGHTINVALID, {anythingbutnil(thismetadata.mapheight)}))
		thismetadata.mapheight = 1
	end
	if ((thismetadata.mapwidth > thislimit.mapwidth) or (thismetadata.mapheight > thislimit.mapheight)) and not s.allowbiggerthansizelimit then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L.MAPBIGGERTHANSIZELIMIT, {anythingbutnil(thismetadata.mapwidth), anythingbutnil(thismetadata.mapheight), thislimit.mapwidth, thislimit.mapheight}))
		thismetadata.mapwidth = math.min(thismetadata.mapwidth, thislimit.mapwidth)
		thismetadata.mapheight = math.min(thismetadata.mapheight, thislimit.mapheight)
	end
	if (thismetadata.levmusic == nil) or (thismetadata.levmusic == "") then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, L.LEVMUSICEMPTY)
		thismetadata.levmusic = 0
	end
	if n_levelmetadata ~= 400 then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, L.NOT400ROOMS)

		--[[ TODO: Think about readding this later, after converting it to the 3D table
		if #theselevelmetadata < 400 then
			for croom = #theselevelmetadata+1, 400 do
				theselevelmetadata[croom] = {
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
	if numliteralnullbytes > 0 then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L_PLU.LITERALNULLS, {numliteralnullbytes}))
	end
	if numxmlnullbytes > 0 then
		mycount.FC = mycount.FC + 1
		cons_fc(FClist, langkeys(L_PLU.XMLNULLS, {numxmlnullbytes}))
	end

	if mycount.FC ~= 0 then
		local FClisttext = ""


		for k,v in pairs(FClist) do
			if k > 5 then
				FClisttext = FClisttext .. "... " .. langkeys(L.MOREERRORS, {(#FClist-5)})
				break
			end

			FClisttext = FClisttext .. arrow_right .. " " .. v .. "\n"
		end

		dialog.create(langkeys(L_PLU.LEVELFAILEDCHECKS, {mycount.FC}) .. "\n\n" .. FClisttext)
	end

	-- No longer x.alltiles
	return true, thismetadata, thislimit, theserooms, allentities, theselevelmetadata, allscripts, mycount, myscriptnames, myvedmetadata, thisextra
end


-- Load a template that we'll need for saving...
level_template = love.filesystem.read("template.vvvvvv") -- updated 1.11.0

function savelevel(path, thismetadata, theserooms, allentities, theselevelmetadata, allscripts, vedmetadata, thisextra, crashed, invvvvvvfolder)
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

	local savethis = level_template

	cons("Placing metadata...")
	for k,v in pairs(metadataitems) do
		cons("Doing " .. v)
		newthis = xmlspecialchars(anythingbutnil(thismetadata[v]))
		savethis = savethis:gsub("%$" .. v:upper() .. "%$", newthis)
	end

	-- Special cases of metadata that may or may not be stored...
	local optional_metadata = ""
	if thismetadata.onewaycol_override then
		optional_metadata = optional_metadata .. "            <onewaycol_override>1</onewaycol_override>\n"
	end
	if thismetadata.font ~= "" and thismetadata.font ~= "font" then
		optional_metadata = optional_metadata .. "            <font>" .. xmlspecialchars(thismetadata.font) .. "</font>\n"
	end
	if thismetadata.rtl then
		optional_metadata = optional_metadata .. "            <rtl>1</rtl>\n"
	end
	savethis = savethis:gsub("%$OPTIONAL_METADATA%$", (optional_metadata:gsub("%%", "%%%%")))

	-- Hold on for a second, we need the map size and music too!
	savethis = savethis
		:gsub("%$MAPWIDTH%$", thismetadata.mapwidth)
		:gsub("%$MAPHEIGHT%$", thismetadata.mapheight)
		:gsub("%$LEVMUSIC%$", thismetadata.levmusic)

	-- The contents are gonna be the hardest!
	cons("Assembling contents......")
	thenewcontents = {}
	local nested_break = false
	for lroomy = 0, math.min(thismetadata.mapheight, limit.mapheight)-1 do
		yv = theserooms[lroomy]
		-- We now have each y.....
		cons("Y: " .. lroomy)
		for line = 0, 29 do
			-- (each line)
			--for roomx, xv in pairs(yv) do
			for lroomx = 0, (thismetadata.mapwidth-1) do
				xv = yv[lroomx]
				-- .....And each x for each line
				table.insert(thenewcontents, table.concat({unpack(theserooms[lroomy][lroomx], (line*40)+1, (line*40)+40)}, ","))
				if lroomy == math.min(thismetadata.mapheight, limit.mapheight)-1 and lroomx == limit.mapwidth-1 and line == 29 then
					nested_break = true
					break
				end
			end
			if nested_break then
				break
			end
		end
		if nested_break then
			break
		end
	end
	savethis = savethis:gsub("%$CONTENTS%$", table.concat(thenewcontents, ",") .. ",")

	-- Slightly cleaning up
	thenewcontents = nil

	-- Now do all entities, if we have any!
	cons("Saving entities...")
	if (count.entities > 0) or (vedmetadata ~= false and vedmetadata ~= nil) then
		-- We do!
		local entitydatasaved = 0
		local thenewentities = {"        <edEntities>\n"}
		-- No pairs(allentities) here, that might end iterating at a nil
		for k = 1, count.entity_ai-1 do
			if allentities[k] ~= nil then
				local v = allentities[k]
				local data = v.data
				if v.t ~= 17 and v.t ~= 18 and v.t ~= 19 and data:len() > 40 then
					-- VVVVVV has saved a lot of data to this entity, which shouldn't even have data - let's save some space.
					entitydatasaved = entitydatasaved + data:len()
					data = ""
				end
				table.insert(thenewentities,
					"            <edentity x=\"" .. v.x
					.. "\" y=\"" .. v.y
					.. "\" t=\"" .. v.t
					.. "\" p1=\"" .. v.p1
					.. "\" p2=\"" .. v.p2
					.. "\" p3=\"" .. v.p3
					.. "\" p4=\"" .. v.p4
					.. "\" p5=\"" .. v.p5
					.. "\" p6=\"" .. v.p6 .. "\">"
					.. xmlspecialchars(data)
					.. "</edentity>\n"
				)
			end
		end

		if vedmetadata ~= false and vedmetadata ~= nil then
			-- We have a metadata entity to save! As for flag names concatenation, table.concat expects all tables to start at index 1.
			local mdedata = thismdeversion .. "|"

			local max_labeled_flag = -1
			for f = limit.flags-1, 0, -1 do
				if vedmetadata.flaglabel[f] ~= "" then
					max_labeled_flag = f
					break
				end
			end
			if max_labeled_flag ~= -1 then
				mdedata = mdedata .. despecialchars(vedmetadata.flaglabel[0])

				for k = 1, max_labeled_flag do -- 0 added above
					mdedata = mdedata .. "$" .. despecialchars(vedmetadata.flaglabel[k])
				end
			end

			mdedata = mdedata .. "||"

			-- Vars
			local varsdata = {}

			for k,v in pairs(vedmetadata.vars) do
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

			for k,v in pairs(vedmetadata.notes) do
				table.insert(notesdata, despecialchars(v.subj) .. "@" .. despecialchars(v.cont))
			end

			mdedata = mdedata .. table.concat(notesdata, "$")

			table.insert(thenewentities,
				"            <edentity"
				.. " x=\"4000\" y=\"3000\""
				.. " t=\"17\""
				.. " p1=\"0\" p2=\"0\" p3=\"0\" p4=\"0\" p5=\"320\" p6=\"240\">"
				.. xmlspecialchars(mdedata)
				.. "</edentity>\n"
			)
		end

		savethis = savethis:gsub("%$EDENTITIES%$", table.concat(thenewentities, ""):gsub("%%", "%%%%") .. "        </edEntities>")

		if entitydatasaved > 0 then
			cons("Done with entities, " .. entitydatasaved .. " bytes were saved from unnecessary entity data.")
		else
			cons("Done with entities.")
		end
	else
		-- We don't!
		savethis = savethis:gsub("%$EDENTITIES%$", "        <edEntities/>")
	end

	cons("Saving room metadata...")
	-- Now all room metadata, aka levelclass
	local all_platvs = {}
	for y = 0, thismetadata.mapheight-1 do
		if y >= limit.mapheight then
			break
		end
		for x = 0, thismetadata.mapwidth-1 do
			if x >= limit.mapwidth then
				break
			end
			-- platv needs special handling, unfortunately.
			table.insert(all_platvs, theselevelmetadata[y][x].platv)
		end
	end
	local alllevelmetadata = {}
	local i = 1
	local lmd_w, lmd_h = 20, 20
	for y = 0, lmd_h-1 do
		for x = 0, lmd_w-1 do
			local v = theselevelmetadata[y][x]
			local my_platv
			my_platv = all_platvs[i]
			if my_platv == nil then
				my_platv = 4
			end
			table.insert(alllevelmetadata,
				"            <edLevelClass tileset=\"" .. v.tileset
				.. "\" tilecol=\"" .. v.tilecol
				.. "\" platx1=\"" .. v.platx1
				.. "\" platy1=\"" .. v.platy1
				.. "\" platx2=\"" .. v.platx2
				.. "\" platy2=\"" .. v.platy2
				.. "\" platv=\"" .. my_platv
				.. "\" enemyx1=\"" .. v.enemyx1
				.. "\" enemyy1=\"" .. v.enemyy1
				.. "\" enemyx2=\"" .. v.enemyx2
				.. "\" enemyy2=\"" .. v.enemyy2
				.. "\" enemytype=\"" .. v.enemytype
				.. "\" directmode=\"" .. (v.auto2mode == 0 and anythingbutnil0(v.directmode) or 1)
				.. "\" warpdir=\"" .. v.warpdir
				.. "\">" .. xmlspecialchars(v.roomname) .. "</edLevelClass>\n"
			)

			i = i+1
		end
	end

	savethis = savethis:gsub("%$EDLEVELCLASSES%$", (table.concat(alllevelmetadata, ""):gsub("%%", "%%%%")))

	-- Now all the scripts!
	cons("Assembling scripts...")
	local allallscripts = {}
	--for k,v in pairs(allscripts) do
	for script_i = 1, #scriptnames do
		local k, v = scriptnames[script_i], allscripts[scriptnames[script_i]]
		table.insert(allallscripts, xmlspecialchars(k) .. ":|" .. xmlspecialchars(table.concat(v, "|")) .. "|")
	end

	savethis = savethis:gsub("%$SCRIPT%$", (table.concat(allallscripts, ""):gsub("%%", "%%%%")))

	-- Now all the 2.4 stuff...
	cons("Assembling possible TextboxColours and SpecialRoomnames...")
	local replace_textboxcolors = ""
	local replace_specialroomnames = ""

	local any_color_tag = false
	local all_color_tags = {}
	for k,v in pairs(thisextra.textboxcolors) do
		table.insert(all_color_tags,
			"\n            <colour r=\"" .. v[1] .. "\" g=\"" .. v[2] .. "\" b=\"" .. v[3] .. "\" name=\"" .. k .. "\"/>"
		)
		any_color_tag = true
	end
	if any_color_tag then
		replace_textboxcolors = "        <TextboxColours>"
			.. table.concat(all_color_tags, "")
			.. "\n        </TextboxColours>\n"
	end

	if thisextra.specialroomnames_xml ~= nil then
		replace_specialroomnames = "        <SpecialRoomnames>" .. thisextra.specialroomnames_xml .. "</SpecialRoomnames>\n"
	end
	savethis = savethis:gsub("%$TEXTBOXCOLOURS%$", (replace_textboxcolors:gsub("%%", "%%%%")))
	savethis = savethis:gsub("%$SPECIALROOMNAMES%$", (replace_specialroomnames:gsub("%%", "%%%%")))

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
		success, iferrmsg = writelevelfile(usethispath, savethis)
	else
		success = true
		iferrmsg = savethis
	end

	if vedmetadata == nil then
		cons("Caution: metadata entity not passed to savelevel()!")
	end

	if success and path ~= nil then
		recentlyopened(path:sub(1, -8))

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
	-- Returns same variables as loadlevel

	-- There should be a list of tileset options and such
	-- - Same as in VVVVVV
	-- - Completely random
	-- - Random from tileset: X
	-- - All: X X

	local mycount = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil}

	-- First do the metadata.
	cons("Loading metadata...")

	thismetadata = {
		Creator = "Unknown",
		Title = "Untitled Level",
		Created = "2",
		Modified = "",
		Modifiers = "2",
		Desc1 = "", Desc2 = "", Desc3 = "",
		website = "",
		onewaycol_override = false,
		font = "font",
		rtl = false,
		mapwidth = lvwidth,
		mapheight = lvheight,
		levmusic = 0,
		target = "V"
	}

	-- Now, the contents!
	cons("Loading all the contents...")

	-- Ok we need to correctly set all rooms... Rooms have 1200 tiles
	theserooms = {}
	for yk = 0, thismetadata.mapheight-1 do
		--print("Y: " .. yk)
		theserooms[yk] = {}
		for xk = 0, thismetadata.mapwidth-1 do
			theserooms[yk][xk] = {}
			for yt = 0, 29 do
				for xt = 0, 39 do
					theserooms[yk][xk][(40*yt) + xt + 1] = 0
				end
			end
		end
	end

	-- Entities.
	cons("Loading entities...")
	allentities = {}

	-- Level meta data, get every room now.
	cons("Loading room metadata...")
	theselevelmetadata = {}
	for ry = 0, 19 do
		theselevelmetadata[ry] = {}
		for rx = 0, 19 do
			theselevelmetadata[ry][rx] = default_levelmetadata(rx, ry)
		end
	end

	-- Scripts
	cons("Loading scripts...")

	allscripts = {}
	myscriptnames = {}

	local myvedmetadata = false

	-- Extra. Since we start with a VVVVVV level, this is empty.
	thisextra = {}
	-- Except... now that we have 2.4, just for completeness...
	thisextra.textboxcolors = {}
	thisextra.specialroomnames_xml = nil

	cons("Done loading!")

	-- No longer x.alltiles
	return true, thismetadata, limit_v, theserooms, allentities, theselevelmetadata, allscripts, mycount, myscriptnames, myvedmetadata, thisextra
end

function default_levelmetadata(rx, ry)
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
