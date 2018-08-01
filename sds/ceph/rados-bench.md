# rados bench

## 写（Write）

```bash
% rados bench -p testdata 10 write --no-cleanup
```

## 顺序读（Seq Read）

```bash
% rados bench -p testdata 10 req
```

## 随机读（Read）

```bash
% rados bench -p testdata 10 rand
```

## 参考

* [Ceph barcelona-v-1.2](https://www.slideshare.net/swamireddy/ceph-barcelonav12)
* [Tame Tomorrow’s Data Growth Today with Ceph Storage and NVMe SSDs Better Building Blocks for Scalable Ceph Storage](https://www.micron.com/solutions/technical-briefs/tame-tomorrows-data-growth-today-with-ceph-storage-and-nvme-ssds)