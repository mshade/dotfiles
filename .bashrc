#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

if [[ -r ~/.dircolors ]] && type -p dircolors >/dev/null; then
     eval $(dircolors -b "$HOME/.dircolors")
fi

# Aliases, functions, and others
for config in .aliases .functions .bashrc."$HOSTNAME";
do
   [[ -r ~/"$config" ]] && . ~/"$config"
done

# Paths and ENV variables
export PATH=~/bin:$PATH
export EDITOR="vim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export PAGER="less"
export JDK_HOME="/usr/lib/jvm/java-7-openjdk/"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk/"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
export PYTHONPATH=$HOME/lib/python2.7/site-packages
export LESSOPEN="|/usr/bin/source-highlight %s"
export LESS=' -R'
export PS1='\[\033[00;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '

# Shell opts
shopt -s histappend
shopt -s checkwinsize
set -o vi
set -o notify

# ssh-agent setupp
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

# Greet yo'sef
fortune -a 
