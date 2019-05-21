#!/bin/bash

hertz=$(getconf CLK_TCK)
list=$(ls -1 /proc/ | egrep "[0-9]{1,}" | sort -h)
for pid in $list
do
    if [ -d /proc/$pid ]; then
        pid_lnk=$(readlink /proc/$pid/fd/0);
        pid_tty=$([ -z $pid_lnk ] || [ "$pid_lnk" = "/dev/null" ] && echo "?" || echo "$pid_lnk" | awk -F '/dev/' '{print $2}')
        pid_state=$(cat /proc/$pid/status | awk '/State:/ {print $2}')
        pid_name=$(cat /proc/$pid/cmdline | tr "\0" " ")
        pid_cmd=$([ -z "$pid_name" ] && cat /proc/$pid/status | awk '/Name:/ {print "["$2"]"}' || echo "$pid_name" )
        pid_time=$(cat /proc/$pid/stat | awk -v herts=$hertz '{ print int((($14+$15)/herts)/60)":"int((($14+$15)/100)%60) }' | gawk -F ":" '{print $1":"strftime("%S",$2)}')
        out+=("$pid|$pid_tty|$pid_state|$pid_time|$pid_cmd\n")
    fi
done
echo -e ${out[@]} | column -t -s "|"
