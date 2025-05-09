-- One element class could have multiple public constructors!
-- Like, a generic "list" or "container" class with tons of spacing attributes,
-- and then different "public" constructors for different kinds of lists.
-- (like, a standard container for the right pane)

-- Element classes may implement all the regular functions that you can see in uis/TEMPLATE too.
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

function elements_iter(elements, container)
	-- Iterate over a collection of elements, which could be
	-- either a simple table or an iterator function.
	-- NOTE: Make sure not to recreate UI elements every frame!
	-- Instead you might consider using a cached list of elements, and using
	-- the iterator to guard that the list is updated first, only when needed.
	if type(elements) == "function" then
		return elements(container)
	end
	return pairs(elements)
end

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
	return elDrawingFunction:new{func = func}
end

function elDrawingFunction:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	-- The drawing function may return the actual width and height, or nil.
	-- Though, it must return those if it's in a container that expects width and height.
	self.pw, self.ph = self.func(x, y, maxw, maxh)
	return self.pw, self.ph
end


-- Container that puts a sub-element at completely custom coordinates.
elFloatContainer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	fx = 0, fy = 0,
	cw = nil, ch = nil,
	el = nil
}

function elFloatContainer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function FloatContainer(el, fx, fy, maxw, maxh)
	return elFloatContainer:new{
		fx = fx, fy = fy,
		cw = maxw, ch = maxh,
		el = el
	}
end

function elFloatContainer:draw(x, y, maxw, maxh)
	-- In this function, imagine you use it to add some padding within another container.
	-- Pretend, for that parent container, that the element just became larger.
	self.px, self.py = x+self.fx, y+self.fy
	maxw, maxh = maxw-x, maxh-y
	if self.cw ~= nil then
		maxw = math.min(maxw, self.cw)
	end
	if self.ch ~= nil then
		maxh = math.min(maxh, self.ch)
	end
	self.pw, self.ph = self.el:draw(self.px, self.py, maxw, maxh)
	if self.pw ~= nil and self.ph ~= nil then
		return self.pw+self.px, self.ph+self.py
	end
end

function elFloatContainer:recurse(name, func, ...)
	-- XXX "draw" is special and won't be recursively called!

	func(self.el, ...)
	if self.el.recurse ~= nil then
		self.el:recurse(name, func, ...)
	end
end


-- Aligns its sub-element left/center/right and top/center/bottom depending on parent maxw and maxh
elAlignContainer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	calign = ALIGN.LEFT,
	cvalign = VALIGN.TOP,
	el = nil
}

function elAlignContainer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function AlignContainer(el, calign, cvalign)
	if calign == nil then calign = ALIGN.LEFT end
	if cvalign == nil then cvalign = VALIGN.TOP end

	return elAlignContainer:new{
		calign = calign,
		cvalign = cvalign,
		el = el
	}
end

function elAlignContainer:draw(x, y, maxw, maxh)
	local w, h = self.el.pw, self.el.ph
	if w == nil then w = maxw end
	if h == nil then h = maxh end

	if self.calign == ALIGN.RIGHT then x = x + maxw - w
	elseif self.calign == ALIGN.CENTER then x = x + (maxw - w)/2
	end
	if self.cvalign == VALIGN.BOTTOM then y = y + maxh - h
	elseif self.cvalign == VALIGN.CENTER then y = y + (maxh - h)/2
	end
	self.px, self.py = x, y

	w, h = self.el:draw(x, y, maxw-x, maxh-y)
	self.pw, self.ph = w, h

	return w, h
end

function elAlignContainer:recurse(name, func, ...)
	func(self.el, ...)
	if self.el.recurse ~= nil then
		self.el:recurse(name, func, ...)
	end
end


-- Simply holds more elements as though this is another root.
-- This has a static width and height, or nil to fill the remaining parent w/h.
elScreenContainer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	cw = nil, ch = nil,
	els = {}
}

function elScreenContainer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function ScreenContainer(els, cw, ch)
	return elScreenContainer:new{
		cw = cw, ch = ch,
		els = els
	}
end

function elScreenContainer:draw(x, y, maxw, maxh)
	self.px, self.py = x, y
	local cw, ch = self.cw, self.ch
	if cw == nil then cw = maxw end
	if ch == nil then ch = maxh end
	self.pw, self.ph = cw, ch

	for k,v in elements_iter(self.els, self) do
		v:draw(x, y, maxw, maxh)
	end

	return self.pw, self.ph
