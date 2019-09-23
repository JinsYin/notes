# rbd 命令 - 管理 RBD 镜像

## 示例

docker 使用 ceph 块存储存储 docker volume，它对应 ceph rbd 中的 image。

```sh
$ rbd create myimage --size 1024 --pool mypool # 创建镜像（默认池是 rbd，单位：MB）
$ rbd ls --pool mypool # 查看池中镜像，缩写: rbd ls mypool
$ rbd info mypool/myimage # 镜像信息，同 rbd info (--image) myimage --pool mypool
$ rbd rm mypool/myimage # 删除镜像
$ rbd cp mypool/myimage mypool/newimage # 拷贝镜像
$ rbd rename mypool/myimage mypool/img # 重命名
```

```sh
$ rbd resize mypool/myimage --size 2048 # 扩容，
$ rbd resize mypool/myimage --size 512 --allow-shrink # 缩容
```

```sh
#
$ rbd snap create mypool/myimage@mysnap # 创建快照（可多个）
$ rbd snap ls mypool/myimage # 查看镜像快照
$ rbd snap rm mypool/myimage@mynap # 删除 myimage 镜像的某个快照
$ rbd snap purge mypool/myimage # 删除 myimage 镜像的所有快照
```

```sh
$ rbd showmapped # 查看本机所有映射，用 lsblk 检查看看
$ rbd unmap /dev/rbd1 # 取消本机对 /dev/rbd1 的映射
```

## 参考

* [RBD – MANAGE RADOS BLOCK DEVICE (RBD) IMAGES](http://docs.ceph.com/docs/master/man/8/rbd/)
