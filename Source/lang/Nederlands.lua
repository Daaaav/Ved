-- Language file for Ved
--- Language: Nederlands (nl)
--- Last converted: 2019-04-09 20:15:53 (CEST)

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
	if c == "ĳ" then -- by the way, 0.0000000% of people use this single character, just looks a bit better in the font
		return "ij" -- 100% of people just use this
	elseif c == "é" or c == "ë" then
		return "e"
	elseif c == "ö" then
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

OUTDATEDLOVE = "Deze versie van L{ve is verouderd. De minimale versie is 0.9.1.\nJe kunt de laatste versie van L{ve downloaden op https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ondersteunt L{ve 0.9.0 niet meer. Gelukkig blijft L{ve 0.9.1 en hoger werken.\nJe kunt de laatste versie van L{ve downloaden op https://love2d.org/.",
UNKNOWNSTATE = "Onbekende staat ($1), naar veranderd vanaf $2",
FATALERROR = "FATALE FOUT: ",
FATALEND = "Sluit het spel en probeer het opnieuw. En als je Dav bent, los het alsjeblieft op.",

OSNOTRECOGNIZED = "Je besturingssysteem ($1) wordt niet herkend! Valt terug op standaard-bestandssysteemfuncties; levels worden opgeslagen in:\n\n$2",
MAXTRINKETS = "Het maximum aantal trinkets (20) is bereikt in dit level.",
MAXCREWMATES = "Het maximum aantal bemanningsleden (20) is bereikt in dit level.",
EDITINGROOMTEXTNIL = "Bestaande tekst die bewerkt werd is nil!",
STARTPOINTNOLONGERFOUND = "Het oude startpunt kan niet meer worden gevonden!",
UNSUPPORTEDTOOL = "Niet-ondersteund gereedschap! Gereedschap: ",
SURENEWLEVEL = "Weet je zeker dat je een nieuw level wilt maken? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
SURELOADLEVEL = "Weet je zeker dat je een level wilt laden? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
COULDNOTGETCONTENTSLEVELFOLDER = "Kon niet de inhoud van de levels-map verkrĳgen. Controleer of $1 bestaat en probeer het opnieuw.",
MAPSAVEDAS = "Kaart opgeslagen als $1!",
RAWENTITYPROPERTIES = "Je kunt de eigenschappen van deze entiteit hier wĳzigen.",
UNKNOWNENTITYTYPE = "Onbekend entiteitstype $1",
METADATAENTITYCREATENOW = "De metadata-entiteit bestaat nog niet. Nu aanmaken?\n\nDe metadata-entiteit is een verborgen entiteit die kan worden toegevoegd aan VVVVVV-levels om extra data op te slaan die door Ved gebruikt wordt, zoals het level-kladblok, namen van vlaggen, en andere dingen.",
WARPTOKENENT404 = "Warptoken-entiteit bestaat niet meer!",
SPLITFAILED = "Splitsen is miserabel mislukt! Zĳn er te veel regels tussen een text-commando en een speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Er zĳn geen vlaggen meer beschikbaar, dus één of meer vlagnamen in dit script kunnen niet geassocieerd worden met een vlagnummer. Dit script in VVVVVV proberen uit te voeren kan fout gaan. Overweeg om alle verwĳzingen te wissen naar vlaggen die je niet meer nodig hebt en probeer het opnieuw.\n\nDe editor verlaten?",
NOFLAGSLEFT_LOADSCRIPT = "Er zĳn geen vlaggen meer beschikbaar, dus er kon geen laadscript gemaakt worden. In plaats daarvan is er een laadscript gemaakt dat het doelscript altĳd laadt met iftrinkets(0,$1). Overweeg om alle verwĳzingen te wissen naar vlaggen die je niet meer nodig hebt en probeer het opnieuw.",
LEVELOPENFAIL = "Kon $1.vvvvvv niet openen.",
SIZELIMIT = "De maximale grootte van een level is 20 bĳ 20.\n\nDe levelgrootte zal worden aangepast naar $1 bĳ $2.",
SCRIPTALREADYEXISTS = "Script \"$1\" bestaat al!",
FLAGNAMENUMBERS = "Namen van vlaggen kunnen niet alleen uit nummers bestaan.",
FLAGNAMECHARS = "Namen van vlaggen kunnen geen haakjes, komma's of spaties bevatten.",
FLAGNAMEINUSE = "De vlagnaam $1 wordt al gebruikt door vlag $2",
DIFFSELECT = "Selecteer level om mee te vergelĳken. Het level dat je nu kiest zal worden gezien als een oudere versie.",
SUREQUIT = "Weet je zeker dat je wilt afsluiten? Niet-opgeslagen wĳzigingen zullen verloren gaan.",
SUREQUITNEW = "Je hebt niet-opgeslagen wĳzigingen. Wil je deze wĳzigingen opslaan voor het afsluiten?",
SURENEWLEVELNEW = "Je hebt niet-opgeslagen wĳzigingen. Wil je deze wĳzigingen opslaan voor het maken van een nieuw level?",
SCALEREBOOT = "De nieuwe schaal-instellingen zullen van toepassing worden na het herstarten van Ved.",
NAMEFORFLAG = "Naam voor vlag $1:",
SCRIPT404 = "Script \"$1\" bestaat niet!",
ENTITY404 = "Entiteit #$1 bestaat niet meer!",
GRAPHICSCARDCANVAS = "Sorry, het lĳkt dat je grafische kaart of het stuurprogramma deze functie niet ondersteunt!",
MAXTEXTURESIZE = "Sorry, het maken van een afbeelding van $1x$2 lĳkt niet te worden ondersteund door je grafische kaart of het stuurprogramma.\n\nDe maximale grootte op dit systeem is $3x$3.",
SUREDELETESCRIPT = "Weet je zeker dat je het script \"$1\" wilt verwĳderen?",
SUREDELETENOTE = "Weet je zeker dat je deze notitie wilt verwĳderen?",
THREADERROR = "Thread-fout!",
WHATDIDYOUDO = "Wat heb je gedaan?!",
UNDOFAULTY = "Waar ben je mee bezig?",
SOURCEDESTROOMSSAME = "Beide kamers zĳn hetzelfde!",
UNKNOWNUNDOTYPE = "Onbekend ongedaan-maak-type \"$1\"!",
MDEVERSIONWARNING = "Dit level lĳkt in een nieuwere versie van Ved te zĳn gemaakt, en kan data bevatten die verloren zal gaan als je dit level opslaat.",
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

METADATAUNDONE = "Level-opties ongedaan gemaakt",
METADATAREDONE = "Level-opties opnieuw gewĳzigd",

