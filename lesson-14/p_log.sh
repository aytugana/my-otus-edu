#!/usr/bin/env bash

yum install -y -q epel-release
yum install -y -q systemd-journal-gateway

mkdir -p /var/log/journal/remote
chown systemd-journal-remote:systemd-journal-remote /var/log/journal/remote

sed -i 's/https/http/g' /lib/systemd/system/systemd-journal-remote.service

systemctl daemon-reload

systemctl enable --now systemd-journal-gatewayd
systemctl enable --now systemd-journal-remote

#наблюдаем за сторонними логами
#journalctl -f -D /var/log/journal/remote