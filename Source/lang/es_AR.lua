-- Language file for Ved
--- Language: es_AR (es_AR)
--- Last converted: 2026-04-11 03:53:20 (CEST)

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

TRANSLATIONCREDIT = "Traduccion por Valso22 (XxTheProTx9999Xx, naether)", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OSNOTRECOGNIZED = "Su sistema operativo ($1) no es reconocido! De nuevo a las funciones filesystem por defecto; los niveles se guardan en:\n\n$2",
MAXTRINKETS = "La cantidad maxima de trinkets ($1) ha sido alcanzada en este nivel.",
MAXCREWMATES = "La cantidad maxima de compañeros ($1) ha sido alcanzada en este nivel.",
UNSUPPORTEDTOOL = "Herramienta no soportada! Herramienta: ",
COULDNOTGETCONTENTSLEVELFOLDER = "No se pudo obtener contenidos de la carpeta de niveles. Porfavor fijese si $1 existe y intente de nuevo.",
MAPSAVEDAS = "Imagen de mapa guardada como $1!",
RAWENTITYPROPERTIES = "Puedes cambiar las propiedades crudas de esta entidad aqui.",
UNKNOWNENTITYTYPE = "Tipo de entidad desconocida $1",
WARPTOKENENT404 = "La entidad de warp token no existe!",
SPLITFAILED = "Division fallada miserablemente! Tienes muchas lineas en medio de un comando de texto y un speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "No quedan mas flags, asi que una o mas flags con nombres en este script no se puede asociar con cualquier numero de flag. Intentar ejecutar este script en VVVVVV podria romperlo. Considere remover todas las referencias a flags que no necesites mas y intente otra vez.",
NOFLAGSLEFT_LOADSCRIPT = "No quedan mas flags, asi que un script de carga usando un flag nuevo no se puede crear. En vez de eso, un script de carga que se ha creado que siempre carga el script tarjeta con iftrinkets(0,$1). considere remover todas las referencias a flags que no necesites mas y intente otra vez.",
LEVELOPENFAIL = "No se puede abrir $1.vvvvvv.",
SIZELIMIT = "El tamaño maximo de un nivel es de $1 por $2.\n\nEl tamaño del nivel se cambiara a $3 por $4.",
SCRIPTALREADYEXISTS = "El script \"$1\" ya existe!",
FLAGNAMENUMBERS = "Los nombres de flags no puede ser solo numeros.",
FLAGNAMECHARS = "Los nombres de flags no pueden contener parentesis, comas, o espacios.",
FLAGNAMEINUSE = "El nombre del flag $1 ya esta en uso por el flag $2",
DIFFSELECT = "Seleccione el nivel al que quieres compararlo. Ese nivel se tratara como una version mas vieja.",
SUREQUITNEW = "Tienes cambios sin guardar. Quieres guardar esos cambios antes de salir?",
SURENEWLEVELNEW = "Tienes cambios sin guardar. Quieres guardar esos cambios antes de crear un nuevo nivel?",
SUREOPENLEVEL = "You have unsaved changes. Do you want to save these changes before opening this level?",
NAMEFORFLAG = "Nombre para flag $1:",
SCRIPT404 = "El script \"$1\" no existe!",
ENTITY404 = "La entidad #$1 no existe!",
GRAPHICSCARDCANVAS = "Lo siento, parece que tu carta grafica o driver no soporta esta caracteristica!",
MAXTEXTURESIZE = "Lo siento, crear una imagen de $1x$2 no parece ser soportada por tu carta grafica o driver.\n\nEl limite de tamaño en este sistema es $3x$3",
SUREDELETESCRIPT = "Estas seguro de que quieres borrar el script \"$1\"?",
SUREDELETENOTE = "Estas seguro de que quieres borrar esta nota?",
THREADERROR = "Error de cadena!",
WHATDIDYOUDO = "Que hiciste?!",
UNDOFAULTY = "Que estas haciendo?",
SOURCEDESTROOMSSAME = "Las habitaciones de entrada y salida son las mismas!",
COORDS_OUT_OF_RANGE = "Huh? These coordinates aren't even in this dimension!",
UNKNOWNUNDOTYPE = "Tipo de deshacer desconocido \"$1\"!",
MDEVERSIONWARNING = "Parece que este nivel se ha hecho en una version mas reciente de Ved, y podria contener unos datos que se perderan cuando guardes este nivel.",
FORGOTPATH = "Te olvidaste de especificar un camino!",
LIB_LOAD_ERRMSG = "Failed to load an essential library. Please tell Dav999 about this problem.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nTry installing GCC to solve this problem, if it isn't already installed.",

SELECTCOPY1 = "Seleccione la habitacion para copiar",
SELECTCOPY2 = "Seleccione donde copiar la habitacion",
SELECTSWAP1 = "Seleccion la primera habitacion para intercambiar",
SELECTSWAP2 = "Seleccione la segunda habitacion para intercambiar",

TILESETCHANGEDTO = "Set cambiado a $1",
TILESETCOLORCHANGEDTO = "Color del set cambiado a $1",
ENEMYTYPECHANGED = "Tipo de enemigos cambiado",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Cambiado a colocación de teja $1",
CHANGEDTOMODEAUTO = "automatico",
CHANGEDTOMODEMANUAL = "manual",
CHANGEDTOMODEMULTI = "multi-set",

BUSYSAVING = "Guardando...",
SAVEDLEVELAS = "Nivel guardado como $1.vvvvvv",

