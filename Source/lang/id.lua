-- Language file for Ved
--- Language: id (id)
--- Last converted: 2026-04-11 03:53:20 (CEST)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return 0 end

L = {

TRANSLATIONCREDIT = "Terjemahan dibuat oleh _march31onne (Marchionne Evangelisti)", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OSNOTRECOGNIZED = "Sistem operasi Anda ($1) tidak dikenali! Kembali ke fungsi sistem file default; level disimpan di:\n\n$2",
MAXTRINKETS = "Jumlah maksimum trinket ($1) telah tercapai di level ini.",
MAXCREWMATES = "Jumlah maksimum crewmate ($1) telah tercapai di level ini.",
UNSUPPORTEDTOOL = "Alat tidak didukung! Alat: ",
COULDNOTGETCONTENTSLEVELFOLDER = "Tidak bisa mendapatkan konten folder level. Silakan periksa apakah $1 ada dan coba lagi.",
MAPSAVEDAS = "Gambar peta disimpan sebagai $1!",
RAWENTITYPROPERTIES = "Anda dapat mengubah nilai properti mentah entitas ini di sini.",
UNKNOWNENTITYTYPE = "Jenis entitas tidak dikenal $1",
WARPTOKENENT404 = "Entitas warp token tidak ada lagi!",
SPLITFAILED = "Berpisah gagal total! Apakah Anda memiliki terlalu banyak baris antara perintah teks dan speak/speak_active?", -- Command names are best left untranslated
NOFLAGSLEFT = "Tidak ada tanda yang tersisa, jadi satu atau beberapa label tanda baru dalam skrip ini tidak dapat dikaitkan dengan nomor tanda mana pun. Mencoba menjalankan skrip ini di VVVVVV mungkin rusak. Pertimbangkan untuk menghapus semua referensi ke tanda yang tidak lagi Anda perlukan dan coba lagi.",
NOFLAGSLEFT_LOADSCRIPT = "Tidak ada tanda yang tersisa, jadi skrip pemuatan menggunakan tanda baru tidak dapat dibuat. Sebagai gantinya, skrip pemuatan telah dibuat yang selalu memuat skrip target dengan iftrinkets(0,$1). Pertimbangkan untuk menghapus semua referensi ke tanda yang tidak lagi Anda perlukan dan coba lagi.",
LEVELOPENFAIL = "Tidak dapat membuka $1.vvvvvv.",
SIZELIMIT = "Ukuran maksimum level adalah $1 kali $2.\n\nUkuran level akan diubah menjadi $3 kali $4.",
SCRIPTALREADYEXISTS = "Skrip \"$1\" sudah ada!",
FLAGNAMENUMBERS = "Nama tanda tidak boleh hanya angka.",
FLAGNAMECHARS = "Nama tanda tidak boleh mengandung tanda kurung, koma, atau spasi.",
FLAGNAMEINUSE = "Nama tanda $1 sudah digunakan oleh tanda $2",
DIFFSELECT = "Pilih level utk dibandingkan. Level yg Anda pilih skrg akan diperlakukan sebagai versi yg lebih lama.",
SUREQUITNEW = "Anda memiliki perubahan yang belum disimpan. Apakah Anda ingin menyimpan perubahan ini sebelum keluar?",
SURENEWLEVELNEW = "Anda memiliki perubahan yang belum disimpan. Apakah Anda ingin menyimpan perubahan ini sebelum membuat level baru?",
SUREOPENLEVEL = "Anda memiliki perubahan yang belum disimpan. Apakah Anda ingin menyimpan perubahan ini sebelum membuka level ini?",
NAMEFORFLAG = "Nama untuk tanda $1:",
SCRIPT404 = "Skrip \"$1\" tidak ada!",
ENTITY404 = "Entitas #$1 tidak ada lagi!",
GRAPHICSCARDCANVAS = "Maaf, sepertinya kartu grafis atau driver Anda tidak mendukung fitur ini!",
MAXTEXTURESIZE = "Maaf, membuat gambar $1x$2 tampaknya tidak didukung oleh kartu grafis atau driver Anda.\n\nBatas ukuran pada sistem ini adalah $3x$3.",
SUREDELETESCRIPT = "Anda yakin ingin menghapus skrip \"$1\"?",
SUREDELETENOTE = "Anda yakin ingin menghapus nota ini?",
THREADERROR = "Kesalahan utas!",
WHATDIDYOUDO = "Apa yang kamu lakukan?!",
UNDOFAULTY = "Apa yang kamu ngapain?",
SOURCEDESTROOMSSAME = "Ruang sumber dan tujuan sama!",
COORDS_OUT_OF_RANGE = "Hah? Koordinat ini bahkan tidak ada di dimensi ini!",
UNKNOWNUNDOTYPE = "Jenis pembatalan tidak diketahui \"$1\"!",
MDEVERSIONWARNING = "Level ini tampaknya dibuat dalam versi Ved yang lebih baru, dan mungkin berisi beberapa data yang akan hilang saat Anda menyimpan level ini.",
FORGOTPATH = "Anda lupa menentukan jalur!",
LIB_LOAD_ERRMSG = "Gagal memuat perpustakaan penting. Silakan beri tahu Dav999 tentang masalah ini.\n\n$1",
LIB_LOAD_ERRMSG_GCC = "\n\nCoba instal GCC untuk mengatasi masalah ini, jika belum diinstal.",

SELECTCOPY1 = "Pilih ruangan yang akan disalin",
SELECTCOPY2 = "Pilih lokasi untuk menyalin ruangan ini",
SELECTSWAP1 = "Pilih ruang pertama yang akan ditukar",
SELECTSWAP2 = "Pilih ruang kedua yang akan ditukar",

TILESETCHANGEDTO = "Tileset diubah menjadi $1",
TILESETCOLORCHANGEDTO = "Warna tileset diubah menjadi $1",
ENEMYTYPECHANGED = "Jenis musuhan berubah",

-- These four strings aren't used apart of each other, so if necessary you could even make CHANGEDTOMODE "$1" and make the other three full sentences
CHANGEDTOMODE = "Berubah menjadi $1 penempatan ubin",
CHANGEDTOMODEAUTO = "otomatis",
CHANGEDTOMODEMANUAL = "manual",
CHANGEDTOMODEMULTI = "multi-tileset",

BUSYSAVING = "Menyimpan...",
SAVEDLEVELAS = "Level disimpan sebagai $1.vvvvvv",

ROOMCUT = "Ruang dipotong ke papan klip",
ROOMCOPIED = "Ruang disalin ke papan klip",
ROOMPASTED = "Ruang ditempel",

METADATAUNDONE = "Opsi level diurung",
METADATAREDONE = "Opsi level diulang",

BOUNDSFIRST = "Klik sudut pertama batas", -- Old string: Click the top left corner of the bounds
BOUNDSLAST = "Klik sudut terakhir", -- Old string: Click the bottom right corner

TILE = "Ubin $1",
HIDEALL = "Smbunyi smua",
SHOWALL = "Lihat semua",
SCRIPTEDITOR = "Editor skrip",
FILE = "File",
NEW = "Baru",
OPEN = "Buka",
SAVE = "Simpan",
UNDO = "Urung",
REDO = "Ulang",
COMPARE = "Membandingkan",
STATS = "Statistik",
SCRIPTUSAGES = "Penggunaan",
EDITTAB = "Ubah",
COPYSCRIPT = "Salin skrip",
SEARCHSCRIPT = "Cari",
GOTOLINE = "Pergi ke baris",
GOTOLINE2 = "Pergi ke baris:",
INTERNALON = "Sk.int aktif",
INTERNALOFF = "Sk.int nonaktif",
INTERNALON_LONG = "Mode skrip internal diaktifkan",
INTERNALOFF_LONG = "Mode skrip internal dinonaktifkan",
INTERNALYESBARS = "Sk.int say(-1)",
INTERNALNOBARS = "Sk.int Loadscript",
VIEW = "Lihat",
SYNTAXHLOFF = "PNY sintaksis: aktif",
SYNTAXHLON = "PNY sintaksis: nonaktif",
TEXTSIZEN = "Ukuran teks: N",
TEXTSIZEL = "Ukuran teks: B",
INSERT = "Masukkan",
HELP = "Bantuan",
INTSCRWARNING_NOLOADSCRIPT = "Memuat skrip diperlukan!",
INTSCRWARNING_NOLOADSCRIPT_EXPL = "Skrip yang memuat skrip ini tidak terdeteksi. Jenis skrip internal ini mungkin tidak akan berfungsi seperti yang Anda harapkan saat tidak dimuat melalui skrip lain.",
INTSCRWARNING_BOXED = "Kotak skrip langsung/referensi terminal!",
INTSCRWARNING_BOXED_EXPL = "Ada terminal atau kotak skrip yang memuat skrip ini secara langsung. Mengaktifkan terminal atau kotak skrip itu mungkin tidak akan berfungsi seperti yang Anda harapkan; jenis skrip internal ini perlu dimuat melalui skrip pemuatan.",
INTSCRWARNING_NAME = "Nama skrip tidak cocok!",
INTSCRWARNING_NAME_EXPL = "Nama skrip ini memiliki huruf kapital, spasi, tanda kurung atau koma. Skrip ini hanya dapat dimuat langsung dari terminal atau kotak skrip.",
COLUMN = "Kolom: ",

BTN_OK = "OKE",
BTN_CANCEL = "Batal",
BTN_YES = "Ya",
BTN_NO = "Tidak",
BTN_APPLY = "Terapkan",
BTN_QUIT = "Keluar",
BTN_DISCARD = "Buang",
BTN_SAVE = "Simpan",
BTN_CLOSE = "Tutup",
BTN_LOAD = "Muat",
BTN_ADVANCED = "Lanjutan",

BTN_AUTODETECT = "Mendeteksi",
BTN_MANUALLY = "Secr. manual", -- choose path to VVVVVV.exe manually. I didn't want 'Manual' in English because it sounds like 'instruction manual', but translations may use some form of 'manual setup'. This button should come across like 'I know what I'm doing, I want to override automatic detection'
BTN_RETRY = "Cob. ulng.",

COMPARINGTHESE = "Membandingkan $1.vvvvvv dengan $2.vvvvvv",
COMPARINGTHESENEW = "Membandingkan (level yang belum disimpan) dengan $1.vvvvvv",

RETURN = "Kembali",
CREATE = "Membuat",
GOTO = "Pergi ke",
DELETE = "Hapus",
RENAME = "Ubah nama",
CHANGEDIRECTION = "Ubah arah",
TESTFROMHERE = "Tes dari sini",
FLIP = "Balik",
CYCLETYPE = "Ubah jenis",
GOTODESTINATION = "Pergi ke tujuan",
GOTOENTRANCE = "Pergi ke jln. masuk",
CHANGECOLOR = "Ganti warna",
EDITTEXT = "Edit teks",
COPYTEXT = "Salin teks",
EDITSCRIPT = "Edit skrip",
OTHERSCRIPT = "Ubah nama skrip",
PROPERTIES = "Properti",
CHANGETOHOR = "Ubah ke horizontal",
CHANGETOVER = "Ubah ke vertikal",
RESIZE = "Pindahkan/Ubah Ukuran",
CHANGEENTRANCE = "Pindahkan masuk",
CHANGEEXIT = "Pindahkan keluar",
COPYENTRANCE = "Salin masuk",
LOCK = "Kunci",
UNLOCK = "Buka kunci",

VEDOPTIONS = "Opsi Ved",
LEVELOPTIONS = "Opsi level",
MAP = "Peta",
SCRIPTS = "Skrip",
SEARCH = "Cari",
SENDFEEDBACK = "Kirim Umpan Balik",
LEVELNOTEPAD = "Level cacatan",
PLUGINS = "Plugin",

BACKB = "Kembali <<",
MOREB = "Lebih >>",
AUTOMODE = "Mode: oto",
AUTO2MODE = "Mode: multi",
MANUALMODE = "Mode: manual",
ENEMYTYPE = "Jenis musuhan: $1",
PLATFORMBOUNDS = "Batas platf.",
WARPDIR = "Arah warp: $1",
ENEMYBOUNDS = "Batas musuhan",
ROOMNAME = "Nama ruangan",
ROOMOPTIONS = "Opsi ruangan",
ROTATE180 = "Putar 180der",
ROTATE180UNI = "Putar 180°",
HIDEBOUNDS = "Sembunyikan batas",
SHOWBOUNDS = "Menunjukkan batas",

ROOMPLATFORMS = "Ruangan platf.", -- basically, platforms/enemies in/for this room
ROOMENEMIES = "Ruangan musuhan",

OPTNAME = "Nama",
OPTBY = "Oleh",
OPTWEBSITE = "Website",
OPTDESC = "Desk", -- If necessary, you can span multiple lines
OPTSIZE = "Ukuran",
OPTMUSIC = "Musik",
CAPNONE = "TDK ADA",
ENTERLONGOPTNAME = "Nama level:",

X = "x", -- Used for level size: 20x20

SOLID = "Padat",
NOTSOLID = "Bukan padat",

TSCOLOR = "Warna $1",

LEVELSLIST = "Level",
LOADTHISLEVEL = "Muat level ini: ",
ENTERNAMESAVE = "Masukkan nama untuk disimpan sebagai: ",
SEARCHFOR = "Cari untuk: ",

VERSIONERROR = "Tidak dapat memeriksa versi.",
VERSIONUPTODATE = "Versi Ved Anda mutakhir.",
VERSIONOLD = "Pembaruan tersedia! Versi terbaru: $1",
VERSIONCHECKING = "Memeriksa pembaruan...",
VERSIONDISABLED = "Pemeriksa pembaruan dinonaktifkan",
VERSIONCHECKNOW = "Cek skrg.", -- Check for updates now

SAVENOSUCCESS = "Menyimpan tidak berhasil! Kesalahan: ",
INVALIDFILESIZE = "Ukuran file tidak valid.",

EDIT = "Ubah",
EDITWOBUMPING = "Edit tanpa menabrak",
EDITWBUMPING = "Edit dan bentrok",
COPYNAME = "Salin nama",
COPYCONTENTS = "Salin konten",
DUPLICATE = "Duplikat",

NEWSCRIPTNAME = "Nama:",
CREATENEWSCRIPT = "Buat skrip baru",

NEWNOTENAME = "Nama:",
CREATENEWNOTE = "Buat cacatan baru",

ADDNEWBTN = "[Buat baru]",
IMAGEERROR = "[KESALAHAN GAMBAR]",

NEWNAME = "Nama baru:",
RENAMENOTE = "Ubah nama nota",
RENAMESCRIPT = "Ubah nama skrip",

LINE = "baris ",

SAVEMAP = "Simpan peta",
COPYROOMS = "Salin ruang",
SWAPROOMS = "Tukar ruang",

MAP_STYLE = "Jenis peta",
MAP_STYLE_FULL = "Penuh", -- Max 12*2 characters
MAP_STYLE_MINIMAP = "Mini-peta", -- Max 12*2 characters
MAP_STYLE_VTOOLS = "VTools", -- Max 12*2 characters

FLAGS = "Tanda",
ROOM = "ruang",
CONTENTFILLER = "Konten",

FLAGUSED = "Digunakn.    ", -- preferably same length as L.FLAGNOTUSED
FLAGNOTUSED = "Tdk digunakn.",
FLAGNONAME = "Tdk ada nama",
USEDOUTOFRANGEFLAGS = "Digunakan di luar jangkauan tanda:",

VVVVVVSETUP = "Pengaturan VVVVVV",
CUSTOMVVVVVVDIRECTORY = "Folder VVVVVV",
CUSTOMVVVVVVDIRECTORYEXPL = "Direktori VVVVVV default yang diharapkan Ved adalah:\n$1\n\nJalur ini tidak boleh disetel ke direktori \"level\".",
CUSTOMVVVVVVDIRECTORY_NOTSET = "Anda tidak memiliki set direktori VVVVVV kustom.\n\n",
CUSTOMVVVVVVDIRECTORY_SET = "Direktori VVVVVV Anda disetel ke jalur kustom:\n$1\n\n",
LANGUAGE = "Bahasa",
DIALOGANIMATIONS = "Animasi dialog",
FLIPSUBTOOLSCROLL = "Arah gulir alat balik",
ADJACENTROOMLINES = "Indikator ubin di ruang yang berdekatan",
NEVERASKBEFOREQUIT = "Jangan pernah bertanya sebelum keluar, meskipun ada perubahan yang belum disimpan",
COORDS0 = "Tampilkan koordinat sebagai mulai dari 0 (seperti dalam skrip internal)",
ALLOWDEBUG = "Aktifkan mode debug",
SHOWFPS = "Tampilkan penghitung FPS",
CHECKFORUPDATES = "Periksa pembaruan",
PAUSEDRAWUNFOCUSED = "Jangan merender saat jendela tidak fokus",
ENABLEOVERWRITEBACKUPS = "Buat cadangan file level yang ditimpa",
AMOUNTOVERWRITEBACKUPS = "Jumlah cadangan yang harus disimpan per level",
SCALE = "Skala",
LOADALLMETADATA = "Muat metadata (seperti judul, penulis, dan deskripsi) untuk semua file dalam daftar level",
COLORED_TEXTBOXES = "Gunakan warna kotak teks yang benar",
MOUSESCROLLINGSPEED = "Kecepatan gulir mouse",
BUMPSCRIPTSBYDEFAULT = "Membentrok skrip ke bagian atas daftar saat mengeditnya secara default",

SCRIPTSPLIT = "Pisahkan",
SPLITSCRIPT = "Pisahkan skrip",
COUNT = "Jumlah: ",
SMALLENTITYDATA = "data",

-- Stats screen
AMOUNTSCRIPTS = "Skrip:",
AMOUNTUSEDFLAGS = "Tanda:",
AMOUNTENTITIES = "Entitas:",
AMOUNTTRINKETS = "Trinket:",
AMOUNTCREWMATES = "Crewmate:",
AMOUNTINTERNALSCRIPTS = "Skrip internal:",
TILESETUSSAGE = "Penggunaan tileset",
TILESETSONLYUSED = "(hanya ruang yang memiliki ubin yang dihitung)",
AMOUNTROOMSWITHNAMES = "Ruang memiliki nama:",
PLACINGMODEUSAGE = "Mode penempatan ubin:",
AMOUNTLEVELNOTES = "Cacatan level:",
AMOUNTFLAGNAMES = "Nama tanda:",
TILESUSAGE = "Penggunaan ubin",
AMOUNTTILES = "Ubin:",
AMOUNTSOLIDTILES = "Padat ubin:",
AMOUNTSPIKES = "Paku:",


UNEXPECTEDSCRIPTLINE = "Baris skrip tak terduga tanpa skrip: $1",
DUPLICATESCRIPT = "Skrip $1 adalah duplikat! Hanya satu yang dapat dimuat.",
MAPWIDTHINVALID = "Lebar peta tidak valid: $1",
MAPHEIGHTINVALID = "Panjang peta tidak valid: $1",
LEVMUSICEMPTY = "Musik level kosong!",
NOT400ROOMS = "Jumlah entri di levelMetaData bukan 400!",
MOREERRORS = "$1 lagi",

DEBUGMODEON = "Mode debug aktif",
FPS = "FPS",
STATE = "State/status",
MOUSE = "Mouse",

BLUE = "Biru",
RED = "Merah",
CYAN = "Biru muda",
PURPLE = "Ungu",
YELLOW = "Kuning",
GREEN = "Hijau",
GRAY = "Abu-abu",
PINK = "Pink",
BROWN = "Cokelat",
RAINBOWBG = "Pelangi LB",

SYNTAXCOLORS = "Warna sintaks",
SYNTAXCOLORSETTINGSTITLE = "Sintaks skrip menyoroti pengaturan warna",
SYNTAXCOLOR_COMMAND = "Memerintah",
SYNTAXCOLOR_GENERIC = "Generik",
SYNTAXCOLOR_SEPARATOR = "Pemisah",
SYNTAXCOLOR_NUMBER = "Nomor",
SYNTAXCOLOR_TEXTBOX = "Kotak teks",
SYNTAXCOLOR_ERRORTEXT = "Perintah tidak dikenal",
SYNTAXCOLOR_CURSOR = "Kursor",
SYNTAXCOLOR_FLAGNAME = "Nama tanda",
SYNTAXCOLOR_NEWFLAGNAME = "Nama tanda baru",
SYNTAXCOLOR_COMMENT = "Komen",
SYNTAXCOLOR_WRONGLANG = "Perintah sederhana dalam mode sk.int atau sebaliknya",
RESETCOLORS = "Setel ulang warna",
STRINGNOTFOUND = "\"$1\" tidak ditemukan",

-- L.MAL is concatenated with an error message
MAL = "File level salah format: ",

LOADSCRIPTMADE = "Muat skrip dibuat",
COPY = "Salin",
CUSTOMSIZE = "Ukuran kuas kustom: $1x$2",
SELECTINGA = "Memilih - klik kiri atas",
SELECTINGB = "Memilih: $1x$2",
TILESETSRELOADED = "Tileset dan sprite dimuat ulang",

BACKUPS = "Cadangan",
BACKUPSOFLEVEL = "Cadangan level $1",
LASTMODIFIEDTIME = "Awalnya terakhir diubah", -- List header
OVERWRITTENTIME = "Ditimpa", -- List header
SAVEBACKUP = "Simpan ke folder VVVVVV",
DATEFORMAT = "Format tanggal",
TIMEFORMAT = "Format waktu",
SAVEBACKUPNOBACKUP = "Pastikan untuk memilih nama yang unik untuk ini jika Anda tidak ingin menimpa apa pun, karena TIDAK ADA cadangan yang akan dibuat dalam kasus ini!",

AUTOSAVECRASHLOGS = "Secara otomatis menyimpan log kerusakan",
MOREINFO = "Info terbaru",
COPYLINK = "Salin tautan",
SCRIPTDISPLAY = "Tunjukkan",
SCRIPTDISPLAY_USED = "Digunakn.",
SCRIPTDISPLAY_UNUSED = "Tdk digunakn.",

RECENTLYOPENED = "Level yang baru dibuka",
REMOVERECENT = "Apakah Anda ingin menghapusnya dari daftar level yang baru dibuka?",
RESETCUSTOMBRUSH = "(Klik kanan untuk mengatur ukuran baru)",

DISPLAYSETTINGS = "Tampilan/Skala",
DISPLAYSETTINGSTITLE = "Pengaturan Tampilan/Skala",
SMALLERSCREEN = "Lebar jendela lebih kecil (lebar 800 piksel, bukan 896 piksel)",
FORCESCALE = "Pengaturan skala paksa",
SCALENOFIT = "Pengaturan skala saat ini membuat jendela terlalu besar untuk muat.",
SCALENONUM = "Pengaturan skala saat ini tidak valid.",
MONITORSIZE = "$1x$2 monitor",
VEDRES = "Resolusi Ved: $1x$2",
NONINTSCALE = "Penskalaan non-integer",

USEFONTPNG = "Gunakan font.png dari folder grafis VVVVVV sebagai font",
USELEVELFONTPNG = "Gunakan font kustom per level.png sebagai font",
REQUIRESHIGHERLOVE = " (membutuhkan LÖVE $1 atau lebih tinggi)",
FPSLIMIT = "Batas FPS",

MAPRESOLUTION = "Resolusi", -- Map export size
MAPRES_ASSHOWN = "Seprti yg ditunjukkn (maks 640x480)", -- $1x$2 is resolution, max 640x480
MAPRES_PERCENT = "$1% ($2x$3 per ruang)", -- Example: 50% (160x120 per room)
MAPRES_RATIO = "$1:$2 ($3x$4 per ruang)", -- Example: 1:8 (40x30 per room)
TOPLEFT = "Kiri atas",
WIDTHHEIGHT = "Panjang & lebar",
BOTTOMRIGHT = "Kanan bawah",
RENDERERINFO = "Informasi penyaji:",
MAPINCOMPLETE = "Peta belum siap (saat Anda menekan Simpan), coba lagi jika sudah siap.",
KEEPDIALOGOPEN = "Biarkan dialog tetap terbuka",
TRANSPARENTMAPBG = "Latar belakang transparan",
MAPEXPORTERROR = "Kesalahan saat membuat peta.",
VIEWIMAGE = "Lihat", -- Verb, view image
INVALIDLINENUMBER = "Harap masukkan nomor baris yang valid.",
OPENLEVELSFOLDER = "Buka dir lvl", -- Open levels directory/folder in Explorer, Finder or another system file manager. I went for making it fit on one line in the button, but this can be near impossible in another language, so feel free to make it longer to use two lines.
MOVEENTITY = "Pindahkan",
GOTOROOM = "Pergi ke ruang",
ESCTOCANCEL = "[Tekan ESC untuk membatalkan]",

INVALIDFILENAME_WIN = "Windows tidak mengizinkan karakter berikut dalam nama file:\n\n: * ? \" < > |\n\n(| menjadi bilah vertikal)",
INVALIDFILENAME_MAC = "macOS tidak mengizinkan karakter : dalam nama file.",

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
SEARCHRESULTS_SCRIPTS = "Skrip [$1]",
SEARCHRESULTS_ROOMS = "Ruang [$1]",
SEARCHRESULTS_NOTES = "Cacatan [$1]",

ASSETS = "Sumber", -- If this is hard to translate, try "resources" or just raw "assets". Assets are files like graphics (tiles.png, sprites.png, etc), music or sound effects
MUSICPLAYERROR = "Tidak dapat memutar lagu ini. Itu mungkin tidak ada atau dari jenis yang tidak didukung.",
SOUNDPLAYERROR = "Tidak dapat memutar suara ini. Itu mungkin tidak ada atau dari jenis yang tidak didukung.",
MUSICLOADERROR = "Tidak dapat memuat $1: ",
MUSICLOADERROR_TOOSMALL = "File musik terlalu kecil untuk valid.",
MUSICEXISTSYES = "Ada",
MUSICEXISTSNO = "Tidak ada",
ASSETS_FOLDER_EXISTS_NO = "Tidak ada - klik untuk membuat",
ASSETS_FOLDER_EXISTS_YES = "Ada - klik untuk membuka",
NO_ASSETS_SUBFOLDER = "Tidak ada folder \"$1\"",
LOAD = "Muat",
RELOAD = "Muat ulang",
UNLOAD = "Bongkarkan",
MUSICEDITOR = "Editor musik",
LOADMUSICNAME = "Muat .vvv",
SAVEMUSICNAME = "Simpan .vvv",
INSERTSONG = "Sisipkan lagu di trek $1",
SUREDELETESONG = "Anda yakin ingin menghapus lagu $1?",
SONGOPENFAIL = "Tidak dapat membuka $1, lagu tidak diganti.",
SONGREPLACEFAIL = "Terjadi masalah saat mengganti lagu.",
BYTES = "$1 B",
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
TERABYTES = "$1 TB",
DECIMAL_SEP = ",", -- The decimal separator for your language (so might be a comma if you use 1,5 instead of 1.5)
CANNOTUSENEWLINES = "Anda tidak dapat menggunakan karakter \"$1\" dalam nama skrip!",
MUSICTITLE = "Judul: ",
MUSICARTIST = "Artis: ",
MUSICFILENAME = "Nama file: ",
MUSICNOTES = "Nota:",
SONGMETADATA = "Metadata untuk lagu $1",
MUSICFILEMETADATA = "Metadata file",
MUSICEXPORTEDON = "Diekspor: ", -- Followed by date and time
SAVEMETADATA = "Simpan metadata",
SOUNDS = "Suara",
GRAPHICS = "Grafis",
FILEOPENERNAME = "Nama: ",
PATHINVALID = "Jalannya tidak valid.",
DRIVES = "Drive", -- like C: or F: on Windows
DOFILTER = "Hanya tampilkan *$1", -- "*.txt" for example
DOFILTERDIR = "Hanya tampilkan direktori",
FILEDIALOGLUV = "Maaf, sistem operasi Anda tidak dikenali, sehingga dialog file tidak berfungsi.",
RESET = "Setel ulang",
CHANGEVERB = "Ubah", -- verb
LOADIMAGE = "Muat gambar",
GRID = "Kisi-kisi",
NOTALPHAONLY = "RGB",

UNSAVED_LEVEL_ASSETS_FOLDER = "Level harus disimpan sebelum dapat menggunakan aset kustom.",
CREATE_ASSETS_FOLDER = "Apakah Anda ingin membuat folder aset kustom untuk level ini?\n\n$1", -- $1: path
CREATE_VVVVVV_FOLDER = "Sepertinya folder VVVVVV tidak ada. Apakah Anda ingin membuatnya?",
CREATE_LEVELS_FOLDER = "Sepertinya folder level tidak ada. Apakah Anda ingin membuatnya?",
CREATE_FOLDER_FAIL = "Tidak dapat membuat folder.\n\n$1",
ASSETS_FOLDER_FOR_LEVEL = "Folder aset untuk $1",

OPAQUEROOMNAMEBACKGROUND = "Jadikan latar belakang nama ruang hitam buram",
PLATVCHANGE_TITLE = "Ubah kecepatan platform",
PLATVCHANGE_MSG = "Kecepatan:",
PLATVCHANGE_INVALID = "Anda harus mengetikkan angka.",
RENAMESCRIPTREFERENCES = "Ganti nama referensi",
PLATFORMSPEEDSLIDER = "Kcpt.:",

TRINKETS = "Trinket",
LISTALLTRINKETS = "Daftar semua trinket", -- "Give a list of all trinkets", on a button. Alternatively: "Find all trinkets".
LISTOFALLTRINKETS = "Daftar untuk semua trinket",
NOTRINKETSINLEVEL = "Tidak ada trinket di level ini.",
CREWMATES = "Crewmate",
LISTALLCREWMATES = "Daftar semua crewmate", -- "Give a list of all rescuable crewmates", on a button. Alternatively: "Find all crewmates".
LISTOFALLCREWMATES = "Daftar untuk semua crewmate yg bisa diselamatkan",
NOCREWMATESINLEVEL = "Tidak ada crewmate yang bisa diselamatkan di level ini.",
SHIFTROOMS = "Pergeseran ruang", -- In the map. Move all rooms in the entire level in any direction

FRAMESTOSECONDS = "$1 = $2 dtk.",
ROOMNUM = "Ruang $1",
SOUNDNUM = "Suara $1",
TRACKNUM = "Trek $1",
STOPSMUSIC = "Menghentikan musik",
PLAYSOUND = "Putar suara",
EDITSCRIPTWOBUMPING = "Edit skrip tanpa menabrak",
EDITSCRIPTWBUMPING = "Edit skrip dan bentrok",
CLICKONTHING = "Klik $1",
ORDRAGDROP = "atau seret dan lepas ke sini", -- follows after "Click on Load". You can also drag and drop a file onto the window, like websites sometimes do when uploading
MORETHANONESTARTPOINT = "Ada lebih dari satu titik awal di level ini!",
STARTPOINTNOTFOUND = "Tidak ada titik awal!",

MAPBIGGERTHANSIZELIMIT = "Ukuran peta $1x$2 lebih besar dari $3x$4!",
BTNOVERRIDE = "Mengesampingkn.",
TARGETPLATFORM = "Platform sasaran", -- What edition of VVVVVV is this level made for? Standard VVVVVV? The Community Edition?
PLATFORM_V = "VVVVVV",
TIMETRIALS = "Percobaan waktu",
TIMETRIALTRINKETS = "Jumlah trinket",
TIMETRIALTIME = "Waktu par",
SUREDELETETRIAL = "Yakin ingin menghapus uji coba waktu \"$1\"?",

CUT = "Potong",
PASTE = "Tempel",
SELECTWORD = "Pilih kata",
SELECTLINE = "Pilih baris",
SELECTALL = "Pilih semua",
INSERTRAWHEX = "Masukkan karakter Unicode",
MOVELINEUP = "Pindahkan garis ke atas",
MOVELINEDOWN = "Pindahkan garis ke bawah",
DUPLICATELINE = "Duplikat baris",

WHEREPLACEPLAYER = "Di mana Anda ingin memulai?",
YOUAREPLAYTESTING = "Anda sedang playtesting",
LOCATEVVVVVV = "Pilih $1 Anda yang dapat dieksekusi", -- application (example: Select your VVVVVV executable)
ALREADYPLAYTESTING = "Anda sudah playtesting!",
PLAYTESTINGFAILED = "Terjadi kesalahan saat membuka VVVVVV:\n$1\n\nJika Anda perlu mengubah executable VVVVVV yang digunakan untuk playtesting, tahan Shift sambil menekan tombol playtest.",
VVVVVV_EXITCODE_FAILURE = "VVVVVV keluar dengan kode $1", -- for example, code 1, indicating failure
VVVVVV_22_OR_OLDER = "Sepertinya Anda menggunakan VVVVVV 2.2 atau lebih lama. Silakan tingkatkan ke VVVVVV 2.3 atau lebih baru.",
VVVVVV_SOMETHING_HAPPENED = "Sepertinya ada yang salah dengan VVVVVV.",
PLAYTESTUNAVAILABLE = "Maaf, Anda tidak dapat bermain dengan $1.", -- you cannot playtest on <operating system>
VVVVVVFILE = "Silakan pilih file bernama '$1'.",

PLAYTESTINGOPTIONS = "Playtesting",
PLAYTESTING_EXECUTABLE_NOTSET = "Anda belum menetapkan $1 yang dapat dieksekusi untuk digunakan untuk pengujian bermain.\nVed akan memintanya saat menguji level $2 untuk pertama kalinya.", -- $1: VVVVVV 2.3, $2: VVVVVV
PLAYTESTING_EXECUTABLE_SET = "$1 yang dapat dieksekusi untuk digunakan untuk pengujian bermain disetel ke:\n$2", -- $1: VVVVVV 2.3

FIND_V_EXE_ERROR = "Maaf, terjadi kesalahan saat mencoba menemukan VVVVVV. Coba atur jalur ke yang dapat dieksekusi secara manual.",
FIND_V_EXE_FOUNDERROR = "Menemukan sesuatu yang terlihat seperti VVVVVV, tetapi tidak bisa mendapatkan jalur yang bisa digunakan untuk dieksekusi. Pastikan Anda tidak menggunakan versi game yang lama (diperlukan 2.3 atau yang lebih baru) atau coba atur jalur ke yang dapat dieksekusi secara manual.",
FIND_V_EXE_NOTFOUND = "Sepertinya VVVVVV tidak berjalan. Pastikan Anda menjalankan VVVVVV dan coba lagi.",
FIND_V_EXE_MULTI = "Ditemukan beberapa contoh berbeda dari VVVVVV berjalan. Pastikan Anda hanya memiliki satu versi permainan yang terbuka dan coba lagi.",

FIND_V_EXE_EXPLANATION = "Ved membutuhkan VVVVVV untuk playtesting, dan jalur ke VVVVVV perlu diatur terlebih dahulu.\n\n\nUntuk mendeteksi VVVVVV secara otomatis, cukup mulai permainan jika belum berjalan dan tekan \"Deteksikan\".",

VCE_REMOVED = "VVVVVV: Community Edition tidak lagi dipertahankan, dan dukungan untuk level VVVVVV-CE telah dihapus dari Ved. Tingkat ini diperlakukan seperti tingkat VVVVVV biasa. Untuk informasi lebih lanjut, lihat https://vsix.dev/vce/status/",

VVVVVV_VERSION = "Versi VVVVVV", -- Choose the version of VVVVVV you are using (for example, you CAN set it to 2.3+ if you have VVVVVV 2.4, but not 2.4+ if you have 2.3)
VVVVVV_VERSION_AUTO = "Oto",
VVVVVV_VERSION_23PLUS = "2.3+",
VVVVVV_VERSION_24PLUS = "2.4+",

ALL_PLUGINS = "Semua plugin",
ALL_PLUGINS_MOREINFO = "Silakan buka ¤https://tolp.nl/ved/plugins.php¤halaman ini¤ untuk informasi lebih lanjut tentang plugin.\\nLCl",
ALL_PLUGINS_FOLDER = "Folder plugin Anda adalah:",
ALL_PLUGINS_NOPLUGINS = "Anda belum memiliki plugin.",

PLUGIN_NOT_SUPPORTED = "[Plugin ini tidak didukung karena memerlukan Ved $1 atau lebih tinggi!]\\r",
PLUGIN_AUTHOR_VERSION = "oleh $1, versi $2", -- by Person, version 1.0.0

CREATE_LOAD_SCRIPT = "Buat skrip pemuatan",

-- These three are limited to 12*2 characters. Instead of "Repeating" you may also say something like "Basic" or "Simple" as long as it's consistent with the explanations below. "once" may be "1x"
CREATE_LOAD_SCRIPT_NO = "Tidak",
CREATE_LOAD_SCRIPT_RUNONCE = "Jalankan 1x",
CREATE_LOAD_SCRIPT_REPEATING = "Mengulang",

-- Explanation for "No"
CREATE_LOAD_SCRIPT_TITLE_NO = "Jangan buat skrip pemuatan",
CREATE_LOAD_SCRIPT_EXPL_T_NO = "Terminal ini akan langsung menunjuk ke skrip.",
CREATE_LOAD_SCRIPT_EXPL_S_NO = "Kotak skrip ini akan langsung menunjuk ke skrip.",

-- Explanation for "Run once"
CREATE_LOAD_SCRIPT_TITLE_RUNONCE = "Buat skrip pemuatan untuk dijalankan sekali",
CREATE_LOAD_SCRIPT_EXPL_T_RUNONCE = "Terminal ini akan menunjuk ke skrip pemuatan baru, yang memuat skrip asli hanya sekali dalam pemutaran. Ved akan memilih tanda yang tidak digunakan.",
CREATE_LOAD_SCRIPT_EXPL_S_RUNONCE = "Kotak skrip ini akan menunjuk ke skrip pemuatan baru, yang memuat skrip asli hanya sekali dalam pemutaran. Ved akan memilih tanda yang tidak digunakan.",

-- Explanation for "Repeating"
CREATE_LOAD_SCRIPT_TITLE_REPEATING = "Buat skrip pemuatan berulang",
CREATE_LOAD_SCRIPT_EXPL_T_REPEATING = "Terminal ini akan menunjuk ke skrip pemuatan baru, yang memuat skrip asli tanpa syarat.",
CREATE_LOAD_SCRIPT_EXPL_S_REPEATING = "Kotak skrip ini akan menunjuk ke skrip pemuatan baru, yang memuat skrip asli tanpa syarat.",

CUSTOM_SIZED_BRUSH = "Kuas kustom",

-- These are limited to 12*2 characters
CUSTOM_SIZED_BRUSH_BRUSH = "Kuas",
CUSTOM_SIZED_BRUSH_STAMP = "Stempel",
CUSTOM_SIZED_BRUSH_TILESET = "Tileset",

-- Explanation for "Brush"
CUSTOM_SIZED_BRUSH_TITLE_BRUSH = "Ukuran kuas kustom",
CUSTOM_SIZED_BRUSH_EXPL_BRUSH = "Pilih ukuran kuas yang Anda butuhkan.",

-- Explanation for "Stamp"
CUSTOM_SIZED_BRUSH_TITLE_STAMP = "Stempel dari ruang",
CUSTOM_SIZED_BRUSH_EXPL_STAMP = "Pilih ubin dari ruangan untuk membuat stempel.",

-- Explanation for "Tileset"
CUSTOM_SIZED_BRUSH_TITLE_TILESET = "Stempel dari tileset",
CUSTOM_SIZED_BRUSH_EXPL_TILESET = "Pilih ubin dari ubin untuk membuat stempel. Hanya bekerja dalam mode manual.",

ADVANCED_LEVEL_OPTIONS = "Opsi level lanjutan",
ONEWAYCOL_OVERRIDE = "Warnai ulang ubin satu arah di aset kustom juga (onewaycol_override)", -- Normally the game only recolors one-way tiles in stock assets, and leaves them unchanged in level-specific assets. Turning this on makes the recolor affect level-specific assets as well. Do not translate the (onewaycol_override)

ZIP_SAVE_AS = "Buat ZIP versi ini untuk dibagikan", -- .ZIP file for distribution to others/sharing with others. The zip contains all the assets so people don't have to package the zip themselves anymore
ZIP_CREATE_TITLE = "Simpan ZIP",
ZIP_BUSY_TITLE = "Membuat ZIP...",
ZIP_LOVE11_ONLY = "Membuat file ZIP memerlukan LÖVE $1 atau lebih tinggi", -- $1: version number
ZIP_SAVING_SUCCESS = "ZIP disimpan!",
ZIP_SAVING_FAIL = "Tidak dapat menyimpan file ZIP!",

OPENFOLDER = "Buka folder", -- Button, open a directory/folder in Explorer, Finder or another system file manager.

LEVELFONT = "Font level",

TEXTBOXCOLORS_BUTTON = "Warna teks",
TEXTBOXCOLORS_TITLE = "Warna kotak teks",
TEXTBOXCOLORS_RENAME = "Ganti nama warna \"$1\"",
TEXTBOXCOLORS_DUPLICATE = "Duplikasi warna \"$1\"",
TEXTBOXCOLORS_CREATE = "Tambah warna baru",

LIB_LOAD_ERRMSG_BIDI = "Gagal memuat perpustakaan untuk dukungan teks kanan ke kiri.\n\n$1",
LIB_LOAD_ERRMSG_AV = "\n\nAntivirus Anda mungkin merusaknya.",

}

