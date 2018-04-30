#!/bin/bash
if [ -x /usr/bin/keepass2 ]; then
  [ $(ps h -C cli | grep KeePass.exe | wc -l) = 0 ] && keepass2
elif [ -x /usr/bin/keepassxc ]; then
  [ $(ps h -C keepassxc | wc -l) = 0 ] && keepassxc
fi
