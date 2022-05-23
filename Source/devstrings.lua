-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L.FIND_V_EXE_ERROR = "Sorry, something went wrong trying to find VVVVVV. Try setting the path to the executable manually."
L.FIND_V_EXE_FOUNDERROR = "Found something that looks like VVVVVV, but couldn't get a useable path to its executable. Make sure you aren't using an old version of the game (2.3 or newer is required) or try setting the path to the executable manually."
L.FIND_V_EXE_NOTFOUND = "It looks like VVVVVV is not running. Make sure you have VVVVVV running and try again."
L.FIND_V_EXE_MULTI = "Found multiple different instances of VVVVVV running. Make sure you have only one version of the game open and try again."

L.FIND_V_EXE_EXPLANATION = "Ved needs VVVVVV for playtesting, and the path to VVVVVV needs to be set first.\n\n\nTo autodetect VVVVVV, simply start the game if it isn't already running and press \"Detect\"."

L.BTN_AUTODETECT = "Detect"
L.BTN_MANUALLY = "Override" -- choose path to VVVVVV.exe manually. I didn't want "Manual" in English because it sounds like "instruction manual", but translations may use some form of "manual setup". This button should come across like "I know what I'm doing, I want to override automatic detection"
L.BTN_RETRY = "Retry"