-- Please check the reference for plural forms
L_PLU = {
	NUMUNSUPPORTEDPLUGINS = {
		[0] = "Anda memiliki plugin $1 yang tidak didukung dalam versi ini.",
	},
	LEVELFAILEDCHECKS = {
		[0] = "Level ini gagal dalam pemeriksaan $1. Masalah mungkin telah diperbaiki secara otomatis, tetapi mungkin saja ini akan tetap menyebabkan error dan inkonsistensi.",
	},
	SCRIPTUSAGESROOMS = {
		[0] = "$1 penggunaan di ruang: $2",
	},
	SCRIPTUSAGESSCRIPTS = {
		[0] = "$1 penggunaan di skrip: $2",
	},
	ENTITYINVALIDPROPERTIES = {
		[0] = "Entitas di [$1 $2] memiliki $3 properti yang tidak valid!",
	},
	ROOMINVALIDPROPERTIES = {
		[0] = "LevelMetadata untuk ruang $1,$2 memiliki $3 properti yang tidak valid!",
	},
	SCRIPTDISPLAY_SHOWING = {
		[0] = "Menampilkan $1",
	},
	FLAGUSAGES = {
		[0] = "Digunakan $1 kali dalam skrip: $2",
	},
	NOTALLTILESVALID = {
		[0] = "Ubin $1 bukan nomor yang valid lebih besar dari atau sama dengan 0",
	},
	BYTES = {
		[0] = "$1 bita",
	},
	NUM_GRAPHICS_CUSTOMIZED = {
		[0] = "$1 gambar disesuaikan",
	},
	NUM_SOUNDS_CUSTOMIZED = {
		[0] = "$1 efek suara disesuaikan",
	},
}

