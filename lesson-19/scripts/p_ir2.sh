#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
ip route add 192.168.0.0/24 via 192.168.250.2 dev eth1

# проброс на centralServer c nginx
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.2:80
# подмена без маскарада
iptables -t nat -A POSTROUTING --dst 192.168.0.2 -p tcp --dport 80 -j SNAT --to-source 192.168.250.1
