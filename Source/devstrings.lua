-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L.WHEREPLACEPLAYER = "Where do you want to start?"
L.YOUAREPLAYTESTING = "You are currently playtesting"
L.LOCATEVVVVVVNONSTEAM = "Select your VVVVVV directory"
L.ALREADYPLAYTESTING = "You're already playtesting!"
L.PLAYTESTUNAVAILABLE = "Sorry, you cannot playtest on $1." -- you cannot playtest on <operating system>
L.VVVVVVNONSTEAMPATHINVALID = "Sorry, but that path is invalid."
L.NONSTEAMCONTAINSFOLDER = "Please select the folder CONTAINING the folder '$1'."
L.NONSTEAMCONTAINSFILE = "Please select the folder containing the file '$1'."
L.CHANGINGPATHAFTERASK = "The VVVVVV folder was changed after pressing play and it is no longer valid!"
L_PLU.LDPRELOADCONTAINSSPACES = {
	[0] = "$1 contains a space! Not running the game.",
	[1] = "$1 contains spaces! Not running the game.",
}

L.CONFIRMBIGGERSIZE = "You are selecting $1 by $2, which is a bigger map size than $3 by $4. Outside the normal $3 by $4 map, rooms and room properties wrap around, but are distorted. You do not get entirely new rooms, nor do you get more room properties. VVVVVV can also crash for any reason in those rooms.\n\nPress Yes if you know what you're doing and want this bigger map size. Press No to set the map size to $5 by $6.\n\nIf unsure, press No."
L.MAPBIGGERTHANSIZELIMIT = "Map size $1 by $2 is bigger than $3 by $4! (Bigger than $3 by $4 support not enabled)"
L.BTN_OVERRIDE = "Override"

L.TODO_ALTSTATES = "This VVVVVV-CE level has alt states, which are not yet supported and will be lost!" -- alternate versions of rooms in the main game have always been known as "altstates"
L.TODO_TOWERS = "This VVVVVV-CE level has towers, which are not yet supported and will be lost!"
L.TODO_TELEPORTERS = "This VVVVVV-CE level has big round teleporters, which are not yet supported and will be lost!"
L.TODO_TIMETRIALS = "This VVVVVV-CE level has time trials, which are not yet supported and will be lost!"
