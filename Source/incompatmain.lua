function load()
	-- Reeeeeally old version of love, I see
	love.load()

	draw = love.draw
end

function love.load()
	create_fallback_window()

	loadfonts_main()

	-- We want to get the strings from every language!
	loadlanginfo()

	-- They should be ordered in alphabetical order... While we're at it, put English first
	langs = {}
	for lang,info in pairs(langinfo) do
		if lang ~= "en" then
			table.insert(langs, lang)
		end
	end
	table.sort(langs)
	table.insert(langs, 1, "en")

	messages = {}

	local langkey
	if not love_version_meets(9) then
		langkey = "OUTDATEDLOVE"
	else
		langkey = "OUTDATEDLOVE090"
	end

	local y = 20
	for k,lang in pairs(langs) do
		require("lang/" .. lang)

		local font = fonts_main[langinfo[lang].font]
		if font == nil then
			font = font_8x8
		end

		local text = L[langkey]

		table.insert(messages, {
				font = font,
				text = text,
				y = y
			}
		)

		local _, lines = font:getWrap(text, love.graphics.getWidth()-20)
		y = y + (lines * font:getHeight()) + 20
	end
end

function love.draw()
	for k,font in pairs(fonts_main) do
		font:frame_start()
	end

	for k,v in pairs(messages) do
		v.font:printf(v.text, 10, v.y, love.graphics.getWidth()-20, "center")
	end

	font_8x8:print(
		"Ved version: " .. ved_ver_human() .. "\n"
		.. "LÖVE version: " .. love_ver_human(),
		8, love.graphics.getHeight()-21
	)
end
