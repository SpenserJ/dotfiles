#!/bin/bash

INTERFACE_COUNT=$(ip addr show $1 | grep 'inet ' | grep global | grep -v virbr | wc -l)

if [[ $INTERFACE_COUNT -gt 0 ]]; then exit 0; fi
exit 1
