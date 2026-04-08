-- Language file for Ved
--- Language: English (templates)
--- Last converted: 2018-05-10 00:00:00 (ZZZ)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n ~= 1) end

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Your version of LÖVE is outdated. Please use version 0.9.1 or higher.\nYou can download the latest version of LÖVE from https://love2d.org/.",
OUTDATEDLOVE090 = "Ved no longer supports LÖVE 0.9.0. Luckily, LÖVE 0.9.1 and up will keep working.\nYou can download the latest version of LÖVE from https://love2d.org/.",

OSNOTRECOGNIZED = "Your operating system ($1) is not recognized! Falling back to default filesystem functions; levels are stored in:\n\n$2",
MAXTRINKETS = "The maximum amount of trinkets ($1) has been reached in this level.",
MAXCREWMATES = "The maximum amount of crewmates ($1) has been reached in this level.",
UNSUPPORTEDTOOL = "Unsupported tool! Tool: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Could not get contents of levels folder. Please check if $1 exists and try again.",
MAPSAVEDAS = "Map image saved as $1!",
RAWENTITYPROPERTIES = "You can change the raw property values of this entity here.",
UNKNOWNENTITYTYPE = "Unknown entity type $1",
WARPTOKENENT404 = "Warp token entity no longer exists!",
SPLITFAILED = "Split failed miserably! Do you have too many lines between a text command and a speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "There are no flags left, so one or more new flag labels in this script cannot be associated with any flag number. Trying to run this script in VVVVVV may break. Consider removing all references to flags you no longer need and try again.",
NOFLAGSLEFT_LOADSCRIPT = "There are no flags left, so a load script using a new flag could not be created. Instead, a load script has been created that always loads the target script with iftrinkets(0,$1). Consider removing all references to flags you no longer need and try again.",
LEVELOPENFAIL = "Unable to open $1.vvvvvv.",
SIZELIMIT = "The maximum size of a level is $1 by $2.\n\nThe level size will be changed to $3 by $4 instead.",
SCRIPTALREADYEXISTS = "Script \"$1\" already exists!",
FLAGNAMENUMBERS = "Flag names cannot be only numbers.",
FLAGNAMECHARS = "Flag names cannot contain parentheses, commas or spaces.",
FLAGNAMEINUSE = "The flag name $1 is already in use by flag $2",
DIFFSELECT = "Select the level to compare to. The level you select now will be treated as being an older version.",
SUREQUITNEW = "You have unsaved changes. Do you want to save these changes before quitting?",
SURENEWLEVELNEW = "You have unsaved changes. Do you want to save these changes before creating a new level?",
SUREOPENLEVEL = "You have unsaved changes. Do you want to save these changes before opening this level?",
NAMEFORFLAG = "Name for flag $1:",
SCRIPT404 = "Script \"$1\" does not exist!",
ENTITY404 = "Entity #$1 no longer exists!",
GRAPHICSCARDCANVAS = "Sorry, it seems like your graphics card or driver does not support this feature!",
MAXTEXTURESIZE = "Sorry, creating an image of $1x$2 doesn't seem to be supported by your graphics card or driver.\n\nThe size limit on this system is $3x$3.",
SUREDELETESCRIPT = "Are you sure you want to delete the script \"$1\"?",
SUREDELETENOTE = "Are you sure you want to delete this note?",
THREADERROR = "Thread error!",
WHATDIDYOUDO = "What did you do?!",
UNDOFAULTY = "What are you doing?",
SOURCEDESTROOMSSAME = "Source and destination rooms are the same!",
COORDS_OUT_OF_RANGE = "Huh? These coordinates aren't even in this dimension!",
UNKNOWNUNDOTYPE = "Unknown undo type \"$1\"!",
MDEVERSIONWARNING = "This level appears to have been made in a more recent version of Ved, and may contain some data which will be lost when you save this level.",
FORGOTPATH = "You forgot to specify a path!",
LIB_LOAD_ERRMSG = "Failed to load an essential library. Please tell Dav999 about this problem.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nTry installing GCC to solve this problem, if it isn't already installed.",

