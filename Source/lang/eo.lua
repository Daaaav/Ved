-- Language file for Ved
--- Language: eo (eo)
--- Last converted: 2024-03-19 00:41:39 (CET)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n ~= 1) end

function fontpng_ascii(c)
	if c == "Ĉ" then
		return "Cx"
	elseif c == "Ĝ" then
		return "Gx"
	elseif c == "Ĥ" then
		return "Hx"
	elseif c == "Ĵ" then
		return "Jx"
	elseif c == "Ŝ" then
		return "Sx"
	elseif c == "Ŭ" then
		return "Ux"
	elseif c == "ĉ" then
		return "cx"
	elseif c == "ĝ" then
		return "gx"
	elseif c == "ĥ" then
		return "hx"
	elseif c == "ĵ" then
		return "jx"
	elseif c == "ŝ" then
		return "sx"
	elseif c == "ŭ" then
		return "ux"
	end
end

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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "La nivelo-dosiero estas misformigita: ",
METADATACORRUPT = "Metadatumoj estas mankantaj aŭ difektitaj.",
METADATAITEMCORRUPT = "Metadatumoj por $1 estas mankantaj aŭ difektitaj.",
TILESCORRUPT = "Kaheloj mankas aŭ estas difektitaj.",
ENTITIESCORRUPT = "Entoj mankas aŭ estas difektitaj.",
LEVELMETADATACORRUPT = "Ĉambraj metadatumoj mankas aŭ estas difektitaj.",
SCRIPTCORRUPT = "Skriptoj mankas aŭ estas difektitaj.",

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
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
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

CONFIRMBIGGERSIZE = "Vi elektas $1 oble $2. Tio estas pli granda mapgrando ol $3 oble $4. Ekster la normala mapo $3 oble $4, ĉambroj kaj ĉambrotrajtoj ĉirkaŭfluas, sed estas distorditaj. Vi ne havos tute novajn ĉambrojn, nek pli da ĉambraj ecoj.\n\nPremu Jes se vi scias, kion vi faras, kaj volas tiun ĉi pli grandan mapograndon. Premu Ne por agordi la grandon al $5 oble $6.\n\nSe vi ne certas, premu Ne.",
MAPBIGGERTHANSIZELIMIT = "Mapogrando $1 oble $2 estas pli granda ol $3 oble $4! (Subteno por pli ol $3 oble $4 ne estas ebligita)",
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
	LITERALNULLS = {
		[0] = "Estas $1 nula bajto!",
		[1] = "Estas $1 nulaj bajtoj!",
	},
	XMLNULLS = {
		[0] = "Estas $1 nula signo de XML!",
		[1] = "Estas $1 nulaj signoj de XML!",
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
subj = "Kiel komenci",
imgs = {},
cont = [[
Kiel komenci\wh#
\C=

Tiu ĉi artikolo helpos vin komenci uzi Ved. Por komenci uzi la redaktilon, vi
devas ŝargi nivelon, aŭ krei novan nivelon.


La redaktilo\h#

Ĉe la maldekstra flanko, vi trovos la ilaron. La plimulto da iloj havas ilidojn
kiuj estas listigitaj dekstre. Por ŝanĝi la uzatan ilon, uzu la taŭgan klavaro-
komandon aŭ rulumu detenante la ŝov- aŭ reg-klavon. Por interŝanĝi ilidojn, vi
povas rulumi ie ajn. Por pli da informoj pri la iloj, legu la helpopaĝon ¤Iloj.\nwl
Vi povas dekstre alklaki entojn por menuo de agoj por tiu ento. Por forigi entojn
sen uzi la kuntekstan menuon, dekstre alklaku ilin detenante la ŝov-klavon.
Ĉe la dekstra flanko de la ekrano, vi trovos multajn butonojn kaj agordojn. La
supraj butonoj rilatas al la tuta nivelo, kaj la malsupraj (sub Ĉambraj agordoj)
estas specifaj pri la aktuala ĉambro. Por pli da informoj pri tiuj butonoj, legu
la respektivajn helpopaĝojn, kie haveblas.

Dosierujo de niveloj\h#

Ved normale uzos la saman dosierujon por konservi nivelojn kiel VVVVVV, por
faciligi interuzadon de la niveloredaktilo de VVVVVV kaj Ved. Se Ved ne ĝuste
detektas vian VVVVVV-dosierujon, vi povas enigi propran dosierindikon
en la agordoj de Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Reĝimoj de kahel-metado",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Reĝimoj de kahel-metado\wh#
\C=

Ved subtenas tri malsamajn reĝimojn por meti kahelojn.

     Aŭtomata reĝimo\h#0

          Tiu ĉi estas la plej facile uzebla reĝimo. En tiu ĉi reĝimo, vi povas
          meti murojn kaj fonojn, kaj la randoj aŭtomate ĝuste metiĝos. Tamen,
          redaktante en tiu ĉi reĝimo, ĉiuj muroj kaj fonoj en la ĉambro devas
          uzi la saman kahelaron kaj koloron.

     Multkahelara reĝimo\h#1

          Tiu ĉi similas al la aŭtomata, krom tio, ke vi povas havi multajn
          malsamajn kahelarojn en la sama ĉambro. Tio estas, ke ŝanĝi la kahelaron
          ne influos jame metitajn murojn kaj fonojn, kaj vi povas desegni per
          multaj kahelaroj en la sama ĉambro.

     Permana reĝimo\h#2

          Alinome rekta reĝimo - en tiu ĉi reĝimo vi povas meti ian ajn
          kahelon permane. Tiel vi ne devas uzi nur antaŭdifinitajn kombinojn
          de kahelaroj, kaj randoj ne aŭtomate aldoniĝos al muroj, kio donas
          tutan regon je la aspekto de la ĉambro. Tamen, ofte estas pli malrapide
          uzi tiun ĉi reĝimon.
]]
},

