-- Language file for Ved
-- b17

L = {

TRANSLATIONCREDIT = "Сделано CreepiX'ом", -- If you're making a translation, feel free to set this to something like "Translation made by (you)"

OUTDATEDLOVE = "Ваша версия LOVE устарела. Пожалуйста, используйте версию 0.9.0 или выше. Загрузите LOVE на http://love2d.org/.",
UNKNOWNSTATE = "Неизвестный режим ($1), пригнул из $2",
FATALERROR = "ФАТАЛЬНАЯ ОШИБКА: ",
FATALEND = "Поажлуйста, закройте игру и попробуйте ещё раз.",

OSNOTRECOGNIZED = "Ваша ОС ($1) не опознана! Возвращаюсь к первичным настройкам файловой системы; ваши уровни находятся в:\n\n$2",
MAXTRINKETS = "Максимальное количество тринкетов (20) было достигнуто.",
MAXTRINKETS_BYPASS = "Максимальное количество тринкетов (20) было достигнуто.\n\nДобавление новых может вызвать глюки. Вы уверены что хотите превысить лимит?",
MAXCREWMATES = "Максимальное количество членов экипажа (20) было достигнуто.",
MAXCREWMATES_BYPASS = "Максимальное количество членов экипажа (20) было достигнуто.\n\nДобавление новых может вызвать глюки. Вы уверены что хотите превысить лимит?",
EDITINGROOMTEXTNIL = "Редактируемый текст не найден!",
STARTPOINTNOLONGERFOUND = "Старая точка старта не найдена!",
UNSUPPORTEDTOOL = "Неподдерживаемый инструмент! Инструмент: ",
SURENEWLEVEL = "Вы действительно хотите создать новый уровень? Вы потеряете весь несохранённый контент.",
SURELOADLEVEL = "Вы действительно хотите загрузить другой уровень? Вы потеряете весь несохранённый контент.",
COULDNOTGETCONTENTSLEVELFOLDER = "Папка с уровнями не найдена. Пожалуйста, убедитесь что $1 существует и попробуйте снова.",
MAPSAVEDAS = "Снимок карты сохранён как $1 в папке $2!",
RAWENTITYPROPERTIES = "Вы можете изменять значения этого объекта.\n",
UNKNOWNENTITYTYPE = "Неизвестный тип объекта $1",
METADATAENTITYCREATENOW = "Объект данных не существует. Создать?\n\nОбъект данных это скрытый объект который может быть добален в уровень для хранения дополнительной информации используемой Ved, например записки уровня, названия флагов и т.д.",
WARPTOKENENT404 = "Объект телепорта больше не существует!",
SPLITFAILED = "Разделение провалено! У вас слишком много линий между комадами text и speak/speak_active!", -- Command names are best left untranslated
NOFLAGSLEFT = "Все флаги использованы, новые имена флагов в этом скрипте не будут ассоциироваться с номерами флагов. Попытка запустить этот скрипт в VVVVVV крашнет игру. Уберите все флаги которые вам не нужны и попробуйте ещё раз.\n\nПокинуть редактор?",
LEVELOPENFAIL = "Невозможно открыть $1.vvvvvv.",
SIZELIMITSURE = "Максимальный размер уровня 20x20.\n\nПревышение этого лимита может вызвать глюки при загрузке уровня в VVVVVV. Вы уверены что хотите превысить лимит?",
SIZELIMIT = "Максимальный размер уровня 20x20.\n\nРазмер уровня будет изменён на $1x$2.",
SCRIPTALREADYEXISTS = "Скрипт \"$1\" уже существует!",
FLAGNAMENUMBERS = "Имя флага не может состоять только из цифр.",
FLAGNAMECHARS = "Имя флага не может содержать (, ), , или пробел.",
FLAGNAMEINUSE = "Имя флага $1 уже используется флагом $2",
DIFFSELECT = "Выберите второй уровень для сравнения. Уровень который вы выберете будет считаться за старую версию.",
SUREQUIT = "Вы действительно хотите выйти? Вы потеряете весь несохранённый контент.",
SCALEREBOOT = "Новые настройки размера придут в силу после перезапуска Ved.",
NAMEFORFLAG = "Имя флага $1:",
SCRIPT404 = "Скрипт \"$1\" не существует!",
ENTITY404 = "Объект #$1 не существует!",
GRAPHICSCARDCANVAS = "Ваша видеокарта не поддерживает данную функцию!",
SUREDELETESCRIPT = "Вы уверены что хотите удалить скрипт \"$1\"?",
SUREDELETENOTE = "Вы уверены что хотите удалить эту записку?",
THREADERROR = "Ошибка темы!",
NUMUNSUPPORTEDPLUGINS = "У вас установлен $1 плагин который не поддерживает данную версию.",
WHATDIDYOUDO = "Что ты наделал?!",
UNDOFAULTY = "Что ты делаешь?",
SOURCEDESTROOMSSAME = "Изначальная комната и конечная комната одна и та же!",
UNKNOWNUNDOTYPE = "Неизвестный тип отмены \"$1\"!",
MDEVERSIONWARNING = "Этот уровень был сделан в более поздней версии Ved, и может содержать информацию которая будет потеряна при сохранении.",
LEVELFAILEDCHECKS = "Этот уровень провалил $1 проверку. Ошибки могли быть исправлены автоматически, но это не точно.",
FORGOTPATH = "Вы забыли указать путь!",
MDENOTPASSED = "Внимание: объекту данных запрещён доступ к команде savelevel!",
RESTARTVEDLANG = "После изменения языка, необходимо перезапустить Ved.",

SELECTCOPY1 = "Выберите комнату для копирования",
SELECTCOPY2 = "Выберите координаты для этой комнаты",
SELECTSWAP1 = "Выберите первую комнату для замены",
SELECTSWAP2 = "Выберите вторую комнату для замены",

TILESETCHANGEDTO = "Стиль стен изменён на $1",
TILESETCOLORCHANGEDTO = "Цвет стен изменён на $1",
ENEMYTYPECHANGED = "Тип врагов изменён",

CHANGEDTOMODE = "Выбран $1 режим.", -- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODEAUTO = "автоматический",
CHANGEDTOMODEMANUAL = "ручной",
CHANGEDTOMODEMULTI = "мульти",

BUSYSAVING = "Сохраняю...",
SAVEDLEVELAS = "Уровень сохранён как $1.vvvvvv",

ROOMCUT = "Комната вырезана в буфер обмена",
ROOMCOPIED = "Комната скопирована в буфер обмена",
ROOMPASTED = "Комната вставлена из буфера обмена",

BOUNDSTOPLEFT = "Кликите на левый верхний угол рамки.",
BOUNDSBOTTOMRIGHT = "Кликите на правый нижний угол рамки.",

TILE = "Стена $1",
HIDEALL = "Спрятать всё",
SHOWALL = "Показать всё",
SCRIPTEDITOR = "Редактор Скриптов",
FILE = "Файл",
NEW = "Создать",
OPEN = "Открыть",
SAVE = "Сохранить",
UNDO = "Отменить",
REDO = "Отменить отмену",
COMPARE = "Сравнить",
STATS = "Статус",
SCRIPTUSAGES = "Использование",
EDITTAB = "Редактировать",
COPYSCRIPT = "Копировать",
SEARCHSCRIPT = "Поиск",
GOTOLINE = "Перейти к линии",
GOTOLINE2 = "Перейти к линии:",
INTERNALON = "Внутренние скрипты",
INTERNALOFF = "Внутренние скрипты",
VIEW = "Просмотр",
SYNTAXHLOFF = "Подсветка включена",
SYNTAXHLON = "Подсветка отключена",
TEXTSIZEN = "Нормальный",
TEXTSIZEL = "Большой",
INSERT = "Вставить",
HELP = "Помощь",
INTSCRWARNING_NOLOADSCRIPT = "Требуется загрузочный скрипт!",
INTSCRWARNING_BOXED = "Прямая загрузка!\n\n",
COLUMN = "Буква: ",

BTN_OK = "OK",
BTN_CANCEL = "Отменить",
BTN_YES = "Да",
BTN_NO = "Нет",
BTN_APPLY = "Применить",
BTN_QUIT = "Выход",

COMPARINGTHESE = "Сравниваю $1.vvvvvv с $2.vvvvvv",
COMPARINGTHESENEW = "Сравниваю (несохранённый уровень) и $1.vvvvvv",

RETURN = "Возврат",
CREATE = "Создать",
GOTO = "Перейти",
DELETE = "Удалить",
RENAME = "Переименовать",
CHANGEDIRECTION = "Изменить направление",
DIRECTION = "Направление ->",
UP = "вверх",
DOWN = "вниз",
LEFT = "влево",
RIGHT = "вправо",
TESTFROMHERE = "Играть отсюда",
FLIP = "Флип",
CYCLETYPE = "Изменить тип",
GOTODESTINATION = "Перейти к точке назначения",
GOTOENTRANCE = "Перейти к телепорту",
CHANGECOLOR = "Изменить цвет",
EDITTEXT = "Изменить текст",
COPYTEXT = "Копировать текст",
EDITSCRIPT = "Редактировать скрипт",
OTHERSCRIPT = "Присвоить другой скрипт",
PROPERTIES = "Свойства",
CHANGETOHOR = "Изменить на горизонтальный",
CHANGETOVER = "Изменить на вертикальный",
RESIZE = "Подвинуть",
CHANGEENTRANCE = "Подвинуть вход",
CHANGEEXIT = "Подвинуть выход",
BUG = "[Глюк!]",

VEDOPTIONS = "Настройки",
LEVELOPTIONS = "Настройки уровня",
MAP = "Карта",
SCRIPTS = "Скрипты",
SEARCH = "Поиск",
SENDFEEDBACK = "Отзыв",
LEVELNOTEPAD = "Записки",
PLUGINS = "Плагины",

BACKB = "Назад <<",
MOREB = "Вперёд >>",
AUTOMODE = "Автоматический",
AUTO2MODE = "Мульти",
MANUALMODE = "Ручной",
PLATFORMSPEED = "Скорость: $1",
ENEMYTYPE = "Тип: $1",
PLATFORMBOUNDS = "Рамка",
WARPDIR = "Тип варпа: $1",
ENEMYBOUNDS = "Рамка",
ROOMNAME = "Название",
ROOMOPTIONS = "Настройки комнаты",
ROTATE180 = "Повернуть на 180 градусов",
HIDEBOUNDS = "Скрыть рамки",
SHOWBOUNDS = "Показать рамки",

ROOMPLATFORMS = "Платформы", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Враги",

OPTNAME = "Название",
OPTBY = "Автор",
OPTWEBSITE = "Сайт",
OPTDESC = "Описание", -- If necessary, you can span multiple lines by using \n
OPTSIZE = "Размер",
OPTMUSIC = "Саундтрек",
CAPNONE = "НЕТ",
ENTERLONGOPTNAME = "Название уровня:",

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

VERSIONERROR = "Невозможно узнать версию.",
VERSIONUPTODATE = "Ваша версия последняя.",
VERSIONOLD = "Доступно обновление! Последняя версия: $1",
VERSIONCHECKING = "Проверяю обновления...",
VERSIONDISABLED = "Проверка обновлений отключена",

SAVESUCCESS = "Сохранение успешно!",
SAVENOSUCCESS = "Сохранение провалено! Ошибка: ",

EDIT = "Редактировать",
EDITWOBUMPING = "Редактировать w/o бампинг",
COPYNAME = "Копировать имя",
COPYCONTENTS = "Копировать контент",
DUPLICATE = "Дублировать",

NEWSCRIPTNAME = "Имя:",
CREATENEWSCRIPT = "Создать новый скрипт",

NEWNOTENAME = "Имя:",
CREATENEWNOTE = "Создать новую записку",

ADDNEWBTN = "[Добавить Новый]",
IMAGEERROR = "[ОШИБКА ИЗОБРАЖЕНИЯ]",

NEWNAME = "Новое название:",
RENAMENOTE = "Переименовать записку",
RENAMESCRIPT = "Переименовать скрипт",

LINE = "линия ",

SAVEMAP = "Сохранить карту",
SAVEFULLSIZEMAP = "Сохранить полную карту",
COPYROOMS = "Копировать комнату",
SWAPROOMS = "Заменить комнаты",

FLAGS = "Флаги",
ROOM = "Комната",
CONTENTFILLER = "Контент",

   FLAGUSED = "Использован   ",
FLAGNOTUSED = "Не использован",
FLAGNONAME = "Нет имени",
USEDOUTOFRANGEFLAGS = "Использовано флагов:",

CUSTOMVVVVVVDIRECTORY = "Папка VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Впишите сюда полный путь к папке VVVVVV если это не \"$1\" (оставьте пустым). Не включайте папку \"levels\" и палочку наклонённую верхом влево.",
LANGUAGE = "Язык",
DIALOGANIMATIONS = "Анимация диалогов",
ALLOWLIMITBYPASS = "Отключить лимиты",
FLIPSUBTOOLSCROLL = "Флипнуть направление прокручивания",
ADJACENTROOMLINES = "Индикаторы стен",
ASKBEFOREQUIT = "Подтверждение выхода",
COORDS0 = "Отображать координаты с 0 (для внутренних скриптов)",
ALLOWDEBUG = "Включить режим разработчика",
SHOWFPS = "Показывать счётчик FPS",
IIXSCALE = "2x размер",
CHECKFORUPDATES = "Проверять обновления",

SCRIPTUSAGESROOMS = "$1 использований в комнатах: $2",
SCRIPTUSAGESSCRIPTS = "$1 использований в скриптах: $2",

SCRIPTSPLIT = "Разделить",
SPLITSCRIPT = "Разделить скрипты",
COUNT = "Счёт: ",
SMALLENTITYDATA = "Инфо",

-- Stats screen
AMOUNTSCRIPTS = "Скрипты:",
AMOUNTUSEDFLAGS = "Флаги:",
AMOUNTENTITIES = "Объекты:",
AMOUNTTRINKETS = "Тринкеты:",
AMOUNTCREWMATES = "Члены экипажа:",
AMOUNTINTERNALSCRIPTS = "Внутренние скрипты:",
TILESETUSSAGE = "Использование набора стен:",
TILESETSONLYUSED = "(считаются только комнаты со стенами)",
AMOUNTROOMSWITHNAMES = "Комнаты с именами:",
PLACINGMODEUSAGE = "Режимы расположения стен:",
AMOUNTLEVELNOTES = "Записки:",
AMOUNTFLAGNAMES = "Названия флагов:",
TILESUSAGE = "Использование стен",


ENTITYINVALIDPROPERTIES = "Объект в комнате [$1 $2] имеет $3 неправильных свойства!",
ROOMINVALIDPROPERTIES = "Информация комнаты #$1 имеет $2 неправильных свойства!",
UNEXPECTEDSCRIPTLINE = "Неизвестная линия скрипта: $1",
MAPWIDTHINVALID = "Ширина карты неверная: $1",
MAPHEIGHTINVALID = "Высота карты неверная: $1",
LEVMUSICEMPTY = "В уровне нет музыки!",
NOT400ROOMS = "#Информация уровня <> 400!!",
MOREERRORS = "Ещё $1",

DEBUGMODEON = "Режим Разработчика",
FPS = "FPS",
STATE = "Статус",
MOUSE = "Мышь",

BLUE = "Синий",
GREEN = "Зелёный",
RED = "Красный",
CYAN = "Голубой",
PURPLE = "Фиолетовый",
YELLOW = "Жёлтый",
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
STRINGNOTFOUND = "\"$1\" не найдено",

-- b17
MAL = "The level file is malformed: ", -- one of the following strings are concatenated to this
METADATACORRUPT = "Metadata is missing or corrupt.",
METADATAITEMCORRUPT = "Metadata for $1 is missing or corrupt.",
TILESCORRUPT = "Tiles missing or corrupt.",
ENTITIESCORRUPT = "Entities missing or corrupt.",
LEVELMETADATACORRUPT = "Room metadata missing or corrupt.",
SCRIPTCORRUPT = "Scripts missing or corrupt.",

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
"Точка старта"

}

