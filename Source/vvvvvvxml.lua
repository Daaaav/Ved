-- First some things that could as well have gone in const.lua but are here for easy reference.
metadataitems =
	{
	"Creator", -- name
	"Title",
	"Created", -- 2?
	"Modified", -- empty?
	"Modifiers", -- 2?
	"Desc1", "Desc2", "Desc3",
	"website"
	}

function loadlevelmetadata(path)
	-- Returns (bool)success, (array)metadata, contents
	-- Map size and music is gonna move in with the metadata here.
	-- If loading isn't successful, metadata will be an error string.

	local success, contents = readlevelfile(levelsfolder .. dirsep .. path)

	if not success or contents == nil then
		return false, contents
	end

	-- First do the metadata.
	cons("Loading metadata...")
	local xmetadata = contents:match("<MetaData>(.*)</MetaData>")
	if xmetadata == nil then
		return false, L.MAL .. L.METADATACORRUPT
	end
	local thismetadata = {}
	for _,v in pairs(metadataitems) do
		local m = xmetadata:match("<" .. v .. ">(.*)</" .. v .. ">")
		if m == nil then
			cons("mdcorr for "..v)
			return false, L.MAL .. langkeys(L.METADATAITEMCORRUPT, {v})
		end
		thismetadata[v] = unxmlspecialchars(m)
	end

	-- But we'll have room size and music also move in with the metadata. Maybe change the regex so it'll match numbers only (not for music though because starting with an internal song number is possible), for now that's not necessary.
	cons("Loading room size and music...")
	for _,v in pairs({"mapwidth", "mapheight", "levmusic"}) do
		local m = contents:match("<" .. v .. ">(.*)</" .. v .. ">")
		if m == nil then
			return false, L.MAL .. langkeys(L.METADATAITEMCORRUPT, {v})
		end
		thismetadata[v] = tonumber(m)
	end

	return true, thismetadata, contents
end

