-- Language file for Ved
-- 1.2.2

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)"

OUTDATEDLOVE = "Your version of L{ve is outdated. Please use version 0.9.0 or higher. You can download the latest version of L{ve from https://love2d.org/.",
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
PAUSEDRAWUNFOCUSED = "Do not render when the window is unfocused",
ENABLEOVERWRITEBACKUPS = "Make backups of level files that are overwritten",
AMOUNTOVERWRITEBACKUPS = "Number of backups to keep per level",
SCALE = "Scale",

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

-- 1.1.0
LOADSCRIPTMADE = "Load script created",
COPY = "Copy",
CUSTOMSIZE = "Custom brush size: $1x$2",
SELECTINGA = "Selecting - click top left",
SELECTINGB = "Selecting: $1x$2",
TILESETSRELOADED = "Tilesets and sprites reloaded",

-- 1.2.0
BACKUPS = "Backups",
BACKUPSOFLEVEL = "Backups of level $1",
LASTMODIFIEDTIME = "Originally last modified", -- List header
OVERWRITTENTIME = "Overwritten", -- List header
SAVEBACKUP = "Save to VVVVVV folder",
DATEFORMAT = "Date format",
CUSTOMDATEFORMAT = "Custom date format",
SAVEBACKUPNOBACKUP = "Make sure to choose a unique name for this if you do not want to overwrite anything, as NO backup will be made in this case!",

-- 1.2.4
AUTOSAVECRASHLOGS = "Automatically save crash logs",
MOREINFO = "More info",
COPYLINK = "Copy link",
SCRIPTDISPLAY = "Show",
SCRIPTDISPLAY_USED = "Used",
SCRIPTDISPLAY_UNUSED = "Unused",
SCRIPTDISPLAY_SHOWING = "Showing $1",

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

[1] = {"1x1 brush", "3x3 brush", "5x5 brush", "7x7 brush", "9x9 brush", "Fill horizontally", "Fill vertically", "Custom brush size", "Potato for Doing Things that are Magical"},
[2] = {"1x1 brush", "3x3 brush", "5x5 brush", "7x7 brush", "9x9 brush", "Fill horizontally", "Fill vertically", "Custom brush size", "Potato for Doing Things that are Magical"},
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
ERR_TIMESINCESTART = "Time since start:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(not loaded)"
ERR_PLUGINSNONE = "(none)"
ERR_PLEASETELLDAV = "Please tell Dav999 about this problem.\n\n\nDetails: (press ctrl/cmd+C to copy to the clipboard)\n\n"
ERR_INTERMEDIATE = " (intermediate version)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (too new)"

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
ERR_LOGSAVED = "More information can be found in the crash log:\n%s"


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



LH = {

-- These are the help articles.

--[[

-------------------------------------------
A T T E N T I O N   T R A N S L A T O R S :
-------------------------------------------


The lines in the help do not automatically wrap, so their lengths should not exceed the width of the window!

Use the following as a ruler:
----------------------------------------------------------------------------------[]-

The scrollbar [] is the limit, however formatting/control characters may cause the line to be smaller/wider.
You can also remember the number 83, when you're in that column, you've reached the limit (subtracting the amount of invisible formatting characters)


If you'd rather not translate the help articles, it's no big deal!


-------------------------------------------


Flags after \:
h - double font size for headers (remember to keep an extra line blank for that)
# - anchor (not yet implemented). There will be a way to switch/link to anchors quickly.
0..9 - display image 0..9 on this line (array index in imgs starts at 0, and remember to keep lines blank to accommodate for the image height)
^ - Put this before the image number, shift image number by 10. So ^4 makes image 14, ^^4 makes image 24. And 3^1^56 makes images 3, 11, 25 and 26.
_ - Put this before the image number to decrease the image number by 10.
> - Put this before the image number to shift further images to the right by 8 pixels. This can be repeated, so 0>>>>1 puts image 0 at x=0 and image 1 at x=32.
< - Same, but shift to the left.
n - normal text
r - red text
g - gray text
w - white text
b - blue text
o - orange text
v - green text
c - Cyan
y - Yellow
p - Purple
V - Dark green
z - black text
Z - dark gray text
C - cyan text (Viridian)
P - pink text (Violet)
Y - yellow text (Vitellary)
R - red text (Vermilion)
G - green text (Verdigris)
B - blue text (Victoria)
& - Interpret next color code as background color instead of text color
l - Link color (not yet supported)
- - Horizontal line
+ - expand background color to end of line
= - underline header (on next line)
) - Return to previous state

Flags can be combined, like \rh or \hr for a red header
Invalid flags will be ignored

1234567890123456789012

Room for 82 characters on a line (85, but the last three characters will have a scrollbar if it is needed. 
----------------------------------------------------------------------------------[]-
]]

{
subj = "Return",
imgs = {},
cont = [[
\)
]]
},

{
subj = "Getting started",
imgs = {},
cont = [[
Getting started\wh#
\C=

This article will help you get started with using Ved. To get started with using
the editor, you need to load a level, or create a new one.


The editor\h#

On the left side, you will find the tools selection. Most tools have subtools that
will be listed to the right of it. To switch between tools, use their respective
shortcut or scroll with shift or ctrl held down. To switch between subtools, you
can scroll anywhere. For more information about the tools, refer to the ¤Tools\nwl
help page.
Entities can be right clicked for a menu of actions for that entity. To delete
entities without having to use the context menu, shift-right click on them.
On the right side of the screen, you will find many buttons and options. The upper
buttons are related to the entire level, the lower buttons (under Room options)
are specific to the current room. For more information about those buttons, refer
to the respective help pages, where available.

Levels folder\h#

Ved will normally use the same folder for storing levels as VVVVVV does, so it is
easy to switch from VVVVVV's level editor to Ved and vice versa. If Ved does not
detect your VVVVVV folder correctly, you can enter a custom path in the Ved
options.
]]
},

{
subj = "Tile placement modes",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
Tile placement modes\wh#
\C=

Ved supports three different modes to draw tiles.

     Automatic mode\h#0

          This is the mode that is easiest to use. In this mode, you can draw
          walls and backgrounds and the edges will automatically get placed
          correctly. However, while editing in this mode, all walls and
          backgrounds in the room must use the same tileset and color.

     Multi-tileset mode\h#1

          This is similar to automatic mode, except that you can have multiple
          different tilesets in the same room. That is, changing the tileset will
          not affect already-placed walls and backgrounds, and you can draw in
          multiple different types of tiles in the same room.

     Manual mode\h#2

          Also called Direct Mode, in this mode you can place down any tile
          manually, so you are not bound to the pre-defined tileset combinations
          and edges will not automatically get added to walls, giving you complete
          control over how the room will look. However, this editing mode is often
          slower to use.
]]
},

