-- Language file for Ved
--- Language: Français (fr)
--- Last converted: 2019-11-01 01:16:29 (CET)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n > 1) end

function fontpng_ascii(c)
	if c == "à" then
		return "a"
	elseif c == "é" or c == "è" or c == "ê" then
		return "e"
	elseif c == "É" or c == "Ê" then
		return "E"
	elseif c == "ç" then
		return "c"
	elseif c == "ô" then
		return "o"
	elseif c == "î" then
		return "i"
	elseif c == "ù" or c == "û" then
		return "u"
	end
end

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Votre version de L{ve est obsolète. Veuillez utiliser la version 0.9.1 ou ultérieure.\nVous pouvez télécharger la dernière version de L{ve sur le site https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ne supporte plus L{ve 0.9.0. Cependant, L{ve 0.9.1 et toute version ultérieure seront supportées.\nVous pouvez télécharger la dernière version de L{ve sur https://love2d.org/.",
UNKNOWNSTATE = "État inconnu ($1), entré depuis l'état $2",
FATALERROR = "ERREUR FATALE : ",
FATALEND = "Veuillez fermer le jeu et réessayer. Et si vous êtes Dav, veuillez le réparer.",

OSNOTRECOGNIZED = "Votre système d'exploitation ($1) n'est pas reconnu! Utilisation des valeurs par défaut des fonctions du système de fichiers; les niveaux sont stockés dans:\n\n$2",
MAXTRINKETS = "Le nombre maximum de médailles (20) a été atteint dans ce niveau.",
MAXCREWMATES = "Le nombre maximum d'équipiers (20) a été atteint dans ce niveau.",
EDITINGROOMTEXTNIL = "Le texte de la salle existante que vous éditiez est nil !",
STARTPOINTNOLONGERFOUND = "L'ancien point de départ ne peut plus être trouvé !",
UNSUPPORTEDTOOL = "Outil non supporté! Outil : ",
SURENEWLEVEL = "Êtes-vous sûr de vouloir créer un nouveau niveau? Vous perdrez tout contenu non sauvegardé.",
SURELOADLEVEL = "Êtes-vous sûr de vouloir charger un niveau? Vous perdrez tout contenu non sauvegardé.",
COULDNOTGETCONTENTSLEVELFOLDER = "Le contenu du dossier de niveaux n'a pas pu être récupéré. Veuillez vérifier si $1 existe et réessayez.",
MAPSAVEDAS = "L'image de la carte a été sauvegardée en tant que $1 !",
RAWENTITYPROPERTIES = "Vous pouvez changer les valeurs brutes des propriétés de cette entité ici.",
UNKNOWNENTITYTYPE = "Type d'entité $1 inconnu",
METADATAENTITYCREATENOW = "L'entité de métadonnées n'existe pas. Voulez vous la créer maintenant?\n\nL'entité de métadonnées est une entité cachée qui peut être ajoutée à des niveaux de VVVVVV pour stocker des données supplémentaires utilisées par Ved, comme par exemple des notes sur le niveau, des noms de drapeaux et bien d'autres choses.",
WARPTOKENENT404 = "Le jeton de téléportation n'existe plus !",
SPLITFAILED = "La séparation a misérablement échoué ! Avez-vous trop de lignes entre une commande texte et une commande speak ou speak_active ?", -- Command names are best left untranslated
NOFLAGSLEFT = "Il n'y a plus de drapeaux disponibles, donc au moins un nouveau nom de drapeau ne peut pas être associé à un numéro de drapeau. L'utilisation de ce script dans VVVVVV a des chances de le casser. Veuillez enlever toutes les références vers des drapeaux que vous n'utilisez plus et réessayez.\n\nQuitter l'éditeur ?",
NOFLAGSLEFT_LOADSCRIPT = "Il n'y a plus de drapeaux disponibles, donc un script de chargement utilisant un nouveau drapeau n'a pas pu être créé. A la place, un script de chargement qui charge le script cible avec iftrinkets(0,$1) a été créé. Veuillez enlever toutes les références vers des drapeaux que vous n'utilisez plus et réessayez.",
LEVELOPENFAIL = "Impossible d'ouvrir le fichier $1.vvvvvv.",
SIZELIMIT = "La taille maximum d'un niveau est de 20 par 20.\n\nA la place, la taille du niveau va être changée en $1 par $2.",
SCRIPTALREADYEXISTS = "Le script \"$1\" existe déjà !",
FLAGNAMENUMBERS = "Les noms de drapeaux ne peuvent pas être composés que de nombres.",
FLAGNAMECHARS = "Les noms de drapeaux ne peuvent pas contenir de virgules, de parenthèses ou d'espaces.",
FLAGNAMEINUSE = "Le nom de drapeau $1 est déjà utilisé par le drapeau $2",
DIFFSELECT = "Choisissez le niveau à comparer. Le niveau que vous sélectionnez sera considéré comme l'ancienne version.",
SUREQUIT = "Êtes-vous sûr de vouloir quitter? Vous allez perdre tout contenu non sauvegardé.",
SUREQUITNEW = "Vous avez des changements non sauvegardés. Voulez-vous sauver ces changements avant de quitter ?",
SURENEWLEVELNEW = "Vous avez des changements non sauvegardés. Voulez-vous sauver ces changements avant de créer un nouveau niveau ?",
SCALEREBOOT = "La nouvelle configuration d'échelle seront prises en compte après avoir redémarré Ved.",
NAMEFORFLAG = "Nom pour le drapeau $1 :",
SCRIPT404 = "Le script \"$1\" n'existe pas !",
ENTITY404 = "L'entité #$1 n'existe plus !",
GRAPHICSCARDCANVAS = "Nous sommes désolés, mais il semble que votre carte graphique ou son pilote ne supporte pas cette fonctionnalité !",
MAXTEXTURESIZE = "Nous sommes désolés, créer une image de dimensions $1x$2 ne semble pas être supporté par votre carte graphique ou son pilote..\n\nLa taille limite sur ce système est $3x$3.",
SUREDELETESCRIPT = "Êtes-vous sûr de vouloir supprimer le script \"$1\" ?",
SUREDELETENOTE = "Êtes-vous sûr de vouloir supprimer cette note ?",
THREADERROR = "Erreur de processus !",
WHATDIDYOUDO = "Qu'avez-vous fait ?!",
UNDOFAULTY = "Qu'est-ce que vous faites ?",
SOURCEDESTROOMSSAME = "La salle de départ et de destination sont les mêmes !",
UNKNOWNUNDOTYPE = "Type de retour en arrière \"$1\" inconnu !",
MDEVERSIONWARNING = "Ce niveau semble avoir été créé dans une version ultérieure de Ved, et peut contenir des données pouvant être perdues lorsque vous sauverez ce niveau.",
FORGOTPATH = "Vous avez oublié de spécifier un chemin !",
MDENOTPASSED = "Attention: aucune entité de métadonnées n'a été passée à savelevel() !",
RESTARTVEDLANG = "Après avoir changé la langue, vous devez relancer Ved pour que les changements prennent effet.",

SELECTCOPY1 = "Sélectionnez la salle à copier",
SELECTCOPY2 = "Sélectionnez l'emplacement où copier cette salle",
SELECTSWAP1 = "Sélectionnez la première salle à échanger",
SELECTSWAP2 = "Sélectionnez la seconde salle à échanger",

TILESETCHANGEDTO = "Jeu de tuiles changé à $1",
TILESETCOLORCHANGEDTO = "La couleur du jeu de tuiles à été changé à $1",
ENEMYTYPECHANGED = "Type d'ennemi changé",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Type de placement de tuiles changé à $1",
CHANGEDTOMODEAUTO = "automatique",
CHANGEDTOMODEMANUAL = "manuel",
CHANGEDTOMODEMULTI = "multi jeux de tuiles",

BUSYSAVING = "Sauvegarde en cours...",
SAVEDLEVELAS = "Niveau sauvegardé en tant que $1.vvvvvv",

ROOMCUT = "Salle coupée et sauvegardée dans le presse papiers",
ROOMCOPIED = "Salle copiée dans le presse papiers",
ROOMPASTED = "Salle collée",

METADATAUNDONE = "Options de niveaux remises en arrière",
METADATAREDONE = "Options de niveaux rétablies",

BOUNDSTOPLEFT = "Sélectionnez le coin en haut à gauche de la zone de sélection",
BOUNDSBOTTOMRIGHT = "Sélectionnez le coin en bas à droite",

TILE = "Tuile $1",
HIDEALL = "Tout cacher",
SHOWALL = "Tout montrer",
SCRIPTEDITOR = "Éditeur de script",
FILE = "Fichier",
NEW = "Nouveau",
OPEN = "Ouvrir",
SAVE = "Sauver",
UNDO = "Revenir en arrière",
REDO = "Revenir en avant",
COMPARE = "Comparer",
STATS = "Statistiques",
SCRIPTUSAGES = "Utilisations",
EDITTAB = "Modifier",
COPYSCRIPT = "Copier le script",
SEARCHSCRIPT = "Chercher",
GOTOLINE = "Aller à la ligne",
GOTOLINE2 = "Aller à la ligne :",
INTERNALON = "Sc.int est activé",
INTERNALOFF = "Sc.int est désactivé",
INTERNALYESBARS = "say(-1) sc.int",
INTERNALNOBARS = "Chgt script sc.int",
VIEW = "Vue",
SYNTAXHLOFF = "Color. syn. : oui",
SYNTAXHLON = "Color. syn. : non",
TEXTSIZEN = "Taille du texte: Normal",
TEXTSIZEL = "Taille du texte: Grand",
INSERT = "Insérer",
HELP = "Aide",
INTSCRWARNING_NOLOADSCRIPT = "Script de chargement requis !",
INTSCRWARNING_BOXED = "Réf. directe à l'invite de commande du script !\n\n",
COLUMN = "Colonne : ",

BTN_OK = "OK",
BTN_CANCEL = "Annuler",
BTN_YES = "Oui",
BTN_NO = "Non",
BTN_APPLY = "Appliquer",
BTN_QUIT = "Quitter",
BTN_DISCARD = "Jeter",
BTN_SAVE = "Sauver",
BTN_CLOSE = "Fermer",
BTN_LOAD = "Charger",

COMPARINGTHESE = "Comparaison entre $1.vvvvvv et $2.vvvvvv en cours",
COMPARINGTHESENEW = "Comparaison entre (niveau non sauvegardé) et $1.vvvvvv en cours",

RETURN = "Retour",
CREATE = "Créer",
GOTO = "Aller à",
DELETE = "Supprimer",
RENAME = "Renommer",
CHANGEDIRECTION = "Changer la direction",
DIRECTION = "Direction->",
UP = "haut",
DOWN = "bas",
LEFT = "gauche",
RIGHT = "droit",
TESTFROMHERE = "Tester depuis ici",
FLIP = "Renverser",
CYCLETYPE = "Changer le type",
GOTODESTINATION = "Aller à la destination",
GOTOENTRANCE = "Aller à l'entrée",
CHANGECOLOR = "Changer la couleur",
EDITTEXT = "Éditer le texte",
COPYTEXT = "Copier le texte",
EDITSCRIPT = "Éditer le script",
OTHERSCRIPT = "Changer le nom du script",
PROPERTIES = "Propriétés",
CHANGETOHOR = "Modifié à horizontal",
CHANGETOVER = "Modifié à vertical",
RESIZE = "Déplacer/Redimensionner",
CHANGEENTRANCE = "Déplacer l'entrée",
CHANGEEXIT = "Déplacer la sortie",
COPYENTRANCE = "Copier l'entrée",
LOCK = "Vérouiller",
UNLOCK = "Dévérouiller",
BUG = "[Bogue!]",

VEDOPTIONS = "Options de Ved",
LEVELOPTIONS = "Options de niveau",
MAP = "Carte",
SCRIPTS = "Scripts",
SEARCH = "Chercher",
SENDFEEDBACK = "Envoyer un avis",
LEVELNOTEPAD = "Commentaires de niveau",
PLUGINS = "Modules",

BACKB = "Retour <<",
MOREB = "Plus >>",
AUTOMODE = "Mode : auto",
AUTO2MODE = "Mode : multi",
MANUALMODE = "Mode : manuel",
PLATFORMSPEED = "Vit. de plateforme : $1",
ENEMYTYPE = "Type d'ennemi: $1",
PLATFORMBOUNDS = "Limites de plateforme",
WARPDIR = "Dir de TP: $1",
ENEMYBOUNDS = "Zone des ennemis",
ROOMNAME = "Nom de la salle",
ROOMOPTIONS = "Options de la salle",
ROTATE180 = "Tourner à 180 degrés",
ROTATE180UNI = "Tourner à 180°",
HIDEBOUNDS = "Cacher les limites",
SHOWBOUNDS = "Afficher les limites",

ROOMPLATFORMS = "Plateformes de la salle", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Ennemis de la salle",

OPTNAME = "Nom",
OPTBY = "Par",
OPTWEBSITE = "SiteWeb",
OPTDESC = "Desc", -- If necessary, you can span multiple lines
OPTSIZE = "Taille",
OPTMUSIC = "Musique",
CAPNONE = "AUCUN",
ENTERLONGOPTNAME = "Nom du niveau :",

X = "x", -- Used for level size: 20x20

SOLID = "Solide",
NOTSOLID = "Non solide",

TSCOLOR = "Couleur : $1",

ONETRINKETS = "M :",
ONECREWMATES = "Eq :",
ONEENTITIES = "En :",

LEVELSLIST = "Niveaux",
LOADTHISLEVEL = "Charger ce niveau : ",
ENTERNAMESAVE = "Entrer le nom utilisé pour la sauvegarde : ",
SEARCHFOR = "Chercher pour : ",

VERSIONERROR = "Impossible de vérifier la version.",
VERSIONUPTODATE = "Votre version de Ved est à jour.",
VERSIONOLD = "Mise à jour disponible! Dernière version : $1",
VERSIONCHECKING = "Recherche de mise à jour...",
VERSIONDISABLED = "Recherche de mise à jour désactivée",

SAVESUCCESS = "Sauvegarde effectuée !",
SAVENOSUCCESS = "La sauvegarde a échouée! Erreur : ",
INVALIDFILESIZE = "Taille de fichier invalide.",

EDIT = "Modifier",
EDITWOBUMPING = "Modifier sans réordonner la liste",
COPYNAME = "Copier le nom",
COPYCONTENTS = "Copier le contenu",
DUPLICATE = "Dupliquer",

NEWSCRIPTNAME = "Nom :",
CREATENEWSCRIPT = "Créer un nouveau script",

NEWNOTENAME = "Nom :",
CREATENEWNOTE = "Créer une nouvelle note",

ADDNEWBTN = "[Ajouter nouveau]",
IMAGEERROR = "[ERREUR D'IMAGE]",

NEWNAME = "Nouveau nom :",
RENAMENOTE = "Renommer la note",
RENAMESCRIPT = "Renommer le script",

LINE = "ligne ",

SAVEMAP = "Sauver la carte",
SAVEFULLSIZEMAP = "Sauver la carte globale",
COPYROOMS = "Copier la salle",
SWAPROOMS = "Échanger les salles",

FLAGS = "Drapeaux",
ROOM = "salle",
CONTENTFILLER = "Contenu",

FLAGUSED = "Utilisé    ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Non utilisé",
FLAGNONAME = "Aucun nom",
USEDOUTOFRANGEFLAGS = "Drapeaux hors limites utilisés :",

CUSTOMVVVVVVDIRECTORY = "Dossier de VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Le répertoire par défaut de VVVVVV que Ved attend est:\n$1\n\nCe chemin ne doit pas mener au dossier \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Vous n'avez pas donné de dossier VVVVVV personnalisé.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Votre dossier de VVVVVV est situé dans un chemin personnalisé:\n$1\n\n",
LANGUAGE = "Langue",
DIALOGANIMATIONS = "Animations de dialogue",
FLIPSUBTOOLSCROLL = "Inverser la direction de défilage des sous-outils",
ADJACENTROOMLINES = "Indicateurs de tuiles dans les salles adjacentes",
ASKBEFOREQUIT = "Demander avant de quitter",
NEVERASKBEFOREQUIT = "Ne jamais demander avant de quitter, même s'il y a des modifications non sauvegardées",
COORDS0 = "Afficher les coordonnées en commençant à 0 (comme dans les scripts internes)",
ALLOWDEBUG = "Activer le mode de débogage",
SHOWFPS = "Afficher le compteur de FPS",
IIXSCALE = "Échelle 2x",
CHECKFORUPDATES = "Chercher une mise à jour",
PAUSEDRAWUNFOCUSED = "Ne pas effectuer de rendu lorsque la fenêtre n'est pas en premier plan",
ENABLEOVERWRITEBACKUPS = "Faire des sauvegardes des fichiers de niveaux qui sont remplacés",
AMOUNTOVERWRITEBACKUPS = "Nombre de sauvegardes à garder par niveau",
SCALE = "Échelle",
LOADALLMETADATA = "Charger des métadonnées (ex : titre, auteur, description) pour tous les fichiers dans la liste de niveaux",
COLORED_TEXTBOXES = "Utiliser des couleurs pour l'éditeur de script",

SCRIPTSPLIT = "Séparer",
SPLITSCRIPT = "Scripts de séparation",
COUNT = "Compte : ",
SMALLENTITYDATA = "texte",

-- Stats screen
AMOUNTSCRIPTS = "Scripts :",
AMOUNTUSEDFLAGS = "Drapeaux :",
AMOUNTENTITIES = "Entités :",
AMOUNTTRINKETS = "Médailles :",
AMOUNTCREWMATES = "Équipiers :",
AMOUNTINTERNALSCRIPTS = "Scripts internes :",
TILESETUSSAGE = "Utilisation du jeu de tuiles",
TILESETSONLYUSED = "(seules les salles ayant des tuiles sont comptées)",
AMOUNTROOMSWITHNAMES = "Salles ayant un nom :",
PLACINGMODEUSAGE = "Modes de placement de tuiles :",
AMOUNTLEVELNOTES = "Notes de niveau :",
AMOUNTFLAGNAMES = "Nom des drapeaux :",
TILESUSAGE = "Utilisation des tuiles",
AMOUNTTILES = "Tuiles :",
AMOUNTSOLIDTILES = "Tuiles solides :",
AMOUNTSPIKES = "Pointes :",


UNEXPECTEDSCRIPTLINE = "Ligne de script sans script inattendue : $1",
MAPWIDTHINVALID = "La largeur de la carte est invalide : $1",
MAPHEIGHTINVALID = "La hauteur de la carte est invalide : $1",
LEVMUSICEMPTY = "La musique du niveau est vide !",
NOT400ROOMS = "Le nombre d'entrées de levelMetadata n'est pas 400 !",
MOREERRORS = "et $1 autres",

DEBUGMODEON = "Mode de débogage activé",
FPS = "FPS",
STATE = "Etat",
MOUSE = "Souris",

BLUE = "Bleu",
RED = "Rouge",
CYAN = "Cyan",
PURPLE = "Violet",
YELLOW = "Jaune",
GREEN = "Vert",
GRAY = "Gris",
PINK = "Rose",
BROWN = "Marron",
RAINBOWBG = "Arc-en-ciel",

-- b14
SYNTAXCOLORS = "Couleurs syntaxiques",
SYNTAXCOLORSETTINGSTITLE = "Options de coloration syntaxique lors de la modification de scripts",
SYNTAXCOLOR_COMMAND = "Commande",
SYNTAXCOLOR_GENERIC = "Générique",
SYNTAXCOLOR_SEPARATOR = "Séparateur",
SYNTAXCOLOR_NUMBER = "Nombre",
SYNTAXCOLOR_TEXTBOX = "Boite de texte",
SYNTAXCOLOR_ERRORTEXT = "Commande non reconnue",
SYNTAXCOLOR_CURSOR = "Curseur",
SYNTAXCOLOR_FLAGNAME = "Nom de drapeau",
SYNTAXCOLOR_NEWFLAGNAME = "Nouveau nom de drapeau",
RESETCOLORS = "Remise à zéro des couleurs",
STRINGNOTFOUND = "\"$1\" n'a pas été trouvé",

-- b17 - L.MAL is concatenated with L.[...]CORRUPT
MAL = "Le fichier de niveau est mal formaté : ",
METADATACORRUPT = "Les métadonnées sont manquantes ou corrompues.",
METADATAITEMCORRUPT = "Les métadonnées pour $1 sont manquantes ou corrompues.",
TILESCORRUPT = "Les tuiles sont manquantes ou corrompues.",
ENTITIESCORRUPT = "Les entités sont manquantes ou corrompues.",
LEVELMETADATACORRUPT = "Les métadonnées des salles sont manquantes ou corrompues.",
SCRIPTCORRUPT = "Les scripts sont manquants ou corrompus.",

-- 1.1.0
LOADSCRIPTMADE = "Script de chargement créé",
COPY = "Copier",
CUSTOMSIZE = "Taille de pinceau customisée : $1x$2",
SELECTINGA = "Sélection - coin haut gauche",
SELECTINGB = "Sélection : $1x$2",
TILESETSRELOADED = "Jeux de tuiles et images rechargées",

-- 1.2.0
BACKUPS = "Sauvegardes",
BACKUPSOFLEVEL = "Sauvegardes du niveau $1",
LASTMODIFIEDTIME = "Dernière modification", -- List header
OVERWRITTENTIME = "Remplacé", -- List header
SAVEBACKUP = "Sauver dans le dossier de VVVVVV",
DATEFORMAT = "Format de date",
TIMEFORMAT = "Format d'heure",
CUSTOMDATEFORMAT = "Format de date personnalisé",
SAVEBACKUPNOBACKUP = "Faites en sorte de choisir un nom unique pour ceci si vous ne voulez rien remplacer, car AUCUNE sauvegarde ne sera effectuée dans ce cas-ci !",

-- 1.2.4
AUTOSAVECRASHLOGS = "Sauver les historiques de plantage automatiquement",
MOREINFO = "Dernières nouvelles",
COPYLINK = "Copier le lien",
SCRIPTDISPLAY = "Montrer",
SCRIPTDISPLAY_USED = "Utilisé",
SCRIPTDISPLAY_UNUSED = "Non utilisé",

-- 1.3.0 (more changes)
RECENTLYOPENED = "Niveaux récemment ouverts",
REMOVERECENT = "Voulez-vous l'enlever de la liste des niveaux ouverts récemment ?",
RESETCUSTOMBRUSH = "(Clic droit pour donner une nouvelle taille)",

-- 1.3.2
DISPLAYSETTINGS = "Affichage/\nÉchelle",
DISPLAYSETTINGSTITLE = "Options d'Affichage/Échelle",
SMALLERSCREEN = "Largeur de la fenêtre plus petite (800px au lieu de 896px)",
FORCESCALE = "Forcer les options d'échelle",
SCALENOFIT = "Les options d'échelle courantes rendent la fenêtre trop grande pour être affichée.",
SCALENONUM = "Les options d'échelle courantes sont invalides.",
MONITORSIZE = "Moniteur $1x$2",
VEDRES = "Résolution de Ved : $1x$2",
NONINTSCALE = "Échelonnage non entière",

-- 1.3.4
USEFONTPNG = "Utiliser font.png du dossier d'images de VVVVVV comme police",
REQUIRESHIGHERLOVE = " (requiert L{VE $1 ou version ultérieure)",
SYNTAXCOLOR_COMMENT = "Commentaire",
FPSLIMIT = "Limite de FPS",

MAPRESOLUTION = "Résolution", -- Map export size
MAPRES_ASSHOWN = "Comme illustré (max 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 par salle)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 par salle)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Haut gauche",
WIDTHHEIGHT = "Largeur & hauteur",
BOTTOMRIGHT = "Bas droit",
RENDERERINFO = "Information sur le moteur de rendu :",
MAPINCOMPLETE = "La carte n'est pas encore prête (au moment où vous avez appuyé sur Sauver), veuillez réessayer quand elle sera prête.",
KEEPDIALOGOPEN = "Garder le dialogue ouvert",
TRANSPARENTMAPBG = "Arrière plan transparent",
MAPEXPORTERROR = "Erreur lors de la création de la carte.",
VIEWIMAGE = "Voir", -- Verb, view image
INVALIDLINENUMBER = "Veuillez entrer un numéro de ligne valide.",
OPENLEVELSFOLDER = "Ouvrir dossier niveaux", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Déplacer",
GOTOROOM = "Aller dans la salle",
ESCTOCANCEL = "[Appuyez sur Échap pour annuler]",

INVALIDFILENAME_WIN = "Windows n'autorise pas les caractères suivants dans un nom de fichier:\n\n: * ? \" < > |\n\n(| étant une barre verticale)",
INVALIDFILENAME_MAC = "macOS n'autorise pas le caractère : dans un nom de fichier.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "CTRL",
TINY_SHIFT = "MAJ",
TINY_ALT = "ALT",
TINY_ESC = "Échap",
TINY_TAB = "TAB",
TINY_HOME = "Menu",
TINY_END = "END",
TINY_INSERT = "INS",
TINY_DEL = "Suppr",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Scripts [$1]",
SEARCHRESULTS_ROOMS = "Salles [$1]",
SEARCHRESULTS_NOTES = "Notes [$1]",

ASSETS = "Ressources", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "La chanson ne peut pas être lue. Il est possible qu'elle n'existe pas ou qu'elle aie un type non supporté.",
SOUNDPLAYERROR = "Le son ne peut pas être lu. Il est possible qu'il n'existe pas ou qu'il aie un type non supporté.",
MUSICLOADERROR = "Impossible de charger $1 : ",
MUSICLOADERROR_TOOSMALL = "Le fichier son est trop petit pour être valide.",
MUSICEXISTSYES = "Existe",
MUSICEXISTSNO = "N'existe pas",
LOAD = "Charger",
RELOAD = "Recharger",
UNLOAD = "Décharger",
MUSICEDITOR = "Editeur de musique",
LOADMUSICNAME = "Charger .vvv",
INSERTSONG = "Insérer une chanson dans la piste $1",
SUREDELETESONG = "Etes-vous sûr de vouloir supprimer la chanson $1 ?",
SONGOPENFAIL = "Impossible d'ouvrir $1, la chanson n'a pas été remplacée.",
SONGREPLACEFAIL = "Quelque chose s'est mal passé lors du remplacement de la chanson.",
KILOBYTES = "$1 ko",
MEGABYTES = "$1 Mo",
GIGABYTES = "$1 Go",
CANNOTUSENEWLINES = "Le caractère \"$1\" ne peut pas être utilisé dans le nom d'un script !",
MUSICTITLE = "Titre : ",
MUSICARTIST = "Artiste : ",
MUSICFILENAME = "Nom de fichier : ",
MUSICNOTES = "Notes :",
SONGMETADATA = "Métadonnées pour la chanson $1",
MUSICFILEMETADATA = "Métadonnées du fichier",
MUSICEXPORTEDON = "Exporté : ", -- Followed by date and time
SAVEMETADATA = "Sauver métadonnées",
SOUNDS = "Sons",
GRAPHICS = "Graphismes",
FILEOPENERNAME = "Nom : ",
PATHINVALID = "Le chemin est invalide.",
DRIVES = "Lecteurs", -- like C: or F: on Windows
DOFILTER = "Seulement montrer *$1", -- "*.txt" for example
DOFILTERDIR = "Seulement montrer les dossiers",
FILEDIALOGLUV = "Désolé, votre système d'exploitation n'est pas reconnu, donc le dialogue de fichier ne fonctionne pas.",
RESET = "Réinit.",
CHANGEVERB = "Changer", -- verb
LOADIMAGE = "Charger image",
GRID = "Grille",
NOTALPHAONLY = "RBV",

OPAQUEROOMNAMEBACKGROUND = "Rendre l'arrière-plan du nom de salle opaque",
PLATVCHANGE_TITLE = "Changer la vitesse de la plateforme",
PLATVCHANGE_MSG = "Vitesse :",
PLATVCHANGE_INVALID = "Vous devez entrer un nombre.",
RENAMESCRIPTREFERENCES = "Renommer les références",
PLATFORMSPEEDSLIDER = "Vit. :",

TRINKETS = "Médailles",
LISTALLTRINKETS = "Lister toutes les médailles", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Liste de toutes les médailles",
NOTRINKETSINLEVEL = "Il n'y a pas de médaille dans ce niveau.",
CREWMATES = "Équipiers",
LISTALLCREWMATES = "Lister tous les équipiers", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Liste de tous les équipiers secourables",
NOCREWMATESINLEVEL = "Il n'a pas d'équipier secourable dans ce niveau.",
SHIFTROOMS = "Déplacer la salle", -- In the map. Move all rooms in the entire level in any direction


OLDSHORTCUT_SCRIPTJUMP = "CTRL+gauche/droite sera bientôt enlevé, utilisez ALT+gauche/droite à la place", -- CTRL and ALT are capitalized here for extra clarity in this string
OLDSHORTCUT_ASSETS = "Ctrl+A sera bientôt enlevé, utilisez Ctrl+R à la place",
OLDSHORTCUT_OPENLVLDIR = "Ctrl+D sera bientôt enlevé, utilisez Ctrl+F à la place",


}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Vous avez $1 module qui n'est pas supporté dans cette version.",
		[1] = "Vous avez $1 modules qui ne sont pas supportés dans cette version.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Ce niveau a échoué $1 test. Le problème a peut-être été réparé automatiquement, mais il est possible que certains problèmes et incohérences subsistent.",
		[1] = "Ce niveau a échoué $1 tests. Les problèmes ont peut-être été réparés automatiquement, mais il est possible que certains problèmes et incohérences subsistent.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 utilisation dans les salles : $2",
		[1] = "$1 utilisations dans les salles : $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 utilisation dans les scripts : $2",
		[1] = "$1 utilisations dans les scripts : $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "L'entité à [$1 $2] a $3 propriété invalide !",
		[1] = "L'entité à [$1 $2] a $3 propriétés invalides !",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "Les métadonnées du niveau pour la salle #$1 a $2 propriété invalide !",
		[1] = "Les métadonnées du niveau pour la salle #$1 a $2 propriétés invalides !",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Affichage de $1",
		[1] = "Affichage de $1",
	},
	FLAGUSAGES = {
		[0] = "Utilisé $1 fois dans les scripts : $2",
		[1] = "Utilisé $1 fois dans les scripts : $2",
	},
	NOTALLTILESVALID = {
		[0] = "La tuile $1 n'est pas un nombre entier valide dans l'intervalle 0-1199",
		[1] = "Les tuiles $1 ne sont pas des nombres entiers valides dans l'intervalle 0-1199",
	},
	BYTES = {
		[0] = "$1 octet",
		[1] = "$1 octets",
	},
}

toolnames = {

"Mur",
"Arrière-plan",
"Pique",
"Médailles",
"Point de sauvegarde",
"Plateforme disparaissante",
"Tapis roulant",
"Plateforme mobile",
"Ennemi",
"Ligne de gravité",
"Texte de salle",
"Moniteur",
"Boite de script",
"Jeton de téléportation",
"Ligne de téléportation",
"Équipiers",
"Point de départ",

}

subtoolnames = {

[1] = {"Pinceau 1x1", "Pinceau 3x3", "Pinceau 5x5", "Pinceau 7x7", "Pinceau 9x9", "Remplir horizontalement", "Remplir verticalement", "Taille de pinceau customisée", "Seau de remplissage", "Patate pour Faire des Trucs qui sont Magiques"},
[2] = {},
[3] = {"Auto 1", "Expansion auto G+D", "Expansion auto G", "Expansion auto D"},
[4] = {},
[5] = {"Vertical", "Renversé"},
[6] = {},
[7] = {"Petit D", "Petit G", "Grand D", "Grand G"},
[8] = {"Bas", "Haut", "Gauche", "Droite"},
[9] = {},
[10] = {"Horizontal", "Vertical"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Entrée", "Quitter"},
[15] = {},
[16] = {"Rose", "Jaune", "Rouge", "Vert", "Bleu", "Cyan", "Aléatoire"},
[17] = {"Tourner vers la droite", "Tourner vers la gauche"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "A",

}

warpdirchangedtext = {

[0] = "Téléportation dans la même salle désactivée",
[1] = "Direction de téléportation : horizontal",
[2] = "Direction de téléportation : vertical",
[3] = "Direction de téléportation : vertical et horizontal",

}

langtilesetnames = {

short0 = "Stn. Spat.",
long0 = "Station Spatiale",
short1 = "Extérieur",
long1 = "Extérieur",
short2 = "Labo",
long2 = "Labo",
short3 = "Zone de TP",
long3 = "Zone de Téléportation",
short4 = "Vaisseau",
long4 = "Vaisseau",

}

ERR_VEDHASCRASHED = "Ved a planté !"
ERR_VEDVERSION = "Version de Ved :"
ERR_LOVEVERSION = "Version de L{VE :"
ERR_STATE = "État :"
ERR_OS = "SE :"
ERR_TIMESINCESTART = "Temps depuis le début :"
ERR_PLUGINS = "Modules :"
ERR_PLUGINSNOTLOADED = "(non chargé)"
ERR_PLUGINSNONE = "(aucun)"
ERR_PLEASETELLDAV = "Veuillez contacter Dav999 à propos de ce problème.\n\n\nDétails : (appuyez sur Ctrl/Cmd+C pour copier dans le presse papiers)\n\n"
ERR_INTERMEDIATE = " (version intermédiaire)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (trop récent)"

ERR_PLUGINERROR = "Erreur de module !"
ERR_FILE = "Fichier à éditer :"
ERR_FILEEDITORS = "Modules qui modifient ce fichier :"
ERR_CURRENTPLUGIN = "Module qui a provoqué cette erreur :"
ERR_PLEASETELLAUTHOR = "Un module était supposé modifier le code de Ved, mais le code à remplacer n'a pas été trouvé.\nIl est possible que ceci soit causé par un conflit entre deux modules, ou qu'une mise à jour de Ved aie cassé ce module.\n\nDétails : (appuyez sur Ctrl/Cmd+C pour copier dans le presse papiers)\n\n"
ERR_CONTINUE = "Vous pouvez continuer en appuyant sur Échap ou Entrée, mais cette modification erronée peut causer des problèmes."
ERR_REPLACECODE = "Impossible de trouver ceci dans %s.lua :"
ERR_REPLACECODEPATTERN = "Impossible de trouver ceci dans %s.lua (en tant que motif) :"
ERR_LINESTOTAL = "%i lignes au total"

ERR_SAVELEVEL = "Pour sauver une copie de votre niveau, appuyez sur S"
ERR_SAVESUCC = "Niveau sauvegardé avec succès en tant que %s !"
ERR_SAVEERROR = "Erreur de sauvegarde! %s"
ERR_LOGSAVED = "Plus d'informations peuvent être trouvées dans le rapport de plantage :\n%s"


diffmessages = {
	pages = {
		levelproperties = "Propriétés de niveaux",
		changedrooms = "Salles modifiées",
		changedroommetadata = "Métadonnées de salle modifiée",
		entities = "Entités",
		scripts = "Scripts",
		flagnames = "Nom des drapeaux",
		levelnotes = "Notes de niveau",
	},
	levelpropertiesdiff = {
		Title = "Le nom a été changé de \"$1\" à \"$2\"",
		Creator = "L'auteur a été changé de \"$1\" à \"$2\"",
		website = "Le site internet a été changé de \"$1\" à \"$2\"",
		Desc1 = "La description 1 a été changée de \"$1\" à \"$2\"",
		Desc2 = "La description 2 a été changée de \"$1\" à \"$2\"",
		Desc3 = "La description 3 a été changée de \"$1\" à \"$2\"",
		mapsize = "La taille de la carte a été changée de $1x$2 à $3x$4",
		mapsizenote = "NOTE: La taille de la carte a été changée de $1x$2 à $3x$4.\\o\nLes salles en dehors de $5x$6 ne sont pas listées.\\o",
		levmusic = "La musique du niveau a été changée de $1 à $2",
	},
	rooms = {
		added1 = "Ajouté ($1,$2) ($3)\\G",
		added2 = "Ajouté ($1,$2) ($3 -> $4)\\G",
		changed1 = "Modifié ($1,$2) ($3)\\Y",
		changed2 = "Modifié ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Tuiles dans la zone ($1,$2) ($3) enlevées\\R",
		cleared2 = "Tuiles dans la zone ($1,$2) ($3 -> $4) enlevées\\R",
	},
	roommetadata = {
		changed0 = "Salle $1,$2 :",
		changed1 = "Salle $1,$2 ($3) :",
		roomname = "Nom de la salle modifié de \"$1\" à \"$2\"\\Y",
		roomnameremoved = "Nom de la salle \"$1\" enlevé\\R",
		roomnameadded = "Salle nommée \"$1\"\\G",
		tileset = "Jeu de tuiles $1 couleur $2 modifié à jeu de tuiles $3 couleur $4\\Y",
		platv = "Vitesse de la plateforme modifiée de $1 à $2\\Y",
		enemytype = "Type d'ennemi modifié de $1 à $2\\Y",
		platbounds = "Bords de la plateforme modifiées de $1,$2,$3,$4 à $5,$6,$7,$8\\Y",
		enemybounds = "Bords de l'ennemi modifié de $1,$2,$3,$4 à $5,$6,$7,$8\\Y",
		directmode01 = "Mode direct activé\\G",
		directmode10 = "Mode direct désactivé\\R",
		warpdir = "Direction de téléportation modifiée de $1 à $2\\Y",
	},
	entities = {
		added = "Type d'entité $1 ajouté à la position $2,$3 dans la salle ($4,$5)\\G",
		removed = "Type d'entité $1 supprimé à la position $2,$3 dans la salle ($4,$5)\\R",
		changed = "Type d'entité $1 modifié à la position $2,$3 dans la salle ($4,$5)\\Y",
		changedtype = "Type d'entité $1 modifié en type $2 à la position $3,$4 dans la salle ($5,$6)\\Y",
		multiple1 = "Entités modifiées à la position $1,$2 dans la salle ($3,$4) :\\Y",
		multiple2 = "vers :",
		addedmultiple = "Entités ajoutées à la position $1,$2 dans la salle ($3,$4) :\\G",
		removedmultiple = "Entités supprimées à la position $1,$2 dans la salle ($3,$4) :\\R",
		entity = "Type $1",
		incomplete = "Toutes les entités n'ont pas pu être traitées! Veuillez reporter ceci à Dav.\\r",
	},
	scripts = {
		added = "Script \"$1\" ajouté\\G",
		removed = "Script \"$1\" supprimé\\R",
		edited = "Script \"$1\" modifié\\Y",
	},
	flagnames = {
		added = "Ajouté un nom pour le drapeau $1 : \"$2\"\\G",
		removed = "Nom \"$1\" supprimé pour le drapeau $2\\R",
		edited = "Nom du drapeau $1 modifié de \"$2\" à \"$3\"\\Y",
	},
	levelnotes = {
		added = "Note de niveau \"$1\" ajoutée\\G",
		removed = "Note de niveau \"$1\" supprimée\\R",
		edited = "Note de niveau \"$1\" modifiée\\Y",
	},
	mde = {
		added = "Entité de métadonnées ajoutée\\G",
		removed = "Entité de métadonnées supprimée\\G",
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
subj = "Retour",
imgs = {},
cont = [[
\)
]] -- This should be left the same!
},

{
splitid = "010_Getting_started",
subj = "Démarrage",
imgs = {},
cont = [[
Démarrage\wh#
\C=

Cet article va vous aider à prendre Ved en main. Pour commencer à utiliser
l'éditeur, vous devez charger ou créer un niveau.


L'éditeur\h#

Sur le côté gauche, vous trouverez les outils de sélection. La majorité de ces
outils ont des outils subsidiaires qui seront listés sur leur droite. Pour changer
d'outil, utilisez leur raccourci ou utilisez la molette en appuyant sur les
touches Ctrl et Maj. Pour changer d'outil secondaire, utilisez seulement la
molette. Pour plus d'informations sur les outils, veuillez consulter la page
d'aider sur les ¤Outils¤.\nwl
Effectuez un clic droit sur les entités pour faire apparaître un menu contextuel
pour cette entité. Pour supprimer une entité sans utiliser son menu contextuel,
effectuez un clic droit sur celle-ci en appuyant sur la touche Maj.
Sur le côté droit de l'écran, vous trouverez beaucoup de boutons et d'options.
Les boutons supérieurs sont liés au niveau tout entier tandis que les boutons
inférieurs (sous Options de salle) sont spécifiques à la salle courante. Pour plus
d'informations sur ces boutons, veuillez consulter leurs pages d'aide respectives,
si elles sont disponibles.

Dossiers de niveau\h#

Ved utilise normalement le même dossier que VVVVVV utilise pour stocker ses 
niveaux, donc il est facile de passer de l'éditeur de niveau de VVVVVV à Ved et
vice versa. So Ved ne détecte pas votre dossier de VVVVVV correctement, vous
pouvez entrer un chemin personnalisé dans les options de Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Modes de placement de tuiles",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
Modes de placement de tuiles\wh#
\C=

Ved supporte trois modes différents pour placer des tuiles.

     Mode automatique\h#0

          Ce mode est le plus facile à utiliser. Dans ce mode, vous pouvez
          ajouter des murs et arrière-plans et les bordures vont être placées
          correctement. Cependant, en utilisant ce mode, tous les murs et
          arrière-plans dans la salle doivent utiliser les mêmes couleurs et
          jeux de tuiles.

     Mode multi-jeu de tuiles\h#1

          Très similaire au mode automatique, mis à part qu'il est possible
          d'utiliser plusieurs jeux de tuiles dans la même salle. Cela veut dire
          que changer un jeu de tuiles n'affectera pas les tuiles de mur et
          d'arrière-plan déjà placées, et multiples types de tuiles peuvent être
          ajoutés dans la même salle.

     Mode manuel\h#2

          Aussi appelé Mode Direct, dans ce mode vous pouvez placer
          n'importe quel tuile manuellement, donc vous n'êtes pas limité par
          les différents groupes dans les jeux de tuiles, et les bords ne seront
          pas ajoutés automatiquement aux murs, vous donnant un contrôle
          complet sur l'aspect de la salle. Cependant, ce mode d'édition est
          plus lent à utiliser.
]]
},

{
splitid = "030_Tools",
subj = "Outils",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
Outils\wh#
\C=

Vous pouvez utiliser ces différents outils pour remplir les salles de votre
niveau :

\0
   Mur\h#


L'outil de mur peut être utiliser pour placer des murs.

\1
   Arrière-plan\h#


L'outil d'arrière-plan peut être utilisé pour placer des arrière-plans.

\2
   Pointes\h#


L'outil de pointes peut être utiliser pour placer des pointes. Vous pouvez
utiliser le sous-outil d'expansion pour placer des pointes sur un mur en un clic
(ou glissement).

\3
   Médaille\h#


L'outil de médaille peut être utiliser pour placer des médailles. Veuillez noter
qu'il existe une limite de vingt médailles dans un niveau.

\4
   Point de sauvegarde\h#


L'outil de point de sauvegarde peut être utilisé pour placer des points de
sauvegarde.

\5
   Plateforme disparaissante\h#


L'outil de plateforme disparaissante peut être utilisé pour places des plateformes
disparaissantes.

\6
   Tapis roulant\h#


L'outil de tapis roulant peut être utilisé pour placer des tapis roulants.

\7
   Plateforme mobile\h#


L'outil de plateforme mobile peut être utilisé pour placer des plateformes
mobiles.

\8
   Ennemi\h#


L'outil d'ennemi permet de placer des ennemis. La forme et couleur de l'ennemi est
déterminé respectivement par l'option de type d'ennemi et le jeu de tuiles
(couleur).

\9
   Ligne de gravité\h#


L'outil de ligne de gravité permet de placer des lignes de gravité.

\^0
   Texte de salle\h#


L'outil de texte de salle permet de placer du texte.

\^1
   Terminal\h#


L'outil de terminal permet de placer des terminaux. En premier, placer le
terminal, ensuite entrer un nom pour son script. Pour plus d'informations sur la
programmation de script, veuillez référer aux références de programmation de
script.

\^2
   Boite de script\h#


L'outil de boite de script permet de placer des boits de script. Tout d'abord
cliquez sur le coin en haut à gauche, puis en bas à droite et enfin entrez le nom
du script. Pour plus d'informations sur la programmation de script, veuillez
référer aux références de programmation de script.

\^3
   Jeton de téléportation\h#


L'outil de jeton de téléportation peut être utilisé pour placer des jetons de 
téléportation. Tout d'abord cliquez à l'endroit où l'entrée doit être, puis à
l'endroit où la sortie doit être.

\^4
   Ligne de téléportation\h#


L'outil de ligne de téléportation peut être utilisé pour placer des lignes de
téléportation. Veuillez noter que les lignes de téléportation ne peuvent être
placées que sur les bords d'une salle.

\^5
   Équipier\h#


L'outil d'équipier peut être utilisé pour placer des équipiers disparus qui
peuvent être secourus. Si tous les équipiers sont secourus, le niveau est terminé.
Veuillez noter qu'il y a une limite de vingt équipiers dans un niveau.

\^6
   Point de départ\h#


L'outil de point de départ peut être utilisé pour placer le point de départ.
]]
},
{
splitid = "040_Script_editor",
subj = "Éditeur de script",
imgs = {},
cont = [[
Éditeur de script\wh#
\C=

Avec l'éditeur de script, vous pouvez gérer et éditer les scripts de votre niveau.


Noms de drapeaux\h#

Pour un confort et une lisibilité de script, il est possible d'utiliser des noms
de drapeaux plutôt que des nombres. Quand un nombre est utilisé à la place d'un
drapeau, un nombre est automatiquement associé à ce nom en arrière-plan.
Il est alors possible de choisir quel nombre utiliser avec chaque nom de drapeau.

Mode de création de script interne\h#

Pour utiliser un script interne dans Ved, vous pouvez activer le mode de création
de script interne dans l'éditeur pour gérer toutes les commandes de ce script
en tant que script interne. Voir le mode Sc.int¤ pour plus d'informations sur le
mode de création de scripte interne. Pour plus d'informations sur la création de
script interne, veuillez consulter la référence sur la création de script interne.

Séparer les scripts\h#

Il est possible de séparer un script en deux scripts avec l'éditeur de script.
Après avoir placé le curseur de texte sur la première ligne qui doit faire partie
du nouveau script, appuyez sur le bouton Séparer et entrez le nom du nouveau
script. Les lignes avant le curseur resteront dans le script original, et toute
ligne en dessous du curseur seront déplacées dans le nouveau script.

Sauter dans les scripts\h#

Dans les lignes avec les commandes iftrinkets, ifflag, customiftrinkets ou
customifflag, il est possible de sauter dans un script donné en cliquant sur le
bouton "Aller à" quand le curseur est sur cette ligne. Vous pouvez aussi entrer
Alt+Droite¤ pour faire ceci, et vous pouvez utiliser ¤Alt+Gauche¤ pour revenir en\wnw
arrière d'un pas dans la chaîne de scripts dans lesquels vous vous trouviez
précédemment.
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Mode sc.int",
imgs = {},
cont = [[
Mode de création de script interne\wh#
\C=

Pour utiliser le mode de création de script interne dans Ved, vous devez activer
le mode de création de script interne dans l'éditeur afin de gérer toutes les
commandes dans ce script en tant que script interne. Avec cette fonctionnalité,
vous n'avez pas à beaucoup vous soucier de comment faire fonctionner le
script interne; vous n'avez pas à utiliser de commande ¤say¤, de compter les\nw
lignes, d'entrer ¤text(1,0,0,4)¤ ou ¤text,,,,4¤ ou n'importe quelle forme de ces\nwnw
commandes - vous n'avez qu'à écrire vos scripts internes comme s'ils étaient
pour le vrai jeu. Vous n'avez même pas besoin de finir avec une commande
¤loadscript¤.\nw

Ved supporte différentes méthodes de création de script interne. Pour mettre
en évidence leurs différences techniques, nous allons utiliser ce script d'exemple
ci-dessous :

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

Les lignes de ce script interne sont en ¤vert clair¤, les lignes qui sont ajoutées\nG
automatiquement et sont nécessaires pour que l'exploit de script fonctionne seront
en ¤gris¤. Veuillez noter que cet exemple a été un peu simplifié; Ved ajoute ¤#v¤\ngnw
à la fin des lignes grises pour être sûr que les scripts modifiés manuellement ne
seront pas changés, et les blocs ¤say¤ qui sont trop grands devront être séparés\nw
en des blocs plus petits.

Pour plus d'informations sur la création de script interne, veuillez vous référer
à la référence sur la création de script interne.

Sc.int loadscript\h#

La méthode loadscript est probablement la méthode la plus utilisée aujourd'hui.
C'est la méthode que Ved a supporté depuis sa version alpha.

Elle requiert un script supplémentaire, le script de chargement, pour charger le
script interne. Le script de chargement, dans sa forme la plus basique, doit
contenir une commande telle que ¤iftrinkets(0,yourscript)¤, mais il y a d'autres\nw
commandes utilisables à sa place, et vous pouvez aussi utiliser ¤ifflag¤ à la place\nw
de ¤iftrinkets¤. Le plus important est que votre script interne doit être chargé\nw
depuis un autre script pour qu'il fonctionne.

Le script interne serait converti plus ou moins en tant que ceci :

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

text(1,0,0,3)¤ doit être la dernière ligne, ou dans l'éditeur de script de VVVVVV,\w
il doit y avoir exactement une ligne vide après le script.

Il est aussi possible de ne pas utiliser ¤squeak(off)¤ et d'utiliser ¤text(1,0,0,4)\nwnw
au lieu de ¤text(1,0,0,3)¤. Cependant, utiliser ¤squeak(off)¤ permet de raccourcir le\nwnw
script de quelques lignes dans un script plus long.

Sc.int say(-1)\h#

La commande say(-1) est plus ancienne et a un désavantage comparé à la méthode
loadscript: elle fait toujours apparaître les barres qui apparaissent lors d'une
cinématique. Cependant, elle a aussi un avantage qui peut être important dans des
niveaux avec beaucoup de scripts: elle n'a pas besoin de script de chargement.
Nous pouvons enlever les commandes ¤cutscene()¤ et ¤untilbars()¤ de ce script car\nwnw
celles-ci seront déjà automatiquement ajoutées par VVVVVV lorsqu'on utilise cette
méthode.

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

Cette méthode a été ajoutée en tant que méthode de création de script interne
supplémentaire dans Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Raccourcis clavier",
imgs = {},
cont = [[
Raccourcis clavier de l'éditeur\wh#
\C=

La majorité des raccourcis clavier utilisable dans VVVVVV peuvent être
utilisés dans Ved.

F1¤  Changer de jeu de tuiles\C
F2¤  Changer de couleur\C
F3¤  Changer d'ennemi\C
F4¤  Limites des ennemis\C
F5¤  Limites des plateformes\C

F10¤  Mode manuel/automatique (mode direct/mode indirect)\C

W¤  Changer la direction de la téléportation\C
E¤  Changer le nom de la salle\C

L¤  Charger carte\C
S¤  Sauver carte\C

Z¤  Pinceau 3x3 (murs et arrière-plans)\C
X¤  Pinceau 5x5 (")\C

< ¤et¤ >¤  Changer d'outil\CnC
Ctrl/Cmd+< ¤et¤ Ctrl/Cmd+>¤  Changer d'outil secondaire\CnC

Plus de raccourcis clavier\h#

Ved introduit aussi quelques raccourcis clavier.

Éditeur principal\gh#

Ctrl+P¤  Aller à la salle contenant le point de départ\C
Ctrl+S¤  Sauvegarde rapide\C
Ctrl+X¤  Couper la salle dans le presse-papier\C
Ctrl+C¤  Copier la salle dans le presse-papier\C
Ctrl+V¤  Coller la salle depuis le presse-papier (si elle est valide)\C
Ctrl+D¤  Comparer ce niveau avec un autre niveau\C
Ctrl+Z¤  Défaire\C
Ctrl+Y¤  Refaire\C
Ctrl+F¤  Recherche\C
Ctrl+/¤  Bloc-notes du niveau\C
Ctrl+F1¤  Aide\C
(NOTE: Sur Mac, replacer Ctrl par Cmd)
N¤  Afficher tous les nombres de tuiles\C
J¤  Afficher la solidité des tuiles\C
M¤  Afficher la carte\C
Q¤  Aller à la salle (entrer les coordonnées avec 4 chiffres)\C
/¤  Scripts\C
[¤  Bloquer la position Y de la souris tant qu'elle est appuyée\C
   (pour dessiner des lignes horizontales facilement)
]¤  Bloquer la position X de la souris tant qu'elle est appuyée\C
   (pour dessiner des lignes verticales facilement)
F11¤  Recharger les jeux de tuiles et images\C

Entités\gh#

Maj+Clic droit¤  Supprimer l'entité\C
Alt+Clic¤        Déplacer l'entité\C
Alt+Maj+Clic¤    Copier l'entité\C

Éditeur de script\gh#

Ctrl+F¤  Chercher\C
Ctrl+G¤  Aller à la ligne\C
Ctrl+I¤  Activer/Désactiver le mode de création de script interne\C
Alt+droite¤  Sauter dans le script de la commande conditionnelle\C
Alt+gauche¤  Sauter dans le script précédent\C

Liste de scripts\gh#

N¤  Create new script\C
F¤  Go to flags list\C
/¤  Go to topmost/latest script\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Simp.script reference",
imgs = {},
cont = [[
Simplified scripting reference\wh#
\C=

VVVVVV's simplified scripting language is a basic language that can be used to
script VVVVVV levels.
Note: whenever something is between quotes, it needs to be typed without them.


say¤([lines[,color]] .. "]]" .. [[)\h#w

Display a text box. Without any arguments, this will make a text box with one
line, and by default this will result in a centered terminal text box. The color
argument can be a color, or the name of a crewmate.
If you use a color and a rescuable crewmate with that color is in the room, then
the text box will be displayed above that crewmate.

reply¤([lines])\h#w

Display a text box for Viridian. Without the lines argument, this will make a text
box with one line.

delay¤(n)\h#w

Delays further action by n ticks. 30 ticks is almost one second.

happy¤([crewmate])\h#w

Makes a crewmate happy. Without an argument, this will make Viridian happy. You
can also use "all", "everyone" or "everybody" as an argument to make everybody
happy.

sad¤([crewmate])\h#w

Makes a crewmate sad. Without an argument, this will make Viridian sad. You
can also use "all", "everyone" or "everybody" as an argument to make everybody
sad.

flag¤(flag,on/off)\h#w

Turn a given flag on or off. For example, flag(4,on) will turn flag number 4 on.
There are 100 flags, numbered from 0 to 99.
By default, all flags are off when you start playing a level.
Note: In Ved, you can also use flag names instead of the numbers.

ifflag¤(flag,scriptname)\h#w

If a given flag is ON, then go to script with name scriptname.
If a given flag is OFF, continue in the current script.
Example:
ifflag(20,cutscene) - If flag 20 is ON, go to script "cutscene", else continue in
                      the current script.
Note: In Ved, you can also use flag names instead of the numbers.

iftrinkets¤(number,scriptname)\h#w

If your amount of trinkets >= number, go to script with name scriptname.
If your amount of trinkets < number, continue in the current script.
Example:
iftrinkets(3,enoughtrinkets) - If you have 3 or more trinkets, the script
                               "enoughtrinkets" will be run, else the current
                               script will continue.
It is common practise to use 0 as a minimum amount of trinkets, as a way to load
a script in any case.

iftrinketsless¤(number,scriptname)\h#w

If your amount of trinkets < number, go to script with name scriptname.
If your amount of trinkets >= number, continue in the current script.

destroy¤(something)\h#w

Valid arguments can be:
warptokens - Remove all warp tokens from the room until you re-enter the room.
gravitylines - Remove all gravity lines from the room until you re-enter the room.
The option "platforms" also exists, but it doesn't work properly.

music¤(number)\h#w

Change the song to a certain song number.
For the list of song numbers, refer to the "Lists reference" article.

playremix\h#w

Plays the remix of Predestined Fate as music.

flash\h#w

Flashes the screen white, makes a bang sound and shakes the screen for a bit.

map¤(on/off)\h#w

Turn the map on or off. If you turn the map off, it will display "NO SIGNAL" until
you turn it on again. Rooms will still be uncovered while the map is off to be
visible when the map is turned on.

squeak¤(crewmate/on/off)\h#w

Make a crewmate squeak, or turn the squeak sound when a text box is displayed on
or off.

speaker¤(color)\h#w

Changes the color and position of the next text boxes created with the "say"
command. This can be used instead of giving a second argument to "say".
]]
},

{
splitid = "080_Int_script_reference",
subj = "Int. script reference",
imgs = {},
cont = [[
Internal scripting reference\wh#
\C=

La création de script interne donne plus de pouvoir au scripteur, mais c'est
aussi un peu plus compliqué que la création de script simplifié.

To use internal scripting in Ved, you can enable internal scripting mode in the
editor, to handle all commands in that script as internal scripting.

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
splitid = "090_Lists_reference",
subj = "Lists reference",
imgs = {},
cont = [[
Lists reference\wh#
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
10 - Popular Potpourri
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
splitid = "100_Formatting",
subj = "Formatting",
imgs = {},
cont = [[
Formatting\wh#
\C=

In notes you can use formatting codes to make your text larger, color it, and some
other things. To add formatting to a line, add a backslash (\) at the end of it.\
After the \, you can add any amount of the following characters, in any order:\

h - Double font size\h

# - Anchor. You can jump to anchors quickly with ¤#Links¤links¤.\nLCl
- - Horizontal line:
\-
= - Horizontal line underneath large text

Text colors:\h#

n - Normal\n
r - Red\r
g - Gray\g
w - White\w
b - Blue\b
o - Orange\o
v - Green\v
c - Cyan\c
y - Yellow\y
p - Purple\p
V - Dark green\V
z - Black¤ (background color is not included)\z&Z
Z - Dark gray\Z
C - Cyan (Viridian)\C
P - Pink (Violet)\P
Y - Yellow (Vitellary)\Y
R - Red (Vermilion)\R
G - Green (Verdigris)\G
B - Blue (Victoria)\B


Example:\h#

\-
Large orange text ("oh" has same result)\ho\
\
Large orange text ("oh" has same result)\ho

\-
Underlined large text\wh\
\r=\
\
Underlined large text\wh
\r=
\-

Using multiple colors on a line\h#

It is possible to use multiple colors on a line by separating colored parts with
the¤ ¤¤ ¤character (which you can type using the ¤Insert¤ key), and putting the color\nYnw
codes in order after¤ \¤. If the last color on the line is the default color (n), it\nC
is not necessary to list that at the end. If you want to use the¤ ¤¤ ¤character on a\nY
line which uses¤ \¤, write¤ ¤¤¤¤ ¤instead. For technical reasons, it is n¤o§¤t possible to\nCnYnR(
color a single character by enclosing it in two¤ ¤¤§¤s, unless you also include a\nY(
space or another character.

\-
You can ¤¤color¤¤ specific ¤¤words¤¤ with this!\nrnv\
\
You can ¤color¤ specific ¤words¤ with this!\nrnv
\-
Some ¤¤te¤¤xt¤¤ co¤¤lo¤¤rs\RYGCBP\
\
Some ¤te¤xt¤ co¤lo¤rs\RYGCBP
\-

Coloring a single character\h#

OK, I lied, it is possible to color a single character without including a space.
To do this, put the character¤ § ¤(which you can type using ¤Shift+Insert¤), after\nYnw
the character you want to color, and enable it with the formatting code¤ ( ¤after¤ \¤:\nCnC

\-
You can c¤¤o§¤¤lor a ¤¤single¤¤ character like this!\nrny(\
\
You can c¤o§¤lor a ¤single¤ character like this!\nrny(
\-

This is not necessary if the single character is the first or last on a line.

Background colors\h#

Not only can text be colored, it can also be ¤highlighted¤ in any of the text\nZ&y
colors. To do this, you can put¤ & ¤after the regular text color code, and then a\nY
color code for the background color. This can be done in combination with the ¤
system described above, note that regular text colors start the next "block",
but background colors do not. The following examples use spaces to make everything
more readable, but this is completely optional. You can use the code¤ + ¤to expand\nY
the (last) background color to the end of the line.

\-
Black text on white background!\z&w\
\
Black text on white background!\z&w
\-
Black text on expanded white background!\z&w+\
\
Black text on expanded white background!\z&w+
\-
Red on yellow¤¤, ¤¤Black on white¤¤ (optionally spaces improve readability)\r&y n z&w\
\
Red on yellow¤, ¤Black on white¤ (optionally spaces improve readability)\r&y n z&w
\-
This still ¤¤works¤¤ to color si¤¤n§¤¤gle characters\n P n n&r (\
\
This still ¤works¤ to color si¤n§¤gle characters\n P n n&r (
\-

If you like, you can also make graphics using background colors:

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
\
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
\
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

Links can be used for two things: linking to somewhere else in the articles/notes,
or linking to websites. Links use the semi-color code¤ l¤. This code does not switch\nY
to the next "colored block", it only applies to the current one, as opposed to
regular (non-background) color codes. It also does not change color, so you can
change the style of the link to anything you want.

You can link to articles by simply using the name of the article:

\-
Tools\bl\
\
Tools\bl
\-

Clicking the "Tools" above will bring you to the Tools help article. I used the
color code¤ b ¤here to make the link blue, and as you can see, the¤ l ¤applies to\nbnY
that same colored part.

You can link to anchors in the same article by linking to a¤ # ¤followed by all text\nY
on that line. (Instances of¤ ¤¤ ¤are completely ignored there.) You can link to the\nY
top of the article with just a hash character (¤#§¤).\nY(

\-
#Using multiple colors on a line\bl\
\
#Using multiple colors on a line\bl
\-

You can link to an anchor in a different article in a similar way:

\-
Lists reference#Gamestates\bl\
\
Lists reference#Gamestates\bl
\-

Linking to websites is straightforward too:

\-
https://example.com/\bl\
\
https://example.com/\bl
\-

You can use a color block with color code¤ L ¤that contains the actual destination\nY
before the link text, and make the link show a different text that way:

\-
Tools¤¤Go to another article\Lbl\
\
Tools¤Go to another article\Lbl
\-
Click ¤¤Tools¤¤here¤¤ to go to another article\nLbl\
\
Click ¤Tools¤here¤ to go to another article\nLbl
\-
[¤¤#Links¤¤Like¤¤] [¤¤#Example:¤¤Dislike¤¤]\n L vl n L rl\
\
[¤#Links¤Like¤] [¤#Example:¤Dislike¤]\n L vl n L rl
\-
#Links¤¤ Button A ¤¤ §¤¤#Links¤¤ Button B \L w&Zl n L w&Z l(\
\
#Links¤ Button A ¤ §¤#Links¤ Button B \L w&Zl n L w&Z l(
\-

Images (only available in plugin\h#
\
descriptions):\h

0..9 - display image 0..9 on this line (array index in the imgs array starts at 0,
       and remember to keep lines blank to accommodate for the image height)
^ - Put this before the image number, shift image number by 10. So ^4 makes image
    14, ^^4 makes image 24. And 3^1^56 makes images 3, 11, 25 and 26.
_ - Put this before the image number to decrease the image number by 10.
> - Put this before the image number to shift further images to the right by 8
    pixels. This can be repeated, so 0>>>>1 puts image 0 at x=0 and
    image 1 at x=32.
< - Same, but shift to the left.
]]
},

{
splitid = "990_Credits",
subj = "Remerciements",
imgs = {"credits.png"},
cont = [[
\0















Remerciements\wh#
\C=

Ved a été créé par Dav999

Autres contributeurs de code: Info Teddy

Quelques graphismes et la police ont été créés par Hejmstel

Traduction en russe: CreepiX, Cheep
Traduction en esperanto: Hejmstel
Traduction en allemand: r00ster
Traduction en français: RhenaudTheLukark


Remerciements spéciaux à :\h#


Terry Cavanagh pour avoir créé VVVVVV

Tous ceux qui ont signalé des bogues, qui ont eu des idées et qui m'ont motivé à
créer ce logiciel!
\
\




Licence\h#
\
Droit d'auteur 2015-2019  Dav999       (Je n'affirme pas la possession ou le droit
                                             d'auteur de VVVVVV ou d'aucune de ses
                                                                      ressources.)
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
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
