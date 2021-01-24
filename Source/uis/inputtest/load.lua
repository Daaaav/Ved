-- inputtest/load

return function()
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
