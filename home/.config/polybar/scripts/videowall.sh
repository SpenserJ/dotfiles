#!/bin/bash

PID=$(pgrep -x videowall)

case "$1" in
--toggle)
  if [ -n "$PID" ]; then
    kill -SIGTERM $PID
  else
    videowall > /dev/null 2>&1 &
  fi
  ;;
*)
  if [ -n "$PID" ]; then
    echo "Running"
  else
    echo "Stopped"
  fi
  ;;
esac
