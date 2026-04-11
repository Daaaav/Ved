-- Language file for Ved
--- Language: nl (nl)
--- Last converted: 2026-04-11 03:53:21 (CEST)

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

OSNOTRECOGNIZED = "Je besturingssysteem ($1) wordt niet herkend! Valt terug op standaard-bestandssysteemfuncties; levels worden opgeslagen in:\n\n$2",
MAXTRINKETS = "Het maximum aantal artefacten ($1) is bereikt in dit level.",
MAXCREWMATES = "Het maximum aantal bemanningsleden ($1) is bereikt in dit level.",
UNSUPPORTEDTOOL = "Niet-ondersteund gereedschap! Gereedschap: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Kon de inhoud van de levelsmap niet verkrijgen. Controleer of $1 bestaat en probeer het opnieuw.",
MAPSAVEDAS = "Kaart opgeslagen als $1!",
RAWENTITYPROPERTIES = "Je kunt de eigenschappen van deze entiteit hier wijzigen.",
UNKNOWNENTITYTYPE = "Onbekend entiteitstype $1",
WARPTOKENENT404 = "Teleportatietoken-entiteit bestaat niet meer!",
SPLITFAILED = "Splitsen is miserabel mislukt! Zijn er te veel regels tussen een text-commando en een speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Er zijn geen vlaggen meer beschikbaar, dus één of meer vlagnamen in dit script kunnen niet geassocieerd worden met een vlagnummer. Dit script in VVVVVV proberen uit te voeren kan fout gaan. Overweeg om alle verwijzingen te wissen naar vlaggen die je niet meer nodig hebt en probeer het opnieuw.",
NOFLAGSLEFT_LOADSCRIPT = "Er zijn geen vlaggen meer beschikbaar, dus er kon geen laadscript gemaakt worden met een nieuwe vlag. In plaats daarvan is er een laadscript gemaakt dat het doelscript altijd laadt met iftrinkets(0,$1). Overweeg om alle verwijzingen te wissen naar vlaggen die je niet meer nodig hebt en probeer het opnieuw.",
LEVELOPENFAIL = "Kon $1.vvvvvv niet openen.",
SIZELIMIT = "De maximale grootte van een level is $1 bij $2.\n\nDe levelgrootte zal worden aangepast naar $3 bij $4.",
SCRIPTALREADYEXISTS = "Script \"$1\" bestaat al!",
FLAGNAMENUMBERS = "Namen van vlaggen kunnen niet alleen uit nummers bestaan.",
FLAGNAMECHARS = "Namen van vlaggen kunnen geen haakjes, komma's of spaties bevatten.",
FLAGNAMEINUSE = "De vlagnaam $1 wordt al gebruikt door vlag $2",
DIFFSELECT = "Selecteer level om mee te vergelijken. Het level dat je nu kiest zal worden gezien als een oudere versie.",
SUREQUITNEW = "Je hebt niet-opgeslagen wijzigingen. Wil je deze wijzigingen opslaan voor het afsluiten?",
SURENEWLEVELNEW = "Je hebt niet-opgeslagen wijzigingen. Wil je deze wijzigingen opslaan voor het maken van een nieuw level?",
SUREOPENLEVEL = "Je hebt niet-opgeslagen wijzigingen. Wil je deze wijzigingen opslaan voor het openen van dit level?",
NAMEFORFLAG = "Naam voor vlag $1:",
SCRIPT404 = "Script \"$1\" bestaat niet!",
ENTITY404 = "Entiteit #$1 bestaat niet meer!",
GRAPHICSCARDCANVAS = "Sorry, het lijkt dat je grafische kaart of het stuurprogramma deze functie niet ondersteunt!",
MAXTEXTURESIZE = "Sorry, het maken van een afbeelding van $1x$2 lijkt niet te worden ondersteund door je grafische kaart of het stuurprogramma.\n\nDe maximale grootte op dit systeem is $3x$3.",
SUREDELETESCRIPT = "Weet je zeker dat je het script \"$1\" wilt verwijderen?",
SUREDELETENOTE = "Weet je zeker dat je deze notitie wilt verwijderen?",
THREADERROR = "Threadfout!",
WHATDIDYOUDO = "Wat heb je gedaan?!",
UNDOFAULTY = "Waar ben je mee bezig?",
SOURCEDESTROOMSSAME = "Beide kamers zijn hetzelfde!",
COORDS_OUT_OF_RANGE = "Huh? Deze coördinaten liggen niet eens in deze dimensie!",
UNKNOWNUNDOTYPE = "Onbekend ongedaan-maak-type \"$1\"!",
MDEVERSIONWARNING = "Dit level lijkt in een nieuwere versie van Ved te zijn gemaakt, en kan data bevatten die verloren zal gaan als je dit level opslaat.",
FORGOTPATH = "Je bent vergeten een pad op te geven!",
LIB_LOAD_ERRMSG = "Een essentiële bibliotheek kan niet worden geladen. Vertel Dav999 alsjeblieft over dit probleem.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nProbeer GCC te installeren om dit probleem op te lossen, als het niet al geïnstalleerd is.",

SELECTCOPY1 = "Selecteer de kamer om te kopiëren",
SELECTCOPY2 = "Selecteer de plek om deze kamer naartoe te kopiëren",
SELECTSWAP1 = "Selecteer de eerste kamer om om te wisselen",
SELECTSWAP2 = "Selecteer de tweede kamer om om te wisselen",

