# DNS Nameserver 管理

## Nameservers

| 提供商     | IP                               |
| ---------- | -------------------------------- |
| Goolge     | `8.8.8.8`、 `8.8.4.4`            |
| 电信       | `202.96.209.5`、`202.96.209.133` |
| 三大运营商 | `114.114.114.114`                |

## Debian

```bash
# 检查 resolvconf 包是否安装
$ apt-get install resolvconf

# 添加 NS
$ vi /etc/resolvconf/resolv.conf.d/head
nameserver 8.8.8.8
nameserver 8.8.4.4

# 更新 NS
$ resolvconf -u              # 方法一
$ service resolvconf restart # 方法二

# 检查 NS
$ cat /etc/resolv.conf

# man page
$ man resolvconf
```

| resolvconf 相关文件                  | 描述                                   |
| ------------------------------------ | -------------------------------------- |
| `/etc/resolvconf/resolv.conf.d/base` | 包含基础的 resolver 信息               |
| `/etc/resolvconf/resolv.conf.d/head` | 预添加到动态生成的 resolver 配置文件前 |
| `/etc/resolvconf/resolv.conf.d/tail` | 追加到动态生成的 resolver 配置文件末尾 |
| `/etc/default/resolvconf`            | 用于设置环境变量                       |

## RHEL

* 方法一

```bash
# PEERDNS=no 选项将阻止 DHCP Server 修改 /etc/resolv.conf
$ vi /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
PEERDNS=no # -_-

# 添加静态 NS
$ vi /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
```

* 方法二

```bash
# 网卡接口配置中直接设置 NS，代替修改 /etc/resolv.conf
$ vi /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
DNS1=8.8.8.8 # -_-
DNS2=8.8.4.4 # -_-
```

## 参考

* [How to configure static DNS on CentOS or Fedora](http://ask.xmodulo.com/configure-static-dns-centos-fedora.html)