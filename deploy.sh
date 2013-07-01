#!/usr/bin/env bash
#
# Script to deploy dotfiles repo to ~

repodir="dotfiles"
destination=$HOME

# directories to link explicitly
DIRS="bin .vim"
files=$(git ls-files |grep -v ^bin|grep -v ^.vim)

for dir in $DIRS
do
    if [[ -f $destination/$dir || -h $destination/$dir || -d $destination/$dir ]]
    then
        echo "File exists, removing and linking."
        rm -vf $destination/$dir || (echo "Deal with $dir yourself first, and then rerun." ; exit 1 )
        ln -vs $destination/$repodir/$dir $destination/$dir
    else
        echo "Creating as new"
        ln -vs $destination/$repodir/$dir $destination/$dir
    fi
done

for file in $files
do
    if [[ -f $destination/$file || -h $destination/$file ]]
    then
        rm -vf $destination/$file 
        ln -vs $destination/$repodir/$file $destination/$file
    elif [[ -d $destination/$(dirname $file) ]]
    then
        ln -vs $destination/$repodir/$file $destination/$file
    else
        if [[ -d $destination/$(dirname $file) ]]
        then
            ln -vs $destination/$repodir/$file $destination/$file
        else
            echo "Not sure what to do with $file"
        fi
    fi
done
