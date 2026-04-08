-- Language file for Ved
--- Language: de (de)
--- Last converted: 2026-04-08 04:26:25 (CEST)

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

TRANSLATIONCREDIT = "Möchtest du bei der Übersetzung auf Deutsch helfen? Bitte nimm Kontakt mit Dav999 auf!", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Deine LÖVE-Version ist veraltet. Bitte benutze Version 0.9.1 oder höher.\nDu kannst die neuste LÖVE-Version von https://love2d.org downloaden.",
OUTDATEDLOVE090 = "LÖVE 0.9.0 wird von Ved nicht mehr unterstützt. Glücklicherweise werden LÖVE 0.9.1 und alle darüber weiterhin funktionieren.\nDu kannst die neuste LÖVE-Version von https://love2d.org/ herunterladen.",

OSNOTRECOGNIZED = "Dein Betriebssystem ($1) wurde nicht erkannt! Benutze Standard Dateisystemfunktionen; Level werden hier gespeichert:\n\n$2",
MAXTRINKETS = "Die maximale Anzahl an Dingsdas ($1) wurde in diesem Level erreicht.",
MAXCREWMATES = "Die maximale Anzahl an Crewmitglieder ($1) wurde in diesem Level erreicht.",
UNSUPPORTEDTOOL = "Nicht unterstütztes Werkzeug! Werkzeug: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Konnte nicht den Inhalt vom Levelordner bekommen. Bitte überprüfe ob $1 existiert und versuche es erneut.",
MAPSAVEDAS = "Kartenbild gespeichert als $1!",
RAWENTITYPROPERTIES = "Du kannst die Eigenschaften von diesem Objekt ändern.",
UNKNOWNENTITYTYPE = "Unbekannter Objekttyp $1",
WARPTOKENENT404 = "Teleporterobjekt existiert nicht mehr!",
SPLITFAILED = "Trennung ist fehlgeschlagen! Hast du zu viele Zeilen zwischen einem Textbefehl und einem speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Es sind keine Flags mehr übrig, also kann eine oder mehr Flagkennzeichnungen in diesem Skript nicht mit Flagnummern verbunden werden. Wenn versucht wird dieses Skript in VVVVVV auszuführen, klappt es vielleicht nicht. Ziehe in betracht, alle Verweise auf nicht mehr benötigte Flags zu entfernen, und versuche es erneut.",
NOFLAGSLEFT_LOADSCRIPT = "Es sind keine Flags mehr übrig, also ein Ladeskript mit einer neuen Flag konnte nicht erstellt werden. Stattdessen, wurde ein Ladeskript erstellt welches immer das Zielskript ladet mit iftrinkets(0,$1). Ziehe in Betracht, alle Verweise auf nicht mehr benötigte Flags zu entfernen, und versuche es erneut.",
LEVELOPENFAIL = "Kann nicht $1.vvvvvv öffnen.",
SIZELIMIT = "Die maximale Größe eines Levels ist $1 bis $2.\n\nDie Levelgröße wird geändert zu $3 bis $4.",
SCRIPTALREADYEXISTS = "Skript \"$1\" existiert schon!",
FLAGNAMENUMBERS = "Flagnamen können nicht nur Nummern enthalten.",
FLAGNAMECHARS = "Flagnamen können keine Klammern, Kommas oder Leerzeichen enthalten.",
FLAGNAMEINUSE = "Der Flagname $1 wird bereits von Flag $2 benutzt",
DIFFSELECT = "Vergleiche Level. Das Level was du auswählst wird behandelt als stamme es von einer älteren Version.",
SUREQUITNEW = "Du hast ungespeicherte Änderungen. Willst du diese Änderungen speichern bevor du beendest?",
SURENEWLEVELNEW = "Du hast ungespeicherte Änderungen. Willst du diese Änderungen speichern bevor du ein neues Level erstellst?",
SUREOPENLEVEL = "Du hast ungespeicherte Änderungen. Willst du diese Änderungen speichern bevor du dieses Level öffnest?",
NAMEFORFLAG = "Name für Flag $1:",
SCRIPT404 = "Skript \"$1\" existiert nicht!",
ENTITY404 = "Objekt #$1 existiert nicht mehr!",
GRAPHICSCARDCANVAS = "Tut mir leid, es sieht so aus als ob deine Grafikkarte oder Treiber diese Funktion nicht unterstützt!",
MAXTEXTURESIZE = "Tut mir leid, ein Bild mit der Größe $1x$2 zu erstellen scheint nicht von deiner Grafikkarte oder deinem Treiber unterstützt zu sein.\n\nDas Größenlimit auf diesem System ist $3x$3.",
SUREDELETESCRIPT = "Bist du sicher du willst das Skript \"$1\" löschen?",
SUREDELETENOTE = "Bist du sicher dass du diese Notiz löschen möchtest?",
THREADERROR = "Threadfehler!",
WHATDIDYOUDO = "Was hast du getan?!",
UNDOFAULTY = "Was tust du?",
SOURCEDESTROOMSSAME = "Quell- und Zielräume sind identisch!",
COORDS_OUT_OF_RANGE = "Hm? Diese Koordinaten befinden sich nicht einmal in dieser Dimension!",
UNKNOWNUNDOTYPE = "Konnte nicht rückgängig machen: \"$1\"!",
MDEVERSIONWARNING = "Dieses Level scheint in einer neueren Version von Ved gemacht zu sein, und kann Daten enthalten die verloren gehen wenn du dieses Level speicherst.",
FORGOTPATH = "Du hast vergessen einen Pfad anzugeben!",
LIB_LOAD_ERRMSG = "Eine benötigte Bibliothek konnte nicht geladen werden. Bitte informiere Dav999 über dieses Problem.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nVersuche, GCC zu installieren, um dieses Problem zu lösen, falls es nicht bereits installiert ist.",

SELECTCOPY1 = "Wähle den Raum aus zum kopieren",
SELECTCOPY2 = "Wähle die Position wo der Raum hinkopiert werden soll",
SELECTSWAP1 = "Wähle den ersten Raum aus zum tauschen",
SELECTSWAP2 = "Wähle den zweiten Raum aus zum tauschen",

