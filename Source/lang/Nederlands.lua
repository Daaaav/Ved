-- Dutch language file for Ved
-- 1.2.2

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)"

OUTDATEDLOVE = "Deze versie van L{ve is verouderd. De minimale versie is 0.9.0. Je kan de laatste versie van L{ve downloaden op https://love2d.org/.",
UNKNOWNSTATE = "Onbekende staat ($1), naar veranderd vanaf $2",
FATALERROR = "FATALE FOUT: ",
FATALEND = "Sluit het spel en probeer het opnieuw. En als je Dav bent, los het alsjeblieft op.",

OSNOTRECOGNIZED = "Je besturingssysteem ($1) wordt niet herkend! Valt terug op standaard-bestandssysteemfuncties; levels worden opgeslagen in:\n\n$2",
MAXTRINKETS = "Het maximum aantal trinkets (20) is bereikt in dit level.",
MAXTRINKETS_BYPASS = "Het maximum aantal trinkets (20) is bereikt in dit level.\n\nHet toevoegen van meer zal problemen veroorzaken bĳ het laden van het level in VVVVVV, en het wordt niet aangeraden om dit te doen. Weet je zeker dat je het limiet wilt overschĳden?",
MAXCREWMATES = "Het maximum aantal bemanningsleden (20) is bereikt in dit level.",
MAXCREWMATES_BYPASS = "Het maximum aantal bemanningsleden (20) is bereikt in dit level.\n\nHet toevoegen van meer zal problemen veroorzaken bĳ het laden van het level in VVVVVV, en het wordt niet aangeraden om dit te doen. Weet je zeker dat je het limiet wilt overschĳden?",
EDITINGROOMTEXTNIL = "Bestaande tekst die bewerkt werd is nil!",
STARTPOINTNOLONGERFOUND = "Het oude startpunt kan niet meer worden gevonden!",
UNSUPPORTEDTOOL = "Niet-ondersteund gereedschap! Gereedschap: ",
SURENEWLEVEL = "Weet je zeker dat je een nieuw level wilt maken? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
SURELOADLEVEL = "Weet je zeker dat je een level wilt laden? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
COULDNOTGETCONTENTSLEVELFOLDER = "Kon niet de inhoud van de levels-map verkrĳgen. Controleer of $1 bestaat en probeer het opnieuw.",
MAPSAVEDAS = "Kaart opgeslagen als $1 in de map $2!",
RAWENTITYPROPERTIES = "Je kunt de eigenschappen van deze entiteit hier wĳzigen.",
UNKNOWNENTITYTYPE = "Onbekend entiteitstype $1",
METADATAENTITYCREATENOW = "De metadata-entiteit bestaat nog niet. Nu aanmaken?\n\nDe metadata-entiteit is een verborgen entiteit die kan worden toegevoegd aan VVVVVV-levels om extra data op te slaan die door Ved gebruikt wordt, zoals het level-kladblok, namen van vlaggen, en andere dingen.",
WARPTOKENENT404 = "Warptoken-entiteit bestaat niet meer!",
SPLITFAILED = "Splitsen is miserabel mislukt! Zĳn er te veel regels tussen een text-commando en een speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Er zĳn geen vlaggen meer beschikbaar, dus één of meer vlagnamen in dit script kunnen niet geassocieerd worden met een vlagnummer. Dit script in VVVVVV proberen uit te voeren kan fout gaan. Overweeg om alle verwĳzingen te wissen naar vlaggen die je niet meer nodig hebt en probeer het opnieuw.\n\nDe editor verlaten?",
LEVELOPENFAIL = "Kon $1.vvvvvv niet openen.",
SIZELIMITSURE = "De maximale grootte van een level is 20 bĳ 20.\n\nDit limiet overschrĳden zal problemen veroorzaken bĳ het laden van het level in VVVVVV, en het wordt niet aangeraden om dit te doen. Weet je zeker dat je het limiet wilt overschĳden?",
SIZELIMIT = "De maximale grootte van een level is 20 bĳ 20.\n\nDe levelgrootte zal worden aangepast naar $1 bĳ $2.",
SCRIPTALREADYEXISTS = "Script \"$1\" bestaat al!",
FLAGNAMENUMBERS = "Namen van vlaggen kunnen niet alleen uit nummers bestaan.",
FLAGNAMECHARS = "Namen van vlaggen kunnen geen (, ), , of spaties bevatten.",
FLAGNAMEINUSE = "De vlagnaam $1 wordt al gebruikt door vlag $2",
DIFFSELECT = "Selecteer level om mee te vergelĳken. Het level dat je nu kiest zal worden gezien als een oudere versie.",
SUREQUIT = "Weet je zeker dat je wilt afsluiten? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
SCALEREBOOT = "De nieuwe schaal-instellingen zullen van toepassing worden na het herstarten van Ved.",
NAMEFORFLAG = "Naam voor vlag $1:",
SCRIPT404 = "Script \"$1\" bestaat niet!",
ENTITY404 = "Entiteit #$1 bestaat niet meer!",
GRAPHICSCARDCANVAS = "Sorry, het lĳkt dat je grafische kaart deze functie niet ondersteunt!",
SUREDELETESCRIPT = "Weet je zeker dat je het script \"$1\" wilt verwĳderen?",
SUREDELETENOTE = "Weet je zeker dat je deze notitie wilt verwĳderen?",
THREADERROR = "Thread-fout!",
NUMUNSUPPORTEDPLUGINS = "Je hebt $1 plugins die niet worden ondersteund in deze versie.",
WHATDIDYOUDO = "Wat heb je gedaan?!",
UNDOFAULTY = "Waar ben je mee bezig?",
SOURCEDESTROOMSSAME = "Beide kamers zĳn hetzelfde!",
UNKNOWNUNDOTYPE = "Onbekend ongedaan-maak-type \"$1\"!",
MDEVERSIONWARNING = "Dit level lĳkt in een nieuwere versie van Ved te zĳn gemaakt, en kan data bevatten die verloren zal gaan als je dit level opslaat.",
LEVELFAILEDCHECKS = "Bĳ $1 test(s) zĳn problemen geconstateerd bĳ dit level. De problemen kunnen al automatisch zĳn opgelost, maar het is nog steeds mogelĳk dat dit crashes of inconsistenties zal veroorzaken.",
FORGOTPATH = "Je bent vergeten een pad op te geven!",
MDENOTPASSED = "Let op: metadata-entiteit niet meegegeven aan savelevel()!",
RESTARTVEDLANG = "Na het veranderen van de taal moet Ved opnieuw opgestart worden voordat de wĳziging van toepassing wordt.",

SELECTCOPY1 = "Selecteer de kamer om te kopiëren",
SELECTCOPY2 = "Selecteer de plek om deze kamer naartoe te kopiëren",
SELECTSWAP1 = "Selecteer de eerste kamer om om te wisselen",
SELECTSWAP2 = "Selecteer de tweede kamer om om te wisselen",