ROOMCUT = "Habitacion cortada al portapapeles",
ROOMCOPIED = "Habitacion copiada al portapapeles",
ROOMPASTED = "Habitacion pegada",

METADATAUNDONE = "Opcion de niveles deshecha",
METADATAREDONE = "Opcion de niveles rehecha",

BOUNDSFIRST = "Click the first corner of the bounds", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Click the last corner", -- Old string: Click the bottom right corner

TILE = "Teja $1",
HIDEALL = "Ocultar todo",
SHOWALL = "Mostar todo",
SCRIPTEDITOR = "Editor de scripts",
FILE = "Archivo",
NEW = "Nuevo",
OPEN = "Abrir",
SAVE = "Guardar",
UNDO = "Deshacer",
REDO = "Rehacer",
COMPARE = "Comparar",
STATS = "Estadisticas",
SCRIPTUSAGES = "Usos",
EDITTAB = "Editar",
COPYSCRIPT = "Copiar script",
SEARCHSCRIPT = "Buscar",
GOTOLINE = "Ir a linea",
GOTOLINE2 = "Ir a linea:",
INTERNALON = "Sc.Interno activado",
INTERNALOFF = "Sc.Interno desactivado",
INTERNALON_LONG = "Sc.Interno activado",
INTERNALOFF_LONG = "Sc.Interno desactivado",
INTERNALYESBARS = "Sc.Interno say(-1)",
INTERNALNOBARS = "Sc.Interno Loadscript",
VIEW = "Ver",
SYNTAXHLOFF = "Hl de sintaxis: SI",
SYNTAXHLON = "Hl de sintaxis: NO",
TEXTSIZEN = "Tamaño de texto: N",
TEXTSIZEL = "Tamaño de texto: L",
INSERT = "Insertar",
HELP = "Ayuda",
INTSCRWARNING_NOLOADSCRIPT = "Se requiere script de carga!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Un script que carga este script no fue detectado. Este tipo de script interno probablemente no funcionara como lo esperes si no es cargado via otro script.",
INTSCRWARNING_BOXED = "Referencia de terminal!",
INTSCRWARNING_BOXED_EXPL = "Hay una terminal o caja de script que carga este script directamente. Activar esa terminal o caja de script probablemente no funcionara como esperado; este tipo de script interno tiene que ser cargado via un script de carga.",
INTSCRWARNING_NAME = "Nombre de script inadecuado!",
INTSCRWARNING_NAME_EXPL = "El nombre de este script tiene una letra mayuscula, un espacio, un paréntesis o una coma. Este script solo puede ser cargado directamente desde una terminal o caja de script.",
COLUMN = "Columna: ",

BTN_OK = "OK",
BTN_CANCEL = "Cancelar",
BTN_YES = "Si",
BTN_NO = "No",
BTN_APPLY = "Aplicar",
BTN_QUIT = "Salir",
BTN_DISCARD = "Descartar",
BTN_SAVE = "Guardar",
BTN_CLOSE = "Cerrar",
BTN_LOAD = "Cargar",
BTN_ADVANCED = "Advanced",

BTN_AUTODETECT = "Detect",
BTN_MANUALLY = "Override", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Retry",

COMPARINGTHESE = "Comparando $1.vvvvvv con $2.vvvvvv",
COMPARINGTHESENEW = "Comparando (nivel sin guardar) con $1.vvvvvv",

RETURN = "Regresar",
CREATE = "Crear",
GOTO = "Ir a",
DELETE = "Borrar",
RENAME = "Renombrar",
CHANGEDIRECTION = "Cambiar direccion",
TESTFROMHERE = "Probar desde aqui",
FLIP = "Voltear",
CYCLETYPE = "Cambiar tipo",
GOTODESTINATION = "Ir a destino",
GOTOENTRANCE = "Ir a entrada",
CHANGECOLOR = "Cambiar color",
EDITTEXT = "Editar texto",
COPYTEXT = "Copiar texto",
EDITSCRIPT = "Editar script",
OTHERSCRIPT = "Cambiar nombre de script",
PROPERTIES = "Propiedades",
CHANGETOHOR = "Cambiar a horizontal",
CHANGETOVER = "Cambiar a vertical",
RESIZE = "Mover/Redimensionar",
CHANGEENTRANCE = "Mover entrada",
CHANGEEXIT = "Mover salida",
COPYENTRANCE = "Copiar entrada",
LOCK = "Bloquear",
UNLOCK = "Desbloquear",

VEDOPTIONS = "Opciones de Ved",
LEVELOPTIONS = "Opciones de nivel",
MAP = "Mapa",
SCRIPTS = "Scripts",
SEARCH = "Buscar",
SENDFEEDBACK = "Enviar Feedback",
LEVELNOTEPAD = "Bloc de notas del nivel",
PLUGINS = "Plugins",

BACKB = "Atras <<",
MOREB = "Mas >>",
AUTOMODE = "Modo: auto",
AUTO2MODE = "Modo: multi",
MANUALMODE = "Modo: manual",
ENEMYTYPE = "Tipo de Enemigo: $1",
PLATFORMBOUNDS = "Limites de Platf.",
WARPDIR = "Dir de warp: $1",
ENEMYBOUNDS = "Limites de enemigo",
ROOMNAME = "Nombre de habitacion",
ROOMOPTIONS = "Opciones de habitacion",
ROTATE180 = "Girar 180grados",
ROTATE180UNI = "Girar 180°",
HIDEBOUNDS = "Ocultar limites",
SHOWBOUNDS = "Mostrar limites",

