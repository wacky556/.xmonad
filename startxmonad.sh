#!/bin/bash
stalonetray &
nm-applet &
nautilus &
exec xmonad-session
