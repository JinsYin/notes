# CentOS SeLinux

## 临时关闭

```sh
# Permissive
$ setenforce 0

# Enforcing
$ setenforce 1

# 查看
$ getenforce
```

## 永久关闭

```sh
$ sed -i -e 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config
$
$ reboot
```