TILESETCHANGEDTO = "Tileset geändert zu $1",
TILESETCOLORCHANGEDTO = "Tilesetfarbe geändert zu $1",
ENEMYTYPECHANGED = "Objekttyp verändert",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Geändert zu $1 Tileplatzierung",
CHANGEDTOMODEAUTO = "automatischer",
CHANGEDTOMODEMANUAL = "manueller",
CHANGEDTOMODEMULTI = "multi-Tileset",

BUSYSAVING = "Speichern...",
SAVEDLEVELAS = "Level wurde gespeichert als $1.vvvvvv",

ROOMCUT = "Raum augeschnitten und zur Zwischenablage kopiert",
ROOMCOPIED = "Raum wurde zur Zwischenablage kopiert",
ROOMPASTED = "Raum eingefügt",

METADATAUNDONE = "Leveloptionen wurden rückgängig gemacht",
METADATAREDONE = "Leveloptionen wiederholt",

BOUNDSFIRST = "Klicke auf die erste Ecke der Begrenzung", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Klicke auf die letzte Ecke", -- Old string: Click the bottom right corner

TILE = "Tile $1",
HIDEALL = "Verstecken",
SHOWALL = "Zeige alles",
SCRIPTEDITOR = "Skripteditor",
FILE = "Datei",
NEW = "Neu",
OPEN = "Öffnen",
SAVE = "Speichern",
UNDO = "Rückgängig",
REDO = "Wiederholen",
COMPARE = "Vergleichen",
STATS = "Statistiken",
SCRIPTUSAGES = "Benutzungen",
EDITTAB = "Bearbeiten",
COPYSCRIPT = "Skript kopieren",
SEARCHSCRIPT = "Suchen",
GOTOLINE = "Gehe zu Zeile",
GOTOLINE2 = "Gehe zu Zeile:",
INTERNALON = "Int.sc ist an",
INTERNALOFF = "Int.sc ist aus",
INTERNALON_LONG = "Interner Skript-Modus eingeschaltet",
INTERNALOFF_LONG = "Interner Skript-Modus ausgeschaltet",
INTERNALYESBARS = "say(-1) int.sc",
INTERNALNOBARS = "Ladeskript int.sc",
VIEW = "Ansehen",
SYNTAXHLOFF = "Syntax HL: an",
SYNTAXHLON = "Syntax HL: aus",
TEXTSIZEN = "Textgröße: N",
TEXTSIZEL = "Textgröße: L",
INSERT = "Einfügen",
HELP = "Hilfe",
INTSCRWARNING_NOLOADSCRIPT = "Ladeskript benötigt!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Ein Skript, das dieses Skript lädt, wurde nicht erkannt. Diese Art von internem Skript funktioniert wahrscheinlich nicht so, wie du es erwartest, wenn es nicht über ein anderes Skript geladen wird.",
INTSCRWARNING_BOXED = "Direkte Skriptbox/Konsolen Referenz!",
INTSCRWARNING_BOXED_EXPL = "Es gibt eine Konsole oder ein Skriptfeld, das dieses Skript direkt lädt. Das Aktivieren dieser Konsole oder dieses Skriptfelds wird wahrscheinlich nicht wie erwartet funktionieren; diese Art von internem Skript muss über ein Ladeskript geladen werden.",
INTSCRWARNING_NAME = "Ungeeigneter Skriptname!",
INTSCRWARNING_NAME_EXPL = "Der Name dieses Skripts hat einen Großbuchstaben, ein Leerzeichen, eine Klammer oder ein Komma. Dieses Skript kann nur direkt von einer Konsole oder Skriptbox geladen werden.",
COLUMN = "Spalte: ",

BTN_OK = "OK",
BTN_CANCEL = "Abbrechen",
BTN_YES = "Ja",
BTN_NO = "Nein",
BTN_APPLY = "Anwenden",
BTN_QUIT = "Beenden",
BTN_DISCARD = "Verwerfen",
BTN_SAVE = "Speichern",
BTN_CLOSE = "Schließen",
BTN_LOAD = "Laden",
BTN_ADVANCED = "Erweitert",

BTN_AUTODETECT = "Erkennen",
BTN_MANUALLY = "Manuell", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Erneut versuchen",

COMPARINGTHESE = "Vergleiche $1.vvvvvv zu $2.vvvvvv",
COMPARINGTHESENEW = "Vergleiche (ungespeichertes Level) zu $1.vvvvvv",

RETURN = "Zurück",
CREATE = "Erstellen",
GOTO = "Gehe zu",
DELETE = "Löschen",
RENAME = "Umbennen",
CHANGEDIRECTION = "Richtung ändern",
TESTFROMHERE = "Teste von hier",
FLIP = "Umdrehen",
CYCLETYPE = "Typ ändern",
GOTODESTINATION = "Gehe zum Ziel",
GOTOENTRANCE = "Gehe zum Eingang",
CHANGECOLOR = "Farbe ändern",
EDITTEXT = "Text bearbeiten",
COPYTEXT = "Text kopieren",
EDITSCRIPT = "Skript bearbeiten",
OTHERSCRIPT = "Skript umbennen",
PROPERTIES = "Eigenschaften",
CHANGETOHOR = "Ändern zu horizontal",
CHANGETOVER = "Ändern zu vertikal",
RESIZE = "Bewegen/Größe ändern",
CHANGEENTRANCE = "Bewege Eingang",
CHANGEEXIT = "Bewege Ausgang",
COPYENTRANCE = "Eingang kopieren",
LOCK = "Fixieren",
UNLOCK = "Entsperren",

VEDOPTIONS = "Ved-Optionen",
LEVELOPTIONS = "Leveloptionen",
MAP = "Karte",
SCRIPTS = "Skripte",
SEARCH = "Suchen",
SENDFEEDBACK = "Feedback senden",
LEVELNOTEPAD = "Level-\nNotizblock",
PLUGINS = "Plugins",

