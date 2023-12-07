function love.conf(t)
	if love._version_major == nil or (love._version_major == 0 and love._version_minor <= 8) then
		t.screen = nil
	else
		t.window = nil
	end
	t.identity = "ved"

	t.modules.joystick = false
	t.modules.physics = false
end
