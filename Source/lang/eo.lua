-- Language file for Ved
--- Language: eo (eo)
--- Last converted: 2026-04-11 00:49:31 (CEST)

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

TRANSLATIONCREDIT = "Esperanta traduko de Reese Rivers", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Via versio de LÖVE estas malaktuala. Bonvolu uzi version 0.9.1 aŭ pli altan.\nVi povas elŝuti la plej lastatempan version de LÖVE ĉe https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ne plu subtenas LÖVE 0.9.0, sed versioj 0.9.1 kaj pli altaj ankoraŭ funkcios.\nVi povas elŝuti la plej lastatempan version de LÖVE ĉe https://love2d.org/.",

OSNOTRECOGNIZED = "Via operaciumo ($1) ne estas konata! Defaŭltaj dosiersistemaj funkcioj estas uzataj; niveloj estas konservitaj en:\n\n$2",
MAXTRINKETS = "La maksimuma kvanto da kolektaĵoj ($1) estas atingita en ĉi tiu nivelo.",
MAXCREWMATES = "La maksimuma kvanto da skipanoj ($1) estas atingita en ĉi tiu nivelo.",
UNSUPPORTEDTOOL = "Nesubtenata ilo! Ilo: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Ne eblis akiri la enhavon de la nivel-dosierujo. Bonvolu kontroli ĉu $1 ekzistas, kaj reprovu.",
MAPSAVEDAS = "Map-bildo konserviĝis kiel $1!",
RAWENTITYPROPERTIES = "Vi povas ŝanĝi la krudajn atributvalorojn de ĉi tiu ento ĉi tie.",
UNKNOWNENTITYTYPE = "Nekonata entotipo $1",
WARPTOKENENT404 = "Teleportĵetona ento ne plu ekzistas!",
SPLITFAILED = "Fendado fiaske malsukcesis! Ĉu estas tro da linioj inter tekstkomando kaj speak aŭ speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Ne plu restas pliaj flagoj, do unu aŭ pli da novaj flagetikedoj en ĉi tiu skripto ne povas esti asociita kun iu ajn flagnumero. Ruli la skripton en VVVVVV eble kaŭzos erarojn. Konsideru viŝi ĉiujn referencojn al flagoj, kiujn vi ne plu bezonas, kaj reprovu.",
NOFLAGSLEFT_LOADSCRIPT = "Ne plu restas flagoj, do ne eblis krei ŝargskripton, kiu uzas novan flagon. Anstataŭe, ŝargskripto estas kreita, kiu ĉiam ŝargas la celatan skripton per iftrinkets(0,$1). Konsideru forigi ĉiujn referencojn al flagoj ne plu bezonataj kaj reprovu.",
LEVELOPENFAIL = "Ne eblis malfermi $1.vvvvvv.",
SIZELIMIT = "La maksimuma grando de nivelo estas $1 oble $2.\n\nLa grando anstataŭe ŝanĝiĝos al $3 oble $4.",
SCRIPTALREADYEXISTS = "Skripto \"$1\" jam ekzistas!",
FLAGNAMENUMBERS = "Nomoj de flagoj ne povas esti nur ciferoj.",
FLAGNAMECHARS = "Nomoj de flagoj ne povas enhavi krampojn, komojn aŭ spacetojn.",
FLAGNAMEINUSE = "La flaga nomo $1 jam estas uzata de flago $2",
DIFFSELECT = "Elektu la nivelon komparotan. La nivelo, kiun vi nun elektas, estos traktata kiel pli-malnovan version.",
SUREQUITNEW = "Estas nekonservitaj ŝanĝoj. Ĉu vi volas konservi ilin antaŭ ol eliri?",
SURENEWLEVELNEW = "Estas nekonservitaj ŝanĝoj. Ĉu vi volas konservi ilin antaŭ ol krei novan nivelon?",
SUREOPENLEVEL = "Estas nekonservitaj ŝanĝoj. Ĉu vi volas konservi ilin antaŭ ol malfermi ĉi tiun nivelon?",
NAMEFORFLAG = "Nomo por flago $1:",
SCRIPT404 = "Skripto \"$1\" ne ekzistas!",
ENTITY404 = "Ento #$1 ne plu ekzistas!",
GRAPHICSCARDCANVAS = "Ni bedaŭras, sed ŝajnas ke via grafikokarto ne subtenas tiun funkcion!",
MAXTEXTURESIZE = "Bedaŭrinde, kreado de bildo de $1x$2 ŝajne ne estas subtenata de via grafikokarto aŭ pelilo.\n\nLa limo de grando por tiu ĉi sistemo estas $3x$3.",
SUREDELETESCRIPT = "Ĉu vi certas, ke vi volas forigi la skripton \"$1\"?",
SUREDELETENOTE = "Ĉu vi certas, ke vi volas forigi ĉi tiun noton?",
THREADERROR = "Fadena eraro!",
WHATDIDYOUDO = "Kion vi faris?!",
UNDOFAULTY = "Kion vi faras?",
SOURCEDESTROOMSSAME = "Originala kaj nova ĉambroj estas samaj!",
COORDS_OUT_OF_RANGE = "He? Tiuj ĉi koordinatoj eĉ ne estas en tiu ĉi dimensio!",
UNKNOWNUNDOTYPE = "Nekonata malfaro-tipo \"$1\"!",
MDEVERSIONWARNING = "Ĉi tiu nivelo ŝajnas esti kreita per pli nova versio de Ved, kaj eble enhavas iujn datumojn, kiuj perdiĝos kiam vi konservas la nivelon.",
FORGOTPATH = "Vi forgesis specifi dosierindikon!",
LIB_LOAD_ERRMSG = "Ŝargado de necesa biblioteko malsukcesis. Bonvolu raporti tiun ĉi problemon al Dav999.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nProvu instali GCC por solvi tiun ĉi problemon, se tiu ne estas jam instalita.",

SELECTCOPY1 = "Elektu la ĉambron por kopii",
SELECTCOPY2 = "Elektu la lokon, kien kopiiĝu la ĉambro",
SELECTSWAP1 = "Elektu la unuan ĉambron por permuti",
SELECTSWAP2 = "Elektu la duan ĉambron por permuti",

