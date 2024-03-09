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
function lang_plurals(n) return 0 end

--- fontpng_ascii: N.A.

L = {

TRANSLATIONCREDIT = "<L.TRANSLATIONCREDIT>", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "<L.OUTDATEDLOVE>",
OUTDATEDLOVE090 = "<L.OUTDATEDLOVE090>",

OSNOTRECOGNIZED = "<L.OSNOTRECOGNIZED>",
MAXTRINKETS = "<L.MAXTRINKETS>",
MAXCREWMATES = "<L.MAXCREWMATES>",
UNSUPPORTEDTOOL = "<L.UNSUPPORTEDTOOL>",
COULDNOTGETCONTENTSLEVELFOLDER = "<L.COULDNOTGETCONTENTSLEVELFOLDER>",
MAPSAVEDAS = "<L.MAPSAVEDAS>",
RAWENTITYPROPERTIES = "<L.RAWENTITYPROPERTIES>",
UNKNOWNENTITYTYPE = "<L.UNKNOWNENTITYTYPE>",
WARPTOKENENT404 = "<L.WARPTOKENENT404>",
SPLITFAILED = "<L.SPLITFAILED>", -- Command names are best left untranslated
NOFLAGSLEFT = "<L.NOFLAGSLEFT>",
NOFLAGSLEFT_LOADSCRIPT = "<L.NOFLAGSLEFT_LOADSCRIPT>",
LEVELOPENFAIL = "<L.LEVELOPENFAIL>",
SIZELIMIT = "<L.SIZELIMIT>",
SCRIPTALREADYEXISTS = "<L.SCRIPTALREADYEXISTS>",
FLAGNAMENUMBERS = "<L.FLAGNAMENUMBERS>",
FLAGNAMECHARS = "<L.FLAGNAMECHARS>",
FLAGNAMEINUSE = "<L.FLAGNAMEINUSE>",
DIFFSELECT = "<L.DIFFSELECT>",
SUREQUITNEW = "<L.SUREQUITNEW>",
SURENEWLEVELNEW = "<L.SURENEWLEVELNEW>",
SUREOPENLEVEL = "<L.SUREOPENLEVEL>",
NAMEFORFLAG = "<L.NAMEFORFLAG>",
SCRIPT404 = "<L.SCRIPT404>",
ENTITY404 = "<L.ENTITY404>",
GRAPHICSCARDCANVAS = "<L.GRAPHICSCARDCANVAS>",
MAXTEXTURESIZE = "<L.MAXTEXTURESIZE>",
SUREDELETESCRIPT = "<L.SUREDELETESCRIPT>",
SUREDELETENOTE = "<L.SUREDELETENOTE>",
THREADERROR = "<L.THREADERROR>",
WHATDIDYOUDO = "<L.WHATDIDYOUDO>",
UNDOFAULTY = "<L.UNDOFAULTY>",
SOURCEDESTROOMSSAME = "<L.SOURCEDESTROOMSSAME>",
COORDS_OUT_OF_RANGE = "<L.COORDS_OUT_OF_RANGE>",
UNKNOWNUNDOTYPE = "<L.UNKNOWNUNDOTYPE>",
MDEVERSIONWARNING = "<L.MDEVERSIONWARNING>",
FORGOTPATH = "<L.FORGOTPATH>",
LIB_LOAD_ERRMSG = "<L.LIB_LOAD_ERRMSG>",
LIB_LOAD_ERRMSG_GCC = "<L.LIB_LOAD_ERRMSG_GCC>",

SELECTCOPY1 = "<L.SELECTCOPY1>",
SELECTCOPY2 = "<L.SELECTCOPY2>",
SELECTSWAP1 = "<L.SELECTSWAP1>",
SELECTSWAP2 = "<L.SELECTSWAP2>",

TILESETCHANGEDTO = "<L.TILESETCHANGEDTO>",
TILESETCOLORCHANGEDTO = "<L.TILESETCOLORCHANGEDTO>",
ENEMYTYPECHANGED = "<L.ENEMYTYPECHANGED>",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "<L.CHANGEDTOMODE>",
CHANGEDTOMODEAUTO = "<L.CHANGEDTOMODEAUTO>",
CHANGEDTOMODEMANUAL = "<L.CHANGEDTOMODEMANUAL>",
CHANGEDTOMODEMULTI = "<L.CHANGEDTOMODEMULTI>",

BUSYSAVING = "<L.BUSYSAVING>",
SAVEDLEVELAS = "<L.SAVEDLEVELAS>",

ROOMCUT = "<L.ROOMCUT>",
ROOMCOPIED = "<L.ROOMCOPIED>",
ROOMPASTED = "<L.ROOMPASTED>",

METADATAUNDONE = "<L.METADATAUNDONE>",
METADATAREDONE = "<L.METADATAREDONE>",

BOUNDSFIRST = "<L.BOUNDSFIRST>", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "<L.BOUNDSLAST>", -- Old string: Click the bottom right corner

TILE = "<L.TILE>",
HIDEALL = "<L.HIDEALL>",
SHOWALL = "<L.SHOWALL>",
SCRIPTEDITOR = "<L.SCRIPTEDITOR>",
FILE = "<L.FILE>",
NEW = "<L.NEW>",
OPEN = "<L.OPEN>",
SAVE = "<L.SAVE>",
UNDO = "<L.UNDO>",
REDO = "<L.REDO>",
COMPARE = "<L.COMPARE>",
STATS = "<L.STATS>",
SCRIPTUSAGES = "<L.SCRIPTUSAGES>",
EDITTAB = "<L.EDITTAB>",
COPYSCRIPT = "<L.COPYSCRIPT>",
SEARCHSCRIPT = "<L.SEARCHSCRIPT>",
GOTOLINE = "<L.GOTOLINE>",
GOTOLINE2 = "<L.GOTOLINE2>",
INTERNALON = "<L.INTERNALON>",
INTERNALOFF = "<L.INTERNALOFF>",
INTERNALON_LONG = "<L.INTERNALON_LONG>",
INTERNALOFF_LONG = "<L.INTERNALOFF_LONG>",
INTERNALYESBARS = "<L.INTERNALYESBARS>",
INTERNALNOBARS = "<L.INTERNALNOBARS>",
VIEW = "<L.VIEW>",
SYNTAXHLOFF = "<L.SYNTAXHLOFF>",
SYNTAXHLON = "<L.SYNTAXHLON>",
TEXTSIZEN = "<L.TEXTSIZEN>",
TEXTSIZEL = "<L.TEXTSIZEL>",
INSERT = "<L.INSERT>",
HELP = "<L.HELP>",
INTSCRWARNING_NOLOADSCRIPT = "<L.INTSCRWARNING_NOLOADSCRIPT>",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "<L.INTSCRWARNING_NOLOADSCRIPT_EXPL>",
INTSCRWARNING_BOXED = "<L.INTSCRWARNING_BOXED>",
INTSCRWARNING_BOXED_EXPL = "<L.INTSCRWARNING_BOXED_EXPL>",
INTSCRWARNING_NAME = "<L.INTSCRWARNING_NAME>",
INTSCRWARNING_NAME_EXPL = "<L.INTSCRWARNING_NAME_EXPL>",
COLUMN = "<L.COLUMN>",

BTN_OK = "<L.BTN_OK>",
BTN_CANCEL = "<L.BTN_CANCEL>",
BTN_YES = "<L.BTN_YES>",
BTN_NO = "<L.BTN_NO>",
BTN_APPLY = "<L.BTN_APPLY>",
BTN_QUIT = "<L.BTN_QUIT>",
BTN_DISCARD = "<L.BTN_DISCARD>",
BTN_SAVE = "<L.BTN_SAVE>",
BTN_CLOSE = "<L.BTN_CLOSE>",
BTN_LOAD = "<L.BTN_LOAD>",
BTN_ADVANCED = "<L.BTN_ADVANCED>",

BTN_AUTODETECT = "<L.BTN_AUTODETECT>",
BTN_MANUALLY = "<L.BTN_MANUALLY>", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "<L.BTN_RETRY>",

COMPARINGTHESE = "<L.COMPARINGTHESE>",
COMPARINGTHESENEW = "<L.COMPARINGTHESENEW>",

RETURN = "<L.RETURN>",
CREATE = "<L.CREATE>",
GOTO = "<L.GOTO>",
DELETE = "<L.DELETE>",
RENAME = "<L.RENAME>",
CHANGEDIRECTION = "<L.CHANGEDIRECTION>",
TESTFROMHERE = "<L.TESTFROMHERE>",
FLIP = "<L.FLIP>",
CYCLETYPE = "<L.CYCLETYPE>",
GOTODESTINATION = "<L.GOTODESTINATION>",
GOTOENTRANCE = "<L.GOTOENTRANCE>",
CHANGECOLOR = "<L.CHANGECOLOR>",
EDITTEXT = "<L.EDITTEXT>",
COPYTEXT = "<L.COPYTEXT>",
EDITSCRIPT = "<L.EDITSCRIPT>",
OTHERSCRIPT = "<L.OTHERSCRIPT>",
PROPERTIES = "<L.PROPERTIES>",
CHANGETOHOR = "<L.CHANGETOHOR>",
CHANGETOVER = "<L.CHANGETOVER>",
RESIZE = "<L.RESIZE>",
CHANGEENTRANCE = "<L.CHANGEENTRANCE>",
CHANGEEXIT = "<L.CHANGEEXIT>",
COPYENTRANCE = "<L.COPYENTRANCE>",
LOCK = "<L.LOCK>",
UNLOCK = "<L.UNLOCK>",

VEDOPTIONS = "<L.VEDOPTIONS>",
LEVELOPTIONS = "<L.LEVELOPTIONS>",
MAP = "<L.MAP>",
SCRIPTS = "<L.SCRIPTS>",
SEARCH = "<L.SEARCH>",
SENDFEEDBACK = "<L.SENDFEEDBACK>",
LEVELNOTEPAD = "<L.LEVELNOTEPAD>",
PLUGINS = "<L.PLUGINS>",

BACKB = "<L.BACKB>",
MOREB = "<L.MOREB>",
AUTOMODE = "<L.AUTOMODE>",
AUTO2MODE = "<L.AUTO2MODE>",
MANUALMODE = "<L.MANUALMODE>",
ENEMYTYPE = "<L.ENEMYTYPE>",
PLATFORMBOUNDS = "<L.PLATFORMBOUNDS>",
WARPDIR = "<L.WARPDIR>",
ENEMYBOUNDS = "<L.ENEMYBOUNDS>",
ROOMNAME = "<L.ROOMNAME>",
ROOMOPTIONS = "<L.ROOMOPTIONS>",
ROTATE180 = "<L.ROTATE180>",
ROTATE180UNI = "<L.ROTATE180UNI>",
HIDEBOUNDS = "<L.HIDEBOUNDS>",
SHOWBOUNDS = "<L.SHOWBOUNDS>",

ROOMPLATFORMS = "<L.ROOMPLATFORMS>", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "<L.ROOMENEMIES>",

OPTNAME = "<L.OPTNAME>",
OPTBY = "<L.OPTBY>",
OPTWEBSITE = "<L.OPTWEBSITE>",
OPTDESC = "<L.OPTDESC>", -- If necessary, you can span multiple lines
OPTSIZE = "<L.OPTSIZE>",
OPTMUSIC = "<L.OPTMUSIC>",
CAPNONE = "<L.CAPNONE>",
ENTERLONGOPTNAME = "<L.ENTERLONGOPTNAME>",

X = "<L.X>", -- Used for level size: 20x20

SOLID = "<L.SOLID>",
NOTSOLID = "<L.NOTSOLID>",

TSCOLOR = "<L.TSCOLOR>",

LEVELSLIST = "<L.LEVELSLIST>",
LOADTHISLEVEL = "<L.LOADTHISLEVEL>",
ENTERNAMESAVE = "<L.ENTERNAMESAVE>",
SEARCHFOR = "<L.SEARCHFOR>",

VERSIONERROR = "<L.VERSIONERROR>",
VERSIONUPTODATE = "<L.VERSIONUPTODATE>",
VERSIONOLD = "<L.VERSIONOLD>",
VERSIONCHECKING = "<L.VERSIONCHECKING>",
VERSIONDISABLED = "<L.VERSIONDISABLED>",
VERSIONCHECKNOW = "<L.VERSIONCHECKNOW>", -- Check for updates now

SAVENOSUCCESS = "<L.SAVENOSUCCESS>",
INVALIDFILESIZE = "<L.INVALIDFILESIZE>",

EDIT = "<L.EDIT>",
EDITWOBUMPING = "<L.EDITWOBUMPING>",
EDITWBUMPING = "<L.EDITWBUMPING>",
COPYNAME = "<L.COPYNAME>",
COPYCONTENTS = "<L.COPYCONTENTS>",
DUPLICATE = "<L.DUPLICATE>",

NEWSCRIPTNAME = "<L.NEWSCRIPTNAME>",
CREATENEWSCRIPT = "<L.CREATENEWSCRIPT>",

NEWNOTENAME = "<L.NEWNOTENAME>",
CREATENEWNOTE = "<L.CREATENEWNOTE>",

ADDNEWBTN = "<L.ADDNEWBTN>",
IMAGEERROR = "<L.IMAGEERROR>",

NEWNAME = "<L.NEWNAME>",
RENAMENOTE = "<L.RENAMENOTE>",
RENAMESCRIPT = "<L.RENAMESCRIPT>",

LINE = "<L.LINE>",

SAVEMAP = "<L.SAVEMAP>",
COPYROOMS = "<L.COPYROOMS>",
SWAPROOMS = "<L.SWAPROOMS>",

MAP_STYLE = "<L.MAP_STYLE>",
MAP_STYLE_FULL = "<L.MAP_STYLE_FULL>", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "<L.MAP_STYLE_MINIMAP>", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "<L.MAP_STYLE_VTOOLS>", -- Max 12*2 characters

FLAGS = "<L.FLAGS>",
ROOM = "<L.ROOM>",
CONTENTFILLER = "<L.CONTENTFILLER>",

FLAGUSED = "<L.FLAGUSED>", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "<L.FLAGNOTUSED>",
FLAGNONAME = "<L.FLAGNONAME>",
USEDOUTOFRANGEFLAGS = "<L.USEDOUTOFRANGEFLAGS>",

VVVVVVSETUP = "<L.VVVVVVSETUP>",
CUSTOMVVVVVVDIRECTORY = "<L.CUSTOMVVVVVVDIRECTORY>",
CUSTOMVVVVVVDIRECTORYEXPL = "<L.CUSTOMVVVVVVDIRECTORYEXPL>",
CUSTOMVVVVVVDIRECTORY_NOTSET = "<L.CUSTOMVVVVVVDIRECTORY_NOTSET>",
CUSTOMVVVVVVDIRECTORY_SET = "<L.CUSTOMVVVVVVDIRECTORY_SET>",
LANGUAGE = "<L.LANGUAGE>",
DIALOGANIMATIONS = "<L.DIALOGANIMATIONS>",
FLIPSUBTOOLSCROLL = "<L.FLIPSUBTOOLSCROLL>",
ADJACENTROOMLINES = "<L.ADJACENTROOMLINES>",
NEVERASKBEFOREQUIT = "<L.NEVERASKBEFOREQUIT>",
COORDS0 = "<L.COORDS0>",
ALLOWDEBUG = "<L.ALLOWDEBUG>",
SHOWFPS = "<L.SHOWFPS>",
CHECKFORUPDATES = "<L.CHECKFORUPDATES>",
PAUSEDRAWUNFOCUSED = "<L.PAUSEDRAWUNFOCUSED>",
ENABLEOVERWRITEBACKUPS = "<L.ENABLEOVERWRITEBACKUPS>",
AMOUNTOVERWRITEBACKUPS = "<L.AMOUNTOVERWRITEBACKUPS>",
SCALE = "<L.SCALE>",
LOADALLMETADATA = "<L.LOADALLMETADATA>",
COLORED_TEXTBOXES = "<L.COLORED_TEXTBOXES>",
MOUSESCROLLINGSPEED = "<L.MOUSESCROLLINGSPEED>",
BUMPSCRIPTSBYDEFAULT = "<L.BUMPSCRIPTSBYDEFAULT>",

SCRIPTSPLIT = "<L.SCRIPTSPLIT>",
SPLITSCRIPT = "<L.SPLITSCRIPT>",
COUNT = "<L.COUNT>",
SMALLENTITYDATA = "<L.SMALLENTITYDATA>",

-- Stats screen
AMOUNTSCRIPTS = "<L.AMOUNTSCRIPTS>",
AMOUNTUSEDFLAGS = "<L.AMOUNTUSEDFLAGS>",
AMOUNTENTITIES = "<L.AMOUNTENTITIES>",
AMOUNTTRINKETS = "<L.AMOUNTTRINKETS>",
AMOUNTCREWMATES = "<L.AMOUNTCREWMATES>",
AMOUNTINTERNALSCRIPTS = "<L.AMOUNTINTERNALSCRIPTS>",
TILESETUSSAGE = "<L.TILESETUSSAGE>",
TILESETSONLYUSED = "<L.TILESETSONLYUSED>",
AMOUNTROOMSWITHNAMES = "<L.AMOUNTROOMSWITHNAMES>",
PLACINGMODEUSAGE = "<L.PLACINGMODEUSAGE>",
AMOUNTLEVELNOTES = "<L.AMOUNTLEVELNOTES>",
AMOUNTFLAGNAMES = "<L.AMOUNTFLAGNAMES>",
TILESUSAGE = "<L.TILESUSAGE>",
AMOUNTTILES = "<L.AMOUNTTILES>",
AMOUNTSOLIDTILES = "<L.AMOUNTSOLIDTILES>",
AMOUNTSPIKES = "<L.AMOUNTSPIKES>",


UNEXPECTEDSCRIPTLINE = "<L.UNEXPECTEDSCRIPTLINE>",
DUPLICATESCRIPT = "<L.DUPLICATESCRIPT>",
MAPWIDTHINVALID = "<L.MAPWIDTHINVALID>",
MAPHEIGHTINVALID = "<L.MAPHEIGHTINVALID>",
LEVMUSICEMPTY = "<L.LEVMUSICEMPTY>",
NOT400ROOMS = "<L.NOT400ROOMS>",
MOREERRORS = "<L.MOREERRORS>",

DEBUGMODEON = "<L.DEBUGMODEON>",
FPS = "<L.FPS>",
STATE = "<L.STATE>",
MOUSE = "<L.MOUSE>",

BLUE = "<L.BLUE>",
RED = "<L.RED>",
CYAN = "<L.CYAN>",
PURPLE = "<L.PURPLE>",
YELLOW = "<L.YELLOW>",
GREEN = "<L.GREEN>",
GRAY = "<L.GRAY>",
PINK = "<L.PINK>",
BROWN = "<L.BROWN>",
RAINBOWBG = "<L.RAINBOWBG>",

SYNTAXCOLORS = "<L.SYNTAXCOLORS>",
SYNTAXCOLORSETTINGSTITLE = "<L.SYNTAXCOLORSETTINGSTITLE>",
SYNTAXCOLOR_COMMAND = "<L.SYNTAXCOLOR_COMMAND>",
SYNTAXCOLOR_GENERIC = "<L.SYNTAXCOLOR_GENERIC>",
SYNTAXCOLOR_SEPARATOR = "<L.SYNTAXCOLOR_SEPARATOR>",
SYNTAXCOLOR_NUMBER = "<L.SYNTAXCOLOR_NUMBER>",
SYNTAXCOLOR_TEXTBOX = "<L.SYNTAXCOLOR_TEXTBOX>",
SYNTAXCOLOR_ERRORTEXT = "<L.SYNTAXCOLOR_ERRORTEXT>",
SYNTAXCOLOR_CURSOR = "<L.SYNTAXCOLOR_CURSOR>",
SYNTAXCOLOR_FLAGNAME = "<L.SYNTAXCOLOR_FLAGNAME>",
SYNTAXCOLOR_NEWFLAGNAME = "<L.SYNTAXCOLOR_NEWFLAGNAME>",
SYNTAXCOLOR_COMMENT = "<L.SYNTAXCOLOR_COMMENT>",
SYNTAXCOLOR_WRONGLANG = "<L.SYNTAXCOLOR_WRONGLANG>",
RESETCOLORS = "<L.RESETCOLORS>",
STRINGNOTFOUND = "<L.STRINGNOTFOUND>",

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "<L.MAL>",
METADATACORRUPT = "<L.METADATACORRUPT>",
METADATAITEMCORRUPT = "<L.METADATAITEMCORRUPT>",
TILESCORRUPT = "<L.TILESCORRUPT>",
ENTITIESCORRUPT = "<L.ENTITIESCORRUPT>",
LEVELMETADATACORRUPT = "<L.LEVELMETADATACORRUPT>",
SCRIPTCORRUPT = "<L.SCRIPTCORRUPT>",

LOADSCRIPTMADE = "<L.LOADSCRIPTMADE>",
COPY = "<L.COPY>",
CUSTOMSIZE = "<L.CUSTOMSIZE>",
SELECTINGA = "<L.SELECTINGA>",
SELECTINGB = "<L.SELECTINGB>",
TILESETSRELOADED = "<L.TILESETSRELOADED>",

BACKUPS = "<L.BACKUPS>",
BACKUPSOFLEVEL = "<L.BACKUPSOFLEVEL>",
LASTMODIFIEDTIME = "<L.LASTMODIFIEDTIME>", -- List header
OVERWRITTENTIME = "<L.OVERWRITTENTIME>", -- List header
SAVEBACKUP = "<L.SAVEBACKUP>",
DATEFORMAT = "<L.DATEFORMAT>",
TIMEFORMAT = "<L.TIMEFORMAT>",
SAVEBACKUPNOBACKUP = "<L.SAVEBACKUPNOBACKUP>",

AUTOSAVECRASHLOGS = "<L.AUTOSAVECRASHLOGS>",
MOREINFO = "<L.MOREINFO>",
COPYLINK = "<L.COPYLINK>",
SCRIPTDISPLAY = "<L.SCRIPTDISPLAY>",
SCRIPTDISPLAY_USED = "<L.SCRIPTDISPLAY_USED>",
SCRIPTDISPLAY_UNUSED = "<L.SCRIPTDISPLAY_UNUSED>",

RECENTLYOPENED = "<L.RECENTLYOPENED>",
REMOVERECENT = "<L.REMOVERECENT>",
RESETCUSTOMBRUSH = "<L.RESETCUSTOMBRUSH>",

DISPLAYSETTINGS = "<L.DISPLAYSETTINGS>",
DISPLAYSETTINGSTITLE = "<L.DISPLAYSETTINGSTITLE>",
SMALLERSCREEN = "<L.SMALLERSCREEN>",
FORCESCALE = "<L.FORCESCALE>",
SCALENOFIT = "<L.SCALENOFIT>",
SCALENONUM = "<L.SCALENONUM>",
MONITORSIZE = "<L.MONITORSIZE>",
VEDRES = "<L.VEDRES>",
NONINTSCALE = "<L.NONINTSCALE>",

USEFONTPNG = "<L.USEFONTPNG>",
USELEVELFONTPNG = "<L.USELEVELFONTPNG>",
REQUIRESHIGHERLOVE = "<L.REQUIRESHIGHERLOVE>",
FPSLIMIT = "<L.FPSLIMIT>",

MAPRESOLUTION = "<L.MAPRESOLUTION>", -- Map export size
MAPRES_ASSHOWN = "<L.MAPRES_ASSHOWN>", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "<L.MAPRES_PERCENT>", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "<L.MAPRES_RATIO>", -- Example: 1:8 (40x30 per room)
TOPLEFT = "<L.TOPLEFT>",
WIDTHHEIGHT = "<L.WIDTHHEIGHT>",
BOTTOMRIGHT = "<L.BOTTOMRIGHT>",
RENDERERINFO = "<L.RENDERERINFO>",
MAPINCOMPLETE = "<L.MAPINCOMPLETE>",
KEEPDIALOGOPEN = "<L.KEEPDIALOGOPEN>",
TRANSPARENTMAPBG = "<L.TRANSPARENTMAPBG>",
MAPEXPORTERROR = "<L.MAPEXPORTERROR>",
VIEWIMAGE = "<L.VIEWIMAGE>", -- Verb, view image
INVALIDLINENUMBER = "<L.INVALIDLINENUMBER>",
OPENLEVELSFOLDER = "<L.OPENLEVELSFOLDER>", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "<L.MOVEENTITY>",
GOTOROOM = "<L.GOTOROOM>",
ESCTOCANCEL = "<L.ESCTOCANCEL>",

INVALIDFILENAME_WIN = "<L.INVALIDFILENAME_WIN>",
INVALIDFILENAME_MAC = "<L.INVALIDFILENAME_MAC>",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "<L.TINY_CTRL>",
TINY_SHIFT = "<L.TINY_SHIFT>",
TINY_ALT = "<L.TINY_ALT>",
TINY_ESC = "<L.TINY_ESC>",
TINY_TAB = "<L.TINY_TAB>",
TINY_HOME = "<L.TINY_HOME>",
TINY_END = "<L.TINY_END>",
TINY_INSERT = "<L.TINY_INSERT>",
TINY_DEL = "<L.TINY_DEL>",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "<L.SEARCHRESULTS_SCRIPTS>",
SEARCHRESULTS_ROOMS = "<L.SEARCHRESULTS_ROOMS>",
SEARCHRESULTS_NOTES = "<L.SEARCHRESULTS_NOTES>",

ASSETS = "<L.ASSETS>", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "<L.MUSICPLAYERROR>",
SOUNDPLAYERROR = "<L.SOUNDPLAYERROR>",
MUSICLOADERROR = "<L.MUSICLOADERROR>",
MUSICLOADERROR_TOOSMALL = "<L.MUSICLOADERROR_TOOSMALL>",
MUSICEXISTSYES = "<L.MUSICEXISTSYES>",
MUSICEXISTSNO = "<L.MUSICEXISTSNO>",
ASSETS_FOLDER_EXISTS_NO = "<L.ASSETS_FOLDER_EXISTS_NO>",
ASSETS_FOLDER_EXISTS_YES = "<L.ASSETS_FOLDER_EXISTS_YES>",
NO_ASSETS_SUBFOLDER = "<L.NO_ASSETS_SUBFOLDER>",
LOAD = "<L.LOAD>",
RELOAD = "<L.RELOAD>",
UNLOAD = "<L.UNLOAD>",
MUSICEDITOR = "<L.MUSICEDITOR>",
LOADMUSICNAME = "<L.LOADMUSICNAME>",
SAVEMUSICNAME = "<L.SAVEMUSICNAME>",
INSERTSONG = "<L.INSERTSONG>",
SUREDELETESONG = "<L.SUREDELETESONG>",
SONGOPENFAIL = "<L.SONGOPENFAIL>",
SONGREPLACEFAIL = "<L.SONGREPLACEFAIL>",
KILOBYTES = "<L.KILOBYTES>",
MEGABYTES = "<L.MEGABYTES>",
GIGABYTES = "<L.GIGABYTES>",
CANNOTUSENEWLINES = "<L.CANNOTUSENEWLINES>",
MUSICTITLE = "<L.MUSICTITLE>",
MUSICARTIST = "<L.MUSICARTIST>",
MUSICFILENAME = "<L.MUSICFILENAME>",
MUSICNOTES = "<L.MUSICNOTES>",
SONGMETADATA = "<L.SONGMETADATA>",
MUSICFILEMETADATA = "<L.MUSICFILEMETADATA>",
MUSICEXPORTEDON = "<L.MUSICEXPORTEDON>", -- Followed by date and time
SAVEMETADATA = "<L.SAVEMETADATA>",
SOUNDS = "<L.SOUNDS>",
GRAPHICS = "<L.GRAPHICS>",
FILEOPENERNAME = "<L.FILEOPENERNAME>",
PATHINVALID = "<L.PATHINVALID>",
DRIVES = "<L.DRIVES>", -- like C: or F: on Windows
DOFILTER = "<L.DOFILTER>", -- "*.txt" for example
DOFILTERDIR = "<L.DOFILTERDIR>",
FILEDIALOGLUV = "<L.FILEDIALOGLUV>",
RESET = "<L.RESET>",
CHANGEVERB = "<L.CHANGEVERB>", -- verb
LOADIMAGE = "<L.LOADIMAGE>",
GRID = "<L.GRID>",
NOTALPHAONLY = "<L.NOTALPHAONLY>",

UNSAVED_LEVEL_ASSETS_FOLDER = "<L.UNSAVED_LEVEL_ASSETS_FOLDER>",
CREATE_ASSETS_FOLDER = "<L.CREATE_ASSETS_FOLDER>", -- $1: path
CREATE_VVVVVV_FOLDER = "<L.CREATE_VVVVVV_FOLDER>",
CREATE_LEVELS_FOLDER = "<L.CREATE_LEVELS_FOLDER>",
CREATE_FOLDER_FAIL = "<L.CREATE_FOLDER_FAIL>",
ASSETS_FOLDER_FOR_LEVEL = "<L.ASSETS_FOLDER_FOR_LEVEL>",

OPAQUEROOMNAMEBACKGROUND = "<L.OPAQUEROOMNAMEBACKGROUND>",
PLATVCHANGE_TITLE = "<L.PLATVCHANGE_TITLE>",
PLATVCHANGE_MSG = "<L.PLATVCHANGE_MSG>",
PLATVCHANGE_INVALID = "<L.PLATVCHANGE_INVALID>",
RENAMESCRIPTREFERENCES = "<L.RENAMESCRIPTREFERENCES>",
PLATFORMSPEEDSLIDER = "<L.PLATFORMSPEEDSLIDER>",

TRINKETS = "<L.TRINKETS>",
LISTALLTRINKETS = "<L.LISTALLTRINKETS>", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "<L.LISTOFALLTRINKETS>",
NOTRINKETSINLEVEL = "<L.NOTRINKETSINLEVEL>",
CREWMATES = "<L.CREWMATES>",
LISTALLCREWMATES = "<L.LISTALLCREWMATES>", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "<L.LISTOFALLCREWMATES>",
NOCREWMATESINLEVEL = "<L.NOCREWMATESINLEVEL>",
SHIFTROOMS = "<L.SHIFTROOMS>", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "<L.FRAMESTOSECONDS>",
ROOMNUM = "<L.ROOMNUM>",
SOUNDNUM = "<L.SOUNDNUM>",
TRACKNUM = "<L.TRACKNUM>",
STOPSMUSIC = "<L.STOPSMUSIC>",
PLAYSOUND = "<L.PLAYSOUND>",
EDITSCRIPTWOBUMPING = "<L.EDITSCRIPTWOBUMPING>",
EDITSCRIPTWBUMPING = "<L.EDITSCRIPTWBUMPING>",
CLICKONTHING = "<L.CLICKONTHING>",
ORDRAGDROP = "<L.ORDRAGDROP>", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "<L.MORETHANONESTARTPOINT>",
STARTPOINTNOTFOUND = "<L.STARTPOINTNOTFOUND>",

CONFIRMBIGGERSIZE = "<L.CONFIRMBIGGERSIZE>",
MAPBIGGERTHANSIZELIMIT = "<L.MAPBIGGERTHANSIZELIMIT>",
BTNOVERRIDE = "<L.BTNOVERRIDE>",
TARGETPLATFORM = "<L.TARGETPLATFORM>", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "<L.PLATFORM_V>",
TIMETRIALS = "<L.TIMETRIALS>",
TIMETRIALTRINKETS = "<L.TIMETRIALTRINKETS>",
TIMETRIALTIME = "<L.TIMETRIALTIME>",
SUREDELETETRIAL = "<L.SUREDELETETRIAL>",

CUT = "<L.CUT>",
PASTE = "<L.PASTE>",
SELECTWORD = "<L.SELECTWORD>",
SELECTLINE = "<L.SELECTLINE>",
SELECTALL = "<L.SELECTALL>",
INSERTRAWHEX = "<L.INSERTRAWHEX>",
MOVELINEUP = "<L.MOVELINEUP>",
MOVELINEDOWN = "<L.MOVELINEDOWN>",
DUPLICATELINE = "<L.DUPLICATELINE>",

WHEREPLACEPLAYER = "<L.WHEREPLACEPLAYER>",
YOUAREPLAYTESTING = "<L.YOUAREPLAYTESTING>",
LOCATEVVVVVV = "<L.LOCATEVVVVVV>", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "<L.ALREADYPLAYTESTING>",
PLAYTESTINGFAILED = "<L.PLAYTESTINGFAILED>",
VVVVVV_EXITCODE_FAILURE = "<L.VVVVVV_EXITCODE_FAILURE>", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "<L.VVVVVV_22_OR_OLDER>",
VVVVVV_SOMETHING_HAPPENED = "<L.VVVVVV_SOMETHING_HAPPENED>",
PLAYTESTUNAVAILABLE = "<L.PLAYTESTUNAVAILABLE>", -- you cannot playtest on <operating system>
VVVVVVFILE = "<L.VVVVVVFILE>",

PLAYTESTINGOPTIONS = "<L.PLAYTESTINGOPTIONS>",
PLAYTESTING_EXECUTABLE_NOTSET = "<L.PLAYTESTING_EXECUTABLE_NOTSET>", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "<L.PLAYTESTING_EXECUTABLE_SET>", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "<L.FIND_V_EXE_ERROR>",
FIND_V_EXE_FOUNDERROR = "<L.FIND_V_EXE_FOUNDERROR>",
FIND_V_EXE_NOTFOUND = "<L.FIND_V_EXE_NOTFOUND>",
FIND_V_EXE_MULTI = "<L.FIND_V_EXE_MULTI>",

FIND_V_EXE_EXPLANATION = "<L.FIND_V_EXE_EXPLANATION>",

VCE_REMOVED = "<L.VCE_REMOVED>",

VVVVVV_VERSION = "<L.VVVVVV_VERSION>", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "<L.VVVVVV_VERSION_AUTO>",
VVVVVV_VERSION_23PLUS = "<L.VVVVVV_VERSION_23PLUS>",
VVVVVV_VERSION_24PLUS = "<L.VVVVVV_VERSION_24PLUS>",

ALL_PLUGINS = "<L.ALL_PLUGINS>",
ALL_PLUGINS_MOREINFO = "<L.ALL_PLUGINS_MOREINFO>",
ALL_PLUGINS_FOLDER = "<L.ALL_PLUGINS_FOLDER>",
ALL_PLUGINS_NOPLUGINS = "<L.ALL_PLUGINS_NOPLUGINS>",

PLUGIN_NOT_SUPPORTED = "<L.PLUGIN_NOT_SUPPORTED>",
PLUGIN_AUTHOR_VERSION = "<L.PLUGIN_AUTHOR_VERSION>", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "<L.CREATE_LOAD_SCRIPT>",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "<L.CREATE_LOAD_SCRIPT_NO>",
CREATE_LOAD_SCRIPT_RUNONCE = "<L.CREATE_LOAD_SCRIPT_RUNONCE>",
CREATE_LOAD_SCRIPT_REPEATING = "<L.CREATE_LOAD_SCRIPT_REPEATING>",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "<L.CREATE_LOAD_SCRIPT_TITLE_NO>",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "<L.CREATE_LOAD_SCRIPT_EXPL_T_NO>",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "<L.CREATE_LOAD_SCRIPT_EXPL_S_NO>",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "<L.CREATE_LOAD_SCRIPT_TITLE_RUNONCE>",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "<L.CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE>",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "<L.CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE>",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "<L.CREATE_LOAD_SCRIPT_TITLE_REPEATING>",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "<L.CREATE_LOAD_SCRIPT_EXPL_T_REPEATING>",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "<L.CREATE_LOAD_SCRIPT_EXPL_S_REPEATING>",

CUSTOM_SIZED_BRUSH = "<L.CUSTOM_SIZED_BRUSH>",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "<L.CUSTOM_SIZED_BRUSH_BRUSH>",
CUSTOM_SIZED_BRUSH_STAMP = "<L.CUSTOM_SIZED_BRUSH_STAMP>",
CUSTOM_SIZED_BRUSH_TILESET = "<L.CUSTOM_SIZED_BRUSH_TILESET>",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "<L.CUSTOM_SIZED_BRUSH_TITLE_BRUSH>",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "<L.CUSTOM_SIZED_BRUSH_EXPL_BRUSH>",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "<L.CUSTOM_SIZED_BRUSH_TITLE_STAMP>",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "<L.CUSTOM_SIZED_BRUSH_EXPL_STAMP>",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "<L.CUSTOM_SIZED_BRUSH_TITLE_TILESET>",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "<L.CUSTOM_SIZED_BRUSH_EXPL_TILESET>",

ADVANCED_LEVEL_OPTIONS = "<L.ADVANCED_LEVEL_OPTIONS>",
ONEWAYCOL_OVERRIDE = "<L.ONEWAYCOL_OVERRIDE>", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "<L.ZIP_SAVE_AS>", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "<L.ZIP_CREATE_TITLE>",
ZIP_BUSY_TITLE = "<L.ZIP_BUSY_TITLE>",
ZIP_LOVE11_ONLY = "<L.ZIP_LOVE11_ONLY>", -- $1: version number
ZIP_SAVING_SUCCESS = "<L.ZIP_SAVING_SUCCESS>",
ZIP_SAVING_FAIL = "<L.ZIP_SAVING_FAIL>",

OPENFOLDER = "<L.OPENFOLDER>", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "<L.LEVELFONT>",

TEXTBOXCOLORS_BUTTON = "<L.TEXTBOXCOLORS_BUTTON>",
TEXTBOXCOLORS_TITLE = "<L.TEXTBOXCOLORS_TITLE>",
TEXTBOXCOLORS_RENAME = "<L.TEXTBOXCOLORS_RENAME>",
TEXTBOXCOLORS_DUPLICATE = "<L.TEXTBOXCOLORS_DUPLICATE>",
TEXTBOXCOLORS_CREATE = "<L.TEXTBOXCOLORS_CREATE>",

LIB_LOAD_ERRMSG_BIDI = "<L.LIB_LOAD_ERRMSG_BIDI>",
LIB_LOAD_ERRMSG_AV = "<L.LIB_LOAD_ERRMSG_AV>",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "<L_PLU.NUMUNSUPPORTEDPLUGINS>",
	},
	LEVELFAILEDCHECKS = {
		[0] = "<L_PLU.LEVELFAILEDCHECKS>",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "<L_PLU.SCRIPTUSAGESROOMS>",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "<L_PLU.SCRIPTUSAGESSCRIPTS>",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "<L_PLU.ENTITYINVALIDPROPERTIES>",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "<L_PLU.ROOMINVALIDPROPERTIES>",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "<L_PLU.SCRIPTDISPLAY_SHOWING>",
	},
	FLAGUSAGES = {
		[0] = "<L_PLU.FLAGUSAGES>",
	},
	NOTALLTILESVALID = {
		[0] = "<L_PLU.NOTALLTILESVALID>",
	},
	BYTES = {
		[0] = "<L_PLU.BYTES>",
	},
	LITERALNULLS = {
		[0] = "<L_PLU.LITERALNULLS>",
	},
	XMLNULLS = {
		[0] = "<L_PLU.XMLNULLS>",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "<L_PLU.NUM_GRAPHICS_CUSTOMIZED>",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "<L_PLU.NUM_SOUNDS_CUSTOMIZED>",
	},
}

