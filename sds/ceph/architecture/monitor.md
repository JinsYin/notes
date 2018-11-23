# Monitor

Monitor 节点需要足够的磁盘空间来存储集群日志，健康集群产生几 MB 到 GB 的日志。如果 Log Level 较低，可能需要几 GB 的磁盘空间。

对于任何读写操作请求，客户端从 Monitor 节点获取 Cluster Map 后，直接与 OSD 进行 I/O 操作，不需要 Monitor 干预。

每个 Monitor 维护着 ClusterMap 的一个主副本（master copy），意味着客户端只需要连接一个 Monitor，就可以确定所有 Monitor、OSD Daemon 和 MDS 服务的位置。

## 配置管理

```bash
# 查询某个 Monitor 的配置
$ ceph -n mon.0 --show-config

# 查询所有 Monitor 的配置
$ ceph -n mon.* --show-config
```

当 OSD 出现故障时（磁盘或者网络故障），如果在 `600s` 内没有得到回复，Monitor 会将该 OSD 标记为 `Down`，之后集群自动进行恢复操作。

```bash
$ ceph -n mon.* --show-config | grep 'mon_osd_down_out_interval'
mon_osd_down_out_interval = 600
```

## monmap

```bash
# 获取 monitor map
$ ceph mon getmap -o {tmp}/{filename}

# 查看 monitor map 信息
$ monmaptool --print {tmp}/{filename}
```