TILESETCHANGEDTO = "Kahelaro ŝanĝiĝis al $1",
TILESETCOLORCHANGEDTO = "Koloro de kahelaro ŝanĝiĝis al $1",
ENEMYTYPECHANGED = "Malamiko-tipo ŝanĝiĝis al $1",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Kahelo-metado $1 estas uzata",
CHANGEDTOMODEAUTO = "aŭtomata",
CHANGEDTOMODEMANUAL = "permana",
CHANGEDTOMODEMULTI = "multkahelara",

BUSYSAVING = "Konservado...",
SAVEDLEVELAS = "Nivelo konserviĝis kiel $1.vvvvvv",

ROOMCUT = "Ĉambro tondiĝis al tondejo",
ROOMCOPIED = "Ĉambro kopiiĝis al tondejo",
ROOMPASTED = "Ĉambro algluiĝis",

METADATAUNDONE = "Nivelagordoj malfariĝis",
METADATAREDONE = "Nivelagordoj refariĝis",

BOUNDSFIRST = "Alklaku la unuan angulon de la limo", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Alklaku la lastan angulon", -- Old string: Click the bottom right corner

TILE = "Kahelo $1",
HIDEALL = "Kaŝi ĉiujn",
SHOWALL = "Montri ĉiujn",
SCRIPTEDITOR = "Skriptilo",
FILE = "Dosiero",
NEW = "Nova",
OPEN = "Malfermi",
SAVE = "Konservi",
UNDO = "Malfari",
REDO = "Refari",
COMPARE = "Kompari",
STATS = "Statistikoj",
SCRIPTUSAGES = "Uzadoj",
EDITTAB = "Redakti",
COPYSCRIPT = "Kopii skripton",
SEARCHSCRIPT = "Serĉi",
GOTOLINE = "Salti al linio",
GOTOLINE2 = "Salti al linio:",
INTERNALON = "Int.skr: JES",
INTERNALOFF = "Int.skr: NE",
INTERNALON_LONG = "Reĝimo de interna skriptado estas ebligita",
INTERNALOFF_LONG = "Reĝimo de interna skriptado estas malebligita",
INTERNALYESBARS = "Int.skr say(-1)",
INTERNALNOBARS = "Int.skr ŝargskripta",
VIEW = "Vidi",
SYNTAXHLOFF = "Sintakso: JES",
SYNTAXHLON = "Sintakso: NE",
TEXTSIZEN = "Tekstgrando: N",
TEXTSIZEL = "Tekstgrando: G",
INSERT = "Enmeti",
HELP = "Helpo",
INTSCRWARNING_NOLOADSCRIPT = "Ŝargskripto estas bezonata!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Ne detektiĝis skripto, kiu ŝargas tiun ĉi skripton. Tia ĉi interna skripto probable ne funkcios kiel atendate, se ĝi ne estas ŝargata per alia skripto.",
INTSCRWARNING_BOXED = "Rekta referenco de skriptkvadrato/terminalo!",
INTSCRWARNING_BOXED_EXPL = "Estas terminalo aŭ skriptkvadrato, kiu rekte ŝargas tiun ĉi skripton. Aktivigi tiun terminalon aŭ skriptkvadraton probable ne funkcios kiel atendate; tia ĉi interna skripto devas ŝargiĝi per ŝargskripto.",
INTSCRWARNING_NAME = "Netaŭga skriptnomo!",
INTSCRWARNING_NAME_EXPL = "La nomo de tiu ĉi skripto havas majusklan literon, spaceton, krampon aŭ komon. Tia ĉi skripto nur povas rekte ŝargiĝi per terminalo aŭ skriptkvadrato.",
COLUMN = "Kolumno: ",

BTN_OK = "Bone",
BTN_CANCEL = "Nuligi",
BTN_YES = "Jes",
BTN_NO = "Ne",
BTN_APPLY = "Apliki",
BTN_QUIT = "Eliri",
BTN_DISCARD = "Forĵeti",
BTN_SAVE = "Konservi",
BTN_CLOSE = "Fermi",
BTN_LOAD = "Ŝargi",
BTN_ADVANCED = "Altnivele",

BTN_AUTODETECT = "Detekti",
BTN_MANUALLY = "Transpasi", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Reprovi",

COMPARINGTHESE = "Komparado de $1.vvvvvv al $2.vvvvvv",
COMPARINGTHESENEW = "Komparado de nekonservita nivelo al $1.vvvvvv",

RETURN = "Reen",
CREATE = "Krei",
GOTO = "Salti al",
DELETE = "Forigi",
RENAME = "Renomi",
CHANGEDIRECTION = "Ŝanĝi direkton",
TESTFROMHERE = "Testi de ĉi tie",
FLIP = "Renversi",
CYCLETYPE = "Ŝanĝi tipon",
GOTODESTINATION = "Salti al celo",
GOTOENTRANCE = "Salti al enirejo",
CHANGECOLOR = "Ŝanĝi koloron",
EDITTEXT = "Redakti tekston",
COPYTEXT = "Kopii tekston",
EDITSCRIPT = "Redakti skripton",
OTHERSCRIPT = "Ŝanĝi skriptnomon",
PROPERTIES = "Atributoj",
CHANGETOHOR = "Ŝanĝi al horizontala",
CHANGETOVER = "Ŝanĝi al vertikala",
RESIZE = "Movi/regrandigi",
CHANGEENTRANCE = "Movi enirejon",
CHANGEEXIT = "Movi elirejon",
COPYENTRANCE = "Kopii enirejon",
LOCK = "Ŝlosi",
UNLOCK = "Malŝlosi",

VEDOPTIONS = "Ved-agordoj",
LEVELOPTIONS = "Nivelagordoj",
MAP = "Mapo",
SCRIPTS = "Skriptoj",
SEARCH = "Serĉi",
SENDFEEDBACK = "Sendi rimarkojn",
LEVELNOTEPAD = "Nivela notbloko",
PLUGINS = "Aldonaĵoj",

BACKB = "Reen <<",
MOREB = "Pli  >>",
AUTOMODE = "Reĝimo: aŭtomata",
AUTO2MODE = "Reĝimo: multkahelara",
MANUALMODE = "Reĝimo: permana",
ENEMYTYPE = "Malamika tipo: $1",
PLATFORMBOUNDS = "Platformlimo",
WARPDIR = "Teleport-\ndirekto: $1",
ENEMYBOUNDS = "Malamika limo",
ROOMNAME = "Ĉambronomo",
ROOMOPTIONS = "Ĉambro-agordoj",
ROTATE180 = "Turni 180-grade",
ROTATE180UNI = "Turni 180-grade",
HIDEBOUNDS = "Kaŝi limojn",
SHOWBOUNDS = "Montri limojn",