SELECTCOPY1 = "Select the room to copy",
SELECTCOPY2 = "Select the location to copy this room to",
SELECTSWAP1 = "Select the first room to swap",
SELECTSWAP2 = "Select the second room to swap",

TILESETCHANGEDTO = "Tileset changed to $1",
TILESETCOLORCHANGEDTO = "Tileset color changed to $1",
ENEMYTYPECHANGED = "Enemy type changed",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Changed to $1 tile placement",
CHANGEDTOMODEAUTO = "automatic",
CHANGEDTOMODEMANUAL = "manual",
CHANGEDTOMODEMULTI = "multi-tileset",

BUSYSAVING = "Saving...",
SAVEDLEVELAS = "Saved level as $1.vvvvvv",

ROOMCUT = "Room cut to clipboard",
ROOMCOPIED = "Copied room to clipboard",
ROOMPASTED = "Pasted room",

METADATAUNDONE = "Level options undone",
METADATAREDONE = "Level options redone",

BOUNDSFIRST = "Click the first corner of the bounds", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Click the last corner", -- Old string: Click the bottom right corner

TILE = "Tile $1",
HIDEALL = "Hide all",
SHOWALL = "Show all",
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
INTERNALON = "Int.sc is on",
INTERNALOFF = "Int.sc is off",
INTERNALON_LONG = "Internal scripting mode is enabled",
INTERNALOFF_LONG = "Internal scripting mode is disabled",
INTERNALYESBARS = "say(-1) int.sc",
INTERNALNOBARS = "Loadscript int.sc",
VIEW = "View",
SYNTAXHLOFF = "Syntax HL: on",
SYNTAXHLON = "Syntax HL: off",
TEXTSIZEN = "Text size: N",
TEXTSIZEL = "Text size: L",
INSERT = "Insert",
HELP = "Help",
INTSCRWARNING_NOLOADSCRIPT = "Load script required!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "A script that loads this script was not detected. This type of internal script will probably not work as you might expect when it is not loaded via another script.",
INTSCRWARNING_BOXED = "Direct script box/terminal reference!",
INTSCRWARNING_BOXED_EXPL = "There is a terminal or script box that loads this script directly. Activating that terminal or script box will probably not work as you might expect; this type of internal script needs to be loaded via a load script.",
INTSCRWARNING_NAME = "Unsuitable script name!",
INTSCRWARNING_NAME_EXPL = "The name of this script has a capital letter, a space, a parenthesis or a comma. This script can only be loaded directly from a terminal or script box.",
COLUMN = "Column: ",

BTN_OK = "OK",
BTN_CANCEL = "Cancel",
BTN_YES = "Yes",
BTN_NO = "No",
BTN_APPLY = "Apply",
BTN_QUIT = "Quit",
BTN_DISCARD = "Discard",
BTN_SAVE = "Save",
BTN_CLOSE = "Close",
BTN_LOAD = "Load",
BTN_ADVANCED = "Advanced",

BTN_AUTODETECT = "Detect",
BTN_MANUALLY = "Override", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Retry",

COMPARINGTHESE = "Comparing $1.vvvvvv to $2.vvvvvv",
COMPARINGTHESENEW = "Comparing (unsaved level) to $1.vvvvvv",

RETURN = "Return",
CREATE = "Create",
GOTO = "Go to",
DELETE = "Delete",
RENAME = "Rename",
CHANGEDIRECTION = "Change direction",
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
COPYENTRANCE = "Copy entrance",
LOCK = "Lock",
UNLOCK = "Unlock",

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
ENEMYTYPE = "Enemy type: $1",
PLATFORMBOUNDS = "Platf. bounds",
WARPDIR = "Warp dir: $1",
ENEMYBOUNDS = "Enemy bounds",
ROOMNAME = "Roomname",
ROOMOPTIONS = "Room options",
ROTATE180 = "Rotate 180deg",
ROTATE180UNI = "Rotate 180°",
HIDEBOUNDS = "Hide bounds",
SHOWBOUNDS = "Show bounds",

ROOMPLATFORMS = "Room platforms", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Room enemies",

