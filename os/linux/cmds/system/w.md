# w

`w` 命令可以查看哪些用户在登录以及他们在做什么。

## 用户

* 关机前检查是否有其他用户在使用以及他们在做什么

## 示例

* Linux

```sh
$ w
 10:03:35 up 60 days, 47 min,  6 users,  load average: 0.40, 0.47, 0.65
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    192.168.8.220    10:03    1.00s  0.00s  0.00s w
root     pts/1    192.168.18.219   二15   23:19m  0.09s  0.09s -bash
root     pts/2    192.168.18.219   三09   17:52m  0.11s  0.11s -bash
root     pts/3    192.168.18.219   三09   43:01m 11:36  11:36  top
root     pts/4    192.168.18.219   三09    2days  1:29m  1:28m nethogs
root     pts/6    192.168.8.220    1211月18  1:19   2.45s  0.47s ssh root@192.168.100.210
```

* macOS

```sh
$ w
22:44  up 28 days, 38 mins, 8 users, load averages: 2.33 1.93 1.96
USER     TTY      FROM              LOGIN@  IDLE WHAT
in       console  -                15 619  25days -
in       s001     -                22:44       - -bash
in       s002     -                22:44       - -bash
in       s003     -                22:44       - -bash
in       s005     -                22:44       - -bash
_mbsetupuser console  -                15 619  25days -
in       s007     -                22:44       - w
in       s006     -                22:44       - -bash
```