ROOMPLATFORMS = "Platformoj en ĉambro", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Malamikoj en ĉambro",

OPTNAME = "Nomo",
OPTBY = "De",
OPTWEBSITE = "Retejo ",
OPTDESC = "Pri-\nskribo", -- If necessary, you can span multiple lines
OPTSIZE = "Grando",
OPTMUSIC = "Muziko",
CAPNONE = "NENIU",
ENTERLONGOPTNAME = "Nivelo-nomo:",

X = "x", -- Used for level size: 20x20

SOLID = "Masiva",
NOTSOLID = "Nemasiva",

TSCOLOR = "Koloro $1",

LEVELSLIST = "Niveloj",
LOADTHISLEVEL = "Ŝargi nivelon: ",
ENTERNAMESAVE = "Enmetu nomon por konservi: ",
SEARCHFOR = "Serĉi: ",

VERSIONERROR = "Ne eblis kontroli version.",
VERSIONUPTODATE = "Via versio de Ved estas aktuala.",
VERSIONOLD = "Ĝisdatigo disponeblas! Plej lastatempa versio: $1",
VERSIONCHECKING = "Kontrolado de ĝisdatigoj...",
VERSIONDISABLED = "Kontrolado de ĝisdatigoj malŝaltiĝis",
VERSIONCHECKNOW = "Kontroli nun", -- Check for updates now

SAVENOSUCCESS = "Konservado malsukcesis! Eraro: ",
INVALIDFILESIZE = "Nevalida dosiergrando.",

EDIT = "Redakti",
EDITWOBUMPING = "Redakti sen ŝanĝi skriptordon",
EDITWBUMPING = "Redakti kaj suprenigi",
COPYNAME = "Kopii nomon",
COPYCONTENTS = "Kopii enhavon",
DUPLICATE = "Duobligi",

NEWSCRIPTNAME = "Nomo:",
CREATENEWSCRIPT = "Krei novan skripton",

NEWNOTENAME = "Nomo:",
CREATENEWNOTE = "Krei novan noton",

ADDNEWBTN = "[Aldoni novan]",
IMAGEERROR = "[BILD-ERARO]",

NEWNAME = "Nova nomo:",
RENAMENOTE = "Renomi noton",
RENAMESCRIPT = "Renomi skripton",

LINE = "linio ",

SAVEMAP = "Konservi mapon",
COPYROOMS = "Kopii ĉambron",
SWAPROOMS = "Permuti ĉambrojn",

MAP_STYLE = "Stilo de mapo",
MAP_STYLE_FULL = "Plena", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Paŭzekrana", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Flagoj",
ROOM = "ĉambro",
CONTENTFILLER = "Enhavo",

FLAGUSED = "Uzata   ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Ne uzata",
FLAGNONAME = "Sennoma",
USEDOUTOFRANGEFLAGS = "Uzataj ekstervariejaj flagoj:",

VVVVVVSETUP = "Agordado pri VVVVVV",
CUSTOMVVVVVVDIRECTORY = "VVVVVV-dosierujo",
CUSTOMVVVVVVDIRECTORYEXPL = "La defaŭlta dosierujo de VVVVVV, kiun atendas Ved estas:\n$1\n\nTiu dosieruja indiko ne estu agordita al la dosierujo \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Vi ne jam agordis propran dosierujon de VVVVVV.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Via dosierujo de VVVVVV estas agordita al propra indiko:\n$1\n\n",
LANGUAGE = "Lingvo",
DIALOGANIMATIONS = "Dialoganimacioj",
FLIPSUBTOOLSCROLL = "Renversi rulumdirekton de ilo",
ADJACENTROOMLINES = "Indikiloj de kaheloj en najbaraj ĉambroj",
NEVERASKBEFOREQUIT = "Neniam demandi antaŭ ol eliri, eĉ se estas nekonservitaj ŝanĝoj",
COORDS0 = "Montri koordinatojn komence je 0 (kiel en interna skriptado)",
ALLOWDEBUG = "Ebligi sencimigan reĝimon",
SHOWFPS = "Montri kadrojn sekunde",
CHECKFORUPDATES = "Kontroli ĝisdatigojn",
PAUSEDRAWUNFOCUSED = "Ne bildigi kiam la fenestro estas elfokusa",
ENABLEOVERWRITEBACKUPS = "Fari savkopiojn de niveldosieroj, kiuj superskribiĝas",
AMOUNTOVERWRITEBACKUPS = "Nombro da savkopioj konservendaj por ĉiu nivelo",
SCALE = "Skalo",
LOADALLMETADATA = "Ŝargi metadatumojn (kiel titolon, aŭtoron kaj priskribon) por ĉiuj dosieroj en nivelolisto",
COLORED_TEXTBOXES = "Uzi verajn tekstskatol-kolorojn",
MOUSESCROLLINGSPEED = "Mus-ruluma rapido",
BUMPSCRIPTSBYDEFAULT = "Movu skriptojn al la supro de la listo redaktante ilin, kiel defaŭlto",

SCRIPTSPLIT = "Fendi",
SPLITSCRIPT = "Fendi skriptojn",
COUNT = "Kvanto: ",
SMALLENTITYDATA = "datumoj",

-- Stats screen
AMOUNTSCRIPTS = "Skriptoj:",
AMOUNTUSEDFLAGS = "Flagoj:",
AMOUNTENTITIES = "Entoj:",
AMOUNTTRINKETS = "Kolektaĵoj:",
AMOUNTCREWMATES = "Ŝipanoj:",
AMOUNTINTERNALSCRIPTS = "Internaj skriptoj:",
TILESETUSSAGE = "Uzado de kahelaroj",
TILESETSONLYUSED = "(nur ĉambroj kun kaheloj estas konsiderataj)",
AMOUNTROOMSWITHNAMES = "Ĉambroj kun nomoj:",
PLACINGMODEUSAGE = "Kahelmetadaj reĝimoj:",
AMOUNTLEVELNOTES = "Nivelnotoj:",
AMOUNTFLAGNAMES = "Flagnomoj:",
TILESUSAGE = "Uzado de kaheloj",
AMOUNTTILES = "Kaheloj:",
AMOUNTSOLIDTILES = "Masivaj kaheloj:",
AMOUNTSPIKES = "Pikaĵoj:",