TILESETCHANGEDTO = "Tileset veranderd naar $1",
TILESETCOLORCHANGEDTO = "Tilesetkleur veranderd naar $1",
ENEMYTYPECHANGED = "Vijandtype veranderd",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Veranderd naar $1plaatsing",
CHANGEDTOMODEAUTO = "automatische ",
CHANGEDTOMODEMANUAL = "handmatige ",
CHANGEDTOMODEMULTI = "multi-tileset-",

BUSYSAVING = "Bezig met opslaan...",
SAVEDLEVELAS = "Level opgeslagen als $1.vvvvvv",

ROOMCUT = "Kamer geknipt naar klembord",
ROOMCOPIED = "Kamer gekopieerd naar klembord",
ROOMPASTED = "Kamer geplakt",

METADATAUNDONE = "Levelopties ongedaan gemaakt",
METADATAREDONE = "Levelopties opnieuw gewijzigd",

BOUNDSFIRST = "Klik op de eerste hoek van de begrenzing", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Klik op de laatste hoek", -- Old string: Click the bottom right corner

TILE = "Blok $1",
HIDEALL = "Verbergen",
SHOWALL = "Toon alles",
SCRIPTEDITOR = "Scriptbewerker",
FILE = "Bestand",
NEW = "Nieuw",
OPEN = "Openen",
SAVE = "Opslaan",
UNDO = "Ongedaan maken",
REDO = "Herhalen",
COMPARE = "Vergelijken",
STATS = "Statistieken",
SCRIPTUSAGES = "Verwijzingen",
EDITTAB = "Bewerken",
COPYSCRIPT = "Alles kopiëren",
SEARCHSCRIPT = "Zoeken",
GOTOLINE = "Ga naar regel",
GOTOLINE2 = "Ga naar regel:",
INTERNALON = "Int.sc is aan",
INTERNALOFF = "Int.sc is uit",
INTERNALON_LONG = "Interne scripting-modus is ingeschakeld",
INTERNALOFF_LONG = "Interne scripting-modus is uitgeschakeld",
INTERNALYESBARS = "say(-1)-int.sc",
INTERNALNOBARS = "Laadscript-\nint.sc",
VIEW = "Beeld",
SYNTAXHLOFF = "Kleuren: aan",
SYNTAXHLON = "Kleuren: uit",
TEXTSIZEN = "Grootte: norm.",
TEXTSIZEL = "Grootte: groot",
INSERT = "Invoegen",
HELP = "Help",
INTSCRWARNING_NOLOADSCRIPT = "Laadscript nodig!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Er is geen script gevonden dat dit script laadt. Dit type interne script zal waarschijnlijk niet werken zoals je verwacht als het niet wordt geladen via een ander script.",
INTSCRWARNING_BOXED = "Rechtstreekse scriptvak-/terminalverwijzing!",
INTSCRWARNING_BOXED_EXPL = "Er is een terminal of scriptvak dat dit script rechtstreeks laadt. Die terminal of dat scriptvak activeren zal waarschijnlijk niet werken zoals je verwacht; dit type interne script moet worden geladen via een laadscript.",
INTSCRWARNING_NAME = "Ongeschikte scriptnaam!",
INTSCRWARNING_NAME_EXPL = "De naam van dit script heeft een hoofdletter, een spatie, een haakje of een komma. Dit script kan alleen rechtstreeks vanaf een terminal of scriptvak worden geladen.",
COLUMN = "Kolom: ",

BTN_OK = "OK",
BTN_CANCEL = "Annuleren",
BTN_YES = "Ja",
BTN_NO = "Nee",
BTN_APPLY = "Toepassen",
BTN_QUIT = "Afsluiten",
BTN_DISCARD = "Verwerpen",
BTN_SAVE = "Opslaan",
BTN_CLOSE = "Sluiten",
BTN_LOAD = "Laden",
BTN_ADVANCED = "Geavanceerd",

BTN_AUTODETECT = "Detecteren",
BTN_MANUALLY = "Handmatig", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Opnieuw",

COMPARINGTHESE = "$1.vvvvvv wordt vergeleken met $2.vvvvvv",
COMPARINGTHESENEW = "(niet-opgeslagen level) wordt vergeleken met $1.vvvvvv",

RETURN = "Terug",
CREATE = "Aanmaken",
GOTO = "Naartoe gaan",
DELETE = "Verwijderen",
RENAME = "Hernoemen",
CHANGEDIRECTION = "Richting wijzigen",
TESTFROMHERE = "Testen vanaf hier",
FLIP = "Omdraaien",
CYCLETYPE = "Type wijzigen",
GOTODESTINATION = "Naar bestemming gaan",
GOTOENTRANCE = "Naar ingang gaan",
CHANGECOLOR = "Kleur wijzigen",
EDITTEXT = "Tekst wijzigen",
COPYTEXT = "Tekst kopiëren",
EDITSCRIPT = "Script wijzigen",
OTHERSCRIPT = "Scriptnaam veranderen",
PROPERTIES = "Eigenschappen",
CHANGETOHOR = "Naar horizontaal veranderen",
CHANGETOVER = "Naar verticaal veranderen",
RESIZE = "Opnieuw plaatsen",
CHANGEENTRANCE = "Ingang verplaatsen",
CHANGEEXIT = "Uitgang verplaatsen",
COPYENTRANCE = "Ingang kopiëren",
LOCK = "Vergrendelen",
UNLOCK = "Ontgrendelen",

VEDOPTIONS = "Ved-opties",
LEVELOPTIONS = "Levelopties",
MAP = "Kaart",
SCRIPTS = "Scripts",
SEARCH = "Zoeken",
SENDFEEDBACK = "Geef feedback",
LEVELNOTEPAD = "Levelkladblok",
PLUGINS = "Plugins",

