ved_require("drawmap")

local ui = {name = "map"}

function ui.load(...)
	mapscale = math.min(1/metadata.mapwidth, 1/metadata.mapheight)
	--mapxoffset = (640-(((1/mapscale)-metadata.mapwidth)*mapscale*640))/2
	--mapyoffset = (480-(((1/mapscale)-metadata.mapheight)*mapscale*480))/2
	mapxoffset = (((1/mapscale)-metadata.mapwidth)*mapscale*640)/2
	mapyoffset = (((1/mapscale)-metadata.mapheight)*mapscale*480)/2

	selectingrooms = 0
	selected1x = -1; selected1y = -1
	selected2x = -1; selected2y = -1

	mapmovedroom = false

	setgenerictimer(2, 2.75)

	locatetrinketscrewmates()

	if editingbounds ~= 0 then
		if editingbounds == 1 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "enemy" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["enemy" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("ENEMY BOUNDS (map canceled)")
		elseif editingbounds == 2 then
			local changeddata = {}
			for k,v in pairs({"x1", "x2", "y1", "y2"}) do
				table.insert(changeddata,
					{
						key = "plat" .. v,
						oldvalue = oldbounds[k],
						newvalue = levelmetadata_get(roomx, roomy)["plat" .. v]
					}
				)
			end
			table.insert(undobuffer, {undotype = "levelmetadata", rx = roomx, ry = roomy, changedmetadata = changeddata})
			finish_undo("PLATFORM BOUNDS (map canceled)")
		end

		editingbounds = 0
	end
end

-- Any "UI elements" that need to be drawn in that order.
-- UI elements can be little things like buttons, but also entire drawing functions.
ui.elements = {
	DrawingFunction(drawmap),
	RightBar(
		{
		},
		{
			EditorIconBar(),
			LabelButton(L.COPYROOMS,
				function()
					selectingrooms = 1
					selected1x = -1; selected1y = -1
					selected2x = -1; selected2y = -1
				end
			),
			LabelButton(L.SWAPROOMS,
				function()
					selectingrooms = 2
					selected1x = -1; selected1y = -1
					selected2x = -1; selected2y = -1
				end
			),
			ScreenContainer(
				{
					DrawingFunction(
						function(x, y, maxw, maxh)
							ved_printf(L.SHIFTROOMS, x, y+6, 8*10, "center")
							hoverrectangle(128,128,128,128, x+8*10, y+10, 10, 10)
							hoverrectangle(128,128,128,128, x+8*13, y+10, 10, 10)
							hoverrectangle(128,128,128,128, x+8*11+4, y, 10, 10)
							hoverrectangle(128,128,128,128, x+8*11+4, y+10+8, 10, 10)
							ved_print(arrow_left, x+8*10+1, y+10+1)
							ved_print(arrow_right, x+8*13+1, y+10+1)
							ved_print(arrow_up, x+8*11+4+1, y+1)
							ved_print(arrow_down, x+8*11+4+1, y+10+8+1)
						end
					),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.LEFT, true) end), 8*10, 10),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.RIGHT, true) end), 8*13, 10),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.UP, true) end), 8*11+4, 0),
					FloatContainer(InvisibleButton(10, 10, function() shiftrooms(SHIFT.DOWN, true) end), 8*11+4, 10+8),
				},
				114, 26
			),
			LabelButtonSpacer(),
			LabelButton(L.SAVEMAP, create_export_dialog, "S", hotkey("s")),
			LabelButton(L.RETURN, function() tostate(1, true) end, "b", hotkey("escape")),
		}
	),
}

-- Just some functions called by their respective main callbacks.
function ui.draw()
end

function ui.update(dt)
end

function ui.textinput(char)
end

function ui.keypressed(key)
	if key == "p" and keyboard_eitherIsDown(ctrl) then
		gotostartpointroom()
	elseif key == "right" or key == "kp6" then
		-->
		gotoroom_r()
		mapmovedroom = true
	elseif key == "left" or key == "kp4" then
		--<
		gotoroom_l()
		mapmovedroom = true
	elseif key == "down" or key == "kp2" then
		--v
		gotoroom_d()
		mapmovedroom = true
	elseif key == "up" or key == "kp8" then
		--^
		gotoroom_u()
		mapmovedroom = true
	elseif table.contains({"return", "kpenter"}, key) or key == "m" or key == "kp5" then
		tostate(1, true)
		nodialog = false
	elseif key == "," or key == "." then
		local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17
		if key == "," then
			if not toolanyofthese then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 1
			end
		elseif key == "." then
			if not toolanyofthese then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 1
			end
		end
		updatewindowicon()
		toolscroll()
	else
		for k,v in pairs(toolshortcuts) do
			if key == string.lower(v) then
				if selectedtool == k and k ~= 13 and k ~= 14 and state == 1 then
					-- We're re-pressing this button, so set the subtool to the first one.
					selectedsubtool[k] = 1
				elseif not (selectedtool == 13 and selectedsubtool[13] ~= 1) then
					selectedtool = k
					updatewindowicon()
				end
				toolscroll()
			end
		end
	end
end

function ui.keyreleased(key)
end

function ui.mousepressed(x, y, button)
	if button == "wu" or button == "wd" then
		local toolanyofthese = selectedtool == 4 or selectedtool == 16 or selectedtool == 17
		if button == flipscrollmore(macscrolling and "wd" or "wu") then
			if not toolanyofthese then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 1
			end
		elseif button == flipscrollmore(macscrolling and "wu" or "wd") then
			if not toolanyofthese then
				selectedtool = 4
			elseif selectedtool == 4 then
				selectedtool = 16
			elseif selectedtool == 16 then
				selectedtool = 17
			elseif selectedtool == 17 then
				selectedtool = 1
			end
		end
		updatewindowicon()
		toolscroll()
	end
end

function ui.mousereleased(x, y, button)
end

return ui
