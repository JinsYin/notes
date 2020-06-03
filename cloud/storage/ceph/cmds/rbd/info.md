# rbd info

查询镜像信息。

## 用法

```sh
rbd info {pool-name}/{image-name}
```

## 示例

```sh
$ rbd info rbdpool/nbd
rbd image 'nbd':
    size 2 GiB in 512 objects
    order 22 (4 MiB objects)
    id: fcad6b8b4567
    block_name_prefix: rbd_data.fcad6b8b4567
    format: 2
    features: layering, exclusive-lock, object-map, fast-diff, deep-flatten
    op_features:
    flags:
    create_timestamp: Mon Jan 20 15:54:04 2020
```
