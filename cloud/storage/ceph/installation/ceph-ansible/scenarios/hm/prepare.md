# 准备

| Role       | 对应的 Inventory host group | 数量 | 状态                |
| ---------- | --------------------------- | ---- | ------------------- |
| osd        | osds                        | 3    | 3 active            |
| mon        | mons                        | 3    | 3 active            |
| mds        | mdss                        | 3    |                     |
| rgw        | rgws                        | 3    | 3 active            |
| mgr        | mgrs                        | 3    | 1 active + 2 standy |
| client     | clients                     | 1    |                     |
| iscsi-gw   | iscsigws                    | 0    |                     |
| nfs        | nfss                        | 0    |                     |
| rbd-mirror | rbdmirrors                  | 0    |                     |
| restapi    | restapis                    | 0    |                     |

| IP        | Role                |
| --------- | ------------------- |
| 111       | ceph-ansible client |
| [205:207] | mon mds rgw mgr     |
| [210:213] | osd                 |

## 网络

## 磁盘

```sh
$ ansible osds -m shell -a 'blkid'

192.168.10.213 | SUCCESS | rc=0 >>
/dev/nvme0n1p1: UUID="fe993883-3fa3-4d90-9577-f99b9703d5dd" TYPE="ext4"
/dev/sdj1: UUID="7682847a-485a-4e82-88f1-b0134e90daa5" TYPE="xfs"
/dev/sdj2: UUID="8lnNOR-3kAR-1XS6-IwBj-0ndN-0Y71-OUccKg" TYPE="LVM2_member"
/dev/mapper/centos-root: UUID="00320c47-580b-4b34-b101-5372d9115afd" TYPE="xfs"
/dev/mapper/centos-swap: UUID="69c2dc62-9a37-4896-a1bd-8479da92dee1" TYPE="swap"
/dev/nvme0n1: PTTYPE="dos"
/dev/sdf: PTTYPE="PMBR"
/dev/sdi: PTTYPE="PMBR"
/dev/sda1: PARTLABEL="ceph journal" PARTUUID="11a7b824-14ed-4801-931b-c155ec75672d"
/dev/sdb1: PARTLABEL="ceph journal" PARTUUID="11a7b824-14ed-4801-931b-c155ec75672d"

192.168.10.210 | SUCCESS | rc=0 >>
/dev/nvme0n1p1: UUID="b6e5489e-1812-47dd-bf35-12dc88df3193" TYPE="xfs"
/dev/sdj1: UUID="5cef25f2-e448-424c-a1bd-26c6f2b65383" TYPE="xfs"
/dev/sdj2: UUID="3MzTPu-lRje-tXat-cr3e-kYSG-XLLI-MzF9I2" TYPE="LVM2_member"
/dev/sdc1: LABEL="ESP" UUID="5C74-EB94" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="1e5a3ef9-5cd1-4e5b-a990-db65b587d393"
/dev/sdc2: LABEL="DIAGS" UUID="FEA3-9156" TYPE="vfat" PARTLABEL="Basic data partition" PARTUUID="39bb9a8a-6251-4651-84bf-915196b2e587"
/dev/sdc3: LABEL="OS" UUID="0CA4-350F" TYPE="vfat" PARTLABEL="Basic data partition" PARTUUID="56966cc6-8952-4a1e-a182-dbdaeed88bcf"
/dev/mapper/centos-root: UUID="39678631-1372-42ff-9173-84b1ce82e0b9" TYPE="xfs"
/dev/sdb: UUID="6686ea73-98c7-48ec-8ff6-48f0cc0829d2" TYPE="xfs"
/dev/mapper/centos-swap: UUID="b0e15702-e776-46a2-9e90-7770f0cb126e" TYPE="swap"
/dev/nvme0n1: PTTYPE="dos"

192.168.10.211 | SUCCESS | rc=0 >>
/dev/sdj1: UUID="967035dc-1e0c-40dc-b523-17d46cda46b0" TYPE="xfs"
/dev/sdj2: UUID="rzTkf5-aKe9-PRl7-mI4V-hRgV-y1wg-SPPcZ6" TYPE="LVM2_member"
/dev/sdc1: LABEL="ESP" UUID="767D-1361" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="0e3f1128-dc76-4e8a-9abb-1296d7ca7c7d"
/dev/sdc2: LABEL="DIAGS" UUID="7AAB-DB2E" TYPE="vfat" PARTLABEL="Basic data partition" PARTUUID="e53ebee9-7547-4ad9-9048-40ff39cadf0d"
/dev/sdc3: LABEL="OS" UUID="72AC-83DA" TYPE="vfat" PARTLABEL="Basic data partition" PARTUUID="d33a7d6c-9e25-48e5-bdd4-038752968f4b"
/dev/mapper/centos-root: UUID="b7cfc27b-8c76-42f6-9b45-b784f1e14fed" TYPE="xfs"
/dev/mapper/centos-swap: UUID="9b247275-125e-49d6-a430-024ce55d54a2" TYPE="swap"
/dev/nvme0n1: PTTYPE="dos"
/dev/sdi: PTTYPE="PMBR"

192.168.10.212 | SUCCESS | rc=0 >>
/dev/nvme0n1p1: UUID="234418b1-6294-4627-88c6-42497214a3c5" TYPE="ext4"
/dev/sdj1: UUID="21657ac9-91ae-4bc9-98cf-52e8b5400b67" TYPE="xfs"
/dev/sdj2: UUID="r00Sac-lmCk-2gCs-5IrT-w4eJ-IGOX-M8sTFQ" TYPE="LVM2_member"
/dev/sdi: UUID="93qxDO-BL2x-j6Aj-EAkd-Cjko-ze21-8LKbGM" TYPE="LVM2_member"
/dev/sdh: UUID="93qxDO-BL2x-j6Aj-EAkd-Cjko-ze21-8LKbGM" TYPE="LVM2_member"
/dev/mapper/centos-root: UUID="a3b49938-0879-4159-b40d-b7a1e514f895" TYPE="xfs"
/dev/mapper/centos-swap: UUID="70433911-a409-4a17-b25e-2c73440a2a29" TYPE="swap"
/dev/nvme0n1: PTTYPE="dos"
/dev/sdd: PTTYPE="PMBR"
/dev/sde: PTTYPE="PMBR"
/dev/sdc: PTTYPE="PMBR"
/dev/sda1: PARTLABEL="ceph journal" PARTUUID="11a7b824-14ed-4801-931b-c155ec75672d"
```
