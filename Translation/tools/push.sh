#!/bin/bash

cd ../../../Ved-translation/

git diff
git commit -a || exit
git show
read -p 'Press ENTER to push this commit, Ctrl+C to abort'
git push
