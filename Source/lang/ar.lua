-- Language file for Ved
--- Language: ar (ar)
--- Last converted: 2026-04-11 03:53:20 (CEST)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return n==0 and 0 or n==1 and 1 or n==2 and 2 or n%100>=3 and n%100<=10 and 3 or n%100>=11 and 4 or 5 end

L = {

TRANSLATIONCREDIT = "Arabic localization by Eternal Dream Arabization", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OSNOTRECOGNIZED = "لم نتعرف على نظام تشغيلك ($1)! سنعود للدوال الأصلية لأنظمة الملفات. المستويات مخزنة تحت: \n\n$2",
MAXTRINKETS = "بلغت العدد الأقصى من المقتنيات ($1) في هذا المستوى.",
MAXCREWMATES = "بلغت العدد الأقصى من الزملاء ($1) في هذا المستوى.",
UNSUPPORTEDTOOL = "أداة غير مدعومة! الأداة:  ",
COULDNOTGETCONTENTSLEVELFOLDER = "فشل الحصول على محتويات مجلد المستويات. يرجى التحقق من وجود $1 ثم إعادة المحاولة.",
MAPSAVEDAS = "حفظت صورة الخريطة تحت $1!",
RAWENTITYPROPERTIES = "يمكنك تغيير القيم الخام لخصائص هذا الكيان من هنا.",
UNKNOWNENTITYTYPE = "نوع كيان مجهول $1",
WARPTOKENENT404 = "كيان تذكرة التنقيلة لم يعد له وجود!",
SPLITFAILED = "فشل الشطر شر فشل! هل عدد أسطرك التي بين تعليمة أمر نصية و speak/speak_active كبير؟", -- Command names are best left untranslated
NOFLAGSLEFT = "لم تتبق أي رايات، لذلك فإن إحدى أسماء الرايات الجديدة على الأقل لا يمكن ربطها بأي رقم راية. يترتب على ذلك أن محاولة تشغيل هذا الاسكربت في لعبة VVVVVV قد تتعطل. يرجى إعادة النظر في أي إشارات إلى رايات لم تعد تحتاجها، وحذفها وإعادة المحاولة.",
NOFLAGSLEFT_LOADSCRIPT = "لم تتبق أي رايات، لذلك تعذر إنشاء اسكربت تحميل يستخدم راية جديدة. وعوض ذلك أنشئ اسكربت تحميل يقوم دوما بتحميل الاسكربت المستهدف بواسطة iftrinkets(0,$1) . يرجى إعادة النظر في أي إشارات إلى رايات لم تعد تحتاجها، وحذفها وإعادة المحاولة.",
LEVELOPENFAIL = "فشل فتح $1.vvvvvv.",
SIZELIMIT = "الحجم الأقصى للمستويات هو $1 في $2.\n\nسنغير حجم المستوى إلى $3 في $4 نتيجة لذلك.",
SCRIPTALREADYEXISTS = "الاسكربت \"$1\" موجود بالفعل!",
FLAGNAMENUMBERS = "لا يمكن أن تحتوي أسماء الرايات الأرقام فحسب.",
FLAGNAMECHARS = "لا يمكن استعمال الأقواس أو الفواصل أو المسافات عند تسمية الرايات.",
FLAGNAMEINUSE = "اسم الراية $1 مستعمل سلفًا من الراية $2",
DIFFSELECT = "حدد المستوى الذي ستقارن به. المستوى الذي ستختاره الآن يعامل على أنه إصدار قديم.",
SUREQUITNEW = "لديك تغييرات لم تحفظ بعد. هل تريد حفظ تلك التغييرات قبل الخروج؟",
SURENEWLEVELNEW = "لديك تغييرات لم تحفظ بعد. هل تريد حفظ تلك التغييرات قبل إنشاء مستوى جديد؟",
SUREOPENLEVEL = "لديك تغييرات لم تحفظ بعد. هل تريد حفظ تلك التغييرات قبل فتح هذا المستوى؟",
NAMEFORFLAG = "اسم الراية $1:",
SCRIPT404 = "الاسكربت \"$1\" غير موجود!",
ENTITY404 = "الكيان عدد $1 لم يعد له وجود!",
GRAPHICSCARDCANVAS = "عذرا، لا يبدو أن بطاقة الرسوميات عندك أو برنامج تعريفها يدعمان هذه الميزة!",
MAXTEXTURESIZE = "عذرا، لا يبدو أن بطاقة الرسوميات عندك أو برنامج تعريفها يسمحان لك بإنشاء صورة بالأبعاد $1x$2. \n\nالحد الأقصى الذي يسمح به نظامك هو صورة بالأبعاد $3x$3.",
SUREDELETESCRIPT = "هل أنت واثق أنك تريد حذف الاسكربت \"$1\"؟",
SUREDELETENOTE = "هل أنت واثق أنك تريد حذف هذه الملحوظة؟",
THREADERROR = "خطأ في العملية البرمجية الجزئية!",
WHATDIDYOUDO = "ماذا فعلت؟!",
UNDOFAULTY = "ماذا تفعل؟",
SOURCEDESTROOMSSAME = "غرفة الوجهة وغرفة المصدر نفس الغرفة!",
COORDS_OUT_OF_RANGE = "ماذا؟ هذه الإحداثيات ليست في هذا البعد حتى!",
UNKNOWNUNDOTYPE = "نوع تراجع مجهول \"$1\"!",
MDEVERSIONWARNING = "يبدو أن نسخة أحدث من محرر Ved أنشأت هذا المستوى، لهذا قد يتضمن بيانات ستضيع لو حفظت هذا المستوى.",
FORGOTPATH = "نسيت أن تحدد مسار الملف!",
LIB_LOAD_ERRMSG = "فشل تحميل مكتبة برمجية ضرورية. يرجى إعلام المطور Dav999 بالمشكلة.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nجرب تنصيب GCC لحل هذه المشكلة، إن لم تكن منصبة عندك سلفا.",

SELECTCOPY1 = "اختر الغرفة التي تريد نسخها",
SELECTCOPY2 = "اختر المكان الذي تريد أن تنسخ إليه هذه الغرفة",
SELECTSWAP1 = "اختر الغرفة الأولى التي تريد تبديلها",
SELECTSWAP2 = "اختر الغرفة الثانية التي تريد تبديلها",

TILESETCHANGEDTO = "مجموعة الخلايا غيرت إلى $1",
TILESETCOLORCHANGEDTO = "لون مجموعة الخلايا غيرت إلى $1",
ENEMYTYPECHANGED = "نوع الأعداء غير",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "غير إلى $1 تموضع الخلايا",
CHANGEDTOMODEAUTO = "تلقائي",
CHANGEDTOMODEMANUAL = "يدوي",
CHANGEDTOMODEMULTI = "متعدد مجموعات الخلايا",

BUSYSAVING = "جار الحفظ...",
SAVEDLEVELAS = "حفظ المستوى تحت $1.vvvvvv",

ROOMCUT = "تم قص الغرفة إلى الحافظة",
ROOMCOPIED = "تم نسخ الغرفة إلى الحافظة",
ROOMPASTED = "تم لصق الغرفة",

METADATAUNDONE = "تم التراجع عن خيارات المستوى",
METADATAREDONE = "تمت إعادة خيارات المستوى",

BOUNDSFIRST = "انقر الزاوية الأولى لمستطيل الحدود", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "انقر الزاوية الأخيرة لمستطيل الحدود", -- Old string: Click the bottom right corner

TILE = "الخلية $1",
HIDEALL = "إخفاء الكل",
SHOWALL = "إظهار الكل",
SCRIPTEDITOR = "محرر الاسكربت",
FILE = "ملف",
NEW = "جديد",
OPEN = "فتح",
SAVE = "حفظ",
UNDO = "تراجع",
REDO = "إعادة",
COMPARE = "مقارنة",
STATS = "إحصائيات",
SCRIPTUSAGES = "استخدامات",
EDITTAB = "تحرير",
COPYSCRIPT = "نسخ اسكربت",
SEARCHSCRIPT = "بحث",
GOTOLINE = "الذهاب للسطر",
GOTOLINE2 = "الذهاب للسطر:",
INTERNALON = "Int.sc يعمل",
INTERNALOFF = "Int.sc لا يعمل",
INTERNALON_LONG = "وضع الاسكربت الداخلي مفعل",
INTERNALOFF_LONG = "وضع الاسكربت الداخلي معطل",
INTERNALYESBARS = "say(-1) int.sc",
INTERNALNOBARS = "تحميل الاسكربت int.sc",
VIEW = "عرض",
SYNTAXHLOFF = "ألوان الصياغة: نعم",
SYNTAXHLON = "ألوان الصياغة: لا",
TEXTSIZEN = "حجم النص: ض",
TEXTSIZEL = "حجم النص: ع",
INSERT = "إدراج",
HELP = "مساعدة",
INTSCRWARNING_NOLOADSCRIPT = "يلزم اسكربت تحميل!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "لم يكتشف اسكربت يفتح هذا الاسكربت. هذا النوع من الاسكربت الداخلي لن يعمل بالطريقة التي ترجوها على الأرجح، لو لم تفتحه عن طريق اسكربت آخر.",
INTSCRWARNING_BOXED = "مرجع مباشر إلى صندوق اسكربت أو حاسب!",
INTSCRWARNING_BOXED_EXPL = "هناك حاسب أو صندوق اسكربت يفتح هذا الاسكربت مباشرة. لن يؤدي تفعيل ذلك الحاسب أو صندوق الاسكربت لعمله بالطريقة التي ترجوها على الأرجح. يحتاج هذا النوع من الاسكربت الداخلي لفتحه من اسكربت تحميل.",
INTSCRWARNING_NAME = "اسم اسكربت غير لائق!",
INTSCRWARNING_NAME_EXPL = "اسم هذا الاسكربت يتضمن حرفا لاتينيا كبيرا أو مسافة أو قوسا أو فاصلة. لا يمكن فتح هذا الاسكربت مباشرة من غير حاسب أو صندوق اسكربت.",
COLUMN = "العمود: ",

BTN_OK = "موافق",
BTN_CANCEL = "إلغاء",
BTN_YES = "نعم",
BTN_NO = "لا",
BTN_APPLY = "تطبيق",
BTN_QUIT = "خروج",
BTN_DISCARD = "عدم حفظ",
BTN_SAVE = "حفظ",
BTN_CLOSE = "إغلاق",
BTN_LOAD = "فتح",
BTN_ADVANCED = "متقدم",

BTN_AUTODETECT = "اكتشاف",
BTN_MANUALLY = "تجاوز النفوذ", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "إعادة",

COMPARINGTHESE = "جار مقارنة $1.vvvvvv و $2.vvvvvv",
COMPARINGTHESENEW = "جار مقارنة (مستوى لم يحفظ) و $1.vvvvvv",

RETURN = "عودة",
CREATE = "إنشاء",
GOTO = "الذهاب إلى",
DELETE = "حذف",
RENAME = "تسمية",
CHANGEDIRECTION = "تغيير اتجاه",
TESTFROMHERE = "الاختبار من هنا",
FLIP = "عكس",
CYCLETYPE = "تغيير النوع",
GOTODESTINATION = "الذهاب للوجهة",
GOTOENTRANCE = "الذهاب للمدخل",
CHANGECOLOR = "تغيير اللون",
EDITTEXT = "تحرير النص",
COPYTEXT = "نسخ النص",
EDITSCRIPT = "تحرير الاسكربت",
OTHERSCRIPT = "تبديل اسم الاسكربت",
PROPERTIES = "الخاصيات",
CHANGETOHOR = "التغيير إلى الأفقي",
CHANGETOVER = "التغيير إلى العمودي",
RESIZE = "تحريك/تحجيم",
CHANGEENTRANCE = "تحريك المدخل",
CHANGEEXIT = "تحريك المخرج",
COPYENTRANCE = "نسخ المدخل",
LOCK = "قفل",
UNLOCK = "فتح القفل",

VEDOPTIONS = "خيارات Ved",
LEVELOPTIONS = "خيارات المستوى",
MAP = "الخريطة",
SCRIPTS = "الاسكربتات",
SEARCH = "بحث",
SENDFEEDBACK = "الإبلاغات",
LEVELNOTEPAD = "مدونة المستوى",
PLUGINS = "الإضافات",

BACKB = "رجوع >>",
MOREB = "<< المزيد",
AUTOMODE = "الوضع: تلقائي",
AUTO2MODE = "الوضع: متعدد",
MANUALMODE = "الوضع: يدوي",
ENEMYTYPE = "نوع عدو: $1",
PLATFORMBOUNDS = "نطاقات منصة",
WARPDIR = "اتجاه تنقيل: $1",
ENEMYBOUNDS = "نطاق الأعداء",
ROOMNAME = "اسم الغرفة",
ROOMOPTIONS = "خيارات الغرفة",
ROTATE180 = "تدوير 180 درجة",
ROTATE180UNI = "تدوير 180 درجة",
HIDEBOUNDS = "إخفاء النطاقات",
SHOWBOUNDS = "إظهار النطاقات",

ROOMPLATFORMS = "منصات الغرفة", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "أعداء الغرفة",

OPTNAME = "الاسم",
OPTBY = "من",
OPTWEBSITE = "الموقع",
OPTDESC = "الوصف", -- If necessary, you can span multiple lines
OPTSIZE = "الحجم",
OPTMUSIC = "الموسيقى",
CAPNONE = "(بدون)",
ENTERLONGOPTNAME = "اسم المستوى:",

X = "x", -- Used for level size: 20x20

SOLID = "ملموس",
NOTSOLID = "لا ملموس",

TSCOLOR = "اللون $1",

LEVELSLIST = "المستويات",
LOADTHISLEVEL = "فتح هذا المستوى:",
ENTERNAMESAVE = "يحفظ بهذا الاسم:",
SEARCHFOR = "البحث عن:",

VERSIONERROR = "فشل التحقق من الإصدار.",
VERSIONUPTODATE = "إصدار محرر Ved عندك هو الأحدث توفرا.",
VERSIONOLD = "يتوفر تحديث! الإصدار الأخير هو: $1",
VERSIONCHECKING = "جار التحقق من التحديثات...",
VERSIONDISABLED = "عطل التحقق من التحديثات",
VERSIONCHECKNOW = "التحقق الآن", -- Check for updates now

SAVENOSUCCESS = "لم ينجح الحفظ! الخطأ: ",
INVALIDFILESIZE = "حجم الملف غير مقبول.",

EDIT = "تحرير",
EDITWOBUMPING = "تحرير بدون رفع",
EDITWBUMPING = "تحرير مع الرفع",
COPYNAME = "نسخ الاسم",
COPYCONTENTS = "نسخ المضمون",
DUPLICATE = "تكرار",

NEWSCRIPTNAME = "الاسم:",
CREATENEWSCRIPT = "إنشاء اسكربت",

NEWNOTENAME = "الاسم:",
CREATENEWNOTE = "إنشاء ملاحظة جديدة",

ADDNEWBTN = "[إضافة جديد]",
IMAGEERROR = "[خطأ صورة]",

NEWNAME = "الاسم الجديد:",
RENAMENOTE = "تسمية الملاحظة",
RENAMESCRIPT = "تسمية الاسكربت",

LINE = "السطر ",

SAVEMAP = "حفظ الخريطة",
COPYROOMS = "نسخ الغرفة",
SWAPROOMS = "تبديل الغرفة",

MAP_STYLE = "نمط الخريطة",
MAP_STYLE_FULL = "كامل", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "خريطة مصغرة", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "أدوات Vtools", -- Max 12*2 characters

FLAGS = "الرايات",
ROOM = "غرفة",
CONTENTFILLER = "المضمون",

FLAGUSED = "    مستخدم", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "غير مستخدم",
FLAGNONAME = "بلا اسم",
USEDOUTOFRANGEFLAGS = "استخدمت الرايات خارج النطاق:",

VVVVVVSETUP = "تجهيز VVVVVV",
CUSTOMVVVVVVDIRECTORY = "مجلد VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "يتوقع المحرر Ved أن المسار الافتراضي للعبة VVVVVV هو:\n$1\n\nلا يجب تحديد هذا المسار إلى مجلد \"levels\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "لم تحدد مسارا مخصصا للعبة VVVVVV \n\n",
CUSTOMVVVVVVDIRECTORY_SET = "عين مسار VVVVVV عندك إلى مسار مخصص: \n$1\n\n",
LANGUAGE = "اللغة",
DIALOGANIMATIONS = "تحريك الحوارات",
FLIPSUBTOOLSCROLL = "قلب اتجاه تصفح الأداة",
ADJACENTROOMLINES = "توضيحات الخلايا في الغرف المجاورة",
NEVERASKBEFOREQUIT = "لا تسأل أبدا قبل المغادرة، حتى لو توجد تغييرات لم تحفظ.",
COORDS0 = "إظهار الإحداثيات بدءا من الصفر (مثلما الحال مع الاسكربت الداخلي)",
ALLOWDEBUG = "تفعيل وضع تتبع الأخطاء",
SHOWFPS = "إظهار عداد الإطارات/ث",
CHECKFORUPDATES = "التحقق من التحديثات",
PAUSEDRAWUNFOCUSED = "عدم رسم الشاشة عندما لا يركز على النافذة",
ENABLEOVERWRITEBACKUPS = "إنشاء نسخ احتياطية من ملفات المستويات عندما تستبدل",
AMOUNTOVERWRITEBACKUPS = "عدد النسخ الاحتياطية التي يحتفظ بها للمستوى الواحد",
SCALE = "مقياس الصورة",
LOADALLMETADATA = "فتح بيانات التعريف (مثل العنوان والمؤلف والوصف) لجميع الملفات في لائحة المستويات",
COLORED_TEXTBOXES = "استخدام ألوان حقيقية لصندوق النص",
MOUSESCROLLINGSPEED = "سرعة تمرير الفأرة",
BUMPSCRIPTSBYDEFAULT = "يرفع الاسكربتات لقمة اللائحة عند تغييرها، بحيث يكون ذلك السلوك الأصلي.",

SCRIPTSPLIT = "شطر",
SPLITSCRIPT = "شطر الاسكربتات",
COUNT = "العدد: ",
SMALLENTITYDATA = "بيانات",

-- Stats screen
AMOUNTSCRIPTS = "الاسكربتات:",
AMOUNTUSEDFLAGS = "الرايات:",
AMOUNTENTITIES = "الكيانات:",
AMOUNTTRINKETS = "المقتنيات:",
AMOUNTCREWMATES = "الزملاء:",
AMOUNTINTERNALSCRIPTS = "الاسكربتات الداخلية:",
TILESETUSSAGE = "استخدام مجموعات الخلايا",
TILESETSONLYUSED = "(فقط الغرف ذات الخلايا تحتسب)",
AMOUNTROOMSWITHNAMES = "الغرف ذات الاسم:",
PLACINGMODEUSAGE = "أوضاع تموضع الخلايا:",
AMOUNTLEVELNOTES = "ملحوظات المستوى:",
AMOUNTFLAGNAMES = "أسماء الرايات:",
TILESUSAGE = "استخدام الخلايا",
AMOUNTTILES = "الخلايا:",
AMOUNTSOLIDTILES = "الخلايا الملموسة:",
AMOUNTSPIKES = "الإبر:",


UNEXPECTEDSCRIPTLINE = "سطر اسكربت غير متوقع جاء بدون اسكربت: $1",
DUPLICATESCRIPT = "الاسكربت $1 مكرر! لا يمكن فتح أكثر من واحد.",
MAPWIDTHINVALID = "عرض الخريطة غير صالح: $1",
MAPHEIGHTINVALID = "ارتفاع الخريطة غير صالح: $1",
LEVMUSICEMPTY = "موسيقى المستوى فارغة!",
NOT400ROOMS = "عدد المدخلات في بيانات levelMetaData ليس 400 !",
MOREERRORS = "$1 زيادة",

DEBUGMODEON = "وضع تتبع الأخطاء يعمل",
FPS = "إطار/ث",
STATE = "الحالة",
MOUSE = "الفأرة",

BLUE = "أزرق",
RED = "أحمر",
CYAN = "سماوي",
PURPLE = "أرجواني",
YELLOW = "أصفر",
GREEN = "أخضر",
GRAY = "رمادي",
PINK = "وردي",
BROWN = "بني",
RAINBOWBG = "خلفية قزحية",

SYNTAXCOLORS = "ألوان الصياغة",
SYNTAXCOLORSETTINGSTITLE = "إعدادات ألوان إبراز الصيغة في الاسكربتات",
SYNTAXCOLOR_COMMAND = "الأمر",
SYNTAXCOLOR_GENERIC = "معياري",
SYNTAXCOLOR_SEPARATOR = "رمز فاصل",
SYNTAXCOLOR_NUMBER = "رقم",
SYNTAXCOLOR_TEXTBOX = "صندوق نص",
SYNTAXCOLOR_ERRORTEXT = "أمر غير معروف",
SYNTAXCOLOR_CURSOR = "مؤشر السهم",
SYNTAXCOLOR_FLAGNAME = "اسم الراية",
SYNTAXCOLOR_NEWFLAGNAME = "اسم راية جديد",
SYNTAXCOLOR_COMMENT = "التعليق",
SYNTAXCOLOR_WRONGLANG = "الأوامر المبسطة في وضع int.sc أو العكس",
RESETCOLORS = "ألوان الأصل",
STRINGNOTFOUND = "لم يعثر على \"$1\"",

-- L.MAL is concatenated with an error message
MAL = "ملف المستوى مشوه: ",

LOADSCRIPTMADE = "تم إنشاء اسكربت تحميل",
COPY = "نسخ",
CUSTOMSIZE = "حجم الفرشاة المخصصة: $1x$2",
SELECTINGA = "جار التحديد - انقر أعلى اليسار",
SELECTINGB = "جار اختيار: $1x$2",
TILESETSRELOADED = "أعيد تحميل مجموعات الخلايا والسبرايتات",

BACKUPS = "نسخ احتياطية",
BACKUPSOFLEVEL = "نسخ احتياطية للملف $1",
LASTMODIFIEDTIME = "آخر تغيير في الأصل", -- List header
OVERWRITTENTIME = "مستبدل", -- List header
SAVEBACKUP = "الحفظ إلى مجلد VVVVVV",
DATEFORMAT = "تنسيق التاريخ",
TIMEFORMAT = "تنسيق التوقيت",
SAVEBACKUPNOBACKUP = "احرص على اختيار اسم فريد لهذا لو لا تريد استبدال أي شيء، لأنه لن تنشئ أي نسخة احتياطية في هذه الحالة!",

AUTOSAVECRASHLOGS = "حفظ تلقائي لتقارير الأعطال",
MOREINFO = "آخر المعلومات",
COPYLINK = "نسخ الرابط",
SCRIPTDISPLAY = "إظهار",
SCRIPTDISPLAY_USED = "مستخدم",
SCRIPTDISPLAY_UNUSED = "غير مستخدم",

RECENTLYOPENED = "مستويات فتحت مؤخرا",
REMOVERECENT = "هل تريد نزعه من قائمة المستويات التي فتحت مؤخرا؟",
RESETCUSTOMBRUSH = "(لتعيين حجم جديد، انقر بأيمن الفأرة)",

DISPLAYSETTINGS = "الإظهار/المقياس",
DISPLAYSETTINGSTITLE = "إعدادات الإظهار/مقياس الصورة",
SMALLERSCREEN = "عرض نافذة أصغر (800 بكسل عوض 896)",
FORCESCALE = "الإجبار على إعدادات مقياس الصورة",
SCALENOFIT = "الإعدادات الحالية لمقياس الصورة تجعل من النافذة أكبر من أن تسعها الشاشة.",
SCALENONUM = "إعدادات مقياس الصورة الحالية غير صالحة.",
MONITORSIZE = "شاشة $1x$2",
VEDRES = "دقة صورة Ved : $1x$2",
NONINTSCALE = "مقياس صورة بقيمة بفاصلة",

USEFONTPNG = "استخدام الخط font.png من مجلد graphics للعبة VVVVV",
USELEVELFONTPNG = "استخدام خط font.png مخصص حسب المستوى",
REQUIRESHIGHERLOVE = " (يتطلب  LÖVE $1 أو أحدث)",
FPSLIMIT = "حد الإطارات/ث",

MAPRESOLUTION = "دقة الشاشة", -- Map export size
MAPRES_ASSHOWN = "كما يظهر (الأقصى 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 للغرفة)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 للغرفة)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "أعلى اليسار",
WIDTHHEIGHT = "العرض والارتفاع",
BOTTOMRIGHT = "أسفل اليمين",
RENDERERINFO = "معلومات التظهير:",
MAPINCOMPLETE = "الخريطة ليست جاهزة بعد (في اللحظة التي ضغطت فيها الحفظ)، يرجى المحاولة مرة أخرى عندما تجهز.",
KEEPDIALOGOPEN = "يترك نافذة الحوار مفتوحة",
TRANSPARENTMAPBG = "خلفية شفافة",
MAPEXPORTERROR = "طرأ خطأ أثناء إنشاء خريطة.",
VIEWIMAGE = "عرض", -- Verb, view image
INVALIDLINENUMBER = "يرجى إدخال رقم سطر صالح.",
OPENLEVELSFOLDER = "فتح مسار مست.", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "تحريك",
GOTOROOM = "الذهاب للغرفة",
ESCTOCANCEL = "[اضغط ESC للتراجع]",

INVALIDFILENAME_WIN = "لا يسمح نظام ويندوز بالرموز التالية في أسماء الملفات:\n\n: * ? \" < > | \n\n (الرمز الأخير سطر عمودي)",
INVALIDFILENAME_MAC = "نظام macOS لا يسمح بالرمز : في أسماء الملفات.",

-- Keyboard key. Please use CAPITAL LETTERS ONLY
TINY_CTRL = "CTRL",
TINY_SHIFT = "SHIFT",
TINY_ALT = "البديل ALT",
TINY_ESC = "الخروج ESC",
TINY_TAB = "جدول TAB",
TINY_HOME = "المنزل HOME",
TINY_END = "النهاية END",
TINY_INSERT = "الإدراج INS",
TINY_DEL = "الحذف DEL",

-- Header for search results
SEARCHRESULTS_SCRIPTS = "الاسكربتات [$1]",
SEARCHRESULTS_ROOMS = "الغرف [$1]",
SEARCHRESULTS_NOTES = "ملاحظات [$1]",

ASSETS = "الموارد", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "لا يمكن فتح هذه الموسيقى. إما أن الملف لا وجود له، وإما أن النوع غير مدعوم.",
SOUNDPLAYERROR = "لا يمكن فتح هذا الصوت. إما أن الملف لا وجود له، وإما أن النوع غير مدعوم.",
MUSICLOADERROR = "لا يمكن تحميل$1: ",
MUSICLOADERROR_TOOSMALL = "ملف الموسيقى أصغر من أن يعد صالحا.",
MUSICEXISTSYES = "موجود",
MUSICEXISTSNO = "لا وجود له",
ASSETS_FOLDER_EXISTS_NO = "لا وجود له - اضغط للإنشاء",
ASSETS_FOLDER_EXISTS_YES = "موجود - اضغط للفتح",
NO_ASSETS_SUBFOLDER = "لا مجلد \"$1\"",
LOAD = "فتح",
RELOAD = "إعادة تحميل",
UNLOAD = "إلغاء تحميل",
MUSICEDITOR = "محرر الموسيقى",
LOADMUSICNAME = "فتح .vvv",
SAVEMUSICNAME = "حفظ .vvv",
INSERTSONG = "إدراج أغنية في المسار $1",
SUREDELETESONG = "هل أنت واثق من إزالة الأغنية $1؟",
SONGOPENFAIL = "عجزت عن فتح $1، الأغنية لم تستبدل.",
SONGREPLACEFAIL = "طرأ خطأ أثناء استبدال الأغنية.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "لا يجوز استخدام الرمز \" $1 \" في أسماء الاسكربتات!",
MUSICTITLE = "العنوان: ",
MUSICARTIST = "الفنان: ",
MUSICFILENAME = "اسم الملف: ",
MUSICNOTES = "ملاحظات: ",
SONGMETADATA = "بيانات التعريف للأغنية $1",
MUSICFILEMETADATA = "بيانات تعريف الملف",
MUSICEXPORTEDON = "تم تصديره: ", -- Followed by date and time
SAVEMETADATA = "حفظ بيانات التعريف",
SOUNDS = "الأصوات",
GRAPHICS = "الرسوميات",
FILEOPENERNAME = "الاسم",
PATHINVALID = "المسار غير صالح.",
DRIVES = "الأقراص", -- like C: or F: on Windows
DOFILTER = "إظهار * $1 فقط", -- "*.txt" for example
DOFILTERDIR = "إظهار المجلدات فقط",
FILEDIALOGLUV = "عذرا، لم نتعرف على نظام تشغيلك، لذا لن تعمل نافذة حوار الملفات.",
RESET = "الإعدادات الأصلية",
CHANGEVERB = "تغيير", -- verb
LOADIMAGE = "فتح صورة",
GRID = "شبكة",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "يجب حفظ المستوى قبل أن يمكن استخدام الموارد المخصصة.",
CREATE_ASSETS_FOLDER = "هل تريد إنشاء مجلد للموارد المخصصة لأجل هذا المستوى؟\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "يبدو أن مجلد اللعبة VVVVVV غير موجود. هل تود إنشاءه؟",
CREATE_LEVELS_FOLDER = "يبدو أن مجلد المستويات غير موجود. هل تود إنشاءه؟",
CREATE_FOLDER_FAIL = "فشل إنشاء المجلد.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "مجلد الموارد لأجل $1",

OPAQUEROOMNAMEBACKGROUND = "جعل الخلفيات السوداء لأسماء المستويات غير شفافة",
PLATVCHANGE_TITLE = "تغيير سرعة المنصة",
PLATVCHANGE_MSG = "السرعة:",
PLATVCHANGE_INVALID = "عليك كتابة قيمة عددية.",
RENAMESCRIPTREFERENCES = "إعادة تسمية المراجع",
PLATFORMSPEEDSLIDER = "سرعة",

TRINKETS = "المقتنيات",
LISTALLTRINKETS = "كل المقتنيات", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "كل المقتنيات",
NOTRINKETSINLEVEL = "لا مقتنيات في هذا المستوى.",
CREWMATES = "الزملاء",
LISTALLCREWMATES = "كل الزملاء", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "قائمة كل زميل يمكن إنقاذه",
NOCREWMATESINLEVEL = "لا زميل يمكن إنقاذه في هذا المستوى",
SHIFTROOMS = "إزاحة الغرف", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 ثا",
ROOMNUM = "الغرفة $1",
SOUNDNUM = "الصوت $1",
TRACKNUM = "الموسيقى $1",
STOPSMUSIC = "إيقاف الموسيقى",
PLAYSOUND = "تشغيل الصوت",
EDITSCRIPTWOBUMPING = "تحرير الاسكربت دون الرفع",
EDITSCRIPTWBUMPING = "تحرير الاسكربت مع الرفع",
CLICKONTHING = "اضغط على $1",
ORDRAGDROP = "أو اسحب وضع هنا", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "في هذا المستوى أكثر من نقطة بدء واحدة!",
STARTPOINTNOTFOUND = "لا توجد نقطة بدء!",

MAPBIGGERTHANSIZELIMIT = "حجم الخريطة $1 في $2 أكبر من $3 في $4!",
BTNOVERRIDE = "تجاوز النفوذ",
TARGETPLATFORM = "المنصة المستهدفة", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "الاختبارات ضد الساعة",
TIMETRIALTRINKETS = "عداد المقتنيات",
TIMETRIALTIME = "الوقت الأمثل",
SUREDELETETRIAL = "هل أنت واثق أنك تريد حذف اختبار ضد الساعة \"$1\"؟",

CUT = "قص",
PASTE = "لصق",
SELECTWORD = "اختيار كلمة",
SELECTLINE = "اختيار سطر",
SELECTALL = "اختيار الكل",
INSERTRAWHEX = "إدراج رمز يونيكود",
MOVELINEUP = "تحريك السطر لأعلى",
MOVELINEDOWN = "تحريك السطر لأسفل",
DUPLICATELINE = "تكرار السطر",

WHEREPLACEPLAYER = "أين تريد البدء؟",
YOUAREPLAYTESTING = "أنت حاليا تجرب اللعبة",
LOCATEVVVVVV = "اختر تطبيقك $1", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "أنت تختبر اللعبة حاليا فعلا!",
PLAYTESTINGFAILED = "طرأ مشكل أثناء فتح VVVVVV : \n$1\n\n لو احتجت لتغيير تطبيق VVVVVV المستخدم أثناء الاختبار، اضغط مطولا زر العالي Shift أثناء ضغط زر الاختبار.",
VVVVVV_EXITCODE_FAILURE = "أغلقت VVVVVV مع رمز الإغلاق $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "يبدو أنك تستخدم VVVVVV بالإصدار 2.2 أو أقدم منه. يرجى الترقية إلى VVVVVV بالإصدار 2.3 أو أي إصدار أحدث منه.",
VVVVVV_SOMETHING_HAPPENED = "يبدو أن خللا طرأ مع لعبة VVVVVV",
PLAYTESTUNAVAILABLE = "عذرا، لا يمكنك الاختبار في $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "رجاء اختر الملف الذي اسمه '$1'.",

PLAYTESTINGOPTIONS = "اختبار اللعبة",
PLAYTESTING_EXECUTABLE_NOTSET = "لم تحدد تطبيقا $1 للاختبار. \nسيطلبها Ved أثناء اختبار لعب $2 مستوى لأول مرة.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "التطبيق $1 المستخدم في الاختبار حدد إلى: \n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "عذرا، طرأت مشكلة أثناء محاولة إيجاد VVVVVV . يرجى محاولة تحديد المسار إلى التطبيق يدويا.",
FIND_V_EXE_FOUNDERROR = "وجدنا شيئا يبدو كأنه VVVVVV، لكن فشلنا في الحصول على مسار نحو التطبيق صالح للاستخدام. تأكد أنك لا تستخدم إصدارا قديما من اللعبة (يشترط إصدار 2.3 أو ما أحدث) وإلا حاول أن تحدد المسار نحو التطبيق يدويا.",
FIND_V_EXE_NOTFOUND = "يبدو أن VVVVVV لا تعمل حاليا. يرجى الحرص أن VVVVVV تعمل، ثم أعد المحاولة.",
FIND_V_EXE_MULTI = "وجدت أكثر من مثيل للتطبيق VVVVVV قيد التشغيل. احرص أن عندك فقط إصدار واحد من اللعبة مفتوحا، وحاول مرة أخرى.",

FIND_V_EXE_EXPLANATION = "محرر Ved يحتاج VVVVVV لأجل الاختبار، والمسار نحو VVVVVV يحتاج أولا لتعيين.\n\n\nللاكتشاف التلقائي للعبة VVVVVV يكفي تشغيل اللعبة (لو لم تشغلها بعد) واضغط \"اكتشاف\".",

VCE_REMOVED = "نسخة VVVVVV: Community Edition لم تعد قيد الدعم، ودعم مستويات VVVVVV-CE نزع من Ved. هذا المستوى يعامل على أنه مستوى VVVVVV عادي. لمزيد من المعلومات، يرجى الاطلاع على https://vsix.dev/vce/status/",

VVVVVV_VERSION = "إصدار VVVVVV", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "تلقائي",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "كل المكونات الإضافية",
ALL_PLUGINS_MOREINFO = ".¤https://tolp.nl/ved/plugins.php¤ هذه الصفحة¤ للمزيد من المعلومات عن المكونات الإضافية يرجى زيارة\\nLCl",
ALL_PLUGINS_FOLDER = "مجلدك للمكونات الإضافية:",
ALL_PLUGINS_NOPLUGINS = "ليس عندك بعد أي مكون إضافي.",

PLUGIN_NOT_SUPPORTED = "[هذا المكون الإضافي غير مدعوم لأنه يتطلب Ved $1 على الأقل!]\\r",
PLUGIN_AUTHOR_VERSION = "من $1، الإصدار $2 ", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "إنشاء اسكربت تحميل",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "لا",
CREATE_LOAD_SCRIPT_RUNONCE = "التشغيل مرة",
CREATE_LOAD_SCRIPT_REPEATING = "التكرار",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "عدم إنشاء اسكربت تحميل",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "هذا الحاسب سيشير مباشرة إلى الاسكربت.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "هذا صندوق اسكربت سيشير مباشرة إلى الاسكربت.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "إنشاء اسكربت تحميل يشغل مرة واحدة",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "هذا الحاسب سيشير إلى تحميل اسكربت جديد، بدوره يفتح الاسكربت الفعلي مرة واحدة في جلسة اللعب. سيختار المحرر Ved راية غير مستخدمة.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "هذا صندوق اسكربت سيشير إلى اسكربت تحميل جديد، بدوره يفتح الاسكربت الفعلي مرة واحدة في جلسة اللعب. سيختار المحرر Ved راية غير مستخدمة.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "إنشاء اسكربت تحميل متكرر",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "هذا الحاسب سيشير إلى اسكربت تحميل جديد، بدوره يفتح الاسكربت الفعلي بدون شروط.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "هذا صندوق اسكربت سيشير إلى اسكربت تحميل جديد، بدوره يفتح الاسكربت الفعلي بدون شروط.",

CUSTOM_SIZED_BRUSH = "فرشاة مخصصة",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "فرشاة",
CUSTOM_SIZED_BRUSH_STAMP = "طابع",
CUSTOM_SIZED_BRUSH_TILESET = "مجموعة الخلايا",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "حجم الفرشاة المخصصة",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "اختر حجم الفرشاة التي تحتاجها.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "الطابع من الغرفة",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "اختر خلايا من الغرفة تنشئ بها طابعا.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "الطابع من مجموعة الخلايا",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "اختر خلايا من مجموعة الخلايا تنشئ بها طابعا. لا يعمل إلا في الوضع اليدوي.",

ADVANCED_LEVEL_OPTIONS = "إعدادات متقدمة للمستوى",
ONEWAYCOL_OVERRIDE = "إعادة تلوين الخلايا ذات الاتجاه الواحد حتى في الموارد المخصصة (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "إنشاء مجلد مضغوط ZIP من هذا الإصدار بغرض المشاركة", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "حفظ مجلد مضغوط ZIP",
ZIP_BUSY_TITLE = "جار إنشاء مجلد ZIP الآن...",
ZIP_LOVE11_ONLY = "إنشاء مجلد مضغوط ZIP يتطلب  LÖVE $1 أو أحدث", -- $1: version number
ZIP_SAVING_SUCCESS = "تم حفظ مجلد ZIP بنجاح!",
ZIP_SAVING_FAIL = "عملية حفظ مجلد ZIP فشلت!",

OPENFOLDER = "فتح مجلد", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "خط المستوى",

TEXTBOXCOLORS_BUTTON = "ألوان النص",
TEXTBOXCOLORS_TITLE = "ألوان صندوق النص",
TEXTBOXCOLORS_RENAME = "تسمية اللون \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "تكرار اللون \"$1\"",
TEXTBOXCOLORS_CREATE = "إضافة لون جديد",

LIB_LOAD_ERRMSG_BIDI = "فشل تحميل المكتبة التي تدعم إظهار النص من اليمين إلى اليسار. \n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nقد يكون السبب أن برنامجك لمكافحة الفايروسات يوقفها.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
		[1] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
		[2] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
		[3] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
		[4] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
		[5] = "عندك $1 مكون إضافي غير مدعوم في هذا الإصدار.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
		[1] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
		[2] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
		[3] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
		[4] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
		[5] = "فشل المستوى في $1 من التحققات. قد تكون المشكلة صححت تلقائيا، لكن من الوارد أن يسفر رغم ذلك هذا عن أعطال وتناقضات.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 من الاستخدامات في الغرف: $2",
		[1] = "$1 من الاستخدامات في الغرف: $2",
		[2] = "$1 من الاستخدامات في الغرف: $2",
		[3] = "$1 من الاستخدامات في الغرف: $2",
		[4] = "$1 من الاستخدامات في الغرف: $2",
		[5] = "$1 من الاستخدامات في الغرف: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 من الاستخدامات في الاسكربتات: $2",
		[1] = "$1 من الاستخدامات في الاسكربتات: $2",
		[2] = "$1 من الاستخدامات في الاسكربتات: $2",
		[3] = "$1 من الاستخدامات في الاسكربتات: $2",
		[4] = "$1 من الاستخدامات في الاسكربتات: $2",
		[5] = "$1 من الاستخدامات في الاسكربتات: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
		[1] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
		[2] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
		[3] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
		[4] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
		[5] = "الكيان في  [$1 $2] لديه $3 من الميزات غير الصالحة!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
		[1] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
		[2] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
		[3] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
		[4] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
		[5] = "بيانات المستوى LevelMetadata للغرفة  $1,$2 لديها $3 من الميزات غير الصالحة!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "يظهر $1",
		[1] = "يظهر $1",
		[2] = "يظهر $1",
		[3] = "يظهر $1",
		[4] = "يظهر $1",
		[5] = "يظهر $1",
	},
	FLAGUSAGES = {
		[0] = "استخدم $1 من مرات في الاسكربتات: $2",
		[1] = "استخدم $1 من مرات في الاسكربتات: $2",
		[2] = "استخدم $1 من مرات في الاسكربتات: $2",
		[3] = "استخدم $1 من مرات في الاسكربتات: $2",
		[4] = "استخدم $1 من مرات في الاسكربتات: $2",
		[5] = "استخدم $1 من مرات في الاسكربتات: $2",
	},
	NOTALLTILESVALID = {
		[0] = "الخلية $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
		[1] = "الخلايا $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
		[2] = "الخلايا $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
		[3] = "الخلايا $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
		[4] = "الخلايا $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
		[5] = "الخلايا $1 ليست قيمتها العددية مناسبة لأنها ليست عددا صحيحا قيمته 0 أو أكثر.",
	},
	BYTES = {
		[0] = "$1 بايت",
		[1] = "$1 بايتات",
		[2] = "$1 بايتات",
		[3] = "$1 بايتات",
		[4] = "$1 بايتات",
		[5] = "$1 بايتات",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 صورة خصصت",
		[1] = "$1 من الصور خصصت",
		[2] = "$1 من الصور خصصت",
		[3] = "$1 من الصور خصصت",
		[4] = "$1 من الصور خصصت",
		[5] = "$1 من الصور خصصت",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 مؤثرات صوتية خصصت",
		[1] = "$1 من المؤثرات الصوتية خصصت",
		[2] = "$1 من المؤثرات الصوتية خصصت",
		[3] = "$1 من المؤثرات الصوتية خصصت",
		[4] = "$1 من المؤثرات الصوتية خصصت",
		[5] = "$1 من المؤثرات الصوتية خصصت",
	},
}