toolnames = {

"<toolnames.1>",
"<toolnames.2>",
"<toolnames.3>",
"<toolnames.4>",
"<toolnames.5>",
"<toolnames.6>",
"<toolnames.7>",
"<toolnames.8>",
"<toolnames.9>",
"<toolnames.10>",
"<toolnames.11>",
"<toolnames.12>",
"<toolnames.13>",
"<toolnames.14>",
"<toolnames.15>",
"<toolnames.16>",
"<toolnames.17>",

}

subtoolnames = {

[1] = {"<subtoolnames.1.1>", "<subtoolnames.1.2>", "<subtoolnames.1.3>", "<subtoolnames.1.4>", "<subtoolnames.1.5>", "<subtoolnames.1.6>", "<subtoolnames.1.7>", "<subtoolnames.1.8>", "<subtoolnames.1.9>", "<subtoolnames.1.10>"},
[2] = {},
[3] = {"<subtoolnames.3.1>", "<subtoolnames.3.2>", "<subtoolnames.3.3>", "<subtoolnames.3.4>"},
[4] = {},
[5] = {"<subtoolnames.5.1>", "<subtoolnames.5.2>"},
[6] = {},
[7] = {"<subtoolnames.7.1>", "<subtoolnames.7.2>", "<subtoolnames.7.3>", "<subtoolnames.7.4>"},
[8] = {"<subtoolnames.8.1>", "<subtoolnames.8.2>", "<subtoolnames.8.3>", "<subtoolnames.8.4>"},
[9] = {},
[10] = {"<subtoolnames.10.1>", "<subtoolnames.10.2>"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"<subtoolnames.14.1>", "<subtoolnames.14.2>"},
[15] = {},
[16] = {"<subtoolnames.16.1>", "<subtoolnames.16.2>", "<subtoolnames.16.3>", "<subtoolnames.16.4>", "<subtoolnames.16.5>", "<subtoolnames.16.6>", "<subtoolnames.16.7>"},
[17] = {"<subtoolnames.17.1>", "<subtoolnames.17.2>"},

}

