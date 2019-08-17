#!/usr/bin/env bash

yum install -y -q epel-release
yum install -y -q nginx systemd-journal-gateway

sed -i 's/^#MaxLevelStore=debug/MaxLevelStore=crit/g' /etc/systemd/journald.conf
sed -i 's/no/yes/g' /etc/audisp/plugins.d/syslog.conf #аудит -> сислог
echo "-w /etc/nginx -p wa -k nginx_watch" >> /etc/audit/rules.d/audit.rules

#отдаём логи в логстэш
echo "URL=http://192.168.10.142:19532" >> /etc/systemd/journal-upload.conf
sed -i 's/^.*access_log.*$/access_log syslog:server=192.168.10.143:5400,tag=nginx_access_log,severity=info;/g' /etc/nginx/nginx.conf
sed -i '1ierror_log syslog:server=192.168.10.143:5400,tag=nginx_error_log,severity=info;' /etc/nginx/nginx.conf
sed -i '1ierror_log /var/log/nginx/error.log crit;' /etc/nginx/nginx.conf

systemctl enable --now nginx
systemtl restart systemd-journald
service auditd restart
systemctl enable --now systemd-journal-upload

#тесты
echo "testing audit" >> /etc/nginx/test.file
curl -s 'http://localhost?LOGGING_OK' >> /dev/null
curl -s 'http://localhost/ERROR_PAGE' >> /dev/null
logger "UNIQ MSG FOR RMT SYSLOG"