BOUNDSTOPLEFT = "Klik op de linkerbovenhoek van de begrenzing",
BOUNDSBOTTOMRIGHT = "Klik op de rechteronderhoek",

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
COMPARE = "Vergelĳken",
STATS = "Statistieken",
SCRIPTUSAGES = "Gebruik",
EDITTAB = "Bewerken",
COPYSCRIPT = "Alles kopiëren",
SEARCHSCRIPT = "Zoeken",
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
INTSCRWARNING_BOXED = "Rechtstreekse scriptvak-/ terminal- verwĳzing!\n\n",
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

COMPARINGTHESE = "$1.vvvvvv wordt vergeleken met $2.vvvvvv",
COMPARINGTHESENEW = "(niet-opgeslagen level) wordt vergeleken met $1.vvvvvv",

RETURN = "Terug",
CREATE = "Aanmaken",
GOTO = "Naartoe gaan",
DELETE = "Verwĳderen",
RENAME = "Hernoemen",
CHANGEDIRECTION = "Richting wĳzigen",
DIRECTION = "Richting->",
UP = "omhoog",
DOWN = "omlaag",
LEFT = "links",
RIGHT = "rechts",
TESTFROMHERE = "Testen vanaf hier",
FLIP = "Omdraaien",
CYCLETYPE = "Type wĳzigen",
GOTODESTINATION = "Naar bestemming gaan",
GOTOENTRANCE = "Naar ingang gaan",
CHANGECOLOR = "Kleur wĳzigen",
EDITTEXT = "Tekst wĳzigen",
COPYTEXT = "Tekst kopiëren",
EDITSCRIPT = "Script wĳzigen",
OTHERSCRIPT = "Scriptnaam veranderen",
PROPERTIES = "Eigenschappen",
CHANGETOHOR = "Naar horizontaal veranderen",
CHANGETOVER = "Naar verticaal veranderen",
RESIZE = "Opnieuw plaatsen",
CHANGEENTRANCE = "Ingang verplaatsen",
CHANGEEXIT = "Uitgang verplaatsen",
LOCK = "Vergrendelen",
UNLOCK = "Ontgrendelen",
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
PLATFORMSPEED = "Snelheid: $1",
ENEMYTYPE = "Type: $1",
PLATFORMBOUNDS = "Begrenzing",
WARPDIR = "Warprichting:$1",
ENEMYBOUNDS = "Begrenzing",
ROOMNAME = "Kamernaam",
ROOMOPTIONS = "Kamer-opties",
ROTATE180 = "180grd draaien",
ROTATE180UNI = "180° draaien",
HIDEBOUNDS = "Grenzen verb.",
SHOWBOUNDS = "Grenzen tonen",

ROOMPLATFORMS = "Kamer-platforms", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Kamer-vĳanden",

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

ONETRINKETS = "T:",
ONECREWMATES = "B:",
ONEENTITIES = "E:",

LEVELSLIST = "Levels",
LOADTHISLEVEL = "Laad dit level: ",
ENTERNAMESAVE = "Naam om mee op te slaan: ",
SEARCHFOR = "Zoeken naar: ",

VERSIONERROR = "Kon versie niet controleren.",
VERSIONUPTODATE = "Je versie van Ved is up-to-date.",
VERSIONOLD = "Update beschikbaar! Laatste versie: $1",
VERSIONCHECKING = "Controleren op updates...",
VERSIONDISABLED = "Update-\ncontrole uitgeschakeld",

SAVESUCCESS = "Succesvol opgeslagen!",
SAVENOSUCCESS = "Opslaan niet succesvol! Fout: ",
INVALIDFILESIZE = "Ongeldige bestandsgrootte.",

EDIT = "Bewerken",
EDITWOBUMPING = "Bewerk, niet naar boven",
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
SAVEFULLSIZEMAP = "Grote kaart opslaan",
COPYROOMS = "Kamer kopiëren",
SWAPROOMS = "Wissel kamers",

FLAGS = "Vlaggen",
ROOM = "kamer",
CONTENTFILLER = "Inhoud",

FLAGUSED = "Gebruikt     ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Niet gebruikt",
FLAGNONAME = "Geen naam",
USEDOUTOFRANGEFLAGS = "Gebruikte vlaggen buiten bereik:",

CUSTOMVVVVVVDIRECTORY = "VVVVVV-map",
CUSTOMVVVVVVDIRECTORYEXPL = "Voer hier het volledige pad naar je VVVVVV-map in, als het niet \"$1\" is (laat het anders leeg). Neem niet de map \"levels\" hierin op, en ook niet een schuine streep.",
LANGUAGE = "Taal",
DIALOGANIMATIONS = "Dialoogvenster-animaties",
FLIPSUBTOOLSCROLL = "Scrollrichting voor subtools omkeren",
ADJACENTROOMLINES = "Aanduidingen van blokken in naastgelegen kamers",
ASKBEFOREQUIT = "Vragen voor afsluiten",
NEVERASKBEFOREQUIT = "Nooit vragen voor afsluiten, zelfs als er niet-opgeslagen wĳzigingen zĳn",
COORDS0 = "Coördinaten laten beginnen bĳ 0 (zoals in interne scripting)",
ALLOWDEBUG = "Debugmodus inschakelen",
SHOWFPS = "FPS-teller tonen",
IIXSCALE = "2x schaal",
CHECKFORUPDATES = "Controleren op updates",
PAUSEDRAWUNFOCUSED = "Niet tekenen als het venster inactief is",
ENABLEOVERWRITEBACKUPS = "Reservekopie maken van levelbestanden die worden overschreven",
AMOUNTOVERWRITEBACKUPS = "Aantal reservekopieën om te bewaren per level",
SCALE = "Schaal",
LOADALLMETADATA = "Laad metadata (zoals titel, auteur en beschrĳving) voor alle bestanden in de lĳst met levels",
COLORED_TEXTBOXES = "Gebruik echte kleuren voor tekstvakken",

SCRIPTSPLIT = "Splitsen",
SPLITSCRIPT = "Scripts splitsen",
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
AMOUNTTILES = "Blokken:",
AMOUNTSOLIDTILES = "Vaste blokken:",
AMOUNTSPIKES = "Spĳkers:",


UNEXPECTEDSCRIPTLINE = "Onverwachte scriptregel zonder script: $1",
MAPWIDTHINVALID = "Levelbreedte is ongeldig: $1",
MAPHEIGHTINVALID = "Levelhoogte is ongeldig: $1",
LEVMUSICEMPTY = "Levelmuziek is leeg!",
NOT400ROOMS = "Het aantal elementen in levelMetaData is niet 400!",
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

