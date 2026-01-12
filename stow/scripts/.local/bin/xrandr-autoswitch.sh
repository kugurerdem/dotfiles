#!/bin/bash

INTERNAL="eDP"
EXTERNAL="HDMI-A-0"

if xrandr | grep "$EXTERNAL connected" >/dev/null; then
    xrandr --output "$EXTERNAL" --primary --auto
    xrandr --output "$INTERNAL" --off
else
    xrandr --output "$INTERNAL" --primary --auto
    xrandr --output "$EXTERNAL" --off
fi

