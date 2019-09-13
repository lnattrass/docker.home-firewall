#!/bin/bash -e
#
#
##

FROM="$1"; shift
TO="$1"; shift
MATCH=$@

if [ $# -lt 2 ]; then
  echo "Usage: $0 from-table to-table selector"
  exit 1
fi

ip route show table $FROM $MATCH | while read route; do
  ip route add table $TO $MATCH $route
done