subtoolnames = {

[1] = {"1x1", "3x3", "5x5", "7x7", "9x9", "Горизонтальная линия", "Вертикальная линия", "Заполнить комнату", "Картошка для магических вещей"},
[2] = {"1x1", "3x3", "5x5", "7x7", "9x9", "Горизонтальная линия", "Вертикальная линия", "Заполнить комнату", "Картошка для магических вещей"},
--[3] = {"1 снизу", "3 снизу", "5 снизу", "7 снизу", "9 снизу", "Расширить Л+П", "Расширить Л", "Расширить П"},
[3] = {"Авто 1", "Авто расширить Л+П", "Авто расширить Л", "Авто расширить П"},
[4] = {},
[5] = {"Нормальный", "Флипнутый"},
[6] = {},
[7] = {"Маленький П", "Маленький Л", "Большой П", "Большой Л"},
[8] = {"Вниз", "Вверх", "Влево", "Вправо"},
[9] = {"Вниз", "Вверх", "Влево", "Вправо"},
[10] = {"Горизонтальный", "Вертикальный"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Вход", "Выход"},
[15] = {},
[16] = {"Розовый", "Жёлтый", "Красный", "Зелёный", "Синий", "Голубой", "Рандомный"},
[17] = {"Лицо вправо", "Лицо влево"},

}

warpdirs = {

[0] = "НЕТ",
[1] = "ГОРИЗОНТАЛЬНЫЙ",
[2] = "ВЕРТИКАЛЬНЫЙ",
[3] = "ПОЛНЫЙ"

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
short1 = "КОС",
long1 = "Космос",
short2 = "Л",
long2 = "Лаборатория",
short3 = "ЗВ",
long3 = "Зона Варпа",
short4 = "КОР",
long4 = "Корабль",

}

ERR_VEDHASCRASHED = "Ved вылетел!"
ERR_VEDVERSION = "Версия Ved:"
ERR_LOVEVERSION = "Версия LOVE:"
ERR_STATE = "Статус:"
ERR_OS = "ОС:"
ERR_PLUGINS = "Плагины:"
ERR_PLUGINSNOTLOADED = "(не загружено)"
ERR_PLUGINSNONE = "(нет)"
ERR_PLEASETELLDAV = "Пожалуйста, расскажите Dav999 об этой проблеме.\n\n\nДетали: (нажмите Ctrl+C/CMD+C чтобы скопировать в буфер обмена)\n\n"

ERR_PLUGINERROR = "Ошибка плагина!"
ERR_FILE = "Файл для редактирования:"
ERR_FILEEDITORS = "Плагины редактируемые этот файл:"
ERR_CURRENTPLUGIN = "Плагин вызвавший ошибку:"
ERR_PLEASETELLAUTHOR = "Плагин должен был редактровать код Ved, но код для замены не был найден.\nВозможно это из-за конфликта между двумя плагинами, или новая версия Ved не поддерживает\nэтот плагин.\n\nДетали: (нажмите Ctrl+C/CMD+C чтобы скопировать в буфер обмена)\n\n"
ERR_CONTINUE = "Вы можете продолжить нажав Esc или Enter, но эта ошибка может вызвать глюки."
ERR_REPLACECODE = "Это не найдено в %s.lua:"
ERR_REPLACECODEPATTERN = "Это не найдено в %s.lua:"
ERR_LINESTOTAL = "%i линий"

ERR_SAVELEVEL = "Чтобы сохранить уровень, нажмите S."
ERR_SAVESUCC = "Уровень сохранён как %s!"
ERR_SAVEERROR = "Ошибка сохранения! %s"


diffmessages = {
	pages = {
		levelproperties = "Настройки уровня",
		changedrooms = "Изменённые комнаты",
		changedroommetadata = "Изменённая информация",
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
		mapsizenote = "УВЕДОМЛЕНИЕ: Размер карты был изменён с $1x$2 на $3x$4.\\o\nКомнаты снаружи $5x$6 не перечислены.\\o",
		levmusic = "Саундтрек был изменён с $1 на $2",
	},
	rooms = {
		added1 = "Добавлен ($1,$2) ($3)\\G",
		added2 = "Добавлен ($1,$2) ($3 -> $4)\\G",
		changed1 = "Изменён ($1,$2) ($3)\\Y",
		changed2 = "Изменён ($1,$2) ($3 -> $4)\\Y",
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
		added = "Set name for flag $1 to \"$2\"\\G",
		removed = "Removed name \"$1\" for flag $2\\R",
		edited = "Changed name for flag $1 from \"$2\" to \"$3\"\\Y",
	},
	levelnotes = {
		added = "Added level note \"$1\"\\G",
		removed = "Removed level note \"$1\"\\R",
		edited = "Edited level note \"$1\"\\Y",
	},
	mde = {
		added = "Metadata entity was added.\\G",
		removed = "Metadata entity was removed.\\R",
	},
}


-- Help articles moved to devstrings, please don't translate them yet as they're still subject to big, unmentioned changes.