#!/usr/bin/env bash

hstnm=$(hostname)
if [ "$hstnm" == "lesson13ipaserver" ]; then
    yum -y -q install ipa-server ipa-server-dns bind bind-dyndb-ldap
    hostnamectl set-hostname lesson13ipaserver.test

    ipa-server-install -U \
    -p dmadminpass \
    -a ipaadminpass \
    -n lesson13ipaserver \
    -r TEST \
    --hostname lesson13ipaserver.test \
    --setup-dns \
    --auto-reverse \
    --auto-forwarders \
    --mkhomedir

    ipactl status

    echo "ipaadminpass" | kinit admin

    echo "newuserpass" | \
    ipa user-add newuser \
        --first=New \
        --last=User \
        --email newuser@lesson13ipaserver.test \
        --password-expiration=20250101000000Z \
        --password
else
    yum -y -q install ipa-client
    hostnamectl set-hostname lesson13client.test

    ipa-client-install -U --mkhomedir -p admin -w ipaadminpass \
    --domain=lesson13ipaserver.test \
    --server=lesson13ipaserver.test \
    --realm=TEST \
    --hostname=lesson13client.test \
    --force-ntpd
fi