-- b17 - L.MAL is concatenated with L.[...]CORRUPT
MAL = "Het levelbestand is niet in orde: ",
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
TIMEFORMAT = "Tĳdformaat",
CUSTOMDATEFORMAT = "Aangepast datumformaat",
SAVEBACKUPNOBACKUP = "Kies een unieke naam hiervoor als je niets wilt overschrĳven, hiervoor wordt namelĳk GEEN backup gemaakt!",

-- 1.2.4
AUTOSAVECRASHLOGS = "Crashlogboeken automatisch opslaan",
MOREINFO = "Laatste info",
COPYLINK = "Link kopiëren",
SCRIPTDISPLAY = "Tonen",
SCRIPTDISPLAY_USED = "Gebruikt",
SCRIPTDISPLAY_UNUSED = "Ongebruikt",

-- 1.3.0 (more changes)
RECENTLYOPENED = "Recent geopende levels",
REMOVERECENT = "Wil je het uit de lĳst met recent geopende levels verwĳderen?",
RESETCUSTOMBRUSH = "(Klik rechts om nieuwe grootte in te stellen)",

-- 1.3.2
DISPLAYSETTINGS = "Beeld/Schaal",
DISPLAYSETTINGSTITLE = "Beeld-/Schaalinstellingen",
SMALLERSCREEN = "Kleinere vensterbreedte (800px breed in plaats van 896px)",
FORCESCALE = "Schaalinstellingen forceren",
SCALENOFIT = "Deze schaalinstellingen maken het venster te groot om te passen.",
SCALENONUM = "Deze schaalinstellingen zĳn ongeldig.",
MONITORSIZE = "$1x$2-beeldscherm",
VEDRES = "Resolutie van Ved: $1x$2",
NONINTSCALE = "Schalen met niet-gehele getallen",

-- 1.3.4
USEFONTPNG = "Gebruik font.png uit de graphics-map van VVVVVV als lettertype",
MAKESLANGUAGEUNREADABLE = "", -- If your language uses another alphabet/writing system (thus becomes completely unreadable if only ASCII is used), please translate the following: " (makes Language unreadable!)" where Language is the name of your language.
REQUIRESHIGHERLOVE = " (vereist L{VE $1 of hoger)",
SYNTAXCOLOR_COMMENT = "Commentaar",
FPSLIMIT = "FPS-limiet",

MAPRESOLUTION = "Resolutie", -- Map export size
MAPRES_ASSHOWN = "Als weergegeven (max 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 per kamer)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 per kamer)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Linksboven",
WIDTHHEIGHT = "Breedte & hoogte",
BOTTOMRIGHT = "Rechtsonder",
RENDERERINFO = "Renderer-informatie:",
MAPINCOMPLETE = "De kaart is nog niet klaar (op het moment dat je op Opslaan klikte), probeer het opnieuw wanneer hĳ klaar is.",
KEEPDIALOGOPEN = "Houd dialoogvenster geopend",
TRANSPARENTMAPBG = "Transparante achtergrond",
MAPEXPORTERROR = "Fout bĳ het maken van de kaart.",
VIEWIMAGE = "Bekĳken", -- Verb, view image
INVALIDLINENUMBER = "Voer een geldig regelnummer in.",
OPENLEVELSFOLDER = "Levelsmap openen", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Verplaatsen",
GOTOROOM = "Ga naar kamer",
ESCTOCANCEL = "[Druk op ESC om te annuleren]",

INVALIDFILENAME_WIN = "Windows staat de volgende tekens niet toe in bestandsnamen:\n\n: * ? \" < > |\n\n(waar | een verticale lĳn is)",
INVALIDFILENAME_MAC = "macOS staat het teken : niet toe in bestandsnamen.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "CTRL",
TINY_SHIFT = "SHIFT",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Scripts [$1]",
SEARCHRESULTS_ROOMS = "Kamers [$1]",
SEARCHRESULTS_NOTES = "Notities [$1]",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Je hebt $1 plugin die niet wordt ondersteund in deze versie.",
		[1] = "Je hebt $1 plugins die niet worden ondersteund in deze versie.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Bĳ $1 test is een probleem geconstateerd bĳ dit level. Het probleem kan al automatisch zĳn opgelost, maar het is nog steeds mogelĳk dat dit crashes of inconsistenties zal veroorzaken.",
		[1] = "Bĳ $1 tests zĳn problemen geconstateerd bĳ dit level. De problemen kunnen al automatisch zĳn opgelost, maar het is nog steeds mogelĳk dat dit crashes of inconsistenties zal veroorzaken.",
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
		[0] = "LevelMetadata voor kamer #$1 heeft $2 ongeldige eigenschap!",
		[1] = "LevelMetadata voor kamer #$1 heeft $2 ongeldige eigenschappen!",
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
		[0] = "$1 blok is geen geldig geheel getal in het bereik 0-1199",
		[1] = "$1 blokken zĳn geen geldig geheel getal in het bereik 0-1199",
	},
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
"Startpunt",

}

subtoolnames = {

[1] = {"1x1-kwast", "3x3-kwast", "5x5-kwast", "7x7-kwast", "9x9-kwast", "Vul horizontaal", "Vul verticaal", "Aangepaste kwastgrootte", "Opvullen", "Aardappel voor het doen van dingen die magisch zĳn"},
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

}

ERR_VEDHASCRASHED = "Ved is gecrasht!"
ERR_VEDVERSION = "Ved-versie:"
ERR_LOVEVERSION = "L{VE-versie:"
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
		platbounds = "Platformbegrenzing veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
		enemybounds = "Vĳandbegrenzing veranderd van $1,$2,$3,$4 naar $5,$6,$7,$8\\Y",
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
subj = "Terug",
imgs = {},
cont = [[
\)
]] -- This should be left the same!
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
J¤  Soliditeit van blokken tonen\C
M¤  Kaart tonen\C
Q¤  Naar kamer gaan (typ coördinaten in als vier cĳfers)\C
/¤  Scripts\C
[¤  Y van muis vastzetten (om makkelĳker horizontale lĳnen te tekenen)\C
]¤  X van muis vastzetten (om makkelĳker verticale lĳnen te tekenen)\C
F11¤  tilesets en sprites opnieuw laden\C

Scriptbewerker\gh#

Ctrl+F¤  Zoeken\C
Ctrl+G¤  Ga naar regel\C
Ctrl+I¤  Schakel internescriptmodus in/uit\C
Ctrl+rechts¤  Spring naar script in voorwaardelĳk commando\C
Ctrl+links¤  Spring één stap terug\C

