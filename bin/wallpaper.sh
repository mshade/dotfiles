#!/usr/bin/env bash
###
# Rotate wallpaper

DIRECTORY="/home/mshade/.wallpaper/"
export DISPLAY=:0.0

find ${DIRECTORY} -type f -print0 | shuf -n1 -z |xargs -0 feh --bg-scale

