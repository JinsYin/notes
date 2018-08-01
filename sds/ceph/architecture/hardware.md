# 硬件

## Network

* 任一节点上 OSD 硬盘的吞吐量之和不能超过网络带宽

## OSD

* 操作系统、OSD data、OSD journal 在不同的设备上，以最大化吞吐量
* 推荐每 4 ～ 6 个 OSD 使用 1 个 SSD 日志盘

## 参考

* [Ceph barcelona-v-1.2](https://www.slideshare.net/swamireddy/ceph-barcelonav12)
* [A Good Network Connects Ceph To Faster Performance](http://www.mellanox.com/blog/2015/08/a-good-network-connects-ceph-to-faster-performance/)