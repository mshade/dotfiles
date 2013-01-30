#!/usr/bin/env python2
# 
# Control ponymix, a command line pulseaudio mixer, with the 
# Griffin PowerMate.  
# Requires: python-evdev module, ponymix, a PowerMate
# by mshade@mshade.org / github.com/mshade


from evdev import InputDevice, ecodes, list_devices
from subprocess import call

# Program to call for mixer operations
mixer = "/usr/bin/ponymix"

# Set device empty to start with - detect later, bail if not found.
dev = None

def findDevice():
    # Map all accessible /dev/input devices
    devices = map(InputDevice, list_devices())

    for candidate in devices:
        # Check for PowerMate in the device name string
        if "PowerMate" in candidate.name: 
            global dev 
            dev = InputDevice(candidate.fn)

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


# Find the device
findDevice()

if dev is None:
    print "No devices found.  Is PowerMate plugged in?"
    quit()

# Open the device and start polling for events.
for event in dev.read_loop():
    # Knob turned - adjust volume up or down.
    if event.type == ecodes.EV_REL:
        volAdjust(event.value)

    # Knob pressed down - call mute toggle
    elif event.type == ecodes.EV_KEY and event.value == 01:
        volMute()
