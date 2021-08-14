-- Dialog button constants
DB = {
	OK = 1,
	CANCEL = 2,
	YES = 3,
	NO = 4,
	APPLY = 5,
	QUIT = 6,
	DISCARD = 7,
	SAVE = 8,
	CLOSE = 9,
	LOAD = 10,
}

-- We'd also like that being indexable by the values...
DB_keys = {}
for k,v in pairs(DB) do
	DB_keys[v] = k
end

-- Dialog button set constants
DBS = {
	OK = {DB.OK},
	QUIT = {DB.QUIT},
	YESNO = {DB.YES, DB.NO},
	OKCANCEL = {DB.OK, DB.CANCEL},
	OKCANCELAPPLY = {DB.OK, DB.CANCEL, DB.APPLY},
	SAVEDISCARDCANCEL = {DB.SAVE, DB.DISCARD, DB.CANCEL},
	YESNOCANCEL = {DB.YES, DB.NO, DB.CANCEL},
	SAVECANCEL = {DB.SAVE, DB.CANCEL},
	LOADCANCEL = {DB.LOAD, DB.CANCEL},
}

-- Field type constants
DF = {
	TEXT = 0,
	DROPDOWN = 1,
	LABEL = 2,
	CHECKBOX = 3,
	RADIOS = 4,
	FILES = 5,
	HIDDEN = 6,
}

-- Field property constants
DFP = {
	KEY = 1,
	X = 2,
	Y = 3,
	W = 4,
	VALUE = 5,
	T = 6,
	TEXT_CONTENT_R = 7,
	DROPDOWN_MENUITEMS = 7,
	DROPDOWN_MENUITEMSLABEL = 8,
	DROPDOWN_ONCHANGE = 9,
	CHECKBOX_ONCHANGE = 7,
	FILES_MENUITEMS = 7,
	FILES_FOLDER_FILTER = 8,
	FILES_FOLDER_SHOW_HIDDEN = 9,
	FILES_LISTSCROLL = 10,
	FILES_FOLDER_ERROR = 11,
	FILES_LIST_HEIGHT = 12,
	FILES_FILTER_ON = 13,
}

-- Dialog class
cDialog =
{
	x = 16,
	y = 16,
	width = 400,
	height = 150,
	moving = false,
	moved_from_wx = 100,
	moved_from_wy = 100,
	moved_from_mx = 0,
	moved_from_my = 0,
	windowani = -11,
	closing = false,

	title = "",
	text = "UNDEFINED",

	buttons = DBS.OK,
	buttons_present = {}, -- buttons as keys
	handler = nil,
	noclosechecker = nil,
	identifier = nil,

	fields = {},
	currentfield = 0,

	return_btn = 0,

	showtabrect = false,
}

function cDialog:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	-- Which buttons do we have? That's useful for shortcuts.
	o.buttons_present = {}
	for k,v in pairs(o.buttons) do
		o.buttons_present[v] = true
	end

	o.x = (love.graphics.getWidth()-400)/2
	o.y = (love.graphics.getHeight()-150)/2

	-- Offset x and y based on length of dialogs stack
	local cascade_offset = #dialogs * 14
	o.x = math.min(o.x + cascade_offset, love.graphics.getWidth()-o.width)
	o.y = math.min(o.y + cascade_offset, love.graphics.getHeight()-o.height)

	if not s.dialoganimations then
		o.windowani = 0
	end

	return o
end

