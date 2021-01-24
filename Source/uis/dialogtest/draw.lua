-- dialogtest/draw

return function()
	vvvvvv_textbox("cyan", 0, 25, {"Cyan"})
	vvvvvv_textbox("red", 0, 50, {"Red"})
	vvvvvv_textbox("yellow", 0, 75, {"Yellow"})
	vvvvvv_textbox("green", 0, 100, {"Green"})
	vvvvvv_textbox("blue", 0, 125, {"Blue"})
	vvvvvv_textbox("purple", 0, 150, {"Purple"})
	vvvvvv_textbox("gray", 0, 175, {"Gray"})

	for k,v in pairs(vvvvvv_textboxes) do
		vvvvvv_textbox(unpack(v))
	end
end
