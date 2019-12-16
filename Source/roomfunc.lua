-- Ok the array (roomdata) with tiles is just continuous for a single room (so it has 1200 items) FOR each array item, roomdata[y][x] contains all the tiles
-- The array entitydata is an array containing entities as subarrays
-- And then there's a roommeta array that contains all the metadata of a room (like roomname and such)

-- This is per room so multiple arrays can be set if zoomed out.

--[[ Also, somewhere, there should be an array with tilesets and all their colors but what tiles they actually use in what tileset
Something like:
tilesets =
	{
	'ship' =
		{
		'tilesetid' = 46,
		'tileimg' = 'tiles2',
		'colors' =
			{
			'red' =
				{
				'colorid' = 15,
				'blocks' =
					{
					1, 2, 3, 11, 12, 13, 21, 22, 23
					},
				'background' =
					{
					31, 32, 33, 41, 42, 43, 51, 52, 53
					}
				}
			}
		}
	}
]]

function loademptyroom() -- unused
	-- Generate an entirely empty room with no entities nor metadata.
	cons("Generating empty room")

	myroomdata = {}

	for k = 1, 1200 do
		myroomdata[k] = 0 -- Just to test.
	end

	myentitydata = {}

	mymetadata = {}

	mymetadata.roomname = "Untitled room"
	mymetadata.tileset = 1

	return myroomdata, myentitydata, mymetadata
end

function loadrohiom(x, y)
	-- Loads blocks of a room from level data and prepares it for display. Also loads entities and metadata.

	return myroomdata, myentitydata, mymetadata
end

function displayroom(offsetx, offsety, theroomdata, themetadata, zoomscale2, displaytilenumbers, displaysolid, displayminimapgrid)
	if zoomscale2 == nil then zoomscale2 = 1 end
	-- This assumes the room is already loaded in roomdata. It just displays a room, without the entities. Also include scale for zooming out.
	local ts = usedtilesets[themetadata.tileset]

	-- Is our SpriteBatch still up-to-date?
	if tile_batch_tileset ~= ts or tile_batch_texture_needs_update then
		tile_batch_needs_update = true
		tile_batch:setTexture(tilesets[tilesetnames[ts]]["img"])
		tile_batch_tileset = ts
		tile_batch_texture_needs_update = false
	end
	if not tile_batch_needs_update then
		-- Doesn't need update? I mean we don't already know it does!
		for i = 1, 1200 do
			if tile_batch_tiles[i] ~= theroomdata[i] then
				tile_batch_needs_update = true
				break
			end
		end
	end
	if tile_batch_needs_update then
		tile_batch:clear()
		tile_batch_zoomscale2 = zoomscale2

		for aty = 0, 29 do
			for atx = 0, 39 do
				local t = theroomdata[(aty*40)+(atx+1)]
				local x, y = 16*atx*zoomscale2, 16*aty*zoomscale2
				if t ~= 0 then
					tile_batch:add(tilesets[tilesetnames[ts]]["tiles"][tonumber(t)], x, y, 0, 2*zoomscale2)
				end
				tile_batch_tiles[(aty*40)+(atx+1)] = t
			end
		end
		tile_batch_needs_update = false
	end
	love.graphics.draw(tile_batch, offsetx, offsety, 0, zoomscale2/tile_batch_zoomscale2)

	if not displaysolid and not displaytilenumbers and not displayminimapgrid then
		return
	end

	local zoom
	if displayminimapgrid then
		zoom = getminimapzoom(metadata)
	end

	for aty = 0, 29 do
		for atx = 0, 39 do
			local t = theroomdata[(aty*40)+(atx+1)]
			local x, y = offsetx+(16*atx*zoomscale2), offsety+(16*aty*zoomscale2)

			if displaysolid then
				if issolid(t, ts, false, true) then
					-- Wall
					love.graphics.draw(solidimg, x, y)
				-- Spikes
				elseif istophalfspike(t, ts) then
					love.graphics.setColor(255,0,0)
					love.graphics.draw(solidhalfimg, x, y)
					love.graphics.setColor(255,255,255)
				elseif isbottomhalfspike(t, ts) then
					love.graphics.setColor(255,0,0)
					love.graphics.draw(solidhalfimg, x, y+8)
					love.graphics.setColor(255,255,255)
				elseif issolid(t, ts, false, true) ~= issolid(t, ts, true, true) then
					love.graphics.setColor(255,0,0)
					love.graphics.draw(solidimg, x, y)
					love.graphics.setColor(255,255,255)
				end
			end

			if displaytilenumbers then
				ved_print(t, x, y)
			end

			if displayminimapgrid then
				love.graphics.setColor(96, 96, 96)
				local function draw()
					love.graphics.draw(solidimg, x, y)
				end
				if zoom == 1 then
					if atx >= 3 and atx <= 36 and atx % 3 == 0 and aty <= 24 and aty % 3 == 0 then
						draw()
					end
				elseif zoom == 2 then
					if atx <= 36 and islineon24x18(atx) and aty <= 27 and islineon24x18(aty) then
						draw()
					end
				elseif zoom == 4 then
					draw()
				end
				love.graphics.setColor(255, 255, 255)
			end
		end
	end
end

function addrooms(neww, newh)
	-- Will add rooms in case we increase the map size. Or in case we create a new level, this prepares empty rooms. (not used for that)
	-- I'm gonna do this in a very simple way, just loop through all rooms and add a room wherever it's nil.
	-- This is because we can have decreased one side and increased another, then increase the other side and still have room data there we don't want to lose in case resizing was an accident
	cons("Maybe adding rooms: new map size is " .. neww .. " " .. newh)

	for y = 0, (newh-1) do
		if roomdata[y] == nil then
			roomdata[y] = {}
		end

		for x = 0, (neww-1) do
			if roomdata[y][x] == nil then
				roomdata[y][x] = {}
				for t = 1, 1200 do
					roomdata[y][x][t] = 0
				end
				map_resetroom(x, y)
			end
		end
	end
end

function displayentities(offsetx, offsety, myroomx, myroomy, bottom2rowstext)
	-- This assumes the entities for this room are already loaded in entitydata. It just displays all entities.
	if bottom2rowstext == nil then
		bottom2rowstext = true
	end
	local showtooltip
	if allowdebug then
		showtooltip = true
	else
		showtooltip = false
	end

	local showtooltipof = nil
	local scriptname_shown = false
	local scriptname_args = {}
	local scriptname_editingshown = false -- is the script name that's being edited in this room? We have its key

	for k,v in pairs(entitydata) do
		if ((v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29)) or ((v.t == 13) and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29)) then
			-- First of all, we can remove an entity by shift-right clicking
			if keyboard_eitherIsDown("shift") and love.mouse.isDown("r") and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16) then
				removeentity(k, entitydata[k].t)
			else
				showtooltip, scriptname_shown, scriptname_editingshown = displayentity(
					offsetx, offsety, myroomx, myroomy, k, v, nil, nil, showtooltip, scriptname_shown, scriptname_args, scriptname_editingshown, true, bottom2rowstext
				)

				if showtooltip and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16) then
					showtooltipof = v
				end
			end
		end
	end

	-- Here so that other entities won't cover the tooltip
	if showtooltipof ~= nil then
		ved_print("x=" .. anythingbutnil(showtooltipof.x) .. "\ny=" .. anythingbutnil(showtooltipof.y) .. "\nt=" .. anythingbutnil(showtooltipof.t) .. "\np1=" .. anythingbutnil(showtooltipof.p1) .. "\np2=" .. anythingbutnil(showtooltipof.p2) .. "\np3=" .. anythingbutnil(showtooltipof.p3) .. "\np4=" .. anythingbutnil(showtooltipof.p4) .. "\np5=" .. anythingbutnil(showtooltipof.p5) .. "\np6=" .. anythingbutnil(showtooltipof.p6) .. "\n" .. L.SMALLENTITYDATA .. "=" .. anythingbutnil(showtooltipof.data), love.mouse.getX()+24, love.mouse.getY()+24)
	end

	if scriptname_editingshown then
		displayscriptname(entitydata[editingroomtext].t == 19, editingroomtext, entitydata[editingroomtext], offsetx, offsety, myroomx, myroomy)
	end
	if scriptname_shown then
		displayscriptname(scriptname_args[1], scriptname_args[2], scriptname_args[3], offsetx, offsety, myroomx, myroomy)
	end
end

function displaybottom2rowstexts(offsetx, offsety, myroomx, myroomy)
	local showtooltip = allowdebug
	local scriptname_shown = false
	local scriptname_args = {}
	local scriptname_editingshown = false
	for k,v in pairs(entitydata) do
		if (v.t == 17) and (v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= (myroomy*30)+28) and (v.y <= (myroomy*30)+29) then
			displayentity(offsetx, offsety, myroomx, myroomy, k, v, nil, nil, showtooltip, scriptname_shown, scriptname_args, scriptname_editingshown, true, true)
		end
	end
end

