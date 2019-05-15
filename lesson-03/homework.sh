#!/bin/bash

echo "🔍 Поиск в fail2ban IP адреса $1 ..."

#функция для сопоставления аргумента с ячейкой из массива
haveIP () {
  local ip match="$1" #задаем переменные
  shift 
  for ip; do [[ "$ip" == "$match" ]] && return 0; done #цикл сопоставления выводящий его результат
  return 1
}

#получаем список джэйлов
list=`fail2ban-client status | grep Jail | awk '{ s = ""; for (i = 4; i <= NF; i++) s = s $i " "; print s }'`

#пихаем список в массив
IFS=', ' read -r -a jails <<< "$list"

#проходимся по джэйлам
for cell in "${jails[@]}"
    do
        #добываем список айпи адресов находящихся в джэйле
        stringIPs=`fail2ban-client status $cell | grep Banned | awk '{ s = ""; for (i = 5; i <= NF; i++) s = s $i " "; print s }'`
        #пихаем их в массив
        IFS=', ' read -r -a arrayIPs <<< "$stringIPs"
        #производим сравнение искомого адреса с адресами в массиве
        haveIP "$1" "${arrayIPs[@]}"
        #далее в зависимости от результата сравнения разбаниваем, если надо
        if [[ 1 -eq $? ]]
            then
                echo "Jail \"$cell\" - НЕ найден ✔️ "
            else
                echo "Jail \"$cell\" - НАЙДЕН! 👻 "
                if whiptail --yesno "Убрать $1 из '$cell'?" 7 60 ;then
                    echo "$(fail2ban-client set $cell unbanip $1;) был разбанен. 🙈  "
                else
                    echo "$1 не был разбанен. 🤔 "
                fi
        fi
done
