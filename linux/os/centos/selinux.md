# CentOS SeLinux

## 临时关闭

```bash
#　Permissive
$ setenforce 0

# Enforcing
$ setenforce 1

# 查看
$ getenforce
```

## 永久关闭

```bash
$ sed -i -e 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config
$
$ reboot
```