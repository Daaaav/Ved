require("vedfont")
local vedxml = require("vedxml")
local vedpo = require("vedpo")

function read_font_file(custom_folder, font_name, ext)
	-- custom_folder can be the path to a level-specific
	-- fonts folder, or nil to signify a built-in font.
	-- Returns contents, or nil

	if custom_folder == nil then
		local success, contents = pcall(love.filesystem.read, "fonts/" .. font_name .. ext)
		if not success then
			contents = nil
		end
		return contents
	end

	local success, contents = readfile(custom_folder .. dirsep .. font_name .. ext)
	if success then
		return contents
	end
end

function load_font_filename(fonts, custom_folder, font_name)
	local png_contents = read_font_file(custom_folder, font_name, ".png")
	if png_contents ~= nil then
		local txt_contents = read_font_file(custom_folder, font_name, ".txt")
		local fontmeta_contents = read_font_file(custom_folder, font_name, ".fontmeta")

		local fallback, fallback_imgdata, fallback_fontmeta_xml
		local fontmeta_xml
		if fontmeta_contents ~= nil then
			pcall(function()
				fontmeta_xml = vedxml.VedXML:new{string=fontmeta_contents, root="font_metadata"}

				-- Fallback is optional and error is fine
				fallback = fontmeta_xml:get_text(fontmeta_xml:find(nil, "fallback"))
			end)
		end
		if fallback ~= nil then
			-- Fallback fonts can only be main fonts, so we can cut corners a liiitle bit...
			fallback_png_contents = read_font_file(nil, fallback, ".png")
			local fallback_fontmeta_contents = read_font_file(nil, fallback, ".fontmeta")
			if fallback_png_contents ~= nil and fallback_fontmeta_contents ~= nil then
				pcall(function()
					fallback_fontmeta_xml = vedxml.VedXML:new{string=fallback_fontmeta_contents, root="font_metadata"}
				end)

				fallback_imgdata = love.image.newImageData(
					love.filesystem.newFileData(fallback_png_contents, fallback.. ".png", "file")
				)
			end
		end

		imgdata = love.image.newImageData(
			love.filesystem.newFileData(png_contents, font_name .. ".png", "file")
		)

		fonts[font_name] = cVedFont:new{standard_height=8}
		fonts[font_name]:init(
			imgdata,
			txt_contents,
			fontmeta_xml,
			fallback_imgdata,
			nil,
			fallback_fontmeta_xml
		)
	end
end

function loadfonts_main()
	-- Load the main (built-in) fonts. This should only be needed once in a session.
	fonts_main = {}
	fonts_custom = {}

	local files
	if love_version_meets(9) then
		files = love.filesystem.getDirectoryItems("fonts")
	else
		files = love.filesystem.enumerate("fonts")
	end
	for k,file_name in pairs(files) do
		if file_name:sub(-9) == ".fontmeta" and file_name ~= "tinyfont.fontmeta" then
			local font_name = file_name:sub(1,-10)
			load_font_filename(fonts_main, nil, font_name)
		end
	end

	font_ui = {
		context = "ui"
	}
	font_ui_metatable = {
		__index = function(table, index)
			local f
			if s ~= nil and s.lang ~= nil
			and langinfo ~= nil
			and langinfo[s.lang] ~= nil
			and langinfo[s.lang].font ~= nil
			and fonts_main[langinfo[s.lang].font] ~= nil then
				f = fonts_main[langinfo[s.lang].font]
			else
				f = font_8x8
			end

			return f[index]
		end
	}
	setmetatable(font_ui, font_ui_metatable)

	font_level = {
		context = "level"
	}
	font_level_metatable = {
		__index = function(table, index)
			local font = "font"
			if level.metadata ~= nil and level.metadata.font ~= nil then
				font = level.metadata.font
			end

			local f
			if fonts_custom[font] ~= nil then
				f = fonts_custom[font]
			elseif fonts_main[font] ~= nil then
				f = fonts_main[font]
			elseif fonts_custom["font"] ~= nil then
				f = fonts_custom["font"]
			else
				f = font_8x8
			end

			return f[index]
		end
	}
	setmetatable(font_level, font_level_metatable)

	font_8x8 = {
		context = "8x8"
	}
	font_8x8_metatable = {
		__index = function(table, index)
			assert(fonts_main["font"] ~= nil, "Main font is missing!")
			return fonts_main["font"][index]
		end
	}
	setmetatable(font_8x8, font_8x8_metatable)

	-- font8 is deprecated
	font8 = {
		context = "8x8"
	}
	setmetatable(font8, font_8x8_metatable)