BACKB = "Zurück <<",
MOREB = "Mehr >>",
AUTOMODE = "Modus: automatisch",
AUTO2MODE = "Modus: multi",
MANUALMODE = "Modus: manuell",
ENEMYTYPE = "Objekttyp: $1",
PLATFORMBOUNDS = "Platf. Grenze",
WARPDIR = "Teleportations\n-richtung: $1",
ENEMYBOUNDS = "Gegnergrenzen",
ROOMNAME = "Raumname",
ROOMOPTIONS = "Raumoptionen",
ROTATE180 = "Um 180 Grad drehen",
ROTATE180UNI = "Um 180° drehen",
HIDEBOUNDS = "Grenzen ausblenden",
SHOWBOUNDS = "Grenzen einblenden",

ROOMPLATFORMS = "Raumplattformen", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Raumgegner",

OPTNAME = "Name",
OPTBY = "Von",
OPTWEBSITE = "Webseite",
OPTDESC = "Beschrei\n-bung", -- If necessary, you can span multiple lines
OPTSIZE = "Größe",
OPTMUSIC = "Musik",
CAPNONE = "KEINE",
ENTERLONGOPTNAME = "Levelname:",

X = "x", -- Used for level size: 20x20

SOLID = "Solid",
NOTSOLID = "Unsolid",

TSCOLOR = "Farbe $1",

LEVELSLIST = "Level",
LOADTHISLEVEL = "Lade dieses Level: ",
ENTERNAMESAVE = "Speichern als: ",
SEARCHFOR = "Suche nach: ",

VERSIONERROR = "Kann nicht die Version prüfen.",
VERSIONUPTODATE = "Deine Version von Ved ist auf dem neusten Stand.",
VERSIONOLD = "Update verfügbar! Neuste Version: $1",
VERSIONCHECKING = "Suche nach Updates...",
VERSIONDISABLED = "Updateüberprüfung deaktiviert",
VERSIONCHECKNOW = "Jetzt überprüfen", -- Check for updates now

SAVENOSUCCESS = "Speichern nicht erfolgreich! Fehler: ",
INVALIDFILESIZE = "Ungültige Dateigröße.",

EDIT = "Bearbeiten",
EDITWOBUMPING = "Bearbeite ohne Stoß zum Anfang",
EDITWBUMPING = "Bearbeite mit Stoß zum Anfang",
COPYNAME = "Name kopieren",
COPYCONTENTS = "Inhalt kopieren",
DUPLICATE = "Duplizieren",

NEWSCRIPTNAME = "Name:",
CREATENEWSCRIPT = "Erstelle neues Skript",

NEWNOTENAME = "Name:",
CREATENEWNOTE = "Erstelle neue Notiz",

ADDNEWBTN = "[Neue hinzufügen]",
IMAGEERROR = "[BILDFEHLER]",

NEWNAME = "Neuer Name:",
RENAMENOTE = "Notiz umbennen",
RENAMESCRIPT = "Skript umbennen",

LINE = "Zeile ",

SAVEMAP = "Karte speichern",
COPYROOMS = "Kopiere Raum",
SWAPROOMS = "Tausche Räume",

MAP_STYLE = "Kartenstil",
MAP_STYLE_FULL = "Voll", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Minikarte", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Flags",
ROOM = "Raum",
CONTENTFILLER = "Inhalt",

FLAGUSED = "Benutzt      ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Nicht benutzt",
FLAGNONAME = "Kein Name",
USEDOUTOFRANGEFLAGS = "Flags die außer Reichweite sind wurden benutzt:",

VVVVVVSETUP = "VVVVVV-\nEinrichtung",
CUSTOMVVVVVVDIRECTORY = "VVVVVV-Ordner",
CUSTOMVVVVVVDIRECTORYEXPL = "Der normale VVVVVV-Order den Ved erwartet ist:\n$1\n\nDieser Pfad sollte nicht zum \"levels\" Ordner gesetzt werden.",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Du hast keinen eigenen VVVVVV-Order gesetzt.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Dein VVVVVV-Order ist zu einem benutzerdefiniertem Pfad gesetzt:\n$1\n\n",
LANGUAGE = "Sprache",
DIALOGANIMATIONS = "Dialoganimationen",
FLIPSUBTOOLSCROLL = "Drehe Scrollrichtung des Werkzeugs",
ADJACENTROOMLINES = "Indikatoren für Tiles in angrenzenden Räumen",
NEVERASKBEFOREQUIT = "Frage niemals vor dem Beenden, auch wenn es ungespeicherte Änderungen gibt",
COORDS0 = "Zeige Koordinaten an, beginnend bei 0 (wie im internen Skripting)",
ALLOWDEBUG = "Aktiviere Debugmodus",
SHOWFPS = "Zeige FPS-Zähler",
CHECKFORUPDATES = "Nach Updates suchen",
PAUSEDRAWUNFOCUSED = "Nicht rendern wenn das Fenster unfokusiert ist",
ENABLEOVERWRITEBACKUPS = "Mache Backups von Level Dateien die überschrieben werden",
AMOUNTOVERWRITEBACKUPS = "Anzahl an Backups die gemacht werden sollen pro Level",
SCALE = "Größe",
LOADALLMETADATA = "Lade Metadaten (sowas wie Titel, Author und Beschreibung) für alle Dateien in der Levelliste",
COLORED_TEXTBOXES = "Benutze Echtfarben für Textbox",
MOUSESCROLLINGSPEED = "Geschwindigkeit des Mausbildlaufs",
BUMPSCRIPTSBYDEFAULT = "Skripte beim Bearbeiten standardmäßig an den Anfang der Liste verschieben",

SCRIPTSPLIT = "Trennen",
SPLITSCRIPT = "Skripts trennen",
COUNT = "Anzahl: ",
SMALLENTITYDATA = "Daten",

-- Stats screen
AMOUNTSCRIPTS = "Skripts:",
AMOUNTUSEDFLAGS = "Flags:",
AMOUNTENTITIES = "Objekte:",
AMOUNTTRINKETS = "Dingsdas:",
AMOUNTCREWMATES = "Crewmitglieder:",
AMOUNTINTERNALSCRIPTS = "Interne Skripts:",
TILESETUSSAGE = "Tileset Benutzung",
TILESETSONLYUSED = "(nur Räume die Tiles haben werden gezählt)",
AMOUNTROOMSWITHNAMES = "Räume die einen Namen haben:",
PLACINGMODEUSAGE = "Tileplatzierungsmoduse:",
AMOUNTLEVELNOTES = "Level-Notizen:",
AMOUNTFLAGNAMES = "Flagnamen:",
TILESUSAGE = "Tiles Verwendung",
AMOUNTTILES = "Tiles:",
AMOUNTSOLIDTILES = "Solide Tiles:",
AMOUNTSPIKES = "Spikes:",


