# Linux Systemd

## 操作

* 启动

```sh
$ systemctl start docker.service
```

* 开机自启动

```sh
$ systemctl enable docker.service
```

* 重启

```sh
# 重新加载 service
$ systemctl daemon-reload

$ systemctl restart docker.service
```

* 查看状态

```sh
$ systemctl status docker.service
```

* 查看日志

```sh
$ journalctl -xe
```

* 查看 service 内容

```sh
# 方法一
$ systemctl cat docker.service

# 方法二
$ cat /usr/lib/systemd/system/docker.service
```

* 查看 unit 是否存在

```sh
$ systemctl list-unit-files | grep docker.service
```

* 查看启动的 unit

```sh
$ systemctl list-units | grep docker.service
```

## 参考

* https://www.freedesktop.org/software/systemd/man/systemd.unit.html
* https://www.freedesktop.org/software/systemd/man/hostnamectl.html