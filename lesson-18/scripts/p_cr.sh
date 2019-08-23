#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
ip route delete default 2>&1 >/dev/null || true
ip address add 192.168.0.33/28 dev eth3:1
ip link set eth3:1 up
ip address add 192.168.0.65/26 dev eth4:1
ip link set eth4:1 up
ip route add 192.168.1.0/24 via 192.168.255.6 dev eth4
ip route add 192.168.2.0/24 via 192.168.255.10 dev eth3
ip route add 0.0.0.0/0 via 192.168.255.1 dev eth1