function displayentity(offsetx, offsety, myroomx, myroomy, k, v, forcetilex, forcetiley, showtooltip, scriptname_shown, scriptname_args, scriptname_editingshown, interact, bottom2rowstext)
	local x, y
	if forcetilex ~= nil then
		x = offsetx+forcetilex*16
	else
		x = offsetx+(v.x-myroomx*40)*16
	end
	if forcetiley ~= nil then
		y = offsety+forcetiley*16
	else
		y = offsety+(v.y-myroomy*30)*16
	end

	-- What kind of entity is this?
	if allowdebug and love.keyboard.isDown("/") then
		love.graphics.draw(cursorimg[5], x, y)
	elseif v.t == 1 then
		-- Enemy
		v6_setcol(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].v6col)
		drawentitysprite(enemysprites[levelmetadata[(myroomy)*20 + (myroomx+1)].enemytype], x, y) -- 78

		-- Where is it going?
		love.graphics.setColor(255,255,255,255)
		ved_print(anythingbutnil(({"V", "^", "<", ">"})[v.p1+1]), x + 8, y + 8, 2)

		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[9], L.DELETE, L.CHANGEDIRECTION, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_1_" .. k,
				2, 2
			)
		end
	elseif v.t == 2 then
		-- Platform, it's either a moving one or a conveyor!
		love.graphics.setColor(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].entcolor)
		love.graphics.draw(platformimg, platformpart[1], x, y, 0, 2)
		love.graphics.draw(platformimg, platformpart[2], x + 16, y, 0, 2)
		love.graphics.draw(platformimg, platformpart[2], x + 32, y, 0, 2)
		if v.p1 < 7 then
			-- 4 tiles
			love.graphics.draw(platformimg, platformpart[3], x + 48, y, 0, 2)
		else
			-- 8 tiles
			love.graphics.draw(platformimg, platformpart[2], x + 48, y, 0, 2)
			love.graphics.draw(platformimg, platformpart[2], x + 64, y, 0, 2)
			love.graphics.draw(platformimg, platformpart[2], x + 80, y, 0, 2)
			love.graphics.draw(platformimg, platformpart[2], x + 96, y, 0, 2)
			love.graphics.draw(platformimg, platformpart[3], x + 112, y, 0, 2)
		end

		-- Now indicate what this actually is.
		love.graphics.setColor(255,255,255,255)
		if platform_labels[v.p1] ~= nil then
			ved_print(platform_labels[v.p1], x, y, 2)
		else
			-- What
			ved_print("...?", x, y, 2)
		end

		if interact then
			entityrightclick(
				x, y,
				{"#" .. (v.p1 < 4 and toolnames[8] or toolnames[7]), L.DELETE, L.CYCLETYPE, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_2_" .. k,
				v.p1 < 7 and 4 or 8, 1
			)
		end
	elseif v.t == 3 then
		-- Disappearing platform
		love.graphics.setColor(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].entcolor)
		love.graphics.draw(platformimg, platformpart[1], x, y, 0, 2)
		love.graphics.draw(platformimg, platformpart[2], x + 16, y, 0, 2)
		love.graphics.draw(platformimg, platformpart[2], x + 32, y, 0, 2)
		love.graphics.draw(platformimg, platformpart[3], x + 48, y, 0, 2)
		-- This is a disappearing platform.
		love.graphics.setColor(255,255,255,255)
		ved_print("////", x, y, 2)
		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[6], L.DELETE, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_3_" .. k,
				4, 1
			)
		end
	elseif v.t == 9 then
		-- Trinket
		v6_setcol(3)
		drawentitysprite(22, x, y)
		love.graphics.setColor(255, 255, 255)
		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[4], L.DELETE, L.MOVEENTITY, (count.trinkets >= 20 and "#" or "") .. L.COPY, L.PROPERTIES}, "ent_9_" .. k,
				2, 2
			)
		end
	elseif v.t == 10 then
		-- Checkpoint. p1=0 is upside down, p1=1 is upright. Yes, VVVVVV works this way:
		v6_setcol(4)
		drawentitysprite(20+v.p1, x, y)
		love.graphics.setColor(255, 255, 255)
		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[5], L.DELETE, L.FLIP, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_10_" .. k,
				2, 2
			)
		end
	elseif v.t == 11 or v.t == 50 then
		local showhitbox = state == 1 and nodialog and editingroomtext == 0 and not editingroomname and not keyboard_eitherIsDown(ctrl) and love.keyboard.isDown("j")
		-- Gravity line or warp line. This is kind of a special story.
		if v.t == 50 then
			-- Warp line
			love.graphics.setColor(0,255,0,255)
		elseif v.t == 11 then
			-- Gravity line
			v6_setgravitylinecol()
		end
		local sel_x, sel_y, sel_w, sel_h
		-- Gravity lines and warp lines have a different p1!
		if (v.t == 11 and v.p1 == 0) or (v.t == 50 and (v.p1 == 2 or v.p1 == 3)) then
			-- Horizontal
			sel_x = offsetx+(v.p2)*16
			sel_y = y
			sel_w = v.p3/8
			sel_h = 1
			if v.t == 11 then
				-- Accurate gravity line pixels
				if showhitbox then
					-- Accurate hitbox
					love.graphics.setColor(255,0,0,255)
					love.graphics.rectangle("line", sel_x - .5, sel_y + 10.5, 16*sel_w + 1, sel_h)
				else
					love.graphics.rectangle("line", sel_x + .5, sel_y + 8.5, 16*sel_w - 1, sel_h)
				end
			else
				love.graphics.line(sel_x + 1, sel_y + 8, sel_x + 16*sel_w - 1, sel_y + 8)
			end
		else
			-- Vertical
			sel_x = x
			sel_y = offsety+(v.p2)*16
			sel_w = 1
			sel_h = v.p3/8
			if v.t == 11 then
				-- Accurate gravity line pixels
				if showhitbox then
					-- Accurate hitbox
					love.graphics.setColor(255,0,0,255)
					love.graphics.rectangle("line", sel_x + 8.5, sel_y - .5, sel_w, 16*sel_h + 1)
					love.graphics.rectangle("line", sel_x + 10.5, sel_y - .5, sel_w, 16*sel_h + 1)
				else
					love.graphics.rectangle("line", sel_x + 6.5, sel_y + .5, sel_w, 16*sel_h - 1)
				end
			else
				love.graphics.line(sel_x + 8, sel_y + 1, sel_x + 8, sel_y + 16*sel_h - 1)
			end
		end
		love.graphics.setColor(255,255,255,255)

		-- Where is it, though?
		love.graphics.draw(cursorimg[0], x, y)
		if interact then
			if v.t == 11 then
				entityrightclick(
					x, y,
					{"#" .. toolnames[10], L.DELETE, (v.p1 == 0 and L.CHANGETOVER or L.CHANGETOHOR), (v.p4 == 1 and L.UNLOCK or L.LOCK), L.PROPERTIES}, "ent_11_" .. k,
					sel_w, sel_h, sel_x, sel_y
				)
			else
				entityrightclick(
					x, y,
					{"#" .. toolnames[15], L.DELETE, L.PROPERTIES}, "ent_50_" .. k,
					sel_w, sel_h, sel_x, sel_y
				)
			end
		end
	elseif v.t == 13 then
		-- Warp token. But are we currently displaying the entrance or the destination? Or both?
		if (v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29) then
			-- Entrance
			v6_setcol(10)
			drawentitysprite(18, x, y)
			love.graphics.setColor(255, 255, 255)
			if interact then
				entityrightclick(
					x, y,
					{"#" .. toolnames[14], L.DELETE, L.GOTODESTINATION, L.CHANGEENTRANCE, L.CHANGEEXIT, L.COPYENTRANCE, L.PROPERTIES}, "ent_13_" .. k,
					2, 2
				)
			end
		end
		-- warpid = what warp token destination we're placing.
		if (warpid ~= k or selectedsubtool[14] >= 3) and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29) then
			-- Destination
			love.graphics.setColor(255,255,255,64)
			drawentitysprite(18, offsetx+(v.p1-myroomx*40)*16, offsety+(v.p2-myroomy*30)*16)
			love.graphics.setColor(255,255,255,255)
			if interact then
				entityrightclick(
					offsetx+(v.p1-myroomx*40)*16, offsety+(v.p2-myroomy*30)*16,
					{"#" .. toolnames[14], L.DELETE, L.GOTOENTRANCE, L.CHANGEENTRANCE, L.CHANGEEXIT, L.COPYENTRANCE, L.PROPERTIES}, "ent_13_" .. k,
					2, 2
				)
			end
		end
	elseif v.t == 15 then
		-- Rescuable crewmate
		setrescuablecolor(v.p1)
		local sprite = getrescuablesprite(v.p1)
		drawentitysprite(sprite, x - 8, y + 2)
		love.graphics.setColor(255, 255, 255)
		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[16], L.DELETE, L.CHANGECOLOR, L.MOVEENTITY, (count.crewmates >= 20 and "#" or "") .. L.COPY, L.PROPERTIES}, "ent_15_" .. k,
				2, 3
			)
		end
	elseif v.t == 16 then
		-- Start point
		v6_setcol(0)
		drawentitysprite(3*v.p1, x - 8, y + 2)
		love.graphics.setColor(255, 255, 255)
		if interact then
			entityrightclick(
				x, y,
				{"#" .. toolnames[17], L.DELETE, L.CHANGEDIRECTION, L.MOVEENTITY, L.PROPERTIES}, "ent_16_" .. k,
				2, 3
			)
		end
	elseif v.t == 17 then
		-- Roomtext
		if not bottom2rowstext and (v.y%30 == 28 or v.y%30 == 29) then
		else
			local data = v.data
			if editingroomtext == k then
				-- We're editing this text at the moment.
				data = input .. __
			end
			v6_setroomprintcol()
			ved_print(data, x, y, 2)
			love.graphics.setColor(255, 255, 255)
			if interact then
				entityrightclick(
					x, y,
					{"#" .. toolnames[11], L.DELETE, L.EDITTEXT, L.COPYTEXT, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_17_" .. k,
					data:len(), 1
				)
			end
		end
	elseif v.t == 18 then
		-- Terminal
		if math.abs(sp_t) == k then
			sp_teken(v, offsetx, offsety, myroomx, myroomy)
		end
		v6_setcol(4)
		drawentitysprite(17, x, y + 16)
		love.graphics.setColor(255, 255, 255)
		-- Maybe we should also display the script name!
		if editingroomtext == k then
			scriptname_editingshown = true
		elseif hovering_over_name(false, k, v, offsetx, offsety, myroomx, myroomy) and interact then
			scriptname_shown = true
			scriptname_args[1], scriptname_args[2], scriptname_args[3] = false, k, v
		end
		if interact then
			entityrightclick(
				x, y,
				{(namefound(v) ~= 0 and "" or "#") .. toolnames[12], L.DELETE, L.EDITSCRIPT, L.OTHERSCRIPT, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_18_" .. k,
				2, 3
			)
		end
	elseif v.t == 19 then
		-- Script box, draw it as an actual box.
		--love.graphics.draw(cursorimg[1], x, y)
		love.graphics.draw(scriptboximg[1], x, y)
		if editingsboxid == k and selectedsubtool[13] ~= 3 then
			-- Currently placing
			love.graphics.draw(scriptboximg[3], math.max(math.floor(love.mouse.getX()/16)*16, x), y)
			love.graphics.draw(scriptboximg[7], x, math.max(math.floor(love.mouse.getY()/16)*16, y))
			love.graphics.draw(scriptboximg[9], math.max(math.floor(love.mouse.getX()/16)*16, x), math.max(math.floor(love.mouse.getY()/16)*16, y))

			-- Horizontal

			for prt = x + 16, math.max(math.floor(love.mouse.getX()/16)*16), 16 do
				love.graphics.draw(scriptboximg[2], prt, y)
				love.graphics.draw(scriptboximg[8], prt, math.max(math.floor((love.mouse.getY()/16))*16, y))
			end

			-- Vertical
			for prt = y + 16, math.max(math.floor(love.mouse.getY()/16)*16, y) - 16, 16 do
				love.graphics.draw(scriptboximg[4], x, prt)
				love.graphics.draw(scriptboximg[6], math.max(math.floor(love.mouse.getX()/16)*16, x), prt)
			end
		else
			-- Normal box
			--[[
			love.graphics.draw(cursorimg[2], x + (v.p1-1)*16, y)
			love.graphics.draw(cursorimg[3], x, y + (v.p2-1)*16)
			love.graphics.draw(cursorimg[4], x + (v.p1-1)*16, y + (v.p2-1)*16)
			]]
			love.graphics.draw(scriptboximg[3], x + (v.p1-1)*16, y)
			love.graphics.draw(scriptboximg[7], x, y + (v.p2-1)*16)
			love.graphics.draw(scriptboximg[9], x + (v.p1-1)*16, y + (v.p2-1)*16)

			-- Horizontal
			for prt = x + 16, x + (v.p1-1)*16 - 16, 16 do
				love.graphics.draw(scriptboximg[2], prt, y)
				love.graphics.draw(scriptboximg[8], prt, y + (v.p2-1)*16)
			end

			-- Vertical
			for prt = y + 16, y + (v.p2-1)*16 - 16, 16 do
				love.graphics.draw(scriptboximg[4], x, prt)
				love.graphics.draw(scriptboximg[6], x + (v.p1-1)*16, prt)
			end

			if interact then
				entityrightclick(
					x, y,
					{"#" .. toolnames[13], L.DELETE, L.EDITSCRIPT, L.OTHERSCRIPT, L.RESIZE, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_19_" .. k,
					v.p1, v.p2
				)
			end
		end
		-- Maybe we should also display the script name!
		if editingroomtext == k then
			scriptname_editingshown = true
		elseif hovering_over_name(true, k, v, offsetx, offsety, myroomx, myroomy) and interact then
			scriptname_shown = true
			scriptname_args[1], scriptname_args[2], scriptname_args[3] = true, k, v
		end
	-- 50 (warp line) handled above with gravity line (11)
	else
		-- We don't know what this is, actually!
		love.graphics.draw(cursorimg[5], x, y)
		showtooltip = true
		if v.t ~= nil and interact then
			entityrightclick(
				x, y,
				{"#" .. "Type " .. v.t, L.DELETE, L.MOVEENTITY, L.COPY, L.PROPERTIES}, "ent_" .. v.t .. "_" .. k,
				1, 1
			)
		end
	end

	return showtooltip, scriptname_shown, scriptname_editingshown
end

function drawentitysprite(tile, atx, aty, small)
	if tilesets["sprites.png"]["tiles"][tile] ~= nil then
		love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][tile], atx, aty, 0, small and 1 or 2)
	else
		love.graphics.draw(cursorimg[5], atx, aty)
	end
end

function hovering_over_name(isscriptbox, k, v, offsetx, offsety, myroomx, myroomy)
	return (((not isscriptbox) or editingsboxid ~= k) and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16))
	or (editingsboxid == k and (selectedsubtool[13] == 3 or sboxdontaskname))
end

