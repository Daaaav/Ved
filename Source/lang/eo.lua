-- Language file for Ved
--- Language: Esperanto (eo)
--- Last converted: 2020-02-24 00:18:43 (CET)

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

TRANSLATIONCREDIT = "Esperantigo de Hejmstel", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Via versio de L{ve estas malaktuala. Bonvolu uzi version 0.9.1 aŭ pli altan.\nVi povas elŝuti la plej freŝan version de L{ve ĉe https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ne plu subtenas L{ve 0.9.0, sed versioj 0.9.1 kaj pli altaj ankoraŭ funkcios.\nVi povas elŝuti la plej freŝan version de L{ve ĉe https://love2d.org/.",
UNKNOWNSTATE = "Saltis al nekonata stato ($1) de stato $2",
FATALERROR = "NERIPAREBLA ERARO: ",
FATALEND = "Bonvolu fermi la ludon kaj reprovu. Kaj se vi estas Dav, bonvolu ripari ĝin.",

OSNOTRECOGNIZED = "Via operaciumo ($1) ne estas konata! Defaŭltaj dosiersistemaj funkcioj estas uzataj; niveloj estas konservitaj en:\n\n$2",
MAXTRINKETS = "La maksimuma kvanto da kolektaĵoj ($1) estas atingita en ĉi tiu nivelo.",
MAXCREWMATES = "La maksimuma kvanto da ŝipanoj ($1) estas atingita en ĉi tiu nivelo.",
EDITINGROOMTEXTNIL = "Ekzistinta ĉambroteksto, kiun ni estis redaktinta, estas nula!",
STARTPOINTNOLONGERFOUND = "La malnova komenciĝejo ne plu troveblas!",
UNSUPPORTEDTOOL = "Nesubtenata ilo! Ilo: ",
SURENEWLEVEL = "Ĉu vi certas, ke vi volas fari novan nivelon? Vi perdos ĉion nekonservitan.",
SURELOADLEVEL = "Ĉu vi certas, ke vi volas ŝargi nivelon? Vi perdos ĉion nekonservitan.",
COULDNOTGETCONTENTSLEVELFOLDER = "Ne povis akiri la enhavon de la nivelodosierujo. Bonvolu kontroli ĉu $1 ekzistas, kaj reprovu.",
MAPSAVEDAS = "Map-bildo konservita kiel $1!",
RAWENTITYPROPERTIES = "Vi povas ŝanĝi la krudajn atributvalorojn de ĉi tiu ento ĉi tie.",
UNKNOWNENTITYTYPE = "Nekonata entotipo $1",
METADATAENTITYCREATENOW = "La metadatuma ento ne jam ekzistas. Ĉu krei ĝin nun?\n\nLa metadatuma ento estas kaŝita ento, kiu povas esti aldonita al VVVVVV-niveloj por teni ekstrajn datumojn, kiujn uzas Ved, ekzemple la nivelo-notblokon, flagnomojn, kaj aliajn aferojn.",
WARPTOKENENT404 = "Teleportila ento ne plu ekzistas!",
SPLITFAILED = "Fendado mizere malsukcesis! Ĉu estas tro da linioj inter tekstkomando kaj speak aŭ speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Ne plu restas pliaj flagoj, do unu aŭ pli da novaj flagetikedoj en ĉi tiu skripto ne povas esti asociita kun iu ajn flagnumero. Provi plenumi la skripton en VVVVVV eble kaŭzos erarojn. Konsideru viŝi ĉiujn referencojn al flagoj, kiujn vi ne plu bezonas, kaj reprovu.\n\nĈu eliri la redaktilon?",
NOFLAGSLEFT_LOADSCRIPT = "Ne plu restas flagoj, do ŝarg-skripto uzanta novan flagon ne povis kreiĝi. Anstataŭe, ŝarg-skripto estis kreita, kiu ĉiam ŝargas la celatan skripton per iftrinkets(0,$1). Konsideru forigi ĉiujn aludojn al flagoj ne plu bezonataj kaj reprovu.",
LEVELOPENFAIL = "Ne povis malfermi $1.vvvvvv.",
SIZELIMIT = "La maksimuma grando de nivelo estas $1 oble $2.\n\nLa grando anstataŭe ŝanĝiĝos al $3 oble $4.",
SCRIPTALREADYEXISTS = "Skripto \"$1\" jam ekzistas!",
FLAGNAMENUMBERS = "Flagnomoj ne povas esti nur ciferoj.",
FLAGNAMECHARS = "Flagnomoj ne povas enhavi parentezojn, komojn aŭ spacetojn.",
FLAGNAMEINUSE = "La flagnomo $1 jam estas uzata de flago $2",
DIFFSELECT = "Elektu la nivelon komparotan. La nivelo, kiun vi nun elektas, estos konsiderata kiel pli malnova versio.",
SUREQUIT = "Ĉu vi certas, ke vi volas eliri? Vi perdos ĉion nekonservitan.",
SUREQUITNEW = "Vi havas nekonservitajn ŝanĝojn. Ĉu vi volas konservi ilin antaŭ ol eliri?",
SURENEWLEVELNEW = "Vi havas nekonservitajn ŝanĝojn. Ĉu vi volas konservi ilin antaŭ ol krei novan nivelon?",
SCALEREBOOT = "La novaj skalagordoj efikos post relanĉi Ved-on.",
NAMEFORFLAG = "Nomo de flago $1:",
SCRIPT404 = "Skripto \"$1\" ne ekzistas!",
ENTITY404 = "Ento #$1 ne plu ekzistas!",
GRAPHICSCARDCANVAS = "Pardonon, sed ŝajnas ke via grafikkarto ne subtenas tiun trajton!",
MAXTEXTURESIZE = "Pardonon, krei bildon de $1x$2 ne ŝajnas esti subtenata de via grafikkarto aŭ pelilo.\n\nLa limo de grando ĉe tiu ĉi sistemo estas $3x$3.",
SUREDELETESCRIPT = "Ĉu vi certas, ke vi volas forigi la skripton \"$1\"?",
SUREDELETENOTE = "Ĉu vi certas, ke vi volas forigi ĉi tiun noton?",
THREADERROR = "Fadena eraro!",
WHATDIDYOUDO = "Kion vi faris?!",
UNDOFAULTY = "Kion vi faras?",
SOURCEDESTROOMSSAME = "Originala kaj nova ĉambroj estas samaj!",
UNKNOWNUNDOTYPE = "Nekonata malfaro-tipo \"$1\"!",
MDEVERSIONWARNING = "Ĉi tiu nivelo ŝajnas esti farita en pli nova versio de Ved, kaj eble enhavas iujn datumojn, kiuj perdiĝos kiam vi konservas la nivelon.",
FORGOTPATH = "Vi forgesis specifi dosierindikon!",
MDENOTPASSED = "Averto: metadatuma ento ne transdonita al savelevel()!",
RESTARTVEDLANG = "Post ŝanĝi la lingvon, vi devas relanĉi Ved-on antaŭ ol la ŝanĝo efikos.",

SELECTCOPY1 = "Elektu la ĉambron kopii",
SELECTCOPY2 = "Elektu la lokon kopii ĉi tiun ĉambron al",
SELECTSWAP1 = "Elektu la unuan ĉambron permuti",
SELECTSWAP2 = "Elektu la duan ĉambron permuti",

TILESETCHANGEDTO = "Blokaro ŝanĝita al $1",
TILESETCOLORCHANGEDTO = "Koloro de blokaro ŝanĝita al $1",
ENEMYTYPECHANGED = "Malamiko-tipo ŝanĝita al $1",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "$1 bloko-metado",
CHANGEDTOMODEAUTO = "Aŭtomata",
CHANGEDTOMODEMANUAL = "Permana",
CHANGEDTOMODEMULTI = "Multblokara",

BUSYSAVING = "Konservado...",
SAVEDLEVELAS = "Konservita kiel $1.vvvvvv",

ROOMCUT = "Ĉambro tondita al tondejo",
ROOMCOPIED = "Ĉambro kopiita al tondejo",
ROOMPASTED = "Ĉambro algluita",

METADATAUNDONE = "Nivelagordoj malfaritaj",
METADATAREDONE = "Nivelagordoj refaritaj",

BOUNDSTOPLEFT = "Alklaku la supra-maldekstran angulon de la limo",
BOUNDSBOTTOMRIGHT = "Alklaku la malsupra-dekstran angulon",

TILE = "Bloko $1",
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
INTERNALYESBARS = "say(-1) int.skr",
INTERNALNOBARS = "Ŝargskripto int.skr",
VIEW = "Vidi",
SYNTAXHLOFF = "Sintakso: JES",
SYNTAXHLON = "Sintakso: NE",
TEXTSIZEN = "Tekstgrando: N",
TEXTSIZEL = "Tekstgrando: L",
INSERT = "Enmeti",
HELP = "Helpo",
INTSCRWARNING_NOLOADSCRIPT = "Ŝargskripto bezonata!",
INTSCRWARNING_BOXED = "Refrencita rekte de skriptkvadrato/komputilo!\n\n",
COLUMN = "Kolumno: ",

BTN_OK = "Bone",
BTN_CANCEL = "Nuligi",
BTN_YES = "Jes",
BTN_NO = "Ne",
BTN_APPLY = "Apliki",
BTN_QUIT = "Eliri",
BTN_DISCARD = "Ignori",
BTN_SAVE = "Konservi",
BTN_CLOSE = "Fermi",
BTN_LOAD = "Ŝargi",

COMPARINGTHESE = "Komparado de $1.vvvvvv al $2.vvvvvv",
COMPARINGTHESENEW = "Komparado de nekonservita nivelo al $1.vvvvvv",

RETURN = "Reen",
CREATE = "Krei",
GOTO = "Alsalti",
DELETE = "Forigi",
RENAME = "Renomi",
CHANGEDIRECTION = "Ŝanĝi direkton",
DIRECTION = "Direkto->",
UP = "supren",
DOWN = "malsupren",
LEFT = "maldekstren",
RIGHT = "dekstren",
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
CHANGETOHOR = "Ŝanĝi al horizantala",
CHANGETOVER = "Ŝanĝi al vertikala",
RESIZE = "Movigi/Regrandigi",
CHANGEENTRANCE = "Movigi enirejon",
CHANGEEXIT = "Movigi elirejon",
COPYENTRANCE = "Kopii enirejon",
LOCK = "Ŝlosi",
UNLOCK = "Malŝlosi",
BUG = "[Erareto!]",

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
AUTO2MODE = "Reĝimo: multblokara",
MANUALMODE = "Reĝimo: permana",
PLATFORMSPEED = "Platformrapido: $1",
ENEMYTYPE = "Malamiko-tipo: $1",
PLATFORMBOUNDS = "Platformlimo",
WARPDIR = "Teleport-\ndirekto: $1",
ENEMYBOUNDS = "Malamiko-limo",
ROOMNAME = "Ĉambronomo",
ROOMOPTIONS = "Ĉambro-agordoj",
ROTATE180 = "Turni 180-grade",
ROTATE180UNI = "Turni 180-grade",
HIDEBOUNDS = "Kaŝi limojn",
SHOWBOUNDS = "Montri limojn",

ROOMPLATFORMS = "Platformoj en ĉambro", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Malamikoj en ĉambro",

OPTNAME = "Nomo",
OPTBY = "Kreinto",
OPTWEBSITE = "Retejo ",
OPTDESC = "Pri-\nskribo", -- If necessary, you can span multiple lines
OPTSIZE = "Grando",
OPTMUSIC = "Muziko",
CAPNONE = "NENIU",
ENTERLONGOPTNAME = "Nivelo-nomo:",

X = "x", -- Used for level size: 20x20

SOLID = "Masiva",
NOTSOLID = "Ne masiva",

TSCOLOR = "Koloro $1",

ONETRINKETS = "K:",
ONECREWMATES = "Ŝ:",
ONEENTITIES = "E:",

LEVELSLIST = "Niveloj",
LOADTHISLEVEL = "Ŝargi nivelon: ",
ENTERNAMESAVE = "Enmetu nomon por konservi: ",
SEARCHFOR = "Serĉi por: ",

VERSIONERROR = "Ne povis kontroli version.",
VERSIONUPTODATE = "Via versio de Ved estas aktuala.",
VERSIONOLD = "Ĝisdatigo disponebla! Plej freŝa versio: $1",
VERSIONCHECKING = "Kontrolado de ĝisdatigoj...",
VERSIONDISABLED = "Kontrolado de ĝisdatigoj malŝaltita",

SAVESUCCESS = "Konservita sukcese!",
SAVENOSUCCESS = "Konservado ne sukcesa! Eraro: ",
INVALIDFILESIZE = "Nevalida dosiergrando.",

EDIT = "Redakti",
EDITWOBUMPING = "Redakti sen ŝanĝi skriptordon",
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
SAVEFULLSIZEMAP = "Konservi plengrandan mapon",
COPYROOMS = "Kopii ĉambron",
SWAPROOMS = "Permuti ĉambrojn",

FLAGS = "Flagoj",
ROOM = "ĉambro",
CONTENTFILLER = "Enhavo",

FLAGUSED = "Uzata   ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Ne uzata",
FLAGNONAME = "Sennoma",
USEDOUTOFRANGEFLAGS = "Uzataj ekstervariejaj flagoj:",

CUSTOMVVVVVVDIRECTORY = "VVVVVV -dosierujo",
CUSTOMVVVVVVDIRECTORYEXPL = "La defaŭlta dosierujo de VVVVVV, kiun atendas Ved estas:\n$1\n\nTiu dosieruj-indiko ne estu agordita al la dosierujo \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Vi ne havas propran dosierujon de VVVVVV agordita.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Via dosierujo de VVVVVV estas agordita al propra indiko:\n$1\n\n",
LANGUAGE = "Lingvo",
DIALOGANIMATIONS = "Dialoganimacioj",
FLIPSUBTOOLSCROLL = "Renversi ruluman direkton de ilido",
ADJACENTROOMLINES = "Indikiloj de blokoj en najbaraj ĉambroj",
ASKBEFOREQUIT = "Demandi antaŭ ol eliri",
NEVERASKBEFOREQUIT = "Neniam demandi antaŭ ol eliri, eĉ se estas nekonservitaj ŝanĝoj",
COORDS0 = "Montri koordinatojn komence je nulo (kiel en interna skriptado)",
ALLOWDEBUG = "Ebligi sencimigan reĝimon",
SHOWFPS = "Montri kadrojn sekunde",
IIXSCALE = "Duobla skalo",
CHECKFORUPDATES = "Kontroli ĝisdatigojn",
PAUSEDRAWUNFOCUSED = "Ne bildigi kiam la fenestro estas elfokusa",
ENABLEOVERWRITEBACKUPS = "Fari savkopiojn de niveldosieroj, kiuj superskribiĝas",
AMOUNTOVERWRITEBACKUPS = "Nombro da savkopioj por konservi por ĉiu nivelo",
SCALE = "Skalo",
LOADALLMETADATA = "Ŝargi metadatumojn (kiel titolon, aŭtoron kaj priskribon) por ĉiuj dosieroj en nivelolisto",
COLORED_TEXTBOXES = "Uzi verajn tekstskatol-kolorojn",

SCRIPTSPLIT = "Fendi",
SPLITSCRIPT = "Fendi skriptojn",
COUNT = "Kvanto:",
SMALLENTITYDATA = "datumoj",

-- Stats screen
AMOUNTSCRIPTS = "Skriptoj:",
AMOUNTUSEDFLAGS = "Flagoj:",
AMOUNTENTITIES = "Entoj:",
AMOUNTTRINKETS = "Kolektaĵoj:",
AMOUNTCREWMATES = "Ŝipanoj:",
AMOUNTINTERNALSCRIPTS = "Internaj skriptoj:",
TILESETUSSAGE = "Uzado de blokaroj",
TILESETSONLYUSED = "(nur ĉambroj kun blokoj estas konsiderataj)",
AMOUNTROOMSWITHNAMES = "Ĉambroj kun nomoj:",
PLACINGMODEUSAGE = "Blokmetadaj reĝimoj:",
AMOUNTLEVELNOTES = "Nivelnotoj:",
AMOUNTFLAGNAMES = "Flagnomoj:",
TILESUSAGE = "Uzado de blokoj",
AMOUNTTILES = "Kaheloj:",
AMOUNTSOLIDTILES = "Solidaj kaheloj:",
AMOUNTSPIKES = "Pintaĵoj:",


UNEXPECTEDSCRIPTLINE = "Neatendita skriptlinio sen skripto: $1",
DUPLICATESCRIPT = "Skripto $1 estas duplikato! Nur unu povas esti ŝargita.",
MAPWIDTHINVALID = "Maplarĝo estas malvalida: $1",
MAPHEIGHTINVALID = "Mapalto estas malvalida: $1",
LEVMUSICEMPTY = "Nivelo-muziko estas nula!",
NOT400ROOMS = "La kvanto da enskriboj en levelMetaData ne estas 400!",
MOREERRORS = "$1 pliaj",

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

-- b14
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
RESETCOLORS = "Defaŭltigi kolorojn",
STRINGNOTFOUND = "\"$1\" ne estis trovita",

-- b17 - L.MAL is concatenated with L.[...]CORRUPT
MAL = "La nivelo-dosiero estas misformigita: ",
METADATACORRUPT = "Meta-datumoj estas mankantaj aŭ koruptitaj.",
METADATAITEMCORRUPT = "Meta-datumoj por $1 estas mankantaj aŭ koruptitaj.",
TILESCORRUPT = "Blokoj mankantaj aŭ koruptitaj.",
ENTITIESCORRUPT = "Entoj mankantaj aŭ koruptitaj.",
LEVELMETADATACORRUPT = "Ĉambraj meta-datumoj mankantaj aŭ koruptitaj.",
SCRIPTCORRUPT = "Skriptoj mankantaj aŭ koruptitaj.",

-- 1.1.0
LOADSCRIPTMADE = "Ŝargskripto kreita",
COPY = "Kopii",
CUSTOMSIZE = "Tajlorita grando de broso: $1x$2",
SELECTINGA = "Elektado - alklaku supre maldekstre",
SELECTINGB = "Elektado: $1x$2",
TILESETSRELOADED = "Tegolaroj kaj ento-grafikoj reŝargitaj",

-- 1.2.0
BACKUPS = "Savkopioj",
BACKUPSOFLEVEL = "Savkopioj de nivelo $1",
LASTMODIFIEDTIME = "Originale laste modifita", -- List header
OVERWRITTENTIME = "Superskribita je", -- List header
SAVEBACKUP = "Konservi al dosierujo de VVVVVV",
DATEFORMAT = "Dato-formo",
TIMEFORMAT = "Tempo-formo",
CUSTOMDATEFORMAT = "Tajlorita dato-formo",
SAVEBACKUPNOBACKUP = "Certigu ke vi elektas unikan nomon por ĉi tiu se vi ne volas superskribi ion ajn, pro ke NENIU savkopio estas farota ĉi-okaze!",

-- 1.2.4
AUTOSAVECRASHLOGS = "Aŭtomate konservi kraŝo-protokolojn",
MOREINFO = "Plej aktualaj informoj",
COPYLINK = "Kopii ligilon",
SCRIPTDISPLAY = "Montri",
SCRIPTDISPLAY_USED = "Uzita",
SCRIPTDISPLAY_UNUSED = "Neuzita",

-- 1.3.0 (more changes)
RECENTLYOPENED = "Lastatempe malfermitaj niveloj",
REMOVERECENT = "Ĉu vi volas forigi ĝin de la listo de lastatempe malfermitaj niveloj?",
RESETCUSTOMBRUSH = "(Dekstre alklaku por agordi novan grandon)",

-- 1.3.2
DISPLAYSETTINGS = "Ekrano/grando",
DISPLAYSETTINGSTITLE = "Agordoj de ekrano/grando",
SMALLERSCREEN = "Pli malgranda fenestro-larĝo (larĝa je 800px anstataŭ 896px)",
FORCESCALE = "Devigi agordojn de grando",
SCALENOFIT = "La nunaj agordoj de grando tro grandigas la fenestron por laŭmezuriĝi.",
SCALENONUM = "La nunaj agordoj de grando estas nevalidaj.",
MONITORSIZE = "$1x$2 ekrano",
VEDRES = "Distingivo de Ved: $1x$2",
NONINTSCALE = "Neentjera skalado",

-- 1.3.4
USEFONTPNG = "Uzi font.png de grafiko-dosierujo de VVVVVV kiel tiparo",
REQUIRESHIGHERLOVE = " (bezonas L{VE $1 aŭ pli altan)",
SYNTAXCOLOR_COMMENT = "Komento",
FPSLIMIT = "KS-limo",

MAPRESOLUTION = "Distingivo", -- Map export size
MAPRES_ASSHOWN = "Kiel montrate (maks. 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% (po $2x$3 por ĉambro)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 (po $3x$4 por ĉambro)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Sp.-maldekstro",
WIDTHHEIGHT = "Larĝo k alto",
BOTTOMRIGHT = "Malsp.-dekstro",
RENDERERINFO = "Informoj de bildigilo:",
MAPINCOMPLETE = "La mapo ne jam pretas (je la tempo, kiam vi premis Konservi), bonvole reprovu kiam ĝi ja pretas.",
KEEPDIALOGOPEN = "Restigi dialogon malferma",
TRANSPARENTMAPBG = "Travidebla fono",
MAPEXPORTERROR = "Eraro dum kreado de mapo.",
VIEWIMAGE = "Vidi", -- Verb, view image
INVALIDLINENUMBER = "Bonvolu enigi validan linio-numeron.",
OPENLEVELSFOLDER = "Malfermi dosierujon", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Movigi",
GOTOROOM = "Iri al ĉambro",
ESCTOCANCEL = "[Premu ESC por nuligi]",

INVALIDFILENAME_WIN = "Windows ne permesas la jenajn signojn en dosiernomoj:\n\n: * ? \" < > |\n\n(| estante vertikala streko)",
INVALIDFILENAME_MAC = "macOS ne permesas la signon : en dosiernomoj.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "REG",
TINY_SHIFT = "MAJUSKLO",
TINY_ALT = "ALT",
TINY_ESC = "ESC",
TINY_TAB = "TAB",
TINY_HOME = "HOME",
TINY_END = "END",
TINY_INSERT = "INS",
TINY_DEL = "DEL",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Skriptoj [$1]",
SEARCHRESULTS_ROOMS = "Ĉambroj [$1]",
SEARCHRESULTS_NOTES = "Notoj [$1]",

ASSETS = "Valoraĵoj", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Ne eblas ludi tiun ĉi melodion. Ĝi eble ne ekzistas aŭ estas de nesubtenata tipo.",
SOUNDPLAYERROR = "Ne eblas ludi tiun ĉi sonon. Ĝi eble ne ekzistas aŭ estas de nesubtenata tipo.",
MUSICLOADERROR = "Ne eblas ŝargi $1: ",
MUSICLOADERROR_TOOSMALL = "La muzikdosiero tro malgrandas por esti valida.",
MUSICEXISTSYES = "Ekzistas",
MUSICEXISTSNO = "Ne ekzistas",
LOAD = "Ŝargi",
RELOAD = "Reŝargi",
UNLOAD = "Malŝargi",
MUSICEDITOR = "Muzikredaktilo",
LOADMUSICNAME = "Ŝargi .vvv",
INSERTSONG = "Enmeti melodion ĉe trako $1",
SUREDELETESONG = "Ĉu vi certas, ke vi volas forigi melodion $1?",
SONGOPENFAIL = "Ne eblis malfermi $1, melodio ne anstataŭigiĝis.",
SONGREPLACEFAIL = "Io misiris dum la anstataŭigado de la melodio.",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
CANNOTUSENEWLINES = "Vi ne povas uzi la signon \"$1\" en skriptnomoj!",
MUSICTITLE = "Titolo: ",
MUSICARTIST = "Artisto: ",
MUSICFILENAME = "Dosiernomo: ",
MUSICNOTES = "Notoj:",
SONGMETADATA = "Metadatumoj por melodio $1",
MUSICFILEMETADATA = "Metadatumoj de dosiero",
MUSICEXPORTEDON = "Eksportita: ", -- Followed by date and time
SAVEMETADATA = "Konservi metadatumojn",
SOUNDS = "Sonoj",
GRAPHICS = "Grafikoj",
FILEOPENERNAME = "Nomo: ",
PATHINVALID = "La dosierindiko malvalidas.",
DRIVES = "Diskoj", -- like C: or F: on Windows
DOFILTER = "Nur montru *$1", -- "*.txt" for example
DOFILTERDIR = "Nur montru dosierujojn",
FILEDIALOGLUV = "Bedaŭrinde, via operaciumo ne estas konata, do la dosierdialogujo ne funkcias.",
RESET = "Rekomencigi",
CHANGEVERB = "Ŝanĝi", -- verb
LOADIMAGE = "Ŝargi bildon",
GRID = "Krado",
NOTALPHAONLY = "RVB",

OPAQUEROOMNAMEBACKGROUND = "Faru la nigrajn ĉambronomo-fonojn opakaj",
PLATVCHANGE_TITLE = "Ŝanĝi rapidon de platformoj",
PLATVCHANGE_MSG = "Rapido:",
PLATVCHANGE_INVALID = "Vi devas entajpi numeron.",
RENAMESCRIPTREFERENCES = "Renomi referencojn",
PLATFORMSPEEDSLIDER = "Rpd.:",

TRINKETS = "Kolektaĵoj",
LISTALLTRINKETS = "Listigi ĉiujn kolektaĵojn", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Listo de ĉiuj kolektaĵoj",
NOTRINKETSINLEVEL = "Ne estas kolektaĵoj en tiu ĉi nivelo.",
CREWMATES = "Ŝipanoj",
LISTALLCREWMATES = "Listigi ĉiujn ŝipanojn", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Listo de ĉiuj saveblaj ŝipanoj",
NOCREWMATESINLEVEL = "Ne estas saveblaj ŝipanoj en tiu ĉi nivelo.",
SHIFTROOMS = "Ŝovi ĉambrojn", -- In the map. Move all rooms in the entire level in any direction


OLDSHORTCUT_SCRIPTJUMP = "REG+(mal)dekstra klavo ĉesos funkcii baldaŭ, anstataŭ tio uzu ALT+(mal)dekstra klavo", -- CTRL and ALT are capitalized here for extra clarity in this string
OLDSHORTCUT_ASSETS = "REG+A ĉesos funkcii baldaŭ, anstataŭ tio uzu REG+R",
OLDSHORTCUT_OPENLVLDIR = "REG+D ĉesos funkcii baldaŭ, anstataŭ tio uzu REG+F",
OLDSHORTCUT_GOTOROOM = "Q ĉesos funkcii baldaŭ, anstataŭ tio uzu G",
OLDSHORTCUT_SHOWBG = "K ĉesos funkcii baldaŭ, anstataŭ tio uzu SHIFT+;",

FRAMESTOSECONDS = "$1 = $2 sek",
ROOMNUM = "Ĉambro $1",
TRACKNUM = "Trako $1",
STOPSMUSIC = "Haltigas muzikon",
EDITSCRIPTWOBUMPING = "Redakti skripton sen suprenigi",
CLICKONTHING = "Alklaku $1",
ORDRAGDROP = "aŭ ŝovmetu ĉi tien", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Estas pli ol unu komencejo en tiu ĉi nivelo!",

CONFIRMBIGGERSIZE = "Vi elektas $1 oble $2. Tio estas pli granda mapgrando ol $3 oble $4. Ekster la normala mapo $3 oble $4, ĉambroj kaj ĉambrotrajtoj ĉirkaŭfluas, sed estas distorditaj. Vi ne havos tute novajn ĉambrojn, nek pli da ĉambrotrajtoj. VVVVVV ankaŭ eble kraŝos ial ajn en tiuj ĉambroj.\n\nPremu Jes se vi scias, kion vi faras, kaj volas tiun ĉi pli grandan mapograndon. Premu Ne por agordi la grandon al $5 oble $6.\n\nSe vi ne certas, premu Ne.",
MAPBIGGERTHANSIZELIMIT = "Mapogrando $1 oble $2 estas pli granda ol $3 oble $4! (Subteno por pli ol $3 oble $4 ne ebligita)",
BTNOVERRIDE = "Transpasi",
TARGETPLATFORM = "Celata platformo", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
PLATFORM_VCE = "VVVVVV-CE",
ENABLETOWER = "Turoreĝimo",
DISABLETOWER = "Malebligi turon",
TIMETRIALS = "Tempelprovoj",
DIMENSIONS = "Dimensioj",
TOWERDIRECTIONUP = "Direkto: ↑",
TOWERDIRECTIONDOWN = "Direkto: ↓",
TOWERENTRYEXIT = "Agordi en/elirejon",
SWITCHEDTOALTSTATEMAIN = "Interŝanĝis al ĉefa stato",
SWITCHEDTOALTSTATE = "Interŝanĝis al alterna stato $1",
ADDEDALTSTATE = "Aldonis novan alternan staton $1",
REMOVEDALTSTATE = "Forigis alternan staton $1",
ENABLEDTOWER = "Turoreĝimo ebligita",
DISABLEDTOWER = "Turoreĝimo malebligita",
TOWERASCENDING = "Turo nun supreniras",
TOWERDESCENDING = "Turo nun malsupreniras",
TOWERENTRYSET = "Tura en/elirejo agordita al aktuala pozicio",
TIMETRIALTRINKETS = "Nombro da kolektaĵoj",
TIMETRIALTIME = "Alpara tempo",
SUREDELETETRIAL = "Ĉu vi certas, ke vi volas forigi la tempelprovon \"$1\"?",
SUREDELETEDIMENSIONNAME = "Ĉu vi certas, ke vi volas forigi la dimension \"$1\"?",
SUREDELETEDIMENSIONNONAME = "Ĉu vi certas, ke vi volas forigi ĉi tiun dimension?",

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
		[0] = "Ento ĉe [$1 $2] havas $3 malvalidan atributon!",
		[1] = "Ento ĉe [$1 $2] havas $3 malvalidajn atributojn!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata por ĉambro $1,$2 havas $3 malvalidan atributon!",
		[1] = "LevelMetadata por ĉambro $1,$2 havas $3 malvalidajn atributojn!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Montranta $1",
		[1] = "Montranta $1",
	},
	FLAGUSAGES = {
		[0] = "Uzita $1 fojon en skriptoj: $2",
		[1] = "Uzita $1 fojojn en skriptoj: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 kahelo ne estas valida entjero en la intervalo 0-1199",
		[1] = "$1 kaheloj ne estas validaj entjeroj en la intervalo 0-1199",
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
"Renversilo",
"Ĉambroteksto",
"Komputilo",
"Skriptkvadrato",
"Teleportilo",
"Teleportlinio",
"Ŝipano",
"Komencejo",

}

subtoolnames = {

[1] = {"Broso 1x1", "Broso 3x3", "Broso 5x5", "Broso 7x7", "Broso 9x9", "Plenigi horizantale", "Plenigi vertikale", "Tajlorita grando de broso", "Plenigilo", "Mirinda mojosa magia terpomo"},
[2] = {},
[3] = {"Aŭtomata", "Aŭtomata ambaŭen", "Aŭtomata maldekstren", "Aŭtomata dekstren"},
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

[0] = "Ĉambro-teleportado: Nenia",
[1] = "Ĉambro-teleportado: Horizontala",
[2] = "Ĉambro-teleportado: Vertikala",
[3] = "Ĉambro-teleportado: Ĉiuj direktoj",

}

langtilesetnames = {

short0 = "Kosmostacio",
long0 = "Kosmostacio",
short1 = "Ekstere",
long1 = "Ekstere",
short2 = "Laboratorio",
long2 = "Laboratorio",
short3 = "Teleportejo",
long3 = "Teleportejo",
short4 = "Ŝipo",
long4 = "Ŝipo",
short5 = "Turo",
long5 = "Turo",

}

ERR_VEDHASCRASHED = "Ved estas kraŝinta!"
ERR_VEDVERSION = "Versio de Ved:"
ERR_LOVEVERSION = "Versio de L{VE:"
ERR_STATE = "Stato:"
ERR_OS = "Operaciumo:"
ERR_TIMESINCESTART = "Tempo ekde starto:"
ERR_PLUGINS = "Aldonaĵoj:"
ERR_PLUGINSNOTLOADED = "(ne ŝargitaj)"
ERR_PLUGINSNONE = "(neniuj)"
ERR_PLEASETELLDAV = "Bonvolu raportu al Dav999 pri la problemo.\n\n\nDetaloj: (premu Ctrl+C/Cmd+C por kopii al la tondejo)\n\n"
ERR_INTERMEDIATE = " (intermeza versio)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (tro nova)"

ERR_PLUGINERROR = "Eraro de aldonaĵo!"
ERR_FILE = "Dosiero redaktata:"
ERR_FILEEDITORS = "Aldonaĵoj, kiuj redaktas tiun dosieron:"
ERR_CURRENTPLUGIN = "Aldonaĵo, kiu ekagigis la eraron:"
ERR_PLEASETELLAUTHOR = "Aldonaĵo devus fari redakton al kodo en Ved, sed la kodo por anstataŭigi ne troviĝis.\nEblas, ke tion kaŭzis konflikto inter du aldonaĵoj, aŭ ĝisdatigo de Ved rompis la aldonaĵon.\n\nDetaloj: (premu Ctrl+C/Cmd+C por kopii al la tondejo)\n\n"
ERR_CONTINUE = "Vi povas daŭrigi per premi ESC aŭ ENTER, sed notu ke tiu malsukcesinta redakto eble kaŭzos erarojn."
ERR_OPENPLUGINSFOLDER = "Vi povas malfermi vian aldonaĵ-dosierujon per premi F, por ripari aŭ forigi la probleman aldonaĵon. Poste, relanĉu Ved."
ERR_REPLACECODE = "Malsukceso trovi ĉi tiun en %s.lua:"
ERR_REPLACECODEPATTERN = "Malsukceso trovi ĉi tiun en %s.lua (kiel modelo):"
ERR_LINESTOTAL = "%i linioj entute"

ERR_SAVELEVEL = "Por konservi kopion de via nivelo, premu S"
ERR_SAVESUCC = "Nivelo sukcese konservita kiel %s!"
ERR_SAVEERROR = "Konserva eraro! %s"
ERR_LOGSAVED = "Pli da informo troviĝas en la kraŝo-protokolo:\n%s"


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
		Creator = "Kreinto estas ŝanĝita de \"$1\" al \"$2\"",
		website = "Retejo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc1 = "1-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc2 = "2-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		Desc3 = "3-a linio de priskribo estas ŝanĝita de \"$1\" al \"$2\"",
		mapsize = "Mapgrando estas ŝanĝita de $1x$2 al $3x$4",
		mapsizenote = "NOTU: Mapgrando estas ŝanĝita de $1x$2 al $3x$4.\\o\nĈambroj eksteraj de $5x$6 ne estas listitaj.\\o",
		levmusic = "Nivelmuziko estas ŝanĝita de $1 al $2",
	},
	rooms = {
		added1 = "Aldonis ($1,$2) ($3)\\G",
		added2 = "Aldonis ($1,$2) ($3 -> $4)\\G",
		changed1 = "Ŝanĝis ($1,$2) ($3)\\Y",
		changed2 = "Ŝanĝis ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Ĉiuj blokoj viŝitaj en ($1,$2) ($3)\\R",
		cleared2 = "Ĉiuj blokoj viŝitaj en ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Ĉambro $1,$2:",
		changed1 = "Ĉambro $1,$2 ($3):",
		roomname = "Ĉambronomo ŝanĝita de \"$1\" al \"$2\"\\Y",
		roomnameremoved = "Ĉambronomo \"$1\" viŝita\\R",
		roomnameadded = "Ĉambro nomita \"$1\"\\G",
		tileset = "Blokaro $1 kaj blokarokoloro $2 ŝanĝitaj al blokaro $3 kaj blokarokoloro $4\\Y",
		platv = "Platformrapido ŝanĝita de $1 al $2\\Y",
		enemytype = "Malamiko-tipo ŝanĝita de $1 al $2\\Y",
		platbounds = "Platformlimo ŝanĝita de $1,$2,$3,$4 al $5,$6,$7,$8\\Y",
		enemybounds = "Malamiko-limo ŝanĝita de $1,$2,$3,$4 al $5,$6,$7,$8\\Y",
		directmode01 = "Rekta reĝimo ŝaltita\\G",
		directmode10 = "Rekta reĝimo malŝaltita\\R",
		warpdir = "Teleportdirekto ŝanĝita de $1 al $2\\Y",
	},
	entities = {
		added = "Aldonis ento-tipon $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\G",
		removed = "Forigis ento-tipon $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\R",
		changed = "Ŝanĝis ento-tipon $1 ĉe pozicio $2,$3 en ĉambro ($4,$5)\\Y",
		changedtype = "Ŝanĝis ento-tipon $1 al tipo $2 ĉe pozicio $3,$4 en ĉambro ($5,$6)\\Y",
		multiple1 = "Ŝanĝis entojn ĉe pozicio $1,$2 en ĉambro ($3,$4):\\Y",
		multiple2 = "al:",
		addedmultiple = "Aldonis entojn ĉe pozicio $1,$2 en ĉambro ($3,$4):\\G",
		removedmultiple = "Forigis entojn ĉe pozicio $1,$2 en ĉambro ($3,$4):\\R",
		entity = "Tipo $1",
		incomplete = "Ne ĉiuj entoj estas traktitaj! Bonvolu raporti tion al Dav.\\r",
	},
	scripts = {
		added = "Aldonis skripton \"$1\"\\G",
		removed = "Forigis skripton \"$1\"\\R",
		edited = "Redaktis skripton \"$1\"\\Y",
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
		added = "Aldoniĝis meta-datuma ento.\\G",
		removed = "Foriĝis meta-datuma ento.\\R",
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
subj = "Reveni",
imgs = {},
cont = [[
\)
]] -- This should be left the same!
},

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
kiuj listiĝos ĉe ĝia dekstro. Por ŝanĝi la uzatan ilon, uzu la taŭgan klavaro-
komandon aŭ rulumu kun Shift aŭ Ctrl premata. Por interŝanĝi ilidojn, vi povas
rulumi ie ajn. Por pli da informoj pri la iloj, legu la helpopaĝon ¤Iloj.\nwl
Entoj povas dekstre alklakiĝi por menuo de agoj por tiu ento. Por forigi entojn
sen uzi la kuntekstan menuon, dekstre alklaku ilin dum premadi Shift.
Ĉe la dekstra flanko de la ekrano, vi trovos multajn butonojn kaj agordojn. La
supraj butonoj rilatas al la tuta nivelo, dum la malsupraj (sub Ĉambro-agordoj)
estas specifaj al la aktuala ĉambro. Por pli da informoj pri tiuj butonoj, legu
la respektivajn helpopaĝojn, kie haveblas.

Dosierujo de niveloj\h#

Ved normale uzos la saman dosierujon por konservi nivelojn kiel VVVVVV, por ke
iri de la niveloredaktilo de VVVVVV al Ved kaj male estas facile. Se Ved ne
detektas vian VVVVVV-dosierujon korekte, vi povas enigi propran dosierindikon
en la agordoj de Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Reĝimoj de kahel-metado",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
Reĝimoj de kahel-metado\wh#
\C=

Ved subtenas tri diversajn reĝimojn por meti kahelojn.

     Aŭtomata reĝimo\h#0

          Tiu ĉi estas la plej facile uzebla reĝimo. En tiu ĉi reĝimo, vi povas
          meti murojn kaj fonojn, kaj la bordoj aŭtomate metiĝos korekte. Tamen,
          dum redakti en tiu ĉi reĝimo, ĉiuj muroj kaj fonoj en la ĉambro devas
          uzi la saman kahelaron kaj koloron.

     Multkahelara reĝimo\h#1

          Tiu ĉi similas al la aŭtomata reĝimo, krom ke vi povas havi multajn
          malsamajn kahelarojn en la sama ĉambro. Tio estas, ke ŝanĝi la kahelaron
          ne influos jame metitaj muroj kaj fonoj, kaj vi povas desegni per multaj
          kahelaroj en la sama ĉambro.

     Permana reĝimo\h#2

          Ankaŭ nomita rekta reĝimo, en tiu ĉi reĝimo vi povas meti ian ajn
          kahelon permane, do vi ne estas limigita al la antaŭdifinitaj kombinoj
          de kahelaroj, kaj bordoj ne aŭtomate aldoniĝos al muroj, por doni al vi
          tutan regon super kiel aspektos la ĉambro. Tamen, tiu ĉi reĝimo de
          redaktado ofte pli malrapide uzeblas.
]]
},

