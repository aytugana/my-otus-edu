Занятие №6 - Дистрибьюция софта

Vagrant'ом разворачиваем машинку

Шелл скриптами проходим несколько этапов:

1. startup.sh - унстанавливает первоначалаьно необходимые пакеты

  redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc

2. rpmbuild.sh:

    2.1 скачивает исходники mc
  
    2.2 распаковывает srpm пакет
  
    2.3 патчит спеку - добавляем патч для mc
  
    2.4 устанавливает зависимости указанные в спеке
  
    2.5 собираем пакет 
  
    2.6 создаем репозиторий в папке с готовыми пакетами
  
3. installdocker.sh - собсна устанавливаем докер и стартуем его

4. rundocker.sh:

    4.1 стартуем контейнер с прибинденными конфигом для nginx и папкой репозитория
  
    4.2 curl'ом показываем, что nginx показывает то, что надо
  

ИТОГО:

  - создали пакет с изменённым mc - изменен дефолтный скин
  
  - создали репозиторий
  
  - создали и запустили докер образ с репозиторием 
  