function displayscriptname(isscriptbox, k, v, offsetx, offsety, myroomx, myroomy)
	local dispy = math.max(3, offsety+(v.y-myroomy*30)*16 - 16)
	if editingroomtext == k then
		local dispx = math.min((offsetx+640)-((input .. __):len()*16)-(__ == "" and 16 or 0), offsetx+(v.x-myroomx*40)*16)
		textshadow(input, dispx, dispy, true)
		ved_print(input .. __, dispx, dispy, 2)
	elseif hovering_over_name(isscriptbox, k, v, offsetx, offsety, myroomx, myroomy) then
		local dispx = math.min((offsetx+640)-(v.data:len()*16), offsetx+(v.x-myroomx*40)*16)
		textshadow(v.data, dispx, dispy, true)
		ved_print(v.data, dispx, dispy, 2)
	end
end

function displaymapentities()

end

function entityrightclick(x, y, menuitems, newmenuid, sel_w, sel_h, sel_x, sel_y)
	-- entityrightclick(x, y, menuitems, newmenuid[, sel_w, sel_h[, sel_x, sel_y]])
	-- sel_* are used for the cyan selection rectangle - w and h are number of tiles,
	-- x and y are used to specify alternative values for x and y (first two args)
	-- which are thus in pixels!
	if lockablemouseon(x, y, 16, 16) and nodialog then
		if sel_w ~= nil and sel_h ~= nil then
			if sel_x == nil or sel_y == nil then
				sel_x = x; sel_y = y
			end
			love.graphics.setColor(0,255,255)
			love.graphics.setLineWidth(2)
			love.graphics.rectangle("line", sel_x+1, sel_y+1, sel_w*16-2, sel_h*16-2)
			love.graphics.setLineWidth(1)
			love.graphics.setColor(255,255,255)
		end
		if love.mouse.isDown("r") then
			rightclickmenu.create(menuitems, newmenuid)
		end
		if nodialog and love.mouse.isDown("l") and keyboard_eitherIsDown("alt") then
			editingroomname = false
			-- Start moving this entity, if we can! Heh, cheap trick to inspect the menu items.
			local entdetails = explode("_", newmenuid)
			if not keyboard_eitherIsDown("shift") then
				cons("Checking alt+click to move entity...")
				for k2,v2 in pairs(menuitems) do
					if v2 == L.MOVEENTITY then
						-- Just a regular, moveable entity.
						movingentity = tonumber(entdetails[3])
						break
					elseif v2 == L.GOTODESTINATION then
						-- This must be a warp token entrance, works a little different to move this.
						selectedtool = 14
						selectedsubtool[14] = 3
						warpid = tonumber(entdetails[3])
						break
					elseif v2 == L.GOTOENTRANCE then
						-- Warp token destination.
						selectedtool = 14
						selectedsubtool[14] = 4
						warpid = tonumber(entdetails[3])
						break
					end
				end
			else
				cons("Checking alt+shift+click to copy entity...")
				for k2,v2 in pairs(menuitems) do
					if v2 == L.COPY or v2 == L.COPYENTRANCE then
						-- The nice thing is, this can't be a trinket/crewmate when 20 already
						-- exist, since the menu item would be "#Copy" to disable it
						setcopyingentity(tonumber(entdetails[3]))
						break
					end
				end
			end
			nodialog = false
		end
	end
end

function displaytilespicker(offsetx, offsety, tilesetname, displaytilenumbers, displaysolid)
	love.graphics.draw(tilesets[tilesetname]["img"], offsetx, offsety, 0, 2)

	if displaytilenumbers or displaysolid then
		local ts = 1
		if tilesetname == "tiles2.png" then
			ts = 2
		end

		for aty = 0, 29 do
			for atx = 0, 39 do
				local t = (aty*40)+atx
				local x, y = offsetx+(16*atx), offsety+(16*aty)

				if displaysolid then
					if issolid(t, ts, false, true) then
						-- Wall
						love.graphics.draw(solidimg, x, y)
					-- Spikes
					elseif istophalfspike(t, ts) then
						love.graphics.setColor(255,0,0)
						love.graphics.draw(solidhalfimg, x, y)
						love.graphics.setColor(255,255,255)
					elseif isbottomhalfspike(t, ts) then
						love.graphics.setColor(255,0,0)
						love.graphics.draw(solidhalfimg, x, y+8)
						love.graphics.setColor(255,255,255)
					elseif issolid(t, ts, false, true) ~= issolid(t, ts, true, true) then
						love.graphics.setColor(255,0,0)
						love.graphics.draw(solidimg, x, y)
						love.graphics.setColor(255,255,255)
					end
				end

				if displaytilenumbers then
					ved_print(t, x, y)
				end
			end
		end
	end

	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		if selectedtool <= 2 and selectedsubtool[selectedtool] == 8 and customsizemode == 2 then
			-- We're currently creating a stamp from the tileset
			local cursorx = math.floor((love.mouse.getX()-screenoffset) / 16)
			local cursory = math.floor(love.mouse.getY() / 16)

			love.graphics.setColor(255,255,0,255)
			love.graphics.rectangle("line",
				screenoffset+customsizecoorx*16,
				customsizecoory*16,
				(math.max(cursorx, customsizecoorx)-customsizecoorx+1)*16,
				(math.max(cursory, customsizecoory)-customsizecoory+1)*16
			)
			love.graphics.setColor(255,255,255,255)
		else
			-- Also draw a box around the currently selected tile!
			local selectedx = selectedtile % 40
			local selectedy = (selectedtile-selectedx) / 40

			love.graphics.draw(cursorimg[20], (16*selectedx+screenoffset)-2, (16*selectedy)-2)
		end
	end
end

function displaysmalltilespicker(offsetx, offsety, chosentileset, chosencolor)
	local selectedx = -1
	local selectedy = -1

	local toolarray

	if selectedtool == 1 then -- wall
		toolarray = tilesetblocks[chosentileset].colors[chosencolor].blocks
	elseif selectedtool == 2 then -- background
		toolarray = tilesetblocks[chosentileset].colors[chosencolor].background
	elseif selectedtool == 3 then -- spikes
		toolarray = tilesetblocks[chosentileset].colors[chosencolor].spikes
	end

	for ly = 0, 4 do
		for lx = 0, 5 do
			-- The number is (6ly)+lx+1. The below line was a monster. Display this.
			love.graphics.draw(tilesets[tilesetnames[tilesetblocks[chosentileset].tileimg]]["img"], tilesets[tilesetnames[tilesetblocks[chosentileset].tileimg]]["tiles"][toolarray[(6*ly)+lx+1]], offsetx+(16*lx), offsety+(16*ly), 0, 2)

			-- Is this tile the selected one?
			if toolarray[(6*ly)+lx+1] == selectedtile then
				selectedx, selectedy = lx, ly
			end

			-- Are we hovering on this tile? And are we in manual mode?
			if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 and nodialog and mouseon(offsetx+(16*lx), offsety+(16*ly), 16, 16) then
				love.graphics.draw(cursorimg[0], offsetx+(16*lx), offsety+(16*ly))

				-- Heck, maybe we're even clicking this.
				if love.mouse.isDown("l") or love.mouse.isDown("m") then
					if selectedtool == 1 then -- wall
						youhavechosen = tilesetblocks[chosentileset].colors[chosencolor].blocks[(6*ly)+lx+1]
					elseif selectedtool == 2 then -- background
						youhavechosen = tilesetblocks[chosentileset].colors[chosencolor].background[(6*ly)+lx+1]
					elseif selectedtool == 3 then -- spikes
						youhavechosen = tilesetblocks[chosentileset].colors[chosencolor].spikes[(6*ly)+lx+1]
					end

					cons("Tile selected: " .. anythingbutnil0(youhavechosen))

					selectedtile = anythingbutnil0(youhavechosen)
				end
			end
		end
	end

	-- Were we highlighting a tile?
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 and selectedx ~= -1 then  -- and selectedy, but if just one of them is -1 then we have a much more serious bug to worry about
		love.graphics.draw(cursorimg[20], offsetx+(16*selectedx)-2, offsety+(16*selectedy)-2)
	end
end

function toolfinish(what)
	if love.keyboard.isDown("v") and what[3] == 4 then
		love.graphics.draw(cursorimg[6], what[1]+9, what[2]+4)
		love.graphics.draw(cursorimg[6], what[1]+13, what[2]+4)
	end
end

function autocorrectroom()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 0 then
		for thist = 1, 1200 do
			if levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 0 or tileincurrenttileset(roomdata[roomy][roomx][thist]) then
				local correctret = correcttile(roomx, roomy, thist, selectedtileset, selectedcolor)
				if roomdata[roomy][roomx][thist] ~= correctret then
					roomdata[roomy][roomx][thist] = correctret
				end
			end
		end
	end
end

function isnot0(tilenum)
	if tilenum == nil then
		return false
	elseif tilenum == 0 then
		return false
	end
	return true
end

function isoutsidebg(tilenum)
	if tilenum == nil then
		return false
	elseif tilenum >= 680 and tilenum <= 703 then
		return true
	end
	return false
end

function issolid(tilenum, tileset, spikessolid, ignoremultimode)
	-- Returns true if a tile is solid, false if not solid.
	-- Tileset can be 1 or 2 for tiles and tiles2 respectively.
	if spikessolid == nil then
		spikessolid = false
	end

	if not ignoremultimode and levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 and not tileincurrenttileset(tilenum) then
		return false
	end

	if tilenum == nil then
		return false
	elseif tilenum == 1 then
		return true
	elseif tileset == 1 and tilenum == 59 then
		return true
	elseif tilenum >= 80 and tilenum < 680 then
		return true
	elseif tileset == 2 and tilenum == 740 then
		return true
	elseif spikessolid then
		if tilenum >= 6 and tilenum <= 9 then
			return true
		elseif tilenum == 49 or tilenum == 50 then
			return true
		elseif tileset == 2 and tilenum >= 51 and tilenum <= 74 then
			return true
		end
	end
	return false
end

function istophalfspike(tilenum, tileset)
	if tilenum == nil then
		return false
	elseif tilenum == 7 or tilenum == 9 then
		return true
	elseif tileset == 2 and tilenum >= 63 and tilenum <= 74 and tilenum % 2 == 0 then
		return true
	end
	return false
end

function isbottomhalfspike(tilenum, tileset)
	if tilenum == nil then
		return false
	elseif tilenum == 6 or tilenum == 8 then
		return true
	elseif tileset == 2 and tilenum >= 63 and tilenum <= 74 and tilenum % 2 == 1 then
		return true
	end
	return false
end

function issolidmultispikes(tilenum, tileset, spikessolid)
	-- Always ignore whether tiles are in the current tileset because we're now checking tiles next to a spike, don't let multi mode ruin that.

	return issolid(tilenum, tileset, spikessolid, true)
end

function issolidforgravline(tilenum, linetype)
	if tilenum == nil then
		return false
	end

	if linetype == 50 then
		-- Warp lines get blocked by solid tiles, but not the tileset-specific exceptions...
		return issolid(tilenum, -1, false, true)
	end

	if tilenum >= 1 and tilenum <= 679 then
		return true
	end

	return false
end