UNEXPECTEDSCRIPTLINE = "Unerwartete Skriptzeile ohne Skript: $1",
DUPLICATESCRIPT = "Skript $1 ist ein Duplikat! Nur eins kann geladen werden.",
MAPWIDTHINVALID = "Kartenbreite ist ungültig: $1",
MAPHEIGHTINVALID = "Kartenhöhe ist ungültig: $1",
LEVMUSICEMPTY = "Levelmusik ist leer!",
NOT400ROOMS = "Die Anzahl an Metadaten in levelMetaData ist nicht 400!",
MOREERRORS = "$1 mehr",

DEBUGMODEON = "Debugmodus an",
FPS = "FPS",
STATE = "Status",
MOUSE = "Maus",

BLUE = "Blau",
RED = "Rot",
CYAN = "Cyan",
PURPLE = "Lila",
YELLOW = "Gelb",
GREEN = "Grün",
GRAY = "Grau",
PINK = "Pink",
BROWN = "Braun",
RAINBOWBG = "Regenbogen",

SYNTAXCOLORS = "Syntaxfarben",
SYNTAXCOLORSETTINGSTITLE = "Skriptingsyntaxhervorhebungsfarbeneinstellungen",
SYNTAXCOLOR_COMMAND = "Befehl",
SYNTAXCOLOR_GENERIC = "Generisch",
SYNTAXCOLOR_SEPARATOR = "Separator",
SYNTAXCOLOR_NUMBER = "Nummer",
SYNTAXCOLOR_TEXTBOX = "Textbox",
SYNTAXCOLOR_ERRORTEXT = "Unbekannter Befehl",
SYNTAXCOLOR_CURSOR = "Mauszeiger",
SYNTAXCOLOR_FLAGNAME = "Flagname",
SYNTAXCOLOR_NEWFLAGNAME = "Neuer Flagname",
SYNTAXCOLOR_COMMENT = "Kommentar",
SYNTAXCOLOR_WRONGLANG = "Vereinfachtes Kommando in Int.sc-Modus oder andersherum",
RESETCOLORS = "Farben zurücksetzen",
STRINGNOTFOUND = "\"$1\" wurde nicht gefunden",

-- L.MAL is concatenated with an error message
MAL = "Das Level ist beschädigt: ",

LOADSCRIPTMADE = "Ladeskript erstellt",
COPY = "Kopieren",
CUSTOMSIZE = "Eigene Pinselgröße: $1x$2",
SELECTINGA = "Auswählen - klicke oben links",
SELECTINGB = "Ausgewählt: $1x$2",
TILESETSRELOADED = "Tilesets und Sprites neugeladen",

BACKUPS = "Backups",
BACKUPSOFLEVEL = "Backups von Level $1",
LASTMODIFIEDTIME = "Ursprünglich zuletzt geändert", -- List header
OVERWRITTENTIME = "Überschrieben", -- List header
SAVEBACKUP = "Im VVVVVV-Ordner speichern",
DATEFORMAT = "Datumsformat",
TIMEFORMAT = "Zeitformat",
SAVEBACKUPNOBACKUP = "Achte darauf einen einzigartigen Namen zu nehmen wenn du nichts überschreiben willst, denn KEIN Backup wird in diesem Fall gemacht!",

AUTOSAVECRASHLOGS = "Absturzprotokolle automatisch speichern",
MOREINFO = "Neuste Infos",
COPYLINK = "Link kopieren",
SCRIPTDISPLAY = "Anzeigen",
SCRIPTDISPLAY_USED = "Benutzt",
SCRIPTDISPLAY_UNUSED = "Unbenutzt",

RECENTLYOPENED = "Zuletzt geöffnete Level",
REMOVERECENT = "Willst du es von der Liste der zuletzt geöffneten Level entfernen?",
RESETCUSTOMBRUSH = "(Rechtsklick um eine neue Größe einzustellen)",

DISPLAYSETTINGS = "Anzeige/\nSkalierung",
DISPLAYSETTINGSTITLE = "Anzeige/Skalierungseinstellungen",
SMALLERSCREEN = "Kleinere Fensterbreite (800px breit anstatt 896px)",
FORCESCALE = "Zwinge Skalierungseinstellungen",
SCALENOFIT = "Die aktuelle Größeneinstellung macht das Fenster zu groß um zu passen.",
SCALENONUM = "Die aktuellen Größeeinstellungen sind ungültig.",
MONITORSIZE = "$1x$2 Monitor",
VEDRES = "Ved Auflösung: $1x$2",
NONINTSCALE = "Nicht-ganzzahlige Skalierung",

USEFONTPNG = "Benutze font.png vom VVVVVV-Grafikordner als Schrift",
USELEVELFONTPNG = "Benutze pro Level benutzerdefinierte font.png als Schrift",
REQUIRESHIGHERLOVE = " (benötigt LÖVE $1 oder höher)",
FPSLIMIT = "FPS-Limit",

MAPRESOLUTION = "Auflösung", -- Map export size
MAPRES_ASSHOWN = "Wie gezeigt (max 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 pro Raum)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 pro Raum)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Oben links",
WIDTHHEIGHT = "Breite & Höhe",
BOTTOMRIGHT = "Unten rechts",
RENDERERINFO = "Rendererinformationen:",
MAPINCOMPLETE = "Die Karte ist noch nicht fertig (zu dem Zeitpunkt, als du Speichern gedrückt hast), bitte versuche es erneut wenn sie fertig ist.",
KEEPDIALOGOPEN = "Halte Dialog offen",
TRANSPARENTMAPBG = "Transparenter Hintergrund",
MAPEXPORTERROR = "Fehler beim erstellen der Karte.",
VIEWIMAGE = "Ansehen", -- Verb, view image
INVALIDLINENUMBER = "Bitte gib eine gültige Zeilennummer an.",
OPENLEVELSFOLDER = "Öffne Levelordner", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Bewegen",
GOTOROOM = "Gehe zu Raum",
ESCTOCANCEL = "[Drücke ESC zum abbrechen]",

