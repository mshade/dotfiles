#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [[ -r ~/.dircolors ]] && type -p dircolors >/dev/null; then
     eval $(dircolors -b "$HOME/.dircolors")
fi

fortune -a 

# Aliases, functions, and others
for config in .aliases .functions .bashrc."$HOSTNAME";
do
   [[ -r ~/"$config" ]] && . ~/"$config"
done

# Paths and ENV variables
export PATH=~/bin:$PATH
export EDITOR="vim"
export VISUAL="$EDITOR"
export BROWSER="chromium"
export PAGER="less"
export JDK_HOME="/usr/lib/jvm/java-7-openjdk/"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

# Shell opts
shopt -s histappend
shopt -s checkwinsize
set -o vi
set -o notify
