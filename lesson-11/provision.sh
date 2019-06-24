#!/usr/bin/env bash

pw="12345678qaz"

yum install docker -y -q
groupadd admin
adduser user1 && usermod --password $(openssl passwd -1 $pw) user1 -G admin
adduser user2 && usermod --password $(openssl passwd -1 $pw) user2

### Разрешаем вход через ssh только в рабочие дни

cp /vagrant/workday.sh /usr/sbin/workday
chmod +x /usr/sbin/workday

cp /etc/pam.d/sshd /etc/pam.d/sshd.original
sed -i '2s@^@auth required pam_exec.so /usr/sbin/workday\n@' /etc/pam.d/sshd
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd.service

### Разрешаем пользователю user2 работу с docker и его перезапуск
echo -e "user2	ALL=NOPASSWD:/usr/bin/docker *, /usr/bin/systemctl restart docker\n" >> /etc/sudoers

### Тесты
echo -e "\n\n### Проверим права на docker для пользователя user2"

echo -e "\n\nПроверяем разрешение на рестарт (успех, если пусто)\n"
su - user2 -c "echo $pw | sudo -S systemctl restart docker"

echo -e "\n\nПроверяем разрешение на стоп (успех, если ругнётся)\n"
su - user2 -c "echo $pw | sudo -S systemctl stop docker"

echo -e "\n\nПроверяем возможность использования (успех, если не ругнется)\n"
su - user2 -c "echo $pw | sudo -S docker run hello-world"

echo -e "\n\n	DONE	\n\n"
