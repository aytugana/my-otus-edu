<code><code>#lesson-01</code></code>
<code><br>2019-04-24 17:57:25</code>&nbsp;yum install -y ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel grub2 wget
<code><br>2019-04-24 17:58:05</code>&nbsp;cd /usr/src/
<code><br>2019-04-24 17:58:11</code>&nbsp;wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.9.tar.xz
<code><br>2019-04-24 17:59:37</code>&nbsp;tar -xvf linux-5.0.9.tar.xz 
<code><br>2019-04-24 18:00:08</code>&nbsp;cd linux-5.0.9
<code><br>2019-04-24 18:00:24</code>&nbsp;uname -sr
<code><br>2019-04-24 18:00:55</code>&nbsp;cp /boot/config-3.10.0-957.el7.x86_64 .config
<code><br>2019-04-24 18:14:47</code>&nbsp;make menuconfig
<code><br>2019-04-24 18:15:51</code>&nbsp;mkdir /lib/modules/5.0.9
<code><br>2019-04-24 18:16:21</code>&nbsp;make -j32 bzImage
<code><br>2019-04-24 18:20:40</code>&nbsp;make -j32 modules
<code><br>2019-04-24 18:28:51</code>&nbsp;make -j32
<code><br>2019-04-24 18:31:17</code>&nbsp;make install
<code><br><code>#здесь вывали</code>лись варнинги, но на вид всё вроде встало как надо</code>
<code><br>2019-04-24 18:33:22</code>&nbsp;make -j32 modules_install
<code><br>2019-04-24 18:35:54</code>&nbsp;reboot
<code><br>2019-04-24 18:38:21</code>&nbsp;uname -r 
<code><br><code>#оказалось, ч</code>то грузится дефолтное ядро</code>
<code><br>2019-04-24 18:40:07</code>&nbsp;grep "^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2
<code><br>2019-04-24 18:40:24</code>&nbsp;grub2-editenv list
<code><br>2019-04-24 18:41:47</code>&nbsp;grub2-set-default "CentOS Linux (5.0.9) 7 (Core)"
<code><br>2019-04-24 18:41:49</code>&nbsp;grub2-editenv list
<code><br><code>#принудительн</code>о в grub.cfg указал какое ядро грузить</code>
<code><br>2019-04-24 18:42:11</code>&nbsp;reboot 
<code><br><code>#5.0.9 не зав</code>елась... загрузлся в дефолтное ядро</code>
<code><br>2019-04-24 18:49:33</code>&nbsp;cd /usr/src/linux-5.0.9
<code><br>2019-04-24 18:49:41</code>&nbsp;make install
<code><br>2019-04-24 18:53:26</code>&nbsp;make modules_install
<code><br><code>#на удивление</code> со второй попытки всё прошло без ошибок</code>
<code><br>2019-04-24 18:55:48</code>&nbsp;reboot 
<code><br>2019-04-24 18:56:33</code>&nbsp;uname -sr
<br>Linux 5.0.9
<br><code>#done</code>
