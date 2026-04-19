#!/bin/bash

cd ../../../Ved-translation/

git commit -am 'Update English templates with new strings' || exit
git show
read -p 'Press ENTER to push this commit, Ctrl+C to abort'
git push