OPTNAME = "Name",
OPTBY = "By",
OPTWEBSITE = "Website",
OPTDESC = "Desc", -- If necessary, you can span multiple lines
OPTSIZE = "Size",
OPTMUSIC = "Music",
CAPNONE = "NONE",
ENTERLONGOPTNAME = "Level name:",

X = "x", -- Used for level size: 20x20

SOLID = "Solid",
NOTSOLID = "Not solid",

TSCOLOR = "Color $1",

LEVELSLIST = "Levels",
LOADTHISLEVEL = "Load this level: ",
ENTERNAMESAVE = "Enter name to save as: ",
SEARCHFOR = "Search for: ",

VERSIONERROR = "Unable to check version.",
VERSIONUPTODATE = "Your version of Ved is up-to-date.",
VERSIONOLD = "Update available! Latest version: $1",
VERSIONCHECKING = "Checking for updates...",
VERSIONDISABLED = "Update check disabled",
VERSIONCHECKNOW = "Check now", -- Check for updates now

SAVENOSUCCESS = "Saving not successful! Error: ",
INVALIDFILESIZE = "Invalid file size.",

EDIT = "Edit",
EDITWOBUMPING = "Edit without bumping",
EDITWBUMPING = "Edit and bump",
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
COPYROOMS = "Copy room",
SWAPROOMS = "Swap rooms",

MAP_STYLE = "Map style",
MAP_STYLE_FULL = "Full", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Minimap", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Flags",
ROOM = "room",
CONTENTFILLER = "Content",

FLAGUSED = "Used    ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Not used",
FLAGNONAME = "No name",
USEDOUTOFRANGEFLAGS = "Used out of range flags:",

VVVVVVSETUP = "VVVVVV setup", -- Settings to adapt Ved to how VVVVVV is installed/setup on this computer, like the location of the levels folder and selection of the executable for playtesting. Maybe "VVVVVV installation" or "VVVVVV configuration"
CUSTOMVVVVVVDIRECTORY = "VVVVVV folder",
CUSTOMVVVVVVDIRECTORYEXPL = "The default VVVVVV directory Ved expects is:\n$1\n\nThis path should not be set to the \"levels\" directory.",
CUSTOMVVVVVVDIRECTORY_NOTSET = "You do not have a custom VVVVVV directory set.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Your VVVVVV directory is set to a custom path:\n$1\n\n",
LANGUAGE = "Language",
DIALOGANIMATIONS = "Dialog animations",
FLIPSUBTOOLSCROLL = "Flip tool scrolling direction",
ADJACENTROOMLINES = "Indicators of tiles in adjacent rooms",
NEVERASKBEFOREQUIT = "Never ask before quitting, even if there are unsaved changes",
COORDS0 = "Display coordinates as starting at 0 (as in internal scripting)",
ALLOWDEBUG = "Enable debug mode",
SHOWFPS = "Show FPS counter",
CHECKFORUPDATES = "Check for updates",
PAUSEDRAWUNFOCUSED = "Do not render when the window is unfocused",
ENABLEOVERWRITEBACKUPS = "Make backups of level files that are overwritten",
AMOUNTOVERWRITEBACKUPS = "Number of backups to keep per level",
SCALE = "Scale",
LOADALLMETADATA = "Load metadata (such as title, author and description) for all files in levels list",
COLORED_TEXTBOXES = "Use true textbox colors",
MOUSESCROLLINGSPEED = "Mouse scrolling speed",
BUMPSCRIPTSBYDEFAULT = "Bump scripts to the top of the list when editing them by default",

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
AMOUNTTILES = "Tiles:",
AMOUNTSOLIDTILES = "Solid tiles:",
AMOUNTSPIKES = "Spikes:",


UNEXPECTEDSCRIPTLINE = "Unexpected script line without script: $1",
DUPLICATESCRIPT = "Script $1 is duplicate! Only one can be loaded.",
MAPWIDTHINVALID = "Map width is invalid: $1",
MAPHEIGHTINVALID = "Map height is invalid: $1",
LEVMUSICEMPTY = "Level music is empty!",
NOT400ROOMS = "The number of entries in levelMetaData is not 400!",
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
SYNTAXCOLOR_COMMENT = "Comment",
SYNTAXCOLOR_WRONGLANG = "Simplified command in int.sc mode or vice versa",
RESETCOLORS = "Reset colors",
STRINGNOTFOUND = "\"$1\" was not found",

