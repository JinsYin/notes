# Ceph 配置基础

## 守护进程

| 集群/客户端                     | Ceph 守护进程                    |
| ------------------------------- | -------------------------------- |
| Ceph 存储集群（含 Ceph 块设备） | :base: = `ceph-osd` + `ceph-mon` |
| Ceph Manager                    | :base: + `ceph-mgr`              |
| Ceph 文件系统                   | :base:  + `ceph-mds`             |
| Ceph 对象存储                   | :base: + `radosgw`               |

每个守护进程都有一系列配置选项，每个选项都有一个默认值，通过修改这些配置选项可以调整系统行为。

## 配置文件

### 检索位置

Ceph 进程启动时会从以下位置检索配置文件：

1. `$CEPH_CONF` 环境变量
2. `-c path/path`（即 `-c` 命令行参数）
3. `/etc/ceph/$cluster.conf`
4. `~/.ceph/$cluster.conf`
5. `./$cluster.conf`（即当前工作目录）
6. `/usr/local/etc/ceph/$cluster.conf`（仅限 FreeBSD 系统）

### 内容示例

```ini
# Ceph 配置文件使用 ini 样式语法，可以使用 '#' 或 ';' 添加注释
[global]
debug ms = 0

[osd]
debug ms = 1

[osd.1]
debug ms = 10
```

## 配置区域

每个配置文件包含一个或多个区域，每个区域以 `[有效的区域名称]` 开头。

| 区域开头     | 描述                                                                                                                | 区域内容示例                                      |
| ------------ | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| **[global]** | 其下配置影响 Ceph 存储集群中所有的守护进程和客户端                                                                  | `log_file = /var/log/ceph/$cluster-$type.$id.log` |
| **[mon]**    | 其下配置影响 Ceph 存储集群中所有的 `ceph-mon` 守护进程，并覆盖 **[global]** 区域下相同的配置                        | `mon_cluster_log_to_syslog = true`                |
| **[mgr]**    | 其下配置影响 Ceph 存储集群中所有的 `ceph-mgr` 守护进程，并覆盖 **[global]** 区域下相同的配置                        | `mgr_stats_period = 10`                           |
| **[osd]**    | 其下配置影响 Ceph 存储集群中所有的 `ceph-osd` 守护进程，并覆盖 **[global]** 区域下相同的配置                        | `osd_op_queue = wpq`                              |
| **[mds]**    | 其下配置影响 Ceph 存储集群中所有的 `ceph-mds` 守护进程，并覆盖 **[global]** 区域下相同的配置                        | `mds_cache_size = 10G`                            |
| **[client]** | 其下配置影响 Ceph 存储集群中所有的 Ceph 客户端（如：挂载的 Ceph 文件系统、映射的 Ceph 块设备等），以及 RGW 守护进程 | `objecter_inflight_ops = 512`                     |

除此之外，还可以针对某个特定的守护进程或客户端指定一个区域，例如：**[mds.a]**、**[osd.6]** 、**[client.jinsyin]**、**[client.rgw.IP101]** 或 **[client.restapi]**。

* 本地配置文件中的值始终优先于 monitor 配置数据库中的值，不论它们出现在哪个区域

## 元变量（Metavariables）

当在 _配置选项值_（configuration value） 中使用元变量时，Ceph 会将元变量替换成具体值，从而简化 Ceph 存储集群的配置。

| 元变量     | 描述                                                             | 默认值 | 示例                                     |
| ---------- | ---------------------------------------------------------------- | ------ | ---------------------------------------- |
| `$cluster` | 替换为集群名称（同一硬件运行多个 Ceph 存储集群时很有用）         | ceph   | `/etc/ceph/$cluster.keyring`             |
| `$type`    | 替换为进程或守护进程的类型（如：mon、osd、mds）                  |        | `/var/lib/ceph/$type`                    |
| `$id`      | 替换为守护进程或客户端的标识符（`osd.0` => `0`，`mds.a` => `a`） |        | `/var/lib/ceph/$type/$cluster-$id`       |
| `$host`    | 替换为运行进程所在主机的主机名                                   |        |                                          |
| `$name`    | 替换为 `$type.$id`                                               |        | `/var/run/ceph/$cluster-$name.asok`      |
| `$pid`     | 替换为守护进程的 PID                                             |        | `/var/run/ceph/$cluster-$name-$pid.asok` |

## Monitor 的配置数据库 / Monitor 配置中心

Monitor 集群管理着整个集群可以使用的配置选项数据库，从而为整个系统实现简化的集中配置管理。

集群的配置选项由 Monitor 集群集中管理

大多数配置选项存储在 Monitor 集群，少数存储在本地配置文件。

### section & mask

### 配置集群的 CLI 命令

| 命令                                                           | 描述                                                                         |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `ceph config dump`                                             | 输出集群的全部配置数据库                                                     |
| `ceph config get <who> {val}`                                  | 输出 Monitor 的配置数据库中某个守护进程或客户端（如：`mds.a`）的（某个）配置 |
| `ceph config set <who> <option> <value>`                       | 在 Monitor 的配置数据库中设置配置选项                                        |
| `ceph config show <who>`                                       |                                                                              |
| `ceph config assimilate-conf -i <input file> -o <output file>` |                                                                              |

## 帮助

## 运行时修改（Runtime Changes）

## 查看运行时设置

## 运行时配置

* 运行时修改守护进程的配置选项

* 运行时临时设置守护进程的配置选项

* 查看运行时守护进程的配置选项

| 命令格式                         | 示例 |
| -------------------------------- | ---- |
| `ceph config show <who> {<key>}` | ``   |


| 行为                                                    | 命令及描述                                 | 示例 |
| ------------------------------------------------------- | ------------------------------------------ | ---- |
| 修改运行时守护进程的配置选项                            | * `ceph config set <who> <option> <value>` |      |
| 临时修改运行时守护进程的配置选项（进程重启后丢失/丢弃） | * `ceph config set <who> <option> <value>` |      |
| 查看运行时守护进程的配置选项                            | * `ceph config show` <br> * `ceph daemon`  |      |