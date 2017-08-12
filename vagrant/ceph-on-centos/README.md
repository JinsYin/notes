# Ceph On Vagrant For CentOS

`vagrant up` 启动虚拟机后默认会在所有节点安装并部署好相应的 ceph 服务。由于使用 `ceph-deploy install` 命令来安装 ceph 总是失败，所以改用源的方式来安装。

## 集群分布

hostname      | ip            | role          | components |
------------- | ------------- | ------------- | -------------
ceph-admin    | 172.1.72.10   | ceph-mon radosgw  | ceph ceph-radosgw ceph-deploy |
ceph-server-1 | 172.1.72.11   | ceph-mon ceph-osd | ceph |
ceph-server-2 | 172.1.72.12   | ceph-mon ceph-osd | ceph |

其中，上面的 ceph 包括 ceph-base、ceph-common、ceph-selinux、ceph-osd、ceph-mon、ceph-osd、ceph-mds 等组件（`rpm -qa | grep ceph*`）。

> 注意：直接通过源来安装 ceph 时默认不会安装 ceph-radosgw、ceph-release 等组件，而通过 `ceph-deploy install` 来安装时会自动安装。


## 部署

```bash
$ # 添加 vagrant 的 insecure_private_key 到 ssh-agent 确保虚拟机与虚拟机之间可以免密钥登录
$ ssh-add ~/.vagrant.d/insecure_private_key
```

```bash
$ # 启动虚拟机并自动部署 ceph
$ vagrant up
$
$ # 如果是重启可以不执行 provision，也就是不执行部署脚本
$ vagrant reload --no-provision
```

```bash
$ # 更新虚拟机与宿主机的 hosts 文件，可以直接通过主机名来访问
$ vagrant hostmanager
```


## 校验

* ceph-admin

```bash
$ vagrant ssh ceph-admin
[vagrant@ceph-admin ~]$ ceph -s
cluster 15ddcfcd-c993-4704-a141-4c4bb3c9b2b8
 health HEALTH_OK
 monmap e1: 3 mons at {ceph-admin=172.1.72.10:6789/0,ceph-node-1=172.1.72.11:6789/0,ceph-node-2=172.1.72.12:6789/0}
        election epoch 6, quorum 0,1,2 ceph-admin,ceph-node-1,ceph-node-2
 osdmap e20: 2 osds: 2 up, 2 in
        flags sortbitwise,require_jewel_osds
  pgmap v83: 112 pgs, 7 pools, 1588 bytes data, 171 objects
        12965 MB used, 63733 MB / 76698 MB avail
             112 active+clean
[vagrant@ceph-admin ~]$ 
[vagrant@ceph-admin ~]$ 
[vagrant@ceph-admin ~]$ sudo netstat -tpln | grep -E "(ceph*|radosgw)"
tcp        0      0 0.0.0.0:7480            0.0.0.0:*               LISTEN      5522/radosgw        
tcp        0      0 172.1.72.10:6789        0.0.0.0:*               LISTEN      4769/ceph-mon
```

* ceph-server

```bash
$ vagrant ssh ceph-server-1
[vagrant@ceph-server-1 ~]$ ceph -s
[vagrant@ceph-server-1 ~]$ 
[vagrant@ceph-server-1 ~]$ 
[vagrant@ceph-server-1 ~]$ sudo netstat -tpln | grep ceph*
tcp        0      0 0.0.0.0:6800            0.0.0.0:*               LISTEN      5574/ceph-osd       
tcp        0      0 0.0.0.0:6801            0.0.0.0:*               LISTEN      5574/ceph-osd       
tcp        0      0 0.0.0.0:6802            0.0.0.0:*               LISTEN      5574/ceph-osd       
tcp        0      0 0.0.0.0:6803            0.0.0.0:*               LISTEN      5574/ceph-osd       
tcp        0      0 172.1.72.11:6789        0.0.0.0:*               LISTEN      4957/ceph-mon 
```


## 参考

  * [codedellemc/vagrant - GitHub](https://github.com/codedellemc/vagrant/tree/master/ceph)