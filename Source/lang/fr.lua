-- Language file for Ved
--- Language: fr (fr)
--- Last converted: 2021-08-07 18:49:38 (CEST)

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
	if c == "à" or c == "â" then
		return "a"
	elseif c == "À" then
		return "A"
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

OSNOTRECOGNIZED = "Votre système d'exploitation ($1) n'est pas reconnu! Utilisation des valeurs par défaut des fonctions du système de fichiers; les niveaux sont stockés dans:\n\n$2",
MAXTRINKETS = "Le nombre maximum de médailles ($1) a été atteint dans ce niveau.",
MAXCREWMATES = "Le nombre maximum d'équipiers ($1) a été atteint dans ce niveau.",
UNSUPPORTEDTOOL = "Outil non supporté! Outil : ",
COULDNOTGETCONTENTSLEVELFOLDER = "Le contenu du dossier de niveaux n'a pas pu être récupéré. Veuillez vérifier si $1 existe et réessayez.",
MAPSAVEDAS = "L'image de la carte a été sauvegardée en tant que $1 !",
RAWENTITYPROPERTIES = "Vous pouvez changer les valeurs brutes des propriétés de cette entité ici.",
UNKNOWNENTITYTYPE = "Type d'entité $1 inconnu",
WARPTOKENENT404 = "Le jeton de téléportation n'existe plus !",
SPLITFAILED = "La séparation a misérablement échoué ! Avez-vous trop de lignes entre une commande texte et une commande speak ou speak_active ?", -- Command names are best left untranslated
NOFLAGSLEFT = "Il n'y a plus de drapeaux disponibles, donc au moins un nouveau nom de drapeau ne peut pas être associé à un numéro de drapeau. L'utilisation de ce script dans VVVVVV a des chances de le casser. Veuillez enlever toutes les références vers des drapeaux que vous n'utilisez plus et réessayez.\n\nQuitter l'éditeur ?",
NOFLAGSLEFT_LOADSCRIPT = "Il n'y a plus de drapeaux disponibles, donc un script de chargement utilisant un nouveau drapeau n'a pas pu être créé. A la place, un script de chargement qui charge le script cible avec iftrinkets(0,$1) a été créé. Veuillez enlever toutes les références vers des drapeaux que vous n'utilisez plus et réessayez.",
LEVELOPENFAIL = "Impossible d'ouvrir le fichier $1.vvvvvv.",
SIZELIMIT = "La taille maximum d'un niveau est de $1 par $2.\n\nA la place, la taille du niveau va être changée en $3 par $4.",
SCRIPTALREADYEXISTS = "Le script \"$1\" existe déjà !",
FLAGNAMENUMBERS = "Les noms de drapeaux ne peuvent pas être composés que de nombres.",
FLAGNAMECHARS = "Les noms de drapeaux ne peuvent pas contenir de virgules, de parenthèses ou d'espaces.",
FLAGNAMEINUSE = "Le nom de drapeau $1 est déjà utilisé par le drapeau $2",
DIFFSELECT = "Choisissez le niveau à comparer. Le niveau que vous sélectionnez sera considéré comme l'ancienne version.",
SUREQUITNEW = "Vous avez des changements non sauvegardés. Voulez-vous sauver ces changements avant de quitter ?",
SURENEWLEVELNEW = "Vous avez des changements non sauvegardés. Voulez-vous sauver ces changements avant de créer un nouveau niveau ?",
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
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Un script qui charge ce script n'a pas été détecté. Ce type de script interne ne fonctionnera probablement pas comme vous l'espérez s'il n'est pas chargé dans un autre script.",
INTSCRWARNING_BOXED = "Réf. directe à l'invite de commande du script !",
INTSCRWARNING_BOXED_EXPL = "Il y a un terminal ou une boîte de script qui charge ce script directement. L'activation de ce terminal ou de cette boîte de script ne fonctionnera probablement pas comme vous l'espérez; ce type de script interne doit être chargé à travers un script de chargement.",
INTSCRWARNING_NAME = "Nom de script incompatible !",
INTSCRWARNING_NAME_EXPL = "Le nom de script a une lettre capitale, un espace, une parenthèse ou une virgule. Ce script ne peut être chargé directement que par un terminal ou une boîte de script.",
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

LEVELSLIST = "Niveaux",
LOADTHISLEVEL = "Charger ce niveau : ",
ENTERNAMESAVE = "Entrer le nom utilisé pour la sauvegarde : ",
SEARCHFOR = "Chercher pour : ",

VERSIONERROR = "Impossible de vérifier la version.",
VERSIONUPTODATE = "Votre version de Ved est à jour.",
VERSIONOLD = "Mise à jour disponible! Dernière version : $1",
VERSIONCHECKING = "Recherche de mise à jour...",
VERSIONDISABLED = "Recherche de mise à jour désactivée",
VERSIONCHECKNOW = "Vérifier maintenant", -- Check for updates now

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
COPYROOMS = "Copier la salle",
SWAPROOMS = "Échanger les salles",

MAP_STYLE = "Map style",
MAP_STYLE_FULL = "Full", -- Max 12 characters
MAP_STYLE_MINIMAP = "Minimap", -- Max 12 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12 characters

FLAGS = "Drapeaux",
ROOM = "salle",
CONTENTFILLER = "Contenu",

FLAGUSED = "Utilisé    ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Non utilisé",
FLAGNONAME = "Aucun nom",
USEDOUTOFRANGEFLAGS = "Drapeaux hors limites utilisés :",

VVVVVVSETUP = "Installation de VVVVVV",
CUSTOMVVVVVVDIRECTORY = "Dossier de VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Le répertoire par défaut de VVVVVV que Ved attend est:\n$1\n\nCe chemin ne doit pas mener au dossier \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Vous n'avez pas donné de dossier VVVVVV personnalisé.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Votre dossier de VVVVVV est situé dans un chemin personnalisé:\n$1\n\n",
LANGUAGE = "Langue",
DIALOGANIMATIONS = "Animations de dialogue",
FLIPSUBTOOLSCROLL = "Flip tool scrolling direction",
ADJACENTROOMLINES = "Indicateurs de tuiles dans les salles adjacentes",
NEVERASKBEFOREQUIT = "Ne jamais demander avant de quitter, même s'il y a des modifications non sauvegardées",
COORDS0 = "Afficher les coordonnées en commençant à 0 (comme dans les scripts internes)",
ALLOWDEBUG = "Activer le mode de débogage",
SHOWFPS = "Afficher le compteur de FPS",
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
DUPLICATESCRIPT = "Le script $1 est un doublon! Il ne peut être chargé qu'une seule fois.",
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
SYNTAXCOLOR_COMMENT = "Commentaire",
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
SAVEMUSICNAME = "Save .vvv",
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
RESET = "Réinitialiser",
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

FRAMESTOSECONDS = "$1 = $2 sec",
ROOMNUM = "Salle $1",
TRACKNUM = "Piste $1",
STOPSMUSIC = "Arrête la musique",
EDITSCRIPTWOBUMPING = "Modifier le script sans réordonner la liste",
CLICKONTHING = "Clique sur $1",
ORDRAGDROP = "ou glisse et pose ici", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Il y a plus qu'un point de départ dans ce niveau !",
STARTPOINTNOTFOUND = "Il n'y a pas de point de départ!",

CONFIRMBIGGERSIZE = "Vous avez sélectionné $1 par $2, qui est une taille de carte plus grande que $3 par $4. En dehors de la carte normale de taille $3 par $4, les salles et les propriétés des salles reviennent au début de la liste, mais sont déformées. Vous n'aurez aucune nouvelle salle, ni aucune propriété de salle supplémentaire. VVVVVV peut aussi planter pour n'importe quelle raison dans n'importe laquelle de ces salles.\n\nAppuyez sur Oui seulement si vous êtes sûrs de ce que vous faites et si vous voulez cette taille de carte plus grande. Appuyez sur Non pour mettre la taille de la carte à $5 par $6.\n\nSi vous n'êtes pas sûrs, appuyez sur Non.",
MAPBIGGERTHANSIZELIMIT = "La taille de la carte $1 par $2 est plus grande que $3 par $4! (Le support d'une taille plus grande que $3 par $4 n'est pas activé)",
BTNOVERRIDE = "Mettre à jour",
TARGETPLATFORM = "Plateforme cible", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Contre la montre",
TIMETRIALTRINKETS = "Compte de médailles",
TIMETRIALTIME = "Temps visé",
SUREDELETETRIAL = "Êtes-vous sûr de vouloir supprimer le contre la montre \"$1\" ?",