end

function elScreenContainer:recurse(name, func, ...)
	for k,v in elements_iter(self.els, self) do
		func(v, ...)
		if v.recurse ~= nil then
			v:recurse(name, func, ...)
		end
	end
end


-- Vertical list (except if `horizontal`). Elements from the top are displayed at start,
-- elements from the bottom are start_bot pixels away from maxh given in the draw function.
-- If the maxh given to the draw function is infinite (nil), then bottom elements are not shown.
-- If horizontal is true, then it's a horizontal list, and top and bottom correspond to left and right.
elListContainer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	cw = nil, ch = nil, -- container w/h. nil for maximum/fill parent
	horizontal = false,
	align = ALIGN.CENTER,
	start = 0,
	spacing = 0,
	start_bot = 0,
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

function ListContainer(els_top, els_bot, cw, ch, align, starty, spacing, starty_bot, spacing_bot)
	if els_top == nil then els_top = {} end
	if els_bot == nil then els_bot = {} end
	if align == nil then align = ALIGN.CENTER end
	if starty == nil then starty = 0 end
	if spacing == nil then spacing = 0 end
	if starty_bot == nil then starty_bot = starty end
	if spacing_bot == nil then spacing_bot = spacing end

	return elListContainer:new{
		cw = cw, ch = ch,
		align = align,
		start = starty,
		spacing = spacing,
		start_bot = starty_bot,
		spacing_bot = spacing_bot,
		els_top = els_top,
		els_bot = els_bot
	}
end

function HorizontalListContainer(els_left, els_right, cw, ch, align, startx, spacing, startx_right, spacing_right)
	if els_left == nil then els_left = {} end
	if els_right == nil then els_right = {} end
	if align == nil then align = VALIGN.CENTER end
	if startx == nil then startx = 0 end
	if spacing == nil then spacing = 0 end
	if startx_right == nil then startx_right = startx end
	if spacing_right == nil then spacing_right = spacing end

	return elListContainer:new{
		cw = cw, ch = ch,
		horizontal = true,
		align = align,
		start = startx,
		spacing = spacing,
		start_bot = startx_right,
		spacing_bot = spacing_right,
		els_top = els_left,
		els_bot = els_right
	}
end

function SideBar(els_top, els_bot, align)
	return AlignContainer(
		elListContainer:new{
			cw = 128, ch = nil,
			start = 8,
			spacing = 8,
			start_bot = 8,
			spacing_bot = 8,
			els_top = els_top,
			els_bot = els_bot
		},
		align
	)
end

function RightBar(els_top, els_bot)
	return SideBar(els_top, els_bot, ALIGN.RIGHT)
end

function LeftBar(els_top, els_bot)
	return SideBar(els_top, els_bot, ALIGN.LEFT)
end

function elListContainer:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	local cw, ch = self.cw, self.ch
	if cw == nil then cw = maxw end
	if ch == nil then ch = maxh end
	local pw, ph = 0, 0

	local cur_x, cur_y
	if self.horizontal then
		cur_x = self.start
	else
		cur_y = self.start
	end
	for k,v in elements_iter(self.els_top, self) do
		local el_pw, el_ph = anythingbutnil0(v.pw), anythingbutnil0(v.ph)
		pw = pw + el_pw
		ph = ph + el_ph
		if self.horizontal then
			local el_y
			if self.align == VALIGN.TOP then
				el_y = y
			elseif self.align == VALIGN.BOTTOM then
				el_y = y + (ch-el_ph)
			else
				el_y = y + (ch-el_ph)/2
			end
			local el_w, el_h = v:draw(x + cur_x, el_y, cw-cur_x, ch)
			cur_x = cur_x + el_w + self.spacing
			pw = pw + self.spacing
		else
			local el_x
			if self.align == ALIGN.LEFT then
				el_x = x
			elseif self.align == ALIGN.RIGHT then
				el_x = x + (cw-el_pw)
			else
				el_x = x + (cw-el_pw)/2
			end
			local el_w, el_h = v:draw(el_x, y + cur_y, cw, ch-cur_y)
			cur_y = cur_y + el_h + self.spacing
			ph = ph + self.spacing
		end
	end
	if self.horizontal then
		cur_x = cw - self.start_bot
		pw = pw - self.spacing
	else
		cur_y = ch - self.start_bot
		ph = ph - self.spacing
	end
	for k = #self.els_bot, 1, -1 do
		local v = self.els_bot[k]

		local el_pw, el_ph = anythingbutnil0(v.pw), anythingbutnil0(v.ph)
		pw = pw + el_pw
		ph = ph + el_ph
		if self.horizontal then
			local el_w, el_h = v:draw(x + cur_x - el_pw, y + (ch-el_ph)/2, el_pw, ch)
			cur_x = cur_x - el_w + self.spacing
		else
			local el_w, el_h = v:draw(x + (cw-el_pw)/2, y + cur_y - el_ph, cw, el_ph)
			cur_y = cur_y - el_h - self.spacing
		end
	end

	if self.horizontal or #self.els_bot > 0 then
		-- In a horizontal container, always use container height.
		-- In a vertical container, only use container height if bottom elements exist,
		-- otherwise use added up height of elements.
		ph = ch
	end
	if not self.horizontal or #self.els_bot > 0 then
		-- In a vertical container, always use container width.
		-- In a horizontal container, only use container width if right elements exist,
		-- otherwise use added up width of elements.
		pw = cw
	end
	self.pw, self.ph = pw, ph
	return pw, ph
