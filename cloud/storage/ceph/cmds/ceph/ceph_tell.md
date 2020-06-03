# ceph tell

发送一个命令给指定的 Ceph 守护进程。

## 用法

```sh
ceph tell <name (type.id)> <args> [<args>...]
```

## 示例

```sh
# 通知 monitoer 修改配置以允许删除存储池
$ ceph tell mon.\* injectargs '--mon-allow-pool-delete=true'
mon.ip-205-gw-ceph-ew: injectargs:mon_allow_pool_delete = 'true'
mon.ip-206-gw-ceph-ew: injectargs:mon_allow_pool_delete = 'true'
mon.ip-207-gw-ceph-ew: injectargs:mon_allow_pool_delete = 'true'
```
