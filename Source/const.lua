toolshortcuts = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "R", "T", "Y", "U", "I", "O", "P"}

tileset_names = {
	[0] = "tiles.png",  -- space station

	[1] = "tiles2.png", -- outside
	[2] = "tiles2.png", -- lab
	[3] = "tiles2.png", -- warp zone
	[4] = "tiles2.png", -- ship

	[5] = "tiles3.png", -- tower
}

usedtilesets = {
	[0] = 1, -- space station

	[1] = 2, -- outside
	[2] = 2, -- lab
	[3] = 2, -- warp zone
	[4] = 2, -- ship

	[5] = 3, -- tower
}

enemysprites = {
	[0] = 78,
	[1] = 88,
	[2] = 36,
	[3] = 164,
	[4] = 68,
	[5] = 48,
	[6] = 176,
	[7] = 168,
	[8] = 112,
	[9] = 114,
	[10] = 92,
	[11] = 40,
	[12] = 28,
	[13] = 32,
	[14] = 100,
	[15] = 52,
	[16] = 54,
	[17] = 51,
	[18] = 156,
	[19] = 44,
	[20] = 106,
	[21] = 82,
	[22] = 116,
	[23] = 64,
	[24] = 56,
}

enemyframes = {
	[0] = 4,
	[1] = 4,
	[2] = 4,
	[3] = 4,
	[4] = 4,
	[5] = 2,
	[6] = 4,
	[7] = 4,
	[8] = 2,
	[9] = 2,
	[10] = 4,
	[11] = 4,
	[12] = 4,
	[13] = 4,
	[14] = 4,
	[15] = 2,
	[16] = 1,
	[17] = 1,
	[18] = 4,
	[19] = 4,
	[20] = 2,
	[21] = 2,
	[22] = 4,
	[23] = 1,
	[24] = 1,
}

-- Some array with arrays of names+ids
list_music_names_ids = {
	{"Pending Silence (" .. L.CAPNONE .. ")", 0}, -- Path Complete, but this is about custom levels where 0 is silence
	{"Pushing Onwards", 1},
	{"Positive Force", 2},
	{"Potential for Anything", 3},
	{"Passion for Exploring", 4},
	{"Pause", 5},
	{"Presenting VVVVVV", 6},
	{"Plenary", 7},
	{"Predestined Fate", 8},
	{"ecroF evitisoP", 9},
	{"Popular Potpourri", 10},
	{"Pipe Dream", 11},
	{"Pressure Cooker", 12},
	{"Paced Energy", 13},
	{"Piercing the Sky", 14},
	{"Predestined Fate Remix", 15},
}

-- Just the names because right click menu
list_music_names = {}
for k,v in pairs(list_music_names_ids) do
	table.insert(list_music_names, v[1])
end

-- Internal VVVVVV IDs as keys
list_music_ids = {}
for k,v in pairs(list_music_names_ids) do
	table.insert(list_music_ids, v[2], v[1])
end

-- Ok well I guess we actually need Path Complete for music commands
list_music_commands_names_ids = table.copy(list_music_names_ids)
list_music_commands_names_ids[1] = {"Path Complete", 0}

list_music_commands_ids = {}
for _, v in pairs(list_music_commands_names_ids) do
	table.insert(list_music_commands_ids, v[2], v[1])
end

-- Mappings from simplified `music` IDs to internal `play` IDs
music_simplified_to_internal = {
	[0] = -1,
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 6,
	[6] = 8,
	[7] = 10,
	[8] = 11,
	[9] = 12,
	[10] = 13,
	[11] = 14,
}

list_sound_ids = {
	[0] = "jump.wav",
	"jump2.wav",
	"hurt.wav",
	"souleyeminijingle.wav",
	"coin.wav",
	"save.wav",
	"crumble.wav",
	"vanish.wav",
	"blip.wav",
	"preteleport.wav",
	"teleport.wav",
	"crew1.wav",
	"crew2.wav",
	"crew3.wav",
	"crew4.wav",
	"crew5.wav",
	"crew6.wav",
	"terminal.wav",
	"gamesaved.wav",
	"crashing.wav",
	"blip2.wav",
	"countdown.wav",
	"go.wav",
	"crash.wav",
	"combine.wav",
	"newrecord.wav",
	"trophy.wav",
	"rescue.wav",
}

