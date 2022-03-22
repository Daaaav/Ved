-- Full option keys (--debug) are assumed to have a table structure, with help and func both being optional.
-- Single-letter abbreviations (-d) are assumed to be strings that are the full key option keys.
local clargs = {
	["d"] = "debug",
	["debug"] = {
		help = "Enable debug mode",
		func = function()
			allowdebug = true
		end
	},

	["l"] = "language-screen",
	["language-screen"] = {
		help = "Force showing the language screen on startup",
		func = function()
			opt_forcelanguagescreen = true
		end
	},

	["n"] = "new",
	["new"] = {
		help = "Start with a blank level (unless file name is given)",
		func = function()
			opt_newlevel = true
		end
	},

	["u"] = "no-update-check",
	["no-update-check"] = {
		help = "Disable the check for updates, bypassing config",
		func = function()
			opt_disableversioncheck = true
		end
	},

	["?"] = "help", ["h"] = "help",
	["help"] = {
		help = "Print help for command line args",
		func = function()
			print(
				"\n\n\nUsage: ved [OPTION]... [FILE]\n\n" ..
				"If given a file name, it is assumed to be a file within the levels directory.\n\n" ..
				"Example use:\n" ..
				"$ love ~/ved my\\ level.vvvvvv --debug\n" ..
				">ved \"my level.vvvvvv\" --debug\n"
			)
			clhelp()

			-- Quit
			return true
		end
	}
}

function clhelp()
	local helps = {}

	-- First get all the full options.
	for kh, vh in pairs(clargs) do
		if type(vh) ~= "string" then
			helps[kh] = {
				full = kh,
				abbr = {},
				help = vh.help
			}
			if vh.help == nil then
				helps[kh].help = ""
			end
		end
	end

	-- Now get all the abbreviations.
	for kh, vh in pairs(clargs) do
		if type(vh) == "string" then
			table.insert(helps[vh].abbr, kh)
		end
	end

	-- What's the longest combination of options? Helps us with alignment.
	local optslen_highscore = 0
	for kh, vh in pairs(helps) do
		optslen_highscore = math.max(optslen_highscore, cloptslen(vh))
	end

	-- Finally display everything
	for kh, vh in pairs(helps) do
		print("  -" .. table.concat(vh.abbr, ", -") .. ", --" .. kh .. (" "):rep(optslen_highscore-cloptslen(vh)) .. "  " .. vh.help)
	end
end

function cloptslen(helpselement)
	return 2 + 4*(#helpselement.abbr) + 2 + helpselement.full:len()
end

return clargs
