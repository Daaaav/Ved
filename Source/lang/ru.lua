-- Language file for Ved
--- Language: ru (ru)
--- Last converted: 2023-11-26 03:11:36 (CET)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return (n%10==1 and n%100~=11 and 0 or n%10>=2 and n%10<=4 and (n%100<10 or n%100>=20) and 1 or 2) end

function fontpng_ascii(c)

end

L = {

TRANSLATIONCREDIT = "Перевод сделан CreepiX'ом, cheep the peanut'ом и Omegaplex'ом", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Ваша версия LÖVE устарела. Пожалуйста, используйте версию 0.9.1 или выше.\nЗагрузите LÖVE на https://love2d.org/.",
OUTDATEDLOVE090 = "Ved больше не поддерживает LÖVE 0.9.0. К счастью, LÖVE 0.9.1 и выше будут работать.\nВы можете скачать последнюю версию LÖVE с https://love2d.org/.",

OSNOTRECOGNIZED = "Ваша ОС ($1) не опознана! Идёт возврат к первичным настройкам файловой системы; ваши уровни находятся в:\n\n$2",
MAXTRINKETS = "Было достигнуто максимальное количество тринкетов ($1).",
MAXCREWMATES = "Было достигнуто максимальное количество членов экипажа ($1).",
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

TILESETCHANGEDTO = "Набор плиток изменён на $1",
TILESETCOLORCHANGEDTO = "Цвет плиток изменён на $1",
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

BOUNDSFIRST = "Click the first corner of the bounds", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Click the last corner", -- Old string: Click the bottom right corner

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
INTERNALYESBARS = "Вн. скрипт с say(-1)",
INTERNALNOBARS = "Вн. скрипт с загруз. скр.",
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
MAP_STYLE_VTOOLS = "VИнстр-ты", -- Max 12*2 characters

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
PAUSEDRAWUNFOCUSED = "Не прогружать, когда окно не активно",
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
AMOUNTTRINKETS = "Тринкеты:",
AMOUNTCREWMATES = "Члены экипажа:",
AMOUNTINTERNALSCRIPTS = "Внутренние скрипты:",
TILESETUSSAGE = "Использование набора плиток",
TILESETSONLYUSED = "(считаются только комнаты со стенами)",
AMOUNTROOMSWITHNAMES = "Комнаты с именами:",
PLACINGMODEUSAGE = "Режимы расположения стен:",
AMOUNTLEVELNOTES = "Заметки:",
AMOUNTFLAGNAMES = "Названия флагов:",
TILESUSAGE = "Использование стен",
AMOUNTTILES = "Стены:",
AMOUNTSOLIDTILES = "Твёрдые плитки:",
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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "Файл уровня повреждён: ",
METADATACORRUPT = "Данные отсутствуют или повреждены.",
METADATAITEMCORRUPT = "Данные для $1 отсутствуют или повреждены.",
TILESCORRUPT = "Плитки отсутствуют или повреждены.",
ENTITIESCORRUPT = "Объекты отсутствуют или повреждены.",
LEVELMETADATACORRUPT = "Данные о комнате отсутствуют или повреждены.",
SCRIPTCORRUPT = "Скрипты отсутствуют или повреждены.",

LOADSCRIPTMADE = "Загрузочный скрипт создан",
COPY = "Копировать",
CUSTOMSIZE = "Пользовательский размер кисти: $1x$2",
SELECTINGA = "Выбор - кликните на верхний левый угол",
SELECTINGB = "Выбор: $1x$2",
TILESETSRELOADED = "Плитки и спрайты перезагружены",

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
KILOBYTES = "$1 КБ",
MEGABYTES = "$1 МБ",
GIGABYTES = "$1 ГБ",
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

TRINKETS = "Тринкеты",
LISTALLTRINKETS = "Показать все тринкеты", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Список тринкетов",
NOTRINKETSINLEVEL = "В этом уровне нет тринкетов.",
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

CONFIRMBIGGERSIZE = "Вы выбрали размер $1 на $2, что больше, чем размер карты $3 на $4. Снаружи обычной карты $3 на $4 комнаты и их свойства переносятся на обратную сторону, но они искажаются. Из-за этого не получаются ни новые комнаты, ни больше их свойств.\n\nНажмите \"Да\", если знаете, что делаете, и хотите карту размером побольше. Нажмите \"Нет\", чтобы выставить размер карты $5 на $6.\n\nЕсли Вы не уверены, нажмите \"Нет\".",
MAPBIGGERTHANSIZELIMIT = "Размер карты $1 на $2 больше $3 на $4! (Размеры больше $3 на $4 не поддерживаются)",
BTNOVERRIDE = "Заменить",
TARGETPLATFORM = "Для издания", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Испытания временем",
TIMETRIALTRINKETS = "Количество тринкетов",
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

VVVVVV_VERSION = "VVVVVV version", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Auto",
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
CUSTOM_SIZED_BRUSH_TILESET = "Набор плиток",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Пользовательский размер плиток",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Выберите необходимый размер кисти.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Штамп из комнаты",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Выберите плитки из комнаты для создания штампа.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Штамп для набора плиток",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Выберите плитки из набора для создания штампа. Работает только в ручном режиме.",

ADVANCED_LEVEL_OPTIONS = "Продвинутые настройки уровня",
ONEWAYCOL_OVERRIDE = "Перекрашивать односторонние плитки в польз. ресурсах (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

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
		[0] = "$1 плитка не является целым числом, большим или равным 0",
		[1] = "$1 плитки не являются целыми числами, большими или равными 0",
		[2] = "$1 плиток не являются целыми числами, большими или равными 0",
	},
	BYTES = {
		[0] = "$1 байт",
		[1] = "$1 байта",
		[2] = "$1 байтов",
	},
	LITERALNULLS = {
		[0] = "В файле $1 нулевой байт!",
		[1] = "В файле $1 нулевых байта!",
		[2] = "В файле $1 нулевых байтов!",
	},
	XMLNULLS = {
		[0] = "В файле $1 нулевой XML байт!",
		[1] = "В файле $1 нулевых XML байта!",
		[2] = "В файле $1 нулевых XML байтов!",
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
"Тринкет",
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
		cleared1 = "Очищены все плитки в ($1,$2) ($3)\\R",
		cleared2 = "Очищены все плитки в ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Комната $1,$2:",
		changed1 = "Комната $1,$2 ($3):",
		roomname = "Название изменено с \"$1\" на \"$2\"\\Y",
		roomnameremoved = "Название \"$1\" убрано\\R",
		roomnameadded = "Комната названа \"$1\"\\G",
		tileset = "Набор плиток $1 с цветом $2 изменён на набор $3 с цветом $4\\Y",
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
subj = "Перед началом",
imgs = {},
cont = [[
Перед началом\wh#
\C=

Данная статья поможет вам разобраться в том, как пользоваться Ved. Перед тем, как
начать пользоваться редактором, вам необходимо открыть уровень или создать новый.


Редактор\h#

С левой стороны расположен набор инструментов. Большинство из них имеют вариации,
которые отображаются правее. Чтобы переключать инструменты, используйте горячие
клавиши или прокручивайте колёсико мыши, зажав клавишу Shift или Ctrl. Менять
вариации инструментов можно, просто прокручивая колёсико мыши. Для дополнительной
информации смотрите пункт ¤Инструменты¤.\nwl
Вы можете нажимать правой кнопкой мыши на объекты для появления меню действий с
ними. Чтобы удалять объекты без появления меню, зажмите клавишу Shift и кликните
по объекту правой кнопкой мыши.
В правой стороне окна расположено множество кнопок и настроек. Верхние кнопки
относятся ко всему уровню, а нижние (те, что под кнопкой "Настройки уровня")
относятся только к данной комнате. Дополнительную информацию о кнопках смотрите в
соответствующих пунктах справки.

Папка уровней\h#

По умолчанию Ved использует ту же папку для хранения уровней, что и VVVVVV,
поэтому можно легко переключаться между редактором уровней VVVVVV и Ved. Если
Ved неверно обнаруживает папку с уровнями, вы можете указать к ней путь в
настройках Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Расположение стен",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Режимы расположения стен\wh#
\C=

Ved поддерживает три разных режима создания стен (плиток).

     Автоматический режим\h#0

          Этот режим является самым простым в применении. При размещении стен в 
          комнате их края будут автоматически располагаться правильно. Все стены
          и элементы фона будут одного набора и одинакового цвета.

     Мульти-набор\h#1

          Этот режим схож с автоматическим, но, используя его, можно работать с
          несколькими разными наборами плиток в одной комнате. Изменение набора
          не повлияет на уже установленные стены и фоновые элементы, и вы сможете
          использовать разные наборы в одной комнате.

     Ручной режим\h#2

          Также называется Direct Mode. В этом режиме вы можете располагать стены
          вручную, т.е. без ограничений в заранее подготовленных наборах. Края
          плиток и фоновых элементов не будут создаваться автоматически, что даёт
          вам полный контроль над внешним видом комнаты. Этот режим чаще всего 
          самый затяжной в использовании.
]]
},