TILESETCHANGEDTO = "Tileset veranderd naar $1",
TILESETCOLORCHANGEDTO = "Tileset-kleur veranderd naar $1",
ENEMYTYPECHANGED = "Vĳand-type veranderd",

CHANGEDTOMODE = "Veranderd naar $1plaatsing", -- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODEAUTO = "automatische ",
CHANGEDTOMODEMANUAL = "handmatige ",
CHANGEDTOMODEMULTI = "multi-tileset-",

BUSYSAVING = "Bezig met opslaan...",
SAVEDLEVELAS = "Level opgeslagen als $1.vvvvvv",

ROOMCUT = "Kamer geknipt naar klembord",
ROOMCOPIED = "Kamer gekopieerd naar klembord",
ROOMPASTED = "Kamer geplakt",

BOUNDSTOPLEFT = "Klik op de linkerbovenhoek",
BOUNDSBOTTOMRIGHT = "Klik op de rechteronderhoek",

TILE = "Blok $1",
HIDEALL = "Verberg alle",
SHOWALL = "  Toon alle ",
SCRIPTEDITOR = "Scriptbewerker",
FILE = "Bestand",
NEW = "Nieuw",
OPEN = "Open",
SAVE = "Opslaan",
UNDO = "Maak ongedaan",
REDO = "Herhaal",
COMPARE = "Vergelĳk",
STATS = "Statistieken",
SCRIPTUSAGES = "Gebruik",
EDITTAB = "Bewerken",
COPYSCRIPT = "Kopieer script",
SEARCHSCRIPT = "Zoek",
GOTOLINE = "Ga naar regel",
GOTOLINE2 = "Ga naar regel:",
INTERNALON = "Int.sc is uit",
INTERNALOFF = "Int.sc is aan",
VIEW = "Beeld",
SYNTAXHLOFF = "Kleuren: aan",
SYNTAXHLON = "Kleuren: uit",
TEXTSIZEN = "Grootte: norm.",
TEXTSIZEL = "Grootte: groot",
INSERT = "Invoegen",
HELP = "Help",
INTSCRWARNING_NOLOADSCRIPT = "Laad-script nodig!",
INTSCRWARNING_BOXED = "Rechtstreekse scriptvak-/ terminal- verwĳzing!\n\n", -- deliberate linebreak spaces
COLUMN = "Kolom: ",

BTN_OK = "OK",
BTN_CANCEL = "Annuleer",
BTN_YES = "Ja",
BTN_NO = "Nee",
BTN_APPLY = "Toepassen",
BTN_QUIT = "Sluit",

COMPARINGTHESE = "Vergelĳkt $1.vvvvvv met $2.vvvvvv",
COMPARINGTHESENEW = "Vergelĳkt (niet-opgeslagen level) met $1.vvvvvv",

RETURN = "Terug",
CREATE = "Aanmaken",
GOTO = "Ga naar",
DELETE = "Verwĳder",
RENAME = "Hernoem",
CHANGEDIRECTION = "Wĳzig richting",
DIRECTION = "Richting->",
UP = "omhoog",
DOWN = "omlaag",
LEFT = "links",
RIGHT = "rechts",
TESTFROMHERE = "Test vanaf hier",
FLIP = "Omdraaien",
CYCLETYPE = "Wĳzig type",
GOTODESTINATION = "Ga naar bestemming",
GOTOENTRANCE = "Ga naar ingang",
CHANGECOLOR = "Wĳzig kleur",
EDITTEXT = "Wĳzig tekst",
COPYTEXT = "Kopieer tekst",
EDITSCRIPT = "Wĳzig script",
OTHERSCRIPT = "Verander scriptnaam",
PROPERTIES = "Eigenschappen",
CHANGETOHOR = "Verander naar horizontaal",
CHANGETOVER = "Verander naar verticaal",
RESIZE = "Opnieuw plaatsen",
CHANGEENTRANCE = "Verplaats ingang",
CHANGEEXIT = "Verplaats uitgang",
BUG = "[Bug!]",

VEDOPTIONS = "Ved-opties",
LEVELOPTIONS = "Level-opties",
MAP = "Kaart",
SCRIPTS = "Scripts",
SEARCH = "Zoeken",
SENDFEEDBACK = "Stuur feedback",
LEVELNOTEPAD = "Level-kladblok",
PLUGINS = "Plugins",

BACKB = "Terug <<",
MOREB = "Meer >>",
AUTOMODE = "Modus: auto",
AUTO2MODE = "Modus: multi",
MANUALMODE = "Modus: handm.",
PLATFORMSPEED = "Platf-snhd.: $1",
ENEMYTYPE = "Vĳand-type: $1",
PLATFORMBOUNDS = "Platf-grenzen",
WARPDIR = "Warprichting:$1",
ENEMYBOUNDS = "Vĳand-grenzen",
ROOMNAME = "Kamernaam",
ROOMOPTIONS = "Kamer-opties",
ROTATE180 = "Roteer 180grd",
HIDEBOUNDS = "Verb. grenzen",
SHOWBOUNDS = "Toon grenzen",

ROOMPLATFORMS = "Kamer-platforms", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Kamer-vĳanden",

OPTNAME = "Naam",
OPTBY = "Door",
OPTWEBSITE = "Website",
OPTDESC = "Beschr.", -- If necessary, you can span multiple lines by using \n
OPTSIZE = "Grootte",
OPTMUSIC = "Muziek",
CAPNONE = "GEEN",
ENTERLONGOPTNAME = "Levelnaam:",

SOLID = "Vast",
NOTSOLID = "Niet vast",

TSCOLOR = "Kleur $1",

ONETRINKETS = "T:",
ONECREWMATES = "B:",
ONEENTITIES = "E:",

LEVELSLIST = "Levels",
LOADTHISLEVEL = "Laad dit level: ",
ENTERNAMESAVE = "Naam om mee op te slaan: ",
SEARCHFOR = "Zoek naar: ",

VERSIONERROR = "Kon versie niet controleren.",
VERSIONUPTODATE = "Je versie van Ved is up-to-date.",
VERSIONOLD = "Update beschikbaar! Laatste versie: $1",
VERSIONCHECKING = "Controleren op updates...",
VERSIONDISABLED = "Update-controle uitgeschakeld",

SAVESUCCESS = "Succesvol opgeslagen!",
SAVENOSUCCESS = "Opslaan niet succesvol! Fout: ",

EDIT = "Bewerk",
EDITWOBUMPING = "Bewerk zonder te bumpen",
COPYNAME = "Kopieer naam",
COPYCONTENTS = "Kopieer inhoud",
DUPLICATE = "Dupliceer",

NEWSCRIPTNAME = "Naam:",
CREATENEWSCRIPT = "Maak nieuw script",

