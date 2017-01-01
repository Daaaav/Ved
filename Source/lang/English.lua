-- Language file for Ved
-- b17

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)"

OUTDATEDLOVE = "Your version of L{ve is outdated. Please use version 0.9.0 or higher. You can download the latest version of L{ve from http://love2d.org/.",
UNKNOWNSTATE = "Unknown state ($1), jumped to from state $2",
FATALERROR = "FATAL ERROR: ",
FATALEND = "Please close the game and try again. And if you're Dav, please fix it.",

OSNOTRECOGNIZED = "Your operating system ($1) is not recognized! Falling back to default filesystem functions; levels are stored in:\n\n$2",
MAXTRINKETS = "The maximum amount of trinkets (20) has been reached in this level.",
MAXTRINKETS_BYPASS = "The maximum amount of trinkets (20) has been reached in this level.\n\nAdding any more will cause glitches and/or inconsistencies when loading the level in VVVVVV, and it is recommended not to do so. Are you sure you want to bypass the limit?",
MAXCREWMATES = "The maximum amount of crewmates (20) has been reached in this level.",
MAXCREWMATES_BYPASS = "The maximum amount of crewmates (20) has been reached in this level.\n\nAdding any more will cause glitches and/or inconsistencies when loading the level in VVVVVV, and it is recommended not to do so. Are you sure you want to bypass the limit?",
EDITINGROOMTEXTNIL = "Existing room text we were editing is nil!",
STARTPOINTNOLONGERFOUND = "The old start point can no longer be found!",
UNSUPPORTEDTOOL = "Unsupported tool! Tool: ",
SURENEWLEVEL = "Are you sure you want to make a new level? You will lose any unsaved content.",
SURELOADLEVEL = "Are you sure you want to load a level? You will lose any unsaved content.",
COULDNOTGETCONTENTSLEVELFOLDER = "Could not get contents of levels folder. Please check if $1 exists and try again.",
MAPSAVEDAS = "Map image saved as $1 in the folder $2!",
RAWENTITYPROPERTIES = "You can change the raw property values of this entity here.",
UNKNOWNENTITYTYPE = "Unknown entity type $1",
METADATAENTITYCREATENOW = "The metadata entity does not exist yet. Create it now?\n\nThe metadata entity is a hidden entity that can be added to VVVVVV levels to hold extra data used by Ved, like the level notepad, flag names, and other things.",
WARPTOKENENT404 = "Warp token entity no longer exists!",
SPLITFAILED = "Split failed miserably! Do you have too many lines between a text command and a speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "There are no flags left, so one or more new flag labels in this script cannot be associated with any flag number. Trying to run this script in VVVVVV may break. Consider removing all references to flags you no longer need and try again.\n\nLeave the editor?",
LEVELOPENFAIL = "Unable to open $1.vvvvvv.",
SIZELIMITSURE = "The maximum size of a level is 20 by 20.\n\nExceeding this limit will cause glitches and inconsistencies when loading the level in VVVVVV. It is strongly recommended not to do this, unless you are only testing. Are you sure you want to bypass the limit?",
SIZELIMIT = "The maximum size of a level is 20 by 20.\n\nThe level size will be changed to $1 by $2 instead.",
SCRIPTALREADYEXISTS = "Script \"$1\" already exists!",
FLAGNAMENUMBERS = "Flag names cannot be only numbers.",
FLAGNAMECHARS = "Flag names cannot contain (, ), , or spaces.",
FLAGNAMEINUSE = "The flag name $1 is already in use by flag $2",
DIFFSELECT = "Select the level to compare to. The level you select now will be treated as being an older version.",
SUREQUIT = "Are you sure you want to quit? You will lose any unsaved content.",
SCALEREBOOT = "The new scale settings will take effect after rebooting Ved.",
NAMEFORFLAG = "Name for flag $1:",
SCRIPT404 = "Script \"$1\" does not exist!",
ENTITY404 = "Entity #$1 no longer exists!",
GRAPHICSCARDCANVAS = "Sorry, it seems like your graphics card does not support this feature!",
SUREDELETESCRIPT = "Are you sure you want to delete the script \"$1\"?",
SUREDELETENOTE = "Are you sure you want to delete this note?",
THREADERROR = "Thread error!",
NUMUNSUPPORTEDPLUGINS = "You have $1 plugins that are not supported in this version.",
WHATDIDYOUDO = "What did you do?!",
UNDOFAULTY = "What are you doing?",
SOURCEDESTROOMSSAME = "Source and destination rooms are the same!",
UNKNOWNUNDOTYPE = "Unknown undo type \"$1\"!",
MDEVERSIONWARNING = "This level appears to have been made in a more recent version of Ved, and may contain some data which will be lost when you save this level.",
LEVELFAILEDCHECKS = "This level failed $1 check(s). The issues may have been fixed automatically, but it's possible this will still result in crashes and inconsistencies.",
FORGOTPATH = "You forgot to specify a path!",
MDENOTPASSED = "Caution: metadata entity not passed to savelevel()!",
RESTARTVEDLANG = "After changing the language, you need to restart Ved before the change will take effect.",

