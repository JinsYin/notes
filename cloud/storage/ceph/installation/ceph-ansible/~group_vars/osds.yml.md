# osds.yml 配置解析 | OSD 详细配置

* 此处的变量作用于所有主机组而非某个角色

（以下均为演示示例）

## 通用选项

```yaml
# 拷贝管理密钥到 OSD 节点（OSD 节点不应该有管理密钥，所以不推荐）
copy_admin_key: true
```

## OSD 选项

### ceph-disk（弃用）

```yaml
#devices:
#  - /dev/sdb
#  - /dev/sdc
#  - /dev/sdd
#  - /dev/sde

#devices: []
```

```yaml
lvm_volumes: []
crush_device_class: ""
osds_per_device: 1
```

原始设备必须被完成擦除，不能存在 GPT 分区表或逻辑分区。

```yaml
# 产生 2 个 OSD，每个 OSD 都有自己独立的日志
devices:
  - /dev/sda
  - /dev/sdb
```

```yaml
# 产生 2 个 OSD，但数据存储在 HDD（/dev/sda 和 /dev/sdb），而日志存储在 SSD （/dev/nvme0n1）
devices:
  - /dev/sda
  - /dev/sdb
  - /dev/nvme0n1
```

```yaml
devices: []

# 不使用具有分区表的设备
osd_auto_discovery: false
```

| 配置选项           | 描述                                                                   |
| ------------------ | ---------------------------------------------------------------------- |
| crush_device_class | 对使用 `osd_auto_discovery` 方式创建的所有 OSD 设置统一的 CRUSH 设备类 |

### ceph-volume + Filestore

**lvm_volumes** 是一个字典列表，每个字典必须包含 `data`、`journal` 和 `vg_name` 键。

| 键           | 值的类型              | 说明                                    |
| ------------ | --------------------- | --------------------------------------- |
| `data`       | lv、device、partition | 如果是多个 lv，不能使用相同的 `journal` |
| `data_vg`    | vg                    | `data` 值为 lv 时使用的 vg              |
| `journal`    | lv、partition         |                                         |
| `journal_vg` | vg                    | `journal` 值为 lv 时使用的 vg           |

```yaml
# lvm_volumes:
#   - data: data-lv1
#     data_vg: vg1
#     journal: journal-lv1
#     journal_vg: vg2
#     crush_device_class: foo
#   - data: data-lv2
#     journal: /dev/sda1
#     data_vg: vg1
#   - data: data-lv3
#     journal: /dev/sdb1
#     data_vg: vg2
#   - data: /dev/sda
#     journal: /dev/sdb1
#   - data: /dev/sda1
#     journal: /dev/sdb1
```

```yaml
lvm_volumes: []
crush_device_class: ""
osds_per_device: 1
```

```yaml
# vm
lvm_volumes:
  - data: data-lv1
    data_vg: vg1
    journal: journal-lv1
    journal_vg: vg2
    crush_device_class: foo
  - data: data-lv2
    journal: /dev/sda1
    data_vg: vg1
  - data: data-lv3
    journal: /dev/sdb1
    data_vg: vg2
  - data: /dev/sda
    journal: /dev/sdb1
  - data: /dev/sda1
    journal: /dev/sdb1
```

```yaml
# hm
lvm_volumes:
  - data: /dev/sdc
    data_vg: hdd
    journal: jlv1
    journal_vg: jvg1
    crush_device_class: hdd
  - data: data-lv2
    journal: /dev/sda1
    data_vg: vg1
  - data: data-lv3
    journal: /dev/sdb1
    data_vg: vg2
  - data: /dev/sda
    journal: /dev/sdb1
  - data: /dev/sda1
    journal: /dev/sdb1
```

### ceph-volume + Bluestore（推荐）

lvm_volume 是一个字典列表，每个字典必须至少包含 `data` 字段。如果要定义 `wal` 或 `db` 字段，必须同时设置 lv 和 vg。以下四种组合方式：

1. data
2. data + wal
3. data + wal + db
4. data + db

```yaml
lvm_volumes:
  - data: data-lv1
    data_vg: vg1
    wal: wal-lv1
    wal_vg: vg1
    crush_device_class: foo
  - data: data-lv2
    db: db-lv2
    db_vg: vg2
  - data: data-lv3
    wal: wal-lv1
    wal_vg: vg3
    db: db-lv3
    db_vg: vg3
  - data: data-lv4
    data_vg: vg4
  - data: /dev/sda
  - data: /dev/sdb1
```

```yaml
# hm
# sdc sdd sde sdf sdg sdh sdi
lvm_volumes:
  - data: data-lv1
    data_vg: vg1
    wal: wal-lv1
    wal_vg: vg1
    crush_device_class: foo
  - data: data-lv2
    db: db-lv2
    db_vg: vg2
  - data: data-lv3
    wal: wal-lv1
    wal_vg: vg3
    db: db-lv3
    db_vg: vg3
  - data: data-lv4
    data_vg: vg4
  - data: /dev/sdc
    data_vg: osd-hdd
  - data: /dev/sdd
    data_vg: osd-hdd
  - data: /dev/sde
    data_vg: osd-hdd
  - data: /dev/sdf
    data_vg: osd-hdd
  - data: /dev/sdg
    data_vg: osd-hdd
  - data: /dev/sdh
    data_vg: osd-hdd
  - data: /dev/sdi
    data_vg: osd-hdd
  - data: /dev/sda
    data_vg: osd-ssd
  - data: /dev/sdb
    data_vg: osd-ssd
```

## Docker

## Systemd

## Check