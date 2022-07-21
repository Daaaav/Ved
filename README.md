# Ved
This is the repository for Ved, an external editor for VVVVVV levels.

# Downloading
You can choose to download the source version, which is a `.love` file, or you can also choose to download an `.exe`, `.app`, or `.AppImage` version (depending on your operating system).

The main place to download Ved is [https://tolp.nl/ved/download](https://tolp.nl/ved/download). That page has the changelog (including for the upcoming version) and download links for each version.

## Source
You can download the latest version from [here](https://tolp.nl/ved/files/download/love/). You'll need to download [LÖVE](https://love2d.org/) 0.9.1+, 0.10.x or 11.x once. After that, you should be able to double-click the `.love`, or drag it on top of the love binary (`love.exe`, `love.app` or `love`).

As long as your version of LÖVE is 0.9.1 or above and wasn't released _too_ recently, you don't really have to worry about getting a specific old version of LÖVE, even if "0.9.1 or higher" might give that impression. I try to add compatibility for new LÖVE versions soon after they're released, and if possible even earlier, without dropping compatibility for old versions.

## Windows version
You can download the latest version from [here](https://tolp.nl/ved/files/download/win/). You do not need to install LÖVE, because each version comes with the required DLLs. An advantage of using the Windows version and not the source version is that you can pin Ved to the taskbar or start menu.

You must extract all files to the same folder, moving out just the `.exe` will not work!

Other than the typical "Windows protected your PC" (just click "More info" and then "Run anyway") if you get an error when trying to start Ved, you might need to follow the instructions for the source version. If you have an old enough system, you might need to specifically use LÖVE 0.9.1 or 0.9.2 (especially if the error is about OpenGL). If you have a 32-bit system, just use 32-bit LÖVE.

## macOS version
You can download the latest version from [here](https://tolp.nl/ved/files/download/mac/). You do not need to install LÖVE.

If you get "Ved cannot be opened because the developer cannot be verified" - you might be used to this by now - right click (or control+click) the app, and select Open, which gives you the option to open the app. Or go to System Preferences > Security & Privacy > Open Anyway. If *that* didn't work and you're completely stuck, you might need to run `sudo spctl --global-disable` in a Terminal. Or `sudo spctl --master-disable`

## Linux
Since Ved 1.10.0, you can download the latest version as an AppImage from [here](https://tolp.nl/ved/files/download/lin/). You may only need to mark it executable, and then you should be able to run it directly as a binary.

You can also use the source version, see the instructions above. For Ubuntu and its flavors, you can easily get a supported version of LÖVE with `sudo apt install love`. Unless you use 14.04 or older. (If/When Ved drops support for LÖVE 0.9.1, 18.04's version will be too old too, but that will probably not happen very soon.)

Do not install love via Snap! Ved will be too sandboxed to access your VVVVVV levels folder. Use `apt install love` instead of `snap install love`.

# Feedback
For places where you can report bugs, make feature requests or ask questions, see [this page](https://tolp.nl/ved/feedback) on the website.

# Changelog
The official changelog can be found [here](https://tolp.nl/ved/download).

# License (BSD)
The license can be found at [Source/license.txt](Source/license.txt).

# Developing plugins
For more information about developing plugins, please check [https://tolp.nl/ved/plugins.php](https://tolp.nl/ved/plugins.php).

# Translating
If you'd like to translate Ved into your own language, please send me a PM on the tOLP forum, the Distractionware forum, or post a message in one of the relevant topics/board on there, or you can contact me via Discord. If you don't know where to find any of these: tOLP is [here](https://tolp.nl/forum/index.php), Distractionware is [here](http://distractionware.com/forum/index.php) and the Discord server for VVVVVV (which has the official channel for Ved) can be found [here](https://discord.gg/Zf7Nzea).
