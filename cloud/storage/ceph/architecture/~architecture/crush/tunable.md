# CRUSH 调制

> 为了使调整后的参数正常生效，需要确保客户端和服务端对应的 Ceph 版本严格一致

## 模板调制（自动调参）

调制 CRUSH 最简单的部分是使用现成的、预先通过验证的模板（Profile）

命令：

```sh
$ ceph osd crush tuanbles {profile}
```

与定义模板：

| 模板名称 | 说明 |
| -------- | ---- |
| argonaut |      |
|          |      |

某些特定场景可能导致使用上述模板仍无法使 CRUSH 正常工作，此时需要手动调整参数。

## 命令行在线调参

## 编辑 CRUSH Map （手动离线调参）

```c
CRUSH Map = Cluster Map + CRUSH Rule
```

1. 获取 CRUSH Map

```sh
$ ceph osd getcrushmap -o {compiled-crush-filename}
```

出于测试等目的可以手动创建 CRUSH Map：

```sh
# crushtool -o {compiled-crush-filename} --build --num_osds N {layer} ...
```

## 参考

* [CRUSH TUNABLES](https://access.redhat.com/documentation/en-us/red_hat_ceph_storage/1.2.3/html/storage_strategies/crush_tunables)