UNEXPECTEDSCRIPTLINE = "Neatendita skriptlinio sen skripto: $1",
DUPLICATESCRIPT = "Skripto $1 estas duoblaĵo! Eblas ŝargi nur unu.",
MAPWIDTHINVALID = "Maplarĝo estas nevalida: $1",
MAPHEIGHTINVALID = "Mapalto estas nevalida: $1",
LEVMUSICEMPTY = "Nivela muziko estas nula!",
NOT400ROOMS = "La kvanto da enskriboj en levelMetaData ne estas 400!",
MOREERRORS = "$1 plia(j)",

DEBUGMODEON = "Sencimiga reĝ.: JES",
FPS = "KS",
STATE = "Stato",
MOUSE = "Muso",

BLUE = "Blua",
RED = "Ruĝa",
CYAN = "Bluverda",
PURPLE = "Viola",
YELLOW = "Flava",
GREEN = "Verda",
GRAY = "Griza",
PINK = "Rozkolora",
BROWN = "Bruna",
RAINBOWBG = "Ĉielarka fono",

SYNTAXCOLORS = "Koloroj de sintakso",
SYNTAXCOLORSETTINGSTITLE = "Agordoj de koloroj de skripta sintaksmarkado",
SYNTAXCOLOR_COMMAND = "Komando",
SYNTAXCOLOR_GENERIC = "Komuna",
SYNTAXCOLOR_SEPARATOR = "Dividilo",
SYNTAXCOLOR_NUMBER = "Nombro",
SYNTAXCOLOR_TEXTBOX = "Tekstujo",
SYNTAXCOLOR_ERRORTEXT = "Nekonata komando",
SYNTAXCOLOR_CURSOR = "Kursoro",
SYNTAXCOLOR_FLAGNAME = "Flagnomo",
SYNTAXCOLOR_NEWFLAGNAME = "Nova flagnomo",
SYNTAXCOLOR_COMMENT = "Komento",
SYNTAXCOLOR_WRONGLANG = "Simpligita komando en reĝimo int.sk aŭ male",
RESETCOLORS = "Defaŭltigi kolorojn",
STRINGNOTFOUND = "\"$1\" ne troviĝis",

-- L.MAL is concatenated with an error message
MAL = "La nivelo-dosiero estas misformigita: ",

LOADSCRIPTMADE = "Ŝargskripto kreiĝis",
COPY = "Kopii",
CUSTOMSIZE = "Tajlorita grando de peniko: $1x$2",
SELECTINGA = "Elektado - alklaku supre maldekstre",
SELECTINGB = "Elektado: $1x$2",
TILESETSRELOADED = "Kahelaroj kaj ento-grafikoj reŝargiĝis",

BACKUPS = "Savkopioj",
BACKUPSOFLEVEL = "Savkopioj de nivelo $1",
LASTMODIFIEDTIME = "Originale laste modifita", -- List header
OVERWRITTENTIME = "Superskribita je", -- List header
SAVEBACKUP = "Konservi al dosierujo de VVVVVV",
DATEFORMAT = "Data formo",
TIMEFORMAT = "Tempa formo",
SAVEBACKUPNOBACKUP = "Certigu ke vi elektas unikan nomon por ĉi tio se vi ne volas superskribi ion ajn, ĉar NENIU savkopio estos kreita ĉi-okaze!",

AUTOSAVECRASHLOGS = "Aŭtomate konservi paneajn protokolojn",
MOREINFO = "Plej aktualaj informoj",
COPYLINK = "Kopii ligilon",
SCRIPTDISPLAY = "Montri",
SCRIPTDISPLAY_USED = "Uzita",
SCRIPTDISPLAY_UNUSED = "Neuzita",

RECENTLYOPENED = "Lastatempe malfermitaj niveloj",
REMOVERECENT = "Ĉu vi volas forigi ĝin el la listo de lastatempe malfermitaj niveloj?",
RESETCUSTOMBRUSH = "(Dekstre alklaku por agordi novan grandon)",

DISPLAYSETTINGS = "Ekrano/grando",
DISPLAYSETTINGSTITLE = "Agordoj de ekrano/grando",
SMALLERSCREEN = "Pli malgranda fenestra larĝo (larĝa je 800px anstataŭ 896px)",
FORCESCALE = "Devigi agordojn de grando",
SCALENOFIT = "La nunaj agordoj de grando faras la fenestron pli granda ol la ekrano.",
SCALENONUM = "La nunaj agordoj de grando estas nevalidaj.",
MONITORSIZE = "Ekrano $1x$2",
VEDRES = "Distingivo de Ved: $1x$2",
NONINTSCALE = "Neentjera skalado",

USEFONTPNG = "Uzi font.png de grafika dosierujo de VVVVVV kiel tiparon",
USELEVELFONTPNG = "Uzi font.png de propra nivelo kiel tiparon",
REQUIRESHIGHERLOVE = " (necesas LÖVE $1 aŭ pli nova)",
FPSLIMIT = "KS-limo",

MAPRESOLUTION = "Distingivo", -- Map export size
MAPRES_ASSHOWN = "Kiel montrate (maks. 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% (po $2x$3 por ĉambro)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 (po $3x$4 por ĉambro)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Supra livo",
WIDTHHEIGHT = "Larĝo k alto",
BOTTOMRIGHT = "Funda dekstro",
RENDERERINFO = "Informoj de bildigilo:",
MAPINCOMPLETE = "La mapo ne jam pretas (je la tempo, kiam vi premis Konservi), bonvolu reprovi kiam ĝi pretas.",
KEEPDIALOGOPEN = "Restigi dialogon malferma",
TRANSPARENTMAPBG = "Travidebla fono",
MAPEXPORTERROR = "Eraro okazis dum kreado de mapo.",
VIEWIMAGE = "Vidi", -- Verb, view image
INVALIDLINENUMBER = "Bonvolu enigi validan linio-numeron.",
OPENLEVELSFOLDER = "Malfermi dosierujon", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Movi",
GOTOROOM = "Iri al ĉambro",
ESCTOCANCEL = "[Premu ESK por nuligi]",