warpdirs = {

[0] = "<warpdirs.0>",
[1] = "<warpdirs.1>",
[2] = "<warpdirs.2>",
[3] = "<warpdirs.3>",

}

warpdirchangedtext = {

[0] = "<warpdirchangedtext.0>",
[1] = "<warpdirchangedtext.1>",
[2] = "<warpdirchangedtext.2>",
[3] = "<warpdirchangedtext.3>",

}

langtilesetnames = {

short0 = "<langtilesetnames.short0>",
long0 = "<langtilesetnames.long0>",
short1 = "<langtilesetnames.short1>",
long1 = "<langtilesetnames.long1>",
short2 = "<langtilesetnames.short2>",
long2 = "<langtilesetnames.long2>",
short3 = "<langtilesetnames.short3>",
long3 = "<langtilesetnames.long3>",
short4 = "<langtilesetnames.short4>",
long4 = "<langtilesetnames.long4>",
short5 = "<langtilesetnames.short5>",
long5 = "<langtilesetnames.long5>",

}

ERR_VEDHASCRASHED = "<ERR_VEDHASCRASHED>"
ERR_VEDVERSION = "<ERR_VEDVERSION>"
ERR_LOVEVERSION = "<ERR_LOVEVERSION>"
ERR_STATE = "<ERR_STATE>"
ERR_OS = "<ERR_OS>"
ERR_TIMESINCESTART = "<ERR_TIMESINCESTART>"
ERR_PLUGINS = "<ERR_PLUGINS>"
ERR_PLUGINSNOTLOADED = "<ERR_PLUGINSNOTLOADED>"
ERR_PLUGINSNONE = "<ERR_PLUGINSNONE>"
ERR_PLEASETELLDAV = "<ERR_PLEASETELLDAV>"
ERR_INTERMEDIATE = "<ERR_INTERMEDIATE>" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = "<ERR_TOONEW>"

