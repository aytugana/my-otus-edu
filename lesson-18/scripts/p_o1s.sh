#!/usr/bin/env bash

ip route delete default 2>&1 >/dev/null || true
ip route add 0.0.0.0/0 via 192.168.2.65 dev eth1