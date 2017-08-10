# CentOS SeLinux

## 临时操作

```bash
$ #　Permissive
$ setenforce 0
$
$ # Enforcing
$ setenforce 1
$
$ # 查看
$ getenforce
```

## 永久操作

```bash
$ sed -i -e 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config
```