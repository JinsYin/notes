# 准备 LVM

## wipe-raw-disk.sh

擦除所有的原始设备（仅擦除分区表或逻辑卷，而不是用 0 填充所有位）：

```bash
#!/bin/bash

# SSD
dd if=/dev/zero of=/dev/sda bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdb bs=65536 count=1 status=progress

# HDD
dd if=/dev/zero of=/dev/sdc bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdd bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sde bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdf bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdg bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdh bs=65536 count=1 status=progress
dd if=/dev/zero of=/dev/sdi bs=65536 count=1 status=progress

# NVME
dd if=/dev/zero of=/dev/nvme0n1 bs=65536 count=1 status=progress
```

调优 block size：

* [Tuning dd block size](http://blog.tdg5.com/tuning-dd-block-size/)
* [Good block size for disk-cloning with diskdump (dd)](https://superuser.com/questions/234199/good-block-size-for-disk-cloning-with-diskdump-dd)

## lvm.sh

```bash
#!/bin/bash

# ------- PV ------- #

# SSD
pvcreate /dev/sda
pvcreate /dev/sdb

# HDD
pvcreate /dev/sdc
pvcreate /dev/sdd
pvcreate /dev/sde
pvcreate /dev/sdf
pvcreate /dev/sdg
pvcreate /dev/sdh
pvcreate /dev/sdi

# NVME SSD
pvcreate /dev/nvme0n1


# ------- VG ------- #

# SSD
vgcreate ssd_sda /dev/sda
vgcreate ssd_sdb /dev/sdb

# HDD
vgcreate hdd_sdc /dev/sdc
vgcreate hdd_sdd /dev/sdd
vgcreate hdd_sde /dev/sde
vgcreate hdd_sdf /dev/sdf
vgcreate hdd_sdg /dev/sdg
vgcreate hdd_sdh /dev/sdh
vgcreate hdd_sdi /dev/sdi

# NVME SSD
vgcreate nvme_dbwal /dev/nvme0n1


# ------- LV ------- #

# SSD Data
lvcreate -n ssd_sda -l 100%VG ssd_sda
lvcreate -n ssd_sdb -l 100%VG ssd_sdb

# HDD Data
lvcreate -n hdd_sdc -l 100%VG hdd_sdc
lvcreate -n hdd_sdd -l 100%VG hdd_sdd
lvcreate -n hdd_sde -l 100%VG hdd_sde
lvcreate -n hdd_sdf -l 100%VG hdd_sdf
lvcreate -n hdd_sdg -l 100%VG hdd_sdg
lvcreate -n hdd_sdh -l 100%VG hdd_sdh
lvcreate -n hdd_sdi -l 100%VG hdd_sdi

# block.db (3%)
lvcreate -n db_sda -l 3%VG nvme_dbwal
lvcreate -n db_sdb -l 3%VG nvme_dbwal
lvcreate -n db_sdc -l 3%VG nvme_dbwal
lvcreate -n db_sdd -l 3%VG nvme_dbwal
lvcreate -n db_sde -l 3%VG nvme_dbwal
lvcreate -n db_sdf -l 3%VG nvme_dbwal
lvcreate -n db_sdg -l 3%VG nvme_dbwal
lvcreate -n db_sdh -l 3%VG nvme_dbwal
lvcreate -n db_sdi -l 3%VG nvme_dbwal

# block.wal (6%)
lvcreate -n wal_sda -l 6%VG nvme_dbwal
lvcreate -n wal_sdb -l 6%VG nvme_dbwal
lvcreate -n wal_sdc -l 6%VG nvme_dbwal
lvcreate -n wal_sdd -l 6%VG nvme_dbwal
lvcreate -n wal_sde -l 6%VG nvme_dbwal
lvcreate -n wal_sde -l 6%VG nvme_dbwal
lvcreate -n wal_sdf -l 6%VG nvme_dbwal
lvcreate -n wal_sdg -l 6%VG nvme_dbwal
lvcreate -n wal_sdh -l 6%VG nvme_dbwal
lvcreate -n wal_sdi -l 6%VG nvme_dbwal

# 注：'nvme_dbwal' VG 还剩 19%，还可以容纳最多两块盘
```

## lvm-playbook.yml

```yaml
- hosts: osds
  remote_user: root
  gather_facts: false
  tasks:
  - name: Install dependencies
    yum: name={{ item }} state=present
    with_items:
      - expect
      - lvm2

  - name: Transfer the wipe-raw-disk.sh
    copy: src=wipe-raw-disk.sh dest=/root/wipe-raw-disk.sh mode=0755

  - name: Transfer the lvm.sh
    copy: src=lvm.sh dest=/root/lvm.sh mode=0755

  - name: Execute the wipe-raw-disk.sh
    command: /bin/bash /root/wipe-raw-disk.sh

  - name: Execute the lvm.sh
    command: /bin/bash /root/lvm.sh

  - name: Check the results
    command: /bin/lsblk
    register: result

  - debug: var=result.stdout_lines
```

## 运行

```sh
$ ansible-playbook lvm-playbook.yml
```

## 参考

* [Ceph-ansible OSD 准备](http://www.tang-lei.com/2018/07/09/ceph-ansible-osd-%E5%87%86%E5%A4%87/)
