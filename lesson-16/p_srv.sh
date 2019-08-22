#!/usr/bin/env bash

setenforce 0
#5cee4d079821e

yum -y -q install bacula-{director,storage,console}

/usr/libexec/bacula/create_sqlite3_database && \
/usr/libexec/bacula/make_sqlite3_tables
echo "2" | alternatives --config libbaccats.so

mv /etc/bacula/bacula-dir.conf /etc/bacula/bacula-dir.conf.bkp
mv /etc/bacula/bacula-sd.conf /etc/bacula/bacula-sd.conf.bkp
cp /vagrant/bacula-dir.conf /etc/bacula/bacula-dir.conf
cp /vagrant/bacula-sd.conf /etc/bacula/bacula-sd.conf

systemctl enable --now bacula-dir
systemctl enable --now bacula-sd