toolnames = {

"Dinding",
"Latar belakang",
"Paku",
"Trinket",
"Checkpoint",
"Penghilang platform",
"Konveyor",
"Platform bergerak",
"Musuhan",
"Garis gravitasi",
"Teks ruangan",
"Terminal",
"Kotak skrip",
"Token warp",
"Garis warp",
"Crewmate",
"Titik awal",

}

subtoolnames = {

[1] = {"kuas 1x1", "kuas 3x3", "kuas 5x5", "kuas 7x7", "kuas 9x9", "Isi secara horizontal", "Isi secara vertikal", "Ukuran kuas kustom", "Isi ember", "Kentang untuk Melakukan Hal-hal yang Ajaib"},
[2] = {},
[3] = {"Oto 1", "Oto luas kiri+kanan", "Oto luas kiri", "Oto luas kanan"},
[4] = {},
[5] = {"Tegak lurus", "Terbalik"},
[6] = {},
[7] = {"Kecil kiri", "Kecil kanan", "Besar kiri", "Besar kanan"},
[8] = {"Bawah", "Atas", "Kiri", "Kanan"},
[9] = {},
[10] = {"Horizontal", "Vertikal"},
[11] = {},
[12] = {},
[13] = {},
[14] = {"Masuk", "Keluar"},
[15] = {},
[16] = {"Pink", "Kuning", "Merah", "Hijau", "Biru", "Biru muda", "Random"},
[17] = {"Wajah kanan", "Wajah kiri"},

}