Scriptlĳst\gh#

N¤  Nieuw script maken\C
F¤  Ga naar vlaggenlĳst\C
/¤  Ga naar bovenste/laatste script\C
]]
},

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
                               "enoughtrinkets" worden uitgevoerd, anders zal het
                               huidige script verdergaan.
Het is gebruikelĳk om 0 als minimum aantal trinkets te gebruiken, om een script
altĳd te laden.

iftrinketsless¤(aantal,scriptnaam)\h#w

Als je aantal trinkets < aantal, ga naar script met naam scriptnaam.
Als je aantal trinkets >= aantal, ga dan verder in het huidige script.

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
subj = "Interne scripting",
imgs = {},
cont = [[
Interne scripting\wh#
\C=

De interne scripting geeft scripters meer controle, maar is ook een beetje
complexer dan vereenvoudigde scripting.

Om interne scripting te gebruiken in Ved kun je interne scripting-modus
inschakelen, om alle commando's in dat script te laten werken als interne
commando's. Je moet er echter zelf voor zorgen dat het script geladen wordt via
iftrinkets() of ifflag().

Kleurcodes:\w
Normaal - Zou veilig moeten zĳn, in het ergste geval zou VVVVVV kunnen crashen
          omdat je een fout hebt gemaakt.
Blauw¤   - Niet al deze commando's werken in aangepaste levels, andere zĳn niet\b
          echt logisch in aangepaste levels, of zĳn maar voor de helft nuttig
          omdat ze echt zĳn ontworpen voor het echte spel.
Oranje¤  - Deze werken en normaal gesproken zal er niks fout gaan, tenzĳ je er heel\o
          specifieke argumenten aan geeft die je opgeslagen data laten verdwĳnen.
Rood¤    - Rode commando's moeten niet gebruikt worden in levels omdat ze ofwel\r
          bepaalde delen van het hoofdspel ontgrendelen (waarvan je niet moet
          willen dat een level het doet, ook al zeg je dat iedereen het spel al
          uitgespeeld heeft), of maken de opgeslagen data helemaal corrupt.


squeak¤(kleur)\w#h

Zorgt dat een bemanningslid een geluid maakt, of een terminal-geluid

kleur - cyan/player/blue/red/yellow/green/purple/terminal

text¤(kleur,x,y,regels)\w#h

Slaat een tekstvak op in het geheugen met kleur, positie en aantal regels. Meestal
wordt het position-commando gebruikt na het text-commando (en het aantal regels)
wat de coördinaten zal overschrĳven die hier gegeven zĳn, dus deze worden meestal
op 0 gelaten.

kleur - cyan/player/blue/red/yellow/green/purple/gray
x - De x-positie van het tekstvak
y - De y-positie van het tekstvak
regels - Het aantal regels

position¤(x,y)\w#h

Overschrĳft de x,y van het text-commando en stelt daarmee de positie van het
tekstvak in.

x - center/centerx/centery, of de naam van een kleur
cyan/player/blue/red/yellow/green/purple
y - Wordt alleen gebruikt als x de naam van een kleur is. Kan above/below zĳn

endtext\w#h

Laat een tekstvak verdwĳnen (fade-out)

endtextfast\w#h

Laat een tekstvak onmiddellĳk verdwĳnen (zonder fade-out)

speak\w#h

Toont een tekstvak, zonder oude tekstvakken te verwĳderen. Pauzeert het script ook
tot je op action drukt (tenzĳ er een backgroundtext-commando boven staat)

speak_active\w#h

Toont een tekstvak, en verwĳdert oude tekstvakken. Pauzeert het script ook tot je
op action drukt (tenzĳ er een backgroundtext-commando boven staat)

backgroundtext\w#h

Als je dit commando op de regel boven speak of speak_active plaatst zal het spel
niet wachten totdat je op action drukt nadat een tekstvak gemaakt is. Dit kan
gebruikt worden om meerdere tekstvakken tegelĳk te maken.

changeplayercolour¤(kleur)\w#h

Verandert de kleur van de speler

kleur - cyan/player/blue/red/yellow/green/purple/teleporter

restoreplayercolour¤()\w#h

Verandert de kleur van de speler terug naar cyaan

changecolour¤(a,b)\w#h

Verandert de kleur van een bemanningslid (let op: dit werkt alleen met
bemanningsleden die gemaakt zĳn met het createcrewman-commando)

a - Kleur van het bemanningslid om te veranderen
cyan/player/blue/red/yellow/green/purple
b - Kleur om naar te veranderen

alarmon\w#h

Zet het alarm aan

alarmoff\w#h

Zet het alarm uit

cutscene¤()\w#h

Laat de cutscene-balken verschĳnen

endcutscene¤()\w#h

Laat de cutscene-balken verdwĳnen

untilbars¤()\w#h

Wacht tot cutscene()/untilbars() is voltooid

customifflag¤(n,script)\w#h

Hetzelfde als ifflag(n,script) in vereenvoudigde scripting

ifflag¤(n,script)\b#h

Hetzelfde als customifflag, maar laadt een intern script (uit het hoofdspel)

loadscript¤(script)\b#h

Laadt een intern script (uit het hoofdspel). Regelmatig gebruikt in aangepaste
levels als loadscript(stop)

iftrinkets¤(n,script)\b#h

Hetzelfde als vereenvoudigde scripting, maar laadt een intern script (uit het
hoofdspel)

iftrinketsless¤(n,script)\b#h

Hetzelfde als vereenvoudigde scripting, maar laadt een intern script (uit het
hoofdspel)

customiftrinkets¤(n,script)\w#h

Hetzelfde als iftrinkets(n,script) in vereenvoudigde scripting

customiftrinketsless¤(n,script)\w#h

Hetzelfde als iftrinketsless(n,script) in vereenvoudigde scripting (maar onthoud
dat het stuk is)

createcrewman¤(x,y,kleur,stemming,ki1,ki2)\w#h

Maakt een bemanningslid (kan niet gered worden)

stemming - 0 voor blĳ, 1 voor verdrietig
ki1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
      faceplayer/panic/faceleft/faceright/followposition,ai2
ki2 - nodig als followposition gebruikt wordt voor ki1

createentity¤(x,y,n,meta1,meta2)\o#h

Maakt een entiteit, zie de Lĳsten-pagina voor nummers van entiteiten

n - Het nummer van de entiteit

vvvvvvman¤()\w#h

Maakt de speler gigantisch

undovvvvvvman¤()\w#h

Terug naar normaal

hideplayer¤()\w#h

Maakt de speler onzichtbaar

showplayer¤()\w#h

Maakt de speler zichtbaar

gamestate¤(x)\o#h

Verander de gamestate naar het opgegeven state-nummer

gamemode¤(x)\b#h

teleporter om de kaart te tonen, game om het te verbergen (toont teleporters van
het hoofdspel)

x - teleporter/game

blackout¤()\w#h

Maakt het beeld zwart/bevriest het beeld

blackon¤()\w#h

Terug naar normaal van blackout()

fadeout¤()\w#h

Laat het beeld zwart worden

fadein¤()\w#h

Laat het beeld herstellen

befadein¤()\w#h

Laat het beeld onmiddellĳk herstellen van fadeout()

untilfade¤()\w#h

Wacht totdat fadeout()/fadein() klaar is

gotoroom¤(x,y)\w#h

Wĳzig de huidige kamer naar x,y, waar x en y beginnen bĳ 0.

x - x-coördinaat van kamer, beginnend bĳ 0
y - y-coördinaat van kamer, beginnend bĳ 0

gotoposition¤(x,y,f)\w#h

Verander Viridians positie naar x,y in deze kamer, en f is of je zwaartekracht
omgedraaid is of niet. (1 voor omgedraaid, 0 voor niet omgedraaid)

z - 1 voor zwaartekracht omgedraaid, 0 voor niet omgedraaid (je kunt ook
gotoposition(x,y) gebruiken, dan heb je standaard normale zwaartekracht)

flash¤(x)\w#h

Maakt het beeld wit, je kunt de tĳd veranderen voor hoe lnag het scherm wit moet
blĳven (alleen flash zal niet werken, je moet flash(5) gebruiken in combinatie met
playef(9) en shake(20) als je een normale flits wil)

x - Het aantal ticks. 30 ticks is bĳna een seconde.

play¤(x)\w#h

Begin met het spelen van muziek met intern nummer.

x - Intern liednummer

jukebox¤(x)\w#h

Maakt een jukeboxterminal wit en zet de kleur van alle andere terminals uit (in
aangepaste levels lĳkt het gewoon de witte kleur van alle geactiveerde terminals
uit te zetten).

musicfadeout¤()\w#h

Laat de muziek outfaden.

musicfadein¤()\w#h

Omgekeerde van musicfadeout() (lĳkt niet te werken)

stopmusic¤()\w#h

Stopt de muziek onmiddellĳk. Equivalent aan music(0) in vereenvoudigde scripting.

resumemusic¤()\w#h

Omgekeerde van stopmusic() (lĳkt niet te werken)

playef¤(x,n)\w#h

Speel een geluidseffect.

n - Eigenlĳk ongebruikt, en kan weggelaten worden. In VVVVVV 1.x werd dit gebruikt
voor het startpunt van het geluidseffect in milliseconden.

changemood¤(kleur,stemming)\w#h

Verandert de stemming van een bemanningslid (werkt alleen voor bemanningsleden
die gemaakt zĳn met createcrewman)

kleur - cyan/player/blue/red/yellow/green/purple
stemming - 0 voor blĳ, 1 voor verdrietig

everybodysad¤()\w#h

Maakt iedereen verdrietig (alleen voor bemanningsleden die gemaakt zĳn met
createcrewman en de speler)

changetile¤(kleur,tile)\w#h

Verandert de sprite van een bemanningslid (je kunt het veranderen naar elke sprite
in sprites.png, en het werkt alleen voor bemanningsleden die gemaakt zĳn met
createcrewman)

kleur - cyan/player/blue/red/yellow/green/purple/gray
tile - Nummer van sprite

face¤(a,b)\w#h

Laat het gezicht van bemanningslid a kĳken naar bemanningslid b (werkt alleen met
bemanningsleden die gemaakt zĳn met createcrewman)

a - cyan/player/blue/red/yellow/green/purple/gray
b - zelfde

companion¤(x)\b#h

Laat het opgegeven bemanningslid de speler volgen (voor zover ik me kan herinneren
hangt dit ook af van de locatie op de kaart)

changeai¤(bemanningslid,ki1,ki2)\w#h

Kan de gezichtsrichting van een bemanningslid veranderen of het loopgedrag

bemanningslid - cyan/player/blue/red/yellow/green/purple
ki1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
      faceplayer/panic/faceleft/faceright/followposition,ki2
ki2 - nodig als followposition gebruikt wordt voor ki1

changedir¤(kleur,richting)\w#h

Net zoals changeai(kleur,faceleft/faceright), verandert dit de gezichtsrichting.

kleur - cyan/player/blue/red/yellow/green/purple
richting - 0 is links, 1 is rechts

walk¤(richting,x)\w#h

Laat de speler lopen voor het opgegeven aantal ticks

richting - left/right

flipgravity¤(kleur)\w#h

Keert de zwaartekracht om van een bepaald bemanningslid (het werkt niet altĳd op
jezelf)

kleur - cyan/player/blue/red/yellow/green/purple

flipme\w#h

Corrigeer verticale positionering van meerdere tekstvakken in flip mode

tofloor\w#h

Laat de speler naar de grond gaan als hĳ daar niet al staat.

flip\w#h

Laat de zwaartekracht van de speler omdraaien

foundtrinket¤(x)\w#h

Laat een trinket gevonden zĳn

x - Nummer van het trinket

runtrinketscript\b#h

Speel Passion For Exploring?

altstates¤(x)\b#h

Verander de layout van sommige kamers, zoals de trinket-kamer in het schip voor en
na de explosie, en de ingang van het geheime lab (aangepaste levels ondersteunen
altstates helemaal niet)

createlastrescued¤(x,y)\b#h

Maak het laatst geredde bemanningslid op positie x,y (?)

rescued¤(kleur)\b#h

Maakt iemand gered

missing¤(kleur)\b#h

Maakt iemand vermist

finalmode¤(x,y)\b#h

Teleporteert je naar Outside Dimension VVVVVV, (46,54) is de eerste kamer van het
Final Level

setcheckpoint¤()\w#h

Stelt het checkpoint in op de huidige locatie

textboxactive\w#h

Laat alle tekstvakken op het scherm verdwĳnen behalve de laatst gemaakte

ifexplored¤(x,y,script)\w#h

Als x+1,y+1 bezocht is, ga naar (intern) script

iflast¤(bemanningslid,script)\b#h

Als bemanningslid x als laatste gered is, ga naar script

bemanningslid - Nummers worden hier gebruikt: 2: Vitellary, 3: Vermillion,
4: Verdigris, 5: Victoria (Ik weet het nummer voor Viridian en Violet niet)

ifskip¤(x)\b#h

Als je cutscenes overslaat in No Death Mode, ga naar script x

ifcrewlost¤(bemanningslid,script)\b#h

Als bemanningslid vermist is, ga naar script

showcoordinates¤(x,y)\w#h

Toon coördinaten x,y op de kaart (Dit werkt voor de kaart in aangepaste levels)

hidecoordinates¤(x,y)\w#h

Verberg coördinaten x,y op de kaart (Dit werkt voor de kaart in aangepaste levels)

showship\w#h

Toon het schip op de kaart

hideship\w#h

Verberg het schip op de kaart

showsecretlab\w#h

Toon het geheime lab op de kaart

hidesecretlab\w#h

Verberg het geheime lab op de kaart

showteleporters¤()\b#h

Toon de teleporters op de kaart (Ik denk dat het alleen de teleporter in Space
Station 1 toont)

hideteleporters¤()\b#h

Verberg de teleporters op de kaart

showtargets¤()\b#h

Toon de doelen op de kaart (onbekende teleporters die getoond worden als ?'s)

hidetargets¤()\b#h

Verberg de doelen op de kaart

showtrinkets¤()\b#h

Toon de trinkets op de kaart

hidetrinkets¤()\b#h

Verberg de trinkets op de kaart

hascontrol¤()\w#h

Laat de speler besturing hebben, maar dit werkt niet tĳdens het uitvoeren van
scripts

nocontrol¤()\w#h

Het omgekeerde van hascontrol()

specialline¤(x)\b#h

Speciale teksten die worden weergegeven in het hoofdspel

destroy¤(x)\w#h

Hetzelfde gedrag als het vereenvoudigde commando

x - gravitylines/warptokens/platforms

delay¤(x)\w#h

Hetzelfde gedrag als het vereenvoudigde commando

flag¤(x,on/off)\w#h

Hetzelfde gedrag als het vereenvoudigde commando

telesave¤()\r#h

Slaat je spel op (in het normale teleporter-bestand, dus gebruik het niet!)

befadein¤()\w#h

Laat het beeld onmiddellĳk herstellen van fadeout()

createactivityzone¤(kleur)\b#h

Maakt een zone waar je staat die zegt "Press ACTION to talk to (Bemanningslid)"

createrescuedcrew¤()\b#h

Maakt alle geredde bemanningsleden

trinketyellowcontrol¤()\b#h

Tekst van Vitellary wanneer hĳ je een trinket geeft in het echte spel

trinketbluecontrol¤()\b#h

Tekst van Victoria wanneer ze je een trinket geeft in het echte spel

rollcredits¤()\r#h

Laat de credits rollen. Het vernietigt je opgeslagen data nadat de credits
afgelopen zĳn!

teleportscript¤(script)\b#h

Gebruikt om een script in te stellen dat wordt uitgevoerd wanneer je een
teleporter gebruikt

clearteleportscript¤()\b#h

Verwĳdert het teleporter-script ingesteld met teleporterscript(x)

moveplayer¤(x,y)\w#h

Verplaatst de speler x pixels naar rechts en y pixels naar beneden. Natuurlĳk kun
je ook negatieve getallen gebruiken om hem omhoog en naar links te verplaatsen

do¤(n)\w#h

Start een lus-blok dat n keer herhaald zal worden

loop\w#h

Zet dit aan het eind van het lus-blok

leavesecretlab¤()\b#h

Zet "secret lab mode" uit

shake¤(n)\w#h

Schud het beeld voor n ticks. Dit zal geen wachttĳd veroorzaken.

activateteleporter¤()\w#h

Als er een teleporter in de kamer is zal deze wit gloeien en hem aanraken zal je
opgeslagen data niet vernietigen. Werkt misschien niet als er meerdere teleporters
zĳn.

customposition¤(x,y)\w#h

Overschrĳft de x,y van het text-commando en stelt daarmee de positie van het
tekstvak in, maar voor bemanningsleden worden bemanningsleden die gered kunnen
worden gebruikt om mee te positioneren, in plaats van
createentity-bemanningsleden.

x - center/centerx/centery, of de naam van een kleur
cyan/player/blue/red/yellow/green/purple (kan gered worden)
y - Wordt alleen gebruikt als x de naam van een kleur is. Kan above/below zĳn

custommap¤(on/off)\w#h

De interne variant van het map-commando

trinketscriptmusic\w#h

Speelt Passion For Exploring, zonder argumenten te accepteren(?)

startintermission2\w#h

Alternatieve finalmode(46,54), brengt je naar het Final Level zonder argumenten te
accepteren. Crasht bĳ Timeslip.

resetgame\w#h

Reset alle trinkets, verzamelde bemanningsleden en vlaggen, en teleporteert de
speler naar het laatste checkpoint.

redcontrol\b#h

Start een gesprek met Vermilion net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

greencontrol\b#h

Start een gesprek met Verdigris net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

bluecontrol\b#h

Start een gesprek met Victoria net zoals wanneer je haar in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

yellowcontrol\b#h

Start een gesprek met Vitellary net zoals wanneer je hem in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

purplecontrol\b#h

Start een gesprek met Violet net zoals wanneer je haar in het hoofdspel ontmoet
en op ENTER drukt. Maakt daarna ook een activiteitszone.

foundlab\b#h

Speelt geluidseffect 3 af, toont tekstvak met "Congratulations! You have found the
secret lab!" Voert geen endtext uit, en heeft geen verdere ongewenste effecten.

foundlab2\b#h

Toont het tweede tekstvak dat je ziet nadat je het geheime lab hebt ontdekt. Voert
ook geen endtext uit, en heeft geen verdere ongewenste effecten.

entersecretlab\r#h

Ontgrendelt het geheime lab voor het hoofdspel, wat waarschĳnlĳk een ongewenst
effect is voor een aangepast level om te hebben. Zet "secret lab mode" aan.
]]
},

