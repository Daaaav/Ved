-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""

L.THEMES = "Themes"
L.THEMESTITLE = "Theme settings"
L.ACTIVETHEMES = "Active themes"
L.INACTIVETHEMES = "Inactive themes"

L.SPECIALROOMNAMES_TITLE = "Special roomnames"
L.STANDARD_ROOMNAME = "Standard roomname" -- Indicates the regular room name
L.HINT_LAST_ROOMNAME = "Lower roomnames have priority." -- There is a list of possible names for this room. The last name in that list will be used over earlier ones if its flag is set, otherwise the second-to-last, and so on
L.ADD_SPECIALROOMNAME = "Add special roomname"
L.SPECIALROOMNAME_STATIC = "Static name"
L.SPECIALROOMNAME_GLITCH = "Glitch"
L.SPECIALROOMNAME_TRANSFORM = "Animation/Transformation"
L.SPECIALROOMNAME_THIS_FLAG = "Flag:" -- Followed by a button, showing either a flag or the None string below
L.SPECIALROOMNAME_NO_FLAG = "None (always active)"
L.SPECIALROOMNAME_ROOMNAME = "Roomname:" -- Followed by input field
L.SPECIALROOMNAME_FRAME1 = "Frame 1:" -- Followed by input field. Like frames in an animation, but with text
L.SPECIALROOMNAME_FRAME2 = "Frame 2:" -- Followed by input field. Like frames in an animation, but with text
L.SPECIALROOMNAME_FRAMES = "Frames (one per line):" -- Followed by multiline input field. Like frames in an animation, but with text
L.SPECIALROOMNAME_LOOP = "Loop" -- Checkbox: this animation keeps repeating

L.FLAGS_SPECIALROOMNAME = "Choose the flag that activates this special roomname"

L.SUREDELETESPECIALROOMNAME = "Are you sure you want to delete this roomname?"

L.RECENT_SEARCHES = "Recent searches" -- You last searched for these 5 things, click one to search it again

L.INTSC_LONG = "Internal scripting mode"

L.INTSC_LOADSCRIPT24 = "Loadscript (2.4+)" -- A scripting mode that requires a loadscript, and only works in VVVVVV 2.4+
L.INTSC_LOADSCRIPT23 = "Loadscript (compatible with 2.3-)" -- Like the other Loadscript option, but also works in earlier versions
L.INTSC_SAYMIN1 = "say(-1)" -- The say(-1) method involves using the scripting command say(-1)

L.INTSC_LOADSCRIPT24_SHORT = "Mode: 2.4+"
L.INTSC_LOADSCRIPT23_SHORT = "Mode: 2.1+"
L.INTSC_SAYMIN1_SHORT = "Mode: say(-1)"

L.INTSC_LOADSCRIPT24_EXPL = "When making a level for VVVVVV 2.4 or above, this setting is all you need. This script needs to be loaded from another script."
L.INTSC_LOADSCRIPT23_EXPL = "Like the 2.4+ method, but the script is (invisibly) split into blocks of less than 50 lines for compatibility with many VVVVVV versions. This might be a limitation for some specific usecases."
L.INTSC_SAYMIN1_EXPL = "Like \"Loadscript (compatible with 2.3-)\", but it saves a loadscript, which helped when there was a limit of 500 scripts in total. The script forcibly starts with cutscene bars." -- the word 'saves' = 'economizes'/'removes the need for', NOT 'stores data to disk'!
