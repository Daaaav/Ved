local self = {}

self.tilesets = {}

self.tilesets.SPACE_STATION = 0
self.tilesets.OUTSIDE = 1
self.tilesets.LAB = 2
self.tilesets.WARP_ZONE = 3
self.tilesets.SHIP = 4

self.tiletypes = {}

self.tiletypes.NONSOLID = 0
self.tiletypes.SOLID = 1
self.tiletypes.SPIKE = 2

function self:init()

	self.tileset = 0
	self.tilecol = 0

	self.tileset_colours = {}
	self.tileset_names = {}
	self.tileset_min_colour = {}
	self.tileset_max_colour = {}
	self.tileset_min_colour_direct = {}
	self.tileset_max_colour_direct = {}

	local basic = {
		121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121, 121,
		160, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80, 80,
		120, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121,
		121, 160, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80,
		80, 120, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121,
		121, 160, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80,
		80, 120, 121, 121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121,
		121, 160, 82, 82, 82, 82, 82, 82, 82, 0, 82, 82, 82, 82, 81, 81, 81, 42, 121,
		121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121, 121, 160, 121,
		121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80, 80, 120, 121,
		121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 121, 121, 121, 160, 121,
		121, 121, 121, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80, 80, 120, 121,
		162, 121, 162, 121, 162, 121, 161, 121, 162, 121, 162, 121, 162, 121, 161, 121,
		162, 121, 162, 121, 162, 121, 161, 121, 162, 121, 162, 80, 0, 121, 2, 121, 162,
		121, 162, 121, 162, 121, 161, 121, 162, 121, 162, 121, 162, 121, 161, 82, 122,
		82, 122, 82, 122, 82, 1, 82, 122, 82, 122, 81, 41, 81, 0
	}

	local lab_cyan = {
		121, 184, 121, 184, 24, 121, 24, 160, 121, 184, 121, 184, 24, 184, 24, 160,
		104, 144, 104, 144, 121, 121, 104, 145, 104, 144, 104, 144, 80, 185, 80, 120,
		121, 184, 121, 184, 24, 121, 24, 160, 121, 184, 121, 184, 24, 121, 24, 160,
		104, 144, 104, 144, 24, 121, 121, 145, 104, 144, 104, 144, 80, 185, 80, 120,
		26, 121, 26, 26, 25, 121, 25, 106, 26, 121, 26, 26, 25, 121, 25, 106, 121,
		121, 121, 121, 121, 121, 121, 160, 26, 121, 121, 26, 66, 80, 80, 120, 26, 184,
		26, 121, 25, 121, 25, 106, 26, 121, 26, 121, 25, 184, 25, 106, 82, 186, 82,
		186, 65, 82, 65, 0, 82, 82, 82, 82, 81, 199, 81, 42, 121, 184, 121, 184, 24,
		24, 24, 160, 121, 121, 121, 184, 24, 121, 24, 160, 104, 144, 104, 144, 121,
		121, 121, 160, 121, 121, 121, 121, 80, 80, 80, 120, 121, 184, 121, 184, 24,
		121, 121, 160, 121, 121, 121, 184, 121, 121, 24, 160, 121, 144, 121, 121, 121,
		24, 121, 160, 104, 121, 104, 144, 80, 80, 80, 120, 26, 162, 121, 162, 25, 105,
		25, 161, 121, 162, 121, 162, 25, 105, 25, 161, 104, 146, 121, 146, 121, 162,
		121, 64, 121, 121, 121, 162, 66, 0, 121, 2, 26, 162, 26, 162, 25, 162, 25, 161,
		26, 162, 26, 162, 25, 105, 25, 161, 82, 122, 82, 122, 65, 122, 82, 1, 82, 122,
		82, 122, 81, 41, 81, 0
	}

	local lab_red = {
		121, 190, 121, 190, 30, 121, 30, 160, 121, 190, 121, 190, 30, 190, 30, 160, 110,
		150, 110, 150, 121, 121, 110, 151, 110, 150, 110, 150, 80, 191, 80, 120, 121,
		190, 121, 190, 30, 121, 30, 160, 121, 190, 121, 190, 30, 121, 30, 160, 110, 150,
		110, 150, 30, 121, 121, 151, 110, 150, 110, 150, 80, 191, 80, 120, 32, 121, 32,
		32, 31, 121, 31, 112, 32, 121, 32, 32, 31, 121, 31, 112, 121, 121, 121, 121, 121,
		121, 121, 160, 32, 121, 121, 32, 72, 80, 80, 120, 32, 190, 32, 121, 31, 121, 31,
		112, 32, 121, 32, 121, 31, 190, 31, 112, 82, 192, 82, 192, 71, 82, 71, 0, 82, 82,
		82, 82, 81, 70, 81, 42, 121, 190, 121, 190, 30, 30, 30, 160, 121, 121, 121, 190,
		30, 121, 30, 160, 110, 150, 110, 150, 121, 121, 121, 160, 121, 121, 121, 121, 80,
		80, 80, 120, 121, 190, 121, 190, 30, 121, 121, 160, 121, 121, 121, 190, 121, 121,
		30, 160, 121, 150, 121, 121, 121, 30, 121, 160, 110, 121, 110, 150, 80, 80, 80,
		120, 32, 162, 121, 162, 31, 111, 31, 161, 121, 162, 121, 162, 31, 111, 31, 161,
		110, 152, 121, 152, 121, 162, 121, 76, 121, 121, 121, 162, 72, 0, 121, 2, 32, 162,
		32, 162, 31, 162, 31, 161, 32, 162, 32, 162, 31, 111, 31, 161, 82, 122, 82, 122,
		71, 156, 82, 1, 82, 122, 82, 122, 81, 41, 81, 0
	}

	local lab_pink = {
		121, 184, 121, 184, 24, 121, 24, 160, 121, 184, 121, 184, 24, 184, 24, 160, 104,
		144, 104, 144, 121, 121, 104, 145, 104, 144, 104, 144, 80, 185, 80, 120, 121,
		184, 121, 184, 24, 121, 24, 160, 121, 184, 121, 184, 24, 121, 24, 160, 104, 144,
		104, 144, 24, 121, 121, 145, 104, 144, 104, 144, 80, 185, 80, 120, 26, 121, 26,
		26, 25, 121, 25, 106, 26, 121, 26, 26, 25, 121, 25, 106, 121, 121, 121, 121, 121,
		121, 121, 160, 26, 121, 121, 26, 66, 80, 80, 120, 26, 184, 26, 121, 25, 121, 25,
		106, 26, 121, 26, 121, 25, 184, 25, 106, 82, 186, 82, 186, 65, 82, 65, 0, 82, 82,
		82, 82, 81, 64, 81, 42, 121, 184, 121, 184, 24, 24, 24, 160, 121, 121, 121, 184,
		24, 121, 24, 160, 104, 144, 104, 144, 121, 121, 121, 160, 121, 121, 121, 121, 80,
		80, 80, 120, 121, 184, 121, 184, 24, 121, 121, 160, 121, 121, 121, 184, 121, 121,
		24, 160, 121, 144, 121, 121, 121, 24, 121, 160, 104, 121, 104, 144, 80, 80, 80,
		120, 26, 162, 121, 162, 25, 105, 25, 161, 121, 162, 121, 162, 25, 105, 25, 161,
		104, 146, 121, 146, 121, 162, 121, 113, 121, 121, 121, 162, 66, 0, 121, 2, 26,
		162, 26, 162, 25, 162, 25, 161, 26, 162, 26, 162, 25, 105, 25, 161, 82, 122, 82,
		122, 65, 122, 82, 1, 82, 122, 82, 122, 81, 41, 81, 0
	}

	local lab_yellow = {
		121, 175, 121, 175, 15, 121, 15, 160, 121, 175, 121, 175, 15, 175, 15, 160, 95,
		135, 95, 135, 121, 121, 95, 136, 95, 135, 95, 135, 80, 176, 80, 120, 121, 175,
		121, 175, 15, 121, 15, 160, 121, 175, 121, 175, 15, 121, 15, 160, 95, 135, 95,
		135, 15, 121, 121, 136, 95, 135, 95, 135, 80, 176, 80, 120, 17, 121, 17, 17, 16,
		121, 16, 97, 17, 121, 17, 17, 16, 121, 16, 97, 121, 121, 121, 121, 121, 121, 121,
		160, 17, 121, 121, 17, 57, 80, 80, 120, 17, 175, 17, 121, 16, 121, 16, 97, 17,
		121, 17, 121, 16, 175, 16, 97, 82, 177, 82, 177, 56, 82, 56, 0, 82, 82, 82, 82,
		81, 55, 81, 42, 121, 175, 121, 175, 15, 15, 15, 160, 121, 121, 121, 175, 15, 121,
		15, 160, 95, 135, 95, 135, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80, 80,
		120, 121, 175, 121, 175, 15, 121, 121, 160, 121, 121, 121, 175, 121, 121, 15, 160,
		121, 135, 121, 121, 121, 15, 121, 160, 95, 121, 95, 135, 80, 80, 80, 120, 17, 162,
		121, 162, 16, 96, 16, 161, 121, 162, 121, 162, 16, 96, 16, 161, 95, 137, 121, 137,
		121, 162, 121, 27, 121, 121, 121, 162, 57, 0, 121, 2, 17, 162, 17, 162, 16, 162,
		16, 161, 17, 162, 17, 162, 16, 96, 16, 161, 82, 122, 82, 122, 56, 122, 82, 1, 82,
		122, 82, 122, 81, 41, 81, 0
	}

	local lab_green = {
		121, 181, 121, 181, 21, 121, 21, 160, 121, 181, 121, 181, 21, 181, 21, 160, 101,
		141, 101, 141, 121, 121, 101, 142, 101, 141, 101, 141, 80, 182, 80, 120, 121, 181,
		121, 181, 21, 121, 21, 160, 121, 181, 121, 181, 21, 121, 21, 160, 101, 141, 101,
		141, 21, 121, 121, 142, 101, 141, 101, 141, 80, 182, 80, 120, 23, 121, 23, 23, 22,
		121, 22, 103, 23, 121, 23, 23, 22, 121, 22, 103, 121, 121, 121, 121, 121, 121, 121,
		160, 23, 121, 121, 23, 63, 80, 80, 120, 23, 181, 23, 121, 22, 121, 25, 103, 23, 121,
		23, 121, 22, 181, 22, 103, 82, 183, 82, 183, 62, 82, 62, 0, 82, 82, 82, 82, 81, 61,
		81, 42, 121, 181, 121, 181, 21, 21, 21, 160, 121, 121, 121, 181, 21, 121, 21, 160,
		101, 141, 101, 141, 121, 121, 121, 160, 121, 121, 121, 121, 80, 80, 80, 120, 121,
		181, 121, 181, 21, 121, 121, 160, 121, 121, 121, 181, 121, 121, 21, 160, 121, 141,
		121, 121, 121, 21, 121, 160, 101, 121, 101, 141, 80, 80, 80, 120, 23, 162, 121, 162,
		22, 102, 22, 161, 121, 162, 121, 162, 22, 102, 22, 161, 101, 143, 121, 143, 121,
		162, 121, 161, 121, 121, 121, 162, 63, 0, 121, 2, 23, 162, 23, 162, 22, 162, 22,
		161, 23, 162, 23, 162, 22, 102, 22, 161, 82, 122, 82, 122, 62, 122, 82, 1, 82, 122,
		82, 122, 81, 41, 81, 0
	}

	local outside = {
		2, 0, 2, 0, 1, 2, 1, 2, 2, 0, 2, 2, 2, 2, 1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0,
		0, 2, 2, 2, 2, 2, 0, 2, 0, 1, 2, 1, 2, 2, 0, 2, 0, 1, 2, 1, 2, 0, 0, 2, 0, 2, 2,
		2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2,
		2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
		1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 1, 2, 1,
		2, 2, 0, 2, 0, 1, 2, 1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0,
		2, 0, 1, 2, 1, 2, 2, 0, 2, 0, 1, 2, 1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2,
		2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2,
		2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2,
		2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	}

	local none = {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}


	self:register_tileset(self.tilesets.SPACE_STATION, "Space Station")
	self:register_tileset(self.tilesets.OUTSIDE, "Outside")
	self:register_tileset(self.tilesets.LAB, "Lab")
	self:register_tileset(self.tilesets.WARP_ZONE, "Warp Zone")
	self:register_tileset(self.tilesets.SHIP, "Ship")

	self:register_tilecol(self.tilesets.SPACE_STATION, -1, basic, 80, basic, 680)
	self:register_tilecol(self.tilesets.SPACE_STATION, 0, basic, 83, basic, 680)
	self:register_tilecol(self.tilesets.SPACE_STATION, 1, basic, 86, basic, 698)
	self:register_tilecol(self.tilesets.SPACE_STATION, 2, basic, 89, basic, 695)
	self:register_tilecol(self.tilesets.SPACE_STATION, 3, basic, 92, basic, 683)
	self:register_tilecol(self.tilesets.SPACE_STATION, 4, basic, 95, basic, 689)
	self:register_tilecol(self.tilesets.SPACE_STATION, 5, basic, 98, basic, 680)
	self:register_tilecol(self.tilesets.SPACE_STATION, 6, basic, 101, basic, 695)
	self:register_tilecol(self.tilesets.SPACE_STATION, 7, basic, 104, basic, 704)
	self:register_tilecol(self.tilesets.SPACE_STATION, 8, basic, 107, basic, 689)
	self:register_tilecol(self.tilesets.SPACE_STATION, 9, basic, 110, basic, 686)
	self:register_tilecol(self.tilesets.SPACE_STATION, 10, basic, 113, basic, 698)

	self:register_tilecol(self.tilesets.SPACE_STATION, 11, basic, 283, basic, 695)
	self:register_tilecol(self.tilesets.SPACE_STATION, 12, basic, 286, basic, 686)
	self:register_tilecol(self.tilesets.SPACE_STATION, 13, basic, 289, basic, 704)
	self:register_tilecol(self.tilesets.SPACE_STATION, 14, basic, 292, basic, 701)
	self:register_tilecol(self.tilesets.SPACE_STATION, 15, basic, 295, basic, 698)
	self:register_tilecol(self.tilesets.SPACE_STATION, 16, basic, 298, basic, 683)
	self:register_tilecol(self.tilesets.SPACE_STATION, 17, basic, 301, basic, 704)
	self:register_tilecol(self.tilesets.SPACE_STATION, 18, basic, 304, basic, 701)
	self:register_tilecol(self.tilesets.SPACE_STATION, 19, basic, 307, basic, 698)
	self:register_tilecol(self.tilesets.SPACE_STATION, 20, basic, 310, basic, 692)
	self:register_tilecol(self.tilesets.SPACE_STATION, 21, basic, 313, basic, 686)

	self:register_tilecol(self.tilesets.SPACE_STATION, 22, basic, 483, basic, 695)
	self:register_tilecol(self.tilesets.SPACE_STATION, 23, basic, 486, basic, 683)
	self:register_tilecol(self.tilesets.SPACE_STATION, 24, basic, 489, basic, 689)
	self:register_tilecol(self.tilesets.SPACE_STATION, 25, basic, 492, basic, 704)
	self:register_tilecol(self.tilesets.SPACE_STATION, 26, basic, 495, basic, 680)
	self:register_tilecol(self.tilesets.SPACE_STATION, 27, basic, 498, basic, 695)
	self:register_tilecol(self.tilesets.SPACE_STATION, 28, basic, 501, basic, 689)
	self:register_tilecol(self.tilesets.SPACE_STATION, 29, basic, 504, basic, 692)
	self:register_tilecol(self.tilesets.SPACE_STATION, 30, basic, 507, basic, 689)
	self:register_tilecol(self.tilesets.SPACE_STATION, 31, basic, 510, basic, 698)

	self:register_tilecol(self.tilesets.OUTSIDE, 0, basic, 480, outside, 680)
	self:register_tilecol(self.tilesets.OUTSIDE, 1, basic, 483, outside, 683)
	self:register_tilecol(self.tilesets.OUTSIDE, 2, basic, 486, outside, 686)
	self:register_tilecol(self.tilesets.OUTSIDE, 3, basic, 489, outside, 689)
	self:register_tilecol(self.tilesets.OUTSIDE, 4, basic, 492, outside, 692)
	self:register_tilecol(self.tilesets.OUTSIDE, 5, basic, 495, outside, 695)
	self:register_tilecol(self.tilesets.OUTSIDE, 6, basic, 498, outside, 698)
	self:register_tilecol(self.tilesets.OUTSIDE, 7, basic, 501, outside, 701)

	self:register_tilecol(self.tilesets.LAB, 0, lab_cyan, 280, none, 0)
	self:register_tilecol(self.tilesets.LAB, 1, lab_red, 283, none, 0)
	self:register_tilecol(self.tilesets.LAB, 2, lab_pink, 286, none, 0)
	self:register_tilecol(self.tilesets.LAB, 3, basic, 289, none, 0)
	self:register_tilecol(self.tilesets.LAB, 4, lab_yellow, 292, none, 0)
	self:register_tilecol(self.tilesets.LAB, 5, lab_green, 295, none, 0)
	self:register_tilecol(self.tilesets.LAB, 6, none, 0, none, 0, true)

	self:register_tilecol(self.tilesets.WARP_ZONE, 0, basic, 80, none, 120)
	self:register_tilecol(self.tilesets.WARP_ZONE, 1, basic, 83, none, 123)
	self:register_tilecol(self.tilesets.WARP_ZONE, 2, basic, 86, none, 126)
	self:register_tilecol(self.tilesets.WARP_ZONE, 3, basic, 89, none, 129)
	self:register_tilecol(self.tilesets.WARP_ZONE, 4, basic, 92, none, 132)
	self:register_tilecol(self.tilesets.WARP_ZONE, 5, basic, 95, none, 135)
	self:register_tilecol(self.tilesets.WARP_ZONE, 6, basic, 98, none, 138)

	self:register_tilecol(self.tilesets.SHIP, 0, basic, 101, basic, 741)
	self:register_tilecol(self.tilesets.SHIP, 1, basic, 104, basic, 744)
	self:register_tilecol(self.tilesets.SHIP, 2, basic, 107, basic, 747)
	self:register_tilecol(self.tilesets.SHIP, 3, basic, 110, basic, 750)
	self:register_tilecol(self.tilesets.SHIP, 4, basic, 113, basic, 753)
	self:register_tilecol(self.tilesets.SHIP, 5, basic, 116, basic, 756)
