#!/bin/sh -e
#
if [ "$1" == "" ]; then
  echo "Usage: $0 <interface>"
  exit 1
fi

ip address show $1 | grep 'inet ' | awk '{ print $2 }' | cut -f1 -d/
