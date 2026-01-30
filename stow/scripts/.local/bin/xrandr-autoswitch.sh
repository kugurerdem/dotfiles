#!/bin/bash

INTERNAL="eDP"
EXTERNAL="HDMI-A-0"

if xrandr | grep "$EXTERNAL connected" >/dev/null; then
    xrandr --output "$EXTERNAL" --primary --mode 2560x1440 --auto
    xrandr --output "$INTERNAL" --off
else
    xrandr --output "$INTERNAL" --primary --mode 1920x1080 --auto
    xrandr --output "$EXTERNAL" --off
fi

