# hostnamectl 管理主机名

## 主机名类别

| 类别      | 含义                                                                                                                                                    |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| static    | 内核主机名，系统启动时从 `/etc/hostname` 中自动初始化                                                                                                   |
| pretty    | 供人阅读和理解，形式比较自由，可以包含特殊字符和空白                                                                                                    |
| transient | 通过网络（DHCP 或 mDNS）临时配置的主机名，默认值为 `localhost`；如果 `static` 主机名存在且不等于 **localhost**，则 `transient` 主机名为 `static` 主机名 |

## 查看所有主机名

```sh
$ hostnamectl status #  hostnamectl
 Static hostname: ip-192-168-10-160.node.k8s.ew
       Icon name: computer-server
         Chassis: server
      Machine ID: 1256343507d6421c87189b5593c6ee1d
         Boot ID: 483bd26f548b45788342dacc560c11d9
Operating System: CentOS Linux 7 (Core)
     CPE OS Name: cpe:/o:centos:centos:7
          Kernel: Linux 3.10.0-514.26.2.el7.x86_64
    Architecture: x86-64
```

* `hostname` 命令

```sh
# short name
$ hostname -s
ip-160

# FQDN
$ hostname --fqdn
ip-160.node.k8s.ew
```

## 设置所有主机名

```sh
# 将修改 static、pretty 和 transient 主机名
$ hostnamectl set-hostname <name>
```

## 设置特定主机名

```sh
# option: --static, --pretty, --transient
$ hostnamectl [option...] set-hostname <name>
```

* `pretty`

```sh
# 如果有空格或单引号，请使用双引号括起来
$ hostnamectl --pretty set-hostname "Stephen's notebook"
```

* `static`

```sh
$ hostnamectl --static set-hostname ip-160.node.k8s.ew

# 等同于以下两步操作
$ echo "ip-160.node.k8s.ew" > /etc/hostname
$ sysctl kernel.hostname="ip-160.node.k8s.ew"
```

## 清除特定主机名

```sh
# 清除并恢复默认值
$ hostnamectl [option...] set-hostname ""
```

## 远程修改主机名

```sh
# 使用 SSH 连接远程主机
$ hostnamectl [option...] set-hostname <name> -H [username]@hostname
```

## 建议

```sh
# 设置 static 主机名
$ hostnamectl --static set-hostname ip-160.node.k8s.ew

# 设置 pretty 主机名
$ hostnamectl --pretty set-hostname "Kubernetes Node"

# 设置 transient 主机名为默认值
$ hostnamectl --transient set-hostname ""
```

```sh
$ hostnamectl status # --pretty, --static
   Static hostname: ip-160.node.k8s.ew
   Pretty hostname: Kubernetes Node
         Icon name: computer-server
           Chassis: server
        Machine ID: 1256343507d6421c87189b5593c6ee1d
           Boot ID: 483bd26f548b45788342dacc560c11d9
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-514.26.2.el7.x86_64
      Architecture: x86-64
```

## 参考

* [CONFIGURING HOST NAMES USING HOSTNAMECTL](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec_configuring_host_names_using_hostnamectl)