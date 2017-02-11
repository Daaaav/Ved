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

function displayroom(offsetx, offsety, theroomdata, themetadata, zoomscale2, displaytilenumbers)
	if zoomscale2 == nil then zoomscale2 = 1 end
	-- This assumes the room is already loaded in roomdata. It just displays a room, without the entities. Also include scale for zooming out.
	for aty = 0, 29 do
		for atx = 0, 39 do
			-- Display roomdata[(aty*40)+(atx+1)]
			--cons("Will display: (aty*40)+(atx+1) in other words " .. (aty*40)+(atx+1) .. " (at " .. atx .. " " .. aty .. ")")
			if theroomdata[(aty*40)+(atx+1)] ~= 0 then
				love.graphics.draw(tilesets[tilesetnames[usedtilesets[themetadata.tileset]]]["img"], tilesets[tilesetnames[usedtilesets[themetadata.tileset]]]["tiles"][tonumber(theroomdata[(aty*40)+(atx+1)])], offsetx+(16*atx*zoomscale2), offsety+(16*aty*zoomscale2), 0, 2*zoomscale2)
			end
			
			if displaytilenumbers then
				love.graphics.print(theroomdata[(aty*40)+(atx+1)], offsetx+(16*atx*zoomscale2), offsety+(16*aty*zoomscale2))
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
			end
		end
	end
end