INVALIDFILENAME_WIN = "Windows erlaubt keines der folgenden Zeichen in Dateinamen:\n\n: * ? \" < > |\n\n(| ist ein senkrechter Strich)",
INVALIDFILENAME_MAC = "macOS erlaubt kein : Zeichen in Dateinamen.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "STRG",
TINY_SHIFT = "SHIFT",
TINY_ALT = "ALT",
TINY_ESC = "ESC",
TINY_TAB = "TAB",
TINY_HOME = "HOME",
TINY_END = "END",
TINY_INSERT = "EINFG",
TINY_DEL = "ENTF",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Skripte [$1]",
SEARCHRESULTS_ROOMS = "Räume [$1]",
SEARCHRESULTS_NOTES = "Notizen [$1]",

ASSETS = "Assets", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Song kann nicht gespielt werden. Er existiert nicht oder der Typ wird nicht unterstützt.",
SOUNDPLAYERROR = "Geräusch kann nicht gespielt werden. Es existiert nicht oder der Typ wird nicht unterstützt.",
MUSICLOADERROR = "$1 kann nicht geladen werden: ",
MUSICLOADERROR_TOOSMALL = "Die Musikdatei ist zu klein um gültig zu sein.",
MUSICEXISTSYES = "Existiert",
MUSICEXISTSNO = "Existiert nicht",
ASSETS_FOLDER_EXISTS_NO = "Existiert nicht - klicken zum Erstellen",
ASSETS_FOLDER_EXISTS_YES = "Existiert - klicken zum Öffnen",
NO_ASSETS_SUBFOLDER = "Kein \"$1\"-Ordner",
LOAD = "Laden",
RELOAD = "Neu laden",
UNLOAD = "Entfernen",
MUSICEDITOR = "Musikeditor",
LOADMUSICNAME = "Lade .vvv",
SAVEMUSICNAME = "Speichere .vvv",
INSERTSONG = "Füge Song ein bei Spur $1",
SUREDELETESONG = "Bist du sicher, dass du Song $1 entfernen willst?",
SONGOPENFAIL = "$1 kann nicht geöffnet werden, Song wurde nicht ersetzt.",
SONGREPLACEFAIL = "Irgendwas ist schief gegangen während der Song ersetzt wurde.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "Du kannst das \"$1\" Zeichen nicht in Skriptnamen benutzen!",
MUSICTITLE = "Titel: ",
MUSICARTIST = "Künstler: ",
MUSICFILENAME = "Dateiname: ",
MUSICNOTES = "Notizen:",
SONGMETADATA = "Metadaten für Song $1",
MUSICFILEMETADATA = "Dateimetadaten",
MUSICEXPORTEDON = "Exportiert: ", -- Followed by date and time
SAVEMETADATA = "Metadaten speichern",
SOUNDS = "Geräusche",
GRAPHICS = "Grafiken",
FILEOPENERNAME = "Name: ",
PATHINVALID = "Der Pfad ist ungültig.",
DRIVES = "Laufwerke", -- like C: or F: on Windows
DOFILTER = "Nur *$1 zeigen", -- "*.txt" for example
DOFILTERDIR = "Nur Verzeichnisse zeigen",
FILEDIALOGLUV = "Entschuldigung, dein Betriebssystem wurde nicht erkannt, also funktioniert der Dateidialog nicht.",
RESET = "Zurücksetzen",
CHANGEVERB = "Ändern", -- verb
LOADIMAGE = "Lade Bild",
GRID = "Netz",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "Der Level muss gespeichert werden, bevor er benutzerdefinierte Assets verwenden kann.",
CREATE_ASSETS_FOLDER = "Möchtest du einen benutzerdefinierten Assets-Ordner für diesen Level erstellen?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "Es scheint, dass der Ordner VVVVVV nicht existiert. Möchtest du ihn erstellen?",
CREATE_LEVELS_FOLDER = "Es scheint, dass der Ordner \"levels\" nicht existiert. Möchtest du ihn erstellen?",
CREATE_FOLDER_FAIL = "Ordner kann nicht erstellt werden.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Assets-Ordner für $1",

OPAQUEROOMNAMEBACKGROUND = "Mache die schwarzen Raumnamenhintergründe undurchsichtig",
PLATVCHANGE_TITLE = "Plattformgeschwindigkeit ändern",
PLATVCHANGE_MSG = "Geschwindigkeit:",
PLATVCHANGE_INVALID = "Du musst eine Nummer eingeben.",
RENAMESCRIPTREFERENCES = "Hinweise umbenennen",
PLATFORMSPEEDSLIDER = "Tempo",

TRINKETS = "Dingsdas",
LISTALLTRINKETS = "Dingsdas auflisten", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Liste aller Dingsdas",
NOTRINKETSINLEVEL = "Es gibt keine Dingsdas in diesem Level.",
CREWMATES = "Crewmitglieder",
LISTALLCREWMATES = "Crewmitglieder auflisten", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Liste aller rettbaren Crewmitglieder",
NOCREWMATESINLEVEL = "Es gibt keine rettbaren Crewmitglieder in diesem Level.",
SHIFTROOMS = "Verschiebe Räume", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 Sek",
ROOMNUM = "Raum $1",
SOUNDNUM = "Geräusch $1",
TRACKNUM = "Track $1",
STOPSMUSIC = "Stoppt Musik",
PLAYSOUND = "Geräusch abspielen",
EDITSCRIPTWOBUMPING = "Bearbeite Skript ohne Stoß zum Anfang",
EDITSCRIPTWBUMPING = "Bearbeite Skript mit Stoß zum Anfang",
CLICKONTHING = "Klicke auf $1",
ORDRAGDROP = "oder ziehe und lege es hier ab", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Es gibt mehr als einen Startpunkt in diesem Level!",
STARTPOINTNOTFOUND = "Es gibt keinen Startpunkt!",

MAPBIGGERTHANSIZELIMIT = "Kartengröße $1 mal $2 ist größer als $3 mal $4!",
BTNOVERRIDE = "Überschreiben",
TARGETPLATFORM = "Zielplattform", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Zeitprüfung",
TIMETRIALTRINKETS = "Dingsda-anzahl",
TIMETRIALTIME = "Zeitprüfungszeit",
SUREDELETETRIAL = "Bist du sicher du willst die Zeitprüfung \"$1\" löschen?",

