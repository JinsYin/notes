# timedatectl

控制系统时间和周期

## 用法

```sh
timedatectl [OPTIONS...] {COMMAND}
```

## 用例

| 用例                 | 描述                          |
| -------------------- | ----------------------------- |
| `timedatectl status` | 查看系统时间和 RTC 的当前设置 |

## 示例

```sh
$ timedatectl status
      Local time: 五 2019-11-22 16:29:10 CST
  Universal time: 五 2019-11-22 08:29:10 UTC
        RTC time: 五 2019-11-22 08:29:09
       Time zone: Asia/Shanghai (CST, +0800)
     NTP enabled: yes
NTP synchronized: yes
 RTC in local TZ: no # timedatectl set-local-rtc 0
      DST active: n/a
```
