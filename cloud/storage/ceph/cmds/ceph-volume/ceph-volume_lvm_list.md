# ceph-volume lvm list

```sh
$ ceph-volume lvm list

====== osd.6 =======

  [  db]    /dev/nvme_dbwal/db_sdb

      type                      db
      osd id                    6
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdb
      cluster name              ceph
      wal uuid                  wR2blS-DP4d-4wWu-E4ot-NQyL-jg7q-ww6md4
      osd fsid                  43353a24-4c2e-4abb-8078-b9277a8bd775
      db device                 /dev/nvme_dbwal/db_sdb
      encrypted                 0
      db uuid                   giZNzX-sjIm-jNpG-P0jD-HN9N-nens-U6Faoe
      cephx lockbox secret
      block uuid                hmMywm-j7tP-Del0-h6yB-zIp2-jGns-u3cis8
      block device              /dev/ssd_sdb/ssd_sdb
      vdo                       0
      crush device class        ssd
      devices                   /dev/nvme0n1

  [ wal]    /dev/nvme_dbwal/wal_sdb

      type                      wal
      osd id                    6
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdb
      cluster name              ceph
      wal uuid                  wR2blS-DP4d-4wWu-E4ot-NQyL-jg7q-ww6md4
      osd fsid                  43353a24-4c2e-4abb-8078-b9277a8bd775
      encrypted                 0
      cephx lockbox secret
      block uuid                hmMywm-j7tP-Del0-h6yB-zIp2-jGns-u3cis8
      block device              /dev/ssd_sdb/ssd_sdb
      vdo                       0
      crush device class        ssd
      devices                   /dev/nvme0n1

  [block]    /dev/ssd_sdb/ssd_sdb

      type                      block
      osd id                    6
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdb
      cluster name              ceph
      wal uuid                  wR2blS-DP4d-4wWu-E4ot-NQyL-jg7q-ww6md4
      osd fsid                  43353a24-4c2e-4abb-8078-b9277a8bd775
      db device                 /dev/nvme_dbwal/db_sdb
      encrypted                 0
      db uuid                   giZNzX-sjIm-jNpG-P0jD-HN9N-nens-U6Faoe
      cephx lockbox secret
      block uuid                hmMywm-j7tP-Del0-h6yB-zIp2-jGns-u3cis8
      block device              /dev/ssd_sdb/ssd_sdb
      vdo                       0
      crush device class        ssd
      devices                   /dev/sdb

====== osd.8 =======

  [block]    /dev/hdd_sdc/hdd_sdc

      type                      block
      osd id                    8
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdc
      cluster name              ceph
      wal uuid                  CmQCeD-K6kz-lh7Q-wWyx-LmOS-kG1B-lyJ19v
      osd fsid                  7c000664-592a-499e-86f5-29ffc8365a0c
      db device                 /dev/nvme_dbwal/db_sdc
      encrypted                 0
      db uuid                   aCQUjj-daEA-eemf-sGle-h9fn-En41-sWnsLl
      cephx lockbox secret
      block uuid                8n3EHA-ofcw-rN9e-fiSY-jvN5-r5OM-lrYOgv
      block device              /dev/hdd_sdc/hdd_sdc
      vdo                       0
      crush device class        hdd
      devices                   /dev/sdc

  [  db]    /dev/nvme_dbwal/db_sdc

      type                      db
      osd id                    8
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdc
      cluster name              ceph
      wal uuid                  CmQCeD-K6kz-lh7Q-wWyx-LmOS-kG1B-lyJ19v
      osd fsid                  7c000664-592a-499e-86f5-29ffc8365a0c
      db device                 /dev/nvme_dbwal/db_sdc
      encrypted                 0
      db uuid                   aCQUjj-daEA-eemf-sGle-h9fn-En41-sWnsLl
      cephx lockbox secret
      block uuid                8n3EHA-ofcw-rN9e-fiSY-jvN5-r5OM-lrYOgv
      block device              /dev/hdd_sdc/hdd_sdc
      vdo                       0
      crush device class        hdd
      devices                   /dev/nvme0n1

  [ wal]    /dev/nvme_dbwal/wal_sdc

      type                      wal
      osd id                    8
      cluster fsid              9e283ec8-ad64-4981-b921-8b6f117325ad
      wal device                /dev/nvme_dbwal/wal_sdc
      cluster name              ceph
      wal uuid                  CmQCeD-K6kz-lh7Q-wWyx-LmOS-kG1B-lyJ19v
      osd fsid                  7c000664-592a-499e-86f5-29ffc8365a0c
      encrypted                 0
      cephx lockbox secret
      block uuid                8n3EHA-ofcw-rN9e-fiSY-jvN5-r5OM-lrYOgv
      block device              /dev/hdd_sdc/hdd_sdc
      vdo                       0
      crush device class        hdd
      devices                   /dev/nvme0n1

......
```