ROOMPLATFORMS = "Plataformas de habitacion", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Enemigos de habitacion",

OPTNAME = "Nombre",
OPTBY = "Por",
OPTWEBSITE = "Sitio",
OPTDESC = "Desc.", -- If necessary, you can span multiple lines
OPTSIZE = "Tamaño",
OPTMUSIC = "Musica",
CAPNONE = "NINGUNO",
ENTERLONGOPTNAME = "Nombre del nivel:",

X = "x", -- Used for level size: 20x20

SOLID = "Solido",
NOTSOLID = "No solido",

TSCOLOR = "Color $1",

LEVELSLIST = "Niveles",
LOADTHISLEVEL = "Cargar este nivel: ",
ENTERNAMESAVE = "Introduce nombre para guardar: ",
SEARCHFOR = "Buscar a: ",

VERSIONERROR = "No se puede comprobar version.",
VERSIONUPTODATE = "Su version de Ved esta actualizada.",
VERSIONOLD = "Actualizacion disponible! Version mas reciente: $1",
VERSIONCHECKING = "Buscando actualizaciones...",
VERSIONDISABLED = "Comprobacion de actualizacion desactivada",
VERSIONCHECKNOW = "Check now", -- Check for updates now

SAVENOSUCCESS = "Guardado sin exito! Error: ",
INVALIDFILESIZE = "Tamaño de archivo invalido.",

EDIT = "Editar",
EDITWOBUMPING = "Editar sin chocar",
EDITWBUMPING = "Edit and bump",
COPYNAME = "Copiar nombre",
COPYCONTENTS = "Copiar contenidos",
DUPLICATE = "Duplicar",

NEWSCRIPTNAME = "Nombre:",
CREATENEWSCRIPT = "Crear nuevo script",

NEWNOTENAME = "Nombre:",
CREATENEWNOTE = "Crear nueva nota",

ADDNEWBTN = "[Añadir nuevo]",
IMAGEERROR = "[ERROR DE IMAGEN]",

NEWNAME = "Nuevo nombre:",
RENAMENOTE = "Renombrar nota",
RENAMESCRIPT = "Renombrar script",

LINE = "linea ",

SAVEMAP = "Guardar mapa",
COPYROOMS = "Copiar habitacion",
SWAPROOMS = "Intercambiar habitaciones",

MAP_STYLE = "Map style",
MAP_STYLE_FULL = "Full", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Minimap", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Flags",
ROOM = "habitacion",
CONTENTFILLER = "Contenido",

FLAGUSED = "Usado", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "No usado",
FLAGNONAME = "Sin nombre",
USEDOUTOFRANGEFLAGS = "Flags usados fuera de rango:",

VVVVVVSETUP = "VVVVVV setup",
CUSTOMVVVVVVDIRECTORY = "Archivo de VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "El directorio de VVVVVV por defecto que Ved espera es:\n$1\n\nEste camino no deberia ser puesto a el directiorio de \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "No tienes un directorio de VVVVVV personalizado.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Su directorio de VVVVVV es un camino personalizado:\n$1\n\n",
LANGUAGE = "Idioma",
DIALOGANIMATIONS = "Animaciones de dialogo",
FLIPSUBTOOLSCROLL = "Voltear direccion de desplazo de herramienta",
ADJACENTROOMLINES = "Indicadores de teja en habitaciones adjuntas",
NEVERASKBEFOREQUIT = "Nunca preguntar antes de salir, hasta si hay cambios sin guardar",
COORDS0 = "Mostrar coordenadas comenzando en 0 (como en scripting interno)",
ALLOWDEBUG = "Habilitar modo debug",
SHOWFPS = "Mostrar contador de FPS",
CHECKFORUPDATES = "Buscar actualizaciones",
PAUSEDRAWUNFOCUSED = "No mostrar cuando la ventana esta desenfocada",
ENABLEOVERWRITEBACKUPS = "Hacer respaldos de archivos de niveles que estan sobreescribidos",
AMOUNTOVERWRITEBACKUPS = "Numeros de respaldos para mantener por nivel",
SCALE = "Escala",
LOADALLMETADATA = "Cargar metadatos (como el titulo, autor y descripcion) para todos los archivos en la lista de niveles",
COLORED_TEXTBOXES = "Usar color verdaderos de dialogos",
MOUSESCROLLINGSPEED = "Mouse scrolling speed",
BUMPSCRIPTSBYDEFAULT = "Bump scripts to the top of the list when editing them by default",

SCRIPTSPLIT = "Dividir",
SPLITSCRIPT = "Dividir scripts",
COUNT = "Cuenta: ",
SMALLENTITYDATA = "datos",

-- Stats screen
AMOUNTSCRIPTS = "Scripts:",
AMOUNTUSEDFLAGS = "Flags:",
AMOUNTENTITIES = "Entidades:",
AMOUNTTRINKETS = "Trinkets:",
AMOUNTCREWMATES = "Compañeros:",
AMOUNTINTERNALSCRIPTS = "Scripts internos:",
TILESETUSSAGE = "Uso de set de teja",
TILESETSONLYUSED = "(solo las habitaciones con tejas se cuentan)",
AMOUNTROOMSWITHNAMES = "Habitaciones con nombre:",
PLACINGMODEUSAGE = "Modos de colocación de teja:",
AMOUNTLEVELNOTES = "Notas de niveles:",
AMOUNTFLAGNAMES = "Nombres de flags:",
TILESUSAGE = "Uso de teja",
AMOUNTTILES = "Tejas:",
AMOUNTSOLIDTILES = "Tejas solidas:",
AMOUNTSPIKES = "Espinas:",


