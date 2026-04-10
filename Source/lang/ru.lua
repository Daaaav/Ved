-- Language file for Ved
--- Language: ru (ru)
--- Last converted: 2026-04-11 00:49:30 (CEST)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n%10==1 and n%100~=11 and 0 or n%10>=2 and n%10<=4 and (n%100<10 or n%100>=20) and 1 or 2) end

L = {

TRANSLATIONCREDIT = "Переведено CreepiX'ом, cheep the peanut'ом и Omegaplex'ом", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Ваша версия LÖVE устарела. Пожалуйста, используйте версию 0.9.1 или выше.\nЗагрузите LÖVE на https://love2d.org/.",
OUTDATEDLOVE090 = "Ved больше не поддерживает LÖVE 0.9.0. К счастью, LÖVE 0.9.1 и выше будут работать.\nВы можете скачать последнюю версию LÖVE с https://love2d.org/.",

OSNOTRECOGNIZED = "Ваша ОС ($1) не опознана! Идёт возврат к первичным настройкам файловой системы; ваши уровни находятся в:\n\n$2",
MAXTRINKETS = "Достигнуто максимальное количество штуковин ($1).",
MAXCREWMATES = "Достигнуто максимальное количество членов экипажа ($1).",
UNSUPPORTEDTOOL = "Неподдерживаемый инструмент! Инструмент: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Папка с уровнями не найдена. Пожалуйста, убедитесь что $1 существует и попробуйте снова.",
MAPSAVEDAS = "Снимок карты $1 сохранён!",
RAWENTITYPROPERTIES = "Вы можете изменять значения свойств этого объекта.",
UNKNOWNENTITYTYPE = "Неизвестный тип объекта $1",
WARPTOKENENT404 = "Объект варп-токена больше не существует!",
SPLITFAILED = "Разделение провалено! Может, у вас слишком много строк между командами text и speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Все флаги использованы, новые имена флагов в этом скрипте не будут ассоциироваться с номерами флагов. Попытка запустить этот скрипт в VVVVVV может привести к ошибке. Уберите все ссылки к флагам которые вам не нужны и попробуйте ещё раз.",
NOFLAGSLEFT_LOADSCRIPT = "Больше нет свободных флагов, поэтому скрипт загрузки использующий новый флаг не может быть создан. Вместо этого был создан скрипт загрузки, загружающий целевой скрипт при помощи iftrinkets(0,$1). Попробуйте убрать все использования ненужных флагов и повторите попытку.",
LEVELOPENFAIL = "Невозможно открыть $1.vvvvvv.",
SIZELIMIT = "Максимальный размер уровня $1x$2.\n\nРазмер уровня будет изменён на $3x$4.",
SCRIPTALREADYEXISTS = "Скрипт \"$1\" уже существует!",
FLAGNAMENUMBERS = "Имя флага не может состоять только из цифр.",
FLAGNAMECHARS = "Имя флага не может содержать скобки, запятые или пробелы.",
FLAGNAMEINUSE = "Имя флага $1 уже используется флагом $2",
DIFFSELECT = "Выберите второй уровень для сравнения. Уровень, который вы выберете, будет считаться за старую версию.",
SUREQUITNEW = "Есть несохранённые изменения. Сохранить их перед выходом?",
SURENEWLEVELNEW = "Есть несохранённые изменения. Сохранить их перед созданием нового уровня?",
SUREOPENLEVEL = "Есть несохранённые изменения. Сохранить их перед открытием нового уровня?",
NAMEFORFLAG = "Имя флага $1:",
SCRIPT404 = "Скрипт \"$1\" не существует!",
ENTITY404 = "Объект #$1 не существует!",
GRAPHICSCARDCANVAS = "Ваша видеокарта или её драйвер не поддерживает данную функцию!",
MAXTEXTURESIZE = "Ваша видеокарта или её драйвер не поддерживает изображение с масштабом $1x$2.\n\nПредел масштаба на этой системе - $3x$3.",
SUREDELETESCRIPT = "Вы уверены, что хотите удалить скрипт \"$1\"?",
SUREDELETENOTE = "Вы уверены, что хотите удалить эту заметку?",
THREADERROR = "Ошибка потока выполнения!",
WHATDIDYOUDO = "Что вы наделали?!",
UNDOFAULTY = "Что ты делаешь?",
SOURCEDESTROOMSSAME = "Изначальная комната и конечная комната совпадают!",
COORDS_OUT_OF_RANGE = "Что? Этих координат даже нету в этом измерении!",
UNKNOWNUNDOTYPE = "Неизвестный тип отмены \"$1\"!",
MDEVERSIONWARNING = "Этот уровень был сделан в более поздней версии Ved, и может содержать информацию, которая будет потеряна при сохранении.",
FORGOTPATH = "Вы забыли указать путь!",
LIB_LOAD_ERRMSG = "Не удалось загрузить необходимую библиотеку. Пожалуйста, свяжитесь с Dav999 и расскажите о проблеме.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nДля решения проблемы попробуйте установить GCC, если он не установлен.",

SELECTCOPY1 = "Выберите комнату для копирования",
SELECTCOPY2 = "Выберите координаты для копии этой комнаты",
SELECTSWAP1 = "Выберите первую комнату для замены",
SELECTSWAP2 = "Выберите вторую комнату для замены",

TILESETCHANGEDTO = "Набор тайлов изменён на $1",
TILESETCOLORCHANGEDTO = "Цвет тайлов изменён на $1",
ENEMYTYPECHANGED = "Тип врагов изменён",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Выбран режим $1",
CHANGEDTOMODEAUTO = "Автоматический",
CHANGEDTOMODEMANUAL = "Ручной",
CHANGEDTOMODEMULTI = "Мульти",

BUSYSAVING = "Сохранение...",
SAVEDLEVELAS = "Уровень сохранён как $1.vvvvvv",

ROOMCUT = "Комната вырезана в буфер обмена",
ROOMCOPIED = "Комната скопирована в буфер обмена",
ROOMPASTED = "Комната вставлена из буфера обмена",

METADATAUNDONE = "Настройки уровня отменены",
METADATAREDONE = "Настройки уровня восстановлены",

BOUNDSFIRST = "Обозначьте первый угол границы", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Обозначьте второй угол", -- Old string: Click the bottom right corner

TILE = "Стена $1",
HIDEALL = "Скрыть все",
SHOWALL = "Показать все",
SCRIPTEDITOR = "Редактор скриптов",
FILE = "Файл",
NEW = "Создать",
OPEN = "Открыть",
SAVE = "Сохранить",
UNDO = "Отменить",
REDO = "Восстановить",
COMPARE = "Сравнить",
STATS = "Статистика",
SCRIPTUSAGES = "Использования",
EDITTAB = "Редактировать",
COPYSCRIPT = "Копировать",
SEARCHSCRIPT = "Поиск",
GOTOLINE = "Перейти к строке",
GOTOLINE2 = "Перейти к строке:",
INTERNALON = "Вн. скриптинг включён",
INTERNALOFF = "Вн. скриптинг отключён",
INTERNALON_LONG = "Режим внутреннего скриптинга включён",
INTERNALOFF_LONG = "Режим внутреннего скриптинга отключён",
INTERNALYESBARS = "Внутр. скрипт через say(-1)",
INTERNALNOBARS = "Внутр. скрипт ч. loadscript",
VIEW = "Просмотр",
SYNTAXHLOFF = "Подсветка включена",
SYNTAXHLON = "Подсветка отключена",
TEXTSIZEN = "Обычный текст",
TEXTSIZEL = "Большой текст",
INSERT = "Вставить",
HELP = "Помощь",
INTSCRWARNING_NOLOADSCRIPT = "Требуется загрузочный скрипт!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Скрипт, загружающий данный скрипт, не найден. Такой тип внутреннего скрипта вряд ли заработает так, как ожидается, если он не загружен с помощью другого скрипта.",
INTSCRWARNING_BOXED = "Прямая ссылка на рамку скрипта/терминал!",
INTSCRWARNING_BOXED_EXPL = "Обнаружены терминал или рамка скрипта, загружающие данный скрипт напрямую. Активация этих терминала или рамки скрипта вряд ли сработает так, как ожидается. Такой тип внутреннего скрипта должен быть загружен с помощью загрузочного скрипта.",
INTSCRWARNING_NAME = "Неподходящее название скрипта!",
INTSCRWARNING_NAME_EXPL = "Название данного скрипта содержит заглавную букву, пробел, скобку или запятую. Такой скрипт может быть загружен только с помощью терминала или рамки скрипта.",
COLUMN = "Символы: ",

BTN_OK = "OK",
BTN_CANCEL = "Отменить",
BTN_YES = "Да",
BTN_NO = "Нет",
BTN_APPLY = "Применить",
BTN_QUIT = "Выход",
BTN_DISCARD = "Не сохранять",
BTN_SAVE = "Сохранить",
BTN_CLOSE = "Закрыть",
BTN_LOAD = "Загрузить",
BTN_ADVANCED = "Продвинутые",

BTN_AUTODETECT = "Определить",
BTN_MANUALLY = "Заменить", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Повторить",

COMPARINGTHESE = "Сравнивание $1.vvvvvv с $2.vvvvvv",
COMPARINGTHESENEW = "Сравнивание (несохранённого уровня) и $1.vvvvvv",

RETURN = "Возврат",
CREATE = "Создать",
GOTO = "Перейти",
DELETE = "Удалить",
RENAME = "Переименовать",
CHANGEDIRECTION = "Изменить направление",
TESTFROMHERE = "Тестировать отсюда",
FLIP = "Перевернуть",
CYCLETYPE = "Изменить тип",
GOTODESTINATION = "Перейти к точке назначения",
GOTOENTRANCE = "Перейти к точке входа",
CHANGECOLOR = "Изменить цвет",
EDITTEXT = "Изменить текст",
COPYTEXT = "Копировать текст",
EDITSCRIPT = "Редактировать скрипт",
OTHERSCRIPT = "Изменить имя скрипта",
PROPERTIES = "Свойства",
CHANGETOHOR = "Сделать горизонтальной",
CHANGETOVER = "Сделать вертикальной",
RESIZE = "Изменить размер",
CHANGEENTRANCE = "Передвинуть вход",
CHANGEEXIT = "Передвинуть выход",
COPYENTRANCE = "Копировать вход",
LOCK = "Закрепить",
UNLOCK = "Открепить",

VEDOPTIONS = "Настройки Ved",
LEVELOPTIONS = "Настройки уровня",
MAP = "Карта",
SCRIPTS = "Скрипты",
SEARCH = "Поиск",
SENDFEEDBACK = "Обратная связь",
LEVELNOTEPAD = "Заметки",
PLUGINS = "Плагины",

BACKB = "Назад <<",
MOREB = "Вперёд >>",
AUTOMODE = "Режим: авто",
AUTO2MODE = "Режим: мульти",
MANUALMODE = "Режим: ручной",
ENEMYTYPE = "Тип: $1",
PLATFORMBOUNDS = "Границы платформ",
WARPDIR = "Тип варпа: $1",
ENEMYBOUNDS = "Границы врагов",
ROOMNAME = "Название комнаты",
ROOMOPTIONS = "Настройки комнаты",
ROTATE180 = "Повернуть на 180 градусов",
ROTATE180UNI = "Повернуть на 180°",
HIDEBOUNDS = "Скрыть границы",
SHOWBOUNDS = "Показать границы",

ROOMPLATFORMS = "Платформы", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Враги",

OPTNAME = "Название",
OPTBY = "Автор",
OPTWEBSITE = "Сайт",
OPTDESC = "Описание", -- If necessary, you can span multiple lines
OPTSIZE = "Размер",
OPTMUSIC = "Нач. музыка",
CAPNONE = "НЕТ",
ENTERLONGOPTNAME = "Название уровня:",

X = "х", -- Used for level size: 20x20

SOLID = "Твёрдый",
NOTSOLID = "Не твёрдый",

TSCOLOR = "Цвет $1",

LEVELSLIST = "Уровни",
LOADTHISLEVEL = "Загрузить: ",
ENTERNAMESAVE = "Сохранить как: ",
SEARCHFOR = "Поиск: ",

VERSIONERROR = "Невозможно проверить версию.",
VERSIONUPTODATE = "Ваша версия Ved последняя.",
VERSIONOLD = "Доступно обновление! Последняя версия: $1",
VERSIONCHECKING = "Проверка обновлений...",
VERSIONDISABLED = "Проверка обновлений отключена",
VERSIONCHECKNOW = "Проверить сейчас", -- Check for updates now

SAVENOSUCCESS = "Сохранение провалено! Ошибка: ",
INVALIDFILESIZE = "Неверный размер файла.",

EDIT = "Редактировать",
EDITWOBUMPING = "Редактировать без перемещения",
EDITWBUMPING = "Редактировать и переместить",
COPYNAME = "Копировать имя",
COPYCONTENTS = "Копировать контент",
DUPLICATE = "Дублировать",

NEWSCRIPTNAME = "Имя:",
CREATENEWSCRIPT = "Создать новый скрипт",

NEWNOTENAME = "Имя:",
CREATENEWNOTE = "Создать новую заметку",

ADDNEWBTN = "[Создать новую]",
IMAGEERROR = "[ОШИБКА ИЗОБРАЖЕНИЯ]",

NEWNAME = "Новое название:",
RENAMENOTE = "Переименовать заметку",
RENAMESCRIPT = "Переименовать скрипт",

LINE = "строка ",

SAVEMAP = "Сохранить карту",
COPYROOMS = "Копировать комнату",
SWAPROOMS = "Заменить комнаты",

MAP_STYLE = "Стиль карты",
MAP_STYLE_FULL = "Полный", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Миникарта", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Флаги",
ROOM = "комната",
CONTENTFILLER = "Контент",

FLAGUSED = "Использован   ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Не использован",
FLAGNONAME = "Нет имени",
USEDOUTOFRANGEFLAGS = "Использовано лишних флагов:",

VVVVVVSETUP = "Настройки VVVVVV",
CUSTOMVVVVVVDIRECTORY = "Папка VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Расположение VVVVVV, которое ожидает Ved:\n$1\n\nЭтот путь не должен вести к папке \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Не установлено пользовательское расположение VVVVVV.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Пользовательское расположение VVVVVV:\n$1\n\n",
LANGUAGE = "Язык",
DIALOGANIMATIONS = "Анимация диалогов",
FLIPSUBTOOLSCROLL = "Инвертировать направление прокручивания",
ADJACENTROOMLINES = "Индикаторы стен в соседних комнатах",
NEVERASKBEFOREQUIT = "Никогда не подтверждать выход, даже при наличии несохранённых изменений",
COORDS0 = "Отображать координаты, начиная с 0 (как во внутреннем скриптинге)",
ALLOWDEBUG = "Включить режим разработчика",
SHOWFPS = "Показать счётчик FPS",
CHECKFORUPDATES = "Проверять обновления",
PAUSEDRAWUNFOCUSED = "Приостановить рендеринг, когда окно неактивно",
ENABLEOVERWRITEBACKUPS = "Создавать бэкапы уровня при перезаписи файла",
AMOUNTOVERWRITEBACKUPS = "Кол-во бэкапов для каждого уровня",
SCALE = "Масштаб",
LOADALLMETADATA = "Показать метаданные (название, автор, описание и т.д.) у всех файлов в списке уровней",
COLORED_TEXTBOXES = "Использовать настоящие цвета текстовых рамок",
MOUSESCROLLINGSPEED = "Скорость прокрутки мыши",
BUMPSCRIPTSBYDEFAULT = "По умолчанию перемещать скрипты в начало списка при их редактировании",

SCRIPTSPLIT = "Разделить",
SPLITSCRIPT = "Разделить скрипты",
COUNT = "Счёт: ",
SMALLENTITYDATA = "инфо",

-- Stats screen
AMOUNTSCRIPTS = "Скрипты:",
AMOUNTUSEDFLAGS = "Флаги:",
AMOUNTENTITIES = "Объекты:",
AMOUNTTRINKETS = "Штуковины:",
AMOUNTCREWMATES = "Члены экипажа:",
AMOUNTINTERNALSCRIPTS = "Внутренние скрипты:",
TILESETUSSAGE = "Использование набора тайлов",
TILESETSONLYUSED = "(считаются только комнаты со стенами)",
AMOUNTROOMSWITHNAMES = "Комнаты с именами:",
PLACINGMODEUSAGE = "Режимы расположения стен:",
AMOUNTLEVELNOTES = "Заметки:",
AMOUNTFLAGNAMES = "Названия флагов:",
TILESUSAGE = "Использование стен",
AMOUNTTILES = "Стены:",
AMOUNTSOLIDTILES = "Твёрдые тайлы:",
AMOUNTSPIKES = "Шипы:",


UNEXPECTEDSCRIPTLINE = "Неизвестная строка скрипта без скрипта: $1",
DUPLICATESCRIPT = "Скрипт $1 - дубликат! Можно загрузить только один.",
MAPWIDTHINVALID = "Ширина карты неверная: $1",
MAPHEIGHTINVALID = "Высота карты неверна: $1",
LEVMUSICEMPTY = "В уровне нет музыки!",
NOT400ROOMS = "Количество данных в levelMetaData не равно 400!",
MOREERRORS = "Ещё $1",

DEBUGMODEON = "Режим разработчика включён",
FPS = "FPS",
STATE = "Статус",
MOUSE = "Мышь",

BLUE = "Синий",
RED = "Красный",
CYAN = "Голубой",
PURPLE = "Фиолетовый",
YELLOW = "Жёлтый",
GREEN = "Зелёный",
GRAY = "Серый",
PINK = "Розовый",
BROWN = "Коричневый",
RAINBOWBG = "Радужный фон",

SYNTAXCOLORS = "Цвета текста",
SYNTAXCOLORSETTINGSTITLE = "Настройки подсветки команд в скриптах",
SYNTAXCOLOR_COMMAND = "Команда",
SYNTAXCOLOR_GENERIC = "Обычный",
SYNTAXCOLOR_SEPARATOR = "Разделитель",
SYNTAXCOLOR_NUMBER = "Номер",
SYNTAXCOLOR_TEXTBOX = "Текст",
SYNTAXCOLOR_ERRORTEXT = "Неизвестная команда",
SYNTAXCOLOR_CURSOR = "Курсор",
SYNTAXCOLOR_FLAGNAME = "Имя флага",
SYNTAXCOLOR_NEWFLAGNAME = "Новое имя флага",
SYNTAXCOLOR_COMMENT = "Комментарий",
SYNTAXCOLOR_WRONGLANG = "Простая команда в режиме вн. скриптинга или наоборот",
RESETCOLORS = "Сбросить цвета",
STRINGNOTFOUND = "\"$1\" не найдена",

-- L.MAL is concatenated with an error message
MAL = "Файл уровня повреждён: ",

LOADSCRIPTMADE = "Загрузочный скрипт создан",
COPY = "Копировать",
CUSTOMSIZE = "Пользовательский размер кисти: $1x$2",
SELECTINGA = "Выбор - кликните на верхний левый угол",
SELECTINGB = "Выбор: $1x$2",
TILESETSRELOADED = "Тайлы и спрайты перезагружены",

BACKUPS = "Бэкапы",
BACKUPSOFLEVEL = "Бэкапы уровня $1",
LASTMODIFIEDTIME = "Последние изменения", -- List header
OVERWRITTENTIME = "Перезаписано", -- List header
SAVEBACKUP = "Сохранить в папку VVVVVV",
DATEFORMAT = "Формат даты",
TIMEFORMAT = "Формат времени",
SAVEBACKUPNOBACKUP = "Выберите уникальное имя для файла, иначе бэкап не будет создан!",

AUTOSAVECRASHLOGS = "Сохранять отчёты об ошибке автоматически",
MOREINFO = "Последняя информация",
COPYLINK = "Скопировать ссылку",
SCRIPTDISPLAY = "Показать",
SCRIPTDISPLAY_USED = "Использовано",
SCRIPTDISPLAY_UNUSED = "Не использ.",

RECENTLYOPENED = "Недавно открытые уровни",
REMOVERECENT = "Вы действительно хотите удалить этот уровень из списка недавно открытых?",
RESETCUSTOMBRUSH = "(ПКМ - изменение размера)",

DISPLAYSETTINGS = "Отображение\n/Масштаб",
DISPLAYSETTINGSTITLE = "Настройки отображения/масштаба",
SMALLERSCREEN = "Меньшая ширина окна (меняется с 896 пикс. на 800 пикс.)",
FORCESCALE = "Запрет изменений настроек масштаба",
SCALENOFIT = "Окно становится больше границ экрана при выбранном масштабе.",
SCALENONUM = "Данный масштаб неверен.",
MONITORSIZE = "Экран $1x$2",
VEDRES = "Разрешение Ved: $1x$2",
NONINTSCALE = "Масштаб с дробным значением",

USEFONTPNG = "Использовать font.png из папки графики VVVVVV как шрифт",
USELEVELFONTPNG = "Использовать font.png как шрифт индивидуально для каждого уровня",
REQUIRESHIGHERLOVE = " (необходим LÖVE версии $1 или выше)",
FPSLIMIT = "Ограничение FPS",

MAPRESOLUTION = "Разрешение", -- Map export size
MAPRES_ASSHOWN = "Как показано (макс. 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 на комнату)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 на комнату)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Левый верхний",
WIDTHHEIGHT = "Ширина и высота",
BOTTOMRIGHT = "Правый нижний",
RENDERERINFO = "Информация о рендере:",
MAPINCOMPLETE = "Карта ещё не готова (к моменту нажатия Сохранить), повторите попытку, когда она будет готова.",
KEEPDIALOGOPEN = "Не закрывать диалог",
TRANSPARENTMAPBG = "Прозрачный фон",
MAPEXPORTERROR = "Ошибка в создании карты.",
VIEWIMAGE = "Просмотр", -- Verb, view image
INVALIDLINENUMBER = "Пожалуйста, введите верное значение строки.",
OPENLEVELSFOLDER = "Открыть в\nпроводнике", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Переместить",
GOTOROOM = "Перейти к комнате",
ESCTOCANCEL = "[ESC для отмены]",

INVALIDFILENAME_WIN = "Windos не позволяет использовать следующие символы в названиях файлов:\n\n: * ? \" < > |\n\n(| как вертикальная черта)",
INVALIDFILENAME_MAC = "macOS не позволяет использовать символ : в названиях файлов.",

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
SEARCHRESULTS_SCRIPTS = "Скрипты [$1]",
SEARCHRESULTS_ROOMS = "Комнаты [$1]",
SEARCHRESULTS_NOTES = "Заметки [$1]",

ASSETS = "Ресурсы", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Невозможно воспроизвести этот саундтрек. Файл не существует или его тип не поддерживается.",
SOUNDPLAYERROR = "Невозможно воспроизвести этот звук. Файл не существует или его тип не поддерживается.",
MUSICLOADERROR = "Невозможно загрузить $1: ",
MUSICLOADERROR_TOOSMALL = "Музыкальный файл слишком мал, чтобы быть действительным.",
MUSICEXISTSYES = "Существует",
MUSICEXISTSNO = "Не существует",
ASSETS_FOLDER_EXISTS_NO = "Не существует — нажмите для создания",
ASSETS_FOLDER_EXISTS_YES = "Существует — нажмите для открытия",
NO_ASSETS_SUBFOLDER = "Папки \"$1\" нет",
LOAD = "Загрузить",
RELOAD = "Перезагрузить",
UNLOAD = "Отменить загрузку",
MUSICEDITOR = "Редактор музыки",
LOADMUSICNAME = "Загрузить .vvv",
SAVEMUSICNAME = "Сохранение .vvv",
INSERTSONG = "Вставить аудио как трек $1",
SUREDELETESONG = "Вы уверены, что хотите удалить песню $1?",
SONGOPENFAIL = "Невозможно открыть $1, трек не заменён.",
SONGREPLACEFAIL = "Что-то пошло не так в процессе замены трека.",
BYTES = "$1 Б",
KILOBYTES = "$1 КБ",
MEGABYTES = "$1 МБ",
GIGABYTES = "$1 ГБ",
TERABYTES = "$1 ТБ",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "Нельзя использовать символ \"$1\" в названиях скриптов!",
MUSICTITLE = "Название: ",
MUSICARTIST = "Автор: ",
MUSICFILENAME = "Название файла: ",
MUSICNOTES = "Примечания:",
SONGMETADATA = "Метаданные трека $1",
MUSICFILEMETADATA = "Метаданные файла",
MUSICEXPORTEDON = "Экспортировано: ", -- Followed by date and time
SAVEMETADATA = "Сохранить метаданные",
SOUNDS = "Звуки",
GRAPHICS = "Графика",
FILEOPENERNAME = "Имя: ",
PATHINVALID = "Неверный путь.",
DRIVES = "Диски", -- like C: or F: on Windows
DOFILTER = "Показывать только *$1", -- "*.txt" for example
DOFILTERDIR = "Только расположения",
FILEDIALOGLUV = "Извините, не удаётся распознать Вашу систему, поэтому файловый диалог не работает.",
RESET = "По умолчанию",
CHANGEVERB = "Изменить", -- verb
LOADIMAGE = "Загрузить изображение",
GRID = "Сетка",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "Уровень должен быть сохранён перед применением пользовательских ресурсов.",
CREATE_ASSETS_FOLDER = "Создать папку пользовательских ресурсов для этого уровня?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "Папка с VVVVVV, кажется, не существует. Хотите её создать?",
CREATE_LEVELS_FOLDER = "Папка с уровнями, кажется, не существует. Хотите создать?",
CREATE_FOLDER_FAIL = "Не удалось создать папку.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Папка с ресурсами $1",

OPAQUEROOMNAMEBACKGROUND = "Сделать фон названия комнаты непрозрачным",
PLATVCHANGE_TITLE = "Изменить скорость платформы",
PLATVCHANGE_MSG = "Скорость:",
PLATVCHANGE_INVALID = "Необходимо ввести число.",
RENAMESCRIPTREFERENCES = "Переименовать ссылки",
PLATFORMSPEEDSLIDER = "Скор.",

TRINKETS = "Штуковины",
LISTALLTRINKETS = "Показать все штуковины", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Список штуковин",
NOTRINKETSINLEVEL = "В этом уровне нет штуковин.",
CREWMATES = "Члены экипажа",
LISTALLCREWMATES = "Показать всех членов экипажа", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Список всех членов экипажа",
NOCREWMATESINLEVEL = "В этом уровне нет членов экипажа.",
SHIFTROOMS = "Сдвинуть комнаты", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 сек",
ROOMNUM = "Комната $1",
SOUNDNUM = "Звук $1",
TRACKNUM = "Трек $1",
STOPSMUSIC = "Останавливает музыку",
PLAYSOUND = "Проиграть звук",
EDITSCRIPTWOBUMPING = "Редактировать без перемещения",
EDITSCRIPTWBUMPING = "Редактировать и переместить",
CLICKONTHING = "Нажмите \"$1\"",
ORDRAGDROP = "или перетащите файл сюда", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "В данном уровне больше одной точки старта!",
STARTPOINTNOTFOUND = "Нет точки старта!",

MAPBIGGERTHANSIZELIMIT = "Размер карты $1 на $2 больше $3 на $4!",
BTNOVERRIDE = "Заменить",
TARGETPLATFORM = "Для издания", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Испытания временем",
TIMETRIALTRINKETS = "Количество штуковин",
TIMETRIALTIME = "Минимум",
SUREDELETETRIAL = "Вы уверены, что хотите удалить испытание временем \"$1\"?",

CUT = "Вырезать",
PASTE = "Вставить",
SELECTWORD = "Выделить слово",
SELECTLINE = "Выделить строку",
SELECTALL = "Выделить всё",
INSERTRAWHEX = "Вставить символ Unicode",
MOVELINEUP = "Поднять строку",
MOVELINEDOWN = "Опустить строку",
DUPLICATELINE = "Дублировать строку",

WHEREPLACEPLAYER = "Где вы хотите начать?",
YOUAREPLAYTESTING = "Вы находитесь в тестовом режиме",
LOCATEVVVVVV = "Выберите исполняемый файл $1", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Вы уже в тестовом режиме!",
PLAYTESTINGFAILED = "Произошёл сбой при запуске VVVVVV:\n$1\n\nЕсли необходимо поменять исполняемый файл VVVVVV, используемый для тестового режима, зажмите Shift при запуске тестового режима.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV закрылась с ошибкой $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "Кажется, у вас установлена версия VVVVVV 2.2 или старше. Пожалуйста, обновитесь до более поздней VVVVVV 2.3 или новее.",
VVVVVV_SOMETHING_HAPPENED = "Кажется, с VVVVVV что-то пошло не так.",
PLAYTESTUNAVAILABLE = "К сожалению, невозможно тестировать на $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Пожалуйста, выберите файл \"$1\".",

PLAYTESTINGOPTIONS = "Тестовый режим",
PLAYTESTING_EXECUTABLE_NOTSET = "Вы ещё не указали исполняемый файл $1 для тестового режима.\nVed попросит указать его при первом запуске уровня $2 в тестовом режиме.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "Исполняемый файл $1 для тестового режима указан как:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Произошла ошибка при попытке найти VVVVVV. Попробуйте ввести путь к игре вручную.",
FIND_V_EXE_FOUNDERROR = "Найдено что-то, похожее на VVVVV, но не удаётся найти подходящий путь к исполняемому файлу. Убедитесь, что вы не используете старую версию игры (требуется 2.3 или новее) или попробуйте задать путь к исполняемому файлу вручную.",
FIND_V_EXE_NOTFOUND = "Кажется, сейчас VVVVVV не запущена. Убедитесь в том, что вы запустили игру и попробуйте снова.",
FIND_V_EXE_MULTI = "Найдено несколько запущеных экземпляров VVVVVV. Убедитесь в том, что у вас запущена только одна версия игры и попробуйте снова.",

FIND_V_EXE_EXPLANATION = "Ved требуется VVVVVV для режима тестирования, но для этого сначала необходимо задать папку к игре.\n\n\nЧтобы автоматически определить VVVVVV - просто запустите игру, если она не запущена, и нажмите \"Определить\".",

VCE_REMOVED = "VVVVVV: Community Edition больше не разрабатывается и поддержка VVVVVV-CE-уровней была удалена из Ved. Этот уровень будет считаться обычным VVVVVV-уровнем. Для получения подробной информации смотрите https://vsix.dev/vce/status/",

VVVVVV_VERSION = "Версия VVVVVV", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Авто",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Все плагины",
ALL_PLUGINS_MOREINFO = "Перейдите на ¤https://tolp.nl/ved/plugins.php¤эту страницу¤ для большей информации о плагинах.\\nLCl",
ALL_PLUGINS_FOLDER = "Ваша папка плагинов:",
ALL_PLUGINS_NOPLUGINS = "У вас пока нет никаких плагинов.",

PLUGIN_NOT_SUPPORTED = "[Этот плагин не поддерживается, так как ему необходима версия Ved $1 и выше!]\\r",
PLUGIN_AUTHOR_VERSION = "Автор: $1, версия $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Создать загрузочный скрипт",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Нет",
CREATE_LOAD_SCRIPT_RUNONCE = "Одноразовый",
CREATE_LOAD_SCRIPT_REPEATING = "Многоразовый",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Не создавать загрузочный скрипт",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Этот терминал перенаправит напрямую на скрипт, минуя загрузочный.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Эта рамка скрипта перенаправит напрямую на скрипт, минуя загрузочный.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Создать загрузочный скрипт, запускающийся один раз",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Этот терминал перенаправит на новый загрузочный скрипт, который загрузит обычный скрипт только один раз за прохождение. Ved выберет неиспользуемый флаг.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Эта рамка скрипта перенаправит на новый загрузочный скрипт, который загрузит обычный скрипт только один раз за прохождение. Ved выберет неиспользуемый флаг.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Создать многоразовый загрузочный скрипт",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Этот терминал перенаправит на новый загрузочный скрипт, который загрузит обычный скрипт.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Эта рамка скрипта перенаправит на новый загрузочный скрипт, который загрузит обычный скрипт.",

CUSTOM_SIZED_BRUSH = "Пользовательская кисть",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Кисть",
CUSTOM_SIZED_BRUSH_STAMP = "Штамп",
CUSTOM_SIZED_BRUSH_TILESET = "Набор тайлов",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Пользовательский размер кисти",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Выберите необходимый размер кисти.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Штамп из комнаты",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Выберите тайлы из комнаты для создания штампа.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Штамп для набора тайлов",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Выберите тайлы из набора для создания штампа. Работает только в ручном режиме.",

ADVANCED_LEVEL_OPTIONS = "Продвинутые настройки уровня",
ONEWAYCOL_OVERRIDE = "Перекрашивать односторонние тайлы в польз. ресурсах (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Создать ZIP-архив этой версии уровня для возможности поделиться", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Сохранить ZIP",
ZIP_BUSY_TITLE = "Создание ZIP...",
ZIP_LOVE11_ONLY = "Для создания ZIP-файла требуется LÖVE $1 или выше", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP сохранён!",
ZIP_SAVING_FAIL = "Не удалось сохранить ZIP-файл!",

OPENFOLDER = "Открыть папку", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Шрифт уровня",

TEXTBOXCOLORS_BUTTON = "Цвета текста",
TEXTBOXCOLORS_TITLE = "Цвета текстовых рамок",
TEXTBOXCOLORS_RENAME = "Переименовать цвет \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Дублировать цвет \"$1\"",
TEXTBOXCOLORS_CREATE = "Добавить цвет",

LIB_LOAD_ERRMSG_BIDI = "Не удалось загрузить библиотеку поддержки отображения текста справа налево.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nВозможно, ваш антивирус блокирует её.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "У вас установлен $1 плагин, не поддерживаемый данной версией программы.",
		[1] = "У вас установлены $1 плагина, не поддерживаемые данной версией программы.",
		[2] = "У вас установлены $1 плагинов, не поддерживаемые данной версией программы.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Этот уровень провалил $1 проверку. Ошибка могла быть исправлена автоматически, но это всё равно может привести к сбоям и несоответствиям.",
		[1] = "Этот уровень провалил $1 проверки. Ошибки могли быть исправлены автоматически, но это всё равно может привести к сбоям и несоответствиям.",
		[2] = "Этот уровень провалил $1 проверок. Ошибки могли быть исправлены автоматически, но это всё равно может привести к сбоям и несоответствиям.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 использование в комнатах: $2",
		[1] = "$1 использования в комнатах: $2",
		[2] = "$1 использований в комнатах: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 использование в скриптах: $2",
		[1] = "$1 использования в скриптах: $2",
		[2] = "$1 использований в скриптах: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Объект в комнате [$1 $2] имеет $3 неверное свойство!",
		[1] = "Объект в комнате [$1 $2] имеет $3 неверных свойства!",
		[2] = "Объект в комнате [$1 $2] имеет $3 неверных свойств!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "Информация комнаты $1,$2 имеет $3 неверное свойство!",
		[1] = "Информация комнаты $1,$2 имеет $3 неверных свойства!",
		[2] = "Информация комнаты $1,$2 имеет $3 неверных свойств!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Всего показано: $1",
		[1] = "Всего показано: $1",
		[2] = "Всего показано: $1",
	},
	FLAGUSAGES = {
		[0] = "Использован $1 раз в скриптах: $2",
		[1] = "Использован $1 раза в скриптах: $2",
		[2] = "Использован $1 раз в скриптах: $2",
	},
	NOTALLTILESVALID = {
		[0] = "$1 тайл не является целым числом, большим или равным 0",
		[1] = "$1 тайла не являются целыми числами, большими или равными 0",
		[2] = "$1 тайлов не являются целыми числами, большими или равными 0",
	},
	BYTES = {
		[0] = "$1 байт",
		[1] = "$1 байта",
		[2] = "$1 байтов",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 изображение изменено",
		[1] = "$1 изображения изменено",
		[2] = "$1 изображений изменено",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 звуковой эффект изменён",
		[1] = "$1 звуковых эффекта изменено",
		[2] = "$1 звуковых эффектов изменено",
	},
}

