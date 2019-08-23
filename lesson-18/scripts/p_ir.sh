#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
iptables -t nat -A POSTROUTING ! -d 192.168.0.0/22 -o eth0 -j MASQUERADE
ip route add 192.168.0.0/24 via 192.168.255.2 dev eth1
ip route add 192.168.1.0/24 via 192.168.255.2 dev eth1
ip route add 192.168.2.0/24 via 192.168.255.2 dev eth1
ip route add 192.168.255.4/30 via 192.168.255.2 dev eth1
ip route add 192.168.255.8/30 via 192.168.255.2 dev eth1