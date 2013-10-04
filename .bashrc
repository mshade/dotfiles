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
export LESS=' -R'
export PS1='\[\033[00;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '
export LESS_TERMCAP_mb=$'\E[01;36m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

# perl
PERL5LIB="/home/mshade/perl5/lib/perl5:"
PERL_MB_OPT="--install_base /home/mshade/perl5"
PATH="/home/mshade/perl5/bin:/home/mshade/bin:/home/mshade/GNUstep/Tools:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/platform-tools:/opt/kde/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
PERL_LOCAL_LIB_ROOT=":/home/mshade/perl5"
PERL_MM_OPT="INSTALL_BASE=/home/mshade/perl5"

# Shell opts
shopt -s histappend
shopt -s checkwinsize
set -o vi
set -o notify

# ssh-agent setupp
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

# Greet yo'sef
fortune -a 