CUT = "Couper",
PASTE = "Coller",
SELECTWORD = "Sélectionner un mot",
SELECTLINE = "Sélectionner une ligne",
SELECTALL = "Tout sélectionner",
INSERTRAWHEX = "Insérer un caractère Unicode",
MOVELINEUP = "Déplacer la ligne vers le haut",
MOVELINEDOWN = "Déplacer la ligne vers le bas",
DUPLICATELINE = "Dupliquer la ligne",

WHEREPLACEPLAYER = "Où voulez-vous commencer ?",
YOUAREPLAYTESTING = "Vous êtes dans un test de jeu",
LOCATEVVVVVV = "Selectionnez votre exécutable de $1", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Vous êtes déjà dans un test de jeu !",
PLAYTESTINGFAILED = "Une erreur inattendue est apparue lors du lancement de VVVVVV :\n$1\n\nSi vous devez changer l'exécutable de VVVVVV qui est utilisé lors du test de jeu, maintenez Maj en appuyant sur le bouton de test de jeu.",
PLAYTESTUNAVAILABLE = "Désolé, vous ne pouvez pas être dans un test de jeu sur un $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Veuillez sélectionner le fichier nommé '$1'.",
CHANGINGPATHAFTERASK = "Le chemin de VVVVVV a été changé après avoir lancé le jeu et n'est plus valide !",

PLAYTESTINGOPTIONS = "Test de jeu",
PLAYTESTING_EXECUTABLE_NOTSET = "Vous n'avez pas encore ajouté d'exécutable de $1 à utiliser pour le test de jeu.\nVed vous le demandera lors du premier test d'un niveau de $2.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "L'exécutable de $1 à utiliser pour les tests de jeu est :\n$2", -- $1: VVVVVV 2.3

VCE_DEPRECATED = "VVVVVV: Community Edition n'est plus maintenu. L'utiliser n'est pas recommandé, et le support pour les niveaux de VVVVVV-CE sera enlevé de Ved dans une version future.\n\nPour plus d'informations, allez sur https://vsix.dev/vce/status/",
VCE_REMOVED = "VVVVVV: Community Edition is no longer being maintained, and support for VVVVVV-CE levels has been removed from Ved. This level is treated like a regular VVVVVV level. For more information, see https://vsix.dev/vce/status/",

ALL_PLUGINS = "Tous les modules externes",
ALL_PLUGINS_MOREINFO = "Veuillez visiter ¤https://tolp.nl/ved/plugins.php¤cette page¤ pour plus d'informations sur les modules externes.\\nLCl",
ALL_PLUGINS_FOLDER = "Votre dossier de modules externes est :",
ALL_PLUGINS_NOPLUGINS = "Vous n'avez pas encore de module externe.",

PLUGIN_NOT_SUPPORTED = "[Ce module externe n'est pas supporté car il requiert Ved $1 ou une version ultérieure!]\\r",
PLUGIN_AUTHOR_VERSION = "par $1, version $2", -- by Person, version 1.0.0

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
		[0] = "Les métadonnées du niveau pour la salle $1,$2 a $3 propriété invalide !",
		[1] = "Les métadonnées du niveau pour la salle $1,$2 a $3 propriétés invalides !",
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
	LITERALNULLS = {
		[0] = "Il y a $1 octet null !",
		[1] = "Il y a $1 octets null !",
	},
	XMLNULLS = {
		[0] = "Il y a $1 caractère XML null !",
		[1] = "Il y a $1 caractères XML null !",
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
short5 = "Tour",
long5 = "Tour",

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
ERR_OPENPLUGINSFOLDER = "Vous pouvez ouvrir votre dossier de greffons en appuyant sur F, pour que vous puissiez réparer ou enlever le greffon défectueux. Après cela, relancez Ved."
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

Flags can be combined, like \rh or \hr for a red header
Invalid flags will be ignored

1234567890123456789012

Room for 82 characters on a line (85, but the last three characters will have a scrollbar if it is needed. 
----------------------------------------------------------------------------------[]-
]]

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
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
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

          Aussi appelé Mode Direct, dans ce mode vous pouvez placer n'importe 
          quel tuile manuellement, donc vous n'êtes pas limité par les différents
          groupes dans les jeux de tuiles, et les bords ne seront pas ajoutés
          automatiquement aux murs, vous donnant un contrôle complet sur l'aspect
          de la salle. Cependant, ce mode d'édition est plus lent à utiliser.
]]
},

