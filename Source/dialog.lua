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
}

-- Dialog class
cDialog =
{
	x = (love.graphics.getWidth()-400)/2,
	y = (love.graphics.getHeight()-150)/2,
	width = 400,
	height = 150,
	moving = false,
	moved_from_wx = 100,
	moved_from_wy = 100,
	moved_from_mx = 0,
	moved_from_my = 0,
	windowani = -15,
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

	-- Offset x and y based on length of dialogs stack
	local cascade_offset = #dialogs * 14
	if DIAwindowani ~= 16 then
		-- Temporarily necessary while old dialogs still exist
		cascade_offset = cascade_offset + 14
	end
	o.x = math.min(o.x + cascade_offset, love.graphics.getWidth()-o.width)
	o.y = math.min(o.y + cascade_offset, love.graphics.getHeight()-o.height)

	if not s.dialoganimations then
		o.windowani = 0
	end

	return o
end

function cDialog:draw(topmost)
	if self.windowani >= 16 then
		return
	end

	-- Window contents
	self:setColor(192,192,192,239)
	love.graphics.rectangle("fill", self.x, self.y+self.windowani, self.width, self.height)
	-- Text
	self:setColor(0,0,0,255)
	love.graphics.setScissor(self.x, self.y+self.windowani, self.width, self.height)
	love.graphics.printf(self.text, self.x+10, self.y+self.windowani+10, self.width-20, "left")
	love.graphics.setScissor()

	-- Text boxes
	for k,v in pairs(self.fields) do
		self:drawfield(topmost, k, unpack(v))
	end

	-- Buttons
	local btnwidth = 72
	for k,v in pairs(self.buttons) do
		local rapos = (#self.buttons)-k+1 -- right-aligned position
		local btn_x = self.x+self.width-rapos*btnwidth-(5*(rapos-1))-1
		local btn_y = self.y+self.windowani+self.height-26

		if topmost and mouseon(btn_x, btn_y, btnwidth, 25) then
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
		love.graphics.printf(btn_text, btn_x, btn_y+10, btnwidth, "center")
	end

	-- Window border
	self:setColor(255,255,255,239)
	love.graphics.rectangle("line", self.x, self.y+self.windowani, self.width, self.height)
	-- Bar
	self:setColor(64,64,64,128, not topmost)
	love.graphics.rectangle("fill", self.x-1, self.y+self.windowani-17, self.width+2, 16)

	-- Also display the title text (if not empty). Shadow first
	self:setColor(0,0,0,255, not topmost)
	love.graphics.print(self.title, self.x+4, self.y+self.windowani-10)
	self:setColor(255,255,255,255, not topmost)
	love.graphics.print(self.title, self.x+3, self.y+self.windowani-11)
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
	elseif self.closing and self.windowani < 16 then
		self.windowani = math.min(self.windowani + dt*60, 16)
	end

	if self.windowani >= 16 and topmost then
		self:closed()
	end
end

function cDialog:mousepressed(x, y)
	-- Left mouse button pressed on the dialog
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
	if key == "return" then
		if self.buttons_present[DB.OK] then
			self:press_button(DB.OK)
		elseif self.buttons_present[DB.CLOSE] then
			self:press_button(DB.CLOSE)
		elseif self.buttons_present[DB.SAVE] then
			self:press_button(DB.SAVE)
		elseif self.buttons_present[DB.QUIT] then
			self:press_button(DB.QUIT)
		end
	elseif key == "escape" and self.buttons_present[DB.CANCEL] then
		self:press_button(DB.CANCEL)
	elseif key == "y" and self.buttons_present[DB.YES] then
		self:press_button(DB.YES)
	elseif key == "n" and self.buttons_present[DB.NO] then
		self:press_button(DB.NO)
	elseif key == "s" and self.buttons_present[DB.SAVE] then
		self:press_button(DB.SAVE)
	elseif key == "d" and self.buttons_present[DB.DISCARD] then
		self:press_button(DB.DISCARD)
	end
end

function cDialog:dropdown_onchange(key, picked)
	if self.closing then
		return
	end

	for k,v in pairs(self.fields) do
		if v[1] == key then
			local new_value = nil
			if v[9] ~= nil then
				new_value = v[9](picked, v[7], v[8])
			end
			if new_value == nil then
				new_value = picked
			end

			v[5] = new_value

			break
		end
	end
end

function cDialog:drawfield(topmost, n, key, x, y, w, content, mode, menuitems, menuitemslabel) -- next: dropdown onchange function
	-- Modes:
	-- 0: textbox (default)
	-- 1: dropdown
	-- 2: text label (can also be function returning string)
	-- 3: checkbox
	if mode == nil then
		mode = 0
	end

	local real_x = self.x+10+x*8
	local real_y = self.y+self.windowani+10+y*8 + 1
	local real_w = w*8

	if mode == 2 then
		-- This is only a label, don't do anything special.
		self:setColor(0,0,0,255)
		local textcontent
		if type(content) == "function" then
			textcontent = content(key, self:return_fields())
		else
			textcontent = content
		end
		love.graphics.printf(anythingbutnil(textcontent), real_x, real_y-1, real_w, "left")
		self:setColor(255,255,255,255)
		return
	end

	local active = self.currentfield == n

	if mode <= 1 then
		-- Text field or dropdown
		if topmost and (active or mouseon(real_x, real_y-3, real_w, 8)) then
			self:setColor(255,255,255,255)
			love.graphics.rectangle("fill", real_x, real_y-3, real_w, 8)

			if (active and love.keyboard.isDown("tab"))
			or (mouseon(real_x, real_y-3, real_w, 8) and love.mouse.isDown("l") and not mousepressed) then
				self.currentfield = n

				if mode == 1 and not RCMactive then
					rightclickmenu.create(menuitems, "dia_" .. key, real_x, (real_y-3)+8, true) -- y+h

					mousepressed = true
				end
			end
		else
			self:setColor(255,255,255,192)
			love.graphics.rectangle("fill", real_x, real_y-3, real_w, 8)
		end

		self:setColor(0,0,0,255)

		if mode == 0 then
			love.graphics.print(anythingbutnil(content) .. (active and __ or ""), real_x, real_y-1)
		elseif mode == 1 then
			if menuitemslabel == false then
				love.graphics.print(anythingbutnil(content), real_x, real_y-1)
			else
				love.graphics.print(anythingbutnil(menuitemslabel[anythingbutnil0(tonumber(content))]), real_x, real_y-1)
			end
			love.graphics.draw(menupijltje, real_x+real_w-8, (real_y-3)+2) -- Die 8 is 7+1
		end
	elseif mode == 3 then
		-- Checkbox
		self:hoverdraw(topmost, content and checkon or checkoff, real_x, real_y-3, real_w, 8)

		if (mouseon(real_x, real_y-3, real_w, 8) and love.mouse.isDown("l") and not mousepressed) then
			self.currentfield = n

			self.fields[n][5] = not content
			mousepressed = true
		end
	end

	self:setColor(255,255,255,255)
end

function cDialog:hoverdraw(topmost, img, x, y, w, h, s)
	if topmost and mouseon(x, y, w, h) then
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
		notclosed = self.noclosechecker(button, self:return_fields(), self.identifier)
	end
	if notclosed then
		if self.handler ~= nil then
			self.handler(button, self:return_fields(), self.identifier, notclosed)
		end
	else
		self:close(button)
	end
end

function cDialog:close(button)
	-- ONLY call this on the topmost dialog.
	-- Button is assumed to exist here, no questions asked.
	self.return_btn = button

	self.closing = true

	if not s.dialoganimations then
		self:closed()
	end
end

function cDialog:closed()
	table.remove(dialogs)
	-- Call the close handler!
	if self.handler ~= nil then
		self.handler(self.return_btn, self:return_fields(), self.identifier, false)
	end
end

function cDialog:return_fields()
	local f = {}

	for k,v in pairs(self.fields) do
		f[v[1]] = v[5]
	end

	return f
end

function cDialog:setColor(red, green, blue, alpha, nottopmost)
	if nottopmost then
		alpha = alpha / 2
	end

	if math.floor(self.windowani) < 0 then
		love.graphics.setColor(red, green, blue, ((math.floor(self.windowani)+15)/15)*alpha)
	elseif math.floor(self.windowani) == 0 then
		love.graphics.setColor(red, green, blue, alpha)
	else
		love.graphics.setColor(red, green, blue, ((15-math.floor(self.windowani))/15)*alpha)
	end
end




dialogs = {}

dialog = {}

function dialog.draw()
	-- Now come the dialogs!
	if DIAwindowani ~= 16 then -- don't change in the old system!
		-- Window contents
		setColorDIA(192,192,192,239)
		love.graphics.rectangle("fill", DIAx, DIAy+DIAwindowani, DIAwidth, DIAheight)
		-- Text
		setColorDIA(0,0,0,255)
		love.graphics.printf(DIAtext, DIAx+10, DIAy+DIAwindowani+10, DIAwidth-20, "left")

		-- Text boxes
		dialog.textboxes()

		-- Button, if enabled
		if DIAcanclose ~= 0 then
			local btnwidth = 72

			if mouseon(DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn1glow < 15) and #dialogs == 0 then
				DIAbtn1glow = DIAbtn1glow + 1

				if DIAwindowani == 0 and love.mouse.isDown("l") then
					if DIAcanclose == 2 then
						dialog.push()
						DIAreturn = 1
						DIAquitting = 1
					elseif DIAcanclose == 5 then
						DIAreturn = 1
					else
						dialog.push()
						DIAreturn = 1
					end
				end
			elseif DIAbtn1glow > 0 then
				DIAbtn1glow = DIAbtn1glow - 1
			end

			if DIAcanclose == 3 or DIAcanclose == 4 or DIAcanclose == 5 or DIAcanclose == 6 then
				if mouseon(DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn2glow < 15) and #dialogs == 0 then
					DIAbtn2glow = DIAbtn2glow + 1

					if DIAwindowani == 0 and love.mouse.isDown("l") then
						dialog.push()
						DIAreturn = 2
					end
				elseif DIAbtn2glow > 0 then
					DIAbtn2glow = DIAbtn2glow - 1
				end
			end

			if DIAcanclose == 5 or DIAcanclose == 6 then
				if mouseon(DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25) and (DIAbtn3glow < 15) and #dialogs == 0 then
					DIAbtn3glow = DIAbtn3glow + 1

					if DIAwindowani == 0 and love.mouse.isDown("l") then
						dialog.push()
						DIAreturn = 3
					end
				elseif DIAbtn3glow > 0 then
					DIAbtn3glow = DIAbtn3glow - 1
				end
			end

			setColorDIA(64+(4*DIAbtn1glow),64+(4*DIAbtn1glow),64+(4*DIAbtn1glow),128)
			love.graphics.rectangle("fill", DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
			setColorDIA(0,0,0,255)
			if DIAcanclose == 1 then
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 2 then
				love.graphics.printf(L.BTN_QUIT, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 3 then
				love.graphics.printf(L.BTN_NO, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 4 or DIAcanclose == 6 then
				love.graphics.printf(L.BTN_CANCEL, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 5 then
				love.graphics.printf(L.BTN_APPLY, DIAx+DIAwidth-btnwidth-1, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end

			if DIAcanclose == 3 or DIAcanclose == 4 or DIAcanclose == 5 or DIAcanclose == 6 then
				setColorDIA(64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),64+(4*DIAbtn2glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
			end
			if DIAcanclose == 3 then
				love.graphics.printf(L.BTN_YES, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 4 then
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 5 then
				love.graphics.printf(L.BTN_CANCEL, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 6 then
				love.graphics.printf(L.BTN_DISCARD, DIAx+DIAwidth-(2*btnwidth)-6, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end

			if DIAcanclose == 5 or DIAcanclose == 6 then
				setColorDIA(64+(4*DIAbtn3glow),64+(4*DIAbtn3glow),64+(4*DIAbtn3glow),128)
				love.graphics.rectangle("fill", DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-26, btnwidth, 25)
				setColorDIA(0,0,0,255)
			end
			if DIAcanclose == 5 then
				love.graphics.printf(L.BTN_OK, DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			elseif DIAcanclose == 6 then
				love.graphics.printf(L.BTN_SAVE, DIAx+DIAwidth-(3*btnwidth)-11, DIAy+DIAwindowani+DIAheight-16, btnwidth, "center")
			end
		end
		-- Window border
		setColorDIA(255,255,255,239)
		love.graphics.rectangle("line", DIAx, DIAy+DIAwindowani, DIAwidth, DIAheight)
		-- Bar, if enabled
		setColorDIA(64,64,64,128, #dialogs > 0)
		love.graphics.rectangle("fill", DIAx-1, DIAy+DIAwindowani-17, DIAwidth+2, 16)

		-- Also display the title text (if not empty). Shadow first
		setColorDIA(0,0,0,255, #dialogs > 0)
		love.graphics.print(DIAbartext, DIAx-1+4+1, DIAy+DIAwindowani-17+6+1)
		setColorDIA(255,255,255,255, #dialogs > 0)
		love.graphics.print(DIAbartext, DIAx-1+4, DIAy+DIAwindowani-17+6)
	end

	if DIAwindowani < 0 then
		-- Window is opening
		DIAwindowani = math.min(DIAwindowani + (60/math.max(love.timer.getFPS(), 1)), 0)
	elseif (DIAwindowani > 0) and (DIAwindowani < 16) then
		-- Window is closing
		DIAwindowani = math.min(DIAwindowani + (60/math.max(love.timer.getFPS(), 1)), 16)
	-- else windowani == 16, window is gone
	elseif DIAwindowani == 16 then
		-- No dialog.
		if DIAquitting == 1 then
			love.timer.sleep(0.1)
			love.event.quit()
		end
	end

	for k,v in pairs(dialogs) do
		v:draw(k == #dialogs)
	end
end

function dialog.textboxes()
	if DIAquestionid == 2 then
		-- Entity properties
		for box = 1, 10 do
			hoverdiatext(DIAx+10+16+24, DIAy+DIAwindowani+10+24+(8*(box-1)), 300, 8, multiinput[box], box, currentmultiinput == box)
		end
	elseif DIAquestionid == 5 then
		-- Level properties
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10, 20*8, 8, multiinput[1], 1, currentmultiinput == 1)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(1*8), 37*8, 8, multiinput[2], 2, currentmultiinput == 2)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(2*8), 40*8, 8, multiinput[3], 3, currentmultiinput == 3)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(4*8), 40*8, 8, multiinput[4], 4, currentmultiinput == 4)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(5*8), 40*8, 8, multiinput[5], 5, currentmultiinput == 5)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(6*8), 40*8, 8, multiinput[6], 6, currentmultiinput == 6)
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(8*8), 3*8, 8, multiinput[7], 7, currentmultiinput == 7) -- 5
		hoverdiatext(DIAx+10+(12*8), DIAy+DIAwindowani+10+(8*8), 3*8, 8, multiinput[8], 8, currentmultiinput == 8) -- 9
		hoverdiatext(DIAx+10+(8*8), DIAy+DIAwindowani+10+(10*8), 240, 8, multiinput[9], 9, currentmultiinput == 9, 1, listmusicnames, listmusicids, "music") -- 6
	elseif DIAquestionid == 9 or DIAquestionid == 11 or DIAquestionid == 12 or DIAquestionid == 13 or DIAquestionid == 15 or DIAquestionid == 20 or DIAquestionid == 21 or DIAquestionid == 22 then
		assert(false)
	-- !!! When migrating simple one line dialogs from this (9,11,12,13,15,19,20,21,22,26), move to above
	elseif DIAquestionid == 19 or DIAquestionid == 26 then
		-- Create new script or note or anything else with a single-line
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(1*8), 40*8, 8, multiinput[1], 1, currentmultiinput == 1)
	elseif DIAquestionid == 10 then
		-- Save level
		assert(false)
	elseif DIAquestionid == 18 then
		-- Go to line
		assert(false)
	elseif DIAquestionid == 23 then
		-- Custom VVVVVV dir, use the space we can get
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(8*8), 47*8, 8, multiinput[1], 1, currentmultiinput == 1)
	elseif DIAquestionid == 24 then
		-- Language
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(4*8), 240, 8, multiinput[1], 1, currentmultiinput == 1, 1, languageslist, nil, "language")
		love.graphics.setColor(0,0,0)
		love.graphics.print(L.DATEFORMAT, DIAx+10, DIAy+DIAwindowani+10+(7*8))
		hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(9*8), 240, 8, multiinput[2], 2, currentmultiinput == 2, 1, standarddateformat_labels, standarddateformat_labels, "dateformat")
		if multiinput[2] == 4 then
			hoverdiatext(DIAx+10, DIAy+DIAwindowani+10+(11*8), 240, 8, multiinput[3], 3, currentmultiinput == 3)
		end

		-- Unique, not an input field, but specific to this text box
		local bottomleft_text = L.TRANSLATIONCREDIT
		if s.plang == "English" then
			-- Yeah, hardcoded text!
			bottomleft_text = "Want to help translating Ved? Please contact Dav999!"
		end
		setColorDIA(0,0,0,255)
		love.graphics.printf(bottomleft_text, DIAx+10, DIAy+DIAwindowani+10+(15*8), DIAwidth-(2*72)-6-10, "left") -- 72 is that btnwidth up there
	end
end

-- TODO maybe actually look in the top dialog and see what the mode is - once I migrate these
function dialog.current_input_not_dropdown()
	if DIAquestionid == 5 and currentmultiinput == 9 then
		return false
	elseif DIAquestionid == 24 and (currentmultiinput == 1 or currentmultiinput == 2) then
		return false
	end
	return true
end

function dialog.is_open()
	return DIAwindowani ~= 16 or #dialogs > 0
end

function dialog.update(dt)
	if DIAwindowani > 16 then
		-- Oops, too far.
		DIAwindowani = 16
	end

	if (DIAcanclose == 5 and DIAreturn == 1) --[[ apply ]] or (DIAwindowani == 16 and DIAquestionid ~= 0) then
		if (DIAquestionid == 1) then -- State 9 test
			-- Do something
			-- if DIAreturn == 1 then
			youdidanswer = "You answered: " .. DIAreturn
		elseif (DIAquestionid == 2) then
			-- Save entity properties
			if DIAreturn == 2 or DIAreturn == 3 then -- cancel/ok
				stopinput()
			end

			if DIAreturn == 1 or DIAreturn == 3 then -- apply or ok
				-- entdetails[3] is still the ID of this entity
				local correctlines = false
				if (entitydata[tonumber(entdetails[3])].t == 11 or entitydata[tonumber(entdetails[3])].t == 50) -- gravity line or warp line
				and entitydata[tonumber(entdetails[3])].p1 == anythingbutnil0(tonumber(multiinput[4]))
				and entitydata[tonumber(entdetails[3])].p2 == anythingbutnil0(tonumber(multiinput[5]))
				and entitydata[tonumber(entdetails[3])].p3 == anythingbutnil0(tonumber(multiinput[6])) then
					correctlines = true
				end

				local entitypropkeys = {"x", "y", "t", "p1", "p2", "p3", "p4", "p5", "p6"}
				local changeddata = {}
				for i = 1, 9 do
					table.insert(changeddata, {
							key = entitypropkeys[i],
							oldvalue = entitydata[tonumber(entdetails[3])][entitypropkeys[i]],
							newvalue = anythingbutnil0(tonumber(multiinput[i]))
						}
					)
					entitydata[tonumber(entdetails[3])][entitypropkeys[i]] = anythingbutnil0(tonumber(multiinput[i]))
				end
				entitydata[tonumber(entdetails[3])].data = multiinput[10]

				if correctlines then
					autocorrectlines()

					for k,v in pairs(changeddata) do
						if v.key == "p1" or v.key == "p2" or v.key == "p3" then
							changeddata[k].newvalue = entitydata[tonumber(entdetails[3])][v.key]
						end
					end

					-- Do keep the fields in sync, if we're only applying
					if DIAreturn == 1 then
						multiinput[4] = entitydata[tonumber(entdetails[3])].p1
						multiinput[5] = entitydata[tonumber(entdetails[3])].p2
						multiinput[6] = entitydata[tonumber(entdetails[3])].p3
						mousepressed = true
					end
				end

				table.insert(undobuffer, {undotype = "changeentity", rx = roomx, ry = roomy, entid = tonumber(entdetails[3]), changedentitydata = changeddata})
				finish_undo("CHANGED ENTITY (PROPERTIES)")
			end
		elseif (DIAquestionid == 3) then
			-- load a level or not
			if DIAreturn == 2 then -- yes
				tostate(6)
			end
		elseif (DIAquestionid == 4) and (DIAreturn == 2) then
			-- Add a 21st trinket
			assert(false)
		elseif (DIAquestionid == 5) then
			stopinput()
			if DIAreturn == 2 then
				-- What are the old properties?
				local undo_propertynames = {"Title", "Creator", "website", "Desc1", "Desc2", "Desc3", "mapwidth", "mapheight", "levmusic"}
				local undo_properties = {}
				for k,v in pairs(undo_propertynames) do
					undo_properties[k] = {
						key = v,
						oldvalue = metadata[v]
					}
				end

				-- Level properties
				metadata.Title = multiinput[1]
				metadata.Creator = multiinput[2]
				metadata.website = multiinput[3]
				metadata.Desc1 = multiinput[4]
				metadata.Desc2 = multiinput[5]
				metadata.Desc3 = multiinput[6]
				metadata.levmusic = multiinput[9]
				--if ( (tonumber(multiinput[7]) > 20) or (tonumber(multiinput[8]) > 20) ) and ( (tonumber(multiinput[7]) < metadata.mapwidth) or (tonumber(multiinput[8]) < metadata.mapheight) ) then
					-- On one side you're making the map size too large and on the other you're making it smaller than it is...

				--v elseif
				if (tonumber(multiinput[7]) ~= nil and tonumber(multiinput[8]) ~= nil) then
					-- Make sure we have a dimension, and that it isn't too interesting
					if (tonumber(multiinput[7]) < 1) then
						multiinput[7] = 1
					end
					if (tonumber(multiinput[8]) < 1) then
						multiinput[8] = 1
					end
					-- Make sure our dimension has a precise width and height
					multiinput[7], multiinput[8] = math.floor(multiinput[7]), math.floor(multiinput[8])

					if (tonumber(multiinput[7]) > 20) or (tonumber(multiinput[8]) > 20) then
						dialog.create(
							langkeys(L.SIZELIMIT, {
								math.min(20, tonumber(multiinput[7])),
								math.min(20, tonumber(multiinput[8]))
							})
						)
						metadata.mapwidth = math.min(20, tonumber(multiinput[7]))
						metadata.mapheight = math.min(20, tonumber(multiinput[8]))
						addrooms(metadata.mapwidth, metadata.mapheight)
						gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
					else
						-- Just do it
						metadata.mapwidth = math.min(20, tonumber(multiinput[7]))
						metadata.mapheight = math.min(20, tonumber(multiinput[8]))
						addrooms(metadata.mapwidth, metadata.mapheight)
						gotoroom(math.min(roomx, metadata.mapwidth-1), math.min(roomy, metadata.mapheight-1))
					end
				end

				--What are the new properties again?
				for k,v in pairs(undo_propertynames) do
					undo_properties[k].newvalue = metadata[v]
				end

				-- Make sure we can undo and redo it
				table.insert(undobuffer, {undotype = "metadata", changedmetadata = undo_properties})
				finish_undo("CHANGED METADATA")
			end
		elseif (DIAquestionid == 6) and (DIAreturn == 2) then
			-- Yes, I do want to change the level size to this. If I set it to lower than the existing size I might lose rooms - or if I bypass the 20x20 limit this level will become nuclear.
			assert(false)
		elseif (DIAquestionid == 7) and (DIAreturn == 2) then
			-- Yes, create a new blank map, I'll lose any unsaved content
			assert(false)
		elseif (DIAquestionid == 8) then
			-- Quitting, save/discard/cancel?
			assert(false)
		elseif (DIAquestionid == 9 or DIAquestionid == 11 or DIAquestionid == 21 or DIAquestionid == 22) then
			--     new script (list)    new script (editor)          split (editor)        duplicate (list)
			assert(false)
		elseif (DIAquestionid == 10) then
			-- Save level
			assert(false)
		-- DIAQUESTIONID 11 IS HANDLED ABOVE (ALMOST EQUAL TO 9)
		elseif (DIAquestionid == 12) then
			assert(false)
		elseif (DIAquestionid == 13) then
			assert(false)
		elseif (DIAquestionid == 14) and (DIAreturn == 2) then
			-- Yes, delete this note
			assert(false)
		elseif (DIAquestionid == 15) then
			assert(false)
		elseif DIAquestionid == 16 and DIAreturn == 2 then
			-- Leave the editor even though a flag label doesn't have a number now.
			assert(false)
		elseif DIAquestionid == 17 and DIAreturn == 2 then
			-- Delete this script!
			-- input is the 'number' of the script

			scripts[scriptnames[input]] = nil
			table.remove(scriptnames, input)
			dirty()

			-- The script number is input
			--table.remove(scripts, scriptnames[input])
			--table.remove(scriptnames, input)
		elseif DIAquestionid == 18 then
			assert(false)
		elseif DIAquestionid == 19 then
			stopinput()
			-- Be a number, you input!
			input = tonumber(input)
			if DIAreturn == 2 then
				-- Rename this script... As long as the names aren't the same, because then we'd end up *removing* the script (just read the code)
				-- And of course, as long as a script with that name doesn't already exist.
				-- input is the 'number' of the script
				if scripts[multiinput[1]] ~= nil and multiinput[1] ~= scriptnames[input] then
					dialog.create(langkeys(L.SCRIPTALREADYEXISTS, {multiinput[1]}))
					replacedialog = true
				elseif multiinput[1] ~= scriptnames[input] then
					scripts[multiinput[1]] = scripts[scriptnames[input]] -- Copy script from old to new name
					scripts[scriptnames[input]] = nil -- Remove old name

					scriptnames[input] = multiinput[1] -- Administrative rename
				end
			end
		elseif DIAquestionid == 20 then
			assert(false)
		-- 21 AND 22 HANDLED ABOVE AT 9 AND 11 (21 is script split, 22 is script duplicate)
		elseif DIAquestionid == 23 then
			stopinput()
			if DIAreturn == 2 then
				-- Set the custom VVVVVV directory to this
				s.customvvvvvvdir = multiinput[1]
			end
		elseif DIAquestionid == 24 then
			stopinput()
			if DIAreturn == 2 then
				-- Set the language
				s.lang = multiinput[1]
				-- The date format has to be valid. This is almost leaning toothpick syndrome, except Lua uses the very standard percent sign escape character.
				s.dateformat = ("^" .. multiinput[3]):gsub("([^%%])%%([^aAbBcdHIMmpSwxXYy%%])", "%1%%%%%2"):sub(2,-1)
				saveconfig()
			end
		elseif DIAquestionid == 25 then
			assert(false)
		elseif DIAquestionid == 26 then
			-- Save copy of backup in levels folder
			if DIAreturn == 2 then
				if dirsep ~= "/" then
					input = input:gsub(dirsep, "/")
				end
				local ficontents = love.filesystem.read("overwrite_backups/" .. input .. ".vvvvvv")
				if ficontents == nil then
					dialog.create(langkeys(L.LEVELOPENFAIL, {"overwrite_backups/" .. input}))
					replacedialog = true
				else
					local success, iferrmsg = writelevelfile(levelsfolder .. dirsep .. multiinput[1] .. ".vvvvvv", ficontents)
					if not success then
						dialog.create(L.SAVENOSUCCESS .. anythingbutnil(iferrmsg))
						replacedialog = true
					end
				end
			end
		end

		-- The answer to the question has been handled now. Or has it?
		if replacedialog == nil then
			if not (DIAcanclose == 5 and DIAreturn == 1) then
				DIAquestionid = 0
				multiinput = {}
			end
			--replacedialog = nil
		end
		replacedialog = nil
		DIAreturn = 0
	end

	if DIAmovingwindow == 1 then
		DIAx = DIAmovedfromwx + (love.mouse.getX()-DIAmovedfrommx)
		DIAy = DIAmovedfromwy + (love.mouse.getY()-DIAmovedfrommy)
	end

	for k,v in pairs(dialogs) do
		v:update(dt, k == #dialogs)
	end
end

function dialog.new(message, title, showbar, canclose, questionid)
	dialog.init()
	DIAbartext = title
	DIAtext = message
	DIAcanclose = canclose
	if s.dialoganimations then
		DIAwindowani = -15
	else
		DIAwindowani = 0
	end

	if (questionid ~= nil) then
		DIAquestionid = questionid
	else
		DIAquestionid = 0
	end

	DIAreturn = 0
end

function dialog.create(message, buttons, handler, title, fields, noclosechecker, identifier)
	if fields ~= nil then
		fields = table.copy(fields)
	end

	RCMactive = false

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

function dialog.push()
	if s.dialoganimations then
		DIAwindowani = DIAwindowani + 1
	else
		DIAwindowani = 16
	end
end

function setColorDIA(rood, groen, blauw, alfa, nottopmost)
	if nottopmost then
		alfa = alfa / 2
	end

	if math.floor(DIAwindowani) < 0 then
		love.graphics.setColor(rood,groen,blauw,((math.floor(DIAwindowani)+15)/15)*alfa)
	elseif math.floor(DIAwindowani) == 0 then
		love.graphics.setColor(rood,groen,blauw,alfa)
	elseif (math.floor(DIAwindowani) > 0) and (math.floor(DIAwindowani) < 16) then
		love.graphics.setColor(rood,groen,blauw,((15-math.floor(DIAwindowani))/15)*alfa)
	end
end

function dialog.init()
	-- DIAx = 200
	-- DIAy = 225
	DIAx = (love.graphics.getWidth()-400)/2
	DIAy = (love.graphics.getHeight()-150)/2
	DIAwidth = 400
	DIAheight = 150
	DIAmovingwindow = 0
	DIAmovedfromwx = 100
	DIAmovedfromwy = 100
	DIAmovedfrommx = 0
	DIAmovedfrommy = 0
	DIAquitting = 0
	DIAwindowani = 16
	DIAbtn1glow = 0
	DIAbtn2glow = 0
	DIAbtn3glow = 0
	DIAquestionid = 0

	DIAcanclose = 1 -- Can be closed. This is actually the button type, 0 is none - dialog can't be closed, 1 is OK, 2 is Quit, 3 is yes or no.

	DIAreturn = 0 -- Button pressed, which could be used afterwards.

	DIAbartext = "UNDEFINED"
	DIAtext = "UNDEFINED"
end

require("dialog_uses")