UNEXPECTEDSCRIPTLINE = "Linea de script no esperada sin script: $1",
DUPLICATESCRIPT = "Script $1 esta duplicado! Solo uno se puede cargar.",
MAPWIDTHINVALID = "Anchura de mapa invalida: $1",
MAPHEIGHTINVALID = "Altura de mapa invalida: $1",
LEVMUSICEMPTY = "La musica de nivel esta vacia!",
NOT400ROOMS = "El numero de entradas en levelMetaData no es 400!",
MOREERRORS = "$1 mas",

DEBUGMODEON = "Modo debug activado",
FPS = "FPS",
STATE = "Estado",
MOUSE = "Mouse",

BLUE = "Azul",
RED = "Rojo",
CYAN = "Azul claro",
PURPLE = "Purpura",
YELLOW = "Amarillo",
GREEN = "Verde",
GRAY = "Gris",
PINK = "Rosa",
BROWN = "Marron",
RAINBOWBG = "Arcoiris",

SYNTAXCOLORS = "Colores de sintaxis",
SYNTAXCOLORSETTINGSTITLE = "Configuracion de color de desacando de sintaxis de scripting",
SYNTAXCOLOR_COMMAND = "Comando",
SYNTAXCOLOR_GENERIC = "Generico",
SYNTAXCOLOR_SEPARATOR = "Separador",
SYNTAXCOLOR_NUMBER = "Numero",
SYNTAXCOLOR_TEXTBOX = "Dialogo",
SYNTAXCOLOR_ERRORTEXT = "Comando no reconozido",
SYNTAXCOLOR_CURSOR = "Cursor",
SYNTAXCOLOR_FLAGNAME = "Nombre de flag",
SYNTAXCOLOR_NEWFLAGNAME = "Nuevo nombre de flag",
SYNTAXCOLOR_COMMENT = "Comentario",
SYNTAXCOLOR_WRONGLANG = "Simplified command in int.sc mode or vice versa",
RESETCOLORS = "Reiniciar colores",
STRINGNOTFOUND = "\"$1\" no ha sido encontrado.",

-- L.MAL is concatenated with an error message
MAL = "El archivo del nivel esta malformado: ",

LOADSCRIPTMADE = "Script de carga creado",
COPY = "Copiar",
CUSTOMSIZE = "Tamaño de brocha personalizado: $1x$2",
SELECTINGA = "Seleccionando - haz click en superior izquierda",
SELECTINGB = "Seleccionando: $1x$2",
TILESETSRELOADED = "Sets y sprites recargados",

BACKUPS = "Respaldos",
BACKUPSOFLEVEL = "Respaldos del nivel $1",
LASTMODIFIEDTIME = "Ultima modificacion original", -- List header
OVERWRITTENTIME = "Sobreescribido", -- List header
SAVEBACKUP = "Guardar al archivo VVVVVV",
DATEFORMAT = "Formato de fecha",
TIMEFORMAT = "Formato de tiempo",
SAVEBACKUPNOBACKUP = "Asegurate de elegir un nombre unico para esto si no quieres sobreescribir algo, porque NO se haran respaldos en este caso!",

AUTOSAVECRASHLOGS = "Guardar logs de crasheo automaticamente",
MOREINFO = "Ultima informacion",
COPYLINK = "Copiar link",
SCRIPTDISPLAY = "Mostrar",
SCRIPTDISPLAY_USED = "Usado",
SCRIPTDISPLAY_UNUSED = "No usado",

RECENTLYOPENED = "Niveles abierto recientemente",
REMOVERECENT = "Quieres borrarlo de la lista de niveles abiertos recientemente?",
RESETCUSTOMBRUSH = "(Click derecho para nuevo tamaño)",

DISPLAYSETTINGS = "Monitor/Escala",
DISPLAYSETTINGSTITLE = "Opciones de Monitor/Escala",
SMALLERSCREEN = "Anchura de ventana mas pequeña (800px en vez de 896px)",
FORCESCALE = "Forzar opciones de escala",
SCALENOFIT = "Las opciones de escala hazen la ventana muy larga como para entrar.",
SCALENONUM = "Las opciones de escala son invalidas.",
MONITORSIZE = "Monitor $1x$2",
VEDRES = "Resolucion de Ved: $1x$2",
NONINTSCALE = "Escala no-entera",

USEFONTPNG = "Usar font.png de las graficas de VVVVVV como fuente",
USELEVELFONTPNG = "Use per-level custom font.png as font",
REQUIRESHIGHERLOVE = " (requiere LÖVE $1 o mejor)",
FPSLIMIT = "Limite de FPS",

MAPRESOLUTION = "Resolucion", -- Map export size
MAPRES_ASSHOWN = "Como mostrado (max. 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 por habitacion)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 por habitacion)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Super. izqrd.",
WIDTHHEIGHT = "Anch. & altur.",
BOTTOMRIGHT = "Inferior derecha",
RENDERERINFO = "Informacion de renderizador:",
MAPINCOMPLETE = "El mapa todavia no esta listo (en el momento que presionaste Guardar), porfavor intente de nuevo cuando este listo.",
KEEPDIALOGOPEN = "Mantener dialogo abierto",
TRANSPARENTMAPBG = "Fondo transparente",
MAPEXPORTERROR = "Error al crear mapa.",
VIEWIMAGE = "Ver", -- Verb, view image
INVALIDLINENUMBER = "Porfavor introduce un numero de linea valido.",
OPENLEVELSFOLDER = "Abrir direc. nivel", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Mover",
GOTOROOM = "Ir a habitacion",
ESCTOCANCEL = "[Presione ESC para cancelar]",

