# rbd resize

对 Ceph 块设备镜像进行扩容或缩容。

Ceph 的块设备镜像属于精简配置（thin provisioned），在实际存储数据之前并没有占用物理存储，但是有一个最大容量限制。

## 示例

```sh
# 缩容
$ rbd resize --size 1024 rbdpool/nbd --allow-shrink

# 扩容
$ rbd resize --size 4096 rbdpool/nbd
```
