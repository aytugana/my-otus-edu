#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
ip route delete default 2>&1 >/dev/null || true
ip address add 192.168.2.193/26 dev eth4:1
ip link set eth4:1 up
ip route add 192.168.0.0/24 via 192.168.255.9 dev eth1
ip route add 192.168.1.0/24 via 192.168.255.9 dev eth1
ip route add 192.168.255.4/30 via 192.168.255.9 dev eth1
ip route add 0.0.0.0/0 via 192.168.255.9 dev eth1