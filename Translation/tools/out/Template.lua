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
UNKNOWNSTATE = "<L.UNKNOWNSTATE>",
FATALERROR = "<L.FATALERROR>",
FATALEND = "<L.FATALEND>",

OSNOTRECOGNIZED = "<L.OSNOTRECOGNIZED>",
MAXTRINKETS = "<L.MAXTRINKETS>",
MAXCREWMATES = "<L.MAXCREWMATES>",
EDITINGROOMTEXTNIL = "<L.EDITINGROOMTEXTNIL>",
STARTPOINTNOLONGERFOUND = "<L.STARTPOINTNOLONGERFOUND>",
UNSUPPORTEDTOOL = "<L.UNSUPPORTEDTOOL>",
SURENEWLEVEL = "<L.SURENEWLEVEL>",
SURELOADLEVEL = "<L.SURELOADLEVEL>",
COULDNOTGETCONTENTSLEVELFOLDER = "<L.COULDNOTGETCONTENTSLEVELFOLDER>",
MAPSAVEDAS = "<L.MAPSAVEDAS>",
RAWENTITYPROPERTIES = "<L.RAWENTITYPROPERTIES>",
UNKNOWNENTITYTYPE = "<L.UNKNOWNENTITYTYPE>",
METADATAENTITYCREATENOW = "<L.METADATAENTITYCREATENOW>",
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
SUREQUIT = "<L.SUREQUIT>",
SUREQUITNEW = "<L.SUREQUITNEW>",
SURENEWLEVELNEW = "<L.SURENEWLEVELNEW>",
SCALEREBOOT = "<L.SCALEREBOOT>",
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
UNKNOWNUNDOTYPE = "<L.UNKNOWNUNDOTYPE>",
MDEVERSIONWARNING = "<L.MDEVERSIONWARNING>",
FORGOTPATH = "<L.FORGOTPATH>",
MDENOTPASSED = "<L.MDENOTPASSED>",
RESTARTVEDLANG = "<L.RESTARTVEDLANG>",

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

BOUNDSTOPLEFT = "<L.BOUNDSTOPLEFT>",
BOUNDSBOTTOMRIGHT = "<L.BOUNDSBOTTOMRIGHT>",

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
VIEW = "<L.VIEW>",
SYNTAXHLOFF = "<L.SYNTAXHLOFF>",
SYNTAXHLON = "<L.SYNTAXHLON>",
TEXTSIZEN = "<L.TEXTSIZEN>",
TEXTSIZEL = "<L.TEXTSIZEL>",
INSERT = "<L.INSERT>",
HELP = "<L.HELP>",
INTSCRWARNING_NOLOADSCRIPT = "<L.INTSCRWARNING_NOLOADSCRIPT>",
INTSCRWARNING_BOXED = "<L.INTSCRWARNING_BOXED>",
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

COMPARINGTHESE = "<L.COMPARINGTHESE>",
COMPARINGTHESENEW = "<L.COMPARINGTHESENEW>",

RETURN = "<L.RETURN>",
CREATE = "<L.CREATE>",
GOTO = "<L.GOTO>",
DELETE = "<L.DELETE>",
RENAME = "<L.RENAME>",
CHANGEDIRECTION = "<L.CHANGEDIRECTION>",
DIRECTION = "<L.DIRECTION>",
UP = "<L.UP>",
DOWN = "<L.DOWN>",
LEFT = "<L.LEFT>",
RIGHT = "<L.RIGHT>",
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
LOCK = "<L.LOCK>",
UNLOCK = "<L.UNLOCK>",
BUG = "<L.BUG>",

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
PLATFORMSPEED = "<L.PLATFORMSPEED>",
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

ONETRINKETS = "<L.ONETRINKETS>",
ONECREWMATES = "<L.ONECREWMATES>",
ONEENTITIES = "<L.ONEENTITIES>",

LEVELSLIST = "<L.LEVELSLIST>",
LOADTHISLEVEL = "<L.LOADTHISLEVEL>",
ENTERNAMESAVE = "<L.ENTERNAMESAVE>",
SEARCHFOR = "<L.SEARCHFOR>",

