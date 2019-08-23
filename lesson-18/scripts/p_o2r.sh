#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
ip route delete default 2>&1 >/dev/null || true
ip route add 192.168.0.0/24 via 192.168.255.5 dev eth1
ip route add 192.168.2.0/24 via 192.168.255.5 dev eth1
ip route add 192.168.255.8/30 via 192.168.255.5 dev eth1
ip route add 0.0.0.0/0 via 192.168.255.5 dev eth1