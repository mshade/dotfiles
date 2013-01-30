#!/usr/bin/env python2

from evdev import InputDevice, ecodes
from subprocess import call

dev = InputDevice('/dev/input/event5')

mixer = "/usr/bin/ponymix"

def volAdjust(amt):
    vol_increase = [ mixer, "increase"]
    vol_decrease = [ mixer, "decrease"]

    if amt > 0:
        vol_increase.append(str(amt))
        call(vol_increase)
    if amt < 0:
        vol_decrease.append(str(abs(amt)))
        call(vol_decrease)

def volMute():
    vol_mute = [ mixer, "toggle"]
    call(vol_mute)

for event in dev.read_loop():
    # Knob turned - adjust volume up or down.
    if event.type == ecodes.EV_REL:
        volAdjust(event.value)

    elif event.type == ecodes.EV_KEY and event.value == 01:
        volMute()
