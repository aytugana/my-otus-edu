<b>Занятие №7 - Инициализация системы. Systemd и SysV.</b>


Vagrant'ом поднимаем виртуалку, провиженим шелл-скриптами:


    1. myservice-setup.sh

        1.1 Раскидываем файлы по местам:

            myservice.conf в /etc/sysconfig

            myservice.service в /etc/systemd/system

            и myservice.sh в /usr/bin, которому сразу делаем chmod +x

            создаем log-файл с записями в /var/log/some.log

        1.2 запускаем таймер с помощью systemd-run

        1.3 стартуем сервис

        1.4 показываем активные таймеры

        1.5 показываем результат работы сервиса

    2. rewrite-fcgi.sh

        2.1 yum install все необходимые штуки

        2.2 раскомменчиваем sed'ом SOCKET и OPTIONS в конфиге spawn-fcgi

        2.3 копируем в нужное место spawn-fcgi.service

        2.4 стартуем spawn-fcgi, показываем его статус

        2.5 находим дефолтный файл httpd.service, копируем его в /etc/systemd/system/httpd@.service

        2.6 добавляем %I в нужное место httpd@.service

        2.7 получаем список занятых портов

        2.8 создаем инстансы httpd:

            для каждого инстанса создаем свой /etc/sysconfig/httpd-инстанс

            в каждый из них кладем соответствующую строку OPTIONS

            кроме того создаем для каждого из них /etc/httpd/conf/httpd-инстанс.conf

            меняем в них Listen и PidFile

            стартуем каждый инстанс, предварительно отключив SELinux, мешает =)

        2.9 показываем результаты