INVALIDFILENAME_WIN = "Windows ne permesas la jenajn signojn en dosiernomoj:\n\n: * ? \" < > |\n\n(| estas vertikala streko)",
INVALIDFILENAME_MAC = "macOS ne permesas la signon : en dosiernomoj.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "REG",
TINY_SHIFT = "ŜOV",
TINY_ALT = "ALT",
TINY_ESC = "ESK",
TINY_TAB = "TAB",
TINY_HOME = "HOME",
TINY_END = "END",
TINY_INSERT = "INS",
TINY_DEL = "DEL",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Skriptoj [$1]",
SEARCHRESULTS_ROOMS = "Ĉambroj [$1]",
SEARCHRESULTS_NOTES = "Notoj [$1]",

ASSETS = "Resursoj", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Ne eblas ludi tiun ĉi muzikaĵon. Ĝi eble ne ekzistas aŭ estas de nesubtenata tipo.",
SOUNDPLAYERROR = "Ne eblas ludi tiun ĉi sonon. Ĝi eble ne ekzistas aŭ estas de nesubtenata tipo.",
MUSICLOADERROR = "Ne eblas ŝargi $1: ",
MUSICLOADERROR_TOOSMALL = "La muzikdosiero tro malgrandas por esti valida.",
MUSICEXISTSYES = "Ekzistas",
MUSICEXISTSNO = "Ne ekzistas",
ASSETS_FOLDER_EXISTS_NO = "Ne ekzistas - alklaku por krei",
ASSETS_FOLDER_EXISTS_YES = "Ekzistas - alklaku por malfermi",
NO_ASSETS_SUBFOLDER = "Neniu dosierujo \"$1\"",
LOAD = "Ŝargi",
RELOAD = "Reŝargi",
UNLOAD = "Malŝargi",
MUSICEDITOR = "Muzikredaktilo",
LOADMUSICNAME = "Ŝargi .vvv",
SAVEMUSICNAME = "Konservi .vvv",
INSERTSONG = "Enmeti muzikaĵon en trakon $1",
SUREDELETESONG = "Ĉu vi certas, ke vi volas forigi la muzikaĵon $1?",
SONGOPENFAIL = "Ne eblis malfermi $1, muzikaĵo ne anstataŭiĝis.",
SONGREPLACEFAIL = "Eraro okazis dum anstataŭigi la muzikaĵon.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "Vi ne povas uzi la signon \"$1\" en skriptnomoj!",
MUSICTITLE = "Titolo: ",
MUSICARTIST = "Artisto: ",
MUSICFILENAME = "Dosiernomo: ",
MUSICNOTES = "Notoj:",
SONGMETADATA = "Metadatumoj por muzikaĵo $1",
MUSICFILEMETADATA = "Metadatumoj de dosiero",
MUSICEXPORTEDON = "Eksportita je: ", -- Followed by date and time
SAVEMETADATA = "Konservi metadatumojn",
SOUNDS = "Sonoj",
GRAPHICS = "Grafikoj",
FILEOPENERNAME = "Nomo: ",
PATHINVALID = "La dosierindiko ne validas.",
DRIVES = "Diskoj", -- like C: or F: on Windows
DOFILTER = "Nur montru *$1", -- "*.txt" for example
DOFILTERDIR = "Nur montru dosierujojn",
FILEDIALOGLUV = "Bedaŭrinde, via operaciumo ne estas konata, do la dosierdialogujo ne funkcias.",
RESET = "Restarigi",
CHANGEVERB = "Ŝanĝi", -- verb
LOADIMAGE = "Ŝargi bildon",
GRID = "Krado",
NOTALPHAONLY = "RVB",

UNSAVED_LEVEL_ASSETS_FOLDER = "La nivelo devas esti konservita antaŭ ol propraj resursoj estas uzeblaj.",
CREATE_ASSETS_FOLDER = "Ĉu vi volas krei dosierujon de propraj resursoj por tiu ĉi nivelo?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "Ŝajnas ke la dosierujo de VVVVVV ne jam ekzistas. Ĉu vi volas krei ĝin?",
CREATE_LEVELS_FOLDER = "Ŝajnas ke la nivela dosierujo ne ekzistas. Ĉu vi volas krei ĝin?",
CREATE_FOLDER_FAIL = "Ne eblas krei dosierujon.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Resursa dosierujo por $1",

OPAQUEROOMNAMEBACKGROUND = "Fari la nigrajn fonojn de ĉambronomoj opakaj",
PLATVCHANGE_TITLE = "Ŝanĝi rapidon de platformoj",
PLATVCHANGE_MSG = "Rapido:",
PLATVCHANGE_INVALID = "Vi devas entajpi numeron.",
RENAMESCRIPTREFERENCES = "Renomi referencojn",
PLATFORMSPEEDSLIDER = "Rpd.:",

TRINKETS = "Kolektaĵoj",
LISTALLTRINKETS = "Listigi ĉiujn kolektaĵojn", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Listo de ĉiuj kolektaĵoj",
NOTRINKETSINLEVEL = "Ne estas kolektaĵoj en tiu ĉi nivelo.",
CREWMATES = "Skipanoj",
LISTALLCREWMATES = "Listigi ĉiujn skipanojn", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Listo de ĉiuj saveblaj skipanoj",
NOCREWMATESINLEVEL = "Ne estas saveblaj skipanoj en tiu ĉi nivelo.",
SHIFTROOMS = "Ŝovi ĉambrojn", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 sek",
ROOMNUM = "Ĉambro $1",
SOUNDNUM = "Sono $1",
TRACKNUM = "Trako $1",
STOPSMUSIC = "Haltigas muzikon",
PLAYSOUND = "Ludi sonon",
EDITSCRIPTWOBUMPING = "Redakti skripton sen suprenigi",
EDITSCRIPTWBUMPING = "Redakti skripton kaj suprenigi",
CLICKONTHING = "Alklaku $1",
ORDRAGDROP = "aŭ ŝovmetu ĉi tien", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Estas pli ol unu komencejo en tiu ĉi nivelo!",
STARTPOINTNOTFOUND = "Ne estas komencejo!",