NEWNOTENAME = "Naam:",
CREATENEWNOTE = "Maak nieuwe notitie",

ADDNEWBTN = "[Maak nieuw]",
IMAGEERROR = "[AFBEELDINGSFOUT]",

NEWNAME = "Nieuwe naam:",
RENAMENOTE = "Hernoem notitie",
RENAMESCRIPT = "Hernoem script",

LINE = "regel ",

SAVEMAP = "Sla kaart op",
SAVEFULLSIZEMAP = "Sla grote kaart op",
COPYROOMS = "Kopieer kamer",
SWAPROOMS = "Wissel kamers",

FLAGS = "Vlaggen",
ROOM = "kamer",
CONTENTFILLER = "Inhoud",

   FLAGUSED = "Gebruikt     ",
FLAGNOTUSED = "Niet gebruikt",
FLAGNONAME = "Geen naam",
USEDOUTOFRANGEFLAGS = "Gebruikte vlaggen buiten bereik:",

CUSTOMVVVVVVDIRECTORY = "VVVVVV-map",
CUSTOMVVVVVVDIRECTORYEXPL = "Voer hier het volledige pad naar je VVVVVV-map in, als het niet \"$1\" is (laat het anders leeg). Neem niet de map \"levels\" hierin op, en ook niet een schuine streep.", -- "een schuine streep naar links is ook een schuine streep" - Dav 2016
LANGUAGE = "Taal",
DIALOGANIMATIONS = "Dialoogvenster-animaties",
ALLOWLIMITBYPASS = "Sta limietbreuk toe",
FLIPSUBTOOLSCROLL = "Keer scrollrichting voor subtools om",
ADJACENTROOMLINES = "Indicaties van blokken in naastgelegen kamers",
ASKBEFOREQUIT = "Vraag voor afsluiten",
COORDS0 = "Laat coördinaten beginnen bĳ 0 (zoals in interne scripting)",
ALLOWDEBUG = "Schakel debugmodus in",
SHOWFPS = "Toon FPS-teller",
IIXSCALE = "2x schaal",
CHECKFORUPDATES = "Controleer op updates",
PAUSEDRAWUNFOCUSED = "Niet tekenen als het venster inactief is",
ENABLEOVERWRITEBACKUPS = "Reservekopie maken van levelbestanden die worden overschreven",
AMOUNTOVERWRITEBACKUPS = "Aantal reservekopieën om te bewaren per level",
SCALE = "Schaal",

SCRIPTUSAGESROOMS = "$1 keer gebruikt in kamers: $2",
SCRIPTUSAGESSCRIPTS = "$1 keer gebruikt in scripts: $2",

SCRIPTSPLIT = "Splits",
SPLITSCRIPT = "Splits scripts",
COUNT = "Aantal:",
SMALLENTITYDATA = "data",

-- Stats screen
AMOUNTSCRIPTS = "Scripts:",
AMOUNTUSEDFLAGS = "Vlaggen:",
AMOUNTENTITIES = "Entiteiten:",
AMOUNTTRINKETS = "Trinkets:",
AMOUNTCREWMATES = "Bemanningsleden:",
AMOUNTINTERNALSCRIPTS = "Interne scripts:",
TILESETUSSAGE = "Tileset-gebruik",
TILESETSONLYUSED = "(alleen kamers met blokken worden geteld)",
AMOUNTROOMSWITHNAMES = "Kamers met een naam:",
PLACINGMODEUSAGE = "Plaatsingsmodi:",
AMOUNTLEVELNOTES = "Levelnotities:",
AMOUNTFLAGNAMES = "Vlagnamen:",
TILESUSAGE = "Gebruik van blokken",


ENTITYINVALIDPROPERTIES = "Entiteit op [$1 $2] heeft $3 ongeldige eigenschappen!",
ROOMINVALIDPROPERTIES = "LevelMetadata voor kamer #$1 heeft $2 ongeldige eigenschappen!",
UNEXPECTEDSCRIPTLINE = "Onverwachte scriptregel zonder script: $1",
MAPWIDTHINVALID = "Levelbreedte is ongeldig: $1",
MAPHEIGHTINVALID = "Levelhoogte is ongeldig: $1",
LEVMUSICEMPTY = "Levelmuziek is leeg!",
NOT400ROOMS = "#levelMetadata <> 400!!",
MOREERRORS = "$1 meer",

DEBUGMODEON = "Debugmodus aan",
FPS = "FPS",
STATE = "Staat",
MOUSE = "Muis",

BLUE = "Blauw",
RED = "Rood",
CYAN = "Cyaan",
PURPLE = "Paars",
YELLOW = "Geel",
GREEN = "Groen",
GRAY = "Grĳs",
PINK = "Roze",
BROWN = "Bruin",
RAINBOWBG = "Regenbg-AG",

-- b14
SYNTAXCOLORS = "Syntaxis-\nkleuren",
SYNTAXCOLORSETTINGSTITLE = "Scriptsyntaxiskleuren",
SYNTAXCOLOR_COMMAND = "Commando",
SYNTAXCOLOR_GENERIC = "Algemeen",
SYNTAXCOLOR_SEPARATOR = "Scheidingsteken",
SYNTAXCOLOR_NUMBER = "Getal",
SYNTAXCOLOR_TEXTBOX = "Tekst",
SYNTAXCOLOR_ERRORTEXT = "Niet-herkend commando",
SYNTAXCOLOR_CURSOR = "Cursor",
SYNTAXCOLOR_FLAGNAME = "Vlagnaam",
SYNTAXCOLOR_NEWFLAGNAME = "Nieuwe vlagnaam",
RESETCOLORS = "Kleuren resetten",
STRINGNOTFOUND = "\"$1\" kan niet worden gevonden",

-- b17
MAL = "Het levelbestand is niet in orde: ", -- one of the following strings are concatenated to this
METADATACORRUPT = "Metadata ontbreekt of is corrupt.",
METADATAITEMCORRUPT = "Metadata voor $1 ontbreekt of is corrupt.",
TILESCORRUPT = "Data voor blokken ontbreekt of is corrupt.",
ENTITIESCORRUPT = "Data voor entiteiten ontbreekt of is corrupt.",
LEVELMETADATACORRUPT = "Kamer-metadata ontbreekt of is corrupt.",
SCRIPTCORRUPT = "Scripts ontbreken of zĳn corrupt.",

-- 1.1.0
LOADSCRIPTMADE = "Laad-script gemaakt",
COPY = "Kopiëren",
CUSTOMSIZE = "Aangepaste kwastgrootte: $1x$2",
SELECTINGA = "Selecteren - klik op linkerbovenhoek",
SELECTINGB = "Selecteren: $1x$2",
TILESETSRELOADED = "Tilesets en sprites opnieuw geladen",