warpdirs = {

[0] = "x",
[1] = "H",
[2] = "V",
[3] = "S",

}

warpdirchangedtext = {

[0] = "Ruangan warping dinonaktifkan",
[1] = "Arah warp diatur ke horizontal",
[2] = "Arah warp diatur ke vertikal",
[3] = "Arah warp diatur ke semua arah",

}

langtilesetnames = {

short0 = "Stasiun RA",
long0 = "Stasiun Ruang Angkasa",
short1 = "Di-luar",
long1 = "Di-luar",
short2 = "Lab",
long2 = "Lab",
short3 = "Zona Warp",
long3 = "Zona Warp",
short4 = "Kapal",
long4 = "Kapal",
short5 = "Menara",
long5 = "Menara",

}

ERR_VEDHASCRASHED = "Ved rusak!"
ERR_VEDVERSION = "Versi Ved:"
ERR_LOVEVERSION = "Versi LÖVE:"
ERR_STATE = "State/status:"
ERR_OS = "OS:"
ERR_TIMESINCESTART = "Waktu sejak mulai:"
ERR_PLUGINS = "Plugin:"
ERR_PLUGINSNOTLOADED = "(tidak dimuat)"
ERR_PLUGINSNONE = "(tidak ada)"
ERR_PLEASETELLDAV = "Harap beri tahu Dav999 tentang masalah ini.\n\n\nDetail: (tekan Ctrl/Cmd+C untuk menyalin ke papan klip)\n\n"
ERR_INTERMEDIATE = " (versi menengah)" -- pre-release version, so a version in between officially released versions
ERR_TOONEW = " (teralu baru)"