CUT = "Schneiden",
PASTE = "Einfügen",
SELECTWORD = "Wort auswählen",
SELECTLINE = "Linie auswählen",
SELECTALL = "Alles auswählen",
INSERTRAWHEX = "Unicodezeichen einfügen",
MOVELINEUP = "Linie nach oben bewegen",
MOVELINEDOWN = "Linie nach unten bewegen",
DUPLICATELINE = "Linie duplizieren",

WHEREPLACEPLAYER = "Wo willst du starten?",
YOUAREPLAYTESTING = "Du Spieltestest momentan",
LOCATEVVVVVV = "Wähle dein $1 Program aus", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Du Spieltestest schon!",
PLAYTESTINGFAILED = "Etwas ist schief gelaufen beim Öffnen von VVVVVV:\n$1\n\nWenn du die ausführbare Datei die zum Spieltest für VVVVVV genutzt wird ändern musst, halte Shift während du den Spieltest-Knopf drückst.",
VVVVVV_EXITCODE_FAILURE = "VVVVVVV hat sich mit Code $1 beendet", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "Es sieht so aus, als ob du VVVVVV 2.2 oder älter verwendest. Bitte aktualisiert auf VVVVVV 2.3 oder höher.",
VVVVVV_SOMETHING_HAPPENED = "Bei VVVVVVV scheint etwas schief gelaufen zu sein.",
PLAYTESTUNAVAILABLE = "Tut mir leid, du kannst nicht Spieltesten auf $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Bitte wähle die Datei namens '$1' aus.",

PLAYTESTINGOPTIONS = "Spieltest",
PLAYTESTING_EXECUTABLE_NOTSET = "Sie haben noch keine ausführbare Datei für $1 zum Spieltesten festgelegt.\nVed wird danach fragen, wenn du zum ersten Mal ein $2-Level testest.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "Die ausführbare Datei $1, die für den Spieltest verwendet werden soll, ist:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Leider ist bei der Suche nach VVVVVV etwas schief gegangen. Versuche, den Pfad zur ausführbaren Datei manuell einzugeben.",
FIND_V_EXE_FOUNDERROR = "Etwas gefunden, das wie VVVVVV aussieht, aber es konnte keinen brauchbaren Pfad zu seiner ausführbaren Datei gefunden werden. Stelle sicher, dass du keine alte Version des Spiels verwendest (2.3 oder neuer ist erforderlich) oder versuche, den Pfad zur ausführbaren Datei manuell festzulegen.",
FIND_V_EXE_NOTFOUND = "Es sieht so aus, als ob VVVVVV nicht läuft. Stell sicher, dass VVVVVV läuft und versuche es erneut.",
FIND_V_EXE_MULTI = "Mehrere verschiedene Exemplare von VVVVVV laufen. Stelle sicher, dass du nur eine Version des Spiels geöffnet hast und versuche es erneut.",

FIND_V_EXE_EXPLANATION = "Ved benötigt VVVVVVV zum Spieltesten, und der Pfad zu VVVVVV muss zuerst festgelegt werden.\n\n\nUm VVVVVV automatisch zu erkennen, starte einfach das Spiel, wenn es noch nicht läuft, und drücke \"Erkennen\".",

VCE_REMOVED = "VVVVVV: Community Edition wird nicht mehr gewartet und VVVVVV-CE-Level werden nicht mehr von Ved unterstützt. Dieses Level wird wie ein normales VVVVVV-Level behandelt. Für mehr Informationen, siehe https://vsix.dev/vce/status/",

VVVVVV_VERSION = "VVVVVV-Version", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Automatisch",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Alle Plugins",
ALL_PLUGINS_MOREINFO = "Bitte besuche ¤https://tolp.nl/ved/plugins.php¤diese Seite¤ für mehr Informationen bezüglich Plugins.\\nLCl",
ALL_PLUGINS_FOLDER = "Dein Plugins-Ordner ist:",
ALL_PLUGINS_NOPLUGINS = "Du hast noch keine Plugins.",

PLUGIN_NOT_SUPPORTED = "[Dieses Plugin ist nicht unterstützt, da Ved $1 oder höher benötigt wird!]\\r",
PLUGIN_AUTHOR_VERSION = "von $1, Version $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Neues Ladeskript",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Nein",
CREATE_LOAD_SCRIPT_RUNONCE = "Einmal",
CREATE_LOAD_SCRIPT_REPEATING = "Wiederholend",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Kein neues Ladeskript",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Dieses Terminal wird direkt zum Skript zeigen.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Diese Skriptbox wird direkt zum Skript zeigen.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Neues Einmal-Ladeskript",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Dieses Terminal wird zu einem neuen Ladeskript zeigen welches das echte Skript nur einmal lädt in einem Spieldurchlauf. Ved wird eine unbenutzte Flag wählen.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Diese Skriptbox wird zu einem neuen Ladeskript zeigen welches das echte Skript nur einmal lädt in einem Spieldurchlauf. Ved wird eine unbenutzte Flag wählen.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Neues wiederholende Ladeskript",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Dieses Terminal wird zu einem neuen Ladeskript zeigen, welches wiederholend das echte Skript lädt.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Diese Skriptbox wird zu einem neuen Ladeskript zeigen, welches wiederholend das echte Skript lädt.",

CUSTOM_SIZED_BRUSH = "Eigene Pinsel",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Pinsel",
CUSTOM_SIZED_BRUSH_STAMP = "Stempel",
CUSTOM_SIZED_BRUSH_TILESET = "Tileset",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Eigene Pinselgröße",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Wähle die Größe der Pinsel, die du brauchst.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stempel vom Zimmer",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Wähle Tiles aus dem Raum aus, um einen Stempel zu erstellen.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stempel aus Tileset",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Wählen Sie Tiles aus dem Tileset aus, um einen Stempel zu erstellen. Funktioniert nur im manuellen Modus.",

