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

	self.tileset_tile_cache = {}

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
		121, 184, 121, 184, 24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104,
		144, 104, 144, 80, 120, 80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 121, 184,
		121, 184, 24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104, 144, 104,
		144, 80, 120, 80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 26, 162, 26, 162, 25,
		161, 25, 106, 26, 162, 26, 162, 25, 161, 25, 106, 82, 122, 82, 186, 81, 0, 81, 0,
		82, 122, 82, 122, 66, 0, 66, 0, 26, 162, 26, 162, 25, 161, 25, 106, 26, 162, 26,
		162, 25, 161, 25, 106, 82, 186, 82, 186, 65, 0, 65, 0, 82, 186, 82, 186, 81, 199,
		81, 42, 121, 184, 121, 184, 24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160,
		104, 144, 104, 144, 80, 120, 80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 121, 184,
		121, 184, 24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104, 144, 104, 144,
		80, 120, 80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 26, 162, 26, 162, 25, 105, 25,
		161, 26, 162, 26, 162, 25, 105, 25, 161, 82, 146, 82, 146, 81, 0, 81, 64, 82, 146, 82,
		146, 66, 0, 66, 2, 26, 162, 26, 162, 25, 105, 25, 161, 26, 162, 26, 162, 25, 105, 25,
		161, 82, 122, 82, 122, 65, 0, 65, 1, 82, 122, 82, 122, 81, 41, 81, 0
	}

	local lab_red = {
		121, 190, 121, 190, 30, 160, 30, 160, 121, 190, 121, 190, 30, 160, 30, 160, 110, 150,
		110, 150, 80, 120, 80, 151, 110, 150, 110, 150, 80, 191, 80, 120, 121, 190, 121, 190,
		30, 160, 30, 160, 121, 190, 121, 190, 30, 160, 30, 160, 110, 150, 110, 150, 80, 120, 80,
		151, 110, 150, 110, 150, 80, 191, 80, 120, 32, 162, 32, 162, 31, 161, 31, 112, 32, 162,
		32, 162, 31, 161, 31, 112, 82, 122, 82, 122, 81, 0, 81, 0, 82, 122, 82, 122, 72, 0, 81,
		0, 32, 162, 32, 162, 31, 161, 31, 112, 32, 162, 32, 162, 31, 161, 31, 112, 82, 192, 82,
		192, 71, 0, 71, 0, 82, 192, 82, 192, 81, 70, 81, 42, 121, 190, 121, 190, 30, 160, 30,
		160, 121, 190, 121, 190, 30, 160, 30, 160, 110, 150, 110, 150, 80, 120, 80, 151, 110,
		150, 110, 150, 80, 191, 80, 120, 121, 190, 121, 190, 30, 160, 30, 160, 121, 190, 121,
		190, 30, 160, 30, 160, 110, 150, 110, 150, 80, 120, 121, 151, 110, 150, 110, 150, 80,
		191, 80, 120, 32, 162, 32, 162, 31, 111, 31, 161, 32, 162, 32, 162, 31, 111, 31, 161,
		82, 152, 82, 152, 81, 0, 81, 76, 82, 152, 82, 152, 72, 0, 72, 2, 32, 162, 32, 162, 31,
		111, 31, 161, 32, 162, 32, 162, 31, 111, 31, 161, 82, 122, 82, 122, 71, 156, 71, 1, 82,
		122, 82, 122, 81, 41, 81, 0
	}

	local lab_pink = {
		121, 184, 121, 184, 24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104, 144,
		104, 144, 80, 120, 80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 121, 184, 121, 184,
		24, 160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104, 144, 104, 144, 80, 120,
		80, 145, 104, 144, 104, 144, 80, 185, 80, 120, 26, 162, 26, 162, 25, 161, 25, 106, 26,
		162, 26, 162, 25, 161, 25, 106, 82, 144, 82, 122, 81, 0, 81, 0, 82, 122, 82, 122, 66,
		0, 66, 0, 26, 162, 26, 162, 25, 161, 25, 106, 26, 162, 26, 162, 25, 161, 25, 106, 82,
		186, 82, 186, 65, 0, 65, 0, 82, 122, 82, 122, 81, 64, 81, 42, 121, 184, 121, 184, 24,
		160, 24, 160, 121, 184, 121, 184, 24, 160, 24, 160, 104, 144, 104, 144, 80, 120, 80,
		145, 104, 144, 104, 144, 80, 185, 80, 120, 121, 184, 121, 184, 24, 160, 24, 160, 121,
		184, 121, 184, 24, 160, 24, 160, 104, 144, 104, 144, 80, 120, 80, 145, 104, 144, 104,
		144, 80, 185, 80, 120, 26, 162, 26, 162, 25, 105, 25, 161, 26, 162, 26, 162, 25, 105,
		25, 161, 82, 146, 82, 146, 81, 0, 81, 113, 82, 146, 82, 146, 66, 0, 66, 2, 26, 162,
		26, 162, 25, 105, 25, 161, 26, 162, 26, 162, 25, 105, 25, 161, 82, 122, 82, 122, 65,
		0, 65, 1, 82, 122, 82, 122, 81, 41, 81, 0
	}

	local lab_yellow = {
		121, 175, 121, 175, 15, 160, 15, 160, 121, 175, 121, 175, 15, 160, 15, 160, 95,
		135, 95, 135, 80, 120, 80, 136, 95, 135, 95, 135, 80, 176, 80, 120, 121, 175,
		121, 175, 15, 160, 15, 160, 121, 175, 121, 175, 15, 160, 15, 160, 95, 135, 95,
		135, 80, 120, 80, 136, 95, 135, 95, 135, 80, 176, 80, 120, 17, 162, 17, 162, 16,
		161, 16, 97, 17, 162, 17, 162, 16, 161, 16, 97, 82, 122, 82, 122, 81, 0, 81, 0,
		82, 122, 82, 122, 57, 0, 57, 0, 17, 162, 17, 162, 16, 161, 16, 97, 17, 162, 17,
		162, 16, 161, 16, 97, 82, 177, 82, 177, 56, 0, 56, 0, 82, 177, 82, 177, 81, 55,
		81, 42, 121, 175, 121, 175, 15, 160, 15, 160, 121, 175, 121, 175, 15, 160, 15,
		160, 95, 135, 95, 135, 80, 120, 80, 136, 95, 135, 95, 135, 80, 176, 80, 120, 121,
		175, 121, 175, 15, 160, 15, 160, 121, 175, 121, 175, 15, 160, 15, 160, 95, 135,
		95, 135, 80, 120, 80, 136, 95, 135, 95, 135, 80, 176, 80, 120, 17, 162, 17, 162,
		16, 96, 16, 161, 17, 162, 17, 162, 16, 96, 16, 161, 82, 137, 82, 137, 81, 0, 81,
		27, 82, 137, 82, 137, 57, 0, 57, 2, 17, 162, 17, 162, 16, 162, 16, 161, 17, 162,
		17, 162, 16, 96, 16, 161, 82, 122, 82, 122, 56, 0, 82, 1, 82, 122, 82, 122, 81,
		41, 81, 0
	}

	local lab_green = {
		121, 181, 121, 181, 21, 160, 21, 160, 121, 181, 121, 181, 21, 160, 21, 160, 101,
		141, 101, 141, 80, 120, 80, 142, 101, 141, 101, 141, 80, 182, 80, 120, 121, 181,
		121, 181, 21, 160, 21, 160, 121, 181, 121, 181, 21, 160, 21, 160, 101, 141, 101,
		141, 80, 120, 80, 142, 101, 141, 101, 141, 80, 182, 80, 120, 23, 162, 23, 162, 22,
		161, 22, 103, 23, 162, 23, 162, 22, 161, 22, 103, 82, 122, 82, 122, 81, 0, 81, 0,
		82, 122, 82, 122, 63, 0, 63, 0, 23, 162, 23, 162, 22, 161, 22, 103, 23, 162, 23,
		162, 22, 161, 22, 103, 82, 183, 82, 183, 62, 0, 62, 0, 82, 183, 82, 183, 81, 61,
		81, 42, 121, 181, 121, 181, 21, 160, 21, 160, 121, 181, 121, 181, 21, 160, 21,
		160, 101, 141, 101, 141, 80, 120, 80, 142, 101, 141, 101, 141, 80, 182, 80, 120,
		121, 181, 121, 181, 21, 160, 21, 160, 121, 181, 121, 181, 21, 160, 21, 160, 101,
		141, 101, 141, 80, 120, 80, 142, 101, 141, 101, 141, 80, 182, 80, 120, 23, 162,
		23, 162, 22, 102, 22, 161, 23, 162, 23, 162, 22, 102, 22, 161, 82, 143, 82, 143,
		81, 0, 81, 0, 82, 143, 82, 143, 63, 0, 63, 2, 23, 162, 23, 162, 22, 102, 22, 161,
		23, 162, 23, 162, 22, 102, 22, 161, 82, 122, 82, 122, 62, 0, 62, 1, 82, 122, 82,
		122, 81, 41, 81, 0
	}

	local outside = {
		2, 0, 2, 0, 1, 2, 1, 2, 2, 0, 2, 2, 1, 2, 1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0,
		0, 2, 2, 2, 2, 2, 0, 2, 0, 1, 2, 1, 2, 2, 0, 2, 0, 1, 2, 1, 2, 0, 0, 2, 0, 2, 2,
		2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2,
		2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
		1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 1, 2, 1,
		2, 2, 0, 2, 0, 1, 2, 1, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 2, 0,
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

	self:register_tilecol(self.tilesets.LAB, 0, lab_cyan, 280, none, 713)
	self:register_tilecol(self.tilesets.LAB, 1, lab_red, 283, none, 713)
	self:register_tilecol(self.tilesets.LAB, 2, lab_pink, 286, none, 713)
	self:register_tilecol(self.tilesets.LAB, 3, basic, 289, none, 713)
	self:register_tilecol(self.tilesets.LAB, 4, lab_yellow, 292, none, 713)
	self:register_tilecol(self.tilesets.LAB, 5, lab_green, 295, none, 713)
	self:register_tilecol(self.tilesets.LAB, 6, none, 0, none, 713, true)

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

function self:reset_tile_cache()
	-- Call this when reloading tilesets, once those become data-driven!
	self.tileset_tile_cache = {}
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

function self:make_autotiling_base()
	if levelmetadata_get(roomx, roomy).directmode == 1 or levelmetadata_get(roomx, roomy).auto2mode == 1 then
		return
	end

	for tile_y = 0, 29 do
		for tile_x = 0, 39 do
			local tile = self:get_tile(tile_x, tile_y)

			if (tile ~= 0) then
				local type = self:get_tile_type(tile)

				if type == self.tiletypes.NONSOLID then
					if (self:in_background(tile)) then
						roomdata_set(roomx, roomy, tile_x, tile_y, 2)
					end
				elseif type == self.tiletypes.SOLID and self:in_tileset(tile) then
					roomdata_set(roomx, roomy, tile_x, tile_y, 1)
				elseif type == self.tiletypes.SPIKE then
					roomdata_set(roomx, roomy, tile_x, tile_y, 6)
				end
			end
		end
	end
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
	if (x < 0 or x >= 40 or y < 0 or y >= 30) then
		return 0
	end

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

	self.tileset_tile_cache[self.tileset] = self.tileset_tile_cache[self.tileset] or {}
	self.tileset_tile_cache[self.tileset][self.tilecol] = self.tileset_tile_cache[self.tileset][self.tilecol] or {}

	if (self.tileset_tile_cache[self.tileset][self.tilecol][tile] or 0) > 0 then
		-- If it's not nil or 0, then it's in the tileset.
		return true
	elseif self.tileset_tile_cache[self.tileset][self.tilecol][tile] == 0 then
		return false
	end

	local info = self.tileset_colours[self.tileset][self.tilecol]

	local base = info.foreground_base

	for i = 1, #info.foreground_type do
		if base + info.foreground_type[i] == tile then
			self.tileset_tile_cache[self.tileset][self.tilecol][tile] = 1
			return true
		end
	end

	base = info.background_base

	for i = 1, #info.background_type do
		if base + info.background_type[i] == tile then
			self.tileset_tile_cache[self.tileset][self.tilecol][tile] = 2
			return true
		end
	end

	self.tileset_tile_cache[self.tileset][self.tilecol][tile] = 0

	return false
end

function self:in_background(tile)
	if (tile == 2) then return true end

	self.tileset_tile_cache[self.tileset] = self.tileset_tile_cache[self.tileset] or {}
	self.tileset_tile_cache[self.tileset][self.tilecol] = self.tileset_tile_cache[self.tileset][self.tilecol] or {}

	if self.tileset_tile_cache[self.tileset][self.tilecol][tile] == 2 then
		-- If it's 2 then it's a background in the tileset.
		return true
	elseif self.tileset_tile_cache[self.tileset][self.tilecol][tile] ~= nil then
		return false
	end

	local info = self.tileset_colours[self.tileset][self.tilecol]

	local base = info.background_base

	for i = 1, #info.background_type do
		if base + info.background_type[i] == tile then
			self.tileset_tile_cache[self.tileset][self.tilecol][tile] = 2
			return true
		end
	end

	self.tileset_tile_cache[self.tileset][self.tilecol][tile] = self.tileset_tile_cache[self.tileset][self.tilecol][tile] or -1

	return false
end

function self:is_multi_tileset_mode()
	return levelmetadata_get(roomx, roomy).auto2mode == 1
end

return self
