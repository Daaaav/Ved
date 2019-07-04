-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L_PLU.BYTES = {
	[0] = "$1 byte",
	[1] = "$1 bytes",
}
L.KILOBYTES = "$1 kB" -- There's also L_PLU.BYTES for "$1 byte"/"$1 bytes"
L.MEGABYTES = "$1 MB"
L.GIGABYTES = "$1 GB"
L.CANNOTUSENEWLINES = "You cannot use the \"$1\" character in script names!"
L.MUSICTITLE = "Title: "
L.MUSICARTIST = "Artist: "
L.MUSICFILENAME = "Filename: "
L.MUSICNOTES = "Notes:"
L.SONGMETADATA = "Metadata for song $1"
L.MUSICFILEMETADATA = "File metadata"
L.MUSICEXPORTEDON = "Exported: " -- Followed by date and time
L.SAVEMETADATA = "Save metadata"
L.INTERNALON = "Int.sc is on"
L.INTERNALOFF = "Int.sc is off"
L.INTERNALYESBARS = "say(-1) int.sc"
L.INTERNALNOBARS = "Loadscript int.sc"
L.SOUNDS = "Sounds"
L.GRAPHICS = "Graphics"
L.SOUNDPLAYERROR = "Can not play this sound. It may not exist or be of an unsupported type."
L.FILEOPENERNAME = "Name: "
L.PATHINVALID = "The path is invalid."
L.DRIVES = "Drives" -- like C: or F: on Windows
L.DOFILTER = "Only show *$1" -- "*.txt" for example
L.DOFILTERDIR = "Only show directories"
L.FILEDIALOGLUV = "Sorry, your operating system is unrecognized, so the file dialog does not work."

L.BTN_LOAD = "Load"
