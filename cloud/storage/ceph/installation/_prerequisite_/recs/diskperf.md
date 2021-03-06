# 测试

## hdparm 测试吞吐量

```sh
# 28001G(4T * 9) HDD RAID5
$ hdparm -Tt /dev/sda
/dev/sdc:
 Timing cached reads:   13370 MB in  2.00 seconds = 6692.46 MB/sec
 Timing buffered disk reads: 2814 MB in  3.00 seconds = 937.88 MB/sec
```

```sh
# 120G SSD (120G * 2) RAID5
$ hdparm -Tt /dev/sdb
/dev/sdb:
 Timing cached reads:   14584 MB in  2.00 seconds = 7301.06 MB/sec
 Timing buffered disk reads: 726 MB in  3.00 seconds = 241.64 MB/sec
```

```sh
# 1T SSD Non-RAID
$ hdparm -Tt /dev/sdc
/dev/sdb:
 Timing cached reads:   23238 MB in  2.00 seconds = 11634.19 MB/sec
 Timing buffered disk reads: 1514 MB in  3.00 seconds = 504.28 MB/sec
```

```sh
# 4T 无RAID
$ hdparm -Tt /dev/sdd
/dev/sde:
 Timing cached reads:   21696 MB in  2.00 seconds = 10861.05 MB/sec
 Timing buffered disk reads: 278 MB in  3.02 seconds =  92.20 MB/sec
```

```sh
# 300G 无RAID
$ hdparm -Tt /dev/sde
/dev/sda:
 Timing cached reads:   12180 MB in  2.00 seconds = 6095.73 MB/sec
 Timing buffered disk reads: 590 MB in  3.00 seconds = 196.57 MB/sec
```

## 对比测试

| 硬盘类型：容量：说明                  | 随机写 IOPS | 随机读 IOPS | 顺序写吞吐量        | 顺序读吞吐量 |
| ------------------------------------- | ----------- | ----------- | ------------------- | ------------ |
| iSCSI：42G：192.168.1.0/24 Xen 虚拟机 | 5.7k        | 5.8k        | 120MB/s（千兆以太） | 590MB/s      |
| SATA-SSD：120G：闪迪（TLC）           | 10k         | 71K         | 80MB/s              | 1.1GB/s      |
| STAT-SSD：250G：镁光（TLC）           | 43k         | 84k         | 710MB/s             | 790MB/s      |
| NVMe-SSD：250G：PCI-e 2.0（203机器）  | 25k         | 133k        | 1.4GB/s             | 1.7GB/s      |
| NVMe-SSD：250G：PCI-e 3.0（202机器）  | 40k         | 188k        | 1.4GB/s             | 2.7GB/s      |

## 参考

* [云盘参数和性能测试方法](https://help.aliyun.com/document_detail/25382.html?spm=5176.doc35241.6.551.9xYiHF)