list_graphics_files = {
	"covered.png",
	"elephant.png",
	"ending.png",
	"entcolours.png",
	"flipgamecomplete.png",
	"fliplevelcomplete.png",
	"flipsprites.png",
	"font.png",
	"fontmask.png",
	"gamecomplete.png",
	"levelcomplete.png",
	"minimap.png",
	"site.png",
	"site2.png",
	"site3.png",
	"site4.png",
	"sprites.png",
	"teleporter.png",
	"tiles.png",
	"tiles2.png",
	"tiles3.png",
}

entitytooltoid = {nil, nil, nil, 9, 10, 3, 2, 2, 1, 11, 17, 18, 19, 13, 50, 15, 16}

platform_labels = {
	[0] = " VV",
	[1] = " ^^",
	[2] = " <",
	[3] = "  >",
	[4] = " >I",
	[5] = ">>>>",
	[6] = "<<<<",
	[7] = ">>>>>>>>",
	[8] = "<<<<<<<<",
}

-- States in which the map is loaded at low priority
lowprio_maploading_states = {
	[3] = true,
	[10] = true,
	[11] = true,
	[19] = true,
	[28] = true,
}

limit_v = {
	mapwidth = 20,
	mapheight = 20,
	scripts = math.huge,
	flags = 100,
	entities = math.huge,
	trinkets = 100,
	crewmates = 100,
}


knowncommands = {
	say = true,
	reply = true,
	delay = true,
	happy = true,
	sad = true,
	flag = true,
	ifflag = true,
	iftrinkets = true,
	iftrinketsless = true,
	destroy = true,
	music = true,
	flash = true,

	map = true,
	squeak = true,
	speaker = true,
	playremix = true,
	warpdir = true,
	ifwarp = true,
}

knowninternalcommands = {
	["activateteleporter"] = true,
	["activeteleporter"] = true,
	["alarmoff"] = true,
	["alarmon"] = true,
	["altstates"] = true,
	["audiopause"] = true,
	["backgroundtext"] = true,
	["befadein"] = true,
	["blackon"] = true,
	["blackout"] = true,
	["bluecontrol"] = true,
	["changeai"] = true,
	["changecolour"] = true,
	["changecustommood"] = true,
	["changedir"] = true,
	["changegravity"] = true,
	["changemood"] = true,
	["changeplayercolour"] = true,
	["changerespawncolour"] = true,
	["changetile"] = true,
	["clearteleportscript"] = true,
	["companion"] = true,
	["createactivityzone"] = true,
	["createcrewman"] = true,
	["createentity"] = true,
	["createlastrescued"] = true,
	["createrescuedcrew"] = true,
	["customifflag"] = true,
	["customiftrinkets"] = true,
	["customiftrinketsless"] = true,
	["custommap"] = true,
	["customposition"] = true,
	["cutscene"] = true,
	["delay"] = true,
	["destroy"] = true,
	["do"] = true,
	["endcutscene"] = true,
	["endtext"] = true,
	["endtextfast"] = true,
	["entersecretlab"] = true,
	["everybodysad"] = true,
	["face"] = true,
	["fadein"] = true,
	["fadeout"] = true,
	["finalmode"] = true,
	["flag"] = true,
	["flash"] = true,
	["flip"] = true,
	["flipgravity"] = true,
	["flipme"] = true,
	["foundlab"] = true,
	["foundlab2"] = true,
	["foundtrinket"] = true,
	["gamemode"] = true,
	["gamestate"] = true,
	["gotoposition"] = true,
	["gotoroom"] = true,
	["greencontrol"] = true,
	["hascontrol"] = true,
	["hidecoordinates"] = true,
	["hideplayer"] = true,
	["hidesecretlab"] = true,
	["hideship"] = true,
	["hidetargets"] = true,
	["hideteleporters"] = true,
	["hidetrinkets"] = true,
	["ifcrewlost"] = true,
	["ifexplored"] = true,
	["ifflag"] = true,
	["iflast"] = true,
	["ifskip"] = true,
	["iftrinkets"] = true,
	["iftrinketsless"] = true,
	["ifwarp"] = true,
	["jukebox"] = true,
	["leavesecretlab"] = true,
	["loadscript"] = true,
	["loop"] = true,
	["missing"] = true,
	["moveplayer"] = true,
	["musicfadein"] = true,
	["musicfadeout"] = true,
	["nocontrol"] = true,
	["play"] = true,
	["playef"] = true,
	["position"] = true,
	["purplecontrol"] = true,
	["redcontrol"] = true,
	["rescued"] = true,
	["resetgame"] = true,
	["restoreplayercolour"] = true,
	["resumemusic"] = true,
	["rollcredits"] = true,
	["setcheckpoint"] = true,
	["shake"] = true,
	["showcoordinates"] = true,
	["showplayer"] = true,
	["showsecretlab"] = true,
	["showship"] = true,
	["showtargets"] = true,
	["showteleporters"] = true,
	["showtrinkets"] = true,
	["speak"] = true,
	["speak_active"] = true,
	["specialline"] = true,
	["squeak"] = true,
	["startintermission2"] = true,
	["stopmusic"] = true,
	["teleportscript"] = true,
	["telesave"] = true,
	["text"] = true,
	["textboxactive"] = true,
	["tofloor"] = true,
	["trinketbluecontrol"] = true,
	["trinketscriptmusic"] = true,
	["trinketyellowcontrol"] = true,
	["undovvvvvvman"] = true,
	["untilbars"] = true,
	["untilfade"] = true,
	["vvvvvvman"] = true,
	["walk"] = true,
	["warpdir"] = true,
	["yellowcontrol"] = true,
}

