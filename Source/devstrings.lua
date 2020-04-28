-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L.CUT = "Cut"
L.PASTE = "Paste"
L.SELECTWORD = "Select word"
L.SELECTLINE = "Select line"
L.SELECTALL = "Select all"
L.INSERTRAWHEX = "Insert Unicode character"
L.MOVELINEUP = "Move line upwards"
L.MOVELINEDOWN = "Move line downwards"
L.DUPLICATELINE = "Duplicate line"

L.CUSTOMGRAPHICS = "Alternative graphics" -- Alternative tileset or sprites images
L.CUSTOMTILESET = "Tileset image:" -- What variant of tiles*.png is used
L.CUSTOMSPRITESHEET = "Sprites image:" -- What variant of sprites*.png is used
L.CUSTOMTILESET_DEFAULT = "Default ($1)" -- Placeholder can be tiles.png, tiles2.png or tiles3.png
L.CUSTOMSPRITESHEET_DEFAULT = "Default (sprites.png)"

L.ONECUSTOMTILESET = "CT $1" -- Custom Tileset
L.ONECUSTOMSPRITESHEET = "CS $1" -- Custom Sprites
L.ONEALTSTATE = "A $1/$2" -- Alt state
L.ONETOWER = "T$1 $2\n $3" -- Tower. $1 is ↑ or ↓, $2 is tower number, $3 is current position

table.insert(toolnames, "Flip token")
table.insert(toolnames, "Coin")
table.insert(toolnames, "Teleporter")
table.insert(subtoolnames, {})
table.insert(subtoolnames, {"Single coin", "10 coin", "20 coin", "50 coin", "100 coin"})
table.insert(subtoolnames, {})

L.WHEREPLACEPLAYER = "Where do you want to start?"
L.YOUAREPLAYTESTING = "You are currently playtesting"
L.LOCATEVVVVVV = "Select your $1 executable"
L.ALREADYPLAYTESTING = "You're already playtesting!"
L.PLAYTESTUNAVAILABLE = "Sorry, you cannot playtest on $1." -- you cannot playtest on <operating system>
L.VVVVVVPATHINVALID = "Sorry, but that path is invalid."
L.VVVVVVFILE = "Please select the file named '$1'."
L.CHANGINGPATHAFTERASK = "The VVVVVV path was changed after pressing play and it is no longer valid!"
