-- Language file for Ved
--- Language: fr (fr)
--- Last converted: 2026-04-11 00:49:31 (CEST)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n > 1) end

L = {

TRANSLATIONCREDIT = "", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Votre version de LÖVE est obsolète. Veuillez utiliser la version 0.9.1 ou ultérieure.\nVous pouvez télécharger la dernière version de LÖVE sur le site https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ne supporte plus LÖVE 0.9.0. Cependant, LÖVE 0.9.1 et toute version ultérieure seront supportées.\nVous pouvez télécharger la dernière version de LÖVE sur https://love2d.org/.",

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
NOFLAGSLEFT = "Il n'y a plus de drapeaux disponibles, donc au moins un nouveau nom de drapeau ne peut pas être associé à un numéro de drapeau. L'utilisation de ce script dans VVVVVV a des chances de le casser. Veuillez enlever toutes les références vers des drapeaux que vous n'utilisez plus et réessayez.",
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
SUREOPENLEVEL = "Vous avez des changements non sauvegardés. Voulez-vous sauvegarder ces changements avant d'ouvrir ce niveau ?",
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
COORDS_OUT_OF_RANGE = "Hein ? Ces coordonnées ne sont même pas dans cette dimension !",
UNKNOWNUNDOTYPE = "Type de retour en arrière \"$1\" inconnu !",
MDEVERSIONWARNING = "Ce niveau semble avoir été créé dans une version ultérieure de Ved, et peut contenir des données pouvant être perdues lorsque vous sauverez ce niveau.",
FORGOTPATH = "Vous avez oublié de spécifier un chemin !",
LIB_LOAD_ERRMSG = "Impossible de charger une bibliothèque essentielle. Veuillez renseigner Dav999 à propos de ce problème.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nEssayez d'installer GCC pour résoudre ce problème, s'il n'est pas déjà installé.",

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

BOUNDSFIRST = "Sélectionnez le premier coin de la zone", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Sélectionnez le second coin", -- Old string: Click the bottom right corner

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
INTERNALON_LONG = "Le mode de scripting interne est activé",
INTERNALOFF_LONG = "Le mode de scripting interne est désactivé",
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
BTN_ADVANCED = "Avancé",

BTN_AUTODETECT = "Détecter",
BTN_MANUALLY = "Mettre à jour", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Réessayer",

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
EDITWOBUMPING = "Modifier sans le monter en haut de la liste",
EDITWBUMPING = "Modifier et le monter en haut de la liste",
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

MAP_STYLE = "Style de carte",
MAP_STYLE_FULL = "Entier", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Minimap", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

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
FLIPSUBTOOLSCROLL = "Inverser la direction de défilement des outils",
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
MOUSESCROLLINGSPEED = "Vitesse de défilement de roulette de souris",
BUMPSCRIPTSBYDEFAULT = "Par défaut, monter le script en haut de la liste lors de leur édition",

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
SYNTAXCOLOR_WRONGLANG = "Commande simplifiée en mode int.sc ou vice-versa",
RESETCOLORS = "Remise à zéro des couleurs",
STRINGNOTFOUND = "\"$1\" n'a pas été trouvé",

-- L.MAL is concatenated with an error message
MAL = "Le fichier de niveau est mal formaté : ",

LOADSCRIPTMADE = "Script de chargement créé",
COPY = "Copier",
CUSTOMSIZE = "Taille de pinceau customisée : $1x$2",
SELECTINGA = "Sélection - coin haut gauche",
SELECTINGB = "Sélection : $1x$2",
TILESETSRELOADED = "Jeux de tuiles et images rechargées",

BACKUPS = "Sauvegardes",
BACKUPSOFLEVEL = "Sauvegardes du niveau $1",
LASTMODIFIEDTIME = "Dernière modification", -- List header
OVERWRITTENTIME = "Remplacé", -- List header
SAVEBACKUP = "Sauver dans le dossier de VVVVVV",
DATEFORMAT = "Format de date",
TIMEFORMAT = "Format d'heure",
SAVEBACKUPNOBACKUP = "Faites en sorte de choisir un nom unique pour ceci si vous ne voulez rien remplacer, car AUCUNE sauvegarde ne sera effectuée dans ce cas-ci !",

AUTOSAVECRASHLOGS = "Sauver les historiques de plantage automatiquement",
MOREINFO = "Dernières nouvelles",
COPYLINK = "Copier le lien",
SCRIPTDISPLAY = "Montrer",
SCRIPTDISPLAY_USED = "Utilisé",
SCRIPTDISPLAY_UNUSED = "Non utilisé",

RECENTLYOPENED = "Niveaux récemment ouverts",
REMOVERECENT = "Voulez-vous l'enlever de la liste des niveaux ouverts récemment ?",
RESETCUSTOMBRUSH = "(Clic droit pour donner une nouvelle taille)",

DISPLAYSETTINGS = "Affichage/\nÉchelle",
DISPLAYSETTINGSTITLE = "Options d'Affichage/Échelle",
SMALLERSCREEN = "Largeur de la fenêtre plus petite (800px au lieu de 896px)",
FORCESCALE = "Forcer les options d'échelle",
SCALENOFIT = "Les options d'échelle courantes rendent la fenêtre trop grande pour être affichée.",
SCALENONUM = "Les options d'échelle courantes sont invalides.",
MONITORSIZE = "Moniteur $1x$2",
VEDRES = "Résolution de Ved : $1x$2",
NONINTSCALE = "Échelonnage non entière",

USEFONTPNG = "Utiliser font.png du dossier d'images de VVVVVV comme police",
USELEVELFONTPNG = "Utiliser un font.png personnalisé par niveau comme police",
REQUIRESHIGHERLOVE = " (requiert LÖVE $1 ou version ultérieure)",
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
ASSETS_FOLDER_EXISTS_NO = "N'existe pas - cliquer pour le créer",
ASSETS_FOLDER_EXISTS_YES = "Existe - cliquer pour l'ouvrir",
NO_ASSETS_SUBFOLDER = "Pas de dossier \"$1\"",
LOAD = "Charger",
RELOAD = "Recharger",
UNLOAD = "Décharger",
MUSICEDITOR = "Editeur de musique",
LOADMUSICNAME = "Charger .vvv",
SAVEMUSICNAME = "Sauvegarder .vvv",
INSERTSONG = "Insérer une chanson dans la piste $1",
SUREDELETESONG = "Etes-vous sûr de vouloir supprimer la chanson $1 ?",
SONGOPENFAIL = "Impossible d'ouvrir $1, la chanson n'a pas été remplacée.",
SONGREPLACEFAIL = "Quelque chose s'est mal passé lors du remplacement de la chanson.",
BYTES = "$1 o",
KILOBYTES = "$1 ko",
MEGABYTES = "$1 Mo",
GIGABYTES = "$1 Go",
TERABYTES = "$1 To",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
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

UNSAVED_LEVEL_ASSETS_FOLDER = "Le niveau doit être sauvegardé avant qu'il puisse utiliser des ressources personnalisées.",
CREATE_ASSETS_FOLDER = "Voulez-vous créer un dossier de ressources personnalisées pour ce niveau?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "On dirait que le dossier de VVVVVV n'existe pas. Voulez-vous le créer ?",
CREATE_LEVELS_FOLDER = "On dirait que le dossier de niveaux n'existe pas. Voulez-vous le créer ?",
CREATE_FOLDER_FAIL = "Impossible de créer le dossier.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Dossier de ressources pour $1",

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
SOUNDNUM = "Son $1",
TRACKNUM = "Piste $1",
STOPSMUSIC = "Arrête la musique",
PLAYSOUND = "Jouer le son",
EDITSCRIPTWOBUMPING = "Modifier le script sans le monter en haut de la liste",
EDITSCRIPTWBUMPING = "Modifier le script et le monter en haut de la liste",
CLICKONTHING = "Clique sur $1",
ORDRAGDROP = "ou glisse et pose ici", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Il y a plus qu'un point de départ dans ce niveau !",
STARTPOINTNOTFOUND = "Il n'y a pas de point de départ !",

MAPBIGGERTHANSIZELIMIT = "La taille de la carte $1 par $2 est plus grande que $3 par $4!",
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
VVVVVV_EXITCODE_FAILURE = "VVVVVV s'est terminé avec comme code $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "On dirait que vous utilisez VVVVVV 2.2 ou une version antérieure. Veuillez mettre à jour vers VVVVVV 2.3 ou une version ultérieure.",
VVVVVV_SOMETHING_HAPPENED = "Quelque chose ne s'est pas bien passé avec VVVVVV.",
PLAYTESTUNAVAILABLE = "Désolé, vous ne pouvez pas être dans un test de jeu sur un $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Veuillez sélectionner le fichier nommé '$1'.",

PLAYTESTINGOPTIONS = "Test de jeu",
PLAYTESTING_EXECUTABLE_NOTSET = "Vous n'avez pas encore ajouté d'exécutable de $1 à utiliser pour le test de jeu.\nVed vous le demandera lors du premier test d'un niveau de $2.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "L'exécutable de $1 à utiliser pour les tests de jeu est :\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Désolé, quelque chose ne s'est pas bien passé en cherchant VVVVVV. Essayez de donner le chemin vers l'exécutable manuellement.",
FIND_V_EXE_FOUNDERROR = "Nous avons trouvé quelque chose ressemblant à VVVVVV, mais nous n'avons pas pu trouver un chemin vers son exécutable. Assurez-vous que vous n'utilisez pas une vieille version du jeu (2.3 ou ultérieur est requis) ou essayez de donner le chemin vers l'exécutable manuellement.",
FIND_V_EXE_NOTFOUND = "On dirait que VVVVVV n'est pas lancé. Assurez-vous que VVVVVV est ouvert et réessayez.",
FIND_V_EXE_MULTI = "Plusieurs instances différentes de VVVVVV ont été trouvées. Vérifiez qu'une seule version du jeu est ouverte et réessayez.",

FIND_V_EXE_EXPLANATION = "Ved a besion de VVVVVV pour tester le jeu, donc le chemin vers VVVVVV doit être donné en premier lieu.\n\n\nPour auto-détecter VVVVVV, veuillez simplement lancer lejeu s'il n'est pas déjà lancé et appuyez sur \"Détecter\".",

VCE_REMOVED = "VVVVVV: Community Edition n'est plus maintenu, et le support pour les niveaux de VVVVVV-CE a été supprimé de Ved. Ce niveau est traité comme un niveau de VVVVVV standard. Pour plus d'informations, allez sur https://vsix.dev/vce/status/",

VVVVVV_VERSION = "Version de VVVVVV", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Auto",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Tous les modules externes",
ALL_PLUGINS_MOREINFO = "Veuillez visiter ¤https://tolp.nl/ved/plugins.php¤cette page¤ pour plus d'informations sur les modules externes.\\nLCl",
ALL_PLUGINS_FOLDER = "Votre dossier de modules externes est :",
ALL_PLUGINS_NOPLUGINS = "Vous n'avez pas encore de module externe.",

PLUGIN_NOT_SUPPORTED = "[Ce module externe n'est pas supporté car il requiert Ved $1 ou une version ultérieure!]\\r",
PLUGIN_AUTHOR_VERSION = "par $1, version $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Créer un script de chargement",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Non",
CREATE_LOAD_SCRIPT_RUNONCE = "Unique",
CREATE_LOAD_SCRIPT_REPEATING = "Basique",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Ne pas créer de script de chargement",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Ce terminal va directement pointer vers le script.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Cette boîte de script va directement pointer vers le script.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Créer un script de chargement à ne lancer qu'une seule fois",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Ce terminal va pointer vers un nouveau script de chargement qui charge le vrai script une seule fois. Ved choisira un drapeau inutilisé.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Cette boîte de script va pointer vers un nouveau script de chargement qui charge le vrai script une seule fois. Ved choisira un drapeau inutilisé.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Créer un script de chargement répété",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Ce terminal va pointer vers un nouveau script de chargement qui charge le script réel sans condition.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Cette boîte de script va pointer vers un nouveau script de chargement qui charge le script réel sans condition.",

CUSTOM_SIZED_BRUSH = "Pinceau personnalisé",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Pinceau",
CUSTOM_SIZED_BRUSH_STAMP = "Tampon",
CUSTOM_SIZED_BRUSH_TILESET = "Jeu de tuiles",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Taille de pinceau personnalisée",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Choisissez la taille du pinceau dont vous avez besoin.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Tampon depuis la salle",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Sélectionne des tuiles de la salle pour créer un tampon.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Tampon depuis le jeu de tuiles",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Sélectionne des tuiles depuis le jeu de tuiles pour créer un tampon. Ne marche qu'en mode manuel.",

ADVANCED_LEVEL_OPTIONS = "Options de niveau avancées",
ONEWAYCOL_OVERRIDE = "Recolore aussi les tuiles à sens unique dans les ressources personnalisées (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Créer un ZIP de cette version à partager", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Sauvegarder le ZIP",
ZIP_BUSY_TITLE = "Créer un ZIP...",
ZIP_LOVE11_ONLY = "La création de ZIP requiert au moins LÖVE $1", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP sauvegardé !",
ZIP_SAVING_FAIL = "Le fichier ZIP n'a pas pu être sauvegardé !",

OPENFOLDER = "Ouvrir un dossier", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Police du niveau",

TEXTBOXCOLORS_BUTTON = "Couleurs du texte",
TEXTBOXCOLORS_TITLE = "Couleurs des boîtes de texte",
TEXTBOXCOLORS_RENAME = "Renommer la couleur \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Dupliquer la couleur \"$1\"",
TEXTBOXCOLORS_CREATE = "Ajouter une couleur",

LIB_LOAD_ERRMSG_BIDI = "Erreur de chargement de la bibliothèque pour le support de texte en lecture de droite à gauche.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nVotre antivirus pourrait en être la cause.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Vous avez $1 module qui n'est pas supporté dans cette version.",
		[1] = "Vous avez $1 modules qui ne sont pas supportés dans cette version.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Ce niveau a échoué $1 test. Le problème a peut-être été réparé automatiquement, mais il est possible que certains plantages et incohérences subsistent.",
		[1] = "Ce niveau a échoué $1 tests. Les problèmes ont peut-être été réparés automatiquement, mais il est possible que certains plantages et incohérences subsistent.",
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
		[0] = "La tuile $1 n'est pas un nombre entier supérieur ou égal à 0",
		[1] = "Les tuiles $1 ne sont pas des nombres entiers supérieurs ou égaux à 0",
	},
	BYTES = {
		[0] = "$1 octet",
		[1] = "$1 octets",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 image personnalisée",
		[1] = "$1 images personnalisées",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 effet sonore personnalisé",
		[1] = "$1 effets sonores personnalisés",
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
ERR_LOVEVERSION = "Version de LÖVE :"
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
ERR_CONTINUE = "Vous pouvez continuer en appuyant sur Echap ou Entrée, mais veuillez noter que cette modification erronée peut causer des problèmes."
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