end

function loadfonts_custom()
	-- Load the level-specific fonts
	fonts_custom = {}

	if editingmap ~= nil then
		local levelassets = getlevelassetsfolder()
		if levelassets ~= nil then
			local fonts_folder = levelassets .. graphicsfolder_rel

			-- Load font.png separately, it's not required to have a .fontmeta...
			load_font_filename(fonts_custom, fonts_folder, "font")

			local success, files = listfiles_generic(fonts_folder, ".fontmeta", true)
			for k,file in pairs(files) do
				if file.name ~= "font.fontmeta" then
					local font_name = file.name:sub(1,-10)
					load_font_filename(fonts_custom, fonts_folder, font_name)
				end
			end
		end
	end
end

function loadlanginfo()
	-- Load the language properties for all languages.
	-- Language properties include the name, fonts, RTL, etc
	langinfo = {}
	local contents = love.filesystem.read("lang/info.xml")
	if contents == nil then
		return
	end
	pcall(function()
		local xml = vedxml.VedXML:new{string=contents, root="langinfo"}
		local xlanguages = xml:find(nil, "languages")
		for language in xml:each_child_element(xlanguages, "language") do
			local attributes = xml:get_attributes(language)
			langinfo[attributes.code] = table.copy(attributes)
		end
	end)
end

local function loadhelpindex()
	-- Loads helpindex.xml so LH is populated with everything
	-- except subj and cont for each article
	LH = {}
	local contents = love.filesystem.read("help/helpindex.xml")
	if contents == nil then
		return
	end
	pcall(function()
		local xml = vedxml.VedXML:new{string=contents, root="helpindex"}
		for xpage in xml:each_child_element(nil, "page") do
			local id = xml:get_attribute(xpage, "id")
			local t = {
				splitid = id,
				subj = id,
				imgs = {},
				cont = ""
			}
			for ximg in xml:each_child_element(xpage, "img") do
				table.insert(t.imgs, xml:get_text(ximg))
			end
			table.insert(LH, t)
		end
	end)
end

function unloadlanguage()
	-- Prepare for language change
	package.loaded.devstrings = false
end

