ved_require("drawmap")

local ui = {}

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
	Float(
		ImageButton(checkon, 2, function() dialog.create("hello world") end, "Z", function(key) return key == "z" end,
			function() return ui_demo end
		),
		64, 64
	),
	RightBar(
		{
			ImageButton(checkon, 2,
				function() dialog.create("hello world 1 (right click to remove this)") end,
				"X", function(key) return key == "x" end,
				function() return ui_demo and not ui_demo_thing_gone end, -- active func
				function() dialog.create("oh you right clicked thing. Now it's gone."); ui_demo_thing_gone = true end, -- action_r
				function(key) return key == "x" and love.keyboard.isDown("lshift") end -- right hotkey func (no text ofc!)
			),
			LabelButton("Label button!", function() dialog.create("hello world 2") end,
				"C", function(key) return key == "c" end,
				function() return ui_demo end, -- active
				function() return true end, -- yellow
				function() dialog.create("right clicked button!") end,
				function(key) return key == "l" end
			),
			LabelButton("Toggle UI demo", function() ui_demo = not ui_demo end, "U", function(key) return key == "u" end),
		},
		{
			LabelButton(L.SAVEMAP, create_export_dialog, "S", function(key) return key == "s" end),
			LabelButton(L.RETURN, function() tostate(1, true) end, "b", function(key) return key == "escape" end),
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
