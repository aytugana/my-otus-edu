#!/bin/bash

n="myservice"

cp /vagrant/$n/$n.conf /etc/sysconfig/
cp /vagrant/$n/$n.sh /usr/bin/ && chmod +x /usr/bin/$n.sh
cp /vagrant/$n/$n.service /etc/systemd/system/
echo -e "First sting\nSecond string\nCowabunga!\nFourth string" > /var/log/some.log
systemd-run --on-unit-active=30 --unit=myservice.service
systemctl start myservice.service
systemctl list-timers
grep "$n" /var/log/messages