MAPBIGGERTHANSIZELIMIT = "Mapogrando $1 oble $2 estas pli granda ol $3 oble $4!",
BTNOVERRIDE = "Transpasi",
TARGETPLATFORM = "Celata platformo", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Tempoprovoj",
TIMETRIALTRINKETS = "Nombro da kolektaĵoj",
TIMETRIALTIME = "Cel-tempo",
SUREDELETETRIAL = "Ĉu vi certas, ke vi volas forigi la tempoprovon \"$1\"?",

CUT = "Tondi",
PASTE = "Alglui",
SELECTWORD = "Elekti vorton",
SELECTLINE = "Elekti linion",
SELECTALL = "Elekti ĉion",
INSERTRAWHEX = "Enmeti Unicode-signon",
MOVELINEUP = "Movi linion supren",
MOVELINEDOWN = "Movi linion malsupren",
DUPLICATELINE = "Duobligi linion",

WHEREPLACEPLAYER = "Kie vi volas komenci?",
YOUAREPLAYTESTING = "Vi nuntempe ludtestas",
LOCATEVVVVVV = "Elektu vian plenumeblan dosieron de $1", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Vi jam ludtestas!",
PLAYTESTINGFAILED = "Eraro okazis malfermante VVVVVV:\n$1\n\nSe vi devas ŝangi la ruleblan dosieron de VVVVVV, kiu estas uzata por ludtestado, detenu la ŝov-klavon dum premi la ludtestad-butonon.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV fermiĝis kun kodo $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "Ŝajnas ke vi uzas VVVVVV 2.2 aŭ pli malnove. Bonvolu ĝisdatigi ĝin al VVVVVV 2.3 aŭ pli nove.",
VVVVVV_SOMETHING_HAPPENED = "Ŝajnas ke eraro okazis teme pri VVVVVV.",
PLAYTESTUNAVAILABLE = "Bedaŭrinde, vi ne povas ludtesti ĉe $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Bonvolu elekti la dosieron kun nomo '$1'.",

PLAYTESTINGOPTIONS = "Ludtestado",
PLAYTESTING_EXECUTABLE_NOTSET = "Vi ne jam agordis ruleblan dosieron de $1 por uzi dum ludtestado.\nVed petos tion ludante nivelon de $2 unuafoje.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "La rulebla dosiero de $1 por uzi dum ludtestado estas agordita al:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Bedaŭrinde, okazis eraro dum trovado de VVVVVV. Provu permane agordi la indikon al la rulebla dosiero.",
FIND_V_EXE_FOUNDERROR = "Io troviĝis, kio ŝajnas esti VVVVVV, sed ne eblis akiri uzeblan indikon al ĝia rulebla dosiero. Certigu ke vi ne uzas malnovan version de la ludo (necesas 2.3 aŭ pli nove) aŭ provu permane agordi la indikon al la rulebla dosiero.",
FIND_V_EXE_NOTFOUND = "Ŝajnas ke VVVVVV ne estas rulata. Certigu ke VVVVVV estas rulata kaj reprovu.",
FIND_V_EXE_MULTI = "Multaj rulataj aperoj de VVVVVV troviĝis. Certigu ke nur unu versio de la ludo estas malfermita, kaj tiam reprovu.",

FIND_V_EXE_EXPLANATION = "Ved bezonas VVVVVV por ludtestado, kaj unue vi devas agordi la indikon al VVVVVV.\n\n\nPor aŭtomate detekti VVVVVV, simple lanĉu la ludon se ĝi ne estas jam rulata, kaj premu \"Detekti\".",

VCE_REMOVED = "VVVVVV: Community Edition ne plu estas prilaborata, kaj subteno por niveloj de VVVVVV-CE estas forigita de Ved. Tiu ĉi nivelo estos traktata kiel normalan nivelon de VVVVVV. Por pli da informoj, vidu https://vsix.dev/vce/status/",

VVVVVV_VERSION = "Versio de VVVVVV", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Aŭtomata",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Ĉiuj aldonaĵoj",
ALL_PLUGINS_MOREINFO = "Bonvolu iri al ¤https://tolp.nl/ved/plugins.php¤tiu ĉi paĝo¤ por pli da informoj pri aldonaĵoj.\\nLCl",
ALL_PLUGINS_FOLDER = "Via dosierujo de aldonaĵoj estas:",
ALL_PLUGINS_NOPLUGINS = "Vi ne jam havas aldonaĵojn.",

PLUGIN_NOT_SUPPORTED = "[Tiu ĉi aldonaĵo ne estas subtenata, ĉar necesas Ved $1 aŭ pli nove!]\\r",
PLUGIN_AUTHOR_VERSION = "de $1, versio $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Krei ŝargskripton",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Neniun",
CREATE_LOAD_SCRIPT_RUNONCE = "Unufojan",
CREATE_LOAD_SCRIPT_REPEATING = "Ripetan",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Ne krei ŝargskripton",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Tiu ĉi terminalo rekte indikos al la skripto.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Tiu ĉi skriptskatolo rekte indikos al la skripto.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Krei ŝargskripton por ruli unu fojon",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Tiu ĉi terminalo indikos al nova ŝargskripto, kiu ŝargas la veran skripton nur unu fojon en ludado. Ved elektos neuzatan flagon.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Tiu ĉi skriptskatolo indikos al nova ŝargskripto, kiu ŝargas la veran skripton nur unu fojon en ludado. Ved elektos neuzatan flagon.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Krei ripetatan ŝargskripton",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Tiu ĉi terminalo indikos al nova ŝargskripto, kiu senkondiĉe ŝargas la veran skripton.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Tiu ĉi skriptskatolo indikos al nova ŝargskripto, kiu senkondiĉe ŝargas la veran skripton.",

CUSTOM_SIZED_BRUSH = "Tajlorita peniko",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Peniko",
CUSTOM_SIZED_BRUSH_STAMP = "Stampilo",
CUSTOM_SIZED_BRUSH_TILESET = "Kahelaro",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Tajlorita grando de peniko",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Elektu la bezonatan grandon de peniko.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stampilo el ĉambro",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Elektu kahelojn de la ĉambro por krei stampilon.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stampilo el kahelaro",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Elektu kahelojn el la kahelaro por krei stampilon. Tio ĉi funkcias nur en permana reĝimo.",

