#!/bin/sh
#

# Kick this off in the background:
/usr/local/bin/primary-backup.sh $1 &

[ ! -f /run/network/dmz-config ] && exit 0

case "$1" in
  primary)
    s6-svc -u /run/s6/services/dhcp-relay
    s6-svc -wu -u /run/s6/services/dmz-network
    ;;
  backup)
    s6-svc -d /run/s6/services/dhcp-relay
    s6-svc -wd -d /run/s6/services/dmz-network
    ;;
  fault)
    s6-svc -d /run/s6/services/dhcp-relay
    s6-svc -wd -d /run/s6/services/dmz-network
    ;;
  *)
    logger "ERROR: unknown state transition"
    echo "Usage: primary-backup.sh {primary|backup|fault}"
    exit 1
    ;;
esac



exit 0