VERSIONERROR = "<L.VERSIONERROR>",
VERSIONUPTODATE = "<L.VERSIONUPTODATE>",
VERSIONOLD = "<L.VERSIONOLD>",
VERSIONCHECKING = "<L.VERSIONCHECKING>",
VERSIONDISABLED = "<L.VERSIONDISABLED>",

SAVESUCCESS = "<L.SAVESUCCESS>",
SAVENOSUCCESS = "<L.SAVENOSUCCESS>",

EDIT = "<L.EDIT>",
EDITWOBUMPING = "<L.EDITWOBUMPING>",
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
SAVEFULLSIZEMAP = "<L.SAVEFULLSIZEMAP>",
COPYROOMS = "<L.COPYROOMS>",
SWAPROOMS = "<L.SWAPROOMS>",

FLAGS = "<L.FLAGS>",
ROOM = "<L.ROOM>",
CONTENTFILLER = "<L.CONTENTFILLER>",

FLAGUSED = "<L.FLAGUSED>", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "<L.FLAGNOTUSED>",
FLAGNONAME = "<L.FLAGNONAME>",
USEDOUTOFRANGEFLAGS = "<L.USEDOUTOFRANGEFLAGS>",

CUSTOMVVVVVVDIRECTORY = "<L.CUSTOMVVVVVVDIRECTORY>",
CUSTOMVVVVVVDIRECTORYEXPL = "<L.CUSTOMVVVVVVDIRECTORYEXPL>",
LANGUAGE = "<L.LANGUAGE>",
DIALOGANIMATIONS = "<L.DIALOGANIMATIONS>",
FLIPSUBTOOLSCROLL = "<L.FLIPSUBTOOLSCROLL>",
ADJACENTROOMLINES = "<L.ADJACENTROOMLINES>",
ASKBEFOREQUIT = "<L.ASKBEFOREQUIT>",
NEVERASKBEFOREQUIT = "<L.NEVERASKBEFOREQUIT>",
COORDS0 = "<L.COORDS0>",
ALLOWDEBUG = "<L.ALLOWDEBUG>",
SHOWFPS = "<L.SHOWFPS>",
IIXSCALE = "<L.IIXSCALE>",
CHECKFORUPDATES = "<L.CHECKFORUPDATES>",
PAUSEDRAWUNFOCUSED = "<L.PAUSEDRAWUNFOCUSED>",
ENABLEOVERWRITEBACKUPS = "<L.ENABLEOVERWRITEBACKUPS>",
AMOUNTOVERWRITEBACKUPS = "<L.AMOUNTOVERWRITEBACKUPS>",
SCALE = "<L.SCALE>",
LOADALLMETADATA = "<L.LOADALLMETADATA>",

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

-- b14
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
RESETCOLORS = "<L.RESETCOLORS>",
STRINGNOTFOUND = "<L.STRINGNOTFOUND>",

-- b17 - L.MAL is concatenated with L.[...]CORRUPT
MAL = "<L.MAL>",
METADATACORRUPT = "<L.METADATACORRUPT>",
METADATAITEMCORRUPT = "<L.METADATAITEMCORRUPT>",
TILESCORRUPT = "<L.TILESCORRUPT>",
ENTITIESCORRUPT = "<L.ENTITIESCORRUPT>",
LEVELMETADATACORRUPT = "<L.LEVELMETADATACORRUPT>",
SCRIPTCORRUPT = "<L.SCRIPTCORRUPT>",

-- 1.1.0
LOADSCRIPTMADE = "<L.LOADSCRIPTMADE>",
COPY = "<L.COPY>",
CUSTOMSIZE = "<L.CUSTOMSIZE>",
SELECTINGA = "<L.SELECTINGA>",
SELECTINGB = "<L.SELECTINGB>",
TILESETSRELOADED = "<L.TILESETSRELOADED>",

