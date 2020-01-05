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
tmp="$HOME/Desktop/tmp"
storage="$HOME/Desktop/storage"
current="$storage/$Y/$m/$d"
symlink="$HOME/Desktop/current"

# Remove empty dirs.
# This needs to be done before save/storage/current are init'd
empty_dirs=$(find ${storage} -maxdepth 3 -type d -empty)
for dir in $empty_dirs; do rmdir ${dir}; done

# Create all folders if they don't exist
[ ! -d ${save} ] && mkdir -p ${save}
[ ! -d ${storage} ] && mkdir -p ${storage}
[ ! -d ${current} ] && mkdir -p ${current}

# Loop through and move all random items in desktop to our current dir
for item in ${clean}/*; do
    if [ "$item" != "$save" -a "$item" != "$storage" -a "$item" != "$symlink" -a "$item" != "$tmp" ]; then
        mv "$item" "$current"
    fi
done

# Remove symlink & reset
[ -L $symlink ] && rm $symlink
ln -s $current $symlink

exit 0;

