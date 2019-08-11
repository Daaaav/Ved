Just for my reference (and transparency), here's more information about these scripts and how to work with them. There's less here than there is, for various reasons.

# Preparing a lua template and .pot templates
This needs to be done whenever the strings get updated (or when starting out altogether).

Starting with the bare .lua language files in the `Source/lang/` folder for Ved, you can run `./create_template_pot.lua`. This will create `Template.lua`, which is a lua language file template with all strings replaced by tokens, which are the same as the keys. It will also create gettext PO template files which can be uploaded to Pootle.

# Uploading new templates to Pootle
Whenever the strings are changed, after running `./create_template_pot.lua` to create new templates, simply run `./upload_new_templates.sh`. This will copy the template files to the translations folder in Pootle, and will then update the files and database as described [here](http://docs.translatehouse.org/projects/pootle/en/stable-2.8.x/server/project_setup.html).

# Downloading all translations from Pootle
To download everything, simply run `./download_everything.sh`. This will sync the Pootle stores, then download all the language folders to in/po/.

# Converting a .po to a lua language file
After downloading everything, and making sure `Template.lua` is up-to-date, you can run `./create_lua_from_po.lua xx`. This will create a `(Language name).lua` file in the `out/` directory, which should be directly copyable to the Ved lang folder.

# Converting a translated lua language file to a .po
In case someone translates the lua file directly, it can be converted to PO format. The script `create_language_po.lua` can be used for that. Add the language file to `Source/lang/`, then add it to the array in `inc.lua`. Then run the script, for example: `./create_language_po.lua xx`. Then create the language in Pootle, download the files for offline translation, and copy over the revision IDs (unless they are 0, in that case try starting translation inside Pootle or something before downloading), make a zip of the po files, and upload them again inside Pootle.
