#!/bin/bash

child () {
    (ch_start=$(date +%s%N | cut -b1-13)
    renice $1 $BASHPID &> /dev/null

    for ((i=1;i<=1000;i++)); 
    do
        cat /dev/urandom | head -n 10 | sha512sum >> /dev/null
    done
    ch_stop=$(date +%s%N | cut -b1-13)
    echo "Время выполнения процесса $BASHPID с проиоритетом $1 (μs):" $(( $ch_stop - $ch_start )) | tee -a homework5-5.log) &
}

echo "Старт скрипта, дождитесь завершения" | tee homework5-5.log
child 1
child 10
wait $!
echo "Выполнение завершено" | tee -a homework5-5.log
