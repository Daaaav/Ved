Just for my reference (and transparency), here's more information about these scripts and how to work with them. There's less here than there is, for various reasons. For example, the tools assume you have a `Ved-translation` Git repository folder, next to the folder for the Ved repository.

# Updating strings
When making new strings for Ved before they're ready for translation, you can define them in `Source/devstrings.lua` to make them work in all languages, like so:

```lua
L.THEMES = "Themes"
L.THEMESTITLE = "Theme settings"
```

To prepare them for translation, move them into `Source/lang/en.pot`.

In this `tools` folder, run the script `./before_push.lua`, which copies all English text from Ved into the `Ved-translation` folder. For the regular language files, this is a simple copy from Ved to Ved-translation. For the help, this generates .pot files based off the English .txt files.

Afterwards, run the script `./push.sh`, which makes a commit and pushes it.

# Downloading all translations from Weblate
Assuming Weblate has committed and pushed all changes (check Operations > Repository maintenance to be sure), you can run `./pull.sh` to pull the `Ved-translation` repo.

Then run `./after_pull.lua` to copy (and if needed, convert) them to the correct places in Ved.
