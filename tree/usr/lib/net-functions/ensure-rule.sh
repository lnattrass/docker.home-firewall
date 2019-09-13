#!/bin/bash
#
##

RULE=$@

ip rule show $RULE | grep -q '[0-9]' > /dev/null
if [ $? -ne 0 ]; then
  echo ip rule add $RULE
  ip rule add $RULE
  if [ $? -ne 0 ]; then
    exit 1
  fi
else
  echo "Rule already exists"
fi