end

function elListContainer:recurse(name, func, ...)
	for k,v in elements_iter(self.els_top, self) do
		func(v, ...)
		if v.recurse ~= nil then
			v:recurse(name, func, ...)
		end
	end
	for k,v in elements_iter(self.els_bot, self) do
		func(v, ...)
		if v.recurse ~= nil then
			v:recurse(name, func, ...)
		end
	end
end


elSpacer =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
}

function elSpacer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Spacer(w, h)
	if w == nil then w = 0 end
	if h == nil then h = 0 end

	return elSpacer:new{pw = w, ph = h}
end

function LabelButtonSpacer()
	return elSpacer:new{pw = 128-16, ph = 16}
end

function elSpacer:draw(x, y, maxw, maxh)
	self.px, self.py = x, y
	return self.pw, self.ph
end


elButton =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	label = nil, -- Not nil for a "LabelButton"
	image = nil, -- Not nil for an "ImageButton"
	color_func = nil, -- Not nil for a "ColorButton"
	imagescale = 1,
	action = nil,
	hotkey_text = nil,
	hotkey_func = nil,
	status_func = nil, -- this function can return shown, enabled, yellow.
	action_r = nil, -- Right click action, nil otherwise
	hotkey_r_func = nil,
}

function elButton:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function LabelButton(label, action, hotkey_text, hotkey_func, status_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = 128-16, ph = 16,
		label = label,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		status_func = status_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function ImageButton(image, scale, action, hotkey_text, hotkey_func, status_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = image:getWidth()*scale, ph = image:getHeight()*scale,
		image = image,
		imagescale = scale,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		status_func = status_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function ColorButton(color_func, w, h, action, hotkey_text, hotkey_func, status_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = w, ph = h,
		color_func = color_func,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		status_func = status_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function InvisibleButton(w, h, action, hotkey_text, hotkey_func, status_func, action_r, hotkey_r_func)
	return elButton:new{
		pw = w, ph = h,
		action = action,
		hotkey_text = hotkey_text,
		hotkey_func = hotkey_func,
		status_func = status_func,
		action_r = action_r,
		hotkey_r_func = hotkey_r_func
	}
end

function elButton:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	local shown, enabled, yellow
	if self.status_func ~= nil then
		shown, enabled, yellow = self.status_func()
	end
	if shown == nil then shown = true end
	if enabled == nil then enabled = true end
	if yellow == nil then yellow = false end

	if shown then
		if self.image ~= nil then
			if not enabled then
				love.graphics.setColor(64,64,64)
				love.graphics.draw(self.image, x, y, 0, self.imagescale)
				love.graphics.setColor(255,255,255)
			else
				hoverdraw(self.image, x, y, self.pw, self.ph, self.imagescale)
			end
		elseif self.label ~= nil then
			local label
			if type(self.label) == "function" then
				label = self.label()
			else
				label = self.label
			end

			-- Text too long to fit?
			local textyoffset = 4
			if (font_ui:getWidth(label) > 128-16 or label:find("\n") ~= nil) then
				textyoffset = 0
			end

			local r,g,b = 128,128,128
			if yellow then
				r,g,b = 160,160,0
			end
			if not enabled then
				r,g,b = r/4, g/4, b/4

				love.graphics.setColor(r, g, b)
				love.graphics.rectangle("fill", x, y, 128-16, 16)
				love.graphics.setColor(64,64,64)
			else
				hoverrectangle(r,g,b,128, x, y, 128-16, 16)
			end
			font_ui:printf(label, x+1, y+textyoffset, 128-16, "center")
			love.graphics.setColor(255,255,255)
		elseif self.color_func ~= nil then
			local hovering = mouseon(x, y, self.pw, self.ph)
			if hovering then
				love.graphics.setColor(255,255,255)
			else
				love.graphics.setColor(224,224,224)
			end
			love.graphics.rectangle("fill", x, y, self.pw, self.ph)
			love.graphics.setColor(self.color_func())
			love.graphics.rectangle("fill", x+1, y+1, self.pw-2, self.ph-2)

			if hovering then
				love.graphics.setColor(255,255,255,96)
				love.graphics.rectangle("fill", x, y, self.pw, self.ph)
			end

			love.graphics.setColor(255,255,255)
		end

		if self.hotkey_text ~= nil then
			local hot_x, hot_y, hot_align, hot_text = x+self.pw-1, y-2, ALIGN.RIGHT
			if type(self.hotkey_text) == "table" then
				-- We may want to put the hotkey text somewhere different.
				hot_text = self.hotkey_text[1]
				hot_x = x+self.hotkey_text[2]
				hot_y = y+self.hotkey_text[3]
				hot_align = self.hotkey_text[4]
			else
				hot_text = self.hotkey_text
			end
			showhotkey(hot_text, hot_x, hot_y, hot_align)
		end
	end

	return self.pw, self.ph
end

function elButton:keypressed(key)
	if self.status_func ~= nil then
		local shown, enabled = self.status_func()

		if shown == false or enabled == false then
			return
		end
	end

	-- Maybe the hotkeys are like, X for left and shift+R for right. Simplify that a little.
	if self.hotkey_r_func ~= nil and self.action_r ~= nil and self.hotkey_r_func(key) then
		self.action_r()
	elseif self.hotkey_func ~= nil and self.action ~= nil and self.hotkey_func(key) then
		self.action()
	end
end

function elButton:mousepressed(x, y, button)
	if self.status_func ~= nil then
		local shown, enabled = self.status_func()

		if shown == false or enabled == false then
			return
		end
	end

	-- This function is called when the mouse is within bounds.
	if button == "l" and self.action ~= nil then
		self.action()
	elseif button == "r" and self.action_r ~= nil then
		self.action_r()
	end
end


function EditorIconBar()
	return HorizontalListContainer(
		{
			ImageButton(image.undobtn, 1, undo, {"cZ", 6, -4, ALIGN.CENTER}, hotkey("z", "ctrl"),
				function() return true, #undobuffer >= 1 end
			),
			ImageButton(image.redobtn, 1, redo, {"cY", 6, 8, ALIGN.CENTER}, hotkey("y", "ctrl"),
				function() return true, #redobuffer >= 1 end
			),
		},
		{
			ImageButton(image.cutbtn, 1, cutroom, {"cX", 6, -4, ALIGN.CENTER}, hotkey("x", "ctrl")),
			ImageButton(image.copybtn, 1, copyroom, {"cC", 6, 8, ALIGN.CENTER}, hotkey("c", "ctrl")),
			ImageButton(image.pastebtn, 1, pasteroom, {"cV", 6, -4, ALIGN.CENTER}, hotkey("v", "ctrl")),
		},
		16*7, 16
	)
end


-- Plain text (via font:print) or wrapped text (via font:printf)
-- text can be a string (for static text), or a function that returns a string (for dynamic text)
-- Shadowed text (via font:shadowprint and font:shadowprintf) not yet supported
elText =
{
	px = 0, py = 0,
	pw = 0, ph = 0,
	text = nil,
	wrapped = true,
	maxwidth = nil, -- nil to fill remaining parent width
	align = "left",
	font = nil,
	cjk_align = nil,
	sx = nil, sy = nil,
	color_func = nil
}

function elText:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Text(text, color_func, font, sx, sy)
	if font == nil then font = font_ui end
	local cjk_align = "cjk_low"

	return elText:new{
		text = text,
		wrapped = false,
		font = font,
		cjk_align = cjk_align,
		sx = sx, sy = sy,
		color_func = color_func
	}
end

function WrappedText(text, maxwidth, align, color_func, font, sx, sy)
	if align == nil then align = "left" end
	if font == nil then font = font_ui end
	local cjk_align = "cjk_low"

	return elText:new{
		text = text,
		wrapped = true,
		maxwidth = maxwidth,
		align = align,
		font = font,
		cjk_align = cjk_align,
		sx = sx, sy = sy,
		color_func = color_func
	}
end

function elText:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	if self.maxwidth ~= nil then
		maxw = self.maxwidth
	end

	local text
	if type(self.text) == "function" then
		text = self.text()
	else
		text = self.text
	end

	local color_set = false

	local r, g, b, a
	if self.color_func ~= nil then
		r, g, b, a = self.color_func()
	end

	if r ~= nil and g ~= nil and b ~= nil then
		love.graphics.setColor(r, g, b, a)
		color_set = true
	end

	if self.wrapped then
		self.font:printf(text, x, y, maxw, self.align, self.cjk_align, self.sx, self.sy)

		local width, lines = self.font:getWrap(text, maxw/(self.sx or 1))
		self.pw = width*(self.sx or 1)
		self.ph = lines*self.font:getHeight()*(self.sy or 1)
	else
		self.font:print(text, x, y, self.cjk_align, self.sx, self.sy)

		self.pw = self.font:getWidth(text)*(self.sx or 1)
		local _, newlines = text:gsub("\n", "")
		self.ph = (newlines+1)*self.font:getHeight()*(self.sy or 1)
	end

	if color_set then
		love.graphics.setColor(255,255,255,255)
	end

	return self.pw, self.ph
end


elColorPicker =
{
	px = 0, py = 0,
	pw = 160, ph = 298,
	get_color_func = nil,
	set_color_func = nil
}

function elColorPicker:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function ColorPicker(get_color_func, set_color_func)
	return elColorPicker:new{
		get_color_func = get_color_func,
		set_color_func = set_color_func
	}
end

function elColorPicker:draw(x, y, maxw, maxh)
	self.px, self.py = x, y

	local r, g, b = self.get_color_func()
	if r == nil or g == nil or b == nil then
		return self.pw, self.ph
	end

	for colb = 0, 255 do
		love.graphics.setColor(colb,0,0)
		love.graphics.rectangle("fill", x, y+294-colb, 50, 1)
		love.graphics.setColor(0,colb,0)
		love.graphics.rectangle("fill", x+55, y+294-colb, 50, 1)
		love.graphics.setColor(0,0,colb)
		love.graphics.rectangle("fill", x+110, y+294-colb, 50, 1)
	end

	-- A colored block at the top
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", x, y+12, 160, 16)
	love.graphics.setColor(r,g,b)
	love.graphics.rectangle("fill", x+1, y+13, 158, 14)

	-- The numbers
	love.graphics.setColor(255,255,255)
	font_8x8:printf(r, x, y+30, 50, "center")
	font_8x8:printf(g, x+55, y+30, 50, "center")
	font_8x8:printf(b, x+110, y+30, 50, "center")
	font_8x8:printf(
		string.format("#%02x%02x%02x", r, g, b),
		x, y,
		160, "center"
	)

	-- The arrows
	love.graphics.draw(image.colorsel, x-4, y+291-r)
	love.graphics.draw(image.colorsel, x+51, y+291-g)
	love.graphics.draw(image.colorsel, x+106, y+291-b)

	-- Are we clicking?
	if love.mouse.isDown("l") and nodialog and not mousepressed then
		local any = false
		if mouseon(x, y+36, 50, 262) then
			r = math.min(math.max(y+294-love.mouse.getY(), 0), 255)
			any = true
		elseif mouseon(x+55, y+36, 50, 262) then
			g = math.min(math.max(y+294-love.mouse.getY(), 0), 255)
			any = true
		elseif mouseon(x+110, y+36, 50, 262) then
			b = math.min(math.max(y+294-love.mouse.getY(), 0), 255)
			any = true
		end

		if any then
			self.set_color_func(r, g, b)
		end
	end

	return self.pw, self.ph
end
