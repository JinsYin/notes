# OSD 场景

从 `stable-4.0` 开始，由于与 ceph-disk 相关联，所以不再支持以下方案：

| OSD Scenario   | provisioning tool | 描述                                                                                                                                                                                                                                                                      |
| -------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| lvm            | ceph-volume       | 推荐                                                                                                                                                                                                                                                                      |
| collocated     | ceph-disk         | * （Mimic 版本被弃用）所有数据放在一块盘 <br> * Filestore 方式将在同一设备上分出 ceph data 和 ceph journal 两个分区 <br> * Bluestore 方式将在同一块设备上分出两个分区： data 分区（存放 ceph data）和 ceph block 分区（存放 ceph block、ceph block.db 和 ceph block.wal） |
| non-collocated | ceph-disk         | * （Mimic 版本被弃用）各种数据放在不同盘 <br> * Filestore 方式在不同设备创建两个分区（ceph data 和 ceph journal） <br> *                                                                                                                                                  |

## LVM

该 OSD 场景使用 `ceph-volume` 来创建 OSD，仅在 Luminous 及更新版本可用。

```yaml
# group_vars/osds.yml
dummy:
copy_admin_key: true
osd_objectstore: bluestore
osd_scenario: lvm
lvm_volumes:
   - data: data1
     data_vg: d_vg
     journal: journal1
     journal_vg: j_vg
   - data: data2
     data_vg: d_vg
     journal: journal2
     journal_vg: j_vg
   - data: data3
     data_vg: d_vg
     journal: journal3
     journal_vg: j_vg
```

> 要求 Volume groups 和 Logical volumes 必须存在
