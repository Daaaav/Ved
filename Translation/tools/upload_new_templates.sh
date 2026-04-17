#!/bin/bash

cd ../../../Ved-translation/

git commit -m 'Update English templates with new strings' || exit
git diff
read -p 'Press ENTER to push this commit, Ctrl+C to abort'
git push
