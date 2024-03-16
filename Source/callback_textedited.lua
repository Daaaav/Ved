function love.textedited(text, start, length)
	-- IME candidate text (CJK)

	ime_textedited = text
	ime_textstart = start
	ime_textlength = length

	if ime_textedited == nil then
		ime_textedited = ""
	end
end
