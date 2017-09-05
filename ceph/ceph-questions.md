# Ceph 问题整理

## Q1

集群部署好后如何修改默认参数，比如默认副本数、默认 PG、默认 PGP 等等？


## Q2

如何关闭 ceph-mon？

解决办法一： 在 Ceph 节点上停止服务

```bash
$ # ceph-node-1 为主机名
$ systemctl stop ceph-mon@ceph-node-1.service
$ systemctl unenable ceph-mon@ceph-node-1.service
```

解决办法二： 在 ceph-admin 节点上移除远程节点的 Ceph MON

```bash
$ ceph-deploy mon destroy ceph-node-1
```