INVALIDFILENAME_WIN = "Windows no permite los caracteres siguientes en los nombres de archivo:\n\n: * ? \" < > |\n\n(| es una linea vertical)",
INVALIDFILENAME_MAC = "macOS no permite el caracter : en los nombres de archivo.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "CTRL",
TINY_SHIFT = "SHIFT",
TINY_ALT = "ALT",
TINY_ESC = "ESC",
TINY_TAB = "TAB",
TINY_HOME = "INICIO",
TINY_END = "FIN",
TINY_INSERT = "INS",
TINY_DEL = "SUPR",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "Scripts [$1]",
SEARCHRESULTS_ROOMS = "Habitaciones [$1]",
SEARCHRESULTS_NOTES = "Notas [$1]",

ASSETS = "Assets", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "No se pudo reproducir la cancion. Quiza no existe o sea de un tipo no soportado.",
SOUNDPLAYERROR = "No se pudo reproducir este sonido. Quiza no existe o sea de un tipo no soportado.",
MUSICLOADERROR = "No se puede cargar $1: ",
MUSICLOADERROR_TOOSMALL = "El archivo de musica es muy pequeño para ser valido.",
MUSICEXISTSYES = "Existe",
MUSICEXISTSNO = "No existe",
ASSETS_FOLDER_EXISTS_NO = "Does not exist - click to create",
ASSETS_FOLDER_EXISTS_YES = "Exists - click to open",
NO_ASSETS_SUBFOLDER = "No \"$1\" folder",
LOAD = "Cargar",
RELOAD = "Recargar",
UNLOAD = "Descargar",
MUSICEDITOR = "Editor de musica",
LOADMUSICNAME = "Cargar .vvv",
SAVEMUSICNAME = "Save .vvv",
INSERTSONG = "Insertar cancion en pista $1",
SUREDELETESONG = "Estas seguro que quieres remover cancion $1?",
SONGOPENFAIL = "No se puede abrir $1, cancion no reemplazada.",
SONGREPLACEFAIL = "Algo salio mar al reemplazar la cancion.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ".", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "No se puede usar el caracter \"$1\" en nombres de scripts!",
MUSICTITLE = "Titulo: ",
MUSICARTIST = "Artista: ",
MUSICFILENAME = "Nombre de archivo: ",
MUSICNOTES = "Notas:",
SONGMETADATA = "Metadatos para cancion $1",
MUSICFILEMETADATA = "Metadatos de archivo",
MUSICEXPORTEDON = "Exportado: ", -- Followed by date and time
SAVEMETADATA = "Guardar metadatos",
SOUNDS = "Sonidos",
GRAPHICS = "Graficos",
FILEOPENERNAME = "Nombre: ",
PATHINVALID = "El camino es invalido.",
DRIVES = "Drives", -- like C: or F: on Windows
DOFILTER = "Solo mostrar *$1", -- "*.txt" for example
DOFILTERDIR = "Solo mostrar directorios",
FILEDIALOGLUV = "Lo siento, su sistema operativo no es reconocido, asi que el dialogo de archivo no funciona.",
RESET = "Reiniciar",
CHANGEVERB = "Cambiar", -- verb
LOADIMAGE = "Cargar imagen",
GRID = "Red",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "The level needs to be saved before it can use custom assets.",
CREATE_ASSETS_FOLDER = "Would you like to create a custom assets folder for this level?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "It seems like the VVVVVV folder doesn't exist. Would you like to create it?",
CREATE_LEVELS_FOLDER = "It seems like the levels folder doesn't exist. Would you like to create it?",
CREATE_FOLDER_FAIL = "Unable to create folder.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Assets folder for $1",

OPAQUEROOMNAMEBACKGROUND = "Hacer el fondo del nombre de habitacion negro opaco",
PLATVCHANGE_TITLE = "Cambiar velocidad de plataforma",
PLATVCHANGE_MSG = "Velocidad:",
PLATVCHANGE_INVALID = "Tienes que poner un numero.",
RENAMESCRIPTREFERENCES = "Renombrar preferencias",
PLATFORMSPEEDSLIDER = "Vel.:",

TRINKETS = "Trinkets",
LISTALLTRINKETS = "Enlistar todos los trinkets", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Lista de todos los trinkets",
NOTRINKETSINLEVEL = "No hay trinkets en este nivel.",
CREWMATES = "Compañeros",
LISTALLCREWMATES = "Enlistar todos los compañeros", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Lista de compañeros rescatables",
NOCREWMATESINLEVEL = "No hay compañeros rescatables en este nivel.",
SHIFTROOMS = "Cambiar habitacion", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 seg.",
ROOMNUM = "Habitacion $1",
SOUNDNUM = "Sound $1",
TRACKNUM = "Pista $1",
STOPSMUSIC = "Para la musica",
PLAYSOUND = "Play sound",
EDITSCRIPTWOBUMPING = "Editar script sin chocar",
EDITSCRIPTWBUMPING = "Edit script and bump",
CLICKONTHING = "Haz click en $1",
ORDRAGDROP = "o arrastra y tira aqui", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Hay mas de un punto de inicio en este nivel!",
STARTPOINTNOTFOUND = "No hay punto de inicio!",