-- 1.2.0
BACKUPS = "Reservekopieën",
BACKUPSOFLEVEL = "Reservekopieën van level $1",
LASTMODIFIEDTIME = "Oorspronkelĳk laatst gewĳzigd", -- List header
OVERWRITTENTIME = "Overschreven", -- List header
SAVEBACKUP = "Opslaan in VVVVVV-map",
DATEFORMAT = "Datumformaat",
CUSTOMDATEFORMAT = "Aangepast datumformaat",
SAVEBACKUPNOBACKUP = "Kies een unieke naam hiervoor als je niets wilt overschrĳven, hiervoor wordt namelĳk GEEN backup gemaakt!",

}

toolnames = {

"Muur",
"Achtergrond",
"Spĳker",
"Trinket",
"Checkpoint",
"Brekend platform",
"Lopende band",
"Verplaatsend platform",
"Vĳand",
"Zwaartekrachtlĳn",
"Tekst",
"Terminal",
"Scriptvak",
"Warptoken",
"Warplĳn",
"Bemanningslid",
"Startpunt"

}

subtoolnames = {

[1] = {"1x1-kwast", "3x3-kwast", "5x5-kwast", "7x7-kwast", "9x9-kwast", "Vul horizontaal", "Vul verticaal", "Aangepaste kwastgrootte", "Aardappel voor het doen van dingen die magisch zĳn"},
[2] = {"1x1-kwast", "3x3-kwast", "5x5-kwast", "7x7-kwast", "9x9-kwast", "Vul horizontaal", "Vul verticaal", "Aangepaste kwastgrootte", "Aardappel voor het doen van dingen die magisch zĳn"},
--[3] = {"1 bottom", "3 bottom", "5 bottom", "7 bottom", "9 bottom", "Expand L+R", "Expand L", "Expand R"},
[3] = {"Auto 1", "Automatisch uitbreiden L+R", "Automatisch uitbreiden L", "Automatisch uitbreiden R"},
[4] = {},
[5] = {"Rechtop", "Ondersteboven"},
[6] = {},
[7] = {"Klein R", "Klein L", "Groot R", "Groot L"},
[8] = {"Omlaag", "Omhoog", "Links", "Rechts"},
[9] = {"Omlaag", "Omhoog", "Links", "Rechts"},
[10] = {"Horizontaal", "Verticaal"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Ingang", "Uitgang"},
[15] = {},
[16] = {"Roze", "Geel", "Rood", "Groen", "Blauw", "Cyaan", "Willekeurig"},
[17] = {"Gezicht naar rechts", "Gezicht naar links"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "A"

}

warpdirchangedtext = {

[0] = "Kamerwarping uitgeschakeld",
[1] = "Warprichting op horizontaal gezet",
[2] = "Warprichting op verticaal gezet",
[3] = "Warprichting op alle richtingen gezet",

}

langtilesetnames = {

short0 = "Space Stn.",
long0 = "Space Station",
short1 = "Buiten",
long1 = "Buiten",
short2 = "Lab",
long2 = "Lab",
short3 = "Warp Zone",
long3 = "Warp Zone",
short4 = "Schip",
long4 = "Schip",

}

ERR_VEDHASCRASHED = "Ved is gecrasht!"
ERR_VEDVERSION = "Ved-versie:"
ERR_LOVEVERSION = "LÖVE-versie:"
ERR_STATE = "Staat:"
ERR_OS = "Besturingssysteem:"
ERR_TIMESINCESTART = "Tĳd sinds opstarten:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(niet geladen)"
ERR_PLUGINSNONE = "(geen)"
ERR_PLEASETELLDAV = "Vertel Dav999 alsjeblieft over dit probleem.\n\n\nDetails: (druk ctrl/cmd+C om naar het klembord te kopiëren)\n\n"
ERR_INTERMEDIATE = " (tussenversie)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (te nieuw)"

ERR_PLUGINERROR = "Pluginfout!"
ERR_FILE = "Bestand om te bewerken:"
ERR_FILEEDITORS = "Plugins die dit bestand bewerken:"
ERR_CURRENTPLUGIN = "Plugin die de fout heeft veroorzaakt:"
ERR_PLEASETELLAUTHOR = "Een plugin moest een wĳziging aanbrengen in code in Ved, maar de te vervangen code werd niet gevonden.\nHet is mogelĳk dat dit wordt veroorzaakt door een conflict tussen twee plugins, of een update van Ved heeft deze plugin onbruikbaar gemaakt.\n\nDetails: (druk ctrl/cmd+C om naar het klembord te kopiëren)\n\n"
ERR_CONTINUE = "Je kunt verdergaan door op ESC of enter te drukken, maar wees bewust dat deze mislukte bewerking voor problemen kan zorgen."
ERR_REPLACECODE = "Kon dit niet vinden in %s.lua:"
ERR_REPLACECODEPATTERN = "Kon dit niet vinden in %s.lua (als pattern):"
ERR_LINESTOTAL = "%i regels in totaal"

ERR_SAVELEVEL = "Om een kopie van je level op te slaan, druk op S"
ERR_SAVESUCC = "Level succesvol opgeslagen als %s!"
ERR_SAVEERROR = "Fout bĳ het opslaan! %s"
ERR_LOGSAVED = "Meer informatie is te vinden in het crashlogboek:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Level-eigenschappen",
		changedrooms = "Gewĳzigde kamers",
		changedroommetadata = "Kamer-metadata",
		entities = "Entiteiten",
		scripts = "Scripts",
		flagnames = "Vlagnamen",
		levelnotes = "Levelnotities",
	},
	levelpropertiesdiff = {
		Title = "Naam is veranderd van \"$1\" naar \"$2\"",
		Creator = "Auteur is veranderd van \"$1\" naar \"$2\"",
		website = "Website is veranderd van \"$1\" naar \"$2\"",
		Desc1 = "Desc1 is veranderd van \"$1\" naar \"$2\"",
		Desc2 = "Desc2 is veranderd van \"$1\" naar \"$2\"",
		Desc3 = "Desc3 is veranderd van \"$1\" naar \"$2\"",
		mapsize = "Levelgrootte is veranderd van $1x$2 naar $3x$4",
		mapsizenote = "Let op: Levelgrootte is veranderd van $1x$2 naar $3x$4.\\o\nKamers buiten het bereik van $5x$6 worden niet genoemd.\\o",
		levmusic = "Levelmuziek is veranderd van $1 naar $2",
	},
	rooms = {
		added1 = "($1,$2) ($3) toegevoegd\\G",
		added2 = "($1,$2) ($3 -> $4) toegevoegd\\G",
		changed1 = "($1,$2) ($3) gewĳzigd\\Y",
		changed2 = "($1,$2) ($3 -> $4) gewĳzigd\\Y",
		cleared1 = "Alle blokken in ($1,$2) ($3) weggehaald\\R",
		cleared2 = "Alle blokken in ($1,$2) ($3 -> $4) weggehaald\\R",
	},
	roommetadata = {
		changed0 = "Kamer $1,$2:",
		changed1 = "Kamer $1,$2 ($3):",
		roomname = "Naam van kamer veranderd van \"$1\" naar \"$2\"\\Y",
		roomnameremoved = "Naam van kamer \"$1\" verwĳderd\\R",
		roomnameadded = "Naam aan kamer gegeven: \"$1\"\\G",
		tileset = "Tileset $1 tilecol $2 veranderd naar tileset $3 tilecol $4\\Y",
		platv = "Platformsnelheid veranderd van $1 naar $2\\Y",
		enemytype = "Vĳand-type veranderd van $1 naar $2\\Y",
		platbounds = "Platformgrenzen veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
		enemybounds = "Vĳandgrenzen veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
		directmode01 = "Direct mode aangezet\\G",
		directmode10 = "Direct mode uitgezet\\R",
		warpdir = "Warprichting veranderd van $1 naar $2\\Y",
	},
	entities = {
		added = "Entiteit van type $1 toegevoegd op positie $2,$3 in kamer ($4,$5)\\G",
		removed = "Entiteit van type $1 verwĳderd van positie $2,$3 in kamer ($4,$5)\\R",
		changed = "Entiteit van type $1 op positie $2,$3 in kamer ($4,$5) gewĳzigd\\Y",
		changedtype = "Entiteit van type $1 veranderd naar type $2 op positie $3,$4 in kamer ($5,$6)\\Y",
		multiple1 = "Entiteiten op positie $1,$2 in kamer ($3,$4) gewĳzigd:\\Y",
		multiple2 = "naar:",
		addedmultiple = "Entiteiten toegevoegd op positie $1,$2 in kamer ($3,$4):\\G",
		removedmultiple = "Entiteiten verwĳderd van positie $1,$2 in kamer ($3,$4):\\R",
		entity = "Type $1",
		incomplete = "Niet alle entiteiten zĳn verwerkt! Rapporteer dit alsjeblieft aan Dav.\\r",
	},
	scripts = {
		added = "Script \"$1\" toegevoegd\\G",
		removed = "Script \"$1\" verwĳderd\\R",
		edited = "Script \"$1\" bewerkt\\Y",
	},
	flagnames = {
		added = "Naam aan vlag $1 gegeven: \"$2\"\\G",
		removed = "Naam \"$1\" voor vlag $2 verwĳderd\\R",
		edited = "Naam voor vlag $1 veranderd van \"$2\" naar \"$3\"\\Y",
	},
	levelnotes = {
		added = "Levelnotitie \"$1\" toegevoegd\\G",
		removed = "Levelnotitie \"$1\" verwĳderd\\R",
		edited = "Levelnotitie \"$1\" bewerkt\\Y",
	},
	mde = {
		added = "Metadata-entiteit is toegevoegd.\\G",
		removed = "Metadata-entiteit is verwĳderd.\\R",
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
subj = "Terug",
imgs = {},
cont = [[
\)
]]
},

