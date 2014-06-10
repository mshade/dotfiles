#!/usr/bin/env bash
# i3 helper to start terminals when invoked


commandstart()
{
   [[ -z $1 ]] && return || size=$1

   #i3-msg -t command 'workspace 2'
   for ((i=0; i<size; i++)); do
      windows=$(xwininfo -root -tree | grep -c 'terminal-bank')
      while ((windows < i*j + j)); do
         echo "Sleeping for 0.1s because $i, $j; $windows < $((i*j + j))"
         sleep 0.1
         windows=$(xwininfo -root -tree | grep -c 'terminal-bank')
      done
      sleep 0.1
      if [[ $i != 0 && ${commands[i-1]} ]]; then
         i3-msg -t command "${commands[i-1]}"
      fi

      sleep 0.1
      urxvt -name 'terminal-bank' &
   done
}

# L-shape:
# ┌──┬──┬──┐
# ├──┤  │  │
# ├──┤  │  │
# ├──┴─┬┴──┤
# └────┴───┘
commands=(
   [0]="split vertical"
   [3]="move right"
   [5]="move down; resize shrink height; resize shrink height; resize shrink height; split horizontal"
)

if [[ -z $@ ]]
then
   numterms='7'
else
   numterms="$@"
fi

commandstart $numterms
