<h1><b>Ansible</b></h1>

<h2>1. Основное задание</h2>

<h4>1.1 Vagrant файл</h4>

Создаем vagrantfile, в котором:

    - описываем конфигурацию хоста

    - передаем хост на провижнинг ansible'у

<h4>1.2 Структура</h4>

Создаем несколько файлов:

    .
    ├── ansible.cfg --- конфигурация ansible'а
    ├── provision
    │   └── playbook.yml --- сценарий
    ├── staging
    │   └── hosts --- список хостов для провижнинга
    ├── templates
    │   └── nginx.conf.j2 --- шаблон nginx.conf
    └── Vagrantfile

<h4>1.3 Playbook и ко.</h4>

В файле playbook.yml:

    - указываем хост на котором будем запускать сценарий

    - создаем переменную с номером порта

    - создаем обработчики сервиса nginx для старта и перезапуска

    - создаем задания установки epel, nginx и переопределения его конфигурации

    - в заданиях дёргаем нужные обработчики

В файле nginx.conf.j2 находится минимальный шаблон для старта nginx, вызывающий переменную nginx_listen_port

Файл hosts содержит в себе список хостов нк которых будет запущен сценарий

<i>все эти файлы перенёс в папку PLAIN-ANSIBLE</i>

<h2>2. Дополнительное задание - роль</h2>

<h4>2.1 Создание роли</h4>

шаблон роли создается командой ansible-galaxy init <имя роли>

<h4>2.2 Перераспределение playbook'а</h4>

Заголовочную часть playbook'а помещаем в файл role.yml - name, hosts, итд

туда же добавляем раздел roles в котором описываем список ролей;

    - в файл handlers/main.yml переносим обработчики добавил тест жив ли nginx)

    - в файл tasks/main.yml - задания

    - в templates/ переносим шаблон конфига

    - в vars/main.yml переменную с номером порта

<h2>PROFIT</h2>