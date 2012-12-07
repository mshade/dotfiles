#!/usr/bin/env bash
#

# Set to manual control
echo 1 | sudo tee /sys/devices/platform/applesmc.768/fan1_manual > /dev/null

# Read fan rpm from input and echo to /sys file.

echo $1 |sudo tee /sys/devices/platform/applesmc.768/fan1_output