{
subj = "Tools",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
Tools\wh#
\C=

You can use the following tools to fill rooms in your level:

\0
   Wall\h#


The wall tool can be used to place walls.

\1
   Background\h#


The background tool can be used to place backgrounds.

\2
   Spike\h#


The spike tool can be used to place spikes. You can use the expand subtool to
place spikes on a surface with one click (or slide).

\3
   Trinket\h#


The trinket tool can be used to place trinkets. Please note that there is a limit
of twenty trinkets in a level.

\4
   Checkpoint\h#


The checkpoint tool can be used to place checkpoints.

\5
   Disappearing platform\h#


The disappearing platform tool can be used to place disappearing platforms.

\6
   Conveyor\h#


The conveyor tool can be used to place conveyors.

\7
   Moving platform\h#


The moving platform tool can be used to place moving platforms.

\8
   Enemy\h#


The enemy tool can be used to place enemies. The shape and color of the enemy are
determined by the enemy type setting and the tileset (color) respectively.

\9
   Gravity line\h#


The gravity line tool can be used to place gravity lines.

\^0
   Roomtext\h#


The roomtext tool can be used to place text.

\^1
   Terminal\h#


The terminal tool can be used to place terminals. First place the terminal, then
type a name for the script. For more information about scripting, please refer to
the scripting references.

\^2
   Script box\h#


The script box tool can be used to place script boxes. First click on the top left
corner, then on the bottom right corner, then type a name for the script. For more
information about scripting, please refer to the scripting references.

\^3
   Warp token\h#


The warp token tool can be used to place warp tokens. First click where the
entrance should be, then where the exit should be.

\^4
   Warp line\h#


The warp line tool can be used to place warp lines. Please note that warp lines
can only be placed on the edges of a room.

\^5
   Crewmate\h#


The crewmate tool can be used to place missing crewmates that can be rescued. If
all crewmates are rescued, the level will be finished. Please note that there is
a limit of twenty missing crewmates in a level.

\^6
   Start point\h#


The start point tool can be used to place the start point.
]]
},
----------------------------------------------------------------------------------[]-
{
subj = "Script editor",
imgs = {},
cont = [[
Script editor\wh#
\C=

With the script editor, you can manage and edit scripts in your level.


Flag names\h#

For convenience and script readability, it is possible to use flag names instead
of numbers. When you use a name instead of a number, a number will automatically
be associated with that name, in the background. It is also possible to choose
which number to use for which flag name.

Internal scripting mode\h#

To use internal scripting in Ved, you can enable internal scripting mode in the
editor, to handle all commands in that script as internal scripting. However, you
need to make sure that script is loaded with iftrinkets() or ifflag(). For more
information about internal scripting, check the internal scripting reference.

Splitting scripts\h#

It is possible to split a script in two scripts with the script editor. After
putting the text cursor on the first line you want to be in the new script, click
the Split button and enter the name of the new script. The lines before the cursor
will remain in the original script, the lines from the cursor onward will be moved
to the new script.

Jumping to scripts\h#

On lines with an iftrinkets, ifflag, customiftrinkets or customifflag command, it
is possible to jump to the given script by clicking the "Go to" button when the
cursor is on that line. You can also press ¤ctrl+right¤ to do this, and you can\nw
use ¤ctrl+left¤ to jump one step back through the chain to where you came from.\nw
]]
},