-- L.MAL is concatenated with an error message
MAL = "The level file is malformed: ",

LOADSCRIPTMADE = "Load script created",
COPY = "Copy",
CUSTOMSIZE = "Custom brush size: $1x$2",
SELECTINGA = "Selecting - click top left",
SELECTINGB = "Selecting: $1x$2",
TILESETSRELOADED = "Tilesets and sprites reloaded",

BACKUPS = "Backups",
BACKUPSOFLEVEL = "Backups of level $1",
LASTMODIFIEDTIME = "Originally last modified", -- List header
OVERWRITTENTIME = "Overwritten", -- List header
SAVEBACKUP = "Save to VVVVVV folder",
DATEFORMAT = "Date format",
TIMEFORMAT = "Time format",
SAVEBACKUPNOBACKUP = "Make sure to choose a unique name for this if you do not want to overwrite anything, as NO backup will be made in this case!",

AUTOSAVECRASHLOGS = "Automatically save crash logs",
MOREINFO = "Latest info",
COPYLINK = "Copy link",
SCRIPTDISPLAY = "Show",
SCRIPTDISPLAY_USED = "Used",
SCRIPTDISPLAY_UNUSED = "Unused",

RECENTLYOPENED = "Recently opened levels",
REMOVERECENT = "Do you want to remove it from the list of recently opened levels?",
RESETCUSTOMBRUSH = "(Right click to set new size)",

DISPLAYSETTINGS = "Display/Scale",
DISPLAYSETTINGSTITLE = "Display/Scale settings",
SMALLERSCREEN = "Smaller window width (800px wide instead of 896px)",
FORCESCALE = "Force scale settings",
SCALENOFIT = "The current scale settings make the window too large to fit.",
SCALENONUM = "The current scale settings are invalid.",
MONITORSIZE = "$1x$2 monitor",
VEDRES = "Ved resolution: $1x$2",
NONINTSCALE = "Non-integer scaling",

USEFONTPNG = "Use font.png from VVVVVV graphics folder as font",
USELEVELFONTPNG = "Use per-level custom font.png as font",
REQUIRESHIGHERLOVE = " (requires LÖVE $1 or higher)",
FPSLIMIT = "FPS limit",

MAPRESOLUTION = "Resolution", -- Map export size
MAPRES_ASSHOWN = "As shown (max 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 per room)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 per room)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Top left",
WIDTHHEIGHT = "Width & height",
BOTTOMRIGHT = "Bottom right",
RENDERERINFO = "Renderer information:",
MAPINCOMPLETE = "The map is not ready yet (at the time you pressed Save), please try again when it is ready.",
KEEPDIALOGOPEN = "Keep dialog open",
TRANSPARENTMAPBG = "Transparent background",
MAPEXPORTERROR = "Error while creating map.",
VIEWIMAGE = "View", -- Verb, view image
INVALIDLINENUMBER = "Please enter a valid line number.",
OPENLEVELSFOLDER = "Open lvl dir", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Move",
GOTOROOM = "Go to room",
ESCTOCANCEL = "[Press ESC to cancel]",

INVALIDFILENAME_WIN = "Windows doesn't allow the following characters in filenames:\n\n: * ? \" < > |\n\n(| being a vertical bar)",
INVALIDFILENAME_MAC = "macOS doesn't allow the : character in filenames.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "CTRL",
TINY_SHIFT = "SHIFT",
TINY_ALT = "ALT",
TINY_ESC = "ESC",
TINY_TAB = "TAB",
TINY_HOME = "HOME",
TINY_END = "END",
TINY_INSERT = "INS",
TINY_DEL = "DEL",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Scripts [$1]",
SEARCHRESULTS_ROOMS = "Rooms [$1]",
SEARCHRESULTS_NOTES = "Notes [$1]",

