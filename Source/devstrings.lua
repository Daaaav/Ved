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

L.LIB_LOAD_ERRMSG = "Failed to load an essential library. Please tell Dav999 about this problem.\n\n$1"
L.LIB_LOAD_ERRMSG_GCC = "\n\nTry installing GCC to solve this problem, if it isn't already installed."

L.VVVVVV_EXITCODE_FAILURE = "VVVVVV exited with code $1" -- for example, code 1, indicating failure
L.VVVVVV_22_OR_OLDER = "It looks like you are using VVVVVV 2.2 or older. Please upgrade to VVVVVV 2.3 or later."
L.VVVVVV_SOMETHING_HAPPENED = "Something seems to have gone wrong with VVVVVV."

L.SYNTAXCOLOR_WRONGLANG = "Simplified command in int.sc mode or vice versa"

L.UNSAVED_LEVEL_ASSETS_FOLDER = "The level needs to be saved before it can use custom assets."
L.CREATE_ASSETS_FOLDER = "Would you like to create a custom assets folder for this level?\n\n$1" -- $1: path
L.CREATE_VVVVVV_FOLDER = "It seems like the VVVVVV folder doesn't exist. Would you like to create it?"
L.CREATE_LEVELS_FOLDER = "It seems like the levels folder doesn't exist. Would you like to create it?"
L.CREATE_FOLDER_FAIL = "Unable to create folder.\n\n$1"
L.ASSETS_FOLDER_FOR_LEVEL = "Assets folder for $1"

L.ASSETS_FOLDER_EXISTS_NO = "Does not exist - click to create"
L.ASSETS_FOLDER_EXISTS_YES = "Exists - click to open"

L.NO_ASSETS_SUBFOLDER = "No \"$1\" folder"

L.COORDS_OUT_OF_RANGE = "Huh? These coordinates aren't even in this dimension!"

L.MOUSESCROLLINGSPEED = "Mouse scrolling speed"

L.BTN_ADVANCED = "Advanced"

L.ADVANCED_LEVEL_OPTIONS = "Advanced level options"
L.ONEWAYCOL_OVERRIDE = "Recolor one-way tiles in custom assets as well (onewaycol_override)" -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

L.CUSTOM_SIZED_BRUSH = "Custom brush"

-- These are limited to 12 characters
L.CUSTOM_SIZED_BRUSH_BRUSH = "Brush"
L.CUSTOM_SIZED_BRUSH_STAMP = "Stamp"
L.CUSTOM_SIZED_BRUSH_TILESET = "Tileset"

L.CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Custom brush size"
L.CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Choose the size of the brush you need."

L.CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stamp from room"
L.CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Select tiles from the room to create a stamp."

L.CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stamp from tileset"
L.CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Select tiles from the tileset to create a stamp. Only works in manual mode."

L_PLU.NUM_GRAPHICS_CUSTOMIZED = {
	[-1] = "$1 image customized",
	[-2] = "$1 images customized",
}
L_PLU.NUM_SOUNDS_CUSTOMIZED = {
	[-1] = "$1 sound effect customized",
	[-2] = "$1 sound effects customized",
}
