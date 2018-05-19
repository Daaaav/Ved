#!/bin/bash

rm -rf in/po/

# Run pootle sync_stores, then scp -r translations/ved/ to in/po/
source ~/pootle_ssh/real_download_everything.sh

# Okay, a bit lazy - not necessary now
#mv in/po/ved/* in/po/
#rmdir in/po/ved
