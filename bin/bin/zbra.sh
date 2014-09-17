#!/bin/bash
#
# z3bra - (c) wtfpl 2014
# Fetch infos on your computer, and print them to stdout every second.
#
# require :
#           amixer      - volume()
#           bc          - cpuload() memused()
#           curl        - netip()
#           fcount      - mails()
#           iwconfig    - netint() (to spot wifi interface)
#           mpc         - nowplaying()
#           xprop       - groups() gstate()
#           xwininfo    - gstate()

# configuration variables
refresh_rate=0.75               # how often will the bar update
datefmt="%d %b %H:%M"         # date time format
#maildir=~/var/mail/INBOX/new    # where do new mails arrive ?
alsactl=Master                  # which alsa channel to display
#battery=BAT0                    # battery index
# find battery name in a smart way
battery=$(ls /sys/class/power_supply | grep BAT)

barch=''
barfg='%{F#ff666666}'
barmg='%{F#ff2288cc}'
barbg='%{F#00888888}'

# Group characters

grpfg='%{F#ff111111} '
grpmg='%{F#ff2288cc} '
grpbg='%{F#ffbbbbbb} '

# no need to modify anything else here

clock() {
    date "+${datefmt}"
}

mails() {
    fcount ${maildir}
}

battery() {
    BATC=/sys/class/power_supply/${battery}/capacity
    BATS=/sys/class/power_supply/${battery}/status

    # prepend percentage with a '-' if discharging, '+' otherwise
    #test "`cat $BATS`" = "Discharging" && echo -n '-' || echo -n '+'

    cat $BATC
}

muted() {
    amixer get $alsactl | grep -o '\[off\]' >/dev/null && false || true
}

volume() {
    amixer get $alsactl | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p' | uniq
}

cpuload() {
    LINE=`ps -eo pcpu |grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp'`
    echo `bc <<< $LINE`
}

memused() {
    read t f <<< `grep -E 'Mem(Total|Free)' /proc/meminfo |awk '{print $2}'`
    read b c <<< `grep -E '^(Buffers|Cached)' /proc/meminfo |awk '{print $2}'`
    bc <<< "100 * ($t - $f - $c - $b) / $t"
}

netstate() {
    test -n "`ip route`" && echo "connected" || echo "disconnected"
}

netip() {
    # local ip
    ip addr show $(netint) | grep 'inet ' | awk '{print $2}'
    # extern ip
    #curl http://canihazip.com/s
}

nettrafic() {
    case $1 in
        up)     col=10;;
        down)   col=2;;
        *) 
    esac

    trafic=$(awk "/$(netint)/ {print \$$col}" /proc/net/dev)
    echo $(( trafic / 1024 ))
}

netint() {
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
    if iwconfig $int1 >/dev/null 2>&1; then
        wifi=$int1
        eth0=$int2
    else
        wifi=$int2
        eth0=$int1
    fi

    if ip link show $eth0 | grep 'state UP' >/dev/null; then
        int=$eth0
    elif ip link show $wifi | grep 'state UP' >/dev/null; then
        int=$wifi
    else
        int=lo
    fi

    echo $int
}

groups() {
    cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

    for w in `seq 0 $((cur - 1))`; do line="${line}${grpbg}"; done
    line="${line}${grpfg}"
    for w in `seq $((cur + 2)) $tot`; do line="${line}${grpbg}"; done
    line="${line}${barfg}"

    echo $line
}

# print current group and shown groups
gstate() {
    cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

    for wid in `xprop -root | sed '/_LIST(WINDOW)/!d;s/.*# //;s/,//g'`; do
        if grep -q 'IsViewable' <<< $(xwininfo -id $wid); then
            grp=`xprop -id $wid _NET_WM_DESKTOP | awk '{print $3}'`
            shown="$shown $grp"
        fi
    done

    for g in `seq 0 $((tot - 1))`; do
        if test $g -eq $cur; then
            line="${line}${grpfg}"
        elif grep -q $g <<< "$shown"; then
            line="${line}${grpmg}"
        else
            line="${line}${grpbg}"
        fi
    done

    echo $line
}

nowplaying() {
    cur=`mpc current`
    # this line allow to choose whether the output will scroll or not
    test "$1" = "scroll" && PARSER='skroll -n20 -d0.5 -r' || PARSER='cat'
    test -n "$cur" && $PARSER <<< $cur || echo "- stopped -"
}

makebar() {
    max=10
    cur=$(($1 / 10))

    bar="$barfg"

    for v in $(seq 0 $((max - 1))); do
        if [ "$v" -lt "$cur" ]; then
            bar="${bar}${barfg}${barch}"
        else
            bar="${bar}${barbg}${barch}"
        fi
    done

    echo "${bar}${barfg}"
}

# This loop will fill a buffer with our infos, and output it to stdout.
buf="%{l}%{S+} "

# Set icon depending on the interface that is up
buf="${buf}${barmg} "
if test "$(netint)" = "enp3s0"; then
    buf="${buf}${barfg}"
elif test "$(netint)" = "wlan0"; then
    buf="${buf}${barfg}"
else
    buf="${buf}${barfg}"
fi

buf="$buf $(netstate) "
buf="${buf}${barmg} ${barfg} $(nettrafic down) "
buf="${buf}${barmg} ${barfg} $(nettrafic up) "

# Aligned center
buf="${buf}%{c} $(gstate)"

# Aligned right
buf="${buf}%{r}"
buf="${buf}${barmg}  ${barfg}$(cpuload) ${barmg} ${barfg}$(memused)" # ${barfg} $(mails) "

# Change icon if volume is muted
if amixer get $alsactl | grep '\[off\]' >/dev/null; then
    buf="${buf}${barmg} ${barfg} "
else
    buf="${buf}${barmg} ${barfg} "
fi
buf="${buf}$(makebar $(volume)) "

# Show battery status if there is a battery (U DONT SAY)
test -n "${battery}" &&
    buf="${buf}${barmg} ${barfg} $(makebar $(battery)) "

buf="${buf}${barmg} ${barfg} $(clock)  "
echo $buf
sleep ${refresh_rate}
