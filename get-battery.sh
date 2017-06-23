#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -f2 -d":" |  sed -e 's/^[ \t]*//'