BACKB = "Terug <<",
MOREB = "Meer >>",
AUTOMODE = "Modus: auto",
AUTO2MODE = "Modus: multi",
MANUALMODE = "Modus: handm.",
ENEMYTYPE = "Type: $1",
PLATFORMBOUNDS = "Begrenzing",
WARPDIR = "Warprichting:$1",
ENEMYBOUNDS = "Begrenzing",
ROOMNAME = "Kamernaam",
ROOMOPTIONS = "Kameropties",
ROTATE180 = "180grd draaien",
ROTATE180UNI = "180° draaien",
HIDEBOUNDS = "Grenzen verb.",
SHOWBOUNDS = "Grenzen tonen",

ROOMPLATFORMS = "Platformen", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Vijanden",

OPTNAME = "Naam",
OPTBY = "Door",
OPTWEBSITE = "Website",
OPTDESC = "Beschr.", -- If necessary, you can span multiple lines
OPTSIZE = "Grootte",
OPTMUSIC = "Muziek",
CAPNONE = "GEEN",
ENTERLONGOPTNAME = "Levelnaam:",

X = "x", -- Used for level size: 20x20

SOLID = "Vast",
NOTSOLID = "Niet vast",

TSCOLOR = "Kleur $1",

LEVELSLIST = "Levels",
LOADTHISLEVEL = "Laad dit level: ",
ENTERNAMESAVE = "Naam om mee op te slaan: ",
SEARCHFOR = "Zoeken naar: ",

VERSIONERROR = "Kon versie niet controleren.",
VERSIONUPTODATE = "Je versie van Ved is up-to-date.",
VERSIONOLD = "Update beschikbaar! Laatste versie: $1",
VERSIONCHECKING = "Controleren op updates...",
VERSIONDISABLED = "Update-\ncontrole uitgeschakeld",
VERSIONCHECKNOW = "Nu controleren", -- Check for updates now

SAVENOSUCCESS = "Opslaan niet succesvol! Fout: ",
INVALIDFILESIZE = "Ongeldige bestandsgrootte.",

EDIT = "Bewerken",
EDITWOBUMPING = "Bewerken, niet naar boven verplaatsen",
EDITWBUMPING = "Bewerken en naar boven verplaatsen",
COPYNAME = "Naam kopiëren",
COPYCONTENTS = "Inhoud kopiëren",
DUPLICATE = "Dupliceren",

NEWSCRIPTNAME = "Naam:",
CREATENEWSCRIPT = "Nieuw script maken",

NEWNOTENAME = "Naam:",
CREATENEWNOTE = "Nieuwe notitie maken",

ADDNEWBTN = "[Nieuwe maken]",
IMAGEERROR = "[AFBEELDINGSFOUT]",

NEWNAME = "Nieuwe naam:",
RENAMENOTE = "Notitie hernoemen",
RENAMESCRIPT = "Script hernoemen",

LINE = "regel ",

SAVEMAP = "Kaart opslaan",
COPYROOMS = "Kamer kopiëren",
SWAPROOMS = "Wissel kamers",

MAP_STYLE = "Kaartstijl",
MAP_STYLE_FULL = "Volledig", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Minimap", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Vlaggen",
ROOM = "kamer",
CONTENTFILLER = "Inhoud",

FLAGUSED = "Gebruikt     ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Niet gebruikt",
FLAGNONAME = "Geen naam",
USEDOUTOFRANGEFLAGS = "Gebruikte vlaggen buiten bereik:",

VVVVVVSETUP = "VVVVVV-\nconfiguratie",
CUSTOMVVVVVVDIRECTORY = "VVVVVV-map",
CUSTOMVVVVVVDIRECTORYEXPL = "De standaard VVVVVV-map die Ved verwacht is:\n$1\n\nDit pad moet niet worden ingesteld op de \"levels\"-map.",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Je hebt geen aangepaste VVVVVV-map ingesteld.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Je VVVVVV-map is ingesteld op een aangepast pad:\n$1\n\n",
LANGUAGE = "Taal",
DIALOGANIMATIONS = "Dialoogvenster-animaties",
FLIPSUBTOOLSCROLL = "Scrollrichting voor gereedschap omkeren",
ADJACENTROOMLINES = "Aanduidingen van blokken in naastgelegen kamers",
NEVERASKBEFOREQUIT = "Nooit vragen voor afsluiten, zelfs als er niet-opgeslagen wijzigingen zijn",
COORDS0 = "Coördinaten laten beginnen bij 0 (zoals in interne scripting)",
ALLOWDEBUG = "Debugmodus inschakelen",
SHOWFPS = "FPS-teller tonen",
CHECKFORUPDATES = "Controleren op updates",
PAUSEDRAWUNFOCUSED = "Niet tekenen als het venster inactief is",
ENABLEOVERWRITEBACKUPS = "Reservekopie maken van levelbestanden die worden overschreven",
AMOUNTOVERWRITEBACKUPS = "Aantal reservekopieën om te bewaren per level",
SCALE = "Schaal",
LOADALLMETADATA = "Laad metadata (zoals titel, auteur en beschrijving) voor alle bestanden in de lijst met levels",
COLORED_TEXTBOXES = "Gebruik echte kleuren voor tekstvakken",
MOUSESCROLLINGSPEED = "Scrollsnelheid van muis",
BUMPSCRIPTSBYDEFAULT = "Verplaats scripts standaard naar de bovenkant van de lijst bij het bewerken",

SCRIPTSPLIT = "Splitsen",
SPLITSCRIPT = "Scripts splitsen",
COUNT = "Aantal: ",
SMALLENTITYDATA = "data",

