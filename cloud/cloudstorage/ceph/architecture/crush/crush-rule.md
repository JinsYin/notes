# CRUSH Rule

![replicated vs erasure coding](.images/erasure-coding-vs-replicated.png)

## replicated rule

```bash
# 创建一个 'replicated' rule
# ceph osd crush rule create-replicated {name} {root} {failure-domain-type} [{class}]
$ ceph osd crush rule create-replicated ssd_rule default host ssd
```

## erasure code

## 参考

![Ceph replication vs erasure coding](https://blog.dachary.org/2013/07/23/ceph-replication-vs-erasure-coding/)