{
splitid = "030_Tools",
subj = "Iloj",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
Iloj\wh#
\C=

Vi povas uzi la sekvantajn ilojn por plenigi ĉambrojn en via nivelo:

\0
   Muro\h#


Tiu ĉi ilo estas uzebla por meti murojn.

\1
   Fono\h#


Tiu ĉi ilo estas uzebla por meti fonojn.

\2
   Pikaĵo\h#


Tiu ĉi ilo estas uzebla por meti pikaĵojn. Vi povas uzi la etendan ilidon por
meti pikaĵojn sur surfacon per unu klako (aŭ deŝovo).

\3
   Kolektaĵo\h#


Tiu ĉi ilo estas uzebla por meti kolektaĵojn. Bonvole notu, ke estas limo
de dudek kolektaĵoj en nivelo.

\4
   Konservejo\h#


Tiu ĉi ilo estas uzebla por meti konservejojn.

\5
   Malaperanta platformo\h#


Tiu ĉi ilo estas uzebla por meti malaperantajn platformojn.

\6
   Transportbendo\h#


Tiu ĉi ilo estas uzebla por meti transportbendojn.

\7
   Moviĝanta platformo\h#


Tiu ĉi ilo estas uzebla por meti moviĝantajn platformojn.

\8
   Malamiko\h#


Tiu ĉi ilo estas uzebla por meti malamikojn. La formo kaj koloro de la malamiko
estas determinitaj de la agordo de la malamiko-tipo, kaj la (koloro de la)
kahelaro, respektive.

\9
   Renversilo\h#


Tiu ĉi ilo estas uzebla por meti renversilojn.

\^0
   Ĉambroteksto\h#


Tiu ĉi ilo estas uzebla por meti ĉambrotekston.

\^1
   Komputilo\h#


Tiu ĉi ilo estas uzebla por meti komputilojn. Unue metu ĝin, kaj tiam
tajpu nomon por la skripto. Por pli da informoj pri skriptado, bonvolu legi
la referencoj de skriptado.

\^2
   Skriptkvadrato\h#


Tiu ĉi ilo estas uzebla por meti skriptkvadratojn. Unue alklaku la supra-
maldekstran angulon, kaj tiam la malsupra-dekstran, kaj tiam tajpu nomon por la
skripto. Por pli da informoj pri skriptado, bonvolu legi la referencoj de
skriptado.

\^3
   Teleportilo\h#


Tiu ĉi ilo estas uzebla por meti teleportilojn. Unue alklaku, kie devus esti la
enirejo, kaj tiam alklaku, kie devus esti la elirejo.

\^4
   Teleportlinio\h#


Tiu ĉi ilo estas uzebla por meti teleportliniojn. Bonvole notu, ke ili nur
povas metiĝi sur la bordoj de ĉambro.

\^5
   Ŝipano\h#


Tiu ĉi ilo estas uzebla por meti mankantajn ŝipanojn, kiuj povas saviĝi. Se
ĉiuj ŝipanoj saviĝas, la nivelo finiĝos. Bonvole notu, ke estas limo de dudek
ŝipanoj en nivelo.

\^6
   Komencejo\h#


Tiu ĉi ilo estas uzebla por meti la komencejon.
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

Por oportuneco kaj legebleco de skriptoj, estas eble uzi flagnomojn anstataŭ
numeroj. Kiam vi uzas nomon anstataŭ numero, numero aŭtomate estos asociita kun
tiu nomo, enfone. Ankaŭ eblas elekti kiun numeron uzi por ĉiu flagnomo.

Reĝimo de interna skriptado\h#

Por uzi internan skriptadon en Ved, vi povas ebligi ĝian reĝimon en la
redaktilo, por trakti ĉiujn komandojn en tiu skripto kiel internan skriptadon.
Vidu ¤Reĝimo Int.skr¤ por pli da informoj pri la reĝimo de interna skriptado.\nwl
Por pli da informoj pri interna skriptado, legu la referencojn de interna
skriptado.

Fendado de skriptoj\h#

Eblas fendi skripton en du per la skripto-redaktilo. Post meti la tekst-
kursoron sur la unuan linion, kiun vi volas esti en la nova skripto, alklaku la
butonon Fendi kaj enigu la nomon de la nova skripto. La linioj antaŭ la kursoro
restos en la originala skripto, kaj la linioj de la kursoro pluen moviĝos al la
nova.

Saltado al skriptoj\h#

Sur linioj kun komando iftrinkets, ifflag, customiftrinkets aŭ customifflag,
eblas salti al la donita skripto per alklaki la butonon "Alsalti" kiam la
kursoro estas sur tiu linio. Vi ankaŭ povas premi ¤Alt+dekstro¤ por fari do,
kaj vi povas uzi ¤Alt+maldekstro¤ por retrosalti unu paŝon tra la ĉeno.\nw
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Reĝimo Int.skr",
imgs = {},
cont = [[
Reĝimo de interna skriptado\wh#
\C=

Por uzi internan skriptadon en Ved, vi povas ebligi ĝian reĝimon en la
redaktilo por trakti ĉiujn komandojn en tiu skripto kiel internan skriptadon.
Per tiu trajto, oni ne devas labori multe por funkciigi internan skriptadon; oni
ne devas uzi komandojn ¤say¤, kalkuli liniojn aŭ tajpi ¤text(1,0,0,4)¤ aŭ kion\nwnw
ajn estas via prefero - simple skribu internajn skriptojn kvazaŭ ili estas
destinitaj por la ĉefa ludo. Oni eĉ ne bezonas fini la skripton per komando
loadscript¤.\wn

Ved subtenas diversajn metodojn de interna skriptado. Por montri ties malsamecojn
teknikajn, ni uzos la sekvan ekzemplan skripton:

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
ekzemploj por certigi ke permane skribitaj skriptoj ne ŝanĝiĝos, kaj blokoj de ¤say¤\nw
kiuj estas tro grandaj devas esti enpecigitaj en pli malgrandajn.

Por pli da informoj pri interna skriptado, kontrolu la konsultilon de
interna skriptado.

Int.sk de ŝargskripto\h#

La metodo loadscript estas probable la plej komune uzata metodo hodiaŭ. Ĝi estas
la metodo, kiun subtenis Ved ekde alfa-versio.

Por ĝi necesas plua skripto, la ŝargskripto, por ŝargi la internan skripton.
La ŝargskripton, en ĝia plej baza formo, enhavus komandon kiel
iftrinkets(0,viaskripto)¤, sed ankaŭ vi povas havi aliajn simpligitajn komandojn\w
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
bezonas ŝargskripton. Ni povas forigi ¤cutscene()¤ kaj ¤untilbars()¤ de nia\nwnw
skripto, pro ke tiuj jam aldoniĝos de VVVVVV kiam tiu ĉi metodo uziĝas.

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

Tiu ĉi metodo estas aldonita kiel plua reĝimo de interna skriptado en Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Klavkombinoj",
imgs = {},
cont = [[
Klavkombinoj de la redaktilo\wh#
\C=

Konsilo: vi povas premadi ¤F9¤ ie ajn ene de Ved por vidi multajn el la fulmoklavoj.\nC

La plimulto da klavkombinoj uzeblaj en VVVVVV ankaŭ uzeblas en Ved.

F1¤  Ŝanĝi kahelaron\C
F2¤  Ŝanĝi koloron\C
F3¤  Ŝanĝi malamikojn\C
F4¤  Limoj de malamikoj\C
F5¤  Limoj de platformoj\C

F10¤  Permana/aŭtomata reĝimo (rekta/nerekta reĝimo)\C

W¤  Ŝanĝi teleport-direkton\C
E¤  Ŝanĝi ĉambronomon\C

L¤  Ŝargi nivelon\C
S¤  Konservi nivelon\C

Z¤  Broso 3x3 (muroj kaj fonoj)\C
X¤  Broso 5x5 (")\C

< ¤kaj¤ >¤  ŝanĝi ilon\CnC
Ctrl/Cmd+< ¤kaj¤ Ctrl/Cmd+>¤  ŝanĝi ilidon\CnC

Pli da klavkombinoj\h#

Ved ankaŭ enkondukas kelkajn klavkombinoj.

Ĉefa redaktilo\gh#

Ctrl+P¤  Salti al la ĉambro enhavanta la komencejon\C
Ctrl+S¤  Rapidkonservo\C
Ctrl+X¤  Tondi ĉambron al tondejo\C
Ctrl+C¤  Kopii ĉambron al tondejo\C
Ctrl+V¤  Alglui ĉambron de tondejo (se eble)\C
Ctrl+D¤  Kompari tiun ĉi nivelon al alia\C
Ctrl+Z¤  Malfari\C
Ctrl+Y¤  Refari\C
Ctrl+F¤  Serĉi\C
Ctrl+/¤  Nivela notbloko\C
Ctrl+F1¤  Helpo\C
(RIMARKU: En macOS, anstataŭigu Ctrl per Cmd)\C
N¤  montri ĉiujn kahelnumerojn\C
J¤  montri solidecon de kaheloj\C
;¤  display minimap tiles\C
Shift+;¤  display background\C
M¤ aŭ ¤Klavareto 5¤  Montri mapon\CnC
G¤  Salti al ĉambro (enigi koordinatojn kiel kvar ciferojn)\C
/¤  Skriptoj\C
[¤  ŝlosi Y de muso dum premadata (por fari horizontalajn strekojn pli facile)\C
]¤  ŝlosi X de muso dum premadata (por fari vertikalajn strekojn pli facile)\C
F11¤  reŝargi grafikajn dosierojn de VVVVVV\C
Tabklavo¤  (mal)ebligi viŝilon\C

Entoj\gh#

Shift+dekstra klako¤  Forigi enton\C
Alt+klako¤          Movi enton\C
Alt+Shift+klako¤    Kopii enton\C

Skripto-redaktilo\gh#

Ctrl+F¤  Trovi\C
Ctrl+G¤  Salti al linio\C
Ctrl+I¤  Baskuligi reĝimon de interna skriptado\C
Alt+dekstro¤  Salti al skripto en kondiĉa komando\C
Alt+maldesktro¤  Retrosalti unu paŝon\C

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
Referenco de simpla skriptado\wh#
\C=

La simpligita skriptlingvo de VVVVVV estas baza lingvo uzebla por skripti nivelojn
de VVVVVV.
Notu: kiam ajn io estas inter citiloj, tio devas tajpiĝi sen ili.


say¤([linioj[,koloro]] .. "]]" .. [[)\h#w

Montri dialog-skatolon. Sen argumentoj, tio ĉi faros dialog-skatolon kun unu
linio, kaj defaŭlte tio rezultos en centrigita komputila dialog-skatolo. La
argumento de koloro povas esti koloro, aŭ nomo de ŝipano.
Se vi uzas koloron kaj savebla ŝipano de tiu koloro estas en la ĉambro, la
dialog-skatolo do estos montrota super tiu ŝipano.

reply¤([linioj])\h#w

Montri dialog-skatolon de Viridian. Sen la linioj-argumento, tio ĉi faros
dialog-skatolon kun unu linio.

delay¤(n)\h#w

Prokrastas pluan agadon ĝis n kadroj. 30 kadroj estas proksimume unu sekundo.

happy¤([ŝipano])\h#w

Feliĉigas ŝipanon. Sen argumento, tio ĉi feliĉigos Viridianon. Vi ankaŭ povas
uzi "all", "everyone" aŭ "everybody" kiel argumenton por feliĉigi ĉiujn.

sad¤([ŝipano])\h#w

Malfeliĉigas ŝipanon. Sen argumento, tio ĉi malfeliĉigos Viridianon. Vi ankaŭ
povas uzi "all", "everyone" aŭ "everybody" kiel argumenton por malfeliĉigi ĉiujn.

flag¤(flago,on/off)\h#w

Ŝalti aŭ malŝalti la donitan flagon. Ekzemple, flag(4,on) ŝaltos la flagon de
numero 4. Estas 100 flagoj, numeritaj de 0 ĝis 99. Defaŭlte, ĉiuj flagoj estas
malŝaltitaj kiam vi komencas ludi nivelon.
Notu: En Ved, vi ankaŭ povas uzi flagnomojn anstataŭ la numerojn.

ifflag¤(flago,skriptnomo)\h#w

Se la donita flago estas ŜALTA, saltu al la skripto kun la nomo skriptnomo.
Se ĝi estas MALŜALTA, daŭru en la nuntempa skripto.
Ekzemplo:
ifflag(20,cutscene) - Se flago 20 estas ŜALTA, saltu al skripto "cutscene",
                      alie daŭru en la nuntempa skripto.
Notu: En Ved, vi ankaŭ povas uzi flagnomojn anstataŭ la numerojn.

iftrinkets¤(nombro,skriptnomo)\h#w

Se via kvanto da kolektaĵoj >= nombro, saltu al la skripto kun la nomo
skriptnomo. Se ĝi estas < nombro, daŭru en la nuntempa skripto.
Ekzemplo:
iftrinkets(3,enoughtrinkets) - Se vi havas 3 aŭ pli da kolektaĵoj, la skripto
"enoughtrinkets" estos plenumita, alie la nuntempa skripto daŭros.
En praktiko, estas kutime uzi 0 por nombro se vi volas ŝargi skripton en ĉiu
okazo.

iftrinketsless¤(nombro,skriptnomo)\h#w

Se via kvanto da kolektaĵoj < nombro, saltu al la skripto kun la nomo
skriptnomo. Se ĝi estas >= nombro, daŭru en la nuntempa skripto.

destroy¤(forigotaĵo)\h#w

Validaj argumentoj estas:
warptokens - Forigi ĉiujn teleportilojn de la ĉambro ĝis kiam vi reeniras la
ĉambron.
gravitylines - Forigi ĉiujn renversilojn de la ĉambro ĝis kiam vi reeniras la
ĉambron.
Ankaŭ ekzistas la opcio "platforms" por platformoj, sed tio ne funkcias korekte.

music¤(numero)\h#w

Ŝanĝi la melodion al certa melodi-numero.
Por la listo da melodi-numeroj, legu la artikolon "Lista referenco".

playremix\h#w

Ludas la remiksaĵon de Predestined Fate kiel muzikon.

flash\h#w

Blankigas kaj skuas la ekranon dum momento, ludante ekbruan sonon.

map¤(on/off)\h#w

Ŝalti aŭ malŝalti la mapon. Se vi malŝaltas ĝin, ĝi montros "NO SIGNAL" ĝis
kiam vi reŝaltas ĝin. Ĉambroj ankoraŭ malkovriĝos dum la mapo estas malŝaltita
por esti videblaj kiam ĝi estas reŝaltita.

squeak(ŝipano/on/off)\h#w

Pepigi ŝipanon, aŭ (mal)ŝalti la pep-sonon de kiam dialog-skatolo montriĝas.

speaker¤(koloro)\h#w

Ŝanĝas la koloron kaj pozicion de la sekvantaj dialog-skatoloj kreitaj per la
komando "say". Tio ĉi uzeblas anstataŭ doni duan argumenton al "say".

warpdir¤(x,y,dir)\w#h

Ŝanĝas la varpdirekton por ĉambro x,y, 1-indice, al la donita direkto. Tio povas
esti kontrolita per ifwarp, rezultante en relative potenca sistemo plua de
flagoj/variantoj.

x - Ĉambra x-koordinato, ekante de 1
y - Ĉambra y-koordinato, ekante de 1
dir - La varpdirekto. Normale 0-3, sed ellimaj valutoj ankaŭ akceptiĝas

ifwarp¤(x,y,dir,skripto)\w#h

Se la warpdir por ĉambro x,y (1-indice) estas agordita al dir, iru al (simpligita)
skripto

x - Ĉambra x-koordinato, ekante de 1
y - Ĉambra y-koordinato, ekante de 1
dir - La varpdirekto. Normale 0-3, sed ellimaj valutoj ankaŭ akceptiĝas
]]
},

{
splitid = "080_Int_script_reference",
subj = "Interna skriptado",
imgs = {},
cont = [[
Referenco de interna skriptado\wh#
\C=

Interna skriptado provizas pli da potenco al skriptantoj, sed ankaŭ estas iom pli
kompleksa ol simpligita skriptado.

Por uzi internan skriptadon en Ved, vi povas ebligi la reĝimon de interna
skriptado en la redaktilo, por trakti ĉiujn komandojn en tiu skripto kiel
internan skriptadon.

Kolorkodoj:\w
Blanka - Devus esti sekura, en plej malbona okazo VVVVVV kraŝos ĉar vi eraris.
Blua¤   - Kelkaj el ĉi tiuj ne funkcias en propraj niveloj, aliaj ne tre senc-\b
         havas en propraj niveloj, aŭ nur duone utilas ĉar ili vere estis
         dezajnitaj por la ĉefa ludo.
Oranĝa¤ - Ĉi tiuj funkcias kaj nenio malbona okazos, krom se vi donas al ili iujn\o
         specifajn argumentojn, kiuj forigos vian konservitajn datumojn.
Ruĝa¤   - Ruĝaj komandoj devus ne uziĝi en propraj niveloj ĉar ili ĉu malŝlosos\r
         iujn partojn de la ĉefa ludo (funkcio ne dezirinda por propra nivelo),
         aŭ difektos viajn konservitajn datumojn entute.


activateteleporter¤()\w#h

Se estas teleportilo en la ĉambro, ĝi ekbrilos per hazardaj koloroj kaj
tuŝi ĝin ne koruptigos konservdatumojn. Nur celas la unue aperigitan teleportilon.

activeteleporter¤()\w#h

Blankigas la teleportilon en la ĉambro, sed tuŝi ĝin ankoraŭ detruos viajn
konservdatumojn. Nur celas la unue aperigitan teleportilon.

alarmoff\w#h

Malŝaltas la sonorilon

alarmon\w#h

Ŝaltas la sonorilon

altstates¤(x)\b#h

Ŝanĝas la aranĝon de iuj ĉambroj, kiel la kolektaĵa ĉambro en la ŝipo antaŭ kaj
post la eksplodo, kaj la enirejon al la sekreta laboratorio (propraj niveloj tute
ne subtenas ĉi tion)

backgroundtext\w#h

Se vi metas tiun ĉi komandon sur la linion super speak aŭ speak_active, la ludo
ne atendos ĝis kiam vi premas ACTION post krei la dialog-skatolon. Tio ĉi uzeblas
por krei multajn dialog-skatolojn samtempe.

befadein¤()\w#h

Tuje maldissolvigas la ekranon de fadeout()

blackon¤()\w#h

Malfaras blackout()

blackout¤()\w#h

Nigrigas/frostigas la ekranon

bluecontrol\b#h

Komenci konversacion kun Victoria ĝuste kiel kiam vi renkontas ŝin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

changeai¤(ŝipano,ai1,ai2)\w#h

Povas ŝanĝi la frontan direkton de ŝipano aŭ la marŝ-agmaniero

ŝipano - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - deviga se followposition estas uzata por ai1

changecolour¤(a,b)\w#h

Ŝanĝas la koloron de ŝipano (notu: tio ĉi nur funkcias kun ŝipanoj kreitaj per la
komando createcrewman)

a - Koloro de ŝanĝota ŝipano (cyan/player/blue/red/yellow/green/purple)
b - Nova koloro

changedir¤(koloro,direkto)\w#h

Ĝuste kiel changeai(koloro,faceleft/faceright), tio ĉi ŝanĝas frontan direkton.

koloro - cyan/player/blue/red/yellow/green/purple
direkto - 0 estas maldekstren, 1 estas dekstren

changegravity¤(ŝipano)\w#h

Pliigi la grafikan numeron de la donita ŝipano per 12.

ŝipano - Koloro de la ŝipano por ŝanĝi cyan/player/blue/red/yellow/green/purple

changemood¤(koloro,animstato)\w#h

Ŝanĝas la animstaton de ŝipano (nur funkcias por ŝipanoj de createcrewman)

koloro - cyan/player/blue/red/yellow/green/purple
animstato - 0 por feliĉa, 1 por malfeliĉa

changeplayercolour¤(koloro)\w#h

Ŝanĝas la koloron de la ludanto.

koloro - cyan/player/blue/red/yellow/green/purple/teleporter

changetile¤(koloro,kahelo)\w#h

Ŝanĝas la kahelon de ŝipano (nur por ŝipanoj de createcrewman; vi povas uzi iun
ajn grafikon en sprites.png)

koloro - cyan/player/blue/red/yellow/green/purple/gray
kahelo - Kahelnumero

clearteleportscript¤()\b#h

Viŝas la teleportilan skripton agorditan per la supra komando.

companion¤(x)\b#h

Faras la specifitan ŝipanon akompananto (eble dependas de la loko sur la mapo)

createactivityzone¤(koloro)\b#h

Kreas zonon kie vi staras, kiu diras "Press ACTION to talk to (Crewmate)"

createcrewman¤(x,y,koloro,animstato,ai1,ai2)\w#h

Kreas ŝipanon (ne saveblan)

animstato - 0 por feliĉa, 1 por malfeliĉa
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - deviga se followposition estas uzata por ai1

createentity¤(x,y,n,meta1,meta2)\o#h

Kreas enton, kontrolu la listan referencon por ento-numeroj

n - La ento-numero

createlastrescued¤(x,y)\b#h

Kreas la laste savitan ŝipanon ĉe pozicio x,y (?)

createrescuedcrew¤()\b#h

Kreas ĉiujn savitajn ŝipanojn

customifflag¤(n,skripto)\w#h

Same kiel ifflag(n,skripto) en simpligita skriptado

customiftrinkets¤(n,skripto)\w#h

Same kiel iftrinkets(n,skripto) en simpligita skriptado

customiftrinketsless¤(n,skripto)\w#h

Same kiel iftrinketsless(n,skripto) en simpligita skriptado (sed memoru, ke tio
estas nefunkcia)

custommap¤(on/off)\w#h

Same kiel map() en simpligita skriptado

customposition¤(x,y)\w#h

Superskribas la x,y de la komando text kaj do agordas la pozicion de la dialog-
skatolo (por saveblaj ŝipanoj anstataŭ ŝipanoj de createcrewman).

x - center/centerx/centery, aŭ kolornomo
cyan/player/blue/red/yellow/green/purple (savebla)
y - Nur uzata se x estas kolornomo. Povas esti above/below

cutscene¤()\w#h

Aperigas striojn de rakontsekvenco.

delay¤(x)\w#h

Same kiel simpligita komando

destroy¤(x)\w#h

Same kiel simpligita komando

x- gravitylines/warptokens/platforms

do¤(n)\w#h

Komencas iteracio-blokon, kiu ripetiĝos n fojojn. Finu la blokon per la
komando loop.

endcutscene¤()\w#h

Malaperigas la striojn de rakontsekvenco.

endtext\w#h

Forigas (fordissolvigas) dialog-skatolon.

endtextfast\w#h

Tuje forigas dialog-skatolon (sen fordissolvo).

entersecretlab\r#h

Fakte malŝlosas la sekretan laboratorion por la ĉefa ludo - verŝajne nevolata
efiko por propra nivelo. Ŝaltas sekretlaboratorian reĝimon.

everybodysad¤()\w#h

Malfeliĉigas ĉiujn (nur por ŝipanoj de createcrewman kaj la ludanto)

face¤(a,b)\w#h

Frontigas ŝipanon a kontraŭ ŝipano b (nur por ŝipanoj de createcrewman)

a - cyan/player/blue/red/yellow/green/purple/gray
b - same

fadein¤()\w#h

Maldissolvigas la ekranon

fadeout¤()\w#h

Dissolvigas la ekranon al nigro

finalmode¤(x,y)\b#h

Teleportigas vin al ekster Dimension VVVVVV, (46,54) estas la inicia ĉambro de la
Fina Nivelo

flag¤(x,on/off)\w#h

Same kiel simpligita komando

flash¤(x)\w#h

Blankigas la ekranon, vi povas ŝanĝi kiom longe la ekrano restu blanka
(nur flash ne funkcios, vi devas uzi flash(5) kombine kun playef(9) kaj
shake(20) se vi volas normalan flash)

x - La kvanto da kadroj. 30 kadroj estas preskaŭ unu sekundo.

flip\w#h

Renversigas la ludanton

flipgravity¤(koloro)\w#h

Renversas la graviton de iu ŝipano (ne ĉiam funkcias kun vi mem)

koloro - cyan/player/blue/red/yellow/green/purple

flipme\w#h

Korektigi vertikalan poziciigadon de multaj dialog-skatoloj en renversita
reĝimo

foundlab\b#h

Ludas sonon 3, montras dialog-skatolon kun "Congratulations! You have found the
secret lab!" Ne uzas endtext, ankaŭ ne havas pluajn nevolatajn efikojn.

foundlab2\b#h

Montras la duan dialog-skatolon, kiun vi vidas post malkovri la sekretan
laboratorion. Ankaŭ ne uzas endtext, kaj ankaŭ ne havas pluajn nevolatajn efikojn.

foundtrinket¤(x)\w#h

Igas kolektaĵon trovita

x - Numero de la kolektaĵo

gamemode¤(x)\b#h

teleporter por montri la mapon, game por kaŝi ĝin (montras teleportilegojn de la
ĉefa ludo)

x - teleporter/game

gamestate¤(x)\o#h

Ŝanĝi la ludstaton al la specifita stato-numero

gotoposition¤(x,y[,f])\w#h

Ŝanĝi la pozicion de Viridian al x,y en tiu ĉi ĉambro, kaj f estas ĉu vi estas
renversita aŭ ne. (1 por renverso, 0 por nerenverso)

f - 1 por renversigita, 0 por ne renversigita. AVERTO: ne lasu tion neagordita,
aŭ alie vi povus molŝlosi la ludon!

gotoroom¤(x,y)\w#h

Ŝanĝi la nuntempan ĉambron al x,y, kie x kaj y ekas je 0

x - Ĉambra x-koordinato, ekante je 0
y - Ĉambra y-koordinato, ekante je 0

greencontrol\b#h

Komenci konversacion kun Verdigris ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

hascontrol¤()\w#h

Donas regpovon al la ludanto, sed ne funkcias en la mezo de skriptoj

hidecoordinates¤(x,y)\w#h

Kaŝi koordinatojn x,y sur la mapo (funkcias por la mapo de propraj niveloj)

hideplayer¤()\w#h

Malvidebligas la ludanton

hidesecretlab\w#h

Kaŝi la sekretan laboratorion sur la mapo

hideship\w#h

Kaŝi la ŝipon sur la mapo

hidetargets¤()\b#h

Kaŝi la celojn sur la mapo

hideteleporters¤()\b#h

Kaŝi la teleportilegojn sur la mapo

hidetrinkets¤()\b#h

Kaŝi la kolektaĵojn sur la mapo

ifcrewlost¤(ŝipano,skripto)\b#h

Se ŝipano estas mankanta, saltu al skripto

ifexplored¤(x,y,skripto)\w#h

Se x,y estas esplorita, saltu al (interna) skripto. x kaj y ekas je 0.

ifflag¤(n,skripto)\b#h

Same kiel customifflag, sed ŝargas internan skripton (de la ĉefa ludo)

iflast¤(ŝipano,skripto)\b#h

Se ŝipano x estis savita laste, saltu al skripto

ŝipano - Numeroj uziĝas ĉi tie: 0: Viridian, 1: Violet, 2: Vitellary, 3:
Vermilion, 4: Verdigris, 5: Victoria

ifskip¤(x)\b#h

Se vi preterpasas la rakontsekvencojn en Nulmorta Reĝimo, saltu al skripto x

iftrinkets¤(n,skripto)\b#h

Same kiel simpligita skriptado, sed ŝargas internan skripton (de la ĉefa ludo)

iftrinketsless¤(n,skripto)\b#h

Same kiel simpligita skriptado, sed ŝargas internan skripton (de la ĉefa ludo)

ifwarp¤(x,y,dir,skripto)\w#h

Se la warpdir por ĉambro x,y (1-indice) estas agordita al dir, iru al (simpligita)
skripto

x - Ĉambra x-koordinato, ekante de 1
y - Ĉambra y-koordinato, ekante de 1
dir - La varpdirekto. Normale 0-3, sed ellimaj valutoj ankaŭ akceptiĝas

jukebox¤(x)\w#h

Blankigas muzikan komputilon kaj malkolorigas ĉiujn aliajn komputilojn
(En propraj niveloj, tiu komando ŝajnas simple malkolorigi ĉiun komputilon).

leavesecretlab¤()\b#h

Malŝalti "sekretlaboratorian reĝimon"

loadscript¤(skripto)\b#h

Ŝargi internan skripton (de la ĉefa ludo). Komune uzata en propraj niveloj kiel
loadscript(stop)

loop\w#h

Metu ĉi tion ĉe la fino de iteracio-bloko komencita per 'do'.

missing¤(color)\b#h

Igas iun mankanta

moveplayer¤(x,y)\w#h

Movas la ludanton x bilderojn dekstren kaj y malsupren. Kompreneble vi ankaŭ povas
uzi minusajn nombrojn por movi tiun maldekstren/supren

musicfadein¤()\w#h

Nefinita komando. Ĝi nenion faras.

musicfadeout¤()\w#h

Dissolvigas la muzikon.

nocontrol¤()\w#h

La malo de hascontrol()

play¤(x)\w#h

Komenci ludi melodion kun interna melodi-numero.

x - Interna melodi-numero

playef¤(x,n)\w#h

Ludi sonon.

n - Fakte neuzata, kaj povas esti forlasita. En VVVVVV 1.x, tio iam regis la
deŝovon, en milisekundoj, je kio la sono ekis.

position¤(x,y)\w#h

Superskribas la x,y de la komando text kaj do agordas la pozicion de la
dialog-skatolo.

x - center/centerx/centery, aŭ kolornomo
cyan/player/blue/red/yellow/green/purple
y - Nur uzita se x estas kolornomo. Povas esti above/below

purplecontrol\b#h

Komenci konversacion kun Violet ĝuste kiel kiam vi renkontas ŝin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

redcontrol\b#h

Komenci konversacion kun Vermilion ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.

rescued¤(koloro)\b#h

Igas iun savita

resetgame\w#h

Restarigas ĉiujn kolektaĵojn, kolektitajn ŝipanojn kaj flagojn, kaj teleportas
la ludanton al la lasta konservejo.

restoreplayercolour¤()\w#h

Reŝanĝas la koloron de la ludanto al cejana

resumemusic¤()\w#h

Nefinita komando. Legas el malpravalorizita memoro, kio rezultas en kraŝo
en iuj maŝinoj kaj simple rezultas en ludi Path Complete en aliaj.

rollcredits¤()\r#h

Montras la kreditojn. Tio ĉi detruas viajn konservitajn datumojn kiam ĝi estas
finiĝinta!

setcheckpoint¤()\w#h

Agordas la konservan punkton al la nuntempa loko

shake¤(n)\w#h

Skuos la ekranon dum n kadroj. Tio ĉi ne kreas prokraston.

showcoordinates¤(x,y)\w#h

Montri koordinatojn x,y sur la mapo (funkcias por la mapo de propraj niveloj)

showplayer¤()\w#h

Videbligas la ludanton

showsecretlab\w#h

Montri la sekretan laboratorion sur la mapo

showship\w#h

Montri la ŝipon sur la mapo

showtargets¤()\b#h

Montri la celojn sur la mapo (nekonataj teleportilegoj, montrataj kiel ?-ojn)

showteleporters¤()\b#h

Montri la teleportilegojn sur la mapo (nur ŝajnas montri tiun de Space Station 1)

showtrinkets¤()\b#h

Montri la kolektaĵojn sur la mapo

speak\w#h

Montras dialog-skatolon sen forigi malnovajn. Ankaŭ paŭzigas la skripton ĝis kiam
vi premas ACTION (krom se estas backgroundtext super ĝi).

speak_active\w#h

Montras dialog-skatolon kaj forigas malnovajn. Ankaŭ paŭzigas la skripton ĝis kiam
vi premas ACTION (krom se estas backgroundtext super ĝi).

specialline¤(x)\b#h

Specialaj dialogoj, kiuj aperas en la ĉefa ludo

squeak¤(koloro)\w#h

Faras pep-sonon de ŝipano, aŭ sonon de komputilo.

koloro - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\w#h

Alterna finalmode(46,54), metas vin en la fina nivelo sen akcepti argumentojn.
Kraŝigas la ludon en Timeslip.

stopmusic¤()\w#h

Haltigas la muzikon tuje. Ekvivalenta al music(0) en simpligita skriptado.

teleportscript¤(skripto)\b#h

Iam agordis skripton, kiu plenumiĝus kiam vi uzus teleportilegon

telesave¤()\r#h

Konservas vian ludon (superskribas viajn konservitajn datumojn de la ĉefa ludo, do
ne uzu ĝin!)

text¤(koloro,x,y,linioj)\w#h

Konservi dialog-skatolon en memoro kun koloro, pozicio kaj nombro da linioj.
Kutime, la komando position estas uzita post la komando text (kaj ties tekst-
linioj), kio superskribos la koordinatojn ĉi tie donitajn, do ĉi tiuj kutime
estas lasitaj kiel 0.

koloro - cyan/player/blue/red/yellow/green/purple/gray
x - La x-pozicio de la dialog-skatolo
y - La y-pozicio de la dialog-skatolo
linioj - La kvanto da linioj

textboxactive\w#h

Forigas ĉiujn dialog-skatolojn sur la ekrano krom la laste kreita

tofloor\w#h

Se la ludanto ne jam estas sur la planko, tio ĉi renversigas rin al ĝi.

trinketbluecontrol¤()\b#h

Dialogo de Victoria, kiam ŝi donas al vi kolektaĵon en la ĉefa ludo

trinketscriptmusic\w#h

Ludas Passion for Exploring. Nenion alian faras.

trinketyellowcontrol¤()\b#h

Dialogo de Vitellary, kiam li donas al vi kolektaĵon en la ĉefa ludo

undovvvvvvman¤()\w#h

Malfaras vvvvvvman()

untilbars¤()\w#h

Atendas, ĝis cutscene/endcutscene estas finiĝinta

untilfade¤()\w#h

Atendi, ĝis fadeout/fadein estas finiĝinta

vvvvvvman¤()\w#h

Grandegigas la ludanton

walk¤(direkto,x)\w#h

Marŝigas la ludanton dum la specifita nombro da kadroj

direkto - left/right

warpdir¤(x,y,dir)\w#h

Ŝanĝas la varpdirekton por ĉambro x,y, 1-indice, al la donita direkto. Tio povas
esti kontrolita per ifwarp, rezultante en relative potenca sistemo plua de
flagoj/variantoj.

x - Ĉambra x-koordinato, ekante de 1
y - Ĉambra y-koordinato, ekante de 1
dir - La varpdirekto. Normale 0-3, sed ellimaj valutoj ankaŭ akceptiĝas

yellowcontrol\b#h

Komenci konversacion kun Vitellary ĝuste kiel kiam vi renkontas lin en la ĉefa
ludo kaj premas ENTER. Ankaŭ kreas agado-zonon poste.
]]
},

{
splitid = "090_Lists_reference",
subj = "Lista referenco",
imgs = {},
cont = [[
Lista referenco\wh#
\C=

Jen listoj de numeroj uzataj en VVVVVV, plejparte kopiitaj de forumaj afiŝoj.
Dank' al ĉiuj, kiuj faris ĉi tiujn listojn!


Tabelo\w&Z+
\&Z+
#Muziknumeroj (simpligita skriptado)\C&Z+l
#Muziknumeroj (internaj)\C&Z+l
#Son-numeroj\C&Z+l
#Entoj\C&Z+l
#Koloroj por ŝipanoj de createentity()\C&Z+l
#Moviĝtipoj por malamikoj\C&Z+l
#Ludstatoj\C&Z+l


Muziknumeroj (simpligita skriptado)\h#

0 - Silento (nul muziko)
1 - Pushing Onwards
2 - Positive Force
3 - Potential For Anything
4 - Passion For Exploring
5 - Presenting VVVVVV
6 - Predestined Fate
7 - Popular Potpourri
8 - Pipe Dream
9 - Pressure Cooker
10 - Paced Energy
11 - Piercing The Sky

Muziknumeroj (internaj)\h#

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
10 - Popular Potpourri
11 - Pipe Dream
12 - Pressure Cooker
13 - Paced Energy
14 - Piercing The Sky
15 - Predestined Fate remixed

Son-numeroj\h#

0 - Renverso al plafono
1 - Rerenverso al planko
2 - Krio
3 - Kolektaĵo kolektita
4 - Monero kolektita
5 - Konservejo tuŝita
6 - Pli rapida movsablo tuŝita
7 - Normala movsablo tuŝita
8 - Renversilo tuŝita
9 - Ekbrilo
10 - Teleporto
11 - Pepo de Viridian
12 - Pepo de Verdigris
13 - Pepo de Victoria
14 - Pepo de Vitellary
15 - Pepo de Violet
16 - Pepo de Vermilion
17 - Komputilo tuŝita
18 - Teleportilego tuŝita
19 - Sonorilo
20 - Pepo de komputilo
21 - Tempoprovaĵa ĝisnombrado "3, 2, 1"
22 - Tempoprovaĵa ĝisnombrado "GO!"
23 - VVVVVV Man rompanta murojn
24 - (Mal)kombiniĝo al/el VVVVVV Man
25 - Nova rekordo en Super Gravitron
26 - Nova trofeo en Super Gravitron
27 - Savita ŝipano (en propraj niveloj)

Entoj\h#

0 - La ludanto
1 - Malamiko
    Metadatumoj: moviĝ-tipo, moviĝ-rapido
    Pro manko de bezonataj datumoj, vi nur iam ajn ricevos purpuran malamikan
    skatolon, krom se vi estas en la polusa dimensio de VVVVVV dum fari tiun ĉi
    komandon.
2 - Moviĝanta platformo
    Metadatumoj: moviĝ-tipo, moviĝ-rapido
    Notu ke movigiloj estas realigitaj kiel moviĝantajn platformojn, vidu moviĝ-
    tipojn 8 kaj 9
3 - Malaperanta platformo
4 - 1x1 pli rapida movsablo-bloko
5 - Renversita Viridian, vi renversiĝos se vi tuŝas ĝin
6 - Stranga ruĝa brilanta aferumo, kiu rapide malaperas
7 - Same kiel supre, sed estas cejana kaj ne brilas
8 - Monero de la prototipo
    Metadatumo: Monera idento
9 - Kolektaĵo
    Metadatumo: Kolektaĵa idento
    Notu ke kolektaĵa idento ekas je 0, kaj ĉio super 19 ne konserviĝos se vi
    reŝargas la nivelon
10 - Konservejo
     Metadatumoj: Stato de konservejo (0=renversita, 1=normala)
                  Idento de konservejo (kontrolas, ĉu la konservejo aktivas aŭ ne)
11 - Horizontala renversilo
     Metadatumo: Longo en bilderoj
12 - Vertikala renversilo
     Metadatumo: Longo en bilderoj
13 - Teleportilo
     Metadatumoj: Celo en kaheloj (X-akso), celo en kaheloj (Y-akso)
14 - Teleportilego
     Metadatumo: Konserveja idento(?)
15 - Verdigris
     Metadatumo: AI-stato
16 - Vitellary (renversita)
     Metadatumo: AI-stato
17 - Victoria
     Metadatumo: AI-stato
18 - Ŝipano
     Metadatumoj: Koloro (uzante krudan kolorliston, ne la ŝipanajn kolorojn),
     animstato
19 - Vermilion
     Metadatumo: AI-stato
20 - Komputilo
     Metadatumoj: Grafiko, skript-idento(?)
21 - Same kiel supre, sed kiam tuŝita la komputilo ne briliĝas
     Metadatumoj: Grafiko, skript-idento(?)
22 - Kolektita kolektaĵo
     Metadatumo: Idento de kolektaĵo
23 - Kvadrata malamiko de Gravitron
     Metadatumo: Direkto
     Se vi enigas minusan aŭ tro altan X-koordinaton, sago montriĝas, ĝuste kiel
     la vera Gravitron
24 - Ŝipano de Interakto 1
     Metadatumoj: Kruda koloro, animstato
     Ŝajne ne afektita de hazardoj, kvankam ĝi devus
25 - Trofeo
     Metadatumoj: Identilo de defio, grafiko
     Se la defio estas plenumita, la baza grafikidento (kiun vi ekhavas se vi uzas
     grafikon=0) ŝanĝos. Nur uzu 0 aŭ 1 se vi volas predikteblajn rezultojn.
26 - La teleportilo al la sekreta laboratorio
     Notu bone ke tio ĉi nur estas bonaspektan grafikon, kaj ke vi mem devos
     skripti ĝian funkcieblon.
55 - Savebla ŝipano
     Metadatumo: Koloro de la ŝipano. Koloroj super 6 ĉiam montros *feliĉan*
     Viridian
56 - Malamiko de propra niveloj
     Metadatumoj: Moviĝ-tipo, moviĝ-rapido
     Notu bone, ke se ne estas malamikoj en la ĉambro, la malamikaj grafik-
     datumoj ne korekte aktualiĝos kaj simple montriĝos tia malamiko, kian vi
     vidis lastatempe, aŭ kvadrata malamiko.
Nedifinitaj entoj (27-50, 57+) donas cimecajn Viridianojn.

Koloroj por ŝipanoj de createentity()\h#

0: Cejana
1: Brilante ruĝa (uzita por mortado)
2: Malhele oranĝa
3: Kolektaĵ-kolora
4: Griza
5: Brilante blanka
6: Ruĝa (iomete pli malhela ol Vermilion)
7: Kalkverda
8: Brilroza
9: Brilflava
10: Brilante blanka
11: Brilcejana
12: Blua, same kiel Victoria
13: Verda, same kiel Verdigris
14: Flava, same kiel Vitellary
15: Ruĝa, same kiel Vermilion
16: Blua, same kiel Victoria
17: Plihele oranĝa
18: Griza
19: Malplihele griza
20: Roza, same kiel Violet
21: Plihele griza
22: Blanka
23: Brilante blanka
24-29: Blanka
30: Griza
31: Hele, iome purpurece griza?
32: Malhele cejana/verda
33: Malhele blua
34: Malhele verda
35: Malhele ruĝa
36: Senverve oranĝa
37: Brilante griza
38: Griza
39: Malplihele cejana/verda
40: Pli-brilante griza
41-99: Blanka
100: Malhele griza
101: Brilante blanka
102: Teleportkolora
103 kaj pluen: Blanka

Moviĝtipoj de malamikoj\h#

0 - Resaltadas supren kaj malsupren, ekas malsupren.
1 - Resaltadas supren kaj malsupren, ekas supren.
2 - Resaltadas maldekstren kaj dekstren, ekas maldekstren.
3 - Resaltadas maldekstren kaj dekstren, ekas dekstren.
4, 7, 11 - Moviĝas dekstren ĝis kolizio.
5 - Same kiel supre, sed ĝi agas strange kiam ĝi kolizias.
    GIF ĉi tie: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Resaltadas supren kaj malsupren, sed nur atingas certan y-pozicion antaŭ ol
    reiri malsupren. Uzita en "Trench Warfare".
8, 9 - Movigiloj (por moviĝantaj platformoj)
       Ne moviĝas (por ĉio alia)
14 - Blokebla de malaperantaj platformoj
15 - Ne moviĝas (?)
10, 12 - Multobligas dekstren en la sama loko, kraŝigas VVVVVV se tro intensiĝas,
         difektos vian nivelon se vi konservas ĝin
13 - Kiel 4, sed moviĝas malsupren ĝis kolizio.
16 - Aperas kaj malaperas
17 - Treme iras maldekstren
18 - Treme iras dekstren, iom pli rapide
19+ - Ne moviĝas (?)

Ludstatoj\h#

0 - Eliĝi de plej multe da ludstatoj
1 - Agordi ludstaton al 0 (t.e. same kiel supre en praktiko)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Plenumas la skripton "returntohub" (t.e. fadeout, teleportiĝi al ĝuste
    antaŭ La Turo, fadein, ludi Passion for Exploring)
7 - Forigas dialog-skatolojn
8 - "Press enter to view map and quicksave"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Provas aliri flipmode-
     kontrolon por skribi "the ceiling" aŭ "the floor", kaj kontroli ŝipanon, sed
     ĉar ĉi tio malsukcesas, la supra montriĝas anstataŭe)
12 - "You can't continue to the next room until he is safely accross."
13 - Forigas dialog-skatolojn rapide
14 - "When you're standing on the floor," (same aplikiĝas ĉi tie kiel 11)
15 - Feliĉigas Viridian
16 - Malfeliĉigas Viridian
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - Se flago 1 estas 0, agordu ĝin al 1 kaj forigi dialog-skatolojn
21 - Se flago 2 estas 0, agordu ĝin al 1 kaj forigi dialog-skatolojn
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - Sekvenco: "Violet, is that you?" (se flago 6 estas 0)
32 - Se flago 7 estas 0: "A teleporter!" "I can get back to the ship with this!"
33 - Se flago 9 estas 0: Victoria-sekvenco
34 - Se flago 10 estas 0: Vitellary-sekvenco
35 - Se flago 11 estas 0: Verdigris-sekvenco
36 - Se flago 8 estas 0: Vermilion-sekvenco
37 - Vitellary post Gravitron
38 - Vermilion post Gravitron
39 - Verdigris post Gravitron
40 - Victoria post Gravitron
41 - Se flago 60 estas 0: plenumi komencon de sekvenco de Interakto 1
42 - Se flago 62 estas 0: plenumi trian sekvencon de Interakto 1
43 - Se flago 63 estas 0: plenumi kvaran sekvencon de Interakto 1
44 - Se flago 64 estas 0: plenumi kvinan sekvencon de Interakto 1
45 - Se flago 65 estas 0: plenumi sesan sekvencon de Interakto 1
46 - Se flago 66 estas 0: plenumi sepan sekvencon de Interakto 1
47 - Se flago 69 estas 0: Kolektaĵsekvenco: "Ohh! I wonder what that is?"
48 - Se flago 70 estas 0: "This seems like a good place to store anything I find
     out there..." (Victoria ne jam trovita)
49 - Se flago 71 estas 0: Ludi Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
Kun ludstatoj 50-56, vi povas elekti kie komenci, ĉar ĉio aperos post unu la alia
80 - Se, kaj nur se la ekrano nigras, daŭri al stato 81 (mia supozo estas, ke tio
     ĉi estas vokita kiam ESC premiĝas, antaŭ ol la paŭzmenuo malfermiĝas)
81 - Reiri al la ĉefmenuo
82 - Rezultoj de tempoprovo (cimeca)
83 - Se ekrano nigras, daŭri al stato 84
84 - Rezultoj de tempoprovo (pli cimeca ol 82)
85 - La tempoprova versio de ludstato 200 (brubrili, ludi Positive Force, ŝalti
     reĝimon finalstretch)
Statoj 90-95 rilatas al tempoprovoj, sed ne funkcias korekte en propraj niveloj.
     La nuraj veraj efikoj, kiuj okazas en propraj niveloj estas teleporto, kaj
     ŝanĝo de muziko
90 - Kosmostacio 1
91 - La laboratorio
92 - Teleportzono
93 - La turo
94 - Kosmostacio 2
95 - Fina niveloj
96 - Se ekrano nigras, daŭri al stato 97
97 - Eliri de Super Gravitron (teleportiĝi kaj ludi Pipe Dream)
100 - Se flago 4 estas 0: daŭri al stato 101
101 - Se vi estas renversita, rerenversiĝi al planko, daŭri al stato 102
      La sekvantaj statoj (102-112) provas iri al la aktuala stato + 1, kiel en
      50-56 (sed ne reiteracias) sed eble missignalos pro ke duono da la statoj
      (103, 105, 107, 109, 111) ne ekzistas.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Forigas dialog-skatolojn
115 - Esence nenio, daŭri al stato 116
116 - Ruĝa dialog-skatolo ĉe la malsupro de la ekrano diranta "Sorry Eurogamers!
      Teleporting around the map doesn't work in this version!", daŭri al stato
      117, kiu ne ekzistas, do aferoj eble malsukcesos
118 - Forigas dialog-skatolojn
Statoj 120-128 funkcias iome kiel 102-112, t.e. en serio, sed kun malpli da
      rompitaj aferoj
120 - Se flago 5 estas 0: daŭri al stato 121
121 - Se vi estas sur la planko, renversiĝi.
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Forigas dialog-skatolojn
200 - Fina reĝimon
1000 - Ŝaltas sekvencostriojn, haltigas la ludon, daŭri al stato 1001
1001 - "You got a shiny trinket!" (sed vi ne fakte akiris kolektaĵon, tio ĉi nur
       vokiĝas ĉiun fojon, kiam vi akiras unu), daŭri al stato 1003
1003 - Malhaltigi ludon
1010 - "You found a crewmate!" samamaniere kiel por kolektaĵoj
1013 - End level with stars
2000 - Konservi la ludon
2500-2509 - Teleportiĝi al iu stranga neekzistana loko, supozeble al la
            laboratorio, mi supozas, daŭri al stato 2510
2510 - Viridian: "Hello?", daŭri al stato 2512
2512 - Viridian: "Is anybody there?", daŭri al stato 2514
2514 - Forigi dialog-skatolojn, ludi Potential for Anything
Statoj 3000-3099:
3000-3005: "Level Complete! You've rescued..." kaj la ŝipano aplikita al
           companion(), defaŭlte Verdigris. 6=Verdigris, 7=Vitellary,
           8=Victoria, 9=Vermilion, 10=Viridian (jes, vere), 11=Violet
           (Ludstatoj: 3006-3011=Verdigris, 3020-3026=Vitellary, 3040-
           3046=Victoria, 3060-3066=Vermilion, 3080-3086=Viridian, 3050-
           3056=Violet)
3070-3072 - Plenumi postsavajn aferojn, kutime reveni al ŝipo
3501 - Game Complete (ludo venkita)
4010 - Brubrilo + teleporto
4070 - La fina nivelo, sed la ludo kraŝos kiam vi atingas Timeslip (pro kiel la
       ludo atingas ento-informojn, kio estas rompita en propraj niveloj)
4080 - Ŝipestro teleportita reen al la ŝipo: "Hello!" [C[C[C[C[Captain!],
       sekvenco kaj kreditoj.
       La supra difektos viajn konservitajn datumojn, do ne uzu krom se vi
       havas restaŭrkopion!
4090 - Sekvenco post venki la unuan kosmostacion
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
aliaj aferoj. Por aldoni aranĝadon al linio, aldoni deklivon (\) ĉe la fino de ĝi.\
Post la \, vi povas aldoni ajnan kvanton da la sekvaj signoj, en ajna ordo:\

h - Duobla tipargrando\h

# - Ankro. Vi povas salti al ankroj rapide per ¤#Ligiloj¤ligiloj¤.\nLCl
- - Horizontala streko:
\-
= - Horizontala streko sub granda tekston

Tekstkoloroj:\h#

n - Normala\n
r - Ruĝa\r
g - Griza\g
w - Blanka\w
b - Blua\b
o - Oranĝa\o
v - Verda\v
c - Cejana\c
y - Flava\y
p - Purpura\p
V - Malhelverda\V
z - Nigra¤ (fonkoloro ne estas inkluzivita)\z&Z
Z - Malhelgriza\Z
C - Cejana (Viridian)\C
P - Roza (Violet)\P
Y - Flava (Vitellary)\Y
R - Ruĝa (Vermilion)\R
G - Verda (Verdigris)\G
B - Blua (Victoria)\B


Ekzemplo:\h#

\-
Granda oranĝa teksto ("oh" havas\ho\

saman rezulton)\ho\

Granda oranĝa teksto ("oh" havas\ho

saman rezulton)\ho

\-
Substrekita granda teksto\wh\
\r=\

Substrekita granda teksto\wh
\r=
\-

Uzi multajn kolorojn sur linio\h#

Eblas uzi multajn kolorojn sur linio per dividi koloritajn partojn per la
signo¤ ¤¤ ¤(kiun vi povas tajpi uzante la klavon ¤insert/enigi¤), kaj meti la\nYnw
kolorkodojn en ordon post¤ \¤. Se la lasta koloro sur la linio estas la defaŭlta\nC
koloro (n), ne necesas listi tion ĉefine. Se vi volas uzi la signon¤ ¤¤ ¤sur\nY
linio, kiu uzas¤ \¤, skribi¤ ¤¤¤¤ ¤anstataŭe. Pro teknikaj kaŭzoj, ne eb¤l§¤as\nCnYnR(
kolorigi unu signon sole per meti ĝin inter du¤ ¤¤§¤oj, krom se vi ankaŭ inkluzivas\nY
spaceton aŭ alian signon.

\-
Vi povas ¤¤kolorigi¤¤ certajn ¤¤vortojn¤¤ per ĉi tio!\nrnv\

Vi povas ¤kolorigi¤ certajn ¤vortojn¤ per ĉi tio!\nrnv
\-
Kelkaj ¤¤te¤¤ks¤¤ta¤¤j ¤¤ko¤¤lo¤¤ro¤¤j\RYGCBPRYG\

Kelkaj ¤te¤ks¤ta¤j ¤ko¤lo¤ro¤j\RYGCBPRYG
\-

Kolorigi unu signon sole\h#

Okej, mi mensogis, ja eblas kolorigi unu signon sole sen inkluzivi spaceton.
Por fari do, meti la signon¤ § ¤(tajpebla per uzi ¤Shift+Insert¤), post\nYnw
la signo, kiun vi volas kolorigi, kaj ebligi ĝin per la aranĝokodo¤ ( ¤post¤ \¤:\nCnC

\-
Vi povas k¤¤o§¤¤lorigi unu signon ¤¤sole¤¤ ĉi tiel!\nrny(\

Vi povas k¤o§¤lorigi unu signon ¤sole¤ ĉi tiel!\nrny(
\-

Tio ĉi ne necesas se la sola signo estas la unua aŭ lasta sur linio.

Fonkoloroj\h#

Teksto ne nur povas esti kolorigita, ĝi ankaŭ povas esti ¤markita¤ en ajnaj de la\nZ&y
tekstkoloroj. Por fari do, vi povas meti¤ & ¤post la regulara teksta kolorkodo, kaj\nY
tiam kolorkodo por la fonkoloro. Tio ĉi fareblas en kombino kun la sistemo
ĉi-supre priskribita; notu, ke kutimaj tekstkoloroj komencas la sekvan "blokon",
sed fonkoloroj ne faras do. La jenaj ekzemploj uzas spacetojn por fari ĉion pli
legeblan, sed tio estas tute malnepra. Vi povas uzi la kodon¤ + ¤por etendi la\nY
(lastan) fonkoloron al la fino de la linio.

\-
Nigra teksto sur blanka fono!\z&w\

Nigra teksto sur blanka fono!\z&w
\-
Nigra teksto sur etendita blanka fono!\z&w+\

Nigra teksto sur etendita blanka fono!\z&w+
\-
Ruĝa sur flavo¤¤, ¤¤Nigra sur blanko¤¤ (nenepre spacetoj pli legebligas)\r&y n z&w\

Ruĝa sur flavo¤, ¤Nigra sur blanko¤ (nenepre spacetoj pli legebligas)\r&y n z&w
\-
Tio ĉi ankoraŭ ¤¤funkcias¤¤ por kolorigi unu si¤¤g§¤¤non sole\n P n n&r (\

Tio ĉi ankoraŭ ¤funkcias¤ por kolorigi unu si¤g§¤non sole\n P n n&r (
\-

Se vi volas, vi ankaŭ povas krei grafikojn pere de fonkoloroj:

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

Ligiloj povas uziĝi por du aferoj: ligi al ie alia en la artikoloj/notoj,
aŭ ligi al retejoj. Ligiloj uzas la duon-kolorkodon¤ l¤. Tiu ĉi kodo ne\nY
ŝanĝas al la sekva "kolorbloko", ĝi nur aplikiĝas al la aktuala, kontraŭe
al kutimaj (nefonaj) kolorkodoj. Ĝi ankaŭ ne ŝanĝas la koloron, do vi povas
ŝanĝi la stilon de la ligilo kiel ajn vi deziras.

Vi povas ligi al artikoloj per simple uzi la nomon de la artikolo:

\-
Iloj\bl\

Iloj\bl
\-

Alklaki la ligilon "Iloj" ĉi-supre prenos vin al la helpoartikolo "Iloj". Mi
uzis la kolorkodon¤ b ¤ĉi tie por bluigi la ligilon, kaj kiel vi povas vidi,\nb
la¤ l ¤aplikiĝas al tiu sama kolorigita parto.\nY

Vi povas ligi al ankroj en la sama artikolo per ligi al¤ # ¤sekvata de ĉiu teksto\nY
sur tiu linio. (Aperoj de¤ ¤¤ ¤tute ignoriĝas tie.) Vi povas ligi al la supraĵo de la\nY
artikolo per nur krado (¤#§¤).\nY(

\-
#Uzi multajn kolorojn sur linio\bl\

#Uzi multajn kolorojn sur linio\bl
\-

Vi povas ligi al ankro en malsama artikolo en simila maniero:

\-
Lista referenco#Ludstatoj\bl\

Lista referenco#Ludstatoj\bl
\-

Ligi al retejo ankaŭ estas rekte facila:

\-
https://example.com/\bl\

https://example.com/\bl
\-

Vi povas uzi kolorblokon kun kolorkodo¤ L ¤kiu enhavas la veran celolokon\nY
antaŭ la ligilo-teksto, kaj igi la ligilon montri malsaman tekston tiel:

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

Bildoj (nur haveblaj en aldonaĵaj\h#

priskriboj):\h

0..9 - montri bildon 0..9 sur ĉi tiu linio (tabelindekso en la imgs-tabelo
       ekas je 0, kaj memoru blankigi liniojn por akomodi la bildan alton)
^ - Metu ĉi tion antaŭ la bildnumero, ŝovi bildnumeron je 10. Do ^4 faras
    bildon 14, ^^4 faras bildon 24. Kaj 3^1^56 faras bildojn 3, 11, 25 kaj
    26.
_ - Metu ĉi tion antaŭ la bildnumero por malpliigi la bildnumeron je 10.
> - Metu ĉi tion antaŭ la bildnumero por ŝovi pluajn bildojn dekstren je
    8 bilderoj. Tio ĉi ripeteblas, do 0>>>>1 metas bildon 0 ĉe x=0 kaj
    bildon 1 ĉe x=32.
< - Same, sed ŝovas maldekstren.
]]
},

{
splitid = "990_Credits",
subj = "Kreditoj",
imgs = {"credits.png"},
cont = [[
\0















Kreditoj\wh#
\C=

Ved estas farita de Dav999

Pluaj kod-kontribuantoj: Info Teddy

Kelkaj grafikoj kaj la tiparo estas faritaj de Hejmstel

Ruslingva traduko: CreepiX, Cheep
Esperanta traduko: Stelpjo
Germanlingva traduko: r00ster
Franclingva traduko: RhenaudTheLukark
Hispanlingva traduko: Valso22/naether


Special-dank' al:\h#


Terry Cavanagh pro lia faro de VVVVVV

Ĉiuj, kiuj raportis erarojn, elpensis ideojn kaj kuraĝigis min fari ĉi tion!
\
\




Permesilo\h#
\
Copyright 2015-2020  Dav999
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

Ved includes some graphics assets from VVVVVV. VVVVVV and its assets are copyright
of Terry Cavanagh. For more information about the license that applies to VVVVVV
and its assets, see ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ and ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md¤ in ¤https://github.com/TerryCavanagh/VVVVVV¤VVVVVV's GitHub\nLClnLClnLCl
https://github.com/TerryCavanagh/VVVVVV¤repository¤.\LCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}