#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias ll="ls -l"

export PATH=$PATH:~/bin
export EDITOR="vim"

shopt -s histappend
shopt -s checkwinsize