-- Stats screen
AMOUNTSCRIPTS = "Scripts:",
AMOUNTUSEDFLAGS = "Vlaggen:",
AMOUNTENTITIES = "Entiteiten:",
AMOUNTTRINKETS = "Artefacten:",
AMOUNTCREWMATES = "Bemanningsleden:",
AMOUNTINTERNALSCRIPTS = "Interne scripts:",
TILESETUSSAGE = "Tilesetgebruik",
TILESETSONLYUSED = "(alleen kamers met blokken worden geteld)",
AMOUNTROOMSWITHNAMES = "Kamers met een naam:",
PLACINGMODEUSAGE = "Plaatsingsmodi:",
AMOUNTLEVELNOTES = "Levelnotities:",
AMOUNTFLAGNAMES = "Vlagnamen:",
TILESUSAGE = "Gebruik van blokken",
AMOUNTTILES = "Blokken:",
AMOUNTSOLIDTILES = "Vaste blokken:",
AMOUNTSPIKES = "Spijkers:",


UNEXPECTEDSCRIPTLINE = "Onverwachte scriptregel zonder script: $1",
DUPLICATESCRIPT = "Script $1 komt meerdere keren voor! Er kan er maar één geladen worden.",
MAPWIDTHINVALID = "Levelbreedte is ongeldig: $1",
MAPHEIGHTINVALID = "Levelhoogte is ongeldig: $1",
LEVMUSICEMPTY = "Levelmuziek is leeg!",
NOT400ROOMS = "Het aantal elementen in levelMetaData is niet 400!",
MOREERRORS = "nog $1",

DEBUGMODEON = "Debugmodus aan",
FPS = "FPS",
STATE = "Toestand",
MOUSE = "Muis",

BLUE = "Blauw",
RED = "Rood",
CYAN = "Cyaan",
PURPLE = "Paars",
YELLOW = "Geel",
GREEN = "Groen",
GRAY = "Grijs",
PINK = "Roze",
BROWN = "Bruin",
RAINBOWBG = "Regenbg-AG",

SYNTAXCOLORS = "Syntaxis-\nkleuren",
SYNTAXCOLORSETTINGSTITLE = "Scriptsyntaxiskleuren",
SYNTAXCOLOR_COMMAND = "Commando",
SYNTAXCOLOR_GENERIC = "Algemeen",
SYNTAXCOLOR_SEPARATOR = "Scheidingsteken",
SYNTAXCOLOR_NUMBER = "Getal",
SYNTAXCOLOR_TEXTBOX = "Tekst",
SYNTAXCOLOR_ERRORTEXT = "Onbekend commando",
SYNTAXCOLOR_CURSOR = "Cursor",
SYNTAXCOLOR_FLAGNAME = "Vlagnaam",
SYNTAXCOLOR_NEWFLAGNAME = "Nieuwe vlagnaam",
SYNTAXCOLOR_COMMENT = "Commentaar",
SYNTAXCOLOR_WRONGLANG = "Vereenvoudigd commando in int.sc-modus of andersom",
RESETCOLORS = "Kleuren resetten",
STRINGNOTFOUND = "\"$1\" kan niet worden gevonden",

-- L.MAL is concatenated with an error message
MAL = "Het levelbestand is niet in orde: ",

LOADSCRIPTMADE = "Laadscript gemaakt",
COPY = "Kopiëren",
CUSTOMSIZE = "Aangepaste kwastgrootte: $1x$2",
SELECTINGA = "Selecteren - klik op linkerbovenhoek",
SELECTINGB = "Selecteren: $1x$2",
TILESETSRELOADED = "Tilesets en sprites opnieuw geladen",

BACKUPS = "Reservekopieën",
BACKUPSOFLEVEL = "Reservekopieën van level $1",
LASTMODIFIEDTIME = "Oorspronkelijk laatst gewijzigd", -- List header
OVERWRITTENTIME = "Overschreven", -- List header
SAVEBACKUP = "Opslaan in VVVVVV-map",
DATEFORMAT = "Datumformaat",
TIMEFORMAT = "Tijdformaat",
SAVEBACKUPNOBACKUP = "Kies een unieke naam hiervoor als je niets wilt overschrijven, hiervoor wordt namelijk GEEN backup gemaakt!",

AUTOSAVECRASHLOGS = "Crashlogboeken automatisch opslaan",
MOREINFO = "Laatste info",
COPYLINK = "Link kopiëren",
SCRIPTDISPLAY = "Tonen",
SCRIPTDISPLAY_USED = "Gebruikt",
SCRIPTDISPLAY_UNUSED = "Ongebruikt",

RECENTLYOPENED = "Recent geopende levels",
REMOVERECENT = "Wil je het uit de lijst met recent geopende levels verwijderen?",
RESETCUSTOMBRUSH = "(Klik rechts om nieuwe grootte in te stellen)",

DISPLAYSETTINGS = "Beeld/Schaal",
DISPLAYSETTINGSTITLE = "Beeld-/Schaalinstellingen",
SMALLERSCREEN = "Kleinere vensterbreedte (800px breed in plaats van 896px)",
FORCESCALE = "Schaalinstellingen forceren",
SCALENOFIT = "Deze schaalinstellingen maken het venster te groot om te passen.",
SCALENONUM = "Deze schaalinstellingen zijn ongeldig.",
MONITORSIZE = "$1x$2-beeldscherm",
VEDRES = "Resolutie van Ved: $1x$2",
NONINTSCALE = "Schalen met niet-gehele getallen",

USEFONTPNG = "Gebruik font.png uit de graphics-map van VVVVVV als lettertype",
USELEVELFONTPNG = "Gebruik level-afhankelijke font.png als lettertype",
REQUIRESHIGHERLOVE = " (vereist LÖVE $1 of hoger)",
FPSLIMIT = "FPS-limiet",

