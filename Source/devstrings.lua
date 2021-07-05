-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""
L.PLAYTESTINGOPTIONS = "Playtesting"
L.PLAYTESTINGFAILED = "Something went wrong when opening VVVVVV:\n$1\n\nIf you need to change the VVVVVV executable that's used for playtesting, hold Shift while pressing the playtest button."

L.PLAYTESTING_EXECUTABLE_NOTSET = "You did not yet set a $1 executable to use for playtesting.\nVed will ask for it when playtesting a $2 level for the first time." -- $1: VVVVVV 2.3, $2: VVVVVV
L.PLAYTESTING_EXECUTABLE_SET = "The $1 executable to use for playtesting is set to:\n$2" -- $1: VVVVVV 2.3

L.VVVVVVSETUP = "VVVVVV setup" -- Settings to adapt Ved to how VVVVVV is installed/setup on this computer, like the location of the levels folder and selection of the executable for playtesting. Maybe "VVVVVV installation" or "VVVVVV configuration"

L.ALL_PLUGINS = "All plugins"
L.ALL_PLUGINS_MOREINFO = "Please go to ¤https://tolp.nl/ved/plugins.php¤this page¤ for more information about plugins.\\nLCl"
L.ALL_PLUGINS_FOLDER = "Your plugins folder is:"
L.ALL_PLUGINS_NOPLUGINS = "You do not have any plugins yet."

L.PLUGIN_NOT_SUPPORTED = "[This plugin is not supported because it requires Ved $1 or higher!]\\r"
L.PLUGIN_AUTHOR_VERSION = "by $1, version $2" -- by Person, version 1.0.0
