# 网络

## 性能测试

### 网络性能

<!--
The network performance is checked after the installation using iperf tool. The following are the
commands used to measure network bandwidth:
Server Side: iperf –s
Client Side: iperf –c <server host IP> -P16 –l64k –i3
For the 10GbE network the bandwidth performance range achieved is 9.48Gb/s to 9.78Gb/s
For the 40GbE network the bandwidth performance range achieved is 36.82Gb/s to 38.43Gb/s
-->

```sh
# Server Side
$ iperf -s

# Client Side
# For the 10GbE network the bandwidth performance range achieved is 9.48Gb/s to 9.78Gb/s
# For the 40GbE network the bandwidth performance range achieved is 36.82Gb/s to 38.43Gb/s
$ iperf -c <server-ip> -P16 -l64k -i3
```

### RBD 性能

<!--
The benchmark testing conducted using fio tool, rev 2.0.13, http://freecode.com/projects/fio. The testing
setting is:
fio --directory=/mnt/cephblockstorage --direct=1 --rw=$Action --bs=$BlockSize --size=30G --numjobs=128
--runtime=60 --group_reporting --name=testfile --output=$OutputFile
-- $Action=read, write, randread, randwrite
-- $bs=4k,128k,8m
-->

```sh
$ rbd -c /etc/ceph/ceph.conf -p benchmark create benchmrk --size 6144000
#> rbd map benchmrk --pool benchmark --secret /etc/ceph/client.admin
#> mkfs.ext4 /dev/rbd1
#> mkdir /mnt/cephblockstorage
#> mount /dev/rbd1 /mnt/cephblockstorage
```

## 参考

* [Deploying Ceph With High Performance Networks - SNIA](https://www.snia.org/sites/default/files/JohnKim_CephWithHighPerformanceNetworks_V2.pdf)
* [CEPH RDMA UPDATE](https://www.openfabrics.org/images/eventpresos/2017presentations/103_Ceph_HWang.pdf)
* [](https://www.openfabrics.org/images/2018workshop/presentations/206_HTang_AcceleratingCephRDMANVMe-oF.pdf)
* [Accelerate CEPH with Remote Direct Memory Access (RDMA) - Youtube](https://www.youtube.com/watch?v=FzD87qSJee0)
* [Ceph RDMA Support - Youtube](https://www.youtube.com/watch?v=Qb2SUWLdDCw)
* [ceph 网络配置](https://blog.csdn.net/jackliu16/article/details/80389079)
* [](http://www.mellanox.com/related-docs/whitepapers/WP_Deploying_Ceph_over_High_Performance_Networks.pdf)