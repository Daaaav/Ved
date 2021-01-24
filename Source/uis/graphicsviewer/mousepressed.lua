-- graphicsviewer/mousepressed

return function(x, y, button)
	if button == "l" and imageviewer_image_color ~= nil and x < love.graphics.getWidth()-128 then
		imageviewer_moving = true
		imageviewer_moved_from_x, imageviewer_moved_from_y = imageviewer_x, imageviewer_y
		imageviewer_moved_from_mx, imageviewer_moved_from_my = x, y
		mousepressed = true
	end
end
