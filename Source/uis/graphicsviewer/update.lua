-- graphicsviewer/update

return function(dt)
	if imageviewer_image_color ~= nil and nodialog then
		if imageviewer_moving then
			imageviewer_x = imageviewer_moved_from_x + (love.mouse.getX()-imageviewer_moved_from_mx)
			imageviewer_y = imageviewer_moved_from_y + (love.mouse.getY()-imageviewer_moved_from_my)
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("left", "kp4", "a") then
			imageviewer_x = imageviewer_x + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("right", "kp6", "d") then
			imageviewer_x = imageviewer_x - 1200*dt
			fix_imageviewer_position()
		end
		if love.keyboard.isDown("up", "kp8", "w") then
			imageviewer_y = imageviewer_y + 1200*dt
			fix_imageviewer_position()
		elseif love.keyboard.isDown("down", "kp2", "s") then
			imageviewer_y = imageviewer_y - 1200*dt
			fix_imageviewer_position()
		end

		if love.keyboard.isDown("pageup") then
			imageviewer_x, imageviewer_y = 8, 16
			fix_imageviewer_position()
		elseif love.keyboard.isDown("pagedown") then
			imageviewer_x, imageviewer_y = -imageviewer_w*imageviewer_s, -imageviewer_h*imageviewer_s
			fix_imageviewer_position()
		end
	end
end
