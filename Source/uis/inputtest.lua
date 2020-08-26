local ui = {name = "inputtest"}

function ui.load()
	newinputsys.create(INPUT.ONELINE, "inputtest", "This is the §¤ caret test", 5)
	newinputsys.create(INPUT.MULTILINE, "inputtest2", {"This is line 1", "The second § ¤ line, this is", "Third line"}, 2, 2)
	newinputsys.create(INPUT.MULTILINE, "inputtest3", {"I'm double-scaled!!!", "Wowzers"})
	newinputsys.create(INPUT.MULTILINE, "inputtest4", {"I'mm streetttcheeeddd", "ooouuuuttttt"})
	newinputsys.create(INPUT.ONELINE, "inputtest5", "This is a VVVVVV script line")
	newinputsys.setnewlinechars("inputtest5", "|") -- Don't care about PleaseDo3DSHandlingThanks in a test state
	newinputsys.create(INPUT.MULTILINE, "inputtest6", {"These are VVVVVV script lines", "The one after this one is numbers-only"})
	newinputsys.setnewlinechars("inputtest6", "|")
	newinputsys.create(INPUT.ONELINE, "inputtest7", "0123456789")
	newinputsys.whitelist("inputtest7", "%d")
	newinputsys.create(INPUT.MULTILINE, "inputtest8", {"I'm testing blacklisting Unicode", "even though really you should whitelist ASCII", "because it's simpler"})
	newinputsys.blacklist("inputtest8", "[^\x01-\x7F]")
	newinputsys.create(INPUT.MULTILINE, "inputtest9", {"This input has a line height of 10 pixels", "Instead of 8 pixels like normal", "so things are spaced out more"})
end

ui.elements = {
}

function ui.draw()
	newinputsys.print("inputtest", 100, 0)
	newinputsys.print("inputtest2", 100, 50)
	newinputsys.print("inputtest3", 100, 100, 2)
	newinputsys.print("inputtest4", 100, 150, 1, 2)
	newinputsys.print("inputtest5", 100, 200)
	newinputsys.print("inputtest6", 100, 250)
	newinputsys.print("inputtest7", 100, 300)
	newinputsys.print("inputtest8", 100, 350)
	newinputsys.print("inputtest9", 100, 400, nil, nil, 10)

	local youhaveselected = "You have selected: "
	local tmp = newinputsys.getseltext(newinputsys.input_ids[#newinputsys.nth_input])
	if tmp ~= nil then
		ved_print(youhaveselected .. tmp, 580, 112)
	end
end

function ui.update(dt)
end

function ui.keypressed(key)
	if key == "tab" then
		newinputsys.bump(newinputsys.input_ids[#newinputsys.nth_input - 8])
	end
end

function ui.keyreleased(key)
end

function ui.textinput(char)
end

function ui.mousepressed(x, y, button)
end

function ui.mousereleased(x, y, button)
end

return ui
