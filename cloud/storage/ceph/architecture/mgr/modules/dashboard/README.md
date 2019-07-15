# Dashboard 模块/插件

## 目录

* [实现管理 RADOSGW](enabling-radosgw.md)
* [实现管理 iSCSI](enabling-iscsi.md)
* [实现嵌入 Grafana](enabling-grafana.md)
* [实现单点登录（SSO）](enabling-sso.md)
* [实现 Prometheus Alerting](enable-prometheus-alerting.md)

## 启用

```bash
$ ceph mgr module enable dashboard
```

## 配置

WARNING: it looks like you might be trying to set a ceph-mgr module configuration key.  Since Ceph 13.0.0 (Mimic), mgr module configuration is done with `config set`, and new values set using `config-key set` will be ignored

> 修改了配置后，需要先 disable 再 enable 才能生效
> 参考所有配置及配置历史 ceph config-key list

### SSL/TLS

* 开启
* 关

```bash
$ ceph config set mgr mgr/dashboard/ssl false
```

### IP 和端口

Dashboard 绑定到 TCP/IP 地址和 TCP 端口。如果未配置地址，将绑定到 `::`，对应于所有可用的 IPv4 和 IPv6 地址。

默认情况下，托管 Dashboard 的 `ceph-mgr` 守护进程（即当前活跃的 manager）将绑定到 TCP 端口：`8443`（SSL 开启）或 `8080`（SSL 禁用）。

* 方式一

```bash
$ ceph config set mgr mgr/dashboard/server_addr $IP
$ ceph config set mgr mgr/dashboard/server_port $PORT
```

```bash
# 如果按以下设置，会存在以下问题：
# 1. 仅在特定节点开启 Dashboard 服务
# 2. 如果该节点不是 Active ceph-mgr 节点，Dashboard 服务将一直在该地址重复重定向（所以 server_addr 必须是 Active ceph-mgr 节点的 IP）
$ ceph config set mgr mgr/dashboard/server_addr 192.168.1.176
$ ceph config set mgr mgr/dashboard/server_port 7789
```

```bash
# 如果按以下设置，会存在以下问题：
# 1. 会在所有节点开启 Dashboard 服务
# 2. Dashboard 服务的地址将使用 Active ceph-mgr 的 $name，访问 standy ceph-mgr 上的 Dashboard 服务将重定向到 http://0.0.0.0:7789
$ ceph config set mgr mgr/dashboard/server_addr 0.0.0.0
$ ceph config set mgr mgr/dashboard/server_port 7789
```

```bash
# 如果按以下设置，会存在以下问题：
# 1. 会在所有 ceph-mgr 节点上开启 Dashboard 服务
# 2. Dashboard 服务的地址将使用 Active ceph-mgr 的 $name，访问 standy ceph-mgr 上的 Dashboard 服务将重定向失败
#ceph mgr services
#{
#    "dashboard": "http://ip-192-168-1-176.ceph.ew:7789/"
#}
$ ceph config set mgr mgr/dashboard/server_port 7789

# or
$ ceph config set mgr mgr/dashboard/server_addr :: # 默认值
$ ceph config set mgr mgr/dashboard/server_port 7789
```

* 方式二

为每个 manager 实例配置各自的 IP 和端口：

```bash
# '$name' 替换为需要托管 Dashboard Web APP 的 ceph-mgr 实例的 ID（ceph status 命令即可获取到）
$ ceph config set mgr mgr/dashboard/$name/server_addr $IP
$ ceph config set mgr mgr/dashboard/$name/server_port $PORT
```

如果有 3 个 ceph-mgr 节点，三者的端口一致（建议）：

```bash
# 每个 ceph-mgr 设置各自的 IP
ceph config set mgr mgr/dashboard/ip-192-168-1-176/server_addr 192.168.1.176
ceph config set mgr mgr/dashboard/ip-192-168-1-177/server_addr 192.168.1.177
ceph config set mgr mgr/dashboard/ip-192-168-1-178/server_addr 192.168.1.178

# 所有 ceph-mgr 设置统一的端口（当然也可以不同）
ceph config set mgr mgr/dashboard/server_port 7789
```

默认会在所有 ceph-mgr 节点启动 Dashboard 服务，访问 standy ceph-mgr 会被重定向（状态码: 303）到 active ceph-mgr

```bash
# 查询存储在 MON 配置数据库中的信息
$ ceph config-key ls
--------------------
[
    ......
    "config/mgr/mgr/dashboard/ip-192-168-1-176/server_addr",
    "config/mgr/mgr/dashboard/ip-192-168-1-177/server_addr",
    "config/mgr/mgr/dashboard/ip-192-168-1-178/server_addr",
    "config/mgr/mgr/dashboard/server_port",
    "config/mgr/mgr/dashboard/ssl",
    ......
]
```

### 用户名和密码

* Mimic

登录之前，需要先设置用户名和密码（只支持一个账号），账号信息存储在 MON 的配置数据库。

```bash
$ ceph dashboard set-login-credentials admin admin
```

```bash
# 获取存储的账号信息
$ ceph config-key get config/mgr/mgr/dashboard/username
$ ceph config-key get config/mgr/mgr/dashboard/password
```

* N

从 N 版本开始，支持用户和角色管理。

## 服务

显示当前配置的使用 endpoints ：

```bash
$ ceph mgr services
```

## 设置防火墙

ansible 192.168.1.[176-178] -m shell

