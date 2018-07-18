# Linux Systemd

## 操作

* 启动

```bash
$ systemctl start docker.service
```

* 开机自启动

```bash
$ systemctl enable docker.service
```

* 重启

```bash
# 重新加载 service
$ systemctl daemon-reload

$ systemctl restart docker.service
```

* 查看状态

```bash
$ systemctl status docker.service
```

* 查看日志

```bash
$ journalctl -xe
```

* 查看 service 内容

```bash
# 方法一
$ systemctl cat docker.service

# 方法二
$ cat /usr/lib/systemd/system/docker.service
```

* 查看 unit 是否存在

```bash
$ systemctl list-unit-files | grep docker.service
```

* 查看启动的 unit

```bash
$ systemctl list-units | grep docker.service
```

## 参考

* https://www.freedesktop.org/software/systemd/man/systemd.unit.html
* https://www.freedesktop.org/software/systemd/man/hostnamectl.html