# Heketi

Heketi 是一个基于 RESTful API 的 GlusterFS 卷管理框架。它提供 RESTful API 供 Kubernetes 调用，实现多 GlusterFS 集群的卷管理。另外，heketi 还有保证 bricks 及其对应的副本均匀地分布到集群中的不同可用区。


## 安装

在任一 GlusterFS 节点上安装

```sh
# 安装统一的版本
$ heketi_version=5.0.1
$ yum --enablerepo=centos-gluster312 install -y heketi-${heketi_version} heketi-client-${heketi_version}
```


## 参考

* [heketi/heketi](https://github.com/heketi/heketi)
