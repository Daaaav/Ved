-- Language file for Ved
--- Language: Русский (ru)
--- Last converted: 2020-02-24 00:18:42 (CET)

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

TRANSLATIONCREDIT = "Сделано CreepiX'ом и Чиприком", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Ваша версия L{VE устарела. Пожалуйста, используйте версию 0.9.1 или выше.\nЗагрузите L{VE на https://love2d.org/.",
OUTDATEDLOVE090 = "Ved больше не поддерживает L{ve 0.9.0. К счастью, L{ve 0.9.1 и выше будут работать.\nВы можете скачать последнюю версию L{ve с https://love2d.org/.",
UNKNOWNSTATE = "Неизвестный режим ($1), перешедший из $2",
FATALERROR = "ФАТАЛЬНАЯ ОШИБКА: ",
FATALEND = "Пожалуйста, закройте игру и попробуйте ещё раз.",

OSNOTRECOGNIZED = "Ваша ОС ($1) не опознана! Идёт возврат к первичным настройкам файловой системы; ваши уровни находятся в:\n\n$2",
MAXTRINKETS = "Было достигнуто максимальное количество тринкетов ($1).",
MAXCREWMATES = "Было достигнуто максимальное количество членов экипажа ($1).",
EDITINGROOMTEXTNIL = "Редактируемый текст не найден!",
STARTPOINTNOLONGERFOUND = "Старая точка старта не найдена!",
UNSUPPORTEDTOOL = "Неподдерживаемый инструмент! Инструмент: ",
SURENEWLEVEL = "Вы действительно хотите создать новый уровень? Вы потеряете весь несохранённый контент.",
SURELOADLEVEL = "Вы действительно хотите загрузить другой уровень? Вы потеряете весь несохранённый контент.",
COULDNOTGETCONTENTSLEVELFOLDER = "Папка с уровнями не найдена. Пожалуйста, убедитесь что $1 существует и попробуйте снова.",
MAPSAVEDAS = "Снимок карты $1 сохранён!",
RAWENTITYPROPERTIES = "Вы можете изменять значения свойств этого объекта.",
UNKNOWNENTITYTYPE = "Неизвестный тип объекта $1",
METADATAENTITYCREATENOW = "Объект данных не существует. Создать его сейчас?\n\nОбъект данных - это скрытый объект, который может быть добавлен в уровень для хранения дополнительной информации используемой Ved, например записки уровня, названия флагов и т.д.",
WARPTOKENENT404 = "Объект жетона телепортации больше не существует!",
SPLITFAILED = "Разделение провалено! Может, у вас слишком много строк между командами text и speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Все флаги использованы, новые имена флагов в этом скрипте не будут ассоциироваться с номерами флагов. Попытка запустить этот скрипт в VVVVVV может привести к ошибке. Уберите все ссылки к флагам которые вам не нужны и попробуйте ещё раз.\n\nПокинуть редактор?",
NOFLAGSLEFT_LOADSCRIPT = "Больше нет свободных флагов, поэтому скрипт загрузки использующий новый флаг не может быть создан. Вместо этого был создан скрипт загрузки, загружающий целевой скрипт при помощи iftrinkets(0,$1). Попробуйте убрать все использования ненужных флагов и повторите попытку.",
LEVELOPENFAIL = "Невозможно открыть $1.vvvvvv.",
SIZELIMIT = "Максимальный размер уровня $1x$2.\n\nРазмер уровня будет изменён на $3x$4.",
SCRIPTALREADYEXISTS = "Скрипт \"$1\" уже существует!",
FLAGNAMENUMBERS = "Имя флага не может состоять только из цифр.",
FLAGNAMECHARS = "Имя флага не может содержать скобки, запятые или пробелы.",
FLAGNAMEINUSE = "Имя флага $1 уже используется флагом $2",
DIFFSELECT = "Выберите второй уровень для сравнения. Уровень, который вы выберете будет считаться за старую версию.",
SUREQUIT = "Вы действительно хотите выйти? Вы потеряете весь несохранённый контент.",
SUREQUITNEW = "Есть несохраненные изменения. Сохранить их перед выходом?",
SURENEWLEVELNEW = "Есть несохранённые изменения. Сохранить их перед созданием нового уровня?",
SCALEREBOOT = "Новые настройки масштаба придут в силу после перезапуска Ved.",
NAMEFORFLAG = "Имя флага $1:",
SCRIPT404 = "Скрипт \"$1\" не существует!",
ENTITY404 = "Объект #$1 не существует!",
GRAPHICSCARDCANVAS = "Ваша видеокарта или её драйвер не поддерживает данную функцию!",
MAXTEXTURESIZE = "Ваша видеокарта или её драйвер не поддерживает изображение с масштабом $1x$2.\n\nПредел масштаба на этой системе - $3x$3.",
SUREDELETESCRIPT = "Вы уверены, что хотите удалить скрипт \"$1\"?",
SUREDELETENOTE = "Вы уверены, что хотите удалить эту записку?",
THREADERROR = "Ошибка потока выполнения!",
WHATDIDYOUDO = "Что Вы наделали?!",
UNDOFAULTY = "Что ты делаешь?",
SOURCEDESTROOMSSAME = "Изначальная комната и конечная комната совпадают!",
UNKNOWNUNDOTYPE = "Неизвестный тип отмены \"$1\"!",
MDEVERSIONWARNING = "Этот уровень был сделан в более поздней версии Ved, и может содержать информацию, которая будет потеряна при сохранении.",
FORGOTPATH = "Вы забыли указать путь!",
MDENOTPASSED = "Внимание: объекту данных запрещён доступ к команде savelevel()!",
RESTARTVEDLANG = "После изменения языка необходимо перезапустить Ved, чтобы изменения вступили в силу.",

SELECTCOPY1 = "Выберите комнату для копирования",
SELECTCOPY2 = "Выберите координаты для копии этой комнаты",
SELECTSWAP1 = "Выберите первую комнату для замены",
SELECTSWAP2 = "Выберите вторую комнату для замены",

TILESETCHANGEDTO = "Стиль стен изменён на $1",
TILESETCOLORCHANGEDTO = "Цвет стен изменён на $1",
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

BOUNDSTOPLEFT = "Кликните на левый верхний угол рамки комнаты",
BOUNDSBOTTOMRIGHT = "Кликните на правый нижний угол рамки комнаты.",

TILE = "Стена $1",
HIDEALL = "Спрятать всё",
SHOWALL = "Показать всё",
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
INTERNALON = "Внутр. скрипты включены",
INTERNALOFF = "Внутр. скрипты отключены",
INTERNALYESBARS = "Внутр. скр. с say(-1)",
INTERNALNOBARS = "Внутр. скр. с загруз. скр.",
VIEW = "Просмотр",
SYNTAXHLOFF = "Подсветка включена",
SYNTAXHLON = "Подсветка отключена",
TEXTSIZEN = "Обычный текст",
TEXTSIZEL = "Большой текст",
INSERT = "Вставить",
HELP = "Помощь",
INTSCRWARNING_NOLOADSCRIPT = "Требуется загрузочный скрипт!",
INTSCRWARNING_BOXED = "Прямая ссылка на скрипт/терминал!\n\n",
COLUMN = "Столбец: ",

BTN_OK = "OK",
BTN_CANCEL = "Отменить",
BTN_YES = "Да",
BTN_NO = "Нет",
BTN_APPLY = "Применить",
BTN_QUIT = "Выход",
BTN_DISCARD = "Не сохр.",
BTN_SAVE = "Сохранить",
BTN_CLOSE = "Закрыть",
BTN_LOAD = "Загрузить",

COMPARINGTHESE = "Сравнивание $1.vvvvvv с $2.vvvvvv",
COMPARINGTHESENEW = "Сравнивание (несохранённого уровня) и $1.vvvvvv",

RETURN = "Возврат",
CREATE = "Создать",
GOTO = "Перейти",
DELETE = "Удалить",
RENAME = "Переименовать",
CHANGEDIRECTION = "Изменить направление",
DIRECTION = "Направление->",
UP = "вверх",
DOWN = "вниз",
LEFT = "влево",
RIGHT = "вправо",
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
BUG = "[Глюк!]",

VEDOPTIONS = "Настройки Ved",
LEVELOPTIONS = "Настройки уровня",
MAP = "Карта",
SCRIPTS = "Скрипты",
SEARCH = "Поиск",
SENDFEEDBACK = "Написать отзыв",
LEVELNOTEPAD = "Записки",
PLUGINS = "Плагины",

BACKB = "Назад <<",
MOREB = "Вперёд >>",
AUTOMODE = "Автоматический",
AUTO2MODE = "Мульти",
MANUALMODE = "Ручной",
PLATFORMSPEED = "Скорость: $1",
ENEMYTYPE = "Тип: $1",
PLATFORMBOUNDS = "Границы платформ",
WARPDIR = "Тип телепорта: $1",
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
CAPNONE = "НЕ УКАЗАНО",
ENTERLONGOPTNAME = "Название уровня:",

X = "х", -- Used for level size: 20x20

SOLID = "Твёрдый",
NOTSOLID = "Не твёрдый",

TSCOLOR = "Цвет $1",

ONETRINKETS = "Т:",
ONECREWMATES = "ЧЭ:",
ONEENTITIES = "О:",

LEVELSLIST = "Уровни",
LOADTHISLEVEL = "Загрузить: ",
ENTERNAMESAVE = "Сохранить как: ",
SEARCHFOR = "Поиск: ",

VERSIONERROR = "Невозможно проверить версию.",
VERSIONUPTODATE = "Ваша версия Ved последняя.",
VERSIONOLD = "Доступно обновление! Последняя версия: $1",
VERSIONCHECKING = "Проверка обновлений...",
VERSIONDISABLED = "Проверка обновлений отключена",

SAVESUCCESS = "Сохранение успешно!",
SAVENOSUCCESS = "Сохранение провалено! Ошибка: ",
INVALIDFILESIZE = "Неверный размер файла.",

EDIT = "Редактировать",
EDITWOBUMPING = "Редактировать без перемещения",
COPYNAME = "Копировать имя",
COPYCONTENTS = "Копировать контент",
DUPLICATE = "Дублировать",

NEWSCRIPTNAME = "Имя:",
CREATENEWSCRIPT = "Создать новый скрипт",

NEWNOTENAME = "Имя:",
CREATENEWNOTE = "Создать новую записку",

ADDNEWBTN = "[Добавить новую]",
IMAGEERROR = "[ОШИБКА ИЗОБРАЖЕНИЯ]",

NEWNAME = "Новое название:",
RENAMENOTE = "Переименовать записку",
RENAMESCRIPT = "Переименовать скрипт",

LINE = "строка ",

SAVEMAP = "Сохранить карту",
SAVEFULLSIZEMAP = "Сохранить полную карту",
COPYROOMS = "Копировать комнату",
SWAPROOMS = "Заменить комнаты",

FLAGS = "Флаги",
ROOM = "комната",
CONTENTFILLER = "Контент",

FLAGUSED = "Использован   ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Не использован",
FLAGNONAME = "Нет имени",
USEDOUTOFRANGEFLAGS = "Использовано лишних флагов:",

CUSTOMVVVVVVDIRECTORY = "Папка VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Расположение VVVVVV, которое ожидает Ved:\n$1\n\nЭтот путь не должен вести к папке \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Не установлено пользовательское расположение VVVVVV.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Пользовательское расположение VVVVVV:\n$1\n\n",
LANGUAGE = "Язык",
DIALOGANIMATIONS = "Анимация диалогов",
FLIPSUBTOOLSCROLL = "Инвертировать направление прокручивания",
ADJACENTROOMLINES = "Индикаторы стен в соседних комнатах",
ASKBEFOREQUIT = "Подтверждение перед выходом",
NEVERASKBEFOREQUIT = "Никогда не подтверждать выход, даже при наличии несохранённых изменений",
COORDS0 = "Отображать координаты, начиная с 0 (для внутренних скриптов)",
ALLOWDEBUG = "Включить режим разработчика",
SHOWFPS = "Показать счётчик FPS",
IIXSCALE = "Двойной масштаб окна",
CHECKFORUPDATES = "Проверять обновления",
PAUSEDRAWUNFOCUSED = "Не прогружать когда окно не активно",
ENABLEOVERWRITEBACKUPS = "Создавать бекапы уровня при перезаписи файла",
AMOUNTOVERWRITEBACKUPS = "Кол-во бекапов для каждого уровня",
SCALE = "Масштаб",
LOADALLMETADATA = "Показать метаданные (название, автор, описание и т.д.) у всех файлов в списке уровней",
COLORED_TEXTBOXES = "Использовать настоящие цвета текстовых рамок",

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
TILESETUSSAGE = "Использование набора стен",
TILESETSONLYUSED = "(считаются только комнаты со стенами)",
AMOUNTROOMSWITHNAMES = "Комнаты с именами:",
PLACINGMODEUSAGE = "Режимы расположения стен:",
AMOUNTLEVELNOTES = "Записки:",
AMOUNTFLAGNAMES = "Названия флагов:",
TILESUSAGE = "Использование стен",
AMOUNTTILES = "Стены:",
AMOUNTSOLIDTILES = "Твёрдые стены:",
AMOUNTSPIKES = "Шипы:",


UNEXPECTEDSCRIPTLINE = "Неизвестная строка скрипта без скрипта: $1",
DUPLICATESCRIPT = "Скрипт $1 - дубликат! Можно загрузить только один.",
MAPWIDTHINVALID = "Ширина карты неверная: $1",
MAPHEIGHTINVALID = "Высота карты неверная: $1",
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

-- b14
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
RESETCOLORS = "Сбросить цвета",
STRINGNOTFOUND = "\"$1\" не найдена",

-- b17 - L.MAL is concatenated with L.[...]CORRUPT
MAL = "Файл уровня повреждён: ",
METADATACORRUPT = "Данные отсутствуют или повреждены.",
METADATAITEMCORRUPT = "Данные для $1 отсутствуют или повреждены.",
TILESCORRUPT = "Стены отсутствуют или повреждены.",
ENTITIESCORRUPT = "Объекты отсутствуют или повреждены.",
LEVELMETADATACORRUPT = "Данные о комнате отсутствуют или повреждены.",
SCRIPTCORRUPT = "Скрипты отсутствуют или повреждены.",

-- 1.1.0
LOADSCRIPTMADE = "Загрузочный скрипт создан",
COPY = "Копировать",
CUSTOMSIZE = "Польз. размер стен: $1x$2",
SELECTINGA = "Выбор - кликните на верхний левый угол",
SELECTINGB = "Выбор: $1x$2",
TILESETSRELOADED = "Стены и спрайты перезагружены",

-- 1.2.0
BACKUPS = "Бекапы",
BACKUPSOFLEVEL = "Бекапы уровня $1",
LASTMODIFIEDTIME = "Последние изменения", -- List header
OVERWRITTENTIME = "Перезаписано", -- List header
SAVEBACKUP = "Сохранить в папку VVVVVV",
DATEFORMAT = "Формат даты",
TIMEFORMAT = "Формат времени",
CUSTOMDATEFORMAT = "Пользовательский формат даты",
SAVEBACKUPNOBACKUP = "Выберите уникальное имя для файла, иначе бекап не будет создан!",

-- 1.2.4
AUTOSAVECRASHLOGS = "Сохранять отчёты об ошибке автоматически",
MOREINFO = "Последняя информация",
COPYLINK = "Скопировать ссылку",
SCRIPTDISPLAY = "Показать",
SCRIPTDISPLAY_USED = "Использовано",
SCRIPTDISPLAY_UNUSED = "Не использовано",

-- 1.3.0 (more changes)
RECENTLYOPENED = "Недавно открытые уровни",
REMOVERECENT = "Вы действительно хотите удалить этот уровень из списка недавно открытых?",
RESETCUSTOMBRUSH = "(ПКМ - изменение размера)",

-- 1.3.2
DISPLAYSETTINGS = "Отображение\n/Масштаб",
DISPLAYSETTINGSTITLE = "Настройки отображения/масштаба",
SMALLERSCREEN = "Меньшая ширина окна (меняется с 896 пикс. на 800 пикс.)",
FORCESCALE = "Запрет изменений настроек масштаба",
SCALENOFIT = "Окно становится больше границ экрана при выбранном масштабе.",
SCALENONUM = "Данный масштаб неверен.",
MONITORSIZE = "Экран $1x$2",
VEDRES = "Разрешение Ved: $1x$2",
NONINTSCALE = "Масштаб с дробным значением",

-- 1.3.4
USEFONTPNG = "Использовать font.png из папки графики VVVVVV как шрифт",
REQUIRESHIGHERLOVE = " (необходим L{VE версии $1 или выше)",
SYNTAXCOLOR_COMMENT = "Комментарий",
FPSLIMIT = "Ограничение FPS",

MAPRESOLUTION = "Разрешение", -- Map export size
MAPRES_ASSHOWN = "Как показано (макс. 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 на комнату)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 на комнату)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Левый верхний",
WIDTHHEIGHT = "Ширина и высота",
BOTTOMRIGHT = "Правый нижний",
RENDERERINFO = "Информация о рендере:",
MAPINCOMPLETE = "Карта ещё не готова (к моменту нажатия Сохранить), повторите попытку когда она будет готова.",
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
SEARCHRESULTS_NOTES = "Записки [$1]",

ASSETS = "Ресурсы", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Невозможно воспроизвести эту музыку. Файл не существует или его тип не поддерживается.",
SOUNDPLAYERROR = "Невозможно воспроизвести этот звук. Файл не существует или его тип не поддерживается.",
MUSICLOADERROR = "Невозможно загрузить $1: ",
MUSICLOADERROR_TOOSMALL = "Музыкальный файл слишком мал чтобы быть действительным.",
MUSICEXISTSYES = "Существует",
MUSICEXISTSNO = "Не существует",
LOAD = "Загрузить",
RELOAD = "Перезагрузить",
UNLOAD = "Отменить загрузку",
MUSICEDITOR = "Редактор музыки",
LOADMUSICNAME = "Загрузить .vvv",
INSERTSONG = "Вставить музыку как трек $1",
SUREDELETESONG = "Вы уверены, что хотите убрать музыку $1?",
SONGOPENFAIL = "Невозможно открыть $1, музыка не заменена.",
SONGREPLACEFAIL = "Что-то пошло не так в процессе замены музыки.",
KILOBYTES = "$1 КБ",
MEGABYTES = "$1 МБ",
GIGABYTES = "$1 ГБ",
CANNOTUSENEWLINES = "Нельзя использовать символ \"$1\" в названиях скриптов!",
MUSICTITLE = "Название: ",
MUSICARTIST = "Музыкант: ",
MUSICFILENAME = "Название файла: ",
MUSICNOTES = "Примечания:",
SONGMETADATA = "Метаданные музыки $1",
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

OPAQUEROOMNAMEBACKGROUND = "Сделать фон названия комнаты непрозрачным",
PLATVCHANGE_TITLE = "Изменить скорость платформы",
PLATVCHANGE_MSG = "Скорость:",
PLATVCHANGE_INVALID = "Необходимо ввести число",
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


OLDSHORTCUT_SCRIPTJUMP = "CTRL+влево/вправо скоро перестанет работать. Используйте ALT+влево/вправо", -- CTRL and ALT are capitalized here for extra clarity in this string
OLDSHORTCUT_ASSETS = "Ctrl+A скоро перестанет работать. Используйте Ctrl+R",
OLDSHORTCUT_OPENLVLDIR = "Ctrl+D скоро перестанет работать. Используйте Ctrl+F",
OLDSHORTCUT_GOTOROOM = "Q скоро перестанет работать. Используйте G",
OLDSHORTCUT_SHOWBG = "K скоро перестанет работать. Используйте Shift+;",

FRAMESTOSECONDS = "$1 = $2 сек",
ROOMNUM = "Комната $1",
TRACKNUM = "Трек $1",
STOPSMUSIC = "Останавливает музыку",
EDITSCRIPTWOBUMPING = "Редактировать без перемещения",
CLICKONTHING = "Нажмите на $1",
ORDRAGDROP = "или перетащите файл сюда", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "В данном уровне больше одной точки старта!",

CONFIRMBIGGERSIZE = "You are selecting $1 by $2, which is a bigger map size than $3 by $4. Outside the normal $3 by $4 map, rooms and room properties wrap around, but are distorted. You do not get entirely new rooms, nor do you get more room properties. VVVVVV can also crash for any reason in those rooms.\n\nPress Yes if you know what you're doing and want this bigger map size. Press No to set the map size to $5 by $6.\n\nIf unsure, press No.",
MAPBIGGERTHANSIZELIMIT = "Map size $1 by $2 is bigger than $3 by $4! (Bigger than $3 by $4 support not enabled)",
BTNOVERRIDE = "Override",
TARGETPLATFORM = "Target platform", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
PLATFORM_VCE = "VVVVVV-CE",
ENABLETOWER = "Tower mode",
DISABLETOWER = "Disable tower",
TIMETRIALS = "Time trials",
DIMENSIONS = "Dimensions",
TOWERDIRECTIONUP = "Direction: ↑",
TOWERDIRECTIONDOWN = "Direction: ↓",
TOWERENTRYEXIT = "Set entry/exit",
SWITCHEDTOALTSTATEMAIN = "Switched to main state",
SWITCHEDTOALTSTATE = "Switched to alt state $1",
ADDEDALTSTATE = "Added new alt state $1",
REMOVEDALTSTATE = "Removed alt state $1",
ENABLEDTOWER = "Tower mode enabled",
DISABLEDTOWER = "Tower mode disabled",
TOWERASCENDING = "Tower now ascending",
TOWERDESCENDING = "Tower now descending",
TOWERENTRYSET = "Tower entry/exit set to current position",
TIMETRIALTRINKETS = "Trinket count",
TIMETRIALTIME = "Par time",
SUREDELETETRIAL = "Are you sure you want to delete the time trial \"$1\"?",
SUREDELETEDIMENSIONNAME = "Are you sure you want to delete the dimension \"$1\"?",
SUREDELETEDIMENSIONNONAME = "Are you sure you want to delete this dimension?",

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
		[0] = "$1 стена имеет недопустимое значение в пределах 0-1199",
		[1] = "$1 стены имеют недопустимые значения в пределах 0-1199",
		[2] = "$1 стен имеют недопустимые значения в пределах 0-1199",
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
}

toolnames = {

"Стена",
"Фон",
"Шипы",
"Тринкет",
"Чекпоинт",
"Исчезающая платформа",
"Конвеер",
"Двигающаяся платформа",
"Враг",
"Грави-линия",
"Текст",
"Компьютер",
"Скрипт",
"Телепорт",
"Линия варпа",
"Член экипажа",
"Точка старта",

}

subtoolnames = {

[1] = {"1x1", "3x3", "5x5", "7x7", "9x9", "Залить горизонтально", "Залить вертикально", "Пользовательский размер стен", "Заливка", "Картошка для магических вещей"},
[2] = {},
[3] = {"Авто 1", "Авто расширить Л+П", "Авто расширить Л", "Авто расширить П"},
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

[0] = "НЕТ",
[1] = "ГОРИЗОНТАЛЬНЫЙ",
[2] = "ВЕРТИКАЛЬНЫЙ",
[3] = "ПОЛНЫЙ",

}

warpdirchangedtext = {

[0] = "Без варпа",
[1] = "Горизонтальный варп",
[2] = "Вертикальный варп",
[3] = "Полный варп",

}

langtilesetnames = {

short0 = "КС",
long0 = "Космическая Станция",
short1 = "Космос",
long1 = "Космос",
short2 = "Лаб.",
long2 = "Лаборатория",
short3 = "Варп-Зона",
long3 = "Варп-Зона",
short4 = "Корабль",
long4 = "Корабль",
short5 = "Tower",
long5 = "Tower",

}

ERR_VEDHASCRASHED = "Ved вылетел!"
ERR_VEDVERSION = "Версия Ved:"
ERR_LOVEVERSION = "Версия L{VE:"
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
ERR_PLEASETELLAUTHOR = "Плагин должен был редактровать код Ved, но код для замены не был найден.\nВозможно это из-за конфликта между двумя плагинами, или новая версия Ved не поддерживает этот плагин.\n\nДетали: (нажмите Ctrl+C/Cmd+C чтобы скопировать в буфер обмена)\n\n"
ERR_CONTINUE = "Вы можете продолжить нажав Esc или Enter, но эта ошибка может вызвать глюки."
ERR_OPENPLUGINSFOLDER = "You can open your plugins folder by pressing F, so you can fix or remove the offending plugin. Afterwards, restart Ved."
ERR_REPLACECODE = "Это не найдено в %s.lua:"
ERR_REPLACECODEPATTERN = "Это не найдено в %s.lua (как шаблон):"
ERR_LINESTOTAL = "%i строк в общем."

ERR_SAVELEVEL = "Чтобы сохранить копию уровня, нажмите S."
ERR_SAVESUCC = "Уровень сохранён как %s!"
ERR_SAVEERROR = "Ошибка сохранения! %s"
ERR_LOGSAVED = "Больше сведений в отчёте об ошибке:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Свойства уровня",
		changedrooms = "Изменённые комнаты",
		changedroommetadata = "Изменённая информация комнаты",
		entities = "Объекты",
		scripts = "Скрипты",
		flagnames = "Имена флагов",
		levelnotes = "Записки",
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
		cleared1 = "Очищены все стены в ($1,$2) ($3)\\R",
		cleared2 = "Очищены все стены в ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Комната $1,$2:",
		changed1 = "Комната $1,$2 ($3):",
		roomname = "Название изменено с \"$1\" на \"$2\"\\Y",
		roomnameremoved = "Название \"$1\" убрано\\R",
		roomnameadded = "Комната названа \"$1\"\\G",
		tileset = "Набор стен $1 с цветом $2 изменён на набор стен $3 с цветом $4\\Y",
		platv = "Скорость платформ изменена с $1 на $2\\Y",
		enemytype = "Тип врагов изменён с $1 на $2\\Y",
		platbounds = "Рамка платформ изменена с $1,$2,$3,$4 на $5,$6,$7,$8\\Y",
		enemybounds = "Рамка врагов изменена с $1,$2,$3,$4 на $5,$6,$7,$8\\Y",
		directmode01 = "Ручной режим включен\\G",
		directmode10 = "Ручной режим выключен\\R",
		warpdir = "Тип варпа изменён с $1 на $2\\Y",
	},
	entities = {
		added = "Добавлен объект типа $1 на позиции $2,$3 в комнате ($4,$5)\\G",
		removed = "Удалён объект типа $1 с позиции $2,$3 в комнате ($4,$5)\\R",
		changed = "Изменён тип объекта $1 на позиции $2,$3 в комнате ($4,$5)\\Y",
		changedtype = "Изменён тип объекта $1 на тип $2 на позиции $3,$4 в комнате ($5,$6)\\Y",
		multiple1 = "Изменены объекты на позиции $1,$2 в комнате ($3,$4):\\Y",
		multiple2 = "на:",
		addedmultiple = "Добавлены объекты на позиции $1,$2 в комнате ($3,$4):\\G",
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
		added = "Добавлена записка \"$1\"\\G",
		removed = "Удалена записка \"$1\"\\R",
		edited = "Изменена записка \"$1\"\\Y",
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
) - Return to previous state