function displayentities(offsetx, offsety, myroomx, myroomy)
	-- This assumes the entities for this room are already loaded in entitydata. It just displays all entities.
	if allowdebug then
		showtooltip = true
	else
		showtooltip = false
	end
	
	showtooltipof = nil
	
	for k,v in pairs(entitydata) do
		if ((v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29)) or ((v.t == 13) and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29)) then
			-- First of all, we can remove an entity by shift-right clicking
			if keyboard_eitherIsDown("shift") and love.mouse.isDown("r") and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16) then
				removeentity(k, entitydata[k].t)
			else
				-- What kind of entity is this?
				if allowdebug and love.keyboard.isDown("/") then
					love.graphics.draw(cursorimg[5], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
				elseif v.t == 1 then
					-- Enemy
					love.graphics.setColor(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].entcolor)
					drawentity(enemysprites[levelmetadata[(myroomy)*20 + (myroomx+1)].enemytype], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16) -- 78
					
					-- Where is it going?
					love.graphics.setColor(255,255,255,255)
					love.graphics.setFont(font16)
					love.graphics.print(anythingbutnil(({"V", "^", "<", ">"})[v.p1+1]), offsetx+(v.x-myroomx*40)*16  + 8, offsety+(v.y-myroomy*30)*16 + 3  + 8)
					love.graphics.setFont(font8)
					
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[9], L.DELETE, L.CHANGEDIRECTION, L.PROPERTIES}, "ent_1_" .. k)
				elseif v.t == 2 then
					-- Platform, it's either a moving one or a conveyor!
					love.graphics.setColor(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].entcolor)
					love.graphics.draw(platformimg, platformpart[1], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 0, 2)
					love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 16, offsety+(v.y-myroomy*30)*16, 0, 2)
					love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 32, offsety+(v.y-myroomy*30)*16, 0, 2)
					if v.p1 < 7 then
						-- 4 tiles
						love.graphics.draw(platformimg, platformpart[3], offsetx+(v.x-myroomx*40)*16 + 48, offsety+(v.y-myroomy*30)*16, 0, 2)
					else
						-- 8 tiles
						love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 48, offsety+(v.y-myroomy*30)*16, 0, 2)
						love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 64, offsety+(v.y-myroomy*30)*16, 0, 2)
						love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 80, offsety+(v.y-myroomy*30)*16, 0, 2)
						love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 96, offsety+(v.y-myroomy*30)*16, 0, 2)
						love.graphics.draw(platformimg, platformpart[3], offsetx+(v.x-myroomx*40)*16 + 112, offsety+(v.y-myroomy*30)*16, 0, 2)
					end
					
					-- Now indicate what this actually is.
					love.graphics.setColor(255,255,255,255)
					love.graphics.setFont(font16)
					if v.p1 == 0 then
						-- Moving down
						love.graphics.print(" VV", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 1 then
						-- Moving up
						love.graphics.print(" ^^", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 2 then
						-- Moving left
						love.graphics.print(" <", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 3 then
						-- Moving right
						love.graphics.print("  >", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 5 then
						-- Conveyor right
						love.graphics.print(">>>>", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 6 then
						-- Conveyor left
						love.graphics.print("<<<<", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 7 then
						-- Long conveyor right
						love.graphics.print(">>>>>>>>", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					elseif v.p1 == 8 then
						-- Long conveyor left
						love.graphics.print("<<<<<<<<", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					else
						-- What
						love.graphics.print("...?", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					end
					love.graphics.setFont(font8)
					
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. (v.p1 < 4 and toolnames[8] or toolnames[7]), L.DELETE, L.CYCLETYPE, L.PROPERTIES}, "ent_2_" .. k)
				elseif v.t == 3 then
					-- Disappearing platform
					love.graphics.setColor(tilesetblocks[levelmetadata[(myroomy)*20 + (myroomx+1)].tileset].colors[levelmetadata[(myroomy)*20 + (myroomx+1)].tilecol].entcolor)
					love.graphics.draw(platformimg, platformpart[1], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 0, 2)
					love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 16, offsety+(v.y-myroomy*30)*16, 0, 2)
					love.graphics.draw(platformimg, platformpart[2], offsetx+(v.x-myroomx*40)*16 + 32, offsety+(v.y-myroomy*30)*16, 0, 2)
					love.graphics.draw(platformimg, platformpart[3], offsetx+(v.x-myroomx*40)*16 + 48, offsety+(v.y-myroomy*30)*16, 0, 2)
					-- This is a disappearing platform.
					love.graphics.setColor(255,255,255,255)
					love.graphics.setFont(font16)
					love.graphics.print("////", offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					love.graphics.setFont(font8)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[6], L.DELETE, L.PROPERTIES}, "ent_3_" .. k)
				elseif v.t == 9 then
					-- Trinket
					drawentity(22, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[4], L.DELETE, L.PROPERTIES}, "ent_9_" .. k)
				elseif v.t == 10 then
					-- Checkpoint. p1=0 is upside down, p1=1 is upright. Yes, VVVVVV works this way:
					drawentity(20+v.p1, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[5], L.DELETE, L.FLIP, L.PROPERTIES}, "ent_10_" .. k)
				elseif v.t == 11 then
					-- Gravity line. This is kind of a special story.
					if v.p1 == 0 then
						-- Horizontal
						love.graphics.line(offsetx+(v.p2)*16 + 1, offsety+(v.y-myroomy*30)*16 + 8, offsetx+(v.p2)*16 + v.p3*2 - 1, offsety+(v.y-myroomy*30)*16 + 8)
					else
						-- Vertical
						love.graphics.line(offsetx+(v.x-myroomx*40)*16 + 8, offsety+(v.p2)*16 + 1, offsetx+(v.x-myroomx*40)*16 + 8, offsety+(v.p2)*16 + v.p3*2 - 1)
					end
					
					-- Where is it, though?
					love.graphics.draw(cursorimg[0], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[10], L.DELETE, (v.p1 == 0 and L.CHANGETOVER or L.CHANGETOHOR), L.PROPERTIES}, "ent_11_" .. k)
				elseif v.t == 13 then
					-- Warp token. But are we currently displaying the entrance or the destination? Or both?
					if (v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29) then
						-- Entrance
						drawentity(18, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
						entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[14], L.DELETE, L.GOTODESTINATION, L.CHANGEENTRANCE, L.CHANGEEXIT, L.PROPERTIES}, "ent_13_" .. k)
					end
					-- warpid = what warp token destination we're placing.
					if (warpid ~= k or selectedsubtool[14] >= 3) and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29) then
						-- Destination
						love.graphics.setColor(255,255,255,64)
						drawentity(18, offsetx+(v.p1-myroomx*40)*16, offsety+(v.p2-myroomy*30)*16)
						love.graphics.setColor(255,255,255,255)
						entityrightclick(offsetx+(v.p1-myroomx*40)*16, offsety+(v.p2-myroomy*30)*16, {"#" .. toolnames[14], L.DELETE, L.GOTOENTRANCE, L.CHANGEENTRANCE, L.CHANGEEXIT, L.PROPERTIES}, "ent_13_" .. k)
					end
				elseif v.t == 15 then
					-- Rescuable crewmate
					if v.p1 == 0 then
						-- Cyan
						--love.graphics.setColor(95, 154, 140)
						love.graphics.setColor(132, 181, 255)
					elseif v.p1 == 1 then
						-- Pink
						love.graphics.setColor(255, 135, 255)
					elseif v.p1 == 2 then
						-- Yellow
						love.graphics.setColor(255, 255, 135)
					elseif v.p1 == 3 then
						-- Red
						love.graphics.setColor(255, 61, 61)
					elseif v.p1 == 4 then
						-- Green
						love.graphics.setColor(144, 255, 144)
					elseif v.p1 == 5 then
						-- Blue
						love.graphics.setColor(75, 75, 230)
					else
						-- What?
						love.graphics.setColor(love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255))
					end
					drawentity(144, offsetx+(v.x-myroomx*40)*16 - 8, offsety+(v.y-myroomy*30)*16 + 2)
					love.graphics.setColor(255, 255, 255)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[16], L.DELETE, L.CHANGECOLOR, L.PROPERTIES}, "ent_15_" .. k)
				elseif v.t == 16 then
					-- Start point
					love.graphics.setColor(132, 181, 255)
					drawentity(3*v.p1, offsetx+(v.x-myroomx*40)*16 - 8, offsety+(v.y-myroomy*30)*16 + 2)
					love.graphics.setColor(255, 255, 255)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[17], L.DELETE, L.CHANGEDIRECTION, L.PROPERTIES}, "ent_16_" .. k)
				elseif v.t == 17 then
					-- Roomtext
					love.graphics.setFont(font16)
					if editingroomtext == k then
						-- We're editing this text at the moment.
						love.graphics.print(input .. __, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					else
						love.graphics.print(v.data, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 3)
					end
					love.graphics.setFont(font8)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[11], L.DELETE, L.EDITTEXT, L.COPYTEXT, L.PROPERTIES}, "ent_17_" .. k)
				elseif v.t == 18 then
					-- Terminal
					if math.abs(sp_t) == k then
						sp_teken(v, offsetx, offsety, myroomx, myroomy)
					end
					drawentity(17, offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + 16)
					-- Maybe we should also display the script name!
					displayscriptname(false, k, v, offsetx, offsety, myroomx, myroomy)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {(namefound(v) ~= 0 and "" or "#") .. toolnames[12], L.DELETE, L.EDITSCRIPT, L.OTHERSCRIPT, L.PROPERTIES}, "ent_18_" .. k)
				elseif v.t == 19 then
					-- Script box, draw it as an actual box.
					--love.graphics.draw(cursorimg[1], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					love.graphics.draw(scriptboximg[1], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					if editingsboxid == k and selectedsubtool[13] ~= 3 then
						-- Currently placing
						love.graphics.draw(scriptboximg[3], math.max(math.floor(love.mouse.getX()/16)*16, offsetx+(v.x-myroomx*40)*16), (v.y-myroomy*30)*16)
						love.graphics.draw(scriptboximg[7], offsetx+(v.x-myroomx*40)*16, math.max(math.floor(love.mouse.getY()/16)*16, (v.y-myroomy*30)*16))
						love.graphics.draw(scriptboximg[9], math.max(math.floor(love.mouse.getX()/16)*16, offsetx+(v.x-myroomx*40)*16), math.max(math.floor(love.mouse.getY()/16)*16, (v.y-myroomy*30)*16))
						
						-- Horizontal
						
						for prt = offsetx+(v.x-myroomx*40)*16 + 16, math.max(math.floor(love.mouse.getX()/16)*16), 16 do
							love.graphics.draw(scriptboximg[2], prt, offsety+(v.y-myroomy*30)*16)
							love.graphics.draw(scriptboximg[8], prt, math.max(math.floor((love.mouse.getY()/16))*16, offsety+(v.y-myroomy*30)*16))
						end
						
						-- Vertical
						for prt = offsety+(v.y-myroomy*30)*16 + 16, math.max(math.floor(love.mouse.getY()/16)*16, offsety+(v.y-myroomy*30)*16) - 16, 16 do
							love.graphics.draw(scriptboximg[4], offsetx+(v.x-myroomx*40)*16, prt)
							love.graphics.draw(scriptboximg[6], math.max(math.floor(love.mouse.getX()/16)*16, offsetx+(v.x-myroomx*40)*16), prt)
						end
					else
						-- Normal box
						--[[
						love.graphics.draw(cursorimg[2], offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16, offsety+(v.y-myroomy*30)*16)
						love.graphics.draw(cursorimg[3], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16)
						love.graphics.draw(cursorimg[4], offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16)
						]]
						love.graphics.draw(scriptboximg[3], offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16, offsety+(v.y-myroomy*30)*16)
						love.graphics.draw(scriptboximg[7], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16)
						love.graphics.draw(scriptboximg[9], offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16)
						
						-- Horizontal
						for prt = offsetx+(v.x-myroomx*40)*16 + 16, offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16 - 16, 16 do
							love.graphics.draw(scriptboximg[2], prt, offsety+(v.y-myroomy*30)*16)
							love.graphics.draw(scriptboximg[8], prt, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16)
						end
						
						-- Vertical
						for prt = offsety+(v.y-myroomy*30)*16 + 16, offsety+(v.y-myroomy*30)*16 + (v.p2-1)*16 - 16, 16 do
							love.graphics.draw(scriptboximg[4], offsetx+(v.x-myroomx*40)*16, prt)
							love.graphics.draw(scriptboximg[6], offsetx+(v.x-myroomx*40)*16 + (v.p1-1)*16, prt)
						end
					end
					-- Maybe we should also display the script name!
					displayscriptname(true, k, v, offsetx, offsety, myroomx, myroomy)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[13], L.DELETE, L.EDITSCRIPT, L.OTHERSCRIPT, L.RESIZE, L.PROPERTIES}, "ent_19_" .. k)
				elseif v.t == 50 then
					-- Warp line
					love.graphics.setColor(0,255,0,255)
					if v.p1 == 2 or v.p1 == 3 then
						-- Horizontal
						love.graphics.line(offsetx+(v.p2)*16 + 1, offsety+(v.y-myroomy*30)*16 + 8, offsetx+(v.p2)*16 + v.p3*2 - 1, offsety+(v.y-myroomy*30)*16 + 8)
					else
						-- Vertical
						love.graphics.line(offsetx+(v.x-myroomx*40)*16 + 8, offsety+(v.p2)*16 + 1, offsetx+(v.x-myroomx*40)*16 + 8, offsety+(v.p2)*16 + v.p3*2 - 1)
					end
					love.graphics.setColor(255,255,255,255)
					
					-- Where is it, though?
					love.graphics.draw(cursorimg[0], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. toolnames[15], L.DELETE, L.PROPERTIES}, "ent_50_" .. k)
				else
					-- We don't know what this is, actually!
					love.graphics.draw(cursorimg[5], offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16)
					showtooltip = true
					if v.t ~= nil then
						entityrightclick(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, {"#" .. "Type " .. v.t, L.DELETE, L.PROPERTIES}, "ent_" .. v.t .. "_" .. k)
					end
				end
				if showtooltip and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16) then
					showtooltipof = v
				end
			end
		end
	end
	
	-- Here so that other entities won't cover the tooltip
	if showtooltipof ~= nil then
		love.graphics.print("x=" .. anythingbutnil(showtooltipof.x) .. "\ny=" .. anythingbutnil(showtooltipof.y) .. "\nt=" .. anythingbutnil(showtooltipof.t) .. "\np1=" .. anythingbutnil(showtooltipof.p1) .. "\np2=" .. anythingbutnil(showtooltipof.p2) .. "\np3=" .. anythingbutnil(showtooltipof.p3) .. "\np4=" .. anythingbutnil(showtooltipof.p4) .. "\np5=" .. anythingbutnil(showtooltipof.p5) .. "\np6=" .. anythingbutnil(showtooltipof.p6) .. "\n" .. L.SMALLENTITYDATA .. "=" .. anythingbutnil(showtooltipof.data), love.mouse.getX()+24, love.mouse.getY()+24)
	end