function loadlevel(path)
	-- Returns (bool)success, (array)metadata, (array)contents, (array)entities, (array)levelmetadata, (array)scripts, (array)count, (array)scriptnames, (array)vedmetadata
	-- Map size and music is gonna move in with the metadata here.
	-- Contents is basically the raw array exploded
	-- Entities bestaat uit arrays (entity contents are array item data)
	-- Of course levelmetadata is all 400 rooms and also consists of arrays (roomname is array item roomname)
	-- Scripts are pre-exploded and scripts[scriptname] = (array)contents
	-- count will return the count of trinkets, crewmates and entities to keep everything within limits. It also contains the ID of the start point so it can be removed in case we place a new one.
	-- scriptnames is used to keep the names in order of opening scripts
	-- vedmetadata has flag names (.flaglabel)
	-- If loading isn't successful, metadata will be an error string.

	local success, thismetadata, contents = loadlevelmetadata(path)

	if not success then
		return false, thismetadata
	end

	local x = {}
	local mycount = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil, FC = 0} -- FC = Failed Checks
	FClist = {}

	-- Now, the contents!
	cons("Loading all the contents...")
	--x.alltiles = explode(",", contents:match("<contents>(.*)</contents>"))

	-- Ok, explode() is far too inefficient, what else have we got?
	x.alltiles = {}
	local m = contents:match("<contents>(.*)</contents>")
	if m == nil then
		return false, L.MAL .. L.TILESCORRUPT
	end
	for num in m:gmatch("(%d+),") do
		--print(num)
		table.insert(x.alltiles, num)
	end

	cons("Contents split (setting all rooms now)")

	-- Ok we need to correctly set all rooms... Rooms have 1200 tiles
	local theserooms = {}
	for yk = 0, thismetadata.mapheight-1 do
		--print("Y: " .. yk)
		theserooms[yk] = {}
		for xk = 0, thismetadata.mapwidth-1 do
			theserooms[yk][xk] = {}
			for yt = 0, 29 do
				for xt = 0, 39 do
					theserooms[yk][xk][(40*yt) + xt + 1] = tonumber(anythingbutnil0(x.alltiles[(yk*1200*thismetadata.mapwidth) + (xk*40) + (yt*thismetadata.mapwidth*40) + xt + 1]))
					--cons("Tile loaded: " .. (yk*1200*thismetadata.mapwidth) + (xk*40) + (yt*thismetadata.mapwidth*40) + xt + 1 .. " (" .. xk .. " " .. yk .. " " .. xt .. " " .. yt .. "), " .. yk .. "*1200*" .. thismetadata.mapwidth .. " + " .. xk .. "*40 + " .. yt .. "*" .. thismetadata.mapwidth .. "*40 + " .. xt .. " + 1")
				end
			end
		end
	end

	-- Entities.
	local allentities = {}
	local myvedmetadata = false

	cons("Loading entities...")
	if contents:find("<edEntities />") == nil and contents:find("<edEntities/>") == nil then
		-- We have entities!
		x.entities = contents:match("<edEntities>(.*)</edEntities>")
		if x.entities == nil then
			return false, L.MAL .. L.ENTITIESCORRUPT
		end

		-- Get all entities
		--.
		entityid = 0
		for entity in x.entities:gmatch("<edentity (.-)\r?\n            </edentity>") do
			entityid = entityid + 1
			allentities[entityid] = {}

			-- We now got x="x" ... p6="x">Data... Attributes to the left of the >, data to the right of it.
			metaparts = explode(">", entity)

			-- Explode more
			attributes = explode(" ", metaparts[1])

			for k,v in pairs(attributes) do
				-- Explode yet even more
				keyvalue = explode("=", v)

				-- Leave out the quotes and convert it to number
				local settothis = tonumber(keyvalue[2]:sub(2, -2))
				allentities[entityid][keyvalue[1]] = settothis

				-- Is this a valid number?
				--[[
				if settothis == nil or type(settothis) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid][keyvalue[1] ] = 0
				end
				]]
			end

			-- Now we only need the data...
			allentities[entityid].data = unxmlspecialchars(metaparts[2])

			-- Now before we go to the next one, if it's a trinket or crewmate, add it up, because we can only have 20 in a level. Officially. Also, parse the special data entity here if we found it.
			if allentities[entityid].t == 9 then
				mycount.trinkets = mycount.trinkets + 1
			elseif allentities[entityid].t == 15 then
				mycount.crewmates = mycount.crewmates + 1
			elseif allentities[entityid].t == 16 then
				mycount.startpoint = entityid
			elseif allentities[entityid].x == 800 and allentities[entityid].y == 600 and allentities[entityid].t == 17 then
				-- This is the metadata entity!
				local explodedmetadata = explode("|", allentities[entityid].data)

				myvedmetadata = createmde()

				myvedmetadata.mdeversion = anythingbutnil0(tonumber(explodedmetadata[1]))

				if myvedmetadata.mdeversion > thismdeversion then
					dialog.create(L.MDEVERSIONWARNING)
				end

				if myvedmetadata.mdeversion >= 2 and explodedmetadata[2] ~= nil then
					local explodedflags = explode("%$", explodedmetadata[2])
					for k,v in pairs(explodedflags) do
						-- Make sure the numbers start with 0
						myvedmetadata.flaglabel[k-1] = undespecialchars(v)
					end
				else
					for f = 0, 99 do
						myvedmetadata.flaglabel[f] = ""
					end
				end

				--[[
				local explodedscripts = explode("%$", explodedmetadata[3])
				for k,v in pairs(explodedscripts) do
					table.insert(myvedmetadata.internalscripts, undespecialchars(v))
				end

				myvedmetadata.leveloptions = explodedmetadata[4]
				]]

				if myvedmetadata.mdeversion >= 3 and explodedmetadata[4] ~= "" and explodedmetadata[4] ~= nil then
					local explodedvars = explode("%$", explodedmetadata[4])
					for k,v in pairs(explodedvars) do
						local explodedvar = explode("@", v)
						if (#explodedvar) >= 3 then
							myvedmetadata.vars[undespecialchars(explodedvar[1])] = {
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

			-- Do some integrity checks on this entity.
			--[[
			mycount.FC = mycount.FC + (allentities[entityid].x == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].y == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].t == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p1 == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p2 == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p3 == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p4 == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p5 == nil and 1 or 0)
			mycount.FC = mycount.FC + (allentities[entityid].p6 == nil and 1 or 0)
			]]

			local oldFCcount = mycount.FC

			-- We might have just nil'd this entity because it was the data entity.
			if allentities[entityid] ~= nil then
				if allentities[entityid].x == nil or type(allentities[entityid].x) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].x = 0
				end if allentities[entityid].y == nil or type(allentities[entityid].y) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].y = 0
				end if allentities[entityid].t == nil or type(allentities[entityid].t) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].t = 0
				end if allentities[entityid].p1 == nil or type(allentities[entityid].p1) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p1 = 0
				end if allentities[entityid].p2 == nil or type(allentities[entityid].p2) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p2 = 0
				end if allentities[entityid].p3 == nil or type(allentities[entityid].p3) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p3 = 0
				end if allentities[entityid].p4 == nil or type(allentities[entityid].p4) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p4 = 0
				end if allentities[entityid].p5 == nil or type(allentities[entityid].p5) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p5 = 0
				end if allentities[entityid].p6 == nil or type(allentities[entityid].p6) ~= "number" then
					mycount.FC = mycount.FC + 1
					allentities[entityid].p6 = 0
				end
			end

			if oldFCcount < mycount.FC then
				cons_fc(langkeys(L_PLU.ENTITYINVALIDPROPERTIES, {anythingbutnil(allentities[entityid].x), anythingbutnil(allentities[entityid].y), (mycount.FC-oldFCcount)}, 3))
			end
		end
		-- See this as MySQL's AUTO_INCREMENT
		mycount.entity_ai = entityid + 1
	else
		--.
	end

	-- Level meta data
	cons("Loading room metadata...")
	x.levelmetadata = contents:match("<levelMetaData>(.*)</levelMetaData>")
	if x.levelmetadata == nil then
		return false, L.MAL .. L.LEVELMETADATACORRUPT
	end

	-- Get every room now.
	local theselevelmetadata = {}
	croom = 0
	for room in x.levelmetadata:gmatch("<edLevelClass (.-)</edLevelClass>") do
		croom = croom + 1
		theselevelmetadata[croom] = {}

		-- We now got tileset="x" ... warpdir="x">Roomname... Attributes to the left of the >, roomname to the right of it.
		metaparts = explode(">", room)

		-- Explode more
		attributes = explode(" ", metaparts[1])

		for k,v in pairs(attributes) do
			-- Explode yet even more
			keyvalue = explode("=", v)

			-- Leave out the quotes and convert it to number
			theselevelmetadata[croom][keyvalue[1]] = tonumber(keyvalue[2]:sub(2, -2))

			--cons("Room: " .. croom .. " Key: " .. keyvalue[1] .. " Value: " .. tonumber(keyvalue[2]:sub(2, -2)))
		end

		-- Now we only need the room name...
		theselevelmetadata[croom].roomname = unxmlspecialchars(metaparts[2])

		-- And make sure directmode isn't nil for 2.0 levels
		if theselevelmetadata[croom].directmode == nil then
			theselevelmetadata[croom].directmode = 0
		end

		-- Do some integrity checks on this room metadata.
		--[[
		mycount.FC = mycount.FC + (theselevelmetadata[croom].tileset == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].tilecol == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].platx1 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].platy1 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].platx2 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].platy2 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].platv == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].enemyx1 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].enemyy1 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].enemyx2 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].enemyy2 == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].enemytype == nil and 1 or 0)
		mycount.FC = mycount.FC + (theselevelmetadata[croom].warpdir == nil and 1 or 0)
		]]

		local oldFCcount = mycount.FC

		if theselevelmetadata[croom].tileset == nil or type(theselevelmetadata[croom].tileset) ~= "number" or (theselevelmetadata[croom].tileset > 4) then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].tileset = 0
		end if theselevelmetadata[croom].tilecol == nil or type(theselevelmetadata[croom].tilecol) ~= "number" or theselevelmetadata[croom].tilecol < 0
		or theselevelmetadata[croom].tileset == 0 and theselevelmetadata[croom].tilecol > 31
		or theselevelmetadata[croom].tileset == 1 and theselevelmetadata[croom].tilecol > 7
		or theselevelmetadata[croom].tileset == 2 and theselevelmetadata[croom].tilecol > 6
		or theselevelmetadata[croom].tileset == 3 and theselevelmetadata[croom].tilecol > 6
		or theselevelmetadata[croom].tileset == 4 and theselevelmetadata[croom].tilecol > 5 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].tilecol = 0
		end if theselevelmetadata[croom].platx1 == nil or type(theselevelmetadata[croom].platx1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].platx1 = 0
		end if theselevelmetadata[croom].platy1 == nil or type(theselevelmetadata[croom].platy1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].platy1 = 0
		end if theselevelmetadata[croom].platx2 == nil or type(theselevelmetadata[croom].platx2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].platx2 = 0
		end if theselevelmetadata[croom].platy2 == nil or type(theselevelmetadata[croom].platy2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].platy2 = 0
		end if theselevelmetadata[croom].platv == nil or type(theselevelmetadata[croom].platv) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].platv = 0
		end if theselevelmetadata[croom].enemyx1 == nil or type(theselevelmetadata[croom].enemyx1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].enemyx1 = 0
		end if theselevelmetadata[croom].enemyy1 == nil or type(theselevelmetadata[croom].enemyy1) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].enemyy1 = 0
		end if theselevelmetadata[croom].enemyx2 == nil or type(theselevelmetadata[croom].enemyx2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].enemyx2 = 0
		end if theselevelmetadata[croom].enemyy2 == nil or type(theselevelmetadata[croom].enemyy2) ~= "number" then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].enemyy2 = 0
		end if theselevelmetadata[croom].enemytype == nil or type(theselevelmetadata[croom].enemytype) ~= "number" or theselevelmetadata[croom].enemytype < 0 or theselevelmetadata[croom].enemytype > 9 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].enemytype = 0
		end if theselevelmetadata[croom].warpdir == nil or type(theselevelmetadata[croom].warpdir) ~= "number" or theselevelmetadata[croom].warpdir < 0 or theselevelmetadata[croom].warpdir > 3 then
			mycount.FC = mycount.FC + 1
			theselevelmetadata[croom].warpdir = 0
		end

		theselevelmetadata[croom].auto2mode = 0

		if oldFCcount < mycount.FC then
			cons_fc(langkeys(L_PLU.ROOMINVALIDPROPERTIES , {croom, (mycount.FC-oldFCcount)}, 2))
		end

		-- If you select a higher tilecol in space station and then go to another tileset, VVVVVV will still save the out-of-range tilecol.
		if tilesetblocks[theselevelmetadata[croom].tileset].colors[theselevelmetadata[croom].tilecol] == nil then
			theselevelmetadata[croom].tilecol = 0
		end
	end

	-- Scripts
	cons("Loading scripts...")
	--x.allscripts = explode("|", unxmlspecialchars(contents:match("<script>(.*)</script>")))
	x.allscripts = {}
	local m = contents:match("<script>(.*)</script>")
	if m == nil then
		return false, L.MAL .. L.SCRIPTCORRUPT
	end
	for ln in unxmlspecialchars(m .. "|"):gmatch("([^|]*)|") do
		--print(num)
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
				table.insert(myscriptnames, currentscript)
				allscripts[currentscript] = {}
				sline = 1
			else
				-- This is just a line. But have we encountered a script name before?
				if allscripts[currentscript] ~= nil then
					allscripts[currentscript][sline] = v
					sline = sline + 1
				else
					mycount.FC = mycount.FC + 1
					cons_fc(langkeys(L.UNEXPECTEDSCRIPTLINE, {anythingbutnil(v)}))
				end
			end
		end
	end

	--[[
	local myvedmetadata =
		{
		flaglabel = {} --{[2] = "testvlag"}
		}
	]]

	cons("Done loading!")


	-- As many of the integrity checks as possible here
	--[[
	mycount.FC = mycount.FC + (type(thismetadata.mapwidth) ~= "number" and 1 or 0)
	mycount.FC = mycount.FC + (type(thismetadata.mapheight) ~= "number" and 1 or 0)
	mycount.FC = mycount.FC + (type(thismetadata.levmusic) ~= "number" and 1 or 0)
	mycount.FC = mycount.FC + (#theselevelmetadata ~= 400 and 1 or 0)
	]]
	if (type(thismetadata.mapwidth) ~= "number") or (thismetadata.mapwidth < 1) or (thismetadata.mapwidth > 20) then
		mycount.FC = mycount.FC + 1
		cons_fc(langkeys(L.MAPWIDTHINVALID, {anythingbutnil(thismetadata.mapwidth)}))
		thismetadata.mapwidth = 1
	end if (type(thismetadata.mapheight) ~= "number") or (thismetadata.mapheight < 1) or (thismetadata.mapheight > 20) then
		mycount.FC = mycount.FC + 1
		cons_fc(langkeys(L.MAPHEIGHTINVALID, {anythingbutnil(thismetadata.mapheight)}))
		thismetadata.mapheight = 1
	end if (thismetadata.levmusic == nil) or (thismetadata.levmusic == "") then
		mycount.FC = mycount.FC + 1
		cons_fc(L.LEVMUSICEMPTY)
		thismetadata.levmusic = 0
	end if (#theselevelmetadata ~= 400) then
		mycount.FC = mycount.FC + 1
		cons_fc(L.NOT400ROOMS)

		if #theselevelmetadata < 400 then
			for croom = #theselevelmetadata+1, 400 do
				theselevelmetadata[croom] =
					{
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
	end

	if mycount.FC ~= 0 then
		local FClisttext = ""

		for k,v in pairs(FClist) do
			if k > 5 then
				FClisttext = FClisttext .. "... " .. langkeys(L.MOREERRORS, {(#FClist-5)})
				break
			end

			FClisttext = FClisttext .. v .. "\n"
		end

		dialog.create(langkeys(L_PLU.LEVELFAILEDCHECKS, {mycount.FC}) .. "\n\n" .. FClisttext)
	end

	-- No longer x.alltiles
	return true, thismetadata, theserooms, allentities, theselevelmetadata, allscripts, mycount, myscriptnames, myvedmetadata
end


-- Load a template that we'll need for saving...
vvvvvvxmltemplate = love.filesystem.read("template.vvvvvv")

function savelevel(path, thismetadata, theserooms, allentities, theselevelmetadata, allscripts, vedmetadata, crashed)
	-- Assumes we've already checked whether the file already exists and whatnot, immediately saves!
	-- Returns success, (if not) error message
	if (path == nil) or (path == "") then
		return false, L.FORGOTPATH
	end

	-- First make a backup of the file we'll overwrite - if it exists and we haven't crashed.
	if not crashed and s.enableoverwritebackups then
		backup_level(levelsfolder, path:sub(1, -8))
	end

	savethis = vvvvvvxmltemplate

	cons("Placing metadata...")
	for k,v in pairs(metadataitems) do
		--cons("Placing metadata: " .. v .. " which should match " .. "%$" .. string.upper(v) .. "%$ and have a value of " .. xmlspecialchars(thismetadata[v]))

		-- OK WHY DID YOU GIVE ME SUCH A DEBUGGING HEADACHE?
		--[[ Why is it that
				savethis = savethis:gsub("%$" .. string.upper(v) .. "%$", xmlspecialchars(thismetadata[v]))
			is NOT good, but
				newthis = xmlspecialchars(thismetadata[v])
				savethis = savethis:gsub("%$" .. string.upper(v) .. "%$", newthis)
			IS? ]]
		cons("Doing " .. v)
		newthis = xmlspecialchars(anythingbutnil(thismetadata[v]))
		savethis = savethis:gsub("%$" .. string.upper(v) .. "%$", newthis)
	end

	-- Hold on for a second, we need the map size and music too!
	savethis = savethis:gsub("%$MAPWIDTH%$", thismetadata["mapwidth"]):gsub("%$MAPHEIGHT%$", thismetadata["mapheight"]):gsub("%$LEVMUSIC%$", thismetadata["levmusic"])

	-- The contents are gonna be the hardest!
	cons("Assembling contents......")
	thenewcontents = {}
	--for roomy, yv in pairs(theserooms) do
	for lroomy = 0, (thismetadata.mapheight-1) do
		yv = theserooms[lroomy]
		-- We now have each y.....
		cons("Y: " .. lroomy)
		for line = 0, 29 do
			-- (each line)
			--for roomx, xv in pairs(yv) do
			for lroomx = 0, (thismetadata.mapwidth-1) do
				xv = yv[lroomx]
				-- .....And each x for each line
				--for tilex = 0, 39 do
					-- Maybe there's a notation for taking a specific part of an array to implode? I think it would be a whole lot better than concatenating every single tile like this
					--thenewcontents = thenewcontents .. theserooms[roomy][roomx][(line*40)+tilex+1] .. ","
				--end
				-- Heeey
				table.insert(thenewcontents, table.concat({unpack(theserooms[lroomy][lroomx], (line*40)+1, (line*40)+40)}, ","))
			end
		end
	end
	savethis = savethis:gsub("%$CONTENTS%$", table.concat(thenewcontents, ",") .. ",")

	-- Slightly cleaning up
	thenewcontents = nil

	-- Now do all entities, if we have any!
	cons("Saving entities...")
	if (#allentities > 0) or (vedmetadata ~= false and vedmetadata ~= nil) then
		-- We do!
		thenewentities = "        <edEntities>\n"
		for k,v in pairs(allentities) do
			thenewentities = thenewentities .. "            <edentity x=\"" .. v.x .. "\" y=\"" .. v.y .. "\" t=\"" .. v.t .. "\" p1=\"" .. v.p1 .. "\" p2=\"" .. v.p2 .. "\" p3=\"" .. v.p3 .. "\" p4=\"" .. v.p4 .. "\" p5=\"" .. v.p5 .. "\" p6=\"" .. v.p6 .. "\">" .. xmlspecialchars(v.data) .. "\n            </edentity>\n"
		end

		if vedmetadata ~= false and vedmetadata ~= nil then
			-- We have a metadata entity to save! As for flag names concatenation, table.concat expects all tables to start at index 1.
			local mdedata = thismdeversion .. "|" .. despecialchars(vedmetadata.flaglabel[0])

			for k = 1, 99 do -- 0 added above
				mdedata = mdedata .. "$" .. despecialchars(vedmetadata.flaglabel[k]) -- table.concat(vedmetadata.flaglabel, "$")
			end

			mdedata = mdedata .. "||"

			-- Vars
			local varsdata = {}

			for k,v in pairs(vedmetadata.vars) do
				table.insert(varsdata, despecialchars(k) .. "@" .. v["type"] .. "@" .. despecialchars(v.value))
			end

			mdedata = mdedata .. table.concat(varsdata, "$") .. "|"

			-- Now add the notes to it!
			local notesdata = {}

			for k,v in pairs(vedmetadata.notes) do
				-- Don't save the "Return" article
				if k ~= 1 then
					table.insert(notesdata, despecialchars(v.subj) .. "@" .. despecialchars(v.cont))
				end
			end

			mdedata = mdedata .. table.concat(notesdata, "$")

			thenewentities = thenewentities .. "            <edentity x=\"800\" y=\"600\" t=\"17\" p1=\"0\" p2=\"0\" p3=\"0\" p4=\"0\" p5=\"320\" p6=\"240\">" .. xmlspecialchars(mdedata) .. "\n            </edentity>\n"
		end

		savethis = savethis:gsub("%$EDENTITIES%$", thenewentities:gsub("%%", "%%%%") .. "        </edEntities>")
	else
		-- We don't!
		savethis = savethis:gsub("%$EDENTITIES%$", "        <edEntities />")
	end

	cons("Saving room metadata...")
	-- Now all room metadata, aka levelclass
	alllevelmetadata = ""
	for k,v in pairs(theselevelmetadata) do
		alllevelmetadata = alllevelmetadata .. "            <edLevelClass tileset=\"" .. v.tileset .. "\" tilecol=\"" .. v.tilecol .. "\" platx1=\"" .. v.platx1 .. "\" platy1=\"" .. v.platy1 .. "\" platx2=\"" .. v.platx2 .. "\" platy2=\"" .. v.platy2 .. "\" platv=\"" .. v.platv .. "\" enemyx1=\"" .. v.enemyx1 .. "\" enemyy1=\"" .. v.enemyy1 .. "\" enemyx2=\"" .. v.enemyx2 .. "\" enemyy2=\"" .. v.enemyy2 .. "\" enemytype=\"" .. v.enemytype .. "\" directmode=\"" .. (v.auto2mode == 0 and anythingbutnil0(v.directmode) or 1) .. "\" warpdir=\"" .. v.warpdir .. "\">" .. xmlspecialchars(v.roomname) .. "</edLevelClass>\n"
	end

	savethis = savethis:gsub("%$EDLEVELCLASSES%$", (alllevelmetadata:gsub("%%", "%%%%")))

	-- Now all the scripts!
	cons("Assembling scripts...")
	allallscripts = ""
	--for k,v in pairs(allscripts) do
	for rvnum = 1, #scriptnames do
		local k, v = scriptnames[rvnum], allscripts[scriptnames[rvnum]]
		allallscripts = allallscripts .. xmlspecialchars(k) .. ":|" .. xmlspecialchars(implode("|", v)) .. "|"
	end

	savethis = savethis:gsub("%$SCRIPT%$", ((allallscripts:sub(1, -2)):gsub("%%", "%%%%")))

	-- Alright, let's save!
	cons("Saving file...")
	success, iferrmsg = writelevelfile(levelsfolder .. dirsep .. path, savethis)

	if vedmetadata == nil then
		dialog.create(L.MDENOTPASSED)
	end

	if success then
		recentlyopened(path:sub(1, -8))

		if undobuffer ~= nil then
			saved_at_undo = #undobuffer
		end
		unsavedchanges = false
	end

	return success, iferrmsg
end

function xmlspecialchars(text)
	-- Replace real special entities like < > & by XML entities like &lt; &gt; &amp;
	return xmlnumericentities(text:gsub("&", "&amp;"):gsub("\"", "&quot;"):gsub("'", "&apos;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("^ ", "&#32;"):gsub(" $", "&#32;"):gsub("  ", " &#32;"))
end

function unxmlspecialchars(text)
	-- Decode XML entities like &lt; &gt; &amp; to < > &
	return unxmlnumericentities(text):gsub("&gt;", ">"):gsub("&lt;", "<"):gsub("&apos;", "'"):gsub("&quot;", "\""):gsub("&amp;", "&")
end

function xmlnumericentities(text)
	-- Replace real control characters (<0x20) by numeric XML entities like &#31;
	return text:gsub(
		"%c",
		function(c)
			return "&#" .. string.byte(c) .. ";"
		end
	)
end

function unxmlnumericentities(text)
	-- Replace numeric XML entities (like &#32;) to real characters
	return text:gsub(
		"&#(%d+);",
		function(n)
			return string.char(n)
		end
	):gsub(
		"&#x(%x+);",
		function(n)
			return string.char(tonumber(n,16))
		end
	)
end

function despecialchars(text)
	return text:gsub("`", "`g"):gsub("\r?\n", "`n"):gsub("|", "`p"):gsub("%$", "`d"):gsub("@", "`a"):gsub("  ", "`_")
end

function undespecialchars(text)
	return text:gsub("`_", "  "):gsub("`a", "@"):gsub("`d", "$"):gsub("`p", "|"):gsub("`n", "\n"):gsub("`g", "`")
end


function createblanklevel(lvwidth, lvheight)
	-- Returns (bool)success, (array)metadata, (array)contents, (array)entities, (array)levelmetadata, (array)scripts, (array)count, (array)scriptnames, (array)vedmetadata
	-- Map size and music is gonna move in with the metadata here.
	-- Contents is basically the raw array exploded
	-- Entities bestaat uit arrays (entity contents are array item data)
	-- Of course levelmetadata is all 400 rooms and also consists of arrays (roomname is array item roomname)
	-- Scripts are pre-exploded and scripts[scriptname] = (array)contents
	-- count will return the count of trinkets, crewmates and entities to keep everything within limits. It also contains the ID of the start point so it can be removed in case we place a new one.
	-- scriptnames is used to keep the names in order of opening scripts
	-- vedmetadata has flag names (.flaglabel)
	-- If loading isn't successful, metadata will be an error string.

	-- There should be a list of tileset options and such
	-- - Same as in VVVVVV
	-- - Completely random
	-- - Random from tileset: X
	-- - All: X X

	-- Dit blijft zo
	local mycount = {trinkets = 0, crewmates = 0, entities = 0, entity_ai = 1, startpoint = nil}

	-- First do the metadata.
	cons("Loading metadata...")

	thismetadata =
		{
		Creator = "Unknown",
		Title = "Untitled Level",
		Created = "2",
		Modified = "",
		Modifiers = "2",
		Desc1 = "", Desc2 = "", Desc3 = "",
		website = "",
		mapwidth = lvwidth,
		mapheight = lvheight,
		levmusic = 0
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
	for croom = 1, 400 do
		theselevelmetadata[croom] =
			{
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

	-- Scripts
	cons("Loading scripts...")

	allscripts = {}
	myscriptnames = {}

	--[[
	myvedmetadata =
		{
		flaglabel = {}
		}
	]]
	local myvedmetadata = false

	cons("Done loading!")

	-- No longer x.alltiles
	return true, thismetadata, theserooms, allentities, theselevelmetadata, allscripts, mycount, myscriptnames, myvedmetadata
end