MAPBIGGERTHANSIZELIMIT = "El tamaño del mapa $1 por $2 es mas grande que $3 por $4!",
BTNOVERRIDE = "Anular",
TARGETPLATFORM = "Plataforma objetivo", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Contrarelojes",
TIMETRIALTRINKETS = "Numero de trinkets",
TIMETRIALTIME = "Tiempo",
SUREDELETETRIAL = "Estas seguro de que quieres borrar el contrareloj \"$1\"?",

CUT = "Cortar",
PASTE = "Pegar",
SELECTWORD = "Seleccionar palabra",
SELECTLINE = "Seleccionar linea",
SELECTALL = "Seleccionar todo",
INSERTRAWHEX = "Insertar carácter Unicode",
MOVELINEUP = "Mover línea hacia arriba",
MOVELINEDOWN = "Mover línea hacia abajo",
DUPLICATELINE = "Duplicar linea",

WHEREPLACEPLAYER = "Donde desea comenzar?",
YOUAREPLAYTESTING = "Estas probando justo ahora.",
LOCATEVVVVVV = "Seleccione su ejecutable de $1", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Ya estas probando!",
PLAYTESTINGFAILED = "Something went wrong when opening VVVVVV:\n$1\n\nIf you need to change the VVVVVV executable that's used for playtesting, hold Shift while pressing the playtest button.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV exited with code $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "It looks like you are using VVVVVV 2.2 or older. Please upgrade to VVVVVV 2.3 or later.",
VVVVVV_SOMETHING_HAPPENED = "Something seems to have gone wrong with VVVVVV.",
PLAYTESTUNAVAILABLE = "Lo sentimos, no se puede probar en $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Porfavor seleccione el archivo '$1'.",

PLAYTESTINGOPTIONS = "Playtesting",
PLAYTESTING_EXECUTABLE_NOTSET = "You did not yet set a $1 executable to use for playtesting.\nVed will ask for it when playtesting a $2 level for the first time.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "The $1 executable to use for playtesting is set to:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Sorry, something went wrong trying to find VVVVVV. Try setting the path to the executable manually.",
FIND_V_EXE_FOUNDERROR = "Found something that looks like VVVVVV, but couldn't get a useable path to its executable. Make sure you aren't using an old version of the game (2.3 or newer is required) or try setting the path to the executable manually.",
FIND_V_EXE_NOTFOUND = "It looks like VVVVVV is not running. Make sure you have VVVVVV running and try again.",
FIND_V_EXE_MULTI = "Found multiple different instances of VVVVVV running. Make sure you have only one version of the game open and try again.",

FIND_V_EXE_EXPLANATION = "Ved needs VVVVVV for playtesting, and the path to VVVVVV needs to be set first.\n\n\nTo autodetect VVVVVV, simply start the game if it isn't already running and press \"Detect\".",

VCE_REMOVED = "VVVVVV: Community Edition is no longer being maintained, and support for VVVVVV-CE levels has been removed from Ved. This level is treated like a regular VVVVVV level. For more information, see https://vsix.dev/vce/status/",

VVVVVV_VERSION = "VVVVVV version", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Auto",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "All plugins",
ALL_PLUGINS_MOREINFO = "Please go to ¤https://tolp.nl/ved/plugins.php¤this page¤ for more information about plugins.\\nLCl",
ALL_PLUGINS_FOLDER = "Your plugins folder is:",
ALL_PLUGINS_NOPLUGINS = "You do not have any plugins yet.",

PLUGIN_NOT_SUPPORTED = "[This plugin is not supported because it requires Ved $1 or higher!]\\r",
PLUGIN_AUTHOR_VERSION = "by $1, version $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Create load script",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "No",
CREATE_LOAD_SCRIPT_RUNONCE = "Run once",
CREATE_LOAD_SCRIPT_REPEATING = "Repeating",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Don't create load script",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "This terminal will directly point to the script.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "This script box will directly point to the script.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Create load script to run once",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "This terminal will point to a new load script, which loads the real script only once in a playthrough. Ved will choose an unused flag.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "This script box will point to a new load script, which loads the real script only once in a playthrough. Ved will choose an unused flag.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Create repeating load script",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "This terminal will point to a new load script, which unconditionally loads the real script.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "This script box will point to a new load script, which unconditionally loads the real script.",

CUSTOM_SIZED_BRUSH = "Custom brush",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Brush",
CUSTOM_SIZED_BRUSH_STAMP = "Stamp",
CUSTOM_SIZED_BRUSH_TILESET = "Tileset",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Custom brush size",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Choose the size of the brush you need.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stamp from room",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Select tiles from the room to create a stamp.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stamp from tileset",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Select tiles from the tileset to create a stamp. Only works in manual mode.",

ADVANCED_LEVEL_OPTIONS = "Advanced level options",
ONEWAYCOL_OVERRIDE = "Recolor one-way tiles in custom assets as well (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Create ZIP of this version for sharing", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Save ZIP",
ZIP_BUSY_TITLE = "Creating ZIP...",
ZIP_LOVE11_ONLY = "Creating a ZIP file requires LÖVE $1 or higher", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP saved!",
ZIP_SAVING_FAIL = "Could not save ZIP file!",

OPENFOLDER = "Open folder", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Level font",

