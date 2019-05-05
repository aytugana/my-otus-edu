#!/bin/bash

yum install -y mdadm
#узнаём на каком диске корень
root_disk=`lsblk -nlpo NAME | grep / -B 1 | head -n 1`
#считаем количество дисков кроме основного
disks_amt=`lsblk -nlpo NAME | grep -v $root_disk | wc -l`
#создаем их список
disks=`lsblk -nlpo NAME | grep -v $root_disk | xargs`
#mdadm --zero-superblock --force $disks
echo y | mdadm --create --verbose --force /dev/md0 --level=1 --raid-devices=$disks_amt $disks
cat /proc/mdstat
mkdir -p /etc/mdadm
touch /etc/mdadm/mdadm.conf
mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf
echo "Lesson 2: RAID part is done."
