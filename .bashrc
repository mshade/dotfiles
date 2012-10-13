#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias ll="ls -l"
alias performance="sudo cpupower frequency-set -g performance"
alias ondemand="sudo cpupower frequency-set -g ondemand"

export PATH=~/bin:$PATH
export EDITOR="vim"

shopt -s histappend
shopt -s checkwinsize
set -o vi