{
splitid = "030_Tools",
subj = "Iloj",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Iloj\wh#
\C=

Vi povas uzi la sekvajn ilojn por plenigi ĉambrojn en via nivelo:

\0
   Muro\h#


Uzu ĉi tiun ilon por meti murojn.

\1
   Fono\h#


Uzu ĉi tiun ilon por meti fonojn.

\2
   Pikaĵo\h#


Uzu ĉi tiun ilon por meti pikaĵojn. Vi povas uzi la etendan ilidon por
meti pikaĵojn sur surfacon per unu klako (aŭ deŝovo).

\3
   Kolektaĵo\h#


Uzu ĉi tiun ilon por meti kolektaĵojn. Bonvole notu, ke estas limo
de dudek kolektaĵoj en nivelo.

\4
   Konservejo\h#


Uzu ĉi tiun ilon por meti konservejojn.

\5
   Malaperanta platformo\h#


Uzu ĉi tiun ilon por meti malaperantajn platformojn.

\6
   Transportbendo\h#


Uzu ĉi tiun ilon por meti transportbendojn.

\7
   Moviĝanta platformo\h#


Uzu ĉi tiun ilon por meti moviĝantajn platformojn.

\8
   Malamiko\h#


Uzu ĉi tiun ilon por meti malamikojn. La formo kaj koloro de la malamiko
estas determinitaj de la agordo de la malamika tipo, kaj la (koloro de la)
kahelaro, respektive.

\9
   Gravita linio\h#


Uzu ĉi tiun ilon por meti gravitajn liniojn.

\^0
   Ĉambroteksto\h#


Uzu ĉi tiun ilon por meti ĉambrotekston.

\^1
   Terminalo\h#


Uzu ĉi tiun ilon por meti terminalojn. Unue metu ĝin, kaj tiam
tajpu nomon por la skripto. Por pli da informoj pri skriptado, bonvolu legi
la helpopaĝojn pri skriptado.

\^2
   Skriptkvadrato\h#


Uzu ĉi tiun ilon por meti skriptkvadratojn. Unue alklaku la supran
maldekstran angulon, kaj tiam la malsupran dekstran, kaj tiam tajpu nomon por la
skripto. Por pli da informoj pri skriptado, bonvolu legi la helpopaĝojn de
skriptado.

\^3
   Teleportĵetono\h#


Uzu ĉi tiun ilon por meti teleportĵetonojn. Unue alklaku la lokon por la
enirejo, kaj tiam alklaku la lokon por la elirejo.

\^4
   Teleportlinio\h#


Uzu ĉi tiun ilon por meti teleportliniojn. Bonvole notu, ke ili estas
meteblaj nur ĉe la randoj de ĉambro.

\^5
   Skipano\h#


Uzu ĉi tiun ilon por meti saveblajn skipanojn. Se ĉiuj skipanoj estas savitaj,
la nivelo finiĝos. Bonvolu noti, ke estas limo de dudek skipanoj en nivelo.

\^6
   Komencejo\h#


Uzu ĉi tiun ilon por meti la komencejon.
]]
},
{
splitid = "040_Script_editor",
subj = "Skripto-redaktilo",
imgs = {},
cont = [[
Skripto-redaktilo\wh#
\C=

Per la skripto-redaktilo, vi povas administri kaj redakti skriptojn en via
nivelo.


Flagnomoj\h#

Por oportuneco kaj legebleco de skriptoj, eblas uzi flagnomojn anstataŭ uzi
numerojn. Kiam vi uzas nomon anstataŭ numero, numero aŭtomate asociiĝos kun
tiu nomo, en la fono. Ankaŭ eblas elekti la specifajn flagnumerojn por nomoj.

Reĝimo de interna skriptado\h#

Por uzi internan skriptadon en Ved, vi povas ebligi ties reĝimon en la
redaktilo, por trakti ĉiujn komandojn en tiu skripto kiel internan skriptaĵon.
Vidu ¤Reĝimo Int.skr¤ por pli da informoj pri la reĝimo de interna skriptado.\nwl
Por pli da informoj pri interna skriptado, legu la helpopaĝojn de interna
skriptado.

Fendado de skriptoj\h#

Eblas fendi skripton en du per la skripto-redaktilo. Post meti la tekst-
kursoron sur la unuan linion, kiu estu en la nova skripto, alklaku la
butonon Fendi kaj enigu la nomon de la nova skripto. La linioj antaŭ la kursoro
restos en la originala skripto, kaj la linioj de la kursoro pluen moviĝos al la
nova.

Saltado al skriptoj\h#

Sur linioj kun komando iftrinkets, ifflag, customiftrinkets aŭ customifflag,
eblas salti al specifita skripto alklakante la butonon "Salti al" kiam la
kursoro estas sur tiu linio. Ankaŭ eblas premi ¤Alt+dekstra sago¤ por fari tiel,\nw
kaj vi povas uzi ¤Alt+maldekstra sago¤ por retrosalti unu paŝon tra la ĉeno, de\nw
kie vi venis.
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Reĝimo Int.skr",
imgs = {},
cont = [[
Reĝimo de interna skriptado\wh#
\C=

Por uzi internan skriptadon en Ved, vi povas ebligi ties reĝimon en la
redaktilo por trakti ĉiujn komandojn en tiu skripto kiel internan skriptaĵon.
Per tiu ĉi funkcio, estas pli facile funkciigi internan skriptadon; vi
ne devas uzi komandojn ¤say¤, kalkuli liniojn aŭ tajpi ¤text(1,0,0,4)¤ aŭ kion\nwnw
ajn estas via prefero - simple skribu internajn skriptojn, kvazaŭ ili estas
destinitaj por la ĉefa ludo. Vi eĉ ne bezonas fini la skripton per komando
loadscript¤.\wn

Ved subtenas diversajn metodojn de interna skriptado. Por montri iliajn
malsamecojn teknikajn, ni uzos la sekvan ekzemplan skripton:

  cutscene()\G
  untilbars()\G
  squeak(player)\G
  text(cyan,0,0,1)\G
  ...\G
  position(player,above)\G
  speak_active\G
  endtext\G
  endcutscene()\G
  untilbars()\G

Linioj de tiu interna skripto estas ¤helverdaj¤, kaj linioj kiuj estas aldonitaj\nG
aŭtomate kaj estas necesaj por la skriptad-ekspluato estos ¤grizaj¤. Notu, ke tio\ng
ĉi estas iome simpligita; Ved aldonas ¤#v¤ ĉe la fino de la grizaj linioj en la\nw
ekzemploj por certigi ke permane skribitaj skriptoj ne ŝanĝiĝos, kaj blokoj
de ¤say¤, kiuj estas tro grandaj devas esti enpecigitaj en pli malgrandajn.\nw

Por pli da informoj pri interna skriptado, kontrolu la helpopaĝon de
interna skriptado.

Int.sk de ŝargskripto\h#

La metodo loadscript estas probable la plej komune uzata metodo hodiaŭ. Ĝi estas
la metodo, kiun subtenis Ved ekde alfa-versio.

Por ĝi necesas plua skripto, la ŝargskripto, por ŝargi la internan skripton.
La ŝargskripto, en ĝia plej baza formo, enhavus komandon kiel
iftrinkets(0,viaskripto)¤, sed vi povas ankaŭ havi aliajn simpligitajn komandojn\w
en ĝi, kaj ankaŭ vi povas uzi ¤ifflag¤ anstataŭ ¤iftrinkets¤. Kio gravas estas\nwnw
ke via interna skripto estas ŝargita de alia skripto por ke ĝi funkciu.

La interna skripto estus konvertita pli-malpli ĉi tiel:

  squeak(off)\g
  say(11)\g
  cutscene()\G
  untilbars()\G
  squeak(player)\G
  text(cyan,0,0,1)\G
  ...\G
  position(player,above)\G
  speak_active\G
  endtext\G
  endcutscene()\G
  untilbars()\G
  loadscript(stop)\g
  text(1,0,0,3)\g

text(1,0,0,3)¤ devas esti la lasta linio, aŭ en la skriptredaktilo de VVVVVV,\w
devas esti ekzakte unu blanka linio post ĝi.

Ankaŭ eblas ne uzi ¤squeak(off)¤, kaj uzi ¤text(1,0,0,4)¤ anstataŭ\nwnw
text(1,0,0,3)¤. Uzi ¤squeak(off)¤, tamen, konservas karajn liniojn en pli longaj\wnw
skriptoj.

Int.sk de say(-1)\h#

La metodo say(-1) estas pli malnova, kaj havas malavantaĝon kompare al la
metodo de ŝargskripto: ĝi ĉiam aperigas barojn de interscenoj. Sed ankaŭ ĝi
havas avantaĝon kiu povas esti grava en niveloj kun multaj skriptoj: ĝi ne
bezonas ŝargskripton. Ni povas forigi ¤cutscene()¤ kaj ¤untilbars()¤ el nia\nwnw
skripto, pro ke tiuj jam aldoniĝos de VVVVVV uzante tiun ĉi metodon.

  squeak(off)\g
  say(-1)\g
  text(1,0,0,3)\g
  say(9)\g
  squeak(player)\G
  text(cyan,0,0,1)\G
  ...\G
  position(player,above)\G
  speak_active\G
  endtext\G
  endcutscene()\G
  untilbars()\G
  loadscript(stop)\g

Tiu ĉi metodo estas aldonita kiel aldona reĝimo de interna skriptado en Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Fulmoklavoj",
imgs = {},
cont = [[
Fulmoklavoj de la redaktilo\wh#
\C=

Konsilo: vi povas deteni ¤F9¤ ie ajn en Ved por vidi multajn el la fulmoklavoj.\nC

La plimulto da fulmoklavoj uzeblaj en VVVVVV ankaŭ uzeblas en Ved.

F1¤  Ŝanĝi kahelaron\C
F2¤  Ŝanĝi koloron\C
F3¤  Ŝanĝi malamikojn\C
F4¤  Limoj de malamikoj\C
F5¤  Limoj de platformoj\C

F10¤  Permana/aŭtomata reĝimo (rekta/nerekta reĝimo)\C

W¤  Ŝanĝi ĉirkaŭfluan direkton\C
E¤  Ŝanĝi ĉambronomon\C

L¤  Ŝargi nivelon\C
S¤  Konservi nivelon\C

Z¤  Peniko 3x3 (muroj kaj fonoj)\C
X¤  Peniko 5x5 (")\C

< ¤kaj¤ >¤  ŝanĝi ilon\CnC
Reg/Cmd+< ¤kaj¤ Reg/Cmd+>¤  ŝanĝi ilidon\CnC

Pliaj fulmoklavoj\h#

Ved ankaŭ havas kelkajn novajn fulmoklavojn.

Ĉefa redaktilo\gh#

Reg+P¤  Salti al la ĉambro enhavanta la komencejon\C
Reg+S¤  Rapidkonservo\C
Reg+X¤  Tondi ĉambron al tondejo\C
Reg+C¤  Kopii ĉambron al tondejo\C
Reg+V¤  Alglui ĉambron el tondejo (se eble)\C
Reg+D¤  Kompari tiun ĉi nivelon al alia\C
Reg+Z¤  Malfari\C
Reg+Y¤  Refari\C
Reg+F¤  Serĉi\C
Reg+/¤  Nivela notbloko\C
Reg+F1¤  Helpo\C
(NOTU: En macOS, anstataŭigu Reg per Cmd)\C
N¤  montri ĉiujn kahelnumerojn\C
J¤  montri masivecon de kaheloj\C
;¤  montri kahelojn de mapeto\C
Ŝov+;¤  montri fonon\C
M¤ aŭ ¤Nombroklavara 5¤  Montri mapon\CnC
G¤  Salti al ĉambro (enigi koordinatojn kiel kvar ciferojn)\C
/¤  Skriptoj\C
[¤  Horizontale ŝlosi muson dum detenado (por facile fari rektajn strekojn)\C
]¤  Vertikale ŝlosi muson dum detenado\C
F11¤  reŝargi grafikajn dosierojn de VVVVVV\C

Entoj\gh#

Ŝov+dekstra klako¤  Forigi enton\C
Alt+klako¤          Movi enton\C
Alt+Ŝov+klako¤    Kopii enton\C

Skripto-redaktilo\gh#

Reg+F¤  Trovi\C
Reg+G¤  Salti al linio\C
Reg+I¤  Baskuligi reĝimon de interna skriptado\C
Alt+dekstra sago¤  Salti al skripto en kondiĉa komando\C
Alt+maldesktra sago¤  Retrosalti unu paŝon\C

Skriptlisto\gh#

N¤  Krei novan skripton\C
F¤  Iri al flaglisto\C
/¤  Iri al plej supra/lastatempa skripto\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Simpla skriptado",
imgs = {},
cont = [[
Manlibreto de simpla skriptado\wh#
\C=

La simpligita skriptlingvo de VVVVVV estas simpla lingvo uzebla por skripti nivelojn
de VVVVVV.
Notu: se io estas inter citiloj, ne tajpu la citilojn.


say¤([linioj[,koloro]] .. "]]" .. [[)\h#w

Montras dialog-skatolon. Sen argumentoj, tio ĉi faros dialog-skatolon kun unu
linio, kaj defaŭlte tio rezultos en centrigita terminala dialog-skatolo. La
argumento de koloro povas esti koloro, aŭ nomo de skipano.
Se vi uzas koloron kaj savebla skipano de tiu koloro estas en la ĉambro, la
dialog-skatolo montriĝos do super tiu skipano.

reply¤([linioj])\h#w

Montras dialog-skatolon de Viridiano. Sen la linioj-argumento, tio ĉi faros
dialog-skatolon kun unu linio.

delay¤(n)\h#w

Prokrastas pluan agadon ĝis n kadroj. 30 kadroj estas proksimume unu sekundo.

happy¤([skipano])\h#w

Feliĉigas skipanon. Sen argumento, tio ĉi feliĉigos Viridianon. Vi ankaŭ povas
uzi "all", "everyone" aŭ "everybody" kiel argumenton por feliĉigi ĉiujn.

sad¤([skipano])\h#w

Malfeliĉigas skipanon. Sen argumento, tio ĉi malfeliĉigos Viridianon. Vi ankaŭ
povas uzi "all", "everyone" aŭ "everybody" kiel argumenton por malfeliĉigi ĉiujn.

Note: this command can also be written as ¤cry¤ instead of ¤sad¤.\nwnw

flag¤(flago,on/off)\h#w

Ŝaltas aŭ malŝaltas la specifitan flagon. Ekzemple, flag(4,on) ŝaltos la flagon de
numero 4. Estas 100 flagoj, numeritaj de 0 ĝis 99. Defaŭlte, ĉiuj flagoj estas
malŝaltitaj kiam vi komencas ludi nivelon.
Notu: En Ved, vi povas ankaŭ uzi flagnomojn anstataŭe de la numeroj.

ifflag¤(flago,skriptnomo)\h#w

Se la specifita flago estas ŜALTA, saltu al la skripto kun la nomo skriptnomo.
Se ĝi estas MALŜALTA, daŭru en la nuntempa skripto.
Ekzemplo:
ifflag(20,cutscene) - Se flago 20 estas ŜALTA, saltu al skripto "cutscene",
                      alie daŭru en la nuntempa skripto.
Notu: En Ved, vi povas ankaŭ uzi flagnomojn anstataŭe de la numeroj.

iftrinkets¤(nombro,skriptnomo)\h#w

Se via kvanto da kolektaĵoj >= nombro, saltu al la skripto kun la nomo
skriptnomo. Se ĝi estas < nombro, daŭru en la nuntempa skripto.
Ekzemplo:
iftrinkets(3,enoughtrinkets) - Se vi havas 3 aŭ pli da kolektaĵoj, la skripto
"enoughtrinkets" ruliĝos, alie la nuntempa skripto daŭros.
En praktiko, estas kutime uzi 0 por la nombro se vi volas ŝargi skripton en ĉiu
okazo.

iftrinketsless¤(nombro,skriptnomo)\h#w

Se via kvanto da kolektaĵoj < nombro, saltu al la skripto kun la nomo
skriptnomo. Se ĝi estas >= nombro, daŭru en la nuntempa skripto.

destroy¤(forigotaĵo)\h#w

Remove all objects of the given type, until you re-enter the room.

Valid arguments can be:
warptokens - Warp tokens
gravitylines - Gravity lines
platforms - Doesn't work properly
moving - Moving platforms (added in 2.4)
disappear - Disappearing platforms (added in 2.4)

music¤(numero)\h#w

Ŝanĝas la muzikon al iu numero de muzikaĵo.
Por la listo de muzikaĵaj numeroj, legu la artikolon "Manlibreto de listoj".

playremix\h#w

Ludas la remiksaĵon de Predestined Fate kiel muzikon.

flash\h#w

Blankigas kaj skuas la ekranon dum momento, ludante ekbruan sonon.

map¤(on/off)\h#w

Ŝaltas aŭ malŝaltas la mapon. Se vi malŝaltas ĝin, ĝi montros "SENSIGNALE" ĝis
kiam vi reŝaltas ĝin. Ĉambroj ankoraŭ malkovriĝos dum la mapo estas malŝaltita
por esti videblaj kiam ĝi estas reŝaltita.

squeak(skipano/on/off)\h#w

Pepigas skipanon, aŭ (mal)ŝaltas la pep-sonon de kiam dialog-skatolo montriĝas.

speaker¤(koloro)\h#w

Ŝanĝas la koloron kaj pozicion de la sekvantaj dialog-skatoloj kreitaj per la
komando "say". Tio ĉi uzeblas anstataŭ doni duan argumenton al "say".

warpdir¤(x,y,dir)\w#h

Ŝanĝas la ĉirkaŭfluan direkton por ĉambro x,y, 1-indice, al la specifita direkto.
Tio estas kontrolebla per ifwarp, rezultante en relative potenca sistemo plua de
flagoj/variabloj.

x - Ĉambra x-koordinato, ekde 1
y - Ĉambra y-koordinato, ekde 1
dir - La ĉirkaŭflua direkto. Normale 0-3, sed ankaŭ ellimaj valutoj akceptiĝas

ifwarp¤(x,y,dir,skripto)\w#h

Se la warpdir por ĉambro x,y (1-indice) estas agordita al dir, iru al (simpligita)
skripto

x - Ĉambra x-koordinato, ekde 1
y - Ĉambra y-koordinato, ekde 1
dir - La ĉirkaŭflua direkto. Normale 0-3, sed ankaŭ ellimaj valutoj akceptiĝas

loadtext¤(language)\w#h

Load a translation for the level by language code. Use an empty value to use
VVVVVV's language again.

language - A language code, like fr or pt_BR

iflang¤(language,script)\w#h

If VVVVVV's language is set to the given language, go to a script. This is not
affected by the language code you pass to loadtext(), only by what language the
user has selected in the menu.

setfont¤(font)\w#h

Change the font used for text in the level. This can be a font supplied with the
game, such as font_ja for Japanese, or a font supplied with the level. Leave blank
to revert to the default font for the level.

setrtl¤(on/off)\w#h

In custom levels, toggle whether or not the font is RTL (right-to-left) or not. By
default, the font is not RTL (it is LTR).

RTL mode mainly makes textboxes right-aligned, for languages like Arabic.

textcase¤(case)\w#h

If your level has translation files, and you have multiple text boxes with the
same text in a single script, this command can make them have unique translations.
Place it before a textbox.

case - A number between 1 and 255
]]
},

{
splitid = "080_Int_script_reference",
subj = "Interna skriptado",
imgs = {},
cont = [[
Manlibreto de interna skriptado\wh#
\C=

Interna skriptado provizas pli da potenco al skriptantoj, sed ankaŭ estas iom pli
kompleksa ol simpligita skriptado.

Por uzi internan skriptadon en Ved, vi povas ebligi la reĝimon de interna
skriptado en la redaktilo, por trakti ĉiujn komandojn en tiu skripto kiel
internan skriptadon.

Kolorkodoj:\w
Blanka - Devus esti sekure, en plej malbona okazo VVVVVV paneos pro eraro via.
Blua¤   - Kelkaj el ĉi tiuj ne funkcias en propraj niveloj, aliaj ne tre senc-\b
         havas en propraj niveloj, aŭ nur duone utilas ĉar ili vere estis
         destinitaj nur por la ĉefa ludo.
Oranĝ-¤ - Ĉi tiuj funkcias kaj nenio malbona okazos, krom se vi donas al ili iujn\o
kolora¤   specifajn argumentojn, kiuj forigos vian konservitajn datumojn.\o
Ruĝa¤   - Ruĝaj komandoj ne estu uzataj en propraj niveloj ĉar ili aŭ malŝlosos\r
         iujn partojn de la ĉefa ludo (funkcio nedezirinda por propra nivelo),
         aŭ difektos viajn konservitajn datumojn entute.


activateteleporter¤()\w#h

Activate the first teleporter in the room, which makes it flash random colors, and
animate erratically.

The teleporter's ¤tile¤ is set to 6, and the ¤color¤ is set to 102. This command makes\gn&Zgn&Zg
the teleporter do nothing when touched, as the teleporter's tile is set to\g
something which isn't ¤1§¤.\gn&Zg(

activeteleporter¤()\w#h

Makes the first teleporter in the room white, aka color ¤101¤.\nn&Z

This command does not change the tile, so it will not affect functionality.\g

alarmoff\w#h

Malŝaltas la sonorilon.

alarmon\w#h

Ŝaltas la sonorilon.

altstates¤(stato)\b#h

Ŝanĝas la aranĝon de iuj ĉambroj, ekzemple la kolektaĵan ĉambron en la ŝipo antaŭ
kaj post la eksplodo, kaj la enirejon al la sekreta laboratorio (propraj niveloj
tute ne subtenas ĉi tion).

In the code, this changes the global ¤altstates¤ variable.\gn&Zg

audiopause¤(on/off)\w#h

Devige (mal)ebligi paŭzigon de sonoj je elfokusiĝo, senrigarde al ties agordo
de la uzanto. La defaŭlto estas off (malŝalta), t.e. paŭzigu sonon dum elfokusiĝa
paŭzo.

This command was added in 2.3.\g

backgroundtext\w#h

Makes the next shown textbox not wait for ACTION to be pressed before continuing
the script. The most common usage of this is to display multiple textboxes at
once.

befadein¤()\w#h

Instantly remove a fade, such as from ¤#fadeout()¤fadeout¤ or ¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z

blackon¤()\w#h

Resume rendering if it was paused by ¤#blackout()¤blackout¤.\nLwl&Z

blackout¤()\w#h

Pauses rendering.

To make the screen black, use ¤#shake(n)¤shake¤ at the same time.\gLwl&Zg

bluecontrol\b#h

Komencas konversacion kun Viktoria ĝuste kiel kiam vi renkontas ŝin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

changeai¤(skipano,ai1,ai2)\w#h

Povas ŝanĝi la frontan direkton de skipano aŭ la marŝan agmanieron

skipano - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceleft/faceright/followposition,ai2
ai2 - deviga se followposition estas uzata por ai1

faceplayer¤ is missing, use 18 instead. ¤panic¤ also does not work, requiring ¤20¤.\n&Zgn&Zgn&Zg

changecolour¤(a,b)\w#h

Changes the color of a crewmate. This command can be used with Arbitrary Entity
Manipulation.

a - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
b - Color name to change to. Since 2.4, you can also use a color ID

changecustommood¤(koloro,humoro)\w#h

Changes the mood of a rescuable crewmate.

color - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
mood - 0 for happy, 1 for sad

changedir¤(koloro,direkto)\w#h

Ĝuste kiel ¤#changeai(skipano,ai1,ai2)¤changeai¤, tio ĉi ŝanĝas frontan direkton.\nLwl&Z

koloro - cyan/player/blue/red/yellow/green/purple
direkto - 0 estas maldekstren, 1 estas dekstren

changegravity¤(skipano)\w#h

Pliigi la grafikan numeron de la specifita skipano per 12.

skipano - Koloro de la ŝanĝenda skipano cyan/player/blue/red/yellow/green/purple

changemood¤(koloro,humoro)\w#h

Changes the mood of the player or a cutscene crewmate.

koloro - cyan/player/blue/red/yellow/green/purple
humoro - 0 por feliĉa, 1 por malfeliĉa

Cutscene crewmates are crewmates created with ¤#createcrewman(x,y,color,mood,ai1,ai2)¤createcrewman¤.\gLwl&Zg

changeplayercolour¤(koloro)\w#h

Ŝanĝas la koloron de la ludanto.

koloro - cyan/player/blue/red/yellow/green/purple/teleporter

changerespawncolour¤(koloro)\w#h

Ŝanĝas la koloron de la ludanto post ties morto kaj reestiĝo.

koloro - red/yellow/green/cyan/blue/purple/teleporter aŭ numero

This command was added in 2.4.\g

changetile¤(koloro,kahelo)\w#h

Ŝanĝas la kahelon de skipano (nur por skipanoj de createcrewman; vi povas uzi iun
ajn sprajton en sprites.png)

koloro - cyan/player/blue/red/yellow/green/purple/gray
kahelo - Kahela numero

clearteleportscript¤()\b#h

Viŝas la teleportilan skripton, kiu estas agordita per teleportscript(x)

companion¤(x)\b#h

Faras la specifitan skipanon akompananto.

x - 0 (neniu) aŭ 6/7/8/9/10/11

createactivityzone¤(koloro)\b#h

Kreas agadan zonon ĉe la specifita skipano (aŭ ĉe la ludanto, se la skipano
ne ekzistas) kiu diras "Premu AGBUTONON por paroli al (skipano)"

createcrewman¤(x,y,koloro,humoro,ai1,ai2)\w#h

Kreas skipanon (ne saveblan)

humoro - 0 por feliĉa, 1 por malfeliĉa
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - deviga se followposition estas uzata por ai1

createentity¤(x,y,e,meta,meta,p1,p2,p3,p4)\o#h

Creates the entity with the ID ¤e§¤, two ¤meta¤ values, and 4 ¤p§¤ values.\nn&Znn&Znn&Z(

e - The entity ID

A list of entity IDs and the ¤meta¤/§¤p§¤ values they use can be found ¤https://vsix.dev/wiki/Createentity_list¤here¤.\gn&Zgn&ZgLClg(

createlastrescued¤()\b#h

Kreas la laste savitan skipanon ĉe kodita pozicio ¤(200,153)¤. La laste savita\nn&Z
skipano baziĝas de la ludstato de nivela kompletiĝo.

createrescuedcrew¤()\b#h

Kreas ĉiujn savitajn skipanojn

customifflag¤(n,skripto)\w#h

Same kiel ¤ifflag(n,skripto)¤ en simpligita skriptado\nn&Z

customiftrinkets¤(n,skripto)\w#h

Same kiel ¤iftrinkets(n,skripto)¤ en simpligita skriptado\nn&Z

customiftrinketsless¤(n,skripto)\w#h

Same kiel ¤iftrinketsless(n,skripto)¤ en simpligita skriptado\nn&Z

custommap¤(on/off)\w#h

Same kiel map() en simpligita skriptado

customposition¤(tipo,above/below)\w#h

Superskribas la x,y de la komando text kaj do agordas la pozicion de la dialog-
skatolo (por saveblaj skipanoj anstataŭ skipanoj de createcrewman).

tipo - center/centerx/centery, aŭ kolornomo
cyan/player/blue/red/yellow/green/purple (savebla)
above/below - Supere aŭ sube, nur uzata se tipo estas kolornomo

cutscene¤()\w#h

Aperigas striojn de intersceno

delay¤(frames)\w#h

Pauses the script for the specified number of frames. Controls are forced to be
unpressed during this pause.

destroy¤(objekto)\w#h

Forigas enton, same kiel la komando de simpligita skriptado.

objekto - gravitylines/warptokens/platforms/moving/disappear

moving¤ and ¤disappear¤ were added in 2.4.\n&Zgn&Zg

do¤(times)\w#h

Starts a loop block which will repeat a specified number of times. End the block
using ¤#loop¤loop¤.\nLwl&Z

times - The amount of times the block will loop.

endcutscene¤()\w#h

Malaperigas la striojn de intersceno.

endtext\w#h

Forigas (fordissolvigas) dialog-skatolon.

endtextfast\w#h

Tuje forigas dialog-skatolon (sen fordissolvo).

entersecretlab\r#h

Ŝaltas reĝimon de sekreta laboratorio.

2.2 KAJ SUBE: Vere malŝlosas la sekretan laboratorion por la ĉefa ludo - verŝajne
nevolata efiko por propra nivelo.

everybodysad¤()\w#h

Makes all crewmates sad.

Does not work on crewmates placed in the editor.\g

face¤(A,B)\w#h

Makes crewmate A look at crewmate B.

A - cyan/player/blue/red/yellow/green/purple/gray
B - cyan/player/blue/red/yellow/green/purple/gray

Does not work on crewmates placed in the editor.\g

fadein¤()\w#h

Fades back in from ¤#fadeout()¤fadeout¤.\nLwl&Z

fadeout¤()\w#h

Fades the screen to black. To undo, use ¤#fadein()¤fadein¤ or ¤#befadein()¤befadein¤.\nLwl&ZnLwl&Z

finalmode¤(x,y)\b#h

Teleportigas vin al ekstere de Dimensio VVVVVV, ¤(46,54)¤ estas la unua ĉambro\nn&Z
de la fina nivelo

flag¤(n,on/off)\w#h

Same kiel simpligita komando

flash¤(length)\w#h

Makes the screen white for ¤length¤ amount of frames.\nn&Z

length - The amount of frames. 30 frames is almost one second.

This is different from the simplified command, which actually calls ¤flash(5)¤,\gn&Zg
playef(9)¤ and ¤shake(20)¤ at the same time. See: ¤#playef(sound)¤playef¤ and ¤#shake(n)¤shake¤.\n&Zgn&ZgLwl&ZgLwl&Zg

flip\w#h

Make the player flip by pressing ACTION.

If the player is not on the ground, this will not work, since it's simulating an\g
ACTION press. Likewise, this command right after a textbox will not function for\g
the same reason as two consecutive ACTION presses in a row is treated as holding\g
the button down, which does not flip the player.\g

flipgravity¤(koloro)\w#h

Flips the gravity of a certain crewmate, or the player.

koloro - cyan/player/blue/red/yellow/green/purple

Before 2.3, this wouldn't unflip crewmates, or affect the player.\g

flipme\w#h

Korekti vertikalan poziciigadon de multaj dialog-skatoloj en renversita
reĝimo

foundlab\b#h

Ludas sonon 3, montras dialog-skatolon kun "Gratulon! Vi trovis la
sekretan labon!" Ne uzas endtext, ankaŭ ne havas pluajn nevolatajn efikojn.

foundlab2\b#h

Montras la duan dialog-skatolon, kiun vi vidas post malkovri la sekretan
laboratorion. Ankaŭ ne uzas endtext, kaj ankaŭ ne havas pluajn nevolatajn efikojn.

foundtrinket¤(x)\w#h

Faras kolektaĵon trovita

x - Numero de la kolektaĵo

gamemode¤(x)\b#h

teleporter por montri la mapon, game por kaŝi ĝin (montras teleportilojn de la
ĉefa ludo)

x - teleporter/game

gamestate¤(state)\o#h

Change the current gamestate to the specified state number.

state - The gamestate to jump to

A full list of gamestates is ¤https://vsix.dev/wiki/List_of_gamestates¤here¤.\gLClg

gotoposition¤(x,y,gravity)\w#h

Change Viridian's position to ¤(x,y)¤ in this room, and change their gravity as\nn&Z
well.

gravity - 1 for flipped, 0 for not flipped. Any other values result in glitchy
player gravity.

gotoroom¤(x,y)\w#h

Ŝanĝi la nuntempan ĉambron al ¤(x,y)¤.\nn&Z

x - x coordinate
y - y coordinate

These room coordinates are 0-indexed.\g

greencontrol\b#h

Komencas konversacion kun Verdigriso ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

hascontrol¤()\w#h

Makes the player have control. Note that you can't use this to regain control
while in the middle of a ¤#delay(frames)¤delay¤.\nLwl&Z

hidecoordinates¤(x,y)\w#h

Set the room at the given coordinates to unexplored

hideplayer¤()\w#h

Malvidebligas la ludanton

hidesecretlab\w#h

Kaŝas la sekretan laboratorion sur la mapo

hideship\w#h

Kaŝas la ŝipon sur la mapo

hidetargets¤()\b#h

Kaŝas la celojn sur la mapo

hideteleporters¤()\b#h

Kaŝas la teleportilojn sur la mapo

hidetrinkets¤()\b#h

Kaŝas la kolektaĵojn sur la mapo

ifcrewlost¤(skipano,skripto)\b#h

Se skipano estas mankanta, saltas al skripto

ifexplored¤(x,y,skripto)\w#h

Se ¤(x,y)¤ estas esplorita, saltas al interna skripto.\nn&Z

These room coordinates are 0-indexed.\g

ifflag¤(n,skripto)\b#h

Same kiel customifflag, sed ŝargas internan skripton (de la ĉefa ludo)

iflang¤(language,script)\w#h

Check if the current language of the game is a certain language, and if so, jump
to the given custom script. ¤#loadtext(language)¤loadtext¤ has no influence on this command; only what\nLwl&Z
language the user has selected in the menu.

language - The language to check, usually a two-letter code, such as ¤en¤ for\nn&Z
English
script - The custom script to jump to, if the check succeeds

This command was added in 2.4.\g

iflast¤(skipano,skripto)\b#h

Se skipano x estas savita laste, saltas al skripto

skipano - Numeroj uziĝas ĉi tie: 0: Viridiano, 1: Violeto, 2: Vitelario, 3:
Vermiljo, 4: Verdigriso, 5: Viktoria

ifskip¤(x)\b#h

Se interscenoj estas preterpasataj en mortula reĝimo, saltas al skripto x

iftrinkets¤(n,skripto)\b#h

Same kiel simpligita skriptado, sed ŝargas internan skripton (de la ĉefa ludo)

iftrinketsless¤(n,skripto)\b#h

Kontrolas ĉu la specifita nombo estas malpli ol kvanto, kiu rilatas al kolektaĵoj.
Tamen, ĝi kontrolas kontraŭ la pleja kvanto da kolektaĵoj, kiun vi iam ajn akiris
dum individua ludado de la ĉefa ludo, kaj NE kontraŭ via aktuala fakta kvanto.
Ŝargas internan (ĉefludan) skripton.

ifwarp¤(x,y,dir,skripto)\w#h

Se la warpdir por ĉambro ¤(x,y)¤ (1-indice) estas agordita al dir, iras al\nn&Z
(simpligita) skripto

x - Ĉambra x-koordinato, ekde 1
y - Ĉambra y-koordinato, ekde 1
dir - La ĉirkaŭflua direkto. Normale 0-3, sed ankaŭ ellimaj valutoj akceptiĝas

jukebox¤(n)\w#h

Blankigas muzikan terminalon kaj malkolorigas ĉiujn aliajn terminalojn.
Se n estas specifita, muzikila agado-zono estiĝos ĉe kodita pozicio, kaj
se terminalo estas ĉe la sama kodita pozicio, ĝi eklumos.
La eblaj valutoj de n kaj la koditaj pozicioj jenas:
1: (88, 80), 2: (128, 80), 3: (176, 80), 4: (216, 80), 5: (88, 128), 6: (176,
128), 7: (40, 40), 8: (216, 128), 9: (128, 128), 10: (264, 40)

leavesecretlab¤()\b#h

Malŝalti "reĝimon de sekreta labo"

loadscript¤(skripto)\b#h

Ŝargi internan skripton (de la ĉefa ludo). Komune uzata en propraj niveloj kiel
loadscript(stop)

loadtext¤(language)\w#h

In custom levels, load the translation for the given language.

language - The language to load, usually a two-letter code, such as ¤en¤ for\nn&Z
English. Pass an empty language code to revert to the default behavior of simply
using VVVVVV's language.

This command was added in 2.4.\g

loop\w#h

Put this at the end of a loop block started with the ¤#do(times)¤do¤ command.\nLwl&Z

missing¤(koloro)\b#h

Faras iun mankanta

moveplayer¤(x,y)\w#h

Moves the player by x pixels to the right and y pixels down. Negative numbers are
accepted as well.

musicfadein¤()\w#h

Fades the music in.

Before 2.3, this command did nothing.\g

musicfadeout¤()\w#h

Dissolvigas la muzikon.

nocontrol¤()\w#h

Faras game.hascontrol falsa, forprenante regon de la ludanto.
game.hascontrol estas aŭtomate agordita dum "- Premu AGBUTONON por daŭrigi -" kaj
fermado de tekstoskatoloj, do tio ĉi estas malfarita post tiuj invitoj

play¤(n)\w#h

Ekludi muzikaĵon kun interna muzika numero.

n - Interna muzika numero

playef¤(sound)\w#h

Ludas sonon.

sound - Sound ID

In VVVVVV 1.x, there was a second argument which controlled the offset in\g
milliseconds at which the sound effect started. This was removed during the C++\g
port.\g

position¤(tipo,above/below)\w#h

Superskribas la x,y de la komando text kaj tiel agordas la pozicion de la
dialog-skatolo.

tipo - center/centerx/centery, aŭ kolornomo
cyan/player/blue/red/yellow/green/purple
above/below - Supere/sube, nur uzata se tipo estas kolornomo

purplecontrol\b#h

Komencas konversacion kun Violeto ĝuste kiel kiam vi renkontas ŝin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

redcontrol\b#h

Komencas konversacion kun Vermiljo ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

rescued¤(koloro)\b#h

Faras iun savita

resetgame\w#h

Restarigas ĉiujn kolektaĵojn, kolektitajn skipanojn kaj flagojn, kaj teleportas
la ludanton al la lasta konservejo.

restoreplayercolour¤()\w#h

Reŝanĝas la koloron de la ludanto al bluverda

resumemusic¤()\w#h

Resumes the music after ¤#musicfadeout()¤musicfadeout¤.\nLwl&Z

Before 2.3, this was unfinished and caused various glitches, including crashes.\g

rollcredits¤()\r#h

Montras la agnoskojn.

2.2 KAJ SUBE: Tio ĉi detruas viajn konservitajn datumojn
post la fino de la agnoskoj!

setactivitycolour¤(color)\w#h

Change the color of the next activity zone that gets spawned.

color - Any color that ¤#text(color,x,y,lines)¤text¤ takes\nLwl&Z

This command was added in 2.4.\g

setactivityposition¤(y)\w#h

Change the position of the next activity zone that gets spawned.

y - The y position

This command was added in 2.4.\g

setactivitytext\w#h

Change the text of the next activity zone that gets spawned. The line after this
command will be taken as the text (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This command was added in 2.4.\g

setcheckpoint¤()\w#h

Agordas la konservejon al via aktuala loko

setfont¤(font,all)\w#h

In custom levels, set the font to the given font.

font - The font to set the font to. If left blank, this will set the font to the
default font of the custom level.
all - If ¤all¤ is specified (literally the word ¤all¤), then this retroactively\nn&Znn&Z
affects all textboxes that are already on screen. Otherwise simply leave this out.

This command was added in 2.4. The ¤all¤ argument was added in 2.4.1.\gn&Zg

setroomname\w#h

Change the room name of the current room. The line after this command will be
taken as the name (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This name is not persistent and will go back to the default room name when the
room is reloaded (e.g. by leaving and coming back).

This name overrides any special changing room name, if the room has one. 

This command was added in 2.4.\g

setrtl¤(on/off)\w#h

In custom levels, toggle whether or not the font is RTL (right-to-left) or not. By
default, the font is not RTL (it is LTR).

RTL mode mainly makes textboxes right-aligned, for languages like Arabic.

This command was added in 2.4.\g

shake¤(n)\w#h

Skuas la ekranon dum n kadroj. Tio ĉi ne kreas prokraston.

showcoordinates¤(x,y)\w#h

Set the room at the given coordinates to explored

showplayer¤()\w#h

Videbligas la ludanton

showsecretlab\w#h

Montras la sekretan labon sur la mapo

showship\w#h

Montras la ŝipon sur la mapo

showtargets¤()\b#h

Montras la celojn sur la mapo (nekonataj teleportiloj, kiuj montriĝas
kiel demandosignoj)

showteleporters¤()\b#h

Show the teleporters in explored rooms on the map

showtrinkets¤()\w#h

Montras la kolektaĵojn sur la mapo

Since 2.3, this command was changed to work in custom levels.\g

speak\w#h

Montras dialog-skatolon sen forigi malnovajn. Ankaŭ paŭzigas la skripton ĝis kiam
vi premas AGBUTONON (krom se estas komando backgroundtext supere).

speak_active\w#h

Montras dialog-skatolon kaj forigas malnovajn. Ankaŭ paŭzigas la skripton ĝis kiam
vi premas AGBUTONON (krom se estas komando backgroundtext supere).

specialline¤(x)\b#h

Specialaj dialogoj, kiuj aperas en la ĉefa ludo

squeak¤(koloro)\w#h

Faras pepan sonon de skipano, aŭ sonon de terminalo.

koloro - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\b#h

Alterna ¤finalmode(46,54)¤, prenas vin al la fina nivelo ne akceptante argumentojn.\nn&Z

stopmusic¤()\w#h

Tuj haltigas la muzikon. Samas kiel ¤music(0)¤ en simpligita skriptado.\nn&Z

teleportscript¤(skripto)\b#h

Iam agordis skripton, kiu estas rulata je uzo de teleportilo

telesave¤()\r#h

Faras nenion en propraj niveloj.

2.2 KAJ SUBE: Konservas vian ludon per la teleportila konservaĵo de la ĉefa ludo,
do ne uzu ĝin!

text¤(koloro,x,y,linioj)\w#h

Konservi dialog-skatolon en memoro kun koloro, pozicio kaj nombro da linioj.
Kutime, la komando position estas uzita post la komando text (kaj ties tekst-
linioj), kio superskribos la koordinatojn ĉi tie donitajn, do ĉi tiuj kutime
estas lasitaj kiel 0.

koloro - cyan/player/blue/red/yellow/green/purple/gray/white/orange/transparent
x - La x-pozicio de la dialog-skatolo
y - La y-pozicio de la dialog-skatolo
linioj - La kvanto da linioj

The ¤transparent¤ color was added in 2.4, along with arbitrary colored textboxes.\gn&Zg
The coordinates can be -500 to center the textbox in the respective axis (if you\g
don't want to use ¤#position(type,above/below)¤position¤).\gLwl&Zg

textboxactive\w#h

Forigas ĉiujn dialog-skatolojn sur la ekrano krom la laste kreita

textboxtimer¤(frames)\w#h

Makes the next shown textbox disappear after a certain amount of frames, without
advancing the script.

frames - The amount of frames to wait before fading out

This command was added in 2.4.\g

textbuttons¤()\w#h

For the text box in memory, replace certain button placeholders by button labels
(such as keyboard keys or controller glyphs).

The replaced placeholders are:
- {b_act} - ACTION
- {b_int} - Interact
- {b_map} - Map
- {b_res} - Restart
- {b_esc} - Esc/Menu

This command was added in 2.4.\g

textcase¤(case)\w#h

If your level has translation files, and you have multiple text boxes with the
same text in a single script, this command can make them have unique translations.
Place it before a textbox.

case - The case number, between 1 and 255.

This command was added in 2.4.\g

textimage¤(image)\w#h

For the text box in memory, draw the given image. There can only be one image per
text box.

image - levelcomplete/gamecomplete, or an unknown value to remove the image

This command was added in 2.4.\g

textsprite¤(x,y,sprite,color)\w#h

For the text box in memory, draw the given sprite. There can be multiple sprites
per text box.

x - The x-coordinate of the sprite. This is relative to the text box.
y - The y-coordinate of the sprite. This is relative to the text box.
sprite - The sprite number of the sprite, from ¤sprites.png¤.\nn&Z
color - The color ID of the sprite.

This command was added in 2.4.\g

tofloor\w#h

Se la ludanto ne jam estas sur la planko, tio ĉi renversigas rin al ĝi.

trinketbluecontrol¤()\b#h

Dialogo de Viktoria, kiam ŝi donas al vi kolektaĵon en la ĉefa ludo

trinketscriptmusic\w#h

Ludas Passion for Exploring.

trinketyellowcontrol¤()\b#h

Dialogo de Vitelario, kiam li donas al vi kolektaĵon en la ĉefa ludo

undovvvvvvman¤()\w#h

Resets the player's hitbox to the normal size, sets their color to 0, and sets
their X position to 100.

untilbars¤()\w#h

Atendas, ĝis kiam ¤#cutscene()¤cutscene¤/§¤#endcutscene()¤endcutscene¤ finiĝas.\nLwl&ZnLwl&Z(

untilfade¤()\w#h

Atendas ĝis kiam ¤#fadeout()¤fadeout¤/§¤#fadein()¤fadein¤ finiĝas.\nLwl&ZnLwl&Z(

vvvvvvman¤()\w#h

Makes the player 6x larger, sets their position to ¤(30,46)¤ and sets their color to\nn&Z
23¤.\n&Z

walk¤(direkto,x)\w#h

Marŝigas la ludanton dum la specifita nombro da kadroj

direkto - left/right (maldekstren/dekstren)

warpdir¤(x,y,dir)\w#h

Ŝanĝas la ĉirkaŭfluan direkton por ĉambro x,y, 1-indice, al la specifita direkto.
Tio estas kontrolebla per ifwarp, rezultante en relative potenca aldona sistemo de
flagoj/variabloj.

x - Ĉambra x-koordinato, ekde 1
y - Ĉambra y-koordinato, ekde 1
dir - La ĉirkaŭflua direkto. Normale 0-3, sed ankaŭ ellimaj valutoj akceptiĝas

yellowcontrol\b#h

Komencas konversacion kun Vitelario ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.
]]
},

{
splitid = "090_Lists_reference",
subj = "Manlibreto de listoj",
imgs = {},
cont = [[
Manlibreto de listoj\wh#
\C=

Jen listoj de numeroj uzataj en VVVVVV, plejparte kopiitaj de forumaj afiŝoj.
Dankon al ĉiuj, kiuj faris ĉi tiujn listojn!


Tabelo\w&Z+
\&Z+
#Muzikaj numeroj (simpligita skriptado)\C&Z+l
#Muzikaj numeroj (internaj)\C&Z+l
#Sonaj numeroj\C&Z+l
#Entoj\C&Z+l
#Koloroj por skipanoj de createentity()\C&Z+l
#Moviĝaj tipoj de malamikoj\C&Z+l
#Ludstatoj\C&Z+l


Muzikaj numeroj (simpligita skriptado)\h#

0 - silento (neniu muziko)
1 - Pushing Onwards
2 - Positive Force
3 - Potential for Anything
4 - Passion for Exploring
5 - Presenting VVVVVV
6 - Predestined Fate
7 - Popular Potpourri
8 - Pipe Dream
9 - Pressure Cooker
10 - Paced Energy
11 - Piercing the Sky

Muzikaj numeroj (internaj)\h#

0 - Path Complete
1 - Pushing Onwards
2 - Positive Force
3 - Potential for Anything
4 - Passion for Exploring
5 - Pause
6 - Presenting VVVVVV
7 - Plenary
8 - Predestined Fate
9 - ecroF evitisoP
10 - Popular Potpourri
11 - Pipe Dream
12 - Pressure Cooker
13 - Paced Energy
14 - Piercing the Sky
15 - Predestined Fate (rearanĝo)

Sonaj numeroj\h#

0 - Renverso al plafono
1 - Renverso al planko
2 - Krio
3 - Kolektaĵo kolektita
4 - Monero kolektita
5 - Konservejo tuŝita
6 - Plirapida movsablo tuŝita
7 - Normala movsablo tuŝita
8 - Tuŝita gravita linio
9 - Ekbrilo
10 - Teleportado
11 - Pepo de Viridiano
12 - Pepo de Verdigriso
13 - Pepo de Viktoria
14 - Pepo de Vitelario
15 - Pepo de Violeto
16 - Pepo de Vermiljo
17 - Terminalo tuŝita
18 - Teleportilo tuŝita
19 - Sonorilo
20 - Pepo de terminalo
21 - Tempoprova ĝisnombrado "3, 2, 1"
22 - Tempoprova ĝisnombrado "EK!"
23 - Rompado de muroj kiel gigantulo
24 - Gigantula (mal)kombiniĝo
25 - Nova rekordo en Supergravitrono
26 - Nova trofeo en Supergravitrono
27 - Savita skipano (en propraj niveloj)

Entoj\h#

\wh#

Enhavo0 - La ludanto
1 - Malamiko
    Metadatumoj: moviĝa tipo, moviĝa rapido
    Pro manko de bezonataj datumoj, vi nur iam ajn ricevos purpuran malamikan
    skatolon, krom se vi estas en la polusa dimensio de VVVVVV farante tiun ĉi
    komandon.
2 - Moviĝanta platformo
    Metadatumoj: moviĝa tipo, moviĝa rapido
    Notu ke transportbendoj estas realigitaj kiel moviĝantaj platformoj,
    vidu moviĝajn tipojn 8 kaj 9
3 - Malaperanta platformo
4 - 1x1 plirapida movsabla kahelo
5 - Renversita Viridiano, vi renversiĝos se vi tuŝas ĝin
6 - Stranga ruĝa brilanta aferaĵo, kiu rapide malaperas
7 - Same kiel supre, sed ĝi estas bluverda kaj ne brilas
8 - Monero de la prototipo
    Metadatumo: Monera idento
9 - Kolektaĵo
    Metadatumo: Kolektaĵa idento
    Notu ke kolektaĵa idento ekas je 0, kaj ĉio super 19 ne konserviĝos se vi
    reŝargas la nivelon
10 - Konservejo
     Metadatumoj: Stato de konservejo (0=renversita, 1=normala)
                  Idento de konservejo (kontrolas, ĉu la konservejo aktivas aŭ ne)
11 - Horizontala gravita linio
     Metadatumo: Longo per bilderoj
12 - Vertikala gravita linio
     Metadatumo: Longo per bilderoj
13 - Teleportĵetonoo
     Metadatumoj: Celloko per kaheloj (X-akso), celloko per kaheloj (Y-akso)
14 - Teleportilo
     Metadatumo: Konserveja idento(?)
15 - Verdigriso
     Metadatumo: Stato de AI
16 - Vitelario (renversita)
     Metadatumo: Stato de AI
17 - Viktoria
     Metadatumo: Stato de AI
18 - Skipano
     Metadatumoj: Koloro (uzante krudan kolorliston, ne la skipanajn kolorojn),
     humoro
19 - Vermiljo
     Metadatumo: Stato de AI
20 - Terminalo
     Metadatumoj: Sprajto, skript-idento(?)
21 - Same kiel supre, sed je tuŝiĝo la terminalo ne eklumas
     Metadatumoj: Sprajto, skript-idento(?)
22 - Kolektita kolektaĵo
     Metadatumo: Idento de kolektaĵo
23 - Kvadrata malamiko de la Gravitrono
     Metadatumo: Direkto
     Se vi enigas minusan aŭ tro altan X-koordinaton, sago montriĝas, ĝuste kiel
     en la vera Gravitrono
24 - Skipano de Interakto 1
     Metadatumoj: Kruda koloro, humoro
     Ŝajne ne influata de obstakloj, kvankam ĝi devus influiĝi
25 - Trofeo
     Metadatumoj: Identilo de defio, sprajto
     Se la defio estas plenumita, la baza sprajtidento (kiun vi ekhavas se vi uzas
     sprajto=0) ŝanĝiĝos. Nur uzu 0 aŭ 1 se vi volas predikteblajn rezultojn.
26 - La teleportĵetonego al la sekreta laboratorio
     Notu bone ke tio ĉi estas nur bela sprajto, kaj ke vi mem devos
     skriptigi ĝian funkciadon.
55 - Savebla skipano
     Metadatumo: Koloro de la skipano. Koloroj super 6 ĉiam montros *feliĉan*
     Viridianon
56 - Malamiko de propra niveloj
     Metadatumoj: Moviĝa tipo, moviĝa rapido
     Notu bone, ke se ne estas malamikoj en la ĉambro, la malamikaj sprajt-
     datumoj ne aktualiĝos ĝuste kaj simple montriĝos tia malamiko, kian vi
     vidis lastatempe, aŭ kvadrata malamiko.
Nedifinitaj entoj (27-50, 57+) aperigas misfunkciantajn Viridianojn.

Koloroj por skipanoj de createentity()\h#

0: Bluverdo
1: Brilanta ruĝo (uzata por mortado)
2: Malhela oranĝkoloro
3: Koloro de kolektaĵo
4: Grizo
5: Brilanta blanko
6: Ruĝo (iomete pli malhela ol Vermiljo)
7: Limea verdo
8: Brilega rozkoloro
9: Brilega flavo
10: Brilanta blanko
11: Brila bluverdo
12: Bluo, same kiel Viktoria
13: Verdo, same kiel Verdigriso
14: Flavo, same kiel Vitelario
15: Ruĝo, same kiel Vermiljo
16: Bluo, same kiel Viktoria
17: Plihela oranĝkoloro
18: Grizo
19: Malplihela grizo
20: Rozkoloro, same kiel Violeto
21: Plihela grizo
22: Blanko
23: Brilanta blanko
24-29: Blanko
30: Grizo
31: Hela, iome purpureca grizo?
32: Malhela verdo/bluverdo
33: Malhela bluo
34: Malhela verdo
35: Malhela ruĝo
36: Malbrila oranĝkoloro
37: Brilanta grizo
38: Grizo
39: Malplihela verdo/bluverdo
40: Plibrilanta grizo
41-99: Blanko
100: Malhela grizo
101: Brilanta blanko
102: Koloro de teleportado
103 kaj pluen: Blanko

Moviĝaj tipoj de malamikoj\h#

0 - Resaltadas supren kaj malsupren, ekas malsupren.
1 - Resaltadas supren kaj malsupren, ekas supren.
2 - Resaltadas maldekstren kaj dekstren, ekas maldekstren.
3 - Resaltadas maldekstren kaj dekstren, ekas dekstren.
4, 7, 11 - Moviĝas dekstren ĝis kolizio.
5 - Same kiel supre, sed ĝi agas strange kiam ĝi kolizias.
    GIF ĉi tie: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Resaltadas supren kaj malsupren, sed nur atingas certan y-pozicion antaŭ ol
    reiri malsupren. Uzita en "Militado el la tranĉeoj".
8, 9 - Transportbendoj (por moviĝantaj platformoj)
       Ne moviĝas (por ĉio alia)
14 - Blokebla de malaperantaj platformoj
15 - Ne moviĝas (?)
10, 12 - Multobliĝas dekstren en la sama loko, paneigas VVVVVV se ĝi troas,
         difektos vian nivelon se vi konservas ĝin
13 - Kiel 4, sed moviĝas malsupren ĝis kolizio.
16 - Aperas kaj malaperas
17 - Treme iras maldekstren
18 - Treme iras dekstren, iom pli rapide
19+ - Ne moviĝas (?)

Ludstatoj\h#

0 - Eliĝas de plej multe da ludstatoj
1 - Agordas ludstaton al 0 (t.e. same kiel supre en praktiko)
2 - "To do: write quick intro to story!"
    (Farende: rapide skribi enkondukon al rakonto!)
4 - "Premu ←/→ aŭ WASD por moviĝi"
5 - Plenumas la skripton "returntohub" (t.e. fadeout, teleportiĝi al ĝuste
    antaŭ La Turo, fadein, ludi Passion for Exploring)
7 - Forigas dialog-skatolojn
8 - "Premu ENTER por vidi mapon kaj rapidkonservi"
9 - Supergravitrono
10 - Gravitrono
11 - "When you're NOT standing on stop and wait for you" (Provas aliri flipmode-
     kontrolon por skribi "the ceiling" aŭ "the floor", kaj kontroli skipanon, sed
     ĉar ĉi tio malsukcesas, la supra teksto montriĝas anstataŭe)
12 - "Ne eblas pluiri al la sekva ĉambro, ĝis kiam li estas sekure transiĝinta."
13 - Forigas dialog-skatolojn rapide
14 - "When you're standing on the floor," (same aplikiĝas ĉi tie kiel 11)
15 - Feliĉigas Viridian
16 - Malfeliĉigas Viridian
17 - "Se vi preferas, eblas premi ↑/↓ por renversiĝi."
20 - Se flago 1 estas 0, agordas ĝin al 1 kaj forigas dialog-skatolojn
21 - Se flago 2 estas 0, agordas ĝin al 1 kaj forigas dialog-skatolojn
22 - "Premu AGBUTONON por renversiĝi"
30 - "Kial la ŝipo teleportigis min ĉi tien sola?" "Mi esperas, ke la aliuloj
     eskapis enordaj..."
31 - Sekvenco: "Violeto! Ĉu estas vi?" (se flago 6 estas 0)
32 - Se flago 7 estas 0: "Ho! Teleportilo!" "Mi povas reveni al la ŝipo per ĝi!"
33 - Se flago 9 estas 0: Sekvenco de Viktoria
34 - Se flago 10 estas 0: Sekvenco de Vitelario
35 - Se flago 11 estas 0: Sekvenco de Verdigriso
36 - Se flago 8 estas 0: Sekvenco de Vermiljo
37 - Vitelario post Gravitrono
38 - Vermiljo post Gravitrono
39 - Verdigriso post Gravitrono
40 - Viktoria post Gravitrono
41 - Se flago 60 estas 0: plenumas komencon de sekvenco de Interakto 1
42 - Se flago 62 estas 0: plenumas trian sekvencon de Interakto 1
43 - Se flago 63 estas 0: plenumas kvaran sekvencon de Interakto 1
44 - Se flago 64 estas 0: plenumas kvinan sekvencon de Interakto 1
45 - Se flago 65 estas 0: plenumas sesan sekvencon de Interakto 1
46 - Se flago 66 estas 0: plenumas sepan sekvencon de Interakto 1
47 - Se flago 69 estas 0: Kolektaĵa sekvenco: "Ho! Kio estas tio, mi scivolas..."
48 - Se flago 70 estas 0: "Tie ĉi ŝajnas bona loko por konservi la aferojn, kiujn
     mi trovas en tiu ĉi dimensio." (Victoria ne jam troviĝis)
49 - Se flago 71 estas 0: Ludas Predestined Fate
50 - "Helpu! Ĉu iu ajn povas aŭdi ĉi tiun mesaĝon?"
51 - "Verdigriso? Ĉu vi estas? Ĉu vi enordas?"
52 - "Bonvole helpu nin! Ni estas kraŝinte kaj bezonas asiston!"
53 - "Ha lo? Ĉu iu ajn estas?"
54 - "Jen estas Doktoro Violeto de la kosmoŝipo Souleye! Bonvolu respondi!"
55 - "Iu ajn... mi petas..."
56 - "Estu enordaj, ĉiuj, mi petas..."
En ludstatoj 50-56, vi povas elekti kie komenci, ĉar ĉio aperos post unu la alia
80 - Se, kaj nur se la ekrano estas nigra, daŭras al stato 81 (mia supozo estas,
 ke tio ĉi estas vokita je premo de ESK, antaŭ ol malfermiĝo de la paŭzmenuo)
81 - Reiras al la ĉefmenuo
82 - Rezultoj de tempoprovo (misfunkcia)
83 - Se ekrano estas nigra, daŭras al stato 84
84 - Rezultoj de tempoprovo (pli misfunkcia ol 82)
85 - La tempoprova versio de ludstato 200 (brubrilas, ludas Positive Force, ŝaltas
     reĝimon finalstretch)
Statoj 90-95 rilatas al tempoprovoj, sed ne funkcias ĝuste en propraj niveloj.
     La nuraj veraj efikoj, kiuj okazas en propraj niveloj estas teleporto, kaj
     ŝanĝo de muziko
90 - Kosmostacio 1
91 - La laboratorio
92 - Teleportejo
93 - La turo
94 - Kosmostacio 2
95 - Fina nivelo
96 - Se ekrano estas nigra, daŭras al stato 97
97 - Eliras de Supergravitrono (teleportas vin kaj ludas Pipe Dream)
100 - Se flago 4 estas 0: daŭras al stato 101
101 - Se vi estas renversita, re-renversas vin al planko, daŭras al stato 102
      La sekvantaj statoj (102-112) provas iri al la aktuala stato + 1, kiel en
      50-56 (sed ne reiteracias) sed eble missignalos pro ke duono el la statoj
      (103, 105, 107, 109, 111) ne ekzistas.
102 - Verdigriso: "Captain! I've been so worried!" (neuzita dialogo)
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Forigas dialog-skatolojn
115 - Esence nenio, daŭras al stato 116
116 - Ruĝa dialog-skatolo ĉe la malsupro de la ekrano, kiu diras "Sorry
      Eurogamers! Teleporting around the map doesn't work in this version!",
      daŭras al stato 117, kiu ne ekzistas, do eraroj eble okazos
118 - Forigas dialog-skatolojn
Statoj 120-128 funkcias iome kiel 102-112, t.e. en serio, sed kun malpli da
      rompitaj aferoj
120 - Se flago 5 estas 0: daŭras al stato 121
121 - Se vi estas sur planko, renversas vin.
122 - Vitelario: "Captain! You're ok!" (neuzita dialogo)
124 - Vitelario: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Forigas dialog-skatolojn
200 - Fina reĝimo
1000 - Ŝaltas interscenajn striojn, haltigas la ludon, daŭras al stato 1001
1001 - "Vi trovis brilan kolektaĵon!" (sed vi ne fakte akiris kolektaĵon,
       tio ĉi estas vokita ĉiun fojon, kiam unu akiriĝas), daŭras al stato 1003
1003 - Redaŭrigas la ludon
1010 - "Vi trovis perditan skipanon!" same kiel kolektaĵoj
1013 - Finas la nivelon kun steloj
2000 - Konservas la ludon
2500-2509 - Teleportas vin al iu stranga neekzistana loko, supozeble al la
            laboratorio, mi supozas, daŭras al stato 2510
2510 - Viridiano: "...Ha lo?", daŭras al stato 2512
2512 - Viridiano: "Ĉu iu ajn estas?", daŭras al stato 2514
2514 - Forigas dialog-skatolojn, ludas Potential for Anything
Statoj 3000-3099:
3000-3005: "Fino de nivelo! Vi savis..." kaj la skipano aplikita al
           companion(), defaŭlte Verdigriso. 6=Verdigriso, 7=Vitelario,
           8=Viktoria, 9=Vermiljo, 10=Viridiano (jes, vere), 11=Violeto
           (Ludstatoj: 3006-3011=Verdigriso, 3020-3026=Vitelario, 3040-
           3046=Viktoria, 3060-3066=Vermiljo, 3080-3086=Viridiano, 3050-
           3056=Violeto)
3070-3072 - Plenumas postsavajn aferojn, kutime revenas al ŝipo
3501 - Fino de ludo (ludo estas kompletigita)
4010 - Brubrilo + teleporto
4070 - La fina nivelo, sed la ludo paneos kiam vi atingas Tempgliton (pro la
       maniero en kiu la ludo akiras ento-informojn, kiu estas rompita en
       propraj niveloj)
4080 - Viridiano estas teleportita reen al la ŝipo: "Saluton!"
       [K[K[K[K[Kapitano!], intersceno kaj agnoskoj.
       La supra difektos viajn konservitajn datumojn, do ne uzu ĝin, krom se vi
       havas savkopion!
4090 - Intersceno post kompletigo de la unua kosmostacio
]]
},

{
splitid = "100_Formatting",
subj = "Aranĝado",
imgs = {},
cont = [[
Aranĝado\wh#
\C=

En notoj vi povas uzi aranĝokodojn por pligrandigi aŭ kolorigi vian tekston, inter
aliaj aferoj. Por aldoni aranĝadon al linio, aldonu deklivon (\) ĉe la fino de ĝi.\
Post la \, vi povas aldoni ajnan kvanton el la sekvaj signoj, en ajna ordo:\

h - Duobla tipara grando\h

# - Ankro. Vi povas rapide salti al ankroj per ¤#Ligiloj¤ligiloj¤.\nLCl
- - Horizontala streko:
\-
= - Horizontala streko sub granda teksto

Tekstaj koloroj:\h#

n - Normala\n
r - Ruĝa\r
g - Griza\g
w - Blanka\w
b - Blua\b
o - Oranĝkolora\o
v - Verda\v
c - Bluverda\c
y - Flava\y
p - Viola\p
V - Malhel-verda\V
z - Nigra¤ (fonkoloro ne estas inkluzivita)\z&Z
Z - Malhel-griza\Z
C - Bluverda (Viridiano)\C
P - Rozkolora (Violeto)\P
Y - Flava (Vitelario)\Y
R - Ruĝa (Vermiljo)\R
G - Verda (Verdigriso)\G
B - Blua (Viktoria)\B


Ekzemplo:\h#

\-
Granda oranĝkolora teksto ("oh" havas\ho\

saman rezulton)\ho\

Granda oranĝkolora teksto ("oh" havas\ho

saman rezulton)\ho

\-
Substrekita granda teksto\wh\
\r=\

Substrekita granda teksto\wh
\r=
\-

Uzi multajn kolorojn sur linio\h#

Eblas uzi multajn kolorojn sur linio dividante koloritajn partojn per la
signo¤ ¤¤ ¤(kiun vi povas tajpi uzante la klavon ¤Insert/Enigi¤), metante la\nYnw
kolorkodojn en ordon post¤ \¤. Se la lasta koloro sur la linio estas la defaŭlta\nC
koloro (n), ne necesas listigi tion ĉefine. Se vi volas uzi la signon¤ ¤¤ ¤sur\nY
linio, kiu uzas¤ \¤, skribu¤ ¤¤¤¤ ¤anstataŭe. Pro teknikaj kaŭzoj, ne eb¤l§¤as\nCnYnR(
kolorigi unu signon sole metante ĝin inter du¤ ¤¤§¤oj, krom se vi aldonas ankaŭ\nY(
spaceton aŭ alian signon.

\-
Vi povas ¤¤kolorigi¤¤ specifajn ¤¤vortojn¤¤ per ĉi tio!\nrnv\

Vi povas ¤kolorigi¤ specifajn ¤vortojn¤ per ĉi tio!\nrnv
\-
Kelkaj ¤¤te¤¤ks¤¤ta¤¤j ¤¤ko¤¤lo¤¤ro¤¤j\RYGCBPRYG\

Kelkaj ¤te¤ks¤ta¤j ¤ko¤lo¤ro¤j\RYGCBPRYG
\-

Kolorigi sole unu signon\h#

Bone, mi mensogis, ja eblas kolorigi sole unu signon sen aldoni spaceton.
Por tiel fari, metu la signon¤ § ¤(tajpebla per ¤Ŝov+Insert¤), post\nYnw
la signo, kiun vi volas kolorigi, kaj ebligu ĝin per la aranĝokodo¤ ( ¤post¤ \¤:\nCnC

\-
Vi povas k¤¤o§¤¤lorigi unu signon ¤¤sole¤¤ ĉi tiel!\nrny(\

Vi povas k¤o§¤lorigi unu signon ¤sole¤ ĉi tiel!\nrny(
\-

Tio ĉi ne necesas se la sola signo estas la unua aŭ lasta sur linio.

Fonaj koloroj\h#

Ne nur eblas kolorigi tekston, ankaŭ eblas ¤marki ĝin¤ per ajne el la tekstkoloroj.\nZ&y
Por tiel fari, vi povas meti¤ & ¤post la regulara teksta kolorkodo, kaj tiam\nY
kolorkodon por la fona koloro. Tio ĉi estas farebla kombine kun la sistemo
ĉi-supre priskribita; notu, ke kutimaj tekstkoloroj komencas la sekvan "blokon",
sed fonkoloroj ne faras do. La jenaj ekzemploj uzas spacetojn por fari ĉion pli
legeblan, sed tio estas tute nedeviga. Vi povas uzi la kodon¤ + ¤por etendi la\nY
(lastan) fonkoloron al la fino de la linio.

\-
Nigra teksto sur blanka fono!\z&w\

Nigra teksto sur blanka fono!\z&w
\-
Nigra teksto sur etendita blanka fono!\z&w+\

Nigra teksto sur etendita blanka fono!\z&w+
\-
Ruĝe surflave¤¤, ¤¤Nigre surblanke¤¤ (nedevige, spacetoj pli legebligas)\r&y n z&w\

Ruĝe surflave¤, ¤Nigre surblanke¤ (nedevige, spacetoj pli legebligas)\r&y n z&w
\-
Tio ĉi ¤¤funkcias¤¤ ankaŭ por kolorigi unu si¤¤g§¤¤non sole\n P n n&r (\

Tio ĉi ¤funkcias¤ ankaŭ por kolorigi unu si¤g§¤non sole\n P n n&r (
\-

Se vi volas, vi povas ankaŭ krei grafikojn pere de fonaj koloroj:

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

Ligiloj\h#

Ligiloj estas uzeblaj por du aferoj: ligi aliloken en la artikoloj/notoj,
aŭ ligi al retejoj. Ligiloj uzas la kvazaŭ-kolorkodon¤ l¤. Tiu ĉi kodo ne\nY
ŝanĝas al la sekva "kolorbloko", ĝi nur aplikiĝas al la aktuala, kontraŭe
al kutimaj (nefonaj) kolorkodoj. Ĝi ankaŭ ne ŝanĝas la koloron, do vi povas
ŝanĝi la stilon de la ligilo kiel ajn vi deziras.

Vi povas ligi al artikoloj simple uzante la nomon de la artikolo:

\-
Iloj\bl\

Iloj\bl
\-

Alklaki la ligilon "Iloj" ĉi-supre prenos vin al la helpoartikolo "Iloj". Mi
uzis la kolorkodon¤ b ¤ĉi tie por bluigi la ligilon, kaj kiel videblas,\nb
la¤ l ¤aplikiĝas al tiu sama kolorigita parto.\nY

Vi povas ligi al ankroj en la sama artikolo ligante al¤ # ¤sekvata de ĉiu teksto\nY
sur tiu linio. (Aperoj de¤ ¤¤ ¤tute ignoriĝas tie.) Vi povas ligi al la supraĵo de la\nY
artikolo per simpla krado (¤#§¤).\nY(

\-
#Uzi multajn kolorojn sur linio\bl\

#Uzi multajn kolorojn sur linio\bl
\-

Vi povas ligi al ankro en malsama artikolo en simila maniero:

\-
Manlibreto de listoj#Ludstatoj\bl\

Manlibreto de listoj#Ludstatoj\bl
\-

Ligi al retejo ankaŭ estas sufiĉe facile:

\-
https://example.com/\bl\

https://example.com/\bl
\-

Vi povas uzi kolorblokon kun kolorkodo¤ L ¤kiu enhavas la veran celolokon\nY
antaŭ la ligila teksto, kaj tiel montrigi la ligilon je malsama teksto:

\-
Iloj¤¤Iri al alia artikolo\Lbl\

Iloj¤Iri al alia artikolo\Lbl
\-
Alklaku ¤¤Iloj¤¤ĉi tien¤¤ por iri al alia artikolo\nLbl\

Alklaku ¤Iloj¤ĉi tien¤ por iri al alia artikolo\nLbl
\-
[¤¤#Ligiloj¤¤Ŝati¤¤] [¤¤#Ekzemplo:¤¤Malŝati¤¤]\n L vl n L rl\

[¤#Ligiloj¤Ŝati¤] [¤#Ekzemplo:¤Malŝati¤]\n L vl n L rl
\-
#Ligiloj¤¤ Butono A ¤¤ §¤¤#Ligiloj¤¤ Butono B \L w&Zl n L w&Z l(\

#Ligiloj¤ Butono A ¤ §¤#Ligiloj¤ Butono B \L w&Zl n L w&Z l(
\-

Bildoj (haveblaj nur en aldonaĵaj\h#

priskriboj):\h

0..9 - montras bildon 0..9 sur ĉi tiu linio (tabelindekso en la imgs-tabelo
       ekas je 0, kaj memoru blankigi liniojn por akomodi la bildan alton)
^ - Metite antaŭ la bildnumero, ŝovas bildnumeron je 10. Do ^4 faras
    bildon 14, ^^4 faras bildon 24. Kaj 3^1^56 faras bildojn 3, 11, 25 kaj
    26.
_ - Metite antaŭ la bildnumero, malpliigas la bildnumeron je 10.
> - Metite antaŭ la bildnumero, ŝovas pluajn bildojn dekstren je
    8 bilderoj. Tio ĉi ripeteblas, do 0>>>>1 metas bildon 0 ĉe x=0 kaj
    bildon 1 ĉe x=32.
< - Same, sed ŝovas maldekstren.
]]
},

{
splitid = "990_Credits",
subj = "Agnoskoj",
imgs = {"images/credits.png"},
cont = [[
\0















Agnoskoj\wh#
\C=

Ved estas farita de Dav999

Pluaj kod-kontribuantoj: Info Teddy

Kelkaj grafikoj kaj la tiparo estas faritaj de Reese Rivers

Ruslingva traduko: CreepiX, Cheep, Omegaplex
Esperanta traduko: Reese Rivers
Germanlingva traduko: r00ster
Franclingva traduko: RhenaudTheLukark
Hispanlingva traduko: Valso22/naether
Indonezilingva traduko: _march31onne/Marchionne Evangelisti


Special-dank' al:\h#


Terry Cavanagh pro krei la ludon VVVVVV

Ĉiuj, kiuj raportis erarojn, elpensis ideojn kaj kuraĝigis min fari ĉi tion!
\
\



Permesilo\h#
\
Copyright 2015-2024  Dav999
\
Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
\
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or other
materials provided with the distribution.
\
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

Havaĵoj de VVVVVV\h#

Ved inkluzivas iujn grafikajn havaĵojn de VVVVVV. VVVVVV kaj ĝiaj havaĵoj estas
kopirajtitaj de Terry Cavanagh. Por pliaj informoj pri la permesilo, kiu aplikiĝas
al VVVVVV kaj ĝiaj havaĵoj, vidu ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ kaj ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md¤ en\nLClnLCln
la ¤https://github.com/TerryCavanagh/VVVVVV¤GitHub-deponejo de VVVVVV¤.\nLCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
