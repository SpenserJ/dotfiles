#!/bin/sh
# https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/info-pingrtt/info-pingrtt.sh

HOST=8.8.8.8

if ! ping=$(ping -n -c 1 -W 1 $HOST); then
  echo ""
  exit 1
fi

rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

echo "$rtt ms"
