# OSD 场景

从 `stable-4.0` 开始，由于与 ceph-disk 想关联，所以不再支持以下方案：

| OSD Scenario   | provisioning tool | 描述             |
| -------------- | ----------------- | ---------------- |
| lvm            | ceph-volume       | 推荐             |
| collocated     | ceph-disk         | Mimic 版本被弃用 |
| non-collocated | ceph-disk         | Mimic 版本被弃用 |

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