ADVANCED_LEVEL_OPTIONS = "Altnivelaj agordoj de nivelo",
ONEWAYCOL_OVERRIDE = "Rekolorigu unudirektajn kahelojn ankaŭ en propraj resursoj (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Krei ZIP-arĥivon de ĉi tiu versio por kunhavigo", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Konservi ZIP-arĥivon",
ZIP_BUSY_TITLE = "Kreado de ZIP-arĥivo...",
ZIP_LOVE11_ONLY = "Necesas LÖVE $1 aŭ pli nova por krei ZIP-dosieron", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP-arĥivo konserviĝis!",
ZIP_SAVING_FAIL = "Ne eblis konservi ZIP-dosieron!",

OPENFOLDER = "Malfermi dosierujon", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Nivela tiparo",

TEXTBOXCOLORS_BUTTON = "Tekstaj koloroj",
TEXTBOXCOLORS_TITLE = "Tekstoskatolaj koloroj",
TEXTBOXCOLORS_RENAME = "Renomi koloron \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Duobligi koloron \"$1\"",
TEXTBOXCOLORS_CREATE = "Aldoni novan koloron",

LIB_LOAD_ERRMSG_BIDI = "Malsukcesis ŝargi bibliotekon por dedekstre skribata teksto.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nVia kontraŭvirusilo eble rompas ĝin.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Vi havas $1 aldonaĵon, kiu ne estas subtenata en ĉi tiu versio.",
		[1] = "Vi havas $1 aldonaĵojn, kiuj ne estas subtenataj en ĉi tiu versio.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Ĉi tiu nivelo malsukcesis je $1 kontrolo. La problemo eble estas riparita aŭtomate, sed eblas ke tio ankoraŭ kaŭzos erarojn kaj nekonsekvencaĵojn.",
		[1] = "Ĉi tiu nivelo malsukcesis je $1 kontroloj. La problemoj eble estas riparitaj aŭtomate, sed eblas ke tio ankoraŭ kaŭzos erarojn kaj nekonsekvencaĵojn.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 uzado en ĉambroj: $2",
		[1] = "$1 uzadoj en ĉambroj: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 uzado en skriptoj: $2",
		[1] = "$1 uzadoj en skriptoj: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Ento ĉe [$1 $2] havas $3 nevalidan atributon!",
		[1] = "Ento ĉe [$1 $2] havas $3 nevalidajn atributojn!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata por ĉambro $1,$2 havas $3 nevalidan atributon!",
		[1] = "LevelMetadata por ĉambro $1,$2 havas $3 nevalidajn atributojn!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Montriĝas $1",
		[1] = "Montriĝas $1",
	},
	FLAGUSAGES = {
		[0] = "Uzita $1 fojon en skriptoj: $2",
		[1] = "Uzita $1 fojojn en skriptoj: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 kahelo ne estas valida entjero pli ol aŭ egala al 0",
		[1] = "$1 kaheloj ne estas validaj entjeroj pli ol aŭ egalaj al 0",
	},
	BYTES = {
		[0] = "$1 bajto",
		[1] = "$1 bajtoj",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 bildo estas alproprigita",
		[1] = "$1 bildoj estas alproprigitaj",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 sono estas alproprigita",
		[1] = "$1 sonoj estas alproprigitaj",
	},
}

toolnames = {

"Muro",
"Fono",
"Pikaĵo",
"Kolektaĵo",
"Konservejo",
"Malaperanta platformo",
"Transportbendo",
"Moviĝanta platformo",
"Malamiko",
"Gravita linio",
"Ĉambroteksto",
"Terminalo",
"Skriptkvadrato",
"Teleportĵetono",
"Teleportlinio",
"Skipano",
"Komencejo",

}