end

function drawentity(tile, atx, aty, small)
	if tilesets["sprites.png"]["tiles"][tile] ~= nil then
		love.graphics.draw(tilesets["sprites.png"]["img"], tilesets["sprites.png"]["tiles"][tile], atx, aty, 0, small and 1 or 2)
	else
		love.graphics.draw(cursorimg[5], atx, aty)
	end
end

function displayscriptname(isscriptbox, k, v, offsetx, offsety, myroomx, myroomy)
	if editingroomtext == k then
		love.graphics.setFont(font16)
		love.graphics.print(input .. __, math.min((offsetx+640)-((input .. __):len()*16)-(__ == "" and 16 or 0), offsetx+(v.x-myroomx*40)*16), math.max(3, offsety+(v.y-myroomy*30)*16 + 3 - 16))
		love.graphics.setFont(font8)
	elseif (((not isscriptbox) or editingsboxid ~= k) and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16))
	or (editingsboxid == k and (selectedsubtool[13] == 3 or sboxdontaskname)) then
		love.graphics.setFont(font16)
		love.graphics.print(v.data, math.min((offsetx+640)-(v.data:len()*16), offsetx+(v.x-myroomx*40)*16), math.max(3, offsety+(v.y-myroomy*30)*16 + 3 - 16))
		love.graphics.setFont(font8)
	end