ASSETS = "Assets", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Can not play this song. It may not exist or be of an unsupported type.",
SOUNDPLAYERROR = "Can not play this sound. It may not exist or be of an unsupported type.",
MUSICLOADERROR = "Can not load $1: ",
MUSICLOADERROR_TOOSMALL = "The music file is too small to be valid.",
MUSICEXISTSYES = "Exists",
MUSICEXISTSNO = "Does not exist",
ASSETS_FOLDER_EXISTS_NO = "Does not exist - click to create",
ASSETS_FOLDER_EXISTS_YES = "Exists - click to open",
NO_ASSETS_SUBFOLDER = "No \"$1\" folder",
LOAD = "Load",
RELOAD = "Reload",
UNLOAD = "Unload",
MUSICEDITOR = "Music editor",
LOADMUSICNAME = "Load .vvv",
SAVEMUSICNAME = "Save .vvv",
INSERTSONG = "Insert song at track $1",
SUREDELETESONG = "Are you sure you want to remove song $1?",
SONGOPENFAIL = "Unable to open $1, song not replaced.",
SONGREPLACEFAIL = "Something went wrong while replacing the song.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ".", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "You cannot use the \"$1\" character in script names!",
MUSICTITLE = "Title: ",
MUSICARTIST = "Artist: ",
MUSICFILENAME = "Filename: ",
MUSICNOTES = "Notes:",
SONGMETADATA = "Metadata for song $1",
MUSICFILEMETADATA = "File metadata",
MUSICEXPORTEDON = "Exported: ", -- Followed by date and time
SAVEMETADATA = "Save metadata",
SOUNDS = "Sounds",
GRAPHICS = "Graphics",
FILEOPENERNAME = "Name: ",
PATHINVALID = "The path is invalid.",
DRIVES = "Drives", -- like C: or F: on Windows
DOFILTER = "Only show *$1", -- "*.txt" for example
DOFILTERDIR = "Only show directories",
FILEDIALOGLUV = "Sorry, your operating system is unrecognized, so the file dialog does not work.",
RESET = "Reset",
CHANGEVERB = "Change", -- verb
LOADIMAGE = "Load image",
GRID = "Grid",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "The level needs to be saved before it can use custom assets.",
CREATE_ASSETS_FOLDER = "Would you like to create a custom assets folder for this level?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "It seems like the VVVVVV folder doesn't exist. Would you like to create it?",
CREATE_LEVELS_FOLDER = "It seems like the levels folder doesn't exist. Would you like to create it?",
CREATE_FOLDER_FAIL = "Unable to create folder.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Assets folder for $1",

OPAQUEROOMNAMEBACKGROUND = "Make the black roomname backgrounds opaque",
PLATVCHANGE_TITLE = "Change platform speed",
PLATVCHANGE_MSG = "Speed:",
PLATVCHANGE_INVALID = "You have to type in a number.",
RENAMESCRIPTREFERENCES = "Rename references",
PLATFORMSPEEDSLIDER = "Spd.:",

TRINKETS = "Trinkets",
LISTALLTRINKETS = "List all trinkets", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "List of all trinkets",
NOTRINKETSINLEVEL = "There are no trinkets in this level.",
CREWMATES = "Crewmates",
LISTALLCREWMATES = "List all crewmates", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "List of all rescuable crewmates",
NOCREWMATESINLEVEL = "There are no rescuable crewmates in this level.",
SHIFTROOMS = "Shift rooms", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 sec",
ROOMNUM = "Room $1",
SOUNDNUM = "Sound $1",
TRACKNUM = "Track $1",
STOPSMUSIC = "Stops music",
PLAYSOUND = "Play sound",
EDITSCRIPTWOBUMPING = "Edit script without bumping",
EDITSCRIPTWBUMPING = "Edit script and bump",
CLICKONTHING = "Click on $1",
ORDRAGDROP = "or drag and drop onto here", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "There is more than one start point in this level!",
STARTPOINTNOTFOUND = "There is no start point!",

MAPBIGGERTHANSIZELIMIT = "Map size $1 by $2 is bigger than $3 by $4!",
BTNOVERRIDE = "Override",
TARGETPLATFORM = "Target platform", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Time trials",
TIMETRIALTRINKETS = "Trinket count",
TIMETRIALTIME = "Par time",
SUREDELETETRIAL = "Are you sure you want to delete the time trial \"$1\"?",

