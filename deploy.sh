#!/usr/bin/env bash
#
# Script to deploy dotfiles repo to ~

# Enumerate all tracked files.
files=$(git ls-files)
repodir="./dotfiles"
destination=$HOME

# loop over files and create symlinks/directories where necessary
cd $destination

for file in $files
do
    # Test if file exists
    if [[ -f $file ]]
    then
        echo "replacing $file with $repodir/$file"
        rm $file && ln -s $repodir/$file $file
    else
        echo "creating link to $repodir/$file"
        ln -s $repodir/$file $file
    fi
done


