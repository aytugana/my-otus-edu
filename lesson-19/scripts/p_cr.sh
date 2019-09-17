#!/usr/bin/env bash

yum -y -q install epel-release
yum -y -q install nmap

sysctl net.ipv4.conf.all.forwarding=1
ip route delete default 2>&1 >/dev/null || true
ip route add 0.0.0.0/0 via 192.168.255.1 dev eth1