{
subj = "Lĳsten",
imgs = {},
cont = [[
Lĳsten\wh#
\C=

Dit zĳn lĳsten van nummers die gebruikt worden in VVVVVV, vooral gekopieerd uit
forumberichten. Bedankt aan iedereen die deze lĳsten samengesteld heeft!


Inhoud\w&Z+
\&Z+
#Muzieknummers (vereenvoudigde scripting)\C&Z+l
#Muzieknummers (intern)\C&Z+l
#Geluidseffecten\C&Z+l
#Entiteiten\C&Z+l
#Kleuren voor createentity()-¤Kleuren voor createentity()-bemanningsleden\LC&Z+l
#Vĳand-bewegingstypes\C&Z+l
#Gamestates\C&Z+l


Muzieknummers (vereenvoudigde scripting)\h#

0 - Silence (geen muziek)
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

Muzieknummers (intern)\h#

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

Geluidseffecten\h#

0 - Keer zwaartekracht om naar plafond
1 - Keer zwaartekracht om naar vloer
2 - Huil
3 - Trinket verzameld
4 - Muntje verzameld
5 - Checkpoint aangeraakt
6 - Sneller drĳfzandblok aangeraakt
7 - Normaal drĳfzandblok aangeraakt
8 - Zwaartekrachtlĳn aangeraakt
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
1 - Vĳand
    Metadata: bewegingstype, bewegingssnelheid
    Omdat de benodigde data ontbreekt krĳg je alleen een paarse doos-vĳand, tenzĳ
    je in de polar dimension van VVVVVV bent wanneer je het commando gebruikt
2 - Bewegend platform
    Metadata: bewegingstype, bewegingssnelheid
    Opmerking: lopende banden zĳn geïmplementeerd als bewegende platforms, zie
    bewegingstype 8 en 9.
3 - Een brekend platform
4 - Een sneller drĳfzandblok van 1x1
5 - Een omgekeerde Viridian, je zwaartekracht zal omkeren wanneer je hem aanraakt
6 - Raar rood flitsend dingetje dat snel verdwĳnt
7 - Zelfde als hierboven, maar flitst niet en is cyaan-gekleurd
8 - Een munt uit het prototype
    Metadata: Munt-ID
9 - Trinket
    Metadata: Trinket-ID
    Opmerking: trinket-ID's beginnen bĳ 0, en alles boven 19 wordt niet
    opgeslagen in het bestand wanneer je het level herstart
10 - Checkpoint
     Metadata: Checkpoint-status (0=ondersteboven, 1=normaal), Checkpoint-ID
     (controleert of het checkpoint actief is of niet)
11 - Horizontale zwaartekrachtlĳn
     Metadata: Lengte in pixels
12 - Verticale zwaartekrachtlĳn
     Metadata: Lengte in pixels
13 - Warptoken
     Metadata: Bestemming in blokken op X-as, bestemming in blokken op Y-as
14 - De ronde teleporter
     Metadata: Checkpoint-ID(?)
15 - Verdigris
     Metadata: KI-status
16 - Vitellary (ondersteboven)
     Metadata: KI-status
17 - Victoria
     Metadata: KI-status
18 - Bemanningslid
     Metadata: Kleur (gebruikt kleurenlĳst, niet bemanningslidkleuren), stemming
19 - Vermilion
     Metadata: KI-status
20 - Terminal
     Metadata: Sprite, Script-ID(?)
21 - Zelfde als hierboven maar wanneer aangeraakt zal de terminal geen licht geven
     Metadata: Sprite, Script-ID(?)
22 - Verzamelde trinket
     Metadata: Trinket-ID
23 - Gravitron-vierkant
     Metadata: Richting
     Als je een negatieve X-coördinaat opgeeft (of te hoog) zal een pĳltje getoond
     worden, net zoals in de echte gravitron
24 - Bemanningslid intermission 1
     Metadata: "Rauwe" kleur, stemming
     Lĳkt niet getroffen te worden door gevaren, maar zou wel moeten.
25 - Trofee
     Metadata: Uitdagings-id, sprite
     Als de uitdaging voltooid is zal de basis-sprite-ID (wat je krĳgt als je
     sprite=0 gebruikt) veranderen. Gebruik alleen 0 of 1 als je voorspelbare
     resultaten wil (0=normaal, 1=ondersteboven)
26 - Het warptoken naar het Secret Lab
     Houd in gedachten dat deze warp alleen geïmplementeerd is als een
     mooi-uitziende sprite. Je moet de functionaliteit zelf scripten
55 - Bemanningslid dat gered kan worden
     Metadata: Kleur van bemanningslid. Kleur >6 zal altĳd een *blĳe* Viridian
     tonen
56 - Vĳand voor aangepaste levels
     Metadata: Bewegingstype, bewegingssnelheid
     Houd in gedachten dat als er geen vĳanden in de kamer zĳn, de vĳand-sprite
     niet correct geüpdate wordt en de vĳand die je de laatste keer zag zal worden
     getoond, of een vierkante vĳand
Ongedefinieerde entiteiten (27-50, 57+) geven rare Viridians.

Kleuren voor createentity()-\h#

bemanningsleden\h

0: Cyaan
1: Flitsend rood (gebruikt voor dood)
2: Donker-oranje
3: Trinket-kleur
4: Grĳs
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
18: Grĳs
19: Donkerder groen
20: Roze, zelfde als Violet
21: Lichter grĳs
22: Wit
23: Flitsend wit
24-29: Wit
30: Grĳs
31: Donker, beetje paarsig grĳs?
32: Donkercyaan/-groen
33: Donkerblauw
34: Donkergroen
35: Donkerrood
36: Saai oranje
37: Flitsend grĳs
38: Grĳs
39: Donkerder cyaan/groen
40: Flitsender grĳs
41-99: Wit
100: Donkergrĳs
101: Flitsend wit
102: Teleporter-kleur
103 en verder: Wit

Vĳand-bewegingstypes\h#

0 - Springt op en neer, begint beneden.
1 - Springt op en neer, begint boven
2 - Springt naar links en rechts, begint links.
3 - Springt naar links en rechts, begint rechts.
4, 7, 11 - Verplaatst naar rechts tot botsing.
5 - Zelfde als hierboven, maar gedraagt zich vreemd wanneer het botst.
    GIF hier: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Springt op en neer, maar bereikt een bepaalde y-positie voor terug te gaan
    naar beneden. Gebruikt in "Trench warfare".
8, 9 - Voor bewegende platforms zĳn het lopende banden, en stilstaand voor de rest
14 - Kan geblokkeerd worden door brekende platforms
15 - Stilstaand (?)
10, 12 - Kloont naar rechts/op dezelfde plek, crasht VVVVVV als het te intens
         wordt, en maakt je opgeslagen data corrupt als je opslaat.
13 - Net zoals 4, maar beweegt naar beneden tot botsing.
16 - Verschĳnt en verdwĳnt.
17 - Gejaagde beweging naar links
18 - Gejaagde beweging naar rechts, klein beetje sneller
19+ - Stilstaand (?)

Gamestates\h#

0 - Breekt uit de meeste gamestates
1 - Zet de gamestate op 0 (oftewel in de praktĳk hetzelfde als hierboven)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Voert het script "returntohub" uit (oftewel fadeout, teleporteer naar rechts
    voor The Tower, fadein, speel Passion for Exploring)
7 - Verwĳdert tekstvakken
8 - "Press enter to view map and quicksave"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Probeert flipmode-check
     te gebruiken om "the ceiling" of "the floor" te laten zien, maar omdat dit
     fout gaat, wordt in plaats daarvan weergegeven wat hierboven staat)
12 - "You can't continue to the next room until he is safely accross."
13 - Verwĳdert tekstvakken snel
14 - "When you're standing on the floor," (hetzelfde is hier van toepassing als
     bĳ 11)
15 - Maakt Viridian blĳ
16 - Maakt Viridian verdrietig
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - Als vlag 1 op 0 staat, zet vlag 1 op 1 en verwĳder tekstvakken
21 - Als vlag 2 op 0 staat, zet vlag 2 op 1 en verwĳder tekstvakken
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - "Violet, is that you?"-cutscene (zolang vlag 6 op 0 staat)
32 - Als vlag 7 op 0 staat: "A teleporter!" "I can get back to the ship with
     this!"
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
47 - Als vlag 69 op 0 staat: "Ohh! I wonder what that is?"-trinket-cutscene
48 - Als vlag 70 op 0 staat: "This seems like a good place to store anything I
     find out there..." (Victoria nog niet gevonden)
49 - Als vlag 71 op 0 staat: Speel Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
Met gamestate 50-56 kun je kiezen waar te beginnen, want alles komt na elkaar
80 - Dan en slechts dan als het beeld zwart is, ga door naar state 81 (Mĳn gok is
     dat dit wordt aangeroepen wanneer ESC wordt ingedrukt, voor het pauze-menu
     wordt geopend)
81 - Ga terug naar het hoofdmenu
82 - Resultaten van time trial (bugged)
83 - Als beeld zwart is, ga door naar state 84
84 - Resultaten van time trial (Ik denk dat 82 beter werkt dan 84)
85 - De Time Trial-versie van gamestate 200 (Flits, speel Positive Force, zet
     finalstretch-mode aan)
States 90-95 zĳn gerelateerd aan time trials, maar werken niet goed in aangepaste
     levels. De enige echte effecten die gebeuren in aangepaste levels zĳn een
     warp, en verandering van de muziek
90 - Space Station 1
91 - The Laboratory
92 - Warp Zone
93 - The Tower
94 - Space Station 2
95 - Final Level
96 - Als het beeld zwart is, ga door naar state 97
97 - Verlaat Super Gravitron (teleporteer en speel Pipe Dream)
100 - Als vlag 4 op 0 staat: ga door naar state 101
101 - Als je zwaartekracht omgekeerd is, ga terug naar de vloer, ga naar state 102
De volgende states (102-112) proberen naar de huidige state te gaan + 1, net zoals
      in 50-56 (maar vormt geen lus), maar kan problemen veroorzaken omdat de
      helft van de staten (103, 105, 107, 109, 111) niet bestaat.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Verwĳdert tekstvakken
115 - In wezen niets, ga door naar state 116
116 - Rood tekstvak onderin beeld met tekst "Sorry Eurogamers! Teleporting around
      the map doesn't work in this version!", ga door naar state 117, wat niet
      bestaat, dus dingen zouden fout kunnen gaan
118 - Verwĳdert tekstvakken
State 120-128 werken een beetje zoals 102-112, d.w.z in serie, maar met minder
      problemen
120 - Als vlag 5 op 0 staat: ga door naar state 121
121 - Als je op de vloer staat, keer zwaartekracht om
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Verwĳdert tekstvakken
200 - Final mode
1000 - Zet cutscenebalken aan, bevriest het spel, gaat door naar state 1001
1001 - "You got a shiny trinket!" (maar je hebt er niet echt een gekregen, dit
       wordt gewoon iedere keer dat je er een verzamelt aangeroepen), ga door naar
       state 1003
1003 - Herstel spel naar normale situatie
1010 - You found a crewmate! op dezelfde manier als voor trinkets
2000 - Sla het spel op
2500-2509 - Teleporteer naar een of andere vreemde niet-bestaande locatie,
            vermoedelĳk naar The Laboratory denk ik, ga door naar state 2510
2510 - Viridian: "Hello?", ga door naar state 2512
2512 - Viridian: "Is anybody there?", ga door naar state 2514
2514 - Verwĳdert tekstvakken, speel Potential For Anything
States 3000-3099:
3000-3005 - "Level Complete! You've rescued..." het bemanningslid toegepast op
            companion(), standaard Verdigris. 6=Verdigris, 7=Vitellary,
            8=Victoria, 9=Vermilion, 10=Viridian (ja, echt), 11=Violet
            (Gamestates: 3006-3011=Verdigris, 3020-3026=Vitellary,
            3040-3046=Victoria, 3060-3066=Vermilion, 3080-3086=Viridian,
            3050-3056=Violet)
3070-3072 - Do dingen na redding, normaal gesproken terug naar schip
3501 - Game Complete
4010 - Flits + warp
4070 - Het Final Level, maar het spel zal crashen wanneer je Timeslip bereikt
       (Door de manier waarop het spel entiteit-informatie krĳgt, wat stuk is in
       aangepaste levels)
4080 - Kapitein teruggeteleporteerd naar het schip:
       "Hello!" [C[C[C[C[Captain!]-cutscene + credits.
       Het bovenstaande zal je opgeslagen data vernietigen dus doe het niet tenzĳ
       je een backup hebt gemaakt!
4090 - Cutscene nadat je space station 1 hebt afgemaakt
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
p - Paars\p
V - Donkergroen\V
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
[¤¤#Links¤¤Like¤¤] [¤¤#Voorbeeld:¤¤Dislike¤¤]\n L vl n L rl\

[¤#Links¤Like¤] [¤#Voorbeeld:¤Dislike¤]\n L vl n L rl
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
},

{
subj = "Credits",
imgs = {"credits.png"},
cont = [[
\0















Credits\wh#
\C=

Ved is gemaakt door Dav999

Sommige afbeeldingen en het lettertype zĳn gemaakt door Doormat

Russische vertaling: CreepiX, Cheeprick
Esperanto vertaling: Doormat
Duitse vertaling: r00ster
Franse vertaling: RhenaudTheLukark


Met dank aan:\h#


Terry Cavanagh voor het maken van VVVVVV

Iedereen die bugs gerapporteerd heeft, met ideeën is gekomen en mĳ heeft
gemotiveerd om dit te maken!








License\h#

Copyright 2015-2019  Dav999              (I do not claim ownership of or copyright
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

}
