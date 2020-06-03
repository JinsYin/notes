# ceph osd pool rm | ceph osd pool delete

删除存储池

## 用法

```sh
ceph osd pool delete <poolname> {<poolname>} {<sure>}
ceph osd pool rm <poolname> {<poolname>} {<sure>}
```

## 示例

```sh
# 允许 Ceph Monitor 删除存储池
$ ceph config set mon mon_allow_pool_delete true

# 删除存储池
$ ceph osd pool rm testpool testpool --yes-i-really-really-mean-it
```