SELECTCOPY1 = "Select the room to copy",
SELECTCOPY2 = "Select the location to copy this room to",
SELECTSWAP1 = "Select the first room to swap",
SELECTSWAP2 = "Select the second room to swap",

TILESETCHANGEDTO = "Tileset changed to $1",
TILESETCOLORCHANGEDTO = "Tileset color changed to $1",
ENEMYTYPECHANGED = "Enemy type changed",

CHANGEDTOMODE = "Changed to $1 tile placement", -- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODEAUTO = "automatic",
CHANGEDTOMODEMANUAL = "manual",
CHANGEDTOMODEMULTI = "multi-tileset",

BUSYSAVING = "Saving...",
SAVEDLEVELAS = "Saved level as $1.vvvvvv",

ROOMCUT = "Room cut to clipboard",
ROOMCOPIED = "Copied room to clipboard",
ROOMPASTED = "Pasted room",

BOUNDSTOPLEFT = "Click the top left corner of the bounds",
BOUNDSBOTTOMRIGHT = "Click the bottom right corner",

TILE = "Tile $1",
HIDEALL = "  Hide all  ",
SHOWALL = "  Show all  ",
SCRIPTEDITOR = "Script editor",
FILE = "File",
NEW = "New",
OPEN = "Open",
SAVE = "Save",
UNDO = "Undo",
REDO = "Redo",
COMPARE = "Compare",
STATS = "Stats",
SCRIPTUSAGES = "Usages",
EDITTAB = "Edit",
COPYSCRIPT = "Copy script",
SEARCHSCRIPT = "Search",
GOTOLINE = "Go to line",
GOTOLINE2 = "Go to line:",
INTERNALON = "Int.sc is off",
INTERNALOFF = "Int.sc is on",
VIEW = "View",
SYNTAXHLOFF = "Syntax HL: on",
SYNTAXHLON = "Syntax HL: off",
TEXTSIZEN = "Text size: N",
TEXTSIZEL = "Text size: L",
INSERT = "Insert",
HELP = "Help",
INTSCRWARNING_NOLOADSCRIPT = "Load script required!",
INTSCRWARNING_BOXED = "Direct script box/terminal reference!\n\n",
COLUMN = "Column: ",

BTN_OK = "OK",
BTN_CANCEL = "Cancel",
BTN_YES = "Yes",
BTN_NO = "No",
BTN_APPLY = "Apply",
BTN_QUIT = "Quit",

COMPARINGTHESE = "Comparing $1.vvvvvv to $2.vvvvvv",
COMPARINGTHESENEW = "Comparing (unsaved level) to $1.vvvvvv",

