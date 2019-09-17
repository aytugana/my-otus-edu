#!/usr/bin/env bash

yum -y -q install epel-release
yum -y -q install nginx
systemctl enable --now nginx

ip route delete default 2>&1 >/dev/null || true
ip route add 0.0.0.0/0 via 192.168.0.1 dev eth1