function correcttile(inroomx, inroomy, t, tileset, tilecol)
	-- tilesetblocks[tileset].colors[tilecol].blocks[x]
	ts = tilesetblocks[tileset].tileimg

	--[[
	if dowhat == nil then
		-- Blocks
		myissolid = issolid
		mytype = "blocks"
	elseif dowhat == 1 then
		-- Background
		myissolid = isnot0
		mytype = "background"
	end
	]]


	doorroomx = inroomx
	doorroomy = inroomy


	-- This is all a complete mess. Basically: wall=8 background=1 spikes=2 nothing=4  outsidebackground = 6
	--local dowhat = issolid(adjtile(t, 0, 0), ts) and 8 or (issolid(adjtile(t, 0, 0), ts) ~= issolid(adjtile(t, 0, 0), ts, true) and 2 or (isnot0(adjtile(t, 0, 0), ts) and (tileset == 1 and 6 or 1) or 4))
	local dowhat
	if issolid(adjtile(t, 0, 0), ts) then
		dowhat = 8  -- WALL
	elseif (issolid(adjtile(t, 0, 0), ts, false, true) ~= issolid(adjtile(t, 0, 0), ts, true, true)) then
		dowhat = 2  -- SPIKES
	elseif isnot0(adjtile(t, 0, 0), ts) then
		if tileset == 1 then
			dowhat = 6  -- OUTSIDEBACKGROUND
		else
			dowhat = 1  -- BACKGROUND
		end
	else
		dowhat = 4  -- NOTHING
	end

	--local myissolid = ((dowhat == 8 or dowhat == 2) and issolid or ((dowhat == 1 or dowhat == 6) and isnot0 or isnot0))
	local myissolid
	if dowhat == 8 then
		myissolid = issolid
	elseif dowhat == 2 then
		if levelmetadata[(roomy)*20 + (roomx+1)].auto2mode == 1 then
			myissolid = issolidmultispikes
		else
			myissolid = issolid
		end
	elseif dowhat == 1 then
		myissolid = isnot0
	elseif dowhat == 6 then
		myissolid = isoutsidebg
	else
		myissolid = isnot0
	end

	local mytype = ((dowhat == 8) and "blocks" or ((dowhat == 1 or dowhat == 6) and "background" or "spikes"))


	--if myissolid(adjtile(t, 0, 0), ts) then
	if dowhat ~= 4 and dowhat ~= 2 and dowhat ~= 6 then
		-- W A L L S   A N D   B A C K G R O U N D S   ( N O N - O U T S I D E   B G )
		if not myissolid(adjtile(t, 0, -1), ts) and not myissolid(adjtile(t, -1, 0), ts) and not myissolid(adjtile(t, 1, 0), ts) and not myissolid(adjtile(t, 0, 1), ts) then
			-- All 4 sides are empty
			return tilesetblocks[tileset].colors[tilecol][mytype][1] -- CENTER
		elseif myissolid(adjtile(t, 0, -1), ts) and myissolid(adjtile(t, -1, 0), ts) and myissolid(adjtile(t, 1, 0), ts) and myissolid(adjtile(t, 0, 1), ts) then
			-- All 4 sides are filled.
			if not myissolid(adjtile(t, -1, -1), ts) then
				-- Top left corner is empty.
				return tilesetblocks[tileset].colors[tilecol][mytype][9] -- BOTTOM RIGHT INNER CORNER
			elseif not myissolid(adjtile(t, 1, -1), ts) then
				-- Top right corner is empty.
				return tilesetblocks[tileset].colors[tilecol][mytype][8] -- BOTTOM LEFT INNER CORNER
			elseif not myissolid(adjtile(t, -1, 1), ts) then
				-- Bottom left corner is empty.
				return tilesetblocks[tileset].colors[tilecol][mytype][3] -- TOP RIGHT INNER CORNER
			elseif not myissolid(adjtile(t, 1, 1), ts) then
				-- Bottom right corner is empty.
				return tilesetblocks[tileset].colors[tilecol][mytype][2] -- TOP LEFT INNER CORNER
			else
				-- Tile is completely surrounded!
				return tilesetblocks[tileset].colors[tilecol][mytype][1] -- CENTER
			end
		elseif not myissolid(adjtile(t, 0, -1), ts) and not myissolid(adjtile(t, -1, 0), ts) then
			-- Top side and left side are empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][13] -- TOP LEFT CORNER
		elseif not myissolid(adjtile(t, 0, -1), ts) and not myissolid(adjtile(t, 1, 0), ts) and myissolid(adjtile(t, -1, 0), ts) then
			-- Top side and right side are empty, left side is NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][15] -- TOP RIGHT CORNER
		elseif not myissolid(adjtile(t, -1, 0), ts) and not myissolid(adjtile(t, 0, 1), ts) and myissolid(adjtile(t, 0, -1), ts) then
			-- Left side and bottom side are empty, top side is NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][25] -- BOTTOM LEFT CORNER
		elseif not myissolid(adjtile(t, 1, 0), ts) and not myissolid(adjtile(t, 0, 1), ts) and myissolid(adjtile(t, 0, -1), ts) and myissolid(adjtile(t, -1, 0), ts) then
			-- Right side and bottom side are empty, top and left side are NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][27] -- BOTTOM RIGHT CORNER
		elseif not myissolid(adjtile(t, 0, -1), ts) and myissolid(adjtile(t, -1, 0), ts) and myissolid(adjtile(t, 1, 0), ts) then
			-- Top side is of course empty, left and right side are NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][14] -- TOP
		elseif not myissolid(adjtile(t, -1, 0), ts) and myissolid(adjtile(t, 0, -1), ts) and myissolid(adjtile(t, 0, 1), ts) then
			-- Left side is empty, top and bottom sides are NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][19] -- LEFT
		elseif not myissolid(adjtile(t, 1, 0), ts) and myissolid(adjtile(t, 0, -1), ts) and myissolid(adjtile(t, 0, 1), ts) then
			-- Right side is empty, top and bottom sides are NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][21] -- RIGHT
		elseif not myissolid(adjtile(t, 0, 1), ts) and myissolid(adjtile(t, -1, 0), ts) and myissolid(adjtile(t, 1, 0), ts) then
			-- Bottom side is empty, left and right side are NOT empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][26] -- BOTTOM
		else
			-- Anything I left out? Fall back on center.
			cons("Fell back on center! Tile " .. t)
			return tilesetblocks[tileset].colors[tilecol][mytype][1] -- CENTER
		end
	elseif dowhat == 6 then
		-- O U T S I D E   B A C K G R O U N D S
		if (myissolid(adjtile(t, 0, -1), ts) or myissolid(adjtile(t, 0, 1), ts)) and (myissolid(adjtile(t, -1, 0), ts) or myissolid(adjtile(t, 1, 0), ts)) then
			-- Both the left || right side and the top || bottom side are not empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][3] -- SQUARE
		elseif (myissolid(adjtile(t, -1, 0), ts) or myissolid(adjtile(t, 1, 0), ts)) then
			-- Either the left or right side is not empty.
			return tilesetblocks[tileset].colors[tilecol][mytype][2] -- HORIZONTAL
		else
			-- Either nothing surrounding it or only on the top or bottom side.
			return tilesetblocks[tileset].colors[tilecol][mytype][1] -- VERTICAL
		end
	elseif dowhat == 2 then
		-- S P I K E S
		-- The extra true for adjtile means that spikes get treated differently at the edges of the screen. The true in myissolid means that multi mode should be ignored for spikes.
		if myissolid(adjtile(t, 0, 1, true), ts, nil, true) then
			-- There's a solid block below this spike.
			return tilesetblocks[tileset].colors[tilecol].spikes[9] -- UP
		elseif myissolid(adjtile(t, 0, -1, true), ts, nil, true) then
			-- There's a solid block above this spike.
			return tilesetblocks[tileset].colors[tilecol].spikes[21] -- DOWN
		elseif myissolid(adjtile(t, -1, 0, true), ts, nil, true) then
			-- There's a solid block to the left of this spike.
			return tilesetblocks[tileset].colors[tilecol].spikes[16] -- RIGHT
		elseif myissolid(adjtile(t, 1, 0, true), ts, nil, true) then
			-- There's a solid block to the left of this spike.
			return tilesetblocks[tileset].colors[tilecol].spikes[14] -- LEFT
		else
			-- No solid blocks directly surrounding this spike
			return tilesetblocks[tileset].colors[tilecol].spikes[9] -- UP
		end
	end

	-- Just return what it already is.
	return roomdata[inroomy][inroomx][t]
end

function adjtile(tilenum, xoff, yoff, spike)
	if spike == nil then
		spike = false
	end

	-- First look if we're not gonna go offscreen
	tily = math.floor((tilenum-1)/40)
	tilx = (tilenum-40*tily)-1

	--[[ debugging crap
	if lastchecked ~= tilenum then
		cons("EVERYTHING. Tilenum=" .. tilenum .. " (we're checking " .. (tilenum + ((yoff)*40) + (xoff)) .. ") tilx=" .. tilx .. " tily=" .. tily .. "")
		lastchecked = tilenum
	end
	]]

	if doorroomy == nil or doorroomx == nil then
		-- Not quite local...
		cons("THE FIRST THING WE DO IS PLACE SPIKES APPARENTLY")
		doorroomx = roomx
		doorroomy = roomy
	end

	if spike and ((tilx+xoff < 0) or (tilx+xoff > 39) or (tily+yoff < 0) or (tily+yoff > 29)) then
		return 0 -- Should not be solid now, because then we're gonna prioritize orienting spikes to be attached to that, and that's not what VVVVVV's automatic mode does.
	elseif (tilx+xoff < 0) or (tilx+xoff > 39) or (tily+yoff < 0) or (tily+yoff > 29) then
		return 1 -- a solid tile for offscreen
	elseif roomdata[doorroomy][doorroomx][tilenum + ((yoff)*40) + (xoff)] == nil then
		cons("THIS SHOULDN'T HAPPEN. Tilenum=" .. tilenum .. " (we're checking " .. (tilenum + ((yoff)*40) + (xoff)) .. ") tilx=" .. tilx .. " tily=" .. tily .. ". Block is nil")
		return 1
	else
		return roomdata[doorroomy][doorroomx][tilenum + ((yoff)*40) + (xoff)]
	end
end

function tileincurrenttileset(tile)
	if tile <= 2 then return true end
	for k = 1, 30 do
		if tile == tilesetblocks[selectedtileset].colors[selectedcolor].blocks[k] then return true end
		if tile == tilesetblocks[selectedtileset].colors[selectedcolor].background[k] then return true end
		if tile == tilesetblocks[selectedtileset].colors[selectedcolor].spikes[k] then return true end -- b9 CORRECTION of b8: this line is just part of the fix for spikes in multi mode
	end

	return false
end

function copymoveentities(myroomx, myroomy, newroomx, newroomy, moving)
	roomxdiff = newroomx - myroomx
	roomydiff = newroomy - myroomy

	local removedentities = nil
	if not moving then
		-- If we're copying, first remove all the entities from the target room.
		removedentities = {}
		local removedentityids = {}

		for k,v in pairs(entitydata) do
			if ((v.x >= newroomx*40) and (v.x <= (newroomx*40)+39) and (v.y >= newroomy*30) and (v.y <= (newroomy*30)+29)) then
				table.insert(removedentities, {k, table.copy(v)})
				table.insert(removedentityids, k)
			end
		end

		for _,v in pairs(removedentityids) do
			removeentity(v, nil, true)
		end
	end

	for k,v in pairs(entitydata) do
		if ((v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29)) then -----------or ((v.t == 13) and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29)) then
			if moving then
				entitydata[k].x = entitydata[k].x + (40*roomxdiff)
				entitydata[k].y = entitydata[k].y + (30*roomydiff)
			else
				if v.t == 16 or (v.t == 9 and count.trinkets >= 20) or (v.t == 15 and count.crewmates >= 20) then
					-- Nope. Can't copy this.
				else
					if v.t == 9 then
						count.trinkets = count.trinkets + 1
					elseif v.t == 15 then
						count.crewmates = count.crewmates + 1
					end

					-- I could have been busy debugging this for a long time.
					local localcopy = table.copy(v)
					localcopy.x = localcopy.x + (40*roomxdiff)
					localcopy.y = localcopy.y + (30*roomydiff)
					table.insert(entitydata, count.entity_ai, localcopy)
					localcopy = nil

					count.entities = count.entities + 1
					count.entity_ai = count.entity_ai + 1
				end
			end
		end
	end

	return removedentities
end

function displayshapedcursor(leftblx, upblx, rightblx, downblx)	
	love.graphics.draw(cursorimg[1], (cursorx*16)+screenoffset-(leftblx*16), (cursory*16)-(upblx*16))
	love.graphics.draw(cursorimg[2], (cursorx*16)+screenoffset+(rightblx*16), (cursory*16)-(upblx*16))
	love.graphics.draw(cursorimg[3], (cursorx*16)+screenoffset-(leftblx*16), (cursory*16)+(downblx*16))
	love.graphics.draw(cursorimg[4], (cursorx*16)+screenoffset+(rightblx*16), (cursory*16)+(downblx*16))