MAPRESOLUTION = "Resolutie", -- Map export size
MAPRES_ASSHOWN = "Als weergegeven (max 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 per kamer)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 per kamer)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Linksboven",
WIDTHHEIGHT = "Breedte & hoogte",
BOTTOMRIGHT = "Rechtsonder",
RENDERERINFO = "Renderer-informatie:",
MAPINCOMPLETE = "De kaart is nog niet klaar (op het moment dat je op Opslaan klikte), probeer het opnieuw wanneer hij klaar is.",
KEEPDIALOGOPEN = "Houd dialoogvenster geopend",
TRANSPARENTMAPBG = "Transparante achtergrond",
MAPEXPORTERROR = "Fout bij het maken van de kaart.",
VIEWIMAGE = "Bekijken", -- Verb, view image
INVALIDLINENUMBER = "Voer een geldig regelnummer in.",
OPENLEVELSFOLDER = "Levelsmap openen", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Verplaatsen",
GOTOROOM = "Ga naar kamer",
ESCTOCANCEL = "[Druk op ESC om te annuleren]",

INVALIDFILENAME_WIN = "Windows staat de volgende tekens niet toe in bestandsnamen:\n\n: * ? \" < > |\n\n(waar | een verticale lijn is)",
INVALIDFILENAME_MAC = "macOS staat het teken : niet toe in bestandsnamen.",

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
SEARCHRESULTS_ROOMS = "Kamers [$1]",
SEARCHRESULTS_NOTES = "Notities [$1]",

ASSETS = "Bronbestanden", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Kan dit nummer niet afspelen. Het zou kunnen ontbreken of van een niet-ondersteund type kunnen zijn.",
SOUNDPLAYERROR = "Kan dit geluid niet afspelen. Het zou kunnen ontbreken of van een niet-ondersteund type kunnen zijn.",
MUSICLOADERROR = "Kan $1 niet laden: ",
MUSICLOADERROR_TOOSMALL = "Het muziekbestand is te klein om geldig te zijn.",
MUSICEXISTSYES = "Bestaat",
MUSICEXISTSNO = "Bestaat niet",
ASSETS_FOLDER_EXISTS_NO = "Bestaat niet - klik om aan te maken",
ASSETS_FOLDER_EXISTS_YES = "Bestaat - klik om te openen",
NO_ASSETS_SUBFOLDER = "Geen \"$1\"-map",
LOAD = "Laden",
RELOAD = "Herladen",
UNLOAD = "Ontladen",
MUSICEDITOR = "Muziekbewerker",
LOADMUSICNAME = ".vvv laden",
SAVEMUSICNAME = ".vvv opslaan",
INSERTSONG = "Nummer invoegen op positie $1",
SUREDELETESONG = "Weet je zeker dat je nummer $1 wilt verwijderen?",
SONGOPENFAIL = "Kon $1 niet openen, nummer is niet vervangen.",
SONGREPLACEFAIL = "Er ging iets fout bij het vervangen van het nummer.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "Je kunt niet het \"$1\"-teken in scriptnamen gebruiken!",
MUSICTITLE = "Titel: ",
MUSICARTIST = "Artiest: ",
MUSICFILENAME = "Bestandsnaam: ",
MUSICNOTES = "Notities:",
SONGMETADATA = "Metadata voor nummer $1",
MUSICFILEMETADATA = "Metadata van bestand",
MUSICEXPORTEDON = "Geëxporteerd: ", -- Followed by date and time
SAVEMETADATA = "Metadata opslaan",
SOUNDS = "Geluiden",
GRAPHICS = "Afbeeldingen",
FILEOPENERNAME = "Naam: ",
PATHINVALID = "Het pad is ongeldig.",
DRIVES = "Schijven", -- like C: or F: on Windows
DOFILTER = "Alleen *$1 tonen", -- "*.txt" for example
DOFILTERDIR = "Alleen mappen tonen",
FILEDIALOGLUV = "Sorry, je besturingssysteem wordt niet herkend, dus het bestandsdialoogvenster werkt niet.",
RESET = "Resetten",
CHANGEVERB = "Wijzigen", -- verb
LOADIMAGE = "Afbeelding laden",
GRID = "Raster",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "Het level moet worden opgeslagen voordat aangepaste bronbestanden kunnen worden gebruikt.",
CREATE_ASSETS_FOLDER = "Wil je een map maken voor aangepaste bronbestanden voor dit level?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "Het lijkt erop dat de VVVVVV-map niet bestaat. Wil je deze aanmaken?",
CREATE_LEVELS_FOLDER = "Het lijkt erop dat de levels-map niet bestaat. Wil je deze aanmaken?",
CREATE_FOLDER_FAIL = "Kan map niet aanmaken.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Bronbestandenmap voor $1",

OPAQUEROOMNAMEBACKGROUND = "Maak de zwarte achtergrond van kamernamen ondoorzichtig",
PLATVCHANGE_TITLE = "Platformsnelheid wijzigen",
PLATVCHANGE_MSG = "Snelheid:",
PLATVCHANGE_INVALID = "Je moet een getal invoeren.",
RENAMESCRIPTREFERENCES = "Verwijzingen hernoemen",
PLATFORMSPEEDSLIDER = "Tempo",