{
subj = "Aan de slag",
imgs = {},
cont = [[
Aan de slag\wh#
\C=

Dit artikel zal je helpen om te beginnen met werken met Ved. Om naar de editor te
gaan, moet je een level laden, of een nieuwe maken.


De editor\h#

Aan de linkerkant staan de verschillende gereedschappen, de tools. De meeste tools
hebben subtools die rechts ervan worden weergegeven. Om tussen tools te schakelen
kun je de bĳbehorende snelkoppelingen gebruiken of scrollen met shift of ctrl
ingedrukt. Om tussen subtools te schakelen kun je overal scrollen. Kĳk voor meer
informatie over de tools op de ¤Tools¤-helppagina.\nwl
Je kunt op entiteiten klikken met de rechtermuisknop voor een menu met acties voor
die entiteit. Om entiteiten te verwĳderen zonder dat menu te gebruiken kun je er
rechts op klikken met shift ingedrukt.
Aan de rechterkant van het scherm staan veel knoppen en opties. De bovenste
knoppen zĳn voor het hele level, de onderste knoppen (onder Kamer-opties) zĳn
specifiek voor de huidige kamer. Kĳk voor meer informatie over deze knoppen op de
helppagina's ervoor, waar beschikbaar.

Levels-map\h#

Ved zal normaal gesproken dezelfde map gebruiken voor het opslaan van levels als
VVVVVV, dus het is makkelĳk om te wisselen tussen de level-editor in VVVVVV en
Ved. Als Ved je levels-map niet juist herkent, kun je zelf een pad invullen in de
Ved-opties.
]]
},

{
subj = "Plaatsingsmodi",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
Plaatsingsmodi\wh#
\C=

Ved ondersteunt drie verschillende modi om muren te tekenen.

     Automatische modus\h#0

          Dit is de modus die het makkelĳkst te gebruiken is. In deze stand kun je
          muren en achtergronden tekenen, en de hoekpunten en zĳkanten zullen
          automatisch goed afgewerkt worden. Het is in deze stand echter niet
          mogelĳk om meerdere verschillende tilesets of kleuren te gebruiken.

     Multi-tileset-modus\h#1

          Dit lĳkt op de automatische modus, behalve dat je meerdere verschillende
          tilesets in dezelfde kamer kunt gebruiken. Dat wil zeggen, als je van
          tileset verandert zullen bestaande muren en achtergronden niet veranderd
          worden, en je kunt in meerdere verschillende kleuren tekenen in dezelfde
          kamer.

     Handmatige modus\h#2

          Ook wel bekend als Direct Mode, in deze modus kun je alles handmatig
          plaatsen, dus je zit niet vast aan de ingebouwde tileset-combinaties en
          hoekpunten en zĳkanten zullen niet automatisch afgewerkt worden,
          waardoor je de volledige controle hebt over hoe de kamer eruit zal zien.
          Het kost meestal echter meer tĳd om in deze modus te werken.
]]
},

