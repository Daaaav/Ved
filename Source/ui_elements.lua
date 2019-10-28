-- One element class could have multiple public constructors!
-- Like, a generic "list" or "container" class with tons of spacing attributes,
-- and then different "public" constructors for different kinds of lists.
-- (like, a standard container for the right pane)

-- Element classes may implement all the regular functions that you can see in uis/map too.
-- TODO: think of a "reset/init this element's state" method that can be implemented.

-- All elements must have:
-- - px and py attributes for the previous/last coordinates.
--   These are screen coordinates, could be used for onclick functions for example.
--   They are always set by the drawing function, and may change!
-- - pw and ph attributes, which indicate the last width and height as seen from px and py.
--   They may or may not change dynamically.
--   These attributes may be nil if not deemed relevant, or to indicate infinity.
-- - A draw function. This can be given a dynamic x and y and a (remaining) parent container w and h,
--   and may return the true width and height.
--   It may also return nil if width and height are not deemed relevant, but containers may rely on them.
--   The max width and height that are given to the draw function are rules meant to be broken...
--   Meaning the draw function definitely does not have to adhere to it.

-- Generic drawing function
elDrawingFunction =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	func = nil,
}

function elDrawingFunction:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function DrawingFunction(func)
	return elDrawingFunction:new{
		func = func,
	}
end

function elDrawingFunction:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	-- The drawing function may return the actual width and height, or nil.
	-- Though, it must return those if it's in a container that expects width and height.
	self.pw, self.ph = self.func(x, y, maxw, maxh)
	return self.pw, self.ph
end


-- Container that puts a sub-element at completely custom coordinates.
-- TODO maybe name this FloatContainer and change fX arguments to cX?
elFloat =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	fx = 0, fy = 0,
	fw = nil, fh = nil,
	el = nil
}

function elFloat:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Float(el, x, y, maxw, maxh)
	return elFloat:new{
		fx = x, fy = y,
		fw = maxw, fh = maxh,
		el = el
	}
end

function elFloat:draw(x, y, maxw, maxh)
	-- In this function, imagine you use it to add some padding within another container.
	-- Pretend, for that parent container, that the element just became larger.
	self.px, self.py = x+self.fx, y+self.fy
	maxw, maxh = maxw-x, maxh-y
	if self.fw ~= nil then
		maxw = math.min(maxw, self.fw)
	end
	if self.fh ~= nil then
		maxh = math.min(maxh, self.fh)
	end
	self.pw, self.ph = self.el:draw(self.px, self.py, maxw, maxh)
	if self.pw ~= nil and self.ph ~= nil then
		return self.pw+self.px, self.ph+self.py
	end
end

function elFloat:recurse(name, func, ...)
	-- XXX "draw" is special and won't be recursively called!

	func(self.el, ...)
	if self.el.recurse ~= nil then
		self.el:recurse(name, func, ...)
	end
end


-- Vertical list. Elements from the top are displayed at starty,
-- elements from the bottom are starty_bot pixels away from maxh given in the draw function.
-- If the maxh given to the draw function is infinite (nil), then bottom elements are not shown.
elListContainer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	cw = nil, ch = nil, -- container w/h. nil for maximum/fill parent
	calign = ALIGN.LEFT,
	cvalign = VALIGN.TOP,
	starty = 0,
	spacing = 0,
	starty_bot = 0,
	spacing_bot = 0,
	els_top = {},
	els_bot = {}
}

function elListContainer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function ListContainer(els_top, els_bot, cw, ch, calign, cvalign, starty, spacing, starty_bot, spacing_bot)
	if els_bot == nil then els_bot = {} end
	if calign == nil then calign = ALIGN.LEFT end
	if cvalign == nil then cvalign = VALIGN.TOP end
	if starty == nil then starty = 0 end
	if spacing == nil then spacing = 0 end
	if starty_bot == nil then starty_bot = starty end
	if spacing_bot == nil then spacing_bot = spacing end

	return elListContainer:new{
		cw = cw, ch = ch,
		calign = calign,
		cvalign = cvalign,
		starty = starty,
		spacing = spacing,
		starty_bot = starty_bot,
		spacing_bot = spacing_bot,
		els_top = els_top,
		els_bot = els_bot
	}
end

function RightBar(els_top, els_bot)
	return elListContainer:new{
		cw = 128, ch = nil,
		calign = ALIGN.RIGHT,
		cvalign = VALIGN.TOP,
		starty = 8,
		spacing = 8,
		starty_bot = 8,
		spacing_bot = 8,
		els_top = els_top,
		els_bot = els_bot
	}