CUT = "Cut",
PASTE = "Paste",
SELECTWORD = "Select word",
SELECTLINE = "Select line",
SELECTALL = "Select all",
INSERTRAWHEX = "Insert Unicode character",
MOVELINEUP = "Move line upwards",
MOVELINEDOWN = "Move line downwards",
DUPLICATELINE = "Duplicate line",

WHEREPLACEPLAYER = "Where do you want to start?",
YOUAREPLAYTESTING = "You are currently playtesting",
LOCATEVVVVVV = "Select your $1 executable", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "You're already playtesting!",
PLAYTESTINGFAILED = "Something went wrong when opening VVVVVV:\n$1\n\nIf you need to change the VVVVVV executable that's used for playtesting, hold Shift while pressing the playtest button.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV exited with code $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "It looks like you are using VVVVVV 2.2 or older. Please upgrade to VVVVVV 2.3 or later.",
VVVVVV_SOMETHING_HAPPENED = "Something seems to have gone wrong with VVVVVV.",
PLAYTESTUNAVAILABLE = "Sorry, you cannot playtest on $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Please select the file named '$1'.",

PLAYTESTINGOPTIONS = "Playtesting",
PLAYTESTING_EXECUTABLE_NOTSET = "You did not yet set a $1 executable to use for playtesting.\nVed will ask for it when playtesting a $2 level for the first time.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "The $1 executable to use for playtesting is set to:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Sorry, something went wrong trying to find VVVVVV. Try setting the path to the executable manually.",
FIND_V_EXE_FOUNDERROR = "Found something that looks like VVVVVV, but couldn't get a useable path to its executable. Make sure you aren't using an old version of the game (2.3 or newer is required) or try setting the path to the executable manually.",
FIND_V_EXE_NOTFOUND = "It looks like VVVVVV is not running. Make sure you have VVVVVV running and try again.",
FIND_V_EXE_MULTI = "Found multiple different instances of VVVVVV running. Make sure you have only one version of the game open and try again.",

FIND_V_EXE_EXPLANATION = "Ved needs VVVVVV for playtesting, and the path to VVVVVV needs to be set first.\n\n\nTo autodetect VVVVVV, simply start the game if it isn't already running and press \"Detect\".",

VCE_REMOVED = "VVVVVV: Community Edition is no longer being maintained, and support for VVVVVV-CE levels has been removed from Ved. This level is treated like a regular VVVVVV level. For more information, see https://vsix.dev/vce/status/",

VVVVVV_VERSION = "VVVVVV version", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Auto",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "All plugins",
ALL_PLUGINS_MOREINFO = "Please go to ¤https://tolp.nl/ved/plugins.php¤this page¤ for more information about plugins.\\nLCl",
ALL_PLUGINS_FOLDER = "Your plugins folder is:",
ALL_PLUGINS_NOPLUGINS = "You do not have any plugins yet.",

PLUGIN_NOT_SUPPORTED = "[This plugin is not supported because it requires Ved $1 or higher!]\\r",
PLUGIN_AUTHOR_VERSION = "by $1, version $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Create load script",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "No",
CREATE_LOAD_SCRIPT_RUNONCE = "Run once",
CREATE_LOAD_SCRIPT_REPEATING = "Repeating",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Don't create load script",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "This terminal will directly point to the script.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "This script box will directly point to the script.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Create load script to run once",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "This terminal will point to a new load script, which loads the real script only once in a playthrough. Ved will choose an unused flag.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "This script box will point to a new load script, which loads the real script only once in a playthrough. Ved will choose an unused flag.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Create repeating load script",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "This terminal will point to a new load script, which unconditionally loads the real script.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "This script box will point to a new load script, which unconditionally loads the real script.",

CUSTOM_SIZED_BRUSH = "Custom brush",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Brush",
CUSTOM_SIZED_BRUSH_STAMP = "Stamp",
CUSTOM_SIZED_BRUSH_TILESET = "Tileset",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Custom brush size",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Choose the size of the brush you need.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stamp from room",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Select tiles from the room to create a stamp.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stamp from tileset",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Select tiles from the tileset to create a stamp. Only works in manual mode.",

