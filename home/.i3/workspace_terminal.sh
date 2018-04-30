#!/bin/bash
[ $(ps h -C gnome-terminal-server | wc -l) = 0 ] && [ $(ps h -C urxvt | wc -l) = 0 ] && i3-sensible-terminal
