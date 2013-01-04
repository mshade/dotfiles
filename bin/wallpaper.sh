#!/usr/bin/env bash
###
# Rotate wallpaper

DIRECTORY="/home/mshade/.wallpaper/"
export DISPLAY=:0.0

# Use provided image, if argument given

if [[ -z $1 ]]
then
   find ${DIRECTORY} -type f -print0 | shuf -n1 -z |xargs -0 feh --bg-scale
   exit 0
fi

feh --bg-scale $1

