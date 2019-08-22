#!/usr/bin/env bash

setenforce 0
yum -y -q install bacula-client

### Генерируем файлы для шифрования
openssl req -nodes -new -x509 -keyout client.key -out client.cert -days 3650 -subj "/C=NT/ST=None/L=Nope/O=Nah/OU=Not/CN=no.no"
openssl req -nodes -new -x509 -keyout master.key -out master.cert -days 3650 -subj "/C=NT/ST=None/L=Nope/O=Nah/OU=Not/CN=no.no"
openssl rsa -in client.key -out client-clear.key
cat client-clear.key client.cert > client.pem
cp client.pem /etc/bacula/
cp master.cert /etc/bacula/
###

mv /etc/bacula/bacula-fd.conf /etc/bacula/bacula-fd.conf.bkp
cp /vagrant/bacula-fd.conf /etc/bacula/bacula-fd.conf

systemctl enable --now bacula-fd