end

function displaymapentities()
	
end

function entityrightclick(x, y, menuitems, newmenuid)
	if love.mouse.isDown("r") and mouseon(x, y, 16, 16) then
		rightclickmenu.create(menuitems, newmenuid)
	end
end

function displaytilespicker(offsetx, offsety, tilesetname)
	love.graphics.draw(tilesets[tilesetname]["img"], offsetx, offsety, 0, 2)
	
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		-- Also draw a box around the currently selected tile!
		local selectedx = selectedtile % 40
		local selectedy = (selectedtile-selectedx) / 40
		
		love.graphics.draw(cursorimg[20], (16*selectedx+screenoffset)-2, (16*selectedy)-2)
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
	else
		return true
	end
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
		elseif tileset == 2 and tilenum >= 51 and tilenum < 80 then
			return true
		end
	end
	return false
end

function issolidmultispikes(tilenum, tileset, spikessolid)
	-- Always ignore whether tiles are in the current tileset because we're now checking tiles next to a spike, don't let multi mode ruin that.
	
	return issolid(tilenum, tileset, spikessolid, true)
end

function issolidforgravline(tilenum)
	if tilenum == nil then
		return false
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
	elseif dowhat == 1 or dowhat == 6 then
		myissolid = isnot0
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
					
					-- How could I forget this?
					count.entities = count.entities + 1
					
					-- I could have been busy debugging this for a long time.
					local localcopy = table.copy(v)
					localcopy.x = localcopy.x + (40*roomxdiff)
					localcopy.y = localcopy.y + (30*roomydiff)
					table.insert(entitydata, localcopy)
					localcopy = nil
				end
			end
		end
	end
