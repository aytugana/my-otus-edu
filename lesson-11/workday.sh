#!/usr/bin/env bash

todate=$(date +%Y%m%d)
dayoff=$(curl -s https://isdayoff.ru/$todate)

username=$PAM_USER

if groups $username | grep &>/dev/null '\badmin\b'; then
    #logger "[myauth]: You're always welcome, $username!"
    exit 0
else
    if [[ $dayoff -eq 0 ]]; then
        #logger "[myauth]: Welcome back, my dear peon."
        exit 0
    else
        #logger "[myauth]: Today is a holiday. Go and have a rest."
        exit 503
    fi
fi

# 0 - рабочий день, 1 - не рабочий
# 0 - success,      1 - fail

# полезный набор данных
# https://data.gov.ru/opendata/7708660670-proizvcalendar
# но isdayoff.ru проще