# 运行时间（uptime）

## 检查系统运行时间

```sh
# 信息保存在 /proc/uptime 文件中
$ uptime
15:06:20 up 32 days,  4:09,  1 user,  load average: 0.00, 0.08, 0.11
```

如上，当前系统时间为 `15:06:20`，系统运行了 `32` 天 `4` 小时 `9` 分钟。

## 检查系统重启历史

```sh
$ last reboot
reboot   system boot  3.10.0-862.el7.x Fri Nov  2 10:56 - 15:13 (32+04:16)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 17:33 - 10:50  (17:17)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 17:27 - 17:27  (00:00)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 15:17 - 17:27  (02:10)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 15:14 - 17:27  (02:13)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 14:54 - 17:27  (02:33)
reboot   system boot  3.10.0-862.el7.x Thu Nov  1 14:11 - 14:16  (00:04)
reboot   system boot  3.10.0-862.el7.x Mon Oct 15 14:26 - 13:59 (16+23:33)
reboot   system boot  3.10.0-862.el7.x Mon Oct 15 09:17 - 13:59 (17+04:42)
reboot   system boot  3.10.0-862.el7.x Sun Sep 30 17:21 - 18:05 (12+00:44)
```