TEXTBOXCOLORS_BUTTON = "Text colors",
TEXTBOXCOLORS_TITLE = "Textbox colors",
TEXTBOXCOLORS_RENAME = "Rename color \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Duplicate color \"$1\"",
TEXTBOXCOLORS_CREATE = "Add new color",

LIB_LOAD_ERRMSG_BIDI = "Failed to load the library for right-to-left text support.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nYour antivirus may be breaking it.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Tienes $1 plugin que no se soporta en esta version.",
		[1] = "Tienes $1 plugins que no se soportan en esta version.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Este nivel fallo $1 check. El problema se pudo haber arreglado automaticamente, pero es posible que esto resulte en crasheos y inconsistencias.",
		[1] = "Este nivel fallo $1 checks. El problema se pudo haber arreglado automaticamente, pero es posible que esto resulte en crasheos y inconsistencias.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 uso en habitaciones: $2",
		[1] = "$1 usos en habitaciones: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 uso en scripts: $2",
		[1] = "$1 usos en scripts: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "La entidad en [$1 $2] tiene $3 propiedad invalida!",
		[1] = "La entidad en [$1 $1] tiene $3 propiedades invalidas!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata para la habitacion $1,$2 tiene $3 propiedad invalida!",
		[1] = "LevelMetadata para la habitacion $1,$2 tiene $3 propiedades invalidas!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Mostrando $1",
		[1] = "Mostrando $1",
	},
	FLAGUSAGES = {
		[0] = "Usado $1 vez en scripts: $2",
		[1] = "Usado $1 veces en scripts: $2",
	},
	NOTALLTILESVALID = {
		[-1] = "$1 tile is not a valid whole number greater than or equal to 0",
		[-2] = "$1 tiles are not a valid whole number greater than or equal to 0",
	},
	BYTES = {
		[0] = "$1 byte",
		[1] = "$1 bytes",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[-1] = "$1 image customized",
		[-2] = "$1 images customized",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[-1] = "$1 sound effect customized",
		[-2] = "$1 sound effects customized",
	},
}

toolnames = {

"Pared",
"Fondo",
"Espina",
"Trinket",
"Checkpoint",
"Plataforma desapareciendo",
"Transportador",
"Plataforma moviendose",
"Enemigo",
"Linea de gravedad",
"Texto de habitacion",
"Terminal",
"Caja de scripts",
"Token de warp",
"Linea de warp",
"Compañero",
"Punto de inicio",

}