toolnames = {

"حائط",
"خلفية",
"إبرة",
"مقتنى",
"نقطة حفظ",
"منصة متلاشية",
"بساط متحرك",
"منصة متحركة",
"عدو",
"خط جاذبية",
"نص الغرفة",
"حاسب",
"صندوق اسكربت",
"تذكرة تنقيلة",
"خط تنقيلة",
"زميل",
"نقطة البدء",

}

subtoolnames = {

[1] = {"فرشاة 1×1", "فرشاة 3×3", "فرشاة 5×5", "فرشاة 7×7", "فرشاة 9×9", "تعبئة أفقية", "تعبئة عمودية", "تخصيص حجم الفرشاة", "تعبئة علبة الدهان", "بطاطس تنجز أمورا سحرية"},
[2] = {},
[3] = {"تلقائي 1", "توسيع تلقائي يمين+يسار", "توسيع تلقائي يسار", "توسيع تلقائي يمين"},
[4] = {},
[5] = {"مستقيم", "معكوس"},
[6] = {},
[7] = {"يمين صغير", "يسار صغير", "يمين عريض", "يسار عريض"},
[8] = {"تحت", "فوق", "يسار", "يمين"},
[9] = {},
[10] = {"أفقي", "عمودي"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"مدخل", "مخرج"},
[15] = {},
[16] = {"وردي", "أصفر", "أحمر", "أخضر", "أزرق", "سماوي", "عشوائي"},
[17] = {"ملتفت لليمين", "ملتفت لليسار"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "A",

}

warpdirchangedtext = {

[0] = "تنقيل حواف الغرفة معطل",
[1] = "تنقيل حواف الغرفة حدد للأفقي",
[2] = "تنقيل حواف الغرفة حدد للعمودي",
[3] = "تنقيل حواف الغرفة حدد لكل الاتجاهات",

}

langtilesetnames = {

short0 = "محطة الفضاء",
long0 = "المحطة الفضائية",
short1 = "فضاء خارجي",
long1 = "الفضاء الخارجي",
short2 = "المخبر",
long2 = "المخبر",
short3 = "نطاق التنقيل",
long3 = "منطقة التنقيل",
short4 = "السفينة",
long4 = "السفينة",
short5 = "البرج",
long5 = "البرج",

}

ERR_VEDHASCRASHED = "تعطل محرر Ved !"
ERR_VEDVERSION = "إصدار Ved :"
ERR_LOVEVERSION = "إصدار LÖVE :"
ERR_STATE = "الحالة:"
ERR_OS = "نظام التشغيل:"
ERR_TIMESINCESTART = "الوقت منذ البدء:"
ERR_PLUGINS = "المكونات الإضافية:"
ERR_PLUGINSNOTLOADED = "(غير محمل)"
ERR_PLUGINSNONE = "(بدون)"
ERR_PLEASETELLDAV = "يرجى إبلاغ المطور Dav999 عن المشكلة.\n\n\nالتفاصيل: (اضغط زر الأوامر Ctrl/Cmd + زر C للنسخ إلى الحافظة)\n\n"
ERR_INTERMEDIATE = " (نسخة انتقالية)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (جديدة أكثر من اللازم)"

ERR_PLUGINERROR = "خطأ في المكون الإضافي!"
ERR_FILE = "الملف الذي سيحرر:"
ERR_FILEEDITORS = "المكون الإضافي الذي يحرر هذا الملف:"
ERR_CURRENTPLUGIN = "المكون الإضافي الذي سبب هذا الخطأ:"
ERR_PLEASETELLAUTHOR = "كان يفترض بمكون إضافي أن يطبق تعديلا على برمجة في محرر Ved، إلا أننا لم نجد البرمجة الأصلية التي كان سيقع استبدالها.\nمن الوارد أن تضاربا بين مكونين إضافيين سبب هذا، أو أن تحديثا لمحرر Ved أفسد التوافق مع هذا المكون الإضافي.\n\nالتفاصيل: (يرجى ضغط زر الأوامر (Ctrl/Cmd) + الزر C لنسخ التفاصيل إلى الحافظة)\n\n"
ERR_CONTINUE = "يمكنك المواصلة بضغط ESC أو Enter ، لكن انتبه لكون هذا التعديل الفاشل قد يتسبب بمشاكل أخرى."
ERR_OPENPLUGINSFOLDER = "يمكنك فتح مجلد المكونات الإضافية بضغط F ، وهكذا يمكنك إصلاح أو نزع المكون الإضافي الذي يسبب المشكلة. بعد ذلك، أعد تشغيل Ved ."
ERR_REPLACECODE = "فشل إيجاد هذا في %s.lua :"
ERR_REPLACECODEPATTERN = "فشل إيجاد هذا في %s.lua (بمثابة نمط) :"
ERR_LINESTOTAL = "%i سطر إجمالا"

ERR_SAVELEVEL = "لحفظ نسخة من المستوى، اضغط S"
ERR_SAVESUCC = "نجح حفظ المستوى تحت %s !"
ERR_SAVEERROR = "خطأ حفظ!  %s"
ERR_LOGSAVED = "يمكن العثور على المزيد من المعلومات في سجل الأعطال:\n%s"


diffmessages = {
	pages = {
		levelproperties = "خاصيات المستوى",
		changedrooms = "الغرف المغيرة",
		changedroommetadata = "معلومات الغرف المغيرة",
		entities = "الكيانات",
		scripts = "الاسكربتات",
		flagnames = "أسماء الرايات",
		levelnotes = "ملحوظات المستوى",
	},
	levelpropertiesdiff = {
		Title = "تغير الاسم من \"$1\" إلى \"$2\"",
		Creator = "تغير المؤلف من \"$1\" إلى \"$2\"",
		website = "تغير موقع الويب من \"$1\" إلى \"$2\"",
		Desc1 = "تغير الوصف Desc1 من \"$1\" إلى \"$2\"",
		Desc2 = "تغير الوصف Desc2 من \"$1\" إلى \"$2\"",
		Desc3 = "تغير الوصف Desc3 من \"$1\" إلى \"$2\"",
		mapsize = "تغير حجم الخريطة من $1x$2 إلى $3x$4",
		mapsizenote = "ملاحظة: تغير حجم الخريطة من $1x$2 إلى $3x$4.\\o\nالغرف خارج $5x$6 لم تدرج في القائمة.\\o",
		levmusic = "تغيرت موسيقى المستوى من $1 إلى $2",
	},
	rooms = {
		added1 = "تمت إضافة ($1,$2) ($3)\\G",
		added2 = "تمت إضافة ($1,$2) ($3 -> $4)\\G",
		changed1 = "تم تغيير ($1,$2) ($3)\\Y",
		changed2 = "تم تغيير ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "تم مسح كل الخلايا في ($1,$2) ($3)\\R",
		cleared2 = "تم مسح كل الخلايا في ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "الغرفة $1,$2:",
		changed1 = "الغرفة $1,$2 ($3):",
		roomname = "اسم الغرفة \"$1\" غير إلى \"$2\"\\Y",
		roomnameremoved = "اسم الغرفة \"$1\" حذف\\R",
		roomnameadded = "الغرفة سميت \"$1\"\\G",
		tileset = "مجموعة خ $1 بلون $2 غيرت إلى مجموعة خ $3 بلون $4\\Y",
		platv = "سرعة المنصة غيرت من $1 إلى $2\\Y",
		enemytype = "نوع الأعداء غير من $1 إلى $2\\Y",
		platbounds = "نطاق المنصات غير من $1,$2,$3,$4 إلى $5,$6,$7,$8\\Y",
		enemybounds = "نطاق الأعداء غير من $1,$2,$3,$4 إلى $5,$6,$7,$8\\Y",
		directmode01 = "الوضع المباشر مفعل\\G",
		directmode10 = "الوضع المباشر معطل\\G",
		warpdir = "اتجاه التنقيل تغير من $1 إلى $2\\Y",
	},
	entities = {
		added = "أضفت نوع الكيان $1 في الموضع $2,$3 في الغرفة ($4,$5)\\G",
		removed = "نزعت نوع الكيان $1 من الموضع $2,$3 في الغرفة ($4,$5)\\R",
		changed = "غيرت نوع الكيان $1 في الموضع $2,$3 في الغرفة ($4,$5)\\Y",
		changedtype = "غيرت نوع الكيان $1 إلى النوع $2 في الموضع $3,$4 في الغرفة ($5,$6)\\Y",
		multiple1 = "غيرت الكيانات في الموضع $1,$2 في الغرفة ($3,$4):\\Y",
		multiple2 = "إلى:",
		addedmultiple = "أضفت الكيانات في الموضع $1,$2 في الغرفة ($3,$4):\\G",
		removedmultiple = "نزعت الكيانات في الموضع $1,$2 في الغرفة ($3,$4):\\R",
		entity = "النوع $1",
		incomplete = "لم يتم التعامل مع كل الكيانات! يرجى إبلاغ المطور Dav بهذا.\\r",
	},
	scripts = {
		added = "أضفت الاسكربت \"$1\"\\G",
		removed = "نزع الاسكربت \"$1\"\\R",
		edited = "حررت الاسكربت \"$1\"\\Y",
	},
	flagnames = {
		added = "عينت للراية $1 الاسم \"$2\"\\G",
		removed = "أزلت الاسم \"$1\" من الراية $2\\R",
		edited = "غيرت اسم الراية $1 من \"$2\" إلى \"$3\"\\Y",
	},
	levelnotes = {
		added = "أضفت ملحوظة المستوى \"$1\"\\G",
		removed = "نزعت ملحوظة على الخريطة \"$1\"\\R",
		edited = "حررت ملحوظة المستوى \"$1\"\\Y",
	},
	mde = {
		added = "وحدة بيانات التعريف أضيفت.\\G",
		removed = "وحدة بيانات التعريف حذفت.\\R",
	},
}