end

function elListContainer:draw(x, y, maxw, maxh)
	local cw, ch = self.cw, self.ch
	if cw == nil then cw = maxw end
	if ch == nil then ch = maxh end
	self.pw, self.ph = cw, ch

	if self.calign == ALIGN.RIGHT then x = x + maxw - cw
	elseif self.calign == ALIGN.CENTER then x = x + (maxw - cw)/2
	end
	if self.cvalign == VALIGN.BOTTOM then y = y + maxh - ch
	elseif self.cvalign == VALIGN.CENTER then y = y + (maxh - ch)/2
	end
	self.px, self.py = x, y

	local cur_y = self.starty
	for k,v in pairs(self.els_top) do
		local el_pw, el_ph = anythingbutnil0(v.pw), anythingbutnil0(v.ph)
		local el_w, el_h = v:draw(x + (cw-el_pw)/2, y + cur_y, cw, ch-cur_y)

		cur_y = cur_y + el_h + self.spacing
	end
	local cur_y = maxh - self.starty_bot
	for k = #self.els_bot, 1, -1 do
		local v = self.els_bot[k]

		local el_pw, el_ph = anythingbutnil0(v.pw), anythingbutnil0(v.ph)
		local el_w, el_h = v:draw(x + (cw-el_pw)/2, y + cur_y - el_ph, cw, ch-cur_y)

		cur_y = cur_y - el_h - self.spacing
	end

	return self.pw, self.ph
end

function elListContainer:recurse(name, func, ...)
	for k,v in pairs(self.els_top) do
		func(v, ...)
		if v.recurse ~= nil then
			v:recurse(name, func, ...)
		end
	end
	for k,v in pairs(self.els_bot) do
		func(v, ...)
		if v.recurse ~= nil then
			v:recurse(name, func, ...)
		end
	end
end


elButton =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	label = nil, -- Not nil for a "LabelButton"
	image = nil, -- Not nil for an "ImageButton"
	imagescale = 1,
	action = nil,
	hotkey_text = nil,
	hotkey_func = nil,
	active_func = nil,
	yellow_func = nil,
	action_r = nil, -- Right click action, nil otherwise
	hotkey_r_func = nil,
}

function elButton:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function LabelButton(label, action, hotkey_text, hotkey_func, active_func, yellow_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = 128-16, ph = 16,
		label = label,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		active_func = active_func,
		yellow_func = yellow_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function ImageButton(image, scale, action, hotkey_text, hotkey_func, active_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = image:getWidth()*scale, ph = image:getHeight()*scale,
		image = image,
		imagescale = scale,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		active_func = active_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function InvisibleButton(w, h, action, hotkey_text, hotkey_func, active_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = w, ph = h,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		active_func = active_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function elButton:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	if self.active_func == nil or self.active_func() then
		if self.image ~= nil then
			hoverdraw(self.image, x, y, self.pw, self.ph, self.imagescale)
		elseif self.label ~= nil then
			local label = self.label

			-- Text too long to fit?
			local textyoffset = 4
			if (font8:getWidth(label) > 128-16 or label:find("\n") ~= nil) then
				textyoffset = 0
			end

			local r,g,b = 128,128,128
			if self.yellow_func ~= nil and self.yellow_func() then
				r,g,b = 160,160,0
			end
			hoverrectangle(r,g,b,128, x, y, 128-16, 16)
			ved_printf(label, x+1, y+textyoffset, 128-16, "center")
		end

		showhotkey(self.hotkey_text, x+self.pw-1, y-2, ALIGN.RIGHT)
	end

	return self.pw, self.ph
end

function elButton:keypressed(key)
	if self.active_func ~= nil and not self.active_func() then
		return
	end

	-- Maybe the hotkeys are like, X for left and shift+R for right. Simplify that a little.
	if self.hotkey_r_func ~= nil and self.action_r ~= nil and self.hotkey_r_func(key) then
		self.action_r()
	elseif self.hotkey_func ~= nil and self.action ~= nil and self.hotkey_func(key) then
		self.action()
	end
end

function elButton:mousepressed(x, y, button)
	if self.active_func ~= nil and not self.active_func() then
		return
	end

	-- This function is called when the mouse is within bounds.
	if button == "l" and self.action ~= nil then
		self.action()
	elseif button == "r" and self.action_r ~= nil then
		self.action_r()
	end
end