end

function self:cache_data()
	self.tileset = self:get_tileset()
	self.tilecol = self:get_tilecol()
end

function self:register_tileset(id, name)
	self.tilesets[id] = name
end

function self:register_tilecol(tileset, index, foreground_type, foreground_base, background_type, background_base, direct)
	local info = {}
	info.foreground_type = foreground_type
	info.foreground_base = foreground_base
	info.background_type = background_type
	info.background_base = background_base
	info.direct_mode = (direct == true)

	self.tileset_colours[tileset] = self.tileset_colours[tileset] or {}
	self.tileset_colours[tileset][index] = info

	if not direct then
		self.tileset_min_colour[tileset] = math.min(self.tileset_min_colour[tileset] or 0, index)
		self.tileset_max_colour[tileset] = math.max(self.tileset_max_colour[tileset] or 0, index)
	end

	self.tileset_min_colour_direct[tileset] = math.min(self.tileset_min_colour_direct[tileset] or 0, index)
	self.tileset_max_colour_direct[tileset] = math.max(self.tileset_max_colour_direct[tileset] or 0, index)
end

function self:autotile(x, y)
	local tile = self:get_tile(x, y)
	local type = self:get_tile_type(tile)

	if tile == 0 then
		return 0
	end

	if type == self.tiletypes.SPIKE then
		local tile_up = self:get_tile_type(self:get_tile(x, y - 1)) == self.tiletypes.SOLID
		local tile_down = self:get_tile_type(self:get_tile(x, y + 1)) == self.tiletypes.SOLID
		local tile_left = self:get_tile_type(self:get_tile(x - 1, y)) == self.tiletypes.SOLID
		local tile_right = self:get_tile_type(self:get_tile(x + 1, y)) == self.tiletypes.SOLID

		if self.tileset == self.tilesets.LAB then
			-- If this is the lab, use the colourful lab spikes!

			if tile_down then return 63 + self.tilecol * 2 end
			if tile_up then return 64 + self.tilecol * 2 end
			if tile_left then return 51 + self.tilecol * 2 end
			if tile_right then return 52 + self.tilecol * 2 end
			return 63 + self.tilecol * 2
		end

		-- Not in the lab, so use the boring normal spikes
		if tile_down then return 8 end
		if tile_up then return 9 end
		if tile_left then return 49 end
		if tile_right then return 50 end
		return 8
	end

	local tile_up = self:autotile_connector(x, y - 1, type)
	local tile_down = self:autotile_connector(x, y + 1, type)
	local tile_left = self:autotile_connector(x - 1, y, type)
	local tile_right = self:autotile_connector(x + 1, y, type)

	local tile_up_left = self:autotile_connector(x - 1, y - 1, type)
	local tile_up_right = self:autotile_connector(x + 1, y - 1, type)
	local tile_down_left = self:autotile_connector(x - 1, y + 1, type)
	local tile_down_right = self:autotile_connector(x + 1, y + 1, type)

	local tile_value = 0

	if tile_up then tile_value = tile_value + 1 end
	if tile_up_right then tile_value = tile_value + 2 end
	if tile_right then tile_value = tile_value + 4 end
	if tile_down_right then tile_value = tile_value + 8 end
	if tile_down then tile_value = tile_value + 16 end
	if tile_down_left then tile_value = tile_value + 32 end
	if tile_left then tile_value = tile_value + 64 end
	if tile_up_left then tile_value = tile_value + 128 end

	local background = (type == self.tiletypes.NONSOLID or self:in_background(tile))

	local base = background and self.tileset_colours[self.tileset][self.tilecol].background_base or self.tileset_colours[self.tileset][self.tilecol].foreground_base

	return base + (background and self.tileset_colours[self.tileset][self.tilecol].background_type or self.tileset_colours[self.tileset][self.tilecol].foreground_type)[tile_value + 1]
