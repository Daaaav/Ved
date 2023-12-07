-- Language file for Ved
--- Language: es_AR (es_AR)
--- Last converted: 2023-11-26 03:11:36 (CET)

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
	if c == "ñ" then
		return "n"
	elseif c == "á" then
		return "a"
	elseif c == "é" then
		return "e"
	elseif c == "í" then
		return "i"
	elseif c == "ó" then
		return "o"
	elseif c == "ú" then
		return "u"
	end
end

L = {

TRANSLATIONCREDIT = "Traduccion por Valso22 (XxTheProTx9999Xx, naether)", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Su versión de LÖVE esta obsoleta. Porfavor use versión 0.9.1 o mejor.\nPuedes descargar la versión mas reciente de LÖVE desde https://love2d.org/.",
OUTDATEDLOVE090 = "Ved ahora no soporta LÖVE 0.9.0. Con suerte, LÖVE 0.9.1 y mejores seguiran funcionando.\nPuedes descargar la versión mas reciente de LÖVE desde https://love2d.org/.",

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
FLIPSUBTOOLSCROLL = "Voltear direccion de desplazo de subherramienta",
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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "El archivo del nivel esta malformado: ",
METADATACORRUPT = "Faltan metadatos o estan corruptos.",
METADATAITEMCORRUPT = "Faltan metadatos para $1 o estan corruptos.",
TILESCORRUPT = "Faltan tejas o estan corruptas.",
ENTITIESCORRUPT = "Faltan entidades o estan corruptas.",
LEVELMETADATACORRUPT = "Faltan metadatos de habitacion o estan corruptos.",
SCRIPTCORRUPT = "Faltan scripts o estan corruptos.",

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
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
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

CONFIRMBIGGERSIZE = "Estas seleccionando $1 por $2, lo cual es un tamaño de mapa mas grande que $3 por $4. Afuera del $3 por $4 normal, las habitaciones y sus propiedades se envuelven, pero están distorsionadas. Usted no tiene habitaciones completas del todo, tampoco las propiedades.\n\nPresiona Si si sabes lo que estas haciendo y quieres este tamaño de mapa mas grande. Presiona No para poner el tamaño del mapa a $5 por $6.\n\nSi no estas seguro, presiona No.",
MAPBIGGERTHANSIZELIMIT = "El tamaño del mapa $1 por $2 es mas grande que $3 por $4! (No se habilito el soporte de mapas mas grandes que $3 por $4)",
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
	LITERALNULLS = {
		[0] = "Hay $1 byte nulo!",
		[1] = "Hay $1 bytes nulos!",
	},
	XMLNULLS = {
		[0] = "Hay $1 caracter XML nulo!",
		[1] = "Hay $1 caracteres XML nulos!",
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
subj = "Comenzando",
imgs = {},
cont = [[
Comenzando\wh#
\C=

Este articulo te ayudara a comenzar a usar Ved. Para comenzar con usar el
editor, deberás cargar un nivel, o crear uno nuevo.


El editor\h#

En el lado izquierdo, encontraras la selección de herramientas. La mayoría de las
herramientas tienen sub-herramientas que se listaran a su derecha. Para cambiar la
herramienta, use su atajo respectivo o desplace con Shift o Ctrl presionado. Para
cambiar a sub-herramienta, puede desplazar adonde sea. Para mas información
sobre las herramientas, referir a la pagina de ayuda ¤Tools\nwl.
Las entidades se pueden clickear con el boton derecho para un menu de acciones
para esa entidad. Para borrar las entidades sin usar el menú de contexto, presione
el boton derecho al presionar Shift en ellas.
En el lado derecho de la pantalla, encontraras muchos botones y opciones. Los
botones superiores se relacionan a el nivel entero, los botones inferiores (debajo
de opciones de habitación) son específicos a la habitación actual. Para mas
información sobre esos botones, referir a las paginas de ayuda respectivas, si
disponibles.

Carpeta de niveles\h#

Ved normalmente usara la misma carpeta para almacenar niveles que usa
VVVVVV, así que es fácil cambiar el editor de niveles de VVVVVV al de Ved
y viceversa. Si Ved no detecta su carpeta de VVVVVV correctamente, puede
entrar un camino personalizado en las opciones de Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Modos de poner tejas",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Modos de poner tejas\wh#
\C=

Ved soporta tres modos diferentes para dibujar tejas.

     Modo automático\h#0

          Este modo es al mas fácil de usar. En este modo, puedes dibujar
          paredes y fondos y los bordes se ajustaran automáticamente
          correctamente. Pero al editar en este modo, todas las paredes y
          fondos en la habitación deben usar el mismo set y color de tejas.

     Modo de multi-set\h#1

          Este es muy similar al modo automático. excepto que puedes tener
          múltiples sets en la misma habitación. Eso es, cambiar el set no
          afectara paredes y fondos ya puestos, y puedes dibujar en multiples
          diferentes tipos de tejas en la misma habitaciones.

     Modo manual\h#2

          También llamado Modo Directo, en este modo puedes poner cualquier
          teja manualmente, asi que no estas encadenado a las combinaciones de
          sets predefinidos y bordes no se ajustaran solas, dándote control
          completo de como se vera la habitación. Pero este modo es muy lento de
          usar.
]]
},

{
splitid = "030_Tools",
subj = "Herramientas",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Herramientas\wh#
\C=

Puedes usar estas herramientas para llenar habitaciónes en tu nivel:

\0
   Pared\h#


La herramienta de pared se usa para poner paredes.

\1
   Fondo\h#


La herramienta de fondo se usa para poner fondos.

\2
   Espina\h#


La herramienta de espina se usa para poner espinas. Puedes usar la subherramienta
de expander para poner espinas en una superficie en un click (o tambien deslizar).

\3
   Trinket\h#


La herramienta de trinket se usa para poner trinkets. Porfavor note que hay un
limite de veinte trinkets en un nivel.

\4
   Checkpoint\h#


La herramienta de checkpoint se usa para poner checkpoints.

\5
   Plataforma desvaneciente\h#


La herramienta de plataforma desvaneciente se usa para poner plataformas
que desaparecen.

\6
   Transportador\h#


La herramienta de transportador se usa para poner transportadores.

\7
   Plataforma moviendose\h#


La herramienda de plataforma moviendose se usa para poner plataformas que se
mueven.

\8
   Enemigo\h#


La herramienta de enemigos se usa para poner enemigos. El color y forma del
enemigo es determinado por el tipo de enemigo y el color del set respectivamente.

\9
   Linea de gravedad\h#


La herramienta de linea de gravedad se usa para poner lineas de gravedad.

\^0
   Texto de habitacion\h#


La herramienta de texto de habitación se usa para poner texto.

\^1
   Terminal\h#


La herramienta de terminal se usa para poner terminales. Primero pon la
terminal, luego pon un nombre para el script. Para mas información sobre scripts,
porfavor referir a las referencias de scripts.

\^2
   Caja de script\h#


La herramienta de caja de scripts se usa para poner cajas de scripts. Primero
haz click en el borde superior izquierdo, luego en el borde inferior derecho,
luego escribe un nombre para el script. Para mas información sobre scripts,
porfavor referir a las referancias de scripts.

\^3
   Token de warp\h#


La herramienta del token de warp se usa para poner tokens de warp. Primero
haz click donde la entrada deberia estar, luego donde la salida deberia estar.

\^4
   Linea de warp\h#


La herramienta de linea de warp se usa para poner lineas de warp. Porfavor note
que las lineas de warp solo se pueden poner en los bordes de una habitación.

\^5
   Compañero\h#


La herramienta de compañeros se usa para poner compañeros desaparecidos que
pueden ser rescatados. Si todos los compañeros son rescatados, el nivel terminara.
Porfavor note que hay un limite de veinte compañeros desaparecidos en un nivel.

\^6
   Punto de comienzo\h#


La herramienta de punto de comienzo se usa para poner el punto de comienzo.
]]
},
{
splitid = "040_Script_editor",
subj = "Editor de scripts",
imgs = {},
cont = [[
Editor de scripts\wh#
\C=

Con el editor de scripts, puedes gestionar y editar scripts en tu nivel.


Nombres de flags\h#

Por conveniencia y legibilidad de los scripts, es posible usar nombres de flags
en vez de números. Cuando use un nombre en vez de un número, un número se
asociara automaticamente con ese nombre, en el fondo. Tambien es posible elegir
que número usar para cual nombre de flag.

Modo de script interno\h#

Para usar scripts internos en Ved, puedes habilitar el modo de scripting interno
en el editor, para encargarse de todos los comandos en ese script como
internos. Mire Int.sc mode¤ para mas informació sobre el modo de scripting\w|
interno. Para mas información sobre scripting interno, mire la referencia de
scripting interno.

Dividiendo scripts\h#

Es posible dividir un script en dos con el editor. Despues de poner el cursor
de texto en la primera linea que quieres que este en el nuevo script, clickee
el boton de Dividir y entre el nombre del nuevo script. Las lineas antes del cursor
permaneceran en el script original, las lineas despues del cursor seran movidas
al nuevo script.

Saltar a scripts\h#

On lines with an iftrinkets, ifflag, customiftrinkets or customifflag command, it
is possible to jump to the given script by clicking the "Go to" button when the
cursor is on that line. You can also press ¤Alt+right¤ to do this, and you can\nw
use ¤Alt+left¤ to jump one step back through the chain to where you came from.\nw
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Int.sc mode",
imgs = {},
cont = [[
Internal scripting mode\wh#
\C=

To use internal scripting in Ved, you can enable internal scripting mode in the
editor, to handle all commands in that script as internal scripting. With this
feature, you do not have to worry much about getting internal scripting to work;
you do not need to use ¤say¤ commands, count lines, or type ¤text(1,0,0,4)¤ or\nwnw
text,,,,4¤ or whatever else your preference goes out to - just write internal\w
scripts like they're meant for the main game. You do not even need to end with a
final ¤loadscript¤ command.\nw

Ved supports different methods of internal scripting. To highlight their technical
differences, we'll use the following example script:

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

Lines of this internal script are ¤light green¤, lines that are added automatically\nG
and are necessary for the scripting exploit to work will be ¤gray¤. Note that this\ng
is simplified a bit; Ved adds ¤#v¤ at the end of the gray lines in the examples to\nw
make sure manually written scripts won't be changed, and ¤say¤ blocks that are too\nw
large have to be broken up into smaller ones.

For more information about internal scripting, check the internal scripting
reference.

Loadscript int.sc\h#

The loadscript method is probably the most commonly used method today. It's the
method that Ved has supported since an alpha version.

It requires an extra script, the loadscript, to load the internal script. The
loadscript would, in its most basic form, contain a command like
iftrinkets(0,yourscript)¤, but you can have other simplified commands in it as\w
well, and you can also use ¤ifflag¤ instead of ¤iftrinkets¤. What's important is\nwnw
that your internal script is loaded from another script for it to work.

The internal script would be converted more or less as follows:

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

text(1,0,0,3)¤ needs to be the last line, or in VVVVVV's script editor, there\w
needs to be exactly one blank line after it.

It's also possible to not use ¤squeak(off)¤, and use ¤text(1,0,0,4)¤ instead of\nwnw
text(1,0,0,3)¤. Using ¤squeak(off)¤ saves some precious lines in longer scripts,\wnw
though.

say(-1) int.sc\h#

The say(-1) method is older, and has a disadvantage to the loadscript method: it
always makes cutscene bars show. But it also has an advantage that can be
important in levels with many scripts: it does not require a loadscript. We can
remove ¤cutscene()¤ and ¤untilbars()¤ from our script, since those will already be\nwnw
added by VVVVVV when using this method.

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

This method has been added as an extra internal scripting mode in Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Shortcuts",
imgs = {},
cont = [[
Editor shortcuts\wh#
\C=

Tip: you can hold ¤F9¤ anywhere within Ved to see many of the shortcuts.\nC

Most shortcuts that can be used in VVVVVV can also be used in Ved.

F1¤  Change tileset\C
F2¤  Change color\C
F3¤  Change enemies\C
F4¤  Enemy bounds\C
F5¤  Platform bounds\C

F10¤  Manual/automatic mode (direct mode/undirect mode)\C

W¤  Change warp direction\C
E¤  Change roomname\C

L¤  Load map\C
S¤  Save map\C

Z¤  3x3 brush (walls and backgrounds)\C
X¤  5x5 brush (")\C

< ¤and¤ >¤  change tool\CnC
Ctrl/Cmd+< ¤and¤ Ctrl/Cmd+>¤  change subtool\CnC

More shortcuts\h#

Ved also introduces a few shortcuts.

Main editor\gh#

Ctrl+P¤  Jump to the room containing the startpoint\C
Ctrl+S¤  Quicksave\C
Ctrl+X¤  Cut room to the clipboard\C
Ctrl+C¤  Copy room to the clipboard\C
Ctrl+V¤  Paste room from clipboard (if valid)\C
Ctrl+D¤  Compare this level to another level\C
Ctrl+Z¤  Undo\C
Ctrl+Y¤  Redo\C
Ctrl+F¤  Search\C
Ctrl+/¤  Level notepad\C
Ctrl+F1¤  Help\C
(NOTE: On Mac, replace Ctrl by Cmd)
N¤  display all tile numbers\C
J¤  display tile solidity\C
;¤  display minimap tiles\C
Shift+;¤  display background\C
M¤ or ¤Keypad 5¤  Show map\CnC
G¤  Go to room (type in coordinates as four digits)\C
/¤  Scripts\C
[¤  lock Y of mouse while held down (for drawing horizontal lines more easily)\C
]¤  lock X of mouse while held down (for drawing vertical lines more easily)\C
F11¤  reload tilesets and sprites\C

Entities\gh#

Shift+right click¤  Delete entity\C
Alt+click¤          Move entity\C
Alt+Shift+click¤    Copy entity\C

Script editor\gh#

Ctrl+F¤  Find\C
Ctrl+G¤  Go to line\C
Ctrl+I¤  Toggle internal scripting mode\C
Alt+right¤  Jump to script in conditional command\C
Alt+left¤  Jump one step back\C

Script list\gh#

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

Note: this command can also be written as ¤cry¤ instead of ¤sad¤.\nwnw

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

Remove all objects of the given type, until you re-enter the room.

Valid arguments can be:
warptokens - Warp tokens
gravitylines - Gravity lines
platforms - Doesn't work properly
moving - Moving platforms (added in 2.4)
disappear - Disappearing platforms (added in 2.4)

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

warpdir¤(x,y,dir)\w#h

Changes the warp direction for room x,y, 1-indexed, to the given direction. This
could be checked with ifwarp, resulting in a relatively powerful extra
flags/variable system.

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

ifwarp¤(x,y,dir,script)\w#h

If the warpdir for room x,y, 1-indexed, is set to dir, go to (simplified) script

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

loadtext¤(language)\w#h

Load a translation for the level by language code. Use an empty value to use
VVVVVV's language again.

language - A language code, like fr or pt_BR

iflang¤(language,script)\w#h

If VVVVVV's language is set to the given language, go to a script. This is not
affected by the language code you pass to loadtext(), only by what language the
user has selected in the menu.

setfont¤(font)\w#h

Change the font used for text in the level. This can be a font supplied with the
game, such as font_ja for Japanese, or a font supplied with the level. Leave blank
to revert to the default font for the level.

textcase¤(case)\w#h

If your level has translation files, and you have multiple text boxes with the
same text in a single script, this command can make them have unique translations.
Place it before a textbox.

case - A number between 1 and 255
]]
},

{
splitid = "080_Int_script_reference",
subj = "Int. script reference",
imgs = {},
cont = [[
Internal scripting reference\wh#
\C=

The internal scripting provides more power to scripters, but is also a bit more
complex than simplified scripting.

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


activateteleporter¤()\w#h

Activate the first teleporter in the room, which makes it flash random colors, and
animate erratically.

The teleporter's ¤tile¤ is set to 6, and the ¤color¤ is set to 102. This command makes\gn&Zgn&Zg
the teleporter do nothing when touched, as the teleporter's tile is set to\g
something which isn't ¤1§¤.\gn&Zg(

activeteleporter¤()\w#h

Makes the first teleporter in the room white, aka color ¤101¤.\nn&Z

This command does not change the tile, so it will not affect functionality.\g

alarmoff\w#h

Turns the alarm off.

alarmon\w#h

Turns the alarm on.

altstates¤(state)\b#h

Changes the layout of certain rooms, being the trinket room in the ship before and
after the explosion, and the secret lab entrance (custom levels don't support
altstates at all).

In the code, this changes the global ¤altstates¤ variable.\gn&Zg

audiopause¤(on/off)\w#h

Force-enable or disable unfocus audio pause, regardless of the user-set audio
pause setting. Defaults to off, i.e. pause audio during unfocus pause.

This command was added in 2.3.\g

backgroundtext\w#h

Makes the next shown textbox not wait for ACTION to be pressed before continuing
the script. The most common usage of this is to display multiple textboxes at
once.

befadein¤()\w#h

Instantly remove a fade, such as from ¤#fadeout()¤fadeout¤ or ¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z

blackon¤()\w#h

Resume rendering if it was paused by ¤#blackout()¤blackout¤.\nLwl&Z

blackout¤()\w#h

Pauses rendering.

To make the screen black, use ¤#shake(n)¤shake¤ at the same time.\gLwl&Zg

bluecontrol\b#h

Start a conversation with Victoria just like when you meet her in the main game
and press ENTER. Also creates an activity zone afterwards.

changeai¤(crewmate,ai1,ai2)\w#h

Can change the face direction of a crewmate or the walking behaviour

crewmate - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceleft/faceright/followposition,ai2
ai2 - required if followposition is used for ai1

faceplayer¤ is missing, use 18 instead. ¤panic¤ also does not work, requiring ¤20¤.\n&Zgn&Zgn&Zg

changecolour¤(a,b)\w#h

Changes the color of a crewmate. This command can be used with Arbitrary Entity
Manipulation.

a - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
b - Color name to change to. Since 2.4, you can also use a color ID

changecustommood¤(color,mood)\w#h

Changes the mood of a rescuable crewmate.

color - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
mood - 0 for happy, 1 for sad

changedir¤(color,direction)\w#h

Just like ¤#changeai(crewmate,ai1,ai2)¤changeai¤, this changes face direction.\nLwl&Z

color - cyan/player/blue/red/yellow/green/purple
direction - 0 is left, 1 is right

changegravity¤(crewmate)\w#h

Increase the sprite number of the given crewmate by 12.

crewmate - Color of crewmate to change cyan/player/blue/red/yellow/green/purple

changemood¤(color,mood)\w#h

Changes the mood of the player or a cutscene crewmate.

color - cyan/player/blue/red/yellow/green/purple
mood - 0 for happy, 1 for sad

Cutscene crewmates are crewmates created with ¤#createcrewman(x,y,color,mood,ai1,ai2)¤createcrewman¤.\gLwl&Zg

changeplayercolour¤(color)\w#h

Changes the player's color

color - cyan/player/blue/red/yellow/green/purple/teleporter

changerespawncolour¤(color)\w#h

Changes the color the player respawns with upon death.

color - red/yellow/green/cyan/blue/purple/teleporter or number

This command was added in 2.4.\g

changetile¤(color,tile)\w#h

Changes the tile of a crewmate (you can change it to any sprite in sprites.png,
and it only works for crewmates created with createcrewman)

color - cyan/player/blue/red/yellow/green/purple/gray
tile - Tile number

clearteleportscript¤()\b#h

Clears the teleporter script set with teleportscript(x)

companion¤(x)\b#h

Makes the specified crewmate a companion.

x - 0 (none) or 6/7/8/9/10/11

createactivityzone¤(color)\b#h

Creates an activity zone at the specified crewmate (or the player, if the crewmate
doesn't exist) which says "Press ACTION to talk to (crewmate)"

createcrewman¤(x,y,color,mood,ai1,ai2)\w#h

Creates a crewmate (not rescuable)

mood - 0 for happy, 1 for sad
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - required if followposition is used for ai1

createentity¤(x,y,e,meta,meta,p1,p2,p3,p4)\o#h

Creates the entity with the ID ¤e§¤, two ¤meta¤ values, and 4 ¤p§¤ values.\nn&Znn&Znn&Z(

e - The entity ID

A list of entity IDs and the ¤meta¤/§¤p§¤ values they use can be found ¤https://vsix.dev/wiki/Createentity_list¤here¤.\gn&Zgn&ZgLClg(

createlastrescued¤()\b#h

Creates the last rescued crewmate at hardcoded position ¤(200,153)¤. The last\nn&Z
rescued crewmate is based on the Level Complete gamestate.

createrescuedcrew¤()\b#h

Creates all rescued crewmates

customifflag¤(n,script)\w#h

Same as ¤ifflag(n,script)¤ in simplified scripting\nn&Z

customiftrinkets¤(n,script)\w#h

Same as ¤iftrinkets(n,script)¤ in simplified scripting\nn&Z

customiftrinketsless¤(n,script)\w#h

Same as ¤iftrinketsless(n,script)¤ in simplified scripting\nn&Z

custommap¤(on/off)\w#h

The internal variant of the map command

customposition¤(type,above/below)\w#h

Overrides the x,y of the text command and thus sets the position of the text box,
but for crewmates, rescuable crewmates are used to position against, instead of
createcrewman crewmates.

type - center/centerx/centery, or a color name cyan/player/blue/red/yellow/green/
purple (rescuable)
above/below - Only used if type is a color name

cutscene¤()\w#h

Makes cutscene bars appear

delay¤(frames)\w#h

Pauses the script for the specified number of frames. Controls are forced to be
unpressed during this pause.

destroy¤(object)\w#h

Removes an entity. This is the same as the simplified scripting command.

object - gravitylines/warptokens/platforms/moving/disappear

moving¤ and ¤disappear¤ were added in 2.4.\n&Zgn&Zg

do¤(times)\w#h

Starts a loop block which will repeat a specified number of times. End the block
using ¤#loop¤loop¤.\nLwl&Z

times - The amount of times the block will loop.

endcutscene¤()\w#h

Makes cutscene bars disappear

endtext\w#h

Makes a text box disappear (fade out)

endtextfast\w#h

Makes a text box disappear immediately (without fading out)

entersecretlab\r#h

Turns on Secret Lab mode.

2.2 AND BELOW: Actually unlocks the Secret Lab, which is probably an unwanted
effect for a custom level to have.

everybodysad¤()\w#h

Makes all crewmates sad.

Does not work on crewmates placed in the editor.\g

face¤(A,B)\w#h

Makes crewmate A look at crewmate B.

A - cyan/player/blue/red/yellow/green/purple/gray
B - cyan/player/blue/red/yellow/green/purple/gray

Does not work on crewmates placed in the editor.\g

fadein¤()\w#h

Fades back in from ¤#fadeout()¤fadeout¤.\nLwl&Z

fadeout¤()\w#h

Fades the screen to black. To undo, use ¤#fadein()¤fadein¤ or ¤#befadein()¤befadein¤.\nLwl&ZnLwl&Z

finalmode¤(x,y)\b#h

Teleports you to Outside Dimension VVVVVV, ¤(46,54)¤ is the initial room of the\nn&Z
Final Level

flag¤(n,on/off)\w#h

Same behavior as simplified command

flash¤(length)\w#h

Makes the screen white for ¤length¤ amount of frames.\nn&Z

length - The amount of frames. 30 frames is almost one second.

This is different from the simplified command, which actually calls ¤flash(5)¤,\gn&Zg
playef(9)¤ and ¤shake(20)¤ at the same time. See: ¤#playef(sound)¤playef¤ and ¤#shake(n)¤shake¤.\n&Zgn&ZgLwl&ZgLwl&Zg

flip\w#h

Make the player flip by pressing ACTION.

If the player is not on the ground, this will not work, since it's simulating an\g
ACTION press. Likewise, this command right after a textbox will not function for\g
the same reason as two consecutive ACTION presses in a row is treated as holding\g
the button down, which does not flip the player.\g

flipgravity¤(color)\w#h

Flips the gravity of a certain crewmate, or the player.

color - cyan/player/blue/red/yellow/green/purple

Before 2.3, this wouldn't unflip crewmates, or affect the player.\g

flipme\w#h

Correct vertical positioning of multiple text boxes in flip mode

foundlab\b#h

Plays sound effect 3, shows text box with "Congratulations! You have found the
secret lab!" Does not endtext, also has no further unwanted effects.

foundlab2\b#h

Displays the second text box you see after discovering the secret lab. Also does
not endtext, and also does not have any further unwanted effects.

foundtrinket¤(x)\w#h

Makes a trinket found

x - Number of the trinket

gamemode¤(x)\b#h

teleporter to show the map, game to hide it (shows teleporters of the main game)

x - teleporter/game

gamestate¤(state)\o#h

Change the current gamestate to the specified state number.

state - The gamestate to jump to

A full list of gamestates is ¤https://vsix.dev/wiki/List_of_gamestates¤here¤.\gLClg

gotoposition¤(x,y,gravity)\w#h

Change Viridian's position to ¤(x,y)¤ in this room, and change their gravity as\nn&Z
well.

gravity - 1 for flipped, 0 for not flipped. Any other values result in glitchy
player gravity.

gotoroom¤(x,y)\w#h

Change the current room to ¤(x,y)¤.\nn&Z

x - x coordinate
y - y coordinate

These room coordinates are 0-indexed.\g

greencontrol\b#h

Start a conversation with Verdigris just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.

hascontrol¤()\w#h

Makes the player have control. Note that you can't use this to regain control
while in the middle of a ¤#delay(frames)¤delay¤.\nLwl&Z

hidecoordinates¤(x,y)\w#h

Set the room at the given coordinates to unexplored

hideplayer¤()\w#h

Makes the player invisible

hidesecretlab\w#h

Hide the secret lab on the map

hideship\w#h

Hide the ship on the map

hidetargets¤()\b#h

Hide the targets on the map

hideteleporters¤()\b#h

Hide the teleporters on the map

hidetrinkets¤()\b#h

Hide the trinkets on the map

ifcrewlost¤(crewmate,script)\b#h

If crewmate is lost, go to script

ifexplored¤(x,y,script)\w#h

If ¤(x,y)¤ is explored, go to internal script.\nn&Z

These room coordinates are 0-indexed.\g

ifflag¤(n,script)\b#h

Same as customifflag, but loads an internal (main game) script

iflang¤(language,script)\w#h

Check if the current language of the game is a certain language, and if so, jump
to the given custom script. ¤#loadtext(language)¤loadtext¤ has no influence on this command; only what\nLwl&Z
language the user has selected in the menu.

language - The language to check, usually a two-letter code, such as ¤en¤ for\nn&Z
English
script - The custom script to jump to, if the check succeeds

This command was added in 2.4.\g

iflast¤(crewmate,script)\b#h

If crewmate x was rescued last, go to script

crewmate - Numbers are used here: 0: Viridian, 1: Violet, 2: Vitellary, 3:
Vermilion, 4: Verdigris, 5 Victoria

ifskip¤(x)\b#h

If you skip the cutscenes in No Death Mode, go to script x

iftrinkets¤(n,script)\b#h

Same as simplified scripting, but loads an internal (main game) script

iftrinketsless¤(n,script)\b#h

Checks if the number given is less than an amount that's related to trinkets.
However, it checks against the greatest number of trinkets that you have ever
gotten during a single playthrough of the main game, NOT the amount of trinkets
you actually have. Loads an internal (main game) script

ifwarp¤(x,y,dir,script)\w#h

If the warpdir for room ¤(x,y)¤, 1-indexed, is set to dir, go to (simplified) script\nn&Z

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

jukebox¤(n)\w#h

Makes a jukebox terminal white and turns off the color of all the other terminals.
If n is given, a jukebox activity zone will be spawned at a hardcoded position and
if a terminal is at the same hardcoded position it will be lit up.
The possible values of n and the hardcoded positions are these:
1: (88, 80), 2: (128, 80), 3: (176, 80), 4: (216, 80), 5: (88, 128), 6: (176,
128), 7: (40, 40), 8: (216, 128), 9: (128, 128), 10: (264, 40)

leavesecretlab¤()\b#h

Turn off "secret lab mode"

loadscript¤(script)\b#h

Load an internal (main game) script. Commonly used in custom levels as
loadscript(stop)

loadtext¤(language)\w#h

In custom levels, load the translation for the given language.

language - The language to load, usually a two-letter code, such as ¤en¤ for\nn&Z
English. Pass an empty language code to revert to the default behavior of simply
using VVVVVV's language.

This command was added in 2.4.\g

loop\w#h

Put this at the end of a loop block started with the ¤#do(times)¤do¤ command.\nLwl&Z

missing¤(color)\b#h

Makes someone missing

moveplayer¤(x,y)\w#h

Moves the player by x pixels to the right and y pixels down. Negative numbers are
accepted as well.

musicfadein¤()\w#h

Fades the music in.

Before 2.3, this command did nothing.\g

musicfadeout¤()\w#h

Fades out the music.

nocontrol¤()\w#h

Sets game.hascontrol to false, which removes control from the player.
game.hascontrol is automatically set during "- Press ACTION to advance text -" and
closing text boxes, so this gets undone after those prompts

play¤(n)\w#h

Start playing a song with internal song number.

n - Internal song number

playef¤(sound)\w#h

Play a sound effect.

sound - Sound ID

In VVVVVV 1.x, there was a second argument which controlled the offset in\g
milliseconds at which the sound effect started. This was removed during the C++\g
port.\g

position¤(type,above/below)\w#h

Overrides the x,y of the text command and thus sets the position of the text box.

type - center/centerx/centery, or a color name cyan/player/blue/red/yellow/green/
purple
above/below - Only used if type is a color name

purplecontrol\b#h

Start a conversation with Violet just like when you meet her in the main game and
press ENTER. Also creates an activity zone afterwards.

redcontrol\b#h

Start a conversation with Vermilion just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.

rescued¤(color)\b#h

Makes someone rescued

resetgame\w#h

Resets all trinkets, collected crewmates and flags, and teleports the player to
the last checkpoint.

restoreplayercolour¤()\w#h

Changes the player's color back to cyan

resumemusic¤()\w#h

Resumes the music after ¤#musicfadeout()¤musicfadeout¤.\nLwl&Z

Before 2.3, this was unfinished and caused various glitches, including crashes.\g

rollcredits¤()\r#h

Makes the credits roll.

2.2 AND BELOW: It destroys your save after the credits are completed!

setactivitycolour¤(color)\w#h

Change the color of the next activity zone that gets spawned.

color - Any color that ¤#text(color,x,y,lines)¤text¤ takes\nLwl&Z

This command was added in 2.4.\g

setactivityposition¤(y)\w#h

Change the position of the next activity zone that gets spawned.

y - The y position

This command was added in 2.4.\g

setactivitytext\w#h

Change the text of the next activity zone that gets spawned. The line after this
command will be taken as the text (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This command was added in 2.4.\g

setcheckpoint¤()\w#h

Sets the checkpoint to the current location

setfont¤(font)\w#h

In custom levels, set the font to the given font.

font - The font to set the font to. If left blank, this will set the font to the
default font of the custom level.

This command was added in 2.4.\g

setroomname\w#h

Change the room name of the current room. The line after this command will be
taken as the name (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This name is not persistent and will go back to the default room name when the
room is reloaded (e.g. by leaving and coming back).

This name overrides any special changing room name, if the room has one. 

This command was added in 2.4.\g

shake¤(n)\w#h

Shake the screen for n ticks. This will not create a delay.

showcoordinates¤(x,y)\w#h

Set the room at the given coordinates to explored

showplayer¤()\w#h

Makes the player visible

showsecretlab\w#h

Show the secret lab on the map

showship\w#h

Show the ship on the map

showtargets¤()\b#h

Show the targets on the map (unknown teleporters which show up as ?s)

showteleporters¤()\b#h

Show the teleporters in explored rooms on the map

showtrinkets¤()\w#h

Show the trinkets on the map

Since 2.3, this command was changed to work in custom levels.\g

speak\w#h

Shows a text box, without removing old text boxes. Also pauses the script until
you press action (unless there's a backgroundtext command above it)

speak_active\w#h

Shows a text box, and removes any old text box. Also pauses the script until you
press action (unless there's a backgroundtext command above it)

specialline¤(x)\b#h

Special dialogs that show up in the main game

squeak¤(color)\w#h

Makes a squeak sound from a crewmate, or a terminal sound

color - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\b#h

Alternate ¤finalmode(46,54)¤, takes you to the final level without accepting\nn&Z
arguments.

stopmusic¤()\w#h

Stops the music immediately. Equivalent to ¤music(0)¤ in simplified scripting.\nn&Z

teleportscript¤(script)\b#h

Used to set a script which is run when you use a teleporter

telesave¤()\r#h

Does nothing in custom levels.

2.2 AND BELOW: Saves your game in the regular teleporter save, so don't use it!

text¤(color,x,y,lines)\w#h

Store a text box in memory with color, position and number of lines. Usually, the
position command is used after the text command (and its lines of text), which
will overwrite the coordinates given here, so these are usually left as 0.

color - cyan/player/blue/red/yellow/green/purple/gray/white/orange/transparent
x - The x position of the text box
y - The y position of the text box
lines - The number of lines

The ¤transparent¤ color was added in 2.4, along with arbitrary colored textboxes.\gn&Zg
The coordinates can be -500 to center the textbox in the respective axis (if you\g
don't want to use ¤#position(type,above/below)¤position¤).\gLwl&Zg

textboxactive\w#h

Makes all text boxes on the screen disappear except for the last created one

textboxtimer¤(frames)\w#h

Makes the next shown textbox disappear after a certain amount of frames, without
advancing the script.

frames - The amount of frames to wait before fading out

This command was added in 2.4.\g

textbuttons¤()\w#h

For the text box in memory, replace certain button placeholders by button labels
(such as keyboard keys or controller glyphs).

The replaced placeholders are:
- {b_act} - ACTION
- {b_int} - Interact
- {b_map} - Map
- {b_res} - Restart
- {b_esc} - Esc/Menu

This command was added in 2.4.\g

textcase¤(case)\w#h

If your level has translation files, and you have multiple text boxes with the
same text in a single script, this command can make them have unique translations.
Place it before a textbox.

case - The case number, between 1 and 255.

This command was added in 2.4.\g

textimage¤(image)\w#h

For the text box in memory, draw the given image. There can only be one image per
text box.

image - levelcomplete/gamecomplete, or an unknown value to remove the image

This command was added in 2.4.\g

textsprite¤(x,y,sprite,color)\w#h

For the text box in memory, draw the given sprite. There can be multiple sprites
per text box.

x - The x-coordinate of the sprite. This is relative to the text box.
y - The y-coordinate of the sprite. This is relative to the text box.
sprite - The sprite number of the sprite, from ¤sprites.png¤.\nn&Z
color - The color ID of the sprite.

This command was added in 2.4.\g

tofloor\w#h

Makes the player flip to the floor if they aren't already on the floor.

trinketbluecontrol¤()\b#h

Dialog of Victoria when she gives you a trinket in the real game

trinketscriptmusic\w#h

Plays Passion for Exploring.

trinketyellowcontrol¤()\b#h

Dialog of Vitellary when he gives you a trinket in the real game

undovvvvvvman¤()\w#h

Resets the player's hitbox to the normal size, sets their color to 0, and sets
their X position to 100.

untilbars¤()\w#h

Wait until ¤#cutscene()¤cutscene¤ or ¤#endcutscene()¤endcutscene¤ is completed.\nLwl&ZnLwl&Z

untilfade¤()\w#h

Wait until ¤#fadeout()¤fadeout¤ or ¤#fadein()¤fadein¤ is completed.\nLwl&ZnLwl&Z

vvvvvvman¤()\w#h

Makes the player 6x larger, sets their position to ¤(30,46)¤ and sets their color to\nn&Z
23¤.\n&Z

walk¤(direction,x)\w#h

Makes the player walk for the specified number of ticks

direction - left/right

warpdir¤(x,y,dir)\w#h

Changes the warp direction for room x,y, 1-indexed, to the given direction. This
could be checked with ifwarp, resulting in a relatively powerful extra flags/
variable system.

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

yellowcontrol\b#h

Start a conversation with Vitellary just like when you meet him in the main game
and press ENTER. Also creates an activity zone afterwards.
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
3 - Potential for Anything
4 - Passion for Exploring
5 - Presenting VVVVVV
6 - Predestined Fate
7 - Popular Potpourri
8 - Pipe Dream
9 - Pressure Cooker
10 - Paced Energy
11 - Piercing the Sky

Music numbers (internal)\h#

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
1013 - End level with stars
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
subj = "Credits",
imgs = {"images/credits.png"},
cont = [[
\0















Credits\wh#
\C=

Ved is made by Dav999

Further code contributors: Info Teddy

Some of the graphics and the font were made by Reese Rivers

Russian translation: CreepiX, Cheep, Omegaplex
Esperanto translation: Reese Rivers
German translation: r00ster
French translation: RhenaudTheLukark
Spanish translation: Valso22/naether
Indonesian translation: _march31onne/Marchionne Evangelisti


Special thanks to:\h#


Terry Cavanagh for making VVVVVV

Everyone who reported bugs, came up with ideas and motivated me to make this!
\
\
\


License\h#
\
Copyright 2015-2023  Dav999
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

VVVVVV assets\h#

Ved includes some graphics assets from VVVVVV. VVVVVV and its assets are copyright
of Terry Cavanagh. For more information about the license that applies to VVVVVV
and its assets, see ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ and ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md¤ in ¤https://github.com/TerryCavanagh/VVVVVV¤VVVVVV's GitHub\nLClnLClnLCl
https://github.com/TerryCavanagh/VVVVVV¤repository¤.\LCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
