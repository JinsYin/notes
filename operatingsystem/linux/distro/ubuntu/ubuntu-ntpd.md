# ntpd

## 同步系统时间

```bash
apt-get install -y ntp
ntpdate cn.pool.ntp.org
hwclock -w
update-rc.d ntp defaults
service ntp restart
```