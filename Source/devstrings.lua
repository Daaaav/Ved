-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L.CUT = "Cut"
L.PASTE = "Paste"
L.SELECTWORD = "Select word"
L.SELECTLINE = "Select line"
L.SELECTALL = "Select all"
L.INSERTRAWHEX = "Insert raw hex"
L.MOVELINEUP = "Move line upwards"
L.MOVELINEDOWN = "Move line downwards"
L.DUPLICATELINE = "Duplicate line"

table.insert(toolnames, "Flip token")
table.insert(toolnames, "Coin")
table.insert(toolnames, "Teleporter")
table.insert(subtoolnames, {})
table.insert(subtoolnames, {})
table.insert(subtoolnames, {})

L.WHEREPLACEPLAYER = "Where do you want to start?"
L.YOUAREPLAYTESTING = "You are currently playtesting"
L.LOCATEVVVVVVNONSTEAM = "Select your VVVVVV directory"
L.ALREADYPLAYTESTING = "You're already playtesting!"
L.PLAYTESTUNAVAILABLE = "Sorry, you cannot playtest on $1." -- you cannot playtest on <operating system>
L.VVVVVVNONSTEAMPATHINVALID = "Sorry, but that path is invalid."
L.NONSTEAMCONTAINSFILE = "Please select the folder containing the file '$1'."
L.CHANGINGPATHAFTERASK = "The VVVVVV folder was changed after pressing play and it is no longer valid!"