end

function displayshapedcursor(leftblx, upblx, rightblx, downblx)	
	love.graphics.draw(cursorimg[1], (cursorx*16)+screenoffset-(leftblx*16), (cursory*16)-(upblx*16))
	love.graphics.draw(cursorimg[2], (cursorx*16)+screenoffset+(rightblx*16), (cursory*16)-(upblx*16))
	love.graphics.draw(cursorimg[3], (cursorx*16)+screenoffset-(leftblx*16), (cursory*16)+(downblx*16))
	love.graphics.draw(cursorimg[4], (cursorx*16)+screenoffset+(rightblx*16), (cursory*16)+(downblx*16))
end

function displayalphatile(leftblx, upblx, forx, fory)
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		--love.graphics.setFont(tinynumbers)
		love.graphics.setColor(255,255,255,128)
		for forfory = 0, fory do
			for forforx = 0, forx do
				--cons(roomx .. " " .. roomy .. " " .. (roomy)*20 + (roomx+1) .. " " .. levelmetadata[(roomy)*20 + (roomx+1)].tileset)
				love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*(cursorx-leftblx+forforx)), (16*(cursory-upblx+forfory)), 0, 2)
				
				--love.graphics.print(selectedtile, 128+(16*(cursorx-leftblx+forforx)), (16*(cursory-upblx+forfory)))
			end
		end
		love.graphics.setColor(255,255,255,255)
		--love.graphics.setFont(font8)
	end
	
	-- But are we holding one of the directions?
	if love.keyboard.isDown("[") or love.keyboard.isDown("]") then
		love.graphics.setColor(0,0,0,92)
		
		if love.keyboard.isDown("[") then
			-- Horizontal
			love.graphics.rectangle("fill", screenoffset, 0, 640, (16*(cursory-upblx)))
			love.graphics.rectangle("fill", screenoffset, (16*(cursory-upblx+(fory+1))), 640, 480-(16*(cursory-upblx+(fory+1))))
		end
		if love.keyboard.isDown("]") then
			-- Vertical
			love.graphics.rectangle("fill", screenoffset, 0, (16*(cursorx-leftblx)), 480)
			love.graphics.rectangle("fill", screenoffset+(16*(cursorx-leftblx+(forx+1))), 0, 640-(16*(cursorx-leftblx+(forx+1))), 480)
		end
		
		love.graphics.setColor(255,255,255,255)
	end
