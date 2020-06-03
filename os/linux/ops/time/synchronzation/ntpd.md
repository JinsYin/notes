# 同步时钟、时区

## 查看时间

```sh
# 查看系统时间
$ date

# 查看 BIOS 时间（或 hwclock -r）
$ clock
```

## 修改时区

```sh
$ rm /etc/localtime

# 修改
$ ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 校验
$ date -u
2019年 11月 18日 星期一 07:55:00 UTC
```

## 同步系统时间

```sh
# ntpdate 软件包已被弃用
$ yum install -y ntp

# 同步一次时钟（停止 ntpd 为了避免 ntpdate 不能打开 socket <UDP port 123> 连接 ntp 服务器）
$ systemctl stop ntpd
$ ntpdate -s cn.pool.ntp.org

# 将系统时间写入 BIOS（系统重启后会首先读取 BIOS 时间）
$ hwclock -w

# 后台运行的 ntpd 会不断调整系统时间（具体配置：/etc/ntp.conf）
$ systemctl enable ntpd
$ systemctl start ntpd

# 校验
$ date -u # 查看系统时间
$ clock # 查看 BIOS 时间（或 hwclock -r）
```

## 最后

```sh
$ timedatectl status
      Local time: 五 2019-11-22 15:58:44 CST
  Universal time: 五 2019-11-22 07:58:44 UTC
        RTC time: 五 2019-11-22 15:58:44
       Time zone: Asia/Shanghai (CST, +0800)
     NTP enabled: yes
NTP synchronized: yes
 RTC in local TZ: no # timedatectl set-local-rtc 0
      DST active: n/a
```

## 参考

* [ntpd vs ntpdate: pros and cons](https://askubuntu.com/questions/297560/ntpd-vs-ntpdate-pros-and-cons)
* [自动调整 linux 系统时间和时区与 Internet 时间同步](http://blog.51cto.com/liumissyou/1302050)