ERR_PLUGINERROR = "<ERR_PLUGINERROR>"
ERR_FILE = "<ERR_FILE>"
ERR_FILEEDITORS = "<ERR_FILEEDITORS>"
ERR_CURRENTPLUGIN = "<ERR_CURRENTPLUGIN>"
ERR_PLEASETELLAUTHOR = "<ERR_PLEASETELLAUTHOR>"
ERR_CONTINUE = "<ERR_CONTINUE>"
ERR_OPENPLUGINSFOLDER = "<ERR_OPENPLUGINSFOLDER>"
ERR_REPLACECODE = "<ERR_REPLACECODE>"
ERR_REPLACECODEPATTERN = "<ERR_REPLACECODEPATTERN>"
ERR_LINESTOTAL = "<ERR_LINESTOTAL>"

ERR_SAVELEVEL = "<ERR_SAVELEVEL>"
ERR_SAVESUCC = "<ERR_SAVESUCC>"
ERR_SAVEERROR = "<ERR_SAVEERROR>"
ERR_LOGSAVED = "<ERR_LOGSAVED>"


diffmessages = {
	pages = {
		levelproperties = "<diffmessages.pages.levelproperties>",
		changedrooms = "<diffmessages.pages.changedrooms>",
		changedroommetadata = "<diffmessages.pages.changedroommetadata>",
		entities = "<diffmessages.pages.entities>",
		scripts = "<diffmessages.pages.scripts>",
		flagnames = "<diffmessages.pages.flagnames>",
		levelnotes = "<diffmessages.pages.levelnotes>",
	},
	levelpropertiesdiff = {
		Title = "<diffmessages.levelpropertiesdiff.Title>",
		Creator = "<diffmessages.levelpropertiesdiff.Creator>",
		website = "<diffmessages.levelpropertiesdiff.website>",
		Desc1 = "<diffmessages.levelpropertiesdiff.Desc1>",
		Desc2 = "<diffmessages.levelpropertiesdiff.Desc2>",
		Desc3 = "<diffmessages.levelpropertiesdiff.Desc3>",
		mapsize = "<diffmessages.levelpropertiesdiff.mapsize>",
		mapsizenote = "<diffmessages.levelpropertiesdiff.mapsizenote>",
		levmusic = "<diffmessages.levelpropertiesdiff.levmusic>",
	},
	rooms = {
		added1 = "<diffmessages.rooms.added1>",
		added2 = "<diffmessages.rooms.added2>",
		changed1 = "<diffmessages.rooms.changed1>",
		changed2 = "<diffmessages.rooms.changed2>",
		cleared1 = "<diffmessages.rooms.cleared1>",
		cleared2 = "<diffmessages.rooms.cleared2>",
	},
	roommetadata = {
		changed0 = "<diffmessages.roommetadata.changed0>",
		changed1 = "<diffmessages.roommetadata.changed1>",
		roomname = "<diffmessages.roommetadata.roomname>",
		roomnameremoved = "<diffmessages.roommetadata.roomnameremoved>",
		roomnameadded = "<diffmessages.roommetadata.roomnameadded>",
		tileset = "<diffmessages.roommetadata.tileset>",
		platv = "<diffmessages.roommetadata.platv>",
		enemytype = "<diffmessages.roommetadata.enemytype>",
		platbounds = "<diffmessages.roommetadata.platbounds>",
		enemybounds = "<diffmessages.roommetadata.enemybounds>",
		directmode01 = "<diffmessages.roommetadata.directmode01>",
		directmode10 = "<diffmessages.roommetadata.directmode10>",
		warpdir = "<diffmessages.roommetadata.warpdir>",
	},
	entities = {
		added = "<diffmessages.entities.added>",
		removed = "<diffmessages.entities.removed>",
		changed = "<diffmessages.entities.changed>",
		changedtype = "<diffmessages.entities.changedtype>",
		multiple1 = "<diffmessages.entities.multiple1>",
		multiple2 = "<diffmessages.entities.multiple2>",
		addedmultiple = "<diffmessages.entities.addedmultiple>",
		removedmultiple = "<diffmessages.entities.removedmultiple>",
		entity = "<diffmessages.entities.entity>",
		incomplete = "<diffmessages.entities.incomplete>",
	},
	scripts = {
		added = "<diffmessages.scripts.added>",
		removed = "<diffmessages.scripts.removed>",
		edited = "<diffmessages.scripts.edited>",
	},
	flagnames = {
		added = "<diffmessages.flagnames.added>",
		removed = "<diffmessages.flagnames.removed>",
		edited = "<diffmessages.flagnames.edited>",
	},
	levelnotes = {
		added = "<diffmessages.levelnotes.added>",
		removed = "<diffmessages.levelnotes.removed>",
		edited = "<diffmessages.levelnotes.edited>",
	},
	mde = {
		added = "<diffmessages.mde.added>",
		removed = "<diffmessages.mde.removed>",
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

Flags can be combined, like \rh or \hr for a red header
Invalid flags will be ignored

1234567890123456789012

Room for 82 characters on a line (85, but the last three characters will have a scrollbar if it is needed. 
----------------------------------------------------------------------------------[]-
]]

{
splitid = "010_Getting_started",
subj = "<LHS.010_Getting_started.subj>",
imgs = {},
cont = [[
<LHS.010_Getting_started.cont>
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "<LHS.020_Tile_placement_modes.subj>",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
<LHS.020_Tile_placement_modes.cont>
]]
},

{
splitid = "030_Tools",
subj = "<LHS.030_Tools.subj>",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
<LHS.030_Tools.cont>
]]
},
{
splitid = "040_Script_editor",
subj = "<LHS.040_Script_editor.subj>",
imgs = {},
cont = [[
<LHS.040_Script_editor.cont>
]]
},

