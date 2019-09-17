#!/usr/bin/env bash

sysctl net.ipv4.conf.all.forwarding=1
ip route add 192.168.0.0/24 via 192.168.255.2 dev eth1

pw="12345678qaz"
adduser user1 && usermod --password $(openssl passwd -1 $pw) user1
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd reload

# порты для knocking'а - 50910 50920 22 в течение 60 секунд
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type any -j ACCEPT
iptables -N KNOCK_FOR_SSH
iptables -A INPUT -j KNOCK_FOR_SSH
iptables -N SSH_ALLOW_SET
iptables -A KNOCK_FOR_SSH -m state --state NEW -m tcp -p tcp -m recent --rcheck --seconds 60 --dport 22 --name KNOCK_2 -j ACCEPT
iptables -A KNOCK_FOR_SSH -m state --state NEW -m tcp -p tcp -m recent --name KNOCK_2 --remove -j DROP
iptables -A KNOCK_FOR_SSH -m state --state NEW -m tcp -p tcp -m recent --rcheck --dport 50920 --name KNOCK_1 -j SSH_ALLOW_SET
iptables -A SSH_ALLOW_SET -m recent --set --name KNOCK_2 -j DROP
iptables -A KNOCK_FOR_SSH -m state --state NEW -m tcp -p tcp -m recent --name KNOCK_1 --remove -j DROP
iptables -A KNOCK_FOR_SSH -m state --state NEW -m tcp -p tcp -m recent --set --dport 50910 --name KNOCK_1 -j DROP
iptables -A KNOCK_FOR_SSH -j DROP
iptables -A INPUT -i eth1 -j DROP