warpbgcolors = {
	{ {16, 34, 33}, {10, 16, 14} },
	{ {34, 16, 17}, {17, 9, 11} },
	{ {34, 16, 34}, {15, 10, 16} },
	{ {16, 16, 34}, {10, 11, 16} },
	{ {34, 30, 16}, {16, 13, 10} },
	{ {20, 34, 16}, {13, 16, 10} },
	{ {18, 18, 18}, {10, 10, 10} }
}

textboxcolors = {
	player = {164, 164, 255},
	cyan = {164, 164, 255},
	red = {255, 60, 60},
	yellow = {255, 255, 134},
	green = {144, 255, 144},
	blue = {95, 95, 255},
	purple = {255, 134, 255},
	white = {244, 244, 244},
	gray = {174, 174, 174},
	orange = {255, 130, 20}
}

alttextboxcolors = {
	player = {19, 164, 255},
	cyan = {19, 164, 255},
	red = {19, 60, 60},
	yellow = {19, 255, 134},
	green = {19, 255, 144},
	blue = {19, 95, 255},
	purple = {19, 134, 255},
	white = {19, 244, 244},
	gray = {19, 174, 174},
	orange = {19, 130, 20}
}

-- For showhotkey()
ALIGN = {
	LEFT = 1,
	CENTER = 2,
	RIGHT = 3,
}

VALIGN = {
	TOP = 1,
	CENTER = 2,
	BOTTOM = 3,
}

-- For shiftrooms()
SHIFT = {
	LEFT = 1,
	RIGHT = 2,
	UP = 3,
	DOWN = 4,
}

-- Final result from playtesting thread
PT_RESULT = {
	DONE = 1, -- thread finished with success result
	ERROR = 2, -- followed by the message. Thread finished with error result
}

-- Messages from main thread to playtesting thread
PT_CMD = {
	DATA_LEVEL = 1, -- followed by level XML
	DATA_POS = 2, -- followed by starting position table
	GO = 3, -- you have all the data now - make VVVVVV show its window!
	CANCEL = 4, -- stop VVVVVV if it's running and terminate (only possible in IDLE state)
}

-- Playtesting engine states
PT_ENGSTATE = {
	OFF = 0,
	IDLE = 1,
	PLAYTESTING = 2,
	CANCELING = 3,
}

PT_UISTATE = {
	OFF = 0,
	ASKING = 1,
	PLAYTESTING = 2,
}

-- For map_correspondreset()
DIRTY = {
	ROW = 1,
	PROPERTY = 3,
	ENTITY = 4,
}

-- For input
INPUT = {
	ONELINE = 1,
	MULTILINE = 2,
}

-- Also for input
UNRE = {
	INSERT = 1,
	DELETE = 2,
}

LOAD_SCRIPT_CREATION_MODE = {
	NO = 0,
	RUNONCE = 1,
	REPEATING = 2,
}