end

function displayalphatile(leftblx, upblx, forx, fory, customsize)
	if (levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 and not (customsize and customsizemode ~= 0))
	or (customsize and customsizemode == 0 and customsizetile ~= nil) then
		love.graphics.setColor(255,255,255,128)
			for forfory = 0, fory do
				for forforx = 0, forx do
					local displayedtile = selectedtile
					if customsize and customsizetile ~= nil then
						displayedtile = customsizetile[forfory+1][forforx+1]
					end
					love.graphics.draw(
						tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"],
						tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][displayedtile],
						screenoffset+(16*(cursorx-leftblx+forforx)),
						(16*(cursory-upblx+forfory)),
						0,
						2
					)
				end
			end
		love.graphics.setColor(255,255,255,255)
	end

	-- But are we holding one of the directions?
	if not editingroomname and (love.keyboard.isDown("[") or love.keyboard.isDown("]")) then
		love.graphics.setColor(0,0,0,92)

		-- Are we holding both down?
		if love.keyboard.isDown("[") and love.keyboard.isDown("]") then
			love.graphics.rectangle("fill", screenoffset, 0, (16*(math.floor((mouselockx-screenoffset) / 16)-leftblx)), (16*(math.floor(mouselocky / 16)-upblx)))
			love.graphics.rectangle("fill", screenoffset+(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), 0, 640-(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), (16*(math.floor(mouselocky / 16)-upblx)))
			love.graphics.rectangle("fill", screenoffset, (16*(math.floor(mouselocky / 16)-upblx+(fory+1))), (16*(math.floor((mouselockx-screenoffset) / 16)-leftblx)), 480-(16*(math.floor(mouselocky / 16)-upblx+(fory+1))))
			love.graphics.rectangle("fill", screenoffset+(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), (16*(math.floor(mouselocky / 16)-upblx+(fory+1))), 640-(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), 480-(16*(math.floor(mouselocky / 16)-upblx+(fory+1))))
		else
			-- Only one of the two, then.
			if love.keyboard.isDown("[") then
				-- Horizontal
				love.graphics.rectangle("fill", screenoffset, 0, 640, (16*(math.floor(mouselocky / 16)-upblx)))
				love.graphics.rectangle("fill", screenoffset, (16*(math.floor(mouselocky / 16)-upblx+(fory+1))), 640, 480-(16*(math.floor(mouselocky / 16)-upblx+(fory+1))))
			end
			if love.keyboard.isDown("]") then
				-- Vertical
				love.graphics.rectangle("fill", screenoffset, 0, (16*(math.floor((mouselockx-screenoffset) / 16)-leftblx)), 480)
				love.graphics.rectangle("fill", screenoffset+(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), 0, 640-(16*(math.floor((mouselockx-screenoffset) / 16)-leftblx+(forx+1))), 480)
			end
		end

		love.graphics.setColor(255,255,255,255)
	end
end

function displayalphatile_hor()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		love.graphics.setColor(255,255,255,128)
		for forforx = 0, 39 do
			love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*forforx), (16*cursory), 0, 2)
		end
		love.graphics.setColor(255,255,255,255)
	end
end

function displayalphatile_ver()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		love.graphics.setColor(255,255,255,128)
		for forfory = 0, 29 do
			love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*cursorx), (16*forfory), 0, 2)
		end
		love.graphics.setColor(255,255,255,255)
	end
end

function displayalphatile_all()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		love.graphics.setColor(255,255,255,128)
		for forfory = 0, 29 do
			for forforx = 0, 39 do
				love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*forforx), (16*forfory), 0, 2)
			end
		end
		love.graphics.setColor(255,255,255,255)
	end
end

function spikes_floor_left(tilex, tiley, ts)
	for loopx = tilex, 0, -1 do
		if (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 1), ts)) then
			break
		else
			roomdata[roomy][roomx][(tiley*40)+(loopx+1)] = useselectedtile
		end
	end
end

function spikes_floor_right(tilex, tiley, ts)
	for loopx = tilex, 39, 1 do
		if (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 1), ts)) then
			break
		else
			roomdata[roomy][roomx][(tiley*40)+(loopx+1)] = useselectedtile
		end
	end
end

function spikes_ceiling_left(tilex, tiley, ts)
	for loopx = tilex, 0, -1 do
		if (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, -1), ts)) then
			break
		else
			roomdata[roomy][roomx][(tiley*40)+(loopx+1)] = useselectedtile
		end
	end
end

function spikes_ceiling_right(tilex, tiley, ts)
	for loopx = tilex, 39, 1 do
		if (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((tiley*40)+(loopx+1), 0, -1), ts)) then
			break
		else
			roomdata[roomy][roomx][(tiley*40)+(loopx+1)] = useselectedtile
		end
	end
end

function spikes_leftwall_up(tilex, tiley, ts)
	for loopy = tiley, 0, -1 do
		if (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((loopy*40)+(tilex+1), -1, 0), ts)) then
			break
		else
			roomdata[roomy][roomx][(loopy*40)+(tilex+1)] = useselectedtile
		end
	end
end

function spikes_leftwall_down(tilex, tiley, ts)
	for loopy = tiley, 29, 1 do
		if (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((loopy*40)+(tilex+1), -1, 0), ts)) then
			break
		else
			roomdata[roomy][roomx][(loopy*40)+(tilex+1)] = useselectedtile
		end
	end
end

function spikes_rightwall_up(tilex, tiley, ts)
	for loopy = tiley, 0, -1 do
		if (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 1, 0), ts)) then
			break
		else
			roomdata[roomy][roomx][(loopy*40)+(tilex+1)] = useselectedtile
		end
	end
end

function spikes_rightwall_down(tilex, tiley, ts)
	for loopy = tiley, 29, 1 do
		if (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 0, 0), ts)) or not (issolidmultispikes(adjtile((loopy*40)+(tilex+1), 1, 0), ts)) then
			break
		else
			roomdata[roomy][roomx][(loopy*40)+(tilex+1)] = useselectedtile
		end
	end
end

function gotostartpointroom()
	if count.startpoint ~= nil then
		cons("Start point is at " .. entitydata[count.startpoint].x .. " " .. entitydata[count.startpoint].y .. " so in room " .. math.floor(entitydata[count.startpoint].x / 40) .. "," .. math.floor(entitydata[count.startpoint].y / 30))
		gotoroom(math.floor(entitydata[count.startpoint].x / 40), math.floor(entitydata[count.startpoint].y / 30))
	end
end

function getroomcopydata(rx, ry)
	cons("Copying room " .. rx .. " " .. ry)

	local roomnumber = ry*20 + (rx+1)

	--local datatable = roomdata[ry][rx] of course this is by reference
	local datatable = {}
	for k,v in pairs(roomdata[ry][rx]) do
		datatable[k] = v
	end

	table.insert(datatable, 1, levelmetadata[roomnumber].tileset)
	table.insert(datatable, 2, levelmetadata[roomnumber].tilecol)
	table.insert(datatable, 3, levelmetadata[roomnumber].platx1)
	table.insert(datatable, 4, levelmetadata[roomnumber].platy1)
	table.insert(datatable, 5, levelmetadata[roomnumber].platx2)
	table.insert(datatable, 6, levelmetadata[roomnumber].platy2)
	table.insert(datatable, 7, levelmetadata[roomnumber].platv)
	table.insert(datatable, 8, levelmetadata[roomnumber].enemyx1)
	table.insert(datatable, 9, levelmetadata[roomnumber].enemyy1)
	table.insert(datatable, 10, levelmetadata[roomnumber].enemyx2)
	table.insert(datatable, 11, levelmetadata[roomnumber].enemyy2)
	table.insert(datatable, 12, levelmetadata[roomnumber].enemytype)
	table.insert(datatable, 13, levelmetadata[roomnumber].directmode)
	table.insert(datatable, 14, levelmetadata[roomnumber].warpdir)
	-- Inserting it directly is causing trouble, even with [1]
	local aiguroomtext = levelmetadata[roomnumber].roomname:gsub(",", "´")
	table.insert(datatable, 15, aiguroomtext)

	return table.concat(datatable, ",")
end

function setroomfromcopy(data, rx, ry, skip_undo)
	cons("Setting room " .. rx .. " " .. ry)

	if not skip_undo then
		table.insert(undobuffer, {undotype = "paste", rx = rx, ry = ry,
				olddata = getroomcopydata(rx, ry),
				newdata = data
			}
		)
		finish_undo("PASTING")
	end

	local _, count = string.gsub(data, ",", "")

	if count ~= 1214 then -- 14+1+1199
		cons("Paste failed- count of , is " .. count .. " so this is probably not the data we're looking for.")
		return
	end

	local explodeddata = explode(",", data)

	for k,v in pairs(explodeddata) do
		if k ~= 15 then
			local numw = tonumber(v)
			explodeddata[k] = numw

			if numw == nil then
				cons("Paste failed- [" .. k .. "] (tile " .. (k-15) .. ") is not a number!")
				return
			elseif k == 1 and (numw < 0 or numw > 4) then
				cons("Paste failed- tileset is out of range! (" .. numw .. ")")
				return
			elseif k == 2 and (numw < 0
			or explodeddata[1] == 0 and numw > 31
			or explodeddata[1] == 1 and numw > 7
			or explodeddata[1] == 2 and numw > 6
			or explodeddata[1] == 3 and numw > 6
			or explodeddata[1] == 4 and numw > 5) then
				cons("Paste failed- tilecol is out of range! (" .. numw .. ")")
				return
			elseif k == 12 and (numw < 0 or numw > 9) then
				cons("Paste failed- enemy type is out of range! (" .. numw .. ")")
				return
			elseif k == 13 and numw ~= 0 and numw ~= 1 then
				cons("Paste failed- direct mode can only be 0 or 1! (is " .. numw .. ")")
				return
			elseif k == 14 and (numw < 0 or numw > 3) then
				cons("Paste failed- warpdir is " .. numw)
			elseif k > 15 and (numw < 0 or numw > 1199) then
				cons("Paste failed- [" .. k .. "] (tile " .. (k-15) .. ") is out of range 0-1199)!")
			end
		end
	end

	-- Everything appears to be well and safe to paste!
	local roomnumber = ry*20 + (rx+1)

	levelmetadata[roomnumber].tileset, selectedtileset = explodeddata[1], explodeddata[1]
	levelmetadata[roomnumber].tilecol, selectedcolor = explodeddata[2], explodeddata[2]
	levelmetadata[roomnumber].platx1 = explodeddata[3]
	levelmetadata[roomnumber].platy1 = explodeddata[4]
	levelmetadata[roomnumber].platx2 = explodeddata[5]
	levelmetadata[roomnumber].platy2 = explodeddata[6]
	levelmetadata[roomnumber].platv = explodeddata[7]
	levelmetadata[roomnumber].enemyx1 = explodeddata[8]
	levelmetadata[roomnumber].enemyy1 = explodeddata[9]
	levelmetadata[roomnumber].enemyx2 = explodeddata[10]
	levelmetadata[roomnumber].enemyy2 = explodeddata[11]
	levelmetadata[roomnumber].enemytype = explodeddata[12]
	levelmetadata[roomnumber].directmode = explodeddata[13]
	levelmetadata[roomnumber].warpdir = explodeddata[14]
	levelmetadata[roomnumber].roomname = explodeddata[15]:gsub("´", ",")

	for i=1,15 do
		table.remove(explodeddata, 1)
	end

	roomdata[ry][rx] = table.copy(explodeddata)

	temporaryroomname = L.ROOMPASTED
	temporaryroomnametimer = 90
end

function mapcopy(x1, y1, x2, y2, skip_undo)
	local oldroomdata
	if not skip_undo then
		oldroomdata = getroomcopydata(x2, y2)
	end

	cons("Copying room data...")
	--roomdata[selected2y][selected2x] = roomdata[selected1y][selected1x]
	local copieddata = getroomcopydata(x1, y1)
	setroomfromcopy(copieddata, x2, y2, true)
	temporaryroomnametimer = 0
	cons("Copying entities...")
	local removedentities = copymoveentities(x1, y1, x2, y2, false)
	cons("Done...")

	if not skip_undo then
		table.insert(undobuffer, {undotype = "mapcopy", rx = x2, ry = y2, rx_src = x1, ry_src = y1,
				olddata = oldroomdata,
				oldentities = removedentities
			}
		)
		finish_undo("MAPCOPY")
	end

	map_resetroom(x2, y2)
