# 集群配置

## 配置文件

### 通用配置文件

* group_vars/all.yml

### 子配置文件

文件用于覆盖通用配置文件中的内容。

* group_vars/agent.yml
* group_vars/ceph-fetch-keys.yml
* group_vars/clients.yml
* group_vars/common-coreoss.yml
* group_vars/docker-commons.yml
* group_vars/factss.yml
* group_vars/iscsigws.yml
* group_vars/mdss.yml
* group_vars/rgws.yml
* group_vars/mons.yml
* group_vars/nfss.yml
* group_vars/osds.yml
* group_vars/rbdmirrors.yml
* group_vars/rgws.yml
* group_vars/rhcs.yml

## group_vars/all.yml

通用配置文件 `group_vars/all.yml` 用于定义全局

```sh
cp group_vars/all.yml.sample group_vars/all.yml
```

```yaml
dummy:


###########
# GENERAL #
###########

ceph_release_num:
  dumpling: 0.67
  emperor: 0.72
  firefly: 0.80
  giant: 0.87
  hammer: 0.94
  infernalis: 9
  jewel: 10
  kraken: 11
  luminous: 12
  mimic: 13
  nautilus: 14
  octopus: 15
  dev: 99

# 集群名称
cluster: ceph

# Inventory 文件定义的主机组名
osd_group_name: osds
mon_group_name: mons
rgw_group_name: rgws
mds_group_name: mdss
mgr_group_name: mgrs


############
# PACKAGES #
############
ntp_service_enabled: true


###########
# INSTALL #
###########

# 指定 Ceph 源（另外支持 'distro' 和 'local'）
ceph_origin: repository

# 当开启 ceph_origin == 'repository' 时
ceph_repository: community

# 当开启 ceph_repository == 'community' 时
ceph_mirror: http://mirrors.163.com/ceph/
ceph_stable_key: http://mirrors.163.com/ceph/keys/release.asc
ceph_stable_release: mimic
ceph_stable_repo: "{{ ceph_mirror }}/rpm-{{ ceph_stable_release }}"

ceph_stable_redhat_distro: el7

######################
# CEPH CONFIGURATION #
######################

## Ceph options

generate_fsid: false # 如果是自动生成 fsid，放在 fetch_directory 文件
fsid: 8d9ea2ef-7b7e-4133-a2db-82e2de381255 # uuidgen

ceph_conf_key_directory: /etc/ceph

# Permissions for keyring files in /etc/ceph
ceph_keyring_permissions: '0600'

cephx: true

## Client options

## Monitor options
# 至少指定 monitor_address、monitor_interface、monitor_address_block 中的一个
monitor_address: 0.0.0.0  # 需要在 inventory 中使用 monitor_address 变量为每个 Monitor 指定不同的地址，或者在 group_vars/*.yml 中覆写
# monitor_address_block: "192.168.10.0/24,192.168.100.0/24" # 如果公共网络是多个子网时
ip_version: ipv4


##########
# CEPHFS #
##########

cephfs: cephfs                   # Ceph 文件系统的名称
cephfs_data: cephfs_data         # 针对给定文件系统的数据存储池的名称
cephfs_metadata: cephfs_metadata # 针对给定文件系统的元数据存储池的名称

cephfs_pools:
 - { name: "{{ cephfs_data }}", pgs: "{{ osd_pool_default_pg_num }}", size: "{{ osd_pool_default_size }}" }
 - { name: "{{ cephfs_metadata }}", pgs: "{{ osd_pool_default_pg_num }}", size: "{{ osd_pool_default_size }}" }

## OSD options

#osd_memory_target: 4294967296
#journal_size: 5120 # OSD journal size in MB
block_db_size: -1  # block db size in bytes for the ceph-volume lvm batch. -1 即尽可能的大
public_network: 192.168.100.0/24 # 10Gbps Ethernet
# public_network: "192.168.10.0/24,192.168.100.0/24" # 1Gbps & 10Gbps Ethernet
cluster_network: 10.0.10.0/24    # 40Gbps Infiniband

osd_mkfs_type: xfs
osd_mkfs_options_xfs: -f -i size=2048
osd_mount_options_xfs: noatime,largeio,inode64,swalloc
osd_objectstore: bluestore  # 将影响 group_vars/osds.yml 的设置

## MDS options

# mds_max_mds: 1

## Rados Gateway options
# 至少指定 radosgw_interface 和 radosgw_address 中的一个
radosgw_address: 0.0.0.0 # 需要在 inventory 中使用 radosgw_address 变量为每个 Monitor 指定不同的地址，或者在 group_vars/*.yml 中覆写
# radosgw_address_block: "192.168.10.0/24,192.168.100.0/24" # 如果公共网络是多个子网时

## REST API options
#
#restapi_interface: "{{ monitor_interface }}"
#restapi_address: "{{ monitor_address }}"
#restapi_port: 5000


###################
# CONFIG OVERRIDE #
###################

# Ceph configuration file override.
# This allows you to specify more configuration options
# using an INI style format.
# The following sections are supported: [global], [mon], [osd], [mds], [rgw]
# ceph_conf_overrides:
#   global:
#     a: 1
#   osd:
#     b: 2
#   mon:
#     c: 3
#   mds:
#     d: 4
#   client.rgw.{instance_name}
#     e: 5


# osd_crush_update_on_start: false


#############
# OS TUNING #
#############

disable_transparent_hugepage: false # 针对 osd_objectstore == 'bluestore'
#os_tuning_params:
#  - { name: fs.file-max, value: 26234859 }
#  - { name: vm.zone_reclaim_mode, value: 0 }
#  - { name: vm.swappiness, value: 10 }
#  - { name: vm.min_free_kbytes, value: "{{ vm_min_free_kbytes }}" }

# For Debian & Red Hat/CentOS installs set TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES
# Set this to a byte value (e.g. 134217728)
# A value of 0 will leave the package default.
#ceph_tcmalloc_max_total_thread_cache: 0
```

