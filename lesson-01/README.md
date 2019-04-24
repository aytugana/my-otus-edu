#lesson-01

2019-04-24 17:57:25	yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 wget

2019-04-24 17:58:05	cd /usr/src/

2019-04-24 17:58:11	wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.9.tar.xz

2019-04-24 17:59:37	tar -xvf linux-5.0.9.tar.xz 

2019-04-24 18:00:08	cd linux-5.0.9

2019-04-24 18:00:24	uname -sr

2019-04-24 18:00:55	cp /boot/config-3.10.0-957.el7.x86_64 .config

2019-04-24 18:14:47	make menuconfig

2019-04-24 18:15:51	mkdir /lib/modules/5.0.9

2019-04-24 18:16:21	make -j32 bzImage

2019-04-24 18:20:40	make -j32 modules

2019-04-24 18:28:51	make -j32

2019-04-24 18:31:17	make install

#здесь вывалились варнинги, но на вид всё вроде встало как надо

2019-04-24 18:33:22	make -j32 modules_install

2019-04-24 18:35:54	reboot

2019-04-24 18:38:21	uname -r 

#оказалось, что грузится дефолтное ядро

2019-04-24 18:40:07	grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2

2019-04-24 18:40:24	grub2-editenv list

2019-04-24 18:41:47	grub2-set-default "CentOS Linux (5.0.9) 7 (Core)"

2019-04-24 18:41:49	grub2-editenv list

#принудительно в grub.cfg указал какое ядро грузить

2019-04-24 18:42:11	reboot 

#5.0.9 не завелась... загрузлся в дефолтное ядро

2019-04-24 18:49:33	cd /usr/src/linux-5.0.9

2019-04-24 18:49:41	make install

2019-04-24 18:53:26	make modules_install

#на удивление со второй попытки всё прошло без ошибок

2019-04-24 18:55:48	reboot 

2019-04-24 18:56:33	uname -sr

Linux 5.0.9

#done