end

function mapswap(x1, y1, x2, y2, skip_undo)
	if not skip_undo then
		table.insert(undobuffer, {undotype = "mapswap", rx = x2, ry = y2, rx_src = x1, ry_src = y1})
		finish_undo("MAPSWAP")
	end

	cons("Swapping room data...")
	local room1data = getroomcopydata(x1, y1)
	local room2data = getroomcopydata(x2, y2)
	setroomfromcopy(room1data, x2, y2, true)
	setroomfromcopy(room2data, x1, y1, true)
	temporaryroomnametimer = 0
	cons("Swapping entities...")
	copymoveentities(x1, y1, 22, 22, true)
	copymoveentities(x2, y2, x1, y1, true)
	copymoveentities(22, 22, x2, y2, true)
	cons("Done...")

	map_resetroom(x1, y1)
	map_resetroom(x2, y2)
end

function rotateroom180(rx, ry, undoing)
	if not undoing then
		table.insert(undobuffer, {undotype = "rotateroom180", rx = rx, ry = ry})
		finish_undo("ROTATE ROOM 180")
	end

	local oldroom = table.copy(roomdata[ry][rx])

	for n = 1, 1200 do
		roomdata[ry][rx][1201-n] = oldroom[n]
	end

	-- Now for the entities!
	for k,v in pairs(entitydata) do
		if ((v.x >= rx*40) and (v.x <= (rx*40)+39) and (v.y >= ry*30) and (v.y <= (ry*30)+29)) then
			--cons(rx .. " " .. ry .. "  en " .. ((rx*40)+39 - v.x - 1)+(rx*40))

			if v.t == 9 or v.t == 13 then
				-- Trinket or warp token entrance, 2x2 block
				entitydata[k].x = ((rx*40)+39 - v.x - 1)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y - 1)+(ry*30)
			elseif v.t == 1 then
				-- Enemy- change the direction as well!
				entitydata[k].x = ((rx*40)+39 - v.x - 1)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y - 1)+(ry*30)

				-- v^<>
				if v.p1 == 0 or v.p1 == 2 then
					entitydata[k].p1 = v.p1+1
				else
					entitydata[k].p1 = v.p1-1
				end
			elseif v.t == 10 then
				-- Checkpoint, 2x2 block that can be flipped.
				entitydata[k].x = ((rx*40)+39 - v.x - 1)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y - 1)+(ry*30)

				if v.p1 == 1 then entitydata[k].p1 = 0 else entitydata[k].p1 = 1 end
			elseif v.t == 15 or v.t == 16 or v.t == 18 then
				-- Rescuable crewmate, start point and terminal, all 2x3 blocks. I won't let myself be stopped from making room rotation/flip functions because you can't rotate these!
				entitydata[k].x = ((rx*40)+39 - v.x - 1)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y - 2)+(ry*30)

				-- Well at least we can flip the start point horizontally, that's something, right?
				if v.t == 16 then
					if v.p1 == 1 then entitydata[k].p1 = 0 else entitydata[k].p1 = 1 end
				end
			elseif v.t == 3 or (v.t == 2 and v.p1 <= 6) then
				-- Disappearing platform, moving platform, or a 4-block conveyor
				entitydata[k].x = ((rx*40)+39 - v.x - 3)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y)+(ry*30)

				-- Change the direction as well!
				if v.p1 == 0 or v.p1 == 2 or v.p1 == 5 then
					entitydata[k].p1 = v.p1+1
				else
					entitydata[k].p1 = v.p1-1
				end
			elseif v.t == 2 then
				-- An 8 block conveyor then!
				entitydata[k].x = ((rx*40)+39 - v.x - 7)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y)+(ry*30)

				-- Flip it
				if v.p1 == 7 then
					entitydata[k].p1 = 8
				else
					entitydata[k].p1 = 7.
				end
			elseif v.t == 17 then
				-- Roomtext, the new placement of x depends on the length of the string!
				entitydata[k].x = ((rx*40)+39 - v.x - (v.data:len()-1))+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y)+(ry*30)
			elseif v.t == 19 then
				-- Script box.
				entitydata[k].x = ((rx*40)+39 - v.x - (v.p1-1))+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y - (v.p2-1))+(ry*30)
			elseif v.t == 11 or v.t == 50 then
				-- Gravity line or warp line
				entitydata[k].x = ((rx*40)+39 - v.x)+(rx*40)
				entitydata[k].y = ((ry*30)+29 - v.y)+(ry*30)

				if v.t == 50 then
					-- Same code as for enemy/moving platform directions, but it works here as well (<>^v now I think)
					if v.p1 == 0 or v.p1 == 2 then
						entitydata[k].p1 = v.p1+1
					else
						entitydata[k].p1 = v.p1-1
					end
				end
			else
				cons("Entity type " .. v.t .. " not handled when rotating the room!")
			end
		end
		if ((v.t == 13) and (v.p1 >= rx*40) and (v.p1 <= (rx*40)+39) and (v.p2 >= ry*30) and (v.p2 <= (ry*30)+29)) then
			-- Warp token exit here!
			entitydata[k].p1 = ((rx*40)+39 - v.p1 - 1)+(rx*40)
			entitydata[k].p2 = ((ry*30)+29 - v.p2 - 1)+(ry*30)
		end
	end

	-- If we have any gravity lines or warp lines, let the autocorrect do the job of fixing them!
	autocorrectlines()
	-- Same with tiles
	autocorrectroom()
end

function autocorrectlines()
	for k,v in pairs(entitydata) do
		if (v.p4 ~= 1) and (v.t == 11 or v.t == 50) and (v.x >= roomx*40) and (v.x <= (roomx*40)+39) and (v.y >= roomy*30) and (v.y <= (roomy*30)+29) then
			-- This is a gravity line in this room.
			if (v.t == 11 and v.p1 == 0) or (v.t == 50 and (v.p1 == 2 or v.p1 == 3)) then
				-- Horizontal
				local startat, linelength

				-- Backtrack to see what tile is solid
				for bt = (v.x%40), 0, -1 do
					if issolidforgravline(roomdata[roomy][roomx][((v.y%30)*40)+(bt)], v.t) then
						startat = bt
						break
					end
				end
				if startat == nil then
					startat = -1
				end

				-- Now to see how long it should be!
				for ft = startat+1, 40 do
					if issolidforgravline(roomdata[roomy][roomx][((v.y%30)*40)+(ft)], v.t) then
						linelength = 8 * (ft-startat) - 8
						break
					end
				end
				if linelength == nil then
					linelength = 8 * (42-startat) - 8
				end

				if entitydata[k].p2 ~= startat then
					entitydata[k].p2 = startat
				end if entitydata[k].p3 ~= linelength then
					entitydata[k].p3 = linelength
				end
			else
				-- Vertical
				local startat, linelength

				-- Backtrack to see what tile is solid
				for bt = (v.y%30), 0, -1 do
					--cons("Checking " .. (bt*40)+(atx+1) .. " " .. bt .. " " .. atx)
					if issolidforgravline(roomdata[roomy][roomx][(bt*40)+((v.x%40)+1)], v.t) then
						startat = bt+1
						break
					end
				end
				if startat == nil then
					startat = -1
				end

				-- Now to see how long it should be!
				for ft = startat+1, 29 do
					--cons("Checking2 " .. (ft*40)+(atx+1) .. " " .. ft .. " " .. atx)
					if issolidforgravline(roomdata[roomy][roomx][(ft*40)+((v.x%40)+1)], v.t) then
						linelength = 8 * (ft-startat)
						break
					end
				end
				if linelength == nil then
					linelength = 8 * (32-startat) - 8
				end

				if entitydata[k].p2 ~= startat then
					entitydata[k].p2 = startat
				end if entitydata[k].p3 ~= linelength then
					entitydata[k].p3 = linelength
				end
			end
		end
	end
end