{
splitid = "030_Tools",
subj = "Outils",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
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
en ¤gris¤. Veuillez noter que cet exemple a été un peu simplifié; Ved ajoute ¤#v\ngnw
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

Aide : vous pouvez laisser la touche ¤F9¤ enfoncée partout dans Ved pour voir\nC
beaucoup de ces raccourcis.

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
;¤  Afficher les tuiles de la minimap\C
Maj+;¤  Afficher le fond\C
M¤ ou ¤Numpad 5¤  Afficher la carte\CnC
G¤  Aller à la salle (entrer les coordonnées avec 4 chiffres)\C
/¤  Scripts\C
[¤  Bloquer la position Y de la souris tant qu'elle est appuyée\C
   (pour dessiner des lignes horizontales facilement)
]¤  Bloquer la position X de la souris tant qu'elle est appuyée\C
   (pour dessiner des lignes verticales facilement)
F11¤  Recharger les jeux de tuiles et images\C
Tab¤  Activer/Désactiver la gomme\C

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

N¤  Créer un nouveau script\C
F¤  Aller dans la liste de drapeaux\C
/¤  Aller dans le script tout en haut\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Référence script simple",
imgs = {},
cont = [[
Référence de création de script simple\wh#
\C=

Le langage de création d'un script simplifié de VVVVVV est un langage basique
qui peut être utilisé pour utiliser des scripts dans des niveaux VVVVVV.
Note: quand quelque chose est entre des guillemets, ceux-ci doivent être enlevés.


say¤([lignes[,couleur]] .. "]]" .. [[)\h#w

Affiche une boite de dialogue. Sans aucun argument, cette fonction créée une
boite de dialogue avec une seule ligne, et ressemblera à une boite de dialogue
centrée de terminal par défaut. L'argument couleur peut être une couleur ou le nom
d'un équipier.
Si vous utilisez une couleur et un équipier secourable de cette couleur est dans
la salle, alors la boite de dialogue sera affichée au dessus de cet équipier.

reply¤([lignes])\h#w

Affiche une boite de dialogue pour Viridian. Sans aucun argument, cette
fonction créée une boite de dialogue avec une seule ligne.

delay¤(n)\h#w

Retarde la prochaine action par n trames. 30 trames fait presque une seconde.

happy¤([équipier])\h#w

Rend un équipier heureux. Sans argument, cette fonction rendre Viridian heureux.
Vous pouvez aussi utiliser "all", "everyone" ou "everybody" comme argument pour
rendre tout le monde triste.

sad¤([équipier])\h#w

Rend un équipier triste. Sans argument, cette fonction rendre Viridian triste.
Vous pouvez aussi utiliser "all", "everyone" ou "everybody" comme argument pour
rendre tout le monde triste.

flag¤(drapeau,on/off)\h#w

Allume ou éteint un drapeau donné. Par exemple, flag(4,on) allumera le drapeau 4.
Il y a 100 drapeaux, numérotés de 0 à 99.
Par défaut, tous les drapeaux sont éteints quand on démarre un niveau.
Note: Dans Ved, vous pouvez aussi utiliser les noms de drapeaux au lieu de
nombres.

ifflag¤(drapeau,nom de script)\h#w

Si un drapeau donné est ALLUMÉ, exécuter le script ayant comme nom nom de script.
Si un drapeau donné est ÉTEINT, continuer dans ce script.
Exemple :
ifflag(20,cutscene) - Si le drapeau 20 est ALLUMÉ, exécuter le script "cutscene",
                      sinon on continue dans ce script.
Note: Dans Ved, vous pouvez aussi utiliser les noms de drapeaux au lieu de
nombres.

iftrinkets¤(nombre,nom de script)\h#w

Si votre nombre de médailles >= nombre, exécuter le script ayant pour nom nom de
script.
Si votre nombre de médailles < nombre, continuer dans ce script.
Exemple :
iftrinkets(3,enoughtrinkets) - Si vous avez 3 médailles ou plus, le script
                               "enoughtrinkets" sera exécuté, sinon ce script sera
                               continué.
Une pratique répandue est d'utiliser 0 comme nombre minimum de médailles afin de
charger un script dans tous les cas.

iftrinketsless¤(nombre,nom de script)\h#w

Si votre nombre de médailles < nombre, exécuter le script ayant pour nom nom de
script.
Si votre nombre de médailles >= nombre, continuer dans ce script.

destroy(objet)\h#w

Les arguments valides peuvent être :
warptokens : Supprime tous les jetons de téléportation de la salle jusqu'à que
vous y entrez une nouvelle fois.
warptokens : Supprime toutes les lignes de gravité de la salle jusqu'à que vous
y entrez une nouvelle fois.
L'option "platforms" existe aussi, mais elle ne marche pas correctement.

music¤(index)\h#w

Change la musique en une autre en utilisant l'index de la chanson.
Pour une liste d'index des chansons, veuillez vous référer à l'article "Référence
de listes".

playremix\h#w

Joue le remix de Predestined Fate en tant que chanson.

flash\h#w

Éclaire l'écran en blanc, émet un son de détonation et fait trembler l'écran pour
un court moment.

map¤(on/off)\h#w

Active (on) ou désactive (off) la carte. Si la carte est désactivée, elle
affichera "NO SIGNAL" jusqu'à ce qu'elle soit activée une nouvelle fois. Les
salles seront toujours découvertes pendant que la carte est désactivée et seront
visibles quand la carte sera activée.

squeak¤(équipier/on/off)\h#w

Fait couiner un équipier, ou active (on) / désactive (off) le couinement
lorsqu'une boite de dialogue est affichée.

speaker¤(couleur)\h#w

Change la couleur et la position des prochaines boites de dialogue créées avec la
commande "say". Cette commande peut être utilisée à la place de donner un second
argument à "say".

warpdir¤(x,y,dir)\w#h

Change la direction de téléportation de la salle x,y à la direction donnée, indexé
à 1. Peut être vérifié avec ifwarp, ce qui peut être utilisé comme un système de
drapeau/variable supplémentaire qui est relativement puissant.

x - Coordonnée x de la salle, commence à 1
y - Coordonnée y de la salle, commence à 1
dir - Direction de la téléportation. Normalement 0-3, mais les valeurs en dehors
de cette fourchette sont valides

ifwarp¤(x,y,dir,script)\w#h

Si la warpdir de la salle x,y (indexé à 1) est dir, lancer script (simplifié)

x - Coordonnée x de la salle, commence à 1
y - Coordonnée y de la salle, commence à 1
dir - Direction de la téléportation. Normalement 0-3, mais les valeurs en dehors
de cette fourchette sont valides
]]
},

{
splitid = "080_Int_script_reference",
subj = "Référence script interne",
imgs = {},
cont = [[
Référence de création de script interne\wh#
\C=

La création de script interne donne plus de pouvoir au scripteur, mais c'est
aussi un peu plus compliqué que la création de script simplifié.

Pour utiliser la création de script interne dans Ved, vous pouvez activer le
mode de création de script interne dans l'éditeur afin de gérer toutes les
commandes dans ce script en tant que commandes de script interne.

Codage de couleurs: \w
Normal - Devrait être sûr, dans le pire des cas VVVVVV va planter car vous avez
         fait une erreur.
Bleu¤   - Certaines de ces commandes ne marchent pas dans un niveau\b
         personnalisé, d'autres ne font aucun sens dans un niveau personnalisé,
         ou sont seulement à moitié utile car elles ont surtout été pensées pour
         le jeu principal.
Orange¤ - Celles-ci marchent et normalement rien ne devrait mal se passer, à\o
         moins que vous leur donnez des arguments spécifiques qui peuvent
         effacer votre sauvegarde.
Rouge¤  - Les commandes rouges ne doivent pas être utilisées dans un niveau\r
         personnalisé car elles vont soit débloquer certaines parties du jeu
         principal (ce qui n'est pas le genre de chose que vous voulez qu'un
         niveau personnalisé ne fasse, même si tout le monde a complété le
         jeu) ou complètement corrompre votre sauvegarde.


activateteleporter¤()\w#h

S'il y a un téléporteur dans la salle, il commencera à scintiller des couleurs
aléatoires et le toucher n'écrasera pas les données de sauvegarde.
Affecte seulement le premier téléporteur qui a été créé.

activeteleporter¤()\w#h

Rend le téléporteur de cette salle blanc, mais le toucher écrasera vos données
de sauvegarde. Cible seulement le premier téléporteur créé.

alarmoff\w#h

Désactive l'alarme

alarmon\w#h

Active l'alarme

altstates¤(x)\b#h

Change l'agencement de quelques salles, telles que la salle des médailles dans le
vaisseau ou l'entrée du laboratoire (les niveaux personnalisés ne supportent pas
du tout altstates)

backgroundtext\w#h

Si vous ajoutez cette commande au-dessus de speak ou speak_active, le jeu
n'attendra pas que vous appuyer sur la touche d'action après avoir créé la boite
de dialogue. Cette commande peut être utilisée pour afficher plusieurs boites de
dialogue en même temps.

befadein¤()\w#h

Affiche l'écran instantanément sans fondu après un appel à la
commande fadeout()

blackon¤()\w#h

Annule la commande blackout() et revient à la normale

blackout¤()\w#h

Rend l'écran noir / bloque l'écran

bluecontrol\b#h

Commence une conversation avec Victoria comme si vous venez de la
rencontrer dans le jeu principal et vous venez d'appuyer sur la touche
ENTREE. Créée aussi une zone d'activité après l'exécution.

changeai¤(équipier,ia1,ia2)\w#h

Change la direction dans laquelle l'équipier regarde ou son comportement
de marche

équipier - cyan/player/blue/red/yellow/green/purple

ia1 - followplayer/followpurple/followyellow/followred/followgreen/followblue
faceplayer/panic/faceleft/faceright/followposition,ia2
ia2 - Position X requise si followposition est utilisé pour ia1

changecolour¤(a,b)\w#h

Change la couleur d'un équipier (note: cette commande ne marque qu'avec les
équipiers créés via la commande createcrewman)

a - Couleur de l'équipier à changer cyan/player/blue/red/yellow/green/purple
b - Nouvelle couleur de l'équipier

changedir¤(couleur,direction)\w#h

Comme changeai(couleur,faceleft/faceright), cette fonction change la
direction du regard d'un équipier.

couleur - cyan/player/blue/red/yellow/green/purple
direction - 0 est gauche, 1 est droite

changegravity¤(equipier)\w#h

Augmente l'index d'image de l'équipier donné de 12.

equipier - Couleur de l'équipier à changer cyan/player/blue/red/yellow/green/purple

changemood¤(couleur,humeur)\w#h

Change l'humeur d'un équipier (marche seulement sur les équipiers créés
avec la commande createcrewman)

couleur - cyan/player/blue/red/yellow/green/purple
humeur - 0 pour heureux, 1 pour triste

changeplayercolour¤(couleur)\w#h

Change la couleur du joueur

couleur - cyan/player/blue/red/yellow/green/purple/teleporter

changetile¤(couleur,tuile)\w#h

Change la tuile d'un équipier (vous pouvez la changer en n'importe quelle image
dans sprites.png, et cette commande marche seulement sur les équipiers via
avec la commande createcrewman)

couleur - cyan/player/blue/red/yellow/green/purple/gray
tuile - Index de la tuile

clearteleportscript¤()\b#h

Supprime le script de téléportation instauré précédemment avec
teleportscript(x)

companion¤(x)\b#h

Force l'équipier spécifié en tant que compagnon (d'après mes souvenirs,
il me semble que cette commande dépend de la position sur la carte)

createactivityzone¤(couleur)\b#h

Créée une zone dans laquelle le joueur peut être qui dira "Press ACTION to
talk to (Équipier)"

createcrewman¤(x,y,couleur,humeur,ia1,ia2)\w#h

Créée un équipier (non secourable)

humeur - 0 pour heureux, 1 pour triste
ia1 - followplayer/followpurple/followyellow/followred/followgreen/followblue
faceplayer/panic/faceleft/faceright/followposition,ia2
ia2 - Position X requise si followposition est utilisé pour ia1

createentity¤(x,y,n,meta1,meta2)\o#h

Créée une entité, veuillez vous référencer à la référence de listes
pour les index d'entités

n - L'index d'entité

createlastrescued¤(x,y)\b#h

Créée le dernier équipier secouru à la position x,y (?)

createrescuedcrew¤()\b#h

Créée tous les équipiers secourus

customifflag¤(n,script)\w#h

Même comportement que ifflag(n,script) dans un script simplifié

customiftrinkets¤(n,script)\w#h

Même comportement que iftrinkets(n,script) dans un script simplifié

customiftrinketsless¤(n,script)\w#h

Même comportement que iftrinketsless(n,script) dans un script simplifié
(mais rappelez-vous que cette fonction ne marche pas)

custommap¤(on/off)\w#h

La variante interne de la commande map

customposition¤(x,y)\w#h

Remplace les valeurs x,y d'une commande de texte et par conséquent change la
position de la boite de dialogue, mais pour les équipiers, les équipiers à
secourir sont utilisés pour positionner la boite de dialogue à la place des
équipiers créés via la commande createcrewman.

x - center/centerx/centery, ou un nom de couleur
cyan/player/blue/red/yellow/green/purple (secourable)
y - Seulement utilisé si x est un nom de couleur. Peut prendre comme
valeur above (au-dessus)/below (au-dessous)

cutscene¤()\w#h

Affiche les barres de cinématique

delay¤(x)\w#h

Même comportement que la commande dans un script simplifié

destroy¤(x)\w#h

Même comportement que la commande dans un script simplifié

x - gravitylines/warptokens/platforms

do¤(n)\w#h

Commence une boucle de code qui va s'effectuer n fois. Finit le bloc avec
la commande de boucle.

endcutscene¤()\w#h

Fais disparaître les barres de cinématique

endtext\w#h

Force une boite de dialogue à disparaître (en fondu)

endtextfast\w#h

Force une boite de dialogue à disparaître immédiatement (sans fondu)

entersecretlab\r#h

Débloque le laboratoire secret pour le jeu principal, ce qui n'est
probablement pas quelque chose qu'un niveau personnalisé devrait
faire. Active le mode laboratoire secret.

everybodysad¤()\w#h

Rend tout le monde triste (marche seulement pour les équipiers créés avec la
commande createcrewman et le joueur)

face¤(a,b)\w#h

Force la tête d'un équipier a à regarder l'équipier b (fonctionne seulement pour
les équipiers créés via la commande createcrewman)

a - cyan/player/blue/red/yellow/green/purple/gray
b - pareil

fadein¤()\w#h

Affiche l'écran en fondu

fadeout¤()\w#h

Rend l'écran noir en fondu

finalmode¤(x,y)\b#h

Vous téléporte dans la Dimension Externe VVVVVV, (46,54) est la première
salle du dernier niveau

flag¤(x,on/off)\w#h

Même comportement que la commande dans un script simplifié

flash¤(x)\w#h

Rend l'écran blanc, vous pouvez changer le temps pendant lequel l'écran doit
être blanc (flash tout seul ne marchera pas, vous devez utiliser flash(5) avec
playef(9) et shake(20) si vous voulez un flash normal)

x - Le nombre de trames. 30 trames fait presque une seconde.

flip\w#h

Retourne le joueur

flipgravity¤(couleur)\w#h

Change la gravité d'un équipier (peut ne pas marcher sur le joueur)

couleur - cyan/player/blue/red/yellow/green/purple

flipme\w#h

Corrige la position verticale de plusieurs boites de dialogues en mode
inversé

foundlab\b#h

Jour l'effet sonore 3, affiche la boite de dialogue "Congratulations! You
have found the secret lab!" Cette commande ne finit pas le texte, et n'a
aucun autre effet indésirable.

foundlab2\b#h

Affiche la seconde boite de dialogue que vous pouvez voir après avoir
découvert le laboratoire secret. Cette commande ne finit pas non plus le
texte, et n'a aucun autre effet indésirable.

foundtrinket¤(x)\w#h

Force la récupération d'une médaille

x - Index de la médaille

gamemode¤(x)\b#h

teleporter pour afficher la carte, game pour la cacher (affiche les téléporteurs
du jeu principal)

x - teleporter/game

gamestate¤(x)\o#h

Change l'état de jeu à l'index d'état spécifié

gotoposition¤(x,y,f)\w#h

Change la position de Viridian à x,y dans cette salle, et f indique s'il est à
l'envers ou non (1 si à l'envers, 0 si à l'endroit)

f - 1 si à l'envers, 0 si à l'endroit. ATTENTION: Ne laissez pas ce paramètre
vide, sinon vous pouvez faire planter le jeu!

gotoroom¤(x,y)\w#h

Change la salle courante à x,y, avec x et y commençant à 0

x - Coordonnée x de la salle, commence à 0
y - Coordonnée y de la salle, commence à 0

greencontrol\b#h

Commence une conversation avec Verdigris comme si vous venez de le
rencontrer dans le jeu principal et vous venez d'appuyer sur la touche
ENTREE. Créée aussi une zone d'activité après l'exécution.

hascontrol¤()\w#h

Rend le contrôle au joueur, cependant cette commande ne marche pas au
milieu d'un script

hidecoordinates¤(x,y)\w#h

Cache les coordonnés x,y sur la carte (Cette commande marche sur la
carte d'un niveau personnalisé)

hideplayer¤()\w#h

Rend le joueur invisible

hidesecretlab\w#h

Cache le laboratoire secret sur la carte

hideship\w#h

Cache le vaisseau sur la carte

hidetargets¤()\b#h

Cache les cibles sur la carte

hideteleporters¤()\b#h

Cache les téléporteurs sur la carte

hidetrinkets¤()\b#h

Cache les médailles sur la carte

ifcrewlost¤(équipier,script)\b#h

Si l'équipier est manquant, exécuter le script donné

ifexplored¤(x,y,script)\w#h

Si la salle x+1,y+1 est explorée, exécuter le script (interne) script

ifflag¤(n,script)\b#h

Même comportement que customifflag mais charge un script interne
(du jeu principal)

iflast¤(équipier,script)\b#h

Si le dernier équipier secouru est x, exécuter le script script

équipier - Des index sont utilisés ici: 0: Viridian, 1: Violet, 2: Vitellary, 3:
Vermilion, 4: Verdigris, 5: Victoria

ifskip¤(x)\b#h

Si vous passez les cinématiques en Mode Sans Mort, exécuter le
script x

iftrinkets¤(n,script)\b#h

Même comportement que iftrinkets(n,script) dans un script simplifié,
mais exécute un script interne (du jeu principal)

iftrinketsless¤(n,script)\b#h

Même comportement que iftrinkets(n,script) dans un script simplifié,
mais exécute un script interne (du jeu principal)

ifwarp¤(x,y,dir,script)\w#h

Si la warpdir de la salle x,y (indexé à 1) est dir, lancer script (simplifié)

x - Coordonnée x de la salle, commence à 1
y - Coordonnée y de la salle, commence à 1
dir - Direction de la téléportation. Normalement 0-3, mais les valeurs en dehors
de cette fourchette sont valides

jukebox¤(x)\w#h

Rend un terminal jukebox blanc et désactive la couleur de tous les autres
terminaux (dans un niveau personnalisé, on dirait que cette commande
ne fait qu'enlever la couleur blanche de tous les terminaux actifs).

leavesecretlab¤()\b#h

Désactive le "Mode laboratoire secret"

loadscript¤(script)\b#h

Charge un script interne (du jeu principal). Souvent utilisé dans des niveaux
personnalisés en tant que loadscript(stop)

loop\w#h

Ajoutez cette commande à la fin d'une boucle de code commencée
avec la commande do.

missing¤(couleur)\b#h

Force la disparition d'un équipier

moveplayer¤(x,y)\w#h

Déplace le joueur x pixels à droite et y pixels en bas. Vous pouvez bien sûr
utiliser des valeurs négatives pour le déplacer en haut ou à gauche

musicfadein¤()\w#h

Une commande non terminée. Ne fait rien.

musicfadeout¤()\w#h

Termine la musique en fondu.

nocontrol¤()\w#h

Contraire de hascontrol()

play¤(x)\w#h

Joue la chanson ayant l'identifiant de chanson interne donné.

x - Index de chanson interne

playef¤(x,n)\w#h

Joue un effet sonore.

n - Actuellement non utilisé, et peut être omis. Dans VVVVVV 1.x, cet argument
permettait de contrôler le temps en millisecondes auquel le son devait
commencer.

position¤(x,y)\w#h

Écrase les valeurs x,y d'une commande de texte, fixant la position de la boite
de dialogue.

x - center/centerx/centery ou un nom de couleur
cyan/player/blue/red/yellow/green/purple
y - Seulement utilisé si x est un nom de couleur. Peut prendre comme
valeur above (au-dessus)/below (au-dessous)

purplecontrol\b#h

Commence une conversation avec Violet comme si vous venez de la
rencontrer dans le jeu principal et vous venez d'appuyer sur la touche
ENTREE. Créée aussi une zone d'activité après l'exécution.

redcontrol\b#h

Commence une conversation avec Vermilion comme si vous venez de le
rencontrer dans le jeu principal et vous venez d'appuyer sur la touche
ENTREE. Créée aussi une zone d'activité après l'exécution.

rescued¤(couleur)\b#h

Force la rescousse d'un équipier

resetgame\w#h

Réinitialise toutes les médailles, les équipiers collectés et les drapeaux, et
téléporte le joueur vers le dernier point de sauvegarde.

restoreplayercolour¤()\w#h

Restaure la couleur du joueur par défaut (cyan)

resumemusic¤()\w#h

Une commande non terminée. Lit dans de la mémoire non-initialisée, ce qui peut
planter le jeu sur certaines machines ou résulte à jouer Path Complete pour
d'autres.

rollcredits¤()\r#h

Affiche les crédits de fin. Cette commande détruit votre sauvegarde après
que les crédits de fin soient finis!

setcheckpoint¤()\w#h

Créée un point de sauvegarde à la position actuelle

shake¤(n)\w#h

Fait trembler l'écran pour n trames. Cette commande ne délayera pas
les commandes suivantes.

showcoordinates¤(x,y)\w#h

Montre les coordonnés x,y sur la carte (Cette commande marche pour la
carte d'un niveau personnalisé)

showplayer¤()\w#h

Rend le joueur visible

showsecretlab\w#h

Affiche le laboratoire secret sur la carte

showship\w#h

Affiche le vaisseau sur la carte

showtargets¤()\b#h

Affiche les cibles sur la carte (téléporteurs inconnus affichés en
tant que ?s)

showteleporters¤()\b#h

Affiche les téléporteurs sur la carte (Je suppose que cette commande affiche
seulement le téléporteur dans Space Station 1)

showtrinkets¤()\b#h

Affiche les médailles sur la carte

speak\w#h

Affiche une boite de dialogue sans enlever les anciennes. Pause aussi le script
jusqu'à ce que vous appuyez sur la touche d'action (à moins que la commande
backgroundtext soit au-dessus de celle-ci)

speak_active\w#h

Affiche une boite de dialogue, et supprime toute autre boite de dialogue. Pause
aussi le script jusqu'à ce que vous appuyez sur la touche d'action (à moins que
la commande backgroundtext soit au-dessus de celle-ci)

specialline¤(x)\b#h

Dialogue spéciaux qui n'apparaissent que dans le jeu principal

squeak¤(couleur)\w#h

Émet un couinement depuis un équipier, ou un son de terminal.

couleur - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\w#h

Fonctionne comme la commande finalmode(46,54), et téléporte le
joueur dans le dernier niveau sans argument. Plante le jeu en mode
chronométré.

stopmusic¤()\w#h

Arrête la musique immédiatement. Équivalent de music(0) dans un script simplifié.

teleportscript¤(script)\b#h

Utilisé pour déterminer quel script est utilisé lorsqu'un téléporteur est
utilisé

telesave¤()\r#h

Sauvegarde votre partie (dans la sauvegarde de téléporteur normale,
donc ne l'utilisez pas!)

text¤(couleur,x,y,lignes)\w#h

Sauvegarde une boite de dialogue en mémoire avec une couleur, une position
et un nombre de lignes. Normalement, la commande de position est utilisée
après la commande de texte (et ses lignes de texte), ce qui écrase les
coordonnées données ici, donc elles sont usuellement laissées à 0.

couleur - cyan/player/blue/red/yellow/green/purple/gray
x - La position x de la boite de dialogue
y - La position y de la boite de dialogue
lignes - Le nombre de lignes

textboxactive\w#h

Supprime toutes les boites de dialogue à l'écran sauf la dernière que vous
avez créée

tofloor\w#h

Force le joueur à inverser sa gravité vers le sol s'il est inversé.

trinketbluecontrol¤()\b#h

Dialogue de Victoria quand elle vous donne une médaille dans le jeu de base

trinketscriptmusic\w#h

Jour Passion for Exploring. Ne fait rien d'autre.

trinketyellowcontrol¤()\b#h

Dialogue de Vitellary quand il vous donne une médaille dans le jeu de base

undovvvvvvman¤()\w#h

Fait revenir le joueur à la normale

untilbars¤()\w#h

Attend que cutscene()/endcutscene() soit terminé

untilfade¤()\w#h

Attend que fadeout()/fadein() soit terminé

vvvvvvman¤()\w#h

Rend le joueur énorme

walk¤(direction,x)\w#h

Force le joueur à marcher pour un certain nombre de trames

direction - left (gauche) / right (droite)

warpdir¤(x,y,dir)\w#h

Change la direction de téléportation de la salle x,y à la direction donnée, indexé
à 1. Peut être vérifié avec ifwarp, ce qui peut être utilisé comme un système de
drapeau/variable supplémentaire qui est relativement puissant.

x - Coordonnée x de la salle, commence à 1
y - Coordonnée y de la salle, commence à 1
dir - Direction de la téléportation. Normalement 0-3, mais les valeurs en dehors
de cette fourchette sont valides

yellowcontrol\b#h

Commence une conversation avec Vitellary comme si vous venez de le
rencontrer dans le jeu principal et vous venez d'appuyer sur la touche
ENTREE. Créée aussi une zone d'activité après l'exécution.
]]
},

{
splitid = "090_Lists_reference",
subj = "Référence listes",
imgs = {},
cont = [[
Références des listes

Ce qui suit sont des listes d'index utilisés dans VVVVVV, en grande majorité
copiées depuis des postes de forums. Un grand merci à tout ceux qui ont
assemblé ces listes!


Index\w&Z+
\&Z+
#Index de musiques (script simplifié)\C&Z+l
#Index de musiques (script interne)\C&Z+l
#Index d'effets sonores\C&Z+l
#Entités\C&Z+l
#Couleurs pour les équipiers créés via createentity()\C&Z+l
#Type de mouvement des ennemis\C&Z+l
#États de jeu\C&Z+l


Index de musiques (script simplifié)\h#

0 - Silence (pas de musique)
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

Index de musiques (script externe)\h#

0 - Path Complete (niveau complété)
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
15 - Remix de Predestined Fate

Index d'effets sonores\h#

0 - Retourner vers le plafond
1 - Retourner vers le sol
2 - Pleur
3 - Médaille collectée
4 - Pièce collectée
5 - Point de sauvegarde touché
6 - Sable mouvant rapide touché
7 - Sable mouvant lent touché
8 - Ligne de gravité touchée
9 - Flash
10 - Téléportation
11 - Couinement de Viridian
12 - Couinement de Verdigris
13 - Couinement de Victoria
14 - Couinement de Vitellary
15 - Couinement de Violet
16 - Couinement de Vermilion
17 - Terminal touché
18 - Téléporteur touché
19 - Alarme
20 - Couinement de terminal
21 - Compte à rebours mode chronométré "3", "2", "1"
22 - Compte à rebours mode chronométré "Go!"
23 - VVVVVV Man cassant des murs
24 - Équipiers (dé)fusionnant en VVVVVV Man
25 - Nouveau record dans Super Gravitron
26 - Nouveau trophé dans Super Gravitron
27 - Équipier secouru (dans un niveau personnalisé)

Entités\h#

0 - Le joueur
1 - Ennemi
    Métadonnées: Type de mouvement, Vitesse de mouvement
    À cause du manque de données requises, vous ne serez capable de créer
    qu'une boite ennemie mauve, à moins que vous ne soyez dans la dimension
    polaire VVVVVV lorsque vous effectuez cette commande
2 - Plateforme mouvante
    Métadonnées: Type de mouvement, Vitesse de mouvement
    Veuillez noter que les tapis mouvants sont implémentés en tant que
    plateformes mouvantes, veuillez voir les types 8 et 9.
3 - Plateforme disparaissante
4 - Sables mouvants rapides de taille 1x1
5 - Un Viridian retourné, vous allez changer votre gravité si vous le touchez
6 - Truc rouge bizarre qui disparaît rapidement
7 - Pareil qu'au dessus, mais sans flash et coloré en cyan
8 - Une pièce du prototype
    Métadonnées: Index de pièce
9 - Médaille
    Métadonnées: Index de médaille
    Veuillez noter que les index de médaille commencent à 0 , et tout index
    supérieur à 19 ne sera pas sauvegardé lorsque le niveau est relancé
10 - Point de sauvegarde
     Métadonnées: État du point de sauvegarde (0=inversé, 1=normal), Index de
     point de sauvegarde (teste si le point de sauvegarde est actif ou non)
11 - Ligne de gravité horizontale
     Métadonnées: Longueur en pixels
12 - Ligne de gravité horizontale
     Métadonnées: Longueur en pixels
13 - Jeton de téléportation
     Métadonnées: Tuile de destination en axe X, Tuile de destination en axe Y
14 - Téléporteur circulaire
     Métadonnées: Index de point de sauvegarde (?)
15 - Verdigris
     Métadonnées: État de l'IA
16 - Vitellary (inversé)
     Métadonnées: État de l'IA
17 - Victoria
     Métadonnées: État de l'IA
18 - Équipier
     Métadonnées: Couleur (en utilisant la liste de couleurs brute, pas la liste
     de couleurs d'équipiers), Humeur
19 - Vermilion
     Métadonnées: État de l'IA
20 - Terminal
     Métadonnées: Image, Index de script (?)
21 - Pareil qu'au dessus mais quand le terminal est touché il ne se s'allume pas
     Métadonnées: Image, Index de script (?)
22 - Médaille collectée
     Métadonnées: Index de médaille
23 - Carré de Gravitron
     Métadonnées: Direction
     Si la position X est négative (ou trop haute), une flèche apparaîtra à la
     place, comme dans le vrai Gravitron.
24 - Équipier de l'intermission 1
     Métadonnées: Couleur brute, Humeur
     N'a pas l'air d'être affecté par des dangers, mais devrait l'être.
25 - Trophée
     Métadonnées: Identifiant de défi, Image
     Si le défi est complété, l'index de l'image de base (ce que vous avez si vous
     utilisez image=0) changera. Si vous voulez des résultats prédictibles,
     utilisez seulement 0 ou 1. (0=normal, 1=inversé)
26 - Le jeton de téléportation vers le Laboratoire Secret
     Veuillez noter que ce jeton de téléportation est implémenté en tant qu'une
     jolie image. Vous devrez programmer son fonctionnement vous-même.
55 - Équipier secourable
     Métadonnées: Couleur d'équipier. Toute couleur>6 affichera un Viridian
     *heureux*.
56 - Ennemi de niveau personnalisé
     Métadonnées: Type de mouvement, Vitesse de mouvement
     Gardez en esprit que s'il n'y a aucun ennemi dans la salle, les données de
     l'image de l'ennemi ne sont pas mises à jour correctement et cette entité
     affichera l'image du dernier ennemi rencontré en dernier ou un ennemi carré.
Les entités indéfinies (27-50, 57+) donne des Viridians bogués.

Couleurs pour les équipiers créés via\h#

createntity()\h

0: Cyan
1: Rouge scintillant (utilisé pour l'animation de mort)
2: Orange foncé
3: Couleur de médaille
4: Gris
5: Blanc scintillant
6: Rouge (un peu plus foncé que Vermilion)
7: Vert citron
8: Rose fluo
9: Jaune éclatant
10: Blanc scintillant
11: Cyan clair
12: Bleu, même couleur que Victoria
13: Vert, même couleur que Verdigris
14: Jaune, même couleur que Vitellary
15: Rouge, même couleur que Vermilion
16: Bleu, même couleur que Victoria
17: Orange plus clair
18: Gris
19: Gris plus foncé
20: Rose, même couleur que Violet
21: Gris plus clair
22: Blanc
23: Blanc scintillant
24-29: Blanc
30: Gris
31: Gris foncé avec une pointe de pourpre?
32: Cyan/Vert foncé
33: Bleu foncé
34: Vert foncé
35: Rouge foncé
36: Orange terne
37: Gris scintillant
38: Gris
39: Cyan/Vert encore plus foncé
40: Gris encore plus scintillant
41-99: Blanc
100: Gris foncé
101: Blanc scintillant
102: Couleur de téléporteur
103 et au-delà: Blanc

Types de mouvement d'ennemis\h#

0 - Rebondit de haut en bas, commence en bas.
1 - Rebondit de haut en bas, commence en haut.
2 - Rebondit de gauche à droite, commence à gauche.
3 - Rebondit de gauche à droite, commence à droite.
4, 7, 11 - Se dirige vers la droite jusqu'à collision.
5 - Pareil qu'au dessus sauf qu'il agit bizarrement lors de la collision.
    En voici un GIF : ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Rebondit de haut en bas, mais rebondit en bas après avoir atteint une certaine
    position y. Utilisé dans la salle "Trench warfare".
8, 9 - Pour des plateformes mobiles, devient un tapis roulant, sinon reste
       immobile.
14 - Peut être bloqué par des plateformes disparaissantes.
15 - Immobile (?)
10, 12 - Se clone à droite/au même endroit, plante VVVVVV si ça devient trop
         intense, et corrompra votre niveau si vous sauvegardez.
13 - Comme 4 sauf que le mouvement est vers le bas.
16 - Apparaît et disparaît en boucle.
17 - Mouvement fébrile vers la gauche.
18 - Mouvement fébrile vers la droite un peu plus rapide.
19+ - Immobile (?)

États de jeu\h#

0 - Permet de sortir de la plupart des états de jeux
1 - Change l'état de jeu à 0 (pareil qu'au dessus en pratique)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Lance le script "returntohub" (cache l'écran en fondu, téléportation juste
    avant The Tower, affiche l'écran en fondu, joue Passion for Exploring)
7 - Enlève les boîtes de dialogue
8 - "Press enter to view map and quicksave"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Tente d'accéder au test
     du mode inversé pour entrer "the ceiling" ou "the floor", et teste
     l'équipier, mais comme ce test échoue, la phrase du dessus est affichée à la
     place)
12 - "You can't continue to the next room until he is safely accross."
13 - Enlève les boîtes de dialogue rapidement
14 - "When you're standing on the floor," (Même cas que 11)
15 - Rend Viridian heureux
16 - Rend Viridian triste
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - Si le drapeau 1 est 0, met le drapeau 1 à 1 et enlève les boîtes de dialogue
21 - Si le drapeau 2 est 0, met le drapeau 2 à 1 et enlève les boîtes de dialogue
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - Cinématique "Violet, is that you?" (tant que le drapeau 6 est 0)
32 - Si le drapeau 7 est 0 : "A teleporter!" "I can get back to the ship with
     this!"
33 - Si le drapeau 9 est 0 : Cinématique de Victoria
34 - Si le drapeau 10 est 0 : Cinématique de Vitellary
35 - Si le drapeau 11 est 0 : Cinématique de Verdigris
36 - Si le drapeau 8 est 0 : Cinématique de Vermilion
37 - Vitellary après le Gravitron
38 - Vermilion après le Gravitron
39 - Verdigris après le Gravitron
40 - Victoria après le Gravitron
41 - Si le drapeau 60 est 0 : Lance le début de la cinématique de l'intermission 1
42 - Si le drapeau 62 est 0 : Lance la 3ème cinématique de l'intermission 1
43 - Si le drapeau 63 est 0 : Lance la 4ème cinématique de l'intermission 1
44 - Si le drapeau 64 est 0 : Lance la 5ème cinématique de l'intermission 1
45 - Si le drapeau 65 est 0 : Lance la 6ème cinématique de l'intermission 1
46 - Si le drapeau 66 est 0 : Lance la 7ème cinématique de l'intermission 1
47 - Si le drapeau 69 est 0 : Cinématique de médaille "Ohh! I wonder what that
     is?"
48 - Si le drapeau 70 est 0 : "This seems like a good place to store anything I
     find out there..." (Victoria pas encore trouvé)
49 - Si le drapeau 71 est 0 : Joue Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
Avec les états de jeu 50-56, vous pouvez choisir quand commencer, car tous les
messages se suivent les uns après les autres
80 - Seulement si l'écran est noir, continue vers l'état de jeu 81 (A mon avis,
     cet état est appelé quand la touche ESC est appuyée, avant que le menu de
     pause s'ouvre)
81 - Retourne vers le menu principal
82 - Résultats de la course contre la montre (bogué)
83 - Si l'écran est noir, continue vers l'état de jeu 84
84 - Résultats de la course contre la montre (Je pense que 82 marche mieux que 84)
85 - La version de course contre la montre de l'état de jeu 200 (Flash, joue
     Positive Force, active le mode final)
Les états 90-95 sont liés à la course contre la montre, mais ne marchent pas
correctement dans un niveau personnalisé. Les seuls effets visibles sont une
téléportation et un changement de musique
90 - Space Station 1
91 - The Laboratory
92 - Warp Zone
93 - The Tower
94 - Space Station 2
95 - Final Level
96 - Si l'écran est noir, continue vers l'état 97
97 - Sortie de Super Gravitron (téléportation et joue Pipe Dream)
100 - Si le drapeau 4 est 0 : continue vers l'état 101
101 - Si vous êtes inversés, retourne le joueur vers le sol, continue vers l'état
      102
Les états suivants (102-112) tentent d'aller au prochain état, comme 50-56 (mais
      ceux-ci ne reviennent pas au début), mais cela peut boguer car la moitié des
      états (103, 105, 107, 109, 111) n'existent pas.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Enlève les boîtes de dialogue
115 - Ne fait pas grand chose, continue vers l'état 116
116 - Dialogue en rouge en bas de l'écran affichant "Sorry Eurogamers! Teleporting
      around the map doesn't work in this version!", continue vers l'état 117, qui
      n'existe pas, donc ça peut échouer
118 - Enlève les boîtes de dialogue
Les états 120-128 marchent un peu comme 102-112, comme une suite, mais avec moins
      de trucs cassés
120 - Si le drapeau 5 est 0 : continue vers l'état 121
121 - Si vous êtes sur le sol, retourne le joueur.
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yay! Let's go home!"
132 - Enlève les boîtes de dialogue
200 - Mode final
1000 - Active les barres de cinématique, gèle le jeu, continue vers l'état 1001
1001 - Dialogue "You got a shiny trinket!" (mais vous n'en avez reçu aucun, c'est
       juste appelé à chaque fois que vous en collectez une), continue vers l'état
       1003
1003 - Remet le jeu à la normale
1010 - "You found a crewmate!" de la même façon que pour les médailles
1013 - End level with stars
2000 - Sauvegarde le jeu
2500-2509 - Téléporte le joueur vers des coordonnées bizarres non-existantes,
            supposément The Laboratory, continue vers l'état 2510
2510 - Viridian: "Hello?", continue vers l'état 2512
2512 - Viridian: "Is anybody there?", continue vers l'état 2514
2514 - Enlève les boîtes de dialogue, joue Potential For Anything
États 3000-3099:
3000-3005 - "Level Complete! You've rescued" l'équipier appliqué à companion(),
            avec Verdigris comme valeur par défaut. 6=Verdigris, 7=Vitellary,
            8=Victoria, 9=Vermilion, 10=Viridian (oui, pour de vrai), 11=Violet
            (États de jeu: 3006-3011=Verdigris, 3020-3026=Vitellary, 
            3040-3046=Victoria, 3060-3066=Vermilion, 3080-3086=Viridian,
            3050-3056=Violet)
3070-3072 - Applique des actions après rescousse, dans la plupart des cas, vous
            renvoie vers le vaisseau
3501 - Game Complete
4010 - Flash + téléportation
4070 - The Final Level, mais le jeu plantera quand vous atteignez Timeslip (A
       cause de la façon dont le jeu récupère des informations sur les entités,
       qui est cassée dans un niveau personnalisé)
4080 - Le capitaine est téléporté dans le vaisseau : cinématique "Hello!"
       [C[C[C[C[Captain!] + crédits.
       L'état du dessus va gâcher votre sauvegarde donc ne le faites pas à moins
       que vous ayez effectué une copie de votre sauvegarde!
4090 - Cinématique après avoir complété Space Station 1
]]
},

{
splitid = "100_Formatting",
subj = "Mise en forme",
imgs = {},
cont = [[
Mise en forme\wh#
\C=

Dans les notes, vous pouvez utiliser des codes de mise en forme pour rendre
votre texte plus grand, le colorer, et quelques autres choses. Pour ajouter de la
mise en forme à une ligne, ajoutez un antislash (\) à la fin de celle-ci. Après\
le \, vous pouvez ajouter n'importe quel nombre de caractères suivants, dans\
n'importe quel ordre:

h - Double la taille de la police\h

# - Ancre. Vous pouvez sauter vers des ancres rapidement avec
des ¤#Liens¤liens¤.\nLCl
- - Ligne horizontale :
\-
= - Ligne horizontale sous un texte large

Couleurs de texte :\h#

n - Normal\n
r - Rouge\r
g - Gris\g
w - Blanc\w
b - Bleu\b
o - Orange\o
v - Vert\v
c - Cyan\c
y - Jaune\y
p - Violet\p
V - Vert foncé\V
z - Noir¤ (couleur d'arrière-plan non incluse)\z&Z
Z - Gris foncé\Z
C - Cyan (Viridian)\C
P - Rose (Violet)\P
Y - Jaune (Vitellary)\Y
R - Rouge (Vermilion)\R
G - Vert (Verdigris)\G
B - Bleu (Victoria)\B


Exemple :\h#

\-
Large texte orange ("oh" a le même\ho\
\
résultat)\ho\
\
Large texte orange ("oh" a le même\ho
\
résultat)\ho

\-
Texte large souligné\wh\
\r=\
\
Texte large souligné\wh
\r=
\-

Utiliser plusieurs couleurs sur une ligne\h#

Il est possible d'utiliser plusieurs couleurs sur une ligne en séparant les
parties colorés avec le caractère¤ ¤¤ ¤(qui est normalement disponible en appuyant\nYn
sur ¤Alt Gr + $¤), et ajoutez les codes couleurs dans l'ordre après¤ \¤. Si la\nwnC
dernière couleur de la ligne est la couleur par défaut(n), il n'est pas nécessaire
de l'ajouter à la fin. Si vous voulez utiliser le caractère¤ ¤¤ ¤sur une ligne\nY
qui utilise¤ \¤, écrivez¤ ¤¤¤¤ ¤à la place. Pour des raisons techniques, il n'est p¤a§¤s\nCnYnR(
possible de colorier un caractère simple en l'entourant avec deux¤ ¤¤§¤, à moins que\nY(
vous n'incluez un espace ou un autre caractère.

\-
Vous pouvez ¤¤colorier¤¤ des ¤¤mots¤¤ spécifiques avec ça!\nrnv\
\
Vous pouvez ¤colorier¤ des ¤mots¤ spécifiques avec ça!\nrnv
\-
Quelques ¤¤cou¤¤leurs¤¤ de ¤¤tex¤¤te\RYGCBP\
\
Quelques ¤cou¤leurs¤ de ¤tex¤te\RYGCBP
\-

Colorier un seul caractère\h#

D'accord, j'ai menti, il est possible de colorier un seul caractère sans ajouter
un espace. Pour ce faire, ajoutez le caractère¤ § ¤(que vous pouvez entrer en\nY
appuyant sur ¤Maj + !¤) après le caractère que vous voulez colorer, et activez\nC
le avec le code de mise en forme¤ ( ¤après¤ \¤ :\nC

\-
Vous pouvez c¤¤o§¤¤lorer un ¤¤seul¤¤ caractère comme ça!\nrny(\
\
Vous pouvez c¤o§¤lorer un ¤seul¤ caractère comme ça!\nrny(
\-

Ceci n'est pas nécessaire si le caractère simple est le premier ou
dernier de la ligne.

Couleurs d'arrière-plan\h#

Non seulement le texte peut être coloré, mais il peut être ¤mis en avant¤ avec\nZ&y
n'importe quelle couleur de texte. Pour ce faire, vous pouvez mettre¤ & ¤après le\nY
code couleur du texte normal, puis un code couleur pour l'arrière-plan. Cela peut
être combiné avec le système de ¤ décrit plus tôt, veuillez noter que les couleurs
de texte normales commencent le prochain "bloc", mais les couleurs d'arrière-plan
ne le font pas. Les exemples suivants utilisent des espaces pour améliorer la
lisibilité, mais c'est complètement optionnel. Vous pouvez utiliser le code¤ + ¤pour\nY
étendre la (dernière) couleur d'arrière-plan jusqu'à la fin de la ligne.

\-
Texte noir sur arrière-plan blanc!\z&w\
\
Texte noir sur arrière-plan blanc!\z&w
\-
Texte noir sur arrière-plan blanc étendu!\z&w+\
\
Texte noir sur arrière-plan blanc étendu!\z&w+
\-
Rouge sur jaune¤¤, ¤¤Noir sur blanc¤¤ (les espaces optionnels augmentent la
lisibilité)\r&y n z&w\
\
Rouge sur jaune¤, ¤Noir sur blanc¤ (les espaces optionnels augmentent la lisibilité)\r&y n z&w
\-
Ceci ¤¤marche¤¤ toujours pour colorer un s¤¤e§¤¤ul caractère\n P n n&r (\
\
Ceci ¤marche¤ toujours pour colorer un s¤e§¤ul caractère\n P n n&r (
\-

Si vous voulez, vous pouvez aussi créer des graphismes en utilisant les
couleurs d'arrière-plan :

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

Liens\h#

Les liens ont deux utilités : lier autre part dans les articles/notes, ou lier 
vers un site Internet. Les liens utilisent le demi-couleur code¤ l¤. Ce code ne\nY 
change pas vers le prochain "bloc coloré" mais s'applique au bloc courant, 
contrairement aux codes couleurs normaux (pas d'arrière-plan). Il ne change pas 
non plus la couleur, donc vous pouvez changer le style du lien tel que vous le 
voulez.

Vous pouvez lier à des articles en utilisant simplement le même
nom que l'article :

\-
Outils\bl\
\
Outils\bl
\-

Cliquer sur "Outils" au-dessus vous renverra à la page d'aide sur les outils.
J'ai ici utilisé le code couleur¤ b ¤pour rendre le lien bleu, et comme vous pouvez\nb
le voir, le¤ l ¤s'applique sur la même partie colorée de ce texte.\nY

Vous pouvez lier à des ancres dans le même article en liant à un¤ # ¤suivi de\nY
tout le texte de cette ligne. (Les instances de¤ ¤¤ ¤sont complètement ignorées ici.)\nY
Vous pouvez lier en haut de l'article juste avec un simple caractère dièse (¤#§¤).\nY(

\-
#Utiliser plusieurs couleurs sur une ligne\bl\
\
#Utiliser plusieurs couleurs sur une ligne\bl
\-

Vous pouvez lier à une ancre dans un article différent d'une façon
similaire :

\-
Référence de listes#États de jeu\bl\
\
Référence de listes#États de jeu\bl
\-

Lier à des sites Internet est aussi simple :

\-
https://example.com/\bl\
\
https://example.com/\bl
\-

Vous pouvez utiliser un bloc de couleur ayant comme code couleur¤ L ¤qui contient\nY
la vraie destination avec le texte du lien, et afficher un texte différent pour ce
lien de cette façon :

\-
Outils¤¤Aller dans un autre article\Lbl\
\
Outils¤Aller dans un autre article\Lbl
\-
Cliquez ¤¤Outils¤¤ici¤¤ pour aller dans un autre article\nLbl\
\
Cliquez ¤Outils¤ici¤ pour aller dans un autre article\nLbl
\-
[¤¤#Liens¤¤Aimer¤¤] [¤¤#Exemple :¤¤Ne pas aimer¤¤]\n L vl n L rl\
\
[¤#Liens¤Aimer¤] [¤#Exemple :¤Ne pas aimer¤]\n L vl n L rl
\-
#Liens¤¤ Bouton A ¤¤ §¤¤#Liens¤¤ Bouton B \L w&Zl n L w&Z l(\
\
#Liens¤ Bouton A ¤ §¤#Liens¤ Bouton B \L w&Zl n L w&Z l(
\-

Images (seulement disponible dans la\h#
\
description des greffons) :\h

0..9 - Affiche l'image 0..9 sur cette ligne (l'index de la table des images
       commence à 0, et n'oubliez pas de garder des lignes vides pour vous 
       accommoder à la hauteur de l'image)
^ - Mettez ceci avant le nombre de l'image pour augmenter le nombre de l'image
    de 10. Donc ^4 donne l'image 14, ^^4 donne l'image 24, et 3^1^56 donne les 
    images 3, 11, 25 et 26.
_ - Mettez ceci avant le nombre de l'image pour réduire le nombre de l'image 
    de 10.
> - Mettez ceci avant le nombre de l'image pour décaler les prochaines images de
    8 pixels vers la droite. Ceci peut être répété, ainsi 0>>>>1 met l'image 0 à 
    x = 0 et l'image 1 à x = 32.
< - Pareil, mais décale les images vers la gauche.
]]
},

{
splitid = "990_Credits",
subj = "Remerciements",
imgs = {"images/credits.png"},
cont = [[
\0















Remerciements\wh#
\C=

Ved a été créé par Dav999

Autres contributeurs de code: Info Teddy

Quelques graphismes et la police ont été créés par Hejmstel

Traduction russe : CreepiX, Cheep, Omegaplex
Traduction esperanto : Hejmstel
Traduction allemande : r00ster
Traduction française : RhenaudTheLukark
Traduction espagnole : Valso22/naether


Remerciements spéciaux à :\h#


Terry Cavanagh pour avoir créé VVVVVV

Tous ceux qui ont signalé des bogues, qui ont eu des idées et qui m'ont motivé à
créer ce logiciel!
\
\



Licence\h#
\
Droit d'auteur 2015-2021  Dav999
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

Ressources de VVVVVV\h#

Ved inclut des ressources graphiques de VVVVVV. VVVVVV et ses ressources sont un
copyright de Terry Cavanagh. Pour plus d'nformations à propos de la licence qui
s'applique à VVVVVV et à ses ressources, voir ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ et ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md\nLCInLCI
dans ¤https://github.com/TerryCavanagh/VVVVVV¤le GitHub de VVVVVV\nLCl
https://github.com/TerryCavanagh/VVVVVV¤répertoire¤.\LCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
