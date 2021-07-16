--[[
	box_exists: nil or false if it doesn't (yet) exist, true if it does (was resizableboxexists)

	boxperi_x, boxperi_y, boxperi_w, boxperi_h	This is the area in which you can resize the box, it will obviously never go outside of those limits.

	box_x, box_y, box_w, box_h	The current position and size of the box.

	box_type	This will be a number which defines which variable to set
		-1	set nothing at all
		0	box test in state 20, snap to 16x16 grid
		1	resizable script box

	box_moving_h	This holds 0 for not holding any horizontal side, 1 for the top one, 2 for the bottom one

	box_moving_v	0 none, 1 left, 2 right
]]

box_exists = false
boxperi_x, boxperi_y, boxperi_w, boxperi_h = 0,0,love.graphics.getWidth(),love.graphics.getHeight()
box_x, box_y, box_w, box_h = 0,0,0,0

box_type = -1

box_moving_h, box_moving_v = 0,0

box_movable = false

box_outsideiscancel = false -- Clicking outside of the box will cancel editing it

box_meta = nil -- Just some data that can be used to do stuff needed for a specific box type

function boxupdate()
	if box_exists then
		if mouseon(box_x-8, box_y-8, 16, 16) or mouseon((box_x+box_w)-8, (box_y+box_h)-8, 16, 16) then
			-- \
			love.mouse.setCursor(cursorobjs[16])
		elseif mouseon((box_x+box_w)-8, box_y-8, 16, 16) or mouseon(box_x-8, (box_y+box_h)-8, 16, 16) then
			-- /
			love.mouse.setCursor(cursorobjs[17])
		elseif mouseon(box_x-8, box_y-8, 16, box_h+16) or mouseon((box_x+box_w)-8, box_y-8, 16, box_h+16) then
			-- Left or right
			love.mouse.setCursor(cursorobjs[12])
		elseif mouseon(box_x-8, box_y-8, box_w+16, 16) or mouseon(box_x-8, (box_y+box_h)-8, box_w+16, 16) then
			-- Top or bottom
			love.mouse.setCursor(cursorobjs[11])
		elseif box_movable and mouseon(box_x, box_y, box_w, box_h) then
			-- Move
			love.mouse.setCursor(cursorobjs[19])
		elseif box_moving_h == 0 and box_moving_v == 0 then
			love.mouse.setCursor()
		end
		if box_moving_h == 1 then
			local oldy = box_y
			box_y = love.mouse.getY()
			box_h = box_h - (box_y - oldy)
		elseif box_moving_h == 2 then
			box_h = love.mouse.getY() - box_y
		end
		if box_moving_v == 1 then
			local oldx = box_x
			box_x = love.mouse.getX()
			box_w = box_w - (box_x - oldx)
		elseif box_moving_v == 2 then
			box_w = love.mouse.getX() - box_x
		end

		-- Don't let the box get too small or even have negative width/height!
		if box_w < 16 then
			--if box_moving_v == 1 then
				--box_x = box_x - (16 - box_w)
			--else
				box_w = 16
			--end
		end
		if box_h < 16 then
			--if box_moving_h == 1 then
				--box_y = box_y - (16 - box_h)
			--else
				box_h = 16
			--end
		end

		if box_type == 1 then
			entitydata[box_meta].x = math.floor(((box_x+8) - 128) / 16) + roomx*40
			entitydata[box_meta].y = math.floor((box_y+8) / 16) + roomy*30
			entitydata[box_meta].p1 = math.floor((box_w+8) / 16)
			entitydata[box_meta].p2 = math.floor((box_h+8) / 16)
		end

		--[[
		if box_type == 0 then
			if box_moving_v == 1 or box_moving_h == 1 then
				box_x, box_y = box_x-(box_x%16), box_y-(box_y%16)
			else
				box_w, box_h = box_w+15, box_h+15
				box_w, box_h = box_w-(box_w%16), box_h-(box_h%16)
			end
		end
		]]
	end
end


function boxmousepress()
	-- Function to be called if the mouse is pressed
	if box_exists then
		--if love.mouse.getX() - 8 >= box_x or love.mouse.getX() - 8 >= box_x
		local raak = false

		if mouseon(box_x-8, box_y-8, 16, box_h+16) then
			-- Left
			box_moving_v = 1
			raak = true
		elseif mouseon((box_x+box_w)-8, box_y-8, 16, box_h+16) then
			-- Right
			box_moving_v = 2
			raak = true
		end
		if mouseon(box_x-8, box_y-8, box_w+16, 16) then
			-- Top
			box_moving_h = 1
			raak = true
		elseif mouseon(box_x-8, (box_y+box_h)-8, box_w+16, 16) then
			-- Bottom
			box_moving_h = 2
			raak = true
		end

		if not raak and box_outsideiscancel then
			box_exists = false
		end
	end
end


function boxmouserelease()
	-- Function to be called if the mouse is released at any time
	if box_exists then
		box_moving_h = 0
		box_moving_v = 0

		box_x, box_y = math.max(boxperi_x, box_x), math.max(boxperi_y, box_y)
		box_w, box_h = math.min((boxperi_x+boxperi_w)-box_x, box_w), math.min((boxperi_y+boxperi_h)-box_y, box_h)

		if box_type == 0 then
			box_x, box_y, box_w, box_h = box_x+8, box_y+8, box_w+8, box_h+8
			box_x, box_y, box_w, box_h = box_x-(box_x%16), box_y-(box_y%16), box_w-(box_w%16), box_h-(box_h%16)
		elseif box_type == 1 then
			box_x, box_y, box_w, box_h = 128+(entitydata[box_meta].x-roomx*40)*16, (entitydata[box_meta].x-roomy*30)*16, (entitydata[box_meta].p1-1)*16, (entitydata[box_meta].p2-1)*16
		end
	end
end
