#!/bin/bash

yum install epel-release -y -q && yum install spawn-fcgi php php-cli mod_fcgid httpd -y -q

sed -i 's/^#SOCKET/SOCKET/g' /etc/sysconfig/spawn-fcgi
sed -i 's/^#OPTIONS/OPTIONS/g' /etc/sysconfig/spawn-fcgi

cp /vagrant/fcgi/spawn-fcgi.service /etc/systemd/system/

systemctl start spawn-fcgi
systemctl status spawn-fcgi

servicefile=$(repoquery -l httpd | grep 'httpd.service')
cp $servicefile /etc/systemd/system/httpd@.service
conffile=$(awk -F "=" '/EnvironmentFile/ {print $2}' /etc/systemd/system/httpd@.service)
sed -i "s@^EnvironmentFile=$conffile@EnvironmentFile=$conffile-%I@g" /etc/systemd/system/httpd@.service

ports=$(ss -4tlnH | awk '/:/ { print $4}' | awk -F ":" '{print $2}') #ipv4 ports in use
hostnames=(foxtrot uniform charlie kilo)
minport=8000
maxport=8100
setenforce 0
for i in "${hostnames[@]}"; #add unused port for hostname
do
    egrep -v "^#|^$" $conffile > $conffile-$i
    echo "OPTIONS=-f conf/httpd-$i.conf" >> $conffile-$i
    for (( port=$minport; port<=$minport+$maxport; port++ )); do
        if [[ "${ports[@]}" =~ "${port}" ]]; then
            (( minport++ ))
        else
            egrep -v "^#|^$| ?#" /etc/httpd/conf/httpd.conf > /etc/httpd/conf/httpd-$i.conf
            sed -i "s/Listen.*/Listen $port/g" /etc/httpd/conf/httpd-$i.conf
            echo "PidFile /var/run/httpd-$i.pid" >> /etc/httpd/conf/httpd-$i.conf
            systemctl start httpd@$i
            (( minport++ ))
            break
        fi
    done
done
ps x | grep httpd
ss -tln sport ge 8000