TRINKETS = "Artefacten",
LISTALLTRINKETS = "Alle artefacten", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Lijst met alle artefacten",
NOTRINKETSINLEVEL = "Er zijn geen artefacten in dit level.",
CREWMATES = "Bemanning",
LISTALLCREWMATES = "Alle leden", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Lijst met alle bemanningsleden",
NOCREWMATESINLEVEL = "Er zijn geen bemanningsleden in dit level.",
SHIFTROOMS = "Verschuif kamers", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 sec",
ROOMNUM = "Kamer $1",
SOUNDNUM = "Geluid $1",
TRACKNUM = "Nummer $1",
STOPSMUSIC = "Stopt muziek",
PLAYSOUND = "Geluid afspelen",
EDITSCRIPTWOBUMPING = "Script bewerken, niet naar boven verplaatsen",
EDITSCRIPTWBUMPING = "Script bewerken en naar boven verplaatsen",
CLICKONTHING = "Klik op $1",
ORDRAGDROP = "of sleep bestand hierheen", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Er is meer dan één startpunt in dit level!",
STARTPOINTNOTFOUND = "Er is geen startpunt!",

MAPBIGGERTHANSIZELIMIT = "Kaartgrootte $1 bij $2 is groter dan $3 bij $4!",
BTNOVERRIDE = "Omzeilen",
TARGETPLATFORM = "Doelplatform", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Races tegen de klok",
TIMETRIALTRINKETS = "Aantal artefacten",
TIMETRIALTIME = "Partijd",
SUREDELETETRIAL = "Weet je zeker dat je de race tegen de klok \"$1\" wilt verwijderen?",

CUT = "Knippen",
PASTE = "Plakken",
SELECTWORD = "Woord selecteren",
SELECTLINE = "Regel selecteren",
SELECTALL = "Alles selecteren",
INSERTRAWHEX = "Unicode-teken invoegen",
MOVELINEUP = "Regel naar boven verplaatsen",
MOVELINEDOWN = "Regel naar onder verplaatsen",
DUPLICATELINE = "Regel dupliceren",

WHEREPLACEPLAYER = "Waar wil je beginnen?",
YOUAREPLAYTESTING = "Je bent momenteel aan het testen",
LOCATEVVVVVV = "Selecteer je $1-applicatie", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Je bent al aan het testen!",
PLAYTESTINGFAILED = "Er ging iets mis bij het openen van VVVVVV:\n$1\n\nAls je de VVVVVV-applicatie die gebruikt wordt voor het testen moet wijzigen, houd dan Shift ingedrukt terwijl je op de testknop drukt.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV is afgesloten met code $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "Het lijkt erop dat je VVVVVV 2.2 of ouder gebruikt. Upgrade naar VVVVVV 2.3 of nieuwer.",
VVVVVV_SOMETHING_HAPPENED = "Er lijkt iets mis te zijn gegaan met VVVVVV.",
PLAYTESTUNAVAILABLE = "Sorry, je kunt niet testen op $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Selecteer het bestand genaamd '$1'.",

PLAYTESTINGOPTIONS = "Testen",
PLAYTESTING_EXECUTABLE_NOTSET = "Je hebt nog geen $1-applicatie ingesteld die gebruikt wordt om levels te testen.\nVed zal hier de eerste keer dat je een $2-level test om vragen.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "De $1-applicatie die gebruikt wordt om levels te testen is ingesteld op:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Sorry, er is iets misgegaan bij het proberen om VVVVVV te vinden. Probeer het pad naar het uitvoerbare bestand handmatig in te stellen.",
FIND_V_EXE_FOUNDERROR = "Er is iets gevonden dat op VVVVVV lijkt, maar het is niet gelukt om een bruikbaar pad ernaar te verkrijgen. Controleer of je niet een oude versie van het spel gebruikt (2.3 of nieuwer is vereist) of probeer het pad naar het uitvoerbare bestand handmatig in te stellen.",
FIND_V_EXE_NOTFOUND = "Het lijkt erop dat VVVVVV niet draait. Controleer of je VVVVVV geopend hebt en probeer het opnieuw.",
FIND_V_EXE_MULTI = "Er lijken meerdere exemplaren van VVVVVV tegelijk te draaien. Zorg dat je maar één versie van het spel open hebt en probeer het opnieuw.",

FIND_V_EXE_EXPLANATION = "Ved heeft VVVVVV nodig voor het testen, en het pad naar VVVVVV moet eerst worden ingesteld.\n\n\nOm VVVVVV automatisch te detecteren hoef je alleen het spel op te starten als het niet al draait en op \"Detecteren\" te drukken.",

VCE_REMOVED = "VVVVVV: Community Edition wordt niet meer onderhouden, en ondersteuning voor VVVVVV-CE levels is verwijderd uit Ved. Dit level wordt behandeld als een gewoon VVVVVV-level. Kijk voor meer informatie op https://vsix.dev/vce/status/",

VVVVVV_VERSION = "VVVVVV-versie", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Auto",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Alle plugins",
ALL_PLUGINS_MOREINFO = "Ga naar ¤https://tolp.nl/ved/plugins.php¤deze pagina¤ voor meer informatie over plugins.\\nLCl",
ALL_PLUGINS_FOLDER = "Je pluginsmap is:",
ALL_PLUGINS_NOPLUGINS = "Je hebt nog geen plugins.",

