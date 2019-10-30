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
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["enemy" .. v]
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
						newvalue = levelmetadata[(roomy)*20 + (roomx+1)]["plat" .. v]
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
	FloatContainer(
		ImageButton(checkon, 2, function() dialog.create("hello world") end, "Z", hotkey("z"),
			function() return ui_demo == true end
		),
		64, 64
	),
	RightBar(
		{
			ImageButton(checkon, 2,
				function() dialog.create("hello world 1 (right click to remove this)") end,
				"X", hotkey("x"),
				function() return ui_demo == true and not ui_demo_thing_gone end, -- active func
				function()
					dialog.create("oh you right clicked thing. Now it's gone.")
					ui_demo_thing_gone = true
				end, -- action_r
				hotkey("x", "shift") -- right hotkey func (no text ofc!)
			),
			LabelButton("Label button!", function() dialog.create("hello world 2") end,
				"C", hotkey("c"),
				function() return ui_demo == true, true, true end, -- shown, enabled, yellow
				function() dialog.create("right clicked button!") end,
				hotkey("l")
			),
			LabelButton("Toggle UI demo", function() ui_demo = not ui_demo end, "U", hotkey("u")),
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
end

function ui.keyreleased(key)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