function undo()
	if #undobuffer >= 1 then
		if undobuffer[#undobuffer].rx ~= nil and undobuffer[#undobuffer].ry ~= nil then
			gotoroom(undobuffer[#undobuffer].rx, undobuffer[#undobuffer].ry)
			map_resetroom(roomx, roomy)
		end
		if undobuffer[#undobuffer].switchtool ~= nil then
			selectedtool = undobuffer[#undobuffer].switchtool
			updatewindowicon()
		end

		if undobuffer[#undobuffer].undotype == "tiles" then
			if (undobuffer[#undobuffer].toundotiles[1] == nil) then
				temporaryroomname = L.UNDOFAULTY
				temporaryroomnametimer = 90
			else
				roomdata[roomy][roomx] = table.copy(undobuffer[#undobuffer].toundotiles)
				autocorrectlines()
			end
		elseif undobuffer[#undobuffer].undotype == "addentity" then
			-- So we need to remove this entity again!
			removeentity(undobuffer[#undobuffer].entid, nil, true)
		elseif undobuffer[#undobuffer].undotype == "removeentity" then
			-- Hmm... Re-add it in this case!
			entitydata[undobuffer[#undobuffer].entid] = undobuffer[#undobuffer].removedentitydata
			updatecountadd(undobuffer[#undobuffer].removedentitydata.t)
		elseif undobuffer[#undobuffer].undotype == "changeentity" then
			for k,v in pairs(undobuffer[#undobuffer].changedentitydata) do
				entitydata[undobuffer[#undobuffer].entid][v.key] = v.oldvalue
			end
		elseif undobuffer[#undobuffer].undotype == "metadata" then
			for k,v in pairs(undobuffer[#undobuffer].changedmetadata) do
				metadata[v.key] = v.oldvalue
			end
			temporaryroomname = L.METADATAUNDONE
			temporaryroomnametimer = 90
		elseif undobuffer[#undobuffer].undotype == "levelmetadata" then
			for k,v in pairs(undobuffer[#undobuffer].changedmetadata) do
				levelmetadata[roomy*20 + (roomx+1)][v.key] = v.oldvalue
			end
			if undobuffer[#undobuffer].changetiles then
				roomdata[roomy][roomx] = table.copy(undobuffer[#undobuffer].toundotiles)
				autocorrectlines()
				selectedtileset = levelmetadata[(roomy)*20 + (roomx+1)].tileset
				selectedcolor = levelmetadata[(roomy)*20 + (roomx+1)].tilecol
			end
		elseif undobuffer[#undobuffer].undotype == "rotateroom180" then
			rotateroom180(roomx, roomy, true)
		elseif undobuffer[#undobuffer].undotype == "paste" then
			setroomfromcopy(undobuffer[#undobuffer].olddata, undobuffer[#undobuffer].rx, undobuffer[#undobuffer].ry, true)
			temporaryroomnametimer = 0
		elseif undobuffer[#undobuffer].undotype == "mapswap" then
			mapswap(
				undobuffer[#undobuffer].rx,
				undobuffer[#undobuffer].ry,
				undobuffer[#undobuffer].rx_src,
				undobuffer[#undobuffer].ry_src,
				true
			)
		elseif undobuffer[#undobuffer].undotype == "mapcopy" then
			-- Remove the copied entities again
			local removedentityids = {}
			local nrx, nry = undobuffer[#undobuffer].rx, undobuffer[#undobuffer].ry

			for k,v in pairs(entitydata) do
				if ((v.x >= nrx*40) and (v.x <= (nrx*40)+39) and (v.y >= nry*30) and (v.y <= (nry*30)+29)) then
					table.insert(removedentityids, k)
				end
			end

			for _,v in pairs(removedentityids) do
				removeentity(v, nil, true)
			end

			setroomfromcopy(undobuffer[#undobuffer].olddata, nrx, nry, true)
			temporaryroomnametimer = 0
			for k,v in pairs(undobuffer[#undobuffer].oldentities) do
				entitydata[v[1]] = table.copy(v[2])
				updatecountadd(v[2].t)
			end
		else
			temporaryroomname = langkeys(L.UNKNOWNUNDOTYPE, {undobuffer[#undobuffer].undotype})
			temporaryroomnametimer = 90
		end

		table.insert(redobuffer, table.copy(undobuffer[#undobuffer]))
		table.remove(undobuffer, #undobuffer)

		mapmovedroom = true
	end
end
-- TODO: Merge these two?
function redo()
	if #redobuffer >= 1 then
		if redobuffer[#redobuffer].rx ~= nil and redobuffer[#redobuffer].ry ~= nil then
			gotoroom(redobuffer[#redobuffer].rx, redobuffer[#redobuffer].ry)
			map_resetroom(roomx, roomy)
		end
		if redobuffer[#redobuffer].switchtool ~= nil then
			selectedtool = redobuffer[#redobuffer].switchtool
			updatewindowicon()
		end

		if redobuffer[#redobuffer].undotype == "tiles" then
			if (redobuffer[#redobuffer].toredotiles[1] == nil) then
				temporaryroomname = L.UNDOFAULTY
				temporaryroomnametimer = 90
			else
				roomdata[roomy][roomx] = table.copy(redobuffer[#redobuffer].toredotiles)
				autocorrectlines()
			end
		elseif redobuffer[#redobuffer].undotype == "addentity" then
			-- Re-add it again
			entitydata[redobuffer[#redobuffer].entid] = redobuffer[#redobuffer].addedentitydata
			updatecountadd(redobuffer[#redobuffer].addedentitydata.t)
		elseif redobuffer[#redobuffer].undotype == "removeentity" then
			-- Redo the removing!
			removeentity(redobuffer[#redobuffer].entid, nil, true)
		elseif redobuffer[#redobuffer].undotype == "changeentity" then
			for k,v in pairs(redobuffer[#redobuffer].changedentitydata) do
				entitydata[redobuffer[#redobuffer].entid][v.key] = v.newvalue
			end
		elseif redobuffer[#redobuffer].undotype == "metadata" then
			for k,v in pairs(redobuffer[#redobuffer].changedmetadata) do
				metadata[v.key] = v.newvalue
			end
			temporaryroomname = L.METADATAREDONE
			temporaryroomnametimer = 90
		elseif redobuffer[#redobuffer].undotype == "levelmetadata" then
			for k,v in pairs(redobuffer[#redobuffer].changedmetadata) do
				levelmetadata[roomy*20 + (roomx+1)][v.key] = v.newvalue
			end
			if redobuffer[#redobuffer].changetiles then
				selectedtileset = levelmetadata[(roomy)*20 + (roomx+1)].tileset
				selectedcolor = levelmetadata[(roomy)*20 + (roomx+1)].tilecol
				autocorrectroom()
			end
		elseif redobuffer[#redobuffer].undotype == "rotateroom180" then
			rotateroom180(roomx, roomy, true)
		elseif redobuffer[#redobuffer].undotype == "paste" then
			setroomfromcopy(redobuffer[#redobuffer].newdata, redobuffer[#redobuffer].rx, redobuffer[#redobuffer].ry, true)
			temporaryroomnametimer = 0
		elseif redobuffer[#redobuffer].undotype == "mapswap" then
			mapswap(
				redobuffer[#redobuffer].rx,
				redobuffer[#redobuffer].ry,
				redobuffer[#redobuffer].rx_src,
				redobuffer[#redobuffer].ry_src,
				true
			)
		elseif redobuffer[#redobuffer].undotype == "mapcopy" then
			mapcopy(
				redobuffer[#redobuffer].rx_src,
				redobuffer[#redobuffer].ry_src,
				redobuffer[#redobuffer].rx,
				redobuffer[#redobuffer].ry,
				true
			)
		else
			temporaryroomname = langkeys(L.UNKNOWNUNDOTYPE, {redobuffer[#redobuffer].undotype})
			temporaryroomnametimer = 90
		end

		table.insert(undobuffer, table.copy(redobuffer[#redobuffer]))
		table.remove(redobuffer, #redobuffer)

		mapmovedroom = true
	end
end	

function entityplaced(id)
	if id == nil then
		id = count.entity_ai
	end

	table.insert(undobuffer, {undotype = "addentity", rx = roomx, ry = roomy, entid = id, addedentitydata = table.copy(entitydata[id])})
	finish_undo("ADDED ENTITY")
end

function removeentity(id, thetype, undoing)
	if id == nil then
		cons("###\nremoveentity: trying to remove nil entity ID: " .. id .. "!\n###")
		return
	elseif entitydata[id] == nil then
		cons("###\nremoveentity: trying to remove nil entity: entitydata[" .. id .. "]!\n###")
		return
	end

	if thetype == nil then
		thetype = entitydata[id].t
	end

	updatecountdelete(thetype, id, undoing)
	entitydata[id] = nil
end

function setcopyingentity(id)
	table.insert(entitydata, count.entity_ai, table.copy(entitydata[id]))
	if entitydata[count.entity_ai].t == 9 then
		count.trinkets = count.trinkets + 1
	elseif entitydata[count.entity_ai].t == 15 then
		count.crewmates = count.crewmates + 1
	end
	count.entities = count.entities + 1

	movingentity = count.entity_ai
	movingentity_copying = true
	count.entity_ai = count.entity_ai + 1
end

function rcm_changingentity(entdetails, changes)
	-- changes is a table containing keys and new values
	local changeddata = {}
	for k,v in pairs(changes) do
		table.insert(changeddata, {
				key = k,
				oldvalue = entitydata[tonumber(entdetails[3])][k],
				newvalue = v
			}
		)
	end

	table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = tonumber(entdetails[3]), changedentitydata = changeddata})
	finish_undo("CHANGED ENTITY")
end

function finish_undo(description)
	redobuffer = {}
	cons("[UNRE] " .. description)

	if saved_at_undo >= #undobuffer then
		-- We just lost the state at which we saved, so we can't undo/redo back to that!
		unsavedchanges = true
	end

	-- Also remove the current room from the map, as it was probably changed. Unless it wasn't, but no biggie.
	map_resetroom(roomx, roomy)
end

function cutroom()
	love.system.setClipboardText(getroomcopydata(roomx, roomy))

	-- That's only a copy, now reset the room except for the tileset/col
	setroomfromcopy(levelmetadata[roomy*20 + (roomx+1)].tileset .. "," .. levelmetadata[roomy*20 + (roomx+1)].tilecol .. ",0,0,320,240,4,0,0,320,240,0,0,0," .. (",0"):rep(1200), roomx, roomy)

	temporaryroomname = L.ROOMCUT
	temporaryroomnametimer = 90

	mapmovedroom = true
end

function copyroom()
	love.system.setClipboardText(getroomcopydata(roomx, roomy))

	temporaryroomname = L.ROOMCOPIED
	temporaryroomnametimer = 90

	mapmovedroom = true
end

function pasteroom()
	setroomfromcopy(love.system.getClipboardText(), roomx, roomy)

	mapmovedroom = true

	if takinginput then
		-- If we're taking input now, then it's gonna be particularly annoying if we paste an entire room in it!!
		cons("TAKING INPUT WHILE PASTING A ROOM")
		stopinput()
	end
end

function gotoroom(rx, ry)
	roomx = rx
	roomy = ry
	gotoroom_finish()
end

function gotoroom_finish()
	selectedtileset = levelmetadata[(roomy)*20 + (roomx+1)].tileset
	selectedcolor = levelmetadata[(roomy)*20 + (roomx+1)].tilecol
end

function shiftrooms(direction, updatescripts)
	dirty()

	-- Copy the rooms that are on the edge
	local edgeroomdata, edgelevelmetadata, edgemapdata, edgetrinketsdata, edgecrewmatesdata = {}, {}, {}, {}, {}
	if direction == SHIFT.LEFT then
		for y = 0, metadata.mapheight-1 do
			edgeroomdata[y] = table.copy(roomdata[y][0])
			edgelevelmetadata[y] = table.copy(levelmetadata[y*20 + 1])
			edgemapdata[y] = table.copy(rooms_map[y][0])
			edgetrinketsdata[y] = map_trinkets[y][0]
			edgecrewmatesdata[y] = table.copy(map_crewmates[y][0])
		end
	elseif direction == SHIFT.RIGHT then
		for y = 0, metadata.mapheight-1 do
			edgeroomdata[y] = table.copy(roomdata[y][metadata.mapwidth-1])
			edgelevelmetadata[y] = table.copy(levelmetadata[y*20 + metadata.mapwidth])
			edgemapdata[y] = table.copy(rooms_map[y][metadata.mapwidth-1])
			edgetrinketsdata[y] = map_trinkets[y][0]
			edgecrewmatesdata[y] = table.copy(map_crewmates[y][0])
		end
	elseif direction == SHIFT.UP then
		for x = 0, metadata.mapwidth-1 do
			edgeroomdata[x] = table.copy(roomdata[0][x])
			edgelevelmetadata[x] = table.copy(levelmetadata[x+1])
			edgemapdata[x] = table.copy(rooms_map[0][x])
			edgetrinketsdata[x] = map_trinkets[0][x]
			edgecrewmatesdata[x] = table.copy(map_crewmates[0][x])
		end
	elseif direction == SHIFT.DOWN then
		for x = 0, metadata.mapwidth-1 do
			edgeroomdata[x] = table.copy(roomdata[metadata.mapheight-1][x])
			edgelevelmetadata[x] = table.copy(levelmetadata[(metadata.mapheight-1)*20 + x+1])
			edgemapdata[x] = table.copy(rooms_map[metadata.mapheight-1][x])
			edgetrinketsdata[x] = map_trinkets[metadata.mapheight-1][x]
			edgecrewmatesdata[x] = table.copy(map_crewmates[metadata.mapheight-1][x])
		end
	end

	-- Room tiles and room properties, and the map image
	-- Reverse the direction of updates as necessary, otherwise we'll trip over ourselves
	-- and smear the row/column with the exact same room
	if direction == SHIFT.LEFT then
		for y = 0, metadata.mapheight-1 do
			for x = 0, metadata.mapwidth-2 do
				roomdata[y][x] = table.copy(roomdata[y][x+1])
				levelmetadata[y*20 + x+1] = table.copy(levelmetadata[y*20 + x+2])
				rooms_map[y][x] = table.copy(rooms_map[y][x+1])
				map_trinkets[y][x] = map_trinkets[y][x+1]
				map_crewmates[y][x] = table.copy(map_crewmates[y][x+1])
			end
		end
		for y = 0, metadata.mapheight-1 do
			roomdata[y][metadata.mapwidth-1] = table.copy(edgeroomdata[y])
			levelmetadata[y*20 + metadata.mapwidth] = table.copy(edgelevelmetadata[y])
			rooms_map[y][metadata.mapwidth-1] = table.copy(edgemapdata[y])
			map_trinkets[y][metadata.mapwidth-1] = edgetrinketsdata[y]
			map_crewmates[y][metadata.mapwidth-1] = table.copy(edgecrewmatesdata[y])
		end
	elseif direction == SHIFT.RIGHT then
		for y = 0, metadata.mapheight-1 do
			for x = metadata.mapwidth-1, 1, -1 do
				roomdata[y][x] = table.copy(roomdata[y][x-1])
				levelmetadata[y*20 + x+1] = table.copy(levelmetadata[y*20 + x])
				rooms_map[y][x] = table.copy(rooms_map[y][x-1])
				map_trinkets[y][x] = map_trinkets[y][x-1]
				map_crewmates[y][x] = table.copy(map_crewmates[y][x-1])
			end
		end
		for y = 0, metadata.mapheight-1 do
			roomdata[y][0] = table.copy(edgeroomdata[y])
			levelmetadata[y*20 + 1] = table.copy(edgelevelmetadata[y])
			rooms_map[y][0] = table.copy(edgemapdata[y])
			map_trinkets[y][0] = edgetrinketsdata[y]
			map_crewmates[y][0] = table.copy(edgecrewmatesdata[y])
		end
	elseif direction == SHIFT.UP then
		for y = 0, metadata.mapheight-2 do
			for x = 0, metadata.mapwidth-1 do
				roomdata[y][x] = table.copy(roomdata[y+1][x])
				levelmetadata[y*20 + x+1] = table.copy(levelmetadata[(y+1)*20 + x+1])
				rooms_map[y][x] = table.copy(rooms_map[y+1][x])
				map_trinkets[y][x] = map_trinkets[y+1][x]
				map_crewmates[y][x] = table.copy(map_crewmates[y+1][x])
			end
		end
		for x = 0, metadata.mapwidth-1 do
			roomdata[metadata.mapheight-1][x] = table.copy(edgeroomdata[x])
			levelmetadata[(metadata.mapheight-1)*20 + x+1] = table.copy(edgelevelmetadata[x])
			rooms_map[metadata.mapheight-1][x] = table.copy(edgemapdata[x])
			map_trinkets[metadata.mapheight-1][x] = edgetrinketsdata[x]
			map_crewmates[metadata.mapheight-1][x] = table.copy(edgecrewmatesdata[x])
		end
	elseif direction == SHIFT.DOWN then
		for y = metadata.mapheight-1, 1, -1 do
			for x = 0, metadata.mapwidth-1 do
				roomdata[y][x] = table.copy(roomdata[y-1][x])
				levelmetadata[y*20 + x+1] = table.copy(levelmetadata[(y-1)*20 + x+1])
				rooms_map[y][x] = table.copy(rooms_map[y-1][x])
				map_trinkets[y][x] = map_trinkets[y-1][x]
				map_crewmates[y][x] = table.copy(map_crewmates[y-1][x])
			end
		end
		for x = 0, metadata.mapwidth-1 do
			roomdata[0][x] = table.copy(edgeroomdata[x])
			levelmetadata[x+1] = table.copy(edgelevelmetadata[x])
			rooms_map[0][x] = table.copy(edgemapdata[x])
			map_trinkets[0][x] = edgetrinketsdata[x]
			map_crewmates[0][x] = table.copy(edgecrewmatesdata[x])
		end
	end

	-- Entities, making sure to take care of warp token destinations as well
	local newx, newy, newp1, newp2
	for idx, ent in pairs(entitydata) do
		if ent.x < 0 or ent.y < 0 or ent.x >= 40*metadata.mapwidth or ent.y >= 30*metadata.mapheight then
		elseif direction == SHIFT.LEFT then
			newx = ent.x - 40
			if newx < 0 then
				newx = newx + 40*metadata.mapwidth
			end
			entitydata[idx].x = newx
			if ent.t == 13 then
				newp1 = ent.p1 - 40
				if newp1 < 0 then
					newp1 = newp1 + 40*metadata.mapwidth
				end
				entitydata[idx].p1 = newp1
			end
		elseif direction == SHIFT.RIGHT then
			newx = ent.x + 40
			if newx >= 40*metadata.mapwidth then
				newx = newx - 40*metadata.mapwidth
			end
			entitydata[idx].x = newx
			if ent.t == 13 then
				newp1 = ent.p1 + 40
				if newp1 >= 40*metadata.mapwidth then
					newp1 = newp1 - 40*metadata.mapwidth
				end
				entitydata[idx].p1 = newp1
			end
		elseif direction == SHIFT.UP then
			newy = ent.y - 30
			if newy < 0 then
				newy = newy + 30*metadata.mapheight
			end
			entitydata[idx].y = newy
			if ent.t == 13 then
				newp2 = ent.p2 - 30
				if newp2 < 0 then
					newp2 = newp2 + 30*metadata.mapheight
				end
				entitydata[idx].p2 = newp2
			end
		elseif direction == SHIFT.DOWN then
			newy = ent.y + 30
			if newy >= 30*metadata.mapheight then
				newy = newy - 30*metadata.mapheight
			end
			entitydata[idx].y = newy
			if ent.t == 13 then
				newp2 = ent.p2 + 30
				if newp2 >= 30*metadata.mapheight then
					newp2 = newp2 - 30*metadata.mapheight
				end
				entitydata[idx].p2 = newp2
			end
		end
	end

	-- Change the current room
	local rx, ry = roomx, roomy
	if direction == SHIFT.LEFT then
		rx = rx - 1
	elseif direction == SHIFT.RIGHT then
		rx = rx + 1
	elseif direction == SHIFT.UP then
		ry = ry - 1
	elseif direction == SHIFT.DOWN then
		ry = ry + 1
	end
	rx = rx % metadata.mapwidth
	ry = ry % metadata.mapheight
	gotoroom(rx, ry)

	-- Scripts
	if not updatescripts then
		return
	end
	local field2_3cmdswrap = {"gotoroom"}
	local field2_3cmdsnowrap = {"ifexplored", "showcoordinates", "hidecoordinates"}
	local transform = {}
	transform[1] = (function(x, y, direction)
		x, y = tonumber(x), tonumber(y)
		if x ~= nil and y ~= nil then
			local x_outofbounds = x < 0 or x >= metadata.mapwidth
			local y_outofbounds = y < 0 or y >= metadata.mapwidth
			if direction == SHIFT.LEFT then
				x = x - 1
				if x < 0 and not x_outofbounds and not y_outofbounds then
					x = x + metadata.mapwidth
				elseif x_outofbounds and x < metadata.mapwidth and not y_outofbounds then
					x = x - metadata.mapwidth
				end
			elseif direction == SHIFT.RIGHT then
				x = x + 1
				if x >= metadata.mapwidth and not x_outofbounds and not y_outofbounds then
					x = x - metadata.mapwidth
				elseif x_outofbounds and x >= 0 and not y_outofbounds then
					x = x + metadata.mapwidth
				end
			elseif direction == SHIFT.UP then
				y = y - 1
				if y < 0 and not y_outofbounds and not x_outofbounds then
					y = y + metadata.mapheight
				elseif y_outofbounds and y < metadata.mapheight and not x_outofbounds then
					y = y - metadata.mapheight
				end
			elseif direction == SHIFT.DOWN then
				y = y + 1
				if y >= metadata.mapheight and not x_outofbounds and not y_outofbounds then
					y = y - metadata.mapheight
				elseif y_outofbounds and y >= 0 and not x_outofbounds then
					y = y + metadata.mapheight
				end
			end
		end
		return x, y
	end)
	transform[2] = (function(x, y, direction)
		x, y = tonumber(x), tonumber(y)
		if x ~= nil and y ~= nil then
			local x_outofbounds = x < 0 or x >= metadata.mapwidth
			local y_outofbounds = y < 0 or y >= metadata.mapheight
			if not x_outofbounds and not y_outofbounds then
				if direction == SHIFT.LEFT then
					x = x - 1
				elseif direction == SHIFT.RIGHT then
					x = x + 1
				elseif direction == SHIFT.UP then
					y = y - 1
				elseif direction == SHIFT.DOWN then
					y = y + 1
				end
				x = x % metadata.mapwidth
				y = y % metadata.mapheight
			end
		end
		return x, y
	end)
	local tmp
	for rvnum = #scriptnames, 1, -1 do
		for k,v in pairs(scripts[scriptnames[rvnum]]) do
			v = v:gsub(" ", "")
			for _,command in pairs(field2_3cmdswrap) do
				if #v > #command then
					local pattern = "^(" .. command .. "[%(,%)]0*)([0-9]+)([%(,%)]0*)([0-9]+)"
					tmp = updateroomline(v, pattern, transform[1], direction)
					if tmp ~= nil then
						scripts[scriptnames[rvnum]][k] = tmp
					end
				end
			end
			for _, command in pairs(field2_3cmdsnowrap) do
				if #v > #command then
					local pattern = "^(" .. command .. "[%(,%)]0*)([0-9]+)([%(,%)]0*)([0-9]+)"
					tmp = updateroomline(v, pattern, transform[2], direction)
					if tmp ~= nil then
						scripts[scriptnames[rvnum]][k] = tmp
					end
				end
			end
		end
	end
end

function setrescuablecolor(color)
	if color == 0 then
		-- Cyan
		v6_setcol(0)
	elseif color == 1 then
		-- Pink
		v6_setcol(20)
	elseif color == 2 then
		-- Yellow
		v6_setcol(14)
	elseif color == 3 then
		-- Red
		v6_setcol(15)
	elseif color == 4 then
		-- Green
		v6_setcol(13)
	elseif color == 5 then
		-- Blue
		v6_setcol(16)
	else
		-- Cyan, but happy
		v6_setcol(0)
	end
end

function getrescuablesprite(color)
	if color >= 0 and color <= 5 then
		return 144
	else
		return 0
	end
end

function islineon24x18(coord) -- Global because used in both displayroom()'s displayminimapgrid and displayminimaproom()
	return table.contains({0, 1, 3, 4, 6}, coord % 8)
end

function displayminimaproom(offsetx, offsety, theroomdata, themetadata, zoomscale2, atx, aty)
	-- Doesn't display the black behind it

	zoomscale2 = zoomscale2 or 1

	local actualtileset = themetadata.tileset
	local ts = usedtilesets[actualtileset]
	local zoom = getminimapzoom(metadata)

	local function setcolor()
		if actualtileset == 1 then -- Outside tileset
			love.graphics.setColor(96, 96, 96)
		else
			love.graphics.setColor(196, 196, 196)
		end
	end

	local function draw_pixel(actualx, actualy)
		love.graphics.rectangle("fill", offsetx + zoomscale2*actualx, offsety + zoomscale2*actualy, zoomscale2, zoomscale2)
	end

	local function do_pixel(t, tilex, tiley, actualx, actualy)
		if tilex == atx and tiley == aty then
			if issolid(t, ts, nil, true) then
				love.graphics.setColor(192, 255, 192)
			else
				love.graphics.setColor(127, 192, 127)
			end
			draw_pixel(actualx, actualy)
			setcolor()
		elseif issolid(t, ts, nil, true) then
			draw_pixel(actualx, actualy)
		end
	end


	setcolor()

	if zoom == 1 then -- 12x9
		-- Easiest to do
		local t
		local actualx, actualy = 0, 0
		for tiley = 0, 24, 3 do
			for tilex = 3, 36, 3 do
				t = theroomdata[(tiley*40)+(tilex+1)]
				do_pixel(t, tilex, tiley, actualx, actualy)
				actualx = actualx + 1
			end
			actualx = 0
			actualy = actualy + 1
		end
	elseif zoom == 2 then -- 24x18
		-- A bit harder
		local t
		local actualx, actualy = 0, 0
		for tiley = 0, 27 do
			if islineon24x18(tiley) then
				for tilex = 0, 36 do
					t = theroomdata[(tiley*40)+(tilex+1)]
					if islineon24x18(tilex) then
						do_pixel(t, tilex, tiley, actualx, actualy)
						actualx = actualx + 1
					end
				end
				actualy = actualy + 1
			end
			actualx = 0
		end
	elseif zoom == 4 then -- 48x36
		-- At this point the minimap pixels are larger than 40x30,
		-- meaning the minimap image is actually stretched and distorted
		local t
		local actualx, actualy = 0, 0
		local function islinedoubled(coord, axis)
			assert(axis == "x" or axis == "y", "axis has to be the string 'x' or 'y'")
			local lastcoord
			if axis == "x" then
				lastcoord = 39
			elseif axis == "y" then
				lastcoord = 29
			end
			return (coord % 5 == 4 or coord == 0) and coord ~= lastcoord
		end
		local function do_row(tiley, actualy)
			for tilex = 0, 39 do
				t = theroomdata[(tiley*40)+(tilex+1)]
				do_pixel(t, tilex, tiley, actualx, actualy)
				actualx = actualx + 1
				if islinedoubled(tilex, "x") then
					do_pixel(t, tilex, tiley, actualx, actualy)
					actualx = actualx + 1
				end
			end
		end
		for tiley = 0, 29 do
			do_row(tiley, actualy)
			actualx = 0
			actualy = actualy + 1
			if islinedoubled(tiley, "y") then
				do_row(tiley, actualy)
				actualx = 0
				actualy = actualy + 1
			end
		end
	end
end