ERR_PLUGINERROR = "Kesalahan plugin!"
ERR_FILE = "File yang akan diedit:"
ERR_FILEEDITORS = "Plugin yang mengedit file ini:"
ERR_CURRENTPLUGIN = "Plugin yang memicu kesalahan:"
ERR_PLEASETELLAUTHOR = "Sebuah plugin seharusnya mengedit kode di Ved, tetapi kode yang akan diganti tidak ditemukan.\nHal ini mungkin disebabkan oleh konflik antara dua plugin, atau pembaruan Ved merusak plugin ini.\n\nDetail: (tekan Ctrl/Cmd+C untuk menyalin ke papan klip)\n\n"
ERR_CONTINUE = "Anda dapat melanjutkan dengan menekan ESC atau enter, tetapi perhatikan bahwa pengeditan yang gagal ini dapat menyebabkan masalah."
ERR_OPENPLUGINSFOLDER = "Anda dapat membuka folder plugin dengan menekan F, sehingga Anda dapat memperbaiki atau menghapus plugin yang mengganggu. Setelah itu, mulai ulang Ved."
ERR_REPLACECODE = "Gagal menemukan ini di %s.lua:"
ERR_REPLACECODEPATTERN = "Gagal menemukan ini di %s.lua (sebagai pola):"
ERR_LINESTOTAL = "%i garis secara total"