subtoolnames = {

[1] = {"Brocha 1x1", "Brocha 3x3", "Brocha 5x5", "Brocha 7x7", "Brocha 9x9", "Llenar horizontalmente", "Llenar verticalmente", "Tamaño de bocha personalizado", "Cubeta de llenar", "Patata para Hacer Cosas que son Magicas"},
[2] = {},
[3] = {"Auto 1", "Expandir auto. I+D", "Expandir auto. I", "Expandir auto. D"},
[4] = {},
[5] = {"Vertical", "Volteado"},
[6] = {},
[7] = {"D Pequeño", "I Pequeño", "D Grande", "I Grande"},
[8] = {"Abajo", "Arriba", "Izquierda", "Derecha"},
[9] = {},
[10] = {"Horizontal", "Vertical"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Entrada", "Salida"},
[15] = {},
[16] = {"Rosa", "Amarillo", "Rojo", "Verde", "Azul", "Azul claro", "Al azar"},
[17] = {"Mirar derecha", "Mirar izquierda"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "T",

}

warpdirchangedtext = {

[0] = "Warp de habitacion desactivado",
[1] = "Direccion de warp horizontal",
[2] = "Direccion de warp vertical",
[3] = "Direccion de warp son todas las direcciones",

}

langtilesetnames = {

short0 = "Estc. Espac.",
long0 = "Estacion Espacial",
short1 = "Afuera",
long1 = "Afuera",
short2 = "Laboratorio",
long2 = "Laboratorio",
short3 = "Zona Warp",
long3 = "Zona Warp",
short4 = "Nave",
long4 = "Nave",
short5 = "Torre",
long5 = "Torre",

}

ERR_VEDHASCRASHED = "Ved ha crasheado!"
ERR_VEDVERSION = "Version de Ved:"
ERR_LOVEVERSION = "Version de LÖVE:"
ERR_STATE = "Estado:"
ERR_OS = "SO:"
ERR_TIMESINCESTART = "Tiempo desde el inicio:"
ERR_PLUGINS = "Plugins:"
ERR_PLUGINSNOTLOADED = "(no cargado)"
ERR_PLUGINSNONE = "(ninguno)"
ERR_PLEASETELLDAV = "Porfavor dile a Dav999 sobre este problema.\n\n\nDetalles: (presione CTRL/CMD+C para copiarlo al portapapeles)\n\n"
ERR_INTERMEDIATE = " (version intermedia)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (muy nueva)"

ERR_PLUGINERROR = "Error de plugin!"
ERR_FILE = "Archivo para editar:"
ERR_FILEEDITORS = "Plugins que editan el archivo:"
ERR_CURRENTPLUGIN = "Plugin que causo el error:"
ERR_PLEASETELLAUTHOR = "Se suponia que un plugin haga una editacion para codificar en Ved, pero el codigo para editar no se encontro.\nEs posible que esto se haya causado por un conflicto entre dos plugins, o una actualizacion de Ved ha roto este plugin.\nDetalles: (presione CTRL/CMD+C para copiar al portapapeles)\n\n"
ERR_CONTINUE = "Puedes continuar al presionar ESC o enter, pero esta editacion fallida podria causar problemas."
ERR_OPENPLUGINSFOLDER = "Puedes abrir la carpeta de plugins al presionar F, para arrelar o remover el plugin que ofende. O si no, puedes reiniciar Ved."
ERR_REPLACECODE = "No se pudo encontrar esto en %s.lua:"
ERR_REPLACECODEPATTERN = "No se pudo encontrar esto en %s.lua (como patron):"
ERR_LINESTOTAL = "%i lineas en total"

ERR_SAVELEVEL = "Para guardar una copia de tu nivel, presione S"
ERR_SAVESUCC = "Nivel guardado con exito como %s!"
ERR_SAVEERROR = "Error de guardado! %s"
ERR_LOGSAVED = "Mas informacion se puede encontrar en el log:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Propiedades del nivel",
		changedrooms = "Habitaciones cambiadas",
		changedroommetadata = "Metadatos de la habitacion cambiada",
		entities = "Entidades",
		scripts = "Scripts",
		flagnames = "Nombres de flags",
		levelnotes = "Notas del nivel",
	},
	levelpropertiesdiff = {
		Title = "El nombre se cambia de \"$1\" a \"$2",
		Creator = "El autor se cambio de \"$1\" a \"$2\"",
		website = "El sitio web se cambio de \"$1\" a \"$2\"",
		Desc1 = "La desc. 1 se cambio de \"$1\" a \"$2\"",
		Desc2 = "La desc. 2 se cambio de \"$1\" a \"$2\"",
		Desc3 = "La desc. 3 se cambio de \"$1\" a \"$2\"",
		mapsize = "El tamaño del mapa se cambio de $1x$2 a $3x$4",
		mapsizenote = "NOTA: El tamaño del mapa se cambio de $1x$2 a $3x$4.\\o\nLas habitaciones fuera de $5x$6 no se enlistaran.\\o",
		levmusic = "La musica del nivel se cambio de $1 a $2",
	},
	rooms = {
		added1 = "Se añadio ($1,$2) ($3)\\G",
		added2 = "Se añadio ($1,$2) ($3 -> $4)\\G",
		changed1 = "Se cambio ($1,$2) ($3)\\Y",
		changed2 = "Se cambio ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Se borraron todas las tejas en ($1,$2) ($3)\\R",
		cleared2 = "Se borraron todas las tejas en ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Habitacion $1,$2:",
		changed1 = "Habitacion $1,$2 ($3):",
		roomname = "El nombre de la habitacion se cambio de \"$1\" a \"$2\"\\Y",
		roomnameremoved = "El nombre de la habitacion \"$1\" se removio\\R",
		roomnameadded = "Se llamo la habitacion \"$1\"\\G",
		tileset = "El set y color de tejas $1 y $2 se cambio a $3 y $4\\Y",
		platv = "La velocidad de plataforma se cambio de $1 a $2\\Y",
		enemytype = "El tipo de enemigo se cambio de $1 a $2\\Y",
		platbounds = "Los limites de plataformas se cambiaron de $1,$2,$3,$4 a $5,$6,$7,$8\\Y",
		enemybounds = "Los limites de enemigos se cambiaron de $1,$2,$3,$4 a $5,$6,$7,$8\\Y",
		directmode01 = "Modo directo habilitado\\G",
		directmode10 = "Modo directo desactivado\\R",
		warpdir = "Direccion de warp se cambio de $1 a $2\\Y",
	},
	entities = {
		added = "Se añadio el tipo de entidad $1 en la posicion $2,$3 en la habitacion ($4,$5)\\G",
		removed = "Se removio el tipo de entidad $1 en la posicion $2,$3 en la habitacion ($4,$5)\\R",
		changed = "Se cambio el tipo de entidad $1 en la posicion $2,$3 en la habitacion ($4,$5)\\Y",
		changedtype = "Se cambio el tipo de entidad $1 a tipo $2 en la posicion $3,$4 en la habitacion ($5,$6)\\Y",
		multiple1 = "Se cambiaron las entidades en la posicion $1,$2 en la habitacion ($3,$4):\\Y",
		multiple2 = "a:",
		addedmultiple = "Se añadieron entidades en la posicion $1,$2 en la habitacion ($3,$4):\\G",
		removedmultiple = "Se removieron entidades en la posicion $1,$2 en la habitacion ($3,$4):\\R",
		entity = "Tipo $1",
		incomplete = "No se aguantaron todas las entidades! Porfavor reportale esto a Dav.\\r",
	},
	scripts = {
		added = "Se añadio el script \"$1\"\\G",
		removed = "Se removio el script \"$1\"\\R",
		edited = "Se edito el script \"$1\"\\Y",
	},
	flagnames = {
		added = "Se nombro el flag $1 como \"$2\"\\G",
		removed = "Se le removio el nombre \"$1\" al flag $2\\R",
		edited = "Se cambio el nombre al flag $1 de \"$2\" a \"$3\"\\Y",
	},
	levelnotes = {
		added = "Se añadio una nota del nivel \"$1\"\\G",
		removed = "Se removio una nota del nivel \"$1\"\\R",
		edited = "Se edito una nota del nivel \"$1\"\\Y",
	},
	mde = {
		added = "Se añadio una entidad de metadatos.\\G",
		removed = "Se removio una entidad de metadatos.\\R",
	},
}

