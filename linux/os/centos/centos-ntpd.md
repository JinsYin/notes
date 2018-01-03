# ntpd

## 同步系统时间

```bash
$ yum install -y ntp
$ ntpdate cn.pool.ntp.org
$ hwclock -w
$ systemctl enable ntpd
$ systemctl restart ntpd
```