{
splitid = "050_Int_sc_mode",
subj = "<LHS.050_Int_sc_mode.subj>",
imgs = {},
cont = [[
<LHS.050_Int_sc_mode.cont>
]]
},

{
splitid = "060_Shortcuts",
subj = "<LHS.060_Shortcuts.subj>",
imgs = {},
cont = [[
<LHS.060_Shortcuts.cont>
]]
},

{
splitid = "070_Simp_script_reference",
subj = "<LHS.070_Simp_script_reference.subj>",
imgs = {},
cont = [[
<LHS.070_Simp_script_reference.cont>
]]
},

{
splitid = "080_Int_script_reference",
subj = "<LHS.080_Int_script_reference.subj>",
imgs = {},
cont = [[
<LHS.080_Int_script_reference.cont>
]]
},

{
splitid = "090_Lists_reference",
subj = "<LHS.090_Lists_reference.subj>",
imgs = {},
cont = [[
<LHS.090_Lists_reference.cont>
]]
},

{
splitid = "100_Formatting",
subj = "<LHS.100_Formatting.subj>",
imgs = {},
cont = [[
<LHS.100_Formatting.cont>
]]
},

{
splitid = "990_Credits",
subj = "<LHS.990_Credits.subj>",
imgs = {"images/credits.png"},
cont = [[
<LHS.990_Credits.cont>
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}