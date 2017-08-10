# Linux Crontab

## 定义

```bash
$ cat /etc/crontab
 ┌───────────── 分 (0 - 59)
 │ ┌───────────── 时 (0 - 23)
 │ │ ┌───────────── 日 (1 - 31)
 │ │ │ ┌───────────── 月 (1 - 12)
 │ │ │ │ ┌───────────── 周 (0 - 6)
 │ │ │ │ │
 │ │ │ │ │
 * * * * *  command to execute
```

```bash
$ # 查看
$ crontab -l
$
$ # 临时编辑
$ crontab -e
$
$ # 永久编辑
$ vi /etc/crontab
```


## Examples

* 每隔 5 分钟执行一次

```
*/5 * * * * date >> /tmp/dateinfo
```

* 每天 23:30 执行一次任务

```
30 23 * * * date >> /tmp/dateinfo
```

* 每月的 1、10、20 日执行一次任务

```
21 10 1,10,20 * * date >> /tmp/dateinfo
```

* 晚上 11 点到早上 8 点之间每隔 2 个小时，以及早上 8 点执行一次任务

```
0 23-7/2,8 * * * date >> /tmp/dateinfo
```