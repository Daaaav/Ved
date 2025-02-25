-- Language file for Ved
--- Language: ar (ar)
--- Last converted: 2025-01-21 16:25:06 (CET)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return n==0 and 0 or n==1 and 1 or n==2 and 2 or n%100>=3 and n%100<=10 and 3 or n%100>=11 and 4 or 5 end

function fontpng_ascii(c)

end

L = {

TRANSLATIONCREDIT = "Arabic localization by Eternal Dream Arabization", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "إصدارك من LÖVE قديم. يرجى استخدام الإصدار 0.9.1 أو أحدث.\nيمكنك تحميل آخر إصدار من LÖVE على موقع https://love2d.org/.",
OUTDATEDLOVE090 = "المحرر Ved لم يعد يدعم LÖVE 0.9.0، لكن لحسن الحظ أن LÖVE 0.9.1 والإصدارات الأحدث ستظل تعمل.\nيمكنك تحميل آخر إصدار من LÖVE على موقع https://love2d.org/.",

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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "ملف المستوى مشوه: ",
METADATACORRUPT = "بيانات التعريف ناقصة أو خربانة.",
METADATAITEMCORRUPT = "بيانات التعريف التي تخص $1 ناقصة أو خربانة.",
TILESCORRUPT = "الخلايا ناقصة أو خربانة.",
ENTITIESCORRUPT = "الكيانات ناقصة أو خربانة.",
LEVELMETADATACORRUPT = "بيانات تعريف الغرف ناقصة أو خربانة.",
SCRIPTCORRUPT = "الاسكربتات ناقصة أو خربانة.",

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
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
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

CONFIRMBIGGERSIZE = "أنت تهم باختيار $1 في $2، وهو حجم خريطة أكبر من $3 في $4. في الهامش خارج الحجم العادي لخريطة $3 في $4، فإن الغرف وخصائصها ستلتف وتتكرر من أطراف الحدود الخارجية، إلا أنها بتشوه. لن تحصل على غرف جديدة فريدة تماما، ولن تحصل على المزيد من خصائص الغرف. \n\n اضغط نعم في حال ما تأكدت أنك تريد هذا الحجم الأكبر للخريطة وتعرف ماذا تفعل. اضغط لا في حال ما تريد تعيين حجم الخريطة إلى $5 في $6. \nفي حال ما لست متأكدا ماذا تختار، اضغط لا.",
MAPBIGGERTHANSIZELIMIT = "حجم الخريطة $1 في $2 أكبر من $3 في $4! (لا ندعم بعد ما أكبر من $3 في $4)",
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
	LITERALNULLS = {
		[0] = "يوجد $1 بايت مصفر!",
		[1] = "يوجد $1 من البايتات المصفرة!",
		[2] = "يوجد $1 من البايتات المصفرة!",
		[3] = "يوجد $1 من البايتات المصفرة!",
		[4] = "يوجد $1 من البايتات المصفرة!",
		[5] = "يوجد $1 من البايتات المصفرة!",
	},
	XMLNULLS = {
		[0] = "يوجد $1 رمز XML مصفر!",
		[1] = "يوجد $1 من رموز XML المصفرة!",
		[2] = "يوجد $1 من رموز XML المصفرة!",
		[3] = "يوجد $1 من رموز XML المصفرة!",
		[4] = "يوجد $1 من رموز XML المصفرة!",
		[5] = "يوجد $1 من رموز XML المصفرة!",
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
subj = "Getting started",
imgs = {},
cont = [[
Getting started\wh#
\C=

This article will help you get started with using Ved. To get started with using
the editor, you need to load a level, or create a new one.


The editor\h#

On the left side, you will find the tools selection. Most tools have subtools that
will be listed to the right of it. To switch between tools, use their respective
shortcut or scroll with Shift or Ctrl held down. To switch between subtools, you
can scroll anywhere. For more information about the tools, refer to the ¤Tools\nwl
help page.
Entities can be right clicked for a menu of actions for that entity. To delete
entities without having to use the context menu, Shift-right click on them.
On the right side of the screen, you will find many buttons and options. The upper
buttons are related to the entire level, the lower buttons (under Room options)
are specific to the current room. For more information about those buttons, refer
to the respective help pages, where available.

Levels folder\h#

Ved will normally use the same folder for storing levels as VVVVVV does, so it is
easy to switch from VVVVVV's level editor to Ved and vice versa. If Ved does not
detect your VVVVVV folder correctly, you can enter a custom path in the Ved
options.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Tile placement modes",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Tile placement modes\wh#
\C=

Ved supports three different modes to draw tiles.

     Automatic mode\h#0

          This is the mode that is easiest to use. In this mode, you can draw
          walls and backgrounds and the edges will automatically get placed
          correctly. However, while editing in this mode, all walls and
          backgrounds in the room must use the same tileset and color.

     Multi-tileset mode\h#1

          This is similar to automatic mode, except that you can have multiple
          different tilesets in the same room. That is, changing the tileset will
          not affect already-placed walls and backgrounds, and you can draw in
          multiple different types of tiles in the same room.

     Manual mode\h#2

          Also called Direct Mode, in this mode you can place down any tile
          manually, so you are not bound to the pre-defined tileset combinations
          and edges will not automatically get added to walls, giving you complete
          control over how the room will look. However, this editing mode is often
          slower to use.
]]
},

{
splitid = "030_Tools",
subj = "Tools",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Tools\wh#
\C=

You can use the following tools to fill rooms in your level:

\0
   Wall\h#


The wall tool can be used to place walls.

\1
   Background\h#


The background tool can be used to place backgrounds.

\2
   Spike\h#


The spike tool can be used to place spikes. You can use the expand subtool to
place spikes on a surface with one click (or slide).

\3
   Trinket\h#


The trinket tool can be used to place trinkets. Please note that there is a limit
of twenty trinkets in a level.

\4
   Checkpoint\h#


The checkpoint tool can be used to place checkpoints.

\5
   Disappearing platform\h#


The disappearing platform tool can be used to place disappearing platforms.

\6
   Conveyor\h#


The conveyor tool can be used to place conveyors.

\7
   Moving platform\h#


The moving platform tool can be used to place moving platforms.

\8
   Enemy\h#


The enemy tool can be used to place enemies. The shape and color of the enemy are
determined by the enemy type setting and the tileset (color) respectively.

\9
   Gravity line\h#


The gravity line tool can be used to place gravity lines.

\^0
   Roomtext\h#


The roomtext tool can be used to place text.

\^1
   Terminal\h#


The terminal tool can be used to place terminals. First place the terminal, then
type a name for the script. For more information about scripting, please refer to
the scripting references.

\^2
   Script box\h#


The script box tool can be used to place script boxes. First click on the top left
corner, then on the bottom right corner, then type a name for the script. For more
information about scripting, please refer to the scripting references.

\^3
   Warp token\h#


The warp token tool can be used to place warp tokens. First click where the
entrance should be, then where the exit should be.

\^4
   Warp line\h#


The warp line tool can be used to place warp lines. Please note that warp lines
can only be placed on the edges of a room.

\^5
   Crewmate\h#


The crewmate tool can be used to place missing crewmates that can be rescued. If
all crewmates are rescued, the level will be finished. Please note that there is
a limit of twenty missing crewmates in a level.

\^6
   Start point\h#


The start point tool can be used to place the start point.
]]
},
{
splitid = "040_Script_editor",
subj = "Script editor",
imgs = {},
cont = [[
Script editor\wh#
\C=

With the script editor, you can manage and edit scripts in your level.


Flag names\h#

For convenience and script readability, it is possible to use flag names instead
of numbers. When you use a name instead of a number, a number will automatically
be associated with that name, in the background. It is also possible to choose
which number to use for which flag name.

Internal scripting mode\h#

To use internal scripting in Ved, you can enable internal scripting mode in the
editor, to handle all commands in that script as internal scripting. See
Int.sc mode¤ for more information about internal scripting mode. For more\wl
information about internal scripting, check the internal scripting reference.

Splitting scripts\h#

It is possible to split a script in two scripts with the script editor. After
putting the text cursor on the first line you want to be in the new script, click
the Split button and enter the name of the new script. The lines before the cursor
will remain in the original script, the lines from the cursor onward will be moved
to the new script.

Jumping to scripts\h#

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

setrtl¤(on/off)\w#h

In custom levels, toggle whether or not the font is RTL (right-to-left) or not. By
default, the font is not RTL (it is LTR).

RTL mode mainly makes textboxes right-aligned, for languages like Arabic.

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

setfont¤(font,all)\w#h

In custom levels, set the font to the given font.

font - The font to set the font to. If left blank, this will set the font to the
default font of the custom level.
all - If ¤all¤ is specified (literally the word ¤all¤), then this retroactively\nn&Znn&Z
affects all textboxes that are already on screen. Otherwise simply leave this out.

This command was added in 2.4. The ¤all¤ argument was added in 2.4.1.\gn&Zg

setroomname\w#h

Change the room name of the current room. The line after this command will be
taken as the name (just like ¤#text(color,x,y,lines)¤text¤ with 1 line).\nLwl&Z

This name is not persistent and will go back to the default room name when the
room is reloaded (e.g. by leaving and coming back).

This name overrides any special changing room name, if the room has one. 

This command was added in 2.4.\g

setrtl¤(on/off)\w#h

In custom levels, toggle whether or not the font is RTL (right-to-left) or not. By
default, the font is not RTL (it is LTR).

RTL mode mainly makes textboxes right-aligned, for languages like Arabic.

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
Copyright 2015-2024  Dav999
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