RETURN = "Return",
CREATE = "Create",
GOTO = "Go to",
DELETE = "Delete",
RENAME = "Rename",
CHANGEDIRECTION = "Change direction",
DIRECTION = "Direction->",
UP = "up",
DOWN = "down",
LEFT = "left",
RIGHT = "right",
TESTFROMHERE = "Test from here",
FLIP = "Flip",
CYCLETYPE = "Change type",
GOTODESTINATION = "Go to destination",
GOTOENTRANCE = "Go to entrance",
CHANGECOLOR = "Change color",
EDITTEXT = "Edit text",
COPYTEXT = "Copy text",
EDITSCRIPT = "Edit script",
OTHERSCRIPT = "Change script name",
PROPERTIES = "Properties",
CHANGETOHOR = "Change to horizontal",
CHANGETOVER = "Change to vertical",
RESIZE = "Move/Resize",
CHANGEENTRANCE = "Move entrance",
CHANGEEXIT = "Move exit",
BUG = "[Bug!]",

VEDOPTIONS = "Ved options",
LEVELOPTIONS = "Level options",
MAP = "Map",
SCRIPTS = "Scripts",
SEARCH = "Search",
SENDFEEDBACK = "Send Feedback",
LEVELNOTEPAD = "Level notepad",
PLUGINS = "Plugins",

BACKB = "Back <<",
MOREB = "More >>",
AUTOMODE = "Mode: auto",
AUTO2MODE = "Mode: multi",
MANUALMODE = "Mode: manual",
PLATFORMSPEED = "Platf. spd.: $1",
ENEMYTYPE = "Enemy type: $1",
PLATFORMBOUNDS = "Platf. bounds",
WARPDIR = "Warp dir: $1",
ENEMYBOUNDS = "Enemy bounds",
ROOMNAME = "Roomname",
ROOMOPTIONS = "Room options",
ROTATE180 = "Rotate 180deg",
HIDEBOUNDS = "Hide bounds",
SHOWBOUNDS = "Show bounds",

ROOMPLATFORMS = "Room platforms", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Room enemies",

OPTNAME = "Name",
OPTBY = "By",
OPTWEBSITE = "Website",
OPTDESC = "Desc", -- If necessary, you can span multiple lines by using \n
OPTSIZE = "Size",
OPTMUSIC = "Music",
CAPNONE = "NONE",
ENTERLONGOPTNAME = "Level name:",

SOLID = "Solid",
NOTSOLID = "Not solid",

TSCOLOR = "Color $1",

ONETRINKETS = "T:",
ONECREWMATES = "C:",
ONEENTITIES = "E:",

LEVELSLIST = "Levels",
LOADTHISLEVEL = "Load this level: ",
ENTERNAMESAVE = "Enter name to save as: ",
SEARCHFOR = "Search for: ",

VERSIONERROR = "Unable to check version.",
VERSIONUPTODATE = "Your version of Ved is up-to-date.",
VERSIONOLD = "Update available! Latest version: $1",
VERSIONCHECKING = "Checking for updates...",
VERSIONDISABLED = "Update check disabled",

SAVESUCCESS = "Saved successfully!",
SAVENOSUCCESS = "Saving not successful! Error: ",

EDIT = "Edit",
EDITWOBUMPING = "Edit without bumping",
COPYNAME = "Copy name",
COPYCONTENTS = "Copy contents",
DUPLICATE = "Duplicate",

NEWSCRIPTNAME = "Name:",
CREATENEWSCRIPT = "Create new script",

NEWNOTENAME = "Name:",
CREATENEWNOTE = "Create new note",

ADDNEWBTN = "[Add new]",
IMAGEERROR = "[IMAGE ERROR]",

NEWNAME = "New name:",
RENAMENOTE = "Rename note",
RENAMESCRIPT = "Rename script",

LINE = "line ",

SAVEMAP = "Save map",
SAVEFULLSIZEMAP = "Save fullsize map",
COPYROOMS = "Copy room",
SWAPROOMS = "Swap rooms",

FLAGS = "Flags",
ROOM = "room",
CONTENTFILLER = "Content",

   FLAGUSED = "Used    ",
FLAGNOTUSED = "Not used",
FLAGNONAME = "No name",
USEDOUTOFRANGEFLAGS = "Used out of range flags:",