function loadlanguage()
	-- Load current language files depending on setting, and devstrings
	-- Possibly reload files that depend on language (const)

	local filename
	if s.lang == "en" then
		filename = "en.pot"
	else
		if langinfo[s.lang] == nil then
			-- Interpret old-style language setting
			for k,v in pairs(langinfo) do
				if s.lang == v.name then
					s.lang = v.code
					break
				end
			end
		end
		filename = s.lang .. ".po"
	end
	local success, iter = pcall(love.filesystem.lines, "lang/" .. filename)
	if not success then
		iter = love.filesystem.lines("lang/en.pot")
	end

	local po = vedpo.VedPO:new(iter, true)

	if po.plural_equation ~= nil then
		lang_plurals = po.plural_equation
	else
		function lang_plurals(n)
			return n == 1 and -1 or -2
		end
	end

	L = {}
	L_PLU = {}
	langtilesetnames = {}
	toolnames = {}
	warpdirs = {}
	warpdirchangedtext = {}
	subtoolnames = {}
	diffmessages = {}

	for k,entry in ipairs(po.entries) do
		local id = entry.msgctxt
		if id ~= nil then
			local str = entry.msgstr
			if entry.msgid_plural ~= nil then
				if entry.fuzzy then
					str = {}
				end
				str[-1] = entry.msgid
				str[-2] = entry.msgid_plural
			elseif anythingbutnil(str) == "" or entry.fuzzy then
				str = entry.msgid
			end

			local p = 3
			local p1, p2, p3 = id:match("^([^%.]+)%.([^%.]+)%.([^%.]+)$")
			if p3 == nil then
				p = 2
				p1, p2 = id:match("^([^%.]+)%.([^%.]+)$")
			end
			if p2 == nil then
				p = 1
				p1 = id
			end
			if p == 2 and (p1 == "L" or p1 == "L_PLU" or p1 == "langtilesetnames") then
				_G[p1][p2] = str
			elseif p == 2 and (p1 == "toolnames" or p1 == "warpdirs" or p1 == "warpdirchangedtext") then
				p2 = tonumber(p2)
				if p2 ~= nil then
					_G[p1][p2] = str
				end
			elseif p == 3 and p1 == "subtoolnames" then
				p2 = tonumber(p2)
				p3 = tonumber(p3)
				if p2 ~= nil and p3 ~= nil then
					if _G[p1][p2] == nil then
						_G[p1][p2] = {}
					end
					_G[p1][p2][p3] = str
				end
			elseif p == 3 and p1 == "diffmessages" then
				if _G[p1][p2] == nil then
					_G[p1][p2] = {}
				end
				_G[p1][p2][p3] = str
			elseif p == 1 and p1:sub(1,4) == "ERR_" then
				_G[p1] = str
			end
		end
	end

	-- Reuse the subtool names from walls for background, and for moving platforms and enemies
	subtoolnames[2] = subtoolnames[1]
	subtoolnames[9] = subtoolnames[8]
	subtoolnames[12] = table.copy(subtoolnames[5])

	loadhelpindex()
	for k,v in pairs(LH) do
		local contents = love.filesystem.read("help/" .. s.lang .. "/" .. v.splitid .. ".txt")
		if contents == nil then
			contents = love.filesystem.read("help/en/" .. v.splitid .. ".txt")
		end
		if contents ~= nil then
			contents = contents:gsub("\r", "")
			local first_nn = contents:find("\n\n", 1, true)
			if first_nn == nil then
				LH[k].cont = contents
			else
				LH[k].subj = contents:sub(1, first_nn-1)
				LH[k].cont = contents:sub(first_nn+2)
			end
		end
	end

	ved_require("devstrings")

	if package.loaded.const then
		package.loaded.const = false
		ved_require("const")
	end
	if package.loaded.tileset_data then
		package.loaded.tileset_data = false
		ved_require("tileset_data")
	end
	if uis ~= nil then
		-- Need to reload this for all the buttons that are in there
		unload_uis()
		load_uis()
	end
end

function loadtinyfont()
	local fontmeta_contents, err = love.filesystem.read("fonts/tinyfont.fontmeta")
	if fontmeta_contents == nil then
		-- I don't want to hardcode a "default" width for tinyfont, and this HAS to exist...
		error(err)
	end

	local xml = vedxml.VedXML:new{string=fontmeta_contents, root="font_metadata"}

	tinyfont = cVedFont:new()
	tinyfont:init(love.image.newImageData("fonts/tinyfont.png"), (love.filesystem.read("fonts/tinyfont.txt")), xml)

	-- Replace some key glyphs based on OS and language
	if s.lang == "de" then
		tinyfont:copy_glyph(0x63, 0xDF) -- c [CTRL] <- ß [STRG]
	elseif s.lang == "fr" then
		tinyfont:copy_glyph(0x62, 0xE9) -- b [ESC] <- é [ECHAP]
	end
	if love.system.getOS() == "OS X" then
		tinyfont:copy_glyph(0x63, 0x6D) -- c [CTRL] <- m [cmd]
	end
end