{
subj = "Shortcuts",
imgs = {},
cont = [[
Editor shortcuts\wh#
\C=

Most shortcuts that can be used in VVVVVV can also be used in Ved.

F1¤  Change tileset\C
F2¤  Change color\C
F3¤  Change enemies\C
F4¤  Enemy bounds\C
F5¤  Platform bounds\C

F10¤  Manual/automatic mode (direct mode/undirect mode)\C

W¤  Change warp direction\C
E¤  Change roomname\C

L¤  Load map\C
S¤  Save map\C

Z¤  3x3 brush (walls and backgrounds)\C
X¤  5x5 brush (")\C

< ¤and¤ >¤  change tool\CnC
Ctrl/Cmd+< ¤and¤ Ctrl/Cmd+>¤  change subtool\CnC

More shortcuts\h#

Ved also introduces a few shortcuts.

Main editor\gh#

Ctrl+P¤  Jump to the room containing the startpoint\C
Ctrl+S¤  Quicksave\C
Ctrl+X¤  Cut room to the clipboard\C
Ctrl+C¤  Copy room to the clipboard\C
Ctrl+V¤  Paste room from clipboard (if valid)\C
Ctrl+D¤  Compare this level to another level\C
Ctrl+Z¤  Undo\C
Ctrl+Y¤  Redo\C
Ctrl+F¤  Search\C
Ctrl+/¤  Level notepad\C
Ctrl+F1¤  Help\C
(NOTE: On Mac, replace ctrl by cmd)
N¤  display all tile numbers\C
M¤  Show map\C
Q¤  Go to room (type in coordinates as four digits)\C
/¤  Scripts\C
[¤  lock Y of mouse while held down (for drawing horizontal lines more easily)\C
]¤  lock X of mouse while held down (for drawing vertical lines more easily)\C
F11¤  reload tilesets and sprites\C

Script editor\gh#

Ctrl+F¤  Find\C
Ctrl+G¤  Go to line\C
Ctrl+right¤  Jump to script in conditional command\C
Ctrl+left¤  Jump one step back\C

Script list\gh#

N¤  Create new script\C
F¤  Go to flags list\C
/¤  Go to topmost/latest script\C
]]
},

--[[
\-
Test thing

command¤(§¤required text¤,§¤required number¤,§¤optional text¤,§¤optional number¤)\wnvnynGnY(

\-
]]

{
subj = "Simp.script reference",
imgs = {},
cont = [[
Simplified scripting reference\wh#
\C=

VVVVVV's simplified scripting language is a basic language that can be used to
script VVVVVV levels.
Note: whenever something is between quotes, it needs to be typed without them.


say¤([lines[,color]] .. "]]" .. [[)\h#w

Display a text box. Without any arguments, this will make a text box with one
line, and by default this will result in a centered terminal text box. The color
argument can be a color, or the name of a crewmate.
If you use a color and a rescuable crewmate with that color is in the room, then
the text box will be displayed above that crewmate.

reply¤([lines])\h#w

Display a text box for Viridian. Without the lines argument, this will make a text
box with one line.

delay¤(n)\h#w

Delays further action by n ticks. 30 ticks is almost one second.

happy¤([crewmate])\h#w

Makes a crewmate happy. Without an argument, this will make Viridian happy. You
can also use "all", "everyone" or "everybody" as an argument to make everybody
happy.

sad¤([crewmate])\h#w

Makes a crewmate sad. Without an argument, this will make Viridian sad. You
can also use "all", "everyone" or "everybody" as an argument to make everybody
sad.

flag¤(flag,on/off)\h#w

Turn a given flag on or off. For example, flag(4,on) will turn flag number 4 on.
There are 100 flags, numbered from 0 to 99.
By default, all flags are off when you start playing a level.
Note: In Ved, you can also use flag names instead of the numbers.

ifflag¤(flag,scriptname)\h#w

If a given flag is ON, then go to script with name scriptname.
If a given flag is OFF, continue in the current script.
Example:
ifflag(20,cutscene) - If flag 20 is ON, go to script "cutscene", else continue in
                      the current script.
Note: In Ved, you can also use flag names instead of the numbers.

iftrinkets¤(number,scriptname)\h#w

If your amount of trinkets >= number, go to script with name scriptname.
If your amount of trinkets < number, continue in the current script.
Example:
iftrinkets(3,enoughtrinkets) - If you have 3 or more trinkets, the script
                               "enoughtrinkets" will be run, else the current
                               script will continue.
It is common practise to use 0 as a minimum amount of trinkets, as a way to load
a script in any case.

destroy¤(something)\h#w

Valid arguments can be:
warptokens - Remove all warp tokens from the room until you re-enter the room.
gravitylines - Remove all gravity lines from the room until you re-enter the room.
The option "platforms" also exists, but it doesn't work properly.

music¤(number)\h#w

Change the song to a certain song number.
For the list of song numbers, refer to the "Lists reference" article.

playremix\h#w

Plays the remix of Predestined Fate as music.

flash\h#w

Flashes the screen white, makes a bang sound and shakes the screen for a bit.

map¤(on/off)\h#w

Turn the map on or off. If you turn the map off, it will display "NO SIGNAL" until
you turn it on again. Rooms will still be uncovered while the map is off to be
visible when the map is turned on.

squeak¤(crewmate/on/off)\h#w

Make a crewmate squeak, or turn the squeak sound when a text box is displayed on
or off.

speaker¤(color)\h#w

Changes the color and position of the next text boxes created with the "say"
command. This can be used instead of giving a second argument to "say".
]]
},

{
subj = "Int. script reference",
imgs = {},
cont = [[
Internal scripting reference\wh#
\C=

The internal scripting provides more power to scripters, but is also a bit more
complex than simplified scripting.

To use internal scripting in Ved, you can enable internal scripting mode in the
editor, to handle all commands in that script as internal scripting. However, you
need to make sure that script is loaded with iftrinkets() or ifflag().

Color coding:\w
Normal - Should be safe, worst case scenario is VVVVVV crashing because you made a
         mistake.
Blue¤   - Some of these don't work in custom levels, others don't make a lot of\b
         sense in custom levels, or are only half useful because they were really
         designed for the main game.
Orange¤ - These work and nothing will go wrong normally, unless you give some\o
         specific arguments to them that will cause your save data to go away.
Red¤    - Red commands shouldn't be used in custom levels because they will either\r
         unlock certain parts of the main game (which you shouldn't want a custom
         level to do, even if you say everyone has already completed the game), or
         corrupt the save data altogether.


squeak¤(color)\w#h

Makes a squeak sound from a crewmate, or a terminal sound

color - cyan/player/blue/red/yellow/green/purple/terminal

text¤(color,x,y,lines)\w#h

Store a text box in memory with color, position and number of lines. Usually, the
position command is used after the text command (and its lines of text), which
will overwrite the coordinates given here, so these are usually left as 0.

color - cyan/player/blue/red/yellow/green/purple/gray
x - The x position of the text box
y - The y position of the text box
lines - The number of lines

position¤(x,y)\w#h

Overrides the x,y of the text command and thus sets the position of the text box.

x - center/centerx/centery, or a color name
cyan/player/blue/red/yellow/green/purple
y - Only used if x is a color name. Can be above/below

endtext\w#h

Makes a text box disappear (fade out)

endtextfast\w#h

Makes a text box disappear immediately (without fading out)

speak\w#h

Shows a text box, without removing old text boxes. Also pauses the script until
you press action (unless there's a backgroundtext command above it)

speak_active\w#h

Shows a text box, and removes any old text box. Also pauses the script until you
press action (unless there's a backgroundtext command above it)

backgroundtext\w#h

If you put this command on the line above speak or speak_active, the game will not
wait until you press action after creating the text box. This can be used to
create multiple text boxes at the same time.

changeplayercolour¤(color)\w#h

Changes the player's color

color - cyan/player/blue/red/yellow/green/purple/teleporter

restoreplayercolour¤()\w#h

Changes the player's color back to cyan

changecolour¤(a,b)\w#h

Changes the color of a crewmate (note: this only works with crewmates who have
been created using the createcrewman command)

a - Color of crewmate to change cyan/player/blue/red/yellow/green/purple
b - Color to change to

alarmon\w#h

Turns the alarm on

alarmoff\w#h

Turns the alarm off

cutscene¤()\w#h

Makes cutscene bars appear

endcutscene¤()\w#h

Makes cutscene bars disappear

untilbars¤()\w#h

Wait until cutscene()/endcutscene() is completed

customifflag¤(n,script)\w#h

Same as ifflag(n,script) in simplified scripting

ifflag¤(n,script)\b#h

Same as customifflag, but loads an internal (main game) script

loadscript¤(script)\b#h

Load an internal (main game) script. Commonly used in custom levels as
loadscript(stop)

iftrinkets¤(n,script)\b#h

Same as simplified scripting, but loads an internal (main game) script

iftrinketsless¤(n,script)\b#h

Same as simplified scripting, but loads an internal (main game) script

customiftrinkets¤(n,script)\w#h

Same as iftrinkets(n,script) in simplfied scripting

customiftrinketsless¤(n,script)\w#h

Same as iftrinketsless(n,script) in simplfied scripting (but remember it is
broken)

createcrewman¤(x,y,color,mood,ai1,ai2)\w#h

Creates a crewmate (not rescuable)

mood - 0 for happy, 1 for sad
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
      faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - required if followposition is used for ai1

createentity¤(x,y,n,meta1,meta2)\o#h

Creates an entity, check the lists reference for entity numbers

n - The entity number

vvvvvvman¤()\w#h

Makes the player huge

undovvvvvvman¤()\w#h

Back to normal

hideplayer¤()\w#h

Makes the player invisible

showplayer¤()\w#h

Makes the player visible

gamestate¤(x)\o#h

Change the gamestate to the specified state number

gamemode¤(x)\b#h

teleporter to show the map, game to hide it (shows teleporters of the main game)

x - teleporter/game

blackout¤()\w#h

Make the screen black/freezes the screen

blackon¤()\w#h

Back to normal from blackout()

fadeout¤()\w#h

Fades the screen to black

fadein¤()\w#h

Fades back

befadein¤()\w#h

Instantly fade in from fadeout()

untilfade¤()\w#h

Wait until fadeout()/fadein() is completed

gotoroom¤(x,y)\w#h

Change the current room to x,y, where x and y start at 0.

x - Room x coordinate, starting at 0
y - Room y coordinate, starting at 0

gotoposition¤(x,y,f)\w#h

Change Viridian's position to x,y in this room, and f is whether you're flipped or
not. (1 for flipped, 0 for not flipped)

z - 1 for flipped, 0 for not flipped (you can also use gotoposition(x,y), then you
will have normal gravity by default)

flash¤(x)\w#h

Makes the screen white, you can change the time how long the screen should stay
white (just flash won't work, you have to use flash(5) in combination with
playef(9) and shake(20) if you want a normal flash)

x - The amount of ticks. 30 ticks is almost one second.

play¤(x)\w#h

Start playing a song with internal song number.

x - Internal song number

jukebox¤(x)\w#h

Makes a jukebox terminal white and turns off the color of all the other terminals
(in custom levels, it just seems to turn off the white color of all activated
terminals).

musicfadeout¤()\w#h

Fades out the music.

musicfadein¤()\w#h

Opposite of musicfadeout() (doesn't seem to work)

stopmusic¤()\w#h

Stops the music immediately. Equivalent to music(0) in simplified scripting.

resumemusic¤()\w#h

Opposite of stopmusic() (doesn't seem to work)

playef¤(x,n)\w#h

Play a sound effect.

n - Actually unused, and can be left out. In VVVVVV 1.x, this used to control the
offset in milliseconds at which the sound effect started.

changemood¤(colour,mood)\w#h

Changes the mood of a crewmate (only works for crewmates created with
createcrewman)

colour - cyan/player/blue/red/yellow/green/purple
mood - 0 for happy, 1 for sad

everybodysad¤()\w#h

Makes everybody sad (only for crewmates created with createcrewman and the player)

changetile¤(colour,tile)\w#h

Changes the tile of a crewmate (you can change it to any sprite in sprites.png,
and it only works for crewmates created with createcrewman)

colour - cyan/player/blue/red/yellow/green/purple/gray
tile - Tile number

face¤(a,b)\w#h

Makes the face of crewmate a point to crewmate b (only works with crewmates
created with createcrewman)

a - cyan/player/blue/red/yellow/green/purple/gray
b - same

companion¤(x)\b#h

Makes the specified crewmate a companion (as far as I remember, this also depends
on on the location on the map)

changeai¤(crewmate,ai1,ai2)\w#h

Can change the face direction of a crewmate or the walking behaviour

crewmate - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
      faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - required if followposition is used for ai1

changedir¤(colour,direction)\w#h

Just like changeai(colour,faceleft/faceright), this changes face direction.

colour - cyan/player/blue/red/yellow/green/purple
direction - 0 is left, 1 is right

walk¤(direction,x)\w#h

Makes the player walk for the specified number of ticks

direction - left/right

flipgravity¤(colour)\w#h

Flips the gravity of a certain crewmate (it won't always work on yourself)

colour - cyan/player/blue/red/yellow/green/purple

flipme\w#h

Correct vertical positioning of multiple text boxes in flip mode

tofloor\w#h

Makes the player flip to the floor if he isn't already on the floor.

flip\w#h

Make the player flip

foundtrinket¤(x)\w#h

Makes a trinket found

x - Number of the trinket

runtrinketscript\b#h

Play Passion For Exploring?

altstates¤(x)\b#h

Changes the layout of some rooms, like the trinket room in the ship before and
after the explosion, and the secret lab entrance (custom levels don't support
altstates at all)

createlastrescued¤(x,y)\b#h

Creates the last rescued crewmate at position x,y (?)

rescued¤(colour)\b#h

Makes someone rescued

missing¤(colour)\b#h

Makes someone missing

finalmode¤(x,y)\b#h

Teleports you to Outside Dimension VVVVVV, (46,54) is the initial room of the
Final Level

setcheckpoint¤()\w#h

Sets the checkpoint to the current location

textboxactive\w#h

Makes all text boxes on the screen disappear except for the last created one

ifexplored¤(x,y,script)\w#h

If x+1,y+1 is explored, go to (internal) script

iflast¤(crewmate,script)\b#h

If crewmate x was rescued last, go to script

crewmate - Numbers are used here: 2: Vitellary, 3: Vermillion, 4: Verdigris, 5
Victoria (I don't know the number for Viridian and Violet)

ifskip¤(x)\b#h

If you skip the cutscenes in No Death Mode, go to script x

ifcrewlost¤(crewmate,script)\b#h

If crewmate is lost, go to script

showcoordinates¤(x,y)\w#h

Show coordinates x,y on the map (This works for the map for custom levels)

hidecoordinates¤(x,y)\w#h

Hide coordinates x,y on the map (This works for the map for custom levels)

showship\w#h

Show the ship on the map

hideship\w#h

Hide the ship on the map

showsecretlab\w#h

Show the secret lab on the map

hidesecretlab\w#h

Hide the secret lab on the map

showteleporters¤()\b#h

Show the teleporters on the map (I guess it only shows the teleporter in Space
Station 1)

hideteleporters¤()\b#h

Hide the teleporters on the map

showtargets¤()\b#h

Show the targets on the map (unknown teleporters which show up as ?s)

hidetargets¤()\b#h

Hide the targets on the map

showtrinkets¤()\b#h

Show the trinkets on the map

hidetrinkets¤()\b#h

Hide the trinkets on the map

hascontrol¤()\w#h

Makes the player have control, however doesn't work in the middle of scripts

nocontrol¤()\w#h

The opposite of hascontrol()

specialline¤(x)\b#h

Special dialogs that show up in the main game

destroy¤(x)\w#h

Same behaviour as simplified command

x - gravitylines/warptokens/platforms

delay¤(x)\w#h

Same behaviour as simplified command

flag¤(x,on/off)\w#h

Same behaviour as simplified command

telesave¤()\r#h

Saves your game (in the regular teleporter save, so don't use it!)

befadein¤()\w#h

Instantly fade in from fadeout()

createactivityzone¤(colour)\b#h

Creates a zone where you are standing which says "Press ACTION to talk to
(Crewmate)"

createrescuedcrew¤()\b#h

Creates all rescued crewmates

trinketyellowcontrol¤()\b#h

Dialog of Vitellary when he gives you a trinket in the real game

trinketbluecontrol¤()\b#h

Dialog of Victoria when she gives you a trinket in the real game

rollcredits¤()\r#h

Makes the credits roll. It destroys your save after the credits are completed!

teleportscript¤(script)\b#h

Used to set a script which is run when you use a teleporter

clearteleportscript¤()\b#h

Clears the teleporter script set with teleporterscript(x)

moveplayer¤(x,y)\w#h

Moves the player x pixels to the right and y pixels down. Of course you can also
use negative numbers to make him move up or to the left

do¤(n)\w#h

Starts a loop block which will repeat n times

loop\w#h

Put this at the end of the loop block

leavesecretlab¤()\b#h

Turn off "secret lab mode"

shake¤(n)\w#h

Shake the screen for n ticks. This will not create a delay.

activateteleporter¤()\w#h

If there's a teleporter in the room, it will glow white and touching it will not
annihilate your save data. May not work if there are multiple teleporters.

customposition¤(x,y)\w#h

Overrides the x,y of the text command and thus sets the position of the text box,
but for crewmates, rescuable crewmates are used to position against, instead of
createentity crewmates.

x - center/centerx/centery, or a color name
cyan/player/blue/red/yellow/green/purple (rescuable)
y - Only used if x is a color name. Can be above/below

custommap¤(on/off)\w#h

The internal variant of the map command

trinketscriptmusic\w#h

Plays passion for exploring, without taking arguments(?)

startintermission2\w#h

Alternate finalmode(46,54), takes you to the final level without accepting
arguments. Crashes in timeslip.

resetgame\w#h

Resets all trinkets, collected crewmates and flags, and teleports the player to
the last checkpoint.

redcontrol\b#h

Start a conversation with Vermilion just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.

greencontrol\b#h

Start a conversation with Verdigris just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.

bluecontrol\b#h

Start a conversation with Victoria just like when you meet her in the main game
and press ENTER. Also creates an activity zone afterwards.

yellowcontrol\b#h

Start a conversation with Vitellary just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.

purplecontrol\b#h

Start a conversation with Violet just like when you meet her in the main game and
press ENTER. Also creates an activity zone afterwards.

foundlab\b#h

Plays sound effect 3, shows text box with "Congratulations! You have found the
secret lab!" Does not endtext, also has no further unwanted effects.

foundlab2\b#h

Displays the second text box you see after discovering the secret lab. Also does
not endtext, and also does not have any further unwanted effects.

entersecretlab\r#h

Actually unlocks the secret lab for the main game, which is probably an unwanted
effect for a custom level to have. Turns on secret lab mode.
]]
},

{
subj = "Lists reference",
imgs = {},
cont = [[
Lists reference\wh#
\C=

These are lists of numbers that are used in VVVVVV, mostly copied from forum
posts. Thanks to everyone who assembled these lists!


Index\w&Z+
\&Z+
#Music numbers (simplified scripting)\C&Z+l
#Music numbers (internal)\C&Z+l
#Sound effect numbers\C&Z+l
#Entities\C&Z+l
#Colors for createentity() crewmates\C&Z+l
#Enemy movement types\C&Z+l
#Gamestates\C&Z+l


Music numbers (simplified scripting)\h#

0 - Silence (no music)
1 - Pushing onwards
2 - Positive force
3 - Potential for anything
4 - Passion for exploring
5 - Presenting VVVVVV
6 - Predestined fate
7 - Popular potpurri
8 - Pipe dream
9 - Pressure cooker
10 - Paced energy
11 - Piercing the sky

Music numbers (internal)\h#

0 - Path Complete
1 - Pushing Onwards
2 - Positive Force
3 - Potential For Anything
4 - Passion For Exploring
5 - Pause
6 - Presenting VVVVVV
7 - Plenary
8 - Predestined Fate
9 - ecroF evitisoP
10 - Popular Potpurri
11 - Pipe Dream
12 - Pressure Cooker
13 - Paced Energy
14 - Piercing The Sky
15 - Predestined Fate remixed

Sound effect numbers\h#

0 - Flip to ceiling
1 - Flip back to floor
2 - Cry
3 - Trinket collected
4 - Coin collected
5 - Checkpoint touched
6 - Quicker quicksand block touched
7 - Normal quicksand block touched
8 - Gravity line touched
9 - Flash
10 - Warp
11 - Viridian squeak
12 - Verdigris squeak
13 - Victoria squeak
14 - Vitellary squeak
15 - Violet squeak
16 - Vermilion squeak
17 - Terminal touched
18 - Teleporter touched
19 - Alarm
20 - Terminal squeak
21 - Time trial countdown "3", "2", "1"
22 - Time trial countdown "Go!"
23 - VVVVVV Man breaking walls
24 - Crewmates (de)combining into VVVVVV Man
25 - New record in Super Gravitron
26 - New trophy in Super Gravitron
27 - Rescued crewmate (in custom levels)

Entities\h#

0 - The player
1 - Enemy
    Metadata: movement type, movement speed
    Due to lacking needed data, you will only ever get a purple enemy box, unless
    you're in the VVVVVV polar dimension while doing the command
2 - Moving platform
    Metadata: movement type, movement speed
    Note that conveyors are implemented as moving platforms, see movement type 8
    and 9.
3 - A disappearing platform
4 - A 1x1 quicker quicksand block
5 - A flipped Viridian, you will flip gravity when touched
6 - Weird red flashy thingy that disappears quickly
7 - Same as above, but doesn't flash and is colored cyan
8 - A coin from the prototype
    Metadata: Coin ID
9 - Trinket
    Metadata: Trinket ID
    Note that trinket ID start at 0, and everything above 19 will not be saved in
    the savefile once you restart the level
10 - Checkpoint
     Metadata: Checkpoint state (0=flipped, 1=normal), Checkpoint ID (checks if
     the checkpoint is active or not)
11 - Horizontal gravity line
     Metadata: Length in pixels
12 - Vertical gravity line
     Metadata: Length in pixels
13 - Warp token
     Metadata: Destination in tiles X axis, destination in tiles Y axis
14 - The round teleporter
     Metadata: Checkpoint ID(?)
15 - Verdigris
     Metadata: AI state
16 - Vitellary (flipped)
     Metadata: AI state
17 - Victoria
     Metadata: AI state
18 - Crewmate
     Metadata: Color (using raw color list, not the crewmate colors), mood
19 - Vermilion
     Metadata: AI state
20 - Terminal
     Metadata: Sprite, Script ID(?)
21 - Same as above but when touched the terminal doesn't light up
     Metadata: Sprite, Script ID(?)
22 - Collected trinket
     Metadata: Trinket ID
23 - Gravitron square
     Metadata: Direction
     If you input negative X coordinate (or too high), an arrow shows instead,
     just like in the real Gravitron
24 - Intermission 1 crewmate
     Metadata: Raw color, mood
     Doesn't seem to be affected by hazards, but should be.
25 - Trophy
     Metadata: Challenge identifier, sprite
     If the challenge is completed, the base sprite ID (what you get if you use
     sprite=0) will change. Only use 0 or 1 if you want predictable results
     (0=normal, 1=flipped)
26 - The warp token to the Secret Lab
     Keep in mind that the warp is just implemented as a nice looking sprite.
     You'll have to script the functionality for yourself
55 - Rescueable crewmate
     Metadata: Crewmate color. Color >6 will always show a *happy* Viridian
56 - Custom level enemy
     Metadata: Movement type, movement speed
     Keep in mind that if there's no enemies in the room, the enemy sprite data
     isn't updated correctly and it will just show what enemy you saw last time,
     or a square enemy
Undefined entities (27-50, 57+) give glitchy Viridians.

Colors for createentity() crewmates\h#

0: Cyan
1: Flashy red (used for death)
2: Dark orange
3: Trinket color
4: Gray
5: Flashy white
6: Red (tiny bit darker than Vermilion)
7: Lime green
8: Hot pink
9: Brilliant yellow
10: Flashy white
11: Bright cyan
12: Blue, same as Victoria
13: Green, same as Verdigris
14: Yellow, same as Vitellary
15: Red, same as Vermilion
16: Blue, same as Victoria
17: Lighter orange
18: Gray
19: Darker gray
20: Pink, same as Violet
21: Lighter gray
22: White
23: Flashy white
24-29: White
30: Gray
31: Dark, slightly purplish gray?
32: Dark cyan/green
33: Dark blue
34: Dark green
35: Dark red
36: Dull orange
37: Flashy gray
38: Gray
39: Darker cyan/green
40: Flashier gray
41-99: White
100: Dark gray
101: Flashy white
102: Teleporter color
103 and onwards: White

Enemy movement types\h#

0 - Bouncing up and down, starts down.
1 - Bouncing up and down, starts up.
2 - Bouncing left and right, starts left.
3 - Bouncing left and right, starts right.
4, 7, 11 - Moves right until collision.
5 - Same as above, only acts weird when it collides.
    GIF here: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Bouncing up and down, but only reaches a certain y position before going back
    down. Used in "Trench warfare".
8, 9 - For moving platforms they're conveyors, and they're still for anything else
14 - Able to be blocked by disappearing platforms
15 - Still (?)
10, 12 - Clones right/in the same spot, crashes VVVVVV if it gets too intense, and
         will corrupt your level if you save.
13 - Like 4, but moves down until collision.
16 - Flashes in and out of existence. (Appears and disappears)
17 - Jittery movement left
18 - Jittery movement right, little bit faster
19+ - Still (?)

Gamestates\h#

0 - Break out from most gamestates
1 - Set gamestate to 0 (i.e. same as above in practice)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Runs the script "returntohub" (i.e. fadeout, teleport to right before The
    Tower, fadein, play Passion for Exploring)
7 - Removes textboxes
8 - "Press enter to view map and quicksave"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Tries to access flipmode
     check to write "the ceiling" or "the floor", and check crewmate, but as this
     fails, the above prints instead)
12 - "You can't continue to the next room until he is safely accross."
13 - Removes textboxes quickly
14 - "When you're standing on the floor," (the same applies here as for 11)
15 - Makes Viridian happy
16 - Makes Viridian sad
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - If flag 1 is 0, set flag 1 to 1 and remove textboxes
21 - If flag 2 is 0, set flag 2 to 1 and remove textboxes
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - "Violet, is that you?" cutscene (as long as flag 6 is 0)
32 - If flag 7 is 0: "A teleporter!" "I can get back to the ship with this!"
33 - If flag 9 is 0: Victoria-cutscene
34 - If flag 10 is 0: Vitellary-cutscene
35 - If flag 11 is 0: Verdigris-cutscene
36 - If flag 8 is 0: Vermilion-cutscene
37 - Vitellary after gravitron
38 - Vermilion after gravitron
39 - Verdigris after gravitron
40 - Victoria after gravitron
41 - If flag 60 is 0: run the beginning of intermission 1 cutscene
42 - If flag 62 is 0: run the 3rd intermission 1 cutscene
43 - If flag 63 is 0: run the 4th intermission 1 cutscene
44 - If flag 64 is 0: run the 5th intermission 1 cutscene
45 - If flag 65 is 0: run the 6th intermission 1 cutscene
46 - If flag 66 is 0: run the 7th intermission 1 cutscene
47 - If flag 69 is 0: "Ohh! I wonder what that is?" trinket cutscene
48 - If flag 70 is 0: "This seems like a good place to store anything I find out
     there..." (Victoria not found yet)
49 - If flag 71 is 0: Play Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
With gamestate 50-56, you can choose where to start, because everything will
     appear after each other
80 - If screen is black (and only if), continue to state 81 (My guess is that this
     is called when ESC is pressed, before the pause menu opens)
81 - Go back to the main menu
82 - Results of time trial (bugged)
83 - If screen is back, continue to state 84
84 - Results of time trial (I think 82 works better than 84)
85 - The Time Trial version of gamestate 200 (Flash, play Positive Force, turn on
     finalstretch mode)
States 90-95 are time trial related, but doesn't work properly in custom levels.
     The only real effects that happens in custom levels is a warp, and music
     change
90 - Space Station 1
91 - The Laboratory
92 - Warp Zone
93 - The Tower
94 - Space Station 2
95 - Final Level
96 - If the screen is black, continue to state 97
97 - Exit from Super Gravitron (teleport and play Pipe Dream)
100 - If flag 4 is 0: continue to state 101
101 - If you are flipped, flip back to floor, continue to state 102
The following states (102-112) try to go to the current state + 1, like in 50-56
      (but doesn't loop around), but may glitch as half of the states (103, 105,
      107, 109, 111) doesn't exist.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Removes textboxes
115 - Essentially nothing, continue to state 116
116 - Red dialog at the bottom of the screen saying "Sorry Eurogamers! Teleporting
      around the map doesn't work in this version!", continue to state 117, which
      doesn't exist, so things may fail
118 - Removes textboxes
State 120-128 work a bit like 102-112, i.e. in a series, but with less broken
      things
120 - If flag 5 is 0: continue to state 121
121 - If you're on the floor, flip.
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Removes textboxes
200 - Final mode
1000 - Turns on cutscenebars, freezes the game, continue to state 1001
1001 - You got a shiny trinket! dialog (but you didn't actually get any, this is
       just called each time you get one), continue to state 1003
1003 - Revert game to normal
1010 - You found a crewmate! in the same manner as for trinkets
2000 - Save the game
2500-2509 - Perform a teleport to some weird non-existent location, supposedly to
            The Laboratory I guess, continue to state 2510
2510 - Viridian: "Hello?", continue to state 2512
2512 - Viridian: "Is anybody there?", continue to state 2514
2514 - Removes textboxes, play Potential For Anything
3000-3099 states:
3000-3005 - Level Complete! You've rescued the crewmate applied to companion(),
            defaults to Verdigris. 6=Verdigris, 7=Vitellary, 8=Victoria,
            9=Vermilion, 10=Viridian (yes, really), 11=Violet (Gamestates:
            3006-3011=Verdigris, 3020-3026=Vitellary, 3040-3046=Victoria,
            3060-3066=Vermilion, 3080-3086=Viridian, 3050-3056=Violet)
3070-3072 - Perform postrescue things, usually return to ship
3501 - Game Complete
4010 - Flash + warp
4070 - The Final Level, but the game will crash when you reach Timeslip (Because
       of how the game gets entity information, which is broken in custom levels)
4080 - Captain teleported back to the ship: "Hello!" [C[C[C[C[Captain!] cutscene +
       credits.
       The above will mess up your save data so don't do it unless you backed up!
4090 - Cutscene after you complete space station 1
]]
},

{
subj = "Formatting",
imgs = {},
cont = [[
Formatting\wh#
\C=

In notes you can use formatting codes to make your text larger, color it, and some
other things. To add formatting to a line, add a backslash (\) at the end of it.\
After the \, you can add any amount of the following characters, in any order:\

h - Double font size\h

# - Anchor. You can jump to anchors quickly with ¤#Links¤links¤.\nLCl
- - Horizontal line:
\-
= - Horizontal line underneath large text

Text colors:\h#

n - Normal\n
r - Red\r
g - Gray\g
w - White\w
b - Blue\b
o - Orange\o
v - Green\v
c - Cyan\c
y - Yellow\y
p - Purple\p
V - Dark green\V
z - Black¤ (background color is not included)\z&Z
Z - Dark gray\Z
C - Cyan (Viridian)\C
P - Pink (Violet)\P
Y - Yellow (Vitellary)\Y
R - Red (Vermilion)\R
G - Green (Verdigris)\G
B - Blue (Victoria)\B


Example:\h#

\-
Large orange text ("oh" has same result)\ho\

Large orange text ("oh" has same result)\ho

\-
Underlined large text\wh\
\r=\

Underlined large text\wh
\r=
\-

Using multiple colors on a line\h#

It is possible to use multiple colors on a line by separating colored parts with
the¤ ¤¤ ¤character (which you can type using the ¤insert¤ key), and putting the color\nYnw
codes in order after¤ \¤. If the last color on the line is the default color (n), it\nC
is not necessary to list that at the end. If you want to use the¤ ¤¤ ¤character on a\nY
line which uses¤ \¤, write¤ ¤¤¤¤ ¤instead. For technical reasons, it is n¤o§¤t possible to\nCnYnR(
color a single character by enclosing it in two¤ ¤¤§¤s, unless you also include a\nY(
space or another character.

\-
You can ¤¤color¤¤ specific ¤¤words¤¤ with this!\nrnv\

You can ¤color¤ specific ¤words¤ with this!\nrnv
\-
Some ¤¤te¤¤xt¤¤ co¤¤lo¤¤rs\RYGCBP\

Some ¤te¤xt¤ co¤lo¤rs\RYGCBP
\-

Coloring a single character\h#

OK, I lied, it is possible to color a single character without including a space.
To do this, put the character¤ § ¤(which you can type using ¤shift+insert¤), after\nYnw
the character you want to color, and enable it with the formatting code¤ ( ¤after¤ \¤:\nCnC

\-
You can c¤¤o§¤¤lor a ¤¤single¤¤ character like this!\nrny(\

You can c¤o§¤lor a ¤single¤ character like this!\nrny(
\-

This is not necessary if the single character is the first or last on a line.

Background colors\h#

Not only can text be colored, it can also be ¤highlighted¤ in any of the text\nZ&y
colors. To do this, you can put¤ & ¤after the regular text color code, and then a\nY
color code for the background color. This can be done in combination with the ¤
system described above, note that regular text colors start the next "block",
but background colors do not. The following examples use spaces to make everything
more readable, but this is completely optional. You can use the code¤ + ¤to expand\nY
the (last) background color to the end of the line.

\-
Black text on white background!\z&w\

Black text on white background!\z&w
\-
Black text on expanded white background!\z&w+\

Black text on expanded white background!\z&w+
\-
Red on yellow¤¤, ¤¤Black on white¤¤ (optionally spaces improve readability)\r&y n z&w\

Red on yellow¤, ¤Black on white¤ (optionally spaces improve readability)\r&y n z&w
\-
This still ¤¤works¤¤ to color si¤¤n§¤¤gle characters\n P n n&r (\

This still ¤works¤ to color si¤n§¤gle characters\n P n n&r (
\-

If you like, you can also make graphics using background colors:

\-
 ¤¤        \n n&C\
          \&C\
   ¤¤  ¤¤  ¤¤  ¤¤ \&C n n&C n n&C\
   ¤¤  ¤¤  ¤¤  ¤¤ \&C n n&C n n&C\
          \&C\
          \&C\
   ¤¤      ¤¤ \&C n n&C\
    ¤¤    ¤¤  \&C n n&C\
 ¤¤        \n n&C\
   ¤¤    \n n&C\

 ¤        \n n&C
          \&C
   ¤  ¤  ¤  ¤ \&C n n&C n n&C
   ¤  ¤  ¤  ¤ \&C n n&C n n&C
          \&C
          \&C
   ¤      ¤ \&C n n&C
    ¤    ¤  \&C n n&C
 ¤        \n n&C
   ¤    \n n&C
\-
          \&o\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(\
 ¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ §¤¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(\
          \&o\

          \&o
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&z n&w n&z n&w n&z n&w n&z n&w n&o(
 ¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ §¤ \&o n&w n&z n&w n&z n&w n&z n&w n&z n&o(
          \&o
\-

Links\h#

Links can be used for two things: linking to somewhere else in the articles/notes,
or linking to websites. Links use the semi-color code¤ l¤. This code does not switch\nY
to the next "colored block", it only applies to the current one, as opposed to
regular (non-background) color codes. It also does not change color, so you can
change the style of the link to anything you want.

You can link to articles by simply using the name of the article:

\-
Tools\bl\

Tools\bl
\-

Clicking the "Tools" above will bring you to the Tools help article. I used the
color code¤ b ¤here to make the link blue, and as you can see, the¤ l ¤applies to\nbnY
that same colored part.

You can link to anchors in the same article by linking to a¤ # ¤followed by all text\nY
on that line. (Instances of¤ ¤¤ ¤are completely ignored there.) You can link to the\nY
top of the article with just a hash character (¤#§¤).\nY(

\-
#Using multiple colors on a line\bl\

#Using multiple colors on a line\bl
\-

You can link to an anchor in a different article in a similar way:

\-
Lists reference#Gamestates\bl\

Lists reference#Gamestates\bl
\-

Linking to websites is straightforward too:

\-
https://example.com/\bl\

https://example.com/\bl
\-

You can use a color block with color code¤ L ¤that contains the actual destination\nY
before the link text, and make the link show a different text that way:

\-
Tools¤¤Go to another article\Lbl\

Tools¤Go to another article\Lbl
\-
Click ¤¤Tools¤¤here¤¤ to go to another article\nLbl\

Click ¤Tools¤here¤ to go to another article\nLbl
\-
[¤¤#Links¤¤Like¤¤] [¤¤#Example:¤¤Dislike¤¤]\n L vl n L rl\

[¤#Links¤Like¤] [¤#Example:¤Dislike¤]\n L vl n L rl
\-
#Links¤¤ Button A ¤¤ §¤¤#Links¤¤ Button B \L w&Zl n L w&Z l(\

#Links¤ Button A ¤ §¤#Links¤ Button B \L w&Zl n L w&Z l(
\-

Images (only available in plugin\h#

descriptions):\h

0..9 - display image 0..9 on this line (array index in the imgs array starts at 0,
       and remember to keep lines blank to accommodate for the image height)
^ - Put this before the image number, shift image number by 10. So ^4 makes image
    14, ^^4 makes image 24. And 3^1^56 makes images 3, 11, 25 and 26.
_ - Put this before the image number to decrease the image number by 10.
> - Put this before the image number to shift further images to the right by 8
    pixels. This can be repeated, so 0>>>>1 puts image 0 at x=0 and
    image 1 at x=32.
< - Same, but shift to the left.
]]
----------------------------------------------------------------------------------[]-
--[[
) - Return to previous state
]]
},

{
subj = "Credits",
imgs = {"credits.png"},
cont = [[
\0















Credits\wh#
\C=

Ved is made by Dav999

Some of the graphics and the font were made by Format

Russian translation: CreepiX
Esperanto translation: Format


Special thanks to:\h#


Terry Cavanagh for making VVVVVV

TurtleP (for the code that made graphics not blurry when scaled)

Everyone who reported bugs, came up with ideas and motivated me to make this!









License\h#

Copyright 2015-2017  Dav999              (I do not claim ownership of or copyright
                                                  on VVVVVV or any of its assets.)

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or other
materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

--[[{
subj = "Testing",
imgs = {"tools2/1.png", "i/warn.png", "i/warn2.png"},
cont = [ [
Getting started\wh#

Lorum ipsum dolor sit amet. The quick brown fox jumps over the lazy dog a lot of -XX-
times, and that is something that should be carefully considered.

More info\h#

Lorum ipsum dolor sit amet. The quick brown fox jumps over the lazy dog a lot of
times.

Even more info\h#

Lorum ipsum dolor sit amet. The quick brown fox jumps over the lazy dog a lot.

Get started with this article.

This should be double font size\h
WRONG

And we should leave an extra line blank for that.

Another section\h#

Section could start here.

Ay more

Ok time to start experimenting with colors.

This line should be red.\r
This line should be gray.\g
Now it gets interesting\rh

Should have same result\hr

\-

Red\r
Gray\g
White\w
Blue\b
Orange\o
Green\v
Viridian\C
Violet\P
Vitellary\Y
Vermilion\R
Verdigris\G
Victoria\B

W
\-r
W

Image test:
\0
   Wall\h#


\1

\2
] ]
},]]

}