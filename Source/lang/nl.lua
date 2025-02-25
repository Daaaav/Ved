-- Language file for Ved
--- Language: nl (nl)
--- Last converted: 2025-01-21 16:25:05 (CET)

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
	if c == "é" or c == "ë" then
		return "e"
	elseif c == "ö" or c == "Ö" then
		return "{"
	elseif c == "ó" then
		return "o"
	elseif c == "ï" then
		return "i"
	elseif c == "ü" then
		return "u"
	end
end

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Deze versie van LÖVE is verouderd. De minimale versie is 0.9.1.\nJe kunt de laatste versie van LÖVE downloaden op https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ondersteunt LÖVE 0.9.0 niet meer. Gelukkig blijft LÖVE 0.9.1 en hoger werken.\nJe kunt de laatste versie van LÖVE downloaden op https://love2d.org/.",

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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "Het levelbestand is niet in orde: ",
METADATACORRUPT = "Metadata ontbreekt of is corrupt.",
METADATAITEMCORRUPT = "Metadata voor $1 ontbreekt of is corrupt.",
TILESCORRUPT = "Data voor blokken ontbreekt of is corrupt.",
ENTITIESCORRUPT = "Data voor entiteiten ontbreekt of is corrupt.",
LEVELMETADATACORRUPT = "Kamermetadata ontbreekt of is corrupt.",
SCRIPTCORRUPT = "Scripts ontbreken of zijn corrupt.",

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
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
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

CONFIRMBIGGERSIZE = "Je hebt $1 bij $2 gekozen, wat groter is dan $3 bij $4. Buiten de normale kaart van $3 bij $4 zullen kamers en eigenschappen daarvan zich om de kaart wikkelen, maar verstoord. Je krijgt geen nieuwe kamers en ook geen nieuwe kamereigenschappen.\n\nDruk op Ja als je weet wat je doet en deze grotere grootte wil. Druk op Nee om de kaartgrootte in te stellen op $5 bij $6.\n\nAls je het niet zeker weet, druk op Nee.",
MAPBIGGERTHANSIZELIMIT = "Kaartgrootte $1 bij $2 is groter dan $3 bij $4! (Ondersteuning voor groter dan $3 bij $4 niet ingeschakeld)",
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
	LITERALNULLS = {
		[0] = "Er is $1 nulbyte!",
		[1] = "Er zijn $1 nulbytes!",
	},
	XMLNULLS = {
		[0] = "Er is $1 XML-nulteken!",
		[1] = "Er zijn $1 XML-nultekens!",
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
subj = "Aan de slag",
imgs = {},
cont = [[
Aan de slag\wh#
\C=

Dit artikel zal je helpen om te beginnen met werken met Ved. Om naar de editor te
gaan, moet je een level laden, of een nieuwe maken.


De editor\h#

Aan de linkerkant staan de verschillende gereedschappen. De meeste gereedschappen
hebben sub-gereedschappen die rechts ervan worden weergegeven. Om tussen
gereedschappen te schakelen kun je de bijbehorende snelkoppelingen gebruiken of
scrollen met Shift of Ctrl ingedrukt. Om tussen sub-gereedschappen te schakelen
kun je overal scrollen. Kijk voor meer informatie over de gereedschappen op de
Gereedschap¤-helppagina.\wl
Je kunt op entiteiten klikken met de rechtermuisknop voor een menu met acties voor
die entiteit. Om entiteiten te verwijderen zonder dat menu te gebruiken kun je er
rechts op klikken met Shift ingedrukt.
Aan de rechterkant van het scherm staan veel knoppen en opties. De bovenste
knoppen zijn voor het hele level, de onderste knoppen (onder Kamer-opties) zijn
specifiek voor de huidige kamer. Kijk voor meer informatie over deze knoppen op de
helppagina's ervoor, waar beschikbaar.

Levels-map\h#

Ved zal normaal gesproken dezelfde map gebruiken voor het opslaan van levels als
VVVVVV, dus het is makkelijk om te wisselen tussen de level-editor in VVVVVV en
Ved. Als Ved je levels-map niet juist herkent, kun je zelf een pad invullen in de
Ved-opties.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Plaatsingsmodi",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Plaatsingsmodi\wh#
\C=

Ved ondersteunt drie verschillende modi om muren te tekenen.

     Automatische modus\h#0

          Dit is de modus die het makkelijkst te gebruiken is. In deze stand kun
          je muren en achtergronden tekenen, en de hoekpunten en zijkanten zullen
          automatisch goed afgewerkt worden. Het is in deze stand echter niet
          mogelijk om meerdere verschillende tilesets of kleuren te gebruiken.


     Multi-tileset-modus\h#1

          Dit lijkt op de automatische modus, behalve dat je meerdere
          verschillende tilesets in dezelfde kamer kunt gebruiken. Dat wil zeggen,
          als je van tileset verandert zullen bestaande muren en achtergronden
          niet veranderd worden, en je kunt in meerdere verschillende kleuren
          tekenen in dezelfde kamer.

     Handmatige modus\h#2

          Ook wel bekend als Direct Mode, in deze modus kun je alles handmatig
          plaatsen, dus je zit niet vast aan de ingebouwde tileset-combinaties en
          hoekpunten en zijkanten zullen niet automatisch afgewerkt worden,
          waardoor je de volledige controle hebt over hoe de kamer eruit zal zien.
          Het kost meestal echter meer tijd om in deze modus te werken.
]]
},

