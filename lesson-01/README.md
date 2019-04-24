<code>#lesson-01</code>
<br>2019-04-24 17:57:25&nbsp;yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 wget
<br>2019-04-24 17:58:05&nbsp;cd /usr/src/
<br>2019-04-24 17:58:11&nbsp;wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.9.tar.xz
<br>2019-04-24 17:59:37&nbsp;tar -xvf linux-5.0.9.tar.xz 
<br>2019-04-24 18:00:08&nbsp;cd linux-5.0.9
<br>2019-04-24 18:00:24&nbsp;uname -sr
<br>2019-04-24 18:00:55&nbsp;cp /boot/config-3.10.0-957.el7.x86_64 .config
<br>2019-04-24 18:14:47&nbsp;make menuconfig
<br>2019-04-24 18:15:51&nbsp;mkdir /lib/modules/5.0.9
<br>2019-04-24 18:16:21&nbsp;make -j32 bzImage
<br>2019-04-24 18:20:40&nbsp;make -j32 modules
<br>2019-04-24 18:28:51&nbsp;make -j32
<br>2019-04-24 18:31:17&nbsp;make install
<br><code>#здесь вывалились варнинги, но на вид всё вроде встало как надо</code>
<br>2019-04-24 18:33:22&nbsp;make -j32 modules_install
<br>2019-04-24 18:35:54&nbsp;reboot
<br>2019-04-24 18:38:21&nbsp;uname -r 
<br><code>#оказалось, что грузится дефолтное ядро</code>
<br>2019-04-24 18:40:07&nbsp;grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
<br>2019-04-24 18:40:24&nbsp;grub2-editenv list
<br>2019-04-24 18:41:47&nbsp;grub2-set-default "CentOS Linux (5.0.9) 7 (Core)"
<br>2019-04-24 18:41:49&nbsp;grub2-editenv list
<br><code>#принудительно в grub.cfg указал какое ядро грузить</code>
<br>2019-04-24 18:42:11&nbsp;reboot 
<br><code>#5.0.9 не завелась... загрузлся в дефолтное ядро</code>
<br>2019-04-24 18:49:33&nbsp;cd /usr/src/linux-5.0.9
<br>2019-04-24 18:49:41&nbsp;make install
<br>2019-04-24 18:53:26&nbsp;make modules_install
<br><code>#на удивление со второй попытки всё прошло без ошибок</code>
<br>2019-04-24 18:55:48&nbsp;reboot 
<br>2019-04-24 18:56:33&nbsp;uname -sr
<br>Linux 5.0.9
<br><code>#done</code>