PLUGIN_NOT_SUPPORTED = "[Deze plugin wordt niet ondersteund omdat deze Ved $1 of hoger vereist!]\\r",
PLUGIN_AUTHOR_VERSION = "door $1, versie $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Laadscript maken",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Nee",
CREATE_LOAD_SCRIPT_RUNONCE = "Eenmalig",
CREATE_LOAD_SCRIPT_REPEATING = "Herhalend",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Geen laadscript maken",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Deze terminal zal rechtstreeks verwijzen naar het script.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Dit scriptvak zal rechtstreeks verwijzen naar het script.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Laadscript maken om eenmalig uit te voeren",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Deze terminal zal verwijzen naar een nieuw laadscript, dat het echte script maar één keer laadt. Ved zal een ongebruikte vlag kiezen.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Dit scriptvak zal verwijzen naar een nieuw laadscript, dat het echte script maar één keer laadt. Ved zal een ongebruikte vlag kiezen.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Herhalend laadscript maken",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Deze terminal zal verwijzen naar een nieuw laadscript, dat het echte script onvoorwaardelijk laadt.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Dit scriptvak zal verwijzen naar een nieuw laadscript, dat het echte script onvoorwaardelijk laadt.",

CUSTOM_SIZED_BRUSH = "Aangepaste kwast",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Kwast",
CUSTOM_SIZED_BRUSH_STAMP = "Stempel",
CUSTOM_SIZED_BRUSH_TILESET = "Tileset",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Aangepaste kwastgrootte",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Kies de grootte van de kwast die je nodig hebt.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stempel uit kamer",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Selecteer blokken uit de kamer om een stempel van te maken.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stempel uit tileset",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Selecteer blokken uit de tileset om een stempel van te maken. Werkt alleen in handmatige modus.",

ADVANCED_LEVEL_OPTIONS = "Geavanceerde levelopties",
ONEWAYCOL_OVERRIDE = "Herkleur eenrichtingsblokken ook in aangepaste bronbestanden (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Maak ZIP van deze versie om te delen", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "ZIP opslaan",
ZIP_BUSY_TITLE = "ZIP maken...",
ZIP_LOVE11_ONLY = "LÖVE $1 of hoger is vereist om een ZIP-bestand te maken", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP opgeslagen!",
ZIP_SAVING_FAIL = "ZIP-bestand kon niet worden opgeslagen!",

OPENFOLDER = "Map openen", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Levellettertype",

TEXTBOXCOLORS_BUTTON = "Tekstkleuren",
TEXTBOXCOLORS_TITLE = "Kleuren voor tekstvakken",
TEXTBOXCOLORS_RENAME = "Kleur \"$1\" hernoemen",
TEXTBOXCOLORS_DUPLICATE = "Kleur \"$1\" dupliceren",
TEXTBOXCOLORS_CREATE = "Nieuwe kleur toevoegen",

LIB_LOAD_ERRMSG_BIDI = "De bibliotheek met ondersteuning voor tekst van rechts naar links kan niet worden geladen.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nHet kan zijn dat je antivirus dit stukmaakt.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Je hebt $1 plugin die niet wordt ondersteund in deze versie.",
		[1] = "Je hebt $1 plugins die niet worden ondersteund in deze versie.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Bij $1 test is een probleem geconstateerd bij dit level. Het probleem kan al automatisch zijn opgelost, maar het is nog steeds mogelijk dat dit crashes of inconsistenties zal veroorzaken.",
		[1] = "Bij $1 tests zijn problemen geconstateerd bij dit level. De problemen kunnen al automatisch zijn opgelost, maar het is nog steeds mogelijk dat dit crashes of inconsistenties zal veroorzaken.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 keer gebruikt in kamers: $2",
		[1] = "$1 keer gebruikt in kamers: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 keer gebruikt in scripts: $2",
		[1] = "$1 keer gebruikt in scripts: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Entiteit op [$1 $2] heeft $3 ongeldige eigenschap!",
		[1] = "Entiteit op [$1 $2] heeft $3 ongeldige eigenschappen!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata voor kamer $1,$2 heeft $3 ongeldige eigenschap!",
		[1] = "LevelMetadata voor kamer $1,$2 heeft $3 ongeldige eigenschappen!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "$1 wordt getoond",
		[1] = "$1 worden getoond",
	},
	FLAGUSAGES = {
		[0] = "$1 keer gebruikt in scripts: $2",
		[1] = "$1 keer gebruikt in scripts: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 blok is geen geldig geheel getal groter dan of gelijk aan 0",
		[1] = "$1 blokken zijn geen geldig geheel getal groter dan of gelijk aan 0",
	},
	BYTES = {
		[0] = "$1 byte",
		[1] = "$1 bytes",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 afbeelding aangepast",
		[1] = "$1 afbeeldingen aangepast",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 geluidseffect aangepast",
		[1] = "$1 geluidseffecten aangepast",
	},
}

toolnames = {

"Muur",
"Achtergrond",
"Spijker",
"Artefact",
"Checkpoint",
"Brekend platform",
"Lopende band",
"Bewegend platform",
"Vijand",
"Zwaartekrachtlijn",
"Tekst",
"Terminal",
"Scriptvak",
"Teleportatietoken",
"Wikkellijn",
"Bemanningslid",
"Startpunt",

}

subtoolnames = {

[1] = {"1x1-kwast", "3x3-kwast", "5x5-kwast", "7x7-kwast", "9x9-kwast", "Vul horizontaal", "Vul verticaal", "Aangepaste kwastgrootte", "Opvullen", "Aardappel voor het doen van dingen die magisch zijn"},
[2] = {},
[3] = {"Auto 1", "Automatisch uitbreiden L+R", "Automatisch uitbreiden L", "Automatisch uitbreiden R"},
[4] = {},
[5] = {"Rechtop", "Ondersteboven"},
[6] = {},
[7] = {"Klein R", "Klein L", "Groot R", "Groot L"},
[8] = {"Omlaag", "Omhoog", "Links", "Rechts"},
[9] = {},
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
[3] = "A",

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
short5 = "Toren",
long5 = "Toren",

}

