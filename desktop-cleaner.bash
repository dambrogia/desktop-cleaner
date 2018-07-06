#!/bin/bash

# #
# Package: Desktop Cleaner
# Author: Dominic Dambrogia
# Version: 1.0.0
# Website: dambrogia.com
# Email: domdambrogia+desktopcleaner@gmail.com
# #

Y=`date '+%Y'`
m=`date '+%m'`
d=`date '+%d'`

# Directory vars
clean="$HOME/Desktop"
save="$HOME/Desktop/save"
storage="$HOME/Desktop/storage"
current="$storage/$Y/$m/$d"
symlink="$HOME/Desktop/current"

# Create current folder if doesn't exist
mkdir -p ${current}

# Loop through and move all random items in desktop to our current dir
for item in ${clean}/*; do
    if [ "$item" != "$save" -a "$item" != "$storage" -a "$item" != "$symlink" ]; then
        mv $item $current
    fi
done

# Remove symlink & reset
[ -L $symlink ] && rm $symlink
ln -s $current $symlink

exit 0;