所有安装都必须配置以下选项，但根据集群方案的不同，可能还有其他必需选项。

* `ceph_origin`
* `ceph_stable_release`
* `public_network`
* `monitor_interface` 或 `monitor_address`
* `radosgw_interface` 或 `radosgw_address`（如需部署 RGW）

<!-- ```yaml
radosgw_address: 192.168.100.205,192.168.100.206,192.168.100.207 # 或者 radosgw_address: {{ radosgw_address }}
``` -->

## group_vars/osds.yml

```sh
$ cp group_vars/osds.yml.sample group_vars/osds.yml
```

```yml
dummy:

###########
# GENERAL #
###########

copy_admin_key: true # OSD 节点可以不需要 admin key

##############
# CEPH OPTIONS
##############

# # 声明用作 OSD 的原始设备（必须被擦除，没有分区表或逻辑卷）
# devices:
#  - /dev/sdc  # HDD
#  - /dev/sdd  # HDD
#  - /dev/sde  # HDD
#  - /dev/sdf  # HDD
#  - /dev/sdg  # HDD
#  - /dev/sdh  # HDD
#  - /dev/sdi  # HDD
#  - /dev/sda  # SSD
#  - /dev/sdb  # SSD

osd_scenario: lvm

# 针对 osd_scenario == 'lvm' 且 osd_objectstore == 'bluestore' （注：所有 db 和 wal 共享一个 VG）
lvm_volumes:
  - data: ssd_sda
    data_vg: ssd_sda
    db: db_sda
    db_vg: nvme_dbwal
    wal: wal_sda
    wal_vg: nvme_dbwal
    crush_device_class: ssd

  - data: ssd_sdb
    data_vg: ssd_sdb
    db: db_sdb
    db_vg: nvme_dbwal
    wal: wal_sdb
    wal_vg: nvme_dbwal
    crush_device_class: ssd

  - data: hdd_sdc      # 100% 使用 data_vg （所以可以直接指定原始盘的路径而不指定 data_vg）
    data_vg: hdd_sdc
    db: db_sdc         # 可以指定分区的路径，此时不用再指定 db_vg
    db_vg: nvme_dbwal
    wal: wal_sdc       # 可以指定分区的路径，此时不用再指定 db_vg
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sdd
    data_vg: hdd_sdd
    db: db_sdd
    db_vg: nvme_dbwal
    wal: wal_sdd
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sde
    data_vg: hdd_sde
    db: db_sde
    db_vg: nvme_dbwal
    wal: wal_sde
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sdf
    data_vg: hdd_sdf
    db: db_sdf
    db_vg: nvme_dbwal
    wal: wal_sdf
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sdg
    data_vg: hdd_sdg
    db: db_sdg
    db_vg: nvme_dbwal
    wal: wal_sdg
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sdh
    data_vg: hdd_sdh
    db: db_sdh
    db_vg: nvme_dbwal
    wal: wal_sdh
    wal_vg: nvme_dbwal
    crush_device_class: hdd

  - data: hdd_sdi
    data_vg: hdd_sdi
    db: db_sdi
    db_vg: nvme_dbwal
    wal: wal_sdi
    wal_vg: nvme_dbwal
    crush_device_class: hdd
```

## LVM

该 OSD 场景使用 `ceph-volume` 来创建 OSD，仅在 Luminous 及更新版本可用。

> 要求 Volume groups 和 Logical volumes 必须存在

## 其他

```sh
# 查询所有定义的配置
$ cd group_vars && grep -v -E '^#|^$' *.yml # 以 '#' 开头或者空行，然后取反
```

## 参考

* [Ceph-ansible 自动化安装 Luminous](http://www.tang-lei.com/2018/07/06/ceph-ansible-%E8%87%AA%E5%8A%A8%E5%8C%96-%E5%AE%89%E8%A3%85-luminous/)