{
splitid = "030_Tools",
subj = "Gereedschap",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Gereedschap\wh#
\C=

Je kunt de volgende gereedschappen gebruiken om kamers te vullen in je level:

\0
   Muur\h#


Hiermee kun je muren plaatsen.

\1
   Achtergrond\h#


Hiermee kun je achtergronden plaatsen.

\2
   Spijker\h#


Hiermee kun je spijkers plaatsen. Je kunt de sub-gereedschappen voor automatisch
uitbreiden gebruiken om spijkers te plaatsen op een oppervlak met één klik (of
verschuiving).

\3
   Artefact\h#


Hiermee kun je artefacten plaatsen. Bedenk dat er maximaal honderd artefacten in
een level geplaatst kunnen worden.

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
   Bewegend platform\h#


Hiermee kun je verplaatsende platforms plaatsen.

\8
   Vijand\h#


Hiermee kun je vijanden plaatsen. De vorm en kleur van de vijand wordt bepaald
door respectievelijk de instellingen voor vijand-type en tileset(-kleur).

\9
   Zwaartekrachtlijn\h#


Hiermee kun je zwaartekrachtlijnen plaatsen.

\^0
   Tekst\h#


Hiermee kun je tekst plaatsen.


\^1
   Terminal\h#


Hiermee kun je terminals plaatsen. Plaats eerst de terminal, typ vervolgens een
naam voor het script. Kijk voor meer informatie over scripts naar de lijsten met
scriptcommando's.

\^2
   Scriptvak\h#


Hiermee kun je scriptvakken plaatsen. Klik eerst op de linkerbovenhoek, dan op de
rechteronderhoek, en typ vervolgens een naam voor het script. Kijk voor meer
informatie over scripts naar de lijsten met scriptcommando's.

\^3
   Teleportatietoken\h#


Hiermee kun je teleportatietokens plaatsen. Klik eerst op de plek waar de ingang
moet komen te staan, dan waar de uitgang moet komen te staan.

\^4
   Wikkellijn\h#


Hiermee kun je wikkellijnen plaatsen. Bedenk dat wikkellijnen alleen aan de
randen van een kamer geplaatst kunnen worden.

\^5
   Bemanningslid\h#


Hiermee kun je bemanningsleden plaatsen die gered kunnen worden. Wanneer alle
bemanningsleden worden gered, eindigt het level. Bedenk dat er maximaal honderd
bemanningsleden in een level geplaatst kunnen worden.

\^6
   Startpunt\h#


Hiermee kun je het startpunt plaatsen.
]]
},
{
splitid = "040_Script_editor",
subj = "Scriptbewerker",
imgs = {},
cont = [[
Scriptbewerker\wh#
\C=

Met de scriptbewerker kun je scripts in je level beheren en bewerken.


Vlagnamen\h#

Voor het gemak en de leesbaarheid van scripts is het mogelijk om namen te
gebruiken voor vlaggen in plaats van nummers. Als je een naam gebruikt in plaats
van een nummer, zal automatisch op de achtergrond een nummer worden toegewezen aan
die naam. Het is ook mogelijk om te kiezen welk vlagnummer gebruikt moet worden
voor welke naam.

Interne scripting-modus\h#

Om interne scripting te gebruiken in Ved kun je interne scripting-modus
inschakelen, om alle commando's in dat script te laten werken als interne
commando's. Zie ¤Int.sc-modus¤ voor meer informatie over interne scripting-modus.\nwl
Kijk voor meer informatie over interne scripting naar de lijst met interne
scriptcommando's.

Scripts splitsen\h#

Het is mogelijk om een script in tweeën te splitsen met de scriptbewerker. Nadat
je de tekstcursor op de eerste regel hebt gezet die je naar het nieuwe script wilt
verplaatsen, klik op de "Splits"-knop en typ de naam van het nieuwe script. De
regels voor de cursor blijven in het oorspronkelijke script, de regel waar de
cursor staat en alle regels daarna zullen verplaatst worden naar het nieuwe
script.

Naar scripts springen\h#

Op regels met een van de commando's iftrinkets, ifflag, customiftrinkets of
customifflag, is het mogelijk om naar het gegeven script te springen door te
klikken op de knop "Ga naar" wanneer de cursor op die regel staat. Je kunt
hiervoor ook op ¤Alt+rechts¤ drukken, en je kunt met ¤Alt+links¤ één stap terug\nwnw
nemen door de keten naar waar je vandaan kwam.
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Int.sc-modus",
imgs = {},
cont = [[
Interne scripting-modus\wh#
\C=

Om interne scripting te gebruiken in Ved kun je interne scripting-modus
inschakelen, om alle commando's in dat script te laten werken als interne
commando's. Met deze functie hoef je je niet veel zorgen te maken om interne
scripting aan de praat te krijgen; je hoeft geen ¤say¤-commando's te gebruiken,\nw
regels te tellen, of ¤text(1,0,0,4)¤ of ¤text,,,,4¤ of waar je voorkeur ook naar uit\nwnw
gaat te typen - je kunt gewoon interne scripts schrijven alsof ze bedoeld zijn
voor het echte spel. Je hoeft niet eens te eindigen met een ¤loadscript¤-commando.\nw

Ved ondersteunt verschillende methoden van interne scripting. Om hun technische
verschillen te tonen gebruiken we het volgende voorbeeldscript:

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

Regels van dit interne script zijn ¤lichtgroen¤, regels die automatisch worden\nG
toegevoegd en die nodig zijn om het script te laten werken zullen ¤grijs¤ zijn. Merk\ng
op dat dit een beetje vereenvoudigd is; Ved voegt ¤#v¤ toe aan het einde van de\nw
grijze regels in de voorbeelden om te zorgen dat handmatig geschreven scripts niet
zomaar aangepast zullen worden, en ¤say¤-blokken die te groot zijn moeten worden\nw
opgesplitst in kleinere stukjes.

Kijk voor meer informatie over interne scripting naar de lijst met interne
scriptcommando's.

Laadscript-int.sc\h#

De laadscript-methode is waarschijnlijk de meest gebruikte methode vandaag de dag.
Het is de methode die Ved al ondersteunt sinds een alfa-versie.

Dit heeft een extra script nodig, het laadscript, om het interne script te laden.
Het laadscript zal, in de meest basale vorm, een commando bevatten zoals
iftrinkets(0,jouwscript)¤, maar kan ook andere vereenvoudigde commando's bevatten,\w
en je kunt ook ¤ifflag¤ gebruiken in plaats van ¤iftrinkets¤. Wat belangrijk is is dat\nwnw
je interne script vanuit een ander script wordt geladen om het te laten werken.

Het interne script zal min of meer als volgt geconverteerd worden:

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

text(1,0,0,3)¤ moet de laatste regel zijn, of in de scriptbewerker van VVVVVV moet\w
er precies één lege regel onder staan.

Het is ook mogelijk om ¤squeak(off)¤ niet te gebruiken, en ¤text(1,0,0,4)¤ te\nwnw
gebruiken in plaats van ¤text(1,0,0,3)¤. Met ¤squeak(off)¤ worden echter een paar\nwnw
waardevolle regels bespaard in langere scripts.

say(-1)-int.sc\h#

De say(-1)-methode is ouder, en heeft een nadeel ten opzichte van de laadscript-
methode: er zullen altijd cutscene-balken verschijnen. Maar het heeft ook een
voordeel dat belangrijk kan zijn in levels met veel scripts: het heeft geen
laadscript nodig. We kunnen ¤cutscene()¤ en ¤untilbars()¤ uit ons script weglaten,\nwnw
omdat deze al worden toegevoegd door VVVVVV als je deze methode gebruikt.

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

Deze methode is toegevoegd als een extra interne scripting-modus in Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Snelkoppelingen",
imgs = {},
cont = [[
Snelkoppelingen\wh#
\C=

Tip: je kunt overal in Ved ¤F9¤ ingedrukt houden om veel van de snelkoppelingen te\nC
zien.

De meeste snelkoppelingen die in VVVVVV gebruikt kunnen worden kunnen ook worden
gebruikt in Ved.

F1¤  Tileset veranderen\C
F2¤  Kleur veranderen\C
F3¤  Vijanden veranderen\C
F4¤  Vijand-grenzen\C
F5¤  Platform-grenzen\C

F10¤  Handmatige/automatische modus (direct mode/niet-direct mode)\C

W¤  Warprichting veranderen\C
E¤  Kamernaam veranderen\C

L¤  Level laden\C
S¤  Level opslaan\C

Z¤  3x3-kwast (muren en achtergronden)\C
X¤  5x5-kwast (")\C

< ¤en¤ >¤  tussen gereedschap schakelen\CnC
Ctrl/Cmd+< ¤en¤ Ctrl/Cmd+>¤  tussen sub-gereedschap schakelen\CnC

Meer snelkoppelingen\h#

Ved introduceert ook een paar snelkoppelingen.

Hoofd-editor\gh#

Ctrl+P¤  Ga naar de kamer met het startpunt\C
Ctrl+S¤  Snel opslaan\C
Ctrl+X¤  Kamer naar het klembord knippen\C
Ctrl+C¤  Kamer naar het klembord kopiëren\C
Ctrl+V¤  Kamer van het klembord plakken (indien geldig)\C
Ctrl+D¤  Dit level met een ander level vergelijken\C
Ctrl+Z¤  Ongedaan maken\C
Ctrl+Y¤  Herhalen\C
Ctrl+F¤  Zoeken\C
Ctrl+/¤  Level-kladblok\C
Ctrl+F1¤  Help\C
(LET OP: Gebruik op Mac Cmd in plaats van Ctrl)
N¤  Nummers van alle blokken tonen\C
J¤  Soliditeit van blokken tonen\C
;¤  Minikaart-tegels tonen\C
Shift+;¤  Achtergrond tonen\C
M¤ of ¤Toetsenblok 5¤  Kaart tonen\CnC
G¤  Naar kamer gaan (typ coördinaten in als vier cijfers)\C
/¤  Scripts\C
[¤  Y van muis vastzetten (om makkelijker horizontale lijnen te tekenen)\C
]¤  X van muis vastzetten (om makkelijker verticale lijnen te tekenen)\C
F11¤  tilesets en sprites opnieuw laden\C

Entiteiten\gh#

Shift+klik rechts¤  Entiteit verwijderen\C
Alt+klik¤           Entiteit verplaatsen\C
Alt+Shift+klik¤     Entiteit kopiëren\C

Scriptbewerker\gh#

Ctrl+F¤  Zoeken\C
Ctrl+G¤  Ga naar regel\C
Ctrl+I¤  Schakel internescriptmodus in/uit\C
Alt+rechts¤  Spring naar script in voorwaardelijk commando\C
Alt+links¤  Spring één stap terug\C

Scriptlijst\gh#

N¤  Nieuw script maken\C
F¤  Ga naar vlaggenlijst\C
/¤  Ga naar bovenste/laatste script\C
]]
},

{
splitid = "070_Simp_script_reference",
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
argument kan een kleur zijn, of de naam van een bemanningslid.
Als je een kleur gebruikt en er is een bemanningslid dat gered kan worden in de
kamer, zal het tekstvak boven dat bemanningslid worden weergegeven.

reply¤([regels])\h#w

Toon een tekstvak voor Viridian. Zonder het regels-argument zal dit een tekstvak
met één regel maken.

delay¤(n)\h#w

Pauzeer het script voor n ticks. 30 ticks is bijna een seconde.

happy¤([bemanningslid])\h#w

Maakt een bemanningslid blij. Zonder een argument zal dit Viridian blij maken. Je
kunt ook "all", "everyone" of "everybody" gebruiken als een argument om iedereen
blij te maken.

sad¤([bemanningslid])\h#w

Maakt een bemanningslid verdrietig. Zonder een argument zal dit Viridian
verdrietig maken. Je kunt ook "all", "everyone" of "everybody" gebruiken als een
argument om iedereen verdrietig te maken.

Opmerking: dit commando kan ook worden geschreven als ¤cry¤ in plaats van ¤sad¤.\nwnw

flag¤(vlag,on/off)\h#w

Zet een bepaalde vlag aan of uit. flag(4,on) zal bijvoorbeeld vlag 4 aanzetten.
Er zijn 100 vlaggen, genummerd van 0 tot 99.
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

Als je aantal artefacten >= aantal, ga naar script met naam scriptnaam.
Als je aantal artefacten < aantal, ga dan verder in het huidige script.
Voorbeeld:
iftrinkets(3,enoughtrinkets) - Als je 3 of meer artefacten hebt zal het script
                               "enoughtrinkets" worden uitgevoerd, anders zal het
                               huidige script verdergaan.
Het is gebruikelijk om 0 als minimum aantal artefacten te gebruiken, om een script
altijd te laden.

iftrinketsless¤(aantal,scriptnaam)\h#w

Als je aantal artefacten < aantal, ga naar script met naam scriptnaam.
Als je aantal artefacten >= aantal, ga dan verder in het huidige script.

destroy¤(iets)\h#w

Verwijder alle objecten van het gegeven type, totdat je opnieuw de kamer
binnenkomt.

Geldige argumenten kunnen zijn:
warptokens - Teleportatietokens
gravitylines - Zwaartekrachtlijnen
platforms - Werkt niet goed
moving - Bewegende platformen (toegevoegd in 2.4)
disappear - Brekende platformen (toegevoegd in 2.4)

music¤(nummer)\h#w

Verander de muziek naar een bepaald nummer.
Kijk voor de lijst van muzieknummers naar het artikel "Lijsten".

playremix\h#w

Speelt de remix van Predestined Fate als muziek.

flash\h#w

Laat het scherm flitsen, maakt een geluid van een knal en schudt het scherm even.

map¤(on/off)\h#w

Zet de kaart aan of uit. Als je de kaart uitzet wordt er "NO SIGNAL" getoond tot
je hem weer aanzet. Kamers zullen nog steeds onthuld worden terwijl de kaart
uitstaat en zichtbaar worden wanneer je de kaart weer aanzet.

squeak¤(bemanningslid/on/off)\h#w

Zorgt dat een bemanningslid een geluid maakt, of zet het tekstvak-geluid aan of
uit.

speaker¤(color)\h#w

Verandert de kleur en positie van de volgende tekstvakken gemaakt met het "say"-
commando. Dit kan worden gebruikt in plaats van het tweede argument voor "say".

warpdir¤(x,y,richting)\w#h

Verandert de warprichting voor kamer x,y, beginnend bij 1, naar de aangegeven
richting. Dit kan worden gecontroleerd met ifwarp, wat zorgt voor een relatief
krachtig extra vlaggen-/variabelesysteem.

x - x-coördinaat van kamer, beginnend bij 1
y - y-coördinaat van kamer, beginnend bij 1
richting - De warprichting. Normaal gesproken 0-3, maar waarden daarbuiten worden
geaccepteerd

ifwarp¤(x,y,richting,script)\w#h

Als de warprichting voor kamer x,y, beginnend bij 1, is ingesteld op richting, ga
naar (vereenvoudigd) script

x - x-coördinaat van kamer, beginnend bij 1
y - y-coördinaat van kamer, beginnend bij 1
richting - De warprichting. Normaal gesproken 0-3, maar waarden daarbuiten worden
geaccepteerd

loadtext¤(taal)\w#h

Laad een vertaling voor het level aan de hand van een taalcode. Gebruik een lege
waarde om de taal van VVVVVV weer te gebruiken.

language - Een taalcode, zoals nl of pt_BR

iflang¤(taal,script)\w#h

Als de taal van VVVVVV is ingesteld op de gegeven taal, ga naar een script. Dit
wordt niet beïnvloed door de taal die je aan loadtext() kunt geven, alleen welke
taal de gebruiker heeft geselecteerd in het menu.

setfont¤(lettertype)\w#h

Wijzig het lettertype dat wordt gebruikt voor tekst in het level. Dit kan een
lettertype zijn dat meegeleverd wordt met het spel, zoals font_ja voor Japans, of
een lettertype dat meegeleverd is met het level. Laat leeg om terug te gaan naar
het standaardlettertype van het level.

setrtl¤(on/off)\w#h

Schakel in spelerlevels of het lettertype RTL (rechts-naar-links) is of niet.
Standaard is het lettertype niet RTL (het is dus links-naar-rechts).

RTL-modus zorgt vooral dat tekstvakken rechts uitgelijnd zijn, voor talen zoals
Arabisch.

textcase¤(case)\w#h

Als je level vertaalbestanden heeft, en je hebt meerdere tekstvakken met dezelfde
tekst in een enkel script, kan dit commando ze unieke vertalingen laten hebben.
Zet het voor een tekstvak.

case - Een getal tussen 1 en 255
]]
},

{
splitid = "080_Int_script_reference",
subj = "Interne scripting",
imgs = {},
cont = [[
Interne scripting\wh#
\C=

De interne scripting geeft scripters meer controle, maar is ook een beetje
complexer dan vereenvoudigde scripting.

Om interne scripting te gebruiken in Ved kun je interne scripting-modus
inschakelen, om alle commando's in dat script te laten werken als interne
commando's.

Kleurcodes:\w
Normaal - Zou veilig moeten zijn, in het ergste geval zou VVVVVV kunnen crashen
          omdat je een fout hebt gemaakt.
Blauw¤   - Niet al deze commando's werken in aangepaste levels, andere zijn niet\b
          echt logisch in aangepaste levels, of zijn maar voor de helft nuttig
          omdat ze echt zijn ontworpen voor het echte spel.
Oranje¤  - Deze werken en normaal gesproken zal er niks fout gaan, tenzij je er\o
          heel specifieke argumenten aan geeft die je opgeslagen data laten
          verdwijnen.
Rood¤    - Rode commando's moeten niet gebruikt worden in levels omdat ze ofwel\r
          bepaalde delen van het hoofdspel ontgrendelen (waarvan je niet moet
          willen dat een level het doet, ook al zeg je dat iedereen het spel al
          uitgespeeld heeft), of maken de opgeslagen data helemaal corrupt.


activateteleporter¤()\w#h

Activeer de eerste teleport in de kamer, waardoor deze kleurrijk zal flitsen,
en op een rare manier zal animeren.

De ¤tile¤ van de teleport wordt 6, en de ¤color¤ wordt 102. Dit commando zorgt ervoor\gn&Zgn&Zg
dat de teleport niets doet als hij wordt aangeraakt, omdat het blok ervan iets\g
anders is dan ¤1§¤.\gn&Zg(

activeteleporter¤()\w#h

Maakt de eerste teleport in de kamer wit, oftewel kleur ¤101¤.\nn&Z

Dit commando zal het blok niet aanpassen, dus het heeft geen invloed op de\g
functionaliteit.\g

alarmoff\w#h

Zet het alarm uit.

alarmon\w#h

Zet het alarm aan.

altstates¤(toestand)\b#h

Verander de layout van sommige kamers, namelijk de artefactenkamer in het schip
voor en na de explosie, en de ingang van het geheime lab (aangepaste levels
ondersteunen altstates helemaal niet).

In de code verandert dit de globale variabele ¤altstates¤.\gn&Zg

audiopause¤(on/off)\w#h

Schakelt het pauzeren van de audio wanneer het venster inactief is geforceerd
in of uit, ongeacht de gebruikersinstelling voor het pauzeren van audio.
Standaard uitgeschakeld, oftewel pauzeer audio tijdens het automatische
pauzescherm.

Dit commando is toegevoegd in 2.3.\g

backgroundtext\w#h

Laat het volgende tekstvak niet wachten voordat je op ACTIE drukt om door te gaan
met het script. Dit wordt vooral gebruikt om meerdere tekstvakken tegelijk weer
te geven.

befadein¤()\w#h

Stop een fade onmiddelijk, zoals van ¤#fadeout()¤fadeout¤ of ¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z

blackon¤()\w#h

Hervat het beeld als het was gepauzeerd door ¤#blackout()¤blackout¤.\nLwl&Z

blackout¤()\w#h

Pauzeert het beeld.

Gebruik tegelijkertijd ¤#shake(n)¤shake¤ om het scherm zwart te maken.\gLwl&Zg

bluecontrol\b#h

Start een gesprek met Victoria net zoals wanneer je haar in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

changeai¤(bemanningslid,ai1,ai2)\w#h

Kan de gezichtsrichting van een bemanningslid veranderen of het loopgedrag

bemanningslid - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceleft/faceright/followposition,ai2
ai2 - nodig als followposition gebruikt wordt voor ai1

faceplayer¤ ontbreekt, gebruik in plaats daarvan 18. ¤panic¤ werkt ook niet,\n&Zgn&Zg
daarvoor is ¤20¤ nodig.\gn&Zg

changecolour¤(a,b)\w#h

Verandert de kleur van een bemanningslid. Dit commando kan worden gebruikt met
Arbitrary Entity Manipulation (arbitraire entiteitmanipulatie).

a - Kleur van het bemanningslid om te veranderen
(cyan/player/blue/red/yellow/green/purple)
b - Kleurnaam om naar te veranderen. Vanaf 2.4 kun je ook een kleur-ID gebruiken

changecustommood¤(kleur,stemming)\w#h

Verandert de stemming van een redbaar bemanningslid.

kleur - Kleur van bemanningslid om te veranderen
        (cyan/player/blue/red/yellow/green/purple)
stemming - 0 voor blij, 1 voor verdrietig

changedir¤(kleur,richting)\w#h

Net zoals ¤#changeai(bemanningslid,ai1,ai2)¤changeai¤, verandert dit de gezichtsrichting.\nLwl&Z

kleur - cyan/player/blue/red/yellow/green/purple
richting - 0 is links, 1 is rechts

changegravity¤(bemanningslid)\w#h

Telt 12 op bij het spritenummer van het opgegeven bemanningslid.

bemanningslid - Kleur van bemanningslid om te wijzigen, cyan/player/blue/red
/yellow/green/purple

changemood¤(kleur,stemming)\w#h

Verandert de stemming van de speler of een cutscene-bemanningslid.

kleur - cyan/player/blue/red/yellow/green/purple
stemming - 0 voor blij, 1 voor verdrietig

Cutscene-bemanningsleden zijn bemanningsleden die gemaakt zijn met ¤#createcrewman(x,y,kleur,stemming,ai1,ai2)¤createcrewman¤.\gLwl&Zg

changeplayercolour¤(kleur)\w#h

Verandert de kleur van de speler

kleur - cyan/player/blue/red/yellow/green/purple/teleporter

changerespawncolour¤(kleur)\w#h

Verandert de kleur waarmee de speler terugkomt na dood te zijn gegaan.

kleur - red/yellow/green/cyan/blue/purple/teleporter of getal

Dit commando is toegevoegd in 2.4.\g

changetile¤(kleur,tile)\w#h

Verandert de sprite van een bemanningslid (je kunt het veranderen naar elke sprite
in sprites.png, en het werkt alleen voor bemanningsleden die gemaakt zijn met
createcrewman)

kleur - cyan/player/blue/red/yellow/green/purple/gray
tile - Nummer van sprite

clearteleportscript¤()\b#h

Verwijdert het teleporter-script ingesteld met teleportscript(x)

companion¤(x)\b#h

Laat het opgegeven bemanningslid de speler volgen.

x - 0 (geen) of 6/7/8/9/10/11

createactivityzone¤(kleur)\b#h

Maakt een activiteitszone bij het gegeven bemanningslid (of de speler, als het
bemanningslid niet bestaat) met de tekst "Press ACTION to talk to (bemanningslid)"

createcrewman¤(x,y,kleur,stemming,ai1,ai2)\w#h

Maakt een bemanningslid (kan niet gered worden)

stemming - 0 voor blij, 1 voor verdrietig
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - nodig als followposition gebruikt wordt voor ai1

createentity¤(x,y,e,meta,meta,p1,p2,p3,p4)\o#h

Creëert een entiteit met het ID ¤e§¤, twee ¤meta¤-waarden, en 4 ¤p§¤-waarden.\nn&Znn&Znn&Z(

e - Het nummer van de entiteit

Een lijst met entity-IDs en de bijbehorende ¤meta¤/§¤p§¤-waarden vind je ¤https://vsix.dev/wiki/Createentity_list¤hier¤.\gn&Zgn&ZgLClg(

createlastrescued¤()\b#h

Maak het laatst geredde bemanningslid op de vaste positie ¤(200,153)¤. Het laatst\nn&Z
geredde bemanningslid is gebaseerd op de Level Complete-gamestate.

createrescuedcrew¤()\b#h

Maakt alle geredde bemanningsleden

customifflag¤(n,script)\w#h

Hetzelfde als ¤ifflag(n,script)¤ in vereenvoudigde scripting\nn&Z

customiftrinkets¤(n,script)\w#h

Hetzelfde als ¤iftrinkets(n,script)¤ in vereenvoudigde scripting\nn&Z

customiftrinketsless¤(n,script)\w#h

Hetzelfde als ¤iftrinketsless(n,script)¤ in vereenvoudigde scripting\nn&Z

custommap¤(on/off)\w#h

De interne variant van het map-commando

customposition¤(type,above/below)\w#h

Overschrijft de x,y van het text-commando en stelt daarmee de positie van het
tekstvak in, maar voor bemanningsleden worden bemanningsleden die gered kunnen
worden gebruikt om mee te positioneren, in plaats van
createcrewman-bemanningsleden.

type - center/centerx/centery, of de naam van een kleur
cyan/player/blue/red/yellow/green/purple (kan gered worden)
above/below - Wordt alleen gebruikt als type de naam van een kleur is

cutscene¤()\w#h

Laat de cutscene-balken verschijnen

delay¤(frames)\w#h

Pauzeert het script voor het gegeven aantal frames. De besturing is geforceerd
niet-ingedrukt tijdens deze pauze.

destroy¤(object)\w#h

Verwijdert een entiteit. Dit is hetzelfde als het vereenvoudigde commando.

object - gravitylines/warptokens/platforms/moving/disappear

moving¤ en ¤disappear¤ zijn toegevoegd in 2.4.\n&Zgn&Zg

do¤(herhalingen)\w#h

Start een lusblok dat het gegeven aantal keer herhaald zal worden. Eindig het
lusblok met het ¤#loop¤loop¤-commando.\nLwl&Z

herhalingen - Het aantal keer dat het blok zal worden herhaald.

endcutscene¤()\w#h

Laat de cutscene-balken verdwijnen

endtext\w#h

Laat een tekstvak verdwijnen (fade-out)

endtextfast\w#h

Laat een tekstvak onmiddellijk verdwijnen (zonder fade-out)

entersecretlab\r#h

Schakelt "Secret Lab mode" in.

2.2 EN LAGER: Ontgrendelt daadwerkelijk het Secret Lab, wat waarschijnlijk
een ongewenst effect is voor een aangepast level om te hebben.

everybodysad¤()\w#h

Maakt alle bemanningsleden verdrietig.

Werkt niet op bemanningsleden die geplaatst zijn in de editor.\g

face¤(A,B)\w#h

Laat bemanningslid A kijken naar bemanningslid B.

A - cyan/player/blue/red/yellow/green/purple/gray
B - cyan/player/blue/red/yellow/green/purple/gray

Werkt niet op bemanningsleden die geplaatst zijn in de editor.\g

fadein¤()\w#h

Herstel van een ¤#fadeout()¤fadeout¤.\nLwl&Z

fadeout¤()\w#h

Laat het beeld zwart worden. Gebruik ¤#fadein()¤fadein¤ of ¤#befadein()¤befadein¤ om ongedaan te maken.\nLwl&ZnLwl&Z

finalmode¤(x,y)\b#h

Teleporteert je naar Outside Dimension VVVVVV, ¤(46,54)¤ is de eerste kamer van het\nn&Z
Eindlevel

flag¤(n,on/off)\w#h

Hetzelfde gedrag als het vereenvoudigde commando

flash¤(lengte)\w#h

Maakt het scherm wit voor ¤lengte¤ frames.\nn&Z

lengte - Het aantal frames. 30 frames is bijna een seconde.

Dit verschilt van het vereenvoudigde commando, dat eigenlijk ¤flash(5)¤,\gn&Zg
playef(9)¤ and ¤shake(20)¤ tegelijk aanroept. Zie: ¤#playef(geluid)¤playef¤ en ¤#shake(n)¤shake¤.\n&Zgn&ZgLwl&ZgLwl&Zg

flip\w#h

Laat de zwaartekracht van de speler omkeren door op ACTION te drukken.

Als de speler niet op de grond staat zal dit niet werken, omdat het een druk op\g
ACTIE simuleert. Op dezelfde manier zal dit commando net na een tekstvak niet\g
werken omdat twee drukken op ACTIE achter elkaar gezien worden als het ingedrukt\g
houden van de knop, wat dus de speler niet zal laten omkeren.\g

flipgravity¤(kleur)\w#h

Keert de zwaartekracht om van een bepaald bemanningslid, of de speler.

kleur - cyan/player/blue/red/yellow/green/purple

Voor 2.3 kon dit bemanningsleden niet naar beneden omkeren, en ook niet werken\g
op de speler.\g

flipme\w#h

Corrigeer verticale positionering van meerdere tekstvakken in flip mode

foundlab\b#h

Speelt geluidseffect 3 af, toont tekstvak met "Congratulations! You have found the
secret lab!" Voert geen endtext uit, en heeft geen verdere ongewenste effecten.

foundlab2\b#h

Toont het tweede tekstvak dat je ziet nadat je het geheime lab hebt ontdekt. Voert
ook geen endtext uit, en heeft geen verdere ongewenste effecten.

foundtrinket¤(x)\w#h

Laat een artefact gevonden zijn

x - Nummer van het artefact

gamemode¤(x)\b#h

teleporter om de kaart te tonen, game om het te verbergen (toont teleporters van
het hoofdspel)

x - teleporter/game

gamestate¤(state)\o#h

Verander de huidige gamestate naar het opgegeven state-nummer.

state - De gamestate om naar te springen

Een volledige lijst met gamestates is ¤https://vsix.dev/wiki/List_of_gamestates¤hier¤.\gLClg

gotoposition¤(x,y,zwaartekracht)\w#h

Verander Viridians positie naar ¤(x,y)¤ in deze kamer, en verander ook de\nn&Z
zwaartekracht.

gravity - 1 voor zwaartekracht omgekeerd, 0 voor niet omgekeerd.
Alle andere waarden zorgen voor zwaartekracht die niet meer goed werkt.

gotoroom¤(x,y)\w#h

Wijzig de huidige kamer naar ¤(x,y)¤.\nn&Z

x - x-coördinaat
y - y-coördinaat

Deze kamercoördinaten beginnen bij 0.\g

greencontrol\b#h

Start een gesprek met Verdigris net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

hascontrol¤()\w#h

Laat de speler besturing krijgen. Denk eraan dat je dit niet kunt gebruiken om
controle te krijgen middenin een ¤#delay(frames)¤delay¤.\nLwl&Z

hidecoordinates¤(x,y)\w#h

Maakt de kamer op de gegeven coördinaten niet-verkend

hideplayer¤()\w#h

Maakt de speler onzichtbaar

hidesecretlab\w#h

Verberg het geheime lab op de kaart

hideship\w#h

Verberg het schip op de kaart

hidetargets¤()\b#h

Verberg de doelen op de kaart

hideteleporters¤()\b#h

Verberg de teleporters op de kaart

hidetrinkets¤()\b#h

Verberg de artefacten op de kaart

ifcrewlost¤(bemanningslid,script)\b#h

Als bemanningslid vermist is, ga naar script

ifexplored¤(x,y,script)\w#h

Als ¤(x,y)¤ bezocht is, ga naar intern script.\nn&Z

Deze kamercoördinaten beginnen bij 0.\g

ifflag¤(n,script)\b#h

Hetzelfde als customifflag, maar laadt een intern script (uit het hoofdspel)

iflang¤(taal,script)\w#h

Controleer of de huidige taal van het spel is ingesteld op een bepaalde taal, en
zo ja, spring naar het gegeven vereenvoudigde script. ¤#loadtext(taal)¤loadtext¤ heeft geen invloed\nLwl&Z
op dit commando; alleen welke taal de gebruiker heeft gekozen in het menu.

taal - De taal om te controleren, meestal een code van twee letters, zoals ¤nl¤ voor\nn&Z
Nederlands
script - Het vereenvoudigde script om naar te springen als de controle waar is

Dit commando is toegevoegd in 2.4.\g

iflast¤(bemanningslid,script)\b#h

Als bemanningslid x als laatste gered is, ga naar script

bemanningslid - Nummers worden hier gebruikt: 0: Viridian, 1: Violet, 2:
Vitellary, 3: Vermilion, 4: Verdigris, 5 Victoria

ifskip¤(x)\b#h

Als je cutscenes overslaat in No Death Mode, ga naar script x

iftrinkets¤(n,script)\b#h

Hetzelfde als vereenvoudigde scripting, maar laadt een intern script (uit het
hoofdspel)

iftrinketsless¤(n,script)\b#h

Controleert of het gegeven getal kleiner is dan een aantal dat gerelateerd is aan
artefacten. Echter, het vergelijkt het met het grootste aantal artefacten dat je
ooit hebt gekregen tijdens het spelen van het hoofdspel, NIET het aantal
artefacten dat je eigenlijk hebt. Laadt een intern script (uit het hoofdspel)

ifwarp¤(x,y,richting,script)\w#h

Als de warprichting voor kamer ¤(x,y)¤, beginnend bij 1, is ingesteld op richting,\nn&Z
ga naar (vereenvoudigd) script

x - x-coördinaat van kamer, beginnend bij 1
y - y-coördinaat van kamer, beginnend bij 1
richting - De warprichting. Normaal gesproken 0-3, maar waarden daarbuiten worden
geaccepteerd

jukebox¤(n)\w#h

Maakt een jukeboxterminal wit en zet de kleur van alle andere terminals uit.
Als n is gegeven zal een jukebox-activiteitszone geplaatst worden op een vaste
positie, en als er een terminal staat op dezelfde vaste positie dan zal deze gaan
oplichten.
De mogelijke waarden van n en de vaste posities zijn als volgt:
1: (88, 80), 2: (128, 80), 3: (176, 80), 4: (216, 80), 5: (88, 128), 6: (176,
128), 7: (40, 40), 8: (216, 128), 9: (128, 128), 10: (264, 40)

leavesecretlab¤()\b#h

Zet "secret lab mode" uit

loadscript¤(script)\b#h

Laadt een intern script (uit het hoofdspel). Regelmatig gebruikt in aangepaste
levels als loadscript(stop)

loadtext¤(taal)\w#h

Laad in spelerlevels de vertaling voor de gegeven taal.

taal - De taal om te laden, meestal een code van twee letters, zoals ¤nl¤ voor\nn&Z
Nederlands. Geef een lege taalcode om weer gewoon de taal van VVVVVV te gebruiken.

Dit commando is toegevoegd in 2.4.\g

loop\w#h

Zet dit aan het eind van het lusblok dat begint met het ¤#do(herhalingen)¤do¤-commando.\nLwl&Z

missing¤(kleur)\b#h

Maakt iemand vermist

moveplayer¤(x,y)\w#h

Verplaatst de speler x pixels naar rechts en y pixels naar beneden. Negatieve
getallen werken ook.

musicfadein¤()\w#h

Fade de muziek in.

Voor 2.3 deed dit commando niets.\g

musicfadeout¤()\w#h

Laat de muziek outfaden.

nocontrol¤()\w#h

Zet game.hascontrol op false, wat de besturing weghaalt van de speler.
game.hascontrol wordt automatisch ingesteld tijdens "- Press ACTION to advance
text -" en het sluiten van tekstvakken, dus dit wordt in dat geval ongedaan
gemaakt

play¤(n)\w#h

Begin met het spelen van muziek met intern nummer.

n - Intern liednummer

playef¤(geluid)\w#h

Speel een geluidseffect.

geluid - Geluids-ID

In VVVVVV 1.x was er een tweede argument dat bepaalde op welke milliseconde het\g
geluidseffect moest starten. Dit is verwijderd tijdens de C++-port.\g

position¤(type,above/below)\w#h

Overschrijft de x,y van het text-commando en stelt daarmee de positie van het
tekstvak in.

type - center/centerx/centery, of de naam van een kleur
cyan/player/blue/red/yellow/green/purple
above/below - Wordt alleen gebruikt als x de naam van een kleur is

purplecontrol\b#h

Start een gesprek met Violet net zoals wanneer je haar in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

redcontrol\b#h

Start een gesprek met Vermilion net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

rescued¤(kleur)\b#h

Maakt iemand gered

resetgame\w#h

Reset alle artefacten, verzamelde bemanningsleden en vlaggen, en teleporteert de
speler naar het laatste checkpoint.

restoreplayercolour¤()\w#h

Verandert de kleur van de speler terug naar cyaan

resumemusic¤()\w#h

Hervat de muziek na ¤#musicfadeout()¤musicfadeout¤.\nLwl&Z

Voor 2.3 was dit een niet-afgemaakt commando en veroorzaakte verschillende\g
glitches, waaronder crashes.\g

rollcredits¤()\r#h

Laat de credits rollen.

2.2 EN LAGER: Het vernietigt je opgeslagen data nadat de credits afgelopen zijn!

setactivitycolour¤(kleur)\w#h

Verander de kleur van de volgende activiteitszone die gemaakt wordt.

kleur - Elke kleur die ¤#text(kleur,x,y,regels)¤text¤ accepteert\nLwl&Z

Dit commando is toegevoegd in 2.4.\g

setactivityposition¤(y)\w#h

Verander de positie van de volgende activiteitszone die gemaakt wordt.

y - De y-positie

Dit commando is toegevoegd in 2.4.\g

setactivitytext\w#h

Verander de tekst van de volgende activiteitszone die gemaakt wordt. De regel
onder dit commando zal gebruikt worden als de tekst (net als ¤#text(kleur,x,y,regels)¤text¤ met 1 regel).\nLwl&Z

Dit commando is toegevoegd in 2.4.\g

setcheckpoint¤()\w#h

Stelt het checkpoint in op de huidige locatie

setfont¤(lettertype,all)\w#h

In spelerlevels verandert dit het lettertype naar het gegeven lettertype.

lettertype - Het lettertype om het lettertype naar te veranderen.
Indien leeggelaten zal het standaardlettertype van het level gebruikt worden.
all - Als ¤all¤ is opgegeven (letterlijk het woord ¤all¤), zal dit met terugwerkende\nn&Znn&Z
kracht van toepassing worden op alle tekstvakken die al in beeld zijn. Laat dit
anders leeg.

Dit commando is toegevoegd in 2.4. Het ¤all¤-argument is toegevoegd in 2.4.1.\gn&Zg

setroomname\w#h

Wijzig de naam van de huidige kamer. De regel onder dit commando zal gebruikt
worden als de naam (net als ¤#text(kleur,x,y,regels)¤text¤ met 1 regel).\nLwl&Z

Deze naam is niet permanent en zal terug worden gezet naar de standaard kamernaam
als de kamer opnieuw wordt geladen (bijvoorbeeld door weg te gaan en terug te
komen)

Deze naam overschrijft speciale veranderende kamernamen, als de kamer die heeft.

Dit commando is toegevoegd in 2.4.\g

setrtl¤(on/off)\w#h

Schakel in spelerlevels of het lettertype RTL (rechts-naar-links) is of niet.
Standaard is het lettertype niet RTL (het is dus links-naar-rechts).

RTL-modus zorgt vooral dat tekstvakken rechts uitgelijnd zijn, voor talen zoals
Arabisch.

Dit commando is toegevoegd in 2.4.\g

shake¤(n)\w#h

Schud het beeld voor n ticks. Dit zal geen wachttijd veroorzaken.

showcoordinates¤(x,y)\w#h

Maakt de kamer op de gegeven coördinaten verkend

showplayer¤()\w#h

Maakt de speler zichtbaar

showsecretlab\w#h

Toon het geheime lab op de kaart

showship\w#h

Toon het schip op de kaart

showtargets¤()\b#h

Toon de doelen op de kaart (onbekende teleporters die getoond worden als ?'s)

showteleporters¤()\b#h

Toon de teleports in verkende kamers op de kaart

showtrinkets¤()\w#h

Toon de artefacten op de kaart

Vanaf 2.3 werkt dit commando ook in spelerlevels.\g

speak\w#h

Toont een tekstvak, zonder oude tekstvakken te verwijderen. Pauzeert het script
ook tot je op action drukt (tenzij er een backgroundtext-commando boven staat)

speak_active\w#h

Toont een tekstvak, en verwijdert oude tekstvakken. Pauzeert het script ook tot je
op action drukt (tenzij er een backgroundtext-commando boven staat)

specialline¤(x)\b#h

Speciale teksten die worden weergegeven in het hoofdspel

squeak¤(kleur)\w#h

Zorgt dat een bemanningslid een geluid maakt, of een terminal-geluid

kleur - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\b#h

Alternatieve ¤finalmode(46,54)¤, brengt je naar het Final Level zonder argumenten te\nn&Z
accepteren.

stopmusic¤()\w#h

Stopt de muziek onmiddellijk. Hetzelfde als ¤music(0)¤ in vereenvoudigde scripting.\nn&Z

teleportscript¤(script)\b#h

Gebruikt om een script in te stellen dat wordt uitgevoerd wanneer je een
teleporter gebruikt

telesave¤()\r#h

Doet niks in aangepaste levels.

2.2 EN LAGER: Slaat je spel op in het normale teleporter-bestand, dus gebruik het
niet!

text¤(kleur,x,y,regels)\w#h

Slaat een tekstvak op in het geheugen met kleur, positie en aantal regels. Meestal
wordt het position-commando gebruikt na het text-commando (en het aantal regels)
wat de coördinaten zal overschrijven die hier gegeven zijn, dus deze worden
meestal op 0 gelaten.

kleur - cyan/player/blue/red/yellow/green/purple/gray/white/orange/transparent
x - De x-positie van het tekstvak
y - De y-positie van het tekstvak
regels - Het aantal regels

De kleur ¤transparent¤ is toegevoegd in 2.4, net als arbitrair gekleurde\gn&Zg
tekstvakken.\g
De coördinaten kunnen -500 zijn om het tekstvak in die as te centreren (als je\g
#position(type,above/below)¤position¤ niet wil gebruiken).\Lwl&Zg

textboxactive\w#h

Laat alle tekstvakken op het scherm verdwijnen behalve de laatst gemaakte

textboxtimer¤(frames)\w#h

Laat het volgende tekstvak na een bepaald aantal frames verdwijnen, zonder het
script te laten verdergaan.

frames - Het aantal frames om te wachten voor het te laten verdwijnen

Dit commando is toegevoegd in 2.4.\g

textbuttons¤()\w#h

Vervang bepaalde placeholders door knoplabels in het tekstvak dat in het geheugen
staat (zoals toetsen op het toetsenbord of controllerknoppen).

De placeholders die worden vervangen zijn:
- {b_act} - ACTIE
- {b_int} - Interactie
- {b_map} - Kaart
- {b_res} - Herstarten
- {b_esc} - Esc/Menu

Dit commando is toegevoegd in 2.4.\g

textcase¤(geval)\w#h

Als je level vertaalbestanden heeft, en je hebt meerdere tekstvakken met dezelfde
tekst in een enkel script, kan dit commando ze unieke vertalingen laten hebben.
Zet het voor een tekstvak.

geval - Het nummer van dit geval, tussen 1 en 255.

Dit commando is toegevoegd in 2.4.\g

textimage¤(afbeelding)\w#h

Geef de opgegeven afbeelding weer voor het tekstvak dat in het geheugen staat.
Er kan maar één afbeelding zijn per tekstvak.

afbeelding - levelcomplete/gamecomplete, of een onbekende waarde om de afbeelding
             te verwijderen

Dit commando is toegevoegd in 2.4.\g

textsprite¤(x,y,sprite,kleur)\w#h

Geef de opgegeven sprite weer voor het tekstvak dat in het geheugen staat.
Er kunnen meerdere sprites zijn per tekstvak.

x - De x-coördinaat van de sprite. Dit is relatief aan het tekstvak.
y - De y-coördinaat van de sprite. Dit is relatief aan het tekstvak.
sprite - Het nummer van de sprite, uit ¤sprites.png¤.\nn&Z
kleur - Het kleur-ID van de sprite.

Dit commando is toegevoegd in 2.4.\g

tofloor\w#h

Laat de speler naar de grond gaan als deze daar niet al staat.

trinketbluecontrol¤()\b#h

Tekst van Victoria wanneer ze je een artefact geeft in het echte spel

trinketscriptmusic\w#h

Speelt Passion for Exploring.

trinketyellowcontrol¤()\b#h

Tekst van Vitellary wanneer hij je een artefact geeft in het echte spel

undovvvvvvman¤()\w#h

Herstelt de hitbox van de speler naar de normale grootte, zet de kleur op 0, en
zet de X-positie op 100.

untilbars¤()\w#h

Wacht tot ¤#cutscene()¤cutscene¤ of ¤#endcutscene()¤endcutscene¤ is voltooid.\nLwl&ZnLwl&Z

untilfade¤()\w#h

Wacht totdat ¤#fadeout()¤fadeout¤ of ¤#fadein()¤fadein¤ klaar is.\nLwl&ZnLwl&Z

vvvvvvman¤()\w#h

Maakt de speler 6x zo groot, zet de positie op ¤(30,46)¤ en zet de kleur op ¤23¤.\nn&Znn&Z

walk¤(richting,x)\w#h

Laat de speler lopen voor het opgegeven aantal ticks

richting - left/right

warpdir¤(x,y,richting)\w#h

Verandert de warprichting voor kamer x,y, beginnend bij 1, naar de aangegeven
richting. Dit kan worden gecontroleerd met ifwarp, wat zorgt voor een relatief
krachtig extra vlaggen-/variabelesysteem.

x - x-coördinaat van kamer, beginnend bij 1
y - y-coördinaat van kamer, beginnend bij 1
richting - De warprichting. Normaal gesproken 0-3, maar waarden daarbuiten worden
geaccepteerd

yellowcontrol\b#h

Start een gesprek met Vitellary net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.
]]
},

{
splitid = "090_Lists_reference",
subj = "Lijsten",
imgs = {},
cont = [[
Lijsten\wh#
\C=

Dit zijn lijsten van nummers die gebruikt worden in VVVVVV, vooral gekopieerd uit
forumberichten. Bedankt aan iedereen die deze lijsten samengesteld heeft!


Inhoud\w&Z+
\&Z+
#Muzieknummers (vereenvoudigde scripting)\C&Z+l
#Muzieknummers (intern)\C&Z+l
#Geluidseffecten\C&Z+l
#Entiteiten\C&Z+l
#Kleuren voor createentity()-¤Kleuren voor createentity()-bemanningsleden\LC&Z+l
#Vijand-bewegingstypes\C&Z+l
#Gamestates\C&Z+l


Muzieknummers (vereenvoudigde scripting)\h#

0 - Stilte (geen muziek)
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

Muzieknummers (intern)\h#

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
15 - Predestined Fate Remix

Geluidseffecten\h#

0 - Keer zwaartekracht om naar plafond
1 - Keer zwaartekracht om naar vloer
2 - Huil
3 - Artefact verzameld
4 - Muntje verzameld
5 - Checkpoint aangeraakt
6 - Sneller drijfzandblok aangeraakt
7 - Normaal drijfzandblok aangeraakt
8 - Zwaartekrachtlijn aangeraakt
9 - Flits
10 - Warp
11 - Geluid van Viridian
12 - Geluid van Verdigris
13 - Geluid van Victoria
14 - Geluid van Vitellary
15 - Geluid van Violet
16 - Geluid van Vermilion
17 - Terminal aangeraakt
18 - Teleporter aangeraakt
19 - Alarm
20 - Terminal-geluid
21 - Aftelling in time trial "3", "2", "1"
22 - Aftelling in time trial "Go!"
23 - VVVVVV Man die muren breekt
24 - Bemanningsleden die (de)combineren in VVVVVV Man
25 - Nieuw record in Super Gravitron
26 - Nieuwe trofee in Super Gravitron
27 - Gered bemanningslid (in aangepaste levels)

Entiteiten\h#

0 - De speler
1 - Vijand
    Metadata: bewegingstype, bewegingssnelheid
    Omdat de benodigde data ontbreekt krijg je alleen een paarse doos-vijand,
    tenzij je in de polar dimension van VVVVVV bent wanneer je het commando
    gebruikt
2 - Bewegend platform
    Metadata: bewegingstype, bewegingssnelheid
    Opmerking: lopende banden zijn geïmplementeerd als bewegende platforms, zie
    bewegingstype 8 en 9.
3 - Een brekend platform
4 - Een sneller drijfzandblok van 1x1
5 - Een omgekeerde Viridian, je zwaartekracht zal omkeren wanneer je hem aanraakt
6 - Raar rood flitsend dingetje dat snel verdwijnt
7 - Zelfde als hierboven, maar flitst niet en is cyaan-gekleurd
8 - Een munt uit het prototype
    Metadata: Munt-ID
9 - Artefact
    Metadata: Artefact-ID
    Opmerking: artefact-ID's beginnen bij 0, en alles boven 19 wordt niet
    opgeslagen in het bestand wanneer je het level herstart
10 - Checkpoint
     Metadata: Checkpoint-status (0=ondersteboven, 1=normaal), Checkpoint-ID
     (controleert of het checkpoint actief is of niet)
11 - Horizontale zwaartekrachtlijn
     Metadata: Lengte in pixels
12 - Verticale zwaartekrachtlijn
     Metadata: Lengte in pixels
13 - Teleportatietoken
     Metadata: Bestemming in blokken op X-as, bestemming in blokken op Y-as
14 - De ronde teleporter
     Metadata: Checkpoint-ID(?)
15 - Verdigris
     Metadata: AI-status
16 - Vitellary (ondersteboven)
     Metadata: AI-status
17 - Victoria
     Metadata: AI-status
18 - Bemanningslid
     Metadata: Kleur (gebruikt kleurenlijst, niet bemanningslidkleuren), stemming
19 - Vermilion
     Metadata: AI-status
20 - Terminal
     Metadata: Sprite, Script-ID(?)
21 - Zelfde als hierboven maar wanneer aangeraakt zal de terminal geen licht geven
     Metadata: Sprite, Script-ID(?)
22 - Verzameld artefact
     Metadata: Artefact-ID
23 - Gravitron-vierkant
     Metadata: Richting
     Als je een negatieve X-coördinaat opgeeft (of te hoog) zal een pijltje
     getoond worden, net zoals in de echte gravitron
24 - Bemanningslid intermission 1
     Metadata: "Rauwe" kleur, stemming
     Lijkt niet getroffen te worden door gevaren, maar zou wel moeten.
25 - Trofee
     Metadata: Uitdagings-id, sprite
     Als de uitdaging voltooid is zal de basis-sprite-ID (wat je krijgt als je
     sprite=0 gebruikt) veranderen. Gebruik alleen 0 of 1 als je voorspelbare
     resultaten wil (0=normaal, 1=ondersteboven)
26 - Het teleportatietoken naar het Secret Lab
     Houd in gedachten dat dit token alleen geïmplementeerd is als een
     mooi-uitziende sprite. Je moet de functionaliteit zelf scripten
55 - Bemanningslid dat gered kan worden
     Metadata: Kleur van bemanningslid. Kleur >6 zal altijd een *blije* Viridian
     tonen
56 - Vijand voor aangepaste levels
     Metadata: Bewegingstype, bewegingssnelheid
     Houd in gedachten dat als er geen vijanden in de kamer zijn, de vijand-sprite
     niet correct geüpdate wordt en de vijand die je de laatste keer zag zal
     worden getoond, of een vierkante vijand
Ongedefinieerde entiteiten (27-50, 57+) geven rare Viridians.

Kleuren voor createentity()-\h#

bemanningsleden\h

0: Cyaan
1: Flitsend rood (gebruikt voor dood)
2: Donker-oranje
3: Artefact-kleur
4: Grijs
5: Flitsend wit
6: Rood (beetje donkerder dan Vermilion)
7: Limoen-groen
8: Felroze
9: Briljant geel
10: Flitsend wit
11: Felcyaan
12: Blauw, zelfde als Victoria
13: Groen, zelfde als Verdigris
14: Geel, zelfde als Vitellary
15: Rood, zelfde als Vermilion
16: Blauw, zelfde als Victoria
17: Lichter oranje
18: Grijs
19: Donkerder groen
20: Roze, zelfde als Violet
21: Lichter grijs
22: Wit
23: Flitsend wit
24-29: Wit
30: Grijs
31: Donker, beetje paarsig grijs?
32: Donkercyaan/-groen
33: Donkerblauw
34: Donkergroen
35: Donkerrood
36: Saai oranje
37: Flitsend grijs
38: Grijs
39: Donkerder cyaan/groen
40: Flitsender grijs
41-99: Wit
100: Donkergrijs
101: Flitsend wit
102: Teleporter-kleur
103 en verder: Wit

Vijand-bewegingstypes\h#

0 - Springt op en neer, begint beneden.
1 - Springt op en neer, begint boven
2 - Springt naar links en rechts, begint links.
3 - Springt naar links en rechts, begint rechts.
4, 7, 11 - Verplaatst naar rechts tot botsing.
5 - Zelfde als hierboven, maar gedraagt zich vreemd wanneer het botst.
    GIF hier: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Springt op en neer, maar bereikt een bepaalde y-positie voor terug te gaan
    naar beneden. Gebruikt in "Trench warfare".
8, 9 - Voor bewegende platforms zijn het lopende banden, en stilstaand voor de
       rest
14 - Kan geblokkeerd worden door brekende platforms
15 - Stilstaand (?)
10, 12 - Kloont naar rechts/op dezelfde plek, crasht VVVVVV als het te intens
         wordt, en maakt je opgeslagen data corrupt als je opslaat.
13 - Net zoals 4, maar beweegt naar beneden tot botsing.
16 - Verschijnt en verdwijnt.
17 - Gejaagde beweging naar links
18 - Gejaagde beweging naar rechts, klein beetje sneller
19+ - Stilstaand (?)

Gamestates\h#

0 - Breekt uit de meeste gamestates
1 - Zet de gamestate op 0 (oftewel in de praktijk hetzelfde als hierboven)
2 - "To do: write quick intro to story!"
4 - "Druk op de pijltjestoetsen of WASD om te bewegen"
5 - Voert het script "returntohub" uit (oftewel fadeout, teleporteer naar rechts
    voor The Tower, fadein, speel Passion for Exploring)
7 - Verwijdert tekstvakken
8 - "Druk op ENTER voor kaart en opslaan"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Probeert flipmode-check
     te gebruiken om "the ceiling" of "the floor" te laten zien, maar omdat dit
     fout gaat, wordt in plaats daarvan weergegeven wat hierboven staat)
12 - "Je kunt niet naar de volgende kamer totdat de ander veilig aan de overkant
     is."
13 - Verwijdert tekstvakken snel
14 - "When you're standing on the floor," (hetzelfde is hier van toepassing als
     bij 11)
15 - Maakt Viridian blij
16 - Maakt Viridian verdrietig
17 - "Je kunt ook op OMHOOG of OMLAAG drukken in plaats van ACTIE om je
     zwaartekracht om te keren."
20 - Als vlag 1 op 0 staat, zet vlag 1 op 1 en verwijder tekstvakken
21 - Als vlag 2 op 0 staat, zet vlag 2 op 1 en verwijder tekstvakken
22 - "Druk op ACTIE om je zwaartekracht om te keren"
30 - "Waarom zou het schip mij hier in mijn eentje hebben geteleporteerd?"
     "Ik hoop dat de rest in orde is..."
31 - "Violet! Ben jij dat?"-cutscene (zolang vlag 6 op 0 staat)
32 - Als vlag 7 op 0 staat: "Een teleport!" "Hiermee kan ik terug naar het schip!"
33 - Als vlag 9 op 0 staat: Victoria-cutscene
34 - Als vlag 10 op 0 staat: Vitellary-cutscene
35 - Als vlag 11 op 0 staat: Verdigris-cutscene
36 - Als vlag 8 op 0 staat: Vermilion-cutscene
37 - Vitellary na gravitron
38 - Vermilion na gravitron
39 - Verdigris na gravitron
40 - Victoria na gravitron
41 - Als vlag 60 op 0 staat: draai het begin van de intermission 1-cutscene
42 - Als vlag 62 op 0 staat: draai de 3e intermission 1-cutscene
43 - Als vlag 63 op 0 staat: draai de 4e intermission 1-cutscene
44 - Als vlag 64 op 0 staat: draai de 5e intermission 1-cutscene
45 - Als vlag 65 op 0 staat: draai de 6e intermission 1-cutscene
46 - Als vlag 66 op 0 staat: draai de 7e intermission 1-cutscene
47 - Als vlag 69 op 0 staat: "Hé! Wat zou dat zijn?"-artefact-cutscene
48 - Als vlag 70 op 0 staat: "Als ik buiten nog iets vind lijkt dit me wel een
     goede plek om het te bewaren..." (Victoria nog niet gevonden)
49 - Als vlag 71 op 0 staat: Speel Predestined Fate
50 - "Help! Kan iemand dit horen?"
51 - "Verdigris? Ben je daar ergens? Ben je in orde?"
52 - "Help ons! We zijn neergestort en hebben assistentie nodig!"
53 - "Hallo? Is er iemand in de buurt?"
54 - "Dit is Doctor Violet van de D.S.S. Souleye! Antwoord alsjeblieft!"
55 - "Alsjeblieft... Iemand..."
56 - "Ik hoop dat jullie allemaal ongedeerd zijn..."
Met gamestate 50-56 kun je kiezen waar te beginnen, want alles komt na elkaar
80 - Dan en slechts dan als het beeld zwart is, ga door naar state 81 (Mijn gok is
     dat dit wordt aangeroepen wanneer ESC wordt ingedrukt, voor het pauze-menu
     wordt geopend)
81 - Ga terug naar het hoofdmenu
82 - Resultaten van race tegen de klok
83 - Als beeld zwart is, ga door naar state 84
84 - Resultaten van race tegen de klok (Ik denk dat 82 beter werkt dan 84)
85 - De race tegen de klok-versie van gamestate 200 (Flits, speel Positive Force,
     zet finalstretch-modus aan)
States 90-95 zijn gerelateerd aan races tegen de klok, maar werken niet goed in
     spelerlevels. De enige echte effecten die gebeuren in spelerlevels zijn een
     teleportatie, en verandering van de muziek
90 - Ruimtestation 1
91 - Het Laboratorium
92 - Wikkelzone
93 - De Toren
94 - Ruimtestation 2
95 - Eindlevel
96 - Als het beeld zwart is, ga door naar state 97
97 - Verlaat Supergravitron (teleporteer en speel Pipe Dream)
100 - Als vlag 4 op 0 staat: ga door naar state 101
101 - Als je zwaartekracht omgekeerd is, ga terug naar de vloer, ga naar state 102
De volgende states (102-112) proberen naar de huidige state te gaan + 1, net zoals
      in 50-56 (maar vormt geen lus), maar kan problemen veroorzaken omdat de
      helft van de states (103, 105, 107, 109, 111) niet bestaat.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Verwijdert tekstvakken
115 - In wezen niets, ga door naar state 116
116 - Rood tekstvak onderin beeld met tekst "Sorry Eurogamers! Teleporting around
      the map doesn't work in this version!", ga door naar state 117, wat niet
      bestaat, dus dingen zouden fout kunnen gaan
118 - Verwijdert tekstvakken
State 120-128 werken een beetje zoals 102-112, d.w.z in serie, maar met minder
      problemen
120 - Als vlag 5 op 0 staat: ga door naar state 121
121 - Als je op de vloer staat, keer zwaartekracht om
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Verwijdert tekstvakken
200 - Final mode
1000 - Zet cutscenebalken aan, bevriest het spel, gaat door naar state 1001
1001 - "Je hebt een glanzend artefact gevonden!" (maar je hebt er niet echt een
       gekregen, dit wordt gewoon iedere keer dat je er een verzamelt
       aangeroepen), ga door naar state 1003
1003 - Herstel spel naar normale situatie
1010 - Je hebt een bemanningslid gevonden! op dezelfde manier als voor artefacten
1013 - Beëindig level met sterren
2000 - Sla het spel op
2500-2509 - Teleporteer naar een of andere vreemde niet-bestaande locatie,
            vermoedelijk naar het Laboratorium denk ik, ga door naar state 2510
2510 - Viridian: "Hello?", ga door naar state 2512
2512 - Viridian: "Is anybody there?", ga door naar state 2514
2514 - Verwijdert tekstvakken, speel Potential For Anything
States 3000-3099:
3000-3005 - "Level uitgespeeld! Je hebt gered..." het bemanningslid toegepast op
            companion(), standaard Verdigris. 6=Verdigris, 7=Vitellary,
            8=Victoria, 9=Vermilion, 10=Viridian (ja, echt), 11=Violet
            (Gamestates: 3006-3011=Verdigris, 3020-3026=Vitellary,
            3040-3046=Victoria, 3060-3066=Vermilion, 3080-3086=Viridian,
            3050-3056=Violet)
3070-3072 - Doe dingen na redding, normaal gesproken terug naar schip
3501 - Spel uitgespeeld
4010 - Flits + teleportatie
4070 - Het Eindlevel, maar het spel zal crashen wanneer je Timeslip bereikt
       (Door de manier waarop het spel entiteit-informatie krijgt, wat stuk is in
       spelerlevels)
4080 - Kapitein teruggeteleporteerd naar het schip:
       "Hallo!" [K[K[K[K[Kapitein!]-cutscene + credits.
       Het bovenstaande zal je opgeslagen data vernietigen dus doe het niet tenzij
       je een backup hebt gemaakt!
4090 - Cutscene nadat je ruimtestation 1 hebt afgemaakt
]]
},

{
splitid = "100_Formatting",
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
- - Horizontale lijn:
\-
= - Horizontale lijn onder grote tekst

Tekstkleuren:\h#

n - Normaal\n
r - Rood\r
g - Grijs\g
w - Wit\w
b - Blauw\b
o - Oranje\o
v - Groen\v
c - Cyaan\c
y - Geel\y
p - Paars\p
V - Donkergroen\V
z - Zwart¤ (exclusief achtergrondkleur)\z&Z
Z - Donkergrijs\Z
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

Het is mogelijk om meerdere kleuren op een regel te gebruiken door gekleurde delen
te scheiden met het teken¤ ¤¤ ¤(dat je kunt typen door op ¤Insert¤ te drukken) en de\nYnw
kleuren in de juiste volgorde na¤ \ ¤te zetten. Als de laatste kleur op de regel de\nC
standaardkleur is (n), is het niet nodig om deze code op het eind neer te zetten.
Als je het¤ ¤¤§¤-teken wilt gebruiken op een regel met¤ \¤, kun je in plaats daarvan¤ ¤¤¤¤\nYnCnY(
typen. Het is om technische redenen ni¤e§¤t mogelijk om een enkel teken een kleur te\nR(
geven door het tussen twee¤ ¤¤§¤'s te zetten, tenzij je ook een spatie of een ander\nY(
teken meeneemt.

\-
Je kunt specifieke ¤¤woorden¤¤ een ¤¤kleur¤¤ geven!\nvnr\

Je kunt specifieke ¤woorden¤ een ¤kleur¤ geven!\nvnr
\-
Een ¤¤paar ¤¤tek¤¤st¤¤kleu¤¤ren\RYGCBP\

Een ¤paar ¤tek¤st¤kleu¤ren\RYGCBP
\-

Een enkel teken een kleur geven\h#

Oké, ik loog, het is wel mogelijk om een enkel teken een kleur te geven zonder een
spatie mee te nemen. Om dit te doen kun je het teken¤ § ¤(dat je kunt typen met\nY
Shift+Insert¤) na het teken dat je wilt kleuren, en schakel het in met de\w
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
dus je kunt zelf de stijl van de link bepalen.

Je kunt naar artikelen linken door simpelweg de naam van het artikel te gebruiken:

\-
Gereedschap\bl\

Gereedschap\bl
\-

Als je hierboven op "Gereedschap" klikt ga je naar het artikel genaamd
"Gereedschap". Ik heb hier de kleurcode¤ b ¤gebruikt om de link blauw te maken, en\nb
zoals je kunt zien is de¤ l ¤van toepassing op datzelfde gekleurde gedeelte.\nY

Je kunt een koppeling maken naar een anker in hetzelfde artikel door een¤ # ¤te\nY
gebruiken gevolgd door alle tekst op die regel. (Gevallen van¤ ¤¤ ¤worden daar\nY
volledig genegeerd.) Je kunt naar de bovenkant van een artikel linken met alleen
een hekje (¤#§¤).\nY(

\-
#Meerdere kleuren op een regel gebruiken\bl\

#Meerdere kleuren op een regel gebruiken\bl
\-

Je kunt op een soortgelijke manier naar een anker in een ander artikel linken:

\-
Lijsten#Gamestates\bl\

Lijsten#Gamestates\bl
\-

Linken naar websites is ook eenvoudig:

\-
https://example.com/\bl\

https://example.com/\bl
\-

Je kunt een kleurblok met kleurcode¤ L ¤gebruiken dat de bestemming van de link\nY
bevat vóór de tekst van de link, en zo de link een andere tekst laten zien:

\-
Gereedschap¤¤Ga naar een ander artikel\Lbl\

Gereedschap¤Ga naar een ander artikel\Lbl
\-
Klik ¤¤Gereedschap¤¤hier¤¤ om naar een ander artikel te gaan\nLbl\

Klik ¤Gereedschap¤hier¤ om naar een ander artikel te gaan\nLbl
\-
[¤¤#Links¤¤Like¤¤] [¤¤#Voorbeeld:¤¤Dislike¤¤]\n L vl n L rl\

[¤#Links¤Like¤] [¤#Voorbeeld:¤Dislike¤]\n L vl n L rl
\-
#Links¤¤ Knop A ¤¤ §¤¤#Links¤¤ Knop B \L w&Zl n L w&Z l(\

#Links¤ Knop A ¤ §¤#Links¤ Knop B \L w&Zl n L w&Z l(
\-

Afbeeldingen (alleen beschikbaar in\h#

beschrijvingen van plugins):\h

0..9 - Toon afbeelding 0..9 op deze regel (index van het imgs-array begint bij 0,
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
},

{
splitid = "990_Credits",
subj = "Credits",
imgs = {"images/credits.png"},
cont = [[
\0















Credits\wh#
\C=

Ved is gemaakt door Dav999

Andere code-bijdragers: Info Teddy

Sommige afbeeldingen en het lettertype zijn gemaakt door Reese Rivers

Russische vertaling: CreepiX, Cheep, Omegaplex
Esperanto vertaling: Reese Rivers
Duitse vertaling: r00ster
Franse vertaling: RhenaudTheLukark
Spaanse vertaling: Valso22/naether
Indonesische vertaling: _march31onne/Marchionne Evangelisti


Met dank aan:\h#


Terry Cavanagh voor het maken van VVVVVV

Iedereen die bugs gerapporteerd heeft, met ideeën is gekomen en mij heeft
gemotiveerd om dit te maken!
\



Licentie\h#
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

VVVVVV-assets\h#

Ved includes some graphics assets from VVVVVV. VVVVVV and its assets are copyright
of Terry Cavanagh. For more information about the license that applies to VVVVVV
and its assets, see ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ and ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md¤ in ¤https://github.com/TerryCavanagh/VVVVVV¤VVVVVV's GitHub\nLClnLClnLCl
https://github.com/TerryCavanagh/VVVVVV¤repository¤.\LCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
