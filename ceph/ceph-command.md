# Ceph 命令

配置
```bash
# 修改配置后需要更新其他ceph-node上 (ceph-admin)
$ ceph-deploy --overwrite-conf config push {node(s)}
```

重启服务
```bash
$ systemctl restart ceph-osd@3.service # 在对应节点上重启 osd.3
$ systemctl restart ceph-mon@centos191.service # 在 centos191 节点上重启 ceph-mon
$ systemctl restart　ceph-radosgw@rgw.centos192.service # 在 centos192 节点上重启 ceph-radosgw
```


## 集群状态

```bash
$ ceph health
$ ceph status # ceph -s
$ ceph osd stat
$ ceph osd dump
$ ceph mon dump
$ ceph quorum_status -f json-pretty
```

## MON 

```bash
$ ceph mon rm centos203 # 移除 monitor
```


## OSD (Object Storage Device)

```bash
$ ceph osd tree　# 查看 osd 权重和运行状态（存储路径： osd.1 --> /var/lib/ceph/osd/ceph-1）
$ ceph osd dump # 查看 osd 和 pool 等详细信息
$ ceph osd pool create mypool 64 64 # 创建存储池（数字分别表示 pg_num　和　pgp_num）
```

```bash
# 查看对象的存储位置信息
# obj1　存储在　pg 2.7 上，即 /var/lib/ceph/osd/ceph-[2,0]/current/2.7_head 
$ ceph osd map mypool obj1
osdmap e45 pool 'mypool' (2) object 'obj1' -> pg 2.6cf8deff (2.7) -> up ([2,0], p2) acting ([2,0], p2)
```

```bash
$ ceph osd down 0 # down 掉一个 osd
$ ceph osd rm 0 # 删除一个 osd（移除一个 osd 之前应该先 down 掉，确保数据同步到其他节点上了）
$ ceph osd crush rm osd.0 # 删除一个 osd 磁盘的 crush map
$ ceph osd crush rm centos194　# 删除一个 osd 的　host 节点
$ ceph osd out osd.3 # 逐出集群
$ ceph osd int osd.3 #　加入集群
```


## RBD (Rados Block Device)

docker 使用　ceph 块存储存储 docker volume，它对应 ceph rbd 中的　image。

```bash
$ rbd create myimage --size 1024 --pool mypool # 创建镜像（默认池是 rbd，单位：MB）
$ rbd ls --pool mypool # 查看池中镜像，缩写: rbd ls mypool
$ rbd info mypool/myimage # 镜像信息，同　rbd info (--image) myimage --pool mypool
$ rbd rm mypool/myimage # 删除镜像
$ rbd cp mypool/myimage mypool/newimage # 拷贝镜像
$ rbd rename mypool/myimage mypool/img # 重命名
```

```bash
$ rbd resize mypool/myimage --size 2048 # 扩容，
$ rbd resize mypool/myimage --size 512 --allow-shrink # 缩容
```

```bash
#
$ rbd snap create mypool/myimage@mysnap # 创建快照（可多个）
$ rbd snap ls mypool/myimage # 查看镜像快照
$ rbd snap rm mypool/myimage@mynap # 删除 myimage 镜像的某个快照
$ rbd snap purge mypool/myimage # 删除　myimage 镜像的所有快照
```

```bash
$ rbd showmapped # 查看本机所有映射，用 lsblk 检查看看
$ rbd unmap /dev/rbd1 # 取消本机对 /dev/rbd1　的映射
```


## RADOS

```bash
$ rados mkpool mypool # pg_num、pgp_num 为默认，ceph osd pool create mypool 64 64
$ rados rmpool mypool # 删除存储池，ceph osd pool rm mypool
$ rados lspools　# 查看所有存储池，ceph osd pool ls
```

```bash
$ rados ls --pool mypool # 查询指定池中的所有 objects
$ rados df # 池容量、object　个数等信息
$ rados put obj1 /etc/hosts --pool mypool # 上传文件作为 mypool 池中的对象 obj1
$ rados stat obj1 --pool mypool # 查看对象信息
```


## RGW (Rados Gateway)
  
略

## PG

```bash
$ ceph pg dump
$ bash ./pg_num_per_osd.sh # 查询每个 osd 上的　pg 的数量
```

## CRUSH map

```bash
$　ceph osd getcrushmap -o crush.map　# 导出当前集群的 crush map
$ crushtool -d crush.map -o crush.txt # 反编译（crush.map　不可读，crush.txt　可读）
```

```bash
$　crushtool -c new_crush.txt -o new_crush.map　# 重新编译（可修改后重新编译　crush map）
$ ceph osd setcrushmap -i new_crush.map # 将 crush map 设置到集群中去
```