function cDialog:draw(topmost)
	local canvas
	if self.windowani >= 12 then
		return
	elseif self.windowani ~= 0 and love.graphics.isSupported("canvas") then
		local canvas_w, canvas_h = love.graphics.getWidth()*s.pscale, love.graphics.getHeight()*s.pscale

		-- It's still possible to break the limit in certain cases
		local texture_limit = love.graphics.getSystemLimit("texturesize")
		if canvas_w <= texture_limit and canvas_h <= texture_limit then
			canvas = love.graphics.newCanvas(canvas_size(canvas_w, canvas_h))
			love.graphics.setCanvas(canvas)
		end
	end

	-- Window contents
	self:setColor(192,192,192,239)
	love.graphics.rectangle("fill", self.x, self.y+self.windowani, self.width, self.height)
	-- Text
	self:setColor(0,0,0,255)
	love.graphics.setScissor(self.x, self.y+self.windowani, self.width, self.height)
	ved_printf(self.text, self.x+10, self.y+self.windowani+8, self.width-20, "left")
	love.graphics.setScissor()

	-- Text boxes
	local fieldactive = false
	local active_x, active_y, active_w, active_h, active_type, active_dropdowns, active_listheight
	for k,v in pairs(self.fields) do
		self:drawfield(topmost, k, unpack(v))
		if self.currentfield == k then
			fieldactive = true
			active_x = v[DFP.X]
			active_y = v[DFP.Y]
			active_w = v[DFP.W]
			active_type = v[DFP.T]
			-- FIXME now it gets weird. Why not active_field or something?
			active_dropdowns = v[DFP.DROPDOWN_MENUITEMS]
			active_listheight = v[DFP.FILES_LIST_HEIGHT]
		end
	end

	if fieldactive and topmost then
		active_x = self.x+10+active_x*8
		active_y = self.y+self.windowani+10+active_y*8 + 1
		if active_type == DF.RADIOS then
			local tmp = {}
			for k,v in pairs(active_dropdowns) do
				tmp[k] = #v
			end
			active_w = math.max(unpack(tmp)) + 2
			active_h = #active_dropdowns * 8
		elseif active_type == DF.FILES then
			active_h = active_listheight*8 + 8 + 4
		else
			active_h = 8
		end
		active_w = active_w*8

		if self.showtabrect then
			self:setColor(255,255,127,255,not topmost)
			love.graphics.rectangle("line", active_x-1, active_y-4, active_w+2, active_h+2)
		end

		if active_type == DF.CHECKBOX then
			showhotkey(" ", active_x+2, active_y, ALIGN.CENTER, topmost, self)
		elseif active_type == DF.FILES then
			showhotkey("d", active_x+12, active_y-6, ALIGN.RIGHT, topmost, self)
		end
	end

	-- Window border
	self:setColor(255,255,255,239)
	love.graphics.rectangle("line", self.x, self.y+self.windowani, self.width, self.height)

	-- Buttons
	local btnwidth = 72
	-- The Enter key can press different buttons depending on their priority
	-- and whether or not they are one of the buttons in this dialog
	-- Make sure we don't end up displaying it twice, if there happen to be
	-- multiple for whatever reason
	local returnalreadyshown = false
	for k,v in pairs(self.buttons) do
		local rapos = (#self.buttons)-k+1 -- right-aligned position
		local btn_x = self.x+self.width-rapos*btnwidth-(5*(rapos-1))-1
		local btn_y = self.y+self.windowani+self.height-26

		if topmost and mouseon(btn_x, btn_y, btnwidth, 25) and window_active() then
			-- Hovering over this button
			self:setColor(124, 124, 124, 128)

			if self.windowani == 0 and love.mouse.isDown("l") and not mousepressed then
				self:press_button(v)
				mousepressed = true
			end
		else
			-- Not hovering over this button
			self:setColor(64, 64, 64, 128)
		end

		-- Display the button itself.
		love.graphics.rectangle("fill", btn_x, btn_y, btnwidth, 25)
		self:setColor(0,0,0,255)

		local btn_text
		if type(v) == "number" and DB_keys[v] ~= nil then
			btn_text = L["BTN_" .. DB_keys[v]]
		else
			btn_text = v
		end
		local textyoffset = 8
		if font8:getWidth(btn_text) > btnwidth or btn_text:find("\n") ~= nil then
			textyoffset = 4
		end
		ved_printf(btn_text, btn_x, btn_y+textyoffset, btnwidth, "center")
		local args = {btn_x+btnwidth, btn_y-2, ALIGN.RIGHT, topmost, self}
		if topmost and not self.closing then
			-- For the Enter key, make sure to put the most prioritized buttons on the left,
			-- in the same order as in cDialog:keypressed()
			if DB_keys[v] == "SAVE" and #self.fields == 0 then
				showhotkey("S", unpack(args))
			elseif not returnalreadyshown and (DB_keys[v] == "OK" or DB_keys[v] == "CLOSE" or DB_keys[v] == "SAVE" or DB_keys[v] == "LOAD" or DB_keys[v] == "QUIT") then
				showhotkey("n", unpack(args))
				returnalreadyshown = true
			elseif DB_keys[v] == "CANCEL" then
				showhotkey("b", unpack(args))
			elseif DB_keys[v] == "YES" then
				showhotkey("Y", unpack(args))
			elseif DB_keys[v] == "NO" then
				showhotkey("N", unpack(args))
			elseif DB_keys[v] == "DISCARD" then
				showhotkey("D", unpack(args))
			end
		end
	end

	-- Bar
	self:setColor(64,64,64,128, not topmost)
	love.graphics.rectangle("fill", self.x-1, self.y+self.windowani-17, self.width+2, 16)

	-- Also display the title text (if not empty). Shadow first
	self:setColor(0,0,0,255, not topmost)
	ved_print(self.title, self.x+4, self.y+self.windowani-12)
	self:setColor(255,255,255,255, not topmost)
	ved_print(self.title, self.x+3, self.y+self.windowani-13)

	if canvas ~= nil then
		love.graphics.setCanvas()
		if math.floor(self.windowani) < 0 then
			love.graphics.setColor(255, 255, 255, ((math.floor(self.windowani)+11)/11)*255)
		elseif math.floor(self.windowani) == 0 then
			love.graphics.setColor(255, 255, 255, 255)
		else
			love.graphics.setColor(255, 255, 255, ((11-math.floor(self.windowani))/11)*255)
		end
		love.graphics.draw(canvas, 0, 0, 0, 1/s.pscale)
	end
end

function cDialog:update(dt, topmost)
	if self.moving then
		self.x = self.moved_from_wx + (love.mouse.getX()-self.moved_from_mx)
		self.y = self.moved_from_wy + (love.mouse.getY()-self.moved_from_my)
	end

	if not s.dialoganimations then
		return
	end

	-- Increase to max 0 if not closing, to max 16 if closing
	if not self.closing and self.windowani < 0 then
		self.windowani = math.min(self.windowani + dt*60, 0)
	elseif self.closing and self.windowani < 12 then
		self.windowani = math.min(self.windowani + dt*60, 12)
	end

	if self.windowani >= 12 and topmost then
		self:closed()
	end
end

function cDialog:mousepressed(x, y)
	-- Left mouse button pressed on the dialog
	self.showtabrect = false
	if self.closing then
		return
	end
	if x > self.x and x <= self.x+self.width and y >= self.y-17 and y <= self.y then
		-- Title bar
		self.moving = true
		self.moved_from_wx = self.x
		self.moved_from_wy = self.y
		self.moved_from_mx = x
		self.moved_from_my = y
	end
end

function cDialog:mousereleased(x, y)
	-- This is run for all dialogs, since a dialog may spawn while dragging another.
	if self.moving then
		self.x = self.moved_from_wx + (x-self.moved_from_mx)
		self.y = self.moved_from_wy + (y-self.moved_from_my)
		self.moving = false
	end
end

function cDialog:keypressed(key)
	-- Key pressed that might be of interest
	if self.closing then
		return
	end
	if table.contains({"return", "kpenter"}, key) then
		returnpressed = true
		if self.buttons_present[DB.OK] then
			self:press_button(DB.OK)
		elseif self.buttons_present[DB.CLOSE] then
			self:press_button(DB.CLOSE)
		elseif self.buttons_present[DB.SAVE] then
			self:press_button(DB.SAVE)
		elseif self.buttons_present[DB.LOAD] then
			self:press_button(DB.LOAD)
		elseif self.buttons_present[DB.QUIT] then
			self:press_button(DB.QUIT)
		end
	elseif key == "escape" and self.buttons_present[DB.CANCEL] then
		self:press_button(DB.CANCEL)
	elseif key == "y" and self.buttons_present[DB.YES] then
		self:press_button(DB.YES)
	elseif key == "n" and self.buttons_present[DB.NO] then
		self:press_button(DB.NO)
	elseif key == "s" and self.buttons_present[DB.SAVE] and #self.fields == 0 then
		self:press_button(DB.SAVE)
	elseif key == "d" and self.buttons_present[DB.DISCARD] then
		self:press_button(DB.DISCARD)
	elseif table.contains({"home", "end"}, key) then
		handle_scrolling(true, key)
	end
end

function cDialog:dropdown_onchange(key, picked)
	if self.closing then
		return
	end

	for k,v in pairs(self.fields) do
		if v[DFP.KEY] == key then
			local new_value = nil
			if v[DFP.DROPDOWN_ONCHANGE] ~= nil then
				new_value = v[DFP.DROPDOWN_ONCHANGE](picked, v[DFP.DROPDOWN_MENUITEMS], v[DFP.DROPDOWN_MENUITEMSLABEL])
			end
			if new_value == nil then
				new_value = picked
			end

			v[DFP.VALUE] = new_value

			break
		end
	end
end

function cDialog:drawfield(topmost, n, key, x, y, w, content, mode, ...)
	if mode == nil then
		mode = DF.TEXT
	end

	if mode == DF.HIDDEN then
		-- Hidden fields are really hidden
		return
	end

	local content_r
	local menuitems, menuitemslabel, onchange
	local folder_filter, folder_show_hidden, listscroll, folder_error, list_height, filter_on
	if mode == DF.TEXT then
		content_r = ...
	elseif mode == DF.DROPDOWN or mode == DF.RADIOS then
		menuitems, menuitemslabel = ...
	elseif mode == DF.CHECKBOX then
		onchange = ...
	elseif mode == DF.FILES then
		menuitems, folder_filter, folder_show_hidden, listscroll, folder_error, list_height, filter_on = ...
	end

	local real_x = self.x+10+x*8
	local real_y = self.y+self.windowani+10+y*8 + 1
	local real_w = w*8

	if mode == DF.LABEL then
		-- This is only a label, don't do anything special.
		self:setColor(0,0,0,255)
		local textcontent
		if type(content) == "function" then
			textcontent = content(key, self:return_fields())
		else
			textcontent = content
		end
		ved_printf(anythingbutnil(textcontent), real_x, real_y-1-2, real_w, "left")
		self:setColor(255,255,255,255)
		return
	end

	local active = self.currentfield == n

	if mode == DF.TEXT or mode == DF.DROPDOWN then
		-- Text field or dropdown
		if topmost and (active or mouseon(real_x, real_y-3, real_w, 8)) and window_active() then
			self:setColor(255,255,255,255)
			love.graphics.rectangle("fill", real_x, real_y-3, real_w, 8)

			if (active and love.keyboard.isDown("tab"))
			or (mouseon(real_x, real_y-3, real_w, 8) and love.mouse.isDown("l") and not mousepressed) then
				if self.fields[self.currentfield] ~= nil and self.fields[self.currentfield][DFP.T] == DF.TEXT then
					self.fields[self.currentfield][DFP.VALUE] = anythingbutnil(self.fields[self.currentfield][DFP.VALUE]) .. anythingbutnil(self.fields[self.currentfield][DFP.TEXT_CONTENT_R])
					self.fields[self.currentfield][DFP.TEXT_CONTENT_R] = ""
				end
				self.currentfield = n

				if mode == DF.DROPDOWN and not RCMactive then
					rightclickmenu.create(menuitems, "dia_" .. key, real_x, (real_y-3)+8, true) -- y+h

					if love.mouse.isDown("l") then
						mousepressed = true
					end
				end
			end
		else
			self:setColor(255,255,255,192)
			love.graphics.rectangle("fill", real_x, real_y-3, real_w, 8)
		end

		self:setColor(0,0,0,255)

		if mode == DF.TEXT then
			love.graphics.setScissor(real_x, real_y-3, real_w, 8)
			if active then
				ved_print(
					anythingbutnil(content) .. __ .. anythingbutnil(allbutfirstUTF8(content_r)),
					math.min(real_x, real_x+real_w-font8:getWidth(anythingbutnil(content) .. "_")),
					real_y-3
				)
			else
				ved_print(anythingbutnil(content) .. anythingbutnil(content_r), real_x, real_y-3)
			end
			love.graphics.setScissor()
		elseif mode == DF.DROPDOWN then
			if not menuitemslabel then
				ved_print(anythingbutnil(content), real_x, real_y-3)
			else
				ved_print(anythingbutnil(menuitemslabel[content]), real_x, real_y-3)
			end
			love.graphics.draw(image.dropdownarrow, real_x+real_w-8, (real_y-3)+2)
		end
	elseif mode == DF.CHECKBOX then
		-- Checkbox
		self:hoverdraw(topmost, content and image.checkon or image.checkoff, real_x, real_y-3, real_w, 8)

		if (mouseon(real_x, real_y-3, real_w, 8) and love.mouse.isDown("l") and not mousepressed) then
			self.currentfield = n

			self.fields[n][DFP.VALUE] = not content
			mousepressed = true

			if onchange ~= nil then
				onchange(not content, self)
			end
		end
	elseif mode == DF.RADIOS then
		for k,v in pairs(menuitems) do
			local selected
			if not menuitemslabel then
				selected = v == content
			else
				selected = v == menuitemslabel[content]
			end
			real_w = 16+font8:getWidth(v)
			self:hoverdraw(topmost, selected and image.radioon or image.radiooff, real_x, real_y-11+k*8, real_w, 8)
			self:setColor(0,0,0,255)
			ved_print(v, real_x+16, real_y-10+k*8)
			self:setColor(255,255,255,255)

			if (mouseon(real_x, real_y-11+k*8, real_w, 8) and love.mouse.isDown("l") and not mousepressed) and not RCMactive then
				self.currentfield = n

				dialogs[#dialogs]:dropdown_onchange(key, v)
				mousepressed = true
			end
		end
	elseif mode == DF.FILES then
		self:setColor(255,255,255,255)
		self:hoverdraw(topmost, image.folder_parent, real_x, real_y-3, 12, 12)
		if mouseon(real_x, real_y-3, 12, 12) and love.mouse.isDown("l") and not mousepressed then
			self.currentfield = n

			self:cd_to_parent(n, content, ...)
			mousepressed = true
		end
		self:setColor(0,0,0,255)
		local toppath
		if content == "" then
			toppath = get_root_dir_display()
		else
			toppath = displayable_filename(content)
		end
		love.graphics.setScissor(real_x+12, real_y-1, real_w-12, 8)
		ved_print(toppath, real_x+real_w-font8:getWidth(toppath), real_y-1)
		love.graphics.setScissor(real_x, real_y+9, real_w-16, 8*list_height)
		self:setColor(100,100,100,192)
		--self:setColor(160,160,160,192)
		--self:setColor(223,223,223,255)
		love.graphics.rectangle("fill", real_x, real_y+9, real_w-16, 8*list_height)
		self:setColor(0,0,0,255)
		for k,v in pairs(menuitems) do
			-- Only display this item if it will be visible
			if k*12+listscroll-4 <= 8+8*list_height and k*12+listscroll-4 >= 0 then
				local row_y = real_y+1+k*12+listscroll-4
				local selected = self:return_fields().name == v.name
				local moused = (mouseon(real_x, row_y, real_w-16, 12) and mouseon(real_x, real_y+9, real_w-16, 8*list_height) and window_active())
				if selected or moused then
					self:setColor(172,172,172,255)
					love.graphics.rectangle("fill", real_x, row_y, real_w-16, 12)
					self:setColor(0,0,0,255)
					if moused and love.mouse.isDown("l") and not mousepressed then
						self.currentfield = n

						if v.isdir then
							self:cd(v.name, n, content, ...)

							mousepressed = true
						else
							self:set_field("name", v.name)
						end
					end
				end
				if v.isdir then
					self:setColor(255,255,255,255)
					love.graphics.draw(image.smallfolder, real_x, row_y+2)
					if active and selected then
						showhotkey(" ", real_x+real_w-20, row_y-1, ALIGN.RIGHT, topmost, self)
					end
					self:setColor(0,0,0,255)
				end
				ved_print(displayable_filename(v.name), real_x+8, row_y+2)
			end
		end
		if folder_error ~= "" then
			self:setColor(192,0,0,255)
			ved_printf(folder_error, real_x, real_y+9, real_w-16, "left")
		end
		love.graphics.setScissor()

		-- Scrollbar
		local newfraction = scrollbar(
			real_x+real_w-16, real_y+9, 8*list_height, #menuitems*12,
			(-listscroll)/((#menuitems*12)-(8*list_height)),
			self
		)

		if newfraction ~= nil then
			self.fields[n][DFP.FILES_LISTSCROLL] = -(newfraction*((#menuitems*12)-(8*list_height)))
		end
	end

	self:setColor(255,255,255,255)
end

function cDialog:hoverdraw(topmost, img, x, y, w, h, s)
	if topmost and mouseon(x, y, w, h) and not RCMactive and window_active() then
		love.graphics.draw(img, x, y, 0, s)
	else
		self:setColor(255,255,255,128)
		love.graphics.draw(img, x, y, 0, s)
		self:setColor(255,255,255,255)
	end
end

function cDialog:press_button(button)
	if self.closing then
		return
	end
	RCMactive = false
	local notclosed = false
	if self.noclosechecker ~= nil then
		notclosed = self.noclosechecker(button, self:return_fields(), self.identifier, self)
	end
	if notclosed then
		if self.handler ~= nil then
			self.handler(button, self:return_fields(), self.identifier, notclosed, self)
		end
	else
		self:close(button)
	end
end

function cDialog:close(button)
	-- ONLY call this on the topmost dialog.
	-- Button is assumed to exist here, no questions asked.
	self.return_btn = button

	self.showtabrect = false
	self.closing = true

	if not s.dialoganimations then
		self:closed()
	end
end

function cDialog:closed()
	table.remove(dialogs)
	-- Call the close handler!
	if self.handler ~= nil then
		self.handler(self.return_btn, self:return_fields(), self.identifier, false, self)
	end
end

function cDialog:return_fields()
	local f = {}

	for k,v in pairs(self.fields) do
		if v[DFP.KEY] ~= "" then
			if anythingbutnil0(v[DFP.T]) == DF.TEXT then
				f[v[DFP.KEY]] = v[DFP.VALUE] .. anythingbutnil(v[DFP.TEXT_CONTENT_R])
			else
				f[v[DFP.KEY]] = v[DFP.VALUE]
			end
		end
	end

	return f
end

function cDialog:setColor(red, green, blue, alpha, nottopmost)
	if nottopmost then
		alpha = alpha / 2
	end

	love.graphics.setColor(red, green, blue, alpha)
end

function cDialog:set_field(key, value)
	for k,v in pairs(self.fields) do
		if v[DFP.KEY] == key then
			v[DFP.VALUE] = value
			break
		end
	end
end

function cDialog:get_on_scrollable_field(x, y, viakeyboard)
	-- If x,y is on a scrollable field,
	-- or the field is focused and input is made via keyboard,
	-- or input is made via keyboard and there's only one scrollable field,
	-- return that field's key, otherwise return nil.
	local scrollable_types = {DF.FILES}
	local scrollable_fields = {}
	for k,v in pairs(self.fields) do
		local v_x, v_y = self.x+10+v[DFP.X]*8, self.y+self.windowani+10+v[DFP.Y]*8+10
		if table.contains(scrollable_types, v[DFP.T]) then
			if (x >= v_x and x < v_x+v[DFP.W]*8
			and y >= v_y and y < v_y+8*v[DFP.FILES_LIST_HEIGHT])
			or (viakeyboard and self.fields[self.currentfield] == k) then
				if viakeyboard then
					self.showtabrect = true
				end
				return k
			else
				table.insert(scrollable_fields, k)
			end
		end
	end
	if viakeyboard and #scrollable_fields == 1 then
		self.showtabrect = true
		return scrollable_fields[DFP.KEY]
	end
	return nil
end

function cDialog:cd_to_parent(cf, currentdir, ...)
	self:cd(nil, cf, currentdir, ...)
end

function cDialog:cd(dir, cf, currentdir, ...)
	local menuitems, folder_filter, folder_show_hidden, listscroll, folder_error, list_height, filter_on = ...

	local newfolder
	if dir == nil then
		newfolder = get_parent_path(currentdir)
	else
		newfolder = get_child_path(currentdir, dir)
	end
	self.fields[cf][DFP.VALUE] = newfolder
	local success, everr
	success, self.fields[cf][DFP.FILES_MENUITEMS], everr = listfiles_generic(
		newfolder,
		filter_on and folder_filter or "",
		folder_show_hidden
	)
	if success then
		everr = ""
	end
	self.fields[cf][DFP.FILES_LISTSCROLL] = 0
	self.fields[cf][DFP.FILES_FOLDER_ERROR] = everr
end




dialogs = {}

dialog = {}

function dialog.draw()
	-- Now come the dialogs!
	for k,v in pairs(dialogs) do
		v:draw(k == #dialogs)
	end
end

function dialog.is_open()
	return #dialogs > 0
end

function dialog.update(dt)
	for k,v in pairs(dialogs) do
		v:update(dt, k == #dialogs)
	end
end

function dialog.create(message, buttons, handler, title, fields, noclosechecker, identifier)
	if fields ~= nil then
		fields = table.copy(fields)
	end

	RCMactive = false
	if tilespicker_shortcut then
		tilespicker = false
		tilespicker_shortcut = false
	end

	if special_cursor then
		love.mouse.setCursor()
		special_cursor = false
	end

	table.insert(dialogs,
		cDialog:new{
			text = message,
			buttons = buttons,
			handler = handler,
			title = title,
			fields = fields,
			noclosechecker = noclosechecker,
			identifier = identifier,
		}
	)
end

require("dialog_uses")