Flags can be combined, like \rh or \hr for a red header
Invalid flags will be ignored

1234567890123456789012

Room for 82 characters on a line (85, but the last three characters will have a scrollbar if it is needed. 
----------------------------------------------------------------------------------[]-
]]

{
subj = "Возврат",
imgs = {},
cont = [[
\)
]] -- This should be left the same!
},

{
splitid = "010_Getting_started",
subj = "Перед началом",
imgs = {},
cont = [[
Перед началом\wh#
\C=

Данная статья поможет Вам разобраться, как пользоваться Ved. Перед тем, как начать
пользоваться редактором, Вам необходимо открыть уровень или создать новый.


Редактор\h#

С левой стороны расположен набор инструментов. Большинство инструментов имеют
вариации, которые будут показаны левее. Чтобы переключать инструменты,
используйте горячие клавиши или прокручивайте колёсико мыши, зажав клавишу
Shift или Ctrl. Менять вариации инструментов можно, прокручивая колёсико
мыши где угодно. Для дополнительной информации смотрите пункт ¤Инструменты¤.\nwl
Объекты можно кликать правой кнопкой мыши для выпадения меню действий с этим
объектом. Чтобы удалять объекты без выпадания меню действий, зажмите клавишу
Shift и кликнете по объекту правой кнопкой мыши.
В правой стороне окна расположено множество кнопок и настроек. Верхние кнопки
относятся ко всему уровню, а кнопки ниже (под кнопкой "Настройки уровня")
относятся только к данной комнате. Для дополнительной информации о кнопках
смотрите соответсвующие пункты.

Папка уровней\h#

По умолчанию Ved использует ту же папку для содержания уровней, что и VVVVVV,
так что можно легко переключаться между редактором уровней VVVVVV и Ved. Если
Ved неверно обнаруживает папку VVVVVV, Вы можете указать к ней путь в
настройках Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Режимы расп-ния стен",
imgs = {"autodemo.png", "auto2demo.png", "manualdemo2.png"},
cont = [[
Режимы расположения стен\wh#
\C=

Ved поддерживает три разных режима создания стен.

     Автоматический режим\h#0

          Этот режим является наилёгким в применении. При создании стен и фона в
          этом режиме, их края будут автоматически расположены правильно. Однако,
          используя этот режим, все стены и фоны будут из одинакого набора и
          одинакого цвета.

     Режим мульти-набор\h#1

          Этот режим схож с автоматическим, но используя его можно работать с
          несколькими разными наборами в одной комнате. Это значит, что изменение
          набора не повлияет на уже установленные стены и фоны и Вы можете
          использовать разные наборы в одной комнате.

     Ручной режим\h#2

          Также называется Режим напрямую (Direct Mode). В этом режиме Вы можете
          распологать стены вручную, т.е. нет ограничений в заранее подготовленных
          наборах и края стен и фонов не будут создаваться автоматически, что даёт
          вам полный контроль над внешним видом комнаты. Однако, этот режим чаще
          всего затяжный в использовании.
]]
},

{
splitid = "030_Tools",
subj = "Инструменты",
imgs = {"tools2/on/1.png", "tools2/on/2.png", "tools2/on/3.png", "tools2/on/4.png", "tools2/on/5.png", "tools2/on/6.png", "tools2/on/7.png", "tools2/on/8.png", "tools2/on/9.png", "tools2/on/10.png", "tools2/on/11.png", "tools2/on/12.png", "tools2/on/13.png", "tools2/on/14.png", "tools2/on/15.png", "tools2/on/16.png", "tools2/on/17.png", },
cont = [[
Инструменты\wh#
\C=

Вы можете использовать следующие инструменты для наполнения уровня:

\0
   Стена\h#


Используется для установки стен.

\1
   Фон\h#


Используется для установки фона.

\2
   Шипы\h#


Используется для устаноки шипов. Вы можете использовать вариацию автоматического
расширения для установки шипов на одной поверхности в один клик.

\3
   Тринкет\h#


Используеся для установки тринкетов. Учтите, что в одном уровне может быть
максимум двадцать тринкетов.

\4
   Чекпоинт\h#


Используется для установки чекпоинтов (точек сохранения).

\5
   Исчезающая платформа\h#


Используется для установки исчезающих платформ.

\6
   Конвеер\h#


Используется для установки конвееров.

\7
   Двигающаяся платворма\h#


Используется для установки двигающихся платформ.

\8
   Враг\h#


Используется для установки врагов. Тип и цвет врагов определяется настройкой
типа врага и цветом набора соответственно.

\9
   Грави-линия\h#


Используется для установки грави-линий.

\^0
   Текст\h#


Используется для установки текста в комнате.

\^1
   Компьютер\h#


Используется для установки компьютеров. Сначала установите компьютер, затем
введите название скрипта. Для дополнительной информации смотрите
справки о скриптах.

\^2
   Скрипт\h#


Используется для установки области скрипта. Сначала укажите правый верхний угол
области, затем левый нижний, затем введите название скрипта. Для дополнительной
информации смотрите справки о скриптах.

\^3
   Телепорт\h#


Используется для установки телепорта. Сначала кликните там, где должен быть вход,
затем там, где выход.

\^4
   Линия варпа\h#


Используется для установки линий варпа. Учтите, что линии варпа могут быть
расположены ролько на краях комнаты.

\^5
   Член экипажа\h#


Используется для установки членов экипажа, которых нужно спасти. Когда все члены
экипажа будут спасены, уровень будет пройден. Учтите, что в одном уровне может
быть максимум двадцать членов экипажа.

\^6
   Точка старта\h#


Используется для установки точки старта.
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

Для удобства чтения скриптов есть возможность использовать названия флагов
вместо чисел. Если вы используете имя вместо числа, число будет автоматически
звязано с этим названием. Также есть возможность выборара определённого числа для
определённого флага.

Режим внутреннего скриптинга\h#

Чтобы использовать внутренний скриптинг в Ved, Вы можете включить режим
внутреннего скриптинга в редакторе, чтобы расценивать все команды в данном
скрипте как во внутреннем скрипте. Смотри ¤Режим вн. скр.¤ для большей информации\nwl
о режиме внутреннего скриптинга. Для дополнительной информации о внутреннем
скриптинге смотрите пункт внутреннего скриптинга.

Разделение скриптов\h#

В редакторе скриптов есть возможность разделения скрипта на две части. Для этого
установите курсор на строке, которая должна быть первой в новом скрипте, затем
нажмите кнопку "Разделить" и введите название нового скрипта. После этого строки
перед курсором останутся в изначальном скрипте, а строки, начиная с положения
курсора и далее, будут перенесены в новый скрипт.

Переход к скриптам\h#

В строках с командами iftrinkets, ifflag, customiftrinkets или customifflag есть
возможность переходить к скриптам используя кнопку "Перейти" когда курсор
находится на строке с этой командой. Также можно нажать ¤Alt+ПКМ¤ чтобы это\nw
сделать, или можно нажать ¤Alt+ЛКМ¤ чтобы вернуться на исходный скрипт.\nw
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Режим вн. скр.",
imgs = {},
cont = [[
Режим нутреннего скриптинга\wh#
\C=

Чтобы использовать внутренний скриптинг в Ved, можно включить режим внутреннего
скриптинга в редакторе, чтобы все команды в данном скрипте воспринимались
внутренним скриптингом. Таким способом вам не придётся тратить больше усилий на
то, чтобы внутренний скриптинг работал; не нужно будет использовать команды ¤say¤,\nw
считать строки, или писать ¤text(1,0,0,4)¤ или ¤text,,,,4¤, смотря, какие у Вас\nwnw
предпочтения - просто пишите внутренние скрипты, как будто они были созданы для
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

Строки этого внутреннего скрипта ¤светло-зелёные¤; автоматически добавленные\nG
строки, необходимые для работы такого скриптинга будут ¤серыми¤. Заметьте, что это\ng
всё немного упрощено; в примере Ved добавляет ¤#v¤ на концах серых строк, чтобы\nw
убедиться, что написанные вручную скрипты не будут изменены, и что слишком большие
блоки ¤say¤ разбиты на более мелкие.\nw

Для дополнительной информации о внутреннем скриптинге смотрите пункт внутреннего
скриптинга.

Вн. скриптинг через loadscript\h#

Метод loadscript, пожалуй, самый распространённый на сегодняшний день. Ved
поддерживал его ещё с версии alpha.

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
subj = "Горячие клавиши",
imgs = {},
cont = [[
Горячие клавиши в редакторе\wh#
\C=

Tip: you can hold ¤F9¤ anywhere within Ved to see many of the shortcuts.\nC

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

< ¤и¤ >¤  менять инструмент\CnC
Ctrl/Cmd+< ¤and¤ Ctrl/Cmd+>¤  менять вариацию инструмента\CnC

Больше горячих клавиш\h#

Ved предоставляет несколько новых горячих клавиш

Основной редактор\gh#

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
Tab¤  enable/disable eraser\C

Entities\gh#

Shift+right click¤  Delete entity\C
Alt+click¤          Move entity\C
Alt+Shift+click¤    Copy entity\C

Редактор скриптов\gh#

Ctrl+F¤  Поиск\C
Ctrl+G¤  Перейти к строке\C
Ctrl+I¤  Переключить внутренний скриптинг\C
Alt+right¤  Перейти к скрипту с ссылкой на данной строке\C
Alt+left¤  Перейти к предыдущему скрипту по ссылке\C

Список скриптов\gh#

N¤  Создать новый скриптt\C
F¤  Перейти к списку скриптов\C
/¤  Перейти к первому/последнему скрипту\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Простые скрипты",
imgs = {},
cont = [[
Простейшие скрипты\wh#
\C=

Простейший язык скриптинга VVVVVV - это основа создания скриптов для создания
уровней в VVVVVV.
Учтите: то, что в этом пункте заключено в ковычки, должно писаться без них.


say¤([кол-во строк[,цвет]] .. "]]" .. [[)\h#w

Показывает текстовую рамку. При отсутствии аргументов создаёт серую текстовую
рамку с одной строкой, расположенную по центру. Аргумент color может быть как
цветом, так и именем члена экипажа.
Если вы используете цвет и в комнате есть член экипажа с соответствующим цветом,
то текстовая рамка будет расположена над ним.

reply¤([кол-во строк])\h#w

Показывает текстовую рамку Виридиана. Без аргументов показывает текстовую рамку
с одной строкой.

delay¤(N)\h#w

Задерживает сделующую команду на N тиков. 30 тиков примерно равны одной секунде.

happy¤([член экипажа])\h#w

Делает члена экипажа счасливым. Без аргумента сделает счастливым Виридиана. Также
можно использовать аргументы "all", "everyone" или "everybody", чтобы сделать
счастливыми всех.

sad¤([член экипажа])\h#w

Делает члена экипажа грустным. Без аргумента сделает грустным Виридиана. Также
можно использовать аргументы "all", "everyone" или "everybody", чтобы сделать
грустными всех.

flag¤(номер флага,on/off)\h#w

Включает (on) или выключает (off) флаг с данным номером. К примеру, flag(4,on)
включит флаг под номером 4. Всего есть 100 флагов, пронумерованных от 0 до 99.
По умолчанию все флаги выключены при запуске уровня.
На заметку: в Ved также можно использовать имена флагов вместо чисел.

ifflag¤(номер флага,название скрипта)\h#w

Если данный флаг ВКЛЮЧЁН, прыгнуть к срипту с данным названием.
Если данный флаг выключен, продожить выполнение скрипта.
Пример:
ifflag(20,cutscene) - Если флаг под номером 20 ВКЛЮЧЁН, прыгнуть к скрипту
                      "cutscene", иначе продолжить выполнение скрипта.
На заметку: в Ved также можно использовать имена флагов вместо чисел.

iftrinkets¤(кол-во,название скрипта)\h#w

Если количество собранных тринкетов >= "кол-во", прыгнуть к скрипту.
Если количество собранных тринкетов < "кол-во", продожить выполнение скрипта.
Пример:
iftrinkets(3,enoughtrinkets) - Если собрано 3 или более тринкетов, прыгнуть к
                               скрипту "enoughtrinkets", иначе продожить
                               выполнение скрипта.
Использование нуля, как минимального количества тринкетов - обычная практика.
Таким способом можно загрузить скрипт при любых обстоятельствах.

iftrinketsless¤(кол-во,название скрипта)\h#w

Если количество собранных тринкетов < "кол-во", прыгнуть к скрипту.
Если количество собранных тринкетов >= "кол-во", продожить выполнение скрипта.

destroy¤(нечто)\h#w

Рабочими аргументами являются:
warptokens - Убрать все телепорты из комнаты до последующего захода в неё.
gravitylines - Убрать все грави-линии из комнаты до последующего захода в неё.
Также есть аргумент "platforms" (платформы), но он не работает должным образом.

music¤(номер)\h#w

Поменять музыку на трек под данным номером.
Для просмотра номеров треков, воспользуйтесь пунктом "Список номеров".

playremix\h#w

Поменять музыку на ремикс Predestined Fate.

flash\h#w

Делает вспышку по всему экрану, играет звук взрыва и немного трясёт экран.

map¤(on/off)\h#w

Включает (on) или выключает (off) карту. Если карта выключена, она будет
показывать надпись "NO SIGNAL" до последующего её включения. Пройденные комнаты
всё равно будут отображаться после выключения и включения карты.

squeak¤(член экипажа/on/off)\h#w

Заставляет взвизгнуть данного члена экипажа, вкючает (on) или выключает (off)
звук взвизга при появлении текстовой рамки.

speaker¤(цвет)\h#w

Меняет цвет и положение последующих текстовых рамок, созданных командой "say".
Может использоваться как второй аргумент в команде "say".


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
Обычная - Эти команды должны работать, в худшем случае VVVVVV вылетет при
          допущенной ошибке.
Синяя¤   - Некоторые из этих команд не работают или не были созданы для\b
          пользовательских уровней, т. к. были сделаны для основной игры.
Рыжая¤   - Эти команды работают без ошибок, если им не присвоен определённый\o
          аргумент, при работе с которым команда удаляет сохранение игры.
Красная¤ - Красные команды не следует использовать в пользовательских уровнях\r
          т. к. они могут привести к разблокированию определённых частей
          основной игры (что не желательно, даже если все уже её прошли), или
          повредить файлы сохранения в целом.


activateteleporter¤()\w#h

If there's a teleporter in the room, it will start flashing random colors and
touching it won't destroy save data. Only targets the first-spawned teleporter.

activeteleporter¤()\w#h

Makes the teleporter in the room white, but touching it will still annihilate your
save data. Only targets the first-spawned teleporter.

alarmoff\w#h

Выключает тревогу

alarmon\w#h

Включает тревогу

altstates¤(x)\b#h

Меняет расстановку некоторых комнат, как в случае с комнатой с тринкетами на
корабле до и после взрыва, или вход в секретную лабораторию (пользовательские
уровни никак не поддерживают данную команду)

backgroundtext\w#h

Если данная команда стоит перед speak или speak_active, игра не будет ждать
нажатия клавиши действия после создания текстовой рамки. Может использоваться для
одновременного создания нескольких текстовых рамок.

befadein¤()\w#h

Немедленная отмена fadeout()

blackon¤()\w#h

Отмена blackout()

blackout¤()\w#h

Резко затемняет/замораживает экран

bluecontrol\b#h

Начинает разговор с Викторией как в основной игре. Создаёт зону действия.

changeai¤(член экипажа,ai1,ai2)\w#h

Может менять направление члена экипажа или его поведение

член экипажа - cyan   /player/blue /red    /yellow/green  /purple
              (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
ai1 -         followplayer/followpurple/followyellow/followred/followgreen
(следовать за:игрок       /фиолетовый  /жёлтый      /красный  /зелёный)

              /followblue/faceplayer        /panic     /faceleft/faceright
              (синий     /следить за игроком/паниковать/влево   /вправо)
              
              /followposition,ai2
              (следовать позиции),ai2
ai2 - необходим, если в ai1 использовано followposition

changecolour¤(a,b)\w#h

Меняет цвет члена экипажа (на заметку: работает только с членами экипажа,
созданными командой createcrewman)

a - Цвет члена экипажа, который нужно поменять:
 cyan   /player/blue /red    /yellow/green  /purple
(голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
b - Цвет, на который нужно поменять предыдущий

changedir¤(цвет,направление)\w#h

Как и в changeai, меняет направление члена экипажа

цвет - cyan   /player/blue /red    /yellow/green  /purple
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
направление - 0 - налево, 1 - направо

changegravity¤(crewmate)\w#h

Increase the sprite number of the given crewmate by 12.

crewmate - Color of crewmate to change cyan/player/blue/red/yellow/green/purple

changemood¤(цвет,настроение)\w#h

Поменять настроение члена экипажа (только для членов экипажа, созданных используя
createcrewman)

цвет - cyan   /player/blue /red    /yellow/green  /purple
(голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
настроение - 0 - счастливый, 1 - грустный

changeplayercolour¤(цвет)\w#h

Меняет цвет игрока.

цвет - cyan   /player/blue /red    /yellow/green  /purple    /teleporter
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый/цвет телепорта)

changetile¤(цвет,спрайт)\w#h

Поменять вид члена экипажа (на любой спрайт из sprites.png, работает только на
членах экипажа, созданных используя createcrewman)

цвет - cyan   /player/blue /red    /yellow/green  /purple    /gray
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый/серый)
спрайт - Номер спрайта

clearteleportscript¤()\b#h

Удаляет скрипт телепортирования, созданный teleportscript(скрипт)

companion¤(x)\b#h

Делает определённого члена экипажа x компаньоном (на сколько я помню, эта команда
зависит от расположения на карте)

createactivityzone¤(цвет)\b#h

Создаёт зону в позиции игрока с надписью "Press ACTION to talk to (Член экипажа)"

createcrewman¤(x,y,цвет,настроение,ai1,ai2)\w#h

Создаёт члена экипажа (нельзя спасти)

mood - 0 for happy, 1 for sad
настроение - 0 - счастливый, 1 - грустный
ai1 -         followplayer/followpurple/followyellow/followred/followgreen
(следовать за:игрок       /фиолетовый  /жёлтый      /красный  /зелёный)

              /followblue/faceplayer        /panic     /faceleft/faceright
              (синий     /следить за игроком/паниковать/влево   /вправо)
              
              /followposition,ai2
              (следовать позиции),ai2
ai2 - необходим, если в ai1 использовано followposition

createentity¤(x,y,номер,meta1,meta2)\o#h

Создаёт объект, пользуйтесь пунктом "Список номеров" для номеров объектов.

номер - Номер объекта

createlastrescued¤(x,y)\b#h

Создаёт последнего спасённого члена экипажа в точке x,y (?)

createrescuedcrew¤()\b#h

Создаёт всех спасённых членов команды

customifflag¤(номер флага,название скипта)\w#h

То же, что и ifflag(номер флага,название скипта) в простейшем скриптинге

customiftrinkets¤(кол-во,скрипт)\w#h

То же, что и iftrinkets(кол-во,скрипт) в простейшем скриптинге

customiftrinketsless¤(кол-во,скрипт)\w#h

То же, что и iftrinketsless(кол-во,скрипт) в простейшем скриптинге (не работает
должным образом)

custommap¤(on/off)\w#h

Внутренний вариант команды управления картой

customposition¤(x,y)\w#h

Переопределяет x,y текстовой команды, тем самым устанавливая позицию текстовой
рамки, а в случае с членами экипажа это работает только на спасаемых членах
экипажа, не созданных с помощью createcrewman.

x - center/centerx/centery, или цвет
   (центр /центр x/центр y)
 cyan   /player/blue /red    /yellow/green  /purple     (спасаемые)
(голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
y - Используется только если x - цвет. Принимает значения above /below
                                                         (сверху/снизу)

cutscene¤()\w#h

Создаёт границы катсцены

delay¤(x)\w#h

То же, что и в соответствующей простейшей команде

destroy¤(x)\w#h

То же, что и в соответствующей простейшей команде

x - gravitylines/warptokens/platforms
   (грави-линии /телепорты /платформы)

do¤(n)\w#h

Starts a loop block which will repeat n times. End the block with the loop
command.

endcutscene¤()\w#h

Убирает границы катсцены

endtext\w#h

Заставляет текстовую рамку плавно исчезнуть

endtextfast\w#h

Заставляет текстовую рамку исчезнуть немедленно

entersecretlab\r#h

Действидельно разблокирует секретную лабораторию в основной игре, что скорее
является нежелательным эффектом для пользовательской игры. Включает режим
секретной лаборатории.

everybodysad¤()\w#h

Сделать всех грустными  (только для членов экипажа, созданных используя
createcrewman, и игрока)

face¤(a,b)\w#h

Поворачивает члена экипажа a смотреть на члена экипажа b (работает только на
членах экипажа, созданных используя createcrewman)

a,b - cyan   /player/blue /red    /yellow/green  /purple
     (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)

fadein¤()\w#h

Плавно отменяет fadein()

fadeout¤()\w#h

Плавно затемняет экран

finalmode¤(x,y)\b#h

Телепортирует игрока во Внешнее Измерение VVVVVV, (45,54) - начальная комната
Последнего Уровня

flag¤(x,on/off)\w#h

То же, что и в соответствующей простейшей команде

flash¤(x)\w#h

Делает экран белым, можно настроить время x, которое будет длиться этот эффект
(команда flash не сработает, придётся использовать flash(5), playef(9) и shake(20)
для её воссоздания)

x - количество тиков. 30 тиков примерно равны одной секунде.

flip\w#h

Переворачивает гравитацию игрока

flipgravity¤(цвет)\w#h

Меняет гравитацию данного чена экипажа (не всегда работает на игроке)

цвет - cyan   /player/blue /red    /yellow/green  /purple
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)

flipme\w#h

Исправляет вертикальное расположение нескольких текстовых рамок во flip-режиме

foundlab\b#h

Проигрывает звуковой эффект 3, показывает текстовую рамку с надписью
"Congratulations! You have found the secret lab!". Не выплняет endtext и не имеет
последующих нежелательных эффектов.

foundlab2\b#h

Показывает вторую текстовую рамку после обнаружения секретной лаборатории. Так же
не выплняет endtext и не имеет последующих нежелательных эффектов.

foundtrinket¤(x)\w#h

Находит тринкеты

x - Количество тринкетов

gamemode¤(x)\b#h

Аргумент teleporter для открытия каты и указания телепортов основной игры,
аргумент game для скрытия карты

x - teleporter/game

gamestate¤(x)\o#h

Меняет номер состояния игры на число x, пользуйтесь пунктом "Список номеров"
для номеров состояний игры

gotoposition¤(x,y,f)\w#h

Сделать координатную позицию Виридиана x,y в данной комнате, f определяет
состояние (1 - перевёрнутый, 0 - нормальный)

f - 1 for flipped, 0 for not flipped. WARNING: Do not leave this unspecified, or
else you could softlock the game!

gotoroom¤(x,y)\w#h

Поменять комнату на x,y (x и y принимают значения больше нуля)

x - координата x комнаты, больше нуля
y - координата y комнаты, больше нуля

greencontrol\b#h

Начинает разговор с Вердигрисом как в основной игре. Создаёт зону действия.

hascontrol¤()\w#h

Даёт игроку управление, не работает в середине скриптов

hidecoordinates¤(x,y)\w#h

Скрывает координаты x,y на карте (работает в пользовательских уровнях)

hideplayer¤()\w#h

Делает игрока невидимым

hidesecretlab\w#h

Скрывает секретную лабораторию на карте

hideship\w#h

Скрывает корабль на карте

hidetargets¤()\b#h

Скрывает цели на карте

hideteleporters¤()\b#h

Скрывает телепорты на карте

hidetrinkets¤()\b#h

Скрывает тринкеты на карте

ifcrewlost¤(член экипажа,скрипт)\b#h

Если член экипажа не был найден, выполнить скрипт

ifexplored¤(x,y,скрипт)\w#h

Если x+1,y+1 уже изучено, выполнить (внутренний) скрипт

ifflag¤(номер флага,название скипта)\b#h

То же, что и customifflag, но включающий скрипт основной игры

iflast¤(член экипажа,скрипт)\b#h

Если определённый член экипажа был спасён последним, выполнить скрипт

член экипажа - Использованные номера: 0: Viridian, 1: Violet, 2: Vitellary, 3:
Vermilion, 4: Verdigris, 5 Victoria

ifskip¤(x)\b#h

Если игрок пропускает катсцену в Режиме Без Смертей, выполнить скрипт x

iftrinkets¤(кол-во,скрипт)\b#h

То же, что и в простейшем скриптинге, но включающий скрипт основной игры

iftrinketsless¤(кол-во,скрипт)\b#h

То же, что и в простейшем скриптинге, но включающий скрипт основной игры

ifwarp¤(x,y,dir,script)\w#h

If the warpdir for room x,y, 1-indexed, is set to dir, go to (simplified) script

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

jukebox¤(x)\w#h

Меняет цвет терминала-проигрывателя на белый и выключает подсветку остальных
(похоже, что в пользовательских уровнях эта команда просто выключает подсветку
использованных терминалов)

leavesecretlab¤()\b#h

Выключает "режим секретной лаборатории"

loadscript¤(скрипт)\b#h

Загружает скрипт основной игры. В пользовательских уровнях обычно используется
как loadscript(stop)

loop\w#h

Put this at the end of a loop block started with the do command.

missing¤(цвет)\b#h

Убирает у члена экипажа состояние спасённого

moveplayer¤(x,y)\w#h

Moves the player x pixels to the right and y pixels down. Of course you can also
use negative numbers to make them move up or to the left

musicfadein¤()\w#h

An unfinished command. This does nothing.

musicfadeout¤()\w#h

Применяет эффект плавного затухания к музыке

nocontrol¤()\w#h

Обратное hascontrol()

play¤(x)\w#h

Играет трек под номером x

x - Номер трека

playef¤(x,n)\w#h

Возпроизвести звуковой эффект x

n - Не используется, может быть нетронутым. В ранних версиях VVVVVV использовался
для обозначения задержки перед воспроизведением в милисекундах.

position¤(x,y)\w#h

Переопределяет x и y текстовой команды, тем самым устанавливая позицию
текстовой рамки.

x - center/centerx/centery,
   (центр /центр x/центр y)
или можно использовать цвета:
 cyan   /player/blue /red    /yellow/green  /purple
(голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый)
y - используется, только если x - цвет. Принимает значения above /below
                                                          (сверху/снизу)

purplecontrol\b#h

Начинает разговор с Виолеттой как в основной игре. Создаёт зону действия.

redcontrol\b#h

Начинает разговор с Вермилионом как в основной игре. Создаёт зону действия.

rescued¤(цвет)\b#h

Спасает определённого члена экипажа

resetgame\w#h

Возвращает в начальное состояние все тринкеты, членов экипажа и флаги,
телепортирует игрока к последнему чекпоинту

restoreplayercolour¤()\w#h

Меняет цвет игрока обратно на голубой

resumemusic¤()\w#h

An unfinished command. Reads from uninitialized memory, which results in a crash
on some machines and just results in playing Path Complete on others.

rollcredits¤()\r#h

Запускает титры. Это удаляет файл сохранения после окончания титров!

setcheckpoint¤()\w#h

Устанавливает чекпоинт в данной позиции

shake¤(n)\w#h

Трясёт экран n тиков. Не создаёт задержку.

showcoordinates¤(x,y)\w#h

Показывает координаты x,y на карте (работает в пользовательских уровнях)

showplayer¤()\w#h

Показывает игрока

showsecretlab\w#h

Показывает секретную лабораторию на карте

showship\w#h

Показывает корабль на карте

showtargets¤()\b#h

Показывает цели на карте (неизвестные телепорты, обозначаемые знаками вопроса)

showteleporters¤()\b#h

Показывает телепорты на карте (по-моему, показывает только телепорт на
Космической Станции 1)

showtrinkets¤()\b#h

Показывает тринкеты на карте

speak\w#h

Показывает текстовую рамку, не убирая предыдущие. Также приостанавливает скрипт
пока не будет нажата клавиша действия (если до этого не было
команды backgroundtext).

speak_active\w#h

Создаёт текстовую рамку, убирая предыдущую. Также приостанавливает скрипт пока не
будет нажата клавиша действия (если до этого не было команды backgroundtext).

specialline¤(x)\b#h

Особые диалоги, которые появляются в основной игре

squeak¤(цвет)\w#h

Заставляет члена команды взвизгнуть, или терминал - издать звук.

цвет - cyan   /player/blue /red    /yellow/green  /purple    /terminal
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый/терминал)

startintermission2\w#h

Альтернатива finalmode(46,54), переносит игрока на финальный уровень не требуя
аргументов. Выленает в комнате Timeslip.

stopmusic¤()\w#h

Немедленно останавливает музыку. То же, что и music(0) в простом скриптинге.

teleportscript¤(скрипт)\b#h

Раньше использовался для создания скрипта при телепортировании

telesave¤()\r#h

Сохраняет игру (только при обычном сохранении у телепорта; не использовать!)

text¤(цвет,x,y,строки)\w#h

Сохраняет текстовую рамку с цветом, координатами и её количеством строк в
памяти. Обычно используется после текстовой команды (с её строками), которая
переписывает данные координаты, так что обычно их приравнивают к нулю.

цвет - cyan   /player/blue /red    /yellow/green  /purple    /gray
      (голубой/игрок /синий/красный/жёлтый/зелёный/фиолетовый/серый)
x - координата x текстовой рамки
y - координата y текстовой рамки
строки - количество строк

textboxactive\w#h

Убирает все текстовые рамки, кроме последней созданной

tofloor\w#h

Makes the player flip to the floor if they aren't already on the floor.

trinketbluecontrol¤()\b#h

Диалог с Викторией когда она даёт тебе тринкет из основной игры

trinketscriptmusic\w#h

Plays Passion for Exploring. Does nothing else.

trinketyellowcontrol¤()\b#h

Диалог с Вителлари когда он даёт тебе тринкет из основной игры

undovvvvvvman¤()\w#h

Вернуть игроку нормальный размер

untilbars¤()\w#h

Ждать, пока закончится выполнение cutscene()/endcutscene()

untilfade¤()\w#h

Ждать конца выполнения fadeout()/fadein()

vvvvvvman¤()\w#h

Делает игрока огромным

walk¤(направление,тики)\w#h

Заставляет игрока идти определённое количество тиков в данном направлении

направление - left /right
             (влево/вправо)

warpdir¤(x,y,dir)\w#h

Changes the warp direction for room x,y, 1-indexed, to the given direction. This
could be checked with ifwarp, resulting in a relatively powerful extra
flags/variable system.

x - Room x coordinate, starting at 1
y - Room y coordinate, starting at 1
dir - The warp direction. Normally 0-3, but out-of-bounds values are accepted

yellowcontrol\b#h

Начинает разговор с Вителлари как в основной игре. Создаёт зону действия.
]]
},

{
splitid = "090_Lists_reference",
subj = "Списки номеров",
imgs = {},
cont = [[
Список номеров\wh#
\C=

Здесь представлены номера, используемые в VVVVVV, в основном скопированных с
постов на форуме. Спасибо всем, кто помог собрать этот список!


Пункты\w&Z+
\&Z+
#Номера музыки (простой скриптинг)\C&Z+l
#Номера музыки (внутренний скриптинг)\C&Z+l
#Номера звуковых эффектов\C&Z+l
#Объекты\C&Z+l
#Список цветов для createentity() crewmates\C&Z+l
#Типы движения врагов\C&Z+l
#Состояния игры\C&Z+l


Номера музыки (простой скриптинг)\h#

0 - Тишина (нет музыки)
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

Номера музыки (внутренний скриптинг)\h#

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

Номера звуковых эффектов\h#

0 - Переворот вверх
1 - Переворот вниз
2 - Плач
3 - Тринкет
4 - Монета
5 - Чекпоинт
6 - Быстрый зыбучий песок
7 - Обычный зыбучий песок
8 - Грави-линия
9 - Вспышка
10 - Варп
11 - Голос Виридиана
12 - Голос Вердигриса
13 - Голос Виктории
14 - Голос Вителлари
15 - Голос Виолетты
16 - Голос Вермилиона
17 - Касание терминала
18 - Телепорт
19 - Сигнал тревоги
20 - Звук терминала
21 - Обратный отсчёт испытания временем
22 - "Go!" испытания временем
23 - Разрушение стены человеком VVVVVV
24 - Члены экипажа сливаются в форму человека VVVVVV (восстанавливаются из неё)
25 - Новый рекорд в Супер Гравитроне
26 - Новый трофей в Супер Гравитроне
27 - Спасение члена экипажа (в пользовательских уровнях)

Объекты\h#

0 - Игрок
1 - Враг
    Данные: тип движения, скорость движения
    Из-за отсутствия необходимых данных, Вы получите лишь фиолетовую
    коробку-врага, за исключением использования этой команды в полярном измерении
    VVVVVV.
2 - Движущаяся платформа
    Учтите: в данном случае конвееры считаются движущимися платформами, смотрите
    типы движения 8 и 9.
3 - Исчезающая платформа
4 - Единичный блок быстрого зыбучего песка
5 - Перевёрнутый Виридиан, переворачивает гравитацию при касании
6 - Непонятная мерцающая красная штука, которая быстро пропадает
7 - То же, что и сверху, но не мерцает и голубого цвета
8 - Монета из прототипа
    Данные: ID монеты
9 - Трикет
    Данные: ID тринкета
    Учтите: ID тринкетов начинаются с 0, любое число выше 19 не сохранится в
    файле уровня при перезапуске.
10 - Чекпоинт
     Данные: Состояние чекпоинта (0 - перевёрнутый, 1 - нормальный), ID чекпоинта
     (проверяет, активен ли чекпоинт)
11 - Горизонтальная грави-линия
     Данные: длина в пикселях
12 - Вертикальная грави-линия
     Данные: длина в пикселях
13 - Жетон телепортации
     Данные: Пункт назначения в тайлах по оси X, пункт назначения в тайлах по
     оси Y
14 - Круглый телепорт
     Данные: ID чекпоинта(?)
15 - Вердигрис
     Данные: состояние AI
16 - Вителлари (перевёрнутый)
     Данные: состояние AI
17 - Виктория
     Данные: состояние AI
18 - Член экипажа
     Данные: Цвет (из списка цветов, не цвет члена экипажа), настроение
19 - Вермилион
     Данные: состояние AI
20 - Терминал
     Данные: Спрайт, ID скрипта(?)
21 - То же, что и сверху, но не высвечивается при касании
     Данные: Спрайт, ID скрипта(?)
22 - Собранный тринкет
     Данные: ID тринкета
23 - Квадрат из Грвитрона
     Данные: направление
     При вводе отрицательной координаты X (или слишком большой) появляется
     только стрелка, как в настоящем Гравитроне
24 - Член экипажа сбоя 1
     Данные: Цвет из списка цветов
     По всей видимости, не страдает от припядствий, чего не следует происходить
25 - Трофей
     Данные: Идентификатор задания, спрайт
     Если задание выполнено, начальное ID спрайта (при sprite=0) изменится.
     Используйте 0 или 1 для предсказуемых результатов (0-нормальный,
     1 - перевёрнутый)
26 - Варп в Секретную Лабораторию
     Учтите, что это только красивый спрайт. Вам придётся создавать отдельный
     скрипт для его функционирования.
55 - Спасаемый член экипжа
     Данные: Цвет члена экипажа. Номера больше 6 дают в результате *счастливого*
     Виридиана.
56 - Враг пользовательского уровня
     Данные: тип движения, скорость движения
     Учтите, что если в комнате врагов нет, то данные врага будут обновленны
     некорректно и в результате это покажет врага, которого вы видели в последний
     раз, или квадратного врага.
Неуказанные объекты (27-50, 57 и далее) дают в результате неисправных Виридианов.

Список цветов для createentity() crewmates\h#

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
102: Цвет телепорта
103 и далее: белый

Типы движения врагов\h#

0 - Прыжки вверх-вниз, сначала вниз.
1 - Прыжки вверх-вниз, сначала вверх.
2 - Движение влево-вправо, сначала влево.
3 - Движение влево-вправо, сначала вправо.
4, 7, 11 - Движение вправо до касания с поверхностью
5 - То же, что и сверху, но ведёт себя странно при соприкосновении
    GIF-пример: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Движение вверх-вниз, но движется вниз только при достижении определённой
    позиции Y. Используется в комнате "Trench warfare".
8, 9 - Конвееры для движущихся платформ и стационарность для всего остального
14 - Может быть блокировно исчезающими платформами
15 - Стационарно (?)
10, 12 - Клонируется вправо/в этой же точке, заставляет VVVVVV вылететь при
         большой интенсивности, искажает файл уровня при сохранении.
13 - Как 4, но движение вниз.
16 - Пропадает из бытия. (Появляется и исчезает)
17 - Дёрганное движение вправо
18 - Дёрганное движение вправо, немного быстрее
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
31 - Катсцена "Violet, is that you?" (если флаг 6 равен 0)
32 - Если флаг 7 равен 0: "A teleporter!" "I can get back to the ship with this!"
33 - Если флаг 9 равен 0: Катсцена с Викторией
34 - Если флаг 10 равен 0: Катсцена с Вителлари
35 - Если флаг 11 равен 0: Катсцена с Вердигрисом
36 - Если флаг 8 равен 0: Катсцена с Вермилионом
37 - Вителлари после гравитрона
38 - Вермилион после гравитрона
39 - Вердигрис после гравитрона
40 - Виктория после гравитрона
41 - Если флаг 60 равен 0: Воспроизводит начало катсцены сбоя 1
42 - Если флаг 62 равен 0: Воспроизводит 3 катсцену сбоя 1
43 - Если флаг 63 равен 0: Воспроизводит 4 катсцену сбоя 1
44 - Если флаг 64 равен 0: Воспроизводит 5 катсцену сбоя 1
45 - Если флаг 65 равен 0: Воспроизводит 6 катсцену сбоя 1
46 - Если флаг 66 равен 0: Воспроизводит 7 катсцену сбоя 1
47 - Если флаг 69 равен 0: Катсцена с тринкетом "Ohh! I wonder what that is?"
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
92 - Зона Варпа
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
200 - Режим финала
1000 - Включает границы катсцен, приостанавливает игру, переход к состоянию 1001
1001 - Диалог "You got a shiny trinket!" (на самом деле Вы не получаете тринкет,
       диалог высвечивается каждый раз при собирании тринкетов), переход к
       состоянию 1003
1003 - Вернуть игру в нормальный режим
1010 - "You found a crewmate!" в том же духе, как и с тринкетами
1013 - End level with stars
2000 - Сохранить игру
2500-2509 - Телепортироваться в какую-то странную несуществующую локацию, скорее
            всего имелась ввиду Лаборатория, перейти к состоянию 2510
2510 - Виридиан: "Hello?", перейти к состоянию 2512
2512 - Виридиан: "Is anybody there?", перейти к состоянию 2514
2514 - Убирает текстовые рамки, воспроизводит Potential For Anything
Состояния 3000-3099:
3000-3005 - "Level Complete! You've rescued the crewmate" применяемый к
            companion(), по умолчанию - Виридиан. 6 - Вердигрис, 7 -Вителлари,
            8 - Виктория, 9- Вермилион, 10 - Виридиан (зуб даю), 11 - Виолетта
            (Состаяния игры: 3006-3011 - Вердигрис, 3020-3026 - Вителлари,
            3040-3046 - Виктория, 3060-3066 - Вермилион, 3080-3086 - Виридиан,
            3050-3056 - Виолетта)
3070-3072 - Делает вещи, выполняемые после спасения, обычно возвращает на корабль
3501 - Игра Завершена
4010 - Вспышка + варп
4070 - The Final Level, but the game will crash when you reach Timeslip (Because
       of how the game gets entity information, which is broken in custom levels)
       The Final Level, но игра крашается при достижении Timeslip (из-за
       получения игрой данных объекта, неисправных в пользовательских уровнях)
4080 - Captain teleported back to the ship: "Hello!" [C[C[C[C[Captain!] cutscene +
       credits.
       Капитан телепортируется обратно на корабль, катсцена
       "Hello!" [C[C[C[C[Captain!] + титры.
       Это испортит Ваши данные сохранения, так что не рискуйте, если не
       сделали бекап!
4090 - Катсцена после Космической Станции 1
]]
},

{
splitid = "100_Formatting",
subj = "Оформление",
imgs = {},
cont = [[
Оформление\wh#
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
subj = "Авторы",
imgs = {"credits.png"},
cont = [[
\0















Авторы\wh#
\C=

Создатель Ved: Dav999

Другие программисты: Info Teddy

Некоторая графика и шрифт: Hejmstel

Russian translation: CreepiX, Cheep
Esperanto translation: Hejmstel
German translation: r00ster
French translation: RhenaudTheLukark
Spanish translation: Valso22/naether


Отдельная благодарность:\h#


Терри Кавана, создателю VVVVVV

Всем, кто оповещал об ошибках, помогал идеями и мотивировал меня создать это!
\
\




License\h#
\
Copyright 2015-2020  Dav999
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