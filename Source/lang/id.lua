-- Language file for Ved
--- Language: id (id)
--- Last converted: 2024-12-11 04:39:19 (CET)

--[[
	If you would like to help translate Ved, please get in touch with Dav999
	to get access to the online translation system!
	If you want to continue translating in this file, it's possible to import
	it into the system later, so don't worry.
]]

-- Plural equations for each language: http://docs.translatehouse.org/projects/localization-guide/en/latest/l10n/pluralforms.html
-- (but then in Lua's syntax)
function lang_plurals(n) return 0 end

function fontpng_ascii(c)

end

L = {

TRANSLATIONCREDIT = "Terjemahan dibuat oleh _march31onne (Marchionne Evangelisti)", -- If you're making a translation, feel free to set this to something like "Translation made by (you)".

OUTDATEDLOVE = "Versi LÖVE Anda sudah usang. Silakan gunakan versi 0.9.1 atau lebih tinggi.\nAnda dapat mengunduh LÖVE versi terbaru dari https://love2d.org/.",
OUTDATEDLOVE090 = "Ved tidak lagi mendukung LÖVE 0.9.0. Untungnya, LÖVE 0.9.1 dan yang lebih baru akan tetap berfungsi.\nAnda dapat mengunduh versi terbaru LÖVE dari https://love2d.org/.",

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

-- L.MAL is concatenated with L.[...]CORRUPT
MAL = "File level salah format: ",
METADATACORRUPT = "Metadata hilang atau rusak.",
METADATAITEMCORRUPT = "Metadata untuk $1 hilang atau rusak.",
TILESCORRUPT = "Ubin hilang atau rusak.",
ENTITIESCORRUPT = "Entitas hilang atau rusak.",
LEVELMETADATACORRUPT = "Ruang metadata hilang atau rusak.",
SCRIPTCORRUPT = "Skrip hilang atau rusak.",

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
KILOBYTES = "$1 kB",
MEGABYTES = "$1 MB",
GIGABYTES = "$1 GB",
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

CONFIRMBIGGERSIZE = "Anda memilih $1x$2, yg merupakan ukuran peta yg lebih besar daripada $3x$4. Di luar peta normal $3x$4, ruang dan properti ruang membungkus, tetapi terdistorsi. Anda tdk mendapatkan ruang yg sama sekali baru, Anda jg tdk mendapatkan lebih banyak properti ruang.\n\nTekan Ya jika Anda tau apa yg Anda lakukan dan menginginkan ukuran peta yang lebih besar ini. Tekan Tidak utk menyetel ukuran peta menjadi $5x$6.\n\nJika tidak yakin, tekan Tidak.",
MAPBIGGERTHANSIZELIMIT = "Ukuran peta $1x$2 lebih besar dari $3x$4! (Lebih besar dari $3x$4 dukungan tidak diaktifkan)",
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
	LITERALNULLS = {
		[0] = "Ada $1 null byte!",
	},
	XMLNULLS = {
		[0] = "Ada $1 karakter null XML!",
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
subj = "Memulai",
imgs = {},
cont = [[
Memulai\wh#
\C=

Artikel ini akan membantu Anda memulai menggunakan Ved. Untuk mulai menggunakan
editor, Anda perlu memuat level, atau membuat yang baru.


Editor\h#

Di sisi kiri, Anda akan menemukan pilihan alat. Sebagian besar alat memiliki
subalat yang akan dicantumkan di sebelah kanannya. Untuk beralih antar alat,
gunakan pintasan masing-masing atau gulir dengan Shift atau Ctrl ditekan. Untuk
beralih di antara subalat, Anda dapat menggulir ke mana saja. Untuk informasi
lebih lanjut tentang alat, lihat halaman bantuan ¤Alat¤.\nwl
Entitas dapat diklik kanan untuk menu tindakan untuk entitas tersebut. Untuk
menghapus entitas tanpa harus menggunakan menu konteks, Shift-klik kanan pada
entitas tersebut.
Di sisi kanan layar, Anda akan menemukan banyak tombol dan opsi. Tombol atas
terkait dengan seluruh tingkat, tombol bawah (di bawah Opsi ruang) kustom untuk
ruangan saat ini. Untuk informasi lebih lanjut tentang tombol-tombol itu, lihat
halaman bantuan masing-masing, jika tersedia.

Folder level\h#

Ved biasanya akan menggunakan folder yang sama untuk menyimpan level seperti yang
dilakukan VVVVVV, jadi mudah untuk beralih dari editor level VVVVVV ke Ved dan
sebaliknya. Jika Ved tidak mendeteksi folder VVVVVV Anda dengan benar, Anda dapat
memasukkan jalur kustom di Opsi Ved.
]]
},

{
splitid = "020_Tile_placement_modes",
subj = "Mode penempatan ubin",
imgs = {"images/demo_auto.png", "images/demo_auto2.png", "images/demo_manual.png"},
cont = [[
Mode penempatan ubin\wh#
\C=

Ved mendukung tiga mode berbeda untuk menggambar ubin.

     Mode otomatis\h#0

          Ini adalah mode yang paling mudah digunakan. Dalam mode ini, Anda dapat
          menggambar dinding dan latar belakang dan ujung-ujungnya akan secara
          otomatis ditempatkan dengan benar. Namun, saat mengedit dalam mode ini,
          semua dinding dan latar belakang dalam ruangan harus tileset dan warna
          yang sama.

     Mode multi-tileset\h#1

          Ini mirip dengan mode otomatis, kecuali bahwa Anda dapat memiliki
          beberapa tileset berbeda di ruangan yang sama. Artinya, mengubah tileset
          tidak akan memengaruhi dinding dan latar belakang yang sudah
          ditempatkan, dan Anda dapat menggambar berbagai jenis tileset di ruangan
          yang sama.

     Mode manual\h#2

          Juga disebut Mode Pengatur, dalam mode ini Anda dapat meletakkan tileset
          apa pun secara manual, jadi Anda tidak terikat pada kombinasi tileset
          yang telah ditentukan sebelumnya dan tepi tidak akan secara otomatis
          ditambahkan ke dinding, memberi Anda kendali penuh atas bagaimana
          ruangan akan terlihat. Namun, mode pengeditan ini seringkali lebih
          lambat digunakan.
]]
},

{
splitid = "030_Tools",
subj = "Alat",
imgs = {"tools/prepared/1.png", "tools/prepared/2.png", "tools/prepared/3.png", "tools/prepared/4.png", "tools/prepared/5.png", "tools/prepared/6.png", "tools/prepared/7.png", "tools/prepared/8.png", "tools/prepared/9.png", "tools/prepared/10.png", "tools/prepared/11.png", "tools/prepared/12.png", "tools/prepared/13.png", "tools/prepared/14.png", "tools/prepared/15.png", "tools/prepared/16.png", "tools/prepared/17.png", },
cont = [[
Alat\wh#
\C=

Anda dapat menggunakan alat berikut untuk mengisi ruangan di level Anda:

\0
   Dinding\h#


Alat dinding dapat digunakan untuk menempatkan dinding.

\1
   Latar Belakang\h#


Alat latar belakang dapat digunakan untuk menempatkan latar belakang.

\2
   Paku\h#


Alat paku dapat digunakan untuk menempatkan paku. Anda dapat menggunakan subalat
perluasan untuk menempatkan paku pada permukaan dengan satu klik (atau geser).

\3
   Trinket/Perhiasan\h#


Alat trinket dapat digunakan untuk meletakkan trinket. Harap dicatat bahwa ada
batas dua puluh trinket dalam satu level.

\4
   Checkpoint\h#


Alat checkpoint dapat digunakan untuk menempatkan checkpoint.

\5
   Penghilang platform\h#


Alat penghilang platform dapat digunakan untuk menempatkan penghilang
platform.

\6
   Konveyor\h#


Alat konveyor dapat digunakan untuk menempatkan konveyor.

\7
   Menggerakan platform\h#


Alat platform bergerak dapat digunakan untuk menempatkan platform bergerak.

\8
   Musuhan\h#


Alat musuhan dapat digunakan untuk menempatkan musuhan. Bentuk dan warna musuhan
ditentukan oleh pengaturan tipe musuhan dan tileset (warna) masing-masing.

\9
   Garis gravitasi\h#


Alat garis gravitasi dapat digunakan untuk menempatkan garis gravitasi.

\^0
   Roomtext/Ruang teks\h#


Alat roomtext dapat digunakan untuk menempatkan teks.

\^1
   Terminal\h#


Alat terminal dapat digunakan untuk menempatkan terminal. Tempatkan terminal
terlebih dahulu, lalu ketikkan nama untuk skrip. Untuk informasi lebih lanjut
tentang skrip, silakan merujuk ke referensi skrip.

\^2
   Kotak skrip/naskah\h#


Alat kotak skrip dapat digunakan untuk menempatkan kotak skrip. Pertama klik di
pojok kiri atas, lalu di pojok kanan bawah, lalu ketikkan nama untuk skripnya.
Untuk informasi lebih lanjut tentang skrip, silakan merujuk ke referensi skrip.

\^3
   Token warp/lusi\h#


Alat token warp dapat digunakan untuk menempatkan token warp. Pertama klik di mana
jalur masuk seharusnya, lalu di mana jalur keluar seharusnya.

\^4
   Garis warp/lusi\h#


Alat garis warp dapat digunakan untuk menempatkan garis warp. Harap dicatat
bahwa garis warp hanya dapat ditempatkan di tepi ruangan.

\^5
   Crewmate/Awak kru\h#


Alat crewmate dapat digunakan untuk menempatkan crewmate yang hilang yang dapat
diselamatkan. Jika semua crewmate diselamatkan, level akan selesai. Harap dicatat
bahwa ada batas dua puluh crewmate yang hilang dalam satu level.

\^6
   Titik awal\h#


Alat titik awal dapat digunakan untuk menempatkan titik awal.
]]
},
{
splitid = "040_Script_editor",
subj = "Editor skrip",
imgs = {},
cont = [[
Editor skrip\wh#
\C=

Dengan editor skrip, Anda dapat mengelola dan mengedit skrip di level Anda.


Nama tanda\h#

Untuk kenyamanan dan keterbacaan skrip, dimungkinkan untuk menggunakan nama
tanda alih-alih angka. Saat Anda menggunakan nama alih-alih nomor, nomor akan
secara otomatis dikaitkan dengan nama itu, di latar belakang. Dimungkinkan juga
untuk memilih nomor mana yang akan digunakan untuk nama tanda.

Mode skrip internal\h#

Untuk menggunakan skrip internal di Ved, Anda dapat mengaktifkan mode skrip
internal di editor, untuk menangani semua perintah dalam skrip itu sebagai skrip
internal. Lihat ¤Mode sk.int¤ untuk informasi selengkapnya tentang mode skrip\nwl
internal. Untuk informasi lebih lanjut tentang skrip internal, periksa referensi
skrip internal.

Memisahkan skrip\h#

Dimungkinkan untuk membagi skrip menjadi dua skrip dengan editor skrip. Setelah
meletakkan kursor teks pada baris pertama yang Anda inginkan di skrip baru,
klik tombol Pisahkan dan masukkan nama skrip baru. Baris sebelum kursor akan tetap
dalam skrip asli, baris dari kursor dan seterusnya akan dipindahkan ke skrip baru.

Melompat ke skrip\h#

Pada baris dengan perintah iftrinkets, ifflag, customiftrinkets atau customifflag,
dimungkinkan untuk melompat ke skrip yang diberikan dengan mengklik tombol
"Pergi ke" saat kursor berada di baris itu. Anda juga dapat menekan ¤Alt+kanan\nw
untuk melakukan ini, dan Anda dapat menggunakan ¤Alt+kiri¤ untuk melompat mundur\nw
satu langkah melalui rantai ke tempat asal Anda.
]]
},

{
splitid = "050_Int_sc_mode",
subj = "Mode sk.int",
imgs = {},
cont = [[
Mode skrip internal\wh#
\C=

Untuk menggunakan skrip internal di Ved, Anda dapat mengaktifkan mode skrip
internal di editor, untuk menangani semua perintah dalam skrip itu sebagai skrip
internal. Dengan fitur ini, Anda tidak perlu terlalu khawatir tentang menjalankan
skrip internal; Anda tidak perlu menggunakan perintah ¤say¤, hitung baris, atau\nw
ketik ¤text(1,0,0,4)¤ atau ¤text,,,,4¤ atau apa pun yang Anda inginkan - cukup\nwnw
tulis skrip internal seperti yang dimaksudkan untuk game utama. Anda bahkan tidak
perlu mengakhiri dengan perintah ¤loadscript¤ terakhir.\nw

Ved mendukung berbagai metode skrip internal. Untuk menyoroti perbedaan teknisnya,
kami akan menggunakan skrip contoh berikut:

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

Baris dari skrip internal ini adalah ¤hijau muda¤, baris yang ditambahkan secara\nG
otomatis dan diperlukan untuk eksploitasi skrip untuk bekerja akan menjadi
abu-abu¤. Perhatikan bahwa ini sedikit disederhanakan; Ved menambahkan ¤#v¤ di\gnw
akhir garis abu-abu pada contoh untuk memastikan skrip yang ditulis secara manual
tidak akan diubah, dan blok ¤say¤ yang terlalu besar harus dipecah menjadi yang\nw
lebih kecil.

Untuk informasi lebih lanjut tentang skrip internal, periksa referensi skrip
internal.

Sk.int Loadscript\h#

Metode loadscript mungkin adalah metode yang paling umum digunakan saat ini.
Ini adalah metode yang didukung Ved sejak versi alpha.

Ini membutuhkan skrip tambahan, skrip beban, untuk memuat skrip internal.
Loadscript akan, dalam bentuknya yang paling dasar, berisi perintah seperti
iftrinkets(0,yourscript)¤, tetapi Anda juga dapat memiliki perintah sederhana\wn
lainnya di dalamnya, dan Anda juga dapat menggunakan ¤ifflag¤ sebagai ganti\nw
iftrinkets¤. Yang penting adalah skrip internal Anda dimuat dari skrip lain\wn
agar bisa berfungsi.

Skrip internal akan dikonversi kurang lebih sebagai berikut:

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

text(1,0,0,3)¤ harus menjadi baris terakhir, atau di editor skrip VVVVVV, harus\w
ada tepat satu baris kosong setelahnya.

Dimungkinkan juga untuk tidak menggunakan ¤squeak(off)¤, dan menggunakan\nw
text(1,0,0,4)¤ sebagai ganti ¤text(1,0,0,3)¤. Menggunakan ¤squeak(off)¤ menyimpan\wnwnw
beberapa baris berharga dalam skrip yang lebih panjang.

Sk.int say(-1)\h#

Metode say(-1) lebih tua, dan memiliki kelemahan pada metode loadscript: metode
ini selalu menampilkan bilah cutscene. Tetapi juga memiliki keuntungan yang dapat
menjadi penting di level dengan banyak skrip: tidak memerlukan skrip beban. Kita
dapat menghapus ¤cutscene()¤ dan ¤untilbars()¤ dari skrip kita, karena keduanya\nwnw
sudah akan ditambahkan oleh VVVVVV saat menggunakan metode ini.

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

Metode ini telah ditambahkan sebagai mode skrip internal tambahan di Ved 1.6.0.
]]
},

{
splitid = "060_Shortcuts",
subj = "Pintasan",
imgs = {},
cont = [[
Pintasan editor\wh#
\C=

Tip: Anda dapat menahan ¤F9¤ di mana saja di dalam Ved untuk melihat banyak\nC
pintasan.

Sebagian besar pintasan yang dapat digunakan di VVVVVV juga dapat digunakan di
Ved.

F1¤  Ubah tileset\C
F2¤  Ubah warna\C
F3¤  Ubah musuhan\C
F4¤  Batasan musuhan\C
F5¤  Batasan platform\C

F10¤  Mode manual/otomatis (mode pengatur/mode non-pengatur)\C

W¤  Ubah arah warp\C
E¤  Ubah nama ruang\C

L¤  Muat peta\C
S¤  Simpan peta\C

Z¤  kuas 3x3 (dinding dan latar belakang)\C
X¤  kuas 5x5 (")\C

< ¤dan¤ >¤  ubah alat\CnC
Ctrl/Cmd+< ¤dan¤ Ctrl/Cmd+>¤  ubah sub-alat\CnC

Lebih banyak jalan pintas\h#

Ved juga memperkenalkan beberapa jalan pintas.

Editor utama\gh#

Ctrl+P¤  Lompat ke ruangan yang berisi titik awal\C
Ctrl+S¤  Quicksave/Simpan cepat\C
Ctrl+X¤  Memotong ruang ke papan klip\C
Ctrl+C¤  Menyalin ruang ke papan klip\C
Ctrl+V¤  Tempel ruang dari clipboard (jika valid)\C
Ctrl+D¤  Bandingkan level ini dengan level lain\C
Ctrl+Z¤  Urung\C
Ctrl+Y¤  Ulang\C
Ctrl+F¤  Cari\C
Ctrl+/¤  Level nota/Cacatan level\C
Ctrl+F1¤  Bantuan\C
(CACATAN: Di Mac, ganti Ctrl dengan Cmd)
N¤  tampilkan semua nomor ubin\C
J¤  menampilkan soliditas ubin\C
;¤  tampilkan ubin minimap\C
Shift+;¤  tampilan latar belakang\C
M¤ atau ¤Keypad 5¤  Perlihatkan peta\CnC
G¤  Pergi ke ruang (ketik koordinat sebagai empat digit)\C
/¤  Skrip\C
[¤  kunci Y mouse sambil ditekan (untuk menggambar garis horizontal lebih mudah)\C
]¤  kunci X mouse sambil ditekan (untuk menggambar garis vertikal lebih mudah)\C
F11¤  muat ulang tileset dan sprite\C

Entitas\gh#

Shift+klik kanan¤  Hapus entitas\C
Alt+klik¤          Pindahkan entitas\C
Alt+Shift+klik¤    Salin entitas\C

Editor skrip\gh#

Ctrl+F¤  Temukan\C
Ctrl+G¤  Pergi ke garis\C
Ctrl+I¤  Alihkan mode skrip internal\C
Alt+kiri¤  Lompat ke skrip dalam perintah bersyarat\C
Alt+kanan¤  Lompat mundur satu langkah\C

Daftar skrip\gh#

N¤  Buat skrip baru\C
F¤  Pergi ke daftar tanda\C
/¤  Buka skrip paling atas/terbaru\C
]]
},

{
splitid = "070_Simp_script_reference",
subj = "Referensi sk.sederhana",
imgs = {},
cont = [[
Referensi skrip sederhana\wh#
\C=

Bahasa scripting VVVVVV sederhana adalah bahasa dasar yang dapat digunakan 
untuk skrip level VVVVVV.
Catatan: setiap kali ada sesuatu di antara tanda kutip, itu harus diketik tanpa
tanda kutip.


say¤([baris[,warna]] .. "]]" .. [[)\h#w

Menampilkan kotak teks. Tanpa argumen apa pun, ini akan membuat kotak teks dengan
satu baris, dan secara default ini akan menghasilkan kotak teks terminal terpusat.
Argumen warna bisa berupa warna, atau nama crewmate.
Jika Anda menggunakan warna dan crewmate yang dapat diselamatkan dengan warna itu
ada di dalam ruangan, maka kotak teks akan ditampilkan di atas crewmate itu.

reply¤([baris])\h#w

Menampilkan kotak teks untuk Viridian. Tanpa argumen garis, ini akan membuat
kotak teks dengan satu baris.

delay¤(n)\h#w

Menunda tindakan lebih lanjut dengan n kutu. 30 kutu hampir satu detik.

happy¤([crewmate])\h#w

Membuat crewmate senang. Tanpa argumen, ini akan membuat Viridian senang.
Anda juga dapat menggunakan "semua", "semua orang" atau "semua orang" sebagai
argumen untuk membuat semua orang bahagia.

sad¤([crewmate])\h#w

Membuat crewmate sedih. Tanpa argumen, ini akan membuat Viridian sedih.
Anda juga dapat menggunakan "all", "everyone" atau "everybody" sebagai
argumen untuk membuat semua orang sedih.

Catatan: perintah ini juga dapat ditulis sebagai ¤cry¤ daripada ¤sad¤.\nwnw

flag¤(flag,on/off)\h#w

Mengaktifkan atau menonaktifkan tanda tertentu. Misalnya, flag(4,on) akan
mengaktifkan flag nomor 4.
Ada 100 tanda, diberi nomor dari 0 hingga 99.
Secara default, semua tanda dimatikan saat Anda mulai memainkan level.
Catatan: Di Ved, Anda juga dapat menggunakan nama tanda alih-alih angka.

ifflag¤(tanda,namaskrip)\h#w

Jika bendera yang diberikan AKTIF, maka buka skrip dengan nama skrip nama.
Jika tanda yang diberikan NONAKTIF, lanjutkan dalam skrip saat ini.
Contoh:
ifflag(20,cutscene) - Jika tanda 20 AKTIF, buka skrip "cutscene", jika tidak
                      lanjutkan di skrip saat ini.
Catatan: Di Ved, Anda juga dapat menggunakan nama bendera alih-alih angka.

iftrinkets¤(angka,namaskrip)\h#w

Jika jumlah trinket Anda >= angka, masuk ke script dengan nama namaskrip.
Jika jumlah trinket Anda < jumlah, lanjutkan di skrip saat ini.
Contoh:
iftrinkets(3,enoughtrinkets) - Jika Anda memiliki 3 atau lebih trinket,
                               skrip "enoughtrinkets" akan dijalankan, jika tidak,
                               skrip saat ini akan dilanjutkan.
Ini adalah praktik umum untuk menggunakan 0 sebagai jumlah minimum trinket,
sebagai cara untuk memuat skrip dalam hal apa pun.

iftrinketsless¤(angka,namaskrip)\h#w

Jika jumlah trinket Anda < angka, masuk ke script dengan nama namaskrip.
Jika jumlah trinket Anda >= jumlah, lanjutkan di skrip saat ini.

destroy¤(apapun)\h#w

Hapus semua benda dari jenis tertentu, sampai Anda masuk kembali ke ruangan.

Argumen yang valid dapat berupa:
warptokens - Token warp
gravitylines - Garis gravitasi
platforms - Tidak berfungsi dengan benar
moving - Platform bergerak (ditambahkan di 2.4)
dissapear - Platform yang menghilang (ditambahkan di 2.4)

music¤(nomor)\h#w

Ubah lagu ke nomor lagu tertentu.
Untuk daftar nomor lagu, lihat artikel "Referensi daftar".

playremix\h#w

Memainkan remix dari Predestined Fate sebagai musik.

flash\h#w

Mengedipkan layar putih, membuat suara ledakan dan mengguncang layar sebentar.

map¤(on/off)\h#w

Mengaktifkan atau menonaktifkan peta. Jika Anda mematikan peta, itu akan
menampilkan "NO SIGNAL/TIDAK ADA SINYAL" sampai Anda menghidupkannya kembali.
Ruangan akan tetap terbuka saat peta mati agar terlihat saat peta dihidupkan.

squeak¤(crewmate/on/off)\h#w

Buat crewmate menciut, atau matikan suara menciut saat kotak teks aktif atau
nonaktif.

speaker¤(warna)\h#w

Mengubah warna dan posisi kotak teks berikutnya yang dibuat dengan "say"
memerintah. Ini dapat digunakan daripada memberikan argumen kedua untuk "say".

warpdir¤(x,y,dir)\w#h

Mengubah arah lengkung untuk ruang x,y, berindeks-1, ke arah yang ditentukan.
Ini dapat diperiksa dengan ifwarp, menghasilkan sistem tanda/variabel ekstra
yang relatif kuat.

x - Kamar x koordinat, mulai dari 1
y - Kamar koordinat y, mulai dari 1
dir - Arah warp. Biasanya 0-3, tetapi nilai di luar batas diterima

ifwarp¤(x,y,dir,skrip)\w#h

Jika warpdir untuk kamar x,y, 1-indexed, diatur ke dir, buka skrip
(sederhana)

x - Kamar x koordinat, mulai dari 1
y - Kamar koordinat y, mulai dari 1
dir - Arah warp. Biasanya 0-3, tetapi nilai di luar batas diterima

loadtext¤(bahasa)\w#h

Muat terjemahan untuk level berdasarkan kode bahasa. Gunakan nilai kosong
untuk menggunakan bahasa VVVVVV lagi.

bahasa - Kode bahasa, seperti fr atau pt_BR

iflang¤(bahasa,skrip)\w#h

Jika bahasa VVVVVV diatur ke bahasa tertentu, buka skrip. Hal ini tidak
dipengaruhi oleh kode bahasa yang Anda berikan ke loadtext(), hanya dipengaruhi
oleh bahasa yang dipilih pengguna di menu.

setfont¤(font)\w#h

Ubah font yang digunakan untuk teks di level. Ini bisa berupa font yang disertakan
dengan game, seperti font_ja untuk bahasa Jepang, atau font yang disertakan dengan
level. Biarkan kosong untuk kembali ke font default untuk level tersebut.

setrtl¤(on/off)\w#h

Di level kustom, alihkan apakah fontnya RTL (kanan ke kiri) atau tidak. Secara
default, fontnya bukan RTL (melainkan LTR).

Mode RTL terutama membuat kotak teks rata kanan, untuk bahasa seperti Arab.

textcase¤(kasus)\w#h

Jika level Anda memiliki file terjemahan, dan Anda memiliki beberapa kotak teks
dengan teks yang sama dalam satu skrip, perintah ini dapat membuatnya memiliki
terjemahan unik. Tempatkan itu sebelum kotak teks.

kasus - Angka antara 1 dan 255
]]
},

{
splitid = "080_Int_script_reference",
subj = "Referensi sk.internal",
imgs = {},
cont = [[
Referensi skrip internal\wh#
\C=

Scripting internal memberikan lebih banyak kekuatan untuk scripters, tetapi juga
sedikit lebih kompleks daripada scripting yang disederhanakan.

Untuk menggunakan skrip internal di Ved, Anda dapat mengaktifkan mode skrip
internal di editor, untuk menangani semua perintah dalam skrip itu sebagai skrip
internal.

Kode warna:\w
Normal - Seharusnya aman, skenario terburuknya adalah VVVVVV mogok karena Anda
         melakukan kesalahan.
Biru¤   - Beberapa di antaranya tidak berfungsi di level kustom, yang lain tidak\b
         masuk akal di level kustom, atau hanya setengah berguna karena
         benar-benar dirancang untuk permainan utama.
Oranye¤ - Ini berfungsi dan tidak ada yang salah secara normal, kecuali jika Anda\o
         memberikan beberapa argumen kustom kepada mereka yang akan menyebabkan
         data simpanan Anda hilang.
Merah¤  - Perintah merah tidak boleh digunakan di level kustom karena akan membuka\r
         kunci bagian tertentu dari game utama (yang seharusnya tidak dilakukan
         level kustom, bahkan jika Anda mengatakan semua orang telah menyelesaikan
         game), atau merusak save data sama sekali.


activateteleporter¤()\w#h

Aktifkan teleporter pertama di ruangan itu, yang membuatnya memancarkan warna
acak, dan menghidupkannya secara tidak menentu.

tile¤ teleporter disetel ke 6, dan ¤color¤ disetel ke 102. Perintah ini membuat\n&Zgn&Zg
teleporter tidak melakukan apa pun saat disentuh, karena ubin teleporter disetel\g
ke sesuatu yang bukan 1.\gn&Zg(

activeteleporter¤()\w#h

Menjadikan teleporter pertama di ruangan itu berwarna putih alias warna ¤101¤.\nn&Z

Perintah ini tidak mengubah ubin, sehingga tidak akan mempengaruhi fungsionalitas.\g

alarmoff\w#h

Menonatifkan alarm.

alarmon\w#h

Mengatifkan alarm.

altstates¤(state)\b#h

Mengubah tata letak beberapa ruangan, seperti ruang perhiasan di kapal sebelum
dan sesudah ledakan, dan pintu masuk lab rahasia (level kustom tidak mendukung
altstate sama sekali).

Dalam kode, ini mengubah variabel ¤altstates¤ global.\gn&Zg

audiopause¤(on/off)\w#h

Aktifkan paksa atau nonaktifkan jeda audio tidak fokus, terlepas dari pengaturan
jeda audio yang diatur pengguna. Default ke mati, yaitu menjeda audio selama jeda
tidak fokus.

Perintah ini ditambahkan di 2.3.\g

backgroundtext\w#h

Membuat textbox show selanjutnya tidak menunggu ACTION ditekan sebelum melanjutkan
script. Penggunaan paling umum dari ini adalah untuk menampilkan beberapa kotak
teks sekaligus.

befadein¤()\w#h

Menghapus memudar secara instan, seperti dari ¤#fadeout()¤fadeout¤ atau ¤#fadein()¤fadein¤.\nLwl&ZnLwl&Z

blackon¤()\w#h

Lanjutkan rendering jika dijeda oleh ¤#blackout()¤blackout¤.\nLwl&Z

blackout¤()\w#h

Menjeda rendering.

Untuk membuat layar menjadi hitam, gunakan ¤#shake(n)¤shake¤ secara bersamaan.\gLwl&Zg

bluecontrol\b#h

Mulailah percakapan dengan Victoria seperti saat Anda bertemu dengannya di game
utama dan tekan ENTER. Juga membuat zona aktivitas setelahnya.

changeai¤(crewmate,ai1,ai2)\w#h

Dapat mengubah arah wajah crewmate atau perilaku berjalan

crewmate - cyan/player/blue/red/yellow/green/purple
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceleft/faceright/followposition,ai2
ai2 - diperlukan jika followposition digunakan untuk ai1

faceplayer¤ tidak ada, gunakan 18 saja. ¤panic¤ juga tidak berfungsi, memerlukan ¤20¤.\n&Zgn&Zgn&Zg

changecolour¤(a,b)\w#h

Mengubah warna crewmate. Perintah ini dapat digunakan dengan Manipulasi Entitas
Sewenang-wenang.

a - Warna crewmate untuk mengubah (cyan/player/blue/red/yellow/green/purple)
b - Nama warna yang ingin diubah. Sejak 2.4, Anda juga dapat menggunakan ID warna

changecustommood¤(warna,suasana)\w#h

Mengubah suasana seorang crewmate yang dapat diselamatkan.

warna - Warna crewmate untuk ubah (cyan/player/blue/red/yellow/green/purple)
suasana - 0 untuk senang, 1 untuk sedih

changedir¤(warna,arah)\w#h

Sama seperti ¤#changeai(crewmate,ai1,ai2)¤changeai¤, ini mengubah arah wajah.\nLwl&Z

warna - cyan/player/blue/red/yellow/green/purple
arah - 0 = kiri, 1 = kanan

changegravity¤(crewmate)\w#h

Meningkatkan jumlah sprite dari crewmate yang diberikan sebanyak 12.

crewmate - Warna crewmate untuk berubah cyan/player/blue/red/yellow/green/purple

changemood¤(warna,suasana)\w#h

Mengubah suasana pemain atau crewmate cutscene.

warna - cyan/player/blue/red/yellow/green/purple
suasana - 0 untuk senang, 1 untuk sedih

Crewmate cutscene adalah rekan kru yang dibuat dengan ¤#createcrewman(x,y,warna,suasana,ai1,ai2)¤createcrewman¤.\gLwl&Zg

changeplayercolour¤(warna)\w#h

Mengubah warna pemain

warna - cyan/player/blue/red/yellow/green/purple/teleporter

changerespawncolour¤(warna)\w#h

Mengubah warna pemain yang dibangkitkan kembali saat mati.

warna - red/yellow/green/cyan/blue/purple/teleporter atau nomor

Perintah ini ditambahkan di 2.4.\g

changetile¤(warna,ubin)\w#h

Mengubah ubin crewmate (Anda dapat mengubahnya ke sprite apa pun di sprite.png,
dan itu hanya berfungsi untuk rekan crewmate yang dibuat dengan createcrewman)

warna - cyan/player/blue/red/yellow/green/purple/gray
ubin - Nomor ubin

clearteleportscript¤()\b#h

Menghapus skrip teleporter yang disetel dengan teleportscript(x)

companion¤(x)\b#h

Menjadikan crewmate yang ditentukan sebagai pendamping.

x - 0 (tidak ada) atau 6/7/8/9/10/11

createactivityzone¤(warna)\b#h

Membuat zona aktivitas di crewmate yang ditentukan (atau pemain, jika crewmate
tidak ada) yang mengatakan "Press ACTION to talk to (crewmate)/
Tekan ACTION untuk berbicara dengan (crewmate)"

createcrewman¤(x,y,warna,suasana,ai1,ai2)\w#h

Membuat crewmate (tidak dapat diselamatkan)

suasana - 0 untuk bahagia, 1 untuk sedih
ai1 - followplayer/followpurple/followyellow/followred/followgreen/followblue/
faceplayer/panic/faceleft/faceright/followposition,ai2
ai2 - diperlukan jika followposition digunakan untuk ai1

createentity¤(x,y,e,meta,meta,p1,p2,p3,p4)\o#h

Membuat entitas dengan ID ¤e§¤, dua nilai ¤meta¤, dan 4 nilai ¤p§¤.\nn&Znn&Znn&Z(

e - ID entitas

Daftar ID entitas dan nilai ¤meta¤/§¤p§¤ yang digunakan dapat ditemukan ¤https://vsix.dev/wiki/Createentity_list¤di sini¤.\gn&Zgn&ZgLClg(

createlastrescued¤()\b#h

Membuat crewmate terakhir yang diselamatkan pada posisi kode keras ¤(200,153)¤.\nn&Z
Rekan crewmate terakhir yang diselamatkan didasarkan pada status game Level
Complete.

createrescuedcrew¤()\b#h

Membuat semua rekan crewmate yang diselamatkan

customifflag¤(n,skrip)\w#h

Sama seperti ¤ifflag(n,skrip)¤ dalam skrip sederhana\nn&Z

customiftrinkets¤(n,skrip)\w#h

Sama seperti ¤iftrinkets(n,skrip)¤ dalam skrip sederhana\nn&Z

customiftrinketsless¤(n,skrip)\w#h

Sama seperti ¤iftrinketsless(n,skrip)¤ dalam skrip sederhana\nn&Z

custommap¤(on/off)\w#h

Varian internal dari perintah peta

customposition¤(type,above/below)\w#h

Mengganti x,y dari perintah teks dan dengan demikian menetapkan posisi kotak teks,
tetapi untuk crewmate, rekan crewmate yang dapat diselamatkan digunakan untuk
memposisikan, bukan rekan crewmate createcrewman.

type - center/centerx/centery, atau nama warna cyan/player/blue/red/yellow/green/
purple (yang dapat diselamatkan)
above/below - Hanya digunakan jika tipe adalah nama warna

cutscene¤()\w#h

Membuat bilah cutscene muncul

delay¤(frame)\w#h

Menjeda skrip untuk jumlah frame yang ditentukan. Kontrol terpaksa tidak ditekan
selama jeda ini.

destroy¤(objek)\w#h

Menghapus entitas. Ini sama dengan perintah scripting yang disederhanakan.

objek - gravitylines/warptokens/platforms/moving/disappear

moving¤ dan ¤disappear¤ ditambahkan di 2.4.\n&Zgn&Zg

do¤(kali)\w#h

Memulai blok perulangan yang akan berulang beberapa kali. Akhiri blok dengan
perintah ¤#loop¤loop¤.\nLwl&Z

kali - Berapa kali blok akan berputar.

endcutscene¤()\w#h

Membuat bilah cutscene menghilang

endtext\w#h

Membuat kotak teks menghilang (memudar)

endtextfast\w#h

Membuat kotak teks langsung menghilang (tanpa memudar)

entersecretlab\r#h

Mengaktifkan mode Secret Lab.

2.2 DAN DI BAWAH: Sebenarnya membuka Rahasia Lab, yang mungkin merupakan efek
yang tidak diinginkan untuk memiliki level kustom.

everybodysad¤()\w#h

Bikin sedih semua crewmate.

Tidak berfungsi pada crewmate yang ditempatkan di editor.\g

face¤(A,B)\w#h

Membuat crewmate A melihat crewmate B.

A - cyan/player/blue/red/yellow/green/purple/gray
B - cyan/player/blue/red/yellow/green/purple/gray

Tidak berfungsi pada crewmate yang ditempatkan di editor.\g

fadein¤()\w#h

Memudar kembali dari ¤#fadeout()¤fadeout¤.\nLwl&Z

fadeout¤()\w#h

Memudarkan layar menjadi hitam. Untuk membatalkan, gunakan ¤#fadein()¤fadein¤ or ¤#befadein()¤befadein¤.\nLwl&ZnLwl&Z

finalmode¤(x,y)\b#h

Menteleportasimu ke Dimensi Luar VVVVVV, ¤(46,54)¤ adalah ruang awal Level Akhir\nn&Z

flag¤(n,on/off)\w#h

Perilaku yang sama seperti perintah yang disederhanakan

flash¤(panjang)\w#h

Membuat layar menjadi putih untuk ¤panjang¤ jumlah frame.\nn&Z

durasi - Jumlah frame. 30 frame hampir satu detik.

Ini berbeda dari perintah yang disederhanakan, yang sebenarnya memanggil ¤flash(5)¤,\gn&Zg
playef(9)¤ dan ¤shake(20)¤ secara bersamaan. Lihat: ¤#playef(suara)¤playef¤ dan ¤#shake(n)¤shake¤.\n&Zgn&ZgLwl&ZgLwl&Zg

flip\w#h

Buat pemain membalik dengan menekan ACTION.

Jika pemain tidak berada di tanah, ini tidak akan berfungsi, karena ini\g
menyimulasikan tekanan ACTION. Demikian pula, perintah ini tepat setelah kotak\g
teks tidak akan berfungsi karena alasan yang sama karena dua penekanan ACTION\g
berturut-turut dianggap sebagai menahan tombol, yang tidak membalik pemutar.\g

flipgravity¤(warna)\w#h

Membalikkan gravitasi crewmate tertentu, atau pemain.

warna - cyan/player/blue/red/yellow/green/purple

Sebelum versi 2.3, hal ini tidak akan membalikkan kembali crewmate, atau\g
memengaruhi pemain.\g

flipme\w#h

Pemosisian vertikal yang benar dari beberapa kotak teks dalam mode flip

foundlab\b#h

Memutar efek suara 3, menunjukkan kotak teks dengan "Congratulations! You have
found the secret lab!/Selamat! Anda telah menemukan lab rahasia!" Tidak endtext,
juga tidak memiliki efek yang tidak diinginkan lebih lanjut.

foundlab2\b#h

Menampilkan kotak teks kedua yang Anda lihat setelah menemukan lab rahasia. Juga
tidak endtext, dan juga tidak memiliki efek yang tidak diinginkan lebih lanjut.

foundtrinket¤(x)\w#h

Membuat trinket ditemukan

x - Jumlah trinket

gamemode¤(x)\b#h

teleporter untuk menunjukkan peta, game untuk menyembunyikannya (menunjukkan
teleporter dari game utama)

x - teleporter/game

gamestate¤(state)\b#h

Ubah gamestate saat ini ke nomor status yang ditentukan.

state - Keadaan permainan untuk melompat ke

Daftar lengkap status permainan ada ¤https://vsix.dev/wiki/List_of_gamestates¤di sini¤.\gLClg

gotoposition¤(x,y,gravitasi)\w#h

Ubah posisi Viridian menjadi ¤(x,y)¤ di ruangan ini, dan mengubah gravitasinya juga.\nn&Z


gravitasi - 1 untuk dibalik, 0 untuk tidak dibalik. Nilai lainnya mengakibatkan
kesalahan gravitasi pemain.

gotoroom¤(x,y)\w#h

Ubah ruangan saat ini menjadi ¤(x,y)¤.\nn&Z

x - koordinat x
y - koordinat y

Koordinat ruangan ini diindeks 0.\g

greencontrol\b#h

Mulai percakapan dengan Verdigris seperti saat Anda bertemu dengannya di game
utama dan tekan ENTER. Juga membuat zona aktivitas setelahnya.

hascontrol¤()\w#h

Membuat pemain memiliki kendali. Perhatikan bahwa Anda tidak dapat menggunakan ini
untuk mendapatkan kembali kendali saat berada di tengah-tengah ¤#delay(frame)¤delay¤.\nLwl&Z

hidecoordinates¤(x,y)\w#h

Atur ruangan pada koordinat yang diberikan ke belum dijelajahi

hideplayer¤()\w#h

Membuat pemain tidak terlihat

hidesecretlab\w#h

Sembunyikan lab rahasia di peta

hideship\w#h

Sembunyikan kapal di peta

hidetargets¤()\b#h

Sembunyikan target di peta

hideteleporters¤()\b#h

Sembunyikan teleporter di peta

hidetrinkets¤()\b#h

Sembunyikan trinket di peta

ifcrewlost¤(crewmate,skrip)\b#h

Jika crewmate hilang, buka skrip

ifexplored¤(x,y,skrip)\w#h

Jika ¤(x,y)¤ dieksplorasi, buka skrip internal.\nn&Z

Koordinat ruangan ini diindeks 0.\g

ifflag¤(n,skrip)\b#h

Sama seperti customifflag, tetapi memuat skrip internal (permainan utama)

iflang¤(bahasa,skrip)\w#h

Periksa apakah bahasa permainan saat ini adalah bahasa tertentu, dan jika ya,
lompat ke skrip khusus yang diberikan. ¤#loadtext(bahasa)¤loadtext¤ tidak berpengaruh pada perintah\nLwl&Z
ini; hanya apa bahasa yang dipilih pengguna di menu.

bahasa - Bahasa yang akan diperiksa, biasanya berupa kode dua huruf, seperti ¤en\nn&Z
untuk bahasa Inggris
skrip - Skrip khusus untuk melompati, jika pemeriksaan berhasil

Perintah ini ditambahkan di 2.4.\g

iflast¤(crewmate,skrip)\b#h

Jika crewmate x diselamatkan terakhir kali, buka skrip

crewmate - Nomor digunakan di sini: 0: Viridian, 1: Violet, 2: Vitellary, 3:
Vermilion, 4: Verdigris, 5 Victoria

ifskip¤(x)\b#h

Jika Anda melewatkan cutscene dalam No Death Mode/Mode Tampa Kematian, buka
skrip x

iftrinkets¤(n,skrip)\b#h

Sama seperti skrip yang disederhanakan, tetapi memuat skrip internal
(permainan utama)

iftrinketsless¤(n,skrip)\b#h

Memeriksa apakah nomor yang diberikan kurang dari jumlah yang terkait dengan
trinket. Namun, itu memeriksa jumlah trinket terbesar yang pernah
Anda dapatkan selama satu permainan utama, BUKAN jumlah trinket yang
sebenarnya Anda miliki. Memuat skrip internal (permainan utama)

ifwarp¤(x,y,dir,skrip)\w#h

Jika warpdir untuk kamar ¤(x,y)¤, berindeks-1, diatur ke dir, buka skrip\nn&Z
(yang disederhanakan)

x - Ruang x koordinat, mulai dari 1
y - Ruang y koordinat, mulai dari 1
dir - Arah warp. Biasanya 0-3, tetapi nilai di luar batas diterima

jukebox¤(n)\w#h

Membuat terminal jukebox menjadi putih dan mematikan warna semua terminal lainnya.
Jika n diberikan, zona aktivitas jukebox akan muncul pada posisi hardcode dan jika
terminal berada pada posisi hardcode yang sama maka akan menyala.
Nilai yang mungkin dari n dan posisi hardcode adalah sebagai berikut:
1: (88, 80), 2: (128, 80), 3: (176, 80), 4: (216, 80), 5: (88, 128), 6: (176,
128), 7: (40, 40), 8: (216, 128), 9: (128, 128), 10: (264, 40)

leavesecretlab¤()\b#h

Nonatifkan "secret lab mode"

loadscript¤(script)\b#h

Muat skrip internal (permainan utama). Biasanya digunakan di level kustom sebagai
loadscript(stop)

loadtext¤(bahasa)\w#h

Di level khusus, muat terjemahan untuk bahasa tertentu.

bahasa - Bahasa yang akan dimuat, biasanya berupa kode dua huruf, seperti ¤en\nn&Z
untuk bahasa Inggris. Berikan kode bahasa kosong untuk kembali ke perilaku default
hanya menggunakan bahasa VVVVVV.

Perintah ini ditambahkan di 2.4.\g

loop\w#h

Letakkan ini di akhir blok perulangan yang dimulai dengan perintah ¤#do(kali)¤do¤.\nLwl&Z

missing¤(warna)\b#h

Membuat seseorang hilang

moveplayer¤(x,y)\w#h

Memindahkan pemutar x piksel ke kanan dan y piksel ke bawah. Angka negatif juga
diterima.

musicfadein¤()\w#h

Memudarkan musik yang masuk.

Sebelum versi 2.3, perintah ini tidak melakukan apa pun.\g

musicfadeout¤()\w#h

Memudar musik.

nocontrol¤()\w#h

Menyetel game.hascontrol ke false, yang menghilangkan kontrol dari pemain.
game.hascontrol secara otomatis diatur selama "- [Press ACTION to advance text/
Tekan TINDAKAN untuk memajukan teks] -" dan menutup kotak teks, jadi ini akan
dibatalkan setelah petunjuk itu

play¤(n)\w#h

Mulai mainkan lagu dengan nomor lagu internal.

n - Nomor lagu internal

playef¤(suara)\w#h

Mainkan efek suara.

suara - ID Suara

Di VVVVVV 1.x, ada argumen kedua yang mengontrol offset dalam milidetik saat efek\g
suara dimulai. Ini telah dihapus selama port C++.\g

position¤(tipe,above/below)\w#h

Mengganti x,y dari perintah teks dan dengan demikian mengatur posisi kotak teks.

tipe - center/centerx/centery, atau nama warna cyan/player/blue/red/yellow/green/
purple
above/below - Hanya digunakan jika tipe adalah nama warna

purplecontrol\b#h

Mulailah percakapan dengan Violet seperti saat kamu bertemu dengannya di game
utama dan tekan ENTER. Juga membuat zona aktivitas setelahnya.

redcontrol\b#h

Mulai percakapan dengan Vermilion seperti saat Anda bertemu dengannya di game
utama dan tekan ENTER. Juga membuat zona aktivitas setelahnya.

rescued¤(warna)\b#h

Membuat seseorang diselamatkan

resetgame\w#h

Mengatur ulang semua trinket, mengumpulkan crewmate dan tanda, dan memindahkan
pemain ke checkpoint terakhir.

restoreplayercolour¤()\w#h

Mengubah warna pemain kembali ke biru muda

resumemusic¤()\w#h

Melanjutkan musik setelah ¤#musicfadeout()¤musicfadeout¤.\nLwl&Z

Sebelum versi 2.3, hal ini belum selesai dan menyebabkan berbagai gangguan,\g
termasuk crash.\g

rollcredits¤()\r#h

Membuat kredit bergulir.

2.2 DAN DI BAWAH: Ini menghancurkan simpanan Anda setelah kredit selesai!

setactivitycolour¤(warna)\w#h

Ubah warna zona aktivitas berikutnya yang muncul.

warna - Warna apa pun yang digunakan ¤#text(warna,x,y,baris)¤text\nLwl&Z

Perintah ini ditambahkan di 2.4.\g

setactivityposition¤(y)\w#h

Ubah posisi zona aktivitas berikutnya yang muncul.

y - Posisi y

Perintah ini ditambahkan di 2.4.\g

setactivitytext\w#h

Ubah teks zona aktivitas berikutnya yang muncul. Baris setelah perintah ini akan
diambil sebagai teks (seperti ¤#text(warna,x,y,baris)¤text¤ dengan 1 baris).\nLwl&Z

Perintah ini ditambahkan di 2.4.\g

setcheckpoint¤()\w#h

Setel pos pemeriksaan ke lokasi saat ini

setfont¤(font,all)\w#h

Di level khusus, atur font ke font yang diberikan.

font - Font untuk mengatur font. Jika dibiarkan kosong, ini akan mengatur font ke
font default level kustom.
all - Jika ¤all¤ ditentukan (secara harafiah kata ¤semua¤), maka ini akan\nn&Znn&Z
mempengaruhi semua kotak teks yang sudah ada di layar secara surut. Kalau tidak,
tinggalkan saja ini.

Perintah ini ditambahkan di 2.4. Argumen ¤all¤ ditambahkan di 2.4.1.\gn&Zg

setroomname\w#h

Ubah nama ruangan dari ruangan saat ini. Baris setelah perintah ini akan diambil
sebagai namanya (seperti ¤#text(warna,x,y,baris)¤text¤ dengan 1 baris).\nLwl&Z

Nama ini tidak bersifat persisten dan akan kembali ke nama ruangan default saat
ruangan dimuat ulang (misalnya dengan keluar dan kembali).

Nama ini menggantikan nama ruang ganti khusus apa pun, jika ruangan tersebut
memilikinya.

Perintah ini ditambahkan di 2.4.\g

setrtl¤(on/off)\w#h

Di level kustom, alihkan apakah fontnya RTL (kanan ke kiri) atau tidak. Secara
default, fontnya bukan RTL (melainkan LTR).

Mode RTL terutama membuat kotak teks rata kanan, untuk bahasa seperti Arab.

Perintah ini ditambahkan di 2.4.\g

shake¤(n)\w#h

Kocok layar untuk n kutu. Ini tidak akan membuat penundaan.

showcoordinates¤(x,y)\w#h

Atur ruangan pada koordinat yang diberikan untuk dijelajahi

showplayer¤()\w#h

Membuat pemain terlihat

showsecretlab\w#h

Tunjukkan lab rahasia di peta

showship\w#h

Tunjukkan kapal di peta

showtargets¤()\b#h

Tampilkan target di peta (teleporter tidak dikenal yang muncul sebagai [?])

showteleporters¤()\b#h

Tunjukkan teleporter di ruangan yang dijelajahi di peta

showtrinkets¤()\w#h

Tunjukkan trinket di peta

Sejak 2.3, perintah ini diubah agar berfungsi di level khusus.\g

speak\w#h

Memperlihatkan kotak teks, tanpa menghapus kotak teks lama. Juga jeda skrip
sampai Anda menekan action/tindakan (kecuali ada perintah backgroundtext di
atasnya)

speak_active\w#h

Memperlihatkan kotak teks, dan menghapus kotak teks lama. Juga jeda skrip hingga
Anda menekan tindakan (kecuali ada perintah teks latar di atasnya)

specialline¤(x)\b#h

Dialog spesial/kustom yang muncul di game utama

squeak¤(warna)\w#h

Membuat suara menciut dari crewmate, atau suara terminal

warna - cyan/player/blue/red/yellow/green/purple/terminal

startintermission2\b#h

Alternate ¤finalmode(46,54)¤, membawa Anda ke level akhir tanpa menerima argumen.\nn&Z

stopmusic¤()\w#h

Menghentikan musik segera. Setara dengan ¤music(0)¤ dalam skrip yang disederhanakan.\nn&Z

teleportscript¤(skrip)\b#h

Digunakan untuk mengatur skrip yang dijalankan saat Anda menggunakan teleporter

telesave¤()\r#h

Tidak melakukan apa pun di level kustom.

2.2 DAN DI BAWAH: Simpan game Anda di penyimpanan teleporter biasa, jadi jangan
gunakan itu!

text¤(warna,x,y,baris)\w#h

Simpan kotak teks dalam memori dengan warna, posisi dan jumlah baris. Biasanya,
perintah posisi digunakan setelah perintah teks (dan baris teksnya), yang akan
menimpa koordinat yang diberikan di sini, jadi ini biasanya dibiarkan sebagai 0.

warna - cyan/player/blue/red/yellow/green/purple/gray/white/orange/transparent
x - Posisi x dari kotak teks
y - Posisi y dari kotak teks
baris - Jumlah baris

Warna ¤transparent¤ ditambahkan di 2.4, bersama dengan kotak teks berwana\gn&Zg
sewenang-wenang. Koordinatnya bisa -500 untuk memusatkan kotak teks pada sumbu\g
masing-masing (jika Anda tidak ingin menggunakan ¤#position(type,above/below)¤position¤.\gLwl&Zg

textboxactive\w#h

Membuat semua kotak teks di layar menghilang kecuali yang terakhir dibuat

textboxtimer¤(frame)\w#h

Membuat kotak teks yang ditampilkan berikutnya menghilang setelah sejumlah frame
tertentu, tanpa memajukan skrip.

frame - Jumlah frame yang harus ditunggu sebelum memudar

Perintah ini ditambahkan di 2.4.\g

textbuttons¤()\w#h

Untuk kotak teks di memori, ganti placeholder tombol tertentu dengan label tombol
(seperti tombol keyboard atau mesin terbang pengontrol).

Placeholder yang diganti adalah:
- {b_act} - TINDAKAN/ACTION
- {b_int} - Berinteraksi
- {b_map} - Peta
- {b_res} - Mulai ulang
- {b_esc} - Esc/Menu

Perintah ini ditambahkan di 2.4.\g

textcase¤(kasus)\w#h

Jika level Anda memiliki file terjemahan, dan Anda memiliki beberapa kotak teks
dengan teks yang sama dalam satu skrip, perintah ini dapat membuatnya memiliki
terjemahan unik. Tempatkan itu sebelum kotak teks.

kasus - Nomor kasus, antara 1 dan 255.

Perintah ini ditambahkan di 2.4.\g

textimage¤(gambar)\w#h

Untuk kotak teks di memori, gambarlah gambar yang diberikan. Hanya boleh ada satu
gambar per kotak teks.

gambar - levelcomplete/gamecomplete, atau nilai yang tidak diketahui untuk
menghapus gambar

Perintah ini ditambahkan di 2.4.\g

textsprite¤(x,y,sprite,warna)\w#h

Untuk kotak teks di memori, gambar sprite yang diberikan. Mungkin ada beberapa
sprite per kotak teks.

x - Koordinat x dari sprite. Ini relatif terhadap kotak teks.
y - Koordinat y dari sprite. Ini relatif terhadap kotak teks.
sprite - Jumlah sprite dari sprite, dari ¤sprites.png¤.\nn&Z
color - ID warna sprite.

Perintah ini ditambahkan di 2.4.\g

tofloor\w#h

Membuat pemain membalik ke lantai jika mereka belum berada di lantai.

trinketbluecontrol¤()\b#h

Dialog Victoria ketika dia memberi Anda perhiasan di game nyata

trinketscriptmusic\w#h

Memainkan Passion for Exploring.

trinketyellowcontrol¤()\b#h

Dialog Vitellary saat dia memberimu perhiasan di game yang sebenarnya

undovvvvvvman¤()\w#h

Menyetel ulang hitbox pemain ke ukuran normal, menyetel warnanya ke 0, dan
menyetel posisi X ke 100.

untilbars¤()\w#h

Tunggu sampai ¤#cutscene()¤cutscene¤/§¤#endcutscene()¤endcutscene¤ selesai.\nLwl&ZnLwl&Z(

untilfade¤()\w#h

Tunggu sampai ¤#fadeout()¤fadeout¤/§¤#fadein()¤fadein¤ selesai.\nLwl&ZnLwl&Z(

vvvvvvman¤()\w#h

Memperbesar pemain 6x, mengatur posisinya menjadi ¤(30,46)¤ dan mengatur warnanya\nn&Z
menjadi ¤23¤.\nn&Z

walk¤(arah,x)\w#h

Membuat pemain berjalan untuk jumlah kutu yang ditentukan

arah - left/right

warpdir¤(x,y,dir)\w#h

Mengubah arah lengkung untuk ruang x,y, berindeks 1, ke arah yang ditentukan. Ini
dapat diperiksa dengan ifwarp, menghasilkan sistem flag/variabel ekstra yang
relatif kuat.

x - Ruang x koordinat, mulai dari 1
y - Ruang y koordinat, mulai dari 1
dir - Arah warp. Biasanya 0-3, tetapi nilai di luar batas diterima

yellowcontrol\b#h

Mulai percakapan dengan Vitellary seperti saat Anda bertemu dengannya di game
utama dan tekan ENTER. Juga membuat zona aktivitas setelahnya.
]]
},

{
splitid = "090_Lists_reference",
subj = "Daftar referensi",
imgs = {},
cont = [[
Daftar referensi\wh#
\C=

Ini adalah daftar nomor yang digunakan di VVVVVV, sebagian besar disalin dari
posting forum. Terima kasih kepada semua orang yang menyusun daftar ini!


Indeks\w&Z+
\&Z+
#Nomor musik (skrip yang disederhanakan)\C&Z+l
#Nomor musik (internal)\C&Z+l
#Nomor suara efek\C&Z+l
#Entitas\C&Z+l
#Warna untuk crewmate createentity()\C&Z+l
#Jenis gerakan musuh\C&Z+l
#Gamestate\C&Z+l


Nomor musik (skrip yang disederhanakan)\h#

0 - Silence (tak ada musik)
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

Nomor musik (internal)\h#

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

Nomor suara efek\h#

0 - Balik ke langit-langit
1 - Balik kembali ke lantai
2 - Sedih
3 - trinket dikumpulkan
4 - Koin dikumpulkan
5 - Checkpoint disentuh
6 - Blok pasir hisap lebih cepat disentuh
7 - Blok pasir hisap normal disentuh
8 - Garis gravitasi disentuh
9 - Flash
10 - Warp
11 - Viridian menciut
12 - Verdigris menciut
13 - Victoria menciut
14 - Vitellary menciut
15 - Violet menciut
16 - Vermilion menciut
17 - Terminal tersentuh
18 - Teleporter tersentuh
19 - Alarm
20 - Terminal menciut
21 - Hitung mundur uji waktu "3", "2", "1"
22 - Hitung mundur uji waktu "{Go/Mulai}!"
23 - VVVVVV Man menghancurkan tembok
24 - Crewmates menggabungkan/menguraikan menjadi VVVVVVV Man
25 - Rekor baru di Super Gravitron
26 - Trofi baru di Super Gravitron
27 - Crewmate yang diselamatkan (dalam level kustom)

Entitas\h#

0 - Pemain
1 - Musuh
     Metadata: jenis gerakan, kecepatan gerakan
     Karena kurangnya data yang dibutuhkan, Anda hanya akan mendapatkan kotak
     musuh berwarna ungu, kecuali jika Anda berada di Polar Dimension VVVVVV saat
     melakukan perintah
2 - Platform bergerak
     Metadata: jenis gerakan, kecepatan gerakan
     Perhatikan bahwa konveyor diimplementasikan sebagai platform bergerak,
     lihat tipe gerakan 8 dan 9.
3 - Platform yang menghilang
4 - Blok pasir hisap 1x1 lebih cepat
5 - Viridian yang terbalik, Anda akan membalik gravitasi saat disentuh
6 - Benda aneh berwarna merah mencolok yang menghilang dengan cepat
7 - Sama seperti di atas, tetapi tidak berkedip dan berwarna cyan
8 - Koin dari prototipe
    Metadata: ID Koin
9 - Trinket
     Metadata: ID trinket
     Perhatikan bahwa ID trinket mulai dari 0, dan semua yang di atas 19
     tidak akan disimpan di savefile setelah Anda memulai ulang level
10 - Checkpoint
     Metadata: Status Checkpoint (0=terbalik, 1=normal), Checkpoint ID (memeriksa
     apakah checkpoint aktif atau tidak)
11 - Garis gravitasi horizontal
     Metadata: Panjang dalam piksel
12 - Garis gravitasi vertikal
     Metadata: Panjang dalam piksel
13 - Token warp
     Metadata: Tujuan di sumbu X ubin, tujuan di sumbu Y ubin
14 - Teleporter bulat
     Metadata: ID Pos Pemeriksaan(?)
15 - Verdigris
     Metadata: status AI
16 - Vitellary (dibalik)
     Metadata: status AI
17 - Victoria
     Metadata: status AI
18 - Rekan crewmate
     Metadata: Warna (menggunakan daftar warna mentah, bukan warna crewmate),
     suasana
19 - Vermilion
     Metadata: status AI
20 - Terminal
     Metadata: Sprite, ID Skrip(?)
21 - Sama seperti di atas tetapi ketika disentuh terminal tidak menyala
     Metadata: Sprite, ID Skrip(?)
22 - Koleksi perhiasan
     Metadata: ID Perhiasan
23 - Gravitron persegi
     Metadata: Arah
     Jika Anda memasukkan koordinat X negatif (atau terlalu tinggi), panah akan
     muncul, seperti di Gravitron asli
24 - Istirahat 1 crewmate
     Metadata: Warna mentah, suasana hati
     Tampaknya tidak terpengaruh oleh bahaya, tetapi seharusnya.
25 - Piala
     Metadata: Pengidentifikasi tantangan, sprite
     Jika tantangan selesai, ID sprite dasar (yang Anda dapatkan jika menggunakan
     sprite=0) akan berubah. Gunakan hanya 0 atau 1 jika Anda ingin hasil yang
     dapat diprediksi
     (0=normal, 1=terbalik)
26 - Token warp ke Lab Rahasia
     Perlu diingat bahwa warp hanya diimplementasikan sebagai sprite yang terlihat
     bagus.
     Anda harus membuat skrip fungsionalitas untuk diri Anda sendiri
55 - Rekan crewmate yang bisa diselamatkan
     Metadata: Warna crewmate. Warna >6 akan selalu menunjukkan *bahagia* Viridian
56 - Musuh level kustom
     Metadata: Jenis gerakan, kecepatan gerakan
     Perlu diingat bahwa jika tidak ada musuh di dalam ruangan, data sprite musuh
     tidak diperbarui dengan benar dan itu hanya akan menunjukkan musuh apa yang
     Anda lihat terakhir kali, atau musuh persegi
Entitas yang tidak ditentukan (27-50, 57+) memberikan Viridian yang glitchy/salah.

Warna untuk crewmate createentity()\h#

0: Cyan
1: Merah mencolok (digunakan untuk kematian)
2: Oranye gelap
3: Warna perhiasan
4: Abu-abu
5: Putih mencolok
6: Merah (sedikit lebih gelap dari Vermilion)
7: hijau limau
8: Merah muda panas
9: Kuning cemerlang
10: Putih mencolok
11: cyan cerah
12: Biru, sama seperti Victoria
13: Hijau, sama seperti Verdigris
14: Kuning, sama seperti Vitellary
15: Merah, sama seperti Vermilion
16: Biru, sama seperti Victoria
17: Oranye lebih terang
18: Abu-abu
19: Abu-abu lebih gelap
20: Pink, sama seperti Violet
21: Abu-abu lebih terang
22: Putih
23: Putih mencolok
24-29: Putih
30: Abu-abu
31: Gelap, abu-abu agak keunguan?
32: Cyan gelap/hijau
33: Biru tua
34: Hijau tua
35: Merah tua
36: Oranye kusam
37: Abu-abu mencolok
38: Abu-abu
39: Cyan/hijau yang lebih gelap
40: Abu-abu lebih mencolok
41-99: Putih
100: Abu-abu gelap
101: Putih mencolok
102: Warna teleporter
103 dan seterusnya: Putih

Jenis gerakan musuh\h#

0 - Memantul ke atas dan ke bawah, mulai turun.
1 - Memantul ke atas dan ke bawah, dimulai.
2 - Memantul ke kiri dan ke kanan, mulai dari kiri.
3 - Memantul ke kiri dan ke kanan, mulai dari kanan.
4, 7, 11 - Bergerak ke kanan hingga bertabrakan.
5 - Sama seperti di atas, hanya bertingkah aneh saat bertabrakan.
     GIF di sini: ¤https://files.catbox.moe/c23ovl.gif\nCl
6 - Memantul ke atas dan ke bawah, tetapi hanya mencapai posisi y tertentu
    sebelum kembali turun. Digunakan dalam "Trench warfare".
8, 9 - Untuk platform bergerak mereka adalah konveyor, dan mereka masih untuk hal
       lain
14 - Dapat diblokir oleh platform yang menghilang
15 - Masih (?)
10, 12 - Mengkloning ke kanan/di tempat yang sama, membuat VVVVVV mogok jika
         terlalu intens, dan akan merusak level Anda jika Anda menyimpan.
13 - Seperti 4, tetapi bergerak ke bawah hingga bertabrakan.
16 - Berkedip masuk dan keluar dari keberadaan. (Muncul dan menghilang)
17 - Gerakan gelisah ke kiri
18 - Gerakan gelisah benar, sedikit lebih cepat
19+ - Masih (?)

Gamestate\h#

0 - Keluar dari sebagian besar status permainan
1 - Setel gamestate ke 0 (yaitu sama seperti di atas dalam praktiknya)
2 - "To do: write quick intro to story!"
4 - "Press arrow keys or WASD to move"
5 - Jalankan skrip "returntohub" (yaitu fadeout, teleport ke kanan sebelumnya
    The Tower, fadein, mainkan Passion for Exploring)
7 - Menghapus kotak teks
8 - "Press enter to view map and quicksave"
9 - Super Gravitron
10 - Gravitron
11 - "When you're NOT standing on stop and wait for you" (Mencoba mengakses
     flipmode, periksa untuk menulis "ceiling" atau "floor", dan periksa
     crewmate, tetapi karena ini gagal, cetakan di atas sebagai gantinya)
12 - "You can't continue to the next room until he is safely accross."
13 - Hapus kotak teks dengan cepat
14 - "When you're standing on the floor," (hal yang sama berlaku di sini
     seperti untuk 11)
15 - Membuat Viridian bahagia
16 - Membuat Viridian sedih
17 - "If you prefer, you can press UP or DOWN instead of ACTION to flip."
20 - Jika tanda 1 adalah 0, atur tanda 1 ke 1 dan hapus kotak teks
21 - Jika tanda 2 adalah 0, atur tanda 2 ke 1 dan hapus kotak teks
22 - "Press ACTION to flip"
30 - "I wonder why the ship teleported me here alone?" "I hope everyone else got
     out ok..."
31 - adegan potong "Violet, is that you?" (selama flag 6 adalah 0)
32 - Jika tanda 7 adalah 0: "A teleporter!" "I can get back to the ship with
     this!"
33 - Jika tanda 9 adalah 0: Victoria-cutscene
34 - Jika tanda 10 adalah 0: Vitellary-cutscene
35 - Jika tanda 11 adalah 0: Verdigris-cutscene
36 - Jika tanda 8 adalah 0: Vermilion-cutscene
37 - Vitellary setelah gravitron
38 - Vermilion setelah gravitron
39 - Verdigris setelah gravitron
40 - Victoria setelah gravitron
41 - Jika tanda 60 adalah 0: jalankan awal cutscene istirahat 1
42 - Jika tanda 62 adalah 0: jalankan cutscene ke-3 istirahat 1
43 - Jika tanda 63 adalah 0: jalankan cutscene ke-4 istirahat 1
44 - Jika tanda 64 adalah 0: jalankan cutscene ke-5 istirahat 1
45 - Jika tanda 65 adalah 0: jalankan cutscene ke-6 istirahat 1
46 - Jika tanda 66 adalah 0: jalankan cutscene ke-7 istirahat 1
47 - Jika tanda 69 adalah 0: "Ohh! I wonder what that is?" adegan potong trinket
48 - Jika tanda 70 adalah 0: "This seems like a good place to store anything I
     find out there..." (Victoria belum ditemukan)
49 - Jika tanda 71 adalah 0: Mainkan Predestined Fate
50 - "Help! Can anyone hear this message?"
51 - "Verdigris? Are you out there? Are you ok?"
52 - "Please help us! We've crashed and need assistance!"
53 - "Hello? Anyone out there?"
54 - "This is Doctor Violet from the D.S.S. Souleye! Please respond!"
55 - "Please... Anyone..."
56 - "Please be alright, everyone..."
Dengan gamestate 50-56, Anda dapat memilih dari mana harus memulai, karena
     semuanya akan muncul satu sama lain
80 - Jika layar hitam (dan hanya jika), lanjutkan ke status 81 (Tebakan saya ini
     dipanggil saat ESC ditekan, sebelum menu jeda terbuka)
81 - Kembali ke menu utama
82 - Hasil uji waktu (bug/disadap)
83 - Jika layar kembali, lanjutkan ke status 84
84 - Hasil time trial (saya pikir 82 bekerja lebih baik dari 84)
85 - Versi Time Trial dari gamestate 200 (Flash, mainkan Positive Force, aktifkan
     mode finalstretch)
State 90-95 terkait dengan uji waktu, tetapi tidak berfungsi dengan baik di level
      kustom. Satu-satunya efek nyata yang terjadi di level kustom adalah
      lengkungan, perubahan musik
90 - Statiun Luar Angkasa 1
91 - Laboratorium
92 - Zona Warp
93 - Menara
94 - Statiun Luar Angkasa 2
95 - Level Akhir
96 - Jika layarnya hitam, lanjutkan dengan state 97
97 - Keluar dari Super Gravitron (teleport dan mainkan Pipe Dream)
100 - Jika tanda 4 adalah 0: lanjutkan ke state 101
101 - Jika Anda terbalik, balikkan kembali ke lantai, lanjutkan dengan state 102
State berikut (102-112) mencoba menuju ke state saat ini + 1, seperti pada 50-56
      tetapi tidak berputar), tetapi mungkin mengalami kesalahan sebagai setengah
      dari state (103, 105, 107, 109, 111) tidak ada.
102 - Verdigris: "Captain! I've been so worried!"
104 - "I'm glad you're ok!"
106 - "I've been trying to find a way out, but I keep going around in circles..."
108 - "Don't worry! I have a teleporter key!"
110 - "Follow me!"
112 - Menghapus kotak teks
115 - Pada dasarnya tidak ada, lanjutkan untuk state 116
116 - Dialog merah di bagian bawah layar mengatakan "Sorry Eurogamers! Teleporting
      around the map doesn't work in this version!", teruskan ke state 117, yang
      tidak ada, jadi semuanya mungkin gagal
118 - Menghapus kotak teks
State 120-128 berfungsi seperti 102-112, yaitu dalam rangkaian, tetapi dengan
      hal-hal yang lebih sedikit rusak
120 - Jika tanda 5 adalah 0: lanjutkan ke state 121
121 - Jika Anda di lantai, balikkan.
122 - Vitellary: "Captain! You're ok!"
124 - Vitellary: "I've found a teleporter, but I can't get it to go anywhere..."
126 - "I can help with that!"
128 - "I have the teleporter codex for our ship!"
130 - "Yey! Let's go home!"
132 - Menghapus kotak teks
200 - Mode final
1000 - Menyalakan cutscenebars, membekukan permainan, teruskan ke state 1001
1001 - Dialog "You got a shiny trinket!" (tetapi Anda tidak benar-benar
       mendapatkannya, ini hanya dipanggil setiap kali Anda mendapatkannya),
       lanjutkan dengan state 1003
1003 - Kembalikan permainan ke normal
1010 - "You found a crewmate!" dengan cara yang sama seperti untuk trinket
1013 - Akhiri level dengan bintang
2000 - Simpan permainan
2500-2509 - Lakukan teleportasi ke beberapa lokasi aneh yang tidak ada,
            konon ke The Laboratory, saya kira, lanjutkan dengan state
            2510
2510 - Viridian: "Hello?", lanjutkan dengan state 2512
2512 - Viridian: "Is anybody there?", lanjutkan dengan state 2514
2514 - Menghapus kotak teks, mainkan Potential For Anything
State 3000-3099:
3000-3005 - "Level Complete! You've rescued the crewmate" diterapkan ke
            companion(), default ke Verdigris. 6=Verdigris, 7=Vitellary,
            8=Victoria, 9=Vermilion, 10=Viridian (ya, betulkah), 11=Violet
            (Gamestate: 3006-3011=Verdigris, 3020-3026=Vitellary,
            3040-3046=Victoria, 3060-3066=Vermilion, 3080-3086=Viridian,
            3050-3056=Violet)
3070-3072 - Lakukan hal-hal pasca penyelamatan, biasanya kembali ke kapal
3501 - Game Complete
4010 - Flash + warp
4070 - The Final Level, tetapi game akan macet ketika Anda mencapai Timeslip
       (Karena bagaimana game mendapatkan informasi entitas, yang rusak di level
       kustom)
4080 - Kapten teleport kembali ke kapal: potong adegan "Hello!" [C[C[C[C[Captain!]
       + kredit.
       Hal di atas akan mengacaukan penyimpanan data Anda, jadi jangan lakukan itu
       kecuali Anda mencadangkan!
4090 - Potongan adegan setelah Anda menyelesaikan stasiun luar angkasa 1
]]
},

{
splitid = "100_Formatting",
subj = "Memformat",
imgs = {},
cont = [[
Memformat\wh#
\C=

Dalam catatan Anda dapat menggunakan kode pemformatan untuk membuat teks Anda
lebih besar, mewarnainya, dan beberapa hal lainnya. Untuk menambahkan pemformatan
ke baris, tambahkan garis miring terbalik (\) di bagian akhir.\
Setelah \, Anda dapat menambahkan jumlah karakter berikut, dalam urutan apa pun:\

h - Ukuran font ganda\h

# - Jangkar. Anda dapat melompat ke jangkar dengan cepat dengan tautan
    ¤#Tautan¤tautan¤.\nLCl
- - Garis horizontal:
\-
= - Garis horizontal di bawah teks besar

Warna teks:\h#

n - Normal\n
r - Merah\r
g - Abu-abu\g
w - Putih\w
b - Biru\b
o - Oranye\o
v - Hijau\v
c - Biru muda\c
y - Kuning\y
p - Ungu\p
V - Hijau gelap\V
z - Hitam¤ (warna latar belakang tidak termasuk)\z&Z
Z - Abu-abu gelap\Z
C - Biru muda (Viridian)\C
P - Pink (Violet)\P
Y - Kuning (Vitellary)\Y
R - Merah (Vermilion)\R
G - Hijau (Verdigris)\G
B - Biru (Victoria)\B


Contoh:\h#

\-
Teks oranye bsr. ("oh" memiliki hsil yg\ho\

sama)\ho\

Teks oranye bsr. ("oh" memiliki hsil yg\ho

sama)\ho

\-
Teks besar yang digarisbawahi\wh\
\r=\
\
Teks besar yang digarisbawahi\wh
\r=
\-

Menggunakan banyak warna dalam satu garis\h#

Anda dapat menggunakan beberapa warna pada satu garis dengan memisahkan bagian
berwarna dengan karakter¤ ¤¤ ¤(yang dapat Anda ketik menggunakan tombol ¤Insert¤),\nYnw
dan mengurutkan kode warna setelah¤ \¤. Jika warna terakhir pada baris adalah warna\nC
default (n), tidak perlu mencantumkannya di akhir. Jika Anda ingin menggunakan
karakter¤ ¤¤ ¤pada baris yang menggunakan¤ \¤, tulis¤ ¤¤¤¤ ¤sebagai gantinya. Untuk\nYnCnY
alasan teknis, ti¤d§¤ak mungkin mewarnai satu karakter dengan melampirkannya dalam\nR(
dua ¤ ¤¤ ¤, kecuali jika Anda juga menyertakan spasi atau karakter lain.\nY

\-
Anda dapat ¤¤mewarnai¤¤ kata-kata¤¤ tertentu dengan ini!\nrv\
\
Anda dapat ¤mewarnai¤ kata-kata¤ tertentu dengan ini!\nrv
\-
Beb¤¤era¤¤pa ¤¤war¤¤na te¤¤ks\RYGCBP\
\
Beb¤era¤pa ¤war¤na te¤ks\RYGCBP
\-

Mewarnai satu karakter\h#

Oke, saya berbohong, dimungkinkan untuk mewarnai satu karakter tanpa menyertakan
spasi.
Untuk melakukannya, letakkan karakter¤ § ¤(yang dapat Anda ketik menggunakan\nY
Shift+Insert¤), setelah karakter yang ingin Anda warnai, dan aktifkan dengan kode\w
pemformatan¤ ( ¤setelah¤ \¤:\nCnC

\-
Anda dapat mew¤¤a§¤¤rnai ¤¤satu¤¤ karakter seperti ini!\nrny(\
\
Anda dapat mew¤a§¤rnai ¤satu¤ karakter seperti ini!\nrny(
\-

Ini tidak diperlukan jika karakter tunggal adalah yang pertama atau terakhir pada
sebuah baris.

Warna latar belakang\h#

Teks tidak hanya dapat diwarnai, tetapi juga dapat ¤disorot¤ dalam salah satu warna\nZ&y
teks. Untuk melakukannya, Anda dapat meletakkan¤ & ¤setelah kode warna teks biasa,\nY
lalu kode warna untuk warna latar belakang. Ini dapat dilakukan dalam kombinasi
dengan sistem ¤ yang dijelaskan di atas, perhatikan bahwa warna teks biasa
memulai "blok" berikutnya, tetapi warna latar tidak. Contoh berikut menggunakan
spasi untuk membuat semuanya lebih mudah dibaca, tetapi ini sepenuhnya opsional.
Anda dapat menggunakan kode¤ + ¤untuk memperluas warna latar belakang (terakhir) ke\nY
akhir baris.

\-
Teks hitam dengan latar belakang putih!\z&w\
\
Teks hitam dengan latar belakang putih!\z&w
\-
Teks hitam pada latar belakang putih yang diperluas!\z&w+\
\
Teks hitam pada latar belakang putih yang diperluas!\z&w+
\-
Merah di atas kuning¤¤, ¤Hitam di atas putih¤¤ (spasi opsional meningkatkan\r&y n z&w\
keterbacaan)
\
Merah di atas kuning¤, ¤Hitam di atas putih¤ (spasi opsional meningkatkan\r&y n z&w
keterbacaan)
\-
Ini masih ¤¤berfungsi¤¤ untuk mewarnai karakter tun¤¤g§¤¤gal\n P n n&r (\
\
Ini masih ¤berfungsi¤ untuk mewarnai karakter tun¤g§¤gal\n P n n&r (
\-

Jika Anda suka, Anda juga dapat membuat grafik menggunakan warna latar belakang:

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

Tautan\h#

Tautan dapat digunakan untuk dua hal: menautkan ke tempat lain di artikel/catatan,
atau menautkan ke situs web. Tautan menggunakan kode semi-warna¤ l¤. Kode ini\nY
tidak beralih ke "blok berwarna" berikutnya, itu hanya berlaku untuk yang
sekarang, sebagai lawan dari kode warna biasa (non-latar belakang). Itu juga tidak
berubah warna, sehingga Anda dapat mengubah gaya tautan ke apa pun yang Anda
inginkan.

Anda dapat menautkan ke artikel hanya dengan menggunakan nama artikel:

\-
Alat\bl\
\
Alat\bl
\-

Mengklik "Alat" di atas akan membawa Anda ke artikel bantuan Alat. Saya
menggunakan kode warna¤ b ¤di sini untuk membuat tautan menjadi biru, dan seperti\nb
yang Anda lihat,¤ l ¤berlaku untuk bagian berwarna yang sama.\nY

Anda dapat menautkan ke jangkar di artikel yang sama dengan menautkan ke¤ #\nY
diikuti oleh semua teks pada baris itu. (Contoh¤ ¤¤ ¤benar-benar diabaikan di sana.)\nY
Anda dapat menautkan ke bagian atas artikel hanya dengan karakter hash (¤#§¤).\nY(

\-
#Menggunakan banyak warna dalam satu garis\bl\
\
#Menggunakan banyak warna dalam satu garis\bl
\-

Anda dapat menautkan ke jangkar di artikel lain dengan cara yang sama:

\-
Daftar referensi#Gamestate\bl\
\
Daftar referensi#Gamestate\bl
\-

Menautkan ke situs web juga mudah:

\-
https://contoh.com/\bl\
\
https://contoh.com/\bl
\-

Anda dapat menggunakan blok warna dengan kode warna¤ L ¤yang berisi tujuan\nY
sebenarnya sebelum teks tautan, dan membuat tautan menampilkan teks yang berbeda
seperti itu:

\-
Alat¤¤Buka artikel lain\Lbl\
\
Alat¤Buka artikel lain\Lbl
\-
Klik ¤¤Alat¤¤di sini¤¤ untuk pergi ke artikel lain\nLbl\
\
Klik ¤Alat¤di sini¤ untuk pergi ke artikel lain\nLbl
\-
[¤¤#Tautan¤¤Suka¤¤] [¤¤#Contoh:¤¤Tidak suka¤¤]\n L vl n L rl\
\
[¤#Tautan¤Suka¤] [¤#Contoh:¤Tidak suka¤]\n L vl n L rl
\-
#Tautan¤¤ Tombol A ¤¤ §¤¤#Tautan¤¤ Tombol B \L w&Zl n L w&Z l(\
\
#Tautan¤ Tombol A ¤ §¤#Tautan¤ Tombol B \L w&Zl n L w&Z l(
\-

Gambar (hanya tersedia dalam\h#
\
deskripsi plugin):\h

0..9 - tampilkan gambar 0..9 pada baris ini (indeks array dalam array imgs dimulai
       dari 0, dan ingat untuk menjaga agar baris tetap kosong untuk mengakomodasi
       tinggi gambar)
^ - Letakkan ini sebelum nomor gambar, geser nomor gambar dengan 10. Jadi ^4
    membuat gambar 14, ^^4 membuat gambar 24. Dan 3^1^56 membuat gambar 3, 11, 25
    dan 26.
_ - Letakkan ini sebelum nomor gambar untuk mengurangi nomor gambar sebanyak 10.
> - Letakkan ini sebelum nomor gambar untuk menggeser gambar lebih jauh ke kanan
    sebesar 8 piksel. Ini dapat diulang, jadi 0>>>>1 menempatkan gambar 0 pada x=0
    dan gambar 1 pada x=32.
< - Sama, tapi bergeser ke kiri.
]]
},

{
splitid = "990_Credits",
subj = "Kredit",
imgs = {"images/credits.png"},
cont = [[
\0















Kredit\wh#
\C=

Ved dibuat oleh Dav999

Kontributor kode lebih lanjut: Info Teddy

Beberapa grafik dan font dibuat oleh Reese Rivers

Terjemahan Rusia: CreepiX, Cheep, Omegaplex
Terjemahan Esperanto: Reese Rivers
Terjemahan Jerman: r00ster
Terjemahan Perancis: RhenaudTheLukark
Terjemahan Spanyol: Valso22/naether
Terjemahan Indonesia: _march31onne/Marchionne Evangelisti


Terima kasih khusus kepada:\h#


Terry Cavanagh untuk membuat VVVVVV

Setiap orang yang melaporkan bug, muncul dengan ide dan memotivasi saya
untuk membuat ini!
\
\


Lisensi\h#
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

Aset VVVVVV\h#

Ved menyertakan beberapa aset grafis dari VVVVVV. VVVVVV dan asetnya adalah hak
cipta Terry Cavanagh. Untuk informasi lebih lanjut tentang lisensi yang berlaku
untuk VVVVVV dan asetnya, lihat ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/LICENSE.md¤LICENSE.md¤ dan ¤https://github.com/TerryCavanagh/VVVVVV/blob/master/License%20exceptions.md¤License exceptions.md¤ di dalam\nLClnLCl
repositori ¤https://github.com/TerryCavanagh/VVVVVV¤GitHub VVVVVV¤ https://github.com/TerryCavanagh/VVVVVV¤.\nLClLCl
]] -- NOTE: Do not translate the license!  Congratulations for reaching the end!
},

}
