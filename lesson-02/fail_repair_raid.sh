#!/bin/bash

echo "################################################################################"
mdadm /dev/md0 --fail /dev/sdb
cat /proc/mdstat
mdadm -D /dev/md0
mdadm /dev/md0 --remove /dev/sdb
mdadm /dev/md0 --add /dev/sdb
cat /proc/mdstat
mdadm -D /dev/md0
echo "################################################################################"
