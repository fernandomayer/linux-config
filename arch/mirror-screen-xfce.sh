#!/bin/bash

## To mirror screens using xrandr
## http://ianmarmour.com/2012/01/22/setting-up-dual-monitors-on-xfce-arch-linux/

## Use
# xrandr -q
## To list available (pluged) devices.
## By default
# eDP1 is the laptop screen
# VGA1 is the datashow VGA output
## CHANGE this names if necessary!!
xrandr --output eDP1 --auto --output VGA1 --auto --same-as eDP1
