-- The place for new strings during development of a new version, before putting them in all the language files.
-- This file gets loaded after the language files do, so keys can overwrite existing ones, and will show up in all languages.

--L. = ""

L.PLUGIN_AUTHOR = "by $1" -- already in pot

L.PLUGINS_INSTALLED = "Installed" -- List of installed plugins
L.PLUGINS_AVAILABLE = "Available" -- List of not installed plugins, available to install

L.PLUGININFO_INSTALLED_HEADER = "== Installed ==" -- Info about the installed version of this plugin
L.PLUGININFO_AVAILABLE_HEADER = "== Online ==" -- Info about the version of this plugin available from online

L.VERSION_IS = "Version: $1" -- Followed by a version number
L.INSTALLED_ON = "Installed on: $1" -- Followed by a date and time
L.LAST_UPDATED = "Last updated: $1" -- Followed by a date and time
L.DOWNLOAD_SIZE = "Size: $1" -- Followed by something like: 100 MB

L.PLUGIN_NOT_INSTALLED = "You don't have this plugin installed."
L.PLUGIN_NOT_AVAILABLE = "This plugin is not available online."
L.PLUGIN_NOT_DOWNLOADABLE = "This plugin does not have a download available for your version of Ved."

L.UPDATE = "Update"
L.UPDATENOW = "Update now"
L.INSTALL = "Install"
L.INFO = "Information" -- See information about something

L.CONFIRM_INSTALL_PLUGIN = "Install this plugin?"
L.CONFIRM_UPDATE_PLUGIN = "Update this plugin?"
L.CONFIRM_DELETE_PLUGIN = "Remove this plugin?"

L.NOTE_SAFE_PLUGINS = "Note that it's not guaranteed that all plugins are safe."
L.NOTE_RESTART_VED_DELETE = "Note that you'll need to restart Ved to see the plugin stop working."
L.DONE_INSTALLING_PLUGIN = "Done! Restart Ved to see the new plugin working."
L.RESTART_NEEDED = "Restart needed!"

L.CANNOT_DELETE_FOLDER_PLUGIN = "This plugin is a folder, please remove it manually."

L.DOWNLOAD_REQUIRES_BETTER_LOVE = "Downloading packages requires LÖVE 11.0 or higher."
L.DOWNLOAD_FAIL_GET = "Download failed."
L.DOWNLOAD_FAIL_VERIFY = "The downloaded package isn't correct. It may have changed from the expected version."