ERR_VEDHASCRASHED = "Ved is gecrasht!"
ERR_VEDVERSION = "Ved-versie:"
ERR_LOVEVERSION = "LÖVE-versie:"
ERR_STATE = "Toestand:"
ERR_OS = "Besturingssysteem:"
ERR_TIMESINCESTART = "Tijd sinds opstarten:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(niet geladen)"
ERR_PLUGINSNONE = "(geen)"
ERR_PLEASETELLDAV = "Vertel Dav999 alsjeblieft over dit probleem.\n\n\nDetails: (druk Ctrl/Cmd+C om naar het klembord te kopiëren)\n\n"
ERR_INTERMEDIATE = " (tussenversie)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (te nieuw)"

ERR_PLUGINERROR = "Pluginfout!"
ERR_FILE = "Bestand om te bewerken:"
ERR_FILEEDITORS = "Plugins die dit bestand bewerken:"
ERR_CURRENTPLUGIN = "Plugin die de fout heeft veroorzaakt:"
ERR_PLEASETELLAUTHOR = "Een plugin moest een wijziging aanbrengen in code in Ved, maar de te vervangen code werd niet gevonden.\nHet is mogelijk dat dit wordt veroorzaakt door een conflict tussen twee plugins, of een update van Ved heeft deze plugin onbruikbaar gemaakt.\n\nDetails: (druk Ctrl/Cmd+C om naar het klembord te kopiëren)\n\n"
ERR_CONTINUE = "Je kunt verdergaan door op ESC of enter te drukken, maar wees bewust dat deze mislukte bewerking voor problemen kan zorgen."
ERR_OPENPLUGINSFOLDER = "Je kunt je pluginsmap openen door op F te drukken, zodat je de problematische plugin kunt repareren of verwijderen. Herstart daarna Ved."
ERR_REPLACECODE = "Kon dit niet vinden in %s.lua:"
ERR_REPLACECODEPATTERN = "Kon dit niet vinden in %s.lua (als pattern):"
ERR_LINESTOTAL = "%i regels in totaal"

ERR_SAVELEVEL = "Om een kopie van je level op te slaan, druk op S"
ERR_SAVESUCC = "Level succesvol opgeslagen als %s!"
ERR_SAVEERROR = "Fout bij het opslaan! %s"
ERR_LOGSAVED = "Meer informatie is te vinden in het crashlogboek:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Leveleigenschappen",
		changedrooms = "Gewijzigde kamers",
		changedroommetadata = "Kamermetadata",
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
		changed1 = "($1,$2) ($3) gewijzigd\\Y",
		changed2 = "($1,$2) ($3 -> $4) gewijzigd\\Y",
		cleared1 = "Alle blokken in ($1,$2) ($3) weggehaald\\R",
		cleared2 = "Alle blokken in ($1,$2) ($3 -> $4) weggehaald\\R",
	},
	roommetadata = {
		changed0 = "Kamer $1,$2:",
		changed1 = "Kamer $1,$2 ($3):",
		roomname = "Naam van kamer veranderd van \"$1\" naar \"$2\"\\Y",
		roomnameremoved = "Naam van kamer \"$1\" verwijderd\\R",
		roomnameadded = "Naam aan kamer gegeven: \"$1\"\\G",
		tileset = "Tileset $1 tilecol $2 veranderd naar tileset $3 tilecol $4\\Y",
		platv = "Platformsnelheid veranderd van $1 naar $2\\Y",
		enemytype = "Vijandtype veranderd van $1 naar $2\\Y",
		platbounds = "Platformbegrenzing veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
		enemybounds = "Vijandbegrenzing veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
		directmode01 = "Direct mode aangezet\\G",
		directmode10 = "Direct mode uitgezet\\R",
		warpdir = "Warprichting veranderd van $1 naar $2\\Y",
	},
	entities = {
		added = "Entiteit van type $1 toegevoegd op positie $2,$3 in kamer ($4,$5)\\G",
		removed = "Entiteit van type $1 verwijderd van positie $2,$3 in kamer ($4,$5)\\R",
		changed = "Entiteit van type $1 op positie $2,$3 in kamer ($4,$5) gewijzigd\\Y",
		changedtype = "Entiteit van type $1 veranderd naar type $2 op positie $3,$4 in kamer ($5,$6)\\Y",
		multiple1 = "Entiteiten op positie $1,$2 in kamer ($3,$4) gewijzigd:\\Y",
		multiple2 = "naar:",
		addedmultiple = "Entiteiten toegevoegd op positie $1,$2 in kamer ($3,$4):\\G",
		removedmultiple = "Entiteiten verwijderd van positie $1,$2 in kamer ($3,$4):\\R",
		entity = "Type $1",
		incomplete = "Niet alle entiteiten zijn verwerkt! Rapporteer dit alsjeblieft aan Dav.\\r",
	},
	scripts = {
		added = "Script \"$1\" toegevoegd\\G",
		removed = "Script \"$1\" verwijderd\\R",
		edited = "Script \"$1\" bewerkt\\Y",
	},
	flagnames = {
		added = "Naam aan vlag $1 gegeven: \"$2\"\\G",
		removed = "Naam \"$1\" voor vlag $2 verwijderd\\R",
		edited = "Naam voor vlag $1 veranderd van \"$2\" naar \"$3\"\\Y",
	},
	levelnotes = {
		added = "Levelnotitie \"$1\" toegevoegd\\G",
		removed = "Levelnotitie \"$1\" verwijderd\\R",
		edited = "Levelnotitie \"$1\" bewerkt\\Y",
	},
	mde = {
		added = "Metadata-entiteit is toegevoegd.\\G",
		removed = "Metadata-entiteit is verwijderd.\\R",
	},
}