end

function displayalphatile_hor()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		--love.graphics.setFont(tinynumbers)
		love.graphics.setColor(255,255,255,128)
		for forforx = 0, 39 do
			--cons(roomx .. " " .. roomy .. " " .. (roomy)*20 + (roomx+1) .. " " .. levelmetadata[(roomy)*20 + (roomx+1)].tileset)
			love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*forforx), (16*cursory), 0, 2)
			
			--love.graphics.print(selectedtile, 128+(16*forforx), (16*cursory))
		end
		love.graphics.setColor(255,255,255,255)
		--love.graphics.setFont(font8)
	end
end

function displayalphatile_ver()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		--love.graphics.setFont(tinynumbers)
		love.graphics.setColor(255,255,255,128)
		for forfory = 0, 29 do
			--cons(roomx .. " " .. roomy .. " " .. (roomy)*20 + (roomx+1) .. " " .. levelmetadata[(roomy)*20 + (roomx+1)].tileset)
			love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*cursorx), (16*forfory), 0, 2)
			
			--love.graphics.print(selectedtile, 128+(16*cursorx), (16*forfory))
		end
		love.graphics.setColor(255,255,255,255)
		--love.graphics.setFont(font8)
	end
end

function displayalphatile_all()
	if levelmetadata[(roomy)*20 + (roomx+1)].directmode == 1 then
		--love.graphics.setFont(tinynumbers)
		love.graphics.setColor(255,255,255,128)
		for forfory = 0, 29 do
			for forforx = 0, 39 do
				love.graphics.draw(tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["img"], tilesets[tilesetnames[usedtilesets[levelmetadata[(roomy)*20 + (roomx+1)].tileset]]]["tiles"][selectedtile], screenoffset+(16*forforx), (16*forfory), 0, 2)
				
				--love.graphics.print(selectedtile, 128+(16*forforx), (16*forfory))
			end
		end
		love.graphics.setColor(255,255,255,255)
		--love.graphics.setFont(font8)
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

function setroomfromcopy(data, rx, ry)
	cons("Setting room " .. rx .. " " .. ry)

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

function rotateroom180(rx, ry)
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
end