CUSTOMVVVVVVDIRECTORY = "VVVVVV folder",
CUSTOMVVVVVVDIRECTORYEXPL = "Enter the full path to your VVVVVV directory here, if it is not \"$1\" (else leave it blank). Do not include the directory called \"levels\" here, nor a trailing (back)slash.",
LANGUAGE = "Language",
DIALOGANIMATIONS = "Dialog animations",
ALLOWLIMITBYPASS = "Allow bypassing of limits",
FLIPSUBTOOLSCROLL = "Flip subtool scrolling direction",
ADJACENTROOMLINES = "Indicators of tiles in adjacent rooms",
ASKBEFOREQUIT = "Ask before quitting",
COORDS0 = "Display coordinates as starting at 0 (as in internal scripting)",
ALLOWDEBUG = "Enable debug mode",
SHOWFPS = "Show FPS counter",
IIXSCALE = "2x scale",
CHECKFORUPDATES = "Check for updates",

SCRIPTUSAGESROOMS = "$1 usages in rooms: $2",
SCRIPTUSAGESSCRIPTS = "$1 usages in scripts: $2",

SCRIPTSPLIT = "Split",
SPLITSCRIPT = "Split scripts",
COUNT = "Count: ",
SMALLENTITYDATA = "data",

-- Stats screen
AMOUNTSCRIPTS = "Scripts:",
AMOUNTUSEDFLAGS = "Flags:",
AMOUNTENTITIES = "Entities:",
AMOUNTTRINKETS = "Trinkets:",
AMOUNTCREWMATES = "Crewmates:",
AMOUNTINTERNALSCRIPTS = "Internal scripts:",
TILESETUSSAGE = "Tileset usage",
TILESETSONLYUSED = "(only rooms having tiles are counted)",
AMOUNTROOMSWITHNAMES = "Rooms having a name:",
PLACINGMODEUSAGE = "Tile placing modes:",
AMOUNTLEVELNOTES = "Level notes:",
AMOUNTFLAGNAMES = "Flag names:",
TILESUSAGE = "Tiles usage",


ENTITYINVALIDPROPERTIES = "Entity at [$1 $2] has $3 invalid properties!",
ROOMINVALIDPROPERTIES = "LevelMetadata for room #$1 has $2 invalid properties!",
UNEXPECTEDSCRIPTLINE = "Unexpected script line without script: $1",
MAPWIDTHINVALID = "Map width is invalid: $1",
MAPHEIGHTINVALID = "Map height is invalid: $1",
LEVMUSICEMPTY = "Level music is empty!",
NOT400ROOMS = "#levelMetadata <> 400!!",
MOREERRORS = "$1 more",

DEBUGMODEON = "Debug mode on",
FPS = "FPS",
STATE = "State",
MOUSE = "Mouse",

BLUE = "Blue",
RED = "Red",
CYAN = "Cyan",
PURPLE = "Purple",
YELLOW = "Yellow",
GREEN = "Green",
GRAY = "Gray",
PINK = "Pink",
BROWN = "Brown",
RAINBOWBG = "Rainbow BG",

-- b14
SYNTAXCOLORS = "Syntax colors",
SYNTAXCOLORSETTINGSTITLE = "Scripting syntax highlighting color settings",
SYNTAXCOLOR_COMMAND = "Command",
SYNTAXCOLOR_GENERIC = "Generic",
SYNTAXCOLOR_SEPARATOR = "Separator",
SYNTAXCOLOR_NUMBER = "Number",
SYNTAXCOLOR_TEXTBOX = "Textbox",
SYNTAXCOLOR_ERRORTEXT = "Unrecognized command",
SYNTAXCOLOR_CURSOR = "Cursor",
SYNTAXCOLOR_FLAGNAME = "Flag name",
SYNTAXCOLOR_NEWFLAGNAME = "New flag name",
RESETCOLORS = "Reset colors",
STRINGNOTFOUND = "\"$1\" was not found",

