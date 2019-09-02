# rados bench

## 写（Write）

```sh
% rados bench -p testdata 10 write --no-cleanup
```

## 顺序读（Seq Read）

```sh
% rados bench -p testdata 10 req
```

## 随机读（Read）

```sh
% rados bench -p testdata 10 rand
```

## 参考

* [Best Practices & Performance Tuning - OpenStack Cloud Storage with Ceph](https://www.slideshare.net/swamireddy/ceph-barcelonav12)
* [Tame Tomorrow’s Data Growth Today with Ceph Storage and NVMe SSDs Better Building Blocks for Scalable Ceph Storage](https://www.micron.com/solutions/technical-briefs/tame-tomorrows-data-growth-today-with-ceph-storage-and-nvme-ssds)