function autocorrectlines()
	for k,v in pairs(entitydata) do
		if (v.t == 11 or v.t == 50) and (v.x >= roomx*40) and (v.x <= (roomx*40)+39) and (v.y >= roomy*30) and (v.y <= (roomy*30)+29) then
			-- This is a gravity line in this room.
			if (v.t == 11 and v.p1 == 0) or (v.t == 50 and (v.p1 == 2 or v.p1 == 3)) then
				-- Horizontal
				local startat, linelength
				
				-- Backtrack to see what tile is solid
				for bt = (v.x%40), 0, -1 do
					if issolidforgravline(roomdata[roomy][roomx][((v.y%30)*40)+(bt)]) then
						startat = bt
						break
					end
				end
				if startat == nil then
					startat = -1
				end
				
				-- Now to see how long it should be!
				for ft = startat+1, 40 do
					if issolidforgravline(roomdata[roomy][roomx][((v.y%30)*40)+(ft)]) then
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
					if issolidforgravline(roomdata[roomy][roomx][(bt*40)+((v.x%40)+1)]) then
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
					if issolidforgravline(roomdata[roomy][roomx][(ft*40)+((v.x%40)+1)]) then
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
		gotoroom(undobuffer[#undobuffer].rx, undobuffer[#undobuffer].ry)
	
		if undobuffer[#undobuffer].undotype == "tiles" then
			if (undobuffer[#undobuffer].toundotiles[1] == nil) then
				temporaryroomname = L.UNDOFAULTY
				temporaryroomnametimer = 90
			else
				roomdata[roomy][roomx] = table.copy(undobuffer[#undobuffer].toundotiles)
			end
		elseif undobuffer[#undobuffer].undotype == "addentity" then
			-- So we need to remove this entity again!
			removeentity(undobuffer[#undobuffer].entid, nil, true)
		elseif undobuffer[#undobuffer].undotype == "removeentity" then
			-- Hmm... Re-add it in this case!
			entitydata[undobuffer[#undobuffer].entid] = undobuffer[#undobuffer].removedentitydata
			updatecountadd(undobuffer[#undobuffer].removedentitydata.t)
		else
			temporaryroomname = langkeys(L.UNKNOWNUNDOTYPE, {undobuffer[#undobuffer].undotype})
			temporaryroomnametimer = 90
		end
		
		table.insert(redobuffer, table.copy(undobuffer[#undobuffer]))
		table.remove(undobuffer, #undobuffer)
	end
end
-- TODO: Merge these two?
function redo()
	if #redobuffer >= 1 then
		gotoroom(redobuffer[#redobuffer].rx, redobuffer[#redobuffer].ry)
	
		if redobuffer[#redobuffer].undotype == "tiles" then
			if (redobuffer[#redobuffer].toredotiles[1] == nil) then
				temporaryroomname = L.UNDOFAULTY
				temporaryroomnametimer = 90
			else
				roomdata[roomy][roomx] = table.copy(redobuffer[#redobuffer].toredotiles)
			end
		elseif redobuffer[#redobuffer].undotype == "addentity" then
			-- Re-add it again
			entitydata[redobuffer[#redobuffer].entid] = redobuffer[#redobuffer].addedentitydata
			updatecountadd(redobuffer[#redobuffer].addedentitydata.t)
		elseif redobuffer[#redobuffer].undotype == "removeentity" then
			-- Redo the removing!
			removeentity(redobuffer[#redobuffer].entid, nil, true)
		else
			temporaryroomname = langkeys(L.UNKNOWNUNDOTYPE, {redobuffer[#redobuffer].undotype})
			temporaryroomnametimer = 90
		end
		
		table.insert(undobuffer, table.copy(redobuffer[#redobuffer]))
		table.remove(redobuffer, #redobuffer)
	end
end	

function entityplaced(id)
	if id == nil then
		id = #entitydata
	end
	
	table.insert(undobuffer, {undotype = "addentity", rx = roomx, ry = roomy, entid = id, addedentitydata = table.copy(entitydata[id])})
	redobuffer = {}
	cons("[UNRE] ADDED ENTITY")
end

function removeentity(id, thetype, undoing)
	if thetype == nil then
		thetype = entitydata[id].t
	end

	updatecountdelete(thetype, id, undoing)
	entitydata[id] = nil
end

function cutroom()
	love.system.setClipboardText(getroomcopydata(roomx, roomy))
	
	-- That's only a copy, now reset the room except for the tileset/col
	setroomfromcopy(levelmetadata[roomy*20 + (roomx+1)].tileset .. "," .. levelmetadata[roomy*20 + (roomx+1)].tilecol .. ",0,0,320,240,4,0,0,320,240,0,0,0," .. (",0"):rep(1200), roomx, roomy)
	
	temporaryroomname = L.ROOMCUT
	temporaryroomnametimer = 90
end

function copyroom()
	love.system.setClipboardText(getroomcopydata(roomx, roomy))
	
	temporaryroomname = L.ROOMCOPIED
	temporaryroomnametimer = 90
end

function pasteroom()
	setroomfromcopy(love.system.getClipboardText(), roomx, roomy)
	
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