-- 1.2.0
BACKUPS = "<L.BACKUPS>",
BACKUPSOFLEVEL = "<L.BACKUPSOFLEVEL>",
LASTMODIFIEDTIME = "<L.LASTMODIFIEDTIME>", -- List header
OVERWRITTENTIME = "<L.OVERWRITTENTIME>", -- List header
SAVEBACKUP = "<L.SAVEBACKUP>",
DATEFORMAT = "<L.DATEFORMAT>",
CUSTOMDATEFORMAT = "<L.CUSTOMDATEFORMAT>",
SAVEBACKUPNOBACKUP = "<L.SAVEBACKUPNOBACKUP>",

-- 1.2.4
AUTOSAVECRASHLOGS = "<L.AUTOSAVECRASHLOGS>",
MOREINFO = "<L.MOREINFO>",
COPYLINK = "<L.COPYLINK>",
SCRIPTDISPLAY = "<L.SCRIPTDISPLAY>",
SCRIPTDISPLAY_USED = "<L.SCRIPTDISPLAY_USED>",
SCRIPTDISPLAY_UNUSED = "<L.SCRIPTDISPLAY_UNUSED>",

-- 1.3.0 (more changes)
RECENTLYOPENED = "<L.RECENTLYOPENED>",
REMOVERECENT = "<L.REMOVERECENT>",
RESETCUSTOMBRUSH = "<L.RESETCUSTOMBRUSH>",

-- 1.3.2
DISPLAYSETTINGS = "<L.DISPLAYSETTINGS>",
DISPLAYSETTINGSTITLE = "<L.DISPLAYSETTINGSTITLE>",
SMALLERSCREEN = "<L.SMALLERSCREEN>",
FORCESCALE = "<L.FORCESCALE>",
SCALENOFIT = "<L.SCALENOFIT>",
SCALENONUM = "<L.SCALENONUM>",
MONITORSIZE = "<L.MONITORSIZE>",
VEDRES = "<L.VEDRES>",
NONINTSCALE = "<L.NONINTSCALE>",

-- 1.3.4
USEFONTPNG = "<L.USEFONTPNG>",
MAKESLANGUAGEUNREADABLE = "<L.MAKESLANGUAGEUNREADABLE>", -- If your language uses another alphabet/writing system (thus becomes completely unreadable if only ASCII is used), please translate the following: " (makes Language unreadable!)" where Language is the name of your language.
REQUIRESHIGHERLOVE = "<L.REQUIRESHIGHERLOVE>",
SYNTAXCOLOR_COMMENT = "<L.SYNTAXCOLOR_COMMENT>",
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

[1] = {"<subtoolnames.1.1>", "<subtoolnames.1.2>", "<subtoolnames.1.3>", "<subtoolnames.1.4>", "<subtoolnames.1.5>", "<subtoolnames.1.6>", "<subtoolnames.1.7>", "<subtoolnames.1.8>", "<subtoolnames.1.9>"},
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
) - Return to previous state

Flags can be combined, like \rh or \hr for a red header
Invalid flags will be ignored

1234567890123456789012

Room for 82 characters on a line (85, but the last three characters will have a scrollbar if it is needed. 
----------------------------------------------------------------------------------[]-
]]

{
subj = "<LH.1.subj>",
imgs = {},
cont = [[
<LH.1.cont>
]] -- This should be left the same!
},

{
subj = "<LH.2.subj>",
imgs = {},
cont = [[
<LH.2.cont>
]]
},

{
subj = "<LH.3.subj>",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
<LH.3.cont>
]]
},

{
subj = "<LH.4.subj>",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
<LH.4.cont>
]]
},
{
subj = "<LH.5.subj>",
imgs = {},
cont = [[
<LH.5.cont>
]]
},

{
subj = "<LH.6.subj>",
imgs = {},
cont = [[
<LH.6.cont>
]]
},

{
subj = "<LH.7.subj>",
imgs = {},
cont = [[
<LH.7.cont>
]]
},

{
subj = "<LH.8.subj>",
imgs = {},
cont = [[
<LH.8.cont>
]]
},

{
subj = "<LH.9.subj>",
imgs = {},
cont = [[
<LH.9.cont>
]]
},

{
subj = "<LH.10.subj>",
imgs = {},
cont = [[
<LH.10.cont>
]]
},

{
subj = "<LH.11.subj>",
imgs = {"credits.png"},
cont = [[
<LH.11.cont>
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}