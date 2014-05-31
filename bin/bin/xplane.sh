#!/usr/bin/env bash

# A unique grep pattern for your joystick. See /proc/bus/input/devices.
name="AV8R"

# The left/right axis, and the up/down axis. Use jstest to find this out.
xaxis=5
zaxis=6

# Executable paths
jhat=~/bin/jhat
#xplane=/data/xplane/X-Plane-i686
xplane="./X-Plane-i686"

## end configuration

for d in /sys/class/input/js*; do
    if grep -q "$name" $d/device/input:input*/name 2>/dev/null; then
	dev=/dev/input/`basename $d`
    fi
done

dev=/dev/input/js0

if [ -z "$dev" ]; then
    echo "Alas, the joystick to match '$name' was not found."
    exit 1
fi

$jhat $dev $xaxis $zaxis &
pid=$!

#cd `dirname "$xplane"`
"$xplane"

kill $pid