ADVANCED_LEVEL_OPTIONS = "Erweiterte Leveloptionen",
ONEWAYCOL_OVERRIDE = "Einwegblöcke auch in benutzerdefinierten Assets umfärben (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Erstelle ein ZIP von dieser Version zur Verteilung", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "ZIP speichern",
ZIP_BUSY_TITLE = "ZIP erstellen...",
ZIP_LOVE11_ONLY = "LÖVE 11 oder höher ist erforderlich, um eine ZIP-Datei zu erstellen", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP gespeichert!",
ZIP_SAVING_FAIL = "ZIP-Datei konnte nicht gespeichert werden!",

OPENFOLDER = "Ordner öffnen", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Level-Schriftart",

TEXTBOXCOLORS_BUTTON = "Textfarben",
TEXTBOXCOLORS_TITLE = "Textbox-farben",
TEXTBOXCOLORS_RENAME = "Farbe \"$1\" umbennen",
TEXTBOXCOLORS_DUPLICATE = "Farbe \"$1\" duplizieren",
TEXTBOXCOLORS_CREATE = "Neue Farbe hinzufügen",

LIB_LOAD_ERRMSG_BIDI = "Die Bibliothek, die Rechts-nach-Links-Text unterstützt, kann nicht geladen werden.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nEs könnte sein, dass dein Antivirus diese Funktion stört.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Du hast $1 Plugin das nicht unterstützt ist in dieser Version.",
		[1] = "Du hast $1 Plugins die nicht untersützt sind in dieser Version.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Dieses Level schlug fehl bei $1 Überprüfung. Das Problem wurde vielleicht automatisch gelöst, aber es ist immer noch möglich dass Abstürze und Inkonsistenzen auftreten.",
		[1] = "Dieses Level schlug fehl bei $1 Überprüfungen. Das Problem wurde vielleicht automatisch gelöst, aber es ist immer noch möglich dass Abstürze und Inkonsistenzen auftreten.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 Benutzung in Räume: $2",
		[1] = "$1 Benutzungen in Räume: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 Benutzung in Skripts: $2",
		[1] = "$1 Benutzungen in Skripts: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Objekt bei [$1 $2] hat $3 ungültige Eigenschaft!",
		[1] = "Objekt bei [$1 $2] hat $3 ungültige Eigenschaften!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata für Raum $1,$2 hat $3 ungültige Eigenschaft!",
		[1] = "LevelMetadata für Raum $1,$2 hat $3 ungültige Eigenschaften!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "$1 wird gezeigt",
		[1] = "$1 werden gezeigt",
	},
	FLAGUSAGES = {
		[0] = "Wurde $1 mal in diesen Skripts benutzt: $2",
		[1] = "Wurde $1 male in diesen Skripts benutzt: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 Tile ist keine gültige Ganzzahl größer oder gleich 0",
		[1] = "$1 Tiles sind keine gültige Ganzzahl größer oder gleich 0",
	},
	BYTES = {
		[0] = "$1 byte",
		[1] = "$1 bytes",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 Abbildung angepasst",
		[1] = "$1 Abbildungen angepasst",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 Soundeffekt angepasst",
		[1] = "$1 Soundeffekte angepasst",
	},
}

toolnames = {

"Mauer",
"Hintergrund",
"Spike",
"Dingsda",
"Checkpoint",
"Verschwindende Plattform",
"Conveyor",
"Bewegliche Plattform",
"Gegner",
"Schwerkraftlinie",
"Raumtext",
"Konsole",
"Skriptbox",
"Teleporter",
"Teleportationslinie",
"Crewmitglied",
"Startpunkt",

}