toolnames = {

"Стена",
"Фон",
"Шипы",
"Штуковина",
"Чекпоинт",
"Исчезающая платформа",
"Конвеер",
"Движущаяся платформа",
"Враг",
"Гравитационная линия",
"Текст",
"Терминал",
"Рамка скрипта",
"Варп-токен",
"Варп-линия",
"Член экипажа",
"Точка старта",

}

subtoolnames = {

[1] = {"1x1", "3x3", "5x5", "7x7", "9x9", "Залить горизонтально", "Залить вертикально", "Пользовательский размер кисти", "Заливка", "Картошка для Магических Вещей"},
[2] = {},
[3] = {"1x1", "Авто-расширение Л+П", "Авто-расширение Л", "Авто-расширение П"},
[4] = {},
[5] = {"Нормальный", "Перевёрнутый"},
[6] = {},
[7] = {"Маленький П", "Маленький Л", "Большой П", "Большой Л"},
[8] = {"Вниз", "Вверх", "Влево", "Вправо"},
[9] = {},
[10] = {"Горизонтальная", "Вертикальная"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Вход", "Выход"},
[15] = {},
[16] = {"Розовый", "Жёлтый", "Красный", "Зелёный", "Синий", "Голубой", "Случайный"},
[17] = {"Вправо", "Влево"},

}

warpdirs = {

[0] = "нет",
[1] = "горизонтальный",
[2] = "вертикальный",
[3] = "полный",

}

warpdirchangedtext = {

[0] = "Варп комнаты выключен",
[1] = "Тип варпа изменён на горизонтальный",
[2] = "Тип варпа изменён на вертикальный",
[3] = "Варп во всех направлениях",

}

langtilesetnames = {

short0 = "Косм. Ст.",
long0 = "Космическая Станция",
short1 = "Космос",
long1 = "Космос",
short2 = "Лаб.",
long2 = "Лаборатория",
short3 = "Варп-Зона",
long3 = "Варп-Зона",
short4 = "Корабль",
long4 = "Корабль",
short5 = "Башня",
long5 = "Башня",

}

ERR_VEDHASCRASHED = "Ved вылетел!"
ERR_VEDVERSION = "Версия Ved:"
ERR_LOVEVERSION = "Версия LÖVE:"
ERR_STATE = "Статус:"
ERR_OS = "ОС:"
ERR_TIMESINCESTART = "Прошло времени с начала запуска:"
ERR_PLUGINS = "Плагины:"
ERR_PLUGINSNOTLOADED = "(не загружено)"
ERR_PLUGINSNONE = "(нет)"
ERR_PLEASETELLDAV = "Пожалуйста, расскажите Dav999 об этой проблеме.\n\n\nДетали: (нажмите Ctrl+C/Cmd+C чтобы скопировать в буфер обмена)\n\n"
ERR_INTERMEDIATE = " (Версия между официально выпущенными версиями)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (слишком новое)"

ERR_PLUGINERROR = "Ошибка плагина!"
ERR_FILE = "Файл для редактирования:"
ERR_FILEEDITORS = "Плагины редактирующие этот файл:"
ERR_CURRENTPLUGIN = "Плагин вызвавший ошибку:"
ERR_PLEASETELLAUTHOR = "Плагин должен был редактровать код Ved, но код для замены не был найден.\nВозможно это из-за конфликта между двумя плагинами или новая версия Ved не поддерживает этот плагин.\n\nДетали: (нажмите Ctrl+C/Cmd+C чтобы скопировать в буфер обмена)\n\n"
ERR_CONTINUE = "Вы можете продолжить, нажав Esc или Enter, но эта ошибка может вызвать глюки."
ERR_OPENPLUGINSFOLDER = "Клавишей F можно открыть папку с плагинами, чтобы исправить или удалить плагин, вызывающий проблему. После этого перезапустите Ved."
ERR_REPLACECODE = "Это не найдено в %s.lua:"
ERR_REPLACECODEPATTERN = "Это не найдено в %s.lua (как шаблон):"
ERR_LINESTOTAL = "%i строк всего"

ERR_SAVELEVEL = "Чтобы сохранить копию уровня, нажмите S"
ERR_SAVESUCC = "Уровень сохранён как %s!"
ERR_SAVEERROR = "Ошибка сохранения! %s"
ERR_LOGSAVED = "Больше сведений в отчёте об ошибке:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Свойства уровня",
		changedrooms = "Изменённые комнаты",
		changedroommetadata = "Изменённая информация комнат",
		entities = "Объекты",
		scripts = "Скрипты",
		flagnames = "Флаги",
		levelnotes = "Заметки",
	},
	levelpropertiesdiff = {
		Title = "Название было изменено с \"$1\" на \"$2\"",
		Creator = "Автор был изменён с \"$1\" на \"$2\"",
		website = "Сайт был изменён с \"$1\" на \"$2\"",
		Desc1 = "Описание 1 было изменено с \"$1\" на \"$2\"",
		Desc2 = "Описание 2 было изменено с \"$1\" на \"$2\"",
		Desc3 = "Описание 3 было изменено с \"$1\" на \"$2\"",
		mapsize = "Размер карты был изменён с $1x$2 на $3x$4",
		mapsizenote = "ЗАМЕТЬТЕ: Размер карты был изменён с $1x$2 на $3x$4.\\o\nКомнаты вне $5x$6 не перечислены.\\o",
		levmusic = "Музыка изменена с $1 на $2",
	},
	rooms = {
		added1 = "Добавлена ($1,$2) ($3)\\G",
		added2 = "Добавлена ($1,$2) ($3 -> $4)\\G",
		changed1 = "Изменена ($1,$2) ($3)\\Y",
		changed2 = "Изменена ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Очищены все тайлы в ($1,$2) ($3)\\R",
		cleared2 = "Очищены все тайлы в ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Комната $1,$2:",
		changed1 = "Комната $1,$2 ($3):",
		roomname = "Название изменено с \"$1\" на \"$2\"\\Y",
		roomnameremoved = "Название \"$1\" убрано\\R",
		roomnameadded = "Комната названа \"$1\"\\G",
		tileset = "Набор тайлов $1 с цветом $2 изменён на набор $3 с цветом $4\\Y",
		platv = "Скорость платформ изменена с $1 на $2\\Y",
		enemytype = "Тип врагов изменён с $1 на $2\\Y",
		platbounds = "Рамка платформ изменена с $1,$2,$3,$4 на $5,$6,$7,$8\\Y",
		enemybounds = "Рамка врагов изменена с $1,$2,$3,$4 на $5,$6,$7,$8\\Y",
		directmode01 = "Ручной режим включён\\G",
		directmode10 = "Ручной режим отключён\\R",
		warpdir = "Тип варпа изменён с $1 на $2\\Y",
	},
	entities = {
		added = "Добавлен объект типа $1 на позицию $2,$3 в комнате ($4,$5)\\G",
		removed = "Удалён объект типа $1 с позиции $2,$3 в комнате ($4,$5)\\R",
		changed = "Изменён тип объекта $1 на позиции $2,$3 в комнате ($4,$5)\\Y",
		changedtype = "Изменён тип объекта $1 на тип $2 на позиции $3,$4 в комнате ($5,$6)\\Y",
		multiple1 = "Изменены объекты на позиции $1,$2 в комнате ($3,$4):\\Y",
		multiple2 = "на:",
		addedmultiple = "Добавлены объекты на позицию $1,$2 в комнате ($3,$4):\\G",
		removedmultiple = "Удалены объекты на позиции $1,$2 в комнате ($3,$4):\\R",
		entity = "Тип $1",
		incomplete = "Не все объекты были опознаны! Пожалуйста, сообщите об этом Dav999.\\r",
	},
	scripts = {
		added = "Добавлен скрипт \"$1\"\\G",
		removed = "Удалён скрипт \"$1\"\\R",
		edited = "Изменён скрипт \"$1\"\\Y",
	},
	flagnames = {
		added = "Задано имя флага $1 - \"$2\"\\G",
		removed = "Удалено имя \"$1\" флага $2\\R",
		edited = "Изменено имя флага $1 с \"$2\" на \"$3\"\\Y",
	},
	levelnotes = {
		added = "Добавлена заметка \"$1\"\\G",
		removed = "Удалена заметка \"$1\"\\R",
		edited = "Изменена заметка \"$1\"\\Y",
	},
	mde = {
		added = "Объект данных добавлен.\\G",
		removed = "Объект данных удалён.\\R",
	},
}