subtoolnames = {

[1] = {"Peniko 1x1", "Peniko 3x3", "Peniko 5x5", "Peniko 7x7", "Peniko 9x9", "Plenigi horizontale", "Plenigi vertikale", "Tajlorita grando de peniko", "Plenigilo", "Mirinda mojosa magia terpomo"},
[2] = {},
[3] = {"Aŭtomate", "Aŭtomate ambaŭdirekten", "Aŭtomate maldekstren", "Aŭtomate dekstren"},
[4] = {},
[5] = {"Grunda", "Plafona"},
[6] = {},
[7] = {"Malgranda, dekstren", "Malgranda, maldekstren", "Granda, dekstren", "Granda, maldekstren"},
[8] = {"Malsupren", "Supren", "Maldekstren", "Dekstren"},
[9] = {},
[10] = {"Horizontala", "Vertikala"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Enira", "Elira"},
[15] = {},
[16] = {"Rozkolora", "Flava", "Ruĝa", "Verda", "Blua", "Bluverda", "Hazarda koloro"},
[17] = {"Rigardi dekstren", "Rigardi maldekstren"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "Ĉ",

}

warpdirchangedtext = {

[0] = "Ĉambra ĉirkaŭfluo: Nenia",
[1] = "Ĉambra ĉirkaŭfluo: horizontala",
[2] = "Ĉambra ĉirkaŭfluo: vertikala",
[3] = "Ĉambra ĉirkaŭfluo: ĉiudirekta",

}

langtilesetnames = {

short0 = "Kosmostacio",
long0 = "Kosmostacio",
short1 = "Eksteraĵo",
long1 = "Eksteraĵo",
short2 = "Laboratorio",
long2 = "Laboratorio",
short3 = "Volviĝejo",
long3 = "Volviĝejo",
short4 = "Ŝipo",
long4 = "Ŝipo",
short5 = "Turo",
long5 = "Turo",

}

ERR_VEDHASCRASHED = "Ved paneis!"
ERR_VEDVERSION = "Versio de Ved:"
ERR_LOVEVERSION = "Versio de LÖVE:"
ERR_STATE = "Stato:"
ERR_OS = "Operaciumo:"
ERR_TIMESINCESTART = "Tempo ekde lanĉo:"
ERR_PLUGINS = "Aldonaĵoj:"
ERR_PLUGINSNOTLOADED = "(neŝargite)"
ERR_PLUGINSNONE = "(neniuj)"
ERR_PLEASETELLDAV = "Bonvolu raporti al Dav999 pri la problemo.\n\n\nDetaloj: (premu Reg+C/Cmd+C por kopii al la tondejo)\n\n"
ERR_INTERMEDIATE = " (intermeza versio)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (tro nova)"

ERR_PLUGINERROR = "Eraro de aldonaĵo!"
ERR_FILE = "Dosiero por redakti:"
ERR_FILEEDITORS = "Aldonaĵoj, kiuj redaktas tiun dosieron:"
ERR_CURRENTPLUGIN = "Aldonaĵo, kiu kaŭzis la eraron:"
ERR_PLEASETELLAUTHOR = "Aldonaĵo provis redakti iun kodon de Ved, sed tiu kodo ne troviĝis.\nEblas, ke tion kaŭzis konflikto inter du aldonaĵoj, aŭ ĝisdatigo de Ved rompis la aldonaĵon.\n\nDetaloj: (premu Reg+C/Cmd+C por kopii al la tondejo)\n\n"
ERR_CONTINUE = "Vi povas daŭrigi premante ESK aŭ ENTER, sed notu ke la malsukcesinta redakto eble kaŭzos erarojn."
ERR_OPENPLUGINSFOLDER = "Vi povas malfermi vian aldonaĵan dosierujon premante F, por ripari aŭ forigi la probleman aldonaĵon. Poste, relanĉu Ved."
ERR_REPLACECODE = "Malsukcesis trovi ĉi tiun en %s.lua:"
ERR_REPLACECODEPATTERN = "Malsukcesis trovi ĉi tiun en %s.lua (kiel modelon):"
ERR_LINESTOTAL = "%i linioj entute"

ERR_SAVELEVEL = "Por konservi kopion de via nivelo, premu S"
ERR_SAVESUCC = "Nivelo sukcese konserviĝis kiel %s!"
ERR_SAVEERROR = "Konservada eraro! %s"
ERR_LOGSAVED = "Pliaj informoj troviĝas en la panea protokolo:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Nivelaj atributoj",
		changedrooms = "Ŝanĝitaj ĉambroj",
		changedroommetadata = "Ŝanĝitaj ĉambraj metadatumoj",
		entities = "Entoj",
		scripts = "Skriptoj",
		flagnames = "Flagnomoj",
		levelnotes = "Nivelaj notoj",
	},
	levelpropertiesdiff = {
		Title = "Nomo estas ŝanĝita de \"$1\" al \"$2\"",
		Creator = "Aŭtoro estas ŝanĝita de \"$1\" al \"$2\"",
		website = "Retejo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc1 = "1-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc2 = "2-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc3 = "3-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		mapsize = "Mapgrando estas ŝanĝita de $1x$2 al $3x$4",
		mapsizenote = "NOTU: Mapgrando estas ŝanĝita de $1x$2 al $3x$4.\\o\nĈambroj ekstere de $5x$6 ne estas listigitaj.\\o",
		levmusic = "Nivela muziko estas ŝanĝita de $1 al $2",
	},
	rooms = {
		added1 = "Aldoniĝis ($1,$2) ($3)\\G",
		added2 = "Aldoniĝis ($1,$2) ($3 -> $4)\\G",
		changed1 = "Ŝanĝiĝis ($1,$2) ($3)\\Y",
		changed2 = "Ŝanĝiĝis ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Ĉiuj kaheloj viŝiĝis en ($1,$2) ($3)\\R",
		cleared2 = "Ĉiuj kaheloj viŝiĝis en ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Ĉambro $1,$2:",
		changed1 = "Ĉambro $1,$2 ($3):",
		roomname = "Ĉambronomo estas ŝanĝita de \"$1\" al \"$2\"\\Y",
		roomnameremoved = "Ĉambronomo \"$1\" estas viŝita\\R",
		roomnameadded = "Ĉambro estas nomita \"$1\"\\G",
		tileset = "Kahelaro $1 kaj kahelarkoloro $2 estas ŝanĝitaj al $3 kaj $4\\Y",
		platv = "Platformrapido estas ŝanĝita de $1 al $2\\Y",
		enemytype = "Malamika tipo estas ŝanĝita de $1 al $2\\Y",
		platbounds = "Platformlimo estas ŝanĝita de $1,$2,$3,$4 al $5,$6,$7,$8\\Y",
		enemybounds = "Malamika limo estas ŝanĝita de $1,$2,$3,$4 al $5,$6,$7,$8\\Y",
		directmode01 = "Rekta reĝimo estas ŝaltita\\G",
		directmode10 = "Rekta reĝimo estas malŝaltita\\R",
		warpdir = "Ĉirkaŭflua direkto estas ŝanĝita de $1 al $2\\Y",
	},
	entities = {
		added = "Aldoniĝis ento-tipo $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\G",
		removed = "Foriĝis ento-tipo $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\R",
		changed = "Ŝanĝiĝis ento-tipo $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\Y",
		changedtype = "Ŝanĝiĝis ento-tipo $1 al tipo $2 ĉe pozicio $3,$4 en ĉambro ($5,$6)\\Y",
		multiple1 = "Ŝanĝiĝis entoj ĉe pozicio $1,$2 en ĉambro ($3,$4):\\Y",
		multiple2 = "al:",
		addedmultiple = "Aldoniĝis entoj ĉe pozicio $1,$2 en ĉambro ($3,$4):\\G",
		removedmultiple = "Foriĝis entoj ĉe pozicio $1,$2 en ĉambro ($3,$4):\\R",
		entity = "Tipo $1",
		incomplete = "Ne ĉiuj entoj estas traktitaj! Bonvolu raporti tion al Dav.\\r",
	},
	scripts = {
		added = "Aldoniĝis skripto \"$1\"\\G",
		removed = "Foriĝis skripto \"$1\"\\R",
		edited = "Redaktiĝis skripto \"$1\"\\Y",
	},
	flagnames = {
		added = "Agordiĝis nomo por flago $1 al \"$2\"\\G",
		removed = "Foriĝis nomo \"$1\" por flago $2\\R",
		edited = "Ŝanĝiĝis nomo por flago $1 de \"$2\" al \"$3\"\\Y",
	},
	levelnotes = {
		added = "Aldoniĝis nivelo-noto \"$1\"\\G",
		removed = "Foriĝis nivelo-noto \"$1\"\\R",
		edited = "Redaktiĝis nivelo-noto \"$1\"\\Y",
	},
	mde = {
		added = "Aldoniĝis metadatuma ento.\\G",
		removed = "Foriĝis metadatuma ento.\\R",
	},
}