{
splitid = "030_Tools",
subj = "Инструменты",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Инструменты\wh#
\C=

Вы можете использовать следующие инструменты для заполнения комнат уровня:

\0
   Стена\h#


Используется для установки стен (плиток).

\1
   Фон\h#


Используется для установки фоновых элементов.

\2
   Шипы\h#


Используется для установки шипов. Вы можете использовать вариацию автоматического
расширения для установки шипов на одной поверхности в один клик.

\3
   Тринкет\h#


Используется для установки тринкетов. Учтите, что в одном уровне может быть
максимум 100 тринкетов.

\4
   Чекпоинт\h#


Используется для установки чекпоинтов (контрольных точек).

\5
   Исчезающая платформа\h#


Используется для установки исчезающих платформ.

\6
   Конвеер\h#


Используется для установки конвееров.

\7
   Движущаяся платформа\h#


Используется для установки двигающихся платформ.

\8
   Враг\h#


Используется для установки врагов. Тип и цвет врагов определяется
настройкой типа врага и цветом набора плиток соответственно.

\9
   Гравитационная линия\h#


Используется для установки гравитационных линий.

\^0
   Текст\h#


Используется для установки текста в комнате.

\^1
   Терминал\h#


Используется для установки терминалов. Сначала установите терминал, затем введите
название скрипта. Для дополнительной информации смотрите справки о скриптах.

\^2
   Рамка скрипта\h#


Используется для установки скриптовых рамок. Сначала укажите левый верхний угол
рамки, затем правый нижний, затем введите название скрипта. Для дополнительной
информации смотрите справки о скриптах.

\^3
   Варп-токен\h#


Используется для установки варп-токенов. Сначала нажмите
там, где должен быть вход, затем там, где выход.

\^4
   Варп-линия\h#


Используется для установки варп-линий. Учтите, что варп-линии
могут быть расположены только по краям комнаты.

\^5
   Член экипажа\h#


Используется для установки членов экипажа, которых нужно спасти. Когда все члены
экипажа будут спасены, уровень будет пройден. Учтите, что в одном уровне может
быть максимум 100 членов экипажа.

\^6
   Точка старта\h#


Используется для установки стартовой позиции игрока.
]]
},
{
splitid = "040_Script_editor",
subj = "Редактор скриптов",
imgs = {},
cont = [[
Редактор скриптов\wh#
\C=

Вы можете управлять и изменять скрипты с помощью редактора скриптов.


Названия флагов\h#

Для удобства чтения скриптов есть возможность использовать названия флагов вместо
чисел. Если вы используете имя вместо числа, число будет автоматически связано с
этим названием. Также есть возможность выбора определённого числа для определён-
ного флага.

Режим внутреннего скриптинга\h#

Чтобы использовать внутренний скриптинг в Ved, вы можете включить соответствующий
режим в редакторе скриптов. Перейдите во вкладку ¤Режим вн. скриптинга¤ для большей\nwl
информации об этом режиме. Для дополнительной информации смотрите пункт "Внутрен-
ний скриптинг".

Разделение скриптов\h#

В редакторе скриптов есть возможность разделения скрипта на две части. Для этого
установите курсор на строке, которая должна быть первой в новом скрипте, затем
нажмите кнопку "Разделить" и введите название нового скрипта. После этого строки
перед курсором останутся в изначальном скрипте, а строки, начиная с положения
курсора и далее, будут перенесены в новый скрипт.

Переход к скриптам\h#

В строках с командами iftrinkets, ifflag, customiftrinkets или customifflag есть
возможность переходить к скриптам, используя кнопку "Перейти", когда курсор нахо-
дится на строке с этой командой. Также можно нажать ¤Alt+ПКМ¤ чтобы это сделать, или\nw
можно нажать ¤Alt+ЛКМ¤, чтобы вернуться на исходный скрипт.\nw
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Режим вн. скриптинга",
imgs = {},
cont = [[
Режим внутреннего скриптинга\wh#
\C=

Чтобы использовать внутренний скриптинг в Ved, нужно включить соответствующий
режим в редакторе скриптов. Таким образом, вам не придётся тратить усилия на то,
чтобы внутренний скриптинг работал. Не нужно будет использовать команды ¤say¤,\nwnw
считать строки, писать ¤text(1,0,0,4)¤ или ¤text,,,4¤ (смотря, какие у вас\nwnw
предпочтения). Просто пишите внутренние скрипты, как будто они были созданы для
основной игры. Вам даже не нужно заканчивать их командой ¤loadscript¤.\nw

Ved поддерживает разные способы внутреннего скриптинга. Чтобы представить их
технические отличия, приведём в пример следующий скрипт:

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

Строки этого внутреннего скрипта ¤светло-зелёные¤. Автоматически добавленные\nG
строки, необходимые для работы такого скриптинга, будут ¤серыми¤. Заметьте, что это\ng
всё немного упрощено. В примере Ved добавляет ¤#v¤ на концах серых строк, чтобы\nw
убедиться, что написанные вручную скрипты не будут изменены, и что слишком большие
блоки ¤say¤ разбиты на более мелкие.\nw

Для дополнительной информации о внутреннем скриптинге смотрите пункт "Внутренний
скриптинг".

Вн. скриптинг через loadscript\h#

Метод Loadscript, пожалуй, самый распространённый на сегодняшний день. Ved
поддерживал его ещё с версии alpha.

Для него требуется загрузочный скрипт (loadscript), который загрузит внутренний
скрипт. Loadscript, в самом распространённом случае, содержит обычную команду,
такую как ¤iftrinkets(0,вн. скрипт)¤, но вы можете использовать любую другую\nw
простую команду, например ¤ifflag¤ вместо ¤iftrinkets¤. Самое важное - это то,\nwnw
чтобы ваш внутренний скрипт загружался другим скриптом.

Внутренний скрипт желательно конвертировать подобным образом:

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

Строка ¤text(1,0,0,3)¤ должна быть последней, так как в редакторе скриптов\nw
VVVVVV должна быть хотя бы одна пустая строка после скрипта.

Также можно не использовать команду ¤squeak(off)¤ и использовать ¤text(1,0,0,4)\nwnw
вместо ¤text(1,0,0,3)¤, однако использование ¤squeak(off)¤ может сэкономить\nw
драгоценные строки в длинных скриптах.

Вн. скриптинг через say(-1)\h#

Метод say(-1) является устаревшим и имеет недостатки по сравнению с методом
loadscript: он всегда показывает чёрные полосы сверху и снизу экрана во время
кат-сцены, однако этот метод имеет преимущество, которое может быть важно в
уровнях с большим количеством скриптов: метод say(-1) не требует загрузочного
скрипта. Мы можем убрать ¤cutscene()¤ и ¤untilbars()¤ из нашего скрипта, так как\nwnw
они добавляются игрой по умолчанию при использовании этого метода.

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

Этот метод был добавлен в качестве дополнительного режима внутреннего скриптинга
в Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Горячие клавиши",
imgs = {},
cont = [[
Горячие клавиши в редакторе\wh#
\C=

Подсказка: вы можете удерживать ¤F9¤ в Ved для просмотра большинства горячих клавиш.\nC

Большинство горячих клавиш из VVVVVV могут быть так же применены и в Ved.

F1¤  Изменить набор\C
F2¤  Изменить цвет\C
F3¤  Изменить тип врагов\C
F4¤  Рамка врагов\C
F5¤  Рамка платформ\C

F10¤  Ручной/автоматический режим (direct mode/undirect mode)\C

W¤  Изменить тип варпа\C
E¤  Изменить название комнаты\C

L¤  Загрузить уровень\C
S¤  Сохранить уровень\C

Z¤  Кисть 3x3\C
X¤  Кисть 5x5\C

< ¤и¤ >¤  Сменить инструмент\CnC
Ctrl/Cmd+< ¤and¤ Ctrl/Cmd+>¤  Сменить вариацию инструмента\CnC

Другие горячие клавиши\h#

Ved предоставляет множество других горячих клавиш.

Основной редактор\gh#

Ctrl+P¤  Перейти к комнате с точкой старта\C
Ctrl+S¤  Быстрое сохранение\C
Ctrl+X¤  Вырезать комнату\C
Ctrl+C¤  Скопировать комнату\C
Ctrl+V¤  Вставить комнату (если есть)\C
Ctrl+D¤  Сравнить данный уровень с другим\C
Ctrl+Z¤  Отменить\C
Ctrl+Y¤  Повторить\C
Ctrl+F¤  Поиск\C
Ctrl+/¤  Заметки к уровню\C
Ctrl+F1¤  Помощь\C
(ВНИМАНИЕ: на версии Mac используйте Cmd вместо Ctrl)
N¤  Показать номера тайлов в комнате\C
J¤  Показать твёрдость\C
;¤  Показать тайлы миникарты\C
Shift+;¤  Показать фон\C
M¤ или ¤Keypad 5¤  Открыть карту\CnC
G¤  Перейти к комнате (ввести координаты комнаты четырьмя цифрами)\C
/¤  Скрипты\C
[¤  Закрепить положение курсора по оси Y (для простого построения горизонтальных\C
   линий)
]¤  Закрепить положение курсора по оси X (для простого построения вертикальных\C
   линий)
F11¤  Перезагрузка спрайтов и тайлов\C

Номера объектов\gh#

Shift+ПКМ¤        Удалить объект\C
Alt+ЛКМ¤          Переместить объект\C
Alt+Shift+ЛКМ¤     Копировать объект\C

Редактор скриптов\gh#

Ctrl+F¤  Поиск\C
Ctrl+G¤  Перейти к строке\C
Ctrl+I¤  Переключить режим внутреннего скриптинга\C
Alt+right¤  Перейти к скрипту со ссылкой на данной строку\C
Alt+left¤  Перейти к предыдущему скрипту по ссылке\C

Список скриптов\gh#

N¤  Создать новый скрипт\C
F¤  Перейти к списку скриптов\C
/¤  Перейти к первому/последнему скрипту\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Простые скрипты",
imgs = {},
cont = [[
Простые скрипты\wh#
\C=

Простейший язык скриптинга VVVVVV - это основа создания скриптов для создания
уровней в VVVVVV.
Учтите: то, что в этом пункте заключено в кавычки, должно писаться без них.


say¤(строки,цвет)\h#w

Показывает текстовую рамку. При отсутствии аргументов создаёт серую текстовую
рамку с одной строкой, расположенную по центру. Аргумент color может быть как
цветом, так и именем члена экипажа.
Если вы используете цвет и в комнате есть член экипажа с соответствующим цветом,
то текстовая рамка будет расположена над ним.

reply¤(кол-во строк)\h#w

Показывает текстовую рамку Виридиана. Без аргументов показывает текстовую рамку
с одной строкой.

delay¤(N)\h#w

Задерживает действия на n тиков. 30 тиков примерно равны одной секунде.

happy¤(член экипажа)\h#w

Делает члена экипажа счасливым. Без аргумента сделает счастливым Виридиана. Также
можно использовать аргументы "all", "everyone" или "everybody", чтобы сделать
счастливыми всех.

sad¤(член экипажа)\h#w

Делает члена экипажа грустным. Без аргумента сделает грустным Виридиана. Также
можно использовать аргументы "all", "everyone" или "everybody", чтобы сделать
грустными всех.

Примечание: вместо команды ¤sad¤ также можно использовать ¤cry¤.\nwnw

flag¤(номер флага,on/off)\h#w

Включает (on) или выключает (off) флаг с данным номером. К примеру, flag(4,on)
включит флаг под номером 4. Всего есть 100 флагов, пронумерованных от 0 до 99.
По умолчанию все флаги выключены при запуске уровня.

На заметку: в Ved также можно использовать имена флагов вместо чисел.

ifflag¤(флаг,скрипт)\h#w

Если данный флаг включён, перейти к скрипту с данным названием.
Если данный флаг выключен, продолжить выполнение скрипта.
Пример:
ifflag(20,cutscene) - Если флаг под номером 20 включён, перейти к скрипту
                      "cutscene", иначе продолжить выполнение скрипта.

На заметку: в Ved также можно использовать имена флагов вместо чисел.

iftrinkets¤(число,скрипт)\h#w

Если количество собранных тринкетов >= "кол-во", перейти к скрипту.

Если количество собранных тринкетов < "кол-во", продолжить выполнение скрипта.


Пример:

iftrinkets(3,enoughtrinkets) - Если собрано 3 или более тринкета, перейти к
                               скрипту "enoughtrinkets", иначе продолжить
                               выполнение скрипта.

Использование нуля, как минимального количества тринкетов - обычная практика.
Таким способом можно загрузить скрипт при любых обстоятельствах.

iftrinketsless¤(число,скрипт)\h#w

Если количество собранных тринкетов < "кол-во", перейти к скрипту.

Если количество собранных тринкетов >= "кол-во", продолжить выполнение скрипта.

destroy¤(нечто)\h#w

Удаляет все объекты определённого типа до следующего входа в комнату.

Допустимые аргументы:
warptokens — варп-токены
gravitylines — гравитационные линии
platforms — платформы (работает неисправно)
moving — движущиеся платформы (добавлено в 2.4)
disappear — исчезающие платформы (добавлено в 2.4)

music¤(номер)\h#w

Меняет играющий саундтрек на другой.
Для просмотра номеров треков воспользуйтесь пунктом "Список номеров".

playremix\h#w

Меняет музыку на ремикс Predestined Fate.

flash\h#w

Делает вспышку по всему экрану, играет звук взрыва и немного трясёт экран.

map¤(on/off)\h#w

Включает (on) или выключает (off) карту. Если карта выключена, она будет
показывать надпись "NO SIGNAL" до последующего её включения. Пройденные комнаты
всё равно будут отображаться после выключения и включения карты.

squeak¤(член экипажа/on/off)\h#w

Заставляет взвизгнуть данного члена экипажа, включает (on) или выключает (off)
звук взвизга при появлении текстовой рамки.

speaker¤(цвет)\h#w

Меняет цвет и положение последующих текстовых рамок, созданных командой "say".
Может использоваться как второй аргумент в команде "say".

warpdir¤(x,y,направление)\w#h

Меняет тип варпа комнаты X,Y (начиная с 1,1) на указанное. Тип можно проверить
с помощью ifwarp, что даёт мощную систему флагов/переменных.

x - X-координата комнаты, начинающаяся с 1
y - Y-координата комнаты, начинающаяся с 1
dir - Тип варпа. Обычно 0-3, но допустимы и другие значения.

ifwarp¤(x,y,направление,скрипт)\w#h

Если warpdir для комнаты X,Y, начиная с (1,1), установлен на направление,
загрузить простой скрипт

x - X-координата комнаты, начинающаяся с 1
y - Y-координата комнаты, начинающаяся с 1
dir - Тип варпа. Обычно 0-3, но допустимы и другие значения.

loadtext¤(язык)\w#h

Загружает локализацию к уровню по языковому коду. Оставьте аргумент пустым для
использования языка VVVVVV по умолчанию.

язык — языковой код, например, fr или pt_BR

iflang¤(язык,скрипт)\w#h

Перейти к скрипту, если язык VVVVVV установлен на заданный в команде. На неё не
влияет язык, указанный через loadtext, в отличие от языка, выбранного через меню
игры.

setfont¤(шрифт)\w#h

Изменяет шрифт текста в уровне. Это может быть шрифт, поставляемый с игрой,
например font_ja для японского языка, или шрифт, поставляемый с уровнем.
Оставьте аргумент пустым для возвращения к шрифту по умолчанию для уровня.

textcase¤(случай)\w#h

Если в вашем уровне есть файлы перевода, и в одном скрипте есть несколько
текстовых рамок с одинаковым текстом, то эта команда может сделать их
перевод уникальным. Поместите её перед текстовой рамкой.

случай — число от 1 до 255
]]
},

{
splitid = "080_Int_script_reference",
subj = "Внутренний скриптинг",
imgs = {},
cont = [[
Внутренний скриптинг\wh#
\C=

Внутренний скриптинг является мощным, но при этом более сложным способом создания
скриптов, чем простейший.

Чтобы использовать внутренний скриптинг в Ved, можно включить режим внутреннего
скриптинга в редакторе, чтобы все команды в данном скрипте воспринимались
внутренним скриптингом.

Подсветка:\w
Обычная - Эти команды должны работать правильно. В худшем случае VVVVVV вылетет
          при допущенной ошибке.
Синяя¤   - Некоторые из этих команд не работают или не были созданы для\b
          пользовательских уровней, т. к. были сделаны для основной игры.
Оранжевая¤   - Эти команды работают без ошибок, если им не присвоен определённый\o
          аргумент, при работе с которым команда удаляет сохранение игры.
Красная¤ - Красные команды не следует использовать в пользовательских уровнях\r
          т. к. они могут привести к разблокированию определённых частей
          основной игры (что не желательно, даже если всё уже прошли), или
          повредить файлы сохранения в целом.


activateteleporter¤()\w#h

Активирует первый помещённый в комнату телепортатор, что заставит его мигать
случайными цветами и хаотично анимироваться.

Тайл¤ телепортатора установлен на 6, а ¤цвет¤ — на 102. Эта команда заставляет\&Zgn&Zg
телепортатор ничего не делать при прикосновении, поскольку тайл телепортатора\g
установлен на значение, отличное от ¤1§¤.\gn&Zg(

activeteleporter¤()\w#h

Делает первый телепортатор в комнате белым (цвет ¤101¤).\nn&Z

Данная команда не меняет тайл, так что она не отразится на функциональности.\g

alarmoff\w#h

Выключает тревогу.

alarmon\w#h

Включает тревогу.

altstates¤(состояние)\b#h

Меняет расстановку некоторых комнат, как в случае с комнатой с тринкетами на
корабле до и после взрыва, или вход в Секретную Лабораторию (пользовательские
уровни не поддерживают данную команду).

Это меняет глобальную переменную ¤altstates¤ в коде игры.\gn&Zg

audiopause¤(on/off)\w#h

Принудительно включает или выключает аудио при расфокусировке, независимо от
пользовательских настроек. По умолчанию выключает, т.е. ставит музыку на паузу
при расфокусировке.

Данная команда была добавлена в версии 2.3.\g

backgroundtext\w#h

Заставляет следующую отображаемую текстовую рамку не ждать нажатия кнопки
ДЕЙСТВИЕ перед появлением. Чаще всего это используется для одновременного
отображения нескольких текстовых рамок.

befadein¤()\w#h

Instantly remove a fade, such as from ¤#fadeout()¤fadeout¤ or ¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z

blackon¤()\w#h

Resume rendering if it was paused by ¤#blackout()¤blackout¤.\nLwl&Z

blackout¤()\w#h

Pauses rendering.

To make the screen black, use ¤#shake(n)¤shake¤ at the same time.\gLwl&Zg

bluecontrol\b#h

Начинает разговор с Викторией как в основной игре. Создаёт зону действия.

changeai¤(член экипажа,ai1,ai2)\w#h

Меняет направление члена экипажа или его поведение

член экипажа - cyan/player/blue/red/yellow/green/purple

              (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)


ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceleft/faceright/followposition,ai2

      (следовать за: игрок/фиолетовый/жёлтый/красный/зелёный/синий/
       влево/вправо/следовать позиции,ai2)


ai2 - необходим, если в ai1 использовано followposition

faceplayer¤ is missing, use 18 instead. ¤panic¤ also does not work, requiring ¤20¤.\n&Zgn&Zgn&Zg

changecolour¤(a,b)\w#h

Changes the color of a crewmate. This command can be used with Arbitrary Entity
Manipulation.

a - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
b - Color name to change to. Since 2.4, you can also use a color ID

changecustommood¤(цвет,настроение)\w#h

Changes the mood of a rescuable crewmate.

color - Color of crewmate to change (cyan/player/blue/red/yellow/green/purple)
mood - 0 for happy, 1 for sad

changedir¤(цвет,направление)\w#h

Как и в ¤#changeai(член экипажа,ai1,ai2)¤changeai¤, меняет направление члена экипажа.\nLwl&Z

цвет - cyan/player/blue/red/yellow/green/purple

       (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)


направление - 0 - влево, 1 - вправо

changegravity¤(член экипажа)\w#h

Увеличить количество спрайтов данного члена экипажа на 12

член экипажа - Цвет члена экипажа для смены:
               cyan/player/blue/red/yellow/green/purple

               (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)

changemood¤(цвет,настроение)\w#h

Changes the mood of the player or a cutscene crewmate.

цвет - cyan/player/blue/red/yellow/green/purple

       (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)


настроение - 0 - счастливый, 1 - грустный

Cutscene crewmates are crewmates created with ¤#createcrewman(x,y,color,mood,ai1,ai2)¤createcrewman¤.\gLwl&Zg

changeplayercolour¤(цвет)\w#h

Меняет цвет игрока.

цвет - cyan/player/blue/red/yellow/green/purple/teleporter

       (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый/телепортатор)

changerespawncolour¤(цвет)\w#h

Изменяет цвет, с которым возрождается игрок после смерти.

цвет - red/yellow/green/cyan/blue/purple/teleporter или номер цвета

       (красный/жёлтый/зелёный/голубой/синий/фиолетовый/телепортатор)

Эта команда была добавлена в версии 2.4.\g

changetile¤(цвет,спрайт)\w#h

Меняет вид члена экипажа на любой спрайт из sprites.png (работает только на
членах экипажа, созданных командой createcrewman)

цвет - cyan/player/blue/red/yellow/green/purple/gray

       (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый/серый)

спрайт - Номер спрайта

clearteleportscript¤()\b#h

Удаляет скрипт телепортирования, созданный teleportscript(скрипт)

companion¤(x)\b#h

Делает определённого члена экипажа компаньоном.

x - 0 (ничего) или 6/7/8/9/10/11

createactivityzone¤(цвет)\b#h

Создаёт зону активности у указанного члена экипажа (или игрока, если члена
экипажа не существует) с текстом "Press ACTION to talk to (член экипажа)"

createcrewman¤(x,y,цвет,настроение,ai1,ai2)\w#h

Создаёт члена экипажа (нельзя спасти)

настроение - 0 - счастливый, 1 - грустный

ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayerpanic/faceleft/faceright/followposition,ai2

(следовать за: игрок/фиолетовый/жёлтый/красный/зелёный/синий/следить за игроком/
паниковать/влево/вправо/следовать позиции,ai2)


ai2 - необходим, если в ai1 использовано followposition

createentity¤(x,y,e,meta,meta,p1,p2,p3,p4)\o#h

Creates the entity with the ID ¤e§¤, two ¤meta¤ values, and 4 ¤p§¤ values.\nn&Znn&Znn&Z(

e - The entity ID

A list of entity IDs and the ¤meta¤/§¤p§¤ values they use can be found ¤https://vsix.dev/wiki/Createentity_list¤here¤.\gn&Zgn&ZgLClg(

createlastrescued¤()\b#h

Создаёт последнего спасённого члена экипажа в точке ¤(X-200, Y-153)¤.\nn&Z
Последний найденный член экипажа основан на состоянии игры Level Completed.

createrescuedcrew¤()\b#h

Создаёт всех спасённых членов команды

customifflag¤(флаг,скрипт)\w#h

То же, что и ¤ifflag(флаг,скрипт)¤ в простейшем скриптинге\nn&Z

customiftrinkets¤(число,скрипт)\w#h

То же, что и ¤iftrinkets(число,скрипт)¤ в простейшем скриптинге\nn&Z

customiftrinketsless¤(число,скрипт)\w#h

То же, что и ¤iftrinketsless(число,скрипт)¤ в простейшем скриптинге\nn&Z

custommap¤(on/off)\w#h

Внутренний вариант команды управления картой

customposition¤(тип,above/below)\w#h

Переопределяет X,Y текстовой команды, тем самым устанавливая позицию текстовой
рамки, а в случае с членами экипажа это работает только на спасаемых членах
экипажа, НЕ созданных с помощью createcrewman.

тип - center/centerx/centery или название цвета:
      cyan/player/blue/red/yellow/green/purple (находимый)

      (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)

above/below - используется только, если тип - это номер цвета

cutscene¤()\w#h

Создаёт границы кат-сцены

delay¤(кадры)\w#h

Pauses the script for the specified number of frames. Controls are forced to be
unpressed during this pause.

destroy¤(объект)\w#h

Удаляет объекты. Работает так же, как и команда в простом скриптинге.

object - gravitylines/warptokens/platforms/moving/disappear

moving¤ and ¤disappear¤ were added in 2.4.\n&Zgn&Zg

do¤(times)\w#h

Starts a loop block which will repeat a specified number of times. End the block
using ¤#loop¤loop¤.\nLwl&Z

times - The amount of times the block will loop.

endcutscene¤()\w#h

Убирает границы кат-сцены

endtext\w#h

Заставляет текстовую рамку плавно исчезнуть

endtextfast\w#h

Заставляет текстовую рамку немедленно исчезнуть

entersecretlab\r#h

Включает режим Секретной Лаборатории.

2.2 И НИЖЕ: Действительно разблокировывает Секретную Лабораторию, что скорее
является нежелательным эффектом для пользовательского уровня.

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

Телепортирует игрока во Внешнее Измерение VVVVVV.
(46,54)¤ - начальная комната Финального Уровня\n&Z

flag¤(n,on/off)\w#h

То же, что и в соответствующей простейшей команде

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

flipgravity¤(цвет)\w#h

Flips the gravity of a certain crewmate, or the player.

цвет - cyan/player/blue/red/yellow/green/purple

       (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)

Before 2.3, this wouldn't unflip crewmates, or affect the player.\g

flipme\w#h

Исправляет вертикальное расположение нескольких текстовых рамок во flip-режиме

foundlab\b#h

Проигрывает звуковой эффект 3, показывает текстовую рамку с надписью
"Congratulations! You have found the secret lab!". Не выполняет endtext и не имеет
последующих нежелательных эффектов.

foundlab2\b#h

Показывает вторую текстовую рамку после обнаружения Секретной Лаборатории.
Также не выполняет endtext и не имеет последующих нежелательных эффектов.

foundtrinket¤(x)\w#h

Находит тринкет

x - Номер тринкета

gamemode¤(x)\b#h

Аргумент teleporter для открытия карты и указания телепортаторов
основной игры, аргумент game для их скрытия

x - teleporter/game

gamestate¤(состояние)\o#h

Меняет состояние игры на определённый номер.

состояние — номер игрового состояния, к которому необходимо перейти

Полный список игровых состояний можно найти ¤https://vsix.dev/wiki/List_of_gamestates¤здесь¤.\gLClg

gotoposition¤(x,y,гравитация)\w#h

Меняет позицию Виридиана на ¤(x,y)¤ в данной комнате, а также его гравитацию.\nn&Z

гравитация — 1 - перевёрнутый, 0 - обычный. Любое другое значение приведёт
к неисправной гравитации игрока.

gotoroom¤(x,y)\w#h

Меняет комнату на ¤(X,Y)¤.\nn&Z

x — X-координата
y — Y-координата

Эти координаты начинаются с 0.\g

greencontrol\b#h

Начинает разговор с Вердигрисом как в основной игре. Создаёт зону действия.

hascontrol¤()\w#h

Даёт игроку управление. Эту команду нельзя использовать в середине ¤#delay(кадры)¤delay¤.\nLwl&Z

hidecoordinates¤(x,y)\w#h

Set the room at the given coordinates to unexplored

hideplayer¤()\w#h

Делает игрока невидимым

hidesecretlab\w#h

Скрывает Секретную Лабораторию на карте

hideship\w#h

Скрывает корабль на карте

hidetargets¤()\b#h

Скрывает целевые точки на карте

hideteleporters¤()\b#h

Скрывает телепортаторы на карте

hidetrinkets¤()\b#h

Скрывает тринкеты на карте

ifcrewlost¤(член экипажа,скрипт)\b#h

Если член экипажа не был найден, выполнить скрипт

ifexplored¤(x,y,скрипт)\w#h

Если комната ¤(X,Y)¤ уже изучена, выполнить внутренний скрипт.\nn&Z

Эти координаты начинаются с 0.\g

ifflag¤(флаг,скрипт)\b#h

То же, что и customifflag, но включающий скрипт основной игры

iflang¤(language,script)\w#h

Check if the current language of the game is a certain language, and if so, jump
to the given custom script. ¤#loadtext(language)¤loadtext¤ has no influence on this command; only what\nLwl&Z
language the user has selected in the menu.

language - The language to check, usually a two-letter code, such as ¤en¤ for\nn&Z
English
script - The custom script to jump to, if the check succeeds

Эта команда была добавлена в версии 2.4.\g

iflast¤(член экипажа,скрипт)\b#h

Если определённый член экипажа был спасён последним, выполнить скрипт

член экипажа - Использованные номера: 0: Виридиан, 1: Виолетта, 2: Вителлари,
3: Вермилион, 4: Вердигрис, 5: Виктория

ifskip¤(x)\b#h

Если игрок пропускает кат-сцену в Режиме Без Смертей, выполнить скрипт X

iftrinkets¤(число,скрипт)\b#h

То же, что и в простейшем скриптинге, но включающий скрипт основной игры

iftrinketsless¤(число,скрипт)\b#h

Проверяет, меньше ли указанное число, чем количество собранных тринкет, однако
команда проверяет максимальное количество собранных тринкет в основной игре
за одно прохождение, а НЕ количество тринкет, которое у вас есть на самом
деле. Загружает внутренний (основной) скрипт игры

ifwarp¤(x,y,направление,скрипт)\w#h

Если warpdir для комнаты ¤(X,Y)¤, начиная с (1,1), установлен на направление,\nn&Z
загрузить простой скрипт

x - X-координата комнаты, начинающаяся с 1
y - Y-координата комнаты, начинающаяся с 1
dir - Тип варпа. Обычно 0-3, но другие значения тоже допустимы

jukebox¤(n)\w#h

Меняет цвет терминала-проигрывателя на белый и выключает подсветку остальных.
Если задан n, то зона активности терминала-проигрывателя будет в жёстко заданной
позиции. Если терминал находится в той же позиции, то он будет подсвечен.
Возможные значения для n и жёстко заданные позиции:
1: (88, 80), 2: (128, 80), 3: (176, 80), 4: (216, 80), 5: (88, 128), 6: (176,
128), 7: (40, 40), 8: (216, 128), 9: (128, 128), 10: (264, 40)

leavesecretlab¤()\b#h

Выключает "Режим Секретной Лаборатории"

loadscript¤(скрипт)\b#h

Загружает скрипт основной игры. В пользовательских уровнях обычно используется
как loadscript(stop)

loadtext¤(language)\w#h

In custom levels, load the translation for the given language.

language - The language to load, usually a two-letter code, such as ¤en¤ for\nn&Z
English. Pass an empty language code to revert to the default behavior of simply
using VVVVVV's language.

Эта команда была добавлена в версии 2.4.\g

loop\w#h

Put this at the end of a loop block started with the ¤#do(times)¤do¤ command.\nLwl&Z

missing¤(цвет)\b#h

Убирает у члена экипажа состояние спасённого

moveplayer¤(x,y)\w#h

Moves the player by x pixels to the right and y pixels down. Negative numbers are
accepted as well.

musicfadein¤()\w#h

Fades the music in.

Before 2.3, this command did nothing.\g

musicfadeout¤()\w#h

Применяет эффект плавного затухания к музыке.

nocontrol¤()\w#h

Устанавливает game.hascontrol в значение false, что отключает управление игроком.
game.hascontrol автоматически переключается во время "- Press ACTION to advance
text -" и после закрытия текстовых полей, поэтому это отменяется после этих
событий

play¤(n)\w#h

Проигрывает трек из списка номеров.

n - Номер трека

playef¤(sound)\w#h

Воспроизводит звуковой эффект.

sound - Sound ID

In VVVVVV 1.x, there was a second argument which controlled the offset in\g
milliseconds at which the sound effect started. This was removed during the C++\g
port.\g

position¤(тип,above/below)\w#h

Переопределяет X,Y текстовой команды, тем самым устанавливая позицию текстовой
рамки.

тип - center/centerx/centery или название цвета:
      cyan/player/blue/red/yellow/green/purple

      (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый)

above/below - Используется, только если тип является названием цвета

purplecontrol\b#h

Начинает разговор с Виолеттой как в основной игре. Создаёт зону действия.

redcontrol\b#h

Начинает разговор с Вермилионом как в основной игре. Создаёт зону действия.

rescued¤(цвет)\b#h

Спасает определённого члена экипажа

resetgame\w#h

Возвращает в начальное состояние все тринкеты, найденных членов
экипажа и флаги, телепортирует игрока к последнему чекпоинту.

restoreplayercolour¤()\w#h

Меняет цвет игрока обратно на голубой

resumemusic¤()\w#h

Resumes the music after ¤#musicfadeout()¤musicfadeout¤.\nLwl&Z

Before 2.3, this was unfinished and caused various glitches, including crashes.\g

rollcredits¤()\r#h

Запускает титры.

2.2 И НИЖЕ: Удаляет файл сохранения после окончания титров!

setactivitycolour¤(color)\w#h

Change the color of the next activity zone that gets spawned.

color - Any color that ¤#text(color,x,y,lines)¤text¤ takes\nLwl&Z

Эта команда была добавлена в версии 2.4.\g

setactivityposition¤(y)\w#h

Change the position of the next activity zone that gets spawned.

y - The y position

Эта команда была добавлена в версии 2.4.\g

setactivitytext\w#h

Change the text of the next activity zone that gets spawned. The line after this
command will be taken as the text (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

Эта команда была добавлена в версии 2.4.\g

setcheckpoint¤()\w#h

Устанавливает чекпоинт в данной позиции

setfont¤(font)\w#h

In custom levels, set the font to the given font.

font - The font to set the font to. If left blank, this will set the font to the
default font of the custom level.

Эта команда была добавлена в версии 2.4.\g

setroomname\w#h

Change the room name of the current room. The line after this command will be
taken as the name (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This name is not persistent and will go back to the default room name when the
room is reloaded (e.g. by leaving and coming back).

This name overrides any special changing room name, if the room has one. 

Эта команда была добавлена в версии 2.4.\g

shake¤(n)\w#h

Трясёт экран N тиков. Не создаёт задержку.

showcoordinates¤(x,y)\w#h

Set the room at the given coordinates to explored

showplayer¤()\w#h

Показывает игрока

showsecretlab\w#h

Показывает Секретную Лабораторию на карте

showship\w#h

Показывает корабль на карте

showtargets¤()\b#h

Показывает цели на карте (неизвестные телепортаторы, обозначаемые знаками вопроса)

showteleporters¤()\b#h

Show the teleporters in explored rooms on the map

showtrinkets¤()\w#h

Показывает тринкеты на карте

Since 2.3, this command was changed to work in custom levels.\g

speak\w#h

Показывает текстовую рамку, не убирая предыдущие. Также приостанавливает
скрипт, пока не будет нажата клавиша действия (если до этого не было команды
backgroundtext).

speak_active\w#h

Создаёт текстовую рамку, убирая предыдущую. Также приостанавливает скрипт, пока
не будет нажата клавиша действия (если до этого не было команды backgroundtext).

specialline¤(x)\b#h

Особые диалоги, которые появляются в основной игре

squeak¤(цвет)\w#h

Заставляет члена команды взвизгнуть, или терминал издать звук.

цвет - cyan/player/blue/red/yellow/green/purple/terminal

       (голубой/игрок/синий/красный/жёлтый/зелёный/фиолетовый/терминал)

startintermission2\b#h

Альтернатива ¤finalmode(46,54)¤, переносит игрока на Финальный Уровень, не требуя\nn&Z
аргументов.

stopmusic¤()\w#h

Немедленно останавливает музыку. То же, что и ¤music(0)¤ в простом скриптинге.\nn&Z

teleportscript¤(скрипт)\b#h

Раньше использовался для создания скрипта при использовании телепортатора

telesave¤()\r#h

Ничего не делает в пользовательских уровнях.

2.2 И НИЖЕ: Сохраняет оригинальную игру в слот сохранения телепортатора.
Не использовать!

text¤(цвет,x,y,строки)\w#h

Сохраняет текстовую рамку с цветом, координатами и её количеством строк в памяти.
Обычно используется после текстовой команды (с её строками), которая переписывает
данные координаты, так что обычно их приравнивают к нулю.

color - cyan/player/blue/red/yellow/green/purple/gray/white/orange/transparent
x - The x position of the text box
y - The y position of the text box
lines - The number of lines

The ¤transparent¤ color was added in 2.4, along with arbitrary colored textboxes.\gn&Zg
The coordinates can be -500 to center the textbox in the respective axis (if you\g
don't want to use ¤#position(type,above/below)¤position¤).\gLwl&Zg

textboxactive\w#h

Убирает все текстовые рамки, кроме последней созданной

textboxtimer¤(frames)\w#h

Makes the next shown textbox disappear after a certain amount of frames, without
advancing the script.

frames - The amount of frames to wait before fading out

Эта команда была добавлена в версии 2.4.\g

textbuttons¤()\w#h

For the text box in memory, replace certain button placeholders by button labels
(such as keyboard keys or controller glyphs).

The replaced placeholders are:
- {b_act} - ACTION
- {b_int} - Interact
- {b_map} - Map
- {b_res} - Restart
- {b_esc} - Esc/Menu

Эта команда была добавлена в версии 2.4.\g

textcase¤(case)\w#h

If your level has translation files, and you have multiple text boxes with the
same text in a single script, this command can make them have unique translations.
Place it before a textbox.

case - The case number, between 1 and 255.

Эта команда была добавлена в версии 2.4.\g

textimage¤(image)\w#h

For the text box in memory, draw the given image. There can only be one image per
text box.

image - levelcomplete/gamecomplete, or an unknown value to remove the image

Эта команда была добавлена в версии 2.4.\g

textsprite¤(x,y,sprite,color)\w#h

For the text box in memory, draw the given sprite. There can be multiple sprites
per text box.

x - The x-coordinate of the sprite. This is relative to the text box.
y - The y-coordinate of the sprite. This is relative to the text box.
sprite - The sprite number of the sprite, from ¤sprites.png¤.\nn&Z
color - The color ID of the sprite.

Эта команда была добавлена в версии 2.4.\g

tofloor\w#h

Переворачивает игрока вниз, если он находится не внизу.

trinketbluecontrol¤()\b#h

Диалог с Викторией, когда она даёт игроку тринкет из основной игры

trinketscriptmusic\w#h

Играет Passion for Exploring.

trinketyellowcontrol¤()\b#h

Диалог с Вителлари, когда он даёт игроку тринкет из основной игры

undovvvvvvman¤()\w#h

Resets the player's hitbox to the normal size, sets their color to 0, and sets
their X position to 100.

untilbars¤()\w#h

Ждать, пока закончится выполнение ¤#cutscene()¤cutscene¤/§¤#endcutscene()¤endcutscene¤.\nLwl&ZnLwl&Z(

untilfade¤()\w#h

Ждать конца выполнения ¤#fadeout()¤fadeout¤/§¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z(

vvvvvvman¤()\w#h

Makes the player 6x larger, sets their position to ¤(30,46)¤ and sets their color to\nn&Z
23¤.\n&Z

walk¤(направление,тики)\w#h

Заставляет игрока идти определённое количество тиков в данном направлении.

направление - left /right
             (влево/вправо)

warpdir¤(x,y,направление)\w#h

Меняет тип варпа в комнате X,Y (координаты начинаются с 1) на заданное
направление. Тип варпа можно проверить через ifwarp, что приведёт к более мощной
системе флагов/переменных.

x - X-координата комнаты, начинающаяся с 1
y - Y-координата комнаты, начинающаяся с 1
dir - Тип варпа. Обычно 0-3, но другие значения тоже допустимы

yellowcontrol\b#h

Начинает разговор с Вителлари как в основной игре, когда игрок его встречает
и нажимает ENTER. Создаёт зону действия.
]]
},

{
splitid = "090_Lists_reference",
subj = "Списки номеров",
imgs = {},
cont = [[
Список номеров\wh#
\C=

Здесь представлены номера, используемые в VVVVVV. Они, в основном, скопированы
с различных постов на форуме. Спасибо всем, кто помог собрать этот список!


Пункты\w&Z+
\&Z+
#Номера музыки (простой скриптинг)\C&Z+l
#Номера музыки (внутренний скриптинг)\C&Z+l
#Номера звуковых эффектов\C&Z+l
#Номера объектов\C&Z+l
#Цвета для createentity() crewmates\C&Z+l
#Типы движения врагов\C&Z+l
#Состояния игры\C&Z+l


Номера музыки (простой скриптинг)\h#

0 - Тишина (без музыки)
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

Номера музыки (внутренний скриптинг)\h#

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

Номера звуковых эффектов\h#

0 - Переворот вверх
1 - Переворот вниз
2 - Плач
3 - Тринкет
4 - Монета
5 - Чекпоинт
6 - Касание быстрого зыбучего песка
7 - Касание обычного зыбучего песка
8 - Касание гравитационной линии
9 - Вспышка
10 - Варп
11 - Голос Виридиана
12 - Голос Вердигриса
13 - Голос Виктории
14 - Голос Вителлари
15 - Голос Виолетты
16 - Голос Вермилиона
17 - Касание терминала
18 - Касание телепортатора
19 - Сигнал тревоги
20 - Звук терминала
21 - Обратный отсчёт испытания временем ("3", "2", "1")
22 - "Go!" испытания временем
23 - Разрушение стены человеком VVVVVV
24 - Члены экипажа сливаются в форму человека VVVVVV (или восстанавливаются из
     неё)
25 - Новый рекорд в Супер Гравитроне
26 - Новый трофей в Супер Гравитроне
27 - Спасение члена экипажа (в пользовательских уровнях)

Номера объектов\h#

0 - Игрок
1 - Враг
    Метаданные: тип движения; скорость движения
    При отсутствии необходимых данных вы получите лишь фиолетового квадратного
    врага, за исключением использования этой команды во Внешнем Измерении VVVVVV.
2 - Движущаяся платформа
    Учтите: в данном случае конвееры считаются движущимися платформами. Смотрите
    типы движения 8 и 9.
3 - Исчезающая платформа
4 - Единичный блок быстрого зыбучего песка
5 - Перевёрнутый Виридиан. При касании игрок перевернёт гравитацию
6 - Непонятная мерцающая красная штука, которая быстро пропадает
7 - То же, что и выше, но голубого цвета и не мерцает
8 - Монета из игры-прототипа VVVVVV
    Метаданные: ID монеты
9 - Тринкет
    Метаданные: ID тринкета
    Учтите: ID тринкетов начинаются с 0. Любое число выше 19 не сохранится в
    файле уровня при перезапуске.
10 - Чекпоинт
     Метаданные: состояние чекпоинта (0 - перевёрнутый, 1 - нормальный), ID
     чекпоинта (проверяет, активен ли чекпоинт)
11 - Горизонтальная гравитационная линия
     Метаданные: длина в пикселях
12 - Вертикальная гравитационная линия
     Метаданные: длина в пикселях
13 - Варп-токен
     Метаданные: пункт назначения в тайлах по оси X; пункт назначения в тайлах
     по оси Y
14 - Круглый телепортатор
     Метаданные: ID чекпоинта(?)
15 - Вердигрис
     Метаданные: состояние AI
16 - Вителлари (перевёрнутый)
     Метаданные: состояние AI
17 - Виктория
     Метаданные: состояние AI
18 - Член экипажа
     Метаданные: цвет из списка цветов (не цвет члена экипажа); настроение
19 - Вермилион
     Метаданные: состояние AI
20 - Терминал
     Метаданные: спрайт; ID скрипта(?)
21 - То же, что и сверху, но не высвечивается при касании
     Метаданные: спрайт; ID скрипта(?)
22 - Собранный тринкет
     Метаданные: ID тринкета
23 - Квадрат из Гравитрона
     Метаданные: направление
     При вводе отрицательной координаты X (или слишком большой) появляется только
     стрелка, как в настоящем Гравитроне
24 - Член экипажа Интермиссии 1
     Метаданные: цвет из списка цветов
     По всей видимости, не страдает от препятствий, хотя должен
25 - Трофей
     Метаданные: идентификатор задания; спрайт
     Если задание выполнено, начальный ID спрайта (при sprite=0) изменится.
     Используйте 0 или 1 для предсказуемых результатов (0 - нормальный,
     1 - перевёрнутый)
26 - Варп-токен в Секретную Лабораторию
     Учтите, что это только красивый спрайт. Вам придётся создавать отдельный
     скрипт для его функционирования.
55 - Спасаемый член экипажа
     Метаданные: цвет члена экипажа.
     Учтите: номера больше 6 дают в результате счастливого Виридиана.
56 - Враг пользовательского уровня
     Метаданные: тип движения; скорость движения
     Учтите, что если в комнате врагов нет, то данные врага будут обновлены
     некорректно и в результате это покажет врага, которого вы видели в последний
     раз, или квадратного врага.
Неуказанные объекты (27-50, 57 и далее) дают в результате неисправных Виридианов.

Цвета для createentity() crewmates\h#

0: Голубой
1: Мерцающий красный (используется при смерти)
2: Тёмно-оранжевый
3: Цвет тринкета
4: Серый
5: Мерцающий белый
6: Красный (немного темнее цвета Вермилиона)
7: Лаймовый
8: Ярко-розовый
9: Блестящий жёлтый
10: Мерцающий белый
11: Ярко-серый
12: Синий, как Виктория
13: Зелёный, как Вердигрис
14: Жёлтый, как Вителлари
15: Красный, как Вермилион
16: Синий, как Виктория
17: Светло-оранжевый
18: Серый
19: Тёмно-серый
20: Розовый, как Виолетта
21: Светло-серый
22: Белый
23: Мерцающий белый
24-29: Белый
30: Серый
31: Тёмно-серый, немного фиолетовый?
32: Тёмный цвет морской волны
33: Тёмно-синий
34: Тёмно-зелёный
35: Тёмно-красный
36: Тускло-оранжевый
37: Мерцающий серый
38: Серый
39: Тёмный цвет морской волны
40: Более мерцающий серый
41-99: Белый
100: Тёмно-серый
101: Мерцающий белый
102: Цвет телепортатора
103 и далее: белый

Типы движения врагов\h#

0 - Движение вверх-вниз, сначала вниз.
1 - Движение вверх-вниз, сначала вверх.
2 - Движение влево-вправо, сначала влево.
3 - Движение влево-вправо, сначала вправо.
4, 7, 11 - Движение вправо до касания с поверхностью
5 - То же, что и сверху, но ведёт себя странно при соприкосновении
    GIF-пример: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Движение вверх-вниз, но движется вниз только при достижении определённой
    позиции Y. Используется в комнате "Trench Warfare".
8, 9 - Конвееры для движущихся платформ и стационарность для всего остального
14 - Может быть блокировано исчезающими платформами
15 - Стационарно (?)
10, 12 - Клонируется вправо/в этой же точке. Заставляет VVVVVV вылететь при
         большой интенсивности. Искажает файл уровня при сохранении.
13 - Как 4, но движение вниз.
16 - Быстро отображается и пропадает (Появляется и исчезает)
17 - Дёрганое движение вправо
18 - Дёрганое движение вправо, немного быстрее
19 и более - Стационарно (?)

Состояния игры\h#

0 - Прерывает большинство состояний игры
1 - Установить состояние игры 0 (по сути, то же, что и 0)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Запускает скрипт "returntohub" (т.е. затемнение, телепортация прямо перед
    The Tower, высветление, воспроизведение Passion for Exploring)
7 - Убирает текстовые рамки
8 - "Press enter to view map and quicksave"
9 - Супер Гравитрон
10 - Гравитрон
11 - "When you're NOT standing on stop and wait for you" (Результат неудачной
     попытки проверить состояние flipmode, чтобы написать "the ceiling" или
     "the floor" в середине)
12 - "You can't continue to the next room until he is safely accross."
13 - Быстро убирает текстовые рамки
14 - "When you're standing on the floor," (случай, схожий с 11)
15 - Делает Виридиана счастливым
16 - Делает Виридиана грустным
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - Если флаг 1 равен 0, устанавливает флаг 1 в 1 и убирает текстовые рамки
21 - Если флаг 2 равен 0, устанавливает флаг 2 в 1 и убирает текстовые рамки
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - Кат-сцена "Violet, is that you?" (если флаг 6 равен 0)
32 - Если флаг 7 равен 0: "A teleporter!" "I can get back to the ship with this!"
33 - Если флаг 9 равен 0: Кат-сцена с Викторией
34 - Если флаг 10 равен 0: Кат-сцена с Вителлари
35 - Если флаг 11 равен 0: Кат-сцена с Вердигрисом
36 - Если флаг 8 равен 0: Кат-сцена с Вермилионом
37 - Вителлари после Гравитрона
38 - Вермилион после Гравитрона
39 - Вердигрис после Гравитрона
40 - Виктория после Гравитрона
41 - Если флаг 60 равен 0: Воспроизводит начало кат-сцены сбоя 1
42 - Если флаг 62 равен 0: Воспроизводит 3 кат-сцену сбоя 1
43 - Если флаг 63 равен 0: Воспроизводит 4 кат-сцену сбоя 1
44 - Если флаг 64 равен 0: Воспроизводит 5 кат-сцену сбоя 1
45 - Если флаг 65 равен 0: Воспроизводит 6 кат-сцену сбоя 1
46 - Если флаг 66 равен 0: Воспроизводит 7 кат-сцену сбоя 1
47 - Если флаг 69 равен 0: Кат-сцена с тринкетом "Ohh! I wonder what that is?"
48 - Если флаг 70 равен 0: "This seems like a good place to store anything I find
     out there..." (Виктория ещё не спасена)
49 - Если флаг 71 равен 0: Воспроизводит Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
При выборе любого состояния игры из 50-56, остальные состояния будут включаться
     по порядку
80 - Только если экран затемнён, перейти к состоянию 81 (По-моему, это состояние
     активируется при нажатии ESC, перед открытием меню паузы)
81 - Вернуться к главному меню
82 - Результаты испытания временем (неисправно)
83 - Если экран затемнён, перейти к состоянию 84
84 - Результаты испытания временем (по-моему, 82 работает лучше)
85 - Состояние 200 в режиме испытания временем (Вспышка, играет Positive Force,
     включается режим finastretch)
Состояния 90-95 связаны с испытаниями временем, но они не работают должным
     образом в пользовательских уровнях. Единственные изменения в
     пользовательских уровнях от этих состояний - варпы и изменения музыки.
90 - Космическая Станция 1
91 - Лаборатория
92 - Варп-Зона
93 - Башня
94 - Космическая Станция 2
95 - Финальный Уровень
96 - Если экран затемнён, перейти к состоянию 97
97 - Выход из Супер Гравитрона (телепортация, играет Pipe Dream)
100 - Если флаг 4 равен 0: перейти к состоянию 101
101 - Если гравитация перевёрнута, перевернуться обратно, перейти к состоянию 102
Далее состояния (102-112) пытаются переходить к состояниям, следующим по списку,
     как 50-56 (но не зацикливаются), однако могут выдать ошибку, так как
     половины состояний (103, 105, 107, 109, 111) не существует.
102 - Вердигрис: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Убирает текстовые рамки
115 - По сути, не делает ничего, переходит к состоянию 116
116 - Красная текстовая рамка внизу экрана: "Sorry Eurogamers! Teleporting
      around the map doesn't work in this version!", переход к состоянию 117,
      которого не существует, так что может не сработать.
118 - Убирает текстовые рамки
Состояния 120-128 работают почти как 102-112, но более надёжно
120 - Если флаг 5 равен 0: перейти к состоянию 121
121 - Если гравитация направлена вниз, перевернуться.
122 - Вителлари: "Captain! You're ok!"
124 - Вителлари: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Убирает текстовые рамки
200 - Финальный режим
1000 - Включает границы кат-сцен, приостанавливает игру, переход к состоянию 1001
1001 - Диалог "You got a shiny trinket!" (на самом деле вы не получаете тринкет,
       диалог высвечивается каждый раз при собирании тринкетов), переход к
       состоянию 1003
1003 - Вернуть игру в нормальный режим
1010 - "You found a crewmate!" в том же духе, как и с тринкетами
1013 - Окончить уровень звёздами (?)
2000 - Сохранить игру
2500-2509 - Телепортироваться в какую-то странную несуществующую локацию, скорее
            всего имелась ввиду Лаборатория, перейти к состоянию 2510
2510 - Виридиан: "Hello?", перейти к состоянию 2512
2512 - Виридиан: "Is anybody there?", перейти к состоянию 2514
2514 - Убирает текстовые рамки, воспроизводит Potential For Anything
Состояния 3000-3099:
3000-3005 - "Level Complete! You've rescued the crewmate" применяемый к
            companion(), по умолчанию - Виридиан. 6 - Вердигрис, 7 - Вителлари,
            8 - Виктория, 9 - Вермилион, 10 - Виридиан (да, всё верно),
            11 - Виолетта (Состояния игры: 3006-3011 - Вердигрис,
            3020-3026 - Вителлари, 3040-3046 - Виктория, 3060-3066 - Вермилион,
            3080-3086 - Виридиан, 3050-3056 - Виолетта)
3070-3072 - Делает вещи, выполняемые после спасения, обычно возвращает на корабль
3501 - Игра Завершена
4010 - Вспышка + варп
4070 - Финальный Уровень, но игра вылетает при достижении Timeslip (из-за
       получения игрой данных объекта, неисправных в пользовательских уровнях)
4080 - Капитан телепортируется обратно на корабль, кат-сцена
       "Hello!" [C[C[C[C[Captain!] + титры.
       Это испортит Ваши данные сохранения, так что не рискуйте, если не
       сделали бэкап!
4090 - Кат-сцена после Космической Станции 1
]]
},

{
splitid = "100_Formatting",
subj = "Оформление",
imgs = {},
cont = [[
Оформление\wh#
\C=

В заметках вы можете использовать код оформления, чтобы увеличивать текст,
раскрашивать его и так далее. Чтобы оформить строку, добавьте обратный слэш (\) в\
её конец. После "\" вы можете добавлять неограниченное количество приведённых\
символов в любом порядке:

h - Крупный размер шрифта\h

# - Заголовок. Вы можете быстро перемещаться к заголовкам с помощью ¤#Ссылки¤ссылок¤.\nLCl
- - Горизонтальная линия:
\-
= - Горизонтальная линия под крупным текстом

Цвета текста:\h#

n - Нормальный\n
r - Красный\r
g - Серый\g
w - Белый\w
b - Синий\b
o - Оранжевый\o
v - Зелёный\v
c - Циан\c
y - Жёлтый\y
p - Фиолетовый\p
V - Тёмно-зелёный\V
z - Чёрный¤ (без серого фона)\z&Z
Z - Тёмно-серый\Z
C - Циан (Виридиан)\C
P - Розовый (Виолетта)\P
Y - Жёлтый (Вителлари)\Y
R - Красный (Вермилион)\R
G - Зелёный (Вердигрис)\G
B - Синий (Виктория)\B


Пример:\h#

\-
Крупный оранжевый текст\ho\
\
Крупный оранжевый текст\ho

\-
Подчёркнутый крупный текст\wh\
\r=\
\
Подчёркнутый крупный текст\wh
\r=
\-

Использование нескольких цветов в строке\h#

Можно использовать несколько цветов на строке, разделяя цветные части символом¤ ¤¤\nY
(который можно ввести с помощью клавиши ¤Insert¤) и расставляя цветовые коды по\nw
порядку после¤ \¤. Если последний цвет на строке является цветом по умолчанию (n),\nC
то указывать его в конце не обязательно. Если вы хотите использовать символ¤ ¤¤ ¤на\nY
строке, в которой используется¤ \¤, напишите¤ ¤¤¤¤§¤. По техническим причинам н¤е§¤возможно\nCnYnR(
окрасить один символ, заключив его в два¤ ¤¤§¤, если вы не добавите пробел или другой\nY(
символ.

\-
Вот так вы можете ¤¤выделять¤¤ важные ¤¤слова¤¤!\nrnv\
\
Вот так вы можете ¤выделять¤ важные ¤слова¤!\nrnv
\-
Немного ¤¤текст¤¤овых¤¤ цв¤¤ет¤¤ов\RYGCBP\
\
Немного ¤текст¤овых¤ цв¤ет¤ов\RYGCBP
\-

Раскраска одного символа\h#

Ладно, я вас обманул. Вы можете раскрашивать по одному символу, не включая пробел.
Чтобы это сделать - используйте символ¤ § ¤(который вы можете набрать, используя\nY
Shift+Insert¤) после символа, цвет которого вы хотите изменить, а также включив\w
его кодом оформления¤ ( ¤после¤ \¤:\nCnC

\-
Вы можете раск¤¤р§¤¤асить ¤¤один¤¤ символ вот так!\nrny(\
\
Вы можете раск¤р§¤асить ¤один¤ символ вот так!\nrny(
\-

Это не обязательно, если этот символ на строке является первым или последним

Фоновые цвета\h#

Текст можно не только раскрашивать, он также может быть ¤выделен¤ любым цветом.\nZ&y
Для этого вы можете поставить¤ & ¤после обычного цветового кода для текста, а затем\nY
цветовой код для фонового текста. Это можно сделать в сочетании с системой,
описанной выше. Обратите внимание, что обычные цвета текста начинают следующий
"блок", а цвета фона - нет. В приведённых ниже примерах используются пробелы,
чтобы сделать текст более читаемым, но делать это вовсе не обязательно. Вы можете
использовать код¤ +§¤, чтобы расширить (продлить) фоновый цвет до конца строки.\nY(

\-
Чёрный текст на белом фоне!\z&w\
\
Чёрный текст на белом фоне!\z&w
\-
Чёрный текст на продлённом белом фоне!\z&w+\
\
Чёрный текст на продлённом белом фоне!\z&w+
\-
Красный на жёлтом¤¤, ¤¤Чёрный на белом¤¤ (пробелы улучшают читабельность)\r&y n z&w\
\
Красный на жёлтом¤, ¤Чёрный на белом¤ (пробелы улучшают читабельность)\r&y n z&w
\-
Ещё это ¤¤работает¤¤ при раскраске од¤¤н§¤¤ого символа\n P n n&r (\
\
Ещё это ¤работает¤ при раскраске од¤н§¤ого символа\n P n n&r (
\-

Вы также можете создавать графику, используя фоновые цвета:

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

Ссылки\h#

Ссылки можно использовать для двух целей: для ссылки на заметки или для ссылки на
веб-сайты. Ссылки используют полуцветной код¤ l¤. Этот код не переключается на\nY
следующий "цветной блок", он применяется только к текущему, в отличие от обычных
(не фоновых) цветовых кодов. Он также не меняет цвет, поэтому вы можете изменить
стиль ссылки на любой, который захотите.

Вы можете ссылаться на заметку, просто используя её название:

\-
Инструменты\bl\
\
Инструменты\bl
\-

Нажав на "Инструменты", вас перенаправит на заметку с названием Инструменты. Я
использовал здесь цветовой код¤ b§¤, чтобы сделать ссылку синей, и, как вы можете\nb(
видеть,¤ l ¤применяется к той же цветной части.\nY

Вы можете создавать ссылки на заголовки в той же статье, вставив в ссылку¤ #§¤, за\nY(
которым следует весь текст на этой строке. (Примеры¤ ¤¤ ¤здесь полностью игнориру-\nY
ются.) Вы можете создать ссылку на начало статьи, используя только символ решётки
(¤#§¤).\nY(

\-
#Использование нескольких цветов в строке\bl\
\
#Использование нескольких цветов в строке\bl
\-

Вы можете создать ссылку на заголовок в другой заметке аналогичным образом:

\-
Списки номеров#Состояния игры\bl\
\
Списки номеров#Состояния игры\bl
\-

Ссылки на веб-сайты тоже достаточно просты:

\-
https://example.com/\bl\
\
https://example.com/\bl
\-

Вы можете использовать цветной блок с цветовым кодом¤ L§¤, который содержит фактичес-\nY(
кое место назначения перед текстом ссылки, и сделать так, чтобы в ссылке отобра-
жался другой текст:

\-
Инструменты¤¤Перейти к другой заметке\Lbl\
\
Инструменты¤Перейти к другой заметке\Lbl
\-
Нажмите ¤¤Инструменты¤¤здесь¤¤ для перехода к другой заметке\nLbl\
\
Нажмите ¤Инструменты¤здесь¤ для перехода к другой заметке\nLbl
\-
[¤¤#Ссылки¤¤Нравится¤¤] [¤¤#Пример:¤¤Не нравится¤¤]\n L vl n L rl\
\
[¤#Ссылки¤Нравится¤] [¤#Пример:¤Не нравится¤]\n L vl n L rl
\-
#Ссылки¤¤ Кнопка А ¤¤ §¤¤#Ссылки¤¤ Кнопка Б \L w&Zl n L w&Z l(\
\
#Ссылки¤ Кнопка А ¤ §¤#Ссылки¤ Кнопка Б \L w&Zl n L w&Z l(
\-

Изображения (доступны только в описаниях\h#
\
плагинов):\h

0..9 - отобразить изображение 0..9 на этой строке (индекс массива в массиве
       изображений начинается с 0, и не забудьте оставить строки пустыми, чтобы
       учесть высоту изображения)
^ - Поместите это перед номером изображения и сместите его на 10. Итак, ^ 4
    создаёт изображение 14, ^^ 4 создаёт изображение 24. А 3 ^ 1 ^ 56 создаёт
    изображения 3, 11, 25 и 26.
_ - Поместите этот символ перед номером изображения, чтобы уменьшить его на 10.
> - Поместите это перед номером изображения, чтобы сместить следующие изображения
    вправо на 8 пикселей. Это можно повторить, поэтому 0>>>>1 помещает изображение
    0 в x=0 и изображение 1 в x=32.
< - То же самое, но смещение влево.
]]
},

{
splitid = "990_Credits",
subj = "Авторы",
imgs = {"images/credits.png"},
cont = [[
\0















Авторы\wh#
\C=

Создатель Ved: Dav999

Другие программисты: Info Teddy

Некоторая графика и шрифт: Reese Rivers

Перевод на русский: CreepiX, Чип, Omegaplex
Перевод на эсперанто: Reese Rivers
Перевод на немецкий: r00ster
Перевод на французский: RhenaudTheLukark
Перевод на испанский: Valso22/naether
Перевод на индонезийский: _march31onne/Marchionne Evangelisti


Отдельная благодарность:\h#


Терри Кавана - создателю VVVVVV

Всем, кто оповещал об ошибках, помогал идеями и мотивировал меня создать это!
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

Ресурсы VVVVVV\h#

Ved включает в себя некоторые графические ресурсы из VVVVVV. VVVVVV и её ресурсы
защищены авторским правом. Для получения дополнительной информации о лицензии,
которая распространяется на VVVVVV и её активы см. ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ и ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License\nLClnLCl
https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤exceptions.md¤ в ¤https://github.com/TerryCavanagh/VVVVVV¤GitHub-репозитории VVVVVV¤.\LClnLCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