-- b17
MAL = "The level file is malformed: ", -- one of the following strings are concatenated to this
METADATACORRUPT = "Metadata is missing or corrupt.",
METADATAITEMCORRUPT = "Metadata for $1 is missing or corrupt.",
TILESCORRUPT = "Tiles missing or corrupt.",
ENTITIESCORRUPT = "Entities missing or corrupt.",
LEVELMETADATACORRUPT = "Room metadata missing or corrupt.",
SCRIPTCORRUPT = "Scripts missing or corrupt.",

}

toolnames = {

"Wall",
"Background",
"Spike",
"Trinket",
"Checkpoint",
"Disappearing platform",
"Conveyor",
"Moving platform",
"Enemy",
"Gravity line",
"Roomtext",
"Terminal",
"Script box",
"Warp token",
"Warp line",
"Crewmate",
"Start point"

}

subtoolnames = {

[1] = {"1x1 brush", "3x3 brush", "5x5 brush", "7x7 brush", "9x9 brush", "Fill horizontally", "Fill vertically", "Fill entire room", "Potato for Doing Things that are Magical"},
[2] = {"1x1 brush", "3x3 brush", "5x5 brush", "7x7 brush", "9x9 brush", "Fill horizontally", "Fill vertically", "Fill entire room", "Potato for Doing Things that are Magical"},
--[3] = {"1 bottom", "3 bottom", "5 bottom", "7 bottom", "9 bottom", "Expand L+R", "Expand L", "Expand R"},
[3] = {"Auto 1", "Auto expand L+R", "Auto expand L", "Auto expand R"},
[4] = {},
[5] = {"Upright", "Flipped"},
[6] = {},
[7] = {"Small R", "Small L", "Large R", "Large L"},
[8] = {"Down", "Up", "Left", "Right"},
[9] = {"Down", "Up", "Left", "Right"},
[10] = {"Horizontal", "Vertical"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Entrance", "Exit"},
[15] = {},
[16] = {"Pink", "Yellow", "Red", "Green", "Blue", "Cyan", "Random"},
[17] = {"Face right", "Face left"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "A"

}

warpdirchangedtext = {

[0] = "Room warping disabled",
[1] = "Warp direction set to horizontal",
[2] = "Warp direction set to vertical",
[3] = "Warp direction set to all directions",

}

langtilesetnames = {

short0 = "Space Stn.",
long0 = "Space Station",
short1 = "Outside",
long1 = "Outside",
short2 = "Lab",
long2 = "Lab",
short3 = "Warp Zone",
long3 = "Warp Zone",
short4 = "Ship",
long4 = "Ship",

}

ERR_VEDHASCRASHED = "Ved has crashed!"
ERR_VEDVERSION = "Ved version:"
ERR_LOVEVERSION = "LÖVE version:"
ERR_STATE = "State:"
ERR_OS = "OS:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(not loaded)"
ERR_PLUGINSNONE = "(none)"
ERR_PLEASETELLDAV = "Please tell Dav999 about this problem.\n\n\nDetails: (press ctrl/cmd+C to copy to the clipboard)\n\n"

ERR_PLUGINERROR = "Plugin error!"
ERR_FILE = "File to be edited:"
ERR_FILEEDITORS = "Plugins that edit this file:"
ERR_CURRENTPLUGIN = "Plugin that triggered the error:"
ERR_PLEASETELLAUTHOR = "A plugin was supposed to make an edit to code in Ved, but the code to be replaced was not found.\nIt is possible that this was caused by a conflict between two plugins, or a Ved update broke\nthis plugin.\n\nDetails: (press ctrl/cmd+C to copy to the clipboard)\n\n"
ERR_CONTINUE = "You can continue by pressing ESC or enter, but note this failed edit may cause issues."
ERR_REPLACECODE = "Failed to find this in %s.lua:"
ERR_REPLACECODEPATTERN = "Failed to find this in %s.lua (as pattern):"
ERR_LINESTOTAL = "%i lines in total"

ERR_SAVELEVEL = "To save a copy of your level, press S"
ERR_SAVESUCC = "Level saved successfully as %s!"
ERR_SAVEERROR = "Save error! %s"


diffmessages = {
	pages = {
		levelproperties = "Level properties",
		changedrooms = "Changed rooms",
		changedroommetadata = "Changed room metadata",
		entities = "Entities",
		scripts = "Scripts",
		flagnames = "Flag names",
		levelnotes = "Level notes",
	},
	levelpropertiesdiff = {
		Title = "Name was changed from \"$1\" to \"$2\"",
		Creator = "Author was changed from \"$1\" to \"$2\"",
		website = "Website was changed from \"$1\" to \"$2\"",
		Desc1 = "Desc1 was changed from \"$1\" to \"$2\"",
		Desc2 = "Desc2 was changed from \"$1\" to \"$2\"",
		Desc3 = "Desc3 was changed from \"$1\" to \"$2\"",
		mapsize = "Map size was changed from $1x$2 to $3x$4",
		mapsizenote = "NOTE: Map size was changed from $1x$2 to $3x$4.\\o\nRooms outside of $5x$6 are not listed.\\o",
		levmusic = "Level music was changed from $1 to $2",
	},
	rooms = {
		added1 = "Added ($1,$2) ($3)\\G",
		added2 = "Added ($1,$2) ($3 -> $4)\\G",
		changed1 = "Changed ($1,$2) ($3)\\Y",
		changed2 = "Changed ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Cleared all tiles in ($1,$2) ($3)\\R",
		cleared2 = "Cleared all tiles in ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Room $1,$2:",
		changed1 = "Room $1,$2 ($3):",
		roomname = "Roomname changed from \"$1\" to \"$2\"\\Y",
		roomnameremoved = "Roomname \"$1\" removed\\R",
		roomnameadded = "Room named \"$1\"\\G",
		tileset = "Tileset $1 tilecol $2 changed to tileset $3 tilecol $4\\Y",
		platv = "Platform speed changed from $1 to $2\\Y",
		enemytype = "Enemy type changed from $1 to $2\\Y",
		platbounds = "Platform bounds changed from $1,$2,$3,$4 to $5,$6,$7,$8\\Y",
		enemybounds = "Enemy bounds changed from $1,$2,$3,$4 to $5,$6,$7,$8\\Y",
		directmode01 = "Direct mode enabled\\G",
		directmode10 = "Direct mode disabled\\R",
		warpdir = "Warp direction changed from $1 to $2\\Y",
	},
	entities = {
		added = "Added entity type $1 at position $2,$3 in room ($4,$5)\\G",
		removed = "Removed entity type $1 from position $2,$3 in room ($4,$5)\\R",
		changed = "Changed entity type $1 at position $2,$3 in room ($4,$5)\\Y",
		changedtype = "Changed entity type $1 to type $2 at position $3,$4 in room ($5,$6)\\Y",
		multiple1 = "Changed entities at position $1,$2 in room ($3,$4):\\Y",
		multiple2 = "to:",
		addedmultiple = "Added entities at position $1,$2 in room ($3,$4):\\G",
		removedmultiple = "Removed entities at position $1,$2 in room ($3,$4):\\R",
		entity = "Type $1",
		incomplete = "Not all entities were handled! Please report this to Dav.\\r",
	},
	scripts = {
		added = "Added script \"$1\"\\G",
		removed = "Removed script \"$1\"\\R",
		edited = "Edited script \"$1\"\\Y",
	},
	flagnames = {
		added = "Set name for flag $1 to \"$2\"\\G",
		removed = "Removed name \"$1\" for flag $2\\R",
		edited = "Changed name for flag $1 from \"$2\" to \"$3\"\\Y",
	},
	levelnotes = {
		added = "Added level note \"$1\"\\G",
		removed = "Removed level note \"$1\"\\R",
		edited = "Edited level note \"$1\"\\Y",
	},
	mde = {
		added = "Metadata entity was added.\\G",
		removed = "Metadata entity was removed.\\R",
	},
}


-- Help articles moved to devstrings, please don't translate them yet as they're still subject to big, unmentioned changes.