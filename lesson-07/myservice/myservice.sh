#!/bin/bash

conf="/etc/sysconfig/myservice.conf"

source $conf
nfound=0
now_lines=$(wc -l $logfile | awk '{print $1}')
if [ $past_lines -lt $now_lines ];
    then
        shift=$(( $now_lines - $past_lines ))
        nfound=$(tail -n $shift $logfile | grep "$keyword" | wc -l)
        if [ $nfound -gt 0 ];
            then
                logger "$(date +"%b %d %H:%M:%S") myservice: $nfound inclusions found since the last scan"
        fi
fi
sed -i "s/past_lines=$past_lines/past_lines=$now_lines/" $conf