toolshortcuts = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "R", "T", "Y", "U", "I", "O", "P"}

tilesetnames = {
	"tiles.png",
	"tiles2.png",
	"tiles3.png"
}

usedtilesets = {
	[0] = 1, -- space station
				-- 
	[1] = 2, -- outside
	[2] = 2, -- lab
	[3] = 2, -- warp zone
	[4] = 2, -- ship
				--
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
listmusicnamesids = {
	{"Pending Silence (" .. L.CAPNONE .. ")", 0}, -- Path Complete, but this is about custom levels where 0 is silence
	{"Pushing Onwards", 1},
	{"Positive Force", 2},
	{"Potential For Anything", 3},
	{"Passion For Exploring", 4},
	{"Pause", 5},
	{"Presenting VVVVVV", 6},
	{"Plenary", 7},
	{"Predestined Fate", 8},
	{"ecroF evitisoP", 9},
	{"Popular Potpourri", 10},
	{"Pipe Dream", 11},
	{"Pressure Cooker", 12},
	{"Paced Energy", 13},
	{"Piercing The Sky", 14},
	{"Predestined Fate remix", 15},
}

-- Just the names because right click menu
listmusicnames = {}
for k,v in pairs(listmusicnamesids) do
	table.insert(listmusicnames, v[1])
end

-- Internal VVVVVV IDs as keys
listmusicids = {}
for k,v in pairs(listmusicnamesids) do
	table.insert(listmusicids, v[2], v[1])
end

-- Ok well I guess we actually need Path Complete for music commands
listmusiccommandsnamesids = table.copy(listmusicnamesids)
listmusiccommandsnamesids[1] = {"Path Complete", 0}

listmusiccommandsids = {}
for _, v in pairs(listmusiccommandsnamesids) do
	table.insert(listmusiccommandsids, v[2], v[1])
end

-- Mappings from simplified `music` IDs to internal `play` IDs
musicsimplifiedtointernal = {
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

listsoundids = {
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

--entityidtotool = {9, }
entitytooltoid = {nil, nil, nil, 9, 10, 3, 2, 2, 1, 11, 17, 18, 19, 13, 50, 15, 16}

state_hotkeys = {
	--[1] = {
		--{"q", "}
	--},
}

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

-- Map exporting resolutions
map_resolutions = {
	{-1, L.MAPRES_ASSHOWN},
	{1/8, langkeys(L.MAPRES_RATIO, {1, 8, 40, 30})},
	{1/4, langkeys(L.MAPRES_PERCENT, {25, 80, 60})},
	{1/2, langkeys(L.MAPRES_PERCENT, {50, 160, 120})},
	{1, langkeys(L.MAPRES_PERCENT, {100, 320, 240})},
	{2, langkeys(L.MAPRES_PERCENT, {200, 640, 480})}
}

-- Make some dropdownable arrays from that.
map_resolutions_labels = {}
map_resolutions_numbertolabel = {}
map_resolutions_labeltonumber = {}
for k,v in pairs(map_resolutions) do
	table.insert(map_resolutions_labels, v[2])
	map_resolutions_numbertolabel[v[1]] = v[2]
	map_resolutions_labeltonumber[v[2]] = v[1]
end

limit_v = {
	mapwidth = 20,
	mapheight = 20,
	scripts = 500,
	scriptlines = 500,
	flags = 100,
	entities = 3000,
	trinkets = 100,
	crewmates = 100,
}

limit_vce = {
	mapwidth = 100,
	mapheight = 100,
	scripts = math.huge,
	scriptlines = math.huge,
	flags = 1000,
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
	["activateteleporter"] = 1,
	["activeteleporter"] = 1,
	["addvar"] = 2,
	["alarmoff"] = 1,
	["alarmon"] = 1,
	["altstates"] = 1,
	["analogue"] = 2,
	["automapimage"] = 2,
	["backgroundtext"] = 1,
	["befadein"] = 1,
	["befadeout"] = 2,
	["blackon"] = 1,
	["blackout"] = 1,
	["bluecontrol"] = 1,
	["changeai"] = 1,
	["changecolour"] = 1,
	["changecustommood"] = 1,
	["changedir"] = 1,
	["changegravity"] = 1,
	["changemood"] = 1,
	["changeplayercolour"] = 1,
	["changetile"] = 1,
	["clearteleportscript"] = 1,
	["coincounter"] = 2,
	["companion"] = 1,
	["createactivityzone"] = 1,
	["createcrewman"] = 1,
	["createdamage"] = 2,
	["createentity"] = 1,
	["createlastrescued"] = 1,
	["createrescuedcrew"] = 1,
	["createroomtext"] = 2,
	["createscriptbox"] = 2,
	["csay"] = 2,
	["csayquiet"] = 2,
	["customactivityzone"] = 2,
	["customifflag"] = 1,
	["customiftrinkets"] = 1,
	["customiftrinketsless"] = 1,
	["custommap"] = 1,
	["customposition"] = 1,
	["customquicksave"] = 2,
	["cutscene"] = 1,
	["cutscenefast"] = 2,
	["delay"] = 1,
	["delchar"] = 2,
	["destroy"] = 1,
	["do"] = 1,
	["drawimage"] = 2,
	["drawimagemasked"] = 2,
	["drawimagepersist"] = 2,
	["drawpixel"] = 2,
	["drawrect"] = 2,
	["drawtext"] = 2,
	["endcutscene"] = 1,
	["endcutscenefast"] = 2,
	["endtext"] = 1,
	["endtextfast"] = 1,
	["endtrial"] = 2,
	["entersecretlab"] = 1,
	["everybodysad"] = 1,
	["face"] = 1,
	["fadein"] = 1,
	["fadeout"] = 1,
	["fatal_bottom"] = 2,
	["fatal_left"] = 2,
	["fatal_right"] = 2,
	["fatal_top"] = 2,
	["finalmode"] = 1,
	["finalstretch"] = 2,
	["flag"] = 1,
	["flash"] = 1,
	["flip"] = 1,
	["flipgravity"] = 1,
	["flipme"] = 1,
	["fog"] = 2,
	["foundlab"] = 1,
	["foundlab2"] = 1,
	["foundtrinket"] = 1,
	["gamemode"] = 1,
	["gamestate"] = 1,
	["gamestatedelay"] = 2,
	["getentitydata"] = 2,
	["getvar"] = 2,
	["gotocheckpoint"] = 2,
	["gotodimension"] = 2,
	["gotoposition"] = 1,
	["gotoroom"] = 1,
	["greencontrol"] = 1,
	["hascontrol"] = 1,
	["hidecoordinates"] = 1,
	["hideplayer"] = 1,
	["hidesecretlab"] = 1,
	["hideship"] = 1,
	["hidetargets"] = 1,
	["hideteleporters"] = 1,
	["hidetrinkets"] = 1,
	["ifcoins"] = 2,
	["ifcoinsless"] = 2,
	["ifcrewlost"] = 1,
	["ifcrewmates"] = 2,
	["ifcrewmatesless"] = 2,
	["ifexplored"] = 1,
	["ifflag"] = 1,
	["ifflipmode"] = 2,
	["ifkey"] = 2,
	["iflast"] = 1,
	["ifmod"] = 2,
	["ifnotflag"] = 2,
	["ifrand"] = 2,
	["ifskip"] = 1,
	["iftrial"] = 2,
	["iftrinkets"] = 1,
	["iftrinketsless"] = 1,
	["ifvar"] = 2,
	["ifvce"] = 2,
	["ifwarp"] = 1,
	["inf"] = 2,
	["infiniflip"] = 2,
	["jukebox"] = 1,
	["killplayer"] = 2,
	["leavesecretlab"] = 1,
	["load"] = 2,
	["loadimage"] = 2,
	["loadscript"] = 1,
	["loop"] = 1,
	["mapimage"] = 2,
	["markers"] = 2,
	["markmap"] = 2,
	["missing"] = 1,
	["moveplayer"] = 1,
	["moveplayersafe"] = 2,
	["musicfadein"] = 1,
	["musicfadeout"] = 1,
	["niceplay"] = 2,
	["noautobars"] = 2,
	["nocontrol"] = 1,
	["pdelay"] = 2,
	["pinf"] = 2,
	["play"] = 1,
	["playef"] = 1,
	["playfile"] = 2,
	["position"] = 1,
	["puntilbars"] = 2,
	["puntilfade"] = 2,
	["puntilmusic"] = 2,
	["purplecontrol"] = 1,
	["randchoose"] = 2,
	["randrange"] = 2,
	["realign_tower"] = 2,
	["redcontrol"] = 1,
	["reloadactivityzones"] = 2,
	["reloadcustomactivityzones"] = 2,
	["reloadonetime"] = 2,
	["reloadroom"] = 2,
	["reloadscriptboxes"] = 2,
	["reloadterminalactivityzones"] = 2,
	["removeimage"] = 2,
	["replacetiles"] = 2,
	["replyquiet"] = 2,
	["rescued"] = 1,
	["resetgame"] = 1,
	["restoreplayercolour"] = 1,
	["resumemusic"] = 1,
	["return"] = 2,
	["rollcredits"] = 1,
	["sayquiet"] = 2,
	["setblendmode"] = 2,
	["setcallback"] = 2,
	["setcheckpoint"] = 1,
	["setentitydata"] = 2,
	["setinterrupt"] = 2,
	["setroomname"] = 2,
	["setspeed"] = 2,
	["settile"] = 2,
	["setvar"] = 2,
	["setvelocity"] = 2,
	["shake"] = 1,
	["showcoordinates"] = 1,
	["showplayer"] = 1,
	["showsecretlab"] = 1,
	["showship"] = 1,
	["showtargets"] = 1,
	["showteleporters"] = 1,
	["showtrinkets"] = 1,
	["speak"] = 1,
	["speak_active"] = 1,
	["speak_active_fast"] = 2,
	["speak_fast"] = 2,
	["specialline"] = 1,
	["squeak"] = 1,
	["startintermission2"] = 1,
	["stop"] = 2,
	["stopfile"] = 2,
	["stopmusic"] = 1,
	["suicide"] = 2,
	["supercrewmate"] = 2,
	["supercrewmateroom"] = 2,
	["teleportscript"] = 1,
	["telesave"] = 1,
	["text"] = 1,
	["textboxactive"] = 1,
	["textboxtimer"] = 2,
	["toceil"] = 2,
	["tofloor"] = 1,
	["toggleflip"] = 2,
	["togglepause"] = 2,
	["trinketbluecontrol"] = 1,
	["trinketscriptmusic"] = 1,
	["trinketyellowcontrol"] = 1,
	["undovvvvvvman"] = 1,
	["unloadscriptimages"] = 2,
	["unmarkmap"] = 2,
	["untilbars"] = 1,
	["untilfade"] = 1,
	["untilmusic"] = 2,
	["vvvvvvman"] = 1,
	["walk"] = 1,
	["warpdir"] = 1,
	["yellowcontrol"] = 1,
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
	gray = {174, 174, 174}
}

alttextboxcolors = {
	player = {19, 164, 255},
	cyan = {19, 164, 255},
	red = {19, 60, 60},
	yellow = {19, 255, 134},
	green = {19, 255, 144},
	blue = {19, 95, 255},
	purple = {19, 134, 255},
	gray = {19, 174, 174}
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

-- For playtesting
PLAYTESTING = {
	DONE = 1,
	ERROR = 2,
}

-- For map_correspondreset()
DIRTY = {
	ROW = 1,
	OUTROW29 = 2,
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
