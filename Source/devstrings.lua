-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""

L_PLU.NOTALLTILESVALID = {
	[0] = "$1 tile is not a valid whole number greater than or equal to 0",
	[1] = "$1 tiles are not a valid whole number greater than or equal to 0",
}
L.PROJECT_UNRECOGNIZED = "Path provided is not a project directory format"
L.PROJECT_TOONEW = "Project format version is too new!"
L.PROJECT_INVALIDVERSION = "Project format version is invalid!"
L.PROJECT_FILE404 = "Project is missing file '$1'!"
L.PROJECT_FOLDER404 = "Project is missing folder '$1'!"
L.WARNINGINFILE = "Warning in file '$1': "
L.ERRORINFILE = "Error in file '$1': "
L.ERRORINFILELINE = "Error in file '$1', line $2: "
L.ERRORINFILELINECOLUMN = "Error in file '$1', line $2, column $3: "
L.COLON404 = "The ':' character is missing!"
L.KEY404 = "The key '$1' is missing!"
L.INCOMPLETEBACKSLASHESCAPE = "Unexpected end of string when parsing backslash escape sequence!"
L.INCOMPLETEHEXADECIMALESCAPE = "Unexpected end of string when parsing hexadecimal escape sequence!"
L.HEXADECIMALNONULL = "Hexadecimal escape sequence cannot be '\\x00'!"
L.INVALIDBACKSLASHESCAPE = "Invalid backslash escape sequence!"
L.INVALIDINTEGERKEYVALUE = "The value for the key '$1' is not a valid integer!"
L.DUPLICATEKEY = "Key '$1' is a duplicate! (previously defined on line $2)"
L.INVALIDFLAGINTEGER = "Flag '$1' is not a valid integer!"
L.INVALIDFLAGNONNEGATIVE = "Flag '$1' is negative!"
L.LINEISBLANK = "This line is blank!"
L.NOENDINGCOMMA = "Line does not have a terminating comma!"
L.INVALIDTILEINTEGER = "Tile '$1' is not a valid integer!"
L.INVALIDTILENONNEGATIVE = "Tile '$1' is negative!"
L_PLU.UNUSEDKEYS = {
	[0] = "The following unused key was found and will be ignored: ",
	[1] = "The following unused keys were found and will be ignored: ",
}
L_PLU.TOOFEWTILES = {
	[0] = "This line has $1 tile too few!",
	[1] = "This line has $1 tiles too few!",
}
L_PLU.TOOMANYTILES = {
	[0] = "This line has $1 tile too many!",
	[1] = "This line has $1 tiles too many!",
}
L_PLU.TOOFEWROWS = {
	[0] = "This file has $1 line too few!",
	[1] = "This file has $1 lines too few!",
}
L_PLU.TOOMANYROWS = {
	[0] = "This file has $1 line too many!",
	[1] = "This file has $1 lines too many!",
}