ERR_SAVELEVEL = "Untuk menyimpan salinan level Anda, tekan S"
ERR_SAVESUCC = "Level berhasil disimpan sebagai %s!"
ERR_SAVEERROR = "Kesalahan simpan! %s"
ERR_LOGSAVED = "Informasi lebih lanjut dapat ditemukan di crash log:\n%s"


diffmessages = {
	pages = {
		levelproperties = "Properti level",
		changedrooms = "Ruang berubah",
		changedroommetadata = "Metadata ruangan berubah",
		entities = "Entitas",
		scripts = "Skrip",
		flagnames = "Nama tanda",
		levelnotes = "Level nota",
	},
	levelpropertiesdiff = {
		Title = "Nama diubah dari \"$1\" menjadi \"$2\"",
		Creator = "Penulis diubah dari \"$1\" menjadi \"$2\"",
		website = "Situs web diubah dari \"$1\" menjadi \"$2\"",
		Desc1 = "Deskr1 diubah dari \"$1\" menjadi \"$2\"",
		Desc2 = "Deskr2 diubah dari \"$1\" menjadi \"$2\"",
		Desc3 = "Deskr3 diubah dari \"$1\" menjadi \"$2\"",
		mapsize = "Ukuran peta diubah dari $1x$2 menjadi $3x$4",
		mapsizenote = "CATATAN: Ukuran peta diubah dari $1x$2 menjadi $3x$4.\\o\nRuang di luar $5x$6 tidak terdaftar.\\o",
		levmusic = "Level musik diubah dari $1 menjadi $2",
	},
	rooms = {
		added1 = "Ditambahkan ($1,$2) ($3)\\G",
		added2 = "Ditambahkan ($1,$2) ($3 -> $4)\\G",
		changed1 = "Berubah ($1,$2) ($3)\\Y",
		changed2 = "Berubah ($1,$2) ($3 -> $4)\\Y",
		cleared1 = "Menghapus semua ubin di ($1,$2) ($3)\\R",
		cleared2 = "Menghapus semua ubin di ($1,$2) ($3 -> $4)\\R",
	},
	roommetadata = {
		changed0 = "Ruang $1,$2:",
		changed1 = "Ruang $1,$2 ($3):",
		roomname = "Nama ruang diubah dari \"$1\" ke \"$2\"\\Y",
		roomnameremoved = "Nama ruang \"$1\" dihapus\\R",
		roomnameadded = "Ruang bernama \"$1\"\\G",
		tileset = "Tileset $1 tilecol $2 diubah dari tileset $3 tilecol $4\\Y",
		platv = "Kecepatan platform berubah dari $1 ke $2\\Y",
		enemytype = "Jenis musuhan berubah dari $1 ke $2\\Y",
		platbounds = "Batasan platform berubah dari $1,$2,$3,$4 ke $5,$6,$7,$8\\Y",
		enemybounds = "Batasan musuhan berubah dari $1,$2,$3,$4 ke $5,$6,$7,$8\\Y",
		directmode01 = "Mode pengatur diaktifkan\\G",
		directmode10 = "Mode pengatur dinonaktifkan\\R",
		warpdir = "Arah warp berubah dari $1 ke $2\\Y",
	},
	entities = {
		added = "Menambahkan jenis entitas $1 pada posisi $2,$3 di ruang ($4,$5)\\G",
		removed = "Jenis entitas yang dihapus $1 dari posisi $2,$3 di ruangan ($4,$5)\\R",
		changed = "Mengubah jenis entitas $1 pada posisi $2,$3 di ruang ($4,$5)\\Y",
		changedtype = "Mengubah jenis entitas $1 menjadi $2 pada posisi $3,$4 di ruang ($5,$6)\\Y",
		multiple1 = "Mengubah entitas pada posisi $1,$2 di ruang ($3,$4):\\Y",
		multiple2 = "ke:",
		addedmultiple = "Menambahkan entitas pada posisi $1,$2 di ruangan ($3,$4):\\G",
		removedmultiple = "Entitas yang dihapus pada posisi $1,$2 di ruangan ($3,$4):\\R",
		entity = "Jenis $1",
		incomplete = "Tidak semua entitas ditangani! Harap laporkan ini ke Dav.\\r",
	},
	scripts = {
		added = "Ditambahkan skrip \"$1\"\\G",
		removed = "Dihapus skrip \"$1\"\\R",
		edited = "Diedit skrip \"$1\"\\Y",
	},
	flagnames = {
		added = "Tetapkan nama untuk tanda $1 ke \"$2\"\\G",
		removed = "Menghapus nama \"$1\" untuk tanda $2\\R",
		edited = "Mengubah nama untuk tanda $1 dari \"$2\" menjadi \"$3\"\\Y",
	},
	levelnotes = {
		added = "Ditambahkan level nota \"$1\"\\G",
		removed = "Dihapus level nota \"$1\"\\R",
		edited = "Diedit level nota \"$1\"\\Y",
	},
	mde = {
		added = "Entitas metadata telah ditambahkan.\\G",
		removed = "Entitas metadata telah dihapus.\\R",
	},
}

