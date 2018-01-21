# Ved
This is the repository for Ved, an external editor for VVVVVV levels.

# Downloading
You can choose to download the source version, which is a `.love` file, or, if you are using Windows or Mac OS X, you can also choose to download a `.exe` or `.app` version.
## Source
You can download the latest version from the [SourcePackages](SourcePackages) folder. You'll need to download [LÖVE](https://love2d.org/) 0.9.x or 0.10.x once. After that, you should be able to double-click the `.love`, or drag it on top of the love binary (`love.exe`, `love.app` or `love`).
As long as your version of LÖVE is 0.9.0 or above and wasn't released _too_ recently, you don't really have to worry about getting a specific old version of LÖVE, even if "0.9.0 or higher" might give that impression. I try to add compatibility for new LÖVE versions soon after they're released, and if possible even earlier, without dropping compatibility for old versions.

## Windows version
You can download the latest version from the [Windows](Windows) folder. You do not need to install LÖVE, because each version comes with the required DLLs which causes one version to take up about 6 MB uncompressed. An advantage of using the Windows version and not the source version is that you can pin Ved to the taskbar or start menu.
You must extract all files to the same folder, moving out just the `.exe` will not work! It's possible that you get an error about OpenGL, especially if you have an older system, in which case you need to follow the instructions for the source version (using LÖVE 0.9.x).

## Mac OS X version
You can download the latest version from the [Mac](Mac) folder. You do not need to install LÖVE.

## Linux
On Linux, you need to use the source version, see the instructions above. For Ubuntu and its flavors, these days you can easily get LÖVE 0.9.1 with `sudo apt-get install love`.
If you really want to have a binary, you can `cat` the `.love` file to your `love` binary.

# Feedback
You can report bugs, make feature requests or ask questions on the [Idea Informer](http://ved.idea.informer.com/?show_all=0&show_idea=1&show_error=1&show_question=1&show_thank=1&show_expect=1&show_inproc=1&show_shedule=1&show_deliver=1&show_complete=1&show_when=0&orderby=2&orderasc=0). Or, if you prefer, you may use the Issues system on this repository. You can also contact me on the forums, Discord, FlockMod and whatnot, but there's a chance I'll lose track of it.

# Changelog
The official changelog can be found [here](https://tolp.nl/ved/?p=download).

# Developing plugins
For more information about developing plugins, please check [https://tolp.nl/ved/plugins.php](https://tolp.nl/ved/plugins.php).

# Translating
If you'd like to translate Ved into your own language, please send me a PM on the tOLP forum, the Distractionware forum, or post a message in one of the relevant topics/board on there, or you can contact me via Discord. If you don't know where to find any of these: tOLP is [here](https://tolp.nl/forum/index.php), Distractionware is [here](http://distractionware.com/forum/index.php) and the Discord server for VVVVVV (which has the official channel for Ved) can be found [here](https://discord.gg/Zf7Nzea).
