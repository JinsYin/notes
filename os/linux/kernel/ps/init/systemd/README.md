# Systemd

```sh
# CentOS
$ pstree
systemd─┬─NetworkManager───2*[{NetworkManager}]
        ├─auditd───{auditd}
        ├─crond
        ├─dbus-daemon───{dbus-daemon}
        ├─irqbalance
        ├─login───bash
        ├─lvmetad
        ├─master─┬─pickup
        │        └─qmgr
        ├─rsyslogd───2*[{rsyslogd}]
        ├─sshd───sshd───bash───pstree
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-udevd
        └─tuned───4*[{tuned}]
```

| 特殊子进程        | 描述                             |
| ----------------- | -------------------------------- |
| `systemd-journal` | 管理进程日志；客户端：journalctl |
| `system-logind`   |                                  |
| `systemd-udevd`   |                                  |
| `login`           |                                  |