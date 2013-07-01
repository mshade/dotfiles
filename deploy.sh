#!/usr/bin/env bash
#
# Script to deploy dotfiles repo to ~

# Enumerate all tracked files.
files=$(git ls-files)
repodir="dotfiles"
destination=$HOME

# loop over files and create symlinks/directories where necessary
cd $destination

for file in $files
do
    # Test if file exists
    if [[ -h $file ]]
    then
        echo "replacing $file with $repodir/$file"
        rm -vf $destination/$file || exit 1
        ln -s ~/$repodir/$file $destination/$file
    elif [[ -f $file ]]
    then
        echo "replacing $file with $repodir/$file"
        rm -vf $destination/$file || exit 1
        ln -s ~/$repodir/$file $destination/$file
    elif [[ -d $file ]]
    then
        echo "$file is a directory..."
    else
        echo "creating link to new $repodir/$file"
        ln -s $destination/$repodir/$file $destination/$file || \
            mkdir -p $destination/$(dirname $file) && \
            ln -s $destination/$repodir/$file $destination/$file 
    fi
done


