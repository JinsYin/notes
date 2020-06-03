# ceph osd pool set-quota

对存储池进行配额，用于设置每个池的最大字节数和/或最大对象数。

## 用法

```sh
ceph osd pool set-quota {pool-name} [max_objects {obj-count}] [max_bytes {bytes}]
```

## 示例

```sh
ceph osd pool set-quota data max_objects 10000
```
