# Ntpd

## 同步系统时间

```sh
apt-get install -y ntp
ntpdate cn.pool.ntp.org
hwclock -w
update-rc.d ntp defaults
service ntp restart
```
