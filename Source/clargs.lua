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

	["e"] = "default-errhand",
	["default-errhand"] = {
		help = "Use default Love2d error handler instead of Ved's custom one",
		func = function()
			defaulterrhand = true
		end
	},

	["?"] = "help", ["h"] = "help",
	["help"] = {
		help = "Print help for command line args",
		func = function()
			print("\n\n")
			clhelp()
			print("\n\n")
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
		print("  -" .. table.concat(vh.abbr, " -") .. ", --" .. kh .. (" "):rep(optslen_highscore-cloptslen(vh)) .. "  " .. vh.help)
	end
end

function cloptslen(helpselement)
	return 2 + 3*(#helpselement.abbr) + 4 + helpselement.full:len()
end

return clargs