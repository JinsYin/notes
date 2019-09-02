# rbd 命令

## 选项

* **-c**/**--conf**：指定配置文件，而不是使用默认的 /etc/ceph/ceph.conf 来确定启动是需要的 monitor 地址。
* **-m**/**--mon_host**：连接到指定 monitor，无需通过 ceph.conf 查找。
* **--cluster**：使用自定义的集群名字，而不是默认的 ceph。
* **--id**/**--user**：client id（没有 `client.` 前缀）。
* **-n**/**--name**：client name 。
* **--keyfile**：secret key 的路径。
* **--keyring**：keyring 的路径。

## 创建块设备镜像

```sh
# rbd create --size {megabytes} {pool-name}/{image-name}
$ rbd create --size 1024 rbd/foo
```

## 查看镜像列表

```sh
# rbd ls {poolname}
$ rbd ls rbd
```

## 查看镜像信息

```sh
# rbd info {pool-name}/{image-name}
$ rbd info rbd/foo
rbd image 'foo':
    size 1 GiB in 256 objects # 每个对象 4 MB
    order 22 (4 MiB objects)
    id: ada574b0dc51
    block_name_prefix: rbd_data.ada574b0dc51
    format: 2
    features: layering, exclusive-lock, object-map, fast-diff, deep-flatten
    op_features:
    flags:
    create_timestamp: Wed Aug  8 07:57:18 2018
```

## 调整镜像大小

```sh
# 增加
$ rbd resize --size 2048 rbd/foo

# 减少
$ rbd resize --size 512 rbd/foo --allow-shrink
```

## 删除块设备镜像

```sh
# rbd rm {pool-name}/{image-name}
$ rbd rm rbd/foo
```