{
subj = "Tools",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
Tools\wh#
\C=

Je kunt de volgende tools gebruiken om kamers te vullen in je level:

\0
   Muur\h#


Hiermee kun je muren plaatsen.

\1
   Achtergrond\h#


Hiermee kun je achtergronden plaatsen.

\2
   Spĳker\h#


Hiermee kun je spĳkers plaatsen. Je kunt de "automatisch uitbreiden"-subtools
gebruiken om spĳkers te plaatsen op een oppervlak met één klik (of schuif).

\3
   Trinket\h#


Hiermee kun je trinkets plaatsen. Bedenk dat er maximaal twintig trinkets in een
level geplaatst kunnen worden.

\4
   Checkpoint\h#


Hiermee kun je checkpoints plaatsen.

\5
   Brekend platform\h#


Hiermee kun je brekende platforms plaatsen.

\6
   Lopende band\h#


Hiermee kun je lopende banden plaatsen.

\7
   Verplaatsend platform\h#


Hiermee kun je verplaatsende platforms plaatsen.

\8
   Vĳand\h#


Hiermee kun je vĳanden plaatsen. De vorm en kleur van de vĳand wordt bepaald door
respectievelĳk de instellingen voor vĳand-type en tileset(-kleur).

\9
   Zwaartekrachtlĳn\h#


Hiermee kun je zwaartekrachtlĳnen plaatsen.

\^0
   Tekst\h#


Hiermee kun je tekst plaatsen.

\^1
   Terminal\h#


Hiermee kun je terminals plaatsen. Plaats eerst de terminal, typ vervolgens een
naam voor het script. Kĳk voor meer informatie over scripts naar de lĳsten met
scriptcommando's.

\^2
   Scriptvak\h#


Hiermee kun je scriptvakken plaatsen. Klik eerst op de linkerbovenhoek, dan op de
rechteronderhoek, en typ vervolgens een naam voor het script. Kĳk voor meer
informatie over scripts naar de lĳsten met scriptcommando's.

\^3
   Warptoken\h#


Hiermee kun je warptokens plaatsen. Klik eerst op de plek waar de ingang moet
komen te staan, dan waar de uitgang moet komen te staan.

\^4
   Warplĳn\h#


Hiermee kun je warplĳnen plaatsen. Bedenk dat warplĳnen alleen aan de zĳkanten van
een kamer geplaatst kunnen worden.

\^5
   Bemanningslid\h#


Hiermee kun je bemanningsleden plaatsen die gered kunnen worden. Wanneer alle
bemanningsleden worden gered, eindigt het level. Bedenk dat er maximaal twintig
bemanningsleden in een level geplaatst kunnen worden.

\^6
   Startpunt\h#


Hiermee kun je het startpunt plaatsen.
]]
},
----------------------------------------------------------------------------------[]-
{
subj = "Scriptbewerker",
imgs = {},
cont = [[
Scriptbewerker\wh#
\C=

Met de scriptbewerker kun je scripts in je level beheren en bewerken.


Vlagnamen\h#

Voor het gemak en de leesbaarheid van scripts is het mogelĳk om namen te gebruiken
voor vlaggen in plaats van nummers. Als je een naam gebruikt in plaats van een
nummer, zal automatisch op de achtergrond een nummer worden toegewezen aan die
naam. Het is ook mogelĳk om te kiezen welk vlagnummer gebruikt moet worden voor
welke naam.

Interne scripting-modus\h#

Om interne scripting te gebruiken in Ved kun je interne scripting-modus
inschakelen, om alle commando's in dat script te laten werken als interne
commando's. Je moet er echter zelf voor zorgen dat het script geladen wordt via
iftrinkets() of ifflag(). Kĳk voor meer informatie over interne scripting naar de
lĳst met interne scriptcommando's.

Scripts splitsen\h#

Het is mogelĳk om een script in tweeën te splitsen met de scriptbewerker. Nadat
je de tekstcursor op de eerste regel hebt gezet die je naar het nieuwe script wilt
verplaatsen, klik op de "Splits"-knop en typ de naam van het nieuwe script. De
regels voor de cursor blĳven in het oorspronkelĳke script, de regel waar de cursor
staat en alle regels daarna zullen verplaatst worden naar het nieuwe script.

Naar scripts springen\h#

Op regels met een van de commando's iftrinkets, ifflag, customiftrinkets of
customifflag, is het mogelĳk om naar het gegeven script te springen door te
klikken op de knop "Ga naar" wanneer de cursor op die regel staat. Je kunt
hiervoor ook op ¤ctrl+rechts¤ drukken, en je kunt met ¤ctrl+links¤ één stap terug\nwnw
nemen door de keten naar waar je vandaan kwam.
]]
},

