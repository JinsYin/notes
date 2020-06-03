# ceph --version & ceph version & ceph versions

| 命令             | 描述                                             |
| ---------------- | ------------------------------------------------ |
| `ceph --version` | 获取 Ceph 客户端（ceph-common）的版本            |
| `ceph version`   | 获取 Ceph 集群的版本（需要身份文件）             |
| `ceph versions`  | 获取 Ceph 集群所有守护进程的版本（需要身份文件） |

## 示例

```sh
$ ceph --version
ceph version 13.2.8 (5579a94fafbc1f9cc913a0f5d362953a5d9c3ae0) mimic (stable)
```

```sh
$ ceph version
ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)
```

```sh
$ ceph versions
{
    "mon": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 3
    },
    "mgr": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 3
    },
    "osd": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 6
    },
    "mds": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 2
    },
    "rbd-mirror": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 1
    },
    "rgw": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 3
    },
    "rgw-nfs": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 1
    },
    "overall": {
        "ceph version 13.2.6 (7b695f835b03642f85998b2ae7b6dd093d9fbce4) mimic (stable)": 19
    }
}
```
