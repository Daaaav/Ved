#!/bin/bash

rm -rf in/po/ved/
rm -rf in/po/ved_help/

# Run pootle sync_stores, then scp -r translations/ved/ to in/po/ved/
source ~/pootle_ssh/real_download_everything.sh