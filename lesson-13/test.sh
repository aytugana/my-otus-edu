#!/usr/bin/env bash

ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.10.102" >> /dev/null
echo "Now testing ssh auth over ldap: "
sshpass -p newuserpass ssh -q -o StrictHostKeyChecking=no -l newuser 192.168.10.102 "whoami; hostname"