ADVANCED_LEVEL_OPTIONS = "Advanced level options",
ONEWAYCOL_OVERRIDE = "Recolor one-way tiles in custom assets as well (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Create ZIP of this version for sharing", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Save ZIP",
ZIP_BUSY_TITLE = "Creating ZIP...",
ZIP_LOVE11_ONLY = "Creating a ZIP file requires LÖVE $1 or higher", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP saved!",
ZIP_SAVING_FAIL = "Could not save ZIP file!",

OPENFOLDER = "Open folder", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Level font",

TEXTBOXCOLORS_BUTTON = "Text colors",
TEXTBOXCOLORS_TITLE = "Textbox colors",
TEXTBOXCOLORS_RENAME = "Rename color \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Duplicate color \"$1\"",
TEXTBOXCOLORS_CREATE = "Add new color",

LIB_LOAD_ERRMSG_BIDI = "Failed to load the library for right-to-left text support.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nYour antivirus may be breaking it.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "You have $1 plugin that is not supported in this version.",
		[1] = "You have $1 plugins that are not supported in this version.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "This level failed $1 check. The issue may have been fixed automatically, but it's possible this will still result in crashes and inconsistencies.",
		[1] = "This level failed $1 checks. The issues may have been fixed automatically, but it's possible this will still result in crashes and inconsistencies.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 usage in rooms: $2",
		[1] = "$1 usages in rooms: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 usage in scripts: $2",
		[1] = "$1 usages in scripts: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Entity at [$1 $2] has $3 invalid property!",
		[1] = "Entity at [$1 $2] has $3 invalid properties!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata for room $1,$2 has $3 invalid property!",
		[1] = "LevelMetadata for room $1,$2 has $3 invalid properties!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Showing $1",
		[1] = "Showing $1",
	},
	FLAGUSAGES = {
		[0] = "Used $1 time in scripts: $2",
		[1] = "Used $1 times in scripts: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 tile is not a valid whole number greater than or equal to 0",
		[1] = "$1 tiles are not a valid whole number greater than or equal to 0",
	},
	BYTES = {
		[0] = "$1 byte",
		[1] = "$1 bytes",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 image customized",
		[1] = "$1 images customized",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 sound effect customized",
		[1] = "$1 sound effects customized",
	},
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
"Start point",

}

subtoolnames = {

[1] = {"1x1 brush", "3x3 brush", "5x5 brush", "7x7 brush", "9x9 brush", "Fill horizontally", "Fill vertically", "Custom brush size", "Fill bucket", "Potato for Doing Things that are Magical"},
[2] = {},
[3] = {"Auto 1", "Auto expand L+R", "Auto expand L", "Auto expand R"},
[4] = {},
[5] = {"Upright", "Flipped"},
[6] = {},
[7] = {"Small R", "Small L", "Large R", "Large L"},
[8] = {"Down", "Up", "Left", "Right"},
[9] = {},
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
[3] = "A",

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
short5 = "Tower",
long5 = "Tower",

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
ERR_PLEASETELLDAV = "Please tell Dav999 about this problem.\n\n\nDetails: (press Ctrl/Cmd+C to copy to the clipboard)\n\n"
ERR_INTERMEDIATE = " (intermediate version)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (too new)"

ERR_PLUGINERROR = "Plugin error!"
ERR_FILE = "File to be edited:"
ERR_FILEEDITORS = "Plugins that edit this file:"
ERR_CURRENTPLUGIN = "Plugin that triggered the error:"
ERR_PLEASETELLAUTHOR = "A plugin was supposed to make an edit to code in Ved, but the code to be replaced was not found.\nIt is possible that this was caused by a conflict between two plugins, or a Ved update broke this plugin.\n\nDetails: (press Ctrl/Cmd+C to copy to the clipboard)\n\n"
ERR_CONTINUE = "You can continue by pressing ESC or enter, but note this failed edit may cause issues."
ERR_OPENPLUGINSFOLDER = "You can open your plugins folder by pressing F, so you can fix or remove the offending plugin. Afterwards, restart Ved."
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

