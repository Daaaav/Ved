function handle_entity_mousedown()
	-- Handles (right) clicking on entities and creating right click menus.
	-- Returns true if right clicking was caught - this stops handle_tool_mousedown() from also drawing or so.

	local offsetx, offsety = screenoffset, 0
	local myroomx, myroomy = roomx, roomy

	for k,v in pairs(entitydata) do
		local shown = false

		if (v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29) then
			shown = true
		end
		if (v.t == 13)
		and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29) then
			-- Warp token destination
			shown = true
		end

		if shown then
			-- First of all, we can remove an entity by shift-right clicking
			if keyboard_eitherIsDown("shift") and love.mouse.isDown("r")
			and mouseon(offsetx+(v.x-myroomx*40)*16, offsety+(v.y-myroomy*30)*16, 16, 16) then
				removeentity(k, entitydata[k].t)
			else
				local x = offsetx+(v.x-myroomx*40)*16
				local y = offsety+(v.y-myroomy*30)*16

				local menu = nil
				if v.t == 1 then
					-- Enemy
					menu = {"#" .. toolnames[9], L.DELETE, L.CHANGEDIRECTION, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 2 then
					-- Platform, it's either a moving one or a conveyor!
					menu = {"#" .. getentityname(2, v.p1), L.DELETE, L.CYCLETYPE, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 3 then
					-- Disappearing platform
					menu = {"#" .. toolnames[6], L.DELETE, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 9 then
					-- Trinket
					menu = {"#" .. toolnames[4], L.DELETE, L.MOVEENTITY, (count.trinkets >= limit.trinkets and "#" or "") .. L.COPY, L.PROPERTIES}
				elseif v.t == 10 then
					-- Checkpoint
					menu = {"#" .. toolnames[5], L.DELETE, L.FLIP, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 11 then
					-- Gravity line
					menu = {"#" .. toolnames[10], L.DELETE, (v.p1 == 0 and L.CHANGETOVER or L.CHANGETOHOR), (v.p4 == 1 and L.UNLOCK or L.LOCK), L.PROPERTIES}
					if v.p4 == 1 then
						table.insert(menu, #menu, L.MOVEENTITY)
						table.insert(menu, #menu, L.COPY)
					end
				elseif v.t == 50 then
					-- Warp line
					menu = {"#" .. toolnames[15], L.DELETE, (v.p4 == 1 and L.UNLOCK or L.LOCK), L.PROPERTIES}
					if v.p4 == 1 then
						table.insert(menu, #menu, L.MOVEENTITY)
						table.insert(menu, #menu, L.COPY)
					end
				elseif v.t == 13 then
					-- Warp token. But are we currently displaying the entrance or the destination? Or both?
					if (v.x >= myroomx*40) and (v.x <= (myroomx*40)+39) and (v.y >= myroomy*30) and (v.y <= (myroomy*30)+29) then
						-- Entrance
						menu = {"#" .. toolnames[14], L.DELETE, L.GOTODESTINATION, L.CHANGEENTRANCE, L.CHANGEEXIT, L.COPYENTRANCE, L.PROPERTIES}
					end
					-- warpid = what warp token destination we're placing.
					if (warpid ~= k or selectedsubtool[14] >= 3)
					and (v.p1 >= myroomx*40) and (v.p1 <= (myroomx*40)+39) and (v.p2 >= myroomy*30) and (v.p2 <= (myroomy*30)+29) then
						-- Destination, special case of course...
						if entity_interactable(
							k, offsetx+(v.p1-myroomx*40)*16, offsety+(v.p2-myroomy*30)*16,
							{"#" .. toolnames[14], L.DELETE, L.GOTOENTRANCE, L.CHANGEENTRANCE, L.CHANGEEXIT, L.COPYENTRANCE, L.PROPERTIES}, "ent_13_" .. k
						) then
							return true
						end
					end
				elseif v.t == 15 then
					-- Rescuable crewmate
					menu = {"#" .. toolnames[16], L.DELETE, L.CHANGECOLOR, L.MOVEENTITY, (count.crewmates >= limit.crewmates and "#" or "") .. L.COPY, L.PROPERTIES}
				elseif v.t == 16 then
					-- Start point
					menu = {"#" .. toolnames[17], L.DELETE, L.CHANGEDIRECTION, L.MOVEENTITY, L.PROPERTIES}
				elseif v.t == 17 then
					-- Roomtext
					menu = {"#" .. toolnames[11], L.DELETE, L.EDITTEXT, L.COPYTEXT, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 18 then
					-- Terminal
					menu = {(namefound(v) ~= 0 and "" or "#") .. toolnames[12], L.DELETE, L.EDITSCRIPT, L.EDITSCRIPTWOBUMPING, L.OTHERSCRIPT, L.FLIP, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				elseif v.t == 19 then
					-- Script box.
					menu = {"#" .. toolnames[13], L.DELETE, L.EDITSCRIPT, L.EDITSCRIPTWOBUMPING, L.OTHERSCRIPT, L.RESIZE, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				else
					-- We don't know what this is, actually!
					menu = {"#" .. langkeys(L.UNKNOWNENTITYTYPE, {v.t}), L.DELETE, L.MOVEENTITY, L.COPY, L.PROPERTIES}
				end

				if menu ~= nil and entity_interactable(k, x, y, menu, "ent_" .. v.t .. "_" .. k) then
					return true
				end
			end
		end
	end
end