subtoolnames = {

[1] = {"1x1 Pinsel", "3x3 Pinsel", "5x5 Pinsel", "7x7 Pinsel", "9x9 Pinsel", "Horizontal füllen", "Vertikal füllen", "Eigene Pinselgröße", "Farbeimer", "Kartoffel für das Machen von Dingen die magisch sind"},
[2] = {},
[3] = {"Automatisch 1", "Automatisch erweitern L+R", "Automatisch erweitern L", "Automatisch erweitern R"},
[4] = {},
[5] = {"Aufrecht", "Umgedreht"},
[6] = {},
[7] = {"Kleines R", "Kleines L", "Großes R", "Großes L"},
[8] = {"Runter", "Hoch", "Links", "Rechts"},
[9] = {},
[10] = {"Horizontal", "Vertikal"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Eingang", "Ausgang"},
[15] = {},
[16] = {"Pink", "Gelb", "Rot", "Grün", "Blau", "Cyan", "Zufällig"},
[17] = {"Gucke nach rechts", "Gucke nach links"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "A",

}

warpdirchangedtext = {

[0] = "Raumteleportation ist deaktiviert",
[1] = "Teleportationsrichtung horizontal gesetzt",
[2] = "Teleportationsrichtung vertikal gesetzt",
[3] = "Teleportationsrichtung zu allen Richtungen gesetzt",

}

langtilesetnames = {

short0 = "Raumstn.",
long0 = "Raumstation",
short1 = "Draußen",
long1 = "Draußen",
short2 = "Lab.",
long2 = "Labor",
short3 = "Teleprtzone.",
long3 = "Teleportationszone",
short4 = "Schf.",
long4 = "Schiff",
short5 = "Turm",
long5 = "Turm",

}

ERR_VEDHASCRASHED = "Ved ist abgestürzt!"
ERR_VEDVERSION = "Ved-Version:"
ERR_LOVEVERSION = "LÖVE-Version:"
ERR_STATE = "Status:"
ERR_OS = "Betriebssystem:"
ERR_TIMESINCESTART = "Zeit seit dem Start:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(nicht geladen)"
ERR_PLUGINSNONE = "(keine)"
ERR_PLEASETELLDAV = "Bitte erzähl Dav999 über dieses Problem.\n\n\nDetails: (drücke Strg/Cmd+C um es zur Zwischenablage zu kopieren)\n\n"
ERR_INTERMEDIATE = " (Zwischenversion)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (zu neu)"

ERR_PLUGINERROR = "Plugin Fehler!"
ERR_FILE = "Datei die bearbeitet wird:"
ERR_FILEEDITORS = "Plugins die diese Datei bearbeiten:"
ERR_CURRENTPLUGIN = "Plugin das diesen Fehler verursacht hat:"
ERR_PLEASETELLAUTHOR = "Ein Plugin sollte eine Bearbeitung an Code in Ved machen, aber der Code der ersetzt werden soll wurde nicht gefunden.\nEs ist möglich dass das verursacht wurde durch einen Konflikt zwischen Zwei Plugins, oder ein Ved-Update hat das Plugin kaputt gemacht.\n\nDetails: (Drücke Strg/Cmd+C um es zur Zwischenable zu kopieren)\n\n"
ERR_CONTINUE = "Du kannst fortfahren indem du ESC oder Enter drückst, aber beachte dass diese gescheiterte Bearbeitung vielleicht Probleme verursacht."
ERR_OPENPLUGINSFOLDER = "Du kannst deinen Pluginordner öffnen indem du F drückst, damit du das störende Plugin beheben oder entfernen kannst. Starte Ved danach neu."
ERR_REPLACECODE = "Konnte dies nicht finden in %s.lua:"
ERR_REPLACECODEPATTERN = "Konnte dies nicht finden in %s.lua (als Muster):"
ERR_LINESTOTAL = "%i Zeilen insgesamt"

ERR_SAVELEVEL = "Um eine Kopie deines Levels zu speichern, drücke S"
ERR_SAVESUCC = "Level erfolgreich gespeichert als %s!"
ERR_SAVEERROR = "Speicherfehler! %s"
ERR_LOGSAVED = "Mehr informationen kann in diesem Absturzprotokoll gefunden werden:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Leveleigenschaften",
		changedrooms = "Räume geändert",
		changedroommetadata = "Raummetadaten geändert",
		entities = "Objekte",
		scripts = "Skripte",
		flagnames = "Flagnamen",
		levelnotes = "Levelnotizen",
	},
	levelpropertiesdiff = {
		Title = "Name wurde geändert von \"$1\" zu \"$2\"",
		Creator = "Author wurde geändert von \"$1\" zu \"$2\"",
		website = "Webseite wurde gändert von \"$1\" zu \"$2\"",
		Desc1 = "Beschreibung1 wurde geändert von \"$1\" zu \"$2\"",
		Desc2 = "Beschreibung2 wurde geändert von \"$1\" zu \"$2\"",
		Desc3 = "Beschreibung3 wurde geändert von \"$1\" zu \"$2\"",
		mapsize = "Kartengröße wurde gändert von $1x$2 zu $3x$4",
		mapsizenote = "BEACHTE: Kartengröße wurde von $1x$2 zu $3x$4 geändert.\\o\nRäume außerhalb von $5x$6 sind nicht gelistet.\\o",
		levmusic = "Levelmusik wurde gändert von $1 zu $2",
	},
	rooms = {
		added1 = "($1,$2) ($3) hinzugefügt\\G",
		added2 = "($1,$2) ($3 -> $4) hinzugefügt\\G",
		changed1 = "($1,$2) ($3) geändert\\Y",
		changed2 = "($1,$2) ($3 -> $4) geändert\\Y",
		cleared1 = "Alle Tiles in ($1,$2) ($3) wurden gelöscht\\R",
		cleared2 = "Alle Tiles in ($1,$2) ($3 -> $4) wurden gelöscht\\R",
	},
	roommetadata = {
		changed0 = "Raum $1,$2:",
		changed1 = "Raum $1,$2 ($3):",
		roomname = "Raumname wurde geändert von \"$1\" zu \"$2\"\\Y",
		roomnameremoved = "Raumname \"$1\" entfernt\\R",
		roomnameadded = "Raum \"$1\" benannt\\G",
		tileset = "Tileset $1 Tilesetfarbe $2 geändert zu Tileset $3 Tilesetfarbe $4\\Y",
		platv = "Plattformgeschwindigkeit geändert von $1 zu $2\\Y",
		enemytype = "Gegnertyp geändert von $1 zu $2\\Y",
		platbounds = "Plattformgrenzen geändert von $1,$2,$3,$4 zu $5,$6,$7,$8\\Y",
		enemybounds = "Gegnergrenzen geändert von $1,$2,$3,$4 zu $5,$6,$7,$8\\Y",
		directmode01 = "Direkter-Modus aktiviert\\G",
		directmode10 = "Direkter-Modus deaktiviert\\R",
		warpdir = "Teleportationsrichtung geändert von $1 zu $2\\Y",
	},
	entities = {
		added = "Objekttyp $1 hinzugefügt auf Position $2,$3 in Raum ($4,$5)\\G",
		removed = "Objekttyp $1 entfernt von Position $2,$3 in Raum ($4,$5)\\R",
		changed = "Objekttyp $1 geändert auf Position $2,$3 in Raum ($4,$5)\\Y",
		changedtype = "Objekttyp $1 geändert zu Typ $2 auf Position $3,$4 in Raum ($5,$6)\\Y",
		multiple1 = "Objekte geändert auf Position $1,$2 in Raum ($3,$4):\\Y",
		multiple2 = "zu:",
		addedmultiple = "Objekte hinzugefügt auf Position $1,$2 in Raum ($3,$4):\\G",
		removedmultiple = "Objekte entfernet auf Position $1,$2 in Raum ($3,$4):\\R",
		entity = "Typ $1",
		incomplete = "Nicht alle Objekte wurden behandelt! Bitte melde das Dav.\\r",
	},
	scripts = {
		added = "Skript \"$1\" hinzugefügt\\G",
		removed = "Skript \"$1\" entfernt\\R",
		edited = "Skript \"$1\" bearbeitet\\Y",
	},
	flagnames = {
		added = "Setze Name für Flag $1 zu \"$2\"\\G",
		removed = "Entferne Name \"$1\" für Flag $2\\R",
		edited = "Name für Flag $1 geändert von \"$2\" zu \"$3\"\\Y",
	},
	levelnotes = {
		added = "Levelnotiz \"$1\" hinzugefügt\\G",
		removed = "Levelnotiz \"$1\" entfernt\\R",
		edited = "Levelnotiz \"$1\" bearbeitet\\Y",
	},
	mde = {
		added = "Metadatenobjekt wurde hinzugefügt.\\G",
		removed = "Metadatenobjekt wurde entfernt.\\R",
	},
}

