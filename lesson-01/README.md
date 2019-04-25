<code>#lesson-01</code>
<br><code>2019-04-24 17:57:25</code>&nbsp;yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 wget
<br><code>2019-04-24 17:58:05</code>&nbsp;cd /usr/src/
<br><code>2019-04-24 17:58:11</code>&nbsp;wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.9.tar.xz
<br><code>2019-04-24 17:59:37</code>&nbsp;tar -xvf linux-5.0.9.tar.xz 
<br><code>2019-04-24 18:00:08</code>&nbsp;cd linux-5.0.9
<br><code>2019-04-24 18:00:24</code>&nbsp;uname -sr
<br><code>2019-04-24 18:00:55</code>&nbsp;cp /boot/config-3.10.0-957.el7.x86_64 .config
<br><code>2019-04-24 18:14:47</code>&nbsp;make menuconfig
<br><code>2019-04-24 18:15:51</code>&nbsp;mkdir /lib/modules/5.0.9
<br><code>2019-04-24 18:16:21</code>&nbsp;make -j32 bzImage
<br><code>2019-04-24 18:20:40</code>&nbsp;make -j32 modules
<br><code>2019-04-24 18:28:51</code>&nbsp;make -j32
<br><code>2019-04-24 18:31:17</code>&nbsp;make install
<br><code>#здесь вывалились варнинги, но на вид всё вроде встало как надо</code>
<br><code>2019-04-24 18:33:22</code>&nbsp;make -j32 modules_install
<br><code>2019-04-24 18:35:54</code>&nbsp;reboot
<br><code>2019-04-24 18:38:21</code>&nbsp;uname -r 
<br><code>#оказалось, что грузится дефолтное ядро</code>
<br><code>2019-04-24 18:40:07</code>&nbsp;grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
<br><code>2019-04-24 18:40:24</code>&nbsp;grub2-editenv list
<br><code>2019-04-24 18:41:47</code>&nbsp;grub2-set-default "CentOS Linux (5.0.9) 7 (Core)"
<br><code>2019-04-24 18:41:49</code>&nbsp;grub2-editenv list
<br><code>#принудительно в grub.cfg указал какое ядро грузить</code>
<br><code>2019-04-24 18:42:11</code>&nbsp;reboot 
<br><code>#5.0.9 не завелась... загрузился в дефолтное ядро</code>
<br><code>2019-04-24 18:49:33</code>&nbsp;cd /usr/src/linux-5.0.9
<br><code>2019-04-24 18:49:41</code>&nbsp;make install
<br><code>2019-04-24 18:53:26</code>&nbsp;make modules_install
<br><code>#на удивление со второй попытки всё прошло без ошибок</code>
<br><code>2019-04-24 18:55:48</code>&nbsp;reboot 
<br><code>2019-04-24 18:56:33</code>&nbsp;uname -sr
<br>Linux 5.0.9
<br><code>#done</code>