{
subj = "Snelkoppelingen",
imgs = {},
cont = [[
Snelkoppelingen\wh#
\C=

De meeste snelkoppelingen die in VVVVVV gebruikt kunnen worden kunnen ook worden
gebruikt in Ved.

F1¤  Tileset veranderen\C
F2¤  Kleur veranderen\C
F3¤  Vĳanden veranderen\C
F4¤  Vĳand-grenzen\C
F5¤  Platform-grenzen\C

F10¤  Handmatige/automatische modus (direct mode/niet-direct mode)\C

W¤  Warprichting veranderen\C
E¤  Kamernaam veranderen\C

L¤  Level laden\C
S¤  Level opslaan\C

Z¤  3x3-kwast (muren en achtergronden)\C
X¤  5x5-kwast (")\C

< ¤en¤ >¤  tussen tools schakelen\CnC
Ctrl/Cmd+< ¤en¤ Ctrl/Cmd+>¤  tussen subtools schakelen\CnC

Meer snelkoppelingen\h#

Ved introduceert ook een paar snelkoppelingen.

Hoofd-editor\gh#

Ctrl+P¤  Ga naar de kamer met het startpunt\C
Ctrl+S¤  Snel opslaan\C
Ctrl+X¤  Kamer naar het klembord knippen\C
Ctrl+C¤  Kamer naar het klembord kopiëren\C
Ctrl+V¤  Kamer van het klembord plakken (indien geldig)\C
Ctrl+D¤  Dit level met een ander level vergelĳken\C
Ctrl+Z¤  Ongedaan maken\C
Ctrl+Y¤  Herhalen\C
Ctrl+F¤  Zoeken\C
Ctrl+/¤  Level-kladblok\C
Ctrl+F1¤  Help\C
(LET OP: Gebruik op Mac cmd in plaats van ctrl)
N¤  Nummers van alle blokken tonen\C
M¤  Kaart tonen\C
Q¤  Naar kamer gaan (typ coördinaten in als vier cĳfers)\C
/¤  Scripts\C
[¤  Y van muis vastzetten (om makkelĳker horizontale lĳnen te tekenen)\C
]¤  X van muis vastzetten (om makkelĳker verticale lĳnen te tekenen)\C
F11¤  tilesets en sprites opnieuw laden\C

Scriptbewerker\gh#

Ctrl+F¤  Zoeken\C
Ctrl+G¤  Ga naar regel\C
Ctrl+rechts¤  Spring naar script in voorwaardelĳk commando\C
Ctrl+links¤  Spring één stap terug\C

Scriptlĳst\gh#

N¤  Nieuw script maken\C
F¤  Ga naar vlaggenlĳst\C
/¤  Ga naar bovenste/laatste script\C
]]
},

--[[
\-
Test thing

command¤(§¤required text¤,§¤required number¤,§¤optional text¤,§¤optional number¤)\wnvnynGnY(

\-
]]

{
subj = "Eenvoudige scripting",
imgs = {},
cont = [[
Vereenvoudigde scripting\wh#
\C=

De vereenvoudigde scriptingtaal van VVVVVV is een soort taal die kan worden
gebruikt om VVVVVV-levels mee te scripten.
Let op: wanneer iets tussen aanhalingstekens staat, moet het zonder die
aanhalingstekens getypt worden.


say¤([regels[,kleur]] .. "]]" .. [[)\h#w

Toon een tekstvak. Zonder argumenten zal dit een tekstvak maken met één regel, en
standaard resulteert dit in een terminal-tekstvak in het midden. Het kleur-
argument kan een kleur zĳn, of de naam van een bemanningslid.
Als je een kleur gebruikt en er is een bemanningslid dat gered kan worden in de
kamer, zal het tekstvak boven dat bemanningslid worden weergegeven.

reply¤([regels])\h#w

Toon een tekstvak voor Viridian. Zonder het regels-argument zal dit een tekstvak
met één regel maken.

delay¤(n)\h#w

Pauzeer het script voor n ticks. 30 ticks is bĳna een seconde.

happy¤([bemanningslid])\h#w

Maakt een bemanningslid blĳ. Zonder een argument zal dit Viridian blĳ maken. Je
kunt ook "all", "everyone" of "everybody" gebruiken als een argument om iedereen
blĳ te maken.

sad¤([bemanningslid])\h#w

Maakt een bemanningslid verdrietig. Zonder een argument zal dit Viridian
verdrietig maken. Je kunt ook "all", "everyone" of "everybody" gebruiken als een
argument om iedereen verdrietig te maken.

flag¤(vlag,on/off)\h#w

Zet een bepaalde vlag aan of uit. flag(4,on) zal bĳvoorbeeld vlag 4 aanzetten.
Er zĳn 100 vlaggen, genummerd van 0 tot 99.
Standaard staan alle vlaggen wanneer als je een level begint te spelen.
Opmerking: In Ved kun je ook vlagnamen gebruiken in plaats van de nummers.

ifflag¤(vlag,scriptnaam)\h#w

Als een bepaalde vlag AAN staat, ga naar script met naam scriptnaam.
Als een bepaalde vlag UIT staat, ga dan verder in het huidige script.
Voorbeeld:
ifflag(20,cutscene) - Als vlag 20 AAN staat, ga naar script "cutscene", zo niet,
                      ga dan verder in het huidige script.
Opmerking: In Ved kun je ook vlagnamen gebruiken in plaats van de nummers.

iftrinkets¤(aantal,scriptnaam)\h#w

Als je aantal trinkets >= aantal, ga naar script met naam scriptnaam.
Als je aantal trinkets < aantal, ga dan verder in het huidige script.
Voorbeeld:
iftrinkets(3,enoughtrinkets) - Als je 3 of meer trinkets hebt zal het script
                               "enoughtrinkets" worden uitgevoerd, anders za het
                               huidige script verdergaan.
Het is gebruikelĳk om 0 als minimum aantal trinkets te gebruiken, om een script
altĳd te laden.

destroy¤(iets)\h#w

Geldige argumenten kunnen zĳn:
warptokens - Verwĳder alle warptokens totdat je opnieuw de kamer binnenkomt.
gravitylines - Verwĳder alle zwaartekrachtlĳnen totdat je opnieuw de kamer
               binnenkomt.
De optie "platforms" bestaat ook, maar werkt niet goed.

music¤(nummer)\h#w

Verander de muziek naar een bepaald nummer.
Kĳk voor de lĳst van muzieknummers naar het artikel "Lĳsten".

playremix\h#w

Speelt de remix van Predestined Fate als muziek.

flash\h#w

Laat het scherm flitsen, maakt een geluid van een knal en schudt het scherm even.

map¤(on/off)\h#w

Zet de kaart aan of uit. Als je de kaart uitzet wordt er "NO SIGNAL" getoond tot
je hem weer aanzet. Kamers zullen nog steeds onthuld worden terwĳl de kaart
uitstaat en zichtbaar worden wanneer je de kaart weer aanzet.

squeak¤(bemanningslid/on/off)\h#w

Zorgt dat een bemanningslid een geluid maakt, of zet het tekstvak-geluid aan of
uit.

speaker¤(color)\h#w

Verandert de kleur en positie van de volgende tekstvakken gemaakt met het "say"-
commando. Dit kan worden gebruikt in plaats van het tweede argument voor "say".
]]
},

{
subj = "Int. script reference",
imgs = {},
cont = [[Te vertalen\w&r
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
subj = "Lĳsten",
imgs = {},
cont = [[Te vertalen\w&r
Lĳsten\wh#
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
subj = "Opmaak",
imgs = {},
cont = [[
Opmaak\wh#
\C=

In notities kun je opmaakcodes gebruiken om je tekst groter te maken, het een
kleur te geven, en nog wat dingen. Om opmaak toe te voegen aan een regel, typ een
backslash (\) aan het eind van de regel. Na de \ kun je elke hoeveelheid van de\
volgende codes gebruiken, in welke volgorde dan ook:

h - Dubbele lettergrootte\h

# - Anker. Je kunt snel naar ankers springen met ¤#Links¤links¤.\nLCl
- - Horizontale lĳn:
\-
= - Horizontale lĳn onder grote tekst

Tekstkleuren:\h#

n - Normaal\n
r - Rood\r
g - Grĳs\g
w - Wit\w
b - Blauw\b
o - Oranje\o
v - Groen\v
c - Cyaan\c
y - Geel\y
z - Zwart¤ (exclusief achtergrondkleur)\z&Z
Z - Donkergrĳs\Z
C - Cyaan (Viridian)\C
P - Roze (Violet)\P
Y - Geel (Vitellary)\Y
R - Rood (Vermilion)\R
G - Groen (Verdigris)\G
B - Blauw (Victoria)\B


Voorbeeld:\h#

\-
Grote oranje tekst ("oh" is hetzelfde)\ho\

Grote oranje tekst ("oh" is hetzelfde)\ho

\-
Onderstreepte grote tekst\wh\
\r=\

Onderstreepte grote tekst\wh
\r=
\-

Meerdere kleuren op een regel gebruiken\h#

Het is mogelĳk om meerdere kleuren op een regel te gebruiken door gekleurde delen
te scheiden met het teken¤ ¤¤ ¤(dat je kunt typen door op ¤insert¤ te drukken) en de\nYnw
kleuren in de juiste volgorde na¤ \ ¤te zetten. Als de laatste kleur op de regel de\nC
standaardkleur is (n), is het niet nodig om deze code op het eind neer te zetten.
Als je het¤ ¤¤§¤-teken wilt gebruiken op een regel met¤ \¤, kun je in plaats daarvan¤ ¤¤¤¤\nYnCnY(
typen. Het is om technische redenen ni¤e§¤t mogelĳk om een enkel teken een kleur te\nR(
geven door het tussen twee¤ ¤¤§¤'s te zetten, tenzĳ je ook een spatie of een ander\nY(
teken meeneemt.

\-
Je kunt specifieke ¤¤woorden¤¤ een ¤¤kleur¤¤ geven!\nvnr\

Je kunt specifieke ¤woorden¤ een ¤kleur¤ geven!\nvnr
\-
Een ¤¤paar ¤¤tek¤¤st¤¤kleu¤¤ren\RYGCBP\

Een ¤paar ¤tek¤st¤kleu¤ren\RYGCBP
\-

Een enkel teken een kleur geven\h#

Oké, ik loog, het is wel mogelĳk om een enkel teken een kleur te geven zonder een
spatie mee te nemen. Om dit te doen kun je het teken¤ § ¤(dat je kunt typen met\nY
shift+insert¤) na het teken dat je wilt kleuren, en schakel het in met de\w
opmaakcode¤ ( ¤na¤ \¤:\nCnC

\-
Je kunt zo een ¤¤enkel¤¤ teken een kl¤¤e§¤¤ur geven!\nynr(\

Je kunt zo een ¤enkel¤ teken een kl¤e§¤ur geven!\nynr(
\-

Dit is niet nodig als het enkele teken het eerste of laatste is op een regel.

Achtergrondkleuren\h#

Niet alleen kan tekst een kleur hebben, het kan ook ¤gemarkeerd¤ worden in welke\nZ&y
tekstkleur dan ook. Om dit te doen kun je¤ & ¤zetten na de kleurcode voor de tekst,\nY
en dan een kleurcode voor de achtergrondkleur. Dit kan gedaan worden in combinatie
met het systeem met ¤ zoals hierboven beschreven, maar bedenk dat gewone
tekstkleuren wel het nieuwe "blok" starten, maar achtergrondkleuren niet. De
volgende voorbeelden gebruiken spaties om alles leesbaarder te maken, maar dit
hoeft niet. Je kunt de code¤ + ¤gebruiken om de (laatste) achtergrondkleur door te\nY
trekken naar het einde van de regel.

\-
Zwarte tekst op witte achtergrond!\z&w\

Zwarte tekst op witte achtergrond!\z&w
\-
Zwarte tekst op doorgetrokken witte achtergrond!\z&w+\

Zwarte tekst op doorgetrokken witte achtergrond!\z&w+
\-
Rood op geel¤¤, ¤¤Zwart op wit¤¤ (spaties verbeteren de leesbaarheid)\r&y n z&w\

Rood op geel¤, ¤Zwart op wit¤ (spaties verbeteren de leesbaarheid)\r&y n z&w
\-
Dit ¤¤werkt¤¤ nog steeds om enk¤¤e§¤¤le tekens kleuren te geven\n P n n&r (\

Dit ¤werkt¤ nog steeds om enk¤e§¤le tekens kleuren te geven\n P n n&r (
\-

Als je wilt kun je ook grafische kunst maken met achtergrondkleuren:

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

Links kunnen voor twee dingen worden gebruikt: het linken naar ergens anders in de
artikelen/notities, of het linken naar websites. Links gebruiken de semi-kleurcode
l¤. Deze code schakelt niet naar het volgende "gekleurde blok", het is alleen van\Y
toepassing op het huidige blok, in tegenstelling tot de normale kleuren (wanneer
ze niet als achtergrondkleur gebruikt worden). Het verandert de kleur ook niet,
dus je kunt zelf de stĳl van de link bepalen.

Je kunt naar artikelen linken door simpelweg de naam van het artikel te gebruiken:

\-
Tools\bl\

Tools\bl
\-

Als je hierboven op "Tools" klikt ga je naar het artikel genaamd "Tools". Ik heb
hier de kleurcode¤ b ¤gebruikt om de link blauw te maken, en zoals je kunt zien is\nb
de¤ l ¤van toepassing op datzelfde gekleurde gedeelte.\nY

Je kunt een koppeling maken naar een ankers door een¤ # ¤te gebruiken gevolgd door
alle tekst op die regel. (Gevallen van¤ ¤¤ ¤worden daar volledig genegeerd.) Je\nY
kunt naar de bovenkant van een artikel linken met alleen een hekje (¤#§¤).\nY(

\-
#Meerdere kleuren op een regel gebruiken\bl\

#Meerdere kleuren op een regel gebruiken\bl
\-

Je kunt op een soortgelĳke manier naar een anker in een ander artikel linken:

\-
Lĳsten#Gamestates\bl\

Lĳsten#Gamestates\bl
\-

Linken naar websites is ook eenvoudig:

\-
https://example.com/\bl\

https://example.com/\bl
\-

Je kunt een kleurblok met kleurcode¤ L ¤gebruiken dat de bestemming van de link\nY
bevat vóór de tekst van de link, en zo de link een andere tekst laten zien:

\-
Tools¤¤Ga naar een ander artikel\Lbl\

Tools¤Ga naar een ander artikel\Lbl
\-
Klik ¤¤Tools¤¤hier¤¤ om naar een ander artikel te gaan\nLbl\

Klik ¤Tools¤hier¤ om naar een ander artikel te gaan\nLbl
\-
[¤¤#Links¤¤Like¤¤] [¤¤#Example:¤¤Dislike¤¤]\n L vl n L rl\

[¤#Links¤Like¤] [¤#Example:¤Dislike¤]\n L vl n L rl
\-
#Links¤¤ Knop A ¤¤ §¤¤#Links¤¤ Knop B \L w&Zl n L w&Z l(\

#Links¤ Knop A ¤ §¤#Links¤ Knop B \L w&Zl n L w&Z l(
\-

Afbeeldingen (alleen beschikbaar in\h#

beschrĳvingen van plugins):\h

0..9 - Toon afbeelding 0..9 op deze regel (index van het imgs-array begint bĳ 0,
       en onthoud om regels leeg te laten onder de afbeelding)
^ - Typ dit voor het afbeeldingsnummer, verhoog afbeeldingsnummer met 10. Dus ^4
    geeft afbeelding 14, ^^4 geeft afbeelding 24. En 3^1^56 geeft afbeeldingen 3,
    11, 25 en 26.
_ - Typ dit voor het afbeeldingsnummer om het nummer te verlagen met 10.
> - Typ dit voor het afbeeldingsnummer om verdere afbeeldingen 8 pixels naar
    rechts te schuiven. Dit kan worden herhaald, dus 0>>>>1 zet afbeelding 0 op
    x=0 en afbeelding 1 op x=32.
< - Zelfde, maar schuif naar links.
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

Ved is gemaakt door Dav999

Sommige afbeeldingen en het lettertype zĳn gemaakt door Format

Russische vertaling: CreepiX
Esperanto vertaling: Format


Met dank aan:\h#


Terry Cavanagh voor het maken van VVVVVV

TurtleP (voor de code die afbeeldingen niet wazig maakt waneer je ze schaalt)

Iedereen die bugs gerapporteerd heeft, met ideeën is gekomen en mĳ heeft
gemotiveerd om dit te maken!








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