end

function self:get_tile(x, y)
	return roomdata_get(roomx, roomy, x, y)
end

function self:get_tileset()
	return levelmetadata_get(roomx, roomy).tileset
end

function self:get_tilecol()
	return levelmetadata_get(roomx, roomy).tilecol
end

function self:get_tile_type(tile)
	local multi = self:is_multi_tileset_mode()

	if (tile == 1 or (tile >= 80 and tile <= 679)) then
		-- It's solid.
		if (multi and not self:in_tileset(tile)) then return self.tiletypes.NONSOLID end
		return self.tiletypes.SOLID
	end

	if ((tile >= 6 and tile <= 9) or tile == 49 or tile == 50) then
		-- It's a spike!
		return self.tiletypes.SPIKE
	end

	if (self.tileset ~= self.tilesets.SPACE_STATION) then
		-- tiles2.png is slightly different.

		if (tile >= 51 and tile <= 74) then
			-- It has more spikes!
			return self.tiletypes.SPIKE
		end

		if tile == 740 then
			-- And a stray solid.
			if (multi and not self:in_tileset(tile)) then return self.tiletypes.NONSOLID end
			return self.tiletypes.SOLID
		end
	end

	return self.tiletypes.NONSOLID
end

function self:autotile_connector(x, y, original_type)
	if (x < 0 or x >= 40 or y < 0 or y >= 30) then
		return true
	end

	local tile = self:get_tile(x, y)

	local new_type = self:get_tile_type(tile)

	if (tile == 0) then
		return false
	end

	if (new_type == self.tiletypes.SOLID and not self:in_background(tile)) then
		return true
	end

	return original_type == self.tiletypes.NONSOLID
end

function self:in_tileset(tile)
	if (tile == 1 or tile == 2) then return true end

	local info = self.tileset_colours[self.tileset][self.tilecol]

	local base = info.foreground_base

	for i = 1, #info.foreground_type do
		if base + info.foreground_type[i] == tile then
			return true
		end
	end

	base = info.background_base

	for i = 1, #info.background_type do
		if base + info.background_type[i] == tile then
			return true
		end
	end

	return false
end

function self:in_background(tile)
	if (tile == 2) then return true end

	local info = self.tileset_colours[self.tileset][self.tilecol]

	local base = info.background_base

	for i = 1, #info.background_type do
		if base + info.background_type[i] == tile then
			return true
		end
	end

	return false
end

function self:is_multi_tileset_mode()
	return levelmetadata_get(roomx, roomy).auto2mode == 1
end

return self