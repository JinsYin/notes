# Ceph 配置

## 守护进程

| daemon     | 描述                          |
| ---------- | ----------------------------- |
| `ceph-mon` | Ceph Monitor 守护进程         |
| `ceph-osd` | Ceph OSD 守护进程             |
| `ceph-mds` | Ceph Metadata Server 守护进程 |
| `radosgw`  | Ceph Rados Gateway 守护进程   |
| `mgr`      |                               |

每个守护进程都有一系列默认值，但可以使用 Ceph 配置文件来覆盖这些默认值。

## 配置文件

Ceph 配置文件定义了：

* 集群身份
* 认证配置
* 集群成员
* 主机名
* 主机 IP
* keyring 路径
* 日志路径
* 数据路径
* 其他运行时选项

默认的 Ceph 配置文件位置的优先级顺序（由强到弱）：

1. `$CEPH_CONF` 环境变量
2. `-c path/path` 命令行参数
3. `/etc/ceph/ceph.conf`
4. `~/.ceph/config`
5. `./ceph.conf`

## 配置分段

| section    | 实例                                 | 描述                                                                 |
| ---------- | ------------------------------------ | -------------------------------------------------------------------- |
| `[global]` | auth supported = cephx               | 其下配置影响集群内的所有守护进程                                     |
| `[osd]`    | osd journal size = 1000              | 其下配置影响集群内的所有 `ceph-osd` 进程，并覆盖 `[global]` 下的设置 |
| `[mon]`    | mon addr = 10.0.10.100:6789          | 其下配置影响集群内的所有 `ceph-mon` 进行，并覆盖 `[global]` 下的设置 |
| `[mds]`    | host = myserver01                    | 其下配置影响集群内的所有 `ceph-mds` 进行，并覆盖 `[global]` 下的设置 |
| `[client]` | log file = /var/log/ceph/radosgw.log | 其下配置影响所有客户端（如 Ceph 文件系统、挂载的块设备等）           |

覆盖 `global` 设置有两种方式：

1. 在 `[osd]`、`[mon]`、`[mds]` 下更改某一类进程的配置
2. 更改某个特定进程的配置，如 `[osd.1]`

配置某个 Ceph 网关客户端（用 `.` 分隔守护进程和实例）：

```ini
[client.radosgw.instance-name]
# settings affect client.radosgw.instance-name only.
```

> Note：OSD 的实例 ID 只能是数字，Monitor 和 MDS 的 ID 可包含字母和数字

## 元变量（metavariable）

元变量大大简化了集群配置，Ceph 会把配置的元变量展开为具体值，可用在配置文件的 `[global]`、`[osd]`、`[mon]`、`[mds]` 段。

| 元变量     | 示例                                | 描述                                                              |
| ---------- | ----------------------------------- | ----------------------------------------------------------------- |
| `$cluster` | `/etc/ceph/$cluster.keyring`        | 展开成集群名；默认值为 `ceph`                                     |
| `$type`    | `/var/lib/ceph/$type`               | 展开成 `mds`、`osd`、`mon` 中的一个；其值取决于当前守护进程的类型 |
| `$id`      | `/var/lib/ceph/$type/$cluster-$id`  | 展开成守护进程的标识符；`osd.0` 为 `0`，`mds.a` 为 `a`            |
| `$name`    | `/var/run/ceph/$cluster-$name.asok` | 展开成 `$type.$id`                                                |
| `$host`    | -                                   | 展开成当前守护进程的主机名                                        |

## 通用设置

每个节点都可以用 `host` 选项设置主机名，Monitor 还需要用 `addr` 选项指定网络地址和端口（即域名或 IP）。基本配置文件可以只指定最小配置：

```ini
[global]
mon_initial_members = ceph1
mon_host = 10.0.0.1
```

> **host** 选项是此节点的短名称，不是全域名（FQDN），也不是 IP 地址；指定 **hostname -s** 获取。不要给初始 MOnitor 之外的其他进程设置 **host**，除非你想手动部署；一定不能用于 chef 或 ceph-deploy，这些工具会自动获取正确结果。

## Monitor 配置

```ini
[mon.a]
host = hostName
mon addr = 10.10.10.10:6789
```

## 客户端配置

```ini
[client]
mon host = 10.10.10.10 # :6789
```

## 运行时配置

### 修改

Ceph 可以在运行时修改 `ceph-osd`、`ceph-mon`、`ceph-mds` 守护进程的配置，此功能在增加/降低日志输出、启用/禁用调试设置、甚至是运行时优化是非常有用。

配置方法：

```bash
# {daemon-type}: osd、mon、mds
$ ceph tell {daemon-type}.{id or *} injectargs --{name} {value} [--{name} {value}]
```

```bash
$ ceph tell osd.0 injectargs --debug-osd 20 --debug-ms 1
debug_osd=20/20 debug_ms=1/1
```

### 查看

```bash
# ceph daemon {daemon-type}.{id} config show | less
$ ceph daemon osd.0 config show | less # 需要在 osd.0 所在的主机运行，确保 /var/run/ceph/ceph-osd.0.asok 存在
```

## 参考

https://github.com/ceph/ceph/blob/master/src/sample.ceph.conf

http://docs.ceph.com/docs/hammer/rados/configuration/ceph-conf/