-- maineditor/load

return function()
	tilespicker = false
	tilespicker_shortcut = false
	tilespicker_page = 0
	selectedtool = 1; selectedsubtool = {1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1, 1,1,1}
	selectedtile = 1
	selectedtileset = 0 --"spacestation" --"outside"
	selectedcolor = 0 --"c9" --"red"
	lefttoolscroll = 16 -- offset
	leftsubtoolscroll = 16
	zoomscale = 1 -- Or 1/2 or 1/4 or w/e
	dropdown = 0
	roomx = 0
	roomy = 0
	updatewindowicon()

	if levelmetadata ~= nil and levelmetadata_get(roomx, roomy) ~= nil then
		gotoroom_finish()
	end

	editingroomtext = 0
	newroomtext = false
	editingroomname = false
	movingentity = 0
	movingentity_copying = false
	upperoptpage2 = false
	warpid = nil
	oldscriptx, oldscripty, oldscriptp1, oldscriptp2 = 0, 0, 0, 0
	oldbounds = {0, 0, 0, 0}

	minsmear = -1; maxsmear = -1

	holdingzvx = false
	oldzxsubtool = 1

	undobuffer = {}
	redobuffer = {}
	undosaved = 0
	unsavedchanges = false
	saved_at_undo = 0

	editingbounds = 0
	showepbounds = true

	mouselockx = -1
	mouselocky = -1

	warpbganimation = 0

	customsizemode = 1 -- 0: using, 1: changing size (or needing to click first tile in tiles picker, 2: needing to click second tile in tiles picker), 3: needing to click top left in a room because I misunderstood the request all along, 4: needing to click bottom right of that.
	customsizex = 0 -- tiles to the left AND right of the cursor (can be a half)
	customsizey = 0 -- tiles to the top AND bottom of the cursor
	customsizetile = nil -- what group of tiles to draw with this special cursor (2D table)
	customsizecoorx = nil -- coordinates of tile selected in mode 3
	customsizecoory